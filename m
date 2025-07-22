Return-Path: <linux-btrfs+bounces-15630-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5F1B0D73D
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 12:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87FD37A7079
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 10:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8672E03E8;
	Tue, 22 Jul 2025 10:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h0AKeTKB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="f2gPhhuR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A840F23CEFF
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Jul 2025 10:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753179688; cv=fail; b=CTxllmdxE56lVTit1jX6Wv/GyJzT/SPioJIsvyGi0/oIr8jpl/okL6+2N6BKacPtAGf1uz94OvISgt6LK8yt4pvxAIRzXOxYx8iXp7dfhEAmgD/7QhDdrTHP31Kq+THp4ZGqnt8FzHvzScIP/EmhhjPMbLTLecHXcDqQrdIDyy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753179688; c=relaxed/simple;
	bh=x0NbFgP/5V6Y6sB00bIfe7DordgjYXuBg2NoFBo/giw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SLxkLBN66yi9FYYAgXVJH19ZrElQqywn6zBVJhRZhxw8mFy3hoVa8zBfNDW2n4IVBtnHSSvKyA37+SN7ebeaYmqHyQLqHmXEF8qUDp8Y3xFt47u0YRoNdo2VSHpcV7qLf1dvUBi8hYSEZxqq4sCOXrFZsucWyfq/DR67FcBXF3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=h0AKeTKB; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=f2gPhhuR; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1753179685; x=1784715685;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=x0NbFgP/5V6Y6sB00bIfe7DordgjYXuBg2NoFBo/giw=;
  b=h0AKeTKBSPoi2cq6AKhD1L2gG5uHFdHjwF7SsR0cC8VoWIcnD5CVLvfh
   OF1RffOHLZhXLc0IGrAzRxuH9xDP90qIdAgMkCHHOQTbNdnJbaX0e2uku
   7rzrcjdwk8e/XJL2xCt1MJcJnDT8tc6qvR/rs96QyvgVCaO+1m5g5ttVi
   lzSvAJiooZ9ib+HaWKsDKlP/CKIJ0f1SQBBKYD0LD5QmYVNNkOVmHmP79
   mKRFtznk1D3EViE0z0CcaVpKhbfVazmhSWqxgTbU7eeHL9pOzYYzF8WU6
   AmC32GupWx9bJXC0bEjmP55tfMa29aCy4t5MIdCcv8sK7Y/WgDtV3QaWt
   w==;
X-CSE-ConnectionGUID: GZx33JbiSe6BvtsBHuTdOw==
X-CSE-MsgGUID: Riq7sm+GTTaTrFstsNQ6qg==
X-IronPort-AV: E=Sophos;i="6.16,331,1744041600"; 
   d="scan'208";a="98922708"
