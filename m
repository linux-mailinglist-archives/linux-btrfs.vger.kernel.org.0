Return-Path: <linux-btrfs+bounces-14190-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99ACAC25B2
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 May 2025 16:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651F0172F2B
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 May 2025 14:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49009297131;
	Fri, 23 May 2025 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="JT2948Zs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A93E297129
	for <linux-btrfs@vger.kernel.org>; Fri, 23 May 2025 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748012053; cv=fail; b=KZuQwhRHyS2DIj45f1hd/0AFFJ1SkX9NRtnpMQVaX/PbIoWkZzS6hmz32NZzW9IzspGIcPb2vJCd/IWZDeHl7naq7iFiFy5W2/sYLUoPp/Ehvqu5v6pp45o22rQzCoEFkXH40XwI0HpVhEzc3eBV1z8rgCm0Aqmhbp/z7sNGL0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748012053; c=relaxed/simple;
	bh=AdxDayLLVnY83eqOZZCUWsSl8fYeAedIGX/iPTQUYCo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=i4JEjnaJYaCEndh+RiHwZAOY86wTONdSMgkzU8Lb2AGrnE2GQJgmTexNDzbmXyyEKclz9WGwuwXy8lttDKhFSX8mK0trBNc+0ndMxmMS7TMaRcDwot28YR3P+iu7eA5c36l6sVLkZQwDzhKoS+cFC91K5N5I60ejldJWfwYcBfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=JT2948Zs; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NEQB04007395
	for <linux-btrfs@vger.kernel.org>; Fri, 23 May 2025 07:54:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=/oHCqNT1mFdDCn05ubpwtyX1kfy5m3KxFnbyFucSoyQ=; b=
	JT2948ZsHF6Eo42SE6Ans1d27hAQgidpVHEUIcdalOwebPl6+HHZOzVzs1DKbNRO
	uvfDvJeljoV0NJjVk3Q+YzvPqtMpsw4SipdJZ5/5jeIbugM1+u6/vCHKK7BDLfhd
	KhI1DgPD0bpXGmEp0IVoSnPcP4Q3vH+35rA2fAnveUI5sqWy8xbhXcNa5v5RS/Hn
	dnapXFHWMA6cGJKc7GRyhmWlLuAfbd4IZk8QMiqtwhfpOMFgsTZOC7V/1Rz0h8lL
	uTI8beWSMqzTtLHYS/t379ilA+1cO3+QfHND8YdRbrflzlFMOPuD5Dz3iPX9P++f
	+qPhtdy6vJASWPQ71QQBOQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46sxy1bkt1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Fri, 23 May 2025 07:54:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ia3Ve/PD6wDloaI/N9Vc0OZOAMPv4G0iA34QGLiNcOqrZwg3MyQVtN9i8RrL1wxJzjES9TUtI1aF0ZsOi7yeGnKL7cdjR1aHRXuitlpFsCN9WbzIGs+xot0nGFfzCSe1L+L1tO8n4FOKq3MLqqSruqU6lbxl7uCGvTMRMQWLIPSsxXP0kCg3/W/Rj8kKzN+ez3Cnonz83vawgj76u8DHIrogBsOWQIDE0K5WN6L/RkufeMPjlKwTxt5riBYOz8kHo3Hn7IACoi3QvDbIw5/rMXc/NAsRiXf8OIwgYVqTpIx1EVm+10s0iQUvLblHA3cPvQXuaWUdLI/4bZW+YBoFHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9+rqWsj5suObJsGi0QfE94uknmCVSbihoAU0PBOAqM=;
 b=SYqH3SHXcFbV6eMvkvKp2+YdBewaecq7CJtkBP9c4sAlfxJ+TKueqV3btToJuQir6Zsd6hd7iFhn03iEX5L1cLEy62qVC9XI7X1XZtJi0RwpzKEpYW/l9/9Hr86iWuzLnvF74dxYERd0j9j+q6FNRN/VUnM8ZwBjq5DBIkWsoMprfVhpZSzDZc513vDDPSs++8t81NCQdh2ANzH0mkzR4Yx0GxXYiVR+++jad8L7TY9/wxMA/n3LluHYT0fYH4mNDF3wfWRNt4o++ICMEgrsigJMXX255zYBpMBewvjJbZfoe2nPzsRHq8lN2z76gjEwbMg+35qs7b7vUJDpN7J0EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by IA1PR15MB5418.namprd15.prod.outlook.com (2603:10b6:208:3a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 23 May
 2025 14:54:06 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%5]) with mapi id 15.20.8769.022; Fri, 23 May 2025
 14:54:06 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Boris Burkov <boris@bur.io>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC PATCH 10/10] btrfs: replace identity maps with actual remaps
 when doing relocations
Thread-Topic: [RFC PATCH 10/10] btrfs: replace identity maps with actual
 remaps when doing relocations
Thread-Index: AQHbxbeTL3YiuKrhNEeW5bMJ74N54LPcPGGAgAQdPoA=
Date: Fri, 23 May 2025 14:54:06 +0000
Message-ID: <023b1da2-9bba-40e3-9aca-d1b8ecffb568@meta.com>
References: <20250515163641.3449017-1-maharmstone@fb.com>
 <20250515163641.3449017-11-maharmstone@fb.com>
 <20250521000423.GA204755@zen.localdomain>
