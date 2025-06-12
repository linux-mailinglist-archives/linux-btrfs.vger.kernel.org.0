Return-Path: <linux-btrfs+bounces-14621-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0A1AD6A8C
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 10:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B4551BC1ABB
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 08:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC6F221F3E;
	Thu, 12 Jun 2025 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TTGtz3LA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KIFC49fp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862DF1A23B6
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 08:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749716546; cv=fail; b=o2dvNF0OH25zHZdNOlDYUTsXhSAoTaSsRKi2fNS6AUb1sb4KV3Th9Qj3tPm69ijMR7IkMzPR+j3jPP63ICkWAq5pPM0iIg9Gaufr2Cdyt9CYqP6vje+u2Tj4qr20Do1p4VCc7mEBbsi9AYsFKsgDqf7JmgrzJ4FBZlGFQ3wOVFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749716546; c=relaxed/simple;
	bh=2kdRLrQVSeqdqqfT81pGJNvM2lRXraBhTu4IOLiJLN8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T6hizAbQgN05RhbwgpXUqd3Wd0kG6qcN9YyeBwUaPooHGQf9PRn2S82mMyrywKpOE5bbMe1Jn2TO7Qxg1zsT2cjVRWWWBOkIbVuTQlVWJq5XSf8cGGKHYxg8D97kKp5RDHBpldLTl6p7sKbSPOmLI4ra+i9moedpvK3HtIIjmQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TTGtz3LA; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=KIFC49fp; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749716544; x=1781252544;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2kdRLrQVSeqdqqfT81pGJNvM2lRXraBhTu4IOLiJLN8=;
  b=TTGtz3LAq0hAhZRyUakYXTMDrSdSY/RCBQeGP6eZfm8wSPu4icBGkL5F
   jF1TaV3ThauaLnlAuUfLKm235cRQFoxSjhebWzMBmxdZ/2W95IJ9BQ267
   wOu6eN3nY84Xd5sEte4nb4rPguuzL9VgtGLFUQWgk0UZ9c3uggqwQzk/M
   +Ohtv/rg+SlaedQNxe1vbOuxCoKuCltAYuNM/WSirsQ8nhU4prvee+xi3
   3oaJLizz/aWyfRxLGYK5XwGNiXS1opJutddYWu58utMKMkhxRp9oRvggt
   ckYsc7GKOrG+VtJZMhznhDA1iDhpXCQb+NKChypcBSBPYUdYY8N/LKbLY
   Q==;
X-CSE-ConnectionGUID: QO4GvojSRbKCBz2fDH6G2g==
X-CSE-MsgGUID: vdHEWUzdSX25G9CDyPUKeA==
X-IronPort-AV: E=Sophos;i="6.16,230,1744041600"; 
   d="scan'208";a="86440907"
