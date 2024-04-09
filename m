Return-Path: <linux-btrfs+bounces-4057-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E3089D888
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 13:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CB85B27F9F
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 11:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06FA129E81;
	Tue,  9 Apr 2024 11:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HvPg33R7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EVP1p+ME"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0185B129A75
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Apr 2024 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712663557; cv=fail; b=CPUqFr/D44f7tF0TPnptL1mrYg+2wGnAA8QGqjvCX8qlpe59p+R1O8PHcj5zYWjJJ1JAs+uS3K+/o5+ri4O8OGlCkBIt5h1hBWNcdPUfGOohcbw6AGb2sq30XDj7xEq9Fj93sEkckM62qX/WZevC/McgW52wz3zjgA6duPyFmoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712663557; c=relaxed/simple;
	bh=AUiopFyLcgszwbZkJkgN31qZ/S7r5hQX/yL1Xhrzh+k=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BrM6UaGhWlnTMkkmy7rsA2G1pIIPmUnEbe4OSfjXSsJyZ9WbIdRo8TQcztuWVBqYBTgGFVuKQDemyW/2bi7++rVX87tnRrTucVqk5g/SquVr1UEnwUZ8g559e2RIEnNZ3ObvbbesaMOou/etrPymTr+4c7ZaHRfOHk+GRxOf/24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HvPg33R7; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=EVP1p+ME; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712663554; x=1744199554;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=AUiopFyLcgszwbZkJkgN31qZ/S7r5hQX/yL1Xhrzh+k=;
  b=HvPg33R795pOPK2pWIfB/M2jnYBEsv5lSMPU9IvrndUQsMy8ipIxlUia
   0IXEPrZjAD7yHdE9G+RH5dFpNwz4YbJ+BNGg/YmeOIq8p+WC/7J5NOcnM
   UKydv004+W/jjEbcFqC1uszSeQ+kGXBEiBvlHdCeUXwqmlljooK+LZYys
   dYo2rHxT0XM8l7kbczwBW00P5XXKRDVxFIacym5DL6jvW2ifENI0uIWih
   lRUjuc6pQF+0HRlswp0P0BRbKNqSLVeFsLzyDzguWJHmBZM8wvgPtWa7r
   7XpTElgWwWLSYeHiKZLLO4fsfhVr2SqNTAN0aqbqlWHEVYIjao5enrPqQ
   Q==;
X-CSE-ConnectionGUID: tS40PWgDRROtNtZUWWk0bA==
X-CSE-MsgGUID: HtGCQi+qS22/q4VgarNyGA==
X-IronPort-AV: E=Sophos;i="6.07,189,1708358400"; 
   d="scan'208";a="13832465"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2024 19:52:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQY1vmkjT94jZcq/HoCMlEqTg3Oqc98T+av/wJjAzWNYYv5+fIilJV9K1iSvrZ9DOW/RvuJMEQLAIkp3GZEqW/ZU/l89RjxPmd4PSls+lCHcTZDseecUw810aYjbY0tpyf3iHaBFB9JuTUZwPpWg57vVSc+zRkblxVT/3yB6Kqb3uMGlogGBf90VJx8qHYrAy+iIpkWt/fUkY2gRm9PyvWmxxKqupRwgC+2mQ2GHSIELDHpTki4TtRRBn1qqI5Ppc/zxx5kwdkcHlVpg6a3pQM3kn0JFv/p8U2MZjIphExkUqWra+vRwCGOt9kCFUZjR1ue8aAVQQ78RfdMECz16Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUiopFyLcgszwbZkJkgN31qZ/S7r5hQX/yL1Xhrzh+k=;
 b=NGneisbqTcGJ3KDiVsTxdMMyDMRaGhexQOGbMCIxVDEals07UEfrcVAKghkGj0qrhaBShQ62ATk6uwy4OLHjL68nty6lWfmE7kIz69vt/943SWWlK3TjbpFU/JC/VV9woc0LArXpc7RiEdsrBeR1p/YkD6dcH2EnSvMWXVNqELEDUHtPsUwxGcs8TiRvL2B3E9+5dn5nQRlDC5hXt+S6yglRKz5dq0PCXxPe7IM78CmjMpMV1HpqFIt2w6L+7r+lOaps6jVQeOGS2ddbSQrb2AjVD8kik9Yw7dfSQbQyOpZeE7z0nHz3DjkHSF/9WufEmRAKlriNLwbvdy7NyuhTBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUiopFyLcgszwbZkJkgN31qZ/S7r5hQX/yL1Xhrzh+k=;
 b=EVP1p+MEkeVgudikb6EMBRaAYn568Jn0+TMOu6FaQOaUgmmQPjBIrpfOQxXID7cooQAW6yoO3JaQvG+nnD7xXd5pp+FnWFBcZF/8FPc0jPwCYYoolSoTbENwYxdiEKB4/fid5zDfVnVXR4MdoMpAmcY6VCar8PccPksLuGSf7hU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7265.namprd04.prod.outlook.com (2603:10b6:303:7c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 11:52:31 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::48bb:3ec7:409:1907]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::48bb:3ec7:409:1907%4]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 11:52:31 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Boris Burkov <boris@bur.io>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 3/6] btrfs: dynamic block_group reclaim threshold