In-Reply-To: <20250521000423.GA204755@zen.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|IA1PR15MB5418:EE_
x-ms-office365-filtering-correlation-id: 3f04dbb5-08f7-4049-8d6b-08dd9a09aa93
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T1pkeFZZV0pEajRNTlBCb1hGaENZZDhHdjNxd0VaZTFGMmV2TmhpUStUV1pM?=
 =?utf-8?B?RExwU1NKZzZ2SGYwS0x3ZVZpWmUvTXIyUjV0d2kvMFVXOHppejJsc1J6YnZr?=
 =?utf-8?B?NlZIZlljRFE0RFdPdUdFYXBuQWFFbmcxcjF6RnBxRTFQa1BGT1NmZGpHaGlt?=
 =?utf-8?B?NE80NTY3cHhZekpseVd1eCtNYjZVWmdTbktVa1hxemlzUTVHd0k0czd1eHMy?=
 =?utf-8?B?VXJ0NElROWE5ZFBXbDJTbmFRdlF2WGhDVHc0WlFJWk9JekxDSW9YaC9valEw?=
 =?utf-8?B?ejIxVzdBL0ZpcjdDUlA5UHN4ZTlIRTJSYVNUQUk3TSsrUGpvYVdlTjd6am5i?=
 =?utf-8?B?aHc0aEdqK1NONXI0Q0FYQk91R3BQbjVjMndYWjJFaVpIU05OLytDQzJ1VUNY?=
 =?utf-8?B?RkZlWUI2ZGRWam9UVnpIaG9HL1dMMW4vajgxMHJyZjVtamF0dTdGUWdrdkV2?=
 =?utf-8?B?Vmp5eHJ3L2NKOElwR1pWVFAvLzluK3NaaFhHZzdESFhNME9tc2pwODBkaHcz?=
 =?utf-8?B?NTdTR2ZtcExEUVNPWUtuMjg4THQ3YnJxMFlMdE9ob2FqZ0MwZ3ArQW5na0pH?=
 =?utf-8?B?VFVwWUZqOVRpalF6SjdqMDJtNXlEbTgrV2orWW1QY2R1bGxMQTN0Q3l0clBH?=
 =?utf-8?B?eHhGNlpWQW1JWmlTWHduODRQWFhOdTczTmY1cmJ5N2lpREE0Q1dldmk4c1RL?=
 =?utf-8?B?Rzl4U0tESkg3L1k0Tjh1T2Vwdk5mUHRUbXlOTi9vMkl0UlptazFqTExMbWVJ?=
 =?utf-8?B?RGJXc01DOVRkalc4ZHZ0M2dQTFpIWDFGUisrb0NRUGZ6TVNGejladjNRMk5I?=
 =?utf-8?B?UDBNSWdiVk4rb2JGckJ6WHdsNFUyT2NwNnBJK0R4SzZyVys3QnBCSkU0c0Nw?=
 =?utf-8?B?Z2p1SXBKbUgrTWN3RHBVY1ZQcUVCNnZHTU5qV1A4T3NpOFFDWXFCZHA4Y2Jq?=
 =?utf-8?B?Um4vWHNjQ2tpTnFVNnNaVE82YlJRS3VCV08xbTlHaDY2eHdqWmtpTWRLTHMw?=
 =?utf-8?B?SWNxdFpZOEhOYXBVb01jM00rVnRSV2dSTzBqZnh3allibUtjN1dRdjBOU01h?=
 =?utf-8?B?blZDcEk5WFZEWGYzdlVyUHN3a3VoeXFWMi8yalBrMEorN2h3dXkxZDYxMEw4?=
 =?utf-8?B?Q2RzYjRMVStnY084V0VLWE5CdmdTY3lQVkF3SEcrUjF4ZkRuRVFJZm1uOVMv?=
 =?utf-8?B?TzNKbHBlcDkwalk5bnRnUUFDdzRVR256Y05KZHBxWVNVVGJpQ0Q1RXlaRkRC?=
 =?utf-8?B?VTA3eGNIUXQ5V0RDQ2k1Wkw5a2lQRlZaRHY5aG9lTERzZmV6UmN6a1NIaGZJ?=
 =?utf-8?B?MWhQNWNpV3ExN2U3T0REYXlKa3I4eVNNZTRqdXhmZFNlK3d2YmtaR3N3Tmox?=
 =?utf-8?B?czNSNkg5NzNmWnY0MXUxa1d1Mm15Z2VNajFYSXdlTVE4dkxxSjVzYW93ZWVk?=
 =?utf-8?B?aTJzTjdGNk85c0tCTGpFUEpHRU9TZTUxajk3WG85QmpWNzhkVlVJdm1sREtn?=
 =?utf-8?B?OE1JNUMwV3JpeHNrUTFTRkFiV095dThNMWNvMGdmdTJzTXZHODZOQWF3V3hr?=
 =?utf-8?B?d0RXUGhhU1FqOE53SFcxZy9IZkhHSG5TMGJnSHdlM24yOW9aT0I5RWZtcldt?=
 =?utf-8?B?bHZqQTNIVURqREUwQTJQQ3ZZbjQrZFBMa1NjRS8vSjBvbjB1cFBYcXBxWDYv?=
 =?utf-8?B?WU9vd2N2clh1TnhOTzBwa0xKeWFITjJZbzJmZUJuQmVnRkExOE9mcHNvSmJG?=
 =?utf-8?B?NEtVWDh3Y05Qay96SHk5eVo1Wjl5bkkrMW9uK1crTjFJMnYyRHBLRmZtUmN1?=
 =?utf-8?B?dkw4YW9GSUU2blhrUjJ1aHB1UzdxaWExdTFPVU1PcUY5bWtRa3dsZEJadEor?=
 =?utf-8?B?amJEWW1aOFQycUVYWnBTSElkTVZ2blAveXl4c3ZQRFZzQTIwZXhhQkhXNlpE?=
 =?utf-8?B?b0o2OXVsRnROMlVPakxNeGIzcHE3ci9QcXBWYmVNYUhjbmpBRFByRXFaK05N?=
 =?utf-8?B?M2ZGU3UwTTRnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RDVqV1IzR0FWcC9ocXk1NXVLT2hrQnlQQ0Z1VXEva28yanRGaHFLU3U4WldI?=
 =?utf-8?B?UzYzUzJHVnNnbFV2bnlpYzBabWU2c2xQcUZhdU9IODJMTjhaaHlJM2NlTERW?=
 =?utf-8?B?cTJjWlN6Z0RjWkZXaU42TkhRcTZucGIzQVI5QzI2aW8wd3dvV0FYTFR2RFU1?=
 =?utf-8?B?VHg4aHozdGtCc0tEWVkyN1JEVWJYQnF5N0JYQXNibTcwZzRuTXZtajdKMTh5?=
 =?utf-8?B?QVVndXpWb2FnQXhkS21WdnRDVGxMQmpMSndrTGNxL2xUbDZ3dFhjSjVOT2pz?=
 =?utf-8?B?YytsWXR4Njc4WHZyM2QvVXhHd2hxbW9WNjkzNWlUM1J4QklBM24zWEJ2QThH?=
 =?utf-8?B?ZVRYR0RHV0hwZk1PRmh5bUhxNWFBWEtxZHJoZ1VKL3pRZEEzaGRqdXN6YU80?=
 =?utf-8?B?M2lTV0tkM0hFTFk5OXdqOEl3aGhzLzhMS1FZVWYwSk9pTTgvRmpxZlJ2Z3dk?=
 =?utf-8?B?RTJFTSttdHFmbzc0NnFyd2wvb0R5L2RYeTJhdFBTbzlwb1RiRXNHOVBLMzhu?=
 =?utf-8?B?QzkrSWlDR3FiTlRjOXptV1MyRUJBWkpKUnNmNjNReUhpam1FUGx3MytUYTBB?=
 =?utf-8?B?VU1ydVJlTnlkY2ZNUG93Yk8xUXUrY1hXYTlzZjRZVjcydno4YWVQNUFucVV4?=
 =?utf-8?B?dmljNHZPL0xnbFNOU3d3RWsyb3RnSXFjU3AycFVxRnZzL3JPdU9mRm5hTUlV?=
 =?utf-8?B?R1JqN0g1VWtHWmlKUm1PSXlJcWFmbmhPbTlBRnRMekt5M2dSbEVTMzRCN0Z6?=
 =?utf-8?B?N3dvZ2VuaWcwWHhjS0dtM2xqTVpiK1ZodlRZZmhXRG9kSkhvZFRBTVhqNzdL?=
 =?utf-8?B?alVoWUltZDVidklPMndxb2dvR20wUWFOVCs4aTd0cUhlNmxXYk56dzRSVlQw?=
 =?utf-8?B?SC9zamZvajA3ZUVyaTBPWkhvTjZPeGswK09hWjFyeUt2NnVYcTN6YXliYXk0?=
 =?utf-8?B?emN4LzRNc2g1THhhc1ZxSkMxZ0hiVjR1VnpCR1FuY3R0YnJHYmxDZkZvVlBW?=
 =?utf-8?B?dVdTMGxibGQyWERINFBqUUQ4VzQ3MksrV1pCSW4rMDRQa2RMUndmeXZnc1I3?=
 =?utf-8?B?TFltQzI0YkpSUUwyTVcvWjJBdkNoYlB3QzBqcUpnNUw3bEtBalBMU0p3YXNN?=
 =?utf-8?B?OTBxT2lrMC9ubGJjNHlha2lSbFFmTzF5YmlMdWRiOFFoZFljWGZUUTExMDFN?=
 =?utf-8?B?V01UTy9nQVl3d0hXM3hvRFBNajlOTzhkT0FiQkt4RHAySlo5N2VpNXlubENw?=
 =?utf-8?B?LysvOWxzN0h4UFZ1L3UrdWVoaFVEaWY5cEZ6a1ZTYkhod29jN1BYRmErNHZV?=
 =?utf-8?B?TEZweXczMGdoT1MzaytOUjc2dm50Z1BYOCtjM3RzSDJ6SEt5UmlsMXV4b2hN?=
 =?utf-8?B?UG80c3ROdmN4c3ovZWlUaUQ4T1p1eG8wV3RpakNJaDEyWXhOdnF3djYvKzQ0?=
 =?utf-8?B?SWcyeGMyU2NieEU0QjNOYjI4WW5KdXpxVThSL0JlTVFGUFBSS001U0U4TDly?=
 =?utf-8?B?ZE1zNW82SGJnemd0ZDE5TWEvenZBVFpqZGtqZW43TEJQSUVQR2dpbXNDekh2?=
 =?utf-8?B?VEZUc2hhQjE1dmpnRThzK2picW5md2NYOEUyRkZKK3JaZFl1a2FCeUhjVDZ5?=
 =?utf-8?B?Y3dsOEt1bkV0cXZlaGZ0NFhuVUxoSEZHMFNyY3VINnhTUllua2oxZmxBRnl0?=
 =?utf-8?B?VEduNXRIU3NqWkNLNzdHMlFLcXZaeENPMUNxNDAvSGY4TDRmaEEyd3lEY3hk?=
 =?utf-8?B?ME9adVRZeXhjbzBSY2NaWHAzUHlYV0hKM0RXYnYxQ3hRUGVXYTgrajI4eE12?=
 =?utf-8?B?L1dwYlloYzR0QWw4czJXR2p6dVNBZWFjRWJqMXdPa01IUHNaaVEwVVI0TDdm?=
 =?utf-8?B?OGVyRUJJQmVxVG4waE82WUNlc0tNK09XV3BSUDNHRGt4eVRhMWM5ZzFwdnk3?=
 =?utf-8?B?dE9ic3ZhbmNoOWdlUzA5VmNrZ0luVTVrNVRsOXd5a1o1M1o5TDVYSjlzYUs4?=
 =?utf-8?B?M3dmVG9sTWxaaEdCelM4ZE9iZ01ZbVVReG9UT3lBUEFTM2xNRExWSDAycFNy?=
 =?utf-8?B?MWZQcHhXd3VQaytlUmlJV1hCWjVTcVlVVEtRU3krWkJHWVdhMjQ1d2tFaXps?=
 =?utf-8?Q?mV8w=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f04dbb5-08f7-4049-8d6b-08dd9a09aa93
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 14:54:06.3155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: axgOffNnCxMyLJ6urzmKsrPLPfiYosl1tAZCn54OO9zzeHH0c/QuYMr1j6h++1Esg92Pnd2qNXe8qGaYACnV/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5418
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <0A3F5F1E78AAF045844B9A72E43018CA@namprd15.prod.outlook.com>
X-Authority-Analysis: v=2.4 cv=dtzbC0g4 c=1 sm=1 tr=0 ts=68308c11 cx=c_pps a=kGn1I/FbrZpDzHfxqj10lA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=FOH2dFAWAAAA:8 a=FeBFE4159DkHrnYcbGUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: tqdq1MJJHvPEkE3ypRdb0rg_byJ6m9h8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEzNCBTYWx0ZWRfX8VlslLme76VN dLieNf/p91NI0JHrhuIuuebPBmoOo9rALnh/U5K2myvT1E8Awi9qtGlimOvPrPfQIJP5LI5bNX9 SHTb08CzVp6wRCLNrFehKNZleII2X3EmLmAd18ndxa9UrWD8/qgPW3OHNnlkINhI2FUZhsi+8Tj
 wYeMW79UAgwZlR0rpYmunlr+7TlrxA9Ul6/FqdLWjfmT4dgmpnNGF5j7Mg5jODqAWVke5Cp+4CA oMnU/rj+W/t7zhERwx951tUsotGerlkvM9pzr5//BTexE/7KYNCWHJKmn1oXMK7FUoruInHVHT7 aCn3Ww5n1cijC9Nlwt3IAlvmB3j7CWFkJiTv1O/SyExQBX8GGckdBSq/UQPphhEjyfKpyb2Ibd2
 THQdTVHs+GplYNQ0lw6+XUVDrC/W7+KHZI2tTV5ANmgKfvipOTdQctLsgh2ufYNdZqbm3Z1d
