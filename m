Return-Path: <linux-btrfs+bounces-4336-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CC78A81B9
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 13:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F6C6B21F74
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 11:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B2413C834;
	Wed, 17 Apr 2024 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HK6VOZPS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UKqHb4np"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E96413BC1B
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352262; cv=fail; b=Nr5XyfXRheLzBVqXDXGMpQN5VNNQhVbUuUi781IGF6JvbSjRpV5Qk3nj4yhXOzEfzCkcqs85CSWI4qJ/0iLbVUTEyHLc1CUJVPoBap0AhubUaeSQ7bH+LIAhegUWgJNu14o3GNdhTllIotyLlfGR3k9/zrjxH5FqFBAYZdSUVkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352262; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TxBLUcOJBUYA9uMooXYSVY7V7oQxDif18iIqfuAO4OyAHkZmGnxWu+HBmKJ6JPtZeWxio60VKDvhW8osqdSoPOwelJviGBWXS5CJXvNDpXW0Twnq7HZ82usqOXgT/kQUrq5swqtCD4LrsFv+0cxUfXvZ6tkb3ObZY6M67MDr9xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HK6VOZPS; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=UKqHb4np; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713352261; x=1744888261;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=HK6VOZPSquiaL1F6/wwn4ItEBtMNJ7PfHYNhse6jk9nlSX6Cq7FWpf48
   A7QnVGHTER5P+3DRRhMbvaLe3v+qnrK4b41qqKZ7EniTjxAlFBWR5yIS7
   7hjRdyR5pnnLGEO6dfT8tJTdfxMzXWHBwurHcB0HyE+vKq7CWxlj+JuFp
   6tMzC1l7rJfAlGVh/S8LsRQHkEkd9Zj+J4vhSI/3RTet59caa2W6PgGFI
   lM1duHwH9uB+wMtCyWnNIP1gD/eUqmAXPzvY4bmvdFShL5A9rJT198j28
   Ozh/KkYIGOKLq/rFCV+klLxxZa6pmYRJu4W36W0hzDje7l54XzGGSsRlO
   A==;
X-CSE-ConnectionGUID: Wll647Z3Sr6nnjMsz8mO1Q==
X-CSE-MsgGUID: o5ewdcYqQUGNr6i4EJR6NA==
X-IronPort-AV: E=Sophos;i="6.07,209,1708358400"; 
   d="scan'208";a="13646541"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2024 19:10:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYGVDOTcGDsAPBUPRBKGrzRCZmP+x0pUDEo3vSACg3nAqzyV1zRPfxfNb1rOVTlLDFcL3qREOI/qg0M9+IaaQkh3FuLzwJg3DRQeCX9aqHNKouqD3cuONj2T9SvN+PLO7yV0l9Bq/qEAJM27CWP8KFuodNSIccNtYNZW0wx7/udMq/vH0lwh27q4dJTKSqm8vuI8ff/F8JvstN7dnQx9VSvX4r9TJUOaOY55rGTezSduuvS36FOZl+fDbUhbw48ttOkI//V5nRTn/kkoLaZVkb6Vbc8zDVNAiIUO1qvncqbM4IePoUv1HDFbgyYv101OxXkwabiqblWSDev4YaAM/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=GTHYXJneoaVuVPBF+rcnoQ62OCI3os/bqNEDMUvMxqkX1NzI2jOXSiq7ngQGVNme6aZISIv8HA1YuIWm1DCkRlHJwZOcWalJhODjto1NgKqXNMxCNmZZe8jTy/C25yCjB3QgEfz/AiBZGbiv3roMPlim57vAekBIysIZf03qu0akqly1pcZPk/Zdm1woUw85zLrDf8XZbXhMPQrLm4K3AfRWrt6qUThW7VfB+WG2lUibWU+SpdVI/D8upxVgK9Y63nOny3o1oZKXfzA5ZctVBWi+k1xo5rdGCQsGk8yxp9zTxHUyLoS3/bF3qYIqsgWPfGq15QaSwRlidak7/RCI0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=UKqHb4npBLaoOwlm+cDxU6iWMdfetrCa7PF8qpCWz7rh8DV0Te5RA5hSYC0c4MlIyrTSEcK+NjN7mIY/zr/oc/U5YsAYkMCO+UTfrNTjIfuCwXO5UomBCXg2r/3O8xNl51wLoEYnyC0oLMdJ65m/yGrYWz4AGAm0LzL+K6JMYx8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8453.namprd04.prod.outlook.com (2603:10b6:510:2b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 11:10:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 11:10:58 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 03/10] btrfs: pass the extent map tree's inode to
 remove_extent_mapping()
