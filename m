Return-Path: <linux-btrfs+bounces-20608-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB26D2CDCD
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 08:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89615300FBF0
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 07:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6A42DCC1F;
	Fri, 16 Jan 2026 07:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iBwnmQph";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="T5t9z4uO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E656AE555
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 07:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768546960; cv=fail; b=lwX0zAWHMM7J0XjiXy0oP2nwbgPFGuJ1jnz3lbUO2ptqAt9XgyFiNMSCTfh93J6OOImJywZ9edxvNMLeTfoxJv78IPyCaPfkiUVPwiKsguNGEn4BUaxs3bCic1BaFytEOiELYEnjBsjQVqj6zRaX0f5kia0TcPE0jd/bWOOSJQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768546960; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZUm8CO5r1qVt32dg3yz7XF9WdtV8aIFcsc/SeeWirpuW8uKC0hkzO6/PyTMS+q+91xKUjhv2yHCGj9hMuDL1GrBmEtkIyxJIKS+OhGzLWTbGPYFB78hA+3B5WmJ5QRSqATUqQlqU1gwL1KWBSdc0d+9vEUQcy0kKsFdlult7Kz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iBwnmQph; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=T5t9z4uO; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768546958; x=1800082958;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=iBwnmQphMx8VcLsuvad+l58C8JE6FqnwwaaredWWBp/Hl1chbmBMiS7v
   laIzAaTwzUSbww5swWt20QaQ5FCPwJ/5h7pVgJEAayRKN2lsCsItx3n/u
   6n2rH0S/B2I6ciWc96FwiQ3lwtG07RkXZ8kn9h6iJ7s32Yvc9RPjEQhGo
   q0tKSCckaRLi5DBPDfzzpfCcyadru/KBOBBkRLPnLTEM6p5jFgtE0aBCy
   U7w0gWsCk85QLNppHhLWkSfv+lBQFtkLmC/u/ZFWQaDLSgyh3oUHYWVP4
   HjecICm1qzRVR3nFvpkZrmY7heuBIWdtoqm7B33lyYAQgJYRcpwGrAz7F
   w==;
X-CSE-ConnectionGUID: aDF+iDppQgCU1iA2IclIeA==
X-CSE-MsgGUID: OMqhO+LAQzyHhwsZcHZQLA==
X-IronPort-AV: E=Sophos;i="6.21,230,1763395200"; 
   d="scan'208";a="139603076"