Received: from mail-bn1nam02on2075.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([40.107.212.75])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2025 16:22:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5RdKNBXh9YzCS7YrO9qVbJUH/iKytL9SsYyckO4doltF/idPZYdk0gSEEwnsC7IU9HMQy7X7qcdYH3EtSZQ/7tAPtwKehZ5zRL1PWMSYCwG1wqAfFflySF+sDNzt/opgvYVONoFxbMtvehR2/GRFjfIeqMCrdEnKHNDRJeIrrsLfZES/uWxz6MjCjUDBQ4y9zNgCkK27+yN97wDtU9MTqwjyYTM4ipPM01tVHKFAQIg4HUZiSRGWhmO52EwvdY3rdZ5CafIa6eGP8cDvD+jTZ1EGex8bQdv8Ebm6wcSSq2bhBU+UFKZliG4QPvgLqn51Eo2dZlbhZ5AZG2I91yWPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kdRLrQVSeqdqqfT81pGJNvM2lRXraBhTu4IOLiJLN8=;
 b=scFK+yG+H0R7WFInmRRMpI64Gr6jLdFnfT2hDvrwZj7EZLYAsEG/jNf31RkgkSt+OfuOKKkGbPnKBLwRur+OTmh4AVw/vRRjPUBr2I8x136ksoD2uAwmOkz4JoRXfMs8l0a0lXRxaOl6VeYojAO6S1jDzxjeSnzqOZU2kdf30o7ODjaJXomRbcZVS1GSn5n1QqAnUgBGtVTrGm841JtCMFfpQbXemy084mGGpIPVlQq3pyorNbxeh2hW8qVLe4yuBOSYJPuWiqwKtRNrnErqXUTI21UN7o2Cdb+yN8AyPX0gPxbFApF6QK14Q6ZPPKRT2wf4E5HKS91WeHHzjsyEbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kdRLrQVSeqdqqfT81pGJNvM2lRXraBhTu4IOLiJLN8=;
 b=KIFC49fpJgxqsHKEdzR+lnbR+yoPlr+ruZfO489voT3SrXJzHqO/PP/lm9oqZlxQ8eHgbYiW0vLexuamPzBbroDS+tOI0TfdP26bTR19sRWflXIr3U25qTrIT9gfhi0isOkQWBRdD3LtfhGaxUAynMkRuRlvOITmGk7xCMfr3bY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 08:22:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8792.039; Thu, 12 Jun 2025
 08:22:20 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Naohiro Aota <Naohiro.Aota@wdc.com>, Damien Le Moal <dlemoal@kernel.org>,
	David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v3] btrfs: zoned: fix alloc_offset calculation for partly
 conventional block groups
Thread-Topic: [PATCH v3] btrfs: zoned: fix alloc_offset calculation for partly
 conventional block groups
