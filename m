Return-Path: <linux-btrfs+bounces-9433-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 757709C4512
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 19:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F511F25D2B
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 18:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F096E1AC427;
	Mon, 11 Nov 2024 18:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="jVi5uwyV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911EB1AB51D
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 18:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350196; cv=fail; b=jm+h8G/yDGtFwc3nOGqT/jACyXTgGJIXB3jEIrVlwdu3yyEL/0CRLAjTQ0Kayh+FbTjX6HmxLhiuzxvixE6Yycz8SBHUSQgUSzdZYu8Jm5v7UUIVV2qvSivnj7wx658YPPYIDxJ3vkyV2fAdtTD3zCHTWrsnWAI9h30YTtm4hAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350196; c=relaxed/simple;
	bh=Xe4+hz7YyGq0YHTvjQAvjxGslLGem7bInjcCTVYqri0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=bWqO8HUZwKVJ3+v6OwWu3dN4B3Wr+Vkg8JWYHfIZBmZvJpWnft7rXpy8w/1r9qfNtG6LvmhAc5NkQlSaJkVk3cXGjNSSpktLQeQdiKH35OcsIks/hYrpk0STFzPxBmkWeSTHtxqk2JCr0Z7J1Lb0tTxzk8FML6Y8pI36wZfI9hQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=jVi5uwyV; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABH6qCn000790
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 10:36:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=Byk2aXkUukfqXte+R+i94NDhrLVJ057tYUlLBREDW2w=; b=
	jVi5uwyVpqVJqBZ19Qzwhg3VhkuarapmyStt629fddUsO2r6ihpDH1KzhrJFNerT
	wLDwZCbklPkUoQjR/FbpNxHs6oQ+NKZUdFUd+OsufaxwItrcmQ8Maeu8utY0Km6U
	kobaxeefEi7EZz9ac204j0uYhNt3Hu5dPiY2E9C2UoIDyZT9UzQvMhbnCn6bh79A
	9U06/QpEJ6UvlzW4smT74fcPGBwchJvKa+22fxNglim0Wr2PXwOrYohc/C/+XLqg
	6WSC5dGPo2REVJe8FhGXckRXB4ocNmfUsHhSo+cLkHpZ255R253q9uV33egv7ezL
	S68KNFBlRXSgYpwAOQKffQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42ufw1b0ca-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 10:36:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ec1hQ/x+lMy1Tvs664XPQg2DI3AdKtVYRanziI5xzf85axvjyI3TwASI9MlI51avvKP8h28lG/qHvC/2smxv0EVdEGTIIVauKJnZFW6lbbLbhjy+JNkmH/maYQ+LErQ8s//LfOBlDhDZ0Ol/infRosep6TVLx9i3EnIQFy7HtUlCasGRNDnoFmDXsuETCXXL3Dho5cyt/dzEXEzLgRxN/Tc8LbN503LpNPkfhXztxR5JXsS5wXSyr1ui3yP7CdC+G2oALVqSUaMgZudMWitDLTtIy1GaI5tKrZID7/LTtRNoCe/dvTOcMV7s+SyhXwmv2WAmUAYdQZCNrFC2qe1YRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKFwvllFgzmWMIhn+u93oLB5svCU9US0lAhe5lUiFWM=;
 b=hP0ju+cubQg7tJehyE+c1SUxHx7khQbCoFJ+E9jXr7myey9H0CxmdOLbmM8pfO1R1UmktX9GYE4mgUpLCJ7nm1UzMgE9iHc1KCJSz4AIZWaqwQX/hjUz7i0r9XHHCX+qxb6mO/jX78WbTpWBKDYTSACeeQW8aD2mNW1YK4AnESjX+TiAPXweM8wGf3LshpJCR0lkT/bR2zSL51cUWAqthlEoJgmzYMjqo9B9sIx39myCBZ1/TbLW9sWFkPj4OI0iDVqxDQp/Bf2xpKBZ+IdedLWoYkZAUIZ9Z0DzMYJZZkarnHwY0ae+Vrwm8p+NZpfcoN5Oi6Bpgpluujb+5NnXkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by IA0PR15MB5522.namprd15.prod.outlook.com (2603:10b6:208:442::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 18:36:28 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 18:36:27 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Johannes Thumshirn <jth@kernel.org>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Damien Le Moal <dlemoal@kernel.org>,
        Johannes Thumshirn
	<johannes.thumshirn@wdc.com>,
        Mark Harmstone <maharmstone@meta.com>,
        Omar
 Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 2/2] btrfs: simplify waiting for encoded read endios
