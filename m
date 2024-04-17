Return-Path: <linux-btrfs+bounces-4335-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3FD8A81B4
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 13:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9951C209A8
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 11:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B369613C818;
	Wed, 17 Apr 2024 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EF45P4UA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ghep0/6i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABDE13C9A3
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352186; cv=fail; b=GnWPuNl8cXaHF7okIUNrKbiaf3aTLDN64M7rhKZFB7w5vpC83Cezoy7j9znsDIZiHqO6eDZe4lNyT6Ant8ABfeewNHiq1QQ5A4oOS0Fr2JOc7O1hHCcjOU3N/JNFso6HpFLLNSPI1STAn7rI6ByptOIHwnUedt3kUtUM6e5Qdt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352186; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XhFxipYnw21sv7UaKYip34IEl042VBI4MC1ZAq11U8g8oFNKkSiLIvOQY2DdqfKkfbi1jwZwwt8X7/Lecbsvl8xde4I5osaccVv8TrwS7Eou1ew7Y3lCtlOp4pPkPhyAqumvbAgvKATw2Tm5DRcGrdu67e1zGIEKvl65t4dwvh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EF45P4UA; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ghep0/6i; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713352185; x=1744888185;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=EF45P4UAzt55j3EvbGb2XLPKnxu3swEVdZiKMeTSqV97Z0fQwEgQX9Ko
   uJt6kquQNVsQ8PcyZAFWSULrIm0OiAXp2YqKHO9Z78uRxJYwgyPB9PGPB
   9brAragcDuYQ51nSa/WT+FLRz3zNGMl9eK9gvYsAep2sxhk+YvwJ1l7Es
   cvalqF7BP1q0/8pj96UBMT0EAUIcrsHOzZYTa5DyX2WdoYBVqf4X/qZpu
   PWIeb/YRXTrHtH1C09mFsfdt/p/LArbe6fni5BA974dbMyzF4Nf4RHuC9
   aQeIqhXV797ggccB8hIsOtE84JviW9iNX85M+KdcoliJ9Tgqla5t/h8z1
   Q==;
X-CSE-ConnectionGUID: nf9PoZjxT0yXZRcPfmbDIg==
X-CSE-MsgGUID: H2HZlYEqR3m1+TUOJsvo4g==
X-IronPort-AV: E=Sophos;i="6.07,209,1708358400"; 
   d="scan'208";a="13646488"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2024 19:09:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C63H4XSll9Ty4wzqnWzSnonWexoN4aUlgHi2f8zORstNBT1zII/9g9NiBoY3Xoci/1JMfqxTldXVsHaNTzeg4jupMf8UWjuEyqWRcYhEtK4aJ7GjbPA+2fhVfWIkmS0L9ceE9dzNnLFrKJws7w6Pq+hSpeK/H5K6AYYkgf8cCs+FGD5upRltmucTKSJx26mfkiMZJkVQOy9kXbMNfsHtyhrnMilTfngEg+cRF9YpVfN35zOPO54ZMkmbOau4xb1MHD26R5+rVwPiX+NVM1y8bnqgqurwDnahmxIKNmltFAjEHLCiJoTRWK1v0YeNCdAFu/0+SL2iLbvBZLz7o1Q+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=dlpxcFEiYkuIJclzZPrrYyq85tTQqb4GGFOskhB9Hf/ZFx0tGhzKyYweM3KVRgxK5E56ENrGqiNFekAaScQPXShJntN4/L00+IED4RhUlM2qdGOjpBiWkxXrNmZBeqvEiQfrJgq5gtqsQ7isGmsqjrSs8s4hLlRtJE/786GpKT1RUYcWcO6OLPZu/wKHKJ6/PkvAVWYgJUxAksHsyoQL28pty7RmVNQRQiDmM0ukGTEM90LwxKPxLlFL9ZyvCqYKRP0RWitHouQen/BA7nEg/7sDJgqVBai6kQWuUYNHxibKguUZxsheRMlxM6Tau1hqnZZWwA4GLFaDVvh+b9Ug/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=ghep0/6ihB/yUcThSWOgt+8FP/z2QwGkea5rKJvnddzjaDQdNAvwA4ey3fWuSBABSlHixjl7kN1sCA6C19VenA6QFvx7EkvdhQauP5a2/h0/E1bz1gFbwNBXeaY4MGfhcAJvif9jO1E7KW34vQLH5miwnaPVpLi16pJxekhrfQg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8453.namprd04.prod.outlook.com (2603:10b6:510:2b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 11:09:41 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 11:09:41 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 02/10] btrfs: pass the extent map tree's inode to
 clear_em_logging()
