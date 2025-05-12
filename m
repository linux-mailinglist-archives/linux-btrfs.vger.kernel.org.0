Return-Path: <linux-btrfs+bounces-13878-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60954AB3174
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 10:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B0E1895A48
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 08:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3642580C0;
	Mon, 12 May 2025 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TCkR638I";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="g0+KBvTp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E47925742B
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 08:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747038120; cv=fail; b=EKVBjwMXTwTw6muZ5QOwWdgvX5lJZytJtanCW7CK7onFm/P+WM+gEg+Il1GXE7G8SLGcciNxshoMy0jFB5nWZhlcqgMkT46EjkJE6ALYTmPK23wQ/8tDvBU0g6fqv494Xh1d8cziW1uqt7yyXD811xdyJkuN1abHJP79yVO0Ho4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747038120; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V0g4YCegFDOY6vhwkXzIe4xNrsdalL3yBtpfM8Roer39TCMh+GljJIauRNbErQDrhsIdx86JRa78wsIpidTtn1CtxdlLuike6ESEH6pOUocOuM9twnSi9DrtKdVu0cQgUxWfSlY76I5Qc+H9zzmjrKTpt6AqrNZUDkngkfQmbWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TCkR638I; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=g0+KBvTp; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1747038119; x=1778574119;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=TCkR638Imw1Z6b/k3WxNXIBeEt1xLRhPjFh8y50NBvWW8uC+Z6gr+d+s
   1Sug4887ZybkKAdEu68+/RFGzir1zWdy0oDJrwKj8WsDOi6JS6DR7EF3U
   xCaPHjjLe66blvWEZStL1y7CM+1VRjujgj0AZ8SFfyrfzCFhgYcXP8SH3
   qn38S5pwV85Y23hT5M9b3QqqYh5vThwJzrkTqlklW2kE/Dl7W4SkiijQt
   J4kwWbkyq+0CZKnxw6XcMkMbUbait23mAisHgjRVdgNwMXgY08EXq+XF3
   /T6oTwyr2PCcNBeCQv0K/VPixXI6iuuEWND8fz2VWGhjXRjHxOrDhSRCd
   A==;
