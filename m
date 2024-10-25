Return-Path: <linux-btrfs+bounces-9167-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD929B03C7
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 15:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF31D1C222BA
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 13:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931A7212173;
	Fri, 25 Oct 2024 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CFXw3iGa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jklz9/5X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EB3212161
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2024 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862368; cv=fail; b=m59MWiFGNJMu1FAZW7ltgnXTFjJEIiHfCGabKfk5V884cPuaunPksp1wodYPibUtY+184UWcY3a/WHbUOJAxU5waTouUqXH/gMtFyK+222Kqgcq81cYKKrRTRlbq5z+vSbwdkBM4aWPY60wrGqGv5U1iZrOiNgwzD97dXMlS4fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862368; c=relaxed/simple;
	bh=5xkqBuhE2dkfYOnHQWAKdLEg4QV2g0MYYNDzY5HwdBI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QKRDUrtRe+crgQoOoSL0D5inuK2Kjcwj1DsgmTu2jSH0xkWBxnA4mKwS1iZ8AFsmkWov2FL2DCtPomVoP1q1VE5losHlmW4KPj4+T5gHEIH2nkjFhdxdaHscPDMZneoz1wi4X9EzJ4esGq/6b8XtXtXaGpltsRvcv3tqJG2tr+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CFXw3iGa; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=jklz9/5X; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729862365; x=1761398365;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=5xkqBuhE2dkfYOnHQWAKdLEg4QV2g0MYYNDzY5HwdBI=;
  b=CFXw3iGa5ptsxroQkhOM+ByxZm4jFUvBZsxHgiDeU+ZjlBuhkr60FdRM
   jDhnTcPutI3q6ast9UgY0sqnqpndL0aglxyW43A0c6tCtNrjewAAd0GE9
   yK3GwI7DCSaeDhv7ndTfwg5ReHVY4dTog1bdcldx8ofqdNtChKjmbnw+f
   hIRriTQHvGo3wA9FqCRmrjcJ4QGuzZ6Pg9TsNZOaEpY7Sl634cbp9kuTb
   BxX6T6zxreHJFdLqJDdVean7YPmlhdlJ0rMiTQ0OQqNYjvfNdmPVZActQ
   UF3LQYKUR0vTEyYWVteC+oU2NJkcbI65VkCW94zRHkF7RasaQf/Y10pPy
   g==;
X-CSE-ConnectionGUID: kwriLtBTRPCHHuZblC0GNg==
X-CSE-MsgGUID: qV6JJWO8S2iRX89q4VUcIQ==
X-IronPort-AV: E=Sophos;i="6.11,231,1725292800"; 
   d="scan'208";a="30977071"
Received: from mail-bn1nam02lp2040.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.40])
  by ob1.hgst.iphmx.com with ESMTP; 25 Oct 2024 21:19:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aE117zcxRi+kwgAbs+p3l6dnmkJuQPWVPV+5jL0VJH+RewxPAhr98Nt9QM6FdB0nz8HVcUBY/FFPaRkQQ6dVXxL5/zllcqy9rK6/IpGOuWzz46llol9UhNWX8cbd4mMG3VGdI3lC4t2/wrmnBMfYvyys1/cWbWbt3WTKdhIBrum2LoYy00qjd+2c8E00DMMM0y24UBzOyLptjC+l+ezREuH2GoUGMzLPbhb81S/eBZPV1uqxfdlfalX1MDfT/DvefhI1xtOi0hRO6mRQS/TRE09deGFDGfDkqmkvrmwonM7S14ngUaSyiH4A684bLNZxmy2q3uqIGPwkzE6Aniq8BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xkqBuhE2dkfYOnHQWAKdLEg4QV2g0MYYNDzY5HwdBI=;
 b=bp4oIBi5cpS9FaYOu/BpSYOqxvCzg6oCrcD1v9cC0etRcfQS+1PWS2HRgmZyXry4BfHJYXc5bpQP9E3OIo+2gxP2rD97WW0fA8NcKIBvfWIS27oPm7KK+Hc6q/ivvSPz1eXL7E5Jro6Kcdbpmeb5jtYpZylHv+aXkoY01pmMkgeIXrXDyToQ8RzZD75STzIve8LgT5tNzN2vH4JtuDscf/4XMmn3BYvEbWauagTemOW1hXiytO3UNMuEe5r1za3iZCnsXt5A/nTk/BDHkLfiyMLoALZSmkALWQ7MZx791lsy5Ioc2vJcuJ0GE9viOzjLJApighPrBPhjCK7DzgS87w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xkqBuhE2dkfYOnHQWAKdLEg4QV2g0MYYNDzY5HwdBI=;
 b=jklz9/5Xgod7EOmNkA88J6DFsZeO9s0Zm7GNJLLppNfy7cilRlFyKcGIhVQiENiNrMIDscUeA/jxhAu6aKfQxxgo8NF74TAeC1lrbZ9P5v+umPLqBFdUUxqxxeIJidxyZOSk8Ty0bdp3+UYdDPMge+yV4yEiW5DSZ6pejBUkBis=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6391.namprd04.prod.outlook.com (2603:10b6:a03:1e9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 13:19:18 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 13:19:17 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/18] btrfs: convert delayed head refs to xarray and
 cleanups
