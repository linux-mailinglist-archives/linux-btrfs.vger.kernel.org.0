Return-Path: <linux-btrfs+bounces-7130-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E4194EFC7
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 16:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5351C2204B
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 14:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB211836E2;
	Mon, 12 Aug 2024 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="hX1M+LYV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0F118132A
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473601; cv=fail; b=Qne3Vg3CxpH4Kd6qAyRWreqR4QlPxXalON1lRQlWpwYA7doEI3GLu1oF6FPsslOjFMKY5zuEpb0dBiE1vlxCKD80Mwo5sYPkTbU2TwbegCHd0JK7esBZ3iQGjr3tHIB7xOtqrTY5BfvGCSizWZpZxBngZ4uXPW+4dYF7b6tRPP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473601; c=relaxed/simple;
	bh=iKZ6hLu8fKDHv+hQ721cIchv/RhrLCbZUvbnduXuxWo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uehl1ZeKL5oXbqrrunrdPAbf91g10+tfviBVgXvWVBazlKdGKaJdsuhlr9lqRKyY3cme9qeDs7XEJkuEjQ0knhKKTMfeKSU/kXFGIxA6uUQkG5+sOPeFi8cPSKoG3LLT5e/5BWqkay5VFRcHrvYVTjRz6rkNEqpc5KHDXZJxTOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=hX1M+LYV; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CE3f7k028539
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 07:39:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=s2048-2021-q4; bh=iKZ6hLu8fKDHv+hQ721cIchv/RhrLCbZUvbnduXuxWo
	=; b=hX1M+LYVdUPEYQb0tX7MqiCSXKxwQI4G/CW+IEb3GmTMi7+qrU3eN3uMZir
	+wQuipkRQrXSvuqR2iYmnaqjMVLEvgJ1JGs6rcpyerWTVfnelqarf4p+bqQhHxiz
	KgcQfM0EWkdhjZRvg/SMI6Wr0eGECSLMZGOfD8OFr0NUCkMaCZMI6W+hugkTrVP/
	9/86Eh+t4nYFsg6aUfKUs3SptcP6nin2icxQFrNshK+Dm9L/0vZ1sazC6nrSVEev
	W72Xw8pBOW9KOx4WyfZvUkI2vzXDTuAwViJbSz2Bi6AVPbrxRO1OJjxii+QXjudh
	YX8IAfWxXEbHrZuRcNrirEVS9Lw==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40ycedjppq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 07:39:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ai8xNJDS9HijCc3SKRrYOpTwAetkGMkX+fJRwOHfM2XkODalKa4Gz7zBR3RoJpKRdoQe2bamqdmRZFVxTDdE+hGx4lsJWb6yq48SelSW2toSefJh2Z/WvTnNnNI0FqSUhgSt55wQ/E4NwtA1RGFNut5/QAQcF9EZqiq/bZpYT9hlLgz97wxydEh1UGSg7hWKv1g5PRHLl1jqQ5U77EWT7TzRIJ4SSV/9L3uNSiH51FCH0WYrx0NTudYjlxDQ7e6eL1r+14QWv195xBn/GQgHJu8/6nxUoL+7eMqCaP/hks1dWMNGJ+qV2pRZXpL2gUlKWgwJgVNKj4S1qK3Fx8o7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKZ6hLu8fKDHv+hQ721cIchv/RhrLCbZUvbnduXuxWo=;
 b=HB3Zb6XisakMAgti8RXdW2eP+QNMDHv2ComzOgxK48Zq1WC+9ONzBKkS6jQ8LwMTgQ2KFDVjc6MU13AtyWVG1C7Y3C8bO5I3DUzBChRrwnFtgGS/IGNL2LK7Ed1wtaC2Xyc89ZulFLXQYID5K9tx7NvxXGFylEMk6Ws6YELq0NPUnGP9/ld+XmkeMuIF6rzFiVt3DNYwLaE/QZabzAU3do9ZRUo2OM+Sd2BSCFZLTF4TuRNFh6FKI9jS1p0XsiPvv/BbVZNQtsMcLqAtp/RhQpt3ZlKkIC4PLdOztxKCwDRUD1zXuM29Tbn63USBWao6KmypOQSq4HZE+D44Eubo8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by MW5PR15MB5220.namprd15.prod.outlook.com (2603:10b6:303:1a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 14:39:50 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%2]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 14:39:50 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: "kreijack@inwind.it" <kreijack@inwind.it>,
        Qu Wenruo
	<quwenruo.btrfs@gmx.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v5] btrfs-progs: add --subvol option to mkfs.btrfs
