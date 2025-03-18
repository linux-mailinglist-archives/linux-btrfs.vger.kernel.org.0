Return-Path: <linux-btrfs+bounces-12376-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10EAA67339
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 12:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FD267A4DD0
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 11:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F3020B208;
	Tue, 18 Mar 2025 11:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="mwJ7GKac"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068E92080E3
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298975; cv=fail; b=ZVOjmxo6MjZu93+F/6fW3OTjmB32SCW+06H85i07ThOI2yHVG3vUjGiK7G93Bz6Mgng8RdJMDarZKSZPy7Wa89sAenVR6EFIGue7WQA4gkg6hU7AX6ajCivoOf7k+ce+63cE4gZjRt63GShiRLtIho6aY1e120cHOrNSPyVjPC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298975; c=relaxed/simple;
	bh=D8uirCM3nvssOqKsoJEtNAqs1cECz1gVHMzIQnL7G/Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PvATxUjUzqWmJk5UGCkwsHNPuPZ2dJ4zfavPmvEm6s6EKQ7iHeG8aUvpExAsW7XDdRc2VbFJwzWKruLiaJIPjJrKFq2YtY91cT6YTk30A3+NEx3+5MiWHukpLRawJDlhO56Io3JwiLaf2ePWV+JgwknMHXNEDiG/Ohv7bZn+lbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=mwJ7GKac; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IAiCIK021016
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 04:56:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=D8uirCM3nvssOqKsoJEtNAqs1cECz1gVHMzIQnL7G/Y=; b=
	mwJ7GKacDsvqU9kYM7srYnsoda8C896x+dUYNBfOq9rVYew1G/M9YUEmjNAjoRE+
	GLiTEm0Jd0/REETPi2LlhT426/DI7QN3tQY13YSPB0Hb8UXCSy26qKTkQwQmN8Mx
	XVXo47erZ2sgjCX0WRveWmx9+ezBiPlgWqbD1Bvb+CpYKVf75cc+XNvxo1H9ikTC
	b9Ph/9C7zjPbGYx5pjqyJUn0pQhCZalIX3mDkohnP0wOxa5TIdo0devcmmue0bB8
	uzpaJiCNWYRheFLCBjFusV1TZq6yxfs5+AZEBl2ZsTos41bbsIO26i3QO6ugpWjO
	J83qEsI6K+Q1t9A2mwSNdg==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 45f3pyt0e1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 04:56:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CW90Dnk/hGHWME/TQj5siefihkzoNz7wcmn0cJaYOpmIABJwEUFrOni6W4i7IAOVTIUnTAxX55+GaF6IF2+ArHkQaq7+BC3eOYwk7IkBn2Qkjw4DObZYlvFhnbIw1InjVZvgJEjps+jnTqXu95ZtZC1Smml2CYRkJquz10hlVfhoEZiHQPBox1RTWPJcBx+vANTD9fiyxv3985FcjaZuuBSKco+7SYbuT4pCd2o87UwB7Vv5EhYdJGxELa39w9h3yJ3JBPcyla+zPs0P3n3yflFAv1XT4OTnWAh1r6d9k2BMWb9PLi6y0C6DAzdvhnasPmM4XcXkyE8/CSKcre+qDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8uirCM3nvssOqKsoJEtNAqs1cECz1gVHMzIQnL7G/Y=;
 b=pAqJ5TltjO1MaLRBkH55ExFedovQYi0ye+p85x2S/QHSO1li0PGUwkKXXwGVPJzlsHjMi4grpyL2ZfTOhYpAWrS8mhomVxZCT6kiCDqnW/DRwrcd3v2zccHA2ED3rj6RYixwOhfR2pwOXc0AIhu6WSUX6bbQD+Hm2C5K+9lFi8qqqhnS7JRa5PAvE7aKhd7O6shASeD9inMZW2tvR9AJikHvoxvc1gkaVFN0WzEjAfTqKzGLMkUtOkRQdVNoFQ4FtnPjumabD1bHGngXxfEnovUv47HivZ3IC93oMsCN1HjR1Rknr23HUPH8ILNKfO2vJH8UeIDAIKodJkSULLLqxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by MW4PR15MB5249.namprd15.prod.outlook.com (2603:10b6:303:188::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 11:56:10 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%7]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 11:56:10 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Leo Martins <loemra.dev@gmail.com>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] btrfs-progs: add slack space for mkfs --shrink
