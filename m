Return-Path: <linux-btrfs+bounces-15456-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 796ADB01663
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 10:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C5B76797F
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 08:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC30F20E71C;
	Fri, 11 Jul 2025 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EXCo143+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zjI07vO5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652362222BB
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222826; cv=fail; b=H5BNT+dKatKA4Q2QfbS44U14nv+ybwupRzvZC+OziSPSboVr2F2GCXGptDSQoTLMlcZeQt6fuo3i802HINxxmMdnbwnDLUONbzkbHKYAEpj+NIsOhiMuquuneeaVlMll/maiyFxeBkCJk0FdcxVMnbUueAAhSuquf2xHgy3gomA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222826; c=relaxed/simple;
	bh=8S85cdev6YUKM3eDLKsgELJHLsNbB49QKwCxvve9HyA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jxLcdIH/C7P7s7swU9COSFZJ8zTmQnlKmJSxJOIoyQpPwwm91SjJaEKmi//Xqxcd2hd2jC77XNB4pI51SNrcCKbdjajmIZUaSwz1xg3MMxj5gZ5ESsx0qtwmvc0eO9jrTzjUuUuvXtary7aTb7ZjzLXuqmz6ZrqGz8Q9c59eBK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EXCo143+; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=zjI07vO5; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752222825; x=1783758825;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=8S85cdev6YUKM3eDLKsgELJHLsNbB49QKwCxvve9HyA=;
  b=EXCo143+sUeYGtbgbwtvs2Y7O9D1NRGx+f6NdRSh0ykcAF4xAyFtPTyu
   Aq/CmZWWjmR3TF8ybV4StWKH+4g7w+6xhrwEVSbY2VP6tNOUyKtzwGsvy
   Yjg2WbmTf4s5YC8RHva0r344Ln6NlL7bJGxWVu5AsusbE7c/YigJ0J59Y
   c7YcrVV5tdW6Gks2QMSbxjX3XTOyCAYAkaZdOcjSW++D+1TTdPT93pgm6
   62w8H/IvwAF0+bSCBPcMfyuYyzQcMVRNpaQzYhYPYHvKLVQOsMeTmvM6i
   2DW6KSnzTmsdGAjpc5EH7iZtUoI2GfMvoYPp1um+Mgptym3udokg7nRmy
   A==;
X-CSE-ConnectionGUID: UIbyjGgqSQqV5EYPom120A==
X-CSE-MsgGUID: Rvrvxwh+Q0m5nnEjz6nsUg==
X-IronPort-AV: E=Sophos;i="6.16,303,1744041600"; 
   d="scan'208";a="87610992"
Received: from mail-dm6nam10on2087.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([40.107.93.87])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2025 16:33:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxvy1C2pEeNN4BQ09yzc8pJIi/GfRLO6XtGroqF8VGrRsoF9KtigT5jbwIKMFH440D8L9jB9+uipC9Mq/F8kcczWEDqn9TZNzbABYNXjnJdljO7836tR1Pga2IqfzXMorgnyU3hk8LSghFasvayKsJeBMMolQAWiBaTDx//jutT9jRELNwSD5aqSBFBNtpVQ4PEEM/ukjgqGTJcBXcwMhaGSjcyUeHl8o4gwRNJ0JIxZvq3J+XIINRjIdjOQrhIrOUtF8jrk57v8JMhrcGdW4NDC4fvfgPCuyHtMci5ru5WFvNbnBNcdk4h5EY4oPKpnZa4I4e97AUDlY55A7b897A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8S85cdev6YUKM3eDLKsgELJHLsNbB49QKwCxvve9HyA=;
 b=L3I4HM40B48DT8xpvexVWQavwCms+3y1yMNnHUce7KsLfnyum4MFYoBCRCEwuKuwv74xecBFu1QcjL4VnjzypLM6xedV53wn+ve7O+nqLfItSXAi+5FhCcMyCPBJignZfeSYtTexSgKZyev+Z/CC/GbOR5feq9qYnFi+cdBiRTB0kJ8szKU08pfZKEv2i0F4Mt/+PcfSE58srpv3g8gKW0kiiHNDlN5Pis4Yv/uqVgIDgmd1KXZn3pdSGDEO/InYbhWEJzxo9WrMtdTHTNDlaBwd3a3YXsPTJGLe8aO1qQ4w++Q/mHuHBTkcgFHw+nf7+qvPL2imMHdmMciT86x0HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8S85cdev6YUKM3eDLKsgELJHLsNbB49QKwCxvve9HyA=;
 b=zjI07vO5IRkr6sOWpfZsRMHoAF4RRasCdnknND3/n3NxIeRar253SnJz3Qc6pmP7J3uFu84tfSudLdW2SEiQXwZ3S4vL6RfWXCdT8/2iC7yka5htMeNDzBRPmK34XKkPJ9qdqhresv7P1+WZJpivRzRjycHpN061/7yq+cbS578=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by PH0PR04MB7461.namprd04.prod.outlook.com (2603:10b6:510:1f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 08:33:40 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%5]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 08:33:40 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] btrfs: zoned: limit active zones to max_open_zones
