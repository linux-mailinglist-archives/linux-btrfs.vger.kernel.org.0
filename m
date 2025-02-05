Return-Path: <linux-btrfs+bounces-11292-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 096A1A289AA
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 12:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B96416416D
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 11:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662F421C9E9;
	Wed,  5 Feb 2025 11:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oPr3I1ip";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="P6O9ZBbQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B188B151986
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Feb 2025 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738756101; cv=fail; b=eKC4uSldI1/iZjA5T7RALYiTXTRQ6jmD0+F19zAIuP5I4Z7W9O3ISnkpNNy1iFriAZ5FcV8aZBo5fwoSBJWklf6PDsyhOpbCN8wTXnxeU4DDaZ9+y++KgYX+Af3f3UEX01q1gI9ylfvCUMwEwrKLrgqnsOIeGL5wpYgAWnCyVAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738756101; c=relaxed/simple;
	bh=RPe8cSMdTDP3J18NA2Xrcm4NrF7+6vQjcX5T9D2pL+Q=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BbS2BzmyvdvBgFrCG9sL2wxhjnJMpadiJrM/KdMU8EtjoYncDURS7ylFkmwxyqWn8EyG5oftdkZgZRtSOJqLnxA7+1fVBsiZMQUGMe1Ka1MxQdSZH8SBGH5bQrbuet44xtmhfvjiOEJmjuqGnfojsR0RF2AoseOo+yaPHrFRbxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oPr3I1ip; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=P6O9ZBbQ; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1738756099; x=1770292099;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=RPe8cSMdTDP3J18NA2Xrcm4NrF7+6vQjcX5T9D2pL+Q=;
  b=oPr3I1ipCBV4yU9WiH/7VCM5Qj6EuI7O2nm3yJ21AnV5HW4MrGq+/dL/
   M4Qsy7ToxXFh/brMA164ZoJLjL63sgalAYzT003vYUoH9w4YJhFsIPm5S
   ROZpSjluWkM5OtfiKPIquw1oLis5gCofNTNV95VBX3N5uU0xIhj2F7oJy
   od07F0YTZI7o5bAsiJWzghuVes7NJ7A8EnMp4fexKZ2aLi5W0ej8yf/co
   V5GOMlWIS7hTQtopp3fOanqlnHaLv4ooZ2rBCvPEjQCT9TthAn3Th/aqy
   eG4DHjcZMCIa9WVG0g1mfPGxKD2Vi4dYHQnQZ3f2dZDhcv7E+S3mNVDrn
   Q==;
X-CSE-ConnectionGUID: 7C/4AdeJQxCNWoV6iGwy/Q==
X-CSE-MsgGUID: nnQ96x3KTEq9LeWJftg5MQ==
X-IronPort-AV: E=Sophos;i="6.13,261,1732550400"; 
   d="scan'208";a="38890013"
