Return-Path: <linux-btrfs+bounces-20680-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E83D39EFC
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 07:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C920E300BBCA
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 06:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEF0289367;
	Mon, 19 Jan 2026 06:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TjJBEh+a";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ukNS842L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBAC286416
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Jan 2026 06:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768805385; cv=fail; b=vC3RWMcNv/nJr22Iyv26pMF7OK0wVZEAgwDUwHwWMm+J+oaCy3ARsgsD0b3FpAXOrLh1j5IUJSNun4mS2EPUTCfYVPhbq7ndZR+jfvvWrnU7AwpA3uwDqwHu9UHOKwBfeK4JW5UJ/A9shnXp6MWwO3RDPBU0sKzaEyrWkZv9uYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768805385; c=relaxed/simple;
	bh=vF6XLHTXcHPWQLy7eLSNvbsFzMXlc4Fxdbd9UGMAzRA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fVzSjI0GGzDJDZReP0vjL7YYKAL99OVA0ouMHD9wBh7zfN0K5HAvDqaAd+ICmDQ/V16tu/ORfYW0kFGOdgHl6QHjttE82ZUv2Oh1eIcc7pcPBHSZANrPWIzMqD7Q5yasvWgUgT63OAEJWAwM4/VUXN/kuivm12tHH51/G7tjv7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TjJBEh+a; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ukNS842L; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768805383; x=1800341383;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vF6XLHTXcHPWQLy7eLSNvbsFzMXlc4Fxdbd9UGMAzRA=;
  b=TjJBEh+ahtNha9SsjPHXlG0aQx+0mQvk+PF8FK07TXhMA/YH0hn4UYis
   h0WBUn/M0FCj5FiIaS4Es4bjQgtVAHAfQ3G3XTqUfBv1TUL2pCzP3ZIEq
   SIqtJ9nEkKbEcCKQThAeox0cChD9n/yNqpxLnavaZrI25tIslNEXtuWW2
   x8FdB7YuLGb2q+/XWdBW/S8fFvNQ+ASTLjOvudxMOWJ5QBeYPTTAXa35K
   WxJmHl1+4rpr8/Y9OkmFSZkWKWOmiF5yo7ESS+wgsYdWgfndXSZPNiy+Z
   zzQ3aCmMX9mmsnsGcs1AEotx6oWb6BpCqufcmR2Ijrtf5LktgDS2i0vk2
   w==;
X-CSE-ConnectionGUID: GAIUApdkTYKON2V1DO4oSg==
X-CSE-MsgGUID: Qq4xVzOgTNuTLYxuWMFpMQ==
X-IronPort-AV: E=Sophos;i="6.21,237,1763395200"; 
   d="scan'208";a="139044438"
Received: from mail-westcentralusazon11013005.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.5])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jan 2026 14:49:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGla1jWMKc6kDHgO7pYdS36FI9zv4dzXKdgf0hfGkRz9DL0MENAyjJQeAiA6sYnLaJ19fl1LLv58fboQ/HIb1iq7zN852OHDPF6HKWnD2TvScOjlIH+JS7qV4MzzvecdbSkfOlNIVOLD/6eYYKImX0dCdrNS7Lcxp6PdRDZXah2UFVoqkpzRVTz8R7BCzDwDaS7WTU2h00kDA9o7Euqz7yZAW8Rbly6QG73cFqhg3ffZNHnm5B8oDwCtYybxAQRmckAOHSpUa7EP3H6wN+4GE3Cl+mAlnZ3WbKH16QxCRRmzRKj2Utts7pTxakMXU12qr2Pycza4Rp3p96F4HCOoRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vF6XLHTXcHPWQLy7eLSNvbsFzMXlc4Fxdbd9UGMAzRA=;
 b=P+jHKRp9M2WGCvfYGEgP8EnEv6wqZQzXk79zvCHYOQfPPLgZlwNpqR9uQvFTuKnOQ1BT4jfzm6qLZZXpK7Cl8bfWOQ/ceEhTarNG4jTb8vdOdLxlqrLtilxA1ZUkvcnd2Alaak3F0SLZf7U7W0mhMUaMNEWXtJCNmdL1vvoxvmxZtpnA+SMUFcG4FTg7nu3JDN813YxMDZjahAhq0OpqGZIQdCypCT034qcUhHMJU/1dPvxS4cJt3EOf9QGqnOg7qkx+24YI/DnSMz97Yd1Trm03gTJV0FdqPpUUgB11PWEBLsXoi5e7p48MLWE76FD8TgHVQuf/R6wqeO8ui1RXrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vF6XLHTXcHPWQLy7eLSNvbsFzMXlc4Fxdbd9UGMAzRA=;
 b=ukNS842LaZ0R+l1AzIwwu6Rqa0IsaNPCOxd9K8oS8Sv1WAddyce11Cuoh4DLLu5YVGDGIbGTmi+A3qbqVupID1iY4UBFPt82ng0oLONF1R5QosGcghyCns6U/S/V6hLhAgpNzli1/wipWDNhmm6KORRREw+ihZfqDYrdqhiWAzI=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by LV3PR04MB8941.namprd04.prod.outlook.com (2603:10b6:408:195::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.8; Mon, 19 Jan
 2026 06:49:35 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9542.007; Mon, 19 Jan 2026
 06:49:34 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, "oe-kbuild@lists.linux.dev"
	<oe-kbuild@lists.linux.dev>, "fdmanana@kernel.org" <fdmanana@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC: "lkp@intel.com" <lkp@intel.com>, "oe-kbuild-all@lists.linux.dev"
	<oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH] btrfs: use the btrfs_block_group_end() helper everywhere
