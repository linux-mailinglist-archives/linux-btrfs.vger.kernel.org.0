Return-Path: <linux-btrfs+bounces-9530-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D02669C5EBF
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 18:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6084A1F21AAC
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 17:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6252144B5;
	Tue, 12 Nov 2024 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fb45qcAK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="W9xW82VQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5EF20822F
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432036; cv=fail; b=HxkRM0kXcUe5CsMT8npGmJvPIDb5njr3Wjcl/FFdN2fSvvdOPdzT7s+5cexsY9l/Xk4AfqTsJzI5pEaK1e7b4uNiawBFyHMCgBQmSrIGi+HelG+6XmEe9Na3s/TI798qukcNg6xzmzyanA5cL4rqFclI3jH378cJdTgn5mYZms8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432036; c=relaxed/simple;
	bh=doHu+Hx+nGiU15J3DMhy3mv3DLkWLxfcF2UpP9TLZ/s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=USNm7Gs/mrOIMe+LTCxe9cYlc8kU5hmLWfw6n21y8bBqpsCXnXhuSBNVknoyLQBWnDS4zAZOksQr3oXkrXxcS5baJV1ZYCnqxU1sUzdKE+jj0fq9lVMRxbY06Yh70LjuhEDcXY3RKG5ny+XQ43PF52LCHal5mNdnkSrPSQkDz24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fb45qcAK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=W9xW82VQ; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731432034; x=1762968034;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=doHu+Hx+nGiU15J3DMhy3mv3DLkWLxfcF2UpP9TLZ/s=;
  b=fb45qcAKcHwqNLpDYlO7MPAwEzuJQwp4FPx0C89giThI9vz7CIc9e3C8
   vP3t1CnMhofuT8+KI5lO8+pgugU/gLqYXdTuB8QS8+ijWPOKVoieb8Wrn
   fA1gwa7q2F35yY3V21pOJq2pp9lSuVuyD4bc3g5BNpBbHeL1Va0wlrvxq
   FvDcNFUlwPJI7un5BaNtQO8i2sNkuPOjk/QBFcGFpfRbbMTowGpNue4VC
   INteyg+VbsWtpXKuQMj+PAPX6O+y+sol6MeLlc3gjWFiphEl4WoofdadP
   7X762TeeMyUrGdK845n2WNdcnuetP6ZY62hmFnFgxQJY2t6AAUzIiBYe3
   Q==;
X-CSE-ConnectionGUID: igozwJEqRZmf9riwxE2bZA==
X-CSE-MsgGUID: 4slcuBMZQd+yxsuFS0xF7w==
X-IronPort-AV: E=Sophos;i="6.12,148,1728921600"; 
   d="scan'208";a="32373828"
Received: from mail-dm6nam10lp2041.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.41])
  by ob1.hgst.iphmx.com with ESMTP; 13 Nov 2024 01:20:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQkOXs/D3tdqfw/ExA4YwucWgcO2sCVmpYV+nI8Irpgh+JTT60gmYL0vTFhjh9hHmSmu1jmzZqZ+dImwZiXfwjbEmOhc7raJYlkA0fmMgKssruKIqGprba5sBbK1Qem4Pujro+RprWA7/FTSxj5B1sA/nNAznnLtHRjod09Rmx/q2yFwjyn9y4388Ogt2lSsim5zCwp5rNgZWm4lOf6VupeMUDiMhIziZXobtJFaAZiLu37qUlk3OHZ0XtM0TiJrK8nZMQe8/xHaCprlATQUrJ7ki0xQYjQAXGSdlvAt5ODAbiNhG4PgvcnrPoMAhCZ6BnEw6xkKZpm24tFDpSJWKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doHu+Hx+nGiU15J3DMhy3mv3DLkWLxfcF2UpP9TLZ/s=;
 b=IbBfwJHb1ov0lZe3qq8UHw9FpdVJVeGTFU1CfzXKFzpvKy/HyQR2kkPMG4h1Fujq6GFfJFcMiCP6y++RrrGbTsetQzq8P28WfVxrKOX2am1SnXms1rrd5U6OBifD+9Xn9cW8u8rAPiKaPX+kJrGlppIJd5l30Pt0x1yLBbqtiwMY4g9N9hz14fyOLP+LwE6k+NVm4xlZjm+wtpm9SFJ3pA9VkOU0Etim1shZ4PjuQ0XKgNOMvCTLk/XZcv+cFocKigGpqXHDxOY9RzXYF6OFEKKjCfqt+3w93h8iAiWz43Uu5nanzj3wfWaCN1hUH7rua0vT9lXaXbxlszNnZuwDDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doHu+Hx+nGiU15J3DMhy3mv3DLkWLxfcF2UpP9TLZ/s=;
 b=W9xW82VQepv2iQ+HLeOZI4+vXn5fBdcObiOF+SCc+gGkT3nqVM7cc30YoLBKmYIlETics8q14rslc1w21wc/X/uGuUnmpEyrkQut6a5ihBOU37S9gBKE/pSXsFmB7Vk/97WnIeZh5veGFb5dqmvosviXhxmnI8ZxMuZ+3IpMI60=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8034.namprd04.prod.outlook.com (2603:10b6:610:f8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Tue, 12 Nov
 2024 17:20:23 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 17:20:22 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>, Johannes Thumshirn <jth@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Filipe Manana
	<fdmanana@suse.com>, Damien Le Moal <dlemoal@kernel.org>, Mark Harmstone
	<maharmstone@fb.com>, Omar Sandoval <osandov@osandov.com>, Shinichiro
 Kawasaki <shinichiro.kawasaki@wdc.com>, Damien Le Moal
	<Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v2 1/2] btrfs: fix use-after-free in
 btrfs_encoded_read_endio
