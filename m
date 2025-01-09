Return-Path: <linux-btrfs+bounces-10846-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3319A078CC
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 15:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE3141882AE9
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 14:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C8821A432;
	Thu,  9 Jan 2025 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="D/4qL8dk";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IVi6tDS6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF73218EBD;
	Thu,  9 Jan 2025 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736432002; cv=fail; b=qqxNTkxIBRCjfPACi/ptZP0gWc1Hz4tDtEKB7pm/nK+Ce0AjlDLjDr3j4ZV51FGGvBLIFxHnynzj49hA3XR3LKhlIYQHSqRVRm7A0GJfDczUCuIGmY7dZJ9umUwN93LfyaFAg8mwo+JJUHFJ1iCp1IaT1l803noBJ1k311K9ooY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736432002; c=relaxed/simple;
	bh=o0ScjT+cC9Sf8H1n2kHd4cZqpCHc0bkq21oWCZrH5EQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IVNnEyzBp24+TIz/diAZwvK87K65h6abod0y8Qs91/ZRm9hP24pEZQiTFYIUxmo+KCS/rWrTUzGXKtOCGMqIsLM7+58GhSwPlBzxt6BDnTrY2GSvqe6gdV1Ue/4APhjcLwKzN3hLqEBzEAZOrvMFIBkqqcBtIjKl4wjJ0pLoaEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=D/4qL8dk; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=IVi6tDS6; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736432000; x=1767968000;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=o0ScjT+cC9Sf8H1n2kHd4cZqpCHc0bkq21oWCZrH5EQ=;
  b=D/4qL8dk4+R4agJpoa2OkH0pROxJ4RhLuey56NTwkiRdkGL2RV/k8OIz
   ZqAFslWq1KlgfZoO8FfUWYyz/elWyaF9/MEgap9hMxV3x++NBbW8SD7WV
   LB7lWSGLugWATiEkWfPXzBR1aV58ggh70rnhPUPaJxFmCwzZlsoo99Tlg
   qZl0MAgO6GgmgsyVQd9OE3ZrKkzfpvq3W5FSwhwRcrXl1JcIrgELIKBBi
   ZB7moVAkYSoC1hI+BvMPxuVUOywg69vHXBkGgo5NmJUfA+p1QYsxo2pL8
   Zeq6Leu96o+/ODR+CgOplXwZaPTXYShFRFoTGiJEVrtYKDjZM1+TSAcpr
   g==;
X-CSE-ConnectionGUID: YR5x8uOlSPG+qtcBrl4WXQ==
X-CSE-MsgGUID: 8tNeqiXmSG+gD9DMOYUGkA==
X-IronPort-AV: E=Sophos;i="6.12,301,1728921600"; 
   d="scan'208";a="34902412"
Received: from mail-westcentralusazlp17012036.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.6.36])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2025 22:13:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t64ggosSQcoChj4XXxXiEx17ncsqldeh02zEAvIrtecmkJypxEq8OHZi7O4bAb8FDcPKI/34UgIeFuUgcpn03xt26COc1vEZfWILWUBsH4sp7jfaVcDF+QJ7ZHXkfnwBB5bY0U2rje69F/kSJLPGm89VF9AHezNCyfeSzE/P5XI3UznvwRYVVxYicg8b7A4tj0zdMZ8w3Yyhz1Conq7gYsa5X1VoOhUEHMR0ExpovyKnum6OK2r0hpA88iRx2zRDAhGBGkT+Zehd0+DA4epUAMpaTBUrPn3ZMRsGe+v9ZL4KUod7utYA7emElSywLMuclgd9g706TCOh+D3lOUzp9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0ScjT+cC9Sf8H1n2kHd4cZqpCHc0bkq21oWCZrH5EQ=;
 b=DMnw+0BABbxmSDqHUHn8PJtnqpFXF2oUepFLgrRhmjjSyf3Xkll54hZvu33PUtfytqFLIXWKO7rADuNCt0XWvEgUy2LXiKPqUqshhheGHolLzWZdAZMNprO5r/H3OoBHguUFPn53NiBtFqCo30DiOKhOmFM0pvFOmvSPgoEt78H0ybIXDiNzzDq/ww8SlTism65gUgdxxINpVwVg7XzENPSqz/1CDcnZMRvd+jSx84KBqPdicGop4zyjKWxe15csP+WhEF+qdtq8ii4O68wdNjwO75/DG3D1WrNQilu0VqNO5jPiHomMOqflWqrSWdDdMCI1k8RFRGMWs4UKa5V78A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0ScjT+cC9Sf8H1n2kHd4cZqpCHc0bkq21oWCZrH5EQ=;
 b=IVi6tDS6wxrw7XjBYQh3Qqwvh7Cg3/AQylYlt75kxmJdqtFesRwq+e/ep/Ma+BhY99e+/WLOvJHuEbk9MCHNE8qpZVNPKCi6Q/GNS2Bu9xu7BpJ6IF3oUu7TgUKrtHP1OsFlIPUj9s8gpvt+Y98DFz/aMwWY0PGqn2nxp77bLNA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7430.namprd04.prod.outlook.com (2603:10b6:510:18::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Thu, 9 Jan
 2025 14:13:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8293.020; Thu, 9 Jan 2025
 14:13:16 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>, Johannes Thumshirn <jth@kernel.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2 03/14] btrfs: fix search when deleting a RAID
 stripe-extent
