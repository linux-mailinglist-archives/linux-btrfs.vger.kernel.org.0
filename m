Return-Path: <linux-btrfs+bounces-9092-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 612F89AC80C
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 12:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A579284B63
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 10:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772181A0AE1;
	Wed, 23 Oct 2024 10:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Xfk3lq8u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F8319CC32;
	Wed, 23 Oct 2024 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729679699; cv=fail; b=oZZwPBhhKyS1In+2DvKLIkFFiM6l8T3AGSjMXolDa2FqX34keThhGl1DSd5cpsPzVTw7rFacyDe3tdku4Ol77+lJ71d5SpoBnna90GZYsgOf0p0gIA27z7vURCJlpY26QhVvUUPD6IXDGOqSHyoKGhv/e3G2hf+NB7lZJ9voIrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729679699; c=relaxed/simple;
	bh=w0EGX20I80JKM986Rjj7RpRU3N8Szfpp5AlNg7Qylm8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=s6mzGdRMQWifsuoeyBcqK6HKJth+n+J/emeXJg1Lzfs5SKP9M2q9p9xqr0yBND1A/6U/afC5vJ3UTuTGFtAnc3k6wdeLHr0EGOD4o7c+Pv4SkW+dOqvdu7MQeGDAAV5JsCieRytGATmKZJEa8NuAs54ijVQo/0q3MTy1SVlh4r4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Xfk3lq8u; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NA9Pt0009369;
	Wed, 23 Oct 2024 03:34:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=gg2sPCcRjrHmtRBJld5B2hVa5ZSRYJ2S8jRCPlDwX/I=; b=
	Xfk3lq8uxsg5dkm9WfE+XpoZYeQkX1pxs5e+0Tf9g7vPQf3j01QHpL2kOee7WsDT
	4s/JTx1L7Z7lc3rcXV4U2Ug6Mzc4goEeyc5YFUPYzRgeOeYPJSYVWT3/Toyk3VpX
	/YzyRvQ8hel3lB8vXEUxQhdOLvQuNN73AAtbTFciQjTv0W/3F3mm8YUeEjXk+tb3
	9c19UDLrct87DB0sIZDhu4oe69KRSKg4TdBorFT95gA8QQ/8NA85E/KmZ+dd8Q2i
	NqRduZ6wqYWQgo135Y3Vx5r8I9t0DU1F1BxnoTTf5RJ8lvcwJn35u0c8Su8BX/zg
	StU12zLV/EIsq+mjrwVu9g==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42eur215xp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 03:34:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2p7VFQA96r1fKKkt+O5BtRBWSdvUMF52GY++qg5gQU/w1iDRm093lDt3LKxBf/7NTOI/uObu/z+9lGpf2wlv8R5Z9rcdCIVo7v+7yO+uj44y6s4kRDksT2ZzFyC/evsOfhiGKzk51Nc9hRoM0pBla+86Wi611XWA+QNGk/zvuFcoBNhSOvTFmJ63QU5YsZtMI4R6Kbwlsa5I6+aeiXRo3iHzvlTvb5OjCKCMHlj7d6BMDqSWE1nlPXtGDbPAOcfUkY1djbyHb5bl9c1osEHjPo8V6NdWEksab9b4nc3ryasXIzESGMkE/ILJqSGnHOdaZqX8VxZAXIRp+IJ+2qR/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCB5E2ow/l0nMn8nBtLhFTvJabAoei7azvUnQmpSRsg=;
 b=M8rdw6+N3K0E2TYbG1wE+vfIvyBAw6o7Y/OAnjVrxAwsw6nuALiQNxVM3+KdmoEP1scMwuLvbtOIeEnfonvzC8iQff+rHCAv12ilyIo9WDI/z6+6cZv15hcm8c6w0ZBgpTrQyPxkwJ8oDjCl+d5TsKGBKimpEQlKQzD9vPOhNv0Dho4+FqXkl3x+Kb0FkfL+1AyLWFwuKNM8CgFIJFSBTxGLDaaIfcGnXLH1e+1j6+kDrlXpRGWfwEZZSPyoPucGvpnfDlJ5xYY8MeTfpNiuRQUrsueQeYAgXmOGYnDklCIt+pg2lBe49TKgN0rErCw+6/fHuNbHaXs71bElioKwig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by SA1PR15MB4918.namprd15.prod.outlook.com (2603:10b6:806:1d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 10:34:54 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%6]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 10:34:54 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Zorro Lang <zlang@redhat.com>
