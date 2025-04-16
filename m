Return-Path: <linux-btrfs+bounces-13075-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8A0A90637
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 16:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16851907134
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 14:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FF81FF1C8;
	Wed, 16 Apr 2025 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YlumX0/x";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ou3+EuoA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7369822F01
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813052; cv=fail; b=iEr+VPzSSi4t856RVI40jSOV2vBfKCmJ3avo5RYFs1nV/k/BV7+CtbzBURzJBWKrDF8RlysGy7MIpzY5b3DE8kGxMnB9kYp6zy6txBzEbP+pDOy3IWDybaAeb1iuixCrQBJb/HI6ZlRt8/NxqI63vnmjUjVbPictk0v2zdgy3tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813052; c=relaxed/simple;
	bh=8nGUIz1TLFtIVEWZADXRXyEMrDaj+2TgKZtRLvDkYII=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F1BHD0tZg0QoWU/MZdUxKBXZ3a2crtscyvJcLsoDGM5qIr3nKloECkjAQzBmFZy6Ap0yvIM2ynysXa6UhbRq9fdhUzd6g/zFBWptuqhhfwiWcIkzUdWwkuThMcKhxZ2vx0gKuELumTW7w/obWDLFkfpCmy9FyuqElbfKEf80gKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YlumX0/x; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ou3+EuoA; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744813050; x=1776349050;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=8nGUIz1TLFtIVEWZADXRXyEMrDaj+2TgKZtRLvDkYII=;
  b=YlumX0/x+wZEH7ArdDX1bpJMntvjYtYyvXBYi9zaWD/OAvNXFyUP+ZmH
   bm38qSpNRnrxD0UsDbcmApOsGAl+pmyXVlHBDGGqsilYPjbDrqneJ8O83
   HytEZSg0Q5xcAJ4lkhvl0QLLtd39WA9eew17q94A5sSF2Ottj1tMax2YS
   ezKuAtV2DyCciHF78q5PJs8RCWhZz6qJTM5N5YqzZ+f5wVJ3PWGyuCMT8
   b0gTswdOqzWen3egq8lzWar9ugoopogRru3NeuimB//l2GtFkIVmF6nGF
   hGqEtlwANsColtgM99ZiyUnbkpZOE26g9VoS9r6iS3g8v38BgBqZOsoXV
   Q==;
X-CSE-ConnectionGUID: FXFbXe4HRsmxgnxa0UwL4g==
X-CSE-MsgGUID: hZwtXzzkQxihWrrmLU7Lyg==
X-IronPort-AV: E=Sophos;i="6.15,216,1739808000"; 
   d="scan'208";a="82364823"
Received: from mail-centralusazlp17010007.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.7])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2025 22:17:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5swWxh14OKImlx59NFGKEd7gGJ2OC/NzAFhTJeTg5P00bG644OeNx7RXIgGqhry/31QfI23UjqNfcQI4903wIFytZZXF1LqKVEM/qksrlMz3qJigMc7CA0x4fLMkOafSBIkrks7XFkJdYmnXqo+wGg40IvJ9H6LTsp54bpRPvxKhWeUJHBJKhuTO37xVVtxoWoFiPYCitQLhLIR/of0nRdS1O0gKIn50iBmPjL57myjAT6fZptRz5VvL1Pvk4vDWx31uZlJUaoq6U3YzRk3qE9/CcU4FqPrLSitAqvB9YdwBofhOJgu+WEglSP735rfX3WGUT6LA2FRbvGHvPXKyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nGUIz1TLFtIVEWZADXRXyEMrDaj+2TgKZtRLvDkYII=;
 b=D55pSYZ8Zfps8kAFrMgsoDieoABRRa0vSIwtZvzdz7UMeHrJhvHBvWEaVd8sLdQIAyvUpwH/s1YKdCQwDvH058luLyBlT9zLp9XvB4rBxaM2glteTXiDdil6QJCUsG3UzEaOksfnBCN1qCirBlabv7WJZX3IehPQNyQEBD9FlOyTSCvtnmnjepW8Ui4hoL2cELMWIbw/dh3vH9nRKYR8/hTjKV4ehoXEEnCdFykJU4u45k+NKTpbAhsQoVTTxa5Hn9lwA9nYVZcedBwriUFkTWJVF2M9MDDLoQCP4AyYf7n4Ey9vwA2fFVDfw6+vT1OhKiO8pu7qCXyN3ZP46aJBnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nGUIz1TLFtIVEWZADXRXyEMrDaj+2TgKZtRLvDkYII=;
 b=ou3+EuoAzn9kJ74Ny0EcnGcCLvaT2UGCkEg2o6HPanoe1QtM411jlGpOhLtRDsZZo1oJy824YlkR0oOOSC3ZaYXvpMKRXwNVYs8XJgDwkZlWnjA6EckiEa0R43/R+a7vMovjxnB5GtOTQH1oOkb6j9G24qX7CsNThfYLRPj3ox8=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CH2PR04MB6759.namprd04.prod.outlook.com (2603:10b6:610:a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 14:17:19 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%6]) with mapi id 15.20.8632.035; Wed, 16 Apr 2025
 14:17:19 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 08/13] btrfs: introduce btrfs_space_info sub-group
