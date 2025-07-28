Return-Path: <linux-btrfs+bounces-15701-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1181B13455
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 07:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F65C3B87DD
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 05:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF15B21D5B5;
	Mon, 28 Jul 2025 05:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pZriGKyj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="u8Jjzq3R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723451D5147
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 05:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753682140; cv=fail; b=F/B+zUPECGAeIYQNUWHX9onNXy9lDbFacUqT5Yb/AfJEL4YpUbTlmTRSGWHIXparW5iAF/l8QiDOqLkboRsoRmZoZk1GbsXxPyvLf2OmlC2Tii6qMw//44OfjlrwqANRBSQzivmCki2WL4K+ofQbDMU7hcxnAbQ2tcSiY59lXfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753682140; c=relaxed/simple;
	bh=amaKxWG9lyzrXceFiX5CQ6Synwuu24nFIJMWciVE8r0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rLRTvNAC1OgNwGk0P6eFtffEsUdhUVap5Rj28dXew0uRNsaNauHPxHB2CxFtLKvTryckHTAI6MbcNQc2mb1raR1flFDv/dPNnymjzBqQXicdswHQm0NbhLdKTfKlT6W4yWS6hz42fNfgKDWRh1oUUpqg8cM5aAZHAfZpNbDIKKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pZriGKyj; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=u8Jjzq3R; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1753682138; x=1785218138;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=amaKxWG9lyzrXceFiX5CQ6Synwuu24nFIJMWciVE8r0=;
  b=pZriGKyjyvj1r7Lpnc7Qur+qqdL5zm2uoTNObUreuDLBCi5hKlXq6y03
   ALE99vdcFnR2gAgf+05cavP2FykX92ZsVpQ6jAxIQjWo17lOzqfEfZLOI
   gFcuvbC5wkCFJzr2cUfKh/CIRr2zrRShrBFF1nomv9TRhm/VHC7mqkibQ
   n+0EVV7vhqbY2G9ULij04o4o06a3hSToI+dPSQchHUwyQ4paGhvjM0z6+
   Xv5TjByG60iiH9EA+deSvmVLTLLdj7wI5EYS5lcjewcK2bAUkZZ9NDDM8
   j3oAvdnSx5DRML4+CoIcAOMW7fGYfqJ6EN+kXwZRysDvO/jZvzmooxXvT
   A==;
X-CSE-ConnectionGUID: XVTGlEynS3amoqRLhuU7GQ==
X-CSE-MsgGUID: WMiqmMrLSEaW7+fjFWr5ig==
X-IronPort-AV: E=Sophos;i="6.16,339,1744041600"; 
   d="scan'208";a="103733390"
Received: from mail-dm6nam10on2046.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([40.107.93.46])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2025 13:55:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oe8KvR0pEBeJbqlOj9hcw3UViUw7OGMZN4lcKTozDYRMsARcFgQYLLIHZrOPD5Qaj6BOE9Pfc8y3UinETgWlHyZT9GVFcw3wiY794h61qZDYb1NGeemNTg+wo3CHKQ7jAQDThuaImK4kCYOCaJX0wxtG0/oLHoYAxDkj33eEbCngcfyRi5jMRbX0/XyfecJX13RfzB0zOM2bmJFrmKIUJ8XnXp6KH/UAh62pkFKGrGYl9UeNYoPv+lFoVgZeuPeFTh8IF3dSuQGocapunXy4Tsyk1/tE49z6oapgaUFatWHqcBHEul98piqf1Nm6p1NEGfNAFV7uLhtW1q1CfUpM0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amaKxWG9lyzrXceFiX5CQ6Synwuu24nFIJMWciVE8r0=;
 b=TgpjpIuIulgeTuneYlY4bGPry4EuqnQOWqEXsXdpepJf8eNVm5hAGgo5VDNQVHvF+mb5WqnEuPEXKlkQN8wz6q0OA8ho15PQwq6x8qK75ggctgyKq4cLtHbWI2kQ40MMCpW9ZCOtREcyUWPLh7+R2kyRE2sqB8HM46LV2FTb8DY6/iTvdusDMmwZenWAqg4I8SJyS/r2Dwms3yruyn4xeuV0LKlc+ZK4qyt7rFHG/v572LeLlQAA44+Xv/y/cY0+UJgihZyAq3ARZPq3htZJdUwkWgxgb/7UUAi+pA2SAJmjKIJJPfXxoH6r860m8Nh3O9wD+YehzTWmxC3aKKCn+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amaKxWG9lyzrXceFiX5CQ6Synwuu24nFIJMWciVE8r0=;
 b=u8Jjzq3RHGCwMS7Bo0U7SnorJIywJPBa6iqW1Z2gq4bgl4JSWcM6hfEcNhsU6YfaPEygo2iRRY9iu6SL6ZDoWUO0z5Fw3XmMyF/XPbyOf70TPcCqW1YGv4iN7ZGT9RyB3fSnSylx8/6nGqJwVybjDUqEKKatu/j7C2GPbz4Oc0k=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB8000.namprd04.prod.outlook.com (2603:10b6:408:15b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 05:55:34 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8964.023; Mon, 28 Jul 2025
 05:55:34 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Boris Burkov <boris@bur.io>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v8] btrfs: try to search for data csums in commit root