Thread-Topic: [PATCH v2 3/3] btrfs: zoned: limit active zones to
 max_open_zones
Thread-Index: AQHb8jTWJiu3f6Uts0aDF72Iu7PRA7QsllCAgAACRoA=
Date: Fri, 11 Jul 2025 08:33:40 +0000
Message-ID: <366a1028-546c-4982-9d96-5ae98c208d04@wdc.com>
References: <cover.1752218199.git.naohiro.aota@wdc.com>
 <99393b24788a89f01d2cd36cdc819c3caafc948e.1752218199.git.naohiro.aota@wdc.com>
 <28d15a75-5217-4288-b607-6c989ad5e7c7@wdc.com>
In-Reply-To: <28d15a75-5217-4288-b607-6c989ad5e7c7@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|PH0PR04MB7461:EE_
x-ms-office365-filtering-correlation-id: 0ea2c01b-8a21-402d-4299-08ddc055a35b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c2NpUThFdzZWR2MxbGQ2R0NUVDVNYThZK1BFc1hkUlZDaVNLc2ZSMHNIVDZw?=
 =?utf-8?B?ZTBhR09YVlZwZUw4aWV0SlFsTlI0cVZNcUZYSFVIT3JmaVlaeGV0U0NzQjd3?=
 =?utf-8?B?a3JoOGc2REpEWE4yaHl4MVlodkNPQUpoaWF6Yi9vemJ1WlJMN3JsRWNvenVI?=
 =?utf-8?B?SGdONGJsU0grbzFJbWJnNEkxdnhmdEQ1ZDJ6WjN2R0d2djdnMXZ0ZmJhVWto?=
 =?utf-8?B?MVhsR0JYRG5DdDlxR0JuOU1aUGREZzBYNzU4WDNyOW00U21ITXVaNTdzSTB1?=
 =?utf-8?B?QzcwajdQNkRjOGdaK3ZQVW5XQUE4cXdTakhTeHFwcVF5MFk4M1hmQ0xBUXVk?=
 =?utf-8?B?RlpRNyswVDgrU2dyRUJWbFBXOGgxd2w4bkdTR0daRU9GdWx2cUNFdzU4Zk80?=
 =?utf-8?B?U0RJUFllR1IyYlpiNjhFMW9qSEFBSW5zTG9tWkdMMVhRREdPTTNpbG1DZThL?=
 =?utf-8?B?QlZhbWYramt5SUFoc29sRG0zc0dQK2J5bndEMVFJc1dBb1FrYTFNWjZMS1kz?=
 =?utf-8?B?ZlZvZTlaZUx4ZjQrVVpOT2srVFRXbmVHN1FuWXM3L1NueUgyWEdhRmY4WVNp?=
 =?utf-8?B?TmlLQlczcmF1L2x1bXZJbWtBS0h3ZmRnOWZjLzRScHp0cENzc0YwTVo4TFd4?=
 =?utf-8?B?UENveW0rUFZNaVZHSis5MDVzYVUxbFltV3E5QWNCR3ZHWVR2QVErSDZjQ0M2?=
 =?utf-8?B?V0JIZ3EvS0czc1UyQW95OXlGUGFPNjFlWCtWbUxTdUNibkxXQm5iVEQxNzkz?=
 =?utf-8?B?UnJQQlFkd1k4ZlAxL28vSDh2czl1U0NTL2haeTExNnoyN1hvenRKNUpOWk9R?=
 =?utf-8?B?MzBrVk9kU2w0MXNIelhneUNTckdyalc5aTBNWjlWUUs0VUU3MnhmaXhnNndt?=
 =?utf-8?B?TTVUMjlLM1VLbCtnNGgzUWhJbzJlVVM0RThWWmZQWVg3b3dsYjk3UGhtdEpo?=
 =?utf-8?B?YWh4dkZEUW5BeWlXM3M0SVJNb3lEQ2cxTy9xSUNraVIwb21RdXkybVVYOGps?=
 =?utf-8?B?OXJvTWVzZktXSXVEaG1HVFZEb0pJMzQvTFBoSDJwZ0pZUEJ2YmNyK1VBS2tZ?=
 =?utf-8?B?VUY4dDRucE9qUkNuRWtEdHN5dWxINFF6bmhRSVBiRUdGRys1OEN4S0hvSXNn?=
 =?utf-8?B?amhXUE9aWDZadUpVaWlRRWVyeWNVY3hyTExpS1dwdDRzbE1DMmRST1psV1Zi?=
 =?utf-8?B?VS9qdTE3TlhmWmNvd1ZhV3dwWWdGZTBxelkvZnNJY3JidG14YVBKdWltWmJk?=
 =?utf-8?B?WTljYStnNEp4NGxPYW1rMTJubDhmQjAwcnpqU0srQ1JvaVJydWoyYWJzSkd3?=
 =?utf-8?B?NnJDL1hreklkK2NQa0VIRkllQk52U3l5MktvSHVESkZ4M2tlL0pjT0w3aVhZ?=
 =?utf-8?B?dk14SERNN2lhK3Y3WUpPRGxiZUZNamwyNVUyR29EczBvTU02Z01ER0htTU1M?=
 =?utf-8?B?emt1eXg5dDNGeCttaVJOZXNWcTdyYWNjUEgybkFZL3JjSnpjWW5zYmczd2ZH?=
 =?utf-8?B?Mm13SHZ1RlVNbXcwRlB6cVdUYS9KSXYrVm96SHNoVUpJUXc0M01WbHQrUzIz?=
 =?utf-8?B?T1Q4d1YvZWZkb1NRbWN4VGxnOThKTHU1Q04raUNZS0lCcHpONGtYVzc3ZVlP?=
 =?utf-8?B?QWlZb1hTSTB2b1VQeXhCRU1COWNKb2V5aDgwd0RwZVdYeUZ3SkZiZGlsQitS?=
 =?utf-8?B?VGpvYVpGc2xvN1BJVUwzWUVpTXlTVFNJQ25ZMExjQ1F0NGdzbHcyYzRQTDNy?=
 =?utf-8?B?ZDZraWVLS2d5bHUxSFBibldNNHdvcmkyRWhIYm5GRTl2ejBFMVV1WkVsbXNS?=
 =?utf-8?B?ZEdrT2M5dncxbVJPTmYvaUU1clFKTDlEUmgwNDhFd0RBWkFQSWlhYjNyT3hP?=
 =?utf-8?B?RE41MFAwclo0RFRXYW0zNmRZdFFyemdjNzR6eUVWdHhacDZnSnhGcHZIUllz?=
 =?utf-8?B?b1AyblRvWHFpMzUwbERzcmhtNFFMcGh5bmFZTHNIM2hJRDVJQTc3Rk8zL1NK?=
 =?utf-8?Q?C8IeLVXEMS9dwgdbktKLWJXaiwkTS0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RThqbTZsQkxCakh1NzFVUWRyQ2pmSlpPdXNDbXVWY0JnLzhncE5WcWJhRXZI?=
 =?utf-8?B?cFJQYmZveGlyd2xVNVpCcXc4Q2ZsK09IYjRsbkdoNk15b3ZuRXA5UHp5eGlJ?=
 =?utf-8?B?dExrcllvVHMrSnRNNWN2Vm5rYzZqL1dlMG1SZDFlYktZNVRlSnRQQ0tmSmJr?=
 =?utf-8?B?Ymt0SmM5UVFIaFZPaHpySFNUcG1TR0RjcGJGbUZOZWVEaXBoVkppWXRkUTBQ?=
 =?utf-8?B?Y2ZFRHQrcUtPcWo5WkNXdWZUcHp3T3plUWhQdTFoM1BOb1IxRWtXV2NjdlFL?=
 =?utf-8?B?SGp4R0JhYnN4VUJVQ1NXSDJMNEt1RTcxRlNqTzdRZ0Zuc0xZa3R4a2ZXNWlK?=
 =?utf-8?B?dFozc3BZczdUYUt3SENDckF6VGhwUUhpNEZLN1YxSlYzV2hwT0lYbk00aFA5?=
 =?utf-8?B?ZWp2QVdOOUVQcTRNcFVHRWo2SGpZNmN3UExuQ1M3dldRZHprL09YTWlvcXZQ?=
 =?utf-8?B?Y3pOcTZlWTFkUWU2V3ZpaENhY2pyQzk0QTg2Qit4OTAzc0dIYWNyenRPMG9m?=
 =?utf-8?B?YUp6NzR4dmFwTHFKZ3F6SUEzeVBUQXBYZFpEWGlQRUEyUFozYnRHT2tDUTE0?=
 =?utf-8?B?TjJkYmhzbWpqdTI3bWozUHJRNkU0NFpZVDFZZXl1ckJSaVo4cFNVd3AwVXdX?=
 =?utf-8?B?bWxyT2pjcTRGN1lEOTk0bHVJb0Y1RjVRWTdQZERyaDRZN0NMeEU0MGtsVDY3?=
 =?utf-8?B?eDh0ZXFwQ3JNcDJSTzRBWVBxRnVQc3FxclhzR1UrUDRlTWlsWTkvVTJVVkw4?=
 =?utf-8?B?OWJLNC9qK2o4eVVpYUxIM3dUYzU4ZEk5c1Z3VGVJVDU2YlRNaE5jS2hJV2pJ?=
 =?utf-8?B?TmFnd3krTTJ3cFZFNU5oaDhXK05wQWhPWDdPZ1N0R2VNdVRVVk1jbjdXa0Jo?=
 =?utf-8?B?SDdWR3dlWkhXb1RYTnN5cnRjVW10V01ab2w3aGUvOWRSWlVNSUFUTkVXQ2tN?=
 =?utf-8?B?d2t4VllqcEJCb1VyeU05MmU5Q0RqVEdraXRvUCtvV2NsYWdIcTRjQmhmTXo4?=
 =?utf-8?B?N1RDZTd2T1VEOHNHRGo4VTNrQWRCcWYvUG16RWxUbGhWOCs3OUtxbFI4LzhI?=
 =?utf-8?B?WmRyZUFNdVE5eGpQUTg0L2dFQ21EVWJXcDBqUG9YRmo1K0ZhWUZKUFFRZHFM?=
 =?utf-8?B?ZXNGcUlGcFdqQXRWMUl5RVNnMVJTQ0xLT252UjVkRzkvdHBTWVByR2JTTFU1?=
 =?utf-8?B?WHcyUnp5ekFHeHJETXlxNTRqQ1gwUDdzM2Fkc1pPZnFxd3pYNDcwRjRpTmhn?=
 =?utf-8?B?TWNhN3VHTE5WTEJmQmpFR0J0QUtwbkVEUXZNSDVFYUpyUVA4REluNlpiZ1RN?=
 =?utf-8?B?M1JuSVV5OFcvd1hNUGpUbWNHY2F1K0JKdVY3RXZDSDR6NEpNWEptZkpFeFcx?=
 =?utf-8?B?SGRkdWM0aHpQN1N2YlA5Mno2NEZZWkJMcCtQL2ZJalQyWDlpWWh2Y1kxRFlM?=
 =?utf-8?B?UG15TzB0Y3ovb1ZPNHRhallsT0NZZFRmZ3kzT1NvT1ZVSG9mZGJyVDFXdlJN?=
 =?utf-8?B?STI1cGszalZPVVZiZmtjdHh0aE4rQktTRy9BSHk3elY1SVF6SEhjckpSMmpR?=
 =?utf-8?B?T0FPWW5YNVVWdnAyMU5DbzMvcFVlMDRyY3pUaHhSVXFOeHZvNmJxK25teEQ1?=
 =?utf-8?B?UEo4MnViWHR2b3RROE9hbitFN3F3SDRqUjZrZzhQSGcyMURQTGtRWkZuZCs4?=
 =?utf-8?B?VTdJeCtQUS9raU1uZHg1NVhhM3Q0V2tXR3VRYVdTVHRSK3FGaG5kWjJEb1VK?=
 =?utf-8?B?cXVCaUpYSURiUDJJa2NOTDFHNFpLcUlCTTd1Vk1zRHRGZlVpaG1vUXRTTndy?=
 =?utf-8?B?NHp1dDF3UjEreU1LVjZlWWJTZnRJRnpLd2JWMnpUeVUvR2NRTVllbWpseStS?=
 =?utf-8?B?dExndGJqQzlqVVFpdXVyVmI2RzB2a2ZXL2JxRVJKTTErQ2d4ck1Kb29NSFBT?=
 =?utf-8?B?bUFRWTUzdzBKeFEzQnRrcC9UamtzZnhWbEdqQkRHaHB6NHU3MVNwbnBEQWpG?=
 =?utf-8?B?YlYzNEdXRFd3MmpvakxNNmNCeTRzTG9aYTNlaG5wQ2ZSOVlydFQ4OE9Cb05w?=
 =?utf-8?B?ejBGYWl0NEl2eFplQ0NpS2hqOUZkdEFxM1gvbVRsWHBBQlZXV25qbXZpcmph?=
 =?utf-8?B?d3JwVXFOTnNEd2FiSkJ1eGRBSVhtNDNNR0x1ajg4djZjRmhKMFJkODAyRVNn?=
 =?utf-8?B?cFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8E4E2E9AB6B77428682D3C214927627@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e2NRK6iGG/x9x6b1ue/jyKb325fef5Fqunnl/iRcTZcTgs6lZQv95GJyaRfUPLvIEoNm4VTAUD10owGHI2S9bryRM7bRELry2ib8M7nR5UGoovvvUK4Dm1BKvsunN6i4AV9zFmvHr3ZxMObzHoWZj41fpidfknsYXCXkl2PiGoGtiM3W3wbK93PqjV91vCl3bzo3ASYXAHlL3jqFcQAZhHZyflkG3AR7XSaFJAKd2z3E0/Ht3HkUywenW0yUmZOQJYLZckaT2GZRwVjXtkiUSFOM99knKi8tgm47P+1rFbaMMc7uLzlQ57A4f35IW76F61yMu0h5LSuFueM/tJQ8hZHDFQoSUj28whfoPsI1sY2a710ETNU7pkNMFzrWGjlJRLknSuxUutqNR+XYmR0ZIdbp88cK5IGxvoKSn85UYP9OSi+jUa46EjdYEo/5VS1Q1jAIJURNYclSikYYKdG8I0nkYkiDP3MeN7E1oUSS31xmoO9yuIaRJkPdc3uA6bQU2CsKG059J4mPFKlFra1a+9oDL0d48wE73KbJ06n8u1nUo6wxvPaeybF5ixVg+nR/RpF9GgTFTrakkoQULM6Jn+bGeUn1DFeC5hdKqx3bHK223sl2RAdIrLT1DF0iDdz/
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea2c01b-8a21-402d-4299-08ddc055a35b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 08:33:40.1457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oLy0VafigjMvC/phLYROOg+ofdsGNjmd5qycdKOcn5roSFgZvGhDxCmR6GpfA6PXH2daaAxTs/VIZ6UdAW98OF6gB3/UqWe/fGdF91e5f4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7461