CC: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] generic: add test for missing btrfs csums in log when
 doing async on subpage vol
Thread-Topic: [PATCH] generic: add test for missing btrfs csums in log when
 doing async on subpage vol
Thread-Index: AQHbHxiG5VfUS1reGUKSxW3KOmM4ibKTv+uAgABwR4A=
Date: Wed, 23 Oct 2024 10:34:54 +0000
Message-ID: <51e616ce-6e30-46bd-8318-e756ccd941a9@meta.com>
References: <20241015153957.2099812-1-maharmstone@fb.com>
 <20241023035301.due7yoel6muwvmec@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To:
 <20241023035301.due7yoel6muwvmec@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|SA1PR15MB4918:EE_
x-ms-office365-filtering-correlation-id: 40e5ee82-9540-4e7d-28a1-08dcf34e551f
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K1VpZDNNV25VZC9XaEF1eU52bGhTQmRSNmtQODVLcnpuNTVlTlJJZG1LZW5F?=
 =?utf-8?B?SFRNVU1USWgvaDJlWUVzTFd2MUFSbmttOG1YWVNpYks3ckIzMDdKYzRCei80?=
 =?utf-8?B?b1UxZkxLQWdkcW1nVVVOdlNrWm51RnRQVUUvS01mZ3FxRnZJRXNKL2RYVEFO?=
 =?utf-8?B?cjNGZ2tkT1RXQzdJM0Rua2h0RFJ1aG5lZWdYSWx1Um5Ub29TTHFOeFhWWmM3?=
 =?utf-8?B?b2VUT0dhWDd1QmswMXgwek1FclpTRmVVNHhvUVlZMXdRTWxWM2Y1UHNwNVE5?=
 =?utf-8?B?bGhYdDFXbENpM0lwTnhzYUt5VTFNQXlBNnZiUFR4eFdmVkJkWm5Qa0d3THVV?=
 =?utf-8?B?MjRvNGw1SVJ6dzRDQ1Y5OVhUazdZdTlFTnFDNzFJSU5rRzdObWdmK0wvQ0t1?=
 =?utf-8?B?a3NweVAxRTBQbWZoOGpHR2hnZURaSU1hTGYrVjRFU0ZxdzZBcnYzYWZNUnc2?=
 =?utf-8?B?bmpLYzNLTHdKaWtyaFk1cXVSZWxqWjkxZjF2M3pQRTh2MzVybG45Qmc2YXRw?=
 =?utf-8?B?Tk1jak1BY0YxQTJDYkRYL0dPck16Zjl5SFczSm1jU1hzOEd4YjV3NFl6cHFF?=
 =?utf-8?B?anJSV21uKzBlSDRmblJtL2JnaVpXM0w3T0w1b0UzdzR5b3lJZXpWeGZDQzBj?=
 =?utf-8?B?WGxaMGVCQXB5YlAvZG1hdHhIaVUrWUJsTkl3SlY1UE5FNzNJbCsvQkl0UXZY?=
 =?utf-8?B?dnBEaFR4UE5IeUpNNlpoS3hoazVGU0R3Tk1oVzhTVGI1VDVUd1B1TFRYM3JZ?=
 =?utf-8?B?MVUxbFE5TWtvOXBUR1VlUEJpWlBPMmFrb0ZTRTZsZnJlUHhnVWFEUGtKSC9W?=
 =?utf-8?B?WTh4VEFaYmJ4eElEeG5NS2V0emtJMUFxQUJScDBLUHk0ZmUzQ2p5azdveGhS?=
 =?utf-8?B?MlBSYVZmU0RUendQRnhQeCtoRmdBTDlscG40UFdGTXFRNlRmMCtUY1EwZnNI?=
 =?utf-8?B?dDJraHovYTMzcnhLRjRjdjJiZXgxWHBNeU00cjEwWXhYanpYaklZM3VuSkRH?=
 =?utf-8?B?b3Z6REVkSDJQQmx3MG9Yb0pNc0RXUzNDaVA1eEdWV1ovRFhNVWIyZXBOOFU1?=
 =?utf-8?B?SkpiY3J6eVk5MmlrdmtvY3gxTUFsYVJiNjhxN0pNUmJRRlpEcnZ0SWo5QUpZ?=
 =?utf-8?B?TVZIcXRaSkJkanFUZWxlc1V1M0d6bGNtb0UyNUtjV0dHNm5NbGh5OXBJb3RW?=
 =?utf-8?B?cTM1TkRXU2x4dytaWnR3QjFML0pEVURpZXVNWk5CRU9pOHJHb2RGaFduTVIv?=
 =?utf-8?B?WmJ3RFZIaThaOVJaTEEzRHovQnhFL2k1eXdJRVkxTHpneWsyUVhmczJlVkFP?=
 =?utf-8?B?NmlRZURibDIrNnE2VUpRV0ViT0pseFp2SWJrdEVoTk1pSDVWdFNGUHpaRGlq?=
 =?utf-8?B?TS94SUR5VGdYTGJZUnNtVVZVWHBiVVpKVlAzcG5RM1pEZnhjYUJtY0RzSmhi?=
 =?utf-8?B?NXoxdWtBTnB6amdIUzM5UkJoaWFqY2YyMnVBcjZGeGtrN05USWh1Wk1XaXU3?=
 =?utf-8?B?bE03aWV6aTI4VG9NdnNtMy9WY2JhZkFVaUtrZUV4ekh2QzVyc0pUanIwZGUx?=
 =?utf-8?B?QlZnbXFiZUU2YzdBaTl5aUpQTFRwdEZlR05HbFhScTVuSHhNUTI4ZUh5VUZT?=
 =?utf-8?B?MXV1U3UvWkVkWUh5VCtpVXFPcEpIdXRyenNGdFV4cmR0NlZKM3dtY2tKYyta?=
 =?utf-8?B?bjB5NG5kdStyK0tmSnZXOE1IajVTUVZBNDRvZGFUeVRYSmhoTWRWZXZ6NnNB?=
 =?utf-8?B?UmpXckllQVF3Ui9ERWhLRFkybS9MWTNvMlkvVTNERzdicDdvUjZmWXdUc291?=
 =?utf-8?Q?f1BvFLFaxsUiS6nXti3DeiiSnwCOKks16Fs20=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V1ZVTTRCRFBWNVFldTlkMTBSYUdzeDlSdUwyZG9STjdMd3JITGNlZGhMdjJM?=
 =?utf-8?B?VlJMZTVhcC9LU3doVFZuYmY5citVbmFsbzl3ZjJncENsK1pGb3gwdEdSWlgv?=
 =?utf-8?B?MjNIdkpuYkpvdFdLUVZJbHVzY2YrZXljWVQ4OVgrSHZudnNaQ2lhR2pZUXNT?=
 =?utf-8?B?eUNzQkZJcVAzUDRLRytaRzZ5VDZ4L1ZtVzdoQnZyakN6Q2h6VWYyZXkxN2Zo?=
 =?utf-8?B?NkhRQTFDR0grOEY5Wm16K0RhaTY1dm4xL1Zoc1FFS3crcW5HMlRDMGF3cllv?=
 =?utf-8?B?OXgwd0c0ZlRYeWYydHIzUlUrdDhkYTNBTlZHRGozU2RXS1FzYUkrMlpIUUpB?=
 =?utf-8?B?N0kxV21CTk96alJyWVB5UTBwOHBUMjZsMVNjZGJLWGZGa2lJZjFySDIrYkgr?=
 =?utf-8?B?VFdxZnpGLzgzYk1LOUhLdjZzbkFqa2IyQ1dKQUx6a243S0lYbXVjT2N5WmVO?=
 =?utf-8?B?UDI5dHBoMTBlbkJKakxDZUNFTjM4QzRFUFRCeU5qbkJPVnpFKzhUZTBhYk11?=
 =?utf-8?B?R0hyWEl3UnN2VDVCYURRZmpmakVRQ0JTd2tTMVFhZ2R2U1pTcUJRZkJhdVpj?=
 =?utf-8?B?bWNiTmRuVDR5MmV6SXM5UFNSYm9MZ0dyaUdJUnVXMWZxVWhweUd2d2hxazNG?=
 =?utf-8?B?RWRTUjM0c3VTYVJyeEl1MWlrdDBmL1FMSnRXZlI2UC9Nc1piL2hCWGwyaU12?=
 =?utf-8?B?Y1ZwVWJFRzJCRlJVMXhJTzlkVWxBMHo2a28zZWJheDFqb1h2MnFRL3dVZ0Fl?=
 =?utf-8?B?cHFCN1JsVTdlaVFkbDkra2cyVHlRT095ZmJabGphRm1zOVhiN2ErbTgraWZI?=
 =?utf-8?B?anFVa2tQWml6RHd5bnVMKy9TRkxucTd1ZUxoN0FrdllmMTFRSnM4a3dXdk5N?=
 =?utf-8?B?T3orSnhGY2sza2dPZE9RNTZ3KytuYzhia2l5RXdMNVdadmMwMlZoZysvRmtT?=
 =?utf-8?B?K1RlY3hlV2VjNXhrZC9vTXdTMGtpMDNnY3hVamFhazMzTzFZQ3ZJeFo1aU5K?=
 =?utf-8?B?WnAyZVRMR1k3MFFRZVdGSVY1VndTeURkWjQ4RGE4SjNHeHBWVVlYL1hyd3pS?=
 =?utf-8?B?Uzl1ODlOa0d0NERtUDEvL1Z3ZWhGMFpBMHBsSWt2QUxjQ1NBdWlKV1ZCcTFD?=
 =?utf-8?B?MTZmTE80MTBJK21IKzArYXQwcmJ4aTNVY21waW9EVjBQZnVnTGlNNUkzTjNR?=
 =?utf-8?B?d2p4a3RPbzlqY2FMTXRqTDdEUTlKd2ltUHM5MkFnL21IK24xemt4Q1kvd0M0?=
 =?utf-8?B?WDZZczRrN1o0SW96UFg3QjZFbGxkK1g4YlZGZytuZDdFcUp0ZHNjUTFhNTVT?=
 =?utf-8?B?aTBPV0x2YkdVK2U1MW11QStBbFRxVHhRZkpDalZPL3lNclNOUnRmdUVwQ25s?=
 =?utf-8?B?UTdUQW4wQlJIWGFkNFFtUzMzalhMQ21kVzVQY0hWd3BvalphNm5paUhCcDNl?=
 =?utf-8?B?RWloOXloQW5rRnEyK2ZWdG9VOXFQaUZ2bWJ3bFRlb2ltZ3hwdm41K3ltNTlw?=
 =?utf-8?B?Uzc1UW9LZjhDK3AvUEl6d0h3ZEdtT3JaZlo0MzJXWjdXQkl0SXcwc3VMcWFG?=
 =?utf-8?B?OUEyUGdkVW4vWGVYOW5lSEVSL1NDM1QyQ293V2FQWUdHYlhMSjZjamlpZzlz?=
 =?utf-8?B?LytiOGhPTDM2enAvV09WT1FZNGdydGtvTlFhenh3ZUZpY1krVVJVdmowaWVq?=
 =?utf-8?B?SUZhcEliVnRVQWs3aU0rc0pkVWtqQU9VUDU4Rk1MVngyV3JSaklMbjJJcnpG?=
 =?utf-8?B?N3dXeEt2SGM0Uy9waDgzTjdRN2lPZ3BxNk1GcW9GR2s1YVRMY1EvLzFqODdB?=
 =?utf-8?B?MmRmQWtQSVZyNWV6NXZoZkg1RnN5NzRDS3MwV2FZR0oyTW9CZjNlMUhqb0dO?=
 =?utf-8?B?TjF0MjkyYXhaelNuVmpheHdIbmNuVkNoclhHMEk3Z1JFV2dJbEkwUTVzenRG?=
 =?utf-8?B?SGFJdk5xVkU3ZmZmZVpMTWI3YlEyeW5ZZFdrUXYyVFJiL1BPWTBiSDI2QW9n?=
 =?utf-8?B?NTRhWURDa2kybHN4b3BzSUpvOWE1N1pqcmplREswdkpqcDBNZE52NFpxNkw5?=
 =?utf-8?B?UHNVL2VNVWYrYlR5bXZ2dWhSZ0s4UUxUNnJZQ3BTSHFuU1ozQjVvQkE0WVdm?=
 =?utf-8?Q?dC5g=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e5ee82-9540-4e7d-28a1-08dcf34e551f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 10:34:54.0376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3tkmOqnMXOjM+Xyx6z6wHa7nBGSsbgUjeA1nPr/SxTzZJ+b4IIURESIBJcQ9jsK8+YRiTj9wx+OrmWrYp/gyKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4918
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <D445FC009FD3454293B87A4A82B18709@namprd15.prod.outlook.com>
X-Proofpoint-GUID: nYJHiTaz64_JqD5_K5qnp2HM81h9XXrF
X-Proofpoint-ORIG-GUID: nYJHiTaz64_JqD5_K5qnp2HM81h9XXrF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

