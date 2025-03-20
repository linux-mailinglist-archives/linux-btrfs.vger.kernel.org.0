Return-Path: <linux-btrfs+bounces-12464-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16854A6AAD5
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 17:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A514670DD
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 16:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47B61EB198;
	Thu, 20 Mar 2025 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fpiicVe9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SffJEFgn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFE374BED
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 16:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487134; cv=fail; b=syqhaW0fMsXuH6hRjVTThzgvn+lu6d05cypOwf4FtJ/oLgPoL5S1MCEfUHYmP/pSH3ZWLdsLclFmcwOSUHA6KE6k9P3xDlDBFYKcYlR+6oIeAU1+rTapBCrnhu9Dnulw2ukvtyAEXun0Q2wDqNMIszmqVnZO99ubKpdt8uTFnIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487134; c=relaxed/simple;
	bh=aL9PC58QRhUMSDjRVYBoVA6A8QgnO6Zki7wIAoirtFY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L/T58SXkZ4FIDchIsr36F84D3wclmkKGZtL7uy82rZZjdJ8YB6OoWE2L+zQiSz1pL1WFrb8yfZLyG2MKwdPiSN81LsB1QZ6h/9YyUqAXgnNE/lJzO8gly4KI707bBfU318dpyGZSXym6XQcNoXALr/0WWUSodQa0AXwAkWBcjG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fpiicVe9; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=SffJEFgn; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742487132; x=1774023132;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=aL9PC58QRhUMSDjRVYBoVA6A8QgnO6Zki7wIAoirtFY=;
  b=fpiicVe97w8Ykk0uuvLmJ7tWi6tEgsv7IYVd6fnZRC6xjgz46YxFsq5w
   vs79QIv9ZG9r9+L3TrolNcTptQKSkoe1bIIj7W7uhWsAfOo8Kk5USeJP6
   XeRyPcTzBHEUvLIKuNOAR4qlm9xuv6hVkPXLKVg5bliAnXUvfWy17dlCC
   GkSL7ShMwJ71/lu9h0B9suxBrq/we7ENfxGbvYLoh1LhR7p1FBujRwej7
   32Wu5qL/vPEYdnRi3H7ndQzOkhalABms4QLYOyoxgNP5HH21Dqasd7yft
   eUqFWMngsxU8ShsnSJfamZ6datECNgtQ1O8AU1+Fbs5Y0p/bkh2wBC79x
   Q==;
X-CSE-ConnectionGUID: 3Qa31afeQUOC2NU53Zsn2A==
X-CSE-MsgGUID: VVB7G8XpQhGfyhsGN6zVWw==
X-IronPort-AV: E=Sophos;i="6.14,262,1736784000"; 
   d="scan'208";a="55037900"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2025 00:12:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4c3qaIi4hVb3iNQNrDKfHnlmlUbd491zgST5vITnN65sMShSxGN5ZY/75KnhuTFIAie5P/m23zaBDpsG8VoNHJ2+zN/SfOfLb/0veGtczj0c3eMQwOMEv/jBNL+kAjxP7SZylek3iiHeHOHLUKlwsMEL+dgNWjn0+EHUzu1hY2MCWGAxyrR//3GW55cbTATgzg/HZ2245E1nEJV5pOMC0tAdfQMEnL+VMpKklUnLhLLCgu5EvJM3YVSCaUw4PMUtfbtxAJhhBuK7XxWEaC5Qs0iyRqNdxxel0zKSK0s8fAPepZprh4BbOODS+xUKsH8EyxzOMLCFpK3cXksorO8fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aL9PC58QRhUMSDjRVYBoVA6A8QgnO6Zki7wIAoirtFY=;
 b=eK4Fepzy0Z6fGt8YqGyRIVhELI/D5VaHQRSPUXc53cWkNCjq1nfKg6cmtt9hhzGT+JZ531LBCj6fZ/w8TcHZzWpowsrMiaGw627ucY4TnQ9o2vyIoe8tZG7EdDHG5bAcprumyQe8lXdT2TvdGLffiBXkNJ7QnC266lVKJjOViTKJhYH+aiYFSyWtDbCU8LD4vWLC4w6yQ8XFhUpzm753vGjWXlDAGGhXovcuSnauETIy2LSp6PRpt7Vl3EqKBionAvOWodd6sikHlQpLcFy61Dw6tkW5/etWxdzMTaqkVNNF2x2JOLMHbkeverPUCmOlIlTfXdFvV4FSyIG/1wMsuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aL9PC58QRhUMSDjRVYBoVA6A8QgnO6Zki7wIAoirtFY=;
 b=SffJEFgnkPXDt5D7kno3otghdPl2B67pQwDVq5NK6SjRmHRQicjRSuN8gOnMnCAxDKSN/JwngTQU0Rq0sNk/X9B9UAjEcBd4gU9QBeyognZ0JmmdlDTHR7DIrJ7f4rzTjocJ4JONDGJ99so80S/iAoBTW6+0KeMrWbadjELqOZw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB7076.namprd04.prod.outlook.com (2603:10b6:a03:222::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 16:12:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 16:12:09 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 09/13] btrfs: introduce tree-log sub-space_info
