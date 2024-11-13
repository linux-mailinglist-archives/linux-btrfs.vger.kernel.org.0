Return-Path: <linux-btrfs+bounces-9588-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96DB9C6CCE
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 11:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A979128C5A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 10:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D4A1FC7E7;
	Wed, 13 Nov 2024 10:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="RLDv/tYU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B902E1FBF67
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 10:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731493478; cv=fail; b=hgHy75aNp6RLp8Y/24fjq7eGdbNyXkT82cXcbtnbRu06c5ixTIBMnT6CQAA4RkJ1gI7KEzrtDA6BCamLVuMi+o65KEKmjeoYgMe1XdU3H/20Q5PV2LDy0JFYV0D83fKI2JQoyHfHg921kskDgcUI7GVZWPZJW2bRQalZjT5GDjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731493478; c=relaxed/simple;
	bh=+E72Qw1ZztljnDmx++pFrfrDJuInBjuLqFOJzVY/89Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Y2Gy+m8TlT91r+jAP0I7gc6QvA016nAs5q1szAVNjIL/WMHMg89jQwchSQnCBCHxds0tzU3IA0EnKXC4QbTn1B0LNuDA0fqgilpAD+u9dELhFgRS8OkYEF+WJER2SEgOg5WON5gqQ0xhZL/XHJQeAyA4X450jiBG2MAEDGtL0nY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=RLDv/tYU; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD4lNU0021448
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 02:24:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=UDFXuvJswIP2wN4bIEXSBVdbc1sANm9p3gETE7pM6RQ=; b=
	RLDv/tYUCRGbjKjabWWc2oz92fK9czI9kQ0ZQdgKwGNr/UOwtc4dwT4n6uZmBN6T
	Yhl8j836rE5VOa2nbkOxLC7aPqmxvNrOCk2Ij2uygh3QpdZUsiyg3hlBO7Rws/v+
	UUs3t0TRFGoaPJcjT6we9vzzcTX2wSJTSCB1bnqWcr88bNWeh8J957AyU9+Kypxy
	GLgHCL6KLkhK8HGeA4+vnnsadOfmYgoPNplFmN9mIppF7BzjT+nP+ipAOXFDZ1a4
	Bo8NzuYFQ8fcuxAIYjIVHqDXhdXj+qfyvTEVum33w1G1eRkefqk40MgG9RyZXDvW
	aNTlM/Io2u1Pv8w/MV0SQw==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42vgyfaudy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 02:24:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G43MsJAi/BvqjNur/QO/4wt961zwVcVdfX3J/WjuhbP1BoJ7ZE+MifdyIwsdbQauRsHKXKr+5UohkrxSS5Kn43i/+YGNBNNYQ3fZFWTOMyVcX4JVTKtPSvUyukC4hg/TViQVvmqkIrRYya1C9AxeF/vTMjQW4rM04smmgI1tvSudeqji+nMcCVyN4ygY0x5NupdPNy7PiPi3YpQkzuyNTANcy6cLOBDJJq989zMxal3AExoq4xSyHmzZjD0zK5Kw7POrCwYZTm4GBNcKWWlBjfvAlZoPlfbCyMXHqIhIjN87BIUCn31/ZC9yiMTqKnhDQY1TBKhIqOkChfjr9so3vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJO5Gw63uahrBivggrE+wifdGAoh7TqhBAck+o1pdBE=;
 b=wo1/mNFLvVNb2rJ5GFJOPbP8fXMNqLeybe6Iht3fMRMBOYdlvLbHxfjgDU0MW9Vok9rKE68jIytpnphSysjJ8Ift2jsonjfjlRlHVWnQ1WXkF6wDL9cqkj7oh45KtubVU9UQrUtMvPEjTViLUvKsVORwd9mdfwvejA/28CUprciY+jWZA7/CFppVs7MwFMiUvBLbsufLkgb6m+n9XPjiPYR2JcJ7MSQtIMLLBoTzjbqA/L9m4i5SmRzPTuC37tXS0sYNDcbCmUrozbbwB4BhoGsMq9Vml6VsQQhCH/87zx46jWUM/A1bYqQ9i4mxPZbF4S0dVwqg7i5sy1hPlFSQWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by SJ2PR15MB5835.namprd15.prod.outlook.com (2603:10b6:a03:4f4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 10:24:32 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 10:24:31 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Mark Harmstone
	<maharmstone@meta.com>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix lockdep warnings on io_uring encoded reads
Thread-Topic: [PATCH] btrfs: fix lockdep warnings on io_uring encoded reads
Thread-Index: AQHbNRwWDaKzGcsc4kWOxTgKfQv67LK03+sAgAAiUIA=
Date: Wed, 13 Nov 2024 10:24:31 +0000
Message-ID: <1b224872-bd05-400e-95fd-2c54e3b5fd1d@meta.com>
References: <20241112160055.1829361-1-maharmstone@fb.com>
 <1c919f94-83c4-421c-8ad0-e0c8da305cff@wdc.com>
In-Reply-To: <1c919f94-83c4-421c-8ad0-e0c8da305cff@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|SJ2PR15MB5835:EE_
x-ms-office365-filtering-correlation-id: 94fa915a-d5ee-4b7e-8320-08dd03cd5ce0
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bGtsaDNmcVZGanU5ZWxaVWlpVWhXdDdXSGtRbjVTL0FlT3FKNVEvQklzOTRB?=
 =?utf-8?B?Wmxqdk1PSmRITkQ3dWZzWTB6SitkMW5JOFdqSEtBcjBhcTFHZWtmSTV3WXJ6?=
 =?utf-8?B?bUY4aVBGalRGcENteUN4ZVRFdXNOcHpoNExNRUYrZWpsRmc5Wm9pbzYwQ09R?=
 =?utf-8?B?b2xpV3JnblhVWnNzaU4rRHdpOTNUT2IzVTQ3b2xEaFhxdlBoN2UxRFRPRGF3?=
 =?utf-8?B?ZFMydlZTOUU1YjJyN3oyckdOV0xoZWdOZThBdmx1VVNHYkV4aG1xWVF3RjFW?=
 =?utf-8?B?bVlFVTR2dmxaSVJsdnl6WlZxV0xXNElaSkJzbzFWTkdmRlRIMFVFcTEzc2Zk?=
 =?utf-8?B?Q3hHc0ZTOTh5S1NlVS9vOWtHMXlMQjhseXI5dWdoMk1lZmN0dEVWZUQ3QkxY?=
 =?utf-8?B?ampjWDNyNXJUWFM4dStwUkNxcU5DTnlFSHRMTWRtWEtKenZBNWVlVEtjWVhO?=
 =?utf-8?B?Ymh0Z0xyZjlRRHRjVHdjdzFCSjF2WDN4a3oyNlF1amVldEFIOXVFR0VCOThJ?=
 =?utf-8?B?UXFDSml3MjlRNnZ2VGVhM3lWT2lWZjR5YnEvTWx1bUNKZXRDSUJSN1ZGRmdx?=
 =?utf-8?B?Ry9iZnk1aWhJRlBMSisrTFU3NlVEVnd4R1NydGs5S1o4eUVPQTVhdmc3ZW9X?=
 =?utf-8?B?M2svYitGNnlHZk8vNUlZYWNaaklDN0U2WUJ6dUhpbmM4YTkwb0hTSDlxbCtJ?=
 =?utf-8?B?MGdaMk9lbGhseExjaCt6U2VTTWR1MzNlU0xYbWZtRUlpd2VXQkFRMWN3NmM3?=
 =?utf-8?B?Y2RwRm1HNFpwcFNFMEs5UmptTjVEMWt4bTY0Z01nS0w5K0lkUXZUZVY5SkdJ?=
 =?utf-8?B?UDFjaTNPVklDN29hU0E3dldGRm1aMTRKd0N2ZVYvVWYraWVEZWo1U0MxLzY4?=
 =?utf-8?B?VFZ5NjZhZjk4S3lDY0MrcHVzSnN6ZURwQjN2ci9vaGNWY1Y0ZkpZbWVMQjAx?=
 =?utf-8?B?bnpML0JKeFIwNndraVg2WG5pYnlOYkszSWdMeXUwaEZZN3lvVUhseFNPclU0?=
 =?utf-8?B?S1NDMGJpaHBGbFZjY1VLMTBhTkhGVHNSdVdKdk1UaUFFWi81a3VoS0tqdmJD?=
 =?utf-8?B?SVcvWVN3aDhzVnBmTEhLeVd4NitrM0pObzczdjg4TFVqTWdKZmlkV1VwN3hw?=
 =?utf-8?B?NFlBQnA3RlpiYkJSTUNZU0dBMUc4bUxHNjg0eUlNbkZWWU1KSkQwdkNGaDYw?=
 =?utf-8?B?MmZPNzE1MlEvVE05UlNzNVFIc2ViLzJpS2pNRVNCZVpMTlNzcGFrMFJ2VEY2?=
 =?utf-8?B?OEx4U290bDhheDlXbUt4SyttTEFvblI1SWs1T3JsblFjNWZ0K0ZCMUcxeXph?=
 =?utf-8?B?OWwzS0Y5YXk1bi9RdGxsR0hDRkpRYWI5VTlsTjN3VFNITFl5SzRUL0E1ck9r?=
 =?utf-8?B?aXI0b3E4QW5ZRkxDcGMxQlkwWEtXdXFCSzE2UFZoY2E0OUs3TGc2d3VDUmlo?=
 =?utf-8?B?L0REa0RBV1VVVFhVdS9wYWt4dmk4VUZ5KzM0ZDZ1Sy9yRmsrdm5nUXJhQnBR?=
 =?utf-8?B?cnFjWXhZY09OaVBYVlp1ZnNoOHJKdGNqWkw1UW0rUSs3bmJzWUV3OWVHZC9r?=
 =?utf-8?B?cGwxLzh2WW1MVWhyNjFJbnNZWmFTUkZnYzBIcDdWTU01d3VUWmo4K3I1VENn?=
 =?utf-8?B?QVFyL0xwQ3ovS1dMbTJtbUdjT3Bpc3BRTkRQUmdEL0xjZWhXLy9TMkJaODBR?=
 =?utf-8?B?eCtTYmpLcnBGd0hucEJXVUt1ekxXbTkvdnMvSHpYc1FaRVJjZUxYTUx3Q2lh?=
 =?utf-8?B?VXVnTDYxNjY5dFN5cXNUS2RSYXJHTmppdHJucnV6cE9MOXcxd3AvZTZ3NVhX?=
 =?utf-8?Q?k7x8Mic6aNPGcgIo4f1ZwznuCUYGxD9MTGyfs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K1d0SXZKT0orWXlXME9NT2FHVmpjMHVQSzdwNFVqUGtNNTFLQkdQdjEyNExo?=
 =?utf-8?B?ajh5SGMrTUlWenAxVzF5aHUzNU5WdTlDT0FPSHNRUnRXaFlURUxqWnZFb1Vy?=
 =?utf-8?B?SzdxcVNIUGIyZVV3V1hPd0dITnJCWEVyejVtYmF2ODZjdUNnV1VTeHliTU1H?=
 =?utf-8?B?QytCckF5VkJhVXg1L3dhVlFQY2hpK1l4ejNpYjcyaUpQVE81VG5rWlptVjF0?=
 =?utf-8?B?K2FIbENFVG92SFpjKzlKcnNhcmQ4WGlFTUUwZHhwR2Nvb3ZCYjNBTHJKN2RJ?=
 =?utf-8?B?Nk9JWTIvSjVyclhwMDg3em90cXF5NmdYTjFLaTlsUlpnNkUwUlBkWU5kY0w1?=
 =?utf-8?B?TFFMeTdRVjhpdnlhRlJ2T3U0MGRKV0Fsck5xOTN6R2tXR0ZBZnJkSUhEaVRG?=
 =?utf-8?B?RUNPWWU1NGZzQVJXWEZnS04xZlRuRlhjZUpjc0V6RjdTUXRjaWovNGM5ZmFZ?=
 =?utf-8?B?Nm9WZHJtZUYvTmVtZ0NIY0hGOEp3QzZQTFR3NFNtVHVwKzE1d0pLd3FhV0Fj?=
 =?utf-8?B?M2FGaExHbStuK1lNU1ZKcnhYY2dBczFTelJadmxZcDdmMEVTcjNWZEFTUVdt?=
 =?utf-8?B?LzFTVlplbFBzbm9WOFFSeVF2b1JoNW9mM24zSGNlMFFxektTVUVPOWVCWnJW?=
 =?utf-8?B?Z0FtbldVZnk0SnYzcGExMlA0aS90UkQ5WlVOeHNsT3lYc1NrRyt6L2NIem85?=
 =?utf-8?B?QlIzS0VqZUFOTVVNZS9rRmt2ZkFTREdFNExVMmV6TGUyUHMvSFVwSmNzU0lD?=
 =?utf-8?B?WE9iL3pyRi8xc3k0ejBhdU9TY3RKU2Q3V2h5OWZQeElnMXVpbWtGRTFjTVcx?=
 =?utf-8?B?ODlwcW9sSEZFOW81bllFeUE5ZWd5K3hhY2ZvMjhBWUlSMk9xcDNvVVlWaGY1?=
 =?utf-8?B?TXRjZEtpdWsrdGNMdmt1Q0xXTzd4aW0xd1pFQzhFQlFGdWY1STlKRVlCZnF3?=
 =?utf-8?B?ejV3OGtYaXd2U2hRaXBqUWhIOHVVY0daYUFtYUo1RUhyZVBsMWVPNUErNUtW?=
 =?utf-8?B?Q2RPRnA4cWFtd1BqRE1SYnVGNUVJbXh3bTdDV3lITWJJYXZxTTd5TzNxZkZL?=
 =?utf-8?B?M2xVNzdmaHhLVE4rNmlCbUxKVTJsVVVkT1FWTTE4aTNHMm9UMVQwMHIrQndh?=
 =?utf-8?B?N2cwM3VWWHd2TUJIZ2x0cWRjSXUyWmhTSlFyck1xY01XdmZXTlpYMW11VmdJ?=
 =?utf-8?B?SnkxMnJBM05hY2NCMzlpUHltUUhSbHUySDVZSmlqcWVleEYwZllZc0JKSGNG?=
 =?utf-8?B?RmNORlhDUXJGbEF2cDI4bUFMNWJ2RkNJTjloQ3p0amE3MUZiVXVOTHhhcjFx?=
 =?utf-8?B?M1FqM3NQakFaYVlkNDdrZWJEcFI3NGpSdWVwNFZuTmlFcnpzOTdzK0xONFN6?=
 =?utf-8?B?bzhsTTdhcmhNT3Fja1pmYUdkTUFiMW9jQWJ3eTljZ1c3WlBBV3ozUEhrME0z?=
 =?utf-8?B?ZmhMRlA2MXZYRG03c3JMdm16UmprUjVaLzk5MUkralRzKzdFQkIrTnRxS2I4?=
 =?utf-8?B?aERJdm5jUGpDT3dEK2FQd2tiQm9tZGVQRTZnYmFmRDFySU5kb0p0SFJqSjJH?=
 =?utf-8?B?eXA4SGMrUTFkMUgvenZvNUdEa1ZaRXlBUk9vclJ6cWtFQkxvUHBtTUw3d2N4?=
 =?utf-8?B?eDBzdzlnWHpVc3J4UzlkTW8rclJNZ0dMOGJqL292MG9wMkZoS2JLeXoyVjd4?=
 =?utf-8?B?Y0xlNHUreXpKT0hqYnFOcmlQUjVZdVBMUk1WM2FJc3owWG1ZTmYyeThpazRq?=
 =?utf-8?B?a3k5a1NRU3QzYjZWbzBublJVeDc0Ymg5eXVkV2Y2aXc1TVdhRFgvek5Yakxn?=
 =?utf-8?B?ZFZRb05zZnVYU1dSRjd2K0pQR1NpNUROOWdHRExWaS9DZHV5QjRTdU1lLzZE?=
 =?utf-8?B?QWo5TzA4NFZNMWZLK3E0RTBlaG5yUWJnbTAyVUtiSk0yeWEzUG9XdDFtQWJ6?=
 =?utf-8?B?VEEyaDNuVEswR3ZhaEFRbEoybG9paG9aTFBaaDFwb3hsMEs2N0ZaZU5WZlBM?=
 =?utf-8?B?MzllQ0NNQ0lmOEJIUWtva2JIZUFMUVB0eUlFYkR1RS9qUVNEQU9QcWVxSFVw?=
 =?utf-8?B?Q0VVSEhLbjN5NnNDZnVOWTZiaXp5b2ZiVGhGaVlpZERvZk83NW1hY01IZXdG?=
 =?utf-8?B?OFNrMXBGQ3pNUzJCa0s2bkl4ZE1QT2J6ZExmNmMxMTUwMWR0eXRCQ1NXR1ZH?=
 =?utf-8?Q?+Q7JXZlF+MogEqnb6qX3j64=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fa915a-d5ee-4b7e-8320-08dd03cd5ce0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 10:24:31.7720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wDcV6sBn8ESEDl72efAUarfvuqPWfua64vvhySYltRKLckEzyt2yJEHYcr0xyMYAiPeJIgxxKiIVmRMp7yMTCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB5835
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <88B2551633637747A83904673CE21143@namprd15.prod.outlook.com>
X-Proofpoint-ORIG-GUID: tbxhMGxqmqopkwOpl05gMFj1ZHlisEaB
X-Proofpoint-GUID: tbxhMGxqmqopkwOpl05gMFj1ZHlisEaB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

On 13/11/24 08:21, Johannes Thumshirn wrote:
> >=20
> On 12.11.24 17:01, Mark Harmstone wrote:
>> Lockdep doesn't like the fact that btrfs_uring_read_extent() returns to
>> userspace still holding the inode lock, even though we release it once
>> the I/O finishes. Add calls to rwsem_release() and rwsem_acquire_read() =
to
>> work round this.
>>
>> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
>> Reported-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>> ---
>>    fs/btrfs/ioctl.c | 14 ++++++++++++++
>>    1 file changed, 14 insertions(+)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 1fdeb216bf6c..6ea01e4f940e 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -4752,6 +4752,11 @@ static void btrfs_uring_read_finished(struct io_u=
ring_cmd *cmd, unsigned int iss
>>    	size_t page_offset;
>>    	ssize_t ret;
>>   =20
>> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
>> +	/* The inode lock has already been acquired in btrfs_uring_read_extent=
.  */
>> +	rwsem_acquire_read(&inode->vfs_inode.i_rwsem.dep_map, 0, 0, _THIS_IP_);
>> +#endif
>> +
>>    	if (priv->err) {
>>    		ret =3D priv->err;
>>    		goto out;
>> @@ -4860,6 +4865,15 @@ static int btrfs_uring_read_extent(struct kiocb *=
iocb, struct iov_iter *iter,
>>    	 * and inode and freeing the allocations.
>>    	 */
>>   =20
>> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
>> +	/*
>> +	 * We're returning to userspace with the inode lock held, and that's
>> +	 * okay - it'll get unlocked in a kthread.  Call rwsem_release to
>> +	 * avoid confusing lockdep.
>> +	 */
>> +	rwsem_release(&inode->vfs_inode.i_rwsem.dep_map, _THIS_IP_);
>> +#endif
>> +
>>    	return -EIOCBQUEUED;
>>   =20
>>    out_fail:
>=20
> Can't say anything about the correctness (as I have no clue), but we
> have wrappers around rwsem_release (btrfs_lockdep_release()) and
> rwsem_acquire_read (btrfs_lockdep_acquire()) that I think serve the
> documentation purpose.

btrfs_lockdep_acquire(a,b) calls rwsem_acquire_read on &a->b_map, so=20
can't be used for something located at &inode->vfs_inode.i_rwsem.dep_map.

Mark

