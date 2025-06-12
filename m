Return-Path: <linux-btrfs+bounces-14625-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2B5AD6FFB
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 14:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 058A91BC559C
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 12:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9EF23C4E1;
	Thu, 12 Jun 2025 12:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qPIqmAv2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="k+KSehe9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0520122F772
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 12:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749730541; cv=fail; b=GCJC+xAvcqoM3GI95SvMy4k3vooxLVPC9nLBrHQPKydvqP6zxgcpIriuSNVfwajORTaZdxVVVSTUVGjUdEkC21rLGHVAjpTC0Mlh0nDgbrVpeFRmy3HQvCKrkwqBjLk8nF+9hcBWin+58pfTDl5h0YbFSKfcb1P6wGYgQls+6Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749730541; c=relaxed/simple;
	bh=tOkIUpsJIrMtT9rME3ZsHOigLEfQx2medvLdFBQZqQQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RAhmDZVD63qGOCSlnxQnQcWy9NqdzM2ZUcj+QUuTtMqEJfojJhOFCYRbzOH5YIQeadkoQhRXJl6JSpXvitEnuj+6CDneIZAnTE5kiStcQkYbkMofvQBdfcfTfeyKMXeNgoYSD/WunyULuyHpez0P0vtxZWK7dc24fH5hC27cYwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qPIqmAv2; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=k+KSehe9; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749730540; x=1781266540;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tOkIUpsJIrMtT9rME3ZsHOigLEfQx2medvLdFBQZqQQ=;
  b=qPIqmAv2rX4LIlG+9bcnj8XlDTL3RVeHnSJO9omzPhSB85KYgp5jqKSD
   Neyi/PHP2BFWvlOR524QSXYsCneych/Sb1h77r3BkcHEVD8oRpFmbmDnV
   /BRzSpMtHplZ8Vmhnih6Cj5KB437xLI4Fd35lh06kuMkLbvuNamu1veuw
   PqjTiSG+JXWNArNc0gsrpy3ERTXR+JoixR9CARcONXRlXzuIgQycTVT3H
   8GlLdwJ1kt7R4/5ZunVvxkP773I+GzZ4u+vt1E0/WVYJW+mJCIQqAI6jL
   vT9UnpTEGEeT7GFo0Unt7jAaQ1ASoPxt1gCQp6KX63hXx4jUaMHYbwBDL
   w==;
X-CSE-ConnectionGUID: wY3xmLM7TXuqbjD/kD/kvw==
X-CSE-MsgGUID: nvM4i6OhSUic/30R5+DKtQ==
X-IronPort-AV: E=Sophos;i="6.16,230,1744041600"; 
   d="scan'208";a="85190688"
Received: from mail-bn7nam10on2073.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([40.107.92.73])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2025 20:15:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbatr0ZHlEjKOtr5vV86wErit1ltY50FjwC5dfd5ZMrj2MmXzySKhZptoN6Ob3zMw2VSDoQgZdKTcmNketp9YPNwFPg3bHBQAX8Ie8EFDs00EuKmGH0OJ/0d3SLNR7OU+yLeA37q2PSZ3XnaqkAQBIIXPvF/IJAi9Y26WG3U8d2sOwYglvdhlvWWCCyXnxxce6ZxPppdA13MkrSJFhfma1a/t/zU7XU/EEG/HfcX0mptLKedYEQ+Cdnp6yfA4A/KYSbzxVQKN0vTIp3+wgytpYwDUq1Mhs+sobkM0c9NtUjzOfl7OUGXrr6DGKiqn0NSgbep2NLazlfig14B3TH/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOkIUpsJIrMtT9rME3ZsHOigLEfQx2medvLdFBQZqQQ=;
 b=jXwt/N+JmaeijwXaEtWzIdIlFRKXLC7MqvilnxS7vcXRDZUgPaQVBPvEWkcc/Vkf7DTjHiic4+gJkiFpe6b+D6nMnDLumLr9tW/s+s+QTK1b6xeIQ6P092FTUzEQhlefljjqEq9Z16JnJMrYA8xUiUSk7OThSGVc1uaCmdaSSxkHBGqpDlb4xzNIxs3ondIFSOav3bZzwmYwXX3DRJ1pREvGpE6vT6dS22dYyOrsNajsabCLLycO2kXhKPAgwqV23UFFFy8AljQLqJUgQkd6NmKjZWwxgFXVHMICZ9XIc4OwuXGUniizcolagDzqCct88cQnbWqKGFcLaAilxSvecQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOkIUpsJIrMtT9rME3ZsHOigLEfQx2medvLdFBQZqQQ=;
 b=k+KSehe9/H8YIP2Idd2wPUmhbdaXtBEqCZ4AHSKkOai+m2+//tNGQYFKUHvWT/Yn8M6voocDq3rzpp3e6bxy3YPWyexIiujR/cuuVdi2boLTk0xleP3NBDaCiFOtSmX4XSQfidZgdpdGD8X/jh5blGVDrmQjYNOy403yVxJSDEw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DS0PR04MB8742.namprd04.prod.outlook.com (2603:10b6:8:12a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 12:15:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8792.039; Thu, 12 Jun 2025
 12:15:27 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, Johannes Thumshirn <jth@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC: Boris Burkov <boris@bur.io>, hch <hch@lst.de>, David Sterba
	<dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 0/5] btrfs: use the super_block as bdev holder