Received: from mail-bl0pr05cu006.outbound1701.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.2.8])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2025 19:48:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FxwPjS/+Vsl41papEjEo6dKDE0LN+zGKIppsI+ma84UyS11zXbzsYthf6t6DvT+Haa4DKUE0WDE5pwUE2GOkllfe1fdBSWnwk8fYiLx5hsNn51eeM99oxiVTc0+BDOWRiDMWDpfBwu6TJXM0+zMNwnBwbF8nW3H/m+3P6jCX9r25ihqkvGLsTsm3XZh0PBQwuZRcaLoYgp1NaUlLOkDj3pHxyqVR0w/0tFNvKcZVmk5CQpou6Jx8ZBcoR2If335uegrRGD8mqEYAI+Xft6zdZfXtr40158tgKZFj9gADtlp7/hrlrrYgGg1mzluxASJ38eEjL5wiTod3cP6CZBXqWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPe8cSMdTDP3J18NA2Xrcm4NrF7+6vQjcX5T9D2pL+Q=;
 b=eouai886H9Ul/UF5/1PWYNZPx5peUHkECc0oiry4l2YPYI1GkR9lCz0Y4lwXCG+vfAAkrVaBbEB+6lzr/7HqqHgSlFTp7Mf0V2HGsJWIv8UkveDnPL+0yrY7NkiZeNMXq7SzKtOVWQm6ik4rIvdux274At0KoJfUMY+P2tyWa5vXUiP2SnP7HFME59j9BlO9VI4yFHIYlhVjSGnAl0s0JhRMa6j79349zvvSaCJHQTawKctXpQyb6flsAxGoL+DzmmCeufuA7f6UYRgLVhXUvd6s6qrAWSwu/csXban2Ig8c8dyfd3S3QOhl8eHCYmM51IVsDw/zrV8d41OhqoIl1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPe8cSMdTDP3J18NA2Xrcm4NrF7+6vQjcX5T9D2pL+Q=;
 b=P6O9ZBbQ+GFva/xfByB71CcIO+9oPBHPkN5Y68w6mH67pIZYhw1e8HW9elKcW5SdeDkT2c7mVRCNDdlASMxel2qjMq1QEp0u4Uz/JWKhNGvvdZ/ZNpmKT/+JA6vilc4bS+5SJNGa1wOXR8FEc+NpiPl5e2ZpQslw+0wGzUsGPnk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB7055.namprd04.prod.outlook.com (2603:10b6:208:1e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 11:48:11 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8422.009; Wed, 5 Feb 2025
 11:48:10 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: avoid assigning twice to block_start at
 btrfs_do_readpage()
Thread-Topic: [PATCH] btrfs: avoid assigning twice to block_start at
 btrfs_do_readpage()
Thread-Index: AQHbd8JD5MtFjzLqNUG8TgLRuWDdMbM4mCMA
Date: Wed, 5 Feb 2025 11:48:10 +0000
Message-ID: <651d1f9e-c7b6-4e7c-b151-ff29adb27047@wdc.com>
References:
 <87182120501efa8c878a65196fd6225481cab7c1.1738755264.git.fdmanana@suse.com>
In-Reply-To:
 <87182120501efa8c878a65196fd6225481cab7c1.1738755264.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB7055:EE_
x-ms-office365-filtering-correlation-id: bd829ca7-9891-4b11-6ec7-08dd45daf738
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S3hNb0ZZZE0wSmM1N1FSSXAwSkVLU2VwRXdvemI1NTR5VDdOdWhxN3dVQ1oz?=
 =?utf-8?B?djFxZTRRRlFCZ2NxbEFJQWFnV0lZcXZNNGZ5ZHN4WE52WXJBVDZxc0xESnRl?=
 =?utf-8?B?SEdzazdleEozM0NZZzZtMEQ2Ym01OG5ERGdqYUdvYWFwbTJGbkJZQy9XVk45?=
 =?utf-8?B?citWazlmcUVqa3FNNHZpS0ZtaTZneGkybCtxeS9SVGNQYi8wcG5hbytuNVpF?=
 =?utf-8?B?MVZQSVhlNzA2d0U2YTMvN3hVcUV2bWZHNlRDZ2ZhMlM0WkVObEdMaDQ5dFRn?=
 =?utf-8?B?YVlEcDFwcEVsUzl5c21teHNNdXZJZy9HUmdSZCt0TFhmTklnTmZYZHM1QjZr?=
 =?utf-8?B?dXJYK3NBdnpnSjJZUER5eTBvK25pRWg2T0tLaTVjVGMyMGd0eVVOUEcxeVNY?=
 =?utf-8?B?SkhmVVdsV3ZOOEo2WXpzajJOa3JYMWxOeGdBdDYzbFp4c1BZQjJuaTlDZXFH?=
 =?utf-8?B?QXdMMkxqWks5cUtyMFFDK1U4MEdzaVZSME1VQnZKZ3JvbDY1SmtlblJZOSt0?=
 =?utf-8?B?Y3Nnb2FRcHdGS0hYNVBqRFNuWjErUTFVaGQyVk5wZzFiYlAxeHR3Ukkrbmh0?=
 =?utf-8?B?aXpqZVBqWjFqMUJ0b3dROXc0L2JpSEwwQmdmT1hpMDNwM3Y4UzQ2UktBWi9p?=
 =?utf-8?B?bVZ4VnFoR3orRkt5YmsvdCtjUlF4N1ZLMmNNdlNldStjTmhMN1VlL1NSdlhO?=
 =?utf-8?B?OUowREJnY1UvL3p6VGF0eGpoVkRpVUdXM2xtazRDU2VxUlJjZnY1S3BYK2FM?=
 =?utf-8?B?djlpRFB1M05sS0ptYmt1ZTl5bXMySnRLek4wQWJacGVMR2VEZVhjN0dSN2R0?=
 =?utf-8?B?bUc5akZtQVdLVGEvMW5XbFhJWkxrVW1lU3VJV1BIR0xDZ2QwcktZcWhGeVk3?=
 =?utf-8?B?RWJTMTB3aGtwRnV0MFh3eldhSGU0TUplUUkrcHRGSmZvWHk1VmMvUEdTaGs4?=
 =?utf-8?B?dTNxMmVCOVM2WGFEWTgrK3dOSkpBRG82WVJHeit0bFdnR01XN3hqSy9CLzdT?=
 =?utf-8?B?dmw1ZHoxUC9ScjhQMHhlT0wwTlVueExYOVNxcUFRNFNZWFJOWHE0Ykh0ZjFG?=
 =?utf-8?B?bk1PLzJTV01USWhLMUR3TjlDMXJlRUIxTTh3QTBkZ3Arb0htdDMwSWk0MllU?=
 =?utf-8?B?dDM1a1RqdFFzY2c2WnpFeDBtMjJSa0JVNUxuZnhWSUZ5aDk0SkhjcTU2dktk?=
 =?utf-8?B?WmxaMEJZWUZiL0FLWXNRbi9vajcybWk2UVlhdzh0S1NkUXJFYkI3cGtwS1dt?=
 =?utf-8?B?WENyTUJZMjdEdmZPOU1iamdUZE9FZlJrT2twSm5GcnBjZTdNT2dxT0sxUU5L?=
 =?utf-8?B?dGhlZkRpMlg1bmZhZzVLaEZoOGRUM29Va3FZSk1aSDY1MGthak5yb0ZvcWM2?=
 =?utf-8?B?eFA3RTVrZUljdUZuQTNqRW1ONWtIYTNpSHQySEg2OGtqUFFWTU93QVk2QWEz?=
 =?utf-8?B?b3JQVWE2RWtzb1VQdzRraVJtanllTXFmVVBKQzhzTHp1ajVxWFBMSmt2MUJD?=
 =?utf-8?B?TUIvQjMvWXJDZGYwY2FRTlB6QWJyNHNrWXB6M2ZuaFZ2NmFVVXM2Q3ZpRkhG?=
 =?utf-8?B?bVJwREtic0ZBNUJxVmtwbTlmWGxlYUlrWEs2S0FLaERkL1NTdkRqejRhUmE0?=
 =?utf-8?B?WkVKajhteE96a2t0UzFEUk1wc1lxQ2xkS0UzMHVsTGx1V2xEbUVHbmZHaVpF?=
 =?utf-8?B?V3dwcjFtVk11NFQ5UWpvUFJ0bHl6c2NYQW03Z2FzZWEyV0h5aVhQaFBtNWI5?=
 =?utf-8?B?bVlGYXpqd2VhOXdWM1ZRdjZhUHRHbHhzcEZueGNDbUloWUxLRkVrSHRLWGU5?=
 =?utf-8?B?SDZUWWg4SEtCVlpEM2JZcWxBY3NwR0p4REFXaGlLK05ZMmswRzgzcnR5bUNB?=
 =?utf-8?B?ZnpTazBTM1UyVHJlWGkzL1VNVktnZ2NMcnVCVWExQnlScnFRRVhkVU5OQ3Mz?=
 =?utf-8?Q?VuiBB3plWArnuk1XXjvpniqzBmoN+iqE?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZGU3dWhWM0k3d2N3REZVVHZVMU95S2ZTSmY1Q2sraFc1L1BudXJyT2dZSXRa?=
 =?utf-8?B?MnRXd2J4bVNSeDE5aEplUk81WmNkSEExTVJaZVYzZ3VGVnJCSFNFUTBna2d3?=
 =?utf-8?B?dXVnQmFUL2t3dzh5MHFCbWVFMUR4c2dDMXg5cDZaSzhoenplekVyeWNSKzJ1?=
 =?utf-8?B?MktVTGIrYXorTCtXSUs3RlJ3TS9ZcWhLbmdSanR1SkNPcVp1aUduUysrZXNJ?=
 =?utf-8?B?bkZJMUdySDBTT0JQM2ZvajRQZVoxV2lHM2s3dm1zTUF6bkFwYllSWG9jdE5s?=
 =?utf-8?B?eE4rRnk2VndDMndRcVpWM0xqVVErUlIxdVl4MTY4Ukp3Q0RQOVpYV2dzdG9J?=
 =?utf-8?B?c3VueXpwVkVaeVRjdnZ5a3pxNHFaRnQ1VXdSZjczV0VlMjdhOW1LSUV0RFhQ?=
 =?utf-8?B?VEZtbVg4S2VzLzl1OVJxa1E5eDl6TThEWGV5N2sycGx4OG1GUjZyK3hjM3lz?=
 =?utf-8?B?NDJXMENTbDF0eWo5UlFCZ2I5TlpJcUphd2FDNmNsSG9laStkZStrZkpteWZL?=
 =?utf-8?B?ZFVsNWRBMUxjQ09HTHYzMTlkTnpwR3VLcCs1dkJDenRWT2RqTmxsUUlsYm5X?=
 =?utf-8?B?MDlUekFXZ1RMdURFWW1uM2xqYWI1ZHM1Qm4vWklSMG5iMlgvVXAvWVJsb2ZB?=
 =?utf-8?B?RzhWWXJLaTRXQ2g1LzFwYUtaaVQwejZJOGRoa2J3bEpHeFJhZktTVHFiRkdB?=
 =?utf-8?B?d2Jqcm43QzhzVFh5TFpEcnRrNjFVaUpjc0lERHpaTW84djQ2cHlGMC9SQzBR?=
 =?utf-8?B?NE5neHR5Z0U4NjN2OFNWRlFHQjQ3d2dpeUtCWEpjRmRlVmI1N1c0ZWhHUUsw?=
 =?utf-8?B?eCtwcUQwUGxlM0xBZmF3Q0swdmorWmFLWGFENlFlV1AySlIxcW9sMDltQVNl?=
 =?utf-8?B?SVVnclQ4dG9rR0dMMUxtc0JNc1dMbmNFMjhKUU5ScFIrRWVjOVJiUEpIbTls?=
 =?utf-8?B?VG9TTmpiWmVEa0lOeWI1RS9tQTVqemUrMjRobnl5WVZVTjNZdnNYd2xhQWll?=
 =?utf-8?B?U25zV1VTYVhrTFhndTduZjhsQmMvSVVDVDBoZUdBS0dTeXRuc1dWY1FPMGhU?=
 =?utf-8?B?ajUrRkJVMkppcHBLS291VVNuTTB5enYrblY1cXA1TkttSk9zS3dYNmFWb1B4?=
 =?utf-8?B?Vlh6a1RnWXFmNEh6YUR4ano3QU5Delc1OC8zby9NWXg5dFhZR1RFRWk5Tm1r?=
 =?utf-8?B?MUhMYzhNeG9rK0pEY3krN244M0ZXUjYzUkh1dkcvZHRRRVJycHBpMWRySmUy?=
 =?utf-8?B?bm45eFdsNXJ1MmEyeDNRYW15eWdYbld0TWQwclJsQzlUNFhLbS9LdkR3ZEhr?=
 =?utf-8?B?TGp5eEs0ZDk3b1B2VENQU21YUFF1VE1KYXhhdDhDZTdhRmE0S2gvYTh4K3JX?=
 =?utf-8?B?NFcrNGl3U1Qxd1pJb1pNVjF4V3prUDM3dDMwZHpVRGc4eGdwN0t0WWVyZUlO?=
 =?utf-8?B?QkhhcXhkcTJndjN2V0d5NThSRHBWZnRlbTQ1c2FrdloxSDhqQWxVSi8vNnRP?=
 =?utf-8?B?QkJTTE9MV0NORnBxTS9PQUVjNWlzclVON1FoVEJFUU8rbFZHbzFiN2FzUTZm?=
 =?utf-8?B?eFp5Y3oxV292SGtCUm1QMEt5S1FBN3AvNzQydnFGN2VBcE1MVXI4WFdjQ2Zo?=
 =?utf-8?B?SWtOZjJ4T0hPeTczMjVuRGJHZENIaDczMDRBd1F0emRuZVZGSytURWQ4TGNU?=
 =?utf-8?B?alZzMWNDdGEwdk9vR3JzYXg4MVZLRDN5WU1WS1MvZmh5M1FkaW9UVzZPVjBk?=
 =?utf-8?B?Mk44RSt2NktmbkgzZmtpU1ZPR0hPQjVNL1kvUzZyTm8vSXI0VG9TemROby9i?=
 =?utf-8?B?RmdSS2JBNFlnQjdaSzhlZWptNzY3R3FYVUNVWWM1aGQzeThBcEVEYk1JYnQv?=
 =?utf-8?B?QytwcHVsVDJ0SFBHRXRNelJ2RDdjSXhhMm9NdUNNcUdWTklDSG9TTEdoVE40?=
 =?utf-8?B?eUR5N0RyY3diZ2NVODVGc3Q3ejU1Zjk2OFlmL1V5Sk9seXl1TG9NZnpwbmta?=
 =?utf-8?B?SnRNaW9VL0VCaUlLMzdkbGEraUI4R09RZzU4M0pCYWEzRGVSQkRPVkxRcmtK?=
 =?utf-8?B?OVJpUDJHY1FaMlZIVlNhaG5tRC9Qa203MVI1ZVdtMU02U2s4WlI0Znh5c0Zv?=
 =?utf-8?B?a1ZyTHhERVE1U1VLenBVQnZkeDhOSm0rT0htNTVoMWJWc0gxUGwrVFlzcjh6?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <554DAF458EF2DC4192981E82C48B327C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PX9AlVJSlSEXluG3BlA62wmoau9n4vErm5Ihf9bHfsSicqYXbaCofOS/A028A6uoMocwH+RbDdAQKwmazY/KFLG06GdAjSr8WPBCLVTtEuiq94CjwFJ74Ikqh/3Ni3bUk4kT6S+TfvFyWr0TzcphHs3sr0We/zrwbXwqCgX9lukna5qVZHAxBrtDlD7bYql31T7WMJlpze8ExsfrH4gzVcOGOoGJOSIFH7qA660d2cpTZ1/V6lCaIe0F3Mk4DcdXzLy4B1u88xXv50kye6ipK8ww5OjOBjmBfNQnt5fKklDuoAP8phLcZPnj2EKaJQBrxtYiLQK7ji3OeRf5SHU2NnHNh3OxaAdeX4OeJzNQd6FJyPuYpEKKZhQ4LiBlWZdN/R+ehbj3zizHI2R24hej2V+oPXJnrFAxTdJ2yc6XGuxeQpatLzD27mp7z3o7bQHrX9hbrQyK2mRTT7QrgD1cxa9QCLwp/QCIh+3tuGaHF9xGK+B3VICDaZZHp/satUdQ+croZSK5xCvsdK0C34E7bFNbsfZfmqFDZM5T1VxeipZO+hAwbe2cg2m0fhp7xsEYSGL5mPV5JSXNOz/rwxJyVZ6j3logMK7UtgYZe3i9cgYfyhU8eMV4A6PiRLx34Y35
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd829ca7-9891-4b11-6ec7-08dd45daf738
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 11:48:10.8913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s8ZyWamd41OCPnZgCQAL8TZR6Db5qYcNuVrydhyHU3xckq9xdzu37wGYBKJh/wbAYzjiQwd3VQ1K1PNqe7y5m1HjCkg6GtYD9qtMKk7kOw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7055

T24gMDUuMDIuMjUgMTI6MzYsIGZkbWFuYW5hQGtlcm5lbC5vcmcgd3JvdGU6DQo+IEZyb206IEZp
bGlwZSBNYW5hbmEgPGZkbWFuYW5hQHN1c2UuY29tPg0KPiANCj4gQXQgYnRyZnNfZG9fcmVhZHBh
Z2UoKSBpZiB3ZSBnZXQgYW4gZXh0ZW50IG1hcCBmb3IgYSBwcmVhbGxvYyBleHRlbnQgd2UNCj4g
ZW5kIHVwIGFzc2lnbmluZyB0d2ljZSB0byB0aGUgJ2Jsb2NrX3N0YXJ0JyB2YXJpYWJsZSwgZmly
c3QgdGhlIHZhbHVlDQo+IHJldHVybmVkIGJ5IGV4dGVudF9tYXBfYmxvY2tfc3RhcnQoKSBhbmQg
dGhlbiBFWFRFTlRfTUFQX0hPTEUuIFRoaXMgaXMNCj4gcG9pbnRsZXNzIHNvIG1ha2UgaXQgbW9y
ZSBjbGVhciBieSB1c2luZyBhbiBpZi1lbHNlIHN0YXRlbWVudCBhbmQgZG9pbmcNCj4gb25seSBv
bmUgYXNzaWdubWVudC4NCg0KSSB0aGluayB5b3UgY291bGQgYWxzbyBtb3ZlIHRoZSBkZWNsYXJh
dGlvbiBvZiBibG9ja19zdGFydCBpbnRvIHRoZSANCndoaWxlKCkgbG9vcCwgYXMgaXQncyBub3Qg
dXNlZCBvdXRzaWRlIG9mIGl0LCB3aGlsZSB5b3UncmUgYXQgaXQuDQpCdXQgdGhhdCdzIG5vdCBh
IGJpZyBpc3N1ZS4NCg0KQW55d2F5cywNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4g
PGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0K

