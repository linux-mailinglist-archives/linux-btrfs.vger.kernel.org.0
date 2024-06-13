Return-Path: <linux-btrfs+bounces-5703-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9FF9067CF
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 10:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CBA11C226C5
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 08:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B381420A6;
	Thu, 13 Jun 2024 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h6sGb3Xp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Wvw6Yprv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2AD54757
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 08:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268680; cv=fail; b=bVDF1vY9yTCOpLXWnqJ4DkdINYBrCIh5HB1QcxJF/GcRN5I6COFLjrWSwgWzzw7CTqYl8dJHuz/GRFNRvCBnI0436zXqZSoT++WdyT38bLyl7nSWSvwT/0lBHKzUW+LsraL8TKORAEeCiP1s3uZQVvRQTsZcHXsuxCOaM2Ld2n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268680; c=relaxed/simple;
	bh=kWNUMLOPUjPK5LaDebmtuUYNJEvvY9b3N2Uwj9tPqNs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MgWEgVcEcy/qDSCbPesHV/C0JzYGu8xt9ToMK3Zeg4aFZzH9NGC6G/P47Z9fDYmoFybohBS83T9REIfoQCvwLJgumViBiv7nuHgGtbNHJXwUpWoWDyMH+jgKtk9YfENF5BpcthRA/BZtYRFnws/6rojxjfJiDz5xloSBfjqevRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=h6sGb3Xp; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Wvw6Yprv; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718268678; x=1749804678;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kWNUMLOPUjPK5LaDebmtuUYNJEvvY9b3N2Uwj9tPqNs=;
  b=h6sGb3XpCJHEGJPnk8eQQeDgUYP2t1BR0nkzkeayPtsn6jeLlWKzeLI0
   y5ucUqbg6lCWLakfMzo1BJQjWYA728z83jzmlNFLeMVeVF3wHRt9+4Njv
   CKoH/M7zC8LUpk8uYcyh13bfoYVdxCQgCLUafdxH0OBvRbI7ZXYtaOw/F
   e3vpV29HuJqABg/HZx3MEnJd90B2sA+vi5yPeTvH8flNTq312nVlAlXFl
   W2GpdRyhaFRI5TpaVVCha6UjFELbTKcyIkoLiElVWwgWNdwKi/IxZ88Lq
   u/kTwbYBAaImUit6WmuUCBHFBex73TLaoVHi9AWBQDDtKWL98ZNuB34wx
   Q==;
X-CSE-ConnectionGUID: fYpwX8iqQwSZ6VIVeQaORQ==
X-CSE-MsgGUID: 4GKCFu+rQceQPV39Krj9iQ==
X-IronPort-AV: E=Sophos;i="6.08,234,1712592000"; 
   d="scan'208";a="18277844"
