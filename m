Return-Path: <linux-btrfs+bounces-17500-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B838BC0515
	for <lists+linux-btrfs@lfdr.de>; Tue, 07 Oct 2025 08:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0ACAF34C869
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Oct 2025 06:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2FE221F1A;
	Tue,  7 Oct 2025 06:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p4mYsxHS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="i/WH2c/d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F220634BA4B;
	Tue,  7 Oct 2025 06:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759818118; cv=fail; b=qeQXpqIMUr8Xs0X0kO86pHjOfXhgjiTdyYbnmDEjMkhNM1wESucgwItWhfVw9N7ffq8pN/4qAOz/cAH8O2UpPIOIiGO5WRdH2emXzJPhCf3PoFMWnPy9HctX/0+LxM0ozHugtGAvbkPXU4iZwXwk0U5dmA0FA5z5swM1NnRH+fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759818118; c=relaxed/simple;
	bh=RZKEx9iLYo+0m0cUhheqUMnyMsnEivyFsMKuORu+dRY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pVVYFUYHavGy/oMNlPLnj81po6Y1RYYhL7IZu05A52P/cEzrYxLHNYChrnhYCYqE9YIxx0zAVd3+AUM7LQeU3xnxOWXhj5QhgI2WwtL/vQq5dTwZ7ZOhOwR1fl2smkWlVU/dkT888BNmQ9mVK7wSAfKDkfGmrPAPynBEVo8qMeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=p4mYsxHS; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=i/WH2c/d; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759818116; x=1791354116;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RZKEx9iLYo+0m0cUhheqUMnyMsnEivyFsMKuORu+dRY=;
  b=p4mYsxHSB1TZ1vUF3zOXl4YcXaO3J9M2NIg1LQIPMNdnAXBwJkgofnvv
   DbIW3R5RRycuRuIFWLlOWhDCZV71Fd1UcEbmdL8kpCSzrl6zyooNWTNBZ
   HLYV+fbOuXla9+/g3xopmZ6YIKj1ErmE/8sdwuJcOP+uKq51WdJcp61lv
   ubRqJxChvYtjETmyMOFgf1w62G5kWGBvnLV3nx0Hph8jU8cYd25+kj8ZW
   So/cRKDfZDmt/jnN82eaC++pyT3Y7bJX9ySJXi1Opf5xap1GthuWe/bNq
   wRK3+kXiTQx17kzK3DWA+SdcYpQiH7vB43l4z9k6fj3RrvSbpz3xWjgYa
   g==;
X-CSE-ConnectionGUID: esJaZTj2RLqhdj9I9lkGqg==
X-CSE-MsgGUID: nA5O68clRaWeq5T5sK/2IA==
X-IronPort-AV: E=Sophos;i="6.18,321,1751212800"; 
   d="scan'208";a="132599353"
Received: from mail-westus2azon11012024.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.24])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2025 14:20:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=boifQwyKv9/GmRn4fPs6Oy66NrDMOqJU0nQ3nnW+O2/4Fu5TL9O0JRbgaDmpHSBXdvnKVRfetkRRbK++qcilONKM+URr5OhHWdMBO0QMdPMqAo8G6iqCWfab3umZRGOgq/5nTdamCI2Ip2vALyUM+f2FhJB27Kc0R6z3XEyslum3AtV/luga/X5trvHKkSPeTvX/sjpks8TXpAVpkxBTq7htR5G+m3JrteNyzOpoiapgIO/KEa0e2DSpCnum0Ws3dKhiRCv28Kaopgo72X0nGmW54YJNR3HcQ68FJxyg54un9M3Amwr+ssmVwX1TL5bis8f8CAumZdOxhq81/EI/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZKEx9iLYo+0m0cUhheqUMnyMsnEivyFsMKuORu+dRY=;
 b=sIZXupOduJp8R/8Cojotx6VLWIdiRuvErbgptxc6423ipaW3JNot3tdQOJpDzCd6unQkNtTX+kFjmrw/T6wqigZCcZQGUfbp+xUEpOQZSgNBvx7YHEObuLWY190LcUahoEOXF31CtZ0n8YlEjUDjVgOsCBjt9ObtBOoAi2g5xyoOfU3z0h1czwOERLEGha0lkhRdj7caWBFuWwrNxGCKel8CI7YEmf3deKknmLSUGff1CX27Y9X1N7q4a7X3LEBEz+3dsIqYrHpJwTghaclAI0gch/lUwcAV5ANC57akgTdWpsD8d8G9+esk2/J2GtOI6uP1oTfOb7YLtkqg3D/TzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZKEx9iLYo+0m0cUhheqUMnyMsnEivyFsMKuORu+dRY=;
 b=i/WH2c/dSAoy9xLIIPqc+X39oehsIhHGuUNF99JinV0OhpUIdQ83IqdU7TBb9As+GyCMFksy0T1wO81vgpRGJUpkTT/x1rHtdV9DTbKTHykfcuUu28jsuaWNmzbEkT1BYv15pP13JjfChN2YCTOOM/AlCLDpTtcURjswbE+2IlU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO1PR04MB8235.namprd04.prod.outlook.com (2603:10b6:303:162::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 06:20:43 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 06:20:43 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Carlos Maiolino <cem@kernel.org>
CC: Zorro Lang <zlang@redhat.com>, hch <hch@lst.de>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, Hans Holmberg <Hans.Holmberg@wdc.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] generic: basic smoke for filesystems on zoned block
 devices