Thread-Topic: [PATCH v2 1/1] btrfs-progs: add slack space for mkfs --shrink
Thread-Index: AQHblEawTMVTnQtebEmAs8KxM2cnALN40OuA
Date: Tue, 18 Mar 2025 11:56:09 +0000
Message-ID: <3ca998a3-baaf-445b-9339-c425e3430ccd@meta.com>
References:
 <121133b547f15980bd02280328bb04017c495ec9.1741890798.git.loemra.dev@gmail.com>
In-Reply-To:
 <121133b547f15980bd02280328bb04017c495ec9.1741890798.git.loemra.dev@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|MW4PR15MB5249:EE_
x-ms-office365-filtering-correlation-id: d4e0c529-e7d0-4a90-f72e-08dd6613dfb1
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cGk1M1N3N294Y1ViY1J2TzR4aHZPNFJxY1hySTd5ZDVtMHUzMCtWK0xYMUo4?=
 =?utf-8?B?Syt6cDRnbVU4aFJsbDVPUU9qU3FwaGdOL0VEcnBEb3dnRUZSZWdMVys3UURK?=
 =?utf-8?B?MUYydGR4azVxUDlJNmlRZm44d200MGhKQzZTNVg4RXAzTm9MWDllYTNsV2Fw?=
 =?utf-8?B?WkxRazNxTkxodGpjOGJjenFoeFRJT2VlQ0tnNVB3VnU2N2NqR3NVOXNiWWpn?=
 =?utf-8?B?MzZTOTJVdUhZbHhkb2VXL0RIV0FDSnVvcHhENVZSMVRhRk52Vm5MUHRsZXI4?=
 =?utf-8?B?Q2t3MVhjQzBmYThBQjkwRnJTRlUvVlRyS3VkUUMrWFNkQ0htL3RoTVNUTWIx?=
 =?utf-8?B?VG1kRWNhSmRzVkpTcVVvYVhpR2RTYXp2L2lHMjU3Ry94UjFmeXpDOXhhTi9s?=
 =?utf-8?B?TG1WVXpEUXY5R2pWUGhoQWxvcHFTRkFiMCtER1RlV0tlWFdFYWh1K3RBWVN6?=
 =?utf-8?B?WWluQURoZmlhTFN6TEJiMitCNzUwKytVekM1ZXVpSHJHeUE4QnRWb2NYaEZm?=
 =?utf-8?B?WllvcyttWFJYM2tZYTVScjArVEY1ZlNSYlVnMDhGM2hxdDQyTnJrZS93WmZt?=
 =?utf-8?B?NWFVVGw2S3FWNXdqR0k4V0t0MU5tdHM2RCtvc0VSQW84VWpabDVSMjRwS2Zl?=
 =?utf-8?B?RjdCUWd3OFVtUll0UktLUkptMXVlOXU2L0NWaWMvaHhTbzVrWVBONHNTVWRT?=
 =?utf-8?B?NVFDdVdPb05Eb3ByTFNuTlRYdStBcTNYYVhkWXc5cGJBTW5kWXU4V1pTOEI4?=
 =?utf-8?B?UUtIN0JFRjdqNzFHODM5dzJyMVA3ckptQkQ1ZG84dnNucHV5MStKS01lbnBH?=
 =?utf-8?B?SDFWY2RjYm1RT2FGdFY3bERPQmRWUnZvRUFQVFcySmo1UzVZaGVVa0Y3ZnB2?=
 =?utf-8?B?R1MxTTlMTjB1TkJ0TWRDOVJLNk5pNDRKYkUyck1HdGl5T3NoT1dOcjczLzlq?=
 =?utf-8?B?disyR3NKK0d1R0s0QzVYdmptdzlxMmRIOSs4ZkdFV2wyekthOHNaK0ltQjZ0?=
 =?utf-8?B?UVlMbHBTL1ozWmhtYTZaR3paS0xleXcrUk5XUTd0eGZCK2QraUdmei9DWjQy?=
 =?utf-8?B?T0t1TmxQd0YyZmtkR3RZNkZCVHk0U1JGWnZqbDlGVm1BNHkxb3hlRVMvRE45?=
 =?utf-8?B?NW5jeUV2aGMrU0NrUHdUM3dMN29VMGRuNmFxVERXcUs3L05XN2JjaXpJMXZo?=
 =?utf-8?B?d0tqMisrdEE5TVFlamhWOTZxTnByc0lhQ1hXeDliSzdDYUpKbXhaVDdudzBQ?=
 =?utf-8?B?SndLOHpIOHB4c0RKQXZ6eFF5dnVXSk82Q0ttU2p5MlZBeUZoNFlaMjhCOW1B?=
 =?utf-8?B?QUpUMDJkZ2tzU3Y1WVgwcmxNZUx3ZmJqSHZjTGtxNHQxWUJrbVI4azJIdjJh?=
 =?utf-8?B?RGFrbHp6OWhXT2Q1dkx6bHlPOWVzZjBsdE5ycDRJYlZXQmFMalBuc0QvaXc2?=
 =?utf-8?B?bEhmN2xCVlhNOFFYUmpsdGczSGNlTGVGcEJya2dCbXU5QWZHa0JsdXJ2YU5z?=
 =?utf-8?B?UVZrZ1BsS2xuV21zdkJncjNIWTc4SkRqOEVEY0dLaDFpZzQ1SjNlbDJNQnJX?=
 =?utf-8?B?L0swM0V6aDl6TjZLeDZXVjFnaWRQTGp1RlRTbml3NHFiaVluVUR1QnB0Y09X?=
 =?utf-8?B?MHRLblJrYXZwakI3ZVR6eEl4a0FPTk9vZlF4MHFJZ3RjRFJ1d0NwUEFqQTA5?=
 =?utf-8?B?QTY3Y3l2a0p5NmUwSWR2MHk1ZnozQ3J2SFJEdnROdFJydmwxa3dyUXJpTi9m?=
 =?utf-8?B?WVN4VUxHcXdzTGg3cWNzSTIxQklsMXNIbVBBeFYrVlY4V1U5dkFqeFhMT3pW?=
 =?utf-8?B?Ulp5aUJYdTJGbjVNOGJPL0JWRzRWZTBWNm91clpBVlBHbkkxUGxUTDZGZ2Fh?=
 =?utf-8?B?b2M0cUd4bUYxVVRWdUVYMWJTa0ZNazloZTZYNnN3QUZoaVluMFpxOHNSZDJO?=
 =?utf-8?Q?MDcDgR4KkJ1DonUJa1wzYxGoC5iSza4A?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dWFKS3l0U3hMeXNQR1ZFOFJ6bDIxSUZ4eUtzOUVCVVVRVnp2Z21lYllFTFpH?=
 =?utf-8?B?dEJzWjBOTDY1enpLaVEydWJBelBoajc4ZmFZT010eVJEdVpoaUZqYnB5bDNE?=
 =?utf-8?B?UFFsaW5nNGJ6NGRCZVh1dlE3eERpNlY1Wm5HZEE0czNiSFMzT2c5TGFVWGx5?=
 =?utf-8?B?NDY2ZUwzZ21vb3BpOEtpMkFXK29NMCtpcHRwbzdKOWJ6SzhKNXQyam5XNGdw?=
 =?utf-8?B?R25lakJEMVFTb0pReDJRS01ScVExNUs0ODB5bUdaTytMbFFMTE9XT2ZBZUlK?=
 =?utf-8?B?SGZFTTJOeHZPRkEveFJ4UkdwYjRtbW80ejlWVUZRcHIrenZXWHh5TkNENnpt?=
 =?utf-8?B?L0djRTViMmNacCt4R0VuTzZnTk1KY2hTdEJuZUVkSTUvN2ErNVN5WnpvTFV1?=
 =?utf-8?B?Y2EyT1JIVHllZzN1ZUc3Z1ZBV1FudVJQZFg4aktVVHdya1M5V1RWbDlqcmtx?=
 =?utf-8?B?MnpsMjBDTWpMNFhVeU9OZ0RlSXovYWMvcFl4NzkzQzVJTlA2dkh6WlZVZ3NZ?=
 =?utf-8?B?TG1RYTBqSzFIQ2xPYnkzT3YyWXFHTkFFV29JUDQ1Nk5aMytDUUJWK1QyNjcw?=
 =?utf-8?B?N1VhZzRReC9EelNiMmhMdXFXUjNyeTRoZlUyZjB4blBDS0EyNDJZMFdBMUdx?=
 =?utf-8?B?Zzc2WWZNRFMwREI4YzVwbFF5TnlHdVE3SjhWdXJ1aXpkVWJTcHAyME5YQVlZ?=
 =?utf-8?B?QXJSMktmd3AwVlNIaDB3TEFLSnNSUUdMeVp3TlNtRkZlaFFUNmZHZ1Nwd3cx?=
 =?utf-8?B?eW1vSEhZaTRuU3BqcC9XNktDTkJaempobjQzV2xJYmxyQ1NYdFhsUjA4WWlX?=
 =?utf-8?B?a0pPVkFiQ2tZMTljYytSaTBTdVRXWi9ScDM4NmpiWW1EV0g0eUZhdWlLa29W?=
 =?utf-8?B?Q0k1MmFTVjNxbWJWaFV1Z3BLTDM1U1JlenVSaytuYWYraHZuMkNXYkZxVDRK?=
 =?utf-8?B?blRvcDZmcVBzNUQrMDEwNWw3cVFDT0g4QTJqODVIWFFrNHRES0c4K0l3VXlM?=
 =?utf-8?B?L3B5clFuV3c3cEhMMGNnWEphamkyaGxESXltdTNwL0lsU3krWWFTNlhUUkdw?=
 =?utf-8?B?K292cFYrblpHMG9WVjhoS0tLTEpUM0ZNWlVLSFMxWVF0UDRqVTZUQ1Q0dXd6?=
 =?utf-8?B?TDNLbS9hMDFtLzFpRExkMXB1VXdvSnVucmd1OEVYM2dNQVExOUszbWdIbGg1?=
 =?utf-8?B?RWpIM2RXdzdzUmI5Zlc4aFhJRUxQdXdUMG0vcTdjREpIeUJrOVdCandKMzQx?=
 =?utf-8?B?Ym9hL1ZnUUF0R2FEMkt2UDNkam90bmVQNkVZMy85c1AvMlUwNmNCQnJONEZ1?=
 =?utf-8?B?a2FjSDgwWVYzZmttYUIza2FqNWV3Sk1memR1RENIQjQ1R2RkOWFDSitFbUZa?=
 =?utf-8?B?TFZFSnNzYkh2Z1dWRHFiL2dicUNXOU1NN1VsT0tTd2d3ZkxKcFZWUkdsK29L?=
 =?utf-8?B?dHZBeUUzOVZVRzlVc1F2YXVYRGl3QUt1MHF2dTQ1UjYreHhmMTI4ODNMRlVU?=
 =?utf-8?B?cy9wN3RGMFlyWVR1L1QvYlJJdUhTS1dkOWU1a2RDazF2alVscjlCTGJYSlll?=
 =?utf-8?B?SnQrV2FpZHFjNXdBb3JVU00yWGtoSFVUeHdXT0JxaTdGTmJsZjVzWmRKMjVj?=
 =?utf-8?B?YnN6OXBKcWM4NjRiditpdzhZd0FrMkg3Sll5Y0RFd01TNTNKZmZ1S1lZVHQ3?=
 =?utf-8?B?aE16bFE1Tm1KOHA0L0x5QUlKQnpUYStmWjFESTRXdEx3aW1FNVJDVnp0YzZo?=
 =?utf-8?B?UkF5V0VPLzhPYnZZNG5LNDhOVWJCYXcybkJocnA2Q01lUHhKdE5lVTdCQWFv?=
 =?utf-8?B?ZU4vN2UwR2lNeGFoZFRIRzNmcVJIeEdPa2FUNWNRYnVTZDFLWk9ZTkZlWXBF?=
 =?utf-8?B?QlpJeWlJV242eVQxSXRMNFdRYVdBOXZNVE1oR09rYnMwRXNpOWlpbmdMQi9n?=
 =?utf-8?B?OUppZmk3V3p2NE9NbzBqaGVDdUFIcnhPdlFOakZMbllPUmVNdjJ6bzhNR2dv?=
 =?utf-8?B?cFBseklZSmNSNnM2VWVZSG54blYvV3Y5bmdNbEVUV1V0RkhBV3VaQmF3TzVJ?=
 =?utf-8?B?RDhpQXVnQ05sOXJCN3N4SlVycWMyQU1Odm9TWGZBMXd6RG9URXd4OEhaaGxa?=
 =?utf-8?Q?3iM8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D9F68AB9554B64BB41E7382AD231470@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e0c529-e7d0-4a90-f72e-08dd6613dfb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 11:56:09.9444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P3KzL/4HyE+BF60a/zMCV55eUxrCGExDG4faPXDaexKBDwOEqyy4f7b+24HgphWp9lEOPJoaNYah7WAHuCghRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB5249
