Return-Path: <linux-btrfs+bounces-12375-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B98A67163
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 11:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74DAE421FEA
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 10:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8CC207DF4;
	Tue, 18 Mar 2025 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cqzSPCX0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Bq7dzATV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC5E20469A;
	Tue, 18 Mar 2025 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294108; cv=fail; b=FLeIPhsMChMtlEpA321tIx9bcY62GAJhZr1PPkiEyQ/F3fj49x33sKGZiOfVqe3bhoQ4iWucUoZOQ0hbxE4gc0yq4umlAFDiWysruiL+oSyzriInzaQ3h/rDysAu2Rv2idoA7HoVxtdcL0VGCnm8dSL6Bpih0PlP997d6IA4w+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294108; c=relaxed/simple;
	bh=DRhJv/+ulDi0fPljkh4WlZP9Q/Rh5jbc/LkD9S0kMFw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TNnnSnsDGqGJpEg8mrcHRjQxQtfPb5qo4bSp9upg491n31KGvHI17y5XWJB99NsBAy6UrTYV4mMyrwgv0FY2c8yvRg69m6qrZ3zmPhOrtR6EHWHDoef20LHPvJYEvwGxIAGQHbjO1jGfqrvn/s+lwLTb9uwHo8TQTDrTz9y4bbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cqzSPCX0; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Bq7dzATV; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742294102; x=1773830102;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DRhJv/+ulDi0fPljkh4WlZP9Q/Rh5jbc/LkD9S0kMFw=;
  b=cqzSPCX0yUZZaCoFCsQhvcsMdLL+84lo5LgRARoVzHOLVS6hlOowuWoR
   K2bzqd4MEjDh9PczqfLP1mjBANNPfqiMmEqS/c/2xzkyXGB+vceGDxBYg
   NDu3rpStC/dzxYQ7n+uGUzXS9Pj3KR29uXIXh5480N+V1OHzS12dszimf
   ZCJMsh/Mizw00FDizkK1aTImREssLIOYxhVvFs2XBNRCPft/keVIo7+8D
   PluOfahULHraEu94CSlBdRD7ETHt9iQ7bsPCni20Spn+UuWhYGu9tHh0+
   TmJT+jRxnpkcmOq2m6Y+oIikWDe1pHl539Qwh9MYqwiBRfWWRYZSFpVHK
   A==;
X-CSE-ConnectionGUID: 4wvpFj50SiGQP4cTC0+O+w==
X-CSE-MsgGUID: T7RN1pZgS6CO34/6YTkw0g==
X-IronPort-AV: E=Sophos;i="6.14,256,1736784000"; 
   d="scan'208";a="53024676"
Received: from mail-westusazlp17010003.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.3])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2025 18:35:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uABSiJF4rJR8fIlKO8UVkn76i94c6uOaE9IiG/1t69kZJEk76f1Hrh6IhdjbgceNZhbrvM45KVlADBGHBAb5bYepwjsuGkY86XvO2I/JCR9t4VHprjuCYZ3erunw+7FvvCssSik5JAfqTSQaA3VUALaAWq7xKghTuS0dRTOgpTG3XRu/qoHwDu0UMYIot0G7P4DICwOAKc2ptCbCnrT6cjaI/2DJQUlSQfcA10xTmvli6q5VsqZcGRd1J7gOqy7F12JD+GeD5Q7HWD3mDcqT/uPT8gULPvPgyFC03QtawBuDsuOrqY9s6sNHcMqbShHf3h+xRSKMLjVmUAJmGf2p0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRhJv/+ulDi0fPljkh4WlZP9Q/Rh5jbc/LkD9S0kMFw=;
 b=D1Vo+2asUCU8GWtJX8ehVz/Tm7TTdiC61CVCvhtTefDfHBAg/X2ILfQfCq7npqJij9MJ67aStcSfa53s0/xkq2vT7sQuNXuAiF4Hv63FfO8pMRy9Jnw4uDzTPRWxBRFHETZOcQ/NPYUVVewUt5ysRkNCXqKakwZWeNiXjHVj7RkJdXdon7A6m1wPMd2BtwEio3nTa88GQKcd8iXm/4wOacMSl4k16syIrTCmOE35Ud5Fifh/1bs/YHjTGxP3FpmVW+8iAiCdhCaLRCAzb4Jihk9ptP4sALJKM4wtLLy+RV1LJjER0OoSiOesSQqLId3zV7t1Nfi4Ts8TPFg/2H25ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRhJv/+ulDi0fPljkh4WlZP9Q/Rh5jbc/LkD9S0kMFw=;
 b=Bq7dzATVDdQGCp9n3sFYFSrmPRJ8qGWqFpmZS/ZEjlN8u3APjfWFlkiueNivaE+U/kLos7arEPWq/wQf/ctn7drzE/zrFGOddKky+jWc6e56vaZ6dF4dBVvdJVCvrvXnpk7ckYwcCfUfozqADEB1yUMCJklAD9NtdpJqYIYrEEg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB8472.namprd04.prod.outlook.com (2603:10b6:a03:4e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 10:35:00 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 10:35:00 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>, Johannes Thumshirn <jth@kernel.org>
CC: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Anand Jain
	<anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH] fstests: btrfs: zoned: verify RAID conversion with write
 pointer mismatch