Thread-Topic: [PATCH] generic: basic smoke for filesystems on zoned block
 devices
Thread-Index: AQHcNsSkKVsK+aBvHEiicL8kQQHvzLS1c98AgADDmwA=
Date: Tue, 7 Oct 2025 06:20:42 +0000
Message-ID: <78e121bd-8f6c-4b79-808c-9f5f75c90d8c@wdc.com>
References: <20251006132455.140149-1-johannes.thumshirn@wdc.com>
 <OtglCyTJgl3RCnletH8ai3IsE0wk2nR5CISvt5ZfvYPj85MMxGBFHEw9UmPSHvpve5QOIFQCXD9LFB1DpsNuAQ==@protonmail.internalid>
 <20251006132455.140149-3-johannes.thumshirn@wdc.com>
 <iqwkuhobfvpeiktvk6pba6ahirgzngltj3ilrifcfgaugme67s@r54pl6d6foys>
In-Reply-To: <iqwkuhobfvpeiktvk6pba6ahirgzngltj3ilrifcfgaugme67s@r54pl6d6foys>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO1PR04MB8235:EE_
x-ms-office365-filtering-correlation-id: c32b6426-7e15-4f34-be36-08de0569a4f5
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VnpvOEpTUEVXVUtBaHpkbFBlcHdHelpJMWlsSXhmWEN4dithUVFJNTljYUMr?=
 =?utf-8?B?MmlsOHZheGpHb1RxTjNJVEhOYVJNZDhuMDVSZy9aZXdyVU8vUXlrVi9NYW5o?=
 =?utf-8?B?NVFSMmFKWTJ0UHFEalVSbWVWeWZtdlJoZVJPS1Jzdkt5S1RGeTZVeUNMblFZ?=
 =?utf-8?B?Z1FBMC9hUy9FL0Q0eHQ4TjR3djNOMzRLNDhxdC9IZVFPT3B6cTZwLzEyamVK?=
 =?utf-8?B?WkNpRzRSdUpYMlVqdGQ3ZitESmM3a3RubFJ0a3RPelFaeHppd3ZHUzRRV2c0?=
 =?utf-8?B?elBlZWlyakEwRnNnS2Z4WXlLZ3RkWXNNbG5tSlN2S1pEUld3ZmVSSmZzcnRG?=
 =?utf-8?B?WG8rY1RqQzBQeGNnc2ZrUWNycENpS1lFN3A4ZUNSbFRHOS9CblZ1WkZNYXhR?=
 =?utf-8?B?V2hvWXAwcjR5N0tWb1hxYWR0UkJBTmNNQSs5c2pQWlVhK0Yrcm4zTzNrdlhT?=
 =?utf-8?B?V1FyblYvWlBiN2wxQ0pucktWSGtRZllWcGI3OFFZaDN1OUNaWm4vaVpEckti?=
 =?utf-8?B?V1NOeFRHbDBPaWZObVVjWnY4SXNUWkk5dms2d0M4MU5jeTRPYnFnM0g1QmVM?=
 =?utf-8?B?NSs4QlZDYXJqRGVJMWV0YjJQY3prYmJ6dkVCZXlSWUd5eEVRYTUxRTh2UFVB?=
 =?utf-8?B?ZC9ySUFGc1M0TU5paEVQdEN0Rzh6ZWErYkd2Mk4yNkdxNCtQMkFWRXh2UzRw?=
 =?utf-8?B?YkJDMlBYMDRsS1cwZGhwa09XTkJMSkVmTDhtMnN1bzZ6Q056TEMyamtLUWJD?=
 =?utf-8?B?YjJQd0pEOVQ3MngxbFRUbmdYSE5XQ1FEcDN3bVZxamZVMSswOURkSy8wL2JK?=
 =?utf-8?B?NGhla3ZUTjVGSW1pTXRxY28yZXBOKytUVDBrOVJUYlJvWU9hYy9BRnRmNXVa?=
 =?utf-8?B?NTVDb3hBb25qT2ZZbHNYSmN3d0RjMXc5aFpWV1JMK29GQ0xqZTBaRmtLdFFW?=
 =?utf-8?B?ekxwV041R0tUQlBQbFlTSisrR3ZvSHRTaFZtT2tXcHovcWVIUmlZWUJ0WjNG?=
 =?utf-8?B?RTRuZERsak1JOW1Ta0NQd21CUzd6S1NwL1VvQktTR29rcEhCa0tqSWhGdDV4?=
 =?utf-8?B?UGxlR1l2eWFxd2RiNVRkQnd6amFaUFZTc2x4WXA2WDZlUjdNc2c3cFFBN0Yw?=
 =?utf-8?B?U0R1WEhrSGJtakptVFY1d0xicFVoaVJOUjhNWTRSaFF3clZIZUcvR2EramY1?=
 =?utf-8?B?WFpZR1VjbVRXOUNtV0krcUFFVWM4NXNJZjFPYUR5eGxMTlQ2b3diOHZsSHYy?=
 =?utf-8?B?b0U2Y3ZqYnJucjJCTUM5T2JBM3VKSEgvWU43WHJLYlZSM0d2cmc2VGpQMVlo?=
 =?utf-8?B?b1hvQnFrOHJjYXoxM1d2Ly95QTQxWlpNY2h0NWtJZnB5YUhOVnp3V3dINUg0?=
 =?utf-8?B?cWVNRHlzcjVIQVZrT2pkSG1vallFaWxTaEZ2ajc1Qm9OWTRKaDRMMXpVVUtm?=
 =?utf-8?B?OE1IMEdsalRRekhSaGNicjJxWFpoYmlpOVpUdEtkWVJXenpEQmJvaWRDcTQz?=
 =?utf-8?B?QVM1SDVVYUdOL0YrUDl5emFiNVp6V0NrelZuMjRPQWV2ajV2c0Z2SjYrSDZz?=
 =?utf-8?B?TWs0Nm4wMXZ2R2lvNnZqT05YUzJqbFpickt0WkQrQTlUenMySjJoa2YvSnlS?=
 =?utf-8?B?SUNtNjF0UWlXdlJaK050eUhOMDFtREVSc1A5bnhYZjVjMFdkNW8zZkU1Mnhv?=
 =?utf-8?B?aFZuVDR2aXV6eFVCdjVXSUhKbHJhOFhsdTdVMWRJcFkxQjJQSFRpdmdvK3My?=
 =?utf-8?B?S3h4Ti9SVDg5S2wwS1JUbi9UaWVFNnVqTkRQcFNlTS9xemZTOWZEZEx5Y3VK?=
 =?utf-8?B?NjBRQ0lKaXR4bWtUQnlwUmtKakJUaWRHSFNUSVEwaDlLRHZZdnk3dDFYeXE1?=
 =?utf-8?B?WnNZUmk1UWtZbVA5SkNISjhtMXBxbmRqeU8rTmxMQjE5NSs5UGtkc0dRZmJU?=
 =?utf-8?B?NnN1U0dpZFh1WGhWNGNEL09NS0srTFdPang1N0c5aE40d1NYdTdmNHRUbW00?=
 =?utf-8?B?UER0eFpYUnVISGY1emdNVXpPRXZOcDNJSGtUQ0lWV2dETWRFOVdTcisvQkVy?=
 =?utf-8?Q?UMkT47?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YjFYSlE1cy8xR0JHTzVzSGhPaVBRSFZ1NlBnM0U5aU1oZFBhY1JBSGJZRllk?=
 =?utf-8?B?NUkxVm03dmJ3aTZVSTh3NUNxaHZnWnFRTEhtWjE4TjBwdWlwODl1cVJSemlq?=
 =?utf-8?B?YjQ3cFFzT21XSjkrNkNVdDRsdlJqMFZVbWZMT2xCbmRCNmg4V0FQc3RsYVow?=
 =?utf-8?B?QUlLeWVLa2JYa3I1QmZUWngvbFU4NFZKQ1lRdDl0K2p4akMwRkhWRU56YTlr?=
 =?utf-8?B?RlpjaGpZTlF0L240alBydFR2ZkpvREJrUGNXVlBwSUY1NnVHNDEyM2J4dDNV?=
 =?utf-8?B?SGloSG5oNHI4YjZ0VzNsQUFzV0Y3YnVGd0I3RTI5WU1Yc0hPV1lxeExrZ3Vm?=
 =?utf-8?B?SlJHOFFaL0J5NjcrUDUvYnhNNWNWTnNBdHlIeGJ1UTRYbllIdThYQjJBaGx1?=
 =?utf-8?B?UjR5Mm5oUjBja2tZVlJiMjRVNkYrVENBZkFCaExGeS9nazQwWDh0ZEdRditC?=
 =?utf-8?B?MldaSmx1Wm1RcmdOeDZ2Z1hrQlNrVUdKUE5sVE1NNGl6aTdDRU9Eeldtd3Fy?=
 =?utf-8?B?SndUSm82QVFZM0l6bzhwT1lCYXJyZXJLa2pkakovNGtDNU1tcjYwWHVlQVU1?=
 =?utf-8?B?UFNiWUNCRHEyMktQZ25FdWpWRnVZM1JBeFprZTlNMElTazFLekVaQTBWUEN3?=
 =?utf-8?B?VDJyT1l5QkVJRDJHQUNORGRqSWxEUk4zNnlkQnhoaWFxZVJOUnVZN1NFNE1R?=
 =?utf-8?B?cmgyY1duSVRjeUdwSkVreHFBcldiRkl1QjV2ak8xbWh5KzVWZCtMOGhjOHZ1?=
 =?utf-8?B?K2tLZFMvM2JGZXpkYlI1Q2EvZHJtSnRKU1lVL2hQcVNYWEJSVlh5M3dEeDNq?=
 =?utf-8?B?WHFYVXFRYUY3OXdhZmdQTlV4UVhUUXgycmtpUzJUWHNHaWNucnZmdzE4Q2cv?=
 =?utf-8?B?elVrcVRMWEpScUFhYmdGR09lSUFvZlZTYnpaeVNGRVFMQk9zbVJtbFVGZkF5?=
 =?utf-8?B?TmIya1NiL3RQSk9aLzE5WTI0Z2hjTWRZS2FUM3ZxWnZCOVJzMkd2RnRrTmJM?=
 =?utf-8?B?VWQyTVdNZnd1a1psL1FkcmxWZG5jelJUR2dwWkdPQ2JYZlVKZmc1S0Vvd2hu?=
 =?utf-8?B?KzUzM0pON29PaEZ2aDZzMkNVOXJEZjlMWlNqYzBTVGl2bWVFcU4yRWM5S0du?=
 =?utf-8?B?YmgzSEJHSnoxKzk3RnNDNXBKcTlnSGRQTUV6WTZCWjhQWnRKZVFhR2p3S3c5?=
 =?utf-8?B?T2k3b3ltRFpHM0RIWFRMYm1DZ0FBcU0xai9lRHpSYTBhRUl5K2duNnlKcG1Z?=
 =?utf-8?B?NjlmUVZDaUlCRk0rNVV4VGZLSk9nUmc5Wkw5dzlEOVdST3E3L3QxTFFHc1I3?=
 =?utf-8?B?MWJGTkRpMG42dFpWR2dOSGlHdWU5NFlNS2dRREl0R2tiazlXVW55alQra3E5?=
 =?utf-8?B?NTU1ZTlpTjRHeW1EN055czYrMmo0aHIzSWlvVlZQeUFrN2FrT2FnNUFBVnRU?=
 =?utf-8?B?N0F6ZElLajY1SnhuVjc5bHZUMmNndWUvTVRFUzgvNG5QSVovWm8yVTJ3Nmht?=
 =?utf-8?B?Uk9FSGlOeU84UzJleElYYnV2TG0vM1JYKyt4dFE5L01EbCtHV3h0QjFxV25J?=
 =?utf-8?B?Q2hEaTI4NG95SXc2UXltckRDa3lnSGc0L0k3NmhuTldicFhKSUFFOWlQSXhv?=
 =?utf-8?B?WndlWHBybDF6bElIbDViaE9ycmRNdWgxdUFUTDZyQWhkZmhMMS93Mnl4ZHZo?=
 =?utf-8?B?U3BCQmJNWkY1N0dOTVlUVG5GaVpvSTBwOUkwSXkrZlNNVFpRcm1hbWdBT3hC?=
 =?utf-8?B?QklLRllPZnd6NHQ5M25HQ3VlNnV6eUl2TlVRc2Iyekt6UTdEL1czZjkwM1VJ?=
 =?utf-8?B?TXhUWFBwS244ZTRLLzJzTmYwT3RxMmNhYURIU25ia3FIMnhWUmZlQmNBZkJo?=
 =?utf-8?B?MFJhTDNIV0x4Z2p4NGhNUXI4dm1ERTEzaXFwamUrNTRUZ000TkN0Vml4SGR1?=
 =?utf-8?B?ZGlmU0xyQ1haSHJhZGJ6ZWZid1MzdXMrWUNiamhtQ0VhQnUxU1RsRFVucnpR?=
 =?utf-8?B?WGcxaGV3a052cEtkekdBMXp4K0V0UzUvbG84QlF1Y0xDMmJxQ1hwdy9qalg1?=
 =?utf-8?B?ekVaT2Mwbkp3Tmo1MnN4Q2xWWkZYc3E3Ky9xd1BMTjFVczM4OExyRXNScnpt?=
 =?utf-8?B?OWpWWk16Vm1pRWxTNlYva2hNb2FLcWhnYnRUV1g0YVVuclYxNExhanJoc2U3?=
 =?utf-8?B?aXJ1N2dCNHJTVE5ORXR1bGsxR3h3dkdxU2pyT1NVamxBOW85dUEvcElPUjdv?=
 =?utf-8?B?bW9VT1owYmFKWk5mcTBiY3h2MmtRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9181CF0CB5198640BEF685EA8B4B99C4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aZ8Sx+S3dY+qyK4KjdKRK00Ghgen0BFiKTkdrr6q1D/ioM4xmxYyZEuTXdLw8+WGYld6XxXCJqAU/ffcuXBO/MsB0jizX9Bwx8juUW4HQD/t0E1SM5I2qyRmb+xzOwkmgSC6cAAFw7BVpgL5dwZC5/ZQoSIlHlpBTH0HXK3Fdi9ivOZrHyd5FCO8DS2/jbecDkG64J3tCfy5dkHafsZ1g5ch099DQwlRjw6osapAr0n49G4gymba9OgsRzMIYGQAVVnQuX5QAxADkCqkLriW2yGgOwJFrW/gjhKDlC6oKzkhzCjyZncmMdbc5aUJjdjMG4Nbw2HqAPSNSRn1OsIOrvi6q2Oysr4q6sSO1PhtxB95mnu4SGUdACPMT9TjSyKb9LqZ+ISmiie07OIcykNRaC2HAvs8STjJti//Mz76gKcV6ixTJlHME6PBISy+UqHj9azsZNZIJBEdpchbcFJ6fsd2dDft6DeYBQBGP6bakR7XAunfyKjmi62SuRRSmAeT99gpBRhUeTDlN+hYcrEQk/fgG2rPj7jjxQuvNUpstMQiGG3yH/tKwwGdrwKd/UweM5GAbe729i6qKuNQUPk1Fjis+4+bksH6g5vT8D4auiT99voKPXyH4NwaMImRYWQa
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c32b6426-7e15-4f34-be36-08de0569a4f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 06:20:43.0440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k3CZuL1EGJ8SoYw759A9cjOnrRQpCWKYG4QY/TA9zX8dJsyaZ4nldhD13r51jLP229qPRQIPWR65ZDSWiIYA+UuU7OJ0qpiwNq/TN0x7wrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB8235