X-Proofpoint-ORIG-GUID: tqdq1MJJHvPEkE3ypRdb0rg_byJ6m9h8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_04,2025-05-22_01,2025-03-28_01

Thanks Boris.

On 21/5/25 01:04, Boris Burkov wrote:
> >=20
> On Thu, May 15, 2025 at 05:36:38PM +0100, Mark Harmstone wrote:
>> Add a function do_remap_tree_reloc(), which does the actual work of
>> doing a relocation using the remap tree.
>>
>> In a loop we call do_remap_tree_reloc_trans(), which searches for the
>> first identity remap for the block group. We call btrfs_reserve_extent()
>> to find space elsewhere for it, and read the data into memory and write
>> it to the new location. We then carve out the identity remap and replace
>> it with an actual remap, which points to the new location in which to
>> look.
>>
>> Once the last identity remap has been removed we call
>> last_identity_remap_gone(), which, as with deletions, removes the
>> chunk's stripes and device extents.
>=20
> I think this is a good candidate for unit testing. Just hammer a bunch
> of cases adding/removing/merging remaps.

Yes, makes sense

>>
>> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
>> ---
>>   fs/btrfs/relocation.c | 522 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 522 insertions(+)
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 7da95b82c798..bcf04d4c5af1 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -4660,6 +4660,60 @@ static int mark_bg_remapped(struct btrfs_trans_ha=
ndle *trans,
>>   	return ret;
>>   }
>>  =20
>=20
> Thinking out loud: I wonder if you do end up re-modeling the
> transactions s.t. we do one transaction per loop or something, then
> maybe you can use btrfs_for_each_slot.