Received: from mail-bn7nam10on2042.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([40.107.92.42])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2025 18:21:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V74Qk28zK2CpqNbfHZ12GcjLtf5B/IRt1+KG2gHSioOivbiZXbMiVEib1wrBZYqDkz7LoarSlRTutjPcsuJZ7zxJbb7eOPW9WeYB6WATMRAn+Uvjxw5GiXe6A/9Y5vUhudFvwTr3EbtkUTJiSYSWpUjcQFbwlEXRIvH2SJvRL5/f4RUHGh8NHLxgm21GLfqFoh65JDpTmDQZ5+2MSgtXcnhWUITjU+hf0SuGnGLfaQAbhoHiiWcJSPStJuSFWwwZPTFAupNkdvGJ8ZQM6AxbF/415dGHulbgDJY8C2TvH1pstqDC9ftLhowe2y5ukW0+n4IFSIB2BvUfXyFTvVq8ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0NbFgP/5V6Y6sB00bIfe7DordgjYXuBg2NoFBo/giw=;
 b=CKO1gyd3Cke8OKglkiP5dsokgrxwaGHjU8jCq/Xpo2tTmb5QuRGbQLSUcmwfNPiSaA9KitUFhaDEc/xCidZgIVW33rn5O+41a4FMuznRnC+ZYrqMk4rmKdpoHmmXS1lIj1al9zOBkS2vGHbvwp8W9Euf8uI5N9oP6sa4xfQGpkzV6Tkcw8u9pR4qnRXgKzjbRkRl8QOHhHH61TyBv9YhiamP6kmpD2Ts8yYm5FGGq8k6lZgKQSMGFY5xuhTIYNpTPYMjoaHMxsxmZQi3Ww1D+Y8sg5nKApzPQVtmP/OKBd5//rnSjrO0XKRh6gvw2CMO7sUMImGb3/bgmVrBNXR90w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0NbFgP/5V6Y6sB00bIfe7DordgjYXuBg2NoFBo/giw=;
 b=f2gPhhuRgWk1WxbqDs2U1xikfg/X7C/3C91GkVTz+p78r9sHSdDbrnOgaAGwOm430zM//Pxdxip9ySTK+IvDLh63tlQE0glBOVG0T5uoSU5a+e9RzOHgDvS2tqbrisIGea1V2DHajMvtSwms0/SSQ3ol6KNsIQxT8EGHjFBTuE8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7267.namprd04.prod.outlook.com (2603:10b6:303:71::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 10:21:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 10:21:16 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Johannes Thumshirn <jth@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC: David Sterba <dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>,
	Naohiro Aota <Naohiro.Aota@wdc.com>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 1/2] btrfs: directly call do_zone_finish() from
 btrfs_zone_finish_endio_workfn()
Thread-Topic: [PATCH v2 1/2] btrfs: directly call do_zone_finish() from
 btrfs_zone_finish_endio_workfn()
Thread-Index: AQHb+uyGbiQ5Ntx9TUSDh62UA2qnorQ94/8AgAAK3gA=
Date: Tue, 22 Jul 2025 10:21:16 +0000
Message-ID: <8a8671cc-3caf-4f84-8ccf-1dcd55c27543@wdc.com>
References: <20250722093915.13214-1-jth@kernel.org>
 <20250722093915.13214-2-jth@kernel.org>
 <a663efc8-dd3c-4880-a477-f0462980e51c@kernel.org>