Thread-Topic: [PATCH 3/6] btrfs: dynamic block_group reclaim threshold
Thread-Index: AQHahf5iw6IpodZnCUeWPaha86HoNbFf3NAA
Date: Tue, 9 Apr 2024 11:52:30 +0000
Message-ID: <e0daf386-d8bb-4bc6-b0e2-e8516788b592@wdc.com>
References: <cover.1712168477.git.boris@bur.io>
 <198348dc7188360fe33083ce06421b1e7f7874d9.1712168477.git.boris@bur.io>
In-Reply-To:
 <198348dc7188360fe33083ce06421b1e7f7874d9.1712168477.git.boris@bur.io>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW4PR04MB7265:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UWlTxRljUz4oAv+LceFyIT9ZUrzwW5DfkO4BfFIHIreghUzDky9obGlDoFAQ0xYshQKVXUzHQBdYrFv5cJ/gJjfDRDJokRLo19PxVeK+UTuDuRO7KopBO2BWkILzivqkZzXtAyM68TDvEX/sXw3unBpKLQddu3em2fPIc4jc0eQcltHzZW0AYYw5qgNVjQ961kcVeG0bfDURwm/ErATm0IizA88AS4fuvkkTCh2D4KCzHsvPsrZRyuQbgvW5dEDlA5xCOvIojqwi2qaoXU7gHz2N6jzM3IK8yTzC5T9QkrI152H2FPH9jjOIASFcxyv/OpsDVBHX9xs8PXEmNSqSLxSbv0QZVQbMI6+qCgtjs69fp5zuXeogJ78FsrwDuNrFolth30kzRe8cgiawqCkJARkPuC1Op4GNWDsHeEjPl7rXs5KLsCPqJRtVBA6j6P0UGEt2nos1i2OWfNauqYfZislYLaGfAKoimeTjp75eq7M6dtZsTlqJpQS4277JTLw99EwLpI8ceiQ95Rm0uAhvYTNU+FLYioANPq1KdFa2P5FYfb2HAoihgpRDx9QfSXWWryRRCHwoliWpAoTU10AqPLsmKgXLfV4fFjJMC7I6V9YCkTNdITwQBiGh8gjHBPg+LmPyPxS391Sn58Z5DHlbEAikcH2Ow82acyy7qpYioGQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dUMvK1pwbytlYWEyZGZUUGtuZ012Y1FvNUlmeE9BR2N2eWNyblpzNjJkY1pV?=
 =?utf-8?B?SW1qcFN6bFlRZDFpRWtWcTFOSUl1Uk1lSjFaSHRIYmFDb0o3WCtzNE4rdUkx?=
 =?utf-8?B?amJYZTFWRk1jUk9rKzA1dVFjM1gzdFVIbGdyQXlaNDNZWUw1YkRSRDllbXhV?=
 =?utf-8?B?WC8wbmRXU1Z1UkFEZGdaU2VhOTAyMExXUTJFRjlMVEplNFhOZWNBcjdYaEpY?=
 =?utf-8?B?UGVML01uVEdKTjhlbXhHb2JaVS95dVNRRThydHUra3pqcTdyR1doc3BqcFlQ?=
 =?utf-8?B?QVRFQWhSUnBOcFhFV0IybjRnQjZ4YXQ2Yml2MHlSMlhzVDJzazRDZWREWlkz?=
 =?utf-8?B?Z21sQkY5VURWSzNac1JXVmVnTXN3eFZxOHRpcjZ6Y1FtcHhNRXVvbUl1dmY3?=
 =?utf-8?B?d0tmZkxSLzc4dGVBQ3U1VkpTeVg0Vzl3WWVHcmlmQ0tVY3BjZXg2R0JZN3ZX?=
 =?utf-8?B?QUd3dThBWXVaTGVha3lIc3NsY0xuS2VSOC9vU2lSamhHNzltZUh6MDR5Zks1?=
 =?utf-8?B?cVZBanEvZkMzeEdqRkI5bWlEU3NWbGt4M0VDSEo0VG04RmRkemNQWW1nMk5y?=
 =?utf-8?B?K2pTa1EwV0g0VGV0MVdUZTM1d2cvUjVLa0NIbVdHUFZscTdMOUZ6QUZyb3BE?=
 =?utf-8?B?Vkx4LzR4eTBGakRxOVphSDJ0cFJQbnh5REhCbXhXWnBKNitvWENXSzVlbnhu?=
 =?utf-8?B?bTk0MXZ1TUxRVEgrNEpYNElkMnFtaFh4N1BEMUgySzY2TU5GRE1XRkNTbCtx?=
 =?utf-8?B?dHhrYUZ3R2d2OFdnVThDU01GY2JyMktHbEYxeHpvTHBiMlNNWFdGT1ZJWGZU?=
 =?utf-8?B?M0FSc0hsb1gyYmwyVCt0VkVmdy91RjU0cENoV28yTWg5ZEFtWW5oVTVuVnZH?=
 =?utf-8?B?ZC9SajBUOHBFK2pRY2R1bWEzQmtGeDNRYUl5TFZFdkc2N1BCVGF0RUh3a3Ew?=
 =?utf-8?B?amVNUzJrNGtaWnFLVmc1R2dXTFlUQUFKY1BnWW5uRjhoaVVtNlJTT0dtNHJi?=
 =?utf-8?B?dHdFZVZjZGJSVTkyVzFTZDJENjJFYjNSQ0V3a20yR2lialc1MHZpYldVeExl?=
 =?utf-8?B?Q3JzQkJSZ3dtWGw2OGVUWDlXVjI1SmNGTzdaWTFNRWNZN2cwUjR2NXFabFNv?=
 =?utf-8?B?U1VNRiswTWY5WVNER0kvZXBQdEpld1EwQ2Y3OFpyUE9iOWNiNVUyNlZnakRB?=
 =?utf-8?B?d0lNVGVVWVIrV1RJMmtFRmlpU1FXT0JOL2tGelpqMGhrRGp1V3NPZ0poWitt?=
 =?utf-8?B?MVhGQjk2RGFnclI5U3BjdkpLbk9USElKbUd5bU1WbjdFZmVJNng1YkIwZlcy?=
 =?utf-8?B?L2FsQWFvbnhUZ2ZoQkN4a24wODJUSTZ6bDVNSWVsVGcvSlVWVFFEelNVT2Uw?=
 =?utf-8?B?RnlyUVNNSjAwa2VQc3FGUFlqalE4YlBybVgzSTdkdkZqWEwzYjUraUhLRU9M?=
 =?utf-8?B?WGV1U2FZY0ZEaG93OUIwNTc5eWtzUDBkQWs0WXlkN2Nwd1JFWUdWcXdXdHRv?=
 =?utf-8?B?UGVlMkllN0lwYW9QT0ZVdDFHWkFlYXIrOGtlbjkzeGJ2M0lnclZtMjdxdGtT?=
 =?utf-8?B?K3J3NmZZMkgvNmc3ZHBwb1ovaGZRQUxUdmpROXM3Y2ZMY29LLzEvU0dLcmFO?=
 =?utf-8?B?VFBSbm9pVmtYYktYQ3Q3VmNxR2tqTHA3MmtBaGN5Tnd4dGREakJOdFhXWlJ4?=
 =?utf-8?B?WnJjSWJHaGVvUFk3UXN5ZFhXU1hVVkQ0cTA4VmdGN0Y3SlAwQnhnWEdrT3Zl?=
 =?utf-8?B?ZUtTdUgzTC9qNVNheGYwYU1pcGYrb3NjSWU2QTEzY3hqOEJuRFRXVHhHM0tm?=
 =?utf-8?B?L1BNQ2dLczdxb3lZSFVZdytkdGl2b1k2UDFNdFJWb3FIS2VFTVk0L2NFMFkr?=
 =?utf-8?B?MkJxZ2tQVVg5OWVPUzQ1dWVRQW9EaU0wUVF3K0FTZU8rS2Z6ZEFGY1JjemNq?=
 =?utf-8?B?blNCL2dEcXkrQnRNM2VIVGxMZUNLWGRvRVpWQnZqUU14ZEhUM2xzWURLbi9p?=
 =?utf-8?B?MXZmT0NLdG9FK0xSRjB5RVY1UU1uaDl5TFh1Ykpoc1RnVUZSTDg1bUtpWk03?=
 =?utf-8?B?QXVkU0JRRlA0dHBOYS95SytsZm1zQnV6R2ZaQU8zL3FIaGVMWnhKQXhhSWtE?=
 =?utf-8?B?WHU5cm9oekxLM3hJbmVaMkpHc2hiQjJuY3ltY0hUNHc2cmw1QWJjd2lkMUU4?=
 =?utf-8?B?MU5HQlA5amhxZURCZzJjOFBZMlBGK0gxQnR2R0FZVll3WSsyVWxVYkhic1JJ?=
 =?utf-8?B?bTRINTQrdW94WXVZcWtoTXZuSnhBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8276B6DDBA37E846A7258B9C5634B79F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nNfCAmk48OriGO6ZC13O3OezgQbQrOM5px/sNUpH7qMCEc70R2uv4HLNgiRDG63VOZ+ey08DwwwlfAeyFRlzhI27LTs3P81VImK0vt+IPR+OnWiHcLAw0EivKziAgq1taE/930r26gwMlx9K58f4HbAXNtMGfNNIwkuJaek1DlYCoelQgq6WA5fpvywUvMk3ihCpFjiPzre09xrrGZMIozAhBNnMCxvcZNd/dBLmEtWg3xSLIi2mY/zUa0rzq0yOx1IW1Yf9zJAk2QL+PbsOtp8ad1gKMjQxXZ8Z80I8jHcR03/8lqOG5fMD2Dm9PsUkAhqfQuzhId6sy1Apgl+8Y2BRRi+dC/vQZH9cLpbN1rplW1ehNPDRwSk2gtYWpVQK7Upf3KtnIwspB3ibq/IBfA2k2RbQ16jAJeIlotaL841FKGOIpnrMdYOK8I9mGLWhIjguIYjNT3FpTecNPjggmiX4s3Li6enZxhS1Xm/A2DNEAik9BK8xAY1tYlupOz1fOsTkqbv7zXQG8Hy/XeYOnUohNxGxJsUkWVKL8pWaCLleUYcxZwtP20JVDm/hjzQOOexoHbP/hQL0F1mJ5bfznVceuSqsBtE+XNTaIF4DQQWtSbbmJLtJQFi9L51cMvJv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf247d3-4efc-4de9-d1c7-08dc588b8979
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 11:52:30.9427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NRgmJIadHTxhqccbXYZTrjdbFhZwh9whk4k3xHzJBaaIkh1rPQuemA8RUHiBOxBl+F7QnXxwTSQKez/7zzDGadCMxUIOCzHqAmA62bhB0N4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7265