Thread-Index: AQHb1rMgE5LE+QuQQkOvLh399jG5tbP/ONQA
Date: Thu, 12 Jun 2025 08:22:20 +0000
Message-ID: <9db4f0ff-fadb-4263-9632-a2c481e2c6f3@wdc.com>
References: <20250606071741.409240-1-jth@kernel.org>
In-Reply-To: <20250606071741.409240-1-jth@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB8549:EE_
x-ms-office365-filtering-correlation-id: a28c81e6-4a2f-45e3-629a-08dda98a405a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NlRZTnlSLzBnSy8vdkZQZUNPYTBtU0NDY2xLV2czL0NneXVmWUJCb2Q4U0F5?=
 =?utf-8?B?b1ZYeTVDaENyLytnVU5GWFBIbHRCRndoamUyMFZHb1lvQkNYZWFPRG9rdmZ0?=
 =?utf-8?B?WmtZamFCTnNzWlN6UnIxb3Bna3RLbnFIOHpvS3M1WXZVUDBNUUhFeEhlQjBJ?=
 =?utf-8?B?L2RpbFVIcGxwSGl6cWZESnRmVFlCT1laMkRDQ3NmSGRBcWt1Q1diQms2bTBr?=
 =?utf-8?B?Wml0TFpRR01oSVlrUm5JMWxRUkVWZHc5amkweStLbUNJczVibjR4WG5ERFlQ?=
 =?utf-8?B?czhhVUE0VUI1OENFSjVvNDlKM1piWGhvcVNNLzdTNHppVFFBdzJTQlY3V3ZM?=
 =?utf-8?B?RWIzdDhnNStQUkJEc0hCTUV5b0xsWDF3a2J2eGYyWU1RZStUQ3FRd0t6RmNL?=
 =?utf-8?B?RjV0aXA2N0FLVXd6dFd6ZklMd25zaURFTGhQMFZJUGZhVllhemJZTktRWTA0?=
 =?utf-8?B?dlpYaWlwU1RFSVBwYjdHcjcrSXQ0QUVpR0ZncW5IK0hBaDdkV1NwNnNRRUQz?=
 =?utf-8?B?MVpGTkRvZksxRUV2TTE1RXFVUnZjUG1hTGh0WDNUVmRCRTVwRFpSamtWSmJC?=
 =?utf-8?B?T29BaXJhZHFaditPR3VKT1cyRGh4aThzaTlKR2M5c2RLU0VxakNseDE5M2lI?=
 =?utf-8?B?emZGRUg0SXU3d3dGY25CVFE4UWNQMDB3cGduL2xZMERYdWlEYlNHcUdlMkxD?=
 =?utf-8?B?YWxrVEo0bzdwQUIyVldUS2RRamdTOTZPczIyR2tTNWVZQjVhdkFwT1FEWjdJ?=
 =?utf-8?B?bUowNHZhY20vWFJRTlhLbDZOZEVxY0lOQzFxQjJFdHNsK1Y4MkkvWXIrV1VF?=
 =?utf-8?B?MDgvSVB2RWczRmFRM2ZkLzk4aWxhaWtKODJNd3djTyt1T0EwS0FjT3N6cXZ1?=
 =?utf-8?B?aFpjNCs5UkFuSHVyaTIyZ1l4QVdEOFhyRDUxQ2NsMFUxUDEvNDNiUVlHYnNx?=
 =?utf-8?B?SnB4bHdWcU81dEw5U3h5eEJsTmFlR1VHZURWdVVxNFVIcGtIR0cwTHJCcDgr?=
 =?utf-8?B?bDJkM3NQQWVjMEh3d1RNYTdaV2JjY2NGNXIwKzV2RnhZbEd3a0N6b1p2amk2?=
 =?utf-8?B?NjhDdG9GVWt5d0NEUWhIcm1TZmtHK24xcUs4cm5JcjRBWktZd3p4aXdqclNO?=
 =?utf-8?B?eW5DVWJCd1JVZi9xSjZuazBFTmVKSFp6Y3NuaitSTWxTUXhQcXE1ZUxxNHhv?=
 =?utf-8?B?RUx1Q2l4M2srVHhkdVBhWlhnWnMyaGRPRTloL1ZVNkxOaXZBS3NGVEJNZFVp?=
 =?utf-8?B?cDcwOE1ESzVSMEgrN3JTNzFYL3JvS2lkWlVDLzZvWEVmMXdIaTd4QjByZXJV?=
 =?utf-8?B?L3kzVFY5ZWgrM0JjV3BrS0xLdWFJWUgzSTFhYy9MeTg2TjY3Z3FZU1MzVkk2?=
 =?utf-8?B?Z0lJV3I1NGtsV1BXK0orRVRtVnFmTFhWSTRZWVVPNzFGM2NvZnFRM3Q3c3ds?=
 =?utf-8?B?ODJjV2lTbG04U0pBTnR5emRtSVRpVVlWNGhRWnNlNGFlSVpJaEM5dzREMFp2?=
 =?utf-8?B?SVV6M0tOaHF4cmpmLzdzTDVIOE5Pdzk3S3BYOGI1TWcyUzZnc2xIWDQxeVpj?=
 =?utf-8?B?eVdBd3pNK1hjUUwzVnFheWhzWEovc2VlaHJJL0JkRkFCbWg5TVJzaFFDWUkw?=
 =?utf-8?B?UzNtcFM0TEE2anYxYmxlbExYeUhjVXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UTh2aEpsQ1NXUm9mOWRaY0NwWDhtL3lSVG5UMTlJb0tEd2tGYTRpVWJQOXNU?=
 =?utf-8?B?QW1pR0sySlQ1anBDS3ZiVVJLeU0vb0FJR1pqWXFoWTZQSE9abkNGekpibkNP?=
 =?utf-8?B?K2hHdElFa2VvczFuWTNDdVkxdGRwekpxU0ZnVUlNV3FwbENhZ3NSVnVCYXdY?=
 =?utf-8?B?WHpQeGoyRGlBUlNUM2xRRllQUHVxS25rK3dkZGZvVnQzUVhPUjJ0RmYrK1Zo?=
 =?utf-8?B?V0JpYVJwRnpGLzFnVHJWNDRXWkRobFVKQ3lVMWpoMGNNRnBMTU1LSklndW1U?=
 =?utf-8?B?ZjEzaEcyTG1HZytDUzhFQlY2cGpwcVhVR3p4ZElPMGJNQzg5WFFrMFJkYkxq?=
 =?utf-8?B?V3l6dHU1eDNMeTVMR3grVjJ5TUt1TE1QMXRTZGNxTk9zangxWXhZT0ltSlNv?=
 =?utf-8?B?QU1xaEZuV3lKOTVBTlhJNmZ2cUIxMXBKQ0dGN2dRSVcwYi9yNFdXQW5sUDlX?=
 =?utf-8?B?N2FPd0h0YWVKMTY5bkdUWW94VXkybGVFbWxWZmQvbEN4TnNia0NKSGY2YzhO?=
 =?utf-8?B?Wlp1VFNBZS9VOWR4UDFDQzMrSC9QWjNBSHdNWlQ1ME4rR1B4R3R6K0ZyZUlD?=
 =?utf-8?B?L0QxVHIzTUQyclVZTUtYU1lrWEY0Y1RwdjFzVnpSeHNMUU9wdjY3aHJpM3Nu?=
 =?utf-8?B?aGs3ZnVFRlNGWEQrS1U5bStUN2ZJZ3pUR1FSVEhERDc0MklESFNyWG9WU1pj?=
 =?utf-8?B?NFViTEw5dnVtRU5zN0txSDVJVjdGQm9DejZpWUYwUVR6SXN4b3pySXo4cENr?=
 =?utf-8?B?blRyOEFOWmJYYklVUHpnRWVQaUF0MEI4bmMrZ3lCRU0rUW8rSXBwYmVEMHBN?=
 =?utf-8?B?b0hpWENQcVZXdnNVNlNueWp4dUwzSkw0c3JIVUNQeUIxaVlXSEJVNlNTa3Ra?=
 =?utf-8?B?VjdMUndXQmppTi93Yk1jK2NGdlBhRndCc1l5OWprMDE5ZkZwQ29vOTJ5eTZE?=
 =?utf-8?B?UXQ0OXZXYUhFOHlGd01yRnlscVFFS2svNVNFNUt1MXRXYWhRSXBEM2t0QUFw?=
 =?utf-8?B?V1FHekp1UVVyMm84SmdMbmlod0dTSnNmdDl0em5PRTBnMkJnaFM0M2QvQTg0?=
 =?utf-8?B?K0xrbEpBVjhNMGdoMFhuNTlxbmVIbWx2QkR4V3dGQm1ORzlTYTVqNHdXRlNJ?=
 =?utf-8?B?aHBvbk1SdGhXcXVqMytORUM3VzNoMEd5S0cyWmorUmNDd3RUYVRsZnE0UjZu?=
 =?utf-8?B?YThPOXh1cTcwNU9jb2FjajlrMEYrcGVtc1BjbndFNkZ2QmtabW5YTmI1UERt?=
 =?utf-8?B?YitQZWo2Y2NaN3FLSWlWWjFMaUgvK3NUR1JkVGVySzdWMlJwaVRxbnJ1a2di?=
 =?utf-8?B?UWZUaWlMZ2NPQjdWN09Ca09VTHZwSFhpTlh2ZFhNc0M5UWJBQ2hqcC9LWWFS?=
 =?utf-8?B?em1Ec292NDlyQUVKeTNjZlhwUG9IcXl6UlR3Y2xKOTNpR0lpSWdHRkhSWDlt?=
 =?utf-8?B?SzlzdERtaGthaTR4Qkh3UUQwQXRFSUt0VDNPQnFrWE4wWG1CUGdmeHRNUXJW?=
 =?utf-8?B?OUxEZHpvOHFjcDgzS096cHJYYWwycFVBSE51aHhuWERORzFuZlpqU0dXanpN?=
 =?utf-8?B?eEVEeW5zaWZvdGl4bmRYMlBpRjFvT1R1dko5U2RuSGwxbFFPTnJXRVN1WXBy?=
 =?utf-8?B?RTlhdmdhOXV6eUw2ZUlOWTZiNTA3blNncW52K0x1MDk5UDloNVYvdWVueWlq?=
 =?utf-8?B?NExsRUJVL21MSFkzbnNualBjUG5nM3dyYUl6bVp2QmxkUjlOVzJTdmV2VjB4?=
 =?utf-8?B?d3M1N2t6WWNCNDN3WTY1WjhNM2R3MHBXTHh4bFJlR1FoL295NXFFd0xqNjBU?=
 =?utf-8?B?QS9XNzkvcm1OQTlrU0VUdFNvSU1WUWV5UnhXejJVODhvU1JORTQvUnpORGVD?=
 =?utf-8?B?bXMxdUZabGZ4aHhZcEtFR0VnU2Ntb01mdzZ3V21qeTF3cW1UVEpDREJ0elUz?=
 =?utf-8?B?YWc3NEZpd05JWmpDNTJkcmJERFNkaXFIQXo1c1dtb0FrWHFmUUQyZVgyYVdD?=
 =?utf-8?B?VFRMenpldEMvMVVBekpVZ0ovVXRsWDhiUi92Z2hhSjVaQVJQZTlwZVg4V1d4?=
 =?utf-8?B?N29VRDdmS05PeDhBOVBWVksrMHBUZFpObUpMdnBvZ1BGQ0RQdkNVYzVXTlhI?=
 =?utf-8?B?RnFmZ0RVc2x5cHQ2TUhJaFFYYkxNcDF6clRkdGRkaU9rdW5tTFJxN3dZbWVJ?=
 =?utf-8?Q?ooBtyHTbAl2WnxPCoQ6IpNY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F29DEF12A0EA8438E99692DF13D0012@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RuYdA6je8NDOJgFLAgjNbf3YnYtNpeZdGyUjX2jO7brymaIzXw4KKaIWh/aYi8mFLcYfTucHGIZP0PD9VCsox9viu8/GxqAbp/6pXXY6D32fJ+MMEVEaAG8TcMk8bdPhpfvzvZne09CucumYKp8mRVUEFEUt3UhJc5tNjm2GDNvxWxHBOP+AURDcPU4Fnk9akLt8dP0TX8jup+MvRJllojPhhzWu4cxNNTMZ14DN4g4lPHxcLkCS7fCFlql5IihAqQmdqMUuL0D1tGI+mxIJRy5ZzXtF/H3K16GMctRDCT88ZdB4/SGi5D4YMU3erquKevDzH5mVm7uKXVoK4GA0OrXcq67GuutH+AF8tNasS1kk+6qpb5XvFwL7d21VB/ydcu2fKrrm4JQJRUKrweJh44KYUCgW7KKp0wkyhCfaU+I0cBavq1QatrIm83O6C4VZ+cgTY/UmKohYt4AEENOtC/gwPdN6ut+CKslCWtQdMFPTBTShqQvTKNNqotAa37btGp45csHL0u3WulTbFHLlYGu9ZsVQPfsqrzruZocOYt35Quxt9S+Q9O3xwIgUqn99jxS5UUwyEAxPetH63Kk87xH4hZ1ThGCvRh6c2/TCGgNpa4splI1kap/V5mneba0b
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a28c81e6-4a2f-45e3-629a-08dda98a405a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 08:22:20.6259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7FuEUV4JAY3B97/va+DGuUXGUWqODTgJ0ysmwGMic0PggHJ2Y/Tlr4Wciys2giFTxtOI1XprS4AQevaiadULjV/jD9trENEqDo1RBo7f730=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8549

UGluZz8NCg==

