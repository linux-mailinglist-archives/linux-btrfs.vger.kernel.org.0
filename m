Return-Path: <linux-btrfs+bounces-11504-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF27AA379E2
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 03:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52093167BE3
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 02:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E7218785D;
	Mon, 17 Feb 2025 02:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JoqAvnk+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nFwc+lu1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6C3145323;
	Mon, 17 Feb 2025 02:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739760158; cv=fail; b=QTBVYIiTwkWwPBF3MN4BG95s2T80xBR0YVH6abol5nqboMctSGjNNeZYO3p8NW5UbIvc7T07tmhK/IomHwOewEg7jlL2J91+QTINKNpWpA9EE3DPm/9OFHi+ent2fwiYDn3Ieu9VYKl9P9TkZWFjWjIx/sag1jOJZyNfmlzeq/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739760158; c=relaxed/simple;
	bh=KeDtzPn873qQbxgihLCSwLkWjX/ZjB3BUp6jl4mFj50=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YcMqUcHH54nAxeZH+wrhkTMfQYpZrokK3J9BhE5s1QXX33A482WK+bSEGXDrJJ0r/dtENV5Ir8foK0OxQHs8Nvf3/Flne5ErEr3rQ0ofzvQWqr1KZ+Pr3RSdn4vc2Hz+69vspYlclahVFbARWp8QiKUmqHR4Zoh8L9+5kQySubE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JoqAvnk+; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=nFwc+lu1; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739760156; x=1771296156;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KeDtzPn873qQbxgihLCSwLkWjX/ZjB3BUp6jl4mFj50=;
  b=JoqAvnk+f+RM5QbSIcB5crMLsJPq2YJddYUEmPEuwAYDnKXBaL/6xGrh
   i4+Qkuw5yVt+UD87yngba/hoQRuFqalEsRakeHpa8in+P5aqXAgEFIWeV
   gUPQt5tbdwypIvvoKItJdBDR4vsfEv2H5ONB+Zmf/Gr1psR8nWIkNpwh7
   XdFhjJ7Hb8eWddVgaAda+sDoacOt1O7ioQdwQfD9xGKR3GgVltjFX0cJh
   aZtE0boxK2XobT0EZHvqJHNpTuifPvhAAdnQ6CmJryZtBSeQYAgxYzKpv
   89hx+3QZMAb7EAjhqIP+8AIRUdFgsBwwAm+A0/RqTcqEBR1aXDTISj7g7
   Q==;
X-CSE-ConnectionGUID: R05D6t3uSGCTOxc2lMwHaA==
X-CSE-MsgGUID: /OrPIqCkT7aJyrL1lqwAoQ==
X-IronPort-AV: E=Sophos;i="6.13,291,1732550400"; 
   d="scan'208";a="39253876"