Thread-Topic: [PATCH v2 1/2] btrfs: fix use-after-free in
 btrfs_encoded_read_endio
Thread-Index: AQHbNQpRAp1W4o1sVk6E4ozx+dAZ6bKzuOkAgAArUQA=
Date: Tue, 12 Nov 2024 17:20:22 +0000
Message-ID: <f2e611a6-fc11-41a0-a643-2bbbe1fd6517@wdc.com>
References: <cover.1731407982.git.jth@kernel.org>
 <7a14a2b897cbeb9a149bed18397ead70ec79345a.1731407982.git.jth@kernel.org>
 <CAL3q7H6qyPn0aeq=LiFpubpvLH6Z7CzZ6649zYPpGFvjuVeCQg@mail.gmail.com>
In-Reply-To:
 <CAL3q7H6qyPn0aeq=LiFpubpvLH6Z7CzZ6649zYPpGFvjuVeCQg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB8034:EE_
x-ms-office365-filtering-correlation-id: 0511f0af-1fec-4647-a6dc-08dd033e4a72
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ekMzOHU0UWM0Y1d4Uy93RE1sOEVaYUVlNEVyTE0wb2U5ZVp1T2lPT0ZiT3U0?=
 =?utf-8?B?ak01bmc5REY5aGFveDZIaDRDNXA5R0hITm1DVE9NVUZKZzFsVTF0SmhlemRC?=
 =?utf-8?B?cUF2alpBRGNNQjBBYjVZbFdjRnc0eWRJbktoRzRkUnVRWDA3WHUxTEhPb05R?=
 =?utf-8?B?TlFZRTRVdWgxVmFOZ045Q3NJRmFjYi8zcXBiQlFZSUYxeWdCWCtTR0pzdlN3?=
 =?utf-8?B?d2lHajU5ZXRlV1c2bVBvekJGb3paSWNES20wVnJtMEVJeUZjNUg5Rm9oZXVF?=
 =?utf-8?B?VUFONGhMOXd0dzRDZVNIM05JYUs4NG9qdHdPQmdiU29TVWlLV1l6bHltS3Rz?=
 =?utf-8?B?c3U3Z25aTkd3V1crNHpCNG8xcWVkSWpjNVBVQ0JmWVdURFNMYnczeG1heUo1?=
 =?utf-8?B?OUZlUWJpUFBYcDV1K2lpME5XaFI3T1UyakZPT2pXSFV2Zk9MRms2NjZZcWpW?=
 =?utf-8?B?T3dsbk9nbnZLY0JDUXRQYzhxUjNEd2pQcHRtNVZTY0xFTGF2RXZ5emNmZnZJ?=
 =?utf-8?B?bHNES3EzVXdicW4zR1A4dTlVWFZwY0gxa1AvRG1GOVpEYWpnTkM0OGtwVnhY?=
 =?utf-8?B?b0l3eGU5bko1Z3RYemlwaW5ZQlRxS1kwQ2loemxGRURqS29LQzF6YldEOGhp?=
 =?utf-8?B?ZGRBcEhqVmIwUXFhN3BEOEhWRmlOaVQ4bktFTnVNbmhQVitLR0xWcXhOR3dv?=
 =?utf-8?B?WTVxb3o2SjZsd3NNNWNQMldJQWZTK2JYUmxoczQ3d3BxTERSY0dFSFJjdGlS?=
 =?utf-8?B?dTFUbmdZZ3EyMzYrb3ZoVlM3c2pNMjE3dEZERU5mZXA5ZW1WRHlpQUhhTDlT?=
 =?utf-8?B?M0pBeTJnU0s2d0IxTG1pWnlXMWQrZVdRTytOSmFqN0tOSmx5djh3c3d4aTZS?=
 =?utf-8?B?aXp4Z3A3QnJnNy81eDdhS1MzdUhFMjlnd200YXlGUy9BMlZoZTkwdTYzSEpJ?=
 =?utf-8?B?SlRxeDRDT0R0bEZnQ0dMZ3NyTXZDTm1oaXZVRW9yNFM5RXNXdCtGc1pqWnpu?=
 =?utf-8?B?bFgyc1ErM3hiQUFSWlN5cnA4K2VvTlNKNHRkczZWTEpLdzJqWSt5R2x3ekR2?=
 =?utf-8?B?YVJ4cTJISmtST3IwK09zdHRIaFR3TzJhMTNRenZvL0IxaVQrSmpUMjRaWjkw?=
 =?utf-8?B?anMwV001Smt0OUFxMjBNaWtyZ1BDb1U5K1d1ajRUZ1ZHeDUxMEc1c1NreHMw?=
 =?utf-8?B?OTF3VXo5YlpoUEVkMWZ2bFM4OFo3c0FrRGhFWENQYkRtL1FXSitTUmtsM0ZR?=
 =?utf-8?B?Ni96Wm5keDJvNno4RjM3Tkt4VjhlZXVMd3A0MXBMUTczbFpzUkc2TGNBNWRM?=
 =?utf-8?B?RVRXNUw2SXI3WDhGUGNTQllRYlFJQm4rNE1DS1VwUGUzeUMxOWY2WHZNbFUw?=
 =?utf-8?B?Qkc0eHptSkxaOWZYNzBTVndoYkxqUytWRXBJRytpOUVWR1NUQUl4NWZiRzIx?=
 =?utf-8?B?NkNUTVIzMlVWcEFwYzlTYUJhNE1yTFMzckRad25TUGd6R0RhL1lXekhkeno2?=
 =?utf-8?B?VW9EOHBZeXNPOVY4cWtHQlhPbHF1UFdsMk1hMWtKYU5WYktvalRLZGp1WUJR?=
 =?utf-8?B?Qm95YU96KzA5YWdqeVl4MEt1aUN3RUhHemlGeEdhNklJMTJxV21vbTZsOG9U?=
 =?utf-8?B?RGVXNnNhdlM0Q1ZOVmFlWFVMZEYxOFFNTnE3RUNvVlVremUzYU1TSEZDZkVh?=
 =?utf-8?B?WkZLUzd1QTBnanV6cHNuaVpJcElmVmVmSzJyRjJwM1VmNTYxbjNoTXp2Ky9l?=
 =?utf-8?B?TXNObU5vNUNSWEcrR0djR3hDQllueHFsWGxhNUIvcTZaSzJvQ2ViTTZDejcz?=
 =?utf-8?Q?jQhT8msA1L8V2FbSCCCoYnJmXjohCjGVsvZcQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WkJ6UTk4TmNWaFRqOER3ek55QS9TclFnUGZtWmdXN2UrRWdxU2U5STJ5RkNt?=
 =?utf-8?B?Y3BGZkppTU9iUFg1eTYwWW9FYnB2RXE2YjN5b21FeDFPWi8vSG1CK1lCTzRH?=
 =?utf-8?B?bDl5RHFiZmFiMU1YNlI1UWRpdGs2K2Rtei9RUVA3Y0tlTG9icmtjU1lkcXBl?=
 =?utf-8?B?a3paL09uZG9PdG5CT0JOTFU4cVdVV1dNZDhVcEpPVlRaRWo4U0JxK2Y5dS9j?=
 =?utf-8?B?OXZDSGVhRU15MTFsVVpCS25UZXd5UGJ3ZEtHSFIrT01MSDFXSW83eVhjUVE4?=
 =?utf-8?B?OXlWb2NuSUFNek1ha3N3VGVLNDIxMGRsRUYrV2NnRFBDU2pKRzlhQlFOb0w5?=
 =?utf-8?B?cFdxMDlZVnYwSlh1aEFjbU9oNGdubkloZG05MTdEN1lHaUZlQTl2ZFNzaWtE?=
 =?utf-8?B?ckx5d0pLelFMZXIyOFdVN2czL1dsYzI3QU42OVM4WkNYdkJBZVNUK2ltVEd4?=
 =?utf-8?B?c0tTS3BzeEtDaGZhWnhrbS9DV3JjclhEYTdCSHJEQk10NVBuU0dGaVdDbnJy?=
 =?utf-8?B?clBJa3A0ZFdIekVxbHFoUFppVUlzQkhWVUlzWkd2WCs1VzUySmVsWG9vSFJE?=
 =?utf-8?B?SWdaV3N0SDBycUh0V1lKRVE3RSsvT3pNQjZGTmM1TG13U1l6dTBPbzN2Uzly?=
 =?utf-8?B?UEpUeTU0b0MxY1Z5S0ZXZjlkZ0ZUcFQ3S2p6alk3NmZIdmRpT0Jja3VUMkt2?=
 =?utf-8?B?VS9zcTlLU2QzWmNMZzhaOWRsWEZKaHBwR0xoVXIwUVBRaWwyWDNQQzFyY2pU?=
 =?utf-8?B?ZEdCRis3a3g4c0FGb1FtTWxQMmxFdjQ1ZWZwVkZuVnNWMHROR3ZzY3cyd2JP?=
 =?utf-8?B?anV6TlRETnYwL0ErRnhPNTZYNTRVSkMyMEppTmZGSmQwUzFvMVhJUHBDOXRP?=
 =?utf-8?B?aTFVRi81TkZRaEt0ejJ5Q3BKMExxOXVnN3Z3V0ZLWFJ1L3RaUTlMSngwSEhn?=
 =?utf-8?B?bG9YNFZTUWN1T0xiaHNsbGxRemZ0bGwrUm14OXBDT1dqM3pxM1dKRXBXRXVa?=
 =?utf-8?B?dEdmU3JUUnljYWVrR1FZQ0RPa2gwaDBRdk9uby93RGhJS2d0Znp4R3kxNVpL?=
 =?utf-8?B?ZEp5M2h3SG5XVTRIY2pUUDk2Qjd0elZBclJhWlJCSnYyYUN4UGg5RU5LWGxC?=
 =?utf-8?B?NUU3RE56eStVVUl1QkxveXRQakZhN0lNcVFlRGhwM3kvcVlCUlBzV242L1Mx?=
 =?utf-8?B?b3RCUVM5MTN2c3NBV2tJUEU0ZzRUZmtTZmtleU9CUjZmSXBiM0tuL3BSR1Nv?=
 =?utf-8?B?aTJpTEJvN01JVXJvQXY5cHE1eno4bWUwUUJGR2VFNjBmY2cxT1lZaGZnZDZp?=
 =?utf-8?B?RTJiZDA5d1FHcmtJdzI0b1F4aGlaLzFRY3FzcjZmQWJ6TzlYODhHUVp0UTFw?=
 =?utf-8?B?TUNJRjNRNmZ2SUVhYXdlZk0wWW1Ddmk5SGdEeWF1YTNvZkFDTk9VUjBIajBr?=
 =?utf-8?B?SzIza1NXR1AxVS9maXZXRFFzTEZmRGtIUldtU05NeXlubTNvZGNyYUVVenlT?=
 =?utf-8?B?USs1WFRIYmJlK2pUV1FGSk5yOEJTUy9aVUo2Ri9tUitMT3NCSUJZbHFlQlhU?=
 =?utf-8?B?cHZSS0tnVndRZG9ublZaZ1l2MU0yNk1DOVpkdFEwS2VLYmhPdHVhTmpLTFBo?=
 =?utf-8?B?UHZvUGoxSDdPRnlaTE5yS3pWVi8xVHkwZWZRQnJJM2dQejVqRVUzUGY4aHY2?=
 =?utf-8?B?dVJmYW9NYWJYOXZaMGhGdVBNdDl5ZDNtUTMxWlBNS3B2V2k3SEVXdm5GY0Nm?=
 =?utf-8?B?QVZLVTFOYTM3M1cyMGRJK2FVYXFjY2syTG4vU1ZLZ09qeWIyN3ZUOHFmaytN?=
 =?utf-8?B?ZUdVeS9LUCtyY3BvWlBlbkRPT3hhdkhjL3ozeWo3Y3ViK01GaHUrd1Zsa1dF?=
 =?utf-8?B?VThwbmc0cUZHUEVIQnRhUW1qMXpGR2JtN2g3U2xVcHBZOHVOdGhmejZnMm9a?=
 =?utf-8?B?MklBZXlFNVZpNEtVdkQyczUyMHU2dlhhdVhRS3RNdHZweUlmWnhxZGlVbmt3?=
 =?utf-8?B?VjlHd28xQVdTRWNoRDVPd1I4UVI1akxOdmp4K0FTOVZ4OERqaC9UOFVlTWVV?=
 =?utf-8?B?cWw0Z3hKTEl4c1V6VWw1b2g0NTQzdlRhNFQ1Q21xNTJxUEFHTHp5VzhxWTBj?=
 =?utf-8?B?bHdTQkgwKzBEMDhGS3hCTzdwR2ZpNnhpOEtBQ1R2SEU2dmU1bnd3QUVpSngv?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EE49718F5E33B4898C5BBBDA0CA18D3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9bTlSB7fDqKQAqNoyq81me42jxW6KYE6qDbOj0NqWxrM01Ow84269lpCwOXfap+gQgOASl0+BLX70Ef0w2WKTdfQb5ujnl7hqdqGs5JjhMM/opMMb0nKQUaZV2bwyv6NmmtTV2KJEozUeiYfTw2MFvOifX4cRQmR7oVxJEGLM3219uywzEnfxGAPGADIBiTPEyP6CRS4f3xMl8EhRw0WwsofJcdE9tCsPypHhrzyMcsqtdXYMJ0GVYjkbbUeXefAOEA+W/PHVuHId9auT979UpMnK7y25GdEGmaCNac9lgjOTm/eizMz9+kUpaBaglL8S5uKhmpKWi7VVFbbgwikuhwVMnki1d1raC7FbGmYlXHpov7vfA45wEtWqes8YazGHMmwJ1ZtZT187bhOxdNoh2pXE5YajBEY1duxV8Cbwyj/3eNNNGryL2+e57p6xsTTK1a9nuJbP7+Ci3Q/zHbBmOeNv0kq66GytcCWmr+LdOSuxkwbnJYatNIibVHyfltpjgA0KRQpdN3aOnC+rE0p+HJWXgPyAFNHUOoK8sd+58U+1REjcvK2Wg8OnE/2UDzqb3q6b9ZaOl9tQ4i+TRtLxHZBDx1wIGDimTTpjUsTl6Hfgg8ShB/hpM1hLiU/tg+a
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0511f0af-1fec-4647-a6dc-08dd033e4a72
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 17:20:22.7996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LxCHIioqH+fn2+JCw7AWJzokOZTlUb6DGY1tf7gsAJYRL9KjE4b0/VUU/onunFQagzDyHjv82XxIXzVL3ydZD21GD5ZFjNUo02uda62pSHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8034

T24gMTIuMTEuMjQgMTU6NDYsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+IFRoaXMgaXMgdGhlIHBh
cnQgSSBkb24ndCBzZWUgd2hhdCdzIHRoZSByZWxhdGlvbiB0byB0aGUgdXNlLWFmdGVyLWZyZWUN
Cj4gcHJvYmxlbSBvbiB0aGUgcHJpdmF0ZSBzdHJ1Y3R1cmUuDQo+IFRoaXMgc2VlbXMgbGlrZSBh
IGNsZWFudXAgdGhhdCBzaG91bGQgYmUgYSBzZXBhcmF0ZSBwYXRjaCB3aXRoIGl0cyBvd24NCj4g
Y2hhbmdlbG9nLg0KDQpJIG5lZWQgdG8gcmUtdGVzdCBmaXJzdCwgYmVjYXVzZSBBRkFJUiBib3Ro
IHRoZSBiaW9fcHV0KCkgYW5kIHRoZSANCmF0b21pY19kZWNfYW5kX3Rlc3QoKSB3aGVyZSBuZWVk
ZWQgdG8gZml4IHRoZSBidWcgb24gdGhlIHRlc3Qgc3lzdGVtLg0K