Thread-Topic: [PATCH 00/18] btrfs: convert delayed head refs to xarray and
 cleanups
Thread-Index: AQHbJjE47/2HCjn3Lk22UAN/97frELKXdJqA
Date: Fri, 25 Oct 2024 13:19:17 +0000
Message-ID: <49b1a5df-eefc-437a-b175-2e9532932dfe@wdc.com>
References: <cover.1729784712.git.fdmanana@suse.com>
In-Reply-To: <cover.1729784712.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB6391:EE_
x-ms-office365-filtering-correlation-id: ac4806ee-f479-4f5d-9cde-08dcf4f7a139
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TFB1Wmw5ZVBrbjlPQVd3U1dhNjZoQUt4Q2lDbEh1akpFZ2JJd1dqclU4a0ZR?=
 =?utf-8?B?eTBJUGpoY0tNZEZYWlo4bktabkUvaGJNUXQyOS9kVFAwdWtoNVk0b0c4MmUz?=
 =?utf-8?B?bjIrZ0xFTE9GSVdWaFFoR3hDNkN0c0JWUHJRZ2hocmRiZU16WmNuNjlldjJX?=
 =?utf-8?B?VXRySllhWXpEbEE1anE4NXIzYjEyVGF6Njg2bGM5emQvU2hId3hxdXkxVDNy?=
 =?utf-8?B?Z1V2eUZEWEFWSGRiRXlybXBUeWVQWDA1b0Y3RHpuMmRIZ1BkeXQ4VHdqS2Qv?=
 =?utf-8?B?anJpQ2JuWlZoV29FOVlBcERDQTNSVHB0UGh5dVpWcGhjQmdnRlZDQm1KVW5m?=
 =?utf-8?B?YmpOVVQrZnVtOXFZR3pUU2ZSbllXVFVkU0wwZm8yc1NmeWdwWnNHTWdYT3Bu?=
 =?utf-8?B?K0RXa1ZMYmIxWUxoQWNTWFFENlVBRm1vOGswUkoyMFR6d3NzSElPOVlVbWow?=
 =?utf-8?B?dzEwVDR3c09pbFA5dXN1SG5EYkl0dlRiMVhoSFduRjNMV1o3S0VxWlo2Nzhp?=
 =?utf-8?B?QXU0VWdOSjF4RVZFN1FnYWN0VXlVbFlmQUplQ0FnWkczbms2bWhPSzhuWnR3?=
 =?utf-8?B?US9uNUNFNCtGZDQ1eW1yQlAvZWRZNDBibnNHRSt2NzNLTENoa2JiMXlZekJ6?=
 =?utf-8?B?SzE0RHkwL2V5eGtXOFFlckdXR3ByRnltZTVFZFBmS1hUZnNUQ2p2d3R5UkRB?=
 =?utf-8?B?VlhUQU8xNGowLzh0bzVlU0tndGlFWkdhRi9qWnlEZ1doSXhaUklLRHY0TVVK?=
 =?utf-8?B?S0l0MUpuTVBwT3BXaVYyYWkrdHdoNlNZK0ZIVnlSeDdvRDZ6YjArU0xCQTVT?=
 =?utf-8?B?Tm1TM0MxWGpHTG5DSVVtL2huQmpnTElVdlllczNwZGQvYWVsaHZuQ2Fzc0pB?=
 =?utf-8?B?MXc2WVM5aGlkZ3N3QVZsTmIyOHp6cDBoV2RCL2NTMzAzbk81RXlUTU5BM0wv?=
 =?utf-8?B?dFcxYWJHc2FIcEFUZjF0OERWcEIxMUt2SC84OCtlYTg3WmRQYjZqdGduL2Ro?=
 =?utf-8?B?eTFmdDlNUnM3b2hKdjk0UENxbzJPbDhGa2kvL0JvMUE5c245dkFZUjFTRjVV?=
 =?utf-8?B?dlordHFjV3B1bXduN1h1UjlmakVaMW9rVEZHKyt2MHNSWWpZTGhPWGtnQTg5?=
 =?utf-8?B?M25sYlJtZ0lLUXBLNHZlNXRRZEpENG1mZXRXWUFQRjhhcmVxN0NYT01adFdn?=
 =?utf-8?B?YUF4YVJmTk5icXBJYnQwbjMzSDVjYUNBaE03TWgxVkd4dlJ5TmR1d2p3eGta?=
 =?utf-8?B?aEVwaTdGL3BkYUl0a001Y0ttOUJKR3BOcTJQbzR0cjRtK1hpYllpaXlBY3R3?=
 =?utf-8?B?RWN0OHl1TzQ3VFRFUFhBTWRRSWxzZDE2ZnJ4WFZjblVndkpNT28wajhGN0Fz?=
 =?utf-8?B?YXVkS0UvL1VLYlN5QjE5Tlg5bi9BbWdjbS9YTlRZbU1yUkIxVGNDSXo1K0Nz?=
 =?utf-8?B?MnRIUmJIb3NyRGE2dnBRQUZYZFZ2SFl1UktYTzQ1VHJ4UmoydEhDS3hVY0Fj?=
 =?utf-8?B?ZmVIMmVPM1N4ZUxIUktuVkVQaURiK0FncFk0SmlGZm56bTFIQjBlVG5jY203?=
 =?utf-8?B?WVVZbmxaUWhRT3M2Qm9URHdFcU1lenVQejVLdkx4VEhKck1CNEFncVIrbUJj?=
 =?utf-8?B?YllsUmtlbnNEM0pNZXZiTy9LMUNNbDhwaWNWVHZQd2FmWlhhaDRCLzBDSkw5?=
 =?utf-8?B?VmFIYVlvQnp4M0xhNXEwYzAxY2NuVXRIZHZvNTdwWG9vSnFleTloRm5CR29I?=
 =?utf-8?B?MWNmQ2FMeWkvcmY4SzhVbWdITGpDaUk3SWpOT3BsZnpudTk3MHg5Vzcvd2hJ?=
 =?utf-8?Q?t3P9PYVrS3I8sO8bZrcTNDF36XyRWgfTw3LZM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eS8xME4rODV1VU9pRjNvSTVxVXRxRXIzRmtpSEFUaDM5ZTZrc3ZkM2ttL1pF?=
 =?utf-8?B?TDNmaE5RSGIrZVpqYkN3RXZvV3lacmFvcEd3MkQ3T1Y1WGg1bXhEUXBHQStN?=
 =?utf-8?B?bzI2T0J4RElPcDlIYVZORktueFVrZUFrYlYyMDdkVDY3R2Rkam85alVRZkRZ?=
 =?utf-8?B?bXdGVWw4YnBlR1NxNElpT0QycmQ4VDZlZStVM2ZDN0ZEZzl4RmEwcnZYK05S?=
 =?utf-8?B?ZCthcGxQV0kvWU9lQ2pQcmZvRTlpbUUzV2hTQ0tIZ3ZmZ0NKTDN4VG42aUdh?=
 =?utf-8?B?enhMZ2M2WTFIQ2xkWmhIN1ZCK0tIdm9ZZFZzMnhCS1lVZmU2T0ZRYTcyT2wx?=
 =?utf-8?B?SUpFZnZyd3JCUmF2a3lWcUxET1dtaE5MOVI5a0ovUSsvR213RkVVc1FGL3Yv?=
 =?utf-8?B?SGcxWXdzMVlwdi9jQU9manE3UWlqVE1xKzVtV1Rpd2JJc0djZGZuVjdRa3RG?=
 =?utf-8?B?VXNsZEF5ZzNaTVg4V1NLeExGL25XZ1NRWTlOL29TM3l2bDZ3OUJFMlArb2xx?=
 =?utf-8?B?VFQxaW16RmVrb3lTTlV4WkJRUHAydmhVclA2d0VKb3RERXgyL2NEb0RDSEVv?=
 =?utf-8?B?TmloY1FZWTVqcTBaOU04TVgzd3hBcVNRUjNzd2pUai9HdDZFOEU5bnAvdGxW?=
 =?utf-8?B?d2JEbmlpdGI4L2VPZDBWTVNvRnFrM2JCNWRUaGk5VzRLR0EyRFNvWlI1V0Nm?=
 =?utf-8?B?bndURnoxZTNFS1VmZGtUaWQzcUt4Wm1oa2crSm8rUDF6aDhZWXNYM1NzbFc1?=
 =?utf-8?B?cnJGYlBFSjF1L3I3UWFyTm1jY2hKc0R0azRnVk5oL0lEeVRrTGhIdlBkdStt?=
 =?utf-8?B?Y0VBMGRiVlJOK3lkUzJocE5vSVRZblYxYVdNUkJDWGk2YlF4M0duZXpQQ2dn?=
 =?utf-8?B?TUc2QjNRNWtjU0FNUVJUOXRPVnByTXNLdTZ4TjlycU16RHFnTXRUM0pQTVpC?=
 =?utf-8?B?VWhkd3FkUitycG5hZmRnc0tZL1E1ZDYweUx3RHlLTUMxU05aQTB5Y0IxY0Nw?=
 =?utf-8?B?S2NkOEhjVUM4Q1FYVEhLSG9aUDVROFM2czlMdWZzbktpeE96bjhLV0N4UXJQ?=
 =?utf-8?B?citaTjdPRHNtYkZBY1F1NFFMNGZmQkF2MzFKK0ZKRjMzMEIwUzRvZURTdFo4?=
 =?utf-8?B?M2tNd0JuMFE3eFR0Q0VQakY0K3lyeHFqb1lXREtrdElueXRqcWQvak5IVnZm?=
 =?utf-8?B?NUNTVHhrNmE5dUd4RW4yOXRYUDlBV24zeWQvM2dwSnpCZzVxVXlwNGQ1ZlFY?=
 =?utf-8?B?anhVYXU1MWRSM1Z1ZkVSRENMbkk4M1dwazl6aHFHT2x2ckM3OXdONzNMMlFE?=
 =?utf-8?B?T0VGeWswQUtTSXdVenhDRVlCWFNYSDFvKytOOURVZW51bi91NGoxOGRXSXlH?=
 =?utf-8?B?Yzl5U3pFdUQycEtFdEplSDBSRE4vK2x0czdmWUdlTklUM1VWeW5PbGt1WGZp?=
 =?utf-8?B?cmNKdjNHUjViS3JEZHVKR2FTb2U1N1lQdExRSUVkb2sybU1WMXROOU1sSDA0?=
 =?utf-8?B?YTlNQU8vbG9RSjhFTDltRElQbW51cmpiYkxmdjd0djFGNGlWZzBCcDlQYkIy?=
 =?utf-8?B?dkN0QTBCYWVyc05aa1Z1NWVqMUpXWkhsbWU0UFNQNmx0eUhVcW5aWEhtei9G?=
 =?utf-8?B?a0RESXQ0MFZZOGkzSHhmZmJIaThPY1FjTGxDc1BHTHZha3ZOT2VxSHJRNlVq?=
 =?utf-8?B?dGFZMWpxUEtvV3dVaHFSZUFzSEh1Z1h3SllObWh5QzZUWTFNZWE5MU9Ocjcy?=
 =?utf-8?B?UjBkdm84TFhpVkhMYmdvc3pTK0tNTmEyWVh1b1A4OXpqUnVjR1hIOFZBeVg4?=
 =?utf-8?B?UGgrUVBPd1ZkbGhZMkZZNmNGdjNmS3poK0VhNlphL1I5TGNQNi95UWlHbUtW?=
 =?utf-8?B?M3lFN0lxR053a3E0bkZpQ1VBbUd0NXpiRnlPSUlpVnE2cXFCaWN2UnpmY0pr?=
 =?utf-8?B?ZnRxUzh2N2lFYkR6ZXMyWkVaWDVmYjlyV2Rlb0tyQk1Xb0dkRWY1Yk5VM2kv?=
 =?utf-8?B?WWIzZGdqdnUvcTF4UEFTcG1lakxucUticUR1bG82bGQwcHl4bG1VRlRLcmE0?=
 =?utf-8?B?TmkvWWU4WHlFanlsSXBzeDZoZFlhcEVTd2RuUktta0ViQlNVZlhEcmpzbjhB?=
 =?utf-8?B?UE5hZ2J4TUlNbTg3ZEJiMVNyazdNRm9ZZ0dicG9KR3BoQTBXK0hXVHlTaEZm?=
 =?utf-8?B?Vmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <016DA788D15BA84A91C3EBCC1FD861D8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bJe5dy2cAJMJLXAqxlnxYMazFb+crYK6q0R3AYz7zfX3mZmiv9EMMN5M7FC0SEJMmbA8Vv25bK6n+7nnOgf0BB6Zcv8l9Njyd0TO9islqmhoDFvsJ6aEzLQjGHzfX3HXhYfi/3YT0gnHM+Qod32Ib4tY3IEtnpSvGCgYdu04deimi71M5dX6Qo+/91aphmbCsDD7M3NP7laAXo3B7AnpAY7ZT91j6nOjh9LxcMOrBXQpsTREAGQ9HNWbxLZquMJLM9/y1EU0IGXdr72+radIp9c0KhCvJ+ur+lhnK7KZzCQqB0QdfYW0AlKBoIOdI2j2l6qpWITfqvq2/0N+eKp4BE7Shy7nVLrkwmTGR4JaWtuhPsLLVkSQwyO4rB0ktr4r4dq7lyFAbjoohDsUkGnrN7KbVVtW0Fiif8pwNhSwKbcOAukm01aan7EzU+uq3TzyHyxjrBg8h8pFPVkt0Z9ud3JGXML2V0uziAI+6fB4QV/5XoJMIiBPqIGGvONmZiMcS4qS9+HXttszIZF1Sos6X+GDp1KxiJ3SDQt1UG+z649p4y3wrooZ1LX4wOGHPpFxXJDCwksVvBTiH5O0RPKnLhqFd46Nujd38NepotWfYxglbMvml40uGEUANMfMobVu
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4806ee-f479-4f5d-9cde-08dcf4f7a139
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 13:19:17.8554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5HmOPUAIYV5LQz9awrFGGkMOZqHp1B11lJxkATBc7picdMzy+uCmUvjoN+FCp+kB3LzkKVODc9PeUQbFxR5HxSgS2wpEdJlD97hCPu7JfS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6391

