Return-Path: <linux-btrfs+bounces-2415-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DFB856259
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 12:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0D56B37362
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 11:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03A312BE80;
	Thu, 15 Feb 2024 11:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MRxRLOpe";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KArpnflG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DB8433B1
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Feb 2024 11:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997121; cv=fail; b=FcOY2xFV9ZxS6nhYU/sU//JGapQ4EywVooNUqr6FqbI10lkJI/q0JQPX+mTQbX6PN8jAt+/IVKiIZENB7X9O99x0XUVfwDrKEWKgL7O/ZKt7g0jjlae2CUT7CJsBodt/FgB5Mt/6WjH0uJKrCT5IjaaI/EtoEUMhgOxUiebc11I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997121; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=egQACPScMMJQuVxio6bKL6HX1eK7baFGtOX35qeAntNpW0eCKzPfF313ojuPPfLsaIpJWTE7mE1sjpNcd9zh3WMAeZOzjU/HVr9g5zcbLYCAwyFjQai14212qbSAfBMKDWSVCl4MeR1xLxAJACmhDeLKek4V/RXvX2fT5LBfXt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MRxRLOpe; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=KArpnflG; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707997119; x=1739533119;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=MRxRLOpeugXibf/xNjXzRpcWQd0i9Hc4WZqWvNmQ1iAhDajFIiJcD7qM
   5T/zXqED8Va2f0qh5DJ33aEnoV9Q8p0P/e47cvYkwHuTF/mCLHr7ko98i
   VtpZXQ1dQvm8hL5QtQfta8hbyIfm7Wj79uX3Y07g6HaTzVDJ8JgRYa4ak
   +PIRS0GMSKRZ/m3koCuA9O89B9vu/Brxlz7x3BQ7SDPPvnHAm/ccsSeNF
   mowTwCbO99vaZeSgWXAh36XSMqePyDPqRn2W5MFg8Q0gaaqsUs6gKQnEH
   MUXHxyIK7uFFfDxsRiCtHtPObD26/ct1C1g30KYUVvMVftnD0ajJpJyL9
   A==;
X-CSE-ConnectionGUID: qgRqa6/UTAeeQy83QRWjCw==
X-CSE-MsgGUID: qJ2e996hQ1iCi5sFBcMahQ==
X-IronPort-AV: E=Sophos;i="6.06,161,1705334400"; 
   d="scan'208";a="9573923"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2024 19:38:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WezI9nj+Ln6h6Eirem/3kpt7cXlJL5TEO8ZgtKBBQCNRcc3TmZQRyQSBWwLH4XvRabTYuemixGM2FgPkQ3oBfpZiSqJamXUE/s1H0MCczeGPe6YjAxNQDo6ZZ4c7h2ypyv6AdcIg3lU0V5z1nsDxbvo8vrR1Mo8apiQJpxdREOuHNReELRUTEz2RRFdmXpAgpxaxj5PFvytSUOacnqVOWWapT4dHG7dBaSv7qBdu4OufG9Q3kaWQZDuefiJ4fNoQQWUMHY+HO4dStcW53oMTjGyKD1cC56lTyfn/aY/Om/8ToLe1Ek9p2n8GPbBmIgbktYi06YNIgesm6Sc0uVSlYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=JyKW/pbI/p4/9TBz0WaHwwq9fa45ybjlmpd8jNwuYwAuj4voX6GiDfP2+8ejzvupuhwOpDhX09jL18xZm0xvU4eceowh6SBAmbYJ8+9AupCIsoAvTmlxLLJDJGAt3NI/Xuj8fOC2TLLN7RAdkAXYn4jTG2CX9J4je6YVk+NGUTpk6cIQ0mqO1LeZ7HVQtNgMFMhOh7vWyAGmc9UdGOXX0Qgm6WpV0A3Na9Z12FB1bko8MFH3PVftx1/byK5DLzMq4H4dpa+q81oPQ3OFtq+K3BNenrF6F1SEeM6wz4QDO88Ni1aSQuX6D3NXUUOX7IzTutyc0BlsKRruBgpBdsaB4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=KArpnflGhq2+I5XWSNXNCtif70qk5utyuuldgBgsUm6aFDbZ6jmbJjY24ZqJyp8yHOx6kT/UZnm7J0+iDInY5SUb3R9STUvO3H9zTvr6p2KIppcErBT8AGILqo/i03/w1dseJxs7+KBUhXhR+YPCmIaX2F6yXxcP3aU+HWSkjUg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7424.namprd04.prod.outlook.com (2603:10b6:a03:29a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 11:38:31 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::73c4:a060:8f19:7b28]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::73c4:a060:8f19:7b28%6]) with mapi id 15.20.7292.026; Thu, 15 Feb 2024
 11:38:31 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: remove no longer used
 btrfs_transaction_in_commit()
