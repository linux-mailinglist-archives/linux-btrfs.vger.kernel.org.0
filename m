Return-Path: <linux-btrfs+bounces-7211-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC1E952D0B
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 12:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1FDD1F229FF
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 10:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCE21714A7;
	Thu, 15 Aug 2024 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SCZN/ZIS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Mi3LxAk3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A46146A6D;
	Thu, 15 Aug 2024 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723719333; cv=fail; b=VMbsIOWumvS05P5PBgwXsVGr05vsZncOxPzTyZQXAI4b2tk1beGypvoEF1pUOeLu3pTTmEqZob9WjeAzdih+aGo4PYtN37XR2fhaVNwQqTMpXyvQdoGn59Rg3LGrXmKTZfQSoM65s6GpIuzcCKFcyiMEYHKx4Xz5A6vH0wcc7Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723719333; c=relaxed/simple;
	bh=IC3y1hRu4veYhOvxtuqKd5Rs6zDCEOBEtZs+XVpb+g4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MGNBidngoGV0vu6CdkrhXTcSv6VFK87wbdxhM2JhOQidJR+TLbhn+N1PvTkbqy1O6vcJ/4CWc+yRggqsH6xkyX4Yxc5j0Q0htfOAbNw2M1nimzyT8ZeXQiIa6l9YuQzIA11FirEq8vcd3kIpmKYULMBb1n5BAjx83gBO+GACByg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SCZN/ZIS; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Mi3LxAk3; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723719331; x=1755255331;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IC3y1hRu4veYhOvxtuqKd5Rs6zDCEOBEtZs+XVpb+g4=;
  b=SCZN/ZISlmIi+LYPE2zOJSxKCDo2N6uP/5IgBARxKJkGSCLixaQ3t46x
   nlar1daRikwdSt2GoSdw8OweQ1xKa+Ea+kP7wf+QAmVBSUZ80n+rQt0gn
   l420IZN/W1ZON/Vx1mqpy8XFVDcy0s6JxQHzhiq3AsE+oSQWb/bOiiNd/
   ZI5xM4u+nRDUnrXofL9RUBDFru1LBjY/iHU7wuk08eiwRWNmip9Zjl4AZ
   n/91PBlAxa79otD7rJDH4MThBgMWzOv4rmHNt/aaL+vBQVSDAZY6YWHYn
   LhuEaz2gC/ba9jSmhh4gkGH9IsiuQrrEfwVnnPz9HMtnEsVA4owrzkrNM
   A==;
X-CSE-ConnectionGUID: tmRjUYtfSOCf0HTNNnRkeA==
X-CSE-MsgGUID: sXwFTMW4TumN7AZ5yT+i7Q==
X-IronPort-AV: E=Sophos;i="6.10,148,1719849600"; 
   d="scan'208";a="24624725"