These look good to me. Thank you for your help

On 23/10/24 04:53, Zorro Lang wrote:
> >=20
> On Tue, Oct 15, 2024 at 04:39:34PM +0100, Mark Harmstone wrote:
>> Adds a test for a bug we encountered on Linux 6.4 on aarch64, where a
>> race could mean that csums weren't getting written to the log tree,
>> leading to corruption when it was replayed.
>>
>> The patches to detect log this tree corruption are in btrfs-progs 6.11.
>>
>> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
>> ---
>=20
> Sorry, more review points below. I can help to change these if you say "y=
es"
> to all :)
>=20
>> This is a genericized version of the test I originally proposed as
>> btrfs/333.
>>
>>   tests/generic/757     | 71 +++++++++++++++++++++++++++++++++++++++++++
>>   tests/generic/757.out |  2 ++
>>   2 files changed, 73 insertions(+)
>>   create mode 100755 tests/generic/757
>>   create mode 100644 tests/generic/757.out
>>
>> diff --git a/tests/generic/757 b/tests/generic/757
>> new file mode 100755
>> index 00000000..6ad3d01e
>> --- /dev/null
>> +++ b/tests/generic/757
>> @@ -0,0 +1,71 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# FS QA Test 757
>> +#
>> +# Test async dio with fsync to test a btrfs bug where a race meant that=
 csums
