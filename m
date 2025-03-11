Return-Path: <linux-btrfs+bounces-12193-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB3EA5C348
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 15:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1FF5188BA42
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 14:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE20925B672;
	Tue, 11 Mar 2025 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="im4kkK6/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABBF6F30C
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702150; cv=fail; b=LQUmlxO/A2QzbBWKKVSlX2+LRs6mv0+uhWqCKPvszXbGFPo3Zo60Kw7/JHpdF/wiZ0+cWYw0tn9Gl4R1C0Z2tmKJHSHutrvuXaDPJ/XECcTbdkQLbfiPeFoQFiaip/tjppXYvwPkAMfW9Uo1AJAIM9UZ/DJyKmEOMLq9crV1WGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702150; c=relaxed/simple;
	bh=0UsIhbB3XACg/VrFREDz3n7Z4g19mawqd/Y+eJ1SEhg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=JqbfDD1lbM2yQddDOgQxar/PxgcF/3npz3UplczLGdKS10nqSc2FG4ZWOfv76yaV0pKkp2te6CAD++EMh/pbYty6K4E9FN1tO5/tW7m4N/s6t2xAZPb89wsi8EgGHwEC+Gc3gfp8mjRy7Z/dUgsQA/zdQNpMDGTV8ECVlm/a+W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=im4kkK6/; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BDKBx3026213
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 07:09:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=0UsIhbB3XACg/VrFREDz3n7Z4g19mawqd/Y+eJ1SEhg=; b=
	im4kkK6/i/jkz3dBzZrBzYqM4F72Uc+uCq+x0IMJd5zP5rCtVon2/3n0mSfLiAfJ
	gtWU5g2hCoz2h4OYNxnko/WGE6MKbt4j0egOy9C/r+LUg3hc36Cmi58OYphsQefe
	LSSBBhivLc0L2BVbnRHXxekp0DCgceGUtLL0ViCjhK1FRD9qrKbfeqbnuj8ngkDA
	eCCtATWL6iFQKoIhSB2rdJzVAkNalvGtDASpAySjS1VNn3XpBnFi4/4N0y3SQyPB
	6L6yDwk2+quLcvUF48wxg9tiEHA5Z9JNuu+Sj0zBEw0rSRL41ebc2w/yOrdke0ba
	S7AhyXjBBw80YguFgCXp8g==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 45any9gabn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 07:09:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7/bpht0pzlYsQ2Ah92BZrbFXVtfmA4j+qoCauCOmGl5tZPyu2RQKMTpHNM96Lt1hhVLq6byaibQ7P3ejbpYG6p4AWYTdqcc8i0UrYprsoFfK7rATQKTnxd8AM2ZKoK9QCVWBJjDIrwh5FsdMwbHTFPB1aOJg2DADYFekjLKngfNjfe7M0HnDInDVtLtFSVsFE15I2dgEewc9D807bMLTiI+JbadFaGsW6LKZhXWwtkO50LwFIPTtyBt5/RBDDFq0pevWbU9Ou9EnMx3zyRueUpapKut9JRYdwT8lpfhm7Pbsl5kUyRVLVLm7zOrCXhbOCOLo1FhLS7vk4qw/KMywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ob9p6kcB9YE/joZ+lNW9IlayXcjp+RcNSieCxjX7CI8=;
 b=xTNddlXwbafMqEq8tDv6ZbwVsktlbzaRdKCCV09VrsBVtfI5+2cz0d+wnU9j+PQ0QKm0W4rQaa5IVw+19hvWcDwgcpkvzgMonZkcR3JUivgrko6q1dsb+hra3m6LoxMqFRvnOr3rGeLBZWEwr9CyC6b1us+k5SWel+uEcqQ7G7hVWt3v2Bai7YttVaB0xUKNfXLGiFQMTbyPwZ7f7z7GPiKgNxz+7OncW/leUmXGSrymP6Al8WcR2WOxJ3stORPPrDL/bOmbp/fuV4VLTvUKvOx3668kGIV5UCkdv208Ieue6BABGcVXRJjNZzf84z0TH1Eas8jB2ZtiSVHPRvl3dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by SJ0PR15MB4677.namprd15.prod.outlook.com (2603:10b6:a03:37a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 14:09:04 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 14:09:04 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: avoid linker error in
 btrfs_find_create_tree_block()
Thread-Topic: [PATCH] btrfs: avoid linker error in
 btrfs_find_create_tree_block()
Thread-Index: AQHbjobNM7sHZpw7+EOO7v0buPx9jLNl8c2AgAbfaACAATAHAA==
Date: Tue, 11 Mar 2025 14:09:04 +0000
Message-ID: <1c1c381c-8911-4da2-8611-02ab35567b1b@meta.com>
References: <20250306105900.1961011-1-maharmstone@fb.com>
 <10586e9f-89d7-4d40-b1a0-027c10b5ce97@meta.com>
 <20250310200054.GE32661@twin.jikos.cz>
In-Reply-To: <20250310200054.GE32661@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|SJ0PR15MB4677:EE_
x-ms-office365-filtering-correlation-id: 9eb6131e-85ae-4ca2-2d05-08dd60a64811
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3VjM3UwSHVYenpDS1ZlRDYzY0JGdTN6andtUXpHamR5NTBOSnNVR0MramRY?=
 =?utf-8?B?dXJsRkl1Z3VDMzJINDVtM1VLRGZmVkhwWHpRWjJSenMzdkw1N3d5R2htdm1Y?=
 =?utf-8?B?ZHZPbElOSjIvMTJMQzZFcEJ3MEFPR3VOYk92bnc3VXppVXlSRmxiZHNpV0g2?=
 =?utf-8?B?ajREb1hXTkg4eVlyZGVCMXdySWthUEMxTTUvZEt0WWl5MXVZZkcwajVCZ2w2?=
 =?utf-8?B?S0k2Y1A5OUlJRExEM2dWcTdEQ1hUSEtGbFdsdDcrNjkrc2ZVc1hGM25WbDg3?=
 =?utf-8?B?UTQ3T1hybjN4bEhmY3BwRkRRYTBOaEphUzh1Y2I2YkU3Q0swNWkzM2g5N3VG?=
 =?utf-8?B?dXAzUzVWc01wcGVRaHArOVVLb0hSMllFZFpUNWxleTRLM05mUVg0Nzh5Sm5F?=
 =?utf-8?B?dXVKRTdFamltbWhWRkYraUdMVncxMDFqay9OUVVxemZPbVlWZ3JQWWRpZzIr?=
 =?utf-8?B?RUFTQWNTYm8vdTFkT1JwWTZjU3VhRzRxdFVxNjlwUEpoL3VaVVFEYlZMWEt2?=
 =?utf-8?B?azl2b2ZQWFRwUzIyYTUzczZlY2V3S3VDbHB2eThNMnZmQlBvVmY3SWcxK3Rr?=
 =?utf-8?B?cG5jRWtraUZxVzhyUVh3c09VYkltVnhDYlhHVklFS3NEWk9KQXJwR0g1czRP?=
 =?utf-8?B?QU91KzlFZTFkcmNEVGdGOVJqSVJMMTlaY1BqRUpZRlV1QldVcHl5WTEwM2hV?=
 =?utf-8?B?TitXWmppa1JlRTVjc3ZjYmZQYWEzcWRzRHdIQkFNbTRyVjk5Ti9xRUlPTUF6?=
 =?utf-8?B?M2RSc1JMMHZjbFVhQjRCMS9XRUYwRUVySFkwUENrYmR0SG9aWk1DeDN6end6?=
 =?utf-8?B?bVc4REtTV3Y3Vnlxa0srMjJaWDlOK0EvckVPVDVac3p3cTN4aTNTMHdGY0Nh?=
 =?utf-8?B?ZWxQMmp2aVdnYkpmK0RUNWwrRWpCdTZXV3dkUjdLalo4YmVmRkQ1d2pGY0xt?=
 =?utf-8?B?Wjg1RWd0VDNYWDVRazI0aG92eXZIS2RWM05LT1Y0OEVKU283angvSlJibXVl?=
 =?utf-8?B?M1YrclhYb1BFSmlHdzYwV1h5VEp1RjFiWmtQTFp6S2JPZHNmVFBKc0dGTXJE?=
 =?utf-8?B?d0JOR0ZmZ1BLaGNSUGVRc1laR3dGM29iNlg4dkk3Q1FsNGU4eXMwVm4rc1l4?=
 =?utf-8?B?LzU3NklvcVRzM25jL0NJTnE4TzVXWS9jOXQzQnRGZGYwS0JSaUQwd3RvWmNk?=
 =?utf-8?B?Y29rMmRYZjgyOStLNGh3ZGFWd0FLNVRVcHFRTTl2Z1JTR1lRLzd4NlduZzNw?=
 =?utf-8?B?M1ZhY1Z4MUdpbkFuTzllYVg4L2tOK3NQbzF4ZTloSVVFUGpRU05SVTk0THhS?=
 =?utf-8?B?dDBQQktabVQ1MHpGN1BBZGtqdFlNR1hDZThRNC9wRVNJZTN2L2FlM29Ubldk?=
 =?utf-8?B?cVhFOXhzeDRvN1NpUENCL2JsN3JXcmM2TTUxUStjZ3IyVnBhS0ZEOHpDQWVy?=
 =?utf-8?B?Mi96OW56Qkp4Q2FuVXhheVFsRlVGdnhoRGFMd3QxUFVRMWd1ZmlZcjM0OEtv?=
 =?utf-8?B?VmRLSnVRajkzbi9heFI0ZWVMeUlEOHpDK2pFVitpTEpUaEEybVRwQ3EvSi9m?=
 =?utf-8?B?TWxySm91NFhsbEpjYXlmbnpxZ0tzU3cxVE1JSld0aVd0VlFwdTVlSFF0TmVs?=
 =?utf-8?B?K0k5V2lCSUpQVDVRQnl6SlFxcTYyV1FEQ0drVFhVcHN1RW5UeTU2RWN6VkFq?=
 =?utf-8?B?NE84WVh6dG5DYmVBTlNtMmtmY2tKTmRqQ09nWVlXaWdNemtwTWNSaVhGYk9x?=
 =?utf-8?B?R09RZEg5K0lDYUZPUVhiWEUrems0eXh3Q3VJRnhTZ20zdVVtZTVsTGRlc08z?=
 =?utf-8?B?bDd4M2lXWms3OGk1eUlhMXArem42ZXI2RXM2Q29Rc2pJUnNGQ1FwUGt5NVN6?=
 =?utf-8?B?Y0QvL045d0N3bUtoR2N0R2tQcDgzYXg1M00ycjNUY0R3cEN1c1BOSTZTRlF2?=
 =?utf-8?Q?vQ+hDPQtlkScKdXakkEWHWjVBEy/aX98?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eVBuSUErWVhHMzhPOURsUDJzeFlFbHZXWmZWd0R4alFweUNHT2U0RHNkd2Jz?=
 =?utf-8?B?ajd2QXlIY0xoQ3Y4QVZrZmRZVk9EL2NjZGtvdmx1dEQ4aFRrS25Ib0N0cmR2?=
 =?utf-8?B?SGx4S0R6UVpnR0lxd2ZXUTRIaTYyNzN5Y2JTTHRqQ3ZDZjd5MCtxUkhBRTdF?=
 =?utf-8?B?Zzg0K3dadkp3elE2MSsxc0lKSllvZmxmM1hxdGFqVUdaY3Z1VUhhZlVCOGww?=
 =?utf-8?B?aWh4UTJtVWl5V3VNNUNab0xLdjFtaVJ6dVBFMnBuN1JLbXc3K3YvbzAxem11?=
 =?utf-8?B?eGZNMFlGb1NXZXZ1L3hjWnVKZWxVZFpFYW12cWRjMEsxV21ob1dVcjQrbmJ4?=
 =?utf-8?B?cVVlbnBoTSt5UUZKYUh0NVBvRmx5VWlKVkI5a2MyMno4THk2SzN0cE1TdnNE?=
 =?utf-8?B?cVNNVEdNaUIrbmQyN3VEMFdIN21sMTJNZm94eDhVb1h1dGZPSmpEbHhuUjFa?=
 =?utf-8?B?d2wrUnVZdEhhZEMyNnpMOWNUQWpmNTNaQ3lWL3drdWJOVVBuZjRkaTA5ZEJt?=
 =?utf-8?B?eFAxRkpCWnluNDVXZjcwM2lMdjJnZnNEWHdzQlJYZzRKVThWbUJETFF2Zlk4?=
 =?utf-8?B?ZnFsM0hiaFRyTVZtd0h6d2JkQ2dyWm96bklzUGpWdDNIUzRHaGM3U2RwZFBG?=
 =?utf-8?B?NTJJbXJsM1hnSUI4T1NIZzVZMXFZOG05NzcvVEg2ZFR2T0xBeTJHOGV5ZFJE?=
 =?utf-8?B?dWpDNG9la0pDWVFHUDVmclhDUkZ4b1hSSU9ONUlBZVM1Vmpxbi9qa3REWHcr?=
 =?utf-8?B?eW5YYjZ0TjNTdW5CS2Vtcm1NeXBGU0M5VGJKUlpISG56TnJhdTByK2RHdWFm?=
 =?utf-8?B?bHhSRlFBUGp4c1gzdmdzL0lBaDRTSFAyRVVMUTNreDhiUW1ZelpEcmhkV1Vl?=
 =?utf-8?B?SSs3a3RjaE5zRnpIcmIvcEhjOUtDS0RWVXRBSGl0alVIRDMwZDUrOHZwZFk2?=
 =?utf-8?B?aTVnd1lQR1AyYWdpS3FCMlB4a2QzdWNWa016SmMwQVlUajMwdG5IQ1R2Tmxm?=
 =?utf-8?B?MmZSMDd1Y3I5NmtCc2ZIRFlnMnI5NVBqWlEvOWdmNjlrT3hlbUNWdTEvSFY5?=
 =?utf-8?B?RWVzSHd3Z2swT2FWNTN6Tlp1YVRodFphalQ0bWtvcElLNTZ1Q0pLRVdENjZD?=
 =?utf-8?B?cmxLWkVIYzFtMHRWRW4valU3ZVZSNDluWGl0R2UwL0N5MjB6MzZMaHJVem12?=
 =?utf-8?B?WEpJbVIrR0MxVFB2dGtJV3NzNHdoTFUzM3dxdE5lV2xRZlFFMWd3eEV1M2JI?=
 =?utf-8?B?Q3BLTURjZVJqVURQZGcvYWpPbTBVWVVTWUVLYmxxV0dDYnhyMzZickx3NGtz?=
 =?utf-8?B?UWk1enVCeUQ4ajZJMlM2bkZDRkozbWxsMCtXcmExZVgyZXZVSDhHS3pxMWox?=
 =?utf-8?B?RXpwQXdiZ2crUy9MMjU4YjUzaEc2VEJrYkk2M2VpdG93a1NUZHgya3FiUVJH?=
 =?utf-8?B?N0RTZk0wWlg2Smk0TXR0NDJBVkMvZWNPK3BGblkrU2x2bDNyTXBqb2VldWMr?=
 =?utf-8?B?bnJxN3dmQk5QeEhicjdUTEdRNkk4N2hOeUV4OHUyU25sbkU2ZzIvU3ZwanNE?=
 =?utf-8?B?YW14UFlHM2VnTmFCY2NHbG5UL3ZHZ3ArZ2ZJdUtTQkxSdk1qKzIyYWxXemIy?=
 =?utf-8?B?YXplZXUzNTE2WDVtRVVsSDVzczY4enI5Q1M2NElDNkhFSkdTTzVBaW9tMHF4?=
 =?utf-8?B?amkwNVNHT2t6MWI5ZHUrNkt3KzRIZTRJWFN2OVhQc0kya01PVUdjVW5sMmtR?=
 =?utf-8?B?KzhxRjdxZWZTWDRZNkdFUnhRS01ySWhUYWRuNHBOTU5jUUdWbmJ0RitHT0hw?=
 =?utf-8?B?UjdSTzkvbGs3T1B4dDdreTlUMGl4VDM3ODB2Q1NkYThGNEw2Qmt2UnRodDZy?=
 =?utf-8?B?YjdObTgycjR6a0Y3RUprbzE2T3dJL3RnRU5OcWhjWFFqTUJNLzlLTkNycG9v?=
 =?utf-8?B?MFpJR042WVp5WXpyQVk0Mnl5VkxBVXBSN1Q2eFFmVDQvdU01OG4xd0hLTHJ2?=
 =?utf-8?B?SDhiQXZPZUFkVnJtWFlXNE52dS83SEZQRCsyT0d0SHFiS202ZXA0cHhMUmlP?=
 =?utf-8?B?aFA2WTR5WmFPYUNPMGJPb01ldFRLQ3Z5eGtWVmU0UTdreDNOTzFCaWE0WFVz?=
 =?utf-8?B?VW5VSHVNWWhCRjBhNUdvcEJid0tHcStSeXdoUkIvNE9NVkh0NndTK1BMcGlx?=
 =?utf-8?Q?Wo5LjkdyNIPMJqL3r5fcisE=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb6131e-85ae-4ca2-2d05-08dd60a64811
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 14:09:04.6040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qM8GDTjXW7FJjvh5EP2sgMn2SmcpFmeOwslSWVXSA78TojQ0yLqYHMAXy9ZKLD7XoIMxNmStA1s2ZqYkV4hykA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4677
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <7B49B04EAF468F4BA3E2607982A11927@namprd15.prod.outlook.com>
X-Proofpoint-ORIG-GUID: ps6wfDr6pfyqGzSchrzPE7mGFKDZFLyN
X-Proofpoint-GUID: ps6wfDr6pfyqGzSchrzPE7mGFKDZFLyN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01

On 10/3/25 20:00, David Sterba wrote:
> >=20
> On Thu, Mar 06, 2025 at 11:03:46AM +0000, Mark Harmstone wrote:
>> The context to this is that I'm fed up of seeing "<optimized out>" in
>> GDB, and am trying to get the kernel to compile with -O0 for development
>> purposes.
>=20
> You can mention that in the changelog as the reason why to do the
> change, making debugging easier namely if it's just a simple change like
> that.

Thanks. Okay, I'll push it with a sentence explaining this.

> In other parts of kernel the -O2 may be necessary to utilize the dead
> code elimination enabled at this level, like the if (0) { code... }
> where the 0 is result of IS_ENABLED macro magic and "code..." needs to
> resolve some symbols. Compiler flags can be set per directory so one can
> mix -O2 globally and -O0 e.g. for fs/btrfs/ .

Yes, I've got -O0 on fs/btrfs in my development branch now. The main=20
problem elsewhere is actually non-constants being passed to "i"=20
immediates in inline assembly, such as in WARN_ON.

>=20
>> There's still a couple of issues elsewhere for this to be possible, but
>> this was one of the problems I ran into.
>=20
> Feel free to send them.

This should be it for btrfs, I think.