T24gMjQuMTAuMjQgMTg6MjQsIGZkbWFuYW5hQGtlcm5lbC5vcmcgd3JvdGU6DQo+IEZyb206IEZp
bGlwZSBNYW5hbmEgPGZkbWFuYW5hQHN1c2UuY29tPg0KPiANCj4gVGhpcyBjb252ZXJ0cyB0aGUg
cmItdHJlZSB0aGF0IHRyYWNrcyBkZWxheWVkIHJlZiBoZWFkcyBpbnRvIGFuIHhhcnJheSwNCj4g
cmVkdWNpbmcgbWVtb3J5IHVzZWQgYnkgZGVsYXllZCByZWYgaGVhZHMgYW5kIG1ha2luZyBpdCBt
b3JlIGVmZmljaWVudA0KPiB0byBhZGQvcmVtb3ZlL2ZpbmQgZGVsYXllZCByZWYgaGVhZHMuIFRo
ZSByZXN0IGFyZSBtb3N0bHkgY2xlYW51cHMgYW5kDQo+IHJlZmFjdG9yaW5ncywgcmVtb3Zpbmcg
c29tZSBkZWFkIGNvZGUsIGRlZHVwbGljYXRpbmcgY29kZSwgbW92ZSBjb2RlDQo+IGFyb3VuZCwg
ZXRjLiBNb3JlIGRldGFpbHMgaW4gdGhlIGNoYW5nZWxvZ3MuDQoNClN0dXBpZCBxdWVzdGlvbiAo
YW5kIGJ5IHRoYXQgSSBsaXRlcmFsbHkgbWVhbiwgaXQncyBhIHN0dXBpZCBxdWVzdGlvbiwgSSAN
CmhhdmUgbm8gaWRlYSk6IGxvb2tpbmcgYXQgb3RoZXIgcGxhY2VzIHdoZXJlIHdlJ3JlIGhlYXZp
bHkgcmVseWluZyBvbiANCnJiLXRyZWVzIGlzIG9yZGVyZWQtZXh0ZW50cy4gV291bGQgaXQgbWFr
ZSBzZW5zZSB0byBtb3ZlIHRoZW0gb3ZlciB0byANCnhhcnJheXMgYXMgd2VsbD8NCg==

