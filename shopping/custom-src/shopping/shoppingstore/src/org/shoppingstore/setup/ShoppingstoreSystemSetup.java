/*
 * [y] hybris Platform
 *
 * Copyright (c) 2018 SAP SE or an SAP affiliate company. All rights reserved.
 *
 * This software is the confidential and proprietary information of SAP
 * ("Confidential Information"). You shall not disclose such Confidential
 * Information and shall use it only in accordance with the terms of the
 * license agreement you entered into with SAP.
 */
package org.shoppingstore.setup;

import static org.shoppingstore.constants.ShoppingstoreConstants.PLATFORM_LOGO_CODE;

import de.hybris.platform.core.initialization.SystemSetup;

import java.io.InputStream;

import org.shoppingstore.constants.ShoppingstoreConstants;
import org.shoppingstore.service.ShoppingstoreService;


@SystemSetup(extension = ShoppingstoreConstants.EXTENSIONNAME)
public class ShoppingstoreSystemSetup
{
	private final ShoppingstoreService shoppingstoreService;

	public ShoppingstoreSystemSetup(final ShoppingstoreService shoppingstoreService)
	{
		this.shoppingstoreService = shoppingstoreService;
	}

	@SystemSetup(process = SystemSetup.Process.INIT, type = SystemSetup.Type.ESSENTIAL)
	public void createEssentialData()
	{
		shoppingstoreService.createLogo(PLATFORM_LOGO_CODE);
	}

	private InputStream getImageStream()
	{
		return ShoppingstoreSystemSetup.class.getResourceAsStream("/shoppingstore/sap-hybris-platform.png");
	}
}