Thread-Topic: [PATCH v2 0/5] btrfs: use the super_block as bdev holder
Thread-Index: AQHb2rgQj+GAUrOINUqOaqTVAHdL07P+f/yAgAAEx4CAAO0pgA==
Date: Thu, 12 Jun 2025 12:15:27 +0000
Message-ID: <1618ecb3-2bc5-4c48-89d5-ba1c9ec788b3@wdc.com>
References: <20250611100303.110311-1-jth@kernel.org>
 <9093e0d6-d33e-4c4b-814f-9134d568f395@suse.com>
 <69982e5e-96d3-4e60-891c-ade4474253cc@suse.com>
In-Reply-To: <69982e5e-96d3-4e60-891c-ade4474253cc@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DS0PR04MB8742:EE_
x-ms-office365-filtering-correlation-id: 54af28ae-1d16-4155-ab1f-08dda9aad15c
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dGYvUlhIaUhFc2ZwK3BoZnJVR1R6bzF3UHUzQkI0Vk9sWDJLZVJ4VHBXSEZj?=
 =?utf-8?B?SHpjQitvODVVajR2K3o1QXFIQW5vdWxTQlN0dy9QQWp0QUxHVi8wRzAvU1px?=
 =?utf-8?B?emUybFRhbklGMFlhYWtpQ29va3Ira1J3bm5JZ0FjZGlYM2VsSVlpdHdaTUNu?=
 =?utf-8?B?UGgwUW5Wa0pDZm9CUjNnU2RHT25WQlBlVUVET1BqSmt2YUJ2aHBsMGtxSDA2?=
 =?utf-8?B?WWNrY0h1dmU4ZW9QYlFud2VNdzZZa2ZicWxxQmhpK2tMQ0VNRlhsTXdjSFlL?=
 =?utf-8?B?Y2Z3MGtiVCtieXJLZzRlWjFiK0tkdnhOemVTRjlXK3hpQkJNTDlHU0JXVUtB?=
 =?utf-8?B?VktGbHFoTitqazFBY1Iyd29tWk9NaHJuQ2RyNzJrckFuN1R5R0E5K2JOZnlN?=
 =?utf-8?B?c2FaNUQxL0pta3Q2dUJvN0gwSiszOWw0STUyWDdNSEhwZHBQQ1lNbmVNeG5Z?=
 =?utf-8?B?czNGdjlmd044dmcrQjJKY2VXNG9Ha3g2d1RJREkwUGRxeWZ6Wjdma21VNlFY?=
 =?utf-8?B?Y0dwS0xoNElOZGVET1czTTdPTGw0ODdUVU16aWJrUzAxVkxFQzlPZXFIYjlI?=
 =?utf-8?B?NWZsWjVORGc1VDlBL0RrUTNHeTFmSzd2Nm1wNjJTL1JmWVR5anBqNVJxOE9i?=
 =?utf-8?B?WnZVWVF2cjlQV21iQTQyWCt4UmllRlpYZ2orRDZjVVE4VGdlV1djK3hlYVY2?=
 =?utf-8?B?RWdVZFhYZ3hqUkpBekdHNUhja3Njd0JwcEtCdXUveXJHQkRjWWU5ZUthbkJt?=
 =?utf-8?B?NlM5M1pJYUFzRWFvUXdXS2FlV21KV1E4ZkE3TGNsM29aRFliaU05UHROWFEw?=
 =?utf-8?B?bno1Y0p3ak4wcEZSQndkQ09LZllaV1RIRUFlOGs1NmhoN213SlRiZGlzSlZh?=
 =?utf-8?B?TUNuQzNINEMvKzNuWjdKUFpuTVpyNi9xeGI3YUpKVk9vNHF6b2FQVDZES3JG?=
 =?utf-8?B?NWErL2pwczYzL2NGdGVPL0FPbnEvdFdJOTJTV3E4RCtyK1I5dmhaS0FrbXdh?=
 =?utf-8?B?dk43a29laXRRMkMxRGFoakxFNjAyOFd0ZEF3Y3d1NVRKVjJjb2NobkJiMjF6?=
 =?utf-8?B?Y0FlU2w5RWxFNUl1Z2w5allmNERwRzVmb2g4TGVqMlNkSVJFNWhZWE1GcDlq?=
 =?utf-8?B?TkpSRm9jdmU5WnZGb3N6VlI2VW5hWGxSQ1BaWnJSZE1aMmNUUmI5OG9PdmxJ?=
 =?utf-8?B?ZitZb09ScVc0VkN6eXl2dDd5RDNuanByV0U5SjMrUDAzbzJBUFQwM0pYbDFL?=
 =?utf-8?B?QTJ6aERNVTRKU3c2ZXNIejU5ZzRCdnVBZlRlTmN1RVNPeUp6eDFGbnpFcDcv?=
 =?utf-8?B?MjlQd3ptSUxpbW9EazcyTzd6bHQ5TzZReTMzT1BSd294dkhjemN2Y2FUNHZw?=
 =?utf-8?B?WEVkcEExa09YR1lqOFRjOG8xTnBCV3RWbzlrdXhjZWJYS0R2UUttazFQcm0v?=
 =?utf-8?B?NkdRZXV5eGhqZXZWWTN3eDdqQjNyWTRaTHdTQ1lndFRZelR5VnhEdWJWZ2Zz?=
 =?utf-8?B?eE1WN3Nhc1A2d3RDYi8vVXQzWlVvRjE1ZWpmN2x6UmVzZnBMRVVzN1NtZDFm?=
 =?utf-8?B?N2t5b1o2UHZ1ZHdzRTdhUEh0V0N3eGtCTmhyMXA0aGkwdnVERlV2SzFZRnc5?=
 =?utf-8?B?cDdleXdNS0c5MW9mb1g4U0FoU2Jpc1doMGdZZWt0YkZId0FvcEhCNHZROG9I?=
 =?utf-8?B?YUFXNllJQWhkSUY2MzhhZDJKZEM0clFPTkxrUFoxSjI4S2t0a0loQVlZeGFM?=
 =?utf-8?B?T1NPdzJLWnpiNWdHMVB0N2RrNHdSMEt4MHdOcWI0RlViQlBJS3Rvd09iK2s4?=
 =?utf-8?B?Zzd6emI0ZUtiTEZITmgybGZhZlArSk5uUE03RVdyV1NXbDlCUXZPazZlWUY1?=
 =?utf-8?B?MmVpaTg4Q2p5WDZkV1U2ZFAxbVJTbzVlWUlIZGJ0eFFzQUduTWZWTVdBNytq?=
 =?utf-8?B?VG1IN2tyV1AzTUVBVWpEeHRCMGF0aDJZM0dCL0V2VFpsTVliazMxVEJBM3lU?=
 =?utf-8?B?RGZjY1d0NXFBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ams0aDh3U0tOaWdyZElxSTc0Zm9KVkpJNDRLSGpMdkdpQUlKRFg2TTVIemVS?=
 =?utf-8?B?NFZRdXNPTmdsZTR4eUgxdzFLaWhPbm5qRzE0QXV6ZEZQbmdDWVVwZ3lhUThj?=
 =?utf-8?B?Y1pobFdQUkl0VGNDamJsMHdRNVk0U2YxdFdoUHBXL2lWVmFyQ25ua1BhNHpB?=
 =?utf-8?B?V1VGZjhwUzFQRFR4VmUyTCsyQTZ3dE5aei9FaStLL2J5MU15UUxPL0drWDBq?=
 =?utf-8?B?eGc5eWwzS3B1NmNuNUxIcVNEb1M0QUF6MzBjbmJzN1lTRUdEb3lDRS93TUl1?=
 =?utf-8?B?YzFQNURzVW84UEkrVHBQSTlVNEZxYVVrb0ZJYTNjY2l6ZTcxU2FZOFJYRS9W?=
 =?utf-8?B?VjY1NGRWOXFqWVpUeFgveENLbEdxMmV2VERKQkpvcEhHdXlWcm5CY2NjbjQx?=
 =?utf-8?B?NDlva0c5UUZHbzQ0bG5BN010bE5vSVNCblhDYTE2aGNjakJ4UDhpR2MrcDNU?=
 =?utf-8?B?b3FWNnZ2bGNlME82ZG56dVJwbUErL1dBZEZzN3ZvR2Mzdm5iNGpFMHRGeEpY?=
 =?utf-8?B?aDZDWUtKQmduVlNMeEx2ZTU0Y1lMcDdoUTlwRjJVN2ZMejdIa1h4cU42VlYv?=
 =?utf-8?B?bHlIeXRUOTJSekp3ei9GaGIzUzJiNDVIcGhicmUrSzdGWnh5ODIweldneG0v?=
 =?utf-8?B?WWNrZ2pweFI0TDdGQk1SVk41UThrdDBOcHBvRWFRSG9kQ0t5UDRwYnMxYS84?=
 =?utf-8?B?djFDd29ld3B3QUpjSVRNaW1ZMHJmQXNaNDJzQ0hMVEFPTS9NVkhvVEp1cWFT?=
 =?utf-8?B?QVRNeUpGVDcyY1dNNlVDUzVRdURUZHNhc0FMVEJ4T01yUVFSTEtDOWR0aHR6?=
 =?utf-8?B?bm56cUZ6dHJ3anlIU1paaFlPUE1RVWZWT2ZKSjlSQVhhYkhzNDdlMlRQdlhG?=
 =?utf-8?B?Mml6cnhIRXBET09nZStmZDJDUlhpcTNKMm1aOUFVWnphclp2MnR4QmU4RnlD?=
 =?utf-8?B?NHErc2JJMGJnZWlDMENXMmFaMXR0ejVYTSs5VmJTMUhJZ2duSmg5TTlWekVH?=
 =?utf-8?B?QktrdVQ3Vzl4cFBBL3BBcURKUVM1Znc4OHpwOENFVi8xREZjUVdsbm9pcnhl?=
 =?utf-8?B?dnBBTWE3WGlKVkVINmgvMXZ1WmFXY3NTV3pyY29qdURVdm5lazh5WmlLcy9K?=
 =?utf-8?B?UXBRWnpESFMwUEpiN2ZkRXJKOXYvNGdwbVNQbW5oekl1ajJieTlrY1VENTNr?=
 =?utf-8?B?cmpzdUdBOFNqeStuN296dmQyMlZUWXpwVkdOR3JROUp5VkdwQjh5a2ZFbVdG?=
 =?utf-8?B?QmNtMmFSWm00YW9YRml0WFAzMSt0MTVZMHprNTFWanhuN2dQc3NyK2RRd3Uv?=
 =?utf-8?B?Q2FaS2pBM2tsTitmVHZFR0kzc05pU09KZ2x3MXdIM3gyNTRpVmZBOW5FTzRY?=
 =?utf-8?B?aS9WaElTK0J5R1hzRUJCd2ZRajFzVERuS2tQUis1c3czZFNTanQ0ajhsdUxX?=
 =?utf-8?B?b1FvR3lOMlpVazJCSlhpdG1hU0d2RWhuQjRWN1dGUEJDNHpKY01ndG5UZU43?=
 =?utf-8?B?cE1vbTA4Q0JlSkVvTWZqWW45OTB4TFR0T2RVSndYaVF5cSt0MWg4bWlGTWh2?=
 =?utf-8?B?UG1HQnVCVWNSTThrR0NZOS9sNVE2cDVsaUwvNXp5UnJvWmV4M0tPWnJjOXVS?=
 =?utf-8?B?Z3NtNHJDU3RONXRwSHViSmZsZkJ0WHBsUW96UWt4UTJHUklTTngxc3NpSDFT?=
 =?utf-8?B?NFQ0THJOYTk0eEc1d2lJTnY5U1RjOTBnQ0pIL005UzhaZ3pLQVNZUmIyOEV2?=
 =?utf-8?B?clV4OVJ3VkR2YTV1OHhQR3VndzQxblFYem5HQ0ZCZnhDN3RMNy8wb0R2MHV0?=
 =?utf-8?B?UTFFL2FQUTBhQi9qbkVBNzVneXh1STY3aGxwN2VQT2VEWnRuMm5kUXpVT0xv?=
 =?utf-8?B?VkIvdVVYaGVKRk9CeGhwY3g4ZzFaeEsxNmpuM2M5RlpGbUxYOTFHci9udlEr?=
 =?utf-8?B?SDBTY2JzaVRZSFRJRThSS2lOb2dTYUVkaEphU0grOWo4bHpmRlRLY09VeE8v?=
 =?utf-8?B?NEEzTDRya3B1U0NPQThmSjMycjl0Z1hQRTJ2SnNCbjJWVVBveTZNa3YvZmRo?=
 =?utf-8?B?Nk8rT1c4SWE5dTRWRGtpbnAzVEZ3TjhyQjV2UVBwZ3JlYlJoOExZQ3FBT0Jl?=
 =?utf-8?B?RWZ2MktsMGp6SVNMU3pVaDlhZjVTeXo2NE9xSm1SV3IrNG1tcUk2eEdLbmFB?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A82A1050AF6F29479CFFD41D13DB0905@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hOpbj/SyvuJLuRg86460ZuXdDd6kABacIY5ETshUuVczikQ2RwpQt+OO3S3AsmBlXBvyJj61gIW2C3Di5DNksjtR3jRBZRQhbMS/cVgese2QyCjot8Ga/GtAP4R/iADaAJpEY2z8NuM/lAsah8Z+car9/IbioXh7ZL6i/hIl+y4IulOSG/RUHIA0m8Xd41OmlZst1JGfeQiBfTaRr5SZJawG1Uc9wqY2mtU1/6ANMU/M0E3YAjhhPC8hX/p2Vn9Yr1yYmRw51zE+0XDjlJ9dXsb5jeDPFII/97G2/XXD7B6YlYPy85zX4j2X9OKazt19y8pS+qpOpCQkprt5tSKt3c0yW0yLyl6kOCWSoH3zjKVL3lfyLxg3olt9AL9b9PiSoWRPxoNB8lAD3TaITfuKKk58SxjAd9n0scgBwi95XE8edke6FI/KeL0xZWiWggSYTU7/rDgHhnZwLr8ERel/BtxRNWnj5aH1PDQFQdyNW9MJCNDuy9GDYFBde4TX4ec0BsDBRTPB5UzltUMaAFVK0p9VvErTp2vLpGjynvKsfaN65GpNwBPD13lzsWW3w1dSu9JzScF9bzzyb39NuTiX39n89kkpGVlxAOu2LDqv1WI4UjSdW39eqgAaF60qcoRY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54af28ae-1d16-4155-ab1f-08dda9aad15c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 12:15:27.7774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CWMlJ1/GASbkvkWwP4FY9vvCxNTcbw/5kyAcH9shvEGo57FGFR97N/O6+7Cgx/skVsmSRCMAQUvWQhmENe2vVho+cwQl9Tc2kHvDgt2540I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8742