T24gMTAvNi8yNSA4OjQwIFBNLCBDYXJsb3MgTWFpb2xpbm8gd3JvdGU6DQo+IE9uIE1vbiwgT2N0
IDA2LCAyMDI1IGF0IDAzOjI0OjU1UE0gKzAyMDAsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToN
Cj4+IEFkZCBhIGJhc2ljIHNtb2tlIHRlc3QgZm9yIGZpbGVzeXN0ZW1zIHRoYXQgc3VwcG9ydCBy
dW5uaW5nIG9uIHpvbmVkDQo+PiBibG9jayBkZXZpY2VzLg0KPj4NCj4+IEl0IGNyZWF0ZXMgYSB6
bG9vcCBkZXZpY2Ugd2l0aCAyIHNlcXVlbnRpYWwgYW5kIDYyIHNlcXVlbnRpYWwgem9uZXMsDQo+
IFRoaXMgc2VlbXMgd3Jvbmc/IERvbid0IHlvdSBtZWFuIDIgY29udmVudGlvbmFsIHpvbmVzPw0K
PiBBbHNvLCB3b24ndCB0aGUgYXJndW1lbnRzIHVzZWQgdG8gY3JlYXRlIHRoZSB6b25lIGRldiBl
bmQgdXAgY3JlYXRpbmcgNjQNCj4gc2VxdWVudGlhbCB6b25lcz8gSSBtaWdodCBiZSB2ZXJ5IHdy
b25nIGhlcmUsIHNvIG15IGFwb2xvZ2llcyBpbiBhZHZhbmNlDQo+IGJ1dCBsb29raW5nIGludG8g
dGhlIHpsb29wIGNvZGUgdGhpcyBzZWVtcyB0aGF0IDI1Nk1pQiB6b25lIHNpemUgd2lsbCBlbmQN
Cj4gdXAgY3JlYXRpbmcgNjQgc2VxdWVudGlhbCB6b25lcyBpbnN0ZWFkIG9mIDYyPw0KDQoyIGNv
bnZlbnRpb25hbCB6b25lcyBhbmQgNjIgc2VxdWVudGlhbCB6b25lcywgbXkgbWlzdGFrZToNCg0K
cm9vdEB2aXJ0bWUtbmc6L21udCMgZWNobyAiJHpsb29wX2FyZ3MiID4gL2Rldi96bG9vcC1jb250
cm9sDQpbwqAgwqA3NS45ODYyMzhdIHpsb29wOiBBZGRlZCBkZXZpY2UgMDogNjQgem9uZXMgb2Yg
MjU2IE1CLCA0MDk2IEIgYmxvY2sgc2l6ZQ0Kcm9vdEB2aXJ0bWUtbmc6L21udCMgbHMgJHpsb29w
ZGlyLzANCmNudi0wMDAwMDDCoCBzZXEtMDAwMDExwqAgc2VxLTAwMDAyMsKgIHNlcS0wMDAwMzPC
oCBzZXEtMDAwMDQ0IHNlcS0wMDAwNTUNCmNudi0wMDAwMDHCoCBzZXEtMDAwMDEywqAgc2VxLTAw
MDAyM8KgIHNlcS0wMDAwMzTCoCBzZXEtMDAwMDQ1IHNlcS0wMDAwNTYNCnNlcS0wMDAwMDLCoCBz
ZXEtMDAwMDEzwqAgc2VxLTAwMDAyNMKgIHNlcS0wMDAwMzXCoCBzZXEtMDAwMDQ2IHNlcS0wMDAw
NTcNCnNlcS0wMDAwMDPCoCBzZXEtMDAwMDE0wqAgc2VxLTAwMDAyNcKgIHNlcS0wMDAwMzbCoCBz
ZXEtMDAwMDQ3IHNlcS0wMDAwNTgNCnNlcS0wMDAwMDTCoCBzZXEtMDAwMDE1wqAgc2VxLTAwMDAy
NsKgIHNlcS0wMDAwMzfCoCBzZXEtMDAwMDQ4IHNlcS0wMDAwNTkNCnNlcS0wMDAwMDXCoCBzZXEt
MDAwMDE2wqAgc2VxLTAwMDAyN8KgIHNlcS0wMDAwMzjCoCBzZXEtMDAwMDQ5IHNlcS0wMDAwNjAN
CnNlcS0wMDAwMDbCoCBzZXEtMDAwMDE3wqAgc2VxLTAwMDAyOMKgIHNlcS0wMDAwMznCoCBzZXEt
MDAwMDUwIHNlcS0wMDAwNjENCnNlcS0wMDAwMDfCoCBzZXEtMDAwMDE4wqAgc2VxLTAwMDAyOcKg
IHNlcS0wMDAwNDDCoCBzZXEtMDAwMDUxIHNlcS0wMDAwNjINCnNlcS0wMDAwMDjCoCBzZXEtMDAw
MDE5wqAgc2VxLTAwMDAzMMKgIHNlcS0wMDAwNDHCoCBzZXEtMDAwMDUyIHNlcS0wMDAwNjMNCnNl
cS0wMDAwMDnCoCBzZXEtMDAwMDIwwqAgc2VxLTAwMDAzMcKgIHNlcS0wMDAwNDLCoCBzZXEtMDAw
MDUzDQpzZXEtMDAwMDEwwqAgc2VxLTAwMDAyMcKgIHNlcS0wMDAwMzLCoCBzZXEtMDAwMDQzwqAg
c2VxLTAwMDA1NA0KDQoNCg==