Thread-Topic: [PATCH v2 09/13] btrfs: introduce tree-log sub-space_info
Thread-Index: AQHbmJaWgpZr7b3CmUiZ/6bF9CvcfLN8NHgA
Date: Thu, 20 Mar 2025 16:12:08 +0000
Message-ID: <a53f482d-310c-4c58-8e3f-659ef1888b37@wdc.com>
References: <cover.1742364593.git.naohiro.aota@wdc.com>
 <f4679fa21b8b55e467c653ae7f0efb64e27044ad.1742364593.git.naohiro.aota@wdc.com>
In-Reply-To:
 <f4679fa21b8b55e467c653ae7f0efb64e27044ad.1742364593.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB7076:EE_
x-ms-office365-filtering-correlation-id: 4d64607a-1197-4c08-a4eb-08dd67c9f731
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c2g3L0FEZzNDdWhKcEo3RVJCYnRPWERSNld4S0JySG90aUhJQmxZME05REJG?=
 =?utf-8?B?NVpsaTJ0d0hYSGpFM1pob1pDalFuNVdKUkhvejhmaDFpdXBVbE9oelNjVFNu?=
 =?utf-8?B?anZERG1YZHBFT2FBa2VDSUJXbHc4d0lST1orN1ZvMmxjeFNQZGEwYXhIWlds?=
 =?utf-8?B?alFpYXN2Q0ltNGdyczJ2KzE0N2RGU0NSWm1IZ3NtL09XbU13d1hkL2NIQUlU?=
 =?utf-8?B?VkZ5emJIVlpTc1Y5Q3dVeFpMc3lMTmVLTXIxUUIzKzdIeFlKby9rRmRGTXpz?=
 =?utf-8?B?d210eEtLYk9wUWRBSFlpKzhtbHN3Yml5S2svYktUMnUreTc4VHN5NHg2NkdM?=
 =?utf-8?B?emFnNWNCWS9KRXNtSmpBbVdmMWFIQitoTlY0TjBNaEx4YTMzZWdYRXJRKzQ4?=
 =?utf-8?B?MUZXZVZxZ0tDQTI0cWIwL2xSbzVkdE40bi9XeVFMY1o2ME5ZOEUyYWZhSlVw?=
 =?utf-8?B?NmI5WE5ZczRGRWJUTm5Mc0VNOWN2bXAwaWpqcFMxY05leVJVQTVOQlNJcmxO?=
 =?utf-8?B?amNvMDViRS96OTdSeCtxWDVmem1DeFpaUHlocFFWZlJJR1NYYnBGbDFxSG9o?=
 =?utf-8?B?OUQ4YzNVcG1CanFGbFdlcVFJdzg2eUFpQlpvWm05WFFMNjVoeUZ5bkd5ZUVX?=
 =?utf-8?B?QzZOK2xoZW95eXdzTzdxNUZyNDBQeURUamQ5RUl3NnBLQ1hKYzJBcVNaODVi?=
 =?utf-8?B?d0l2aWNOVHpuWGROcW1Hd0pPNlY2azNUTkltNS95NnFPUldxbGUwejYya2VU?=
 =?utf-8?B?Y2daUGhaMmpWSDlnY1NwaXlHZlNWNEVpTVhISkptWExZTlhzUXJ0Sitsam9V?=
 =?utf-8?B?UnpNaldBZGkxZWVNZGRHU1NjRVRUblE3aVdwWFozczBDam0rcVdESmt6bnUz?=
 =?utf-8?B?dElTNFZQNDZBU1JnZnJZZEM0L3o0Zyt6UC96MEdwU0lXZ1JaLzI1QjdZdGth?=
 =?utf-8?B?VHRyWXFmMG84UmNsckNXNEtDU1BMeHI1a2Fja0cvbVRrT1h4aGRTMjkzbzdl?=
 =?utf-8?B?SlhWb1Vmak04VHZtRnNqTnk4K1ZDS3A2ZmJ4KzdqdFZ4Rzh0SklzMUtwNzM2?=
 =?utf-8?B?cWY5R0FSZ3RpTHlDMkRId0RxVW5OMW1pUDVVd0owem9RTlV2L1NBald3Y01x?=
 =?utf-8?B?QUJqZnFtTWtHNnBFVkx2M3RBWTd6TjlWZmpLa2JUNWNldUpqTnBlV0hNZHVV?=
 =?utf-8?B?Z1FDbDhXZ0dpQVNreGw2K2R3Ty9BbGdrZVIxUjl6TUhEc3JFTGsrT1FkbUMv?=
 =?utf-8?B?RENPYnlDOGQ3dG1kMTEzYnM5c3dvTkd4NTdmR3pQTTYyV2UyQlk4NnZKM0xH?=
 =?utf-8?B?YThmL3RaaWxSbkZqMnZFUTNTTk02TTZicXFkbUswZ3VWYm10Q3JncGlkckV1?=
 =?utf-8?B?YkVtSkxudXNUV3I0cW5peXBUc24yM2lBM1NaaitmTHlkcURQNWFpZW9oK2xO?=
 =?utf-8?B?dlZybDAySmJLWDBZYk5OR2R5d2tUUENDOWhtd3BEVkxPN2Vpb2ZjR0E5dkxY?=
 =?utf-8?B?Z3d5dkp5d2xUbW9sWWU5SHhJdmhrOW9manlYZkVFR3FMVTMralZtdXRQYkIv?=
 =?utf-8?B?ZWRHeE1sMk9ZK2lLMkpRVytYWm1vVW8rVjdpQTF4d1lnSDJkQ0hPZHBMWCtB?=
 =?utf-8?B?MU5vcjJMU01DeDhFcFE3OXNFMFpDaWVvTmIzajQ5Mm9LdHlSeGE3QnVVOHNH?=
 =?utf-8?B?MUc1YTFPSWdhNFVOZ2R6RS9hRUoyOVJZaEdXT252K2ljbERzWm1uZ2g3QXFx?=
 =?utf-8?B?ZG1XWldtTHFOQVV2eElQa0lXdjF6bWNEcGIzMnVQUngrVURybWprNFZPcnI4?=
 =?utf-8?B?ejl6WVNsdy9kMGpqSnZHajltdzE1QkhlSHowTERRc1UzMkxrUmR6cFdIT1kv?=
 =?utf-8?B?WVZBaFFzN28zN0tQWUlXK1NyQUZKL2ZNaVUvcHYyT2VXZHFjVDBVNC9rb1hJ?=
 =?utf-8?Q?nY9DOed8NtQ516Wzg1Q3P6DXeuUZB1Zx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bzFwZGNmRGphd3l3dXJNdDZpbi91VWNEM0dsWWtibnVXcWhEZmpGK2ZUV2gv?=
 =?utf-8?B?ZmQ0QWljd2RuOUpMMVJWaW1hbi9ES0NFck5maGMwQnl2bWM2eWpkWEZxS21a?=
 =?utf-8?B?SXU1WFVucDRTQWJmYnNMV3FyTDR3SFdQR1EzVFJyRktPbnJRTGFzZG11bTlC?=
 =?utf-8?B?SnIvQzJUZWRYRWIxdVNsMXlIV1RKZ0RSd3cvMHlhekZDM3BIY2ZURjJYMlV6?=
 =?utf-8?B?MU82WUs4WkowQXdnZ2NGb1N0QXI5MGdVVkwyc1lxWVVKSTNya0sybGJlWGpj?=
 =?utf-8?B?bUdLdHljaFpSTFVsUXFFZDNscTBtbTVlRTFWd1BHalZGdVZkTnhKT3pSZ0Nw?=
 =?utf-8?B?SHdWaGY5dHBaWHNIR1dwZkFoNWVmVEM4KzNKYW9rTDAxcU1IekV5Z1lTMXBr?=
 =?utf-8?B?ZGU1RUdJRksvaGN3aGVtQy9GNjg5aUQ4Y2xveC9JM1dBNGUrZml6ZFlRVitN?=
 =?utf-8?B?YVpIdHZtaW1pcWo4OGRJRlJFb2Nmek03WGxWZ015c0I4Ukx5Z01ITkR4UDVL?=
 =?utf-8?B?bXdhQzZIdkR2cFJWR0VhSTc4KzlLbitleVN6eE5ubjRIcHFldVZvNXN4WFdq?=
 =?utf-8?B?WlpDN0NNd1NudCt4MG1JUWRrbG5vNDh1azlzOVVJM1MyQWpTZkhoZURKUEVa?=
 =?utf-8?B?MlR1ekRWSW5rZEVtTnVjcEVtREQzMEVESDVMRjJRRDgxZjFGZE5kSW1OZ2Q5?=
 =?utf-8?B?ZXhRMmkwcXZFQURvRkIrS2hhaktPdkdDOEY4M1pqcnp4cUkzUzFPbmx6Y20r?=
 =?utf-8?B?ODc5dGhWN09VcW44UUJuNjE1RTBwNW9IR1ovZjVIZy9Db0JMR0JBVkRzTmR6?=
 =?utf-8?B?TWZjUDFONFpJQkFHcGNlc29MS3hHMU9GUWdsR3dMUmVNc2x3UmpiUkxwcHdX?=
 =?utf-8?B?TVlrcTRaUXRmY29hQTJlOWJvQ3VIYmRTNlZ1TnJMSmkxS3NwcWFaOFo5VktW?=
 =?utf-8?B?Q00rUmdlMVZaT1dDQkpCK25qZ0d3K3lONXA2MWdaNG5xOXBvMG0rZ3FJQjlK?=
 =?utf-8?B?MHF4NkpaRytYZFc2K05adXg1MTAwYXVwdTR0SDk2TnJLKzBXalZSejBpWElI?=
 =?utf-8?B?bGRERzVLYnBLL2s2b2V1RytwR1A5THJIZ1VSSlNkK3QwSDNJcE9wWFdhYXFS?=
 =?utf-8?B?QzdWYUU5R0huVVBPMlhlZ0p1Q0NpYkpTTWpLUUtOdm5FekhzTTQ4WWZoMzN5?=
 =?utf-8?B?RWZ6VldtQU1OeWpKMk1sc1lNYlJ6endMeS9Ic29CR0NwaG12cysveVNlWXkx?=
 =?utf-8?B?L2tyY1VKaC9TbGlDOVNoRXZYRHlkUmUxMWllMmkvUWNlNnkvNEJ1VnEyU2Vr?=
 =?utf-8?B?ZXBldS9CVmdieHNZT1Jjck9mV3dhZWlvcHpucnRVN3JzSjlEVnVWUEdJTTVI?=
 =?utf-8?B?L0g5ZlZsS3JQTGVTOWdVSW5Mc01GdDgvVzc4aVh6b3FjTWhuazBpbGphRVpE?=
 =?utf-8?B?cHpTaU9Xd2Jpb1FDMGhFRGNIVlNFQW5IbzhIVXdjQ3AwL2JKaVFsNUphakRS?=
 =?utf-8?B?TDYwOE5BMU5OTXg2V1ZxMndFVFduTDkwKzYrQmx3Uy9oUXBwSEJEb3RRQTBh?=
 =?utf-8?B?Z2xIZE9STXQzaUlxMnpnbkJjVVQrT2xEMVBvZWtISTdOQW5YSElUQXIzUENF?=
 =?utf-8?B?QkFpK2JZMmJNUFB5S3RoZEZwakxxSTFVZG5JMXJ0ampuYkp6V1JFaWtmemM1?=
 =?utf-8?B?UFVkMzlnUk9JS2hEQ1cvZjFWcTV2TVV0Y3BsQkhOYTFNbWRGUkVGL0pYay85?=
 =?utf-8?B?Y05vaGZ1U1dhOHYxdjdjblJ4cUthNjZZS1grdGVwS25kTHl2c3hzYndpbW9t?=
 =?utf-8?B?b2d5VWFKbnZmUzlSdXlSWnBzelFIQVlVS2NLNWFlQzI0RmZKMGRQT2RCRDVs?=
 =?utf-8?B?YW9XUkE2Q2RjaHk1R0tMTFFEMnlBTkpKNzJndzlxaXE2RHhkdThac1lTTW5q?=
 =?utf-8?B?ZnBsUi9qMDVWNmViaExzZTZ2THlqeGdKVmk3ZXA4ZzVMNmZaMWtYODRlSDVt?=
 =?utf-8?B?NGYzdnZ5QUltTDlkTlRmY0JXK3pUR1F0am93SUNmd0NtSlBQNjExN3ZDTDdV?=
 =?utf-8?B?dFhCbUdzb3dZMk12ZTlxbUY1ZFlJYXpMQ1pseW1nZ0ttZm4yRnArdHpvU0Zr?=
 =?utf-8?B?UnJUaEtqbzcrL0p6MFhSTk1FK2IzV3VWaTJmVEYxRlE3WE02VVVRYWVzd0tP?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A325B0AE80E48B4FBF184AD1A1A8D5C3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yHVEYg51JUCMsBBDELiRNdYXKxl6K6JeAU6n/LzgrJ5/OMJuasJetdOpOl4s+icixkr7L+83WRwmPig4idSNOgHa5vTM1waJMSEVKBtXSM68sKy1hZFY815lHFeErMPQTRoaRxK4+1T42w+q+sLnPGN3MlYjinl5L5lsaouBxqePnCaoUtlqDy93qCkYz8vxRaBWHsVWwkP13TUsKGhd6oUpRSr+Af1AAUGd5qJkBfS604u0cjHY0JD30IyueLAn0BLTEsfdJUhaSZfnFj3uf7JMw+spdfgzJF7cj5loST3LydLvSxZuRzy75I+NSe548x7VmN+AFlqYSlsI3OlvjBvTi6Y6BZ1pqAyqSW3KiSSymc8gcRzhXWUCWNCSvcZGRPvS/JSVJBKdU9SYx9QrmOjLE916I+Wp+gZEgJAYzJyAdVYKaQ80ASkoMV+T/XS+9oWYYKd2ltDtPVYYewa2nvWLB0prngNJoKOqHqGdA6aOH7Fs64dK2vTS0A3b4G3QDb6XzDdXNIsMcAsOWBQ8dWPbxhkKFA47ILcfvxbRQF/61yRCbuAwwHWA3rKK2cZxh6XcqQBeG9LDhbuxJPhpe73XgSqkkulMOUIy8sdOAFubjjW4rprXLTYN320WeLpx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d64607a-1197-4c08-a4eb-08dd67c9f731
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 16:12:08.9518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TWXUKDQgWFPrSz6Dj+h1EJpD/78RT0XoGBR9L1bw8wEjEsSYVkr/p5qFfWaNTbNJbaLMz+fcD+XZ6UIwC83KcV/jFBVMkpyAib5z5YO16x8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7076