Thread-Topic: [PATCH] btrfs: use the btrfs_block_group_end() helper everywhere
Thread-Index: AQHchtOhINvO9S28dUGMw5M5g4U43LVZDy8AgAACsoA=
Date: Mon, 19 Jan 2026 06:49:34 +0000
Message-ID: <9398ca7c-f114-47f9-ac22-8fd8f67214a7@wdc.com>
References: <202601170636.WsePMV5H-lkp@intel.com>
In-Reply-To: <202601170636.WsePMV5H-lkp@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|LV3PR04MB8941:EE_
x-ms-office365-filtering-correlation-id: f483ebd2-a250-4520-0561-08de5726e836
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QTQvQzhTY0FlUU5ITVJIMGxaV1dBMUN5R0t6cHNHTk5ONWtLMHpGY2k3Ry9L?=
 =?utf-8?B?dThVVmtsLzhmYUFIQ3ZRbEM2RzI5VWlRNm9UakpLdHRjTmVIWG9oZkR3V0VD?=
 =?utf-8?B?aUoyeFNBdi9kVVlQSXVsVE5wS1NCZElaclJ0Vy82TXgwaGtzUjR6TjlsaUV1?=
 =?utf-8?B?c1p6Tnc1ZlpWTWlvZDh4ck1QK3lHR00yNjIzdzVLLzA0S3Nzcy9iUS9xYkt6?=
 =?utf-8?B?cXVObE0zT1ZjTUdqdTNKYk5SRXBFV3l1YTFxMytGdFl2QzNsOWk2WkZQUkg3?=
 =?utf-8?B?aUpocFhRMVo5YUFReWYxMGk0UG91dXBXNUNwQjJxc0g0TWlITDFyanNBYm5S?=
 =?utf-8?B?MWZRbDNmWUhOdENVeG5BeDhPUjFPYVZCWkNmUXJPcTg3L29pSnhNekhnM0RM?=
 =?utf-8?B?aHdxUzZTMHhMQzBiUmNrcm90RUJpeEorOXNHZCszeDhPenZqNjhBODVtOGJ4?=
 =?utf-8?B?eTFpVlU0VkRuVWpIeTRBWXNqNG4wYW1YRDBSNGNqQWlyMmZweWVmbndULytj?=
 =?utf-8?B?K1RweUNCRXJmYXFUME0waWJzWFNZQTBrbExiSDFRSnROL0hGRzNVaEw5VkhW?=
 =?utf-8?B?UDJSN05oNk1TZjFtcmpIV2hLdzhrc01JU1UxaHgzc3FEMlVTOFF6WGJVS2tY?=
 =?utf-8?B?VTB2M09mOWZUMXJEU2plTURDVW5HaUhTUEFSWnh6dG9HV0pxWFp2UHFESmt3?=
 =?utf-8?B?VjVJWjR6MDdVNGVMeHhZbXFZUEZoNmFXMFMzUmNZOUgyUVFZdXl3QS9vdUcy?=
 =?utf-8?B?UW90cXlpZjE3RkRJL1hkNWY0eVFRTUdvUnowRnlHVTVxd1JZZm9Jd3VPMmdG?=
 =?utf-8?B?VGx5c2JqYjRyZ1hkbE9udzJadi9KbnB5c29DQTZrK2hmdjc2bGlEOWhZVGIz?=
 =?utf-8?B?OHNHUEIySFBNMU9HWS9pUFNPWlZuTWIrRVNnZUgyQjBNcmg5UFJsejBTNEpD?=
 =?utf-8?B?bEpiMG14UlIxWlJEMmxLdkJsWElhYTYvWHBQSTZ4L0F6ZkxwSDM4QUhVVzY1?=
 =?utf-8?B?azI2L3dYTW9iQWRUd2xqemF1bkhOUVQ3UTk5S3VSL21VdHk4V2IvbXZwQkdZ?=
 =?utf-8?B?ZkNTdUpjTUJEOTlxUmQvNFpNTEZuTWNtMDZGcVVxZUFZOWhyMXdCWWpkSDc5?=
 =?utf-8?B?bVVtWW9QVldScjJyZFZHRW80TnRUZU5VVWgxZWNaRWFnV2NnOXhHVDAyWTBR?=
 =?utf-8?B?YXB5K1h2K3lTcUg3Ny9RRWRnN25pZGFsME5pa21vN0wzLzdtTGZkc0F4d0hh?=
 =?utf-8?B?SnFLNDF1dkdwdnFSOUtPdWxKOEFKY3ZPRFlQaERlQnRJc2ltclgvQ0RTSkhY?=
 =?utf-8?B?U3VQcnRCMmM2WGZmM1JFdTBacnFNTmdQWWdhU0JmVjVDMkZYUFJ4ckxZZzNM?=
 =?utf-8?B?U2lsWkhvUDRhc3F0RUVrM0g2RzlPejBSc3ZIYi83MlhWR2QzcTIxNlA0Z2lY?=
 =?utf-8?B?K0d0eDEvM3lmL1EvUytXVVVIN1RzZFcwNWtKa0lUZGZIbFZPZGV3ZEFkYmhU?=
 =?utf-8?B?N1dDN0w5WUJYTXQrWXVjSGM3WEJlVk5xNlJJVUN3SzFrb1RtOVFhbTlwUi9R?=
 =?utf-8?B?bjJPUm5OdksrTEppcWFKZkJXUjJ6M1BYM2p5bDVHQ0VETURzSUZhSWllUTgy?=
 =?utf-8?B?U0F6eklVbXFRUUs4QTZydlVlV0p1amdqV21jdzY5bW1JSTQvamhMTkJhbjJq?=
 =?utf-8?B?VHVVSVpEYUQzZnloTE55ZFZ1U3dkOWp5VER0ano4Z3N2TGJZZGkwcE0zbVVQ?=
 =?utf-8?B?Znc2TWFhSjhNdzN0aVdwR1lJME1UTjZGYWVjaFREdU9CZFp4SDc2OWIvbDZN?=
 =?utf-8?B?R0ZwYnYrVnliQk53R0xEMW4rSEdzVmxPdWYxazdhdjdGUy9xUDZzdUxkcHl2?=
 =?utf-8?B?QjZsWkYyT0YxZVE2T2RIVFRyZU95SEFGMTBEWE5CTXh2Y3lueWpIRFNTWGpT?=
 =?utf-8?B?K09HRmkyTy9QSFYvRWJrSTYveTFpUGpOQi9LTWxBQy9aSXBSZWRtLzRHSmRD?=
 =?utf-8?B?V1I2WVo0N3VrSUxIZmdHb0NGQldEeWhiaHhWWDFhRXhiTm9YbzJNMy9UQWtp?=
 =?utf-8?B?VklpT3NPU3l3eVRpY2Nodll4RXBTS2prWW5wTGFRTEdVMVo0bDJ5YVlVMG80?=
 =?utf-8?B?WVJWc1VySUxWa1VRRlkvY29RYmNPUUlIa2J5TEpXT084RFk5S2tyekVuYVlG?=
 =?utf-8?Q?bE9hHPqJpExWf1J3jG5HvjE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUJwU2Rmanh1eGt2ajUvSFJ3LzZSWnZHOWRmWW96STE0UnZRVjczY3N1SjBO?=
 =?utf-8?B?MUo0VldKdUU2Nngwd2RnbWgzWmpiZDlYNWhWMjNsNVF6KzhLTTVYVjlXS0pn?=
 =?utf-8?B?alJnMStsV3o1Q1YybUltVE5jS0ExbzJnZWZMZXVzSHA2aWltb01ySlVaZVhD?=
 =?utf-8?B?WEdOTE1xeS9uUnBOV3ZUK1RxWE9wdWE5MW4wZXhRdVhkbm1yVGUzT0JwVGEr?=
 =?utf-8?B?YStQUUNsZWcyQTVxUmZYNFFudm5ZN0ZEVlczU09tRWhSZWlOVmU3bHhKelV5?=
 =?utf-8?B?TVE3a2ZtNTJsYlVTZ1R2OEUyNXV1ZXBaL1gzbmdKYVVtSFlFTmpUeUdQMkc5?=
 =?utf-8?B?U3ZURVVWeGFKN3E4WUthcSt2Q3Bxdkt6ZTJKR0V6a0hXTlgvbEZSTHdWcEE5?=
 =?utf-8?B?MG1XRFN6K1FXN2ppeVhPcWJpMmN5RXAzMG1KbFQwRUJMRnVldHB0cE9ueGNv?=
 =?utf-8?B?N3pEMlZOUk9ibk0zOHBkZm1zSzd1SEJzMzlDejR5WG9QNkcyRk9BRUV3MUZh?=
 =?utf-8?B?Qjc4a3VDRHhWZ2gwMkFsRkN2YVlwbFlzYi9QdVJXc2FMOUNENzBFNHJvOS9l?=
 =?utf-8?B?aXdpUFplTWpJR0lNcTRRR0RqVDByYU5YeVRuUG92bEVUR1ZubTU4SzVUMk04?=
 =?utf-8?B?SWRlNTNrWExxRGNjd1l2K1k0djlOb3dkcm5NRU5IcVMxSTNIU0srVlZQTzR3?=
 =?utf-8?B?QUVoenJhRit3L3FNSnlkVDE3Rnc2OU9xRmtJbHVlaVg3WElIL2tiNzdGSjI0?=
 =?utf-8?B?MER0UHZFZ1hLVnlPYTZRS0hUS3lHNkFxU2pFejNMVnJrZWJwSzFFNERWcFpx?=
 =?utf-8?B?eC9IM0poZjByYUFKRVk4YUtkSldnd1hZM0RIaVJFY3VKMnNpUzM4cGV5ZURy?=
 =?utf-8?B?aXZ3cEM1MnBsSittM2JvV3JqNTZQbmNORGFlcEVCMWptZzJNd0IrK2VlbEpF?=
 =?utf-8?B?MHJPMUNlYjBMOVJ6cUNsWlBLc0h5ZWl1b2dKRGRqYlI5MyswVWVSYTMvS0Jw?=
 =?utf-8?B?VjVncXc0ZTF5d0Fqck9qUGZNdFB0QjZtazl5Y0kweGsrVUxCcHBNUDhiY1Vt?=
 =?utf-8?B?MVdpTHhGYm94UWJ0VFpJQStPaVJKdytiS3kxWms0ei9HWFRobWorQ2FCZ3B1?=
 =?utf-8?B?RnhHVkVCVFltd3lrQVF0UnJVd29ObXNFcWYvbC9kM2kyQjYxV1ZDR1E4Q2ZU?=
 =?utf-8?B?WnNIODJkSTFwVmhRZzFmcXdabVltS3NIZ09ybW81aTNlbEtNNWdsY3p0THQx?=
 =?utf-8?B?UmZXbnV2TERMQWpRb1czZmVqbDNHQUU3VHYwQTEvdzNMUHJsczVka08zMm1W?=
 =?utf-8?B?c2ZObUsrdCswYzVOblUydGtaUkU4R3oxZy9LVkNkVGtocTlSU2FtdVVqZlp2?=
 =?utf-8?B?VlNTWndJRndXSUJsQTZvMzJuOUkzOHRHWlRGcmY3ekNSejhPYjI1Rjc3S1Zy?=
 =?utf-8?B?VDVjSERWbEoxV0krNmhIOXN3UjN1MXdOalRFemZPUURUTEJJVG1TSzhKeUxj?=
 =?utf-8?B?cERxbHByOGdDNEpBN1NRR0c2RFBZc3liMEloR1lZWUMySDVCVy9UVVM0NXp5?=
 =?utf-8?B?dXFCM2UxcnlnRkhtNDkrUHFJL0RtL0ltWVZtcUYzdUpKRzk3OUg1VlJJMnhZ?=
 =?utf-8?B?VG1kb0ozWFFLMi9SeWNWM3BXRTluOWxzWjVDS1N5ZjFabXBxQTZyb0ZkMGtZ?=
 =?utf-8?B?WXhEamdOMG1UZ1JIaHYwWXFNMTZ5a0puTDRBclQwQWF0K1U5WmEyZzA4bmdM?=
 =?utf-8?B?d2JHKzJuN3dZQjduTFZoa0FvVGMwR09qNm1aMGs5bmNhVzVCNTd1anZUSnE1?=
 =?utf-8?B?OW84RGhCUEoveFRMMFkwM29BWSsxOGdNRHBYSktIK05ESjhsVWJWWlR5bkN4?=
 =?utf-8?B?anNJajJmbDd4OUt1cDhZQ0tseXdEbGVidDBZTTFXZEVtTjkvdVdXWEx6UEh5?=
 =?utf-8?B?elBHRUlhakR2RGRpSWVCSU9vY2oxMHdYZW1hU0NrRFNsS2pQMW1HVzVEUklV?=
 =?utf-8?B?TGtPa0pBdno0alJ3b3ZsZkJqdExySHZ6K3NFTjdaKy9oNGQ0SmMyYVppVXB6?=
 =?utf-8?B?cWFyUTBMNkk0cndSZWlUR2ZYNlIyVC9FMXpMdG9IVnlucmxwNTRhMFh0bXVS?=
 =?utf-8?B?S1RhRTJKa2h5SHViWnNLWlJPeHBVWDRPbzlSZkZsVVRXcW1ZNUpVd1ZCUDJB?=
 =?utf-8?B?WTM3RFVlaU1GK2hjTVplRllaSUlKS2xnOU1YWlV0aFZFbTFtMHc0N3h4Tnk5?=
 =?utf-8?B?em5nZHVMYldJSFVrVlQyVEw4NVRodDNkTmUrTUx0bDI0Z3V5WndNbjFEdE5R?=
 =?utf-8?B?NGZQdXRrQnZUUXpoam1pS0haMVBJZXFYd014SUtZa0pmZkpFbDhTV1hTSnNS?=
 =?utf-8?Q?0qWQ/1JLraPJlUiqjj2rBEujJicXVnIJf4kdN/l6+i5ft?=