That is what we're doing in do_remap_tree_reloc(). I think the downside=20
of btrfs_for_each_slot is that we're not necessarily removing the whole=20
identity remap every time, as btrfs_reserve_extent() might give us less=20
than we asked for.

>> +static int find_next_identity_remap(struct btrfs_trans_handle *trans,
>> +				    struct btrfs_path *path, u64 bg_end,
>> +				    u64 last_start, u64 *start,
>> +				    u64 *length)
>> +{
>> +	int ret;
>> +	struct btrfs_key key, found_key;
>> +	struct btrfs_root *remap_root =3D trans->fs_info->remap_root;
>> +	struct extent_buffer *leaf;
>> +
>> +	key.objectid =3D last_start;
>> +	key.type =3D BTRFS_IDENTITY_REMAP_KEY;
>> +	key.offset =3D 0;
>> +
>> +	ret =3D btrfs_search_slot(trans, remap_root, &key, path, 0, 0);
>> +	if (ret < 0)
>> +		goto out;
>> +
>> +	leaf =3D path->nodes[0];
>> +	while (true) {
>> +		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
>> +
>> +		if (found_key.objectid >=3D bg_end) {
>> +			ret =3D -ENOENT;
>> +			goto out;
>> +		}
>> +
>> +		if (found_key.type =3D=3D BTRFS_IDENTITY_REMAP_KEY) {
>> +			*start =3D found_key.objectid;
>> +			*length =3D found_key.offset;
>> +			ret =3D 0;
>> +			goto out;
>> +		}
>> +
>> +		path->slots[0]++;
>> +		if (path->slots[0] >=3D btrfs_header_nritems(leaf)) {
>> +			ret =3D btrfs_next_leaf(remap_root, path);
>> +
>> +			if (ret !=3D 0) {
>> +				if (ret =3D=3D 1)
>> +					ret =3D -ENOENT;
>> +				goto out;
>> +			}
>> +
>> +			leaf =3D path->nodes[0];
>> +		}
>> +	}
>> +
>> +out:
>> +	btrfs_release_path(path);
>> +
>> +	return ret;
>> +}
>> +
>>   static int remove_chunk_stripes(struct btrfs_trans_handle *trans,
>>   				struct btrfs_chunk_map *chunk,
>>   				struct btrfs_path *path)
>> @@ -4779,6 +4833,288 @@ static int adjust_identity_remap_count(struct bt=
rfs_trans_handle *trans,
>>   	return ret;
>>   }
>>  =20
>> +static int merge_remap_entries(struct btrfs_trans_handle *trans,
>> +			       struct btrfs_path *path,
>> +			       struct btrfs_block_group *src_bg, u64 old_addr,
>> +			       u64 new_addr, u64 length)
>> +{
>> +	struct btrfs_fs_info *fs_info =3D trans->fs_info;
>> +	struct btrfs_remap *remap_ptr;
>> +	struct extent_buffer *leaf;
>> +	struct btrfs_key key, new_key;
>> +	u64 last_addr, old_length;
>> +	int ret;
>> +
>> +	leaf =3D path->nodes[0];
>> +	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
>> +
>> +	remap_ptr =3D btrfs_item_ptr(leaf, path->slots[0],
>> +				   struct btrfs_remap);
>> +
>> +	last_addr =3D btrfs_remap_address(leaf, remap_ptr);
>> +	old_length =3D key.offset;
>> +
>> +	if (last_addr + old_length !=3D new_addr)
>> +		return 0;
>> +
>> +	/* Merge entries. */
>> +
>> +	new_key.objectid =3D key.objectid;
>> +	new_key.type =3D BTRFS_REMAP_KEY;
>> +	new_key.offset =3D old_length + length;
>> +
>> +	btrfs_set_item_key_safe(trans, path, &new_key);
>> +
>> +	btrfs_release_path(path);
>> +
>> +	/* Merge backref too. */
>> +
>> +	key.objectid =3D new_addr - old_length;
>> +	key.type =3D BTRFS_REMAP_BACKREF_KEY;
>> +	key.offset =3D old_length;
>> +
>> +	ret =3D btrfs_search_slot(trans, fs_info->remap_root, &key, path, 0, 1=
);
>> +	if (ret < 0) {
>> +		return ret;
>> +	} else if (ret =3D=3D 1) {
>> +		btrfs_release_path(path);
>> +		return -ENOENT;
>> +	}
>> +
>> +	new_key.objectid =3D new_addr - old_length;
>> +	new_key.type =3D BTRFS_REMAP_BACKREF_KEY;
>> +	new_key.offset =3D old_length + length;
>> +
>> +	btrfs_set_item_key_safe(trans, path, &new_key);
>> +
>> +	btrfs_release_path(path);
>> +
>> +	/* Fix the following identity map. */
>> +
>> +	key.objectid =3D old_addr;
>> +	key.type =3D BTRFS_IDENTITY_REMAP_KEY;
>> +	key.offset =3D 0;
>> +
>> +	ret =3D btrfs_search_slot(trans, fs_info->remap_root, &key, path, 0, 1=
);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
>> +
>> +	if (key.objectid !=3D old_addr || key.type !=3D BTRFS_IDENTITY_REMAP_K=
EY)
>> +		return -ENOENT;
>> +
>> +	if (key.offset =3D=3D length) {
>> +		ret =3D btrfs_del_item(trans, fs_info->remap_root, path);
>> +		if (ret)
>> +			return ret;
>> +
>> +		btrfs_release_path(path);
>> +
>> +		ret =3D adjust_identity_remap_count(trans, path, src_bg, -1);
>> +		if (ret)
>> +			return ret;
>> +
>> +		return 1;
>> +	}
>> +
>> +	new_key.objectid =3D old_addr + length;
>> +	new_key.type =3D BTRFS_IDENTITY_REMAP_KEY;
>> +	new_key.offset =3D key.offset - length;
>> +
>> +	btrfs_set_item_key_safe(trans, path, &new_key);
>> +
>> +	btrfs_release_path(path);
>> +
>> +	return 1;
>> +}
>> +
>> +static int add_new_remap_entry(struct btrfs_trans_handle *trans,
>> +			       struct btrfs_path *path,
>> +			       struct btrfs_block_group *src_bg, u64 old_addr,
>> +			       u64 new_addr, u64 length)
>> +{
>> +	struct btrfs_fs_info *fs_info =3D trans->fs_info;
>> +	struct btrfs_key key, new_key;
>> +	struct btrfs_remap remap;
>> +	int ret;
>> +	int identity_count_delta =3D 0;
>> +
>> +	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
>> +
>> +	/* Shorten or delete identity mapping entry. */
>> +
>> +	if (key.objectid =3D=3D old_addr) {
>> +		ret =3D btrfs_del_item(trans, fs_info->remap_root, path);
>> +		if (ret)
>> +			return ret;
>> +
>> +		identity_count_delta--;
>> +	} else {
>> +		new_key.objectid =3D key.objectid;
>> +		new_key.type =3D BTRFS_IDENTITY_REMAP_KEY;
>> +		new_key.offset =3D old_addr - key.objectid;
>> +
>> +		btrfs_set_item_key_safe(trans, path, &new_key);
>> +	}
>> +
>> +	btrfs_release_path(path);
>> +
>> +	/* Create new remap entry. */
>> +
>> +	new_key.objectid =3D old_addr;
>> +	new_key.type =3D BTRFS_REMAP_KEY;
>> +	new_key.offset =3D length;
>> +
>> +	ret =3D btrfs_insert_empty_item(trans, fs_info->remap_root,
>> +		path, &new_key, sizeof(struct btrfs_remap));
>> +	if (ret)
>> +		return ret;
>> +
>> +	btrfs_set_stack_remap_address(&remap, new_addr);
>> +
>> +	write_extent_buffer(path->nodes[0], &remap,
>> +		btrfs_item_ptr_offset(path->nodes[0], path->slots[0]),
>> +		sizeof(struct btrfs_remap));
>> +
>> +	btrfs_release_path(path);
>> +
>> +	/* Add entry for remainder of identity mapping, if necessary. */
>> +
>> +	if (key.objectid + key.offset !=3D old_addr + length) {
>> +		new_key.objectid =3D old_addr + length;
>> +		new_key.type =3D BTRFS_IDENTITY_REMAP_KEY;
>> +		new_key.offset =3D key.objectid + key.offset - old_addr - length;
>> +
>> +		ret =3D btrfs_insert_empty_item(trans, fs_info->remap_root,
>> +					      path, &new_key, 0);
>> +		if (ret)
>> +			return ret;
>> +
>> +		btrfs_release_path(path);
>> +
>> +		identity_count_delta++;
>> +	}
>> +
>> +	/* Add backref. */
>> +
>> +	new_key.objectid =3D new_addr;
>> +	new_key.type =3D BTRFS_REMAP_BACKREF_KEY;
>> +	new_key.offset =3D length;
>> +
>> +	ret =3D btrfs_insert_empty_item(trans, fs_info->remap_root, path,
>> +				      &new_key, sizeof(struct btrfs_remap));
>> +	if (ret)
>> +		return ret;
>> +
>> +	btrfs_set_stack_remap_address(&remap, old_addr);
>> +
>> +	write_extent_buffer(path->nodes[0], &remap,
>> +		btrfs_item_ptr_offset(path->nodes[0], path->slots[0]),
>> +		sizeof(struct btrfs_remap));
>> +
>> +	btrfs_release_path(path);
>> +
>> +	if (identity_count_delta =3D=3D 0)
>> +		return 0;
>> +
>> +	ret =3D adjust_identity_remap_count(trans, path, src_bg,
>> +					  identity_count_delta);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static int add_remap_entry(struct btrfs_trans_handle *trans,
>> +			   struct btrfs_path *path,
>> +			   struct btrfs_block_group *src_bg, u64 old_addr,
>> +			   u64 new_addr, u64 length)
>> +{
>> +	struct btrfs_fs_info *fs_info =3D trans->fs_info;
>> +	struct btrfs_key key;
>> +	struct extent_buffer *leaf;
>> +	int ret;
>> +
>> +	key.objectid =3D old_addr;
>> +	key.type =3D BTRFS_IDENTITY_REMAP_KEY;
>> +	key.offset =3D 0;
>> +
>=20
> Can this lookup code be shared at all with the remapping logic in the
> previous patch? It seems fundamentally both are finding a remap entry for
> a given logical address. Or is it impossible since this one needs cow?
>=20
> Maybe some kind of prev_item helper that's either remap tree specific or
> for this use case of going back exactly one item instead of obeying a
> min_objectid?

Thanks - yes, there's some overlap between add_remap_entry() and=20
move_existing_remap(), it'd make sense to merge them as much as possible.

>=20
>> +	ret =3D btrfs_search_slot(trans, fs_info->remap_root, &key, path, 0, 1=
);
>> +	if (ret < 0)
>> +		goto end;
>> +
>> +	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
>> +
>> +	if (key.objectid >=3D old_addr) {
>> +		if (path->slots[0] =3D=3D 0) {
>> +			ret =3D btrfs_prev_leaf(trans, fs_info->remap_root, path,
>> +					      0, 1);
>> +			if (ret < 0)
>> +				goto end;
>> +		} else {
>> +			path->slots[0]--;
>> +		}
>> +	}
>> +
>> +	while (true) {
>> +		leaf =3D path->nodes[0];
>> +		if (path->slots[0] >=3D btrfs_header_nritems(leaf)) {
>> +			ret =3D btrfs_next_leaf(fs_info->remap_root, path);
>> +			if (ret < 0)
>> +				goto end;
>> +			else if (ret =3D=3D 1)
>> +				break;
>> +			leaf =3D path->nodes[0];
>> +		}
>> +
>> +		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
>> +
>> +		if (key.objectid >=3D old_addr + length) {
>> +			ret =3D -ENOENT;
>> +			goto end;
>> +		}
>> +
>> +		if (key.type !=3D BTRFS_REMAP_KEY &&
>> +		    key.type !=3D BTRFS_IDENTITY_REMAP_KEY) {
>> +			path->slots[0]++;
>> +			continue;
>> +		}
>> +
>> +		if (key.type =3D=3D BTRFS_REMAP_KEY &&
>> +		    key.objectid + key.offset =3D=3D old_addr) {
>> +			ret =3D merge_remap_entries(trans, path, src_bg, old_addr,
>> +						  new_addr, length);
>> +			if (ret < 0) {
>> +				goto end;
>> +			} else if (ret =3D=3D 0) {
>> +				path->slots[0]++;
>> +				continue;
>> +			}
>> +			break;
>> +		}
>> +
>> +		if (key.objectid <=3D old_addr &&
>> +		    key.type =3D=3D BTRFS_IDENTITY_REMAP_KEY &&
>> +		    key.objectid + key.offset > old_addr) {
>> +			ret =3D add_new_remap_entry(trans, path, src_bg,
>> +						  old_addr, new_addr, length);
>> +			if (ret)
>> +				goto end;
>> +			break;
>> +		}
>> +
>> +		path->slots[0]++;
>> +	}
>> +
>> +	ret =3D 0;
>> +
>> +end:
>> +	btrfs_release_path(path);
>> +
>> +	return ret;
>> +}
>> +
>>   static int mark_chunk_remapped(struct btrfs_trans_handle *trans,
>>   			       struct btrfs_path *path, uint64_t start)
>>   {
>> @@ -4828,6 +5164,188 @@ static int mark_chunk_remapped(struct btrfs_tran=
s_handle *trans,
>>   	return ret;
>>   }
>>  =20
>> +static int do_remap_tree_reloc_trans(struct btrfs_fs_info *fs_info,
>> +				     struct btrfs_block_group *src_bg,
>> +				     struct btrfs_path *path, u64 *last_start)
>> +{
>> +	struct btrfs_trans_handle *trans;
>> +	struct btrfs_root *extent_root;
>> +	struct btrfs_key ins;
>> +	struct btrfs_block_group *dest_bg =3D NULL;
>> +	struct btrfs_chunk_map *chunk;
>> +	u64 start, remap_length, length, new_addr, min_size;
>> +	int ret;
>> +	bool no_more =3D false;
>> +	bool is_data =3D src_bg->flags & BTRFS_BLOCK_GROUP_DATA;
>> +	bool made_reservation =3D false, bg_needs_free_space;
>> +	struct btrfs_space_info *sinfo =3D src_bg->space_info;
>> +
>> +	extent_root =3D btrfs_extent_root(fs_info, src_bg->start);
>> +
>> +	trans =3D btrfs_start_transaction(extent_root, 0);
>> +	if (IS_ERR(trans))
>> +		return PTR_ERR(trans);
>> +
>> +	mutex_lock(&fs_info->remap_mutex);
>> +
>> +	ret =3D find_next_identity_remap(trans, path, src_bg->start + src_bg->=
length,
>> +				       *last_start, &start, &remap_length);
>> +	if (ret =3D=3D -ENOENT) {
>> +		no_more =3D true;
>> +		goto next;
>> +	} else if (ret) {
>> +		mutex_unlock(&fs_info->remap_mutex);
>> +		btrfs_end_transaction(trans);
>> +		return ret;
>> +	}
>> +
>> +	/* Try to reserve enough space for block. */
>> +
>> +	spin_lock(&sinfo->lock);
>> +	btrfs_space_info_update_bytes_may_use(sinfo, remap_length);
>=20
> Why isn't this partly leaked if btrfs_reserve_extent returns a smaller ex=
tent than
> remap_length?
>=20
>> +	spin_unlock(&sinfo->lock);
>> +
>> +	if (is_data)
>> +		min_size =3D fs_info->sectorsize;
>> +	else
>> +		min_size =3D fs_info->nodesize;
>> +
>> +	ret =3D btrfs_reserve_extent(fs_info->fs_root, remap_length,
>> +				   remap_length, min_size,
>> +				   0, 0, &ins, is_data, false);
>=20
> ^ i.e., this will reduce bytes_may_use by the amount it actually
> reserved, and I don't see anywhere where we make up the difference. Then
> it looks like we will remap the extent we can, find the next free range
> and come back to this function and that remaining range to bytes_may_use
> a second time.

As I said to you off-list, this tripped me up! btrfs_reserve_extent()=20
reverses the whole bytes_may_use value, even if it hands out less than that.

>=20
>> +	if (ret) {
>> +		spin_lock(&sinfo->lock);
>> +		btrfs_space_info_update_bytes_may_use(sinfo, -remap_length);
>> +		spin_unlock(&sinfo->lock);
>> +
>> +		mutex_unlock(&fs_info->remap_mutex);
>> +		btrfs_end_transaction(trans);
>> +		return ret;
>> +	}
>> +
>> +	made_reservation =3D true;
>> +
>> +	new_addr =3D ins.objectid;
>> +	length =3D ins.offset;
>> +
>> +	if (!is_data && length % fs_info->nodesize) {
>> +		u64 new_length =3D length - (length % fs_info->nodesize);
>=20
> Why not use the IS_ALIGNED / ALIGN_DOWN macros? Nodesize is a power of
> two, so I think it should be quicker. Probably doesn't matter, but it
> does seem to be the predominant pattern in the code base. Also avoids
> ever worrying about dividing by zero.

Makes sense, thank you. I changed this to use & after kernelbot=20
complained that I broke compilation on 32-bit CPUs, which is presumably=20
what the macro is doing.

>=20
>> +
>> +		btrfs_free_reserved_extent(fs_info, new_addr + new_length,
>> +					   length - new_length, 0);
>> +
>> +		length =3D new_length;
>> +	}
>> +
>> +	ret =3D add_to_free_space_tree(trans, start, length);
>=20
> Can you explain this? Intuitively, to me, the old remapped address is
> not a logical range we can allocate from, so it should not be in the
> free space tree. Is this a hack to get the bytes back into the
> accounting and allocations are blocked by the remapped block group being
> remapped / read-only?

Yes, good point - we should be clearing out the FST once a block is=20
marked REMAPPED. I think I'll have to fix the discard code, IIRC it=20
works by walking the FST. Plus btrfs-check as well of course

>=20
>> +	if (ret)
>> +		goto fail;
>> +
>> +	dest_bg =3D btrfs_lookup_block_group(fs_info, new_addr);
>> +
>> +	mutex_lock(&dest_bg->free_space_lock);
>> +	bg_needs_free_space =3D test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE,
>> +				       &dest_bg->runtime_flags);
>> +	mutex_unlock(&dest_bg->free_space_lock);
>> +
>> +	if (bg_needs_free_space) {
>> +		ret =3D add_block_group_free_space(trans, dest_bg);
>> +		if (ret)
>> +			goto fail;
>> +	}
>> +
>> +	ret =3D remove_from_free_space_tree(trans, new_addr, length);
>> +	if (ret)
>> +		goto fail;
>=20
> I think you have also discussed this recently with Josef, but it seems
> a little sketchy. I suppose it depends if the remap tree ends up getting
> delayed refs and going in the extent tree? I think this is currently
> only called from alloc_reserved_extent.

Do you mean the bit about BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE? We delay=20
populating the in-memory representation of the FST for a BG until we=20
need it, so we have to force it here. Presumably if we accept that=20
remapped BGs don't have anything in the FST we can remove this code.

>> +
>> +	ret =3D do_copy(fs_info, start, new_addr, length);
>> +	if (ret)
>> +		goto fail;
>> +
>> +	ret =3D add_remap_entry(trans, path, src_bg, start, new_addr, length);
>> +	if (ret)
>> +		goto fail;
>> +
>> +	adjust_block_group_remap_bytes(trans, dest_bg, length);
>> +	btrfs_free_reserved_bytes(dest_bg, length, 0);
>> +
>> +	spin_lock(&sinfo->lock);
>> +	sinfo->bytes_readonly +=3D length;
>> +	spin_unlock(&sinfo->lock);
>> +
>> +next:
>> +	if (dest_bg)
>> +		btrfs_put_block_group(dest_bg);
>> +
>> +	if (made_reservation)
>> +		btrfs_dec_block_group_reservations(fs_info, new_addr);
>> +
>> +	if (src_bg->used =3D=3D 0 && src_bg->remap_bytes =3D=3D 0) {
>> +		chunk =3D btrfs_find_chunk_map(fs_info, src_bg->start, 1);
>> +		if (!chunk) {
>> +			mutex_unlock(&fs_info->remap_mutex);
>> +			btrfs_end_transaction(trans);
>> +			return -ENOENT;
>> +		}
>> +
>> +		ret =3D last_identity_remap_gone(trans, chunk, src_bg, path);
>> +		if (ret) {
>> +			btrfs_free_chunk_map(chunk);
>> +			mutex_unlock(&fs_info->remap_mutex);
>> +			btrfs_end_transaction(trans);
>> +			return ret;
>> +		}
>> +
>> +		btrfs_free_chunk_map(chunk);
>> +	}
>> +
>> +	mutex_unlock(&fs_info->remap_mutex);
>> +
>> +	ret =3D btrfs_end_transaction(trans);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (no_more)
>> +		return 1;
>> +
>> +	*last_start =3D start;
>> +
>> +	return 0;
>> +
>> +fail:
>> +	if (dest_bg)
>> +		btrfs_put_block_group(dest_bg);
>> +
>> +	btrfs_free_reserved_extent(fs_info, new_addr, length, 0);
>> +
>> +	mutex_unlock(&fs_info->remap_mutex);
>> +	btrfs_end_transaction(trans);
>> +
>> +	return ret;
>> +}
>> +
>> +static int do_remap_tree_reloc(struct btrfs_fs_info *fs_info,
>> +			       struct btrfs_path *path,
>> +			       struct btrfs_block_group *bg)
>> +{
>> +	u64 last_start;
>> +	int ret;
>> +
>> +	last_start =3D bg->start;
>> +
>> +	while (true) {
>> +		ret =3D do_remap_tree_reloc_trans(fs_info, bg, path,
>> +						&last_start);
>> +		if (ret) {
>> +			if (ret =3D=3D 1)
>> +				ret =3D 0;
>> +			break;
>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>   int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
>>   			  u64 *length)
>>   {
>> @@ -5073,6 +5591,10 @@ int btrfs_relocate_block_group(struct btrfs_fs_in=
fo *fs_info, u64 group_start,
>>   		}
>>  =20
>>   		err =3D start_block_group_remapping(fs_info, path, bg);
>> +		if (err)
>> +			goto out;
>> +
>> +		err =3D do_remap_tree_reloc(fs_info, path, rc->block_group);
>>  =20
>>   		goto out;
>>   	}
>> --=20
>> 2.49.0
>>