Thread-Topic: [PATCH] btrfs: remove no longer used
 btrfs_transaction_in_commit()
Thread-Index: AQHaXpK1h05lbmrbyEWuCwh7rYuRpLELSdiA
Date: Thu, 15 Feb 2024 11:38:31 +0000
Message-ID: <04b65bc7-12c5-4111-876f-ebb303e2b679@wdc.com>
References:
 <00e9779bc56f516852e1488cc89403ca2d7d3a7c.1707838285.git.fdmanana@suse.com>
In-Reply-To:
 <00e9779bc56f516852e1488cc89403ca2d7d3a7c.1707838285.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7424:EE_
x-ms-office365-filtering-correlation-id: b5648400-79a1-43b3-137e-08dc2e1aa2c0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IY+eGhPdiqrq8DE6VL53CLvfTRj4mG9nmcVoFnRuvOQx6Nkys+Pa/cpJCyjlpcVRRDy1jbZQW9WK+1thOr8UHor0vSjG/ujT/4HJK9WnQVnTdKD5EFVDS7hhPh9x+RgTWWTCwSPIfbWmNcGtwIhNEpVJUD+WOnNOPuvPGmLFKws9/yI2v41t4jPQK20IY/ifOEtu4FdSBKDEhlnnnnrbQPcNM7cCdFSR4CVD6iO1mWnGvMvxEECqUEAuUYI0q7t8yWuVWPN95VQa7j9XcmPqrFqU7TfEA9BrTVVyvZuYBxoHv+wnHiPSyN0d/KW02fw2LN8RCiXCMCf5VryUUgYCZozHv/f947NfAlBL5n8J8ugfX8qiE3b2JspT2KiGocLQqXJpi1Ql5S+bpX9wGiaQ+cPQj9zEnSO3wsaMg2yF82MnZtdY2uD4jloOUqygPV6cJlHyV3NsAygiBaVoJb9zTeG17z1PZPt1LmKoHvH0hCUdzuEWilNpWCIH7FUOQ2TY7+mbZmQEuL2S0V/43k4Lc6Or5fzqHMxkWqlpsSKVCX+5ZmPXKosbnOqUCUXz7IHqv8v3pQb9f03+dSr6nQ5SZ1PNpJ6D579hlWvbJVr5jqiV32S/dG95ri1NQFMFgLC3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(71200400001)(6486002)(4270600006)(6512007)(478600001)(41300700001)(19618925003)(8676002)(8936002)(2906002)(5660300002)(6506007)(66556008)(64756008)(110136005)(66476007)(76116006)(66946007)(66446008)(316002)(2616005)(31696002)(122000001)(86362001)(82960400001)(26005)(558084003)(38070700009)(38100700002)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RVc0WjJyRTJwclRNUFF5Y292K2FiaWxLR2Z3cHpqeTE0OE15MGhSRklLcm8r?=
 =?utf-8?B?OXkwbTdNOWRDWGRoR1d3eGhnc25RZENudzMrZzhnQStqZ3RWQWpXNG5Ramt6?=
 =?utf-8?B?ZnJSM2VJOEpYUVFQcmxhQlhVWEpkNk5PY2xHQ3NsNlVnWGtlSHhWZUt3NFYz?=
 =?utf-8?B?Wm1NcGpZbjFORXp0cmJFV0lTeWFrNjVXTjNNQUV5L0l0WVg5NnVaVGd0YWJP?=
 =?utf-8?B?M1Q4TVQycTR4SUF3dnRxZlp1RktnMnd1OWRHcDV3RDhpVXExRnhHazN1U3A1?=
 =?utf-8?B?eDJNVmRRcFp5dTZ3S0FIZ3VRVTQwRys2cWtxTzhkbVdkQkpPdkd0MmUvV3V4?=
 =?utf-8?B?ZFpMT2tUU3c3RkRvN1l3dEhXVE9xM3BXQlcvbmlsaUhXQ0J2RVh1allYdVBK?=
 =?utf-8?B?M2VZMUtZZUpYWnZtNFAvRTRyMHhhdG1WdXFEcnZJcFExRlBZeEhFNittdFpU?=
 =?utf-8?B?N1MyaXM3TC9PSk4zVUl0Nmg5a1NMZjUxalpwSWVQSnVHb0Q3UjlDenhwYUNZ?=
 =?utf-8?B?TXArTEdFYXVjV0p2eVRvZnBiQVdXQStrb1BHdFdBcEtpblpxL3V1QnJleXNO?=
 =?utf-8?B?U3k5TDVJaFI1M083Z1hhaEF2aWZHOFpBU3ZhNkFpTjJjMzJyMDkva0VXRWZJ?=
 =?utf-8?B?TUlZUTRIVHYvSER2N1hoME1hMXJpUURxNEE2S3o1b0gwMkg3TkhRbUcrTUp3?=
 =?utf-8?B?T3Y5V3pDajBMS1lodTZrbTl0U2wzQmZSVUZ4UzNYOVh1dTVmV0NUMjFMNEw1?=
 =?utf-8?B?Z2ZTSXdMbWxwTFE5b1VCdFdtOTJnWVJrUnNrdVBPWXphWk9UQnBaaU1KMVRl?=
 =?utf-8?B?ZnNWa1BzdlRpZlgrTHFGREZoaUVsTkppaTdNWWpTMkpieHRzWTQvRHUwNTR4?=
 =?utf-8?B?NU1QaWgvZjQza0l4ZUNHb1JvelhkSzViM3FJNDFtUmFWZDFUK0VmRUUvSDR3?=
 =?utf-8?B?NWxyS0ZxY0hibDZqcXJ3czJBQ2xQOWFOWlBPTzZvWUI4bnNkeG0xc3cvOTVO?=
 =?utf-8?B?aXc3K0ZjZ3VKeTJLN0w2ZDlQQnBiN3RQZkNHb2lVLzIwb0M2b1dYU0NiOGhW?=
 =?utf-8?B?c2lXc3JySHE4R3p3UEk0Y1JlT0pnODUraFNaNzdMNC96Q2M2Njdacm9leGdC?=
 =?utf-8?B?aC9FWG82RlJia2krZFpBQmhlWEt6ZnVvYUJ0TmxSRTA1ZE9xaHFjYndNNTlx?=
 =?utf-8?B?eTJxdGN5UTYwb1ZnNDcyQ2lpOFp6dDlFZ2xwVndaS3M2VVhqT3dxQlhYeVla?=
 =?utf-8?B?WDArY1hBOFhWdldJbVdEZndxZHRRZ1ZwaW5PV2RjMDk3UU1JQ2FqZDVNa2Iz?=
 =?utf-8?B?MzY1SUVRdStFTWJ2eC9Ob1U0NXVGbytjQVVURkt0aStOZ0xHQVYxYmU2ckRp?=
 =?utf-8?B?bWxXVjQrSE1qRkIwZnlpVWZENmRhYmU0RWplYUIvOW00bkNnbmMxM1JRNS9v?=
 =?utf-8?B?RFQvTVZNUVA3cTgwbGMrWFlGSzRpamc1V3E5OGVJM2x4Uk5kY3JzdjhMQnJL?=
 =?utf-8?B?aDNRS2xQQTBSNWFNNk4zZHA5T25NcVRhTTd3Qnl4SHQ1bmE1aWpHNWVlNDR5?=
 =?utf-8?B?WjRSR0t3dG1GbnNGaDhRdkdMVzB4QzYrdnNMRHBEbWhvUmZ6WmpIL2dUcy8x?=
 =?utf-8?B?RlZFUXdJMTlJS3dOM1Q5dkRaUDlvT0lJYklYZG92eUNMbXhNeVBaM01Eelph?=
 =?utf-8?B?Wi9IZUhTenZyL2xoMWRWTkJIblYyMW9GSm9VNUF4N3BpRXAwZEtOUUoxaEg4?=
 =?utf-8?B?RTU5QVVZS1BvR2NJY2pPZjhxWVJDRnI2SC9RenUrOTBrY09GU25qcUFWSnA0?=
 =?utf-8?B?aHNOaW9mN1pjTWpBYVRrUlZZTkdHNVJUMnZDTGo4ZUw2OGptRURQUWpUMXd4?=
 =?utf-8?B?WWJVSk9BODRBdHdvQXVTdGNYRXE4SUpWS1UvQUdqZi8rQjAyaTJYRnNXWXN1?=
 =?utf-8?B?MlMwdjEvcWpwcTR2Tks3UzBGZTVTQmMxVUx1VFNqYURSNFhnTjdpWUQrNWVx?=
 =?utf-8?B?UHF5Y1FyS3pTQ0JpM25NWDEvV05GdGFuSXZHL2lrWEdpamY2S0Y4TjdNVjNl?=
 =?utf-8?B?NHFuNWFUZGo1UVFOMzJ4MllCME5RcGw2cGtMaXlrYnN6eXBQZnVEMnJHcDZU?=
 =?utf-8?B?ZExoaFhNV1M3cmlDQVU1Sk9JdTNzYVdMSUszakJJU2R1MjhDaGtQTFNJTkNv?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C590BBF93D5F994487C3B7D0ADBA8C1B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z4wYsXjnlanUG31wKMyR1DicUe2Df4A2iay50lgJtc3rxAx1VRuniBrU70ceFqYAzQBlmC4MNfvat2YgsF1XGkqZ6TW0vWS4R5TJrLeLiUP0NHyhf+ioKUlC9SLgvJPe3Z4tl/m6UsunSPNh6Lf5uncz+n58Gb1RAWArzjKYsLgYgpNs0lYnfu3avyE2blPBmnqfEZvrJGK0kv0bSvsILu82NvmSExZYieO01lpLmcCj319orpxJPEjUQgRbBR6YuIfy2wjveOOmpCfhSDTl8+fETF2lrgPzfTXqSHkynrJ12LHGFXEqk0odOoMaK/hfE86zhGx+xD0DavXo3+C+NPmonLJaBl7ZPIhruBjvPE+0XhydP1IPTmGQH5f3ejI9Sz+R98EOcVebWHxIymhJ7LAuRKMjn6JWGo46hf9dCZCU+R16zSmckj75W8JJrrkgdGrINEIlD3dA8JBL9szz0tW6TO97qIAs5QS65Wois1J1PffQ5oqFcRy886hMyiOiVZqKpWI2GhhqC2gPl0qqcN2CzSQMAZ8qoP7YTMD6L9uoY1jPRYF2rF7QgDWz+GN5oJ6+EEqzRz2+Zme/UTmAFfVzQwzsfY5M5KSGSb1h62CjM0blgjCB4YSrEKeyXQ+E
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5648400-79a1-43b3-137e-08dc2e1aa2c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 11:38:31.3732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oPCvf9QToRurxxFftEEh6nX2+28o6eg7884c8S2xCwxLVBKCpxIPsso7zPsotQc5iM/QNK9nHe1+CRxcvwBnpZkhcKYwln5zsnQdnmDX/U4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7424

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=