x-ms-exchange-antispam-messagedata-1: Aw4hojVKRumTB8B5pVCM0qj+ahzBc8hndTw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6393ADACE0946D4988AAAA00768CFFB1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k6Cep6PQrnYu4TP2XhagP0AoRuYWBozEgTsN9+p0H92rDEXx12TsdtOPMwg1VDRUa6zp3a8smXSqjlNyBH7Cg7fOYyIhoczM9dYH77WB87OZsMKWQawB0NNgU98xcmED1G297KWAoQ3DNf5f0khFvtK22A3nA9lqNopVpN/8K44351R7X2ZKPCgXrDKAivDBMo9GDwGzhjv6fNsodxoimxSsWhLbg5hAO0rlTdUAZfv11RuoAZHTW1eJHxXF7wY3sq/bXWKLS3UMHaJne02ZjJeo2BAYq2Mg5OFdjMuofGs7PLthhRondRo3CpHbsjjpHC0ot5R/JyDkACK05eBn7GfNh10EBL8MxsbbviqDmqYYGdX/Hoj3rKRDf9YNqi39P/6ayFU9baCOBa2W4YxvvjWLzpw9dxU9NP9XvT4njjQEF5H3HF68Fj2easGMSXuql3mO/CuRi3wQEGR04YIf849HhKf0JfYXESZCh+i2Z38x1QrbDPNk0Ek5p5SOKnkk37zZEZZc/iZCkPRFT7BXvtZmmXha6BJOEpNiv7TrUPGpFXDL0K5dBcGl2G9z3d7ZxqXEEAzgJ+HWr+bwUHzYI0fifQEl/22ZtddV7w+51UhW+XVsXsiIf2rTYJHOOcSc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f483ebd2-a250-4520-0561-08de5726e836
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 06:49:34.9039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: moOH4QCxofOWE1qJavhIZ9MG4NCDyb0PpqCY94N9uty0Ha0AgN5LMmxrDxJl0nx7Zxigj4HTAtptf5bHq+EW2Z4y8gn+mJCeJJ4Zqpegkbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB8941