Thread-Topic: [PATCH v8] btrfs: try to search for data csums in commit root
Thread-Index: AQHb/NeG2gQVkv+ZOUSKPw4O3OCeR7RHDsgA
Date: Mon, 28 Jul 2025 05:55:34 +0000
Message-ID: <d2f052ad-8aca-4f55-9898-1477d6059f32@wdc.com>
References:
 <818a6ecac805e1a9c630275c8485e373ec9c4cb6.1753387903.git.boris@bur.io>
In-Reply-To:
 <818a6ecac805e1a9c630275c8485e373ec9c4cb6.1753387903.git.boris@bur.io>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN0PR04MB8000:EE_
x-ms-office365-filtering-correlation-id: a6ad8574-d0a7-48bf-0205-08ddcd9b5ea7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NkFpUmpOeEovdXV6Y3ZPZWVsTG13S2FSS3Y4TTBvUkl2cHpINEcyZEZMU3Bp?=
 =?utf-8?B?ZlpPWXNnTkJCamtWeURvZ1gvc2ppQW9KMkxEOFg1aXpuQXBvbVJCa1lIbFRr?=
 =?utf-8?B?R3U1S25OWEcvQXZDUUtpNzB5VmIvSE14RVIvbG5mazhWTmd0dVpRZVN1WVFM?=
 =?utf-8?B?T28yVDc2VFdPZ0JXai96QzRDb1M0dVhDUExPc2pzOHEwT3hhWmlpcHVQeWVO?=
 =?utf-8?B?YmhWN2pFOGN5clNCem5FVStYYkhsdDlKZG5Bd1lrTitFYWw3Zm9BdkgyWkNP?=
 =?utf-8?B?a25DNzBpcFgrZ2h0LzhFMitzL0lib3lrY3VJR1c0MVhFeGpRNURkbU9mKzFL?=
 =?utf-8?B?eE9RRlY5Uk4xNGYxRVNlQk5vbW5USnduN0E5TWRaSlZqTWViNjVSbDdaWUZL?=
 =?utf-8?B?V012aDAwMEtWajhydEkrSzBVRS9wajBtdlQwVjBoWXVDcUZVY3Z2RFA5U2Vo?=
 =?utf-8?B?cXZBM0JxZFdlN3ZkYmNsWkdPREcvNkJHZnVBTSsxSGtFMXUyVVVqVjh1bTdB?=
 =?utf-8?B?UUZFMXJJVVRYWWZuTTJWWVhQaUo3bzdNNnVadDM2bnBySXdMRGNjUFV3aE5O?=
 =?utf-8?B?U21oZThsWG9IWFpLNTd3RFBWZzBRMlR4d3I2Y3IxR2J6c3Z3clFNUnEvenUv?=
 =?utf-8?B?V1JOckFGSC8ycjJQS20vdGs0eVlPTmp4OWpqeVhyblljeUQxeHBRUUdNTWZD?=
 =?utf-8?B?aUI0cVFnZkJMb1I1dmJEYmthK1F3eHFpQVRkUXJJZkluRFpwanRBendJYitE?=
 =?utf-8?B?MWFzelBlUytzQ2pOMFBqMDBRcHpkTXhMd0lwNkdhTTR0dmJRb1I2U0N2bXg3?=
 =?utf-8?B?Smd2WE5MWVRyUEUxQU9BMlVFb251V3VoQzVEQXBWbXhuSDhPRmdnT1FRVmhu?=
 =?utf-8?B?M0lHRVp0ZnlTWnJrTTl5dllpQ2VQV1cvMFdXc0RRdXBMb0lIdGtYcU54cTk1?=
 =?utf-8?B?RGNCWGh4eDdOS0NhL3E4ZFhGSDk4R2NqUlFjclIwT0tqa1kwSmJTVDhIcnNn?=
 =?utf-8?B?bGhjREY0VWEvZTVNdkZ1UWJvaGM3R1FDSDJNcHQzcVlHTWZHNG85U1NBN1Ar?=
 =?utf-8?B?VnJSZ3A4SVBzV1oyRmJGb0ViUUpJV0JsV3NFWWJYeXJ3Z2NtQWNzbDJZKzNm?=
 =?utf-8?B?Y2RiUlA0QXV2R1NFSWJQU2lYVUNNcjVkcjhQUUlML0pUbENDSzlrU093aXBJ?=
 =?utf-8?B?SnRVcjZ0RmF5c2JNc2FUWTl1RmNKV1VkMzBvVUNNbTlhckd1S1NjUm9PTEFo?=
 =?utf-8?B?OGhzaXhhU1hBTEkwMHBWc2w1amhtNVAyN3ZjNW0vVjZxREtEK281clJsa1J5?=
 =?utf-8?B?QlU0TVc1SUUvMTZOZnd3SjJVdGhHbDVwOTFDVDhuaU14TnNUS3VHRDVqSkZn?=
 =?utf-8?B?SDAwSkFHR25hMXJJOG9LNFpMeFpUcGJrbFlGMGs0NlpydlM0TnJCYTVmaTQ1?=
 =?utf-8?B?Y0xZQUxPY3l4ZUJFU2FSQmpLNjFiQ0d0VGFvUWVtSXJhd3dQcitOenhuQXpG?=
 =?utf-8?B?NlJVTXpkaUhNdlNHbmtXZ2hnQzZESmZiVnBDem8yanh0eSs1d1V5djFvQWZF?=
 =?utf-8?B?NnRIeENtUHdkMTNNVFBkT0FESHNSbmV2MGE5L2luajVKWDZDbUptb0YxY05m?=
 =?utf-8?B?TjBIWGF0YmNnY09YNWNjNnZWbW1tazk4bFlCYWNITDE5MXF0NUl6bmpSMEZO?=
 =?utf-8?B?UENGYS82QzhJQ0pjOXpCOUJDNWxrTk5CTGtndVFGVHJTNmoyTXd3L1J2dzhv?=
 =?utf-8?B?OTdoYzFHbnBKVUVpM1ZvazRraXY0NUZmQ2Q1MjM2aGpFYW10ZUlEYjg2R1Vq?=
 =?utf-8?B?ak8yaTg2T0hWaWpMc1hyWEw2b1kvMHIveDBJZ2lVNTBiRVloem1jRUc2T1l4?=
 =?utf-8?B?bzRYYWp3OFp3L2ZnTUd6R0QxMlVaNGtoMldjWE15NE00dEU4ZWhBZlEvcEpw?=
 =?utf-8?B?Q0h6TDcvWGZxOFhuUys3OWlBMnVEZUdlR0NaV0orRlY1Skd6QXdMRzhXMU1R?=
 =?utf-8?B?aUEvaDVCT0xBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0s4NkZnV0NIOWx3KzlXUWRlT3RmeTBBam8za1hvQmhVbUdoNG5ZeEdPQzht?=
 =?utf-8?B?b3BKdms2ZDhtbVVLSklWK0swR1NROFZkbHlzd3N4akFhMFlURnZwbXp1ZTcz?=
 =?utf-8?B?UUErNm5lTFcxQzM0RDhjY3RPeWYzaEZuZlRNN05aeU1PQjVDajUrUW5WdC9s?=
 =?utf-8?B?VWcySFdpVXhpRjFJVXZSbTkzUnpqOWRUakdPRGsxM1ZtNEc3Uldmdm9mOTgy?=
 =?utf-8?B?T2hpUVh6TmVTZ0M1c0NtUXZKVFN6U1huRktFU3NkeGtodkdtQVhENDdGM0VK?=
 =?utf-8?B?eElmQzhqQjNWeUdPOTJoVG1zK2ExNWZFQW1VTC9uMkF1QXY3ck40Q2RjZURs?=
 =?utf-8?B?Zm03TE8xZ1hRcEhYZmFucS9lZmRJVmJ2OGxQYkswWno0eHp4QmVGQ2gveWNh?=
 =?utf-8?B?aXhwYXIwZEtCcFVDak5CR3RVVE1VRVYzdW13WFQ1NlIveGgreWR4WUFsc0FK?=
 =?utf-8?B?SEs3WEVBelRRRnZxL3dIYjRNTXhQc2RvY25DQUpLNzJGRTQyaVo3SlNyTGw3?=
 =?utf-8?B?d3hFcnI0bXdnalpmRVl2YjBEcnNGQ3ZiMlVnRFFnR0M4aFhwSXZ2VGQrTDlI?=
 =?utf-8?B?b1h5QjB1dW9MdHcySUgralgyd0ZQa1c4d2MxdWhqZHY1dlR0ZDA0SXQ2OC9Q?=
 =?utf-8?B?Y2JCU3NsV3BZTjV6dUdqWEtVNGFLaVZNVGZwc2FCR0h2M0RuTUVGdTRKeGx1?=
 =?utf-8?B?bkRrSUxVdGkydGRCRW5BbzF1dUZOejI0UUY1SU9IVFZPZkQrT1dxa3JhaDJ5?=
 =?utf-8?B?dXhBYmhBZFBmK2dUU2hzbjBXNENrb1owTkVtZldPcTZIZUhZTnpXN0grNlNW?=
 =?utf-8?B?VGNiUjVJY2ZNb0l3d2piNUdFdXQva1hqV3RRUVZzbmdLZEozRmNuU05MVkgv?=
 =?utf-8?B?b21GL3NNZmdaeXlhaDBSNHRGVGZkZW40cG5kcE1rZHR2T0txVCtPTU9ZQVRn?=
 =?utf-8?B?ZTJ2cXJ6cmwvM2VvYWF3SVdUK0t6aVVic0FYL250WERNUDhLWnFoNVJ0cGtT?=
 =?utf-8?B?dkVYWDM3L1V6TElRZDhDSXNNUkt0Wk5BT2F3UWZxQ0IycDVvMHZGTkpCNG4y?=
 =?utf-8?B?cnd6eEJiT3Y5WXFTaHhSUDZmdnl1alNqclJjdlNpRldsVlN5cmp3VDdkdDZV?=
 =?utf-8?B?NEViWkRzeTJDalpFc1BXS0daQiszbEVTL0NudVIrQ3lMWWVYbHo3M3dYeWdH?=
 =?utf-8?B?ZXpVZjBXMW9NV3hpWWd5Z05QbGlZV1JEM2UvaXBsMGJ2bysxaHRvZUMxdkRT?=
 =?utf-8?B?Y3lyblpMQ0NVSVQ3QzhOb2hDcWJnWGZtMDZKamtOMlkwelhWS2dybmZINHNu?=
 =?utf-8?B?WlNaQS9ReE1nRFp1K1AzWDZkNWNKa3lENkxuVi9vbmZDRm80SzlLYm91TkxS?=
 =?utf-8?B?VG1jSGVtNHRjeXdrUlZpbFl4SmdTNWlxcStyQjBlMm8wbEtnRUw2dkcvdndC?=
 =?utf-8?B?cTdvS1gxY3ZJeVlrMDcrakFLRG5LdjBJUFpZbHdWTVNETmtTYTNoY0p3L3pW?=
 =?utf-8?B?R2VvbE5GUW01eFZ3eUtrdVFWTVc3b0xIRTdlYTBFbTRzZ2JEL1kwRkNlVE5k?=
 =?utf-8?B?emFtRjZmSTBSalpqTUp5S2pZdFhQU2VUbEFmbUYyQlBFa2d6NVpuQmMrbUFH?=
 =?utf-8?B?VEpQdWhtaEhZUGxxSkx4cml3S0p5bFQxVTJJNUFQRGY0Y0hnQ24wR3NWQnVY?=
 =?utf-8?B?VytYY21PZGdKMENIazZTZ04vY0NsNXczOUhEMFBNK0VQeTdXUUtKdXZVQm9m?=
 =?utf-8?B?a3NnSmhxeFdEVDRBQUVrQkhZL1dCOXBJMXlrNHp3NnoxZS9sQU84dktXOFBS?=
 =?utf-8?B?MWVHbDdtSDl0MHR0azVXQ1ZKSFo5SXUvK1VxNzJFMlFzR0dOU0lSQlJLU2pm?=
 =?utf-8?B?aWtuKytGRzNRbmRlS1ZIbkNkd1pnRzJjaVkzTUpEYUwxZ0ZuaWtEN0wzQUk3?=
 =?utf-8?B?VTY1MGdMaWlPT0JYZUJJMVFDRnp4RTVBd242YXNGblB6ckF2R29RZzhucHpw?=
 =?utf-8?B?cklhZjEvb2xPcllJS0NxMnE0THpVN2dQNnNVSnI2T1RBVG1iR09HR3FsWmEx?=
 =?utf-8?B?QzIzUVkzcGY5RVNHdGtCbkZWWHM4QzdsRzRybHQ1eVJneTE5R2NpMEErU3Ji?=
 =?utf-8?B?STAzSVQ2clZEdDlRWEpoNEt3cW8yV3N4YU52VzU2Y3B3cDIwdU5SYUdWcllv?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A80AEEF6F5EA4A41925FB60CC4F5B196@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WGeNNhVG1p2R0dhejAUD9TaOcrVi2DevbiIHIXWSbNMJOnDBc5Pyqt2Uxzfa/55l5x4wrdxZA89ALIfZ24j8/97R+OmYPtitRQfODysf+1/l0mnh+GsgJVImGtf/xxfMq5MGDGoIl6QST3fDMyTF8ue/09wE3toz9KBgDoaSUYodGb3Zm9E5U0X92BRjaEvT3YRJYiGU+2YmR1mMj4PZVACPVZlrUHzIbjoVmYFj2T1nq0tTeGgLmmqxGvdcyoduRI0u8mrPOw5LeOiq+yJFdI4KlwGpXkt5nVIhYzUslPq8Dio5t1gYiVvnrgSS7Kh4wYVBOwTrM2CtTl6dYNVR84cAml6SD0kArS4Xdh7pYoPU4cS8a6AwDFEYLUPosikgbpdnxS3vRf3wTrpMuxOW8l3unUlNDWlRf32aLoiL4qOM+0jo+dU/ww98VP7YNFiLcfJQ8OasgRrig+qKncb4m2c61Rvklz8TBD8fyAdDhQm8izPo+caZtWcV3iFVssdXBPOtIn9icO2lwJURfd5cWfuvJLJ6M2Tz/KGFXE39cn06UXi0YyAhl9dqfsa1SSPL8bPX3dD92k24AhsK7qCQNVYJvaPlMlRkd/uZpB6zxABl/Z5KroziFDPaZQM+maQz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ad8574-d0a7-48bf-0205-08ddcd9b5ea7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 05:55:34.7722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A2hbEi8Qo7YnfAlWlyRBgNYgv7l2rMYPPyS7QhbZ6fX/mTOi8BmWZNBTFG/bq9w+k9q6pDHegnJKCusCUeqxLlNOGRGWTuYcEyjNHzGBdAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8000