Thread-Topic: [PATCH v2 03/14] btrfs: fix search when deleting a RAID
 stripe-extent
Thread-Index: AQHbYQJe7uLIXEk6M0KVlp5LRptWBbMOZcaAgAAZdQA=
Date: Thu, 9 Jan 2025 14:13:16 +0000
Message-ID: <de8da1ce-1299-4feb-b855-6e991b852026@wdc.com>
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
 <20250107-rst-delete-fixes-v2-3-0c7b14c0aac2@kernel.org>
 <CAL3q7H40wEFPz19ce+Fv5CkJVviTESearHBzLMFQc2UHZqJqNQ@mail.gmail.com>
In-Reply-To:
 <CAL3q7H40wEFPz19ce+Fv5CkJVviTESearHBzLMFQc2UHZqJqNQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7430:EE_
x-ms-office365-filtering-correlation-id: 50e745c3-58ef-4b41-0b6a-08dd30b7c321
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NVRaMXlQQ1Bvd2FLYjY3VStFTkxpN3orcVFVdW0vQkNyT0U4dmIwMXdsU3dQ?=
 =?utf-8?B?bEhLaW5FMWVVaENNWjV3czhVamppOWduVzd5SWY3T05odEFwZ0djelBMYlQz?=
 =?utf-8?B?VUhORzIvNlJvMEJOUkgwMncyVCtGK0Y4M1cxRmROOWpLdmpUU2lyaFkrZFVa?=
 =?utf-8?B?aDMwTUVkQlowOWtuRWNCdUhRTExacGdTa0NuVy9TYXkvbWlLZHplM0kzRXIw?=
 =?utf-8?B?cHNNREI1Nng2N0RXN05mUzZoWHd3TG16Y2pNcUQzTVdUU2lIODczWHAyWmVp?=
 =?utf-8?B?MElubFlvU2RGU1hNblhPMVZONmNhY1l2alFSWmsvVjNWWGxNQXJUWGE2VGZi?=
 =?utf-8?B?emx6dUJYTXV4czlxelE4WFFsckdOVS9uYXdLLzA0QkVqQzBTZGtpbm14Zm5u?=
 =?utf-8?B?ZWFpTm81UTM3a2RkRlcxbDVLSlUrbm5zNDZoamM5MUhWZGgzR2tDNnljUTBx?=
 =?utf-8?B?TGhHbkJmRVptWUtPc3hSZGdwcWQzbTA2UEVrZ3hud09BNWNUa1AwMjA2VWdk?=
 =?utf-8?B?U25wOTdDUzZVTEhPYVVsd2JRRU5zQkhxRnBqM0ZZcEoyOXNaL2lCWnFhMkNJ?=
 =?utf-8?B?WGJtQVJZd2tOVVZYcTBrVlQvSXBYL0d2NTd0N3Q0YTVoVWYyemNwUU93cXlz?=
 =?utf-8?B?UWxORjVYcHBVdDdKU2xTbzB6aCtZblJXWUJ1SlNCVW5RTFhld0xJVmc2MHhV?=
 =?utf-8?B?QVNHQW13TjhMb1o0bk9RWUhmSFlIRTc3cThPVVFLU2RlUE9PeHBxM1VxVXRs?=
 =?utf-8?B?NWZITklhZlNtL2RoeVdjalMvblJZaktOcG14WlBZZUtTM2FiaHdXTXU5eEx6?=
 =?utf-8?B?WGNCdjFYaWYva0FEeEczQzZUNXE1M2E5S1drdVRKRWppaUxvUGR0Q2Vsb2xO?=
 =?utf-8?B?c3ZDWkhmZXBtdkVWaSt0UGdSTWNGYVVKd0FuNmZLTHkwNDJjRng4a0djVm8w?=
 =?utf-8?B?RnRZU2w4VEYyVlcwa052TExQOEtNTlEwam1qUEVyc2Zzbzg1OXhYQjhOZGdZ?=
 =?utf-8?B?bTZZaWpVR25wTS8xTlczeklUVjE5d3VscjJMeU9nanVjVjhOWW1MZDFGRTZq?=
 =?utf-8?B?Q3I1aTNmVEFOQU9aSUdPT0FrcjY3RzJFbko1TFBCQ2NvTEtiZjBha0U2eUh6?=
 =?utf-8?B?d0pxZ2k2bGIxZlcwZzlvVmF5MEZ3UjJBdkpRRWZ5VitZcWRaRTJMZm5veE5E?=
 =?utf-8?B?RWtwV2hRaGlmVU9zQUREWEs1bC9PcXIvcW81MHE3WGF0a2pPL0t0eC9oRGl5?=
 =?utf-8?B?MDZxRVJ5aGN3RXNScTRwbkVvTkwzaFlaL0gvMDBVNSs5QmhRUExnVG5UNWhG?=
 =?utf-8?B?cHl0UGUyQmx2VnpBOTFhWmR1Q3VzMnZGM3lmd0RkNlo4K1BFdGFON2VsWGEr?=
 =?utf-8?B?SVQxUkNIS0Erc3lwdFkxOSt1d0FiK1lMRUZJZDNjMndXT2hRQmhraU9EdzdF?=
 =?utf-8?B?aStXaUJnNHZVQ0FWMWhKQ0pGM3hwdnUvNFhVK3IwbWgyQ3poSjZwY25yOXBx?=
 =?utf-8?B?T1hvM2hsbUpYY1p6djlaeFA5UXZ0TnplU3RkZVZIQlRNMEt3anNoMVdQVVFT?=
 =?utf-8?B?WmwvTUVtOTJTdHB2SkdMcWVkMXZxZFhCUVM4bkFSMG9aN3VhQ1VaUUJyVHVB?=
 =?utf-8?B?Smc1MU9KQ3RBdVg5eHI1OExxRlI4Um1KVVAvWEFteDJJbnlCaFVkSEVGS21y?=
 =?utf-8?B?aGVPOUJiZ212VGUzZHJVZEwyZXp4M3EreVVEUjJwYWVxQ0tqa1ZiK2plaVBE?=
 =?utf-8?B?cmF6TjdHTzJtZklsdWJHOVhheGg0eGt1TWFmTkhyY1Q4VUxWQ1g2ZkEyWk5s?=
 =?utf-8?B?SThHZlVUMVdkdUVJaDMxWWc1Ymtkd1JwWVNNMEFwMExLc3lVdW1rQTJncklz?=
 =?utf-8?B?NVcyekliMDlxNGk3anpKcTZNcER1R21oUnJiL1RTZFZ5OWdLVGNJSkZKREJM?=
 =?utf-8?Q?/1lsi3mR+RV1Bm3J96pWR5DgihMowQqo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N2NWY3Bhd0owYk5zQnk2WnNHcEl1bHZXM2JzajQvTnAvUzRrSWwwa2wwSlIv?=
 =?utf-8?B?VC9jSHRlWW5qV3ppWHNXYnBXMmNBM2tRVFFhOVJuWG1tZFZyZW9CYjNLckNw?=
 =?utf-8?B?MDBoUjBJZ1VYYUxxc053VitZVWJiY1lRenRCdWZCSU9rVmgzek5vcXVtSnpH?=
 =?utf-8?B?V1VEeUZTamo5VFVrSVRFY0hCUExQZlU5aUVpNkhhR0FFdmhMRGdlKzFHd3Z3?=
 =?utf-8?B?bG1uWTl3bHNtT2x6ZXk5Umx6VTViUHZrcGNINlgvQ2lFbHRTU3RlNk1POUZh?=
 =?utf-8?B?Z3VkV1dPOW5xdTNlb0pPQisxMUxIRUJwTmVpTGUvMldyVDNhcmVwSFI5eWNv?=
 =?utf-8?B?UTAxSDYrQVViY3lLZzV5S1dIUWphSUMrdy9CZEt2Y0w4UC9zYXJlcCszQ1Q2?=
 =?utf-8?B?Q2U0bjUydmhIZXBrNGhYNmtLdXpkeHMrM0ZNbWRIc1Nic0ZaUjlRdlRsbW9F?=
 =?utf-8?B?WHVBSzFWNzU0YTk0bWI1MUJzRnhmaU1PbVFJY2o2YWVkUEhtTnVDdWF1Mlps?=
 =?utf-8?B?ajZKZE8zU013WG1xYjhVeUhRMWNqeVAzTWY0dHFZQzJ6UFBzMnhNdGZPTlhh?=
 =?utf-8?B?dE5DTnVTK1VNb1dkRlE0N05hVFdTTXVpRktlQWVOVElzSDk5dmw0MlkwT05j?=
 =?utf-8?B?M2pEb3dDbkU3WHlkdnlmb0s5UElkbUVBYlV0NURBTlplUWtpTkJLdk9NdHJh?=
 =?utf-8?B?cE96N01aQzAvYzRlV2t3U2tWV0h2YTdYUDkzK2lYZ3RvRnpSWnczMHRtR2Q0?=
 =?utf-8?B?UnNEWFdzQkZFTXpVeHhrbVBPNzlXazB2V2VWaGg5MnBSZ0cwRk1mTloxVXdo?=
 =?utf-8?B?aVVmeFFhR0VQRVRJSGthZUt4SGNqKzJoelBmemFUcGNERFRILzZaQnRZdkR2?=
 =?utf-8?B?Y2tKdUdmV0JCYlBLYnUvMmg1eG1uQUIwdks3OHV1bUlrZVVlZHF0U3JRVy9Q?=
 =?utf-8?B?d0RieEtvTjFxT3pSdFpmdDM4aWlsQ2R5L3Jxd0ltTFdaQ0NBYUQyeE5aY2xW?=
 =?utf-8?B?Z0FnSzF1RXpvNi9TNG96bzVpMHR6VjdDd3VRVHF3STd3dmtLb0p2MHZVR3lT?=
 =?utf-8?B?aS9JTGNqOVJqZVVtVEtvNXNkbFBTK01Sdi9taVdCT2xoZ3BHbXhJNVFUcFlY?=
 =?utf-8?B?SzVGN0pUalcvS2ZNZDlLTVo2L0g3L3VUa2R0Ky9POU1Mb0lMdlVGRUVoQmwv?=
 =?utf-8?B?SkNnR1hyVXYrRnVaQXVUWXk4N0U5VllaTS9ZMFFMMkRTWU41YXJrQVlCUTYx?=
 =?utf-8?B?dmF1UHpCcFNDNGlrOG9wNlIwYmlJV1k5cFFsL2R2blhpUEpPVng3YTdLTnd3?=
 =?utf-8?B?T3JIcmZMRXV2cmtUZDFUR3lYS3E0a21RYzJBRjNiVi91M3VoUS9nMVk1c2gv?=
 =?utf-8?B?bm53M3NraDk5SkpYRDNFSGk0bXBOdTVCaWV1TUY2M2QzbUpJVi9ickNuV0JP?=
 =?utf-8?B?M1ZUZWFuZm1TRDF5Z0FPak13Vnh2OVlBZnlqazRMNEJIVm9sVzRycDFGVVd1?=
 =?utf-8?B?dDVOMGdJaTVqRENXRzU2dXQwckRhWFRnd3QvVm9mME1VT3l3WjhtSldneTQ2?=
 =?utf-8?B?YnVjc1lqdTVKRlAxY0xYVVp1UkVkVEg5eHhSMVFSMFpjYTJNeFljOWNxdHV3?=
 =?utf-8?B?ME01aEs4N3ZsL3ZnZWdQNkdMREd2eDExcFRYbU5jTmFEdDl2UVkydHVjaWEv?=
 =?utf-8?B?S2ZmK1BQcEN2di8raldFTGgrallkUTVGOG9qWVp6dG03N0tDQ3dUS0Y4YXhN?=
 =?utf-8?B?TjVGS1I3WDYzMjJrcmNoMjg3QnhNMXFGbVI4RWZzeHdYQlVKNXIyYlFUTGNZ?=
 =?utf-8?B?VVFpUWdXcTROSVoxT3o0eCtsRmVvdU5zTWVjYnJMVWtuek9FcTBBSWEvbUxE?=
 =?utf-8?B?NVY5TGlOY3ZRSmx3aWx3akRwRmxwRyt1KzU3dTc5N2lnRXMvRXhpNXFOWklW?=
 =?utf-8?B?dUhnd0dsVTlVQzN5T3ZwL3E0K2FsK2M4SEkvTmdFanZQU1YydnNqY3RaTUVX?=
 =?utf-8?B?aElqSllhNmhWWTRERktPMWh6aGFmTlZBcVpIdTcwWkRvbjhMUHdFR01JcEdz?=
 =?utf-8?B?REI2R20yZ0F2T2ZjOVMrLzl2bTJpZzF4Q2k0N3BjTEtkWHRLWU9vODRkMzhW?=
 =?utf-8?B?SU9TVnh3Mm1ramVZRXNOOVAzYUlzYU5SY2hqNXFtOEVUYWJlRElPK1dPRHN5?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA64449E3C970E4FA47378B318F32266@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a+YE8vFtEkjkjIDkGUlxAHlDVCCmL+AzbkcviuavuqP11cb1FgqqUtkTmf2YeULscNWowj2S4F8uCXpEdFvJlAsoVpjZwgrg95aPPGQTDgK4VMmV+U2bk6wNJadVpzaZ7fNaFcfI8JAuBHEUIpCLNmToMprQyTw8OjAaK+S+9l6DI65WUqQb0D8zdmYqp6fzGRv9OXdzqo//dXV1do1DghzFP/A4ovUtv+cd8avQOpuqXHd7i2Y9wjRFo/WOzMU2lKmcsfeQVvKOSoqlqET7SaOz9plZ+MB9Jhmfu0/pTgejiV4DGqmri6gleTyD3aqAMxSUKGa6VgoaVURvGcrlLcizMBLGt98lH0A5Tvd2/ALcDfLnx+cyLYarWS8ZWrDnFNSHoqVb6PFvIswvbiYF0EsrtI0iMIjfoNXLUoKWzsvZFtsmyKHP2i9vxiirXVApM9Mc/uihkgRKWkn52LDRgKghQrYX8ojgMONF4XhMwvWuJt/zMipKsYPSlYU+i9vJQshcJZwcO9A3+q8AcW0Q+xyQDJIFbWuoQxOCCnKmOfH//2Ava9w49k4y5dU7tq22/VROxeT6n26ycyvJzOGsMO/MpXo7HT5AejsjrjHvouVeJuMGjZFEvESNhe7cdsJd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e745c3-58ef-4b41-0b6a-08dd30b7c321
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 14:13:16.6957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FNMYzbM7MngIAvcKcQn5oyKQf1a7erdamvKCA5870h1cdCAAHbTKsrPJjaoX6ARXB3B7zMVtcu99m322vNJuWDFLujJhFGyTyuxlbfOLnQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7430