Thread-Topic: [PATCH v3 03/10] btrfs: pass the extent map tree's inode to
 remove_extent_mapping()
Thread-Index: AQHaj/8wBYx8yi20YEG5IysxXG/JCbFsT9oA
Date: Wed, 17 Apr 2024 11:10:58 +0000
Message-ID: <453349ee-342a-415e-b119-e899acb050df@wdc.com>
References: <cover.1713267925.git.fdmanana@suse.com>
 <10d9942cd5349cf6be9f31dbc9a447467df9edf9.1713267925.git.fdmanana@suse.com>
In-Reply-To:
 <10d9942cd5349cf6be9f31dbc9a447467df9edf9.1713267925.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8453:EE_
x-ms-office365-filtering-correlation-id: 02b39db4-5573-4256-c3a3-08dc5ecf0f1c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 u+4lE5e4rzMHiKBKYVCtRHDWKS9bbOYuPQXiyuEm168BZt4tiUGgNDYoKBOrlFaYyKtBApB1FD2XPyiVE7O5yJZnLjfBBlothkpyHPm71zoF3bN+QeErlEVs0z8MS1KZkR5aA0AdVaRw0jT8iXjrIwN2XN8Tsc/fLlQzvlk31+DbFhsei8Zu+NJ9yk9izG+T+d1/nXzAZUyVuZLUqfeb3d2k+UmGEro1zH85pxOxUjsrt8E52qKnVE/eE2VvBIm9OFcnXse4bR0FQK3NEED74xf2rUFO7n0jDCyb3Z9vlsY7gPy94XHJ7Qw+1J4S6sRBXFGW1ad3LpVwZRWmgBH9N3TN8KVUczPpqbRDvPk7aAzSXb1MpCwLEJrCi5qnbGCadVzw8cI5kaXREmYrgVIolErIJRLWbVH7XLu9Quw/xM3/9y6JX9/rm6oYz3HD/7IXwRpOIp+5FKCUWWjTCRC/u7kWEKWvdpGNt6poQWqR1OEO72B0+5w9Fyq2FBA0Qd7W1JH29ynfk5NKDNLH8v5UXiNqLIbFIrEUTLVHv06v6BEec7DkYzPNmPHubLbox93lnO7y+xjeuptXmymWyyhhvPafKzjbvmatsYPKTKqLHRqIoPaic0zlS/bWd2EXf/xgVYvbHad7QaQ4CG1MlRDY7BSJJgpEcTAqFbF9OkaUtmG9fQzYrc+qkD+difZqYnMCaVEZCOoo4FfV3Xe9ttlKDPjt5RjzFtRGTWUmIaDbL5E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L3pYc3o4NWd5WUE5RDBKZS9qUXgzYm9SWVNRMmpiNC9DWUgyOGxoblRQcmxT?=
 =?utf-8?B?dE43ZFhGcUtqeW1rcFNTYmk0WTYyNW1yOEpyQ25CNXcweCtOcVpaaUYrcVJC?=
 =?utf-8?B?ZjFzRlVXaVBYdE1NU3pzMXJ5cllROWNRRDFRSU9EM05RRXJ5OW9lYW9sRy9x?=
 =?utf-8?B?REIzdTh5dFBUcThyOUhNZFliVzBZQ2d0elJ3aFBENS8zVjFwdElpQ1Fab2px?=
 =?utf-8?B?dXZpU3IzNGZDWmNud2tuNU9najVCdE9GSGMxVDRlY01qaFQwZU1Ha0JGUzVi?=
 =?utf-8?B?OTBNOFBpWnhOSmlEeTdYU0poQ3pFZUx3ZXZ4Z2lKNHRsRDZZZkxxRnZqM1lH?=
 =?utf-8?B?WFpUYU5SOGxhNDZYSWRWYjhWNlJuUFBjQ2o0RWxDZ0hrK0JQcjFlaklGTVVR?=
 =?utf-8?B?L3hiYjRPWStlZk10dHhJWkpJSkRjQzA0Z2U0UUZzK1pQZlJNN0dEbXBNUnNC?=
 =?utf-8?B?MXFNdTE4U1N0THB6c2IydEpOS21nVXQvMUptR3FCNXVTcHJTbFdtTkpLUHM1?=
 =?utf-8?B?R3o5TG50YmNUWi83U0pJOC9Rb2FqOGhtcWd3bVpqRS9rbTFYOE8vTStJc0xw?=
 =?utf-8?B?c0lpdS9ZSzFHdUcrL0JVRW5kUHM3ZXQ2VVRNU2xSeVh6VitjZXNDd2padWhq?=
 =?utf-8?B?dUs2TDdpbnBYOGQxR0IwTUtxbjh4ektTMVM3WDRrcUNVRFJDMFhZTVJFdkJr?=
 =?utf-8?B?SkltNGdwN1NUaDRuYUROOWlGeGJnK1RuQ0IzNm51QXVFaXU4ZGRwRm8yWkla?=
 =?utf-8?B?ZjdaMzFmcHJWemdMWU5pUmFlQlVRNTlEZjJwc0RTTEtPdDNaUTdZSGl3UHgy?=
 =?utf-8?B?Q2Y2OXdaOFJxKzBhZnk5RmtPejJ4bFhOU0R0NERZaU0wOWVVVkc5S0pMNVlH?=
 =?utf-8?B?Rk5qTVlYQ0o4OEtuVzA1ZzNNQlc4NG1hUm5pTkwxQ2RwaGhjQ0xDNGtSb2tO?=
 =?utf-8?B?TWh6Q0s2OWpEOXRsS0hMZEJGOG5ZQzQ3aEUzNklEdlBPUU9vM3BKK3JYR0gz?=
 =?utf-8?B?cVVvQytDdHNOYy81VUFCTDduRWNOM1liZnlZVmVBaTFaaTArSHZEQkM1QXVa?=
 =?utf-8?B?K2dWOVd1VDUySENxSTBRdEJDUHhFY2k0YVhueHRIdzFoUVU1ZEtieHlLVlcz?=
 =?utf-8?B?aUoxVERXdUVSa3RhZzdkMzd3YkZxL1JtVHpjYVpJVDdyQ0hKakZ5dWlTdURS?=
 =?utf-8?B?dk5KTHc4WUZMNm1YTGZRU0VKblVYbnc1TlhoZzc2dXMxbWY4U1UzSy85Rk80?=
 =?utf-8?B?YnREMFVlUkJsTm1pUGl3eHhGQk85ajlHY3ZZV2hPNkJjKzJTWHRkYnR4QjFC?=
 =?utf-8?B?WldINE1aS1ZhdFdKUWRtQnVnL2VNYm5qNWxNK2s3SEJzcU00N3UyMVoxV1Bh?=
 =?utf-8?B?MkxiT3VuN1pLUmwxRDBuSy9QelNvUkEyS3VFdzQxQlBvUWlLcnFFSVdQSGtp?=
 =?utf-8?B?OWxUZG9tZ3pzSExKSURHSVdUWFljQWdZVEhYMThISVh0TlRLNjhOYmNWM0FE?=
 =?utf-8?B?U1JzL0xBS3dWdW5ObmJIdElsdW9ySUNVSXBCa2RBelh5MXR1L0J0c0lNVjR3?=
 =?utf-8?B?OXBwZnp2cFFQYjJ1MHEwZVFZemlqay9nUWcvSjliZHZmT3NiTVdCTEN4VkR5?=
 =?utf-8?B?Z1lHeVRwdnpxU0pSVmRxR1VVYlRnSVcySGFLaEcwR1pET0RDbGdXUWVIZGQw?=
 =?utf-8?B?WEFiT3ZsbzFYYzQyQ3l1NWo3KzlTU015OWZRWDl3dXRSYmVDQlNUWkEvS1I1?=
 =?utf-8?B?amx2QUZCeEdHV2VlQWlZWWVmOXd4VHNDb3VCeDh6RzBLOGEzTWNGUTd5NGk3?=
 =?utf-8?B?SWt6dHVBci9qalNiTmdoU05ONUpmS0tBMFpSZGRsaXh0cnFGWDE0Q3BrSDVT?=
 =?utf-8?B?V2NBUnpsempWZ3ZnaU9JemU3WVFjMGZwVVI1d2F1VHBMOWl2UEFOQVZqeTli?=
 =?utf-8?B?cUlUTGF2VXZMZUowTVB2KysvZCtqNkRKWW10aTJsUGNyWkFrM1NDY0loZ3BX?=
 =?utf-8?B?QjZGeEJwT0JjcVM2UDFoYjFqWWlGYlM5OHR3aUQrWUxBYWtMaDBlTU1lQ3c1?=
 =?utf-8?B?TGJRc1hrQmU0MWJoY3l2bldrdXpSYVR1Tmw5dTdubGJ1cjZqMDBOSHlBR0ww?=
 =?utf-8?B?bjFWU3pPcHg3ME5VRmYyNjU5c1dvZzZZdE9SWHFHRWVGcUQzMVhqQXN5U3BS?=
 =?utf-8?B?TXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC02C972F0AA0245ADF1C916D069C1D3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yFJyEg80zwm2jPSsOH2OCO7yVKJHTOrvwHyDdzZPNYIgylSAxCHm8rVxwpbY1ROjd5zM3Gaa4kCv1L0qegalucyq/WfmpSU4r8BoUBliwk81xcIBzo133Xihjd68zkxhv/tspGgHXfFQ5wIFWrwt8bD8aHnJD44OjzvZmjzqs9WEKqk1thtCNIwx+hVxrH8f1iLHkwyXcVjRXApd6K5wKFJNBrqhCqcInotJav9coiS8nVdSHj47LeHj/H7bPrS37xGJkPUECU4HBqw/UVecJpSD6GBya5Hi0Oel07j7hksNMDWdioulBC4gJaYGJ/ecyOMGMqfjkxYBeq5SxhbZnfP6Vv+k+rr/blDKp/HawnyGlMVvw894HHsARQv9BZICJPJxZ0dA7zBvGIvMHO2GIrmchFvQL2mEYK9qiKTxxawlFWqjZIm5y/31HFU4DnBli/C4unFsDaCWz/8hE9zzdwJFGJ27b8xtOx0nAIe8SBy58mzT3UiJGYxQ3FJATsNlJsEENmZ5++wiTa9CSJOiUeWsq3hUO+Fuz2J8y7asUEzBbnF2bL1LlZNWFeBrR1v1hQ7oiKRtY1AXsuwz9IRM0luxI4tK8a80w6OkdoLXSLedtNIN3to+xWrcVk4e9FYb
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b39db4-5573-4256-c3a3-08dc5ecf0f1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 11:10:58.4014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kbwg9A+bTT/O4YuNK+ySmQ6xLakqz5wQGCGQeishjdNNmKCaOuEA9Q4YddgihH4VFZqqXvn1lQCdqwl+hjvYY/T0/cSsdmST1qYtywGOVt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8453

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=