T24gMTEuMDcuMjUgMTA6MjYsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gT24gMTEuMDcu
MjUgMDk6MjQsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gDQo+PiAtCW1heF9hY3RpdmVfem9uZXMg
PSBiZGV2X21heF9hY3RpdmVfem9uZXMoYmRldik7DQo+PiArCW1heF9hY3RpdmVfem9uZXMgPSBt
aW5fbm90X3plcm8oYmRldl9tYXhfYWN0aXZlX3pvbmVzKGJkZXYpLA0KPj4gKwkJCQkJYmRldl9t
YXhfb3Blbl96b25lcyhiZGV2KSk7DQo+PiArCWlmICghbWF4X2FjdGl2ZV96b25lcyAmJiB6b25l
X2luZm8tPm5yX3pvbmVzID4gQlRSRlNfREVGQVVMVF9NQVhfQUNUSVZFX1pPTkVTKQ0KPj4gKwkJ
bWF4X2FjdGl2ZV96b25lcyA9IEJUUkZTX0RFRkFVTFRfTUFYX0FDVElWRV9aT05FUzsNCj4+ICAg
IAlpZiAobWF4X2FjdGl2ZV96b25lcyAmJiBtYXhfYWN0aXZlX3pvbmVzIDwgQlRSRlNfTUlOX0FD
VElWRV9aT05FUykgew0KPiANCj4gQ2FuIG1heF9hY3RpdmVfem9uZXMgYmUgMCBoZXJlPw0KPiAN
Cj4gSXNuJ3QgaXQgZWl0aGVyICdiZGV2X21heF9hY3RpdmVfem9uZXMoYmRldiknLA0KPiAnYmRl
dl9tYXhfb3Blbl96b25lcyhiZGV2KScgb3IgQlRSRlNfREVGQVVMVF9NQVhfQUNUSVZFX1pPTkVT
Pw0KPiANCj4gSWYgbWluX25vdF96ZXJvKCkgcmV0dXJucyAwIEFORCB6b25lX2luZm8tPm5yX3pv
bmVzIDw9DQo+IEJUUkZTX0RFRkFVTFRfTUFYX0FDVElWRV9aT05FUyB3ZSBjYW4gZW5kIHVwIGlu
IHRoZSBjYXNlIHdoZXJlDQo+IG1heF9hY3RpdmVfem9uZXMgaXMgc3RpbGwgMC4NCj4gDQo+IFNh
eSB3ZSBoYXZlIGEgaHlwb3RoZXRpY2FsIGRldmljZSB3aXRoIE1BWiA9IDAgYW5kIE1PWiA9IDAg
YnV0IG5yX3pvbmVzDQo+ID0gMTIwLCB0aGVuIHdlIGdldCBtYXhfYWN0aXZlX3pvbmVzID0gMCBh
bmQgdGhlbiBkbzoNCj4gDQo+IHpvbmVfaW5mby0+bWF4X2FjdGl2ZV96b25lcyA9IG1heF9hY3Rp
dmVfem9uZXM7DQo+IA0KPiBPciBhbSBJIHRhbGtpbmcgQlMgbm93Pw0KPiANCg0KRm9yZ2V0IGFi
b3V0IGl0LCB3ZSBkb24ndCBjYXJlIGlmIHdlIGhhdmUgYSBNQVogb2YgMC4NCg0KUmV2aWV3ZWQt
Ynk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo=