X-CSE-ConnectionGUID: 7orR5288QOu/egjj/BEvZg==
X-CSE-MsgGUID: AqXvsk4uTH6AM4SYB0xuWQ==
X-IronPort-AV: E=Sophos;i="6.15,281,1739808000"; 
   d="scan'208";a="80147751"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 12 May 2025 16:21:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUCnuQxpGf1eMVBcD5M1PT1MqSC9S+ORYwustnU+bA3ntv/K4SwcYr0eDbBDhUH4v7ng6oqbutmXVKG8FVrUSidifE03lNgU94ekBDSRozdXkL+kN/cGBugcz4bnu1xPM69Oq68DtSvnTlblJqAeyk61W4XEs3VFrnd+qET0gic35B8E11N8R65cElM2rE07wPd0nNoQJUv3+MV4IXdykE6QqUpv42afHjx3AcZA1k1TDBv+Jy6wcmoXWx5nAeBGKNVj2IsgPEreK8ju5rVXPro/QSCGg5bmOnLuTR/dCUZo7o+8a6hSqwSSpf2cSqlUyjify7Qzrj/o5vVcobjZRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=pTBZ2EZGocZwbTBs90fpc3cltmSQBiA7l9SGvtFsbm54pN+Ujjie8lUhbBCJT9VVmxxf65h24DWHOODBLDIpeEAJTrdvoWSkHJ1qmoGp4pYyQLEH1XVf1vH3ytFdAVETi3IyCJLUwzwWs0/qvR4ZOciMFK+nNs7uuY452ZY6qD/YyhgzWp/gKQH1vIdXqCwRBXZvzNDA3XDLw9gLufP/ELjpi8CHZ5y6t/kZMbJT93XmrbGjySJ6Ru88cmzYYXRaQV2ISXilCbaQKw6eY6GpRauLgC02IKX8T4zmhpm2qU+QSd5ZuJuyhma+9i4sniK2uRgeXyq8rGLM0chfizQcLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=g0+KBvTpJfvHCBkW1u2om3puXDaAuO6uslpExgmNkaYIwxq/0ZM83SDbJM6osfTWfs8eYRqnnEbTtMW9+oCyyvp/XiCQ2TtLb39qWu819+c/bjb4BlhyZ7Aa7IJTDXHe4rJZQiddIK8eqfHhOOIEOkTZMrpIyrkavbuO4QpPV7s=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB8202.namprd04.prod.outlook.com (2603:10b6:208:349::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 12 May
 2025 08:21:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8678.025; Mon, 12 May 2025
 08:21:55 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: log error codes during failures when writing super
 blocks
Thread-Topic: [PATCH] btrfs: log error codes during failures when writing
 super blocks
Thread-Index: AQHbwxJLRVK/vw53hUiP54vbsicjDrPOp7KA
Date: Mon, 12 May 2025 08:21:55 +0000
Message-ID: <95412558-d5c1-4ae0-b3e9-c309f04a1351@wdc.com>
References:
 <bb1c6b0212c4e60ef4a6b08be741f1c50ace6afb.1747035917.git.fdmanana@suse.com>
In-Reply-To:
 <bb1c6b0212c4e60ef4a6b08be741f1c50ace6afb.1747035917.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB8202:EE_
x-ms-office365-filtering-correlation-id: e891d077-c47e-4f95-4957-08dd912e0e8f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VG5NRFl0R0FxUm0wbU9yWTRMSWlPU0tiaUFjcEFQWUdyWDZnS2FkVHlhbUF3?=
 =?utf-8?B?R1BGc2VXa0FHUHp4dXpycW5LckRQNE0vMTltVHJMMmJVQ1Q4bWFoT2RkUWt6?=
 =?utf-8?B?TjJkUkZTWmpQZlNNbG1kWU9lSFNSeXJBTmtOU0l6anNRcTloYkwwMWFJeDE3?=
 =?utf-8?B?L0JiQjdUUFdZL2I4ZCtCYlozNWJKRzJIczcxVVdMd2ZsYzk5RG9LbUZFRTMx?=
 =?utf-8?B?djV5bG1JZjhRN25PMmhHbHQ0RmtYOWpwc1ovdHJVaCtnWWFwS2FVQzBSYkZq?=
 =?utf-8?B?a05XV084RmxiMENRbTZ5d1NLNGo2SjF4OEtielJ0V1pBazRtRHY5bjVnemxw?=
 =?utf-8?B?TlFsRFc4Mk4zVkx4eU9WbU1WajVXL09adVZ0TnhvcmN6cllLeHlITHd3K3ZV?=
 =?utf-8?B?dHF5QWNBSGhBT2dMOVhIS3BTRmZCdmMxaVUwWHNsYW1tS3pQb0FuVUQ2dXAy?=
 =?utf-8?B?SGwxZmJVSUh1MWkrVmR1RWJmOEg4MkttVVRROGI5WmVnSFhEQmJpeWt1QlUz?=
 =?utf-8?B?Uk1WR2VHbjBqMHFUUGJKSTNDZHFJdDByN0RDV1JUZHkvZVMwZmFqVFVMc25x?=
 =?utf-8?B?V05OTEVGTTdBTGl4cHVWN1FrQWEyZGtCREl3NldMcEFESXlXRXA4bnFzSW5G?=
 =?utf-8?B?WmNuVzhLeGFHdkk2Q0dla3d0RTBWQmxXbXZkQWxrMDFXTEtLNEIwU1E0QlBY?=
 =?utf-8?B?byt0bzlKZE5Na3I0ditMVURvd2RZQndNY2VJZ0VpZ3NEMzhHTUNpS2pMeEk1?=
 =?utf-8?B?S0dHOFNBVUZudVV2V0lCWFJJSTVybXJyMmo1SHdxNjkwQUdGS09lUWJzTWJK?=
 =?utf-8?B?R3BkbUx2ZWdSbHB0SG1haU9BeVVVeXR0a2pkZFRPT2VyWGROZmMzZis0VzVw?=
 =?utf-8?B?bjhnT1hrRDBNQm5KOFlxcjdPbXZaaDNCNEcvYmx6TWNqUW1wSy9WMGtnbldh?=
 =?utf-8?B?eGh2ck43TDF2RFpRcSt3UGxKckEwUTBub2UrWmVHTy90Z3NDQVV5VkVIWTRC?=
 =?utf-8?B?NGxmRTlRMVhySTI3cHNjRTE0MkdneGtTNEhlMlAvS0xJc2RkRDJZNVhBbGJG?=
 =?utf-8?B?RkNHcTMvaDNkcllHMnZ1NWFVeFNLQ3VYaDBuR0xxekNydnJLUzBxaWhnaHVG?=
 =?utf-8?B?dUh0TEhvcXJIR3d1alVDQ2dEcjFTYWI4YkttcGVpUXA1cDdkNDl0NXhmcExU?=
 =?utf-8?B?TlVnUFBuc2o0cHZRby9ZRmVYOUZGSmxpWjRtY3h2bGcrVXd4SUxyWFVVdHk4?=
 =?utf-8?B?a0ZVTlJlRWw1S004czJsSnpsL3pOMG1wSm5BdXFqOWdYazA4Z0JkNGlhV3l4?=
 =?utf-8?B?QjFlVjFxSTc4bmZEUk9xMUFRam1XMGhUb0ZFcjVIVmV4Qk1Ca1lrY3RFRC9x?=
 =?utf-8?B?Q0UreENLQ1FzYzVhWFVBZGt4ejlORXVGbFUrU0xSZGswTDFWMnFNTDlpb3dF?=
 =?utf-8?B?dzhMdkpSNWIzZFMzdFpOVlhJOXpBWWsvSmEzRHZRRFRPNmJUSWp4WDNqTVFq?=
 =?utf-8?B?SE84aVhQblJGRlNYTE5QVlhiR1NkUUY3Nmlqei91WlJHU3NVL2dOZGx4aGdN?=
 =?utf-8?B?T3ZKenBYWkhuN2JVeVBrcmJxa2VUUkdDS0hFTHE4ZGJvWXJDb1NVRmFuRmQw?=
 =?utf-8?B?VEhPTUppUGQ0TjJDU1dYUC9CYU93djF1UTU3WG5yc2ljYVphWXBQR241VzNw?=
 =?utf-8?B?d05PSkJQNHhicXNmRHVRVGRHcGlaR3d5NGZtYmpaUGliYXRVNytjZzN3ak43?=
 =?utf-8?B?YjRTSkU3dUZCbWlSRFN6ZlVLRUhJUFVpOHY1THU4cGhid2YrNHhZVjIxNFBa?=
 =?utf-8?B?Yk1Qdy9xd0JIQTdhK095b2wvdFFjRU92MHJ4Ni9VdTdvcjdVeHpqdTZrOFZL?=
 =?utf-8?B?Vkd4RlpsQzN3dmVUUEVkMmpXRGhVa01Gcm1sTGVHaGZmTkFLbXZpMlhjNmRk?=
 =?utf-8?B?VVFaMXB5T0YzTmlFRU5JVlNiakNCSXdad1QzcG1zcXUyYlpyd1BvUTltdE56?=
 =?utf-8?Q?Fyx4udxCFDhCwuK+H2KbtYgXBGO7A8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bURCWFZ5QjUzTUN4UEpvdDRGMnVxWTVuSXcyT1NHN1E2OWh0WjRhUU5jeGdk?=
 =?utf-8?B?SW5hNXVzZE9ib3BYNitmbVdid2kwbTdmcDJId3NsUjNtU3VabEM0UDhId3R5?=
 =?utf-8?B?eDV5aDdqMnIweFBmaVlsNEFOL0pFR04wOVM1N2NwZ0Z5WHlaWWNUNDRXVlY5?=
 =?utf-8?B?QUlrcTFQRzdEVGZWcFFsVk5qSHZGN2hPS0FuR2V4SEc4YVdNN0N3WWxYenl5?=
 =?utf-8?B?Q2gxT1B1eHZlZmlsemZoa2ljVnROeVVid1lkd3FmVGQ5SUl2cGV0bGlFamFm?=
 =?utf-8?B?K2RKS0cvWm03Q3Q3Q0wrR0NLN05FeWR1c3lZd3dIV2IzeEJyK2xtc2J2QjEz?=
 =?utf-8?B?cHBQOVNLTFhMcEswdHJRQkNNb0Q0cnE3S2RqRlVQdTZyYXhreU5ZRlJZZ0Na?=
 =?utf-8?B?RWZxYzBzZ1Bnd01OMkx3VGdRMmVaVldzWUVObGNCWUFkUitBWGYzemZMV3d3?=
 =?utf-8?B?by9Xc21pUFhyRGkxdG04T3dEUUFVa1V3MlJta1RhdDJ1M2ZBU1NJKzBUSjkv?=
 =?utf-8?B?d2hKaC9VZkkraUJnaEt3Zk5VVCt6VVNQOGRiRWZ3a0crbHZyNEg5dHJac3ho?=
 =?utf-8?B?WlhsWmhHbmVrS3M2M3djcXdSUnJlekE4UEx2YnprR0hwT1ZhLzlKTVFiUks0?=
 =?utf-8?B?L0hEUFlOcTdIT3dxc0ZiYXppRjJVdEplZ2hmeUMvMmRwMWdEbjBSNWYzbkFm?=
 =?utf-8?B?S0N2N002SjI2QjFPUWpZUHB0emlyM0FUSjJlVURoQy92bGQzTG1CMUFKK2VN?=
 =?utf-8?B?Tno3UjdOOCtPZjd4bW5TUTY1eFlNdDRxVXdtRUVXOFlvYUtlbGVVOWFkWTlT?=
 =?utf-8?B?YS90MWNVeFZpa2RtWjREMmZKajY5a3dXTUVueDNrd3FaUFVkcG5NNkpYaUJs?=
 =?utf-8?B?MlhNZjhYb01GclVUVFV4d2lrYThNditBakNTSms4aUthZEdTNi8yeXZ0NHdB?=
 =?utf-8?B?SGt1QUpHdzUzT1FzcUp1TVFqbDA3Y3NuK0lELzl2V09RbmZuNTUyZk8xb1pS?=
 =?utf-8?B?NGxvRTl6VVBOelM0YStjOFFyTWgyUGRMZkRxeHpvZGhUT1NwQ2tVTjZ0Z2N5?=
 =?utf-8?B?b3NpL2JaQXU3cGdFczFlQ3g5ZDdxVTM2UUlPZjZ6OExtSGJHODBZR0w4Rkxq?=
 =?utf-8?B?c202RXY1MXlEZG9jWHdrZDUwQUJxdENiSXk2Y0kxSitTTy9PSFhuRTJqY2FB?=
 =?utf-8?B?Z214TGNOOWFGYzFiRVoyVTd6bHNqWXVQaDdXdWxzdHp2RE1aM1F6cW9BQWN1?=
 =?utf-8?B?eGFjYjduS0RYaHVxVkpQSkl3NlFLRTdaTHZWdGR3MlF3RHY3Uzc0TmtpcGRt?=
 =?utf-8?B?ZjNEWWNzTzFuMlYvZDhXUWpTd0FLRlpOcHdRYU9CVGNKUnFJeFZtZ2o1THhp?=
 =?utf-8?B?Z2xPeDdvWjE2TzlqSnF2d3dLRkZrMUd4d0lFSFIzMnRUdWNyV0dMQmhXM002?=
 =?utf-8?B?Umh4a3J4YjU2VWxyVkgrVUJZT2hqSGJRc0JtOVg0RUFIemt3cU1NYTdtVGM3?=
 =?utf-8?B?SG9DamN5Ky9GQjk3a2tweGhIbDgvNkpDYlRYdGk5TTRQYWVDZWJoMnBxRDNF?=
 =?utf-8?B?NEFkUUJURmF6ZHNJU3NqL1NkT0dhNjk2UDJEL2ovRXZObGZ4VTJNam1OdVVS?=
 =?utf-8?B?dklPNGVHT1ZsQ284TDYwL1JQSk53dlhiTmJsMW5rWHRyS2h6T25iQVJuSlV2?=
 =?utf-8?B?QzlKL2IvcHNvSWlSdGdCbkY0RCtGKzRRaUx2eGtvZHI5ZWhCZHVhSGNLWlJ2?=
 =?utf-8?B?VmlVODNOeUpyQXZWRWlsRUZ2VVBkTnNFUHdxcGJkUFlkdlZva2JDazdjOXB1?=
 =?utf-8?B?RGpXOHlob3dMVWZvMnh2MTJZRllVbFEwenNiVytVLzFmQXJ0NnpUSHRRc2gy?=
 =?utf-8?B?c0IrWmg1QzM2RVFEdU8wZUZjdUNPaFZwY3J3VUp3cW1GM3lQWWg4VVdQSXll?=
 =?utf-8?B?QjRFUzlpUkZRZzEwcHhVSzVJQ01xZEhqMkNnTXFQYmxpZHpBZkNZR3QvWlZw?=
 =?utf-8?B?aUJ3MDFWOVFpLzRuenRreEEyaGxJUkRTTXdIdTdkMitXS0tTU0x0YjVSVlZW?=
 =?utf-8?B?ZnluL2J4aFpiMWY3K2lOT1NVNFoxb1F4MkF1VlAyMzAreEEyUlBqWDZVQnZ5?=
 =?utf-8?B?blVPL2VoK2dBNjU4MDY5Qm1ZZGZESmpDN2s2Si94VnpKd3FhRVBFZUw5TXN6?=
 =?utf-8?B?Y1k3UndROHVDUytiV2RmSjRNak1qTUNkcVJoY09Qb2loWDRDSUUzaWxvckx0?=
 =?utf-8?B?MjE0TG5xTEpkNmtsa1hZTWdWR1lBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2CED058AEC76B4982AFA7E428B84472@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2ePazG5gbnk/m/lyoGCy5/T1AQUQZhGb0dm4xyV2oWoKS1rHK4IuvHBuSafQEFvJPeAhztITbJo1fsmLO7Gl3ldQmDXzca/o10FquErdRxtV33L4eLa1GTiDr1A/8JqAZOl1vqxXNKzZ0dVY8UQW5wuPErEipOi+fV538ry2LCcSbjOYfRA6d7gmtutr9qah7ocAL/p/lUlG4n9qqKsVM6IqIqD7Tnhf/H4cBPpUudn4FYfJG1smqXigyBJAO17Yu+WOz4S+IgoDz/ddMRvU3CowKFccWS6o82Ft09YDLGrwVWaAbb3FB/0+BDa/3Pk3/e18nC0Dsc8NJ+OBQJ2AEx+L0yyTbDfQro4vXxBoT6g9G9cZ9T4nbVEa6PCxAF8OdNC86HWgTUUEOoN2YvfF6X5MChtl5JQYYruASTvSNPYxVVphsiuYRS7W6XDuqkDDdsJtuMcvy1y9hM5izmeuLt0QihCv/Q6JoApT6miQTbBd/4liNWDDYt/92FXRFgpszH8xu091fCQKaiVrxHIMd6KXgXFD81/jqxkfwu5f1IBVPxjY297E1orxIFFMcveBMdD3m5Qxklz1VEl3cOiaXEb4d0m8d7lvEy2uG5HGY0MoRQuFYQHy56P2L8b46RbL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e891d077-c47e-4f95-4957-08dd912e0e8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 08:21:55.5064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QrcJd4m9kAf/vqZ7VtbQgiZHNsXcTFWLxnXQzZw/PvrhxV1Gy8+L4SLwZe2NfvoqEFti6vK5jR1c4D1suZlLU0S09y8lBALKMxCw07bJ7Vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8202

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=