Thread-Topic: [PATCH] fstests: btrfs: zoned: verify RAID conversion with write
 pointer mismatch
Thread-Index: AQHbl04BYPWchuIgeEmgsVMc9mwiQbN4siiAgAACB4A=
Date: Tue, 18 Mar 2025 10:35:00 +0000
Message-ID: <cf745454-beb3-42a9-a7cb-b75f223170d1@wdc.com>
References:
 <5c6dcd33d98c4d79630748381b2aa3880fd156ac.1742223870.git.jth@kernel.org>
 <CAL3q7H7aoYKhQG6V_MgvxVvNhE9mdEnEYgv3b1A10wyz0Zkr_Q@mail.gmail.com>
In-Reply-To:
 <CAL3q7H7aoYKhQG6V_MgvxVvNhE9mdEnEYgv3b1A10wyz0Zkr_Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB8472:EE_
x-ms-office365-filtering-correlation-id: e75ab40f-e0b7-4051-b2d7-08dd66088919
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UFgxQWdJb0ZGQlFXeG5tMWJaWitRK0U0UkF4UDhLSnArZW5wc3FuSTdEdXRw?=
 =?utf-8?B?a0JvTlR4akFRamZBdHN4QXNqVWtBc0dMWXRjWlN2RnVkdnZLYXNhQ0IvY3VL?=
 =?utf-8?B?MERLbG8vVWR3L3hUWVlWeFJHQjZhWmlkVGNoWUQ1NFV0Y2diMiszRU5BeFFi?=
 =?utf-8?B?VmZqUGZkeWh3NmJTZHZyQkl3WEtJdHpMUUQ2VWNkT3RFQlEySjd2dkl3RUY3?=
 =?utf-8?B?WGNjckZtSHM4ZjVFVzR3MTA1c29BajJnRXM0QTFnY3BvazVCZlhKZEpKOXd3?=
 =?utf-8?B?KzVtV3RnR2tQNkcrVGp1K1ZmUlRJTE5HU3ZrMndHRXVYTG00bFlpNTNveGJo?=
 =?utf-8?B?UU1WbVhKdExmSi9MYUNwT1poQ0tJU2x6TmFIN0QxVmhzSlRrbXRHeWdTRjZv?=
 =?utf-8?B?N3d5VFlwZ1Vvd3RmdmJ6T0d6R2ZpZll2OUNxajJCYXZSMnQ5ODk1VmJXME5h?=
 =?utf-8?B?K0ZsWE96R0FJaVZJU3lVWEVSaFF0eERnbnFmWlU5N2YvaE1xeWtreUgxdmJV?=
 =?utf-8?B?ZE9rZklLajVRa2tsK3FVdjlmTUloVE5kR214MklINW1pYTU3YVNqTHNaWm0y?=
 =?utf-8?B?Ui9ScmowdmNtcktzSXcrUDVmdUJYc1VMWGhuTmttcEY3bUdZRFZsQ2JwN0d4?=
 =?utf-8?B?YUs5aGozYmdwUjdLTGtqSWo1ZUlyWFE0a1FYamJ6UGpnVVJ3VkNnUU5sSDJ0?=
 =?utf-8?B?bTVLVXkxNTREWE5PbFYzRUlzM1RFZy9yVnJTTURCenQ2aHpJK2NGNnh2SlVT?=
 =?utf-8?B?enVSNEF6TFpueXVDeEw4M0h5b3pTWDE1ZWNRZGdKYnpPTVVvc1I4M0hCbUtJ?=
 =?utf-8?B?SERTUjBDTXg0ZEprNitUUFlxVW1Hd3VtWUNaNUw3UGpSQnlaR1JienhpMVVP?=
 =?utf-8?B?bFFvdzNSN0o1Z1g1TFpmQ1loQU1UNjZHbzdjYUcyQTIwT29HNVZ5VVgvNFR1?=
 =?utf-8?B?blhWdHBiMm1XMWhEMmFIS3VhaGRYYU1aNEJxdjVtYVcranJZbU1sUGFJcXZU?=
 =?utf-8?B?VzhsYWZJREdZaTFTemJ5VTlGanNyd0tvWE5pRHNqV2tVSjZySi9PR25adEF5?=
 =?utf-8?B?amh3Mi84QVRMMENCUWpsUnZQcnh6aWlQVjdyampoRzUwRWlLb1c1aDBZVXll?=
 =?utf-8?B?QzV0ZDNCK3NuTkhxbDFjNSs5cEZwTDV3elNPTDhHaVlyd0VsNGFXekVUYWsv?=
 =?utf-8?B?Qll1MlFSSUJ1eGVINmcxRDhwZ1hLaTIzbzJlYSs4R0tTVEk1aFFKN1Z1c3F2?=
 =?utf-8?B?WUlTQVZPNVI2aW9tam01YU5SRTE0UDdJSGE1US83RnZId21ZUE1jLzlKNDdO?=
 =?utf-8?B?WnJzZFFBY3djMlQ5a0luV1lJSHNaM1dLRmRsNkd1R3dwSURja1FrQ282ZjZj?=
 =?utf-8?B?UzZNNHFTK2NINlU2dFZRM2d4MUZ4dnpEaWRZbHBRM25rVFllQVUrNGNkK2Fp?=
 =?utf-8?B?am9CS3dKSVBERit2QzhUdDYxYTc3aGJDd2ZtUE4vclFSS3pkK1IvNStrbDA5?=
 =?utf-8?B?QmF0RGRvN2QrbUwwNkZ1b2M2a3o4QlMxZzRBTlFkT1g0UFhoYVlKdHdFc0tC?=
 =?utf-8?B?WkhXNHo4bGE4cW9mVVJqZnlEbVBIT2VtenJYeFFYQ3JMSGs5ZzFGOVVCVnph?=
 =?utf-8?B?SlgvdnN5YVRmbmVpc3BkRGZJaGZtN3kvcGJXNnd0eDczOEwzKzMyemZFZCtE?=
 =?utf-8?B?bkdiZ0w3ZkF6cjFOUnFKczJ6bzFLcFBPZHZVRlYreUFwenlHRU5Cd2FGK0pP?=
 =?utf-8?B?VkVhY3grSENOR2xEdko1VUpjRFg2L2R3Ti9yVERwNGpGV01OanBGdjdVRmdR?=
 =?utf-8?B?ZTkrREt3ajMwZVVueVFLbzhYRzJYL0RYV0w2QzJKN01IMGlIT0lUNWdvVGxm?=
 =?utf-8?B?TU5mSmpLUm1kK0g2L3Q0bXZkWjdzUy9Wc0VENHFvTC9yQmtsVnBUZmh6NWhM?=
 =?utf-8?Q?DEBSDHmirNrs7FmwYpIynSwV8R0Oj7L4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2Y2UnRxY2hsWTh5eUZZaWo3bW43ZExmajA2RGphQStsTUhUT1RCTitwa2Ru?=
 =?utf-8?B?NDM4dllTOHU3bmxlYmxkY3JXVlBHQjdGb05hWE0zbXlYUHo2WE5SM2xvOThT?=
 =?utf-8?B?S1hSbksxRjVQOHF5WGdTSHR4WUNFWGlGR1R5bEo0MHNpRXI3bGU0dGNBbG82?=
 =?utf-8?B?U1BJZERsZHAyWEM2NEMzckhHU3V1ZjZVbVNxOEpkTmJ3MXhTV3ZOQ1gvK2dR?=
 =?utf-8?B?K2lPL3dLZkZqZjQ4TzQxUU9ZNXN4c0MvT2JaQ2hpSmI3RWlqcWZPN0l6cVVo?=
 =?utf-8?B?NjVlamgyN0pjNlg3M1hPTDgrVkdYUmJoQlNKRFJFNjgxZ28va3dVYWVnSGJ5?=
 =?utf-8?B?M2xpanp0YXVaR1VSTTQ3b0hkeHl5aG5pYmV2amlQZFVYTkhSaWFza2Z6N1B0?=
 =?utf-8?B?Ui8zZGRHN2ZrV25NemFZV3pTaGNkeU1oQmQzbnZCbnRPUjlBNTZOR0NkZy9v?=
 =?utf-8?B?WTV2U1JlcFFaN0VlSHJub2JRMzgxbXZ4OTcvTjcvYlRvOWcxUloxM0IzVDlN?=
 =?utf-8?B?b0RDbUVvbUVRNE9nNXNYamxhYjJqMDBDelZNcGp1eVhPNFVNeGtvdzBDbm5x?=
 =?utf-8?B?SG9HdWFsZmM3T0JULzRxWU9nVWNBN3B6WE9oc2lXcFAxbkd4bkhTeUlEczVy?=
 =?utf-8?B?bHgyNFJXZlN1dkpBeDgvSHFMUjVaWGUydEk4dWdVeXd5Skk1bDZuVE45RU84?=
 =?utf-8?B?NERCcGo3eVkzeDB5MlB6VDloTTF4NkQzYTl6WUtQNkYwaWMxTE9OQWJmc2pw?=
 =?utf-8?B?VlJJQUd1bVhLaUVEelZESllKQkhHWmlJbHR3S250c3hFM3JXNXRBY0NXME5s?=
 =?utf-8?B?UHpxNFJCVjB5dlJNMWErZ0FUdzFNa0tydmRSaVNGaTBSSllJRTJ5VlVNM2dI?=
 =?utf-8?B?ZndhcTVzQVd2andRV3lOVWt4VWhMbG1oWUs3ODFzanhtL29YQlBRWHVrT1Y1?=
 =?utf-8?B?clZuRFpnaXpyZC95dEdta2d1MWZkL0FVT29vdXo4S2pFU2JwU2s5QlZCaEFV?=
 =?utf-8?B?aEVlMEJIR3AvcVBPVWl2Ui95dzZXZlhHTEMrQUxJWDFiSHUycUZKZWwwU0tV?=
 =?utf-8?B?N0F0bG5uYUMwanEweEYrT2NPUjVZUGZtUHRYdlR1N2RiNm1kN2lmUTZ5T3Nr?=
 =?utf-8?B?NWdvVVlwOFBlb1N6Mlh6d2c4cndhNVZsZUhqTktwU3c5QlEyWUp6dTVOS3I1?=
 =?utf-8?B?ZVU5MVQ3MEljRnZiVThYcDREWVlxMXhUL0JlQW5LRm8xMVF5aTAyQmZaS0po?=
 =?utf-8?B?Skh0cXJ1U3JBMkx1R05LekxadmFqUDM1S3FEd0hXWHBUdVBJRWxMWU9OYzI0?=
 =?utf-8?B?aERyQ2lLN2FPOUtQSTZkNENWTDNhNjViaGR2NVhSdVp4YkU0MVQzOFVCVmpw?=
 =?utf-8?B?NFI3TFpZMVJUejhSSjQ0Q0JWczRKS3drUElrMlltaGhKRS9vYW9HcDVpRVV4?=
 =?utf-8?B?WENhbTNvWE8yNHJJMnVjV3VPREoycDVqaCswNXBYdWdrT1dBcDRwVU9FekZj?=
 =?utf-8?B?emJBWFJnSnlvQ3JNN3U5VVRaaks0VERCWXJpVHpmOUh4TmNXd24zS0ZDRitO?=
 =?utf-8?B?aWZFRVNLRDdURm5QZ21hKzF5ZDNsaXo4KzNDWklndVVySWtVanV5a3Q4MGxQ?=
 =?utf-8?B?QWVxaGRxOENtbldhbSs2WXZJNmlCTkZKRDVRMmFvVkRyS21PREdnaVRPNkVW?=
 =?utf-8?B?WlFDemx1T3VJcG9tb2QzYjZ6SFpIbkMxN3VXSkVLRzFoVTBhZ0VYbHlzQVlx?=
 =?utf-8?B?VWtDUm5QVGFZOTQ3Unk4cWx2N0NoNHZ5b2FsMFQ4bVVoK2hZZlFBdU1MbzRa?=
 =?utf-8?B?Zmd6OGFyR3BLN0JnaXhMcWdVcXBjc1JydmVONk1MTDZMd243UDU0czJQa1NH?=
 =?utf-8?B?SGVYdUwyTGR5K2E1cjl4Q2FQaEs0Y0plWHgzbTU5NUZOdExPeGxteFhKUFM0?=
 =?utf-8?B?aUxBZWRqWUxXV0U0aUt2cG1nZVdwUFUzcUVGWnJZVWNtUDlrL3VJazBJeXlr?=
 =?utf-8?B?UmUyUkFLZ3RSYml0L3hUWnRjUm81YnNYSlBxM2tsVEt5OEg1eER5WUNGYTZL?=
 =?utf-8?B?UTgxRFhSanhSTVFuTlJQRUZpTkF3Sm9MTHNxTzlxWU02eXV4RFA0VHo4T0Ru?=
 =?utf-8?B?Si9idDl0dURiTHhhSHVxQmhRbHRjQTlMUStMU0FKSEdWdkVMaGFhczljN2k0?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8EBC623C0887A46A31ACF0E358B3272@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KKgYUremO7RDo0zCXcay41Y9bp0i/al1r23MPkKWJDtesKQKomrFfBjEX7Qhk5xaQLpN+kUYXA1IBizsOTNY1tXCAoeuc6OaayrORX3JIfE+9q0t1mP+7aDR0iC+tW4CGmQp52ofakz7NLxaRNmGpPnGp0b76E9rTYnysHbuijBOXLOctx3KqT886Jk/ikSNoavpsSyfZpCIlfSSrnOtuV/Bgc+Wea1Ox2Ee/TsCEG+z9ay7unrss+3DnwPpJvdrj/wKsKQi/YIualqlhCcCRl9b3AS7ZtK6uUeB9x8WXzgkwlThYjFAEngSQvHgXS4aB6pEAROhDWB4kFWM87UIWLYt7JSJIMN9K8Yhy55xG+CXfP59eliFUQOfA2fQit/RdUdHU6W+eZDeYrYVIXIJEAfWMtlht6t6IeR6P7oupc/HZSA0BFr/pXAM+zFIrVXtYCQbAWsID23u+oevERuph3kh+GHAROEKIhB9Sfz22JCU0PGsXJ6pg4iAyn4DYg9ibEEBIAABBWG/1fBZoAPcLObxwwyTqUPMIstVGKRJYZC6u2qZjONXT5/6MvVLTC7hGcDEgO8bHnDBDw7Op1+/Z1BMRGM5j1aGzxsIktYWfgzdQOgARnwzlaAFGK0fh3Oc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e75ab40f-e0b7-4051-b2d7-08dd66088919
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 10:35:00.1914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZcSCT7KfAQ2jo+n8rz8higVboFcDYRiGTJRWFykTmeS3k7wvn20BJ43SHcWjGLe1yoc/EDV5DmLsJpxdUC1biDnsk9kT5ZUhOWzr0AADUus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8472