Thread-Topic: [PATCH 2/2] btrfs: simplify waiting for encoded read endios
Thread-Index: AQHbNBwjsI+o9gnI7UKnPyG/vCt8eLKyaQIA
Date: Mon, 11 Nov 2024 18:36:27 +0000
Message-ID: <53822a38-f181-4ff5-b871-c405c29566f0@meta.com>
References: <cover.1731316882.git.jth@kernel.org>
 <22c7231a2ce9c0c7c187dff159be1c868d783765.1731316882.git.jth@kernel.org>
In-Reply-To:
 <22c7231a2ce9c0c7c187dff159be1c868d783765.1731316882.git.jth@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|IA0PR15MB5522:EE_
x-ms-office365-filtering-correlation-id: bea2892a-1512-4ace-2663-08dd027fc0e7
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eTBpb1B3cmt0Wk9zcGRFY1NLMzRoNDJsMURnUnp1cVpORTB5dDdQUFpFM1hD?=
 =?utf-8?B?cTI4MHBwODNJSDNURGFEMVhYbzM2VmduZzZMRm9paG52bGt3MGxNY214YXRX?=
 =?utf-8?B?WGpmOWIydWtvd3lYMHNkYmFnMWV1VmR4RXdvKzNHTytRRFYySGRyOTJnTWZU?=
 =?utf-8?B?UGlJeFlXSndnaEdOZmU4cC9tSkh6eVBCdXpQVkZQNXZRN0JaMjRrRkJkMU1t?=
 =?utf-8?B?dzE0V29KUzlPNTNSa3BNRVI4a3pkZldnUzZRZzVmSXFlZzI5TzZoVkFFUmRE?=
 =?utf-8?B?ZjJiRWE0VWNWNTQvQXAxcnRDZmNyRTVFZnpMZ1NNRUNIdGxWenVHZDRMaW92?=
 =?utf-8?B?QWdaUFdEVmV4dndhM1U3ZVRlaGJHL0FRVHQ1YVQ0czVUbjhJbVlHb094c3Qy?=
 =?utf-8?B?TnAxWDVKclNLUUhTMlh1YVpYV0EvdFptM29mL0tESDkyUUlJdE1RMmUrVXVm?=
 =?utf-8?B?UEs3c1hCbnJFU0pINEtuQnhIeGpqUXo4eXdTbTVzakR4VU1jVCt6YjhnNnlE?=
 =?utf-8?B?TXRKR2d4aDFSUU5ZVGFDMUxZSHg3T2p6akpyN2t5RFZ4ZW5GNThCWVF3SVFN?=
 =?utf-8?B?eTcxa0VEdHlXNFl4N0h6RXVpVmFWbUR4MENsWTFHYTQ5SWIvWU4rQjBSa0hz?=
 =?utf-8?B?U1E4WTFYMVJNL2lqZzFBTzNLVWNCVlVMdXZOVXY1eXBFSWFFdktCRnk3Zk1q?=
 =?utf-8?B?QS9teEx4aHJJdDJnbmo5U2lScWtqOW1lR2NZdzN2OGZKRW5HeXpoRnJLOTlk?=
 =?utf-8?B?cE03Z3Q1V1hGWEJ0QitGM3hTSkpHaTlmMjArcnNwVU5lQ1JZWDE1OHFqNDZQ?=
 =?utf-8?B?OXBvSWRqcHY2c1M2N3J6WkN6UXh3MnVRODRZQmRJcnlpT2xXNHd6ODhCYWJZ?=
 =?utf-8?B?UHZsQkd2cmFwaUo5SmJVaVFBa3hMM0hlUWxpTWViQ283OW1ScXE1TEpZOUZI?=
 =?utf-8?B?ek5UY2s3YklMTXJXclllWnF6S09MMlhUNUdrRVhWTEdhSkhLT1ZwRVJxWE5y?=
 =?utf-8?B?aDE4alJ3QVRjaEVDd3VOOG1ES2xOVWZ2azFrV1NleXFoMmg2bEQyWXRvNEdW?=
 =?utf-8?B?ZzdjMnEwK0p2WXQwQ04vTDlsaVY0TlJOTnF0cjhpWGxzRHdKS2pnaTgwK1Ar?=
 =?utf-8?B?eGdiY2J4dGN0ZzVLYklzbVBwekFvcllzYzYrV2VSUkdUZkxqcDZJZDZ1M1ls?=
 =?utf-8?B?OEw1dU8rN0VLWlQwWFVrQVB2OGI3SkNZb2xZdzhHNDROcTFkd1UrQ2h4bUdn?=
 =?utf-8?B?VDZERTNlcDQvazF1dXJCb1RpVlRnUHJjTWttQlZzSmJQZkhSZUhhNzAxRTZE?=
 =?utf-8?B?MlBnUVVyejd6Uko0aXdKV0tIeUlMZFA5SlJuSzYxM2FyZ2ZDeDN6MFZFWVpa?=
 =?utf-8?B?ME9qc0F0V1dKQ2RuSnZRTWl1bHM3MW5DNWIzVlhqWitGU2VlYUFoODNrSTdD?=
 =?utf-8?B?Q3hwYyttTFJJdWxtMldxV2ZEWlhTODNXdEorOGNxZ1k1R3B5MUNpT3hGeUF6?=
 =?utf-8?B?NzM2dFovZnJhN2JOejJYTTcwWUx1dCtSYllQdTJUZkRhbFVVdFJqZ3pmdmJv?=
 =?utf-8?B?SFQ4dXgxdER3cHBRclRyOVFDbllmbE1ZS1dRZ0ZINVBXL3h0RGJhcEdwOHNN?=
 =?utf-8?B?eDhXZzNNSERDYjl5emNyNGVIRWk1T2ZzaFYvQkc4WTF2aHgxREZrNXc0Q2Vw?=
 =?utf-8?B?dGZtYUpNays1am9MdlFlU25uMDRzVWxXazVXb3BRc0VCUXpjVUlOMmFFMGw4?=
 =?utf-8?B?YUZsYVlGZXlFQnJqT2xITi9mQ1JGT1Zqb3AyMnBWQjd6L0tHR1dkNE9Xcjh3?=
 =?utf-8?Q?rsV8mmHyuhL0oi+0lm6Y7rKHzYJ3sxLm2hkTM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bHIxVmY0OVYxeVpqbUxPaGVFQmE5emhlZS91TGRSN3RSYm9mSXBpT01wMzRY?=
 =?utf-8?B?WFFtYkZLZzFRSGhRRGFZOW8yaG5Vc0pnY3Vqbkl4S0YrRGN0bXVzT2xaeWs0?=
 =?utf-8?B?WjhBTDVVRVg4NUhUS1RrZWt3NDdseXFhQmpCeE5BMnJ5U05UR2YvMC96L0tG?=
 =?utf-8?B?QWhkZ0xpTTBIR3NLSDZhaHFzbXZ2Zjg0K2pkdHAyTUtiTnRkWVljdVFFTXBT?=
 =?utf-8?B?SnNvNWM5RWdmeGc0bHJTMTc0R1Ardkc5ZEdsamw0dGRUWU93TzEzRW55c1hu?=
 =?utf-8?B?S3VWejg2MlNOQWs2OUMxbG1pclRFb2R1a0ZnakszUklzNS94SWRVTE5sdmZl?=
 =?utf-8?B?SUxaTVVPUVlEd1FrQkJNN1ZxT0pmQ24wZkZnMVlRUHQweVlnTWdDZmZHNmZJ?=
 =?utf-8?B?YlJuNlNBcFNsQnVQdHQvbHRFNTZjcnVZMmtwbGkvL0JzM0ZPN1luenViakE0?=
 =?utf-8?B?eHdlNUdRMHNVb0Y1MEsvQTRpSklSb3pNWFZZRFI1OWYwczQwS0VBd3RCNW1w?=
 =?utf-8?B?S0RxZ1drS0RVS2VySm9zd2REdEtVR01Jc0lCR0M0d1Z6di85ZVpvdjV5WkY3?=
 =?utf-8?B?WDBiZ2NDL1ppRWY1ci9scnREQ2NGeERVeDlrb3p1U2ZBNTdLRllIeUZnOWlu?=
 =?utf-8?B?bTJDMzZ6RGYvcnpGbTNReHpzdm40c3BjSmozQmszWEVNQU80alFnZnBTOXM2?=
 =?utf-8?B?OGRCZWtYQ09zU0pnNzhkOXFkRGh5WGQrUUszTHFYU1ZWbE9LM3crRHNmOG52?=
 =?utf-8?B?QTl2STFUR2pybk5MSmluMUU4aTYzd1dKQkd6ZXhwWUwvTXJ4Mkhwc2RYMWpj?=
 =?utf-8?B?Q0xGMjd3c2RSVkhuZHlNZXBlZk5qSjlHMWJhTTVUaytGMDR4WXZSU1BQanQr?=
 =?utf-8?B?TW5lRzYzU0hRNi9iaXhBZDN2UXJPeDhZSmIvU0dTMndiK0RURy9vS01rRVlN?=
 =?utf-8?B?L0dOc2RkYUtKOEVlMFlsSlZKQi9vQUgyZDJOUFhUZE5xcTNXQ0pyY0t1aHdy?=
 =?utf-8?B?MDQvekdJQVpVbEg0VVVOMHZTallMeGpXUU5PNHJEZlJVUDFKdHIrZkUxNmo0?=
 =?utf-8?B?ZHd1NnpTdWkxMlRyYlRrbC9wR0lGRDZFaTAxc1FxV29kQWZMdjR1UjRqUTBJ?=
 =?utf-8?B?bkNiTGdMa2V4czRNb1hQRGlKZ21hMnJLZFFqUm9CTC9hc2E5TytDUTRyZFV1?=
 =?utf-8?B?M2xkdG44QVlVb0tSL2xCcjlqTm5BcFY3a3h2TGNSeVFGODhscUxNaGcybmVS?=
 =?utf-8?B?eWdFZ242RktzVVVnWkt3V0todi9JV2RvWGl4U0hQM2FCdE1BdVVzbDJtaEpC?=
 =?utf-8?B?dXp3NjlBNXk3dFFWOExuazZqdXNhd01zem9pUHFFRmIxS2ZpTG1PNlBNTUww?=
 =?utf-8?B?S09MZzVNTHhiTlhBSHV0YkoyTkZ4eFM4aUVaeGpEZFVvN1lkWHZ3SUt0cmox?=
 =?utf-8?B?a1dYVGFUaStybm9RUXkxaHZWa05tY3B3bS9jL2RycmtlaWplenpNSHpPa0xK?=
 =?utf-8?B?TUVLZ1pnelRHenpTbVhHQzEvczQ2ZTJ0eWVKdE92Q0ZHK0FSNjkxVFJNTVFV?=
 =?utf-8?B?eDBFcjR0cGcvV1VMcXBqWTFkUGpzaS9VbHQyUG52cFV0SGVEZHVQVy9YdHdz?=
 =?utf-8?B?K253YzFmRnhVSXpkd0ZzQTViL1hhRGlmVW9zZ0JYRWlIZ1ZIbG04cHlnVk1m?=
 =?utf-8?B?eklWU2QvdTNFQ0hkMHh2c3dycEo3VDlnekZobFZBWjh1NE1NZVpyV1NrNFI4?=
 =?utf-8?B?UEw5alRiR1VGdDVLR3RkYmhtRDVrTmgxbEJ1N2RhczVTTGFkcUZOUHp1Qmkz?=
 =?utf-8?B?MVQzakV3ejZMVmI2eTUyYmdEY2lzcEZ3SnRnK3FvZ0cvMWhlb0xZUk50SjI0?=
 =?utf-8?B?cnZHZ0dRekhJK1ptMWZqQnpaOXByRTdxdkZsMzZGbE4vOXg3SjMxd2tSa25q?=
 =?utf-8?B?dFpKRjQzL0xKaGc4WjJ4a3FUYnJwSFNud1RaV0I5aTlOdG5aYXcrcWtCMnRo?=
 =?utf-8?B?MkpmZWxmcFd1bUZReWo2RzNzQzc2NmRKdzFwN3J4MlpnZXZFTUNvTWxUZHVE?=
 =?utf-8?B?TkJ3Tm5WM1hwU3o3d01PUDJxVENPck8wcGJLa204YjVyc0doazRUQ2k2UWJK?=
 =?utf-8?B?Ni9JSEZLS1J2T3VZcVJTK1JFVjlKa0x6aWxlZ2ZVV2pLTm5jdVpYbVhxSzcr?=
 =?utf-8?Q?evg3JfSdJf1KnNrMsLLzR1A=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea2892a-1512-4ace-2663-08dd027fc0e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 18:36:27.6321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2VnuYMyedK7dGAWzo7R+9ASGA7YHtZpK6OskIEbcH8HcN128rodqba7ys2ra70h8Icuv4G8m51P7U/ht3uS/5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR15MB5522
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <D9EEDDC8B0380C488E1D01E6964969D8@namprd15.prod.outlook.com>
X-Proofpoint-ORIG-GUID: A3v1ZNmCmsIY3iRsEwuZh2bpDaxncJm9
X-Proofpoint-GUID: A3v1ZNmCmsIY3iRsEwuZh2bpDaxncJm9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