In-Reply-To: <a663efc8-dd3c-4880-a477-f0462980e51c@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW4PR04MB7267:EE_
x-ms-office365-filtering-correlation-id: f83f31e6-730c-4706-f072-08ddc9097e51
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d25rRHROWkdISXdOWDluenU5Q2hNYjBKQ0d0YkU4cjFrZ3FDQzBxQndxM05l?=
 =?utf-8?B?djY1UEI1STBjTkNkOEhmajZ5aURpbzExSXBnM0lTMStVeFJJSGFuL05LWFR3?=
 =?utf-8?B?c0dqQk9qeGcvc3BMOUxCT0JpMFREYUdQbm9XbHdqVlE2TU92OHN5NXJwRGpx?=
 =?utf-8?B?UERJSEt1K1hjSTUyNnhCM2FPSU1DQkFKT1lLWDlEa014ZGdxRDJXdXBESHY4?=
 =?utf-8?B?WU5hR24zOWtkNTlxeEV2OEVyRStCVW0ybVR0WG51dno2Ri9JbTV2WFkrZmU1?=
 =?utf-8?B?cHRyQjFXOVBBZDlrZlJsbnZJOHdibnIzUStIOCtIMG55eDNOSDJWenRaUXB0?=
 =?utf-8?B?QWlha0lGSHE1eGthcnk3WEI4amJxZm5CeXFScVA3ajlOeGtyNVE5R3lmZC8y?=
 =?utf-8?B?cHdHcjk4Wm81MWVaTHdmdmdZZlJGay93WmRvWkxkN2xCSHJVY3crMmtLRkdo?=
 =?utf-8?B?UGF4R1J6SGRiSXlneVVXVDZNVXJqdkFuR3VwSE9idkJMcTlNOGtrWWRCUk5V?=
 =?utf-8?B?TnBJKzJRWmYwcU5CSG1aRGVlY0wvbHFReVdhM0dwd1RwczFXYTgwaktZckI3?=
 =?utf-8?B?SkRBRUVNRlcxTGV1OWdxVkVXYldhVUNzcHpDT1B1WnM4ODJNVXFpbXVuN3ZS?=
 =?utf-8?B?UktidGZlM1dHNms5dld1Zk5XV05YR1d4bzl3RVoyTnl5OGFJTnNILzJvR0Jv?=
 =?utf-8?B?NkZmbnkvQUZHSHYxSWRNVG5yb0hrRmVEaUVscTYxdWRqNDNFd2Mvb3JZN2p4?=
 =?utf-8?B?anJJdExhL0ZTZ3c2bkRxL2dVenNDNWdBNk5wZVF2UGEwQkJCWm9wRVhWWFc0?=
 =?utf-8?B?YWtNVjNxbXZBNHZxeldOTktRVmZQQXFmaGtyNm1scm9rQXdaUlBaUVp2d08v?=
 =?utf-8?B?MzJhYUFPQzdpamFYQWFpSFR6UmdSYTNaa3dSdWpjY2g5N2M1V3EwVGJKSjA5?=
 =?utf-8?B?dGFDcUlKdmIvOHNCTDY1bisxSlJhZW1Ia0t0S2FwTXFsbjJvVThYSzc4V3dt?=
 =?utf-8?B?UU1xVkIya0ZIYkVWSXlKdEQ2a3VOSEhldXB5c2lyQXNOd2IzRVJsdVlJRWw0?=
 =?utf-8?B?MG0wYkl2ZW5wZHJBOE5KSzVBT1hNNldaR0ZjZjZVNk41czg0WjdROFJ2VElB?=
 =?utf-8?B?QitFeTBPWXFUcnNBY3hwbHlpZlI2SXdISWxOYjR4VU9JTGNWbFBGUG5GVU1U?=
 =?utf-8?B?R1JoQ3dMa3FFWHRCTzFWWTBtam5DYXNjL2thSS9zekJXSXNCQmpVQ1k5VUw4?=
 =?utf-8?B?ajJGOWl0ZHY4QWw0Kzd4Ull3U2pRSU90WkFvWFFFMFhoZmY4REN5VE9xQ0RB?=
 =?utf-8?B?bnhNYVhYVnQ2eWdoLzUrYzQ4OGFXaEFZaW9WbFhleFJXR2FiTXZkUDVnalZl?=
 =?utf-8?B?azRKTFZLZTJCWFFFTnY1cldSNDFYNDEybFZSRTNkdE5pYjJFbkpQNmVCWC9H?=
 =?utf-8?B?OFVWbEJGbUlmanZ5K0JYUURGdkk3Z3FoNTJydmU1d21nc3ZMWUsxaGdqYkN6?=
 =?utf-8?B?Qk40VVRGNUVaVFdKckl5UmlMbVl2NkJENVpEbDB6SG9wTG9YSjdQNjBiYWR5?=
 =?utf-8?B?dDVhY1N6YndUSFFPQTRJZHZKR3gyand0ZWkwZ0dlTEV5ai9BMjIyT3dpRUpu?=
 =?utf-8?B?cTIza2lOL3RaWi9uSkQyYlVac0ltcjIxeUdCK1JwQURiNWxmRExKV2tCRUVD?=
 =?utf-8?B?dlpmVWJLOE9hVzR6LzJHUjUzdDR1aWJZOWJoSFlIalZyZkhTNHFPQThuSVN1?=
 =?utf-8?B?dm1TT05wek9ybEZTRHZUdTQ5RDRPSitGdXJBMDRlMFU4Y2tMS1JybE5SN3RE?=
 =?utf-8?B?eWoxWkdPRVU0Q0JlN1lTVDRQVG8vUDZ4RjVvdHgxeWdIL3F0MW1VbmtUVXJj?=
 =?utf-8?B?dUh1U01EanlKWGl4L2NaWFpXRTZOY1ZJQTVvbXErMEdsT2dUdFMwUENCRENk?=
 =?utf-8?B?MEUzTlpuS0xXNncyaktMKzlDNEFjaUVmS1c2Q28ya0IzZHNubHBQWjcxQmdG?=
 =?utf-8?B?WHJtcU5rL253PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OG5SMlY4aUJYTnNXaERld2I1QzVqakdwcXl5Slo2cFVyd0xTMkVzcE1jMzdF?=
 =?utf-8?B?c21WRmloa3pSVDRVV2hFVHpIWU0zQ3NhU0ROc3pPcGFnMVpwYWxVWDByRHUy?=
 =?utf-8?B?Q1p4WlI3RzFOZ0RGaS8rRkpEOTZCcHZmMnRhc3RZWHBJZGh5Z2x0cHVwUXRj?=
 =?utf-8?B?K3NGd0V0ZDBudVhvaFJRTWlRaTZKbmNTOVc3Um5WVVVBd0VwdGJhSktONjFP?=
 =?utf-8?B?dlM1REI1SnpjTktiOE05c0FxcFVwWkcyVytKaVpyRFRhalpoWWs0Y3NyWTNm?=
 =?utf-8?B?UW5mWXZ6RkJ5NmM1Q3QxSFNreVNId2RVV3lkQTYrdUlSMk8xbS9vMXQyS1VP?=
 =?utf-8?B?bmtBNy82VVZWVkZkMkdQMzRPZ25sQ0FZNEkvVUpvWkJsZzl3bVNkK3ZmeWF1?=
 =?utf-8?B?cXBDeS9hanZFekVpcC94VjlKQk1oN2R5SXd3QkFDZ3lNRGV2WHc5UGswcXFF?=
 =?utf-8?B?cU5JLzhGdmRMV0dBZ2JsVjFxMkZrMkxweUNIVUEzbU8rdnVkZDBDMVpDdlFt?=
 =?utf-8?B?WlA3cUhHTXRpNUU3SU9QdTlHUjFaRW9xeE9Bd1c4RStxYW9nbnBVUzl4TnFn?=
 =?utf-8?B?K3l2TFVkSlpEVEx6eTkvQURSUHBPRERkeWVWQm84SEtGSUtqbTVzT0l2U24w?=
 =?utf-8?B?ejB6RGdjYlQxcCtNb0p5aWJ4NXJNMFV5RlpmazRwclNIYXVDQVRYbjFlVk1Q?=
 =?utf-8?B?T1FxbGIzd2p6aENiZmVnenhHMFVzWkZ1TEhXeFFzdHc0ZENhTzNESFY2ckdm?=
 =?utf-8?B?R2ZuNnRKSTJ6L3Rndm5Ud0FUejFyWllrNjFJWjVqM0s3SFluRVZObnJld1Fz?=
 =?utf-8?B?aDRKVXZBYUtyNWdhdTdOOUF4TEFxVkxaNXN5OHlxUENqZi9WM01QekFSOUtt?=
 =?utf-8?B?OXF2N1U3VElmbkxXZnJGeHU3NHlJRlFRWnNIVXpiSWRDQmE3Z1NZY0djZWF1?=
 =?utf-8?B?UFVBcjNrMU8wYWJEZUdjdWUvTzlkZTZBaFRINnNqNnhUR3RJdm1rU2JsVTdt?=
 =?utf-8?B?NS9xT0RoYWVaYjkxaWlLWXpwQVFhNzlTZms4SUVUeTJsKzRpbEtiZUY5dmMr?=
 =?utf-8?B?QkQreCsyMkNzQk1Yc3J0TnM1eHN6NUh3SXpMYTlJT0Yxc2EvL2ZFRzdwWi9q?=
 =?utf-8?B?NklkalY5TFZGbVRsRWZlYkJGL1lML3RiK2xNUzFRVU54RWRMSVBMeExWdkdG?=
 =?utf-8?B?eHVXQVR5c0lmck45M0hudXlpTDRQeTRXUEJ0dlVUbCt0ek1KNEtueU93NXpP?=
 =?utf-8?B?M0dDRTJQeFpybnVWVThBYTFscmxyRyt1M1dKdlppU1R1c2ZDeENvOUNBVzB5?=
 =?utf-8?B?MG5zcS9zSDVuUCttNVlPUmVzV0VwdU1MUGw5UExvRHpscDVTNUxPRE96b1lC?=
 =?utf-8?B?NnI5dm1OTzFpdFdQV3dwNFpDc2tPQ3VwdzMzenJyRkVaaHNLaG4wdGR6TkVJ?=
 =?utf-8?B?L3RSK1VQNnd2dFNOUGxqd2VxelNuN3ZMeUJKSzR0NUVtK3cvb2ZsUW55b3Y3?=
 =?utf-8?B?U0pWNVVnYUJYM2tRbmpSdWVUd1RLTjVzYW9jZ1B2bldZdmdZWWQwZEpxaVBh?=
 =?utf-8?B?SGxhWjZ6RWVwSmV5M3N2SW1sZ1lqdWMyNHRjN1pzV01oY3EyRk5WdXYyZ1Ax?=
 =?utf-8?B?MU4zQnc2Y2JmY0pjd2hwTnVXSUFHOXAweWxwcUhZeGpoS2ZEZHVwcFY2UmpT?=
 =?utf-8?B?K1hHd1BpL0wxVHdoUlIyUXNuY05NSWI3dGpFSzhocHhqN3FJT1VrQkZpcUFw?=
 =?utf-8?B?V1pmSU41ZDc0RWNpdzRtWnAvSWt6blpBNkNUbmJmY0NsSTlOR2lIbmozbVlp?=
 =?utf-8?B?a0RwVUFpL2xhb2lTc0RDeUkveGpINk1lMG9FWHFpdE9PRHVBUVlzOEtJR3Fs?=
 =?utf-8?B?d29hUG9PWTBCSE5lQm03MEgyck15RFYrQ3lRSGhzRU83Rkd4dVpTbEF1R3dp?=
 =?utf-8?B?R0k3TGQzM3RLTmUyNUI4bXdNZURObzdRUk1HOGJYWnh0Q3kwK09NaVpDaFRC?=
 =?utf-8?B?bW5QMjE2T1YxUGZxejNKNzRzYktKY0htMVhtQnQ2aFpzZ1ZMSlUwVFRkR3JP?=
 =?utf-8?B?M2x4cElGRG1OVmRQV0lIbWxUZ3pGaUpaVWNDZ0pXd2VvNEhwajdXcHJmTFdI?=
 =?utf-8?B?cGZEdVlyQi92RldoUVdUemlLaXB0VVJQUTBHc2w4WUtDaW44TExUK0R1RFF5?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <454218327CB8B5429E905DBCCCC21371@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AMv6FBJqUmwKHZea4Qp3JIFynPSf1BXtCR0zDi4cc+weNQyeDPmn5gIj0U6hRAxv1Oo1iuEHUQQ8+A0hXHFMe62/j523XR9k8DxFY9RKYyGB3s36QR48RoJIQtqG/ig08QKacZyUxYqgOCNBr8e2Yn78PlxK0orZFihH4MlYekfg4cB+WjgUzZF25G+valNIZWxLXN85jzDo7XOdQGbf8U1dnTlLheXrEQtyWeDXvt2ZAHyhWI0KKdC4hTQ5WBjJ8epi8g0b5wwkjX19KFzjOJoF/AfWaobJGYiVP5H8Mb1i4z+KXem3n3RMzPPTW+sUEzU1nx9s6PJ8RA7b7E9FfZFF22HwsYb0N9fcwsHWx/jsbuO6HUyfzrUuBH82cZ4p7PihnMngqPPyawRh/XDDQ+JDR5M2UVYq8p7jDjhG/44R5D1yUpEixSo4BmYfABXVUREnURsWyq5EoS1zdN6nTPrVaQ6b+pSdPMNLsQFQfPD80nLEyVPhjxLEPe+6yTVW4GokGB7jL/nuASkLCS+iQMi23/z4j08fqLvl38+wRl02UxprBeGjDRUzdOwV0fywfHfSN9LfFNLy0UJfqt7TJCYAoYIxznQ0iAmRO9PUZWKLuUegvhSEzZo4w+1b2Ohz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f83f31e6-730c-4706-f072-08ddc9097e51
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 10:21:16.7117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u3ljMUSCAr4MIsK+iD/rEPz2NgGkfbM8DoRw1qVeso2+Mfwgl/8fgz4eMGi4Pg0v0yLB3kvAif3pIXon0eUDly67dbNvABjuUsthyGc93sA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7267