Thread-Topic: [PATCH v2 08/13] btrfs: introduce btrfs_space_info sub-group
Thread-Index: AQHbmJZG2GmIWxo4XECGht7L429KvLN8NEqAgCpPDgA=
Date: Wed, 16 Apr 2025 14:17:19 +0000
Message-ID: <D984LOF83ZW8.26YW45VOYTT85@wdc.com>
References: <cover.1742364593.git.naohiro.aota@wdc.com>
 <355f307dca7ea6da7db20038d46b3ef7a2cedd4f.1742364593.git.naohiro.aota@wdc.com>
 <a97c2dc4-f83a-4db3-9655-db353bd44864@wdc.com>
In-Reply-To: <a97c2dc4-f83a-4db3-9655-db353bd44864@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CH2PR04MB6759:EE_
x-ms-office365-filtering-correlation-id: e6a2622c-ad76-4c99-9b06-08dd7cf165c2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3lHakZGd3Vaa3VybXhYYVlxUVhPU1hjbElGRWJoMjdLVlhEMENzRlIydFU2?=
 =?utf-8?B?NmRrRThrRS9MS3FsVmFpVGtwNmJNMTlJeHhPaUNSTTA2ZWJ3aUdJcW1ZL3FU?=
 =?utf-8?B?SmlqZGk0L2dEU0pUM3NCNFg2am9YK3BQL0NaL1A1TmFIME9Dek45VThYUlhs?=
 =?utf-8?B?NmZpQTdFckdMRGhmR0xsdVZXbnF0c3E2bG11ZFRaNmpndUt3dEloRkVpaDNy?=
 =?utf-8?B?eUc1ZGZDdmwvZitGZGpwMDBuVTNMNEZZQXQrQXFZaW41RG1jNkhoWkJLdHps?=
 =?utf-8?B?eWxJRUxOK1NyZTFlckVkcDYvWERqSGEwK2F1UTNtUTBweEtLUkx3bUN3N2NL?=
 =?utf-8?B?c09YdnVVcitiT3V5dnZDS0pSS1NNcldacWZaYzRLUmtraWV2d1d4Z1RLbmk5?=
 =?utf-8?B?R3E0cHdrTHlraENTdk55MlFMMm4rcm9pYU8veTUwQWZrZC8yMkNUQTR0SVA1?=
 =?utf-8?B?blNHMjdoQThMRU1kRW5BQlBrem9ydVJsSVFxand0UzluMjl6eHcxSDEvM2ZP?=
 =?utf-8?B?MDNteFFsWmxiSmJiMzFGbEZYSGNhY1pUSXdWbHB2SzdEN0JaTXFKbUdVckg0?=
 =?utf-8?B?Nld3T2NNU1hhcFEvRDdOSUhXOXRlQmRTd0EzZ2xzU3NQaTRBOGVPMzZOR3Iz?=
 =?utf-8?B?bE5wekxEdkRKb1VYNnVrMzFBVExXM2VkQy9yUHBKZnZzbGs3d1p2WWM0Vlcy?=
 =?utf-8?B?Ykc1K2xFSERnSmZvaDZMb2g0Z2tLOVlhelZGZ3NmSU9FaFEzUEI4ZldiTXVF?=
 =?utf-8?B?dzdUbkRHT0ovbGF0cGJzbytTeUlrTS85OGkzcmJJUjV4ci9FdlY3SnFYMXpW?=
 =?utf-8?B?L2pJYTY4S3o1QkJKR3kzRE5NM1h3eVdlekVLbFA3OUZVZW1ESnRabHFwSFow?=
 =?utf-8?B?QW5pNnJIMTJuQVh2VE16ZmdOUWlKMGcxYm05NWhEek9Ob0ZFa04vS3FHQ05H?=
 =?utf-8?B?NUJhY2o5c1F3VW5XVHBST0VqYmFSNHZ6MzA5MTB6UVdqMDcvTU16cFRvc0pF?=
 =?utf-8?B?YVp4UzhvOW5lVlNlSmMvemdTZzd5eHNOSUtVNlJkOUlDclJ5YUNRNis3bE5X?=
 =?utf-8?B?TU9zSmE2bVR3NjJ1cmxRTXcxMTc1cGcwWFE3OTNkWUxqT3k0a25qWU0rTWxl?=
 =?utf-8?B?TDczUTMyczNNUU9OMExnWFIwbWFLZWIraEJlWko3UHRUdTcrSkd4eDBHRndj?=
 =?utf-8?B?WWxOamtoWVpRbXR2Z2s5Nmw2UXVORDQxcU5rWHkyVWN6cE1xZHE5NmRKeUtw?=
 =?utf-8?B?djVjT2ZHd0JTUlFKa2NkMm9qYjFIQ2FtUmE5bXRXaU90NXZHR1Q0aENXL3hw?=
 =?utf-8?B?bDJPV3lQVFVmUnNBN2g3QkUxQTg0N3ZoSGp1dDVlVUlaVDlRNmZQZXN0Tldk?=
 =?utf-8?B?OWdpVU4yNGZKOXNqYkRhN3lTei9UTmVrVjI0NDJTRGVVVkF5VEFxZUtDa3h4?=
 =?utf-8?B?UVo4WFBhVmt6d0VuY0NwZkMxZnFtZ0hJQXhQWDAzU2dlZU5PTk11bVVYaitv?=
 =?utf-8?B?T1pyVUoxY1Nva3JyenpuOU9WZG9sUjZJMC83U0VJTU14UWtQZ09zWVI3LzU1?=
 =?utf-8?B?UWZMNTByK2c5aWZJbWw4T0tsMlV0MmJ3NGZ0cGk5N3FoelEyWjlZMFo0T21r?=
 =?utf-8?B?OU1ITHVORVpOK2Z4SG91RFlFR1FiaTNWbHNaUW9mYmphN09RQzhyZFdsVmt0?=
 =?utf-8?B?RnJWb25vWk5tN25YSkZlQW1kOWtkQWxjNURkSmxrSzVOVDB3dVEyb3F1ZW9N?=
 =?utf-8?B?cUt2czU4bGRieUZzZmEyekhoWG9lRWFFY2lFTUI3TTlIMFVNMWdIaUlQZ29N?=
 =?utf-8?B?ZWRQODhTbDErVndhRTZNVGhQdWxaNkcxeGxsZWZHR0JyM1RqZXEwZFpWQU1C?=
 =?utf-8?B?eHY0QmdFRDhlSjMxREJBN0JmT2dHckRWb2dSN0c4MG9tL0NrQjdrbkordnVZ?=
 =?utf-8?B?QUgvUlpSTUMvdm45WndzVEdmSXlQb3ZUSVBCUWcvdm1MWHBtSEZoRVRpZ0ZL?=
 =?utf-8?B?dkFWaFJ4MkN3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QkZ3cm11a3htUWFZajBZcFVUd2J2ZlNuTFRMeUNTdXhPL3B6OWxVVGg3eGRT?=
 =?utf-8?B?YkhOLzVGZUhRTzlYRGVmMml4ZHJmM1Z3SWcrYkZYZ2ZpMkpTNlp6emlqMWxY?=
 =?utf-8?B?ekVoQU83R3o5dnhyTEh2ZHUwSW9CQzV2dDdSWklhRkhkUzRwaHdpOXpwWjEr?=
 =?utf-8?B?UElhN0kwaVlMNzgzS0VCQkxCMFNEcTVZV1hWemR4NlBnUTZxL1YxNVlmZjNK?=
 =?utf-8?B?ZFFWcEc0WFowTzdSVVVhUmZhdW5xYm9tUXE1M3VVY1ZVOTFQTklIUUUxZzV4?=
 =?utf-8?B?SlJvQW1xYWxkL2JWcGZySnpHZTh2ZFM5dG12cjJJdTBycjFHa2dQU2NRdVVY?=
 =?utf-8?B?dWgrMVV3YUFuU3pFN0RRdHo1RjFLMk5venBDdDlvRmJEUDJqdFRUd3BZQTNV?=
 =?utf-8?B?UTVaYjdTdlh0RWplNlo5aWhrbWI0d0dJdTBnOVF4N0dEelJiaHpXRHRMWGY4?=
 =?utf-8?B?a09QZklVWXpNQUpJL1ByWmJZZW8zSXBYeXZFZXJ0UGU0eTV5c3FkYk5HYVE2?=
 =?utf-8?B?VFFKU1pSMjZvSU9UY3UwbVB2U1pIUUhhbW5HNWRaUThOSUd6MHNubzZoTmMw?=
 =?utf-8?B?U1pDRWVJenNrWGx0Y3JheGtLTXhvZERtdGp4Q2tmOUNNTSs2TGVPeml2QXBr?=
 =?utf-8?B?RmZQN0tUWFg4SG9XRVU4RkRjblJDU1BlUkJHOWYxeTRZeXZFUzVlL0s1d2lM?=
 =?utf-8?B?bU5haW43Ynd6L05tQVBtdWkxeU9jVFVYaWFDZVV3ZkhMNDZJLzZaKzBFOEUz?=
 =?utf-8?B?eGF6K3h2YktmRkJEZHRRYm5CbmN6WlYvRllvNXJqRHYvRDNJd01nQzg2Rm1t?=
 =?utf-8?B?eWZzeko4QVpybUF0V1g2dGVyZGZwY1ZTVXF5cjNKUFNqajNOTko4cGREa0ly?=
 =?utf-8?B?Q2FtVGEvWGcwTHZYMDBOdklBZW1UZUJDaUw5VEx3NUVZVWIrcFplZ1haWC84?=
 =?utf-8?B?YTJQYkorNjFwd1NvN214b1BURW5NRVlMdkozSGM2U01mdUZwR3Y4bk5oNk9E?=
 =?utf-8?B?OGpYR1VTbG5YMEd2VmdZbFJmaDhZeXVQb0VCa0h4RklYcWVGNVJ3T1p4ajhq?=
 =?utf-8?B?UCtDQ0lNNWNBQmtvWkZZRktFaWNWTWpWSmhtZXBQTElzcjgxL2w4WElBeWhL?=
 =?utf-8?B?SjhwU0l0TGc1a3I0dmUzajQ2eXhtcWZSdVJ2cm16MktrcitSd241bkdicTI3?=
 =?utf-8?B?OXk1aXFSekoydVNBMDNjaTFJMitzRU1MTGc4Zmx3SmgveEdVTDIrTFM3aXlr?=
 =?utf-8?B?c1lLMnVqS1Rhc202aGg4Y2lJS1FqV3d0MFdTa3I4RGV1dGVMZ1hBZ1QrZjd3?=
 =?utf-8?B?cXJveDdEODJ5RjcrelNkaDNrVnhkUmJlWVU0UU5CeFVZdXNGd09xRDFudFlR?=
 =?utf-8?B?Q3ZLZkJZMDQweGJCWlVKcWo5SFh3bmhxcUdDNFNUTmxwdVBGT01oalkvbWNT?=
 =?utf-8?B?NHR2Q2ZjYXd3Q0FJbGF0Ukx0b0twQXhhRW0vTWtBU1pHVlB5QTBJOS9rVUFN?=
 =?utf-8?B?UUx3MlNxc3E1L2dhakZ1L01PeUt1cjhkb0pKTElQVEJVVHNRbE4zeitBT09N?=
 =?utf-8?B?a3lvQk5USGYwSXA2SDN6Lzk2Z0VucXpRZnRqcVFVSmZ0amhFV2J3T0VTbjRr?=
 =?utf-8?B?NlBZa1NKNUhOVEVsNFFaSUpCM0YrejhHOWo0bU1VOUxuQXNJUktNUGJOMkZS?=
 =?utf-8?B?NjlTcnREcTVmOWNLVWpoVzFscHNLS1pqYm1iMlJGbEMzUUppbythcTJaSklI?=
 =?utf-8?B?cXVORXo3aTFWVk5wMGFUdjF3N0pGdzRvWElrRS9hSkFkdSsyd1F5Z2xSYW9s?=
 =?utf-8?B?SSs4T2hBN0Y5UjNTOVVnakp3a01ZSUFZY1BDQloxckhSVnVUS2dTS0psQkJq?=
 =?utf-8?B?MC8rU3dHMnJYTUVtV2xZTXE5MnlGaWhQMGU0NDU2UVRLK0lyQ3NudHRXeEhR?=
 =?utf-8?B?Zzl0cXllSXNyTmVYQjJZUk5NOU92UEJ5bzBrUEtmT2N3ZlU4M0lGUjVnMndi?=
 =?utf-8?B?eUZDUDNkMmU4OGZERlNQZXlaSVpENlBhTnhIUFhyM3U5L2VUUVNDY1VRNElq?=
 =?utf-8?B?SUVOYVMxOEZHVUwzdnRvSjljSUVkcjd6bnNSTWExWk1objNNMlFvbHJYczlt?=
 =?utf-8?B?U2RKbWFDOXllZyt6L0I2ZmFTNjVuYTdoaUg5US9zSTZzWjJtNnk4NHpRSDVl?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DF86BB7A71262429478202B55C08266@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ydVjimJxeSfBLsI8UvrXlxa/bLMt5DU+hp2Hlutdy/xi+y3RsrrIjrpnonfHV8LlzRwFOLOyMjy926CkZfcOnQIeboUiSrsalsfS/77xetfVHUCoA+WD7XHFh/gh60SCQbN9Mhis+xsWhalA1z7lqo1vISLjKmhaCUrjg+BuPH9eMgCZRGxcTHvUUUHsvhslcKogef8QyWjH94CpumILLFZvxXOE3Szf2uv5+iY01EwyzsfZj+zIAv0MWMnqTaeVxJhFKMjujV2cYDrBqUBH7SeVTQZijxKq7hK/RojKdHRQScDXdKGaKO0EiQjHjY26FpTqs0MLDim9GgiEWDzeDmxHiJ1h8nguCv+FNh6R9aXtz5Siuxu9CnsMuzk1n/nabrXyMPU0GLxT01Hq+Hrz+MZOq/n21Bju6ncTYrGEbP1grrcYH+zHGFkcRHKt4q8O3H4hXQQlu1Ph0uD/RzVCHi/xcot9cu153hzRB6/dIudM5hRTnpzRAAjeAQw5XztAm4RlCs6GPxEv6zfFZbvEk0rq5jQj6M7cJQVxoi7rg93FgRqbc+qIiMbH6tpeTfmpfFrhllkxixumBQS4Pw7+SWdNtusESzxKJdHj8k+SbGqTgt5mezcSrA2WQCC10ypA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a2622c-ad76-4c99-9b06-08dd7cf165c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 14:17:19.2579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1GqU9SAYYnPZug8lqw+2NcJPvDHxBV6fkPHewVGxLzIpCj9lCvq7qPmt8LEdlUnODLy4USfNPgsJFkyzztSbNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6759