On 11/11/24 09:28, Johannes Thumshirn wrote:
> >=20
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>=20
> Simplifiy the I/O completion path for encoded reads by using a
> completion instead of a wait_queue.
>=20
> Furthermore skip taking an extra reference that is instantly
> dropped anyways.
>=20
> Suggested-by: Damien Le Moal <Damien.LeMoal@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/inode.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index cb8b23a3e56b..916c9d7ca112 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9068,7 +9068,7 @@ static ssize_t btrfs_encoded_read_inline(
>   }
>  =20
>   struct btrfs_encoded_read_private {
> -	wait_queue_head_t wait;
> +	struct completion done;
>   	void *uring_ctx;
>   	atomic_t pending;
>   	blk_status_t status;
> @@ -9097,7 +9097,7 @@ static void btrfs_encoded_read_endio(struct btrfs_b=
io *bbio)
>   			btrfs_uring_read_extent_endio(priv->uring_ctx, err);
>   			kfree(priv);
>   		} else {
> -			wake_up(&priv->wait);
> +			complete(&priv->done);
>   		}
>   	}
>   }
> @@ -9116,7 +9116,7 @@ int btrfs_encoded_read_regular_fill_pages(struct bt=
rfs_inode *inode,
>   	if (!priv)
>   		return -ENOMEM;
>  =20
> -	init_waitqueue_head(&priv->wait);
> +	init_completion(&priv->done);
>   	atomic_set(&priv->pending, 1);
>   	priv->status =3D 0;
>   	priv->uring_ctx =3D uring_ctx;
> @@ -9145,11 +9145,10 @@ int btrfs_encoded_read_regular_fill_pages(struct =
btrfs_inode *inode,
>   		disk_io_size -=3D bytes;
>   	} while (disk_io_size);
>  =20
> -	atomic_inc(&priv->pending);
>   	btrfs_submit_bbio(bbio, 0);

Is this safe for the io_uring path? The bio completion calls=20
btrfs_encoded_read_endio, which frees priv if it decreases pending to 0.

>  =20
>   	if (uring_ctx) {
> -		if (atomic_dec_return(&priv->pending) =3D=3D 0) {
> +		if (atomic_read(&priv->pending) =3D=3D 0) {
>   			ret =3D blk_status_to_errno(READ_ONCE(priv->status));
>   			btrfs_uring_read_extent_endio(uring_ctx, ret);
>   			kfree(priv);
> @@ -9158,8 +9157,7 @@ int btrfs_encoded_read_regular_fill_pages(struct bt=
rfs_inode *inode,
>  =20
>   		return -EIOCBQUEUED;
>   	} else {
> -		if (atomic_dec_return(&priv->pending) !=3D 0)
> -			io_wait_event(priv->wait, !atomic_read(&priv->pending));
> +		wait_for_completion(&priv->done);

Probably a nitpick, but completion.txt implies that this ought to be=20
wait_for_completion_io.

>   		/* See btrfs_encoded_read_endio() for ordering. */
>   		ret =3D blk_status_to_errno(READ_ONCE(priv->status));
>   		kfree(priv);

Mark