>> +# weren't getting written to the log tree, causing corruptions on remou=
nt.
>> +# This can be seen on subpage FSes on Linux 6.4.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick metadata log recoveryloop
>                                                        ^^^
>                                                        aio
>=20
>> +
>> +_fixed_by_kernel_commit e917ff56c8e7 \
>> +	"btrfs: determine synchronous writers from bio or writeback control"
>> +
>> +fio_config=3D$tmp.fio
>> +
>> +. ./common/dmlogwrites
>> +
>> +_require_scratch
>> +_require_log_writes
>> +
>> +cat >$fio_config <<EOF
>> +[global]
>> +iodepth=3D128
>> +direct=3D1
>> +ioengine=3Dlibaio
>=20
> _require_aiodio ?
>=20
>> +rw=3Drandwrite
>> +runtime=3D1s
>> +[job0]
>> +rw=3Drandwrite
>> +filename=3D$SCRATCH_MNT/file
>> +size=3D1g
>> +fdatasync=3D1
>> +EOF
>> +
>> +_require_fio $fio_config
>> +
>> +cat $fio_config >> $seqres.full
>> +
>> +_log_writes_init $SCRATCH_DEV
>> +_log_writes_mkfs >> $seqres.full 2>&1
>> +_log_writes_mark mkfs
>> +
>> +_log_writes_mount
>> +
>> +$FIO_PROG $fio_config > /dev/null 2>&1
>=20
> Don't you care the output of fio running anymore? Maybe use > $seqres.ful=
l ?
>=20
> And just make sure, do you want to ignore failures of fio, as you do "2>&=
1"?
>=20
> Thanks,
> Zorro
>=20
>> +_log_writes_unmount
>> +
>> +_log_writes_remove
>> +
>> +prev=3D$(_log_writes_mark_to_entry_number mkfs)
>> +[ -z "$prev" ] && _fail "failed to locate entry mark 'mkfs'"
>> +cur=3D$(_log_writes_find_next_fua $prev)
>> +[ -z "$cur" ] && _fail "failed to locate next FUA write"
>> +
>> +while [ ! -z "$cur" ]; do
>> +	_log_writes_replay_log_range $cur $SCRATCH_DEV >> $seqres.full
>> +
>> +	_check_scratch_fs
>> +
>> +	prev=3D$cur
>> +	cur=3D$(_log_writes_find_next_fua $(($cur + 1)))
>> +	[ -z "$cur" ] && break
>> +done
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/generic/757.out b/tests/generic/757.out
>> new file mode 100644
>> index 00000000..dfbc8094
>> --- /dev/null
>> +++ b/tests/generic/757.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 757
>> +Silence is golden
>> --=20
>> 2.44.2
>>
>>
>=20


