Return-Path: <linux-btrfs+bounces-14604-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EE9AD51C9
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 12:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4BC16A005
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 10:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C195261575;
	Wed, 11 Jun 2025 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FkcU9L9M";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="l/vllslN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BA720C485
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749637665; cv=fail; b=ZnNusQyFv58T7fXnkx2P463RJvDbbD4FdDL0YlP9X5Fx1f75ddeUX2T/VsCXk4d2Tf3rJKl9+P9NpR86Nzfy6+ivENzQ9QZYDeIjIxIcdFmsrtAV5o46fzy0Xk9HD08oT5zaz1SNJt/UXqHuuaaX33zPrZN4TD62zDCWNc3lK8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749637665; c=relaxed/simple;
	bh=hwAArB6z9ozdqdVeym0zky5GU/zAP/ALmwBccRlwyzM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FNcFucjNfkVI6rPa3zQRweIJwvQTUC9FKedAynBZJfvR/+RTR+eJPa3XZd+D8uqr00QfcwykuC1NXEwtv1qASoH8Lz6xcyBN5vSBdAwMQJr9vYFVi00poOYsaWR+uKdSX30DAyFa4Td+0PYrwk32Zimh18AG+KN2B3RP0czh7aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FkcU9L9M; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=l/vllslN; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749637664; x=1781173664;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=hwAArB6z9ozdqdVeym0zky5GU/zAP/ALmwBccRlwyzM=;
  b=FkcU9L9Mx6TKQQN5GUEQ4inkBBDIu3ZV2x6Id4nqTOjg1FxJ99BY/Hcr
   k5qX51odYfRpbSDdqVWsej6yscBFLqetpCtljLqlTFqH/ypNYs9A/j4aB
   DdJTpHPN4kTxPFY6ru3oJ1JsetzyeoWxXgVoVVU/tulne+i3jRRAtUWTV
   pG0sOBI5JN1iNLRkzVpev/yPrbrysBdVQfXcpOXbErxQqIWSiZqy+FM+p
   niCwDQcnYtPcMtAIP9MKi67TwL9SquRNRAkLnXjA8Hk2nQUX88tt3RPmV
   BK9xRXkHhFDOPnhaOyYaKq9zBdac+8o1PjZf9CSoVMeZFkYYzOTUBFZW0
   Q==;
X-CSE-ConnectionGUID: IWpfMRMhRuSPrwjomePNWQ==
X-CSE-MsgGUID: 4mK/tfe/Qc6r3482YZBf1w==
X-IronPort-AV: E=Sophos;i="6.16,227,1744041600"; 
   d="scan'208";a="90376543"