T24gMDMuMDQuMjQgMjE6MzcsIEJvcmlzIEJ1cmtvdiB3cm90ZToNCj4gKy8qDQo+ICsgKiBUaGUg
ZnVuZGFtZW50YWwgZ29hbCBvZiBhdXRvbWF0aWMgcmVjbGFpbSBpcyB0byBwcm90ZWN0IHRoZSBm
aWxlc3lzdGVtJ3MNCj4gKyAqIHVuYWxsb2NhdGVkIHNwYWNlIGFuZCB0aHVzIG1pbmltaXplIHRo
ZSBwcm9iYWJpbGl0eSBvZiB0aGUgZmlsZXN5c3RlbSBnb2luZw0KPiArICogcmVhZCBvbmx5IHdo
ZW4gYSBtZXRhZGF0YSBhbGxvY2F0aW9uIGZhaWx1cmUgY2F1c2VzIGEgdHJhbnNhY3Rpb24gYWJv
cnQuDQo+ICsgKg0KPiArICogSG93ZXZlciwgcmVsb2NhdGlvbnMgaGFwcGVuIGludG8gdGhlIHNw
YWNlX2luZm8ncyB1bnVzZWQgc3BhY2UsIHRoZXJlZm9yZQ0KPiArICogYXV0b21hdGljIHJlY2xh
aW0gbXVzdCBhbHNvIGJhY2sgb2ZmIGFzIHRoYXQgc3BhY2UgcnVucyBsb3cuIFRoZXJlIGlzIG5v
DQo+ICsgKiB2YWx1ZSBpbiBkb2luZyB0cml2aWFsICJyZWxvY2F0aW9ucyIgb2YgcmUtd3JpdGlu
ZyB0aGUgc2FtZSBibG9jayBncm91cA0KPiArICogaW50byBhIGZyZXNoIG9uZS4NCj4gKyAqDQo+
ICsgKiBGdXJ0aGVybW9yZSwgd2Ugd2FudCB0byBhdm9pZCBkb2luZyB0b28gbXVjaCByZWNsYWlt
IGV2ZW4gaWYgdGhlcmUgYXJlIGdvb2QNCj4gKyAqIGNhbmRpZGF0ZXMuIFRoaXMgaXMgYmVjYXVz
ZSB0aGUgYWxsb2NhdG9yIGlzIHByZXR0eSBnb29kIGF0IGZpbGxpbmcgdXAgdGhlDQo+ICsgKiBo
b2xlcyB3aXRoIHdyaXRlcy4gU28gd2Ugd2FudCB0byBkbyBqdXN0IGVub3VnaCByZWNsYWltIHRv
IHRyeSBhbmQgc3RheQ0KPiArICogc2FmZSBmcm9tIHJ1bm5pbmcgb3V0IG9mIHVuYWxsb2NhdGVk
IHNwYWNlIGJ1dCBub3QgYmUgd2FzdGVmdWwgYWJvdXQgaXQuDQo+ICsgKg0KPiArICogVGhlcmVm
b3JlLCB0aGUgZHluYW1pYyByZWNsYWltIHRocmVzaG9sZCBpcyBjYWxjdWxhdGVkIGFzIGZvbGxv
d3M6DQo+ICsgKiAtIGNhbGN1bGF0ZSBhIHRhcmdldCB1bmFsbG9jYXRlZCBhbW91bnQgb2YgNSBi
bG9jayBncm91cCBzaXplZCBjaHVua3MNCj4gKyAqIC0gcmF0Y2hldCB1cCB0aGUgaW50ZW5zaXR5
IG9mIHJlY2xhaW0gZGVwZW5kaW5nIG9uIGhvdyBmYXIgd2UgYXJlIGZyb20NCj4gKyAqICAgdGhh
dCB0YXJnZXQgYnkgdXNpbmcgYSBmb3JtdWxhIG9mIHVuYWxsb2MgLyB0YXJnZXQgdG8gc2V0IHRo
ZSB0aHJlc2hvbGQuDQo+ICsgKg0KPiArICogVHlwaWNhbGx5IHdpdGggMTAgYmxvY2sgZ3JvdXBz
IGFzIHRoZSB0YXJnZXQsIHRoZSBkaXNjcmV0ZSB2YWx1ZXMgdGhpcyBjb21lcw0KPiArICogb3V0
IHRvIGFyZSAwLCAxMCwgMjAsIC4uLiAsIDgwLCA5MCwgYW5kIDk5Lg0KPiArICovDQo+ICtzdGF0
aWMgaW50IGNhbGNfZHluYW1pY19yZWNsYWltX3RocmVzaG9sZChzdHJ1Y3QgYnRyZnNfc3BhY2Vf
aW5mbyAqc3BhY2VfaW5mbykNCj4gK3sNCj4gKwlzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5m
byA9IHNwYWNlX2luZm8tPmZzX2luZm87DQo+ICsJdTY0IHVuYWxsb2MgPSBhdG9taWM2NF9yZWFk
KCZmc19pbmZvLT5mcmVlX2NodW5rX3NwYWNlKTsNCj4gKwl1NjQgdGFyZ2V0ID0gY2FsY191bmFs
bG9jX3RhcmdldChmc19pbmZvKTsNCj4gKwl1NjQgYWxsb2MgPSBzcGFjZV9pbmZvLT50b3RhbF9i
eXRlczsNCj4gKwl1NjQgdXNlZCA9IGJ0cmZzX3NwYWNlX2luZm9fdXNlZChzcGFjZV9pbmZvLCBm
YWxzZSk7DQoNCkFzIGJ0cmZzX3NwYWNlX2luZm9fdXNlZCgpIGluY2x1ZGVzIGJ5dGVzX3pvbmVf
dW51c2FibGUsIEkgL3RoaW5rLyB3ZSANCm5lZWQgdG8gc3VidHJhY3QgaXQgaGVyZSBhZ2Fpbiwg
b3IgYWRkIGl0IHRvIHVudXNlZC4NCg0KPiArCXU2NCB1bnVzZWQgPSBhbGxvYyAtIHVzZWQ7DQo+
ICsJdTY0IHdhbnQgPSB0YXJnZXQgPiB1bmFsbG9jID8gdGFyZ2V0IC0gdW5hbGxvYyA6IDA7DQo+
ICsJdTY0IGRhdGFfY2h1bmtfc2l6ZSA9IGNhbGNfZWZmZWN0aXZlX2RhdGFfY2h1bmtfc2l6ZShm
c19pbmZvKTsNCj4gKwkvKiBDYXN0IHRvIGludCBpcyBPSyBiZWNhdXNlIHdhbnQgPD0gdGFyZ2V0
ICovDQo+ICsJaW50IHJhdGlvID0gY2FsY19wY3RfcmF0aW8od2FudCwgdGFyZ2V0KTsNCj4gKw0K
PiArCS8qIElmIHdlIGhhdmUgbm8gdW51c2VkIHNwYWNlLCBkb24ndCBib3RoZXIsIGl0IHdvbid0
IHdvcmsgYW55d2F5ICovDQo+ICsJaWYgKHVudXNlZCA8IGRhdGFfY2h1bmtfc2l6ZSkNCj4gKwkJ
cmV0dXJuIDA7DQo+ICsNCj4gKwlyZXR1cm4gcmF0aW87DQo+ICt9DQoNCg==