Thread-Topic: [PATCH v5] btrfs-progs: add --subvol option to mkfs.btrfs
Thread-Index: AQHa6bbd868+Clc3dEqLqcexqyie8rIfUfQAgADw0gCAANZegIACbNeAgAAxjoA=
Date: Mon, 12 Aug 2024 14:39:50 +0000
Message-ID: <7b3eb035-7537-49db-b8f0-7d67736e2f03@meta.com>
References: <20240808171721.370556-1-maharmstone@fb.com>
 <20240809193112.GD25962@twin.jikos.cz>
 <f9492406-1fc4-4801-a74d-890353a34e3e@libero.it>
 <df13dc7a-88d5-4769-b028-3c5c28c29698@gmx.com>
 <1af5c6be-27ff-4dd5-ba5e-9213bd1e9f68@inwind.it>
In-Reply-To: <1af5c6be-27ff-4dd5-ba5e-9213bd1e9f68@inwind.it>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|MW5PR15MB5220:EE_
x-ms-office365-filtering-correlation-id: a460515b-0e4e-444e-d5b0-08dcbadc9ef0
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q1FtTDhyczNndE84VkpQdGZsdkU3NTlJb09SRG1vNzFmdjA4M0pjUmxvb29m?=
 =?utf-8?B?MExhZXl6KzRrQitKb2FxZU90a1hEZ3VFTFNDSkp6QWlkaXNmNENWeVhvWlYy?=
 =?utf-8?B?YURqKzBMdmFGZHhIUU1wZVZBNlBOUlhZWElhQnNQejFaQ3JldDdtZ3hZU0N3?=
 =?utf-8?B?YlFtcjB1Ym1ZMXY2cldMUFQ2MlBJKzIvTUErZVdTMEZNU2xxZWVFc01CTlRT?=
 =?utf-8?B?L0Rod1VhSmRBa29qdmVya3QzeTN1alFxWGliaE9TV0NPOVFrTzJlelBmTFkr?=
 =?utf-8?B?RjNwZG0yYnIwUFU1NklJdU5hZExadzJKVzB0Mm1JbnNZYS9ZNzFSZlZUM21u?=
 =?utf-8?B?NEJWM2dzaGtDdkcrUnFTYU52YmhoaHBuQnRCQ3ZwdXhoK2EwVkx1L0FxME1T?=
 =?utf-8?B?Nk91aFUzZXZRRSsrWlBBbzZScmF1TkxsR0RQeXVhZkhmQzZRbUFjMVowWWZl?=
 =?utf-8?B?R1htWmZnZEo3b0xYb2pyb1B0OEt0YWllOTVWbVlMeVh2cDQ3Tmt3b09KbHNi?=
 =?utf-8?B?cHJDZzdPVGQ0bWJhdll5RGtDeXRhWjROY3F2Ny8wWHorY3JtQ3NaK1dKdXBa?=
 =?utf-8?B?MFRIakRMREFpeW5GU3p4dXFEb1YzSUhiazdmd1dROHJyVWZhMm84aTczSkp5?=
 =?utf-8?B?ZmpBVWdzc3UxMFRYUTJ4S1RFS09xNnJ5QU5FbXBYTm03emhyMGRpYzM4RDhJ?=
 =?utf-8?B?MEdqNURhRjhRcHVuVkgzb1BOdzhZY0FjN0VZNC9nWVZHVGp3OTNPV1c2U3RW?=
 =?utf-8?B?WG42MDBDaVg2cnhEUS8zM2tZVDIraEYvdG1uZndIVzduNFUrOFBNNDB5QmZp?=
 =?utf-8?B?Q1NHUnpJYy9OaUZBV0hkZVJVSkdGQVBqeVIwZzVUdFNGc0VWRmhhL21Pcmdw?=
 =?utf-8?B?eFFIMEZhQWpoRmZYZ3l3M2psTWFXeEZ4d1A5NVpzVnRwOTBVUFhYWWl1TDZv?=
 =?utf-8?B?eVFZbnhTYW5HUVdFTWZ0cFM4MFZQSlVxbkRySitpRFNjNGcyVTVKRDEvU2Zv?=
 =?utf-8?B?VGUzTUhzd0NBbThjOHRsN1VBM2RKSUUyUjdGZWE2SGxHK29QcVAzV3pHM0JE?=
 =?utf-8?B?UE43Q3lOVk4vUldNWWhsVHhOc2ZSRDVQZWRxaWpwLzJabU55WUtCcGJNYnAx?=
 =?utf-8?B?Q3U5aTJUWDQ3b3l5V1k1b3dhTlBGL1lyL3hmcmlUbjVFWTlSS0k5LzVqeTBW?=
 =?utf-8?B?NHd6Z0R4UjlPVHJ5QUkrdHNxeEd6Z0ZsN0RvOFFGc1dINXhWSVFOL29ReEox?=
 =?utf-8?B?dVNEbnJ5QllVMjVQR0U2cHZ5bUVBWjZ5bUwvS1BnZXZVRWZNOTQ2ZEVvVVd0?=
 =?utf-8?B?OUdpYWhxTFcwMS9xekRFaCtyMU94dklKV25xcUc2WjVhWENSZUlXS1pqdG95?=
 =?utf-8?B?dkVjWVVzY0h6eG5tc3JhQ3MzTDI2aGxrdDJjSllBbTVIeGdES2U3VkFXUnpY?=
 =?utf-8?B?TEdCOEJkOGloZGIzeTA5RytxVTRlSjd5dGxIZmZ3enRSSjRnVHRNdElqL1VD?=
 =?utf-8?B?YjJLbzJhYytleEthcEZTcVI3Qk5Xb0lxNnY2UnB4OXFEaFZDWlZsOG1qYUpZ?=
 =?utf-8?B?cERvcFV2NVh5RWdSQ1ZuVThwaWprMktZRTd3aE41TGNZdXM5dGVIY09wVzZ3?=
 =?utf-8?B?dmROOU1KUUhBWEsvY2czd2UwajFIeXNHcUp4N2lwcnB0bkNmRFVBU0laTWIw?=
 =?utf-8?B?aVlQbnhvbDVPdnluOUFGN1pmWHlYUFc3SnN0aVVzNEdMOE8wZ1BwS2FaeVJ0?=
 =?utf-8?B?ZFI0dlNidHhyTnBtekQ4NlFxU2VJbS9paE5sdUo1WU1GU3VpcnJNUnR4WDE1?=
 =?utf-8?B?M1JYMjQzRFR5MEUrRkY2bzIzT1B0NDV4bkt2OHVtN2RiS3pLaWRXbkUyMnd3?=
 =?utf-8?B?ZGlpSUNhRW9wU2lPaE9ocmZIbkMyL3lJOVR2MkhQZmxOc0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cCt1VmdnZ2FQQlkveit5alVRYjNaaVA5ODZqaGRabTFWc0JCWDFpWXd1Z29T?=
 =?utf-8?B?RnZ5QS84dGpEWlBpdFAwMXM1RTVaM2tsNGg4aTkzQ3BwYnFMQ1hEMmcvelk2?=
 =?utf-8?B?UXVlZVRkV2tuZER1UTNJdnM2emlsVHN5cVlMMW1JTXF2NzlnampKU05TcjRr?=
 =?utf-8?B?VE4xUXhFdStjMlpJdnNuWVF3bWZMMVpFV0xkZ2VvTXFsR0hBdFQxSTJhNjV6?=
 =?utf-8?B?czlTWVk5S2FWRkxqbFkwaDNEbGcvVTdDS3BYUTI1dkVyK3lVWXo3MFMyTHE3?=
 =?utf-8?B?S3lWcnRVR3RYaXBYZjlneUd4ZTE0REpGdWpRUklydUUvd25CbExaekwxWUo5?=
 =?utf-8?B?cjlEZmE2QnJyZTNETlFwbDRxL1pUVjhxT21rczVESkdQRmhDbGRrc0VwL2Jk?=
 =?utf-8?B?YkJpcjFCVEtuRkE3UEx6ZVRMVEF3eHJKNUxyNDdiQm92WFp1QWREMHlIUWVC?=
 =?utf-8?B?bWtlSnJNQ28reW9SOUtTV3NHVzBOZmlwUnhnb2syQ01Zbmp6dWNrclM2TzR0?=
 =?utf-8?B?RUM2OVB6M0lvZHNiR1FHa2VrN3NtK2ltc3N6dVBxci8yT3BkZlFPOFNHU2xY?=
 =?utf-8?B?Z1N3K2dtaVg0WTIzbXpveGl5OTlMQTl3VmtNbXEydTFTK2JEcjZNREZJTG1N?=
 =?utf-8?B?M3F0RjVTRWZldmVnTitvV0lvc09LRG1nUnVBUFBsQVByZlQ4VGF2elU4dW5p?=
 =?utf-8?B?Y0VBdGlHNTU3WmJsZ2QyUDVUMitEalpkY3hLNFRNVzY2aFNKNmZKVDVuNHhy?=
 =?utf-8?B?eHV3RC90OVJBREtMR1JCYXpxTkpBb2MwVEMrKzROUm50dms0YW5aaXJBaisv?=
 =?utf-8?B?N1ZHT0M1YSttMWRVQUdsRWV4a1J6OVZwbVVSTnJsN2FLNWtNbW15REluZUM0?=
 =?utf-8?B?YnFWUGhrMFZ0b21kM0xZNmhxSExoY0sxOUpncGZ5YytzSHdtcEhiKzc1c1Iv?=
 =?utf-8?B?TWFUb05HVU85NFd5REV2NFk3MWVwbFFySW05djFzVnMyTUxpb1piYkpkQ2ZE?=
 =?utf-8?B?TllFaEErQU5FUzhXaEQ5akxuRHpnN0RFVndnY0dkcmJiR1RwSDVlUUdwbjVo?=
 =?utf-8?B?T01JNzRPSlJjS0x4dmpzd3VUdzBUUk9wRG56eDNta0Fiem5jR2Q2NmV0aGtv?=
 =?utf-8?B?ZnkvNGFubDEwY3VhTHM1aHJ6YUlkZ0NJVWZKMStuaFhUai9mdlZCSE81R3cx?=
 =?utf-8?B?MWhlMkluRWhqcDZ0K0RqY0JRK0d3d0JUY2VQbmJnRlhOeXlYZi9oalJtK1BP?=
 =?utf-8?B?NXN5Q21HbElmajhDUFNJeDFyUUtZTzczL3JrRm05eXpuYVdkVW41a2VPU1dT?=
 =?utf-8?B?S3U0QjMzOGNvd204SUVSWG9RN0VzQ3M0ekpaTEpYajZOdFVUekxJZVEyZm4y?=
 =?utf-8?B?eThOYmpOVHRRZXYrcXY3b1NTNW82SXJFb1FEdTIveC9MdlZTcFExMEl5RFdN?=
 =?utf-8?B?NzI4M3FycnJwRXBOb0kwSlEzQ29VbjloaW9INlNxamp5c05RWFFsaTlIYmVP?=
 =?utf-8?B?ckN4QllHY3ZHekxwQTRndmVseFZ1OVRnWm5SczI1V0lua1RkM1l2QmlyZDRj?=
 =?utf-8?B?KzRqSEtLTzRnVkwzQWRRbXp0bDB5NDBhOWhiYmNTaldYYVlGeHBhRjRIUWRs?=
 =?utf-8?B?ZWg4VGZXTmUxekUyeEsxVVFjSitseVVqdmx6amJmQlozZ0ZQZjhlNFpqU3Z5?=
 =?utf-8?B?NEtTMURtT1pJQnpRQzRIckdNZlVCNG9WUEZqdlJnRk83SzJ2THhwVEdzUDBk?=
 =?utf-8?B?emhaL0cxZjV5TDhmM3Z1Y01qYWd4d3Y0Tm1LVzB2M2xPdmZlemc0Q2poc2VN?=
 =?utf-8?B?aGVLYnBOMnhIbExsVUZYSk80dG5zUFJNRXdYTEdxYkZDOVhMWkVsM1hYdU5C?=
 =?utf-8?B?R3NsOStUTVdzc3lnZ2ZzTmJYVURxc21jWlV2Zm9tenBLK2lkWmFRMkl5M3JE?=
 =?utf-8?B?WTE3aE5YNk41R21NMzhLUXRMNm9BOElKRnVXRGpaeUtjQTI1SENOVnVWNW9s?=
 =?utf-8?B?VkE3VWlNSldSUm9qWndPTnlJbmVBY1Y4cHpZekljRlo3SUxjZ29UU2pmUjN2?=
 =?utf-8?B?NW9kL05SMTNQVjJJR0YrSmNXZ3l4NmZ2M3YwNFFBTXBsRER4RjloNm8zRS81?=
 =?utf-8?Q?ODYarZ44vIn44+Cgs67Av6600?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E5A3068C6DC9C499BF3BB5E453477AA@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a460515b-0e4e-444e-d5b0-08dcbadc9ef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 14:39:50.1403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UAW0ETAaWTyWmq/k3r/z/dr18pFvSaEXXP1uF5iao84U25oiu2bDKZY6VHlD6R3ZFkeU5gL4SYKGuUKmq2dbsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5220