Received: from mail-westusazlp17010006.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.6])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2025 10:42:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdXRTfaQc/Nb1/lY/P+IhK1xxGON/gdn1NUcP4KNkeddGiRA7gnL0s+5ZkMFTSbBhgLaKJz3EGSTorveMABbCxVBNF5ch8zBzGECD7BOkuiWqsZh/c8yr7NZ+vcspnacQIdDUyxdpH36nfyR0B7lDc1ew/bZVXOBJlGtylHYPkt0SlQutP6OblTEZcwCAVGRG+YHSKF2U+awGVZpA5GMrYquZZ1DwVE/awldky7mDvlSs/wacikUvWnqwJBTxVeQxAg5tkHlk/j5r+knlzjJC+Dqp9QaumJj88WZjA+NSuSaHyeOEISV9OzKQqU6cRPW7OhZLieDw5+O+5WocJc1YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeDtzPn873qQbxgihLCSwLkWjX/ZjB3BUp6jl4mFj50=;
 b=cU2++uaXGPh0r3MWIBLkOkeYCmTG1tjD8Y9FwPDk/KzyW/BI7+Ss9gef+rZG3SsOTQTpk/4MhY1AZtwRXnGdQS3NJB4L0AQh8CSJhmI//VZcMuycMjdhuRRIlZqa52C/COLVG1o1SH0AOer+mmSNiwvW8VpsOOVvdqs6CfDPW1Ea+i905K5VKqhbUT94j2955GqFt3vt/q+J76fWQYIn+nzd/7+wBV31PipFkhhHVkL355Ufku+GeTsx4rkBT/zcHpKHv2Mz1bMrpsEJjrd9K67P/aTiSITyN/C1ULp4O1V1lHTAWxUQn20Y/+MvBExzv7xOoQblv4KRuAxpi2PyiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeDtzPn873qQbxgihLCSwLkWjX/ZjB3BUp6jl4mFj50=;
 b=nFwc+lu1x9vzgvauiqt7MCU32tbDhnkIdSjGiMIjlTx58XSwyJYyaeXbdCkp9zwmDwE5XiDhVoIXlhB9uuy5ebdkERl47fGzG/SwOT3MQqeOEKijxFhUK3NRDL1kE5R1Gtjr73Um+B9o1+rKEC7BDaGktsjLBdtQV+P3kS6tqM8=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM8PR04MB8101.namprd04.prod.outlook.com (2603:10b6:8:c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.17; Mon, 17 Feb 2025 02:42:28 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 02:42:28 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, open
 list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: exit btrfs_can_activate_zone if
 BTRFS_FS_NEED_ZONE_FINISH is set
Thread-Topic: [PATCH] btrfs: zoned: exit btrfs_can_activate_zone if
 BTRFS_FS_NEED_ZONE_FINISH is set
Thread-Index: AQHbfVcjZTBXbTQY1EuPj2OcUWhhxbNK0GIA
Date: Mon, 17 Feb 2025 02:42:27 +0000
Message-ID: <D7UDHSQ8V7YD.32M3W782CTH7D@wdc.com>
References:
 <f811034c9494b256f50a0675297f072a6b65076d.1739368972.git.jth@kernel.org>
In-Reply-To:
 <f811034c9494b256f50a0675297f072a6b65076d.1739368972.git.jth@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM8PR04MB8101:EE_
x-ms-office365-filtering-correlation-id: f424c805-a8c5-4c34-7f32-08dd4efcb7e0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZC9pUUpZcjUzbXRYcS9NdVYyNitHcDFRMEh0Z2d5NW53NytkU2lLT3RGWFEy?=
 =?utf-8?B?eGhoMW1saVBLWmNteVRJTDhjY29NTkxna0hGVTNEeXhrK2ZaamJZN0dMVGE3?=
 =?utf-8?B?TUZGVi9wcmErSldHNTY4MGhiZUZnMllHdWpQY2JEdWUrZXdwZ21YQis3QXZH?=
 =?utf-8?B?d2plYXpZRWZaRjBrd0xmc05sWVJpbmRKbmlWcEZJd2NSMyttR3ZEaldINWQv?=
 =?utf-8?B?Zm1xckVpLzl0a05KWWpBT2FpZFowb041YzhLZ3VjM1FjaXkzblgwdXZKZHM0?=
 =?utf-8?B?RHlBS0xiR2VkdzlNbHBOSEF2WFJwYVRIaWVteWtBK3BieWVvaFRHWmlOdkN2?=
 =?utf-8?B?T1VTdUhDSlAwaEFRSFhtQXRHSGJKaVVTdDMyWWRQOVZLdXZkR2FLeDZMaHph?=
 =?utf-8?B?SzhCL0doNzM5OHlHdENHbFA4NWZmNU85MUYwQ3RacSs4OFNqVUFhenJIMTNI?=
 =?utf-8?B?YndZUlF6anp4Y1c1d3l4VWNYVnZ4M0VOYkExdW1FWm1kQ2RZbVhWRTZ0M3Vj?=
 =?utf-8?B?TElQYUVJNjZHTVJ4QnVjL0FWVmlPZXFPbkliUCtNUkpHWjk2NTlRT3Y2Nm02?=
 =?utf-8?B?UGtORld2aUZaekpVa1RqVy9tRU1OdVBxdmpKNlBlT2VGekc1eW9YcWUrSitH?=
 =?utf-8?B?UDRScU9KRnpTUWlzWnY0cDZlMlk2aVI4YlQ5SFRQKzMyRE1iSGxsTW1QSVVs?=
 =?utf-8?B?d09ZaElDeklwMzZjN3B4YWd3ckNjdHhCVHZqRHdaUi9iditLTkt1Y0sydnpp?=
 =?utf-8?B?M2o5YnVTRVRYZXJMYTUzbkpSUTkydHB4ODFtMU92K0JuNE8wZ25ReVp3SXZp?=
 =?utf-8?B?b3pPVFRlNlhtZ1JVYUp1ZDA0d3VIREpRU3JGam0xUXFDR1A2Wm1YTTFIN3hR?=
 =?utf-8?B?cTljMlh4Mkd5RTJYQ0djeEo2SVB4bTdndGI3VFd5UkEyRDRKdi9KWmx2RGlD?=
 =?utf-8?B?TWpjU0VxWWYrWTM5bVVHZ1lYOHVwbHRBWVNVc3o3UTg1Q1pYRENkUk80ZFJQ?=
 =?utf-8?B?cWxYNkthYkRJbW1JbmMwcXg5aVZFZFIvQUllWHVtVnJjNUJQNzVNMU51ejZW?=
 =?utf-8?B?SmcvdlA0c2QwY2FhcG9BV1NFTTNBTEtMUjNxRTdyRWQ2c052cVVTamYzTElU?=
 =?utf-8?B?am9pQ1JKM1piKyt3VlRiVlZyQXJLQzJkdCt2dWJkazBSd3phS21QUlBvNWZt?=
 =?utf-8?B?Sm14RkJ6bi91TDFoZFNXYzlySXk4RDlrbHFzTHVxcDh0MXZEWVVXSkRqVnlY?=
 =?utf-8?B?SVppbjJ5RElOMXd6bGR1NVgzNlFzcDQ2QUJKQm5GVDh0N1ZiZWxzVHczWFlF?=
 =?utf-8?B?RE9UWjYzRU9iV1lRYmwzQnc5NXArNlh5dVA0Skthb0ZSaWV2MDZucHhuTWJM?=
 =?utf-8?B?Nlgyc1dJamsxYVdIdnM0dUUxUmZRYWRzN2wxa3lFdlV1K3FXbitZRWJ1YnVx?=
 =?utf-8?B?bkt2OXNJVk1lZ2FpQVdjREpqRDB3dkNVQ0E2dmNuNHZTSkpGbE50bGEySkJJ?=
 =?utf-8?B?a28wZUwzU0IzTTNoUjBRdkVQWHFzUm9wQ05iUU80QUtjU2xiczhYRUxyemY1?=
 =?utf-8?B?SFlIaTNJZmNNT1lrR2I5VGFYdHYyTkcvSnQvc2thL2ZEWEh5b2xvcGxqZXdu?=
 =?utf-8?B?cHRtR1UxTmY1RVRtYnVkN3dPZ0JBVzlvKy91blF3WU9XRWxlR0dNMk01dkJ3?=
 =?utf-8?B?b1NJaWsxSHkrdjJmTE1xL2l3aDhkd0VBUGV0bGFoSXY1NGQ1cWpKU2NtQ3VC?=
 =?utf-8?B?UVlxOTMrcUxVcW5MUkllSk5kMFp0SXd4bTRobk4ycDJDK0YyL1pLK3JxcFo5?=
 =?utf-8?B?VitnQ1l2TGUxUFBpWWVEMGhhUDVRMnl1NjQ1a2xrOWVGbGI3WlYxa3lBb2tp?=
 =?utf-8?B?SXZaemZ1R2piL0M1TExiaisyUEdYQ2R2TTRqeTFlL2VuaXNHK0taZGZrVjNT?=
 =?utf-8?Q?KTCepCYklqg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UHBWRGROSzdkc2htSGwwTDNCYktXSVdDZW1UUjlDbklVdDQxNXFqV0E1Lzlk?=
 =?utf-8?B?VWZvZjVYTG1ZWDBhU2FPODhSZHlEekVBaGZHc0UrdmlGa2w0NU0yY1dMWkpl?=
 =?utf-8?B?QXN5VTV4b0l3NTBTR2c2OURkL3phc1RUbUhtSnQ4dGhYYUxCU2tYbkFjOTVN?=
 =?utf-8?B?aEV4WldzZDBnK0ROQW1mWC9Qa3E5TnJBcmp0dGlsRmVWbEVqazFzNi9LL2Z6?=
 =?utf-8?B?YjlGeWFKOGVHZHUzZmFPQTBmNCtlRFg4SkdjWW14UFUxUlhqbnFydnh3RzZJ?=
 =?utf-8?B?QWtGZXU5eU90ZFFKajVTdzVlWXpJSElOM3pPYzdnTGRmNGNuWGlBYXR1bTZX?=
 =?utf-8?B?M3ZVTXBMSGhrdWtncmlCNmtpbmNLV1FUL0JtaHIwaU5XTmp3dENIZVJmV2J2?=
 =?utf-8?B?dkdLT2pZQmZrZEhHRzZBeXV3Zm5qUVlub0dWQXpQTU85N1ZIclB4NTRxNEdm?=
 =?utf-8?B?amFSNVdXV1JWdXkwMUJ3Z2J6cW9abFllNkNQdDFhRE53aElYNnlONVdxcThn?=
 =?utf-8?B?TnViYnp0WEpPWDF3Z1FnOEVQWXp1bTczU1AwdnVJZnlkTEVPeXlEM0FKdVBX?=
 =?utf-8?B?eEw0Y0xwS1pGYnlpRUN1Tm9JWENVdS81SXMxRWZ5WFlPeUdmbjlZZTdjUXJU?=
 =?utf-8?B?UHFpSm5xWnkrMW9qNDRObkdWR1dYbE1OTG10YzV4NUVtU094b1NzYUs4amM1?=
 =?utf-8?B?SUk2SUdFVEV5SDZhblV1VVc5eFBMWGdCa09FcDZmK25hbThzMHorVkRvL2Ja?=
 =?utf-8?B?eWxmTStoeE12NmZsSWlnS1hIeDBERVUxZE9iOHdLVjNXcHczQlRLd0tVRlM1?=
 =?utf-8?B?OVRYM2Nhb21VaUFuT1hjak1kK0xBZDFxNnJySi9WNHcvbUFYME1iYlJ5OEwz?=
 =?utf-8?B?ZE1Scm5IUGJlR3JrSzRkSDdzTHBuSlgvSDEyQXFjU0l3OVpZSEJBak1IYm04?=
 =?utf-8?B?di9zQk5jQ0N0d1VKZEFYWmFNZDFrMXZna1hpUUhzWDg1eCsvM2NYOEVPUkI5?=
 =?utf-8?B?KzZIU01HeHg3aHpNQndpNit6THo1bkgvZ3dMaVdtRmlTWTNtU3h0dEV5RzFL?=
 =?utf-8?B?aUJzZ3BPQmxHeFUxcTZHYmVnQWlINEhUWWRNM0NmZnVJbjNQTzI4aElVSSt6?=
 =?utf-8?B?Rnk0c2p3TndsRnpCSnNlTVlsOWhjTG8rN3BLbC9Gakk1SkVpcEJXNmEwWjZu?=
 =?utf-8?B?OVJGK3dzQ2hLQ1d3M1U1NGtlOS84ZlVibmsvVDhrM3ZTVFdsOVlRR1g3b3U1?=
 =?utf-8?B?aWxXZyt4NG11d2dwczQyZXAySVdqcGhnVlFSSFZUd3pNMFppUEcwVGNsN2M0?=
 =?utf-8?B?bTh3Vm5NcEZRVG9ySWYrMWc2SVgvYVZNOU9hWWZybWpjM1lEUkwrZExNdXlF?=
 =?utf-8?B?TWxyZkFwTDcvc3VUVm9GaExsb1cvOWJrYXlLTzdoeENTby9pVHhaSHFRVTdx?=
 =?utf-8?B?UGtIVDB4Z01qT3hsb3B3RWdBbzBRMGdnQjVLbEcvanRXUDF4M05zakRiajdT?=
 =?utf-8?B?MkIzMjdkNHRHZi9zd3kzQkNRczdDNDRBMFpYb1RITXVTTEZqaVg4ZDNSdmZE?=
 =?utf-8?B?S24yWFg0WGFjLzdCS0IySzdKQnB1UEwvSFdXYXFqZ0hibjl2N2x6eTFCbDZu?=
 =?utf-8?B?VXU1Tm5aZERBVHhTcU5YZlBQWXNaTk10ak5KZkgwNzJmVHUxSko1T0c5TEtM?=
 =?utf-8?B?T0JqTzhDVWhXcGdXTTNXUFlodjFERGNvWW95YjlwM2o2MGFFSVAvVVNBSWtt?=
 =?utf-8?B?SlFuVThVRXNlUDIwTlczZ2xzRnp2b3JkUzVxMlZEWEt1NzF4WFVWTHd3dzVy?=
 =?utf-8?B?b2Yxd1RjYmpRL01WVlJDcTdBUUhTNGhyVm51aDBFV0grRFd4UklQQkFZcDZh?=
 =?utf-8?B?akRmWmtxQ25uenRYQm1Ja0hVeFd5TElGY3RuelBlVlFGTHgvRWFWSi9heXRm?=
 =?utf-8?B?d3dMTnl1RjZFVmVpZDRJTU9Ob0svUWhyZ0VrNUwrRU5BL0hJMXY1ZWJFaU5q?=
 =?utf-8?B?dERJdU43cFdSNEQ2UGN0WUl4VjEwdy8ybU1nTW1aV21pSkJMMHNMRGwzZWxa?=
 =?utf-8?B?blI4dXBad2oyemNaTzlJOTZOZXZqamFCYTRXakxvOEtpeUpidDZVcExCRVpV?=
 =?utf-8?B?QytHUlBNWmtxWTNybXFQSU1qN285UE1VSEdnYzgvWVpwUEtXY0FEWVlBQ3Jk?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88E21A10A90B584C8016E8B8CAF3E986@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2fNOZyfdOqTzHXeHgZDQfHNrlyMREL8vIYWZ3lha+YKAg5ifXg/65qi68TBtdvyd4GVDx57NY318E315QDOVuADGFcNtIuKLEPTU978w44Y13y2rkkDaZffg5zdCAgh6gj8ePaxnfLX4lvxEqH4f9+MrKswjKmTHipKMCIuwHQoO8EO0xJAVDK2dZvRsAyiP2nyW62BLRvgAfUQ08AXAcB/oiLEczT0fvTWG6gHgE/eZNuS2ujAgSjnd9DwVT83HMXly4vHLUwzmkaEDfOQvQ5Zm45lHKwAn+rwSO8FCIVYBukJNr5+4qXGVK/AG45G+tGt/DNAroH3/8zcJk5rjIk2nuHKbT1crJt6SZqfUbN6EWbvHfqiHDcazEkpv19NrQeYsVU36bRsIPno+9f5f2s19cg046c1kJpKLdcglVpW1s24ioRGbgVbd3XyDShCu9ZM6ZA/oMtcX/x+VhL9gN0qO0T0tcKSwuA+u7vnxRIAieLPwHiI3mq/etfdfEOEsYq1JxXlsH1Tuq5FnUhSczXR+5fPSRWaIct8HIqVSdfMGqQL+PQp58IT3Q3wGYcp/m49idS9qaPEhQ+DlOJIw/zp0iEdIeawl9tWUuq0/lrSAWBJbNQQxB8SfSmYVbU9h
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f424c805-a8c5-4c34-7f32-08dd4efcb7e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 02:42:27.9549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SB1g8ZSnQinEjf4Z40uF3HL3zF+5m5p8huKxaHr4KGQrceEvFdmTiKw5aR2SldfuXoUY4HhFtq0ywolo/NbgWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8101

T24gV2VkIEZlYiAxMiwgMjAyNSBhdCAxMTowNSBQTSBKU1QsIEpvaGFubmVzIFRodW1zaGlybiB3
cm90ZToNCj4gRnJvbTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2Rj
LmNvbT4NCj4NCj4gSWYgQlRSRlNfRlNfTkVFRF9aT05FX0ZJTklTSCBpcyBhbHJlYWR5IHNldCBm
b3IgdGhlIHdob2xlIGZpbGVzeXN0ZW0sIGV4aXQNCj4gZWFybHkgaW4gYnRyZnNfY2FuX2FjdGl2
YXRlX3pvbmUoKS4gVGhlcmUncyBubyBuZWVkIHRvIGNoZWNrIGlmDQo+IEJUUkZTX0ZTX05FRURf
Wk9ORV9GSU5JU0ggbmVlZHMgdG8gYmUgc2V0IGlmIGl0IGlzIGFscmVhZHkgc2V0Lg0KPg0KPiBT
aWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMu
Y29tPg0KPiAtLS0NCj4gIGZzL2J0cmZzL3pvbmVkLmMgfCAzICsrKw0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKQ0KDQpMb29rcyByZWFzb25hYmxlLg0KDQpSZXZpZXdlZC1ieTog
TmFvaGlybyBBb3RhIDxuYW9oaXJvLmFvdGFAd2RjLmNvbT4=