Received: from mail-westus3azon11010046.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.46])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2026 15:02:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tclV8s/+vEFOmPLCKDv0f+xSD9dI/h8YsILmb4EuYXq8sv6wWQW3mTZi35RfoNRMwz4sA7Uw27eKDZEduv3tY6YIz4+L/lINcvB+Im5C+3N8w1QOa3E7aEA5OC76eOTe3z3T0BJTsN/CDIn8WLf6xeuVn996uIWDfuQa+bnJiwwtEYpuK9KPP/7LwCKHUy1q9fG6oqAqoCUcctCsZtVklqz7MKwNQ3sC2bsIQK/lubPsWKjcHPaY+0gW4VH2bj8SPubjmc0ZmSxVthRZQ19o5lYX+dTGltBnpsAjw0v0p0PZUpLHjKXIDjZPd8Y+KQd7IFwVAe13nt3UDgaJo0RgJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=uoWpC1YjD/qGQUsE6r9ZhizP8TNKJSdrldDGJSdEDmm2niKTEJ1BDSQgufxpRJOyitgCLTc4b9Q6sNn1PwR0IneZH8VQKuTN0Vv3zuvLIL8n1di7/jUGyAXBAM6gdXltXy6GCVCbL8YFoTGb3RILEF6nyU1/mMTW+D09TFrpmw4EH5+PCtj2NzR8CPrJye8csSaeuDUX+dDtRSo67MqXyfx3sB52zUFqmfLYE0p64HZEh1v1cD1XUpyY2HK0Q386FXBcXnIDhQSaPtkOVwIOmIklfQ47DgF8Z3tAdmKjEkNHzpPB+WY2u7c3qHcCP/M7Y+3D/w/Fap9YozMSOscBeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=T5t9z4uOehHDYTKed0/elLdldgJJd9/ZRqx7DHionmego/fPx2pzKD5/vCJ4DbqazOJo7R0cfiEnr2Q0eJm8QC7poXBi4tXFmMZah1N8PE27Svgu8l21esiAArTJtEsajcNx7hszpFwcclX4qtZTf7/3uB2Tsfwc+uArcgNdZIA=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by MN2PR04MB7086.namprd04.prod.outlook.com (2603:10b6:208:1eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.2; Fri, 16 Jan
 2026 07:02:30 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9499.004; Fri, 16 Jan 2026
 07:02:30 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: add and use helper to compute the free space
 for a block group
Thread-Topic: [PATCH v2] btrfs: add and use helper to compute the free space
 for a block group
Thread-Index: AQHchmlIPLDBGXEe4E6RvQEY0dRWdbVUX1WA
Date: Fri, 16 Jan 2026 07:02:30 +0000
Message-ID: <9dfef030-c5a0-4fe7-a014-9ffd82552744@wdc.com>
References:
 <2ba3b023e186d4eec78b8515bb375f310b4b2390.1768512027.git.fdmanana@suse.com>
 <9f70166505b58147e580c51d0ea498b0e9f30ea2.1768513901.git.fdmanana@suse.com>
In-Reply-To:
 <9f70166505b58147e580c51d0ea498b0e9f30ea2.1768513901.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|MN2PR04MB7086:EE_
x-ms-office365-filtering-correlation-id: ed114505-293d-4219-333a-08de54cd370e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MWdYdk54K0VKQVBUWS91YmRLcnFPZEpOS3g5bThIS2RWdDZIZVpGNEl0R245?=
 =?utf-8?B?MTVSVnczdndvbkNzbW50V1IxWngvVnlIR1MyUFQwMWVCK0J3MVlSc0hxWU1K?=
 =?utf-8?B?K2MxZVhlbUVjT0NJRGdEUnk5WTRGQ2EwSmdSclhHVENhZHpEOG5CT3B1VGwy?=
 =?utf-8?B?REsrWVNUcE9VUEFucEFsNTdwTlhHbmJxckpTc2h6T3hmWnhLUVZxQys0Qllt?=
 =?utf-8?B?TURwbU9pZFNBOS92dktrOWRoTjVzeklPVkkxTlhqbDFtOGJyRVIrRzg4ZVdX?=
 =?utf-8?B?d0lYR3o1YkRVWklORXpHdWozVzVRZ0Zjby9MU1BWWi9TRHR5bDZCZ0pKQVRa?=
 =?utf-8?B?RVVWc0VlZHdscWhLc05jZjRuOTBUUWQwVjlSZmROdmI4a2lWOEdKL0xFT05w?=
 =?utf-8?B?cHgzeUliVzI1UG91SU1GcTJNWHQzS0JaekJFeTdYbXgvZzIzUnFuOU9jNTlT?=
 =?utf-8?B?dmluK2o1amx2djIvRlVLazE2TjRxRzlJYlJmV0xBdkpxaUswNmZzcHYzbEpU?=
 =?utf-8?B?T2JnV0hWc3kzZDFXWVBocU41d01nL2ZPc2FEbFlsa3YwemZyeFQ5RlpiMVRE?=
 =?utf-8?B?M1lBaFFhNVM3NnF3cTNQL01sRGkrN1FkWWpIdk91ZVVHTFVDc2JGM1J5ZTNZ?=
 =?utf-8?B?VDJhQkFoNjhCVVIvT21VSTNkWWN6c1hXTFByT0VrUTVBaXpBdVVreXV6Z1Jp?=
 =?utf-8?B?OUpHRUhTMXMvWHd5V0J4VkpMeVVQZCtTeUFtdUVvQ2ZiSGpZdkdIY1JnaTdR?=
 =?utf-8?B?eVRrWnRnWmRmZklrMG15c25yQi9Wd3RmeVp2MHVZNG0rZnlMQUNlT3ZaNjZW?=
 =?utf-8?B?eDMyM3NFZmxXL0pWd3BNeCtwOXBqVy9sUEY3TXRQZ1RoeEFYZURQUFVuSnk2?=
 =?utf-8?B?bm8vOEpzZklKa1ZMV2lDMG1pTVdmMTkxM3FkNlprMDM4YkFCd3dTLzUzeHVK?=
 =?utf-8?B?TXZWUUpuMzV6VHRwaEpjckNvQ0kyYlRoL0JpOGFOOGxIazRpVHdyRWd6U0hF?=
 =?utf-8?B?WC9DQ1NXR1BRK1dTQWpGdXN4T2tMZ0F5bFd6RkgzTE1iYmpXOTJKaU5WalhW?=
 =?utf-8?B?bStvelNVUmh1cmxpQ2RIdzlldllnTDl1VUNkcVhWTE8xWnRwZk1CZTdlM2Jk?=
 =?utf-8?B?THJ0d2QvdUw2ME1hOExJdWZXenNEYVVHS1Vnejd0WEhaZ2JCbkR0dzRXZ1hs?=
 =?utf-8?B?OUs4TngyK29VK3F0MFp6YTlkbUFlTGpRY0RZa3plMSt6d2hFTFNQSTZlWVNl?=
 =?utf-8?B?UEFjWjBsZ1RTVDdST2Y0L0pTWlJnS2JtaWpFaVJlWjJDZlR6d2RsSWY5MllB?=
 =?utf-8?B?ZGJMVUhGZlhUdzU0YXRiZy9PbEE4M0Fvd1EwYjlQWTJMZzMyTThsMHJUaW5h?=
 =?utf-8?B?Y2xFQVZZTzJqOTZVWjJxMWJ1WnRQUUp2YzlEUnp6bUd2eTIvUnc2Y3NLZ0lm?=
 =?utf-8?B?ZHlMbkp3QVhXYTlZeitCaG1NTk9PVnpBOGo4bkJJZXVHRm9WS1hncFdkU2w1?=
 =?utf-8?B?VTlLdW4wSmhHbDNnekRzUUpTWHZnL2FtOVZwOS83cWFJZGVKeUtIUW1keWZZ?=
 =?utf-8?B?a21zWnRwN3FYQmV0UXlYZ0RDZkp1ZHB4T20xd3ZSeUI5OG5iRUVWdjlFZk9i?=
 =?utf-8?B?aVo4djJnSFJkd0dudWZlc3hKSGM4QVprSk9Jamh2Z1pmZFRoNnZHdzF1cGxm?=
 =?utf-8?B?SG5QZHFHb1pRV1JjUjdIaENOaFJ6OTAxczBKNFM5eXNtUEZMVld4eURFYkhr?=
 =?utf-8?B?dkg3ZVpqYVJpV0U0SGkxSy9CSlRpNnl2VmtIUFkxaHd4cXc4VWcvTk83OWM0?=
 =?utf-8?B?ZWEyTnA3V0h3RzA3SWhLUDhLcWxzRkl2VXZVSFVFemY3bjZjTWNJZlpPTXlz?=
 =?utf-8?B?M2Fyc3IwcFJTY0loUW1hK200VlJXSHZCeUoyZy96bjNHdUVGV1ZtLzVUYXYy?=
 =?utf-8?B?LzZOaWJpZEJHVkNCaU9FbVJzd1EwcXRxR1VqVFlkNzB3RFVtaU5lYUdWUGE4?=
 =?utf-8?B?Sm9SRXh0V21qRkl5eDhmUGVNTWo5WmRkQmZvdTFuMVQ3b3BySitsS1JpekhW?=
 =?utf-8?B?cVB2MTZXYzJNVWUwZ0kyelZwS1k0LytkdjVreVh0amhZYkpDeUYzdG5jS2d1?=
 =?utf-8?B?ZjVKMXk5UUhxdk9sSDVVaTEzREFJSTBKbnJOMWE0MklhK0JEa1oyUFpSQWNk?=
 =?utf-8?Q?vTeAd2s1U9DiSVbwwK8FQlY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QS8wL05OMGdFcVJGYnI0Q3dzaWs3eWxzTW16RU5ibnhzb2lOQk05dUdqa3N2?=
 =?utf-8?B?YTVSdUc2d1RNczVVQmU1aTNLWm05Z20zOCswWmN4MmlqeWxsajRacDcyMDBn?=
 =?utf-8?B?Q1lLZjNtNWdDODZxK2wvL3k2Z3RoZjZWSkc1cVA1NGJiTnVKODNMSXM0aHE4?=
 =?utf-8?B?NmdmVGgxWHlnK1Y2d3NsTkRrQnZzQUM1ZnBVYmQ2ZlovYlN0YVI5MEhBb0RL?=
 =?utf-8?B?WXBkMk1sd3FXUkFHNGRUSkpzWWpmNmRJbGdxR3BRMUNKUm5EVFliR3NDN2Ey?=
 =?utf-8?B?cFVTcGU2NjdKM3I3dHl0ejMwbDlGbnZkS0VDRFk0TldNM1IxTTZrODJpdVlo?=
 =?utf-8?B?N2xWNHlRVm40QStrVCtVbzVqcjFhSkh5SFNtU1hEL3A0dFdKWGdnMHJNd0xQ?=
 =?utf-8?B?K1lZS0x0a2RYc1h5ZlVhMTZpTmo1WFg0MnN0aERldjJDTXFFN25OUlVlQkFD?=
 =?utf-8?B?Qjd0RFgvUlV1S3JhSlkyZEJLNzhsU3F1WEd6dHljaUVlR1Vnd2xyVkY0dm9O?=
 =?utf-8?B?TnRHVHR1Z2RUT0hBMnFHWmRkdmFoMmloNXJURjlsMlhtRmI4T1F0SnU5VUZs?=
 =?utf-8?B?ZWtnMDEvMUx2UmJOaFBDV2dQa1UvUmk4ZDBHc242aUZna2RFMjN5VllUeFFU?=
 =?utf-8?B?REVYaGZ0RVU0cWZTYU1aY0FkMFZKT3V0TmxnNWx4TjljTk1OZWtieXZpdlZk?=
 =?utf-8?B?Qkdlbk5pWXI5M0E0UGdrWUdVYTVlTnBQd0NjMjQ0R0xXWVVtQmpXRzZMVGVk?=
 =?utf-8?B?Z3pSOTFTaDR1eXpzOXJyYUVxcTBpOWhuZTFFNWR1NTFkRkNndHdXWW1zeHUz?=
 =?utf-8?B?Mk8zZTdBK0g3L1lHMXl5eDRzR09Yd3NrQnNkeXd1SlBnNHl6TU1reW96aU1j?=
 =?utf-8?B?d2ticWhZQVVYeis0OUJmbEhZVmVGR3JDS3FiblZhWldhSDlxNlYraEZOWHhC?=
 =?utf-8?B?RWMwRk5EUFVOVElQL21QZDBTRFhjdDhjTGZES3dPNVZISzFmSTJaeFRCV0ww?=
 =?utf-8?B?SGFVMFZOdmFWY2F1TytLR01VdytaaTFFS0FXYVVlZXpVVmpBSStPN2JMZXNn?=
 =?utf-8?B?K2RsY1dCdCtwVGZOMWVRQWVZQi9pQndaQkhmZktpNVNxTDF0UGloM3UvdzFX?=
 =?utf-8?B?THBWSC8wcVFtK00rUmkwdENMeHNmWTB3Smh0Z2VCekFxNFRIV0xEUjNGQlc5?=
 =?utf-8?B?eWJ4b29Rd1BjVTZXQXhOclNpTkFxWGlvazBUVWlrbzZ0OGJPaXAxUTNFM3RX?=
 =?utf-8?B?TWJVaDFBUmE1cFpWMlJxRWlqa29KSzhORDhPT1QzWUR0blEwNGc4bkZDVUlw?=
 =?utf-8?B?OGRnUWJsWWN6VnBuNzV1SFQ0VFFsNkI3ZnVhdEc4OTAxZTN4NHRxdmdVWEpU?=
 =?utf-8?B?U0oxMzRGVC9oTXB5V2h6N3h1VzZQNE52MW5ld3JHYkttTGd1cWFwQWd1Mi92?=
 =?utf-8?B?WDZXSmx1d3RnZ3RIOFZ1QUZvWDBrZ1dQbjV1Sm1tODlaNFAxTjUvQjZ0NjNT?=
 =?utf-8?B?MXE4SGhSNGNLRXpzVHNCNGh4eDgva29YZk9nM09aUHcyRjFPRzZuTmVydUdO?=
 =?utf-8?B?Q3J5Z0JOUnpMQVZ5djhKZW1pNU9NWmEwejM2VzVDS00waTBzMTdwK0hsakRI?=
 =?utf-8?B?VnpldTN1ZGwxV1R4NVJNUU51aXk0RU5kTGdSazhHMTJadlZzcmUxY3M0b0lU?=
 =?utf-8?B?MkJ1TCtCK1NJcjlHZGZGR01kMnJpK2hsZDhPVXQ3blF1NjZYT21VSlFPcGRn?=
 =?utf-8?B?aktoU0gzcTNwRnpFSHpOUTV3QWdrUnkxTEt0aHZaeFN4Q1NyZnBHQ0tBSGJG?=
 =?utf-8?B?ZVJ4cG1vNDljaTRBUlZ0cW04T284ZzFHOERDcVhYTG5iVWEvT0hUYmo5eUg2?=
 =?utf-8?B?eU5ONEhUQ3d3Q0FVMkF6UGF0TjJ2YVB1MVZtTFJCVmJXTyt0ZjFDa2VQMGZT?=
 =?utf-8?B?emIyUVdyaVhmcHpIRnVoRkFlWThzbCtJM0hQL1JzdlJCd05LMEYwak81U2lu?=
 =?utf-8?B?WENacWpYdzdZNTVyVlF4bWhLZm9LOWlRK1R0U0ZUS3Q0MGpPa2JlV21vYlIx?=
 =?utf-8?B?TG1HOXJYVlg4bC9hVitONUlkeThzeU5LSXR5endManZ2dm5GQlVXZTRGVWwx?=
 =?utf-8?B?OVUySWZOY00rNDhOdUk0WnFmOVBUV0N5VVZmSUN1TENPS3VMUlVEMW9SYysw?=
 =?utf-8?B?YlJCYlJhMjRPYi82QWxsT1BhVWFiSTV6L3VJSWFRQ01WU0d5U3lRdXNQaWtu?=
 =?utf-8?B?ZmEwVU1sM05ramN6dUFlK1FsMngzVjJ2VkNzRTVQV1BlMnorTHNQdXZ4ZElW?=
 =?utf-8?B?d3pQSS83eWlQUHJ5NXlXMUNBNVJGaUxiUHQxQlBZWmN4aWhlSnpURlQ4NUtR?=
 =?utf-8?Q?5uzBgTojdtyZiqgXizSb7cnxxfSjEe2t6OHYONPDEB8//?=
x-ms-exchange-antispam-messagedata-1: LzZZI2J3GrWramkbqE9lxiwRHOtJO2QnHIA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6092EE3AFDF2264A8F64125D29E32C1A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6nDd2A6UMqw36aNIT0RkDgpZ9eArgkqBiuyNffMwfrc6pr7QpvnNMd/YHd8u8NgEiQWu39kLGVm/J4EfkZR32lRQFj/IJ719lc7KllczP25EoMeq7SleW3OIl/r1xsxlLDyZ+NRUFggAVO8EVcL4kP448LXRM9fx+JHIBcAbalQfm0mCDPvt0TO/MuCyI2X5JskyKiniuWakogXKXE2uArqCO1prgJ8mpnHNHp+miCFuKD975QQsG0x3d8rxKBLduK/g8Zq+Kg9UjKDKcAfwmL5ZNi8e3ll6eIyGM92qw3cnDo6BPwkr90VhBqspXUd/o1FU8DM7FoUGgFn++aqfF80WnV1Sq8o9NfEc9hTmTwhr1oQsfPWjlGW9RgKIBEyGRJCLKIR4k2TaothtAR1kM86VEXzqiGfggGvzmaOMdtEYrEAkkj1ZqzwKem/2bTkoFDh80+BWmwyEErCyZq00NbAADUjMNFEWk6VrzicN9oUvYiTvauOk8Wgxl9k6zWSl05kQbTDfGctTX0rVsrlKbYm4Hsgw28fhTaMrtAhQl017Tg3YOiaIkIWlZYK65lMBeGkDKz7JG/tFes3rTUIcsoHufjCmadvaM5JauXlYH08w8Qf12eGhEc1cPEubCjpZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed114505-293d-4219-333a-08de54cd370e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 07:02:30.1292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ga5fp44EOog7T+IF5vz17Uzw53dDdrH/GsB/dv7Re6Uj66Gw+ufTqnVvCy0tftqJc3+actQ43CShS116WAf8zBbd+AGKEFghCUYumYWBT0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7086

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