T24gMDkuMDEuMjUgMTM6NDIsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+IE9uIFR1ZSwgSmFuIDcs
IDIwMjUgYXQgMTI6NDjigK9QTSBKb2hhbm5lcyBUaHVtc2hpcm4gPGp0aEBrZXJuZWwub3JnPiB3
cm90ZToNCj4+DQo+PiBGcm9tOiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGly
bkB3ZGMuY29tPg0KPj4NCj4+IE9ubHkgcGljayB0aGUgcHJldmlvdXMgc2xvdCwgd2hlbiBidHJm
c19zZWFyY2hfc2xvdCgpIHJldHVybmVkICcxJy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKb2hh
bm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KPj4gLS0tDQo+PiAg
IGZzL2J0cmZzL3JhaWQtc3RyaXBlLXRyZWUuYyB8IDggKysrKysrLS0NCj4+ICAgMSBmaWxlIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvZnMvYnRyZnMvcmFpZC1zdHJpcGUtdHJlZS5jIGIvZnMvYnRyZnMvcmFpZC1zdHJpcGUtdHJl
ZS5jDQo+PiBpbmRleCA1YzYyMjRlZDNlZGE1M2ExMWE0MWJmZmRmNmM3ODlmYmQ2ZDNhNTAzLi4w
YzRkMjE4YTk5ZDRhYWVhNWRhNmMzOTYyNGUyMGU3Nzc1OGE4OWQzIDEwMDY0NA0KPj4gLS0tIGEv
ZnMvYnRyZnMvcmFpZC1zdHJpcGUtdHJlZS5jDQo+PiArKysgYi9mcy9idHJmcy9yYWlkLXN0cmlw
ZS10cmVlLmMNCj4+IEBAIC04OSw4ICs4OSwxMiBAQCBpbnQgYnRyZnNfZGVsZXRlX3JhaWRfZXh0
ZW50KHN0cnVjdCBidHJmc190cmFuc19oYW5kbGUgKnRyYW5zLCB1NjQgc3RhcnQsIHU2NCBsZQ0K
Pj4gICAgICAgICAgICAgICAgICBpZiAocmV0IDwgMCkNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICBicmVhazsNCj4+DQo+PiAtICAgICAgICAgICAgICAgaWYgKHBhdGgtPnNsb3RzWzBdID09
IGJ0cmZzX2hlYWRlcl9ucml0ZW1zKHBhdGgtPm5vZGVzWzBdKSkNCj4+IC0gICAgICAgICAgICAg
ICAgICAgICAgIHBhdGgtPnNsb3RzWzBdLS07DQo+PiArICAgICAgICAgICAgICAgaWYgKHJldCA9
PSAxKSB7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICByZXQgPSAwOw0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgaWYgKHBhdGgtPnNsb3RzWzBdID09DQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgYnRyZnNfaGVhZGVyX25yaXRlbXMocGF0aC0+bm9kZXNbMF0pKQ0KPiANCj4g
QnR3IHRoaXMgY2FuIGZpdCBpbiBhIHNpbmdsZSBsaW5lLCBpdCBzdGF5cyBhdCA4MyBjaGFyYWN0
ZXJzIHdoaWNoIGlzDQo+IGFjY2VwdGFibGUgbm93YWRheXMsIG1ha2luZyB0aGluZ3MgYSBiaXQg
bW9yZSByZWFkYWJsZS4NCj4gSSd2ZSBjb21tZW50ZWQgb24gdGhpcyBtYW55IHRpbWVzIGJlZm9y
ZSBpbiBvdGhlciBwYXRjaGVzLg0KPiANCj4gQ2FuIHlvdSBleHBsYWluIHdoYXQgYnVnIGlzIHRo
aXMgcGF0Y2ggZml4aW5nPw0KPiBUaGUgY2hhbmdlbG9nIGRvZXNuJ3QgcHJvdmlkZSBhbnkgaW5m
b3JtYXRpb24gYWJvdXQgdGhhdC4NCj4gDQo+IHBhdGgtPnNsb3RzWzBdIHNob3VsZCBvbmx5IG1h
dGNoIGJ0cmZzX2hlYWRlcl9ucml0ZW1zKHBhdGgtPm5vZGVzWzBdKQ0KPiB3aGVuIHRoZSBrZXkg
d2Fzbid0IGZvdW5kLCB0aGF0IGlzLCB3aGVuIHJldCA9PSAxLg0KPiBTbyBJIGRvbid0IHNlZSB3
aGF0IHRoaXMgcGF0Y2ggaXMgdHJ5aW5nIHRvIGZpeCBvciBpbXByb3ZlLg0KPiANCj4gQWxzbywg
dGhlICdyZXQgPSAwJyBpcyBwb2ludGxlc3MsIGFzIHdlIGRvIGl0IHNob3J0bHkgYWZ0ZXIgdGhp
cyBjb2RlLg0KPiANCg0KWW91J3JlIHJpZ2h0LCB0aGF0IHBhdGNoIGlzIEJTLiBJJ2xsIGRyb3Ag
aXQuDQo=