T24gNy8yNC8yNSAxMDoxNCBQTSwgQm9yaXMgQnVya292IHdyb3RlOg0KPiBkaWZmIC0tZ2l0IGEv
ZnMvYnRyZnMvYmlvLmggYi9mcy9idHJmcy9iaW8uaA0KPiBpbmRleCBkYzJlYjQzYjcwOTcuLjAw
ODgzYWVhNTVkNyAxMDA2NDQNCj4gLS0tIGEvZnMvYnRyZnMvYmlvLmgNCj4gKysrIGIvZnMvYnRy
ZnMvYmlvLmgNCj4gQEAgLTgyLDYgKzgyLDggQEAgc3RydWN0IGJ0cmZzX2JpbyB7DQo+ICAgCS8q
IFNhdmUgdGhlIGZpcnN0IGVycm9yIHN0YXR1cyBvZiBzcGxpdCBiaW8uICovDQo+ICAgCWJsa19z
dGF0dXNfdCBzdGF0dXM7DQo+ICAgDQo+ICsJLyogVXNlIHRoZSBjb21taXQgcm9vdCB0byBsb29r
IHVwIGNzdW1zIChkYXRhIHJlYWQgYmlvIG9ubHkpLiAqLw0KPiArCWJvb2wgY3N1bV9zZWFyY2hf
Y29tbWl0X3Jvb3Q7DQoNCkFzIHRoaXMgaXMgZm9yIHRoZSByZWFkIHNpZGUgb25seSwgaXMgaXQg
cG9zc2libGUgdG8gYWRkIHRoZSBmaWVsZCB0byANCnRoZSByZWFkIHBhcnQgb2YNCg0KdGhlIHVu
aW9uIGluIHN0cnVjdCBidHJmc19iaW86DQoNCiDCoMKgwqDCoMKgwqDCoCB1bmlvbiB7DQovKg0K
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogRm9yIGRhdGEgcmVhZHM6IGNoZWNr
c3VtbWluZyBhbmQgb3JpZ2luYWwgSS9PIA0KaW5mb3JtYXRpb24uDQogwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKiAoZm9yIGludGVybmFsIHVzZSBpbiB0aGUgYnRyZnNfc3VibWl0
X2JiaW8oKSANCm1hY2hpbmVyeSBvbmx5KQ0KKi8NCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc3RydWN0IHsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHU4ICpjc3VtOw0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdTggY3N1bV9pbmxpbmVbQlRSRlNfQklPX0lOTElORV9DU1VNX1NJWkVdOw0KIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGJ2ZWNf
aXRlciBzYXZlZF9pdGVyOw0KDQo=