X-Proofpoint-ORIG-GUID: CH9ncw_fc3aDZE5J1ap8MZehxvOXYzoe
X-Proofpoint-GUID: CH9ncw_fc3aDZE5J1ap8MZehxvOXYzoe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_05,2025-03-17_03,2024-11-22_01

TG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IE1hcmsgSGFybXN0b25lIDxtYWhhcm1zdG9uZUBm
Yi5jb20+DQoNCk9uIDEzLzMvMjUgMTg6MzUsIExlbyBNYXJ0aW5zIHdyb3RlOg0KPiBUaGUgZm9s
bG93aW5nIGNvbW1hbmQgd2lsbCBzdWNjZWVkIHdpdGhvdXQgd2FybmluZyBldmVuIGlmIGAkREVW
SUNFYCBpcw0KPiBhIGJsb2NrIGRldmljZSBzbWFsbGVyIHRoYW4gMTBULiBIb3dldmVyLCBtb3Vu
dGluZyBgJERFVklDRWAgd2lsbCBmYWlsLg0KPiANCj4gYG1rZnMuYnRyZnMgLWYgJERFVklDRSAt
LXJvb3QgJFJPT1QgLS1zaHJpbmsgLS1zaHJpbmstc2xhY2stc2l6ZSAxMFRgDQo+IA0KPiBJIGRv
bid0IGtub3cgaWYgdGhpcyB3b3VsZCBiZSBjb25zaWRlcmVkIGluY29ycmVjdCBiZWNhdXNlICRE
RVZJQ0UgY291bGQNCj4gYWxzbyBiZSBhIHJlZ3VsYXIgZmlsZSB0aGF0IGNhbiBmdHJ1bmNhdGUg
dXAgdG8gdGhlIGFwcHJvcHJpYXRlIHNpemUuDQo+IFNob3VsZCBJIGFkZCBhIHdhcm5pbmcgbWVz
c2FnZSwgb3IgbGVhdmUgaXQgdG8gbW91bnQgdGltZSB0byBpbmRpY2F0ZQ0KPiB0aGF0IHNvbWV0
aGluZyBpcyB3cm9uZz8NCg0KSSB3YXNuJ3QgYWJsZSB0byByZXByb2R1Y2UgdGhpcywgaXQgd29y
a2VkIGZpbmUgZm9yIG1lLiBJZiB5b3UgY2FuIGNvbWUgDQp1cCB3aXRoIGEgc3RlcCBieSBzdGVw
IGd1aWRlIHRvIG1rZnMtaW5nIGFuIGltYWdlIHRoYXQgY2FuJ3QgYmUgbW91bnRlZCwgDQppdCdk
IGJlIHVzZWZ1bC4NCg0KTWFyaw0K