T24gMTkuMDMuMjUgMDc6MTcsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gZGlmZiAtLWdpdCBhL2Zz
L2J0cmZzL3NwYWNlLWluZm8uYyBiL2ZzL2J0cmZzL3NwYWNlLWluZm8uYw0KPiBpbmRleCA1M2Vl
YTNjZDJiZjMuLjNjNzc1Yzc2ZTJhZiAxMDA2NDQNCj4gLS0tIGEvZnMvYnRyZnMvc3BhY2UtaW5m
by5jDQo+ICsrKyBiL2ZzL2J0cmZzL3NwYWNlLWluZm8uYw0KPiBAQCAtMjgwLDYgKzI4MCwxOCBA
QCBzdGF0aWMgaW50IGNyZWF0ZV9zcGFjZV9pbmZvKHN0cnVjdCBidHJmc19mc19pbmZvICppbmZv
LCB1NjQgZmxhZ3MpDQo+ICAgDQo+ICAgCQkJcmV0ID0gYnRyZnNfc3lzZnNfYWRkX3NwYWNlX2lu
Zm9fdHlwZShpbmZvLCByZWxvYyk7DQo+ICAgCQkJQVNTRVJUKCFyZXQpOw0KPiArCQl9IGVsc2Ug
aWYgKGZsYWdzICYgQlRSRlNfQkxPQ0tfR1JPVVBfTUVUQURBVEEpIHsNCj4gKwkJCXN0cnVjdCBi
dHJmc19zcGFjZV9pbmZvICp0cmVlbG9nID0ga3phbGxvYyhzaXplb2YoKnRyZWVsb2cpLCBHRlBf
Tk9GUyk7DQo+ICsNCj4gKwkJCWlmICghdHJlZWxvZykNCj4gKwkJCQlyZXR1cm4gLUVOT01FTTsN
Cj4gKwkJCWluaXRfc3BhY2VfaW5mbyhpbmZvLCB0cmVlbG9nLCBmbGFncyk7DQo+ICsJCQlzcGFj
ZV9pbmZvLT5zdWJfZ3JvdXBbU1VCX0dST1VQX01FVEFEQVRBX1RSRUVMT0ddID0gdHJlZWxvZzsN
Cj4gKwkJCXRyZWVsb2ctPnBhcmVudCA9IHNwYWNlX2luZm87DQo+ICsJCQl0cmVlbG9nLT5zdWJn
cm91cF9pZCA9IFNVQl9HUk9VUF9NRVRBREFUQV9UUkVFTE9HOw0KPiArDQo+ICsJCQlyZXQgPSBi
dHJmc19zeXNmc19hZGRfc3BhY2VfaW5mb190eXBlKGluZm8sIHRyZWVsb2cpOw0KPiArCQkJQVNT
RVJUKCFyZXQpOw0KPiAgIAkJfQ0KPiAgIAl9DQo+ICAgDQoNClNhbWUgY29tbWVudCBhcyBmb3Ig
dGhlIHByZXZpb3VzIG9uZS4NCg==