Received: from mail-dm6nam04lp2040.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.40])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2024 16:50:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgPdywjZjeOu+HUgeQHIBtl9FpB0frdKFvsmINO+JpVtxLW8eRhm4gDCJ/g1A/+2OIRssz3N4BIiLQOByAVV3JrE8U3mCo+YMjUjRDUXlaLykvHUdh4ddI1NQ1DNqIHZCV/bnIbXrnIuJ0rqpZzDDUJM4g93aNwe5RgMRWdtkE3UbxJnyyeX+RgyTPSKfe3YGQFh2e2gIa7gcDTWsC83xkQYrobRpyGxsGRrfy9nTqXhbFEs4Vgx/KTqwNJU2cChQ+FN64c0vHnAbQ+CyFnez1K+cazjBH+hZrFnHOrG01oduYL97q51vijtzusFAl9UAMkY2l8MDLkTTHECd5pblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWNUMLOPUjPK5LaDebmtuUYNJEvvY9b3N2Uwj9tPqNs=;
 b=Zztd3D5ugEr8zui8a3x4zGIH5hIW7l+QKn0WavdMQ/eKkG/Xfw9/r0b2viG3bmuwDWvcOKZ746NYojuljIPEXCosvDyNG9kGUi2K+x794W/EnDPwL1P4a4eo0MR2/zThXiiQccuGO5LAafPpCW8G3OMPgjRNvgfWILKPNKn1NZRpB25eZkpxAdOolFaOAt0wcpU4mIEPRQ8DKfIwTaNahmqOHedN0toPvahXtv6MY34JcNCbybelTbpcxoBeE7iY8PO7B8tZMGSxFnCnORgCi/NZZGYCE1n8bzg1skb0kWGWGgN6yrZdVe67LRIC6uE4EqZRHm57/tTkfixj/n/k3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWNUMLOPUjPK5LaDebmtuUYNJEvvY9b3N2Uwj9tPqNs=;
 b=Wvw6YprvPG0UVOkOrbkflvXAeOMwZXco0BTQ8nuENcd/sr6Ar0r9CKJdkeHFciKY4Ux6tgk3z0XkvtQeIcvZWZZQL51Yf606Cq2njcyt8vwU9FbNSJXzBaEp/GGnydMAyhnlkVIcq0NPz/gbNs8ayY2G+N9aKdqyYFyGJ9/WU4I=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8612.namprd04.prod.outlook.com (2603:10b6:510:245::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 08:50:07 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 08:50:07 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <wqu@suse.com>, HAN Yuwei <hrx@bupt.moe>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/4] btrfs-progs: move RST feature back to experimental
Thread-Topic: [PATCH 0/4] btrfs-progs: move RST feature back to experimental
Thread-Index: AQHavSf8L97VgPl13kedIXisUaMXO7HFUagAgAAOhQCAAALkgA==
Date: Thu, 13 Jun 2024 08:50:07 +0000
Message-ID: <e4d04d5f-0ea8-440a-a3da-33b73e991fd8@wdc.com>
References: <cover.1718238120.git.wqu@suse.com>
 <3E9580E891A06375+d6a5f369-32e8-467c-a230-82298a979d10@bupt.moe>
 <45911acf-3035-4e6c-9f33-5704eae31014@suse.com>