T24gMTIuMDYuMjUgMDA6MDYsIFF1IFdlbnJ1byB3cm90ZToNCj4gVGhpcyBpcyBhdCB0aGUgbGlu
ZSAiaWYgKGZzX2luZm8tPmZzX2RldmljZXMpIiwgc28gYXQgdGhpcyBzdGFnZSBmc19pbmZvDQo+
IGlzIE5VTEwgYWxyZWFkeS4NCj4gDQo+IEFuZCBpdCdzIGFnYWluIGJhY2sgdG8gdGhlIG9yaWdp
bmFsIGNvbW1lbnQgb24gdGhlIDJuZCBwYXRjaCwgd2h5IHdlDQo+IG5lZWQgdG8gY2xvc2UgdGhl
IGRldmljZXMgYXQgYnRyZnNfcmVjb25maWd1cmVfZm9yX21vdW50KCkuDQoNClNvcnJ5IGZvciBu
b3QgcnVubmluZyB0aGUgc2VyaWVzIHRocm91Z2ggZnN0ZXN0cyBhZnRlciB0aGUgcmViYXNlLg0K
DQpBcyBmb3IgeW91ciBxdWVzdGlvbiwgZ2l2ZSBtZSBzb21lIHRpbWUgdG8gYW5zd2VyIGl0LiBJ
J20gY3VycmVudGx5DQpvbmx5ICJ3b3JraW5nIiBvbiB0aGlzIHdoaWxlIHRlc3QgcnVucyBhcmUg
b25nb2luZyBmb3IgZGlmZmVyZW50LA0KbW9yZSB1cmdlbnQgcHJvYmxlbXMgSSdtIGZvY3VzZWQg
b24sIHNvcnJ5Lg0KDQpPbmUgdGhpbmcgSSd2ZSBhZGRlZCBvbiB0b3AgaXM6DQoNCmRpZmYgLS1n
aXQgYS9mcy9idHJmcy9zdXBlci5jIGIvZnMvYnRyZnMvc3VwZXIuYw0KaW5kZXggMzBjOTI4NTYy
NTU4Li5lZGYzMzVhNzM4MmQgMTAwNjQ0DQotLS0gYS9mcy9idHJmcy9zdXBlci5jDQorKysgYi9m
cy9idHJmcy9zdXBlci5jDQpAQCAtMjAwNyw3ICsyMDA3LDggQEAgc3RhdGljIGludCBidHJmc19y
ZWNvbmZpZ3VyZV9mb3JfbW91bnQoc3RydWN0IGZzX2NvbnRleHQgKmZjKQ0KICAgICAgICAgICog
V2UgZ290IGEgcmVmZXJlbmNlIHRvIG91ciBmc19kZXZpY2VzLCBzbyB3ZSBuZWVkIHRvIGNsb3Nl
IGl0IGhlcmUgdG8NCiAgICAgICAgICAqIG1ha2Ugc3VyZSB3ZSBkb24ndCBsZWFrIG91ciByZWZl
cmVuY2Ugb24gdGhlIGZzX2RldmljZXMuDQogICAgICAgICAgKi8NCi0gICAgICAgaWYgKGZzX2lu
Zm8tPmZzX2RldmljZXMpIHsNCisgICAgICAgaWYgKGZzX2luZm8gJiYgZnNfaW5mby0+ZnNfZGV2
aWNlcykgew0KKyAgICAgICAgICAgICAgIEFTU0VSVChmc19pbmZvLT5mc19kZXZpY2VzLT5pc19v
cGVuKTsNCiAgICAgICAgICAgICAgICAgYnRyZnNfY2xvc2VfZGV2aWNlcyhmc19pbmZvLT5mc19k
ZXZpY2VzKTsNCiAgICAgICAgICAgICAgICAgZnNfaW5mby0+ZnNfZGV2aWNlcyA9IE5VTEw7DQog
ICAgICAgICB9DQoNClNvIGlmIHdlIGVuZCB1cCBpbiBidHJmc19yZWNvbmZpZ3VyZV9mb3JfbW91
bnQoKSBhbmQgZnNfaW5mbyBhbmQNCmZzX2luZm8tPmZzX2RldmljZXMgYXJlIHNldCwgSSBzZWUg
dGhlIGlzX29wZW4gZmxhZyBiZWluZyBzZXQgYXMNCndlbGwuIEJ1dCB0aGUgZnN0ZXN0cyBydW4g
aXNuJ3QgMTAwJSBmaW5pc2hlZCB5ZXQgKGFuZCBpdCdzIG9ubHkNCmJlZW4gYSAtZyBxdWljayBy
dW4gYW55d2F5cykuDQoNCg0K