T24gRnJpIE1hciAyMSwgMjAyNSBhdCAxOjExIEFNIEpTVCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdy
b3RlOg0KPiBPbiAxOS4wMy4yNSAwNzoxNywgTmFvaGlybyBBb3RhIHdyb3RlOg0KPj4gZGlmZiAt
LWdpdCBhL2ZzL2J0cmZzL2Jsb2NrLWdyb3VwLmMgYi9mcy9idHJmcy9ibG9jay1ncm91cC5jDQo+
PiBpbmRleCA1NmMzYWEwZTdmZTIuLmY1ZjA0ODVkMzdiNiAxMDA2NDQNCj4+IC0tLSBhL2ZzL2J0
cmZzL2Jsb2NrLWdyb3VwLmMNCj4+ICsrKyBiL2ZzL2J0cmZzL2Jsb2NrLWdyb3VwLmMNCj4+IEBA
IC00NTM3LDYgKzQ1MzcsMTIgQEAgaW50IGJ0cmZzX2ZyZWVfYmxvY2tfZ3JvdXBzKHN0cnVjdCBi
dHJmc19mc19pbmZvICppbmZvKQ0KPj4gICAJCQkJCXN0cnVjdCBidHJmc19zcGFjZV9pbmZvLA0K
Pj4gICAJCQkJCWxpc3QpOw0KPj4gICANCj4+ICsJCWZvciAoaW50IGkgPSAwOyBpIDwgQlRSRlNf
U1BBQ0VfSU5GT19TVUJfR1JPVVBfTUFYOyBpKyspIHsNCj4+ICsJCQlpZiAoc3BhY2VfaW5mby0+
c3ViX2dyb3VwW2ldKSB7DQo+PiArCQkJCWNoZWNrX3JlbW92aW5nX3NwYWNlX2luZm8oc3BhY2Vf
aW5mby0+c3ViX2dyb3VwW2ldKTsNCj4+ICsJCQkJa2ZyZWUoc3BhY2VfaW5mby0+c3ViX2dyb3Vw
W2ldKTsNCj4+ICsJCQl9DQo+PiArCQl9DQo+PiAgIAkJY2hlY2tfcmVtb3Zpbmdfc3BhY2VfaW5m
byhzcGFjZV9pbmZvKTsNCj4NCj4geW91IGNvdWxkIG1vdmUgdGhlIGxvb3AgaW50byBjaGVja19y
ZW1vdmluZ19zcGFjZV9pbmZvKCkuIEFzIGxvbmcgYXMgDQo+IHN1Yl9ncm91cHMgZG9uJ3QgaGF2
ZSBzdWJfZ3JvdXBzIHRoZSByZWN1cnNpb24gd29uJ3QgYmUgdG9vIGJhZCBmb3IgdGhlIA0KPiBr
ZXJuZWwncyBzdGFjayBjb25zdHJhaW50cy4NCj4NCj4+ICAgCQlsaXN0X2RlbCgmc3BhY2VfaW5m
by0+bGlzdCk7DQo+PiAgIAkJYnRyZnNfc3lzZnNfcmVtb3ZlX3NwYWNlX2luZm8oc3BhY2VfaW5m
byk7DQo+PiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvc3BhY2UtaW5mby5jIGIvZnMvYnRyZnMvc3Bh
Y2UtaW5mby5jDQo+PiBpbmRleCBjNDIxMTYxZjQyMzcuLjUzZWVhM2NkMmJmMyAxMDA2NDQNCj4+
IC0tLSBhL2ZzL2J0cmZzL3NwYWNlLWluZm8uYw0KPj4gKysrIGIvZnMvYnRyZnMvc3BhY2UtaW5m
by5jDQo+PiBAQCAtMjQ5LDYgKzI0OSw3IEBAIHN0YXRpYyB2b2lkIGluaXRfc3BhY2VfaW5mbyhz
dHJ1Y3QgYnRyZnNfZnNfaW5mbyAqaW5mbywNCj4+ICAgCUlOSVRfTElTVF9IRUFEKCZzcGFjZV9p
bmZvLT5wcmlvcml0eV90aWNrZXRzKTsNCj4+ICAgCXNwYWNlX2luZm8tPmNsYW1wID0gMTsNCj4+
ICAgCWJ0cmZzX3VwZGF0ZV9zcGFjZV9pbmZvX2NodW5rX3NpemUoc3BhY2VfaW5mbywgY2FsY19j
aHVua19zaXplKGluZm8sIGZsYWdzKSk7DQo+PiArCXNwYWNlX2luZm8tPnN1Ymdyb3VwX2lkID0g
U1VCX0dST1VQX1BSSU1BUlk7DQo+PiAgIA0KPj4gICAJaWYgKGJ0cmZzX2lzX3pvbmVkKGluZm8p
KQ0KPj4gICAJCXNwYWNlX2luZm8tPmJnX3JlY2xhaW1fdGhyZXNob2xkID0gQlRSRlNfREVGQVVM
VF9aT05FRF9SRUNMQUlNX1RIUkVTSDsNCj4+IEBAIC0yNjYsNiArMjY3LDIyIEBAIHN0YXRpYyBp
bnQgY3JlYXRlX3NwYWNlX2luZm8oc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmluZm8sIHU2NCBmbGFn
cykNCj4+ICAgDQo+PiAgIAlpbml0X3NwYWNlX2luZm8oaW5mbywgc3BhY2VfaW5mbywgZmxhZ3Mp
Ow0KPj4gICANCj4+ICsJaWYgKGJ0cmZzX2lzX3pvbmVkKGluZm8pKSB7DQo+PiArCQlpZiAoZmxh
Z3MgJiBCVFJGU19CTE9DS19HUk9VUF9EQVRBKSB7DQo+PiArCQkJc3RydWN0IGJ0cmZzX3NwYWNl
X2luZm8gKnJlbG9jID0ga3phbGxvYyhzaXplb2YoKnJlbG9jKSwgR0ZQX05PRlMpOw0KPj4gKw0K
Pj4gKwkJCWlmICghcmVsb2MpDQo+PiArCQkJCXJldHVybiAtRU5PTUVNOw0KPg0KPiBJJ2QgcHJl
ZmVyOg0KPg0KPiAJCQlzdHJ1Y3QgYnRyZnNfc3BhY2VfaW5mbyAqcmVsb2M7DQo+DQo+IAkJCXJl
bG9jID0ga3phbGxvYyhzaXplb2YoKnJlbG9jKSwgR0ZQX05PRlMpOw0KPiAJCQlpZiAoIXJlbG9j
KQ0KPiAJCQkJcmV0dXJuIC1FTk9NRU07DQo+DQo+IEFsc28gbWF5YmUgYWRkIGFzIHRoZSBuZXh0
IHBhdGNoIGFsc28gYWRkcyBhIGNhc2UgZm9yIE1FVEFEQVRBLCBtYXliZSANCj4gZmFjdG9yIHRo
YXQgb3V0IGludG86DQo+DQo+IAlpZiAoYnRyZnNfaXNfem9uZWQoaW5mbykpIHsNCj4gCQlyZXQg
PSBidHJmc19jcmVhdGVfem9uZV9zdWJfc3BhY2VfaW5mbyhpbmZvKTsNCj4gCQkvKiBvciBjcmVh
dGVfc3ViX2luZm9fZm9yX3pvbmVkPyAqLw0KPiAJCWlmIChyZXQpDQo+IAkJCXJldHVybiByZXQ7
DQo+IAl9DQoNCkluZGVlZC4gSSdsbCBmYWN0b3Igb3V0IHRoZSBjb2RlIGludG8gYSBmdW5jdGlv
bi4NCg0KPg0KPj4gKwkJCWluaXRfc3BhY2VfaW5mbyhpbmZvLCByZWxvYywgZmxhZ3MpOw0KPj4g
KwkJCXNwYWNlX2luZm8tPnN1Yl9ncm91cFtTVUJfR1JPVVBfREFUQV9SRUxPQ10gPSByZWxvYzsN
Cj4+ICsJCQlyZWxvYy0+cGFyZW50ID0gc3BhY2VfaW5mbzsNCj4+ICsJCQlyZWxvYy0+c3ViZ3Jv
dXBfaWQgPSBTVUJfR1JPVVBfREFUQV9SRUxPQzsNCj4+ICsNCj4+ICsJCQlyZXQgPSBidHJmc19z
eXNmc19hZGRfc3BhY2VfaW5mb190eXBlKGluZm8sIHJlbG9jKTsNCj4+ICsJCQlBU1NFUlQoIXJl
dCk7DQo+PiArCQl9DQo+PiArCX0NCj4+ICsNCg==