Received: from mail-northcentralusazon11013066.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.66])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2025 18:27:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTuuIvZtzAp0yAR1WXyKPMtXvhD09GoZyk9N8FA75tEf8v84d1J+/Rr9cSDzpwoDWSx0Ll9HHfQ/KSymMjxhWcztuCPlmOa2QCgq11wU6caril2+ozgKEeo0Jbn9wps1T0QRTwwWX4JEKWzJvQRwSqQ++UQyMQFePJgAlpxEUGIPkTPUOfh302LVX72LXEiBFU0AyHR1NLxh2RRfzym9JUHjcS3Fb0kMiXDo+rANTo4KnjL2bJgs9vc9Y0TTglsV1TDxJYqCZH23pChApCI61yOhCsmTt2yMFu63c/cQ2z+zPQQSHOlXeLY+R0dBHYxNTMo83ETHLMzqZhbkWpRPIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwAArB6z9ozdqdVeym0zky5GU/zAP/ALmwBccRlwyzM=;
 b=Ro0DUftJuN/EZoV0dSoukRqGOl90RGcIiaaO4t3b1xJZVI4nb0AjHQ8pNba73npizVB5f1f9/ApJwBTog6VJCsK+v62cX+jxoy8SaR92jzKSu6gALaph9810/jr7Rthj60wAci0HdDYzsXoY8fYejxPDBz/vxSpO612gBce1F3MAd6IBLSOE2gDmFC2TZIlz/dHj7LSxXDRMfNi/0BZs5P62RBxIKDzLLy2jJk5yHlsgjeO78wD6g3nzAanza1DH3qf+nkFW4JbAGSrXiec7fTIpfShbihwD5DWgjnJkmKDqNXia/TwWLsK0YYCIQZmjc0zHdBEppA7OF1TyoSOAJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwAArB6z9ozdqdVeym0zky5GU/zAP/ALmwBccRlwyzM=;
 b=l/vllslNrbwtpmvguUNGof0OMWVcAMvYJfm7XtOskb2upc4y0iReJvWzbR0XzI/j2eFFfPDAUA3SC3aE7UGq2bzy/qSaYU/7YLJLFQkysMOa4ZEMmE+XcWuPaByky70NE/yWwFvyjpFNIuQpkGTWwGonMIBYknsZHRrxRqX0dxQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7792.namprd04.prod.outlook.com (2603:10b6:a03:3b8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 11 Jun
 2025 10:27:41 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8792.039; Wed, 11 Jun 2025
 10:27:40 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Folio pos + size cleanups
Thread-Topic: [PATCH v2 0/4] Folio pos + size cleanups
Thread-Index: AQHb2gHwxPRzP0X1dEeVqYBmGZhzCLP9wuYA
Date: Wed, 11 Jun 2025 10:27:40 +0000
Message-ID: <24ba5684-5146-4d44-9356-cb4a72aa4f02@wdc.com>
References: <cover.1749557686.git.dsterba@suse.com>
In-Reply-To: <cover.1749557686.git.dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7792:EE_
x-ms-office365-filtering-correlation-id: 3543ec1a-06df-4ed7-986b-08dda8d29860
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c3ArL2lRQ0RqTjBCSGlZWVVZTnF2Qk5CSExKdjlHcm9oWFprNzNQQVkrU3hx?=
 =?utf-8?B?RVhENlozbGRmdmZlMnR4WG5BakkxWE1tNHNHR0s3eFFYZGtyYWNxZVpoMXdh?=
 =?utf-8?B?U2VVamR6ZmwrZVdHdm8vQ0lTcDE3SG9heTI4cDMzZ09tYnI5NVNLclk2Z2kz?=
 =?utf-8?B?RXdLQUNaVlZnNXBWeFdxUG5zYld3UjNUTVRTK1Y1RWs2UEFEc2dvTzJrd0hJ?=
 =?utf-8?B?UmFiblVDb1ZVMnFBcGdaUTlQTHFQSGlyOXFlbW81ZTYzdXlCRjRYTVVJNkw2?=
 =?utf-8?B?R0VYdVljaWx5NE9nSDdKb1lSQTJ3MlZhcWNFa2I2WTRKYndBK1hwbEZxZjdU?=
 =?utf-8?B?UDF2YXlBdk9lbklKbWhIbTdLUFhXSGtvTkZsL0pxbUNzYkIzRWdCN3dOcXo1?=
 =?utf-8?B?R0hFYkI4UVFBZC9VNmFETUxUNGxwaVdVWlU3TE9xZCtnTVpHWURFUTNuSUVQ?=
 =?utf-8?B?NTFKdngzcDJmc0xZOUtMLzZlODlDV1ZLNUN5WXkxMW1qWVp3dGV3MGJPSWho?=
 =?utf-8?B?UUVyZFppWGJsL2hrQmVFTmk2ZCtGajR5MGNDTFVIcUhndUczVWNjL3Z3U05J?=
 =?utf-8?B?Z1ZDZ1IzRVhuMWJtTUkzNmhDNzRMazFnSEczWGR6ekV0TDBJeU5PczFnT3dX?=
 =?utf-8?B?bG1tRzBZdTltcjhRK3dkSWFNdnlhZXNrZHpheFRlSmRJSzF6VGN0THVGVitp?=
 =?utf-8?B?Zk1SMkJ5NXZUTzBMM1V1d2hkSWVlMTRmdVZ2UExNKzdUVEI2SlJBU0RCSXpq?=
 =?utf-8?B?M1V6QmtST0pIeTMrYTQ2dVp6Rzl1cDVLMFVlRTlnNGcrT1NvZFVXVDFiMEx0?=
 =?utf-8?B?WkI5WnN4UE42cW5KTE5lWmQ2Nk1Bb3loSStPZm1mYkdkeU4zMTA2aXdJQ05T?=
 =?utf-8?B?WmE5cnFZZVptalVnbmpMdEF6UHZvVWd3Ym0zRFVIbnNLckpBdUxpLzVlL1pv?=
 =?utf-8?B?ZC9BNTRqVjgzVmdGbmNhZkNCS0tJQ0g0UVcyT3cwUkw3bFBUODZZdktlSE1I?=
 =?utf-8?B?VHVrQUVqaGFsVm1aMjdCU2NZdU5DRFBzT2VCUTB5UkptUWVkbzA3dkplVXlJ?=
 =?utf-8?B?RU9CQWcweGJTNGNjQzdJUVZIZFZCbGllQjQ5S3RwSFF6SjIvUnZvQWVKek9y?=
 =?utf-8?B?VFo4K3JkQ2VLZW5WUFNyRUNWM0R3cHZXOEt3TnN6UlVlR2xkMmo4dHB4R3JE?=
 =?utf-8?B?N1NQcjh4dmdCODRDL0hYY2tiRUNGeUl6TDA4RGo1VUlnNnVPTXg3NGw3TkRI?=
 =?utf-8?B?SHhocHVrcHJFeWhEWFBGY0NVNTZlNExJd21OeitKNDMrcy9VS2dmcUVoVUl2?=
 =?utf-8?B?QkRDdjRnMVpVeVVGdTdVZUlEelFtbHV2QitSOGx4MjdzZm1RQUtYdUJMaExG?=
 =?utf-8?B?K2FOV29BckF1STE2dXdWRG03UEh3T2RHY2VXOVo1Q0d0cVd5TE9ZSDlWSUxr?=
 =?utf-8?B?bDZlbk5jYUp1dXFNa2lQc0dLWjMzTVdIY0V2UTZQZ1VjdjUvOWY1eGpweVBZ?=
 =?utf-8?B?dHVDVjZ2NEREY01hd3Z1Vk54SXg3NEJwNmZHNHVsV0MrN1BmYVozd0Y4NTFE?=
 =?utf-8?B?WndaNGl1MmZFdlVqek1rb3prUkhIYWRObkU2STFlRkMrZGpDTTJtc3VLL0p1?=
 =?utf-8?B?TVpBa1dvY2E1SlN5NFJKMUxBQUdLaFk4aE0wWlpuNm9CK3IyVEE4aVFFVjJW?=
 =?utf-8?B?dkMvZGppbUQ0TEtwb0lNZTVaRXVMUXdRWWN4bGxjaWVtODQxYzBmU2RGb2wv?=
 =?utf-8?B?UGYvTjMrRTFGK1A2M1VkaURqdFJ4MkhoMHJNVEYwcXV3Q0x0RG96b3dMTlhT?=
 =?utf-8?B?STlNaFVldEVkczZTOXV0RitlUmtDei9sNXBWMEdZL3ZXYXM0ZG90NnM3THc1?=
 =?utf-8?B?T25GNVBTWWpUckJlQjc4Y3JkMDQzKzJHREdFV1Z0ZWZ3M1BlbGU4ZkpLME1Z?=
 =?utf-8?B?enUyMm9lTXZEY0dEbVpXVWpUSVBadlhFc0hrVC9QbnkxWldLVDBwSUMyNG9K?=
 =?utf-8?Q?1kpVaaQZet0ZZAGCEnXHcNri6sQC7A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?alQ2NFM2NGx3S3FFUkNmMitmOVVobUU0dzJGQ1pVR0hxREVVUERmVGwrZVJX?=
 =?utf-8?B?M1BucXpwZnNFcnVsamNUZGJDSmxES1FveGNXWU42VnFxN0hwelhMZlQxL04x?=
 =?utf-8?B?R1h6YnhsRnQzaXFseXdpVzczdnlnZjBwOUxOak5UTFgzVzRuUzhyanorQWVZ?=
 =?utf-8?B?WVRhS1U0ZGkzOHBVbVk2RXh5UjVuY0xFZ0ljczVSSnFodXMwSFo2OVUrNE41?=
 =?utf-8?B?aWpOdXlaUjRCSTV5OVBlQW4vbCtRYUVlSHZIWk9DeWs2VDE1enhjZFBWWHVN?=
 =?utf-8?B?VmRHbmx0cHVvWUR5WTIwT2Y4WnNnQ2owNkZ1blB3UDU2TjhVZUJqVFlRRTRL?=
 =?utf-8?B?bjhlWFR2OHVQYUZ6LzFZYi9oNVU4dFZVb1pKS2VzZVRkdHJZSWdhRjk2YXFH?=
 =?utf-8?B?MnZVaHdQUGR4TDBCN3QzeWZld0JIeEtzZkZnQWlQNUIvRXh0Nk1FclRRa0x1?=
 =?utf-8?B?M3pPMlBnRHIxTEhaMmRVSEhUVjRNVTZKSENXMjdVc081dFdxWngzUWdIYzhk?=
 =?utf-8?B?Y2QzT05HRnd2c0RPR1BpaTZJd0F5SDYwQXhZNUl5SlJJWTdKbWUvWEVSZWV0?=
 =?utf-8?B?RnpkNWdJOTRWNlY1WDNRS0gxbE9HMVhsYkdMUU1HTDdLOS9jdkt1QXMvT2dY?=
 =?utf-8?B?aU9EQ1JPZld4MWxoNXpoUG1XMWRtdVhJNW5tYUREWVlmWEorOHdOZEE4RFow?=
 =?utf-8?B?d3ZUNFBTaVd4U09POVQ5RGNXUEliUGI4Y3A5NkJITlBRU3JIam9sbldMWFlj?=
 =?utf-8?B?R1U2QTFKaWhYL3lkVXI3WG12dklOMDVzWjNBekdXTERCVGZWRHpHYllOZ2h0?=
 =?utf-8?B?bW5LVGFUNXRNbGZvdlJ3b1cvWUNra2FGRGxSVGI2VTNxNmZGenROQVFTK0lH?=
 =?utf-8?B?Q3hWYlBwMnVYQkxYb2VhMkgzZEpyUkJEbEFUeDRQdU5hOU9wQmhhZ2trMlJZ?=
 =?utf-8?B?czg0S3dBSTl5QmE2MDFaMy9lczdtVHJsc3hxb2dZZ05pWDRwczNWdEZXZGN2?=
 =?utf-8?B?ZWZVMVZXRjBQRlMrL3BxcFAyVmgzWUVucVBmNXNDcWFCNktZUktjN1pSQXVu?=
 =?utf-8?B?NXNmU0lGaGhSMjBGTWNGZTVkZFJLdEZDMlVDTUxiMDM3U21VYzNrNmt5Y0R6?=
 =?utf-8?B?ZW9WS2VtWUVsRUkyNnJUMWtzcytXNUZCK3h0VjhDNnRNRWY0WVNsVjY0ZTJs?=
 =?utf-8?B?QU5SVDhobDl4UFgyeVFVTmcwQzVkVWdrYUFERGtDeHVEV003bm41U3BDSkhy?=
 =?utf-8?B?R3pMQWlTNzU2MXNBOGgzYWZVb1BWZGtMelBXbjhwZWdFMXU5UEdsdlB4Z0JV?=
 =?utf-8?B?NHdNbysxQzIwbkNLWjZsd0xOWW9JM2RYdnpDUUQ1NDJJU1dMRFNkUGhyZlAz?=
 =?utf-8?B?VytwZDVFbTNrTmorVnN0cFgvakhPVFdQZDJEVmpkbjdBYlZTd0VnWjFkMEIr?=
 =?utf-8?B?SXUyZGtyanRsek5ITmdUdGk2UmF0RFNxRUh1NmhCSHpwRzQ4YnZ5NzBkU0x5?=
 =?utf-8?B?MmtMTVJDZ1pNblh1V1VONzkxK1g1ZTV0NUpHUE5Qb09DSGxiMmhQVmlWdEsw?=
 =?utf-8?B?N1lSYUFtMlp6Wlk2TnFycGhnYlhUak13MEUzMXNxSGhaUm9EcmRzN3lIc0JB?=
 =?utf-8?B?MERteiswVkxiZWg5Y01pejF1c01GVkdyUWxBbEVJNHhTUzlPUVQ2STFhVVhM?=
 =?utf-8?B?UGQ3dWxJRFRSNGhJOUZkdUprMitQZzhZbzIrWEoyblB6ZXQ4WXlSamlyVlFT?=
 =?utf-8?B?b1Fncnk0dGNoWTd0N0t0TjFzM2ZKYnBxME5LNEJIQ3RJRU5kVVpQcjJIQXZV?=
 =?utf-8?B?NXRva05RSUQxYzNNbnlmWVlNQit2bDU4MzVJYVVYM01VTlpZMThzc1E5R2pM?=
 =?utf-8?B?MFVJTzQyZjNhZkVFajhGaWl4YmJjSmlUNHE5TGRINXI0M1RwZ284dFlnRjFK?=
 =?utf-8?B?cjZzdDhicTlkdURveVFqczQxbjl0cXFLMWtkNEhqeEhXVXhRQWY2bUZ6Vldp?=
 =?utf-8?B?WGxiM2NOMEwrTTF5TFBldEl4OHN4OFl2NTI2aHNLbUhoSFpDYWZ1RDNONHdZ?=
 =?utf-8?B?dVlyREwrZi84dU5vdStsWmdQL0I1dVhZTkRUK3hxVE1hdEZKd25ub0tYaUpX?=
 =?utf-8?B?TmUxTEtuK0ZEaUloa2dldFhqT1NFZ0JNZzZ0anB1bUJHYytOMWIrRGdiRG1k?=
 =?utf-8?B?RXptczZ0VWo3RXg1N09tUjZHeEpabVZsVkwrakRjZXpmeWxNOEdSZnBiMnAx?=
 =?utf-8?B?bWpZM1h2ZHZ4VFlHS1B2cTAzNm53PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A84C30A9E927F439C12B7C869086AE0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c49KK828mduMC7DoylGyL2Uto0aH6iJxY9MwZv3X9ch5t34hd/YH6XKj/tWKRKe9pl25HY5cz7rh5s7tLEBGK3uetONygOj1bORg0zLLEEc/igOCxg5I40uMJ0kkLsk0rA7rUAUEEBkbCXs1pQpLfYSG6oGsH3mJOvGgIapTpRltoH0alcTZNHxZAY89uChex022GU0XVxC0dyJHwd5yI0YOpzVBjc2tmCC98LNXtg4Rkvfl1Qofvhc8sbrv8c4h8h0pVN4ySqGB9xo6XrVD2DV+uHRh3wmIpDBiY9tcyRkVexRaXOnXFsoyGZ0XEsLrApnlZemoadnOLfywmA7RWD2ivD1BcpAQX2Rsq2crxqfB7zoMFY0RUYQoGEf/PiKWfK2B8hl8xqzmavXHHTZAr77w6sFISxLMjwgjF3xNyCRel5rL5TdyvHRIEL7zIzX7Phb0IaJAkh5zt1UDrttd0S1jNj/lIyBvMyq2FxreaRX6PnRwSc99eBpDCfW8qK5+5fsSv7NANGK+dhWHcbaAJNHaJz7n69Cnr2DF+GBhu8gu5BrVJ6ENYcg9wcJhCqqa0N3+gyRhaPr5+HlqiYKC3JS1v7CCLQ7FuNbAlYMdpj/0JKS/dGeS0IpXNwfRdbyQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3543ec1a-06df-4ed7-986b-08dda8d29860
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 10:27:40.9035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3jdiRBzLVpRqXAcLg/yDw9QaPc7/VMawa0vTrodR8Qs+XfBiaPp7Y1QMt52Xk/YgyOM0MkFm/6D+xIIAH0f4Bc89GVXtDbwY009pbGgNMsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7792

TWludXMgdGhlIG5pdCBpbiAxLzQncyBjb21taXQgbWVzc2FnZQ0KUmV2aWV3ZWQtYnk6IEpvaGFu
bmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo=