Thread-Topic: [PATCH v3 02/10] btrfs: pass the extent map tree's inode to
 clear_em_logging()
Thread-Index: AQHaj/8tMnEiX0fqX0CBPl7V0UImL7FsT36A
Date: Wed, 17 Apr 2024 11:09:41 +0000
Message-ID: <e672cfbb-169b-4ba1-989c-d20f53b83fa7@wdc.com>
References: <cover.1713267925.git.fdmanana@suse.com>
 <e65a4683c02ac3e4eb41612d3d76f665a9a72d98.1713267925.git.fdmanana@suse.com>
In-Reply-To:
 <e65a4683c02ac3e4eb41612d3d76f665a9a72d98.1713267925.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8453:EE_
x-ms-office365-filtering-correlation-id: 3f8d3ba5-40a5-48e2-c212-08dc5ecee155
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 liuO3HUiS4LL1VusE5X1UWblfAIi/Em5QDqhLykuES9+Ye1gZ5Mjli1tDUIfyc5tgPYbxTezOMIENsPZQXHSokFtd2MAA4ubvYH+kMoZ7Q7tavtp1dk5YtG2UX2F30tzWF0iF8lSQWzzMOo1RXi6mkJwHV7NpOYkg05B3WaWoEsE+reZUjiVvqZ0X7PrKjo2vEcNlKUXy27pFWBJ2FHYV6hCX/IxBiWxaJjHFfY4awRISyBhneocVMUvOEjIbQwUbKfcx7BhQ7E6+ALoP15Wr8JpDK8snNHSUff63+l3QXnS/MqwEdKkWgZlpVr+ZjWVBqGcNhwWL0IyP+2IggziJhjBcxUpL1iuZ6bR1U9gA2fmEYEMYSKmfpuUbosFw9obmsc8tpGfmukNuyv0nHNuarRihzk4pVQxkayqEX67Bw2M0VkjLxpuVlwPZ+oS3Hxl3yJh5RLygZjENhYszDwlk0rfN9OmOA7D7YZm8O+h05HItVXWrZzaRsmjoKrO1NVFWwpJf+1S+N+uGRfyUd+cjlPb37J51rohEVGQQI+J88OjCRch7dnNuZzoMswqzsFCA7fE2azpbgHCkR2FxwSUEUKoT+AdmLa/+QzNmC5PQP3T9v6jD3QJb2fAXmVzLUvsGNWp8vvHxrTPMxzXFy+pGWSsqYToUxB+HhSnEqlPI79hoD8lmjN+6UACbXZFwkr5w1pnUIzmRsS6K/DM/ZLB8WKtm8jqXvOvexR9fe7Wc1E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d2ZyRlQ1QUVRbU82cTZNS0kzcjF4c3FRSlRQdVlrUVAvNk9lWXE5N05YQmpG?=
 =?utf-8?B?cWtQVmlsWk9Rc3FvRE1yRGZ4TklrQ2drR1FxM1QwQVRMWVNpM2pSUFFRV2RB?=
 =?utf-8?B?UWNNY0V0WFE1aWdCUFBMSW12ajhLbUgxcHlVTjV1UDJCOEJwK3FBa0pqWHBa?=
 =?utf-8?B?ZjB5N05scWlOQ1JGb2haSWpkOFE5dE5qL3RTS0FjVm85b1pCN1hNVlJaVEJn?=
 =?utf-8?B?dTFjS3hZLzkyRGZPWFBQOVpHbWZOL3Z4aGcwVEVxOUZOK0RWN0NpcU03T3M0?=
 =?utf-8?B?Q2JWa0FSR0ZCVm9QeEgyMFc3OTVnVjk0eFdqYVRCUUU0MFhxeUEvYmw2N3dE?=
 =?utf-8?B?anlncDdkRk1pTUg0MUp3TkU0bFVvSVllc2VmK0RadkdPNlorU2ZPb3JURzhC?=
 =?utf-8?B?ck9JbzlMeW96eUR5R0tZVTZLcHdNTS9JZVdIUjBvdy9jWWxobEVJaU9lVmJ3?=
 =?utf-8?B?R1BZU3kyY2ZVMFp0RmVUeW9ycEk0cGR5VU9FU1ZVaE1vNnQrYjBpdE9OZVBQ?=
 =?utf-8?B?SXR3VzR1N0JHd1pRNkh5c0VLSjNUbGNhQk80Z3BtUVF5dW0yRldxQXRNUko1?=
 =?utf-8?B?S080SFRlenIzUncvajMzdnFrT1FjaWIvYm5LUXM5VVVpSk5Jc3BvMU4vS2pM?=
 =?utf-8?B?U0puUzJFMVphdlFXSWlyQnExenBDYWFKQ09MM25IVHhOcG52U2VGR3I3MmpE?=
 =?utf-8?B?T2NuWEZ5elVNdERWTTBCWGp5d1JVNUVZV2l4WjZHM0JyTEs2eWRTczhuck5t?=
 =?utf-8?B?SWFTMGY3dkJwM0FHQVhFY1Z0T201eHFsK0hLR0VsVnVmQlI5c1dXczB5Q3NJ?=
 =?utf-8?B?UUFlM1NIZHQ1WlAxWk5QUUlVT0ozV2RNWGtGNUVsaEgxWFZwNGRHT2NNU2Uw?=
 =?utf-8?B?Mm1RcktJQTlSV2Y2c1doM011Y3RJSWYwRnpYQktCbXNKNkhqVWpSTjZTK1hh?=
 =?utf-8?B?RW5GMHJHNVJhVWtQZ3JiYjIxTkY1aXd5ampyNHB5YUtCVG51UEgwa2hRVDMr?=
 =?utf-8?B?MjdsSHFLOE5ybEFVbjdxNGJmNVZkZlJJaXJ1eXpqQ3lxZWlrR2Jkdld5QS9r?=
 =?utf-8?B?eDducWg0S2pnNFBFbWhaamg2MG9mb0RhMmloZENNQ3hLaTdQQlB0bWZoYy9w?=
 =?utf-8?B?TFhXSnFnbXhia3haTWJUaDF3M1ErYTVyK3MySEpwT2hHdmZRSGlEVExwdC8w?=
 =?utf-8?B?WmdmZ05Zc1ZWNjBGNk5DUlNlN1RDWC9YUWw0NC90WFA0VmRnczl1a2JzWDhr?=
 =?utf-8?B?a3UrTVJhbndUV1NCVjYyTnU2UXd5UlNubzA0cUUwK2h6SlV5QVZHcUVJbmxk?=
 =?utf-8?B?aGJXNnlNdmp0RkNXc080WjZwR01hRlRuTytYYnZGYTBUS3ppKzRBOVh5NkdU?=
 =?utf-8?B?N3pPeVl1enM0UWUvY0plcU9qSE5wdFpybUw3SWRkY2NUekZkYkJ5dHhqeHZG?=
 =?utf-8?B?OTg1SjJ1UENRbzlpZnZkZktMNUx0WXNtWkhQQ0NxZ1lWZWZxYmd5ZENzYmpL?=
 =?utf-8?B?WERjdTB1T2pyM3A5ZFZWdnFTOERTZDhuZThrTE5JUGxhOEtMc29oMlVMMEJk?=
 =?utf-8?B?ZEZ0Rkh3OEdIY2xOMVQxWnRYd01vWkloVnNLT2IzTzh2byswUEU0ejZvR05Q?=
 =?utf-8?B?TmNrZE5ueERHWXdOUEhHUEtLTW1iaW1naWNhRGJub2Q0ZXpVUnJaeEV2TXFV?=
 =?utf-8?B?WUJqWVdhZnlwVHRTd0lJRHRxQktReEJ2NFZScTBJVkxJS2Nield0aWhZRGVF?=
 =?utf-8?B?RHZxd1dCa0sxNmtuUXQ5ZUZQVzFGT01aRW5oa0tEU295NTV5QWlhQVZjK2lt?=
 =?utf-8?B?anJhZ3VQY3BCWStwZWJCZUhGYnVXQW5wVVlLYVV4VWU0NXNONXk2U3prSzZZ?=
 =?utf-8?B?aDNUWmZaVFFzTnhsWUtXaitvdFBwNFVRUXdSNjNtQzJjYVJua2JSUEV6WlBE?=
 =?utf-8?B?dktTZngwSW45UXI0eXdIc0g1cjJRUjNCcXdtbDVkR1A3aXNjb2FzeERtcHEr?=
 =?utf-8?B?d3dHdmp5VDJhL0ltM2pDS1JCb0FBTCtHSEdMMk01VU5ObkdtMy9RazNNSjdF?=
 =?utf-8?B?YWtDSHFoMWpjaEhlTWgrc2p1bG4rR3Q3S1V3VVRHVGUycE15WFNVVGJ0SWkr?=
 =?utf-8?B?aHBjU0Z5TXREc2RIczZ1emlMREhmd0h0QURlNWxnK2Qza0xpd25EWHZEbnl4?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <207C89E95E19B2438169EA76B34BC3DB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MOYZuN309IYlOG8z8wDc0WuW/CPRsY53bSBSX001xhRlQ4EvXENtDNeXrIzHIQagioiUMXPijcyXZZ3ge/hYdfsIfBhzyO3yI1X7Tcn7XSyFONpL4NxZFKP0WuvzpACWRCoi3xPTkyujJctxv1FCCV5JKViAkCczeZqZi1QQo/isDNNlEVgOTTVbBIuoPam3s0D5fKTI5Q+blUV7H95MLhojhLuT6GoHQbGXFMjR8mN7hCZmpkchVhZvzopQ+tDHfyG0lzYT8NiIcUnTH4RRSYkJHAjNMLXkev3h8er4N3wNsG2mc04GmfcFKQZRVd8KpAlF7tLz0032h/npygaEM03tSxN+J8xm2mF4kTcr6z8Xt+Gh+qPXRNW0/1KBsZmtLhTLRd5QRbpJ3VWtcEGEXMQO7kdfstPi4Ni/H7BFMBejEVbK/1IfMycV/m/jLX1E4RSdXCIovgb1bRjCt0T1cFEl0LEfIQZdj5JqgmInJNrfWnJv2UO/goOXk2ntvYSUh8sgwOhDciOj1Cul7AZbd2AklqT5qPV3T3tx3GZ6dEwuZUFT3L2IIV5h9Qds1Jw3YQmQPJ+dbIYewdjb/FiC54OCULu2PsX0VjBNb76tKOMiBTMDsZ4zN3Dn9N0ySjT+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8d3ba5-40a5-48e2-c212-08dc5ecee155
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 11:09:41.6079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EskNJoyAWy+q9T37BhJp747G707BSmPNb5cSYi/Ir88qakmhZYGNyODFfohLZnsJRa6e5MUiULq/tw8OscSed5atBn4NnMHu4P8jkzmjVxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8453

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=