X-Proofpoint-ORIG-GUID: DC9novfIKe5NXyE9PLTDEYJytkRJ4tO2
X-Proofpoint-GUID: DC9novfIKe5NXyE9PLTDEYJytkRJ4tO2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_04,2024-08-12_02,2024-05-17_01

QXMgUXUgc2FpZCwgdGhpcyBwYXRjaCBpcyBqdXN0IGZvciBpbi10cmVlIHN1YnZvbHMuIEhhdmlu
ZyBvdXQtb2YtdHJlZSANCnN1YnZvbHMgaXMgc29tZXRoaW5nIEkgZG8gaW50ZW5kIHRvIGxvb2sg
YXQsIGJ1dCBpdCdzIHN1ZmZpY2llbnRseSANCmNvbXBsaWNhdGVkIHRoYXQgaXQgd291bGQgbmVl
ZCBhIHNlcGFyYXRlIHBhdGNoLiBZb3UgaGF2ZSB0byB3b3JyeSBhYm91dCANCm5hbWUgY29sbGlz
aW9ucywgbWlzc2luZyBpbnRlcm1lZGlhcnkgZGlyZWN0b3JpZXMsIGV0Yy4NCg0KPiBPbiAwOS8w
OC8yMDI0IDIxLjMxLCBEYXZpZCBTdGVyYmEgd3JvdGU6DQo+IENhbiB0aGlzIGJlIGZpeGVkIHNv
IHRoZSBpbnRlcm1lZGlhdGUgZGlyZWN0b3JpZXMgYXJlIGNyZWF0ZWQgaWYgdGhleQ0KPiBkb24n
dCBleGlzdD8gU28gZm9yIGV4YW1wbGUNCj4NCj4gbWtmcy5idHJmcyAtLXJvb3RkaXIgZGlyIC0t
c3Vidm9sdW1lIC92YXIvbGliL2ltYWdlcw0KPg0KPiB3aGVyZSBkaXIgY29udGFpbnMgb25seSAv
dmFyLiBJIGRvbid0IHRoaW5rIGl0J3MgdGhhdCBjb21tb24gYnV0IHdlDQo+IHNob3VsZCBub3Qg
bWFrZSB1c2VycyB0eXBlIHNvbWV0aGluZyBjYW4gYmUgZG9uZSBwcm9ncmFtbWF0aWNhbHkuDQoN
Ci0tc3Vidm9sIGlzIHJlbGF0aXZlIHRvIHRoZSB3b3JraW5nIGRpcmVjdG9yeSwgbm90IHRoZSBy
b290IGRpciwgc28gaWYgDQp5b3UgdHJpZWQgdGhpcyB5b3UnZCBnZXQgYW4gZXJyb3IgdGhhdCAv
dmFyL2xpYi9pbWFnZXMgd2Fzbid0IGEgY2hpbGQgb2YgDQpkaXIuDQoNCk1hcmsNCg0K