T24gMjIuMDcuMjUgMTE6NDQsIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiBPbiA3LzIyLzI1IDY6
MzkgUE0sIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4+IEZyb206IEpvaGFubmVzIFRodW1z
aGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+Pg0KPj4gV2hlbiBidHJmc196b25l
X2ZpbmlzaF9lbmRpb193b3JrZm4oKSBpcyBjYWxsaW5nIGJ0cmZzX3pvbmVfZmluaXNoX2VuZGlv
KCkNCj4+IGl0IGFscmVhZHkgaGFzIGEgcG9pbnRlciB0byB0aGUgYmxvY2sgZ3JvdXAuIEZ1cnRo
ZXJtb3JlDQo+PiBidHJmc196b25lX2ZpbmlzaF9lbmRpbygpIGRvZXMgYWRkaXRpb25hbCBjaGVj
a3MgaWYgdGhlIGJsb2NrIGdyb3VwIGNhbiBiZQ0KPj4gZmluaXNoZWQgb3Igbm90Lg0KPj4NCj4+
IEJ1dCBpbiB0aGUgY29udGV4dCBvZiBidHJmc196b25lX2ZpbmlzaF9lbmRpb193b3JrZm4oKSBv
bmx5IHRoZSBhY3R1YWwNCj4+IGNhbGwgdG8gZG9fem9uZV9maW5pc2goKSBpcyBvZiBpbnRlcmVz
dCwgYXMgdGhlIHNraXBwaW5nIGNvbmRpdGlvbiB3aGVuDQo+PiB0aGVyZSBpcyBzdGlsbCByb29t
IHRvIGFsbG9jYXRlIGZyb20gdGhlIGJsb2NrIGdyb3VwIGNhbm5vdCBiZSBjaGVja2VkLg0KPj4N
Cj4+IERpcmVjdGx5IGNhbGwgZG9fem9uZV9maW5pc2goKSBvbiB0aGUgYmxvY2sgZ3JvdXAuDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hp
cm5Ad2RjLmNvbT4NCj4+IC0tLQ0KPj4gICBmcy9idHJmcy96b25lZC5jIHwgNCArKystDQo+PiAg
IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBk
aWZmIC0tZ2l0IGEvZnMvYnRyZnMvem9uZWQuYyBiL2ZzL2J0cmZzL3pvbmVkLmMNCj4+IGluZGV4
IDI0NWU4MTNlY2Q3OC4uNWEyMzRmMzFjOGRhIDEwMDY0NA0KPj4gLS0tIGEvZnMvYnRyZnMvem9u
ZWQuYw0KPj4gKysrIGIvZnMvYnRyZnMvem9uZWQuYw0KPj4gQEAgLTI0NjEsMTIgKzI0NjEsMTQg
QEAgdm9pZCBidHJmc196b25lX2ZpbmlzaF9lbmRpbyhzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNf
aW5mbywgdTY0IGxvZ2ljYWwsIHU2NCBsZW4NCj4+ICAgDQo+PiAgIHN0YXRpYyB2b2lkIGJ0cmZz
X3pvbmVfZmluaXNoX2VuZGlvX3dvcmtmbihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+PiAg
IHsNCj4+ICsJaW50IHJldDsNCj4+ICAgCXN0cnVjdCBidHJmc19ibG9ja19ncm91cCAqYmcgPQ0K
Pj4gICAJCWNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAsIHpvbmVf
ZmluaXNoX3dvcmspOw0KPj4gICANCj4+ICAgCXdhaXRfb25fZXh0ZW50X2J1ZmZlcl93cml0ZWJh
Y2soYmctPmxhc3RfZWIpOw0KPj4gICAJZnJlZV9leHRlbnRfYnVmZmVyKGJnLT5sYXN0X2ViKTsN
Cj4+IC0JYnRyZnNfem9uZV9maW5pc2hfZW5kaW8oYmctPmZzX2luZm8sIGJnLT5zdGFydCwgYmct
Pmxlbmd0aCk7DQo+PiArCXJldCA9IGRvX3pvbmVfZmluaXNoKGJnLCB0cnVlKTsNCj4+ICsJQVNT
RVJUKCFyZXQpOw0KPiANCj4gV2h5IHRoZSBhc3NlcnQgPyBab25lIGZpbmlzaCBjb21tYW5kIG1h
eSBmYWlsIGlmIGZvciBpbnN0YW5jZSB0aGVyZSBpcyBhDQo+IFBIWS9saW5rIGlzc3VlLiBJIHdv
dWxkIHJhdGhlciBoYXZlIHNvbWV0aGluZyBjbGVhbiBoZXJlIGxpa2UgZ29pZyB0byByZWFkLW9u
bHkNCj4gcmF0aGVyIHRoYW4gdGhpcyBhc3NlcnQgPT0gaWdub3JpbmcgdGhlIGVycm9yIGlmIG5v
dCBpbiBkZWJ1ZyBtb2RlLiBObyA/DQoNClNvbWV0aGluZyBsaWtlIHRoaXM6DQoNCmRpZmYgLS1n
aXQgYS9mcy9idHJmcy96b25lZC5jIGIvZnMvYnRyZnMvem9uZWQuYw0KaW5kZXggMGU2MWU0OWI4
Y2U5Li4yNzk0NDZlOTg1MTYgMTAwNjQ0DQotLS0gYS9mcy9idHJmcy96b25lZC5jDQorKysgYi9m
cy9idHJmcy96b25lZC5jDQpAQCAtMjQ3MCw3ICsyNDcwLDkgQEAgc3RhdGljIHZvaWQgYnRyZnNf
em9uZV9maW5pc2hfZW5kaW9fd29ya2ZuKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCiAgICAg
ICAgIHdhaXRfb25fZXh0ZW50X2J1ZmZlcl93cml0ZWJhY2soYmctPmxhc3RfZWIpOw0KICAgICAg
ICAgZnJlZV9leHRlbnRfYnVmZmVyKGJnLT5sYXN0X2ViKTsNCiAgICAgICAgIHJldCA9IGRvX3pv
bmVfZmluaXNoKGJnLCB0cnVlKTsNCi0gICAgICAgQVNTRVJUKCFyZXQpOw0KKyAgICAgICBpZiAo
cmV0KQ0KKyAgICAgICAgICAgICAgIGJ0cmZzX2hhbmRsZV9mc19lcnJvcihiZy0+ZnNfaW5mbywg
cmV0LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiRmFpbGVkIHRvIGZp
bmlzaCBibG9jay1ncm91cCdzIHpvbmUiKTsNCiAgICAgICAgIGJ0cmZzX3B1dF9ibG9ja19ncm91
cChiZyk7DQogIH0NCg0KYnRyZnNfaGFuZGxlX2ZzX2Vycm9yKCkgd2lsbCBzZXQgdGhlIEZTIHRv
IHJlYWQtb25seSBpbnRlcm5hbGx5Lg0K