Received: from mail-westcentralusazlp17010002.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.2])
  by ob1.hgst.iphmx.com with ESMTP; 15 Aug 2024 18:55:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t57SZW6KHp4rZrN0bdzGVR2+Dy48vPvIr1ZFEMxaJ68dq1mlPKW0zfiiY7ky0LWCMYs0Qal35Qd1x9fPAa0F9HH+8FvowTOlbUKTq3yfjGFjzvCALN0FTEJl/gYG2sE3DWaP9g60Wd2p1ZVfhbKIdieJ/8BYY34aYGhiK2SfG3GkjK8QRyVEkIZlaVj1BUTx4hOZ0aZ1fDeS8Fuu7xMmWM4iP8g26toVq/2xlGErQQwWhnjTwzdfblKloOb767MMnRpvPzqTzqw+rQi5+ExGS2DZdGiAO0K4ldk10V2CEmJzzhO55VZP+DsQhdTnroPzMxqo81reBjQ77LGXORM9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IC3y1hRu4veYhOvxtuqKd5Rs6zDCEOBEtZs+XVpb+g4=;
 b=zOK0/76caqRJGsnJv2JbBBMbx6WaKpqt0o58ZTgdL9CDmBSWT2+RlYTqVTb6v0isTR3MDmtIMYyTHIVXOJTVlhGlJuxAG037zpi4o1PEg7VkbrMJBVO2CzSJNgP6mvNjEv8q9MOQaXnAAU2IhqYtMKz9wpdkdTu56bw1JUFH+7GjXF4/BwS6J+oD+dGnS+BCxEfAwnQEV4bFgEHfJHd6aaqlUzWBH1Bp7I9nag4w6YSEMuub94Q/VFzwHWAXNgIZ6LaA76gg66AgWTyfR0Qo4+NDMskhWZEo8e0B93UAl5S+SjhzZS8wm16bZRHYDpdqSN9AToee2pCayLELuewhNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IC3y1hRu4veYhOvxtuqKd5Rs6zDCEOBEtZs+XVpb+g4=;
 b=Mi3LxAk3zN315bwxZxq3NmfnjrP85Dp2rahOEWkqsD68baG1yyk9nvVjw0VMxcgFUj1xOhAn1kHwVle4+TMKB89ndEX5YsWACuVtHfaW48dZ97i2auyIaL22asU/wDmvlXaFJwJbpAYi4zgELiqdu9mQLoopQqS4JKeBY/qHv/Q=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7836.namprd04.prod.outlook.com (2603:10b6:510:e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 10:55:22 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.7875.018; Thu, 15 Aug 2024
 10:55:22 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>, Johannes Thumshirn <jth@kernel.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: relax dev_replace rwsem usage on scrub with rst
Thread-Topic: [PATCH] btrfs: relax dev_replace rwsem usage on scrub with rst
Thread-Index: AQHa7kfrHnST/6cpJ0yQOSc010shd7Imv9cAgAALrICAAVssgA==
Date: Thu, 15 Aug 2024 10:55:22 +0000
Message-ID: <3e42ca95-0fc8-461e-84b3-161a107a22c2@wdc.com>
References: <20240814-dev_replace_rwsem-new-v1-1-c42120994ce6@kernel.org>
 <CAL3q7H45Ym_QHPYaregfVvUDzaVpm5i62G8==yNQ3Bfd63Ffmw@mail.gmail.com>
 <CAL3q7H5L-j6Pe2zBmd07K1MyRXbEOO6C=-SB93PdoOQ+4spSOA@mail.gmail.com>
In-Reply-To:
 <CAL3q7H5L-j6Pe2zBmd07K1MyRXbEOO6C=-SB93PdoOQ+4spSOA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7836:EE_
x-ms-office365-filtering-correlation-id: d58d6520-13a2-4a3c-2637-08dcbd18c2a8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R1RQRGVTS0pMd0NBZmo4S0lNRlN1STF2dHNQNEI0cG1hbm9GZXdteFB6dEh4?=
 =?utf-8?B?TGMvQU5nQVZKeUp1SlI4dXpvc3h4M3BpaU1QWDBTZmxRYWlxQytSWjg1NFh4?=
 =?utf-8?B?MiszRnJ2TnUrMHdPVjVKb1ExZ09vV2hLbkRkMGhySWt3LzVKK3NZM2xXSmJR?=
 =?utf-8?B?TGJSekdrOC9xcFQzK0w4VEVCbnU3VENRUzVRNGJzR0pMY3Y5MnNpVkVNcWt4?=
 =?utf-8?B?b2YrVkRmY0thYlRsUnpzL3NpOFIzb1M2eTlyRHRFNzEwa3c2V1BYVkF6RGNQ?=
 =?utf-8?B?a2RtcFZUL0RGQUlmYjAvY1NsNFJYQ1VjcDkzWUEySUVYUjhQZVBjcDNOQ21V?=
 =?utf-8?B?K3VUaGdna0dzT1dSd0JINng1QnprTklxZnJubWcvRUpteS93RFFjMDZxMllk?=
 =?utf-8?B?Q0g5eHRiV3U1QjBDUlN3T3llc2xnaDdoZXJhVnJhY1VodFdGNExDUWM4NHpS?=
 =?utf-8?B?c255b2MzeXRtdVJCSExGMDBOT1F4MFRvenVoVWFzdlZZVml6UUE1M0ZRS0U4?=
 =?utf-8?B?TFBrZkMxVkluZnkyVXBOSWpNQVVZc3lacXAxUXpDZG5IMHF2N2FvdTAzVWtp?=
 =?utf-8?B?SDVKdWN6a1dIQnV5dEdFZUJXdW4vMmpkZFVCb1NpcmtqVUNmSFI0Rlh3OEVG?=
 =?utf-8?B?VVJaM2syc0hPeVZudTlJZE16V2x2cnpuOU5mUzFqWXNRU21iK2Nhanhzd0Vz?=
 =?utf-8?B?bU0zVjhFamxsN1BHbDgxbUxxK284SkFBSDV1VXhJN2h1ck1hQUs5MHNBNEM4?=
 =?utf-8?B?T2Q1OUJxcU04a3BxNDQxVzJHTmhjN1FiWmFqYkNtRStoajB0a29WTndMeXNN?=
 =?utf-8?B?VGNqUlhiL01DZW1BTlkxUDlIenM4dWFvWTA0dkpZWnNmOFRnK0VYWlRaVXRR?=
 =?utf-8?B?SGdRUzlvcXFpcTZ3QVdNS3NTcE5SL0loR2FXVlhESG5PeTcyNFdqSEJYSzFT?=
 =?utf-8?B?NThEL1Z5NFhBQUkzUElKVUxHZndoYVBJd1QwamxXQnRMVXJOcVFVTjU5SEhs?=
 =?utf-8?B?ZFlwYnBHbUpDL3JUN1V5UnU3NC9TOS9DMWpsdm5ITnQ5bFRtVnFpUlYyb0Rt?=
 =?utf-8?B?VlpMMzNPVGJQbGFDeEJTb3M2UUw3MnJDbHRUaHh4bHM0ZTF6dE1rdmtpU1k4?=
 =?utf-8?B?SWF2RllyMmVrRE5BMTBoYzVUSlF4cWpSdldES1FVcWpSbkxmTHEvZHRjeWg3?=
 =?utf-8?B?OGVqTmZZMnEzTmJucURaYUpDSVdaWmRJeVRDckI0SXhxbFZkQkVQVkh1YUVU?=
 =?utf-8?B?aTBmSTlXeUc2Wk1mMlZ4b2FTU25CeWRja1hlaHhKVjNJZjc0aUV2SDFvVlJT?=
 =?utf-8?B?cGRDOGhEbGFFbk0xVlVIM1NSRFZ0ZDFjT2xVdU83K0lKNkpBNS9xcS9PaDFX?=
 =?utf-8?B?SFRYNFlBRDZPQkVsRFM4Z0JEZjlNNmpzWVBxb2dSN0dxNFh6enpHK2wzemQ1?=
 =?utf-8?B?VCtvZnV2NmNIeGoxWlNTWUdyQmMzSTVwcm95bnNOSElacmhnL2t2SlRFV29E?=
 =?utf-8?B?ZDZRUml5ZENtdzNVcFFPcHBJVS9VNUJxOFVYREhZc1l5UjN3VzZzUm1qcXJk?=
 =?utf-8?B?UHBoUTNRcVVnSmR2bzZXSnhHdWdJY1hSckI1NDlEWTlnZDVySDdrYzRZdW9U?=
 =?utf-8?B?dVo2bFFHakJHeTYrekU0U1BKN0Y4eEd4ck5VWENET2lZTkpqa2RORDdHZ1V2?=
 =?utf-8?B?UkZVOFFZdG1tL3h5ZEJOMEdkV1B1eXkzMHJIUGVUYllhOGEzMFZkN1REaHF3?=
 =?utf-8?B?VDg1UncwR1JqVjJ1WXdqNjNtL0d5a0xKaDA3VzQ5dXdiSlkvSUxncVQ2U1lL?=
 =?utf-8?B?NnFkUFNtSXBNZk01ZzZQMENqYXFHdXNJc1BzMWVCU0s1anIwb1Z5TGtaWklS?=
 =?utf-8?B?VDRmbU1YaGVtdWNmRHpWRmhuWmlYZXc2MTkvOEgxMEJveEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yk1BS1NYbGtuWVNuVFhmZVNLWXMzQ1ZZVlRDVkQrb0J5dVBxNkhrUjk2ajNt?=
 =?utf-8?B?cFFLN0lTMVJIVnozeHB1Rm5zTWV4VENOTzFyMEhDcXFYbUhFU0FEeWZkOW5k?=
 =?utf-8?B?aVd6Qk1UREpDREhsbEN6OHhrV053SUR3UlVUY3V5OXl3cG9tRzZ2M2F2NnNG?=
 =?utf-8?B?MWhyLyttemFyRVVDaFErUFVuNk5WTWN0c1pSRk5oZWdYemJmeXQyVHpVU3N6?=
 =?utf-8?B?TlkwN2l0L01sczdXS0NUenIyQ2Yyd25FK1pZdWdZOVNoTmh3OHhrYUd3QjAz?=
 =?utf-8?B?b2gwMHJOQnc5RlhjYzIxQ1lzcHFnOWgrWFQyYzJQYlc3c3RMcmNLcGI0a1Y2?=
 =?utf-8?B?aWJqYlF2WFl0ckptc2ZsMXNIMi9IZVpSVEs3RUh0R0d5WlJnMkxaYzVyVGNX?=
 =?utf-8?B?WkQxck1KYjJIdDlhcUx3ZFV6RmxLb0J5bkR1aVBJVXhEQUhoMi96VmplRzVT?=
 =?utf-8?B?UUlJWWdOaVdkMCtGbTZJQysvQk5lVWlHOGtIOUlGSlhLOVpjUnpUbXMxU0JU?=
 =?utf-8?B?SkNnTEQ0Z3hhM1MyQlB1MTM0dlluNEc5S1JDdEwwajh6WjQ2STZ3QjZWY0RS?=
 =?utf-8?B?dUpDZDZGSytqMjFqNnJmb0UxakV1Mi9HbDlYelZKZWYrMG1rSzRIYWFrdVpI?=
 =?utf-8?B?NHlFdjFlRVFTN2tzVkNsS0FXdDZPU3lBdzBab0VucVhFV3JPMVJidXM3NnJ1?=
 =?utf-8?B?dFRuajgyTDJrU0I4VjA0Z2dOQ0VwNHVqV1JpK0I3YkMydVNmZDM2T0ZueW5M?=
 =?utf-8?B?ckdMRy80T2pxa2dtUUpCQ3p0RUlyS2xUZTRmOURlT0lDdTNGdUpMejdhSnhE?=
 =?utf-8?B?NmFISXZSaDB4R3BCSHVPSXViZGZaNG1qcDNuNW5KbnU5V1VXRzB4K2NseStX?=
 =?utf-8?B?czZSOGE2Q01BcVlveDZ2dVcrZjNyeEdXam9yaGNwVWZYVFh4Z054ejhzOTcw?=
 =?utf-8?B?Z0RJdmpqc3JkRFhRYnJ5Tlp5dXY5cmdUeitmVjZNZDMra3V1VkluaW1uck93?=
 =?utf-8?B?NzFLVlB4NXZTenBTL3FacEtoREplS25tOHR3ZjFXL2hHTm1ieWViNU9TbVlo?=
 =?utf-8?B?cnhmaE9Eb1h6Z2JpL0tVYVVDQ3Fvb29BMGs4b0V3Q3NqMUE5TVZLb21SN1RG?=
 =?utf-8?B?N1ljZC9XWGphbUJMMzJhbXpERmV2SGVpSXRiQURrYi9vNE9sNmxFdXdQeDg1?=
 =?utf-8?B?R2dMcWdsbUlCb0ZJSnFmdG5mcnRTTVlZd3BkcG54VUxWbERxeGNiNmNPNXB5?=
 =?utf-8?B?ckZHa2diV0d0eDhkR0xjRENrb2hhL3pXdjF6NmFMVnYxa1oyYmxKaWJmbkxm?=
 =?utf-8?B?bWpGYTZMZlBXMzF0ZWY1ckxsdDFvUkI1UThwc253aTZUTGhwQ1FURGpScG5p?=
 =?utf-8?B?d3ZlTHFkazYwWmlBU21nQmlzWmdpTzFEOEhkRmRqM2F1OVBxdHhKSUNwcHpD?=
 =?utf-8?B?Mk5DUFZsU1Y4V0JKTEFoR04rOVZWUzBodnRzb2g2SU1yVkltTTYrUEVDUTZ4?=
 =?utf-8?B?clRKMWtlTVhjeE1aNW5uTUVvRHZIakcrS1l0Qzl1dnBZeE9rbVBacDlnTXFp?=
 =?utf-8?B?MUlqeFZzSzhjSHNxUlJDcGNHcHM4WkNGQmVwZGFISXBGUFpVemN4QzZXWW5I?=
 =?utf-8?B?YitxdHJpVDlrM3loR2JkL3NwaDhuYjlPWEVoazJBdXI0dTllNW5HdzBUMGdJ?=
 =?utf-8?B?bmpqUXBzS3k4NzVFTGFQUHBZeWdVdlRKSHRvSnZWcU1yLzdUZDUvY2U2NDcy?=
 =?utf-8?B?SVVYZ2ZwQW96dkpmVVQyV1MrbmZwNmtXN0lsNlRPeHVQKzRBOW4yN2JEVFZk?=
 =?utf-8?B?cTY2NEpEZWJobUpucmUzZkdvcjhKOFkvTG9YbVB2WTZRRlNvaGh5RzNPWDdN?=
 =?utf-8?B?L2h1dGhacSs4QkVtZDdJZ0RkZ0pqcWdwYzhFbnFmRE1BQjJqSlBNRTdQQWs2?=
 =?utf-8?B?T25WZlR6NVV4VVpHTUg1S1J6ZkFySVVPNDVxbzExZUlDZU9IN2dxTGR3MHdP?=
 =?utf-8?B?WlBuK1dDZWNqZFRiYXdudTROVTh6MGdvRXlsUVV2YzlvMW9XVTdGbFhoa3FI?=
 =?utf-8?B?UDFKMTI0amdTQzg2NUdPVHRUbTFrSEJWMjQ5U3RPQmdqUldzbURYYVR4clFu?=
 =?utf-8?B?dWZGaHhQQlRTeTFkMWNkYWY5Z3dQNHJ2dlQ5K2UxUnllcXREUjJHeFlhTVY5?=
 =?utf-8?B?OGp1U0orKy82QXhXMzBabjY2aGQyUWxRY1pma1ZtZkxhaFVnenJoRzFWV3Er?=
 =?utf-8?B?Rmc5SFREbmtOOHJIS3FDd2w2QndBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8E3AE2419151B42B33A4460F49508B5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fYW/yD3bMaUqxSMMLHVYQbpmxHkp3//4BI2CPzyRktokMYYxN9gKqCu8Yfcrh+42+5BJ0nvjGT4/DtDDi9qDWEHDsQGJdHrMTMjvLLhOtRkENRA7JFfJFNPbYgBKuStBq10qJHAPESPG51Tyu0Zy8I/gTWn5AqsEVA93U/Kv/FvM1abu8hDgz4ZkyoGJMvaXRzmObORltN8N2/tlo4mB/4V7XU+KrbZM/ieJVb53itqv0lvchDUIn1iETBtE78++VHf0N83Lj4ZdryeD9n7B5Eufbw8QVifRAzOqTR+PBKLmk5wtm5xrqcrDTFCP1w9deAZBIG4W78LRUZD90bGHgyMq3BRCdwcmH7/meekqJk216yBHJ5Gyd892XsqvFhkF1+d7kTE6oSTrk/kcrkiFhUmVTdfR1my5RLUbZ8lonVq+WKVQqX9hatwajBXKk8B5vFVxaf2+PKwptpbmk8jzhE1eG/5cxIhaq1k7sjfm5DOwe+3jH5oikrMqRgrL4a/0fKZE2hWiMcJBXj8QnFTNYAW+V1lYnpfqsWa5x3KMR7t2c9S5Y/p88VAF0bKuGdwkr1Mv9sXZGvCXLFoPmb3ykpUIyQeFdxgQ38uc+koCEAoRzykKlNWKYUL2Zy+DJDge
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58d6520-13a2-4a3c-2637-08dcbd18c2a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 10:55:22.2175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6BZKmeG4ouW4QMgHvOmJu9TYFrVN9uVOvN1Rro8CxFGZQJRa8YtgSZfce7vicFDE++Bebrf1qOZbCqWz3+19AZ90RM00r9d3Tt4JylyT6ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7836

T24gMTQuMDguMjQgMTY6MTQsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+IA0KPiBBbmQsIGhvdyBh
Y3R1YWxseSBkb2VzIHRoaXMgcGF0Y2ggZml4ZXMgdGhlIGRvdWJsZSBsb2NraW5nIHByb2JsZW0/
DQo+IA0KPiBJc24ndCB0aGUgcHJvYmxlbSB0aGF0IHRoZSByZXBsYWNlIGNvZGUgZW5kcyBjYWxs
aW5nIGJ0cmZzX21hcF9ibG9jaygpDQo+IHdoaWxlIGhvbGRpbmcgYSByZWFkIGxvY2sgb24gdGhl
IHNlbWFwaG9yZSBhbmQgdGhlbiBidHJmc19tYXBfYmxvY2soKQ0KPiBkb2VzIGEgcmVhZCBsb2Nr
IG9uIGl0IGFnYWluPw0KPiANCj4gSSB3b3VsZCBzdWdnZXN0IGEgZGlmZmVyZW50IGZpeDoNCj4g
DQo+IE1ha2UgdGhlIGRldmljZSByZXBsYWNlIGNvZGUgc3RvcmUgYSBwb2ludGVyIChvciBwaWQp
IG9mIHRvIHRoZSB0YXNrDQo+IHJ1bm5pbmcgZGV2aWNlIHJlcGxhY2UsIGFuZCBhdCBidHJmc19t
YXBfYmxvY2soKSBkb24ndCB0YWtlIHRoZQ0KPiBzZW1hcGhvcmUgaWYgImN1cnJlbnQiIG1hdGNo
ZXMgdGhhdCBwb2ludGVyL3BpZC4NCj4gDQo+IFdvdWxkbid0IHRoYXQgd29yaz8gU2VlbXMgc2Fm
ZSBhbmQgc2ltcGxlIHRvIG1lLg0KDQogRnJvbSB0aGUgZmlyc3QgdGVzdCwgdGhpcyBzZWVtcyB0
byB3b3JrLiBBdCBsZWFzdCBJIGRvbid0IGdldCBhIGxvY2tkZXAgDQpzcGxhdCBhbnltb3JlLg0K
DQpJJ2xsIGdpdmUgaXQgc29tZSBtb3JlIHRlc3QgdGltZSBhbmQgdGhlbiBJJ2xsIHN1Ym1pdCB0
aGUgcGF0Y2guDQoNClRoYW5rcywNCglKb2hhbm5lcw0K

