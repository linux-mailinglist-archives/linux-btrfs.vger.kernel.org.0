Return-Path: <linux-btrfs+bounces-4339-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC488A81C4
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 13:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C103A1C23010
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 11:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598DE13C81D;
	Wed, 17 Apr 2024 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j49GcTsS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Qvv8MhOX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EDA13C80E
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 11:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352338; cv=fail; b=OwpKpljaDmnw2/Go3f1Cj4oGYJHdp2Ti2ptYEkXe0BbDL55CbZC/dNn3z2mOHPaQraoiE/ZOAO6q6VnotTmwJB3SJjlTIe+l69y5M80tbPpOgcQ6rqLTrm7ir3wGUUrlmobO3ep7BWsymlp4usUTsNm6k1RsaJGIZ61FErE+ii4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352338; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JoFckbWglIY60pMv7sByKnn9lh2ap/pn9Ma3EMBEHUC1emcNk1xwmABVfs+rvdjFC/BFS38XA7p0IRACSwuufQJAD7GBRWRKR0RgCLYUd2CjUzSuHcHCRgKIwoNXTinTySbgfTAbZw3cNcXTbZtfYIJDLg3wXmMviXmnHkz6+1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=j49GcTsS; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Qvv8MhOX; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713352336; x=1744888336;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=j49GcTsSd93UYw8t8VwuA8u1AOV9p2AnczCD59P44eESUwVuvIVe0x8D
   zg16Lg1G54ENYZlhmjDBJ9kGKqSgBM84W6JY/e2v3jotNC0rF/5QH1d7M
   fnxsQ9cM6xxtnvT9BrwSxm+6yZfyQC7qjhK40dTh0Ax9kXS5sznwxvpl9
   jWDhS4c2+JAs2qZVGALlhmJIhOzvDzBk3SWtEmC/fFUOWwstZN0OOq0x7
   168v3GkIwn8gYlznrwesYY6rHHEt61QJr7gk/RAV2ogv9GzDFkLcRSYJf
   2FsTKp4ztoH3lmi1itNNQi0EQ99IemWpT7OnBl8w1RY/JS5brzyKOKjgA
   w==;
X-CSE-ConnectionGUID: v8Y679arR0+oVdA22AV+DA==
X-CSE-MsgGUID: rnNWFdHwSBSCdth/p5UlQA==
X-IronPort-AV: E=Sophos;i="6.07,209,1708358400"; 
   d="scan'208";a="14214615"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2024 19:12:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QasczEEh5yquR9p/zvG2RCJWpNLOSctV68IEMUPe4+vLcwMveBe8YK3NylJCSJqJ3V1qCGol/XjNtzHsJcIA59xONmpLJVrWQ5EE/Y5YH5z4U4NKmPc3xGlzAmTjxGYVer97FHYdYun6vkHGCc4Kwl7M4Q6NI0YxZR8iRGpmb3N0rC31zsTRoKbQmq0lE0DQ+y/VPnTfvnVTHiEDWCp4EwIDuLRodgaE8zR0Zwb7v+fDPbO04gbe07mPvFda6UkakIdWEhaUaYt9ZRf0RkuxcQW53Ge7HkSiseNQP/sruZlqzF0RVlmv013Oh1xnLcsS1H0AEuqw0kZPmHvtferYfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=eI7MnqYUhDGSTFk7nDo+tXNutpzxsBbqGwOsU1mwbbrY/ktMvKY+QTy1WxM+t/ImlVUDD67dd5+AlmozZW6/XTT6MhHkKKBh4/NNRE9TN5x/yrRMHuOtHR6B44HeD+Tb4aToQeIRhfNOLCkqtRLsr5S5k3OTxx55chI7wMfft6nkE0Cb+GISvNtZFvW1DxJQ2AGPtZAF3KIo2k3dCcGPz7GtzVAYbluqYNpAWnJBHG1Qzbz5AfTk5eJ6lsxjFnJUCF1s1sWxkf060kD0VdgavskYPjoPvkBx4jF76NEs35EntNBw5Pg7npl/SHwll+ElcmaPwDcO+Y35oWr/Gk5RLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=Qvv8MhOXdN8ZyrHnf+n8TOgNeYBGTrX3fhD2vJ4ctoktvj725Pzsd3P/s/Eg/7h+lVl5O97XWM4GmLoLeLGprhDwBL6sDtSr297t5gOnqAlciLGGY2in8ibJOHP5lIUVR9xMOoIWhx1gtCMQMa6qkDUoiLdyzlM6o/7WTdV6o9M=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8453.namprd04.prod.outlook.com (2603:10b6:510:2b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 11:12:14 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 11:12:14 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 06/10] btrfs: pass the extent map tree's inode to
 try_merge_map()