T24gMS8xOS8yNiA3OjQwIEFNLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0KPiBkNDQ1MmJjNTI2YzQz
MSBDaHJpcyBNYXNvbiAgICAgMjAxNC0wNS0xOSAgMTIwMiAgCXU2NCBzdGFydCwgZXh0ZW50X3N0
YXJ0LCBleHRlbnRfZW5kLCBsZW47DQo+IDdmYzVhNjk2ODQwM2M3IEZpbGlwZSBNYW5hbmEgICAy
MDI2LTAxLTE2IEAxMjAzICAJY29uc3QgdTY0IGJsb2NrX2dyb3VwX2VuZCA9IGJ0cmZzX2Jsb2Nr
X2dyb3VwX2VuZChibG9ja19ncm91cCk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXl5eXl5eXl5eXl5eDQo+IERlcmVmZXJlbmNlZC4NCj4NCj4g
ZDQ0NTJiYzUyNmM0MzEgQ2hyaXMgTWFzb24gICAgIDIwMTQtMDUtMTkgIDEyMDQgIAlzdHJ1Y3Qg
ZXh0ZW50X2lvX3RyZWUgKnVucGluID0gTlVMTDsNCj4gZDQ0NTJiYzUyNmM0MzEgQ2hyaXMgTWFz
b24gICAgIDIwMTQtMDUtMTkgIDEyMDUgIAlpbnQgcmV0Ow0KPiA0M2JlMjE0NjJkOGMyNiBKb3Nl
ZiBCYWNpayAgICAgMjAxMS0wNC0wMSAgMTIwNg0KPiA1MzQ5ZDZjM2ZmZWFkMiBNaWFvIFhpZSAg
ICAgICAgMjAxNC0wNi0xOSBAMTIwNyAgCWlmICghYmxvY2tfZ3JvdXApDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXl5eXl5e
Xl5eXl4NCj4gVG9vIGxhdGUuDQoNCkkgX3RoaW5rXyB0aGlzIGNoZWNrIGlzIGJvZ3VzLg0KDQpP
biBvbmUgaGFuZMKgIHdyaXRlX3Bpbm5lZF9leHRlbnRfZW50cmllcygpIGdldHMgY2FsbGVkIGJ5
IA0KX19idHJmc193cml0ZV9vdXRfY2FjaGUoKSwgd2hpY2ggaGFzIHRoZSBmb2xsb3dpbmcgY29t
bWVudCBhdCB0aGUgdG9wOg0KDQovKg0KIMKgKiBXcml0ZSBvdXQgY2FjaGVkIGluZm8gdG8gYW4g
aW5vZGUuDQogwqAqDQogwqAqIEBpbm9kZTrCoCDCoCDCoCDCoGZyZWVzcGFjZSBpbm9kZSB3ZSBh
cmUgd3JpdGluZyBvdXQNCiDCoCogQGN0bDrCoCDCoCDCoCDCoCDCoGZyZWUgc3BhY2UgY2FjaGUg
d2UgYXJlIGdvaW5nIHRvIHdyaXRlIG91dA0KIMKgKiBAYmxvY2tfZ3JvdXA6IGJsb2NrX2dyb3Vw
IGZvciB0aGlzIGNhY2hlIGlmIGl0IGJlbG9uZ3MgdG8gYSBibG9ja19ncm91cA0KDQpidXQgdGhl
bsKgX19idHJmc193cml0ZV9vdXRfY2FjaGUoKSBpcyBvbmx5IGNhbGxlZCBieSANCmJ0cmZzX3dy
aXRlX291dF9jYWNoZSgpIHdoaWNoIGxvb2tzIGxpa2UgdGhpczoNCg0KIMKgIMKgIHJldCA9IF9f
YnRyZnNfd3JpdGVfb3V0X2NhY2hlKGlub2RlLCBjdGwsIGJsb2NrX2dyb3VwLA0KIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZibG9ja19ncm91cC0+aW9fY3RsLCB0cmFucyk7DQoN
CnNvIGlmZiBibG9ja19ncm91cCByZWFsbHkgaXMgTlVMTCwgd2UnZCBoYXZlIGEgTlVMTCBwb2lu
dGVyIGRlcmVmZXJlbmNlIA0Kd2hlbiBhY2Nlc3NpbmcgYmxvY2tfZ3JvdXA6OmlvX2N0bC4NCg0K
DQpTYW1lIGZvciBhbGwgdGhlIGlmIChibG9ja19ncm91cCkgY29uc3RydWN0cyBpbiBfX2J0cmZz
X3dyaXRlX291dF9jYWNoZSgpLg0KDQoNCg0K