In-Reply-To: <45911acf-3035-4e6c-9f33-5704eae31014@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8612:EE_
x-ms-office365-filtering-correlation-id: cdff4dde-c5f1-469c-015a-08dc8b85d3ae
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230034|376008|1800799018|366010|38070700012;
x-microsoft-antispam-message-info:
 =?utf-8?B?NTVOUnJ6VUZtL0VKaXFNaFZzcXorREN0TTI1VERTQ3oxaUhTNWpvUzhWSVlv?=
 =?utf-8?B?cDI3c2c2RkxqYjVjL0VVNjVXWWk4K1JMQjJwY0U1YjZUdnFidkd4U2NGZThk?=
 =?utf-8?B?eFV4TG9qYWFyVW1pMUNqWmNBd3U4VFdzNWFZYzZsWUttTjFNTWNwOGQvQmxp?=
 =?utf-8?B?U0lDVVhBOHJFU3MxZkhaaFFSSmtUaGR4ZHhwOGxlNEN4emFPem9zdnl0cnlm?=
 =?utf-8?B?ZkRCUnk3bCtyeWYrbGNUa3llUW02MnN6VGE2bEdVLzg2OXBRWE1vWFJTRW5O?=
 =?utf-8?B?eGxaYUk0Y2VzTHVzOVNWU1lYR0lkUGFMQnRPQnpqaE03MlZmbU1rMmxNdUU2?=
 =?utf-8?B?a1JPL2ZwSGhpTDhxaDhNckVKZHM1VDhaeU5CU2o3WVpyRjl0ZDc4ZTFYQlls?=
 =?utf-8?B?S3VvdEw1aTJsYkJ4blFaa3llb2RBb2JpS1NxMDhmTFdvYUxkNE9wMlYwK3Z4?=
 =?utf-8?B?M0lNbFJuUUNtZTlSdmZUR0FzUkwrMjZDMkU1OEppRCtoVGhBN2h2S2RYeUFB?=
 =?utf-8?B?U01uRWhrcW5kRFpGQkR4N3hraWU5aU43M2Flc1gzV3JMZDh5L3VIeEtvZjAr?=
 =?utf-8?B?ekV0SlV4eFRqSTBWcDVQZEl6aDZiVGpWMGh3cnFGSnFzV0JaZitPejVaV1ZQ?=
 =?utf-8?B?YldjbTc1NzNhSXVPUVFQLyt4bEtvd09EWUxHMy9HTTlsUkVxWE90NE1MVHph?=
 =?utf-8?B?azNpR1BHSjA4eDRhQ0VxUVMxNmRXWGRBbExlSmdsVlhtRHcwTDc3MTNrN0NT?=
 =?utf-8?B?VkhMcVFBWE0xRnhwb0lNZEI1UnBoUk5TRmhGdDUxZHpndFVIRVdmMEkzS2lB?=
 =?utf-8?B?TWdXOGVKQXlXRXBMbVBZRnJoRHNUbjR6UU1hcmppbnBWMzIwak9ab2d6ajVU?=
 =?utf-8?B?YUVBQWhWeHRRVGxMREtkbXpvTDJ1N3dzdjJOekZNakRxWmt0ek8wSFBhcTVZ?=
 =?utf-8?B?NzQyL1pmUm1FNTNwTEdIVnBRM0xpd0k4d29PbXhPMU1OTEFxN3VMbTE4L2xD?=
 =?utf-8?B?NmJmZGRwaWxZWUlsdW50YUxtSGNiYWlCVnRtWHcrMUxmeUdFbkZZN0dHWG1p?=
 =?utf-8?B?K245cHYva2JUYUhZbkNFSmN3Zm1yOWRVZjRDVjlrcmpZbytqZ1FIdnhWc2E4?=
 =?utf-8?B?V2VwQThxMTNva1Z6NWZkTW9JSGZTZFlBNTRybHRab3k1bzR3c0kzMEY1VmF4?=
 =?utf-8?B?bXJVbVVEMXZFdlhJNkI1akgxTW1GeFpaVGt6T3AranE5Wkx0R09CaDZzQzZh?=
 =?utf-8?B?NUJ6TjJRRjF5V1puckVCbDAxQlJKMmZZSUFjekQ2U0s3cWtnSVY0VXI5Z0Nt?=
 =?utf-8?B?WEZGbmN1NlNrYWlsNGtYSWZ6N3VaQzI5WVgyMXVEUzdHTDVRc0xaWDVrWjhs?=
 =?utf-8?B?OFdiQlRYMGVsY2FVajNJYXJTbXBtQVlCRmxrYnJyOG94OVRITFZnelNtWlpk?=
 =?utf-8?B?V0k4TkFSbzVHUTRBdjF0YXZVRW5yNTZSeXZCcll4TWxhTlNZRWljUlgycjhz?=
 =?utf-8?B?dWZNa21oalZBOVFOeE1wQnl0VTlYVnN1RGxsVVVUemovZWNPUTJqZTY1aURq?=
 =?utf-8?B?Qkt1QW5yUU54QVFpOEFWcXl5UTIvM1V4OWZFdWt5dDJ4WnlKS2NaL3dIMHhV?=
 =?utf-8?B?MXZqVXYrODM2WGlLNnFzbitOUHhvWXJOWkg5ZWFBY21lZGM2VzdOckF2RWRS?=
 =?utf-8?B?Q2lzTVdHRjJmb0dFTmtzNForWlpsVTNqYWkzV2RMZHdnd0E0WVVZQytnZnJt?=
 =?utf-8?B?bVp1T0o1MjkxY0ZvMnRqTGpyb1BqUVI2c2FsNDExVkprWUhDeG5hWTYxUTBB?=
 =?utf-8?Q?kRLO1JsSm87dCgMtkjGErVvGOgtXgQIlZU8P4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(38070700012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGxaeXg5OGRJZEhPNW1ESTF5WGw2VktKbWRZL1VzalZ4UldoN0lHVDNuak0w?=
 =?utf-8?B?VXNJSGFYeGhVRytoV09kZVNVTzRpaEQzdWtzSHg0MkxmenpCMGpKREVzR0k1?=
 =?utf-8?B?dm5Ld0hnTDNFV3h3d2d2Q0JrUTVaT3gyNVB6K1VteFVWdVZlbHBRSHorN0JQ?=
 =?utf-8?B?T2E3WVpvbVFGUm4xNjNuc1VjZU9zbjFxdWlkRVV4VzBaNUwrZ2pTVXRqVk0y?=
 =?utf-8?B?NzNIbDZ0c2s2TzB6dGhlNHdpTU1BbFJWeGN2SzRSTE5yKzk5ZDByTTA5OUJS?=
 =?utf-8?B?TCtrNXR4K0dIdWpUWThmVFlHOWhiV1FFbU05V1ZCL2w2ZmlDVEdESUVrMGZ3?=
 =?utf-8?B?M3pldnNNU3FZakY3dFhEenhsM0lQQ2RrT3VBV0pKQjMzQVM3dGIwNldhTThM?=
 =?utf-8?B?TElOS3FFSUFrUHFkSnZuNEdzbFRMZFVJTmo4d00xTWtXQ0ZHN3ZneU5oeW5P?=
 =?utf-8?B?YzVSZUNOMk8zQmtWVk5jSy9UbVVoR1BmWERrdHV2TW5tMTM4MmV1NXdVNllt?=
 =?utf-8?B?ZS9YbDJ2TVREMTNWWFBOZTU2YWxpMXhoV0F2cm1ReUEvQWszTnd5dUVUV1hW?=
 =?utf-8?B?ZXA4SWUvdjRVOHBzNFV1Zkoya0hzMitxdm10NXFpdDZKaWVTOVdFL3ljZEZU?=
 =?utf-8?B?QUNwU1JUb1VHMnJNQ0wyZWdxa2pRWTZtaEJHby91ekRsT0dIVFBjMmRDZ1Y1?=
 =?utf-8?B?cHVSUkVORUxTZlRrR085RFcvdkppa2NSUUJHeStWRWhhdkhmRFlYV1hEQ3JG?=
 =?utf-8?B?TEs2YUtaOXIrZXNFT0FqeUEyODkvN0dNbUJBMGsvSjZyOHZvZStnbU85Q2xl?=
 =?utf-8?B?bGJreFJ6cWRQWG9QV3lBMytwbkpaQnpXdjRqSTdIWEJwNHV2aElCQ3hrS0Ri?=
 =?utf-8?B?TmxXMzVieFFGeVMxV0NHTmI0aW1kaXdsZ09Idyt0dmNXaUsra0lOdU4vMnFi?=
 =?utf-8?B?cnowbHR6REhVWFNnajBWa0tvdTdVdWlNYS8rbVhOUlVpTTAxRXBocTBsaUNy?=
 =?utf-8?B?QjMvY2lMUE9La1FRTEp2bE8wVk8xN0xLRzlxRDZZajdJeS9Yd2h4SHhJeFZv?=
 =?utf-8?B?QWFKdTQ1NW5jUFdYZk1sL3ROOWxrZVpvRGIwdjJqZTBlTkJtN1M1V2cvN0FX?=
 =?utf-8?B?MnE1S0xiS09VSHBUY0g4RkprblRZRTM3YVNhRTA5MVF0enJjdzk2Mlpla3Fi?=
 =?utf-8?B?NGxLOGZrWUpLdHRMaVdrRzFqUk93NHRKNXkzd0tnamQxRzdSbU42SUdwS01t?=
 =?utf-8?B?aGNleitqV3V0blJ3cHdjVTh2cVNrd0VuUWdPSFR6VXBUblFuYXNzc2lGQlVo?=
 =?utf-8?B?NWo5d1puQTlwTk5GVWdpMkNXWkhIVW1iUWpjLzBwUXYwNVIzd2tkbGRmSWNO?=
 =?utf-8?B?UWlJZWFGNmo2VHpLaE1vRC9mSWR2dXdTdFBVT0tYc0twRDBmRnduSzNTUXoy?=
 =?utf-8?B?aUd5bVQwVGpWQzRhS2M5ZWdvWTJidjUvOGx5aEMwS05zU0pFQ00zUE50bjhY?=
 =?utf-8?B?T0M5WTNwcjBPMmF1QkZ0UTJ6aytFak5lbGZDMWJWZm1ucEdzcXJrbmVScWpF?=
 =?utf-8?B?cVlRQ1kvQmpLZ1ZxZHFDSDE4clZCYndxOE5hSlMxQzdPREc2OGRxb0dnZFBn?=
 =?utf-8?B?Z1BteE5jekgzbE9OY3JCTWJ0NEcrWFdpWHpWbmIvOC8xdlFYM0diVW0xYXFE?=
 =?utf-8?B?QUQwRmNPM3AzamhTL3RsajQydWNuYm93TnEwRWQ4UE95Y1d6dGhyOXNzNURa?=
 =?utf-8?B?c3FJUU53VTBtVnlFMUZONWx2U2ZwMUVPOTZMVXZpK01UWnZxZ2M3czhzK0do?=
 =?utf-8?B?ODZaWkNGZmQzd3h4WkxZWDhCT3pNVUt0UklFcFBhbUU4SkY4ekZ2cU5qa0Vh?=
 =?utf-8?B?VHBObjIvaGp2NHQycXZRK0swcXBWTjFnSE1aa0JxREZBMDR2WVhrY2JxM3hJ?=
 =?utf-8?B?T3hrQlhSS2o0VGpxZTNLMUFOYm9FNFZCZmo1SWFteENIeWJiR24vYVNtMGdZ?=
 =?utf-8?B?VDg2cXJYQlhFeFd5SE13QmpWb04wWmhXWG5qR2Z6MW5pWVJRU1M1c05uWTQw?=
 =?utf-8?B?MncrSkxneHJiWVpwajNJZlc1S05OeWZjVjRsdzRFTDFQYk9jWDJOYnVGZVRj?=
 =?utf-8?B?ZzVFWDhlQUo1VEZkN1lPVWlFS1BNalRKdVFCREpxM00wUU1hc0dacURTMTB1?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D08B5640E57D4C46AC26B4C62D90463E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	42MKprtse48ChbOf1nwcFtN7rxCBZXuiUBL8nrTRDFXRr9Sy6FFpSNLigFWIt6ywpvNRWTI87lS/qSd+oQSJ6ERjGP2nUgeFWPvAtyl/Heit60FOWLvEz2HJPAlsbj0WtdLldzq0x5n+cgaJD731cMTcQEf+V2SrcrUtdgzc3j76ohVu4zdvsKAcAs0q3VNVbRGkDUfZ+l0caivT4ybIWr4g3koRya1+Z3JkfgspWRUaLhdYJjAj8JaX/PgXXW5L0rEQKfGUNhIGNVjhgTsOzGwxn12/bdC9i8M2DSyxNAP1c08lLwrg7F5NfAlVcrI3JnVX0UIRXXzd7V+cCN2muXnuYI4HDgxvJ125QVvZ15MEcZNOsiDG+beOM0KGPSs4o1fAabcZlQzznJZjYNwBOpKrDG+uI7hTeOmR0TI25H/YrIBY2EZt1xD0wNGhQSJErmhUJFoVn5DBMxXwMVGopiDb8ksSAClhu41xK2OWiRXlCW4PJmvSRQ+ce1g2w9Y5d5mlL03JUQ7lzS0mVzLdBwg3cJ9dSjJ6QUwdk/iAbeeklj931J/vpTo3BKTMv5G2eUZ+3cDTc0x9sTvMWV2h4OCXLywgcjCunvaToJfiUhbgTFT31gA/iotR/3vSljgP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdff4dde-c5f1-469c-015a-08dc8b85d3ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 08:50:07.8008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HUxS4yldiuBvQHem1f1WkzTaYXFa2pKSCuCB426ErUSXOP9yiSkhXrfZ0vgOWU2ePMSmUawURwQy8ZXmsrklACT5PQww8l07GB7N9N//loI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8612

T24gMTMuMDYuMjQgMTA6NDMsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiDlnKggMjAyNC82
LzEzIDE3OjE3LCBIQU4gWXV3ZWkg5YaZ6YGTOg0KPj4+IFRoaXMgcGF0Y2hzZXQgd291bGQgaGlk
ZSBSU1QgZmVhdHVyZSBiYWNrIGJlaGluZCBleHBlcmltZW50YWwgYnVpbGRzIGZvcg0KPj4+IG1r
ZnMsIGFuZCBjb21wbGV0ZWx5IGRpc2FibGUgcnN0IGZvciBjb252ZXJ0LCBzbyBlbmQgdXNlcnMg
d29uJ3QgYW5kDQo+Pj4gY2FuJ3QgZW5hYmxlIFJTVCBieSBhY2NpZGVudC4NCj4+IEhvdyBhYm91
dCBpbnRyb2R1Y2UgYSBvcHRpb24gbmFtZWQgbGlrZSAiLS1leHBlcmltZW50YWwiIHRvIGVuYWJs
ZSB0aGVzZQ0KPj4gZmVhdHVyZT8NCj4gDQo+IFdlbGwsIHRoYXQncyBleGFjdGx5IHdoYXQgd2Ug
KGF0IGxlYXN0IG1lKSB3YW50LCB0byBtYWtlIGl0IGhhcmRlciBmb3INCj4gZW5kIHVlcnMgdG8g
cmVhY2ggaXQuDQoNCkkgY29tcGxldGVseSBhZ3JlZSB3aXRoIFF1IGhlcmUuIEFzIG11Y2ggYXMg
SSBsb3ZlIHlvdSBiZWluZyBhbiBlYXJseSANCmFkb3B0ZXIgZm9yIG15IFJTVCBzdHVmZiwgaXQg
aXMgbm90IGluIGEgc2hhcGUgd2hlcmUgSSB3YW50IGl0IHRvIGJlIA0KdXNlZCBieSBwZW9wbGUu
DQoNCkFsc28gdGhlcmUgd2lsbCBiZSBhIGNoYW5nZSBpbiB0aGUgb24tZGlzayBmb3JtYXQgYXMg
d2VsbCwgc28gcGxlYXNlIGRvIA0Kbm90ICh5ZXQpIHVzZSBpdC4NCg0KDQo+IEZvciB5b3UsIHdp
dGggeW91ciBhZHZhbmNlZCBzdWJwYWdlIGFuZCB6b25lZCBzZXR1cCwgY29tcGlsaW5nDQo+IGJ0
cmZzLXByb2dzIHNob3VsZCBvbmx5IGJlIGEgc21hbGwgaGFzc2xlLCBhbmQgeW91IG9ubHkgbmVl
ZCB0byBkbyBpdCBvbmNlLg0KPiANCj4gVGhhbmtzLA0KPiBRdQ0KPj4NCj4+IEl0IGNhbiB3b3Jr
IHBlcmZlY3RseSBhbmQgZG9uJ3QgbmVlZCBtZSB0byByZS1jb21waWxpbmcgYW5vdGhlcg0KPj4g
YnRyZnMtcHJvZ3MuDQo+Pg0KPj4gSEFOIFl1d2VpDQo+Pg0KPiANCj4gDQoNCg==