T24gMTguMDMuMjUgMTE6MjgsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+IE9uIE1vbiwgTWFyIDE3
LCAyMDI1IGF0IDM6MDXigK9QTSBKb2hhbm5lcyBUaHVtc2hpcm4gPGp0aEBrZXJuZWwub3JnPiB3
cm90ZToNCj4+DQo+PiBGcm9tOiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGly
bkB3ZGMuY29tPg0KPj4NCj4+IFJlY2VudGx5IHdlIGhhZCBhIGJ1ZyByZXBvcnQgYWJvdXQgYSBr
ZXJuZWwgY3Jhc2ggdGhhdCBoYXBwZW5lZCB3aGVuIHRoZQ0KPj4gdXNlciB3YXMgY29udmVydGlu
ZyBhIGZpbGVzeXN0ZW0gdG8gdXNlIFJBSUQxIGZvciBtZXRhZGF0YSwgYnV0IGZvciBzb21lDQo+
PiByZWFzb24gdGhlIGRldmljZSdzIHdyaXRlIHBvaW50ZXJzIGdvdCBvdXQgb2Ygc3luYy4NCj4+
DQo+PiBUZXN0IHRoaXMgc2NlbmFyaW8gYnkgbWFudWFsbHkgaW5qZWN0aW5nIGRlLXN5bmNocm9u
aXplZCB3cml0ZSBwb2ludGVyDQo+PiBwb3NpdGlvbnMgYW5kIHRoZW4gcnVubmluZyBjb252ZXJz
aW9uIHRvIGEgbWV0YWRhdGEgUkFJRDEgZmlsZXN5c3RlbS4NCj4+DQo+PiBJbiB0aGUgdGVzdGNh
c2UgYWxzbyByZXBhaXIgdGhlIGJyb2tlbiBmaWxlc3lzdGVtIGFuZCBjaGVjayBpZiBib3RoIHN5
c3RlbQ0KPj4gYW5kIG1ldGFkYXRhIGJsb2NrIGdyb3VwcyBhcmUgYmFjayB0byB0aGUgZGVmYXVs
dCAnRFVQJyBwcm9maWxlDQo+PiBhZnRlcndhcmRzLg0KPj4NCj4+IExpbms6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xpbnV4LWJ0cmZzL0NBQl9iNHNCaERlM3RzY3o9ZHVWeWhjOWhORStndT1C
OENyZ0xPMTUydU15YW5SOEJFQUBtYWlsLmdtYWlsLmNvbS8NCj4+IFNpZ25lZC1vZmYtYnk6IEpv
aGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+PiAtLS0NCj4+
ICAgdGVzdHMvYnRyZnMvMzI5ICAgICB8IDYxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPj4gICB0ZXN0cy9idHJmcy8zMjkub3V0IHwgIDMgKysrDQo+PiAg
IDIgZmlsZXMgY2hhbmdlZCwgNjQgaW5zZXJ0aW9ucygrKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA3
NTUgdGVzdHMvYnRyZnMvMzI5DQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9idHJmcy8z
Mjkub3V0DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2J0cmZzLzMyOSBiL3Rlc3RzL2J0cmZz
LzMyOQ0KPj4gbmV3IGZpbGUgbW9kZSAxMDA3NTUNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uNDQx
YmUxMzNlMjMwDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi90ZXN0cy9idHJmcy8zMjkNCj4+
IEBAIC0wLDAgKzEsNjEgQEANCj4+ICsjISAvYmluL2Jhc2gNCj4+ICsjIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBHUEwtMi4wDQo+PiArIyBDb3B5cmlnaHQgKGMpIDIwMjUgV2VzdGVybiBEaWdp
dGFsIENvcnBvcmF0aW9uLiAgQWxsIFJpZ2h0cyBSZXNlcnZlZC4NCj4+ICsjDQo+PiArIyBGUyBR
QSBUZXN0IDMyOQ0KPj4gKyMNCj4+ICsjIHdoYXQgYW0gSSBoZXJlIGZvcj8NCj4gDQo+IE1pc3Np
bmcgZGVzY3JpcHRpb24gaGVyZS4NCg0KDQpPb3BzLg0KDQo+IA0KPj4gKyMNCj4+ICsuIC4vY29t
bW9uL3ByZWFtYmxlDQo+PiArX2JlZ2luX2ZzdGVzdCB6b25lIHF1aWNrIHZvbHVtZQ0KPj4gKw0K
Pj4gKy4gLi9jb21tb24vZmlsdGVyDQo+PiArDQo+PiArX2ZpeGVkX2J5X2tlcm5lbF9jb21taXQg
WFhYWFhYWFhYWFhYIFwNCj4+ICsgICAgICAgImJ0cmZzOiB6b25lZDogcmV0dXJuIEVJTyBvbiBS
QUlEMSBibG9jayBncm91cCB3cml0ZSBwb2ludGVyIG1pc21hdGNoIg0KPj4gKw0KPj4gK19yZXF1
aXJlX3NjcmF0Y2hfZGV2X3Bvb2wgMg0KPj4gK2RlY2xhcmUgLWEgZGV2cz0iKCAkU0NSQVRDSF9E
RVZfUE9PTCApIg0KPj4gK19yZXF1aXJlX3pvbmVkX2RldmljZSAke2RldnNbMF19DQo+PiArX3Jl
cXVpcmVfem9uZWRfZGV2aWNlICR7ZGV2c1sxXX0NCj4+ICtfcmVxdWlyZV9jb21tYW5kICIkQkxL
Wk9ORV9QUk9HIiBibGt6b25lDQo+PiArDQo+PiArX3NjcmF0Y2hfbWtmcyA+PiAkc2VxcmVzLmZ1
bGwgMj4mMQ0KPiANCj4gfHwgX2ZhaWwgIm1rZnMgZmFpbGVkIg0KPiANCj4gVGhhdCdzIHdoYXQg
d2UgZG8gbm93YWRheXMuDQo+IA0KPj4gK19zY3JhdGNoX21vdW50DQo+PiArDQo+PiArIyBXcml0
ZSBzb21lIGRhdGEgdG8gdGhlIEZTIHRvIGRpcnR5IGl0DQo+PiArZGQgaWY9L2Rldi96ZXJvIG9m
PSRTQ1JBVENIX01OVC90ZXN0IGJzPTEyOGsgY291bnQ9MTAyNCA+PiAkc2VxcmVzLmZ1bGwgMj4m
MQ0KPiANCj4gSXMgdGhlcmUgYW55IHJlYXNvbiB0byB1c2UgZGQ/DQo+IA0KPiBBIHNpbXBsZToN
Cj4gDQo+ICRYRlNfSU9fUFJPRyAtZiAicHdyaXRlIDAgMTI4TSIgJFNDUkFUQ0hfTU5UL3Rlc3QN
Cj4gDQo+IHdvdWxkIGRvIGl0IGFuZCBpdCdzIGVhc2llciB0byByZWFkIChkb24ndCBoYXZlIHRv
IGRvIHRoZQ0KPiBtdWx0aXBsaWNhdGlvbiB0byBmaWd1cmUgb3V0IGl0J3MgMTI4TSBvZiBkYXRh
KS4NCj4gDQo+IEFsc28sIHdoeSByZWRpcmVjdCBib3RoIHN0ZG91dCBhbmQgc3RkZXJyIHRvIHRo
ZSAuZnVsbCBmaWxlPw0KPiBXZSB3YW50IHRvIGRldGVjdCBlcnJvcnMgYW5kIGZhaWwgd2l0aCBh
IGdvbGRlbiBvdXRwdXQgbWlzbWF0Y2ggcmF0aGVyDQo+IHRoYW4gc2lsZW50bHkgaWdub3JlIGVy
cm9ycywgc28gYXQgbGVhc3QgZG9uJ3QgcmVkaXJlY3Qgc3RkZXJyLg0KPiBJIHNlZSB0aGlzIHBh
dHRlcm4gZG9uZSBldmVyeXdoZXJlIGluIHRoZSB0ZXN0IGNhc2UsIGVmZmVjdGl2ZWx5DQo+IGln
bm9yaW5nIGVycm9ycy4NCg0KUmlnaHQsIHhmc19pbyB3aWxsIGJlIGEgbG90IGVhc2llci4NCg0K
PiANCj4gDQo+PiArDQo+PiArIyBBZGQgZGV2aWNlIHR3byB0byB0aGUgRlMNCj4+ICskQlRSRlNf
VVRJTF9QUk9HIGRldmljZSBhZGQgJHtkZXZzWzFdfSAkU0NSQVRDSF9NTlQgPj4gJHNlcXJlcy5m
dWxsIDI+JjENCj4gDQo+IFNhbWUgaGVyZS4NCj4gDQo+PiArDQo+PiArIyBNb3ZlIHdyaXRlIHBv
aW50ZXJzIG9mIGFsbCBlbXB0eSB6b25lcyBieSA0ayB0byBzaW11bGF0ZSB3cml0ZSBwb2ludGVy
DQo+PiArIyBtaXNtYXRjaC4NCj4+ICsjICdibGt6b25lIHJlcG9ydCcgcmVwb3J0cyB0aGUgem9u
ZSBudW1iZXJzIGluIHNlY3RvcnMgc28gd2UgbmVlZCB0byBjb252ZXJ0DQo+PiArIyBpdCB0byBi
eXRlcyBmaXJzdC4gQWZ0ZXJ3YXJkcyB3ZSBuZWVkIHRvIGNvbnZlcnQgaXQgdG8gNGsgYmxvY2tz
IGZvciBkZC4NCj4+ICt6b25lcz0kKCRCTEtaT05FX1BST0cgcmVwb3J0ICR7ZGV2c1sxXX0gfCAk
QVdLX1BST0cgJy9lbS8geyBwcmludCAkMiB9JyB8XA0KPj4gKyAgICAgICBzZWQgJ3MvLC8vJykN
Cj4+ICtmb3Igem9uZSBpbiAkem9uZXM7DQo+PiArZG8NCj4+ICsgICAgICAgem9uZT0kKCgkem9u
ZSAvIDgpKQ0KPj4gKyAgICAgICBkZCBpZj0vZGV2L3plcm8gb2Y9JHtkZXZzWzFdfSBzZWVrPSR6
b25lIGJzPTRrIG9mbGFnPWRpcmVjdCBcDQo+PiArICAgICAgICAgICAgICAgY291bnQ9MSA+PiAk
c2VxcmVzLmZ1bGwgMj4mMQ0KPiANCj4gU2FtZSBoZXJlLg0KPiANCj4gJFhGU19JT19QUk9HIGNh
biBhbHNvIGJlIHVzZWQuDQo+IEFuZCBzaW5jZSB0aGlzIGlzIHVzaW5nIG9kaXJlY3QsIHdlIHNo
b3VsZCBoYXZlIGEgX3JlcXVpcmVfb2RpcmVjdCBhYm92ZS4NCg0KVGhlIE9fRElSRUNUIGlzIGZv
ciB0aGUgYmxvY2sgZGV2aWNlIGZpbGUsIG5vdCB0aGUgdW5kZXJseWluZyBmaWxlc3lzdGVtIA0K
YW5kIGl0IGlzIHVzZWQgdGhlIGluamVjdCB6b25lIHdyaXRlIHBvaW50ZXIgbWlzbWF0Y2hlcyBi
eSBieXBhc3NpbmcgdGhlIEZTLg0KDQpTbyB3aGlsZSBJIGNhbiBhZGQgX3JlcXVpcmVfb2RpcmVj
dCwgaXQgZG9lc24ndCByZWFsbHkgbWF0dGVyIGZvciB0aGlzIGNhc2UuDQoNCj4gDQo+IA0KPj4g
K2RvbmUNCj4+ICsNCj4+ICsjIGV4cGVjdGVkIHRvIGZhaWwNCj4+ICskQlRSRlNfVVRJTF9QUk9H
IGJhbGFuY2Ugc3RhcnQgLW1jb252ZXJ0PXJhaWQxICRTQ1JBVENIX01OVCBcDQo+PiArICAgICAg
ID4+ICRzZXFyZXMuZnVsbCAyPiYxDQo+IA0KPiBFeHBlY3RlZCB0byBmYWlsLCBidXQgdGhlIHRl
c3QgaXMgbm90IGNoZWNraW5nIGlmIGl0IGZhaWxzIGF0IGFsbCAtIGlmDQo+IGl0IGRvZXNuJ3Qg
ZmFpbCBpdCBkb2Vzbid0IGRldGVjdCBpdCBhbGwuDQo+IFNvIGRvbid0IHJlZGlyZWN0IHN0ZGVy
ciBhbmQgaW5jbHVkZSBzdGRlcnIgb3V0cHV0IGluIHRoZSBnb2xkZW4gb3V0cHV0IGZpbGUuDQo+
IA0KPj4gKw0KPj4gK19zY3JhdGNoX3VubW91bnQNCj4+ICsNCj4+ICskTU9VTlRfUFJPRyAtdCBi
dHJmcyAtb2RlZ3JhZGVkICR7ZGV2c1swXX0gJFNDUkFUQ0hfTU5UDQo+PiArDQo+PiArJEJUUkZT
X1VUSUxfUFJPRyBkZXZpY2UgcmVtb3ZlIC0tZm9yY2UgbWlzc2luZyAkU0NSQVRDSF9NTlQgPj4g
JHNlcXJlcy5mdWxsIDI+JjENCj4+ICskQlRSRlNfVVRJTF9QUk9HIGJhbGFuY2Ugc3RhcnQgLS1m
dWxsLWJhbGFuY2UgJFNDUkFUQ0hfTU5UID4+ICRzZXFyZXMuZnVsbCAyPiYxDQo+IA0KPiBTYW1l
IGhlcmUsIGlnbm9yaW5nIGZhaWx1cmVzLg0KPiANCj4+ICsNCj4+ICsjIENoZWNrIHRoYXQgYm90
aCBTeXN0ZW0gYW5kIE1ldGFkYXRhIGFyZSBiYWNrIHRvIHRoZSBEVVAgcHJvZmlsZQ0KPj4gKyRC
VFJGU19VVElMX1BST0cgZmlsZXN5c3RlbSBkZiAvbW50L3NjcmF0Y2gvIHxcDQo+IA0KPiBQbGVh
c2UgcmVwbGFjZSAvbW50L3NjcmF0Y2gvIHdpdGggJFNDUkFUQ0hfTU5ULCBvdGhlcndpc2UgdGhl
IHRlc3QNCj4gd2lsbCBub3Qgd29yayBvbiBzZXR1cHMgd2l0aCBhIGRpZmZlcmVudCBzY3JhdGNo
IG1vdW50IHBvaW50IChsaWtlDQo+IG1pbmUpLg0KDQpPb3BzIHN1cmUuDQoNCg0K