Thread-Topic: [PATCH v3 06/10] btrfs: pass the extent map tree's inode to
 try_merge_map()
Thread-Index: AQHaj/81PNJ3BIbxvk+E57LLeRSkBbFsUDQA
Date: Wed, 17 Apr 2024 11:12:14 +0000
Message-ID: <9f0115c6-e0c6-4e4b-8471-2e5a9281bd03@wdc.com>
References: <cover.1713267925.git.fdmanana@suse.com>
 <7b4df753d47b4efc82769f897708ac146dfaf521.1713267925.git.fdmanana@suse.com>
In-Reply-To:
 <7b4df753d47b4efc82769f897708ac146dfaf521.1713267925.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8453:EE_
x-ms-office365-filtering-correlation-id: 88def3ca-4c56-43fc-778a-08dc5ecf3c8b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ogC1NyZkA3S4VhsqJXAHQt9yYWaNW4bsZocpuStGU3DqPlH746/tpAuMsL84rdWzvxaI2ynXEGS+EuHoU2lTYX7h+lEje14M1noxRkvoQrVlsEX6I3/iowaoOd5cDo2WK32ycYfUGepA5R+YLmpYnJbXW1gb6rmBj6NVE6pmwXQGZM/Y7oyKC13NHFgNhz9VbQ6nU3/79Sx+aCaD2SIrYEDT61HUT0PCf+jKfouAaoCY9y2yppRixp0ugDvbYczZXCiXeOaWIScJVQHzicx/0Bmpv01HLkVZE1EbYnbk6EKYMtXmc5s3P9xJVyF1S0oQpzMHBNU8b2CMRn/pPTe8vp7pitfplxBKTb5oD9TDqRH6QXto5VygAK7ScNFzmby1XPPsRVCfIzVoM5Q53+ZZMtdvuNXwaxWDuS/UCidef3M2Xn5VdQx3icowMpUxxz3BBd+/wvle71aI4c57GykTtGhDML5Q2bmaeShY2tIEJ3bUVjIZBkzPCKIoepq5Pb+TnDU5TgvwXBm+7cTuR6i3hV5zlsIewvAnwYfgC6XQwUhHoA+YzozOyDLi14kaw9lKatjQCxw3TdgJvRNyxOr1zh09w+Q7yufKd2BINY6548VtyXc0CZ9+sZKcMroKLwVSnHgPEVS7BSII2Kl6KSOXuzRck0f1dZNIvMyFkXoqOyIDEAQoFtyF9kRGL43YjJeFis1+bLzUwq9nQ9cASulQpGDz6OzP/VnXLlI0VTaOs14=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TlJ1bkw3ODBlQzVMV0wzNWUxdGMzT3ZkdXkybTRyNTBiZHlqNEg1eHNjQ0Fs?=
 =?utf-8?B?L3BDSlRQTElzTFJ5WWwvK0tJWjhGOW8ydWJEcDlRZk5rZVNhc3R5a0s3Sy9B?=
 =?utf-8?B?ek9za0FtazBnVnJSNmJhcDVGWlhTU01pamgrMEhzQ2Vha2MxT3NvQWRYclhi?=
 =?utf-8?B?d0J5SlN4dFFYcVRuUk1ORE1LL3F2U2g3aHRmQnYxSXhZczFLSTJ5V2Y1WjIy?=
 =?utf-8?B?dk5TWFFrcnVubkttNm9zSzJ1aU1lYUx1QkVEdVMzVUtnTFk5enR0WnJ1eC9j?=
 =?utf-8?B?M21XSzE3VTg1aXZpdVdLWm1GWm91MWhXS3lVUExucnFHcTk2T0c4NTNrR09t?=
 =?utf-8?B?VElsdDUzV1VDeHpGK0tCd2pZUXdaYTNERzd5bXoyamtlUlp5VUNPUGdVaGs3?=
 =?utf-8?B?ZEZSVk4vcDhZcG1wN21ubDlxVmw5em9PdkQ3VUdnY3ZmVStFN3Y5NDliUHhq?=
 =?utf-8?B?WlRLbkZiS3Joc0Jwc1ozREQ0R2N4MWUyb3ZkajMxOTdxb3hBMWhMUktGWCtD?=
 =?utf-8?B?NGhTdWYvRE5JYTM0TUZWM1d6UjNLQTFoOEs0dUVZa09UZ2ljaG1LRUptV0pK?=
 =?utf-8?B?S0ZYWW5iTGFQbWdPbzVrcGUzRkRrVWh0WWJDdzV5Z1RTVU50UVBTSkVnZ2J2?=
 =?utf-8?B?Y1Evc3VFdEI4d3hrM2c4dk9vamljYXV4enpJK0FTUXNacVBaVHF5ek9Gc2l3?=
 =?utf-8?B?NlY0WEIyb00yNjNOSXFLNVZ5cGdOKzFxWHNBNnQ4dm12ZU12eHhoRGxBcFpo?=
 =?utf-8?B?cmUrTFdiVVhWQ1J5Sk9ib002dFpXRFNBTUJaVFhIR0hMOFVDQnJYc0tuWWpm?=
 =?utf-8?B?OWxGSkJaOU9lS3VwRWlCTGNFSmdTbnpRRnBSQ1g2ZDdYQll5RFBDMjJGWW1a?=
 =?utf-8?B?YXBRMi92VFRLT0t5dW5CbExLK0h3bDVmR2F3YVNxdG5XM2s5dTF2ejV3Q0d1?=
 =?utf-8?B?dG5XVUNUdHhzT1dmUEp5c1dRcDU2WXhpYUpjYUhnMVh2ekxjSmZETHJZUFVI?=
 =?utf-8?B?aGUyTUcrbG9LdW5XblhTNEZjVVhIY2h5UXZuTlZiSGdrQzV1eG9VcGFKU1RD?=
 =?utf-8?B?ODZ5Q1cydHJNMWlkYlVOQ2s3cXRKMUd0Y3RxNFYxcDM2R2I3clVNK2k0TTJa?=
 =?utf-8?B?aVIwM1EzelNSbDREOHRZbDArRXF1UkdDQzV2akh1UlB0b1UzOU1zU2RtOWNE?=
 =?utf-8?B?UW11cjBvb3RwUzIzZkNjbVVhT1JyVDJvV3cwRHZQVXF4MVJPTTF6Q0pkRzZO?=
 =?utf-8?B?Z2xuQXdnb2xJTVFYaXNBcHhhajE2K2xHMHZhWHlQYVBRczJVQi9FZnVrcFhz?=
 =?utf-8?B?K1BCYkE5Rk5sSll3UGZoMVpEZ00rTnBSYmcwVHNaUFBMdFdVa2dGTmVNVm1M?=
 =?utf-8?B?YjFqb2tiZHViS1QxbUdXUHFhNnlyd3JvRVBRVHZVdzBXM0pGRE9DMHcvMy9N?=
 =?utf-8?B?RzBCZ1VQSlIzeE1mYU1MS0VVR3hFeGwzQlpERk9sOWlwVktkaDZCRzRrb05B?=
 =?utf-8?B?SnhXdGhRZDF4L05tQmFvV1F4bkE2cnRpT2xkNkVIRDM3YldwS0orTVVydnhi?=
 =?utf-8?B?OVJWSjhXcTFWckpqbFFzYVJ6L3hlTjRSVlIyQU5EdHZhVE9oUHBCNk9Wa3Bk?=
 =?utf-8?B?ZitIS0U0MzZIYjQ0Y2ZmT2F6V1c1VnRrVzZtZmZPNEVLdGZBL2FsM043UE1P?=
 =?utf-8?B?NzVrc0JLaFZJMzJ6eDE1MGc4eWxNVW43aW5qczdkelFYSXJ4bUxnSU40a040?=
 =?utf-8?B?QzlNYlVVSUhlQnVVU2NYVDBiTzh1eGZYdUJUNTJNYWVieXNVYWxvdnJicTk1?=
 =?utf-8?B?bjhEVXZ4YUtHdS9uVXZQMHBPeWZuak1NSHhJNGV6OHVyYXpFV3Ntb3c0d2ZT?=
 =?utf-8?B?Z1JPS3J6T2gwckJucE51MnN1VGFRZk9KOEtlcnVVUjlCanJRTU04K29Mcy9w?=
 =?utf-8?B?aGVqYlV5TWtPZVJGQXcxK0NrRElXbDVvS0RCeDBaRDY3cEJydGQ1RG1ZZk1M?=
 =?utf-8?B?SkZENHpNb2tYdkZGc0ZmcFk5RjRVVzBiNlllaHZaZDBpc05yREFhcENDOGJT?=
 =?utf-8?B?Rk4vY3lSY2RPM3AvTHdKV3MvMXAwVisrQjJybXhtbTltSHkzYitlQTBsenJK?=
 =?utf-8?B?eldxQnBWbzc0OUs1djVKYnhGdXN5R09KT3ZkQkVRd1cxbmZxWEhWdm93YmVa?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5C96F253E031C41B1CFA43ADA5A4EF3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mrIZczcumywmtX5nhXOJXp0JqXeqYn1n9TYY2CryN9lBUjZ0A4Cx6mVDd2tHeLycZABmH+tKd7B2eoHG07DxzRyzeRBHntf0sky2kHtse3rwCW0PKj2FBGqh0UQrYweKgNweS1qsZWdfp2ScfOpFY8AiQuBWfbBAGD+G+uysqf6qnREFxfW5RI7aXo/E4FRm2MUmxubM9zcYabw7jlEMpMJuFbapVNRY2crnRYB1etZZfmU0P6f77pGOfGIZMGYTI82mKlm1IL/oTd5tQ7QS9OgeB9btxb7HGN6my1lts+H3mAoBrBEzM82v99sFtsVMQSJ6PxwfZYpRds0PzYs2dSmmR7GBa9/c/1Uc84YaMtzghgcEWxSzbyCoM86xmeOQYldEa1m9JSjMGhV3f6d8IOwW8orYaiJGBdRyZANZ+C/9aq9UDpFe2HMmQ6D53Zs45RGcDDiHfgNERc5pLjvT3dIQzVv4/nHL+7BLTtPE+unZ88IKJpVQ1Sutg93bed6dJBJ3m4XyGVTYLjG5XpKEVBbdDxhv5+jD/HP2cV5ZKV9QjeZE2DP7lQ/EoQUQw8N38gKXNiUAATmEvDRIr88foYNHPAXC9JUTyiJNcKUDi5epcnc73L0m9oEt/aTFKcai
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88def3ca-4c56-43fc-778a-08dc5ecf3c8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 11:12:14.6295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tfEV8TQGcMdvOpVfmXh5FmVa2rfuY9CF7kr0ncW1BbeLkxwC8PgySxr1kwPfQrv3NCaNX5cvc8Gj21VKt7dAmdHbpLcRT8TxQmpsrPAirE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8453

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=

