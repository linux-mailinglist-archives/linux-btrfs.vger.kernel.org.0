Return-Path: <linux-btrfs+bounces-10897-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F15A08C60
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 10:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12BC83A40C1
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 09:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A77320969B;
	Fri, 10 Jan 2025 09:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="U9xCAtUn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FE41FAC4E
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501898; cv=fail; b=fWsqc9LZImBlq2QbhER9PxueIgli/OqJmYB8xNq2g8e1kA6r4yfLNGoT0OCZQEePlu6VXGtG70OVI7tVPm8SXyn/nA8w5G8XHyosmynBgNcidK+kcr7NQNFEWWgffHOqDPmNzgLX43OkL4hR8mtTodNXorTnrC3PsaBJCBXHMck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501898; c=relaxed/simple;
	bh=mWwsmJgg1lRy0hzaRntPRzbor7gA/tTAd5MK41T29Js=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fm3OzBWSVKhjP7WSBJUd2Heb9XGehI4AxJDyniKmTcLdyw7xquu4qbms26JPZ5+kJKAFoY+hAnonWJWgD+bwEEV1xSOqu+/j6vL3NG2jKGXpZvz6+PPc/JLJe+Bp09cankUVE0MXOM+j9R36Q+03ZXLD/JCJnmGhh7zh+JqbqZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=U9xCAtUn; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A8lx3L031146
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 01:38:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=mWwsmJgg1lRy0hzaRntPRzbor7gA/tTAd5MK41T29Js=; b=
	U9xCAtUnTBvw9kL14VrjCeCswXsFQTF6YnNn8xTsGdu/Kn+gwXGbb0QQ+lrJ6Hm2
	+4OoI+lhBTrSgfhvo3Qr8rhuFijkY6zYbRrPNfxww+IVycPYUHZth1gnkrQR4HS+
	Qgy0dji2CnW1L712XX9w4qUcH+zRWV3/QmCol+m2OArEoaTJXE5s4l1dZNykYWl1
	nbGlLX3EFoKQCMMyv1xCJiC/8xdphScQ3X9mugkFUlWjuwJP+lO43PLmOuWiRWnI
	2CpAgD4sUGASd2rIsA2AFBe8qKkuG4vShIfvimx/yt5OR0BR6h9jK9Yhnwd6rORl
	SaVVktNzLj6E00q+FR6EAQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 442wxsrvnk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 01:38:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/hfzZ3xuVXTof8UL0hBFaIGBaR3UqVBXn54ls9PB3tWv4AXGUXQjHxWzYg2pkgqwHkYXg1/Run/DCUBqAsT6alFCeFt73jCpCdAmhkuxkxQjPWKX2LnaY2t79ZlobgWQDH8WjJnn9ClFK9i0pKszpiQQavxJ5wI59nqHuDBUA7nhteRwxjWogK4MI5gokS0ZSnjg+TMO1fQK4lbiQQQkx/4zFErMpg10+7uzsesqIcZxsQgSr0gmELvJMU2DYdMBUDbHhAfKAm7g79kHr60Kwls1G7r84FGrUpGHItIqFM4KAlP1asu3rB1oy7ch+lAhT1d0q4pDbqEwR0s6RFsqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWwsmJgg1lRy0hzaRntPRzbor7gA/tTAd5MK41T29Js=;
 b=eXwZ37OdD+zmbIv64Tc2ligqz+28+S04HGbCrruvRQpAwyN0gc2bKsmxqUQ4pqQAU8aghipyYd6UmM+QSk8vJjjqP1tBLBMC/cnutQhnzI9xwmqo8Yik/O+6KecdcHpgxPI5zQJCOiWRKhPXSUAEr6Y21p0rI4b2vcXctYNBmXSIo4qlcWrL0idPiY39H5T4K2MbE3vpL77iqNz79gqFrEGPvK2Ec426sqTkMiPOJeIPx8/cJ3BlSpaDETaAiahK404N9baxErQr19hBUZ9OOMQOgYaGBp/Nv/ePEMnbDd54KKVln0T1R2YCkjbFQN9OetOMXBhMPcN9TCMr+VxwXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by MN6PR15MB6050.namprd15.prod.outlook.com (2603:10b6:208:475::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 09:38:12 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%5]) with mapi id 15.20.8335.010; Fri, 10 Jan 2025
 09:38:12 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>,
        BTRFS
	<linux-btrfs@vger.kernel.org>
Subject: Re: I created btrfs repair/data recovery tools
Thread-Topic: I created btrfs repair/data recovery tools
Thread-Index: AQHbYuZ0WW575T2gnka4yhrQEEmhDrMPwOyA
Date: Fri, 10 Jan 2025 09:38:12 +0000
Message-ID: <db84010a-f5c8-4ec5-b5ae-babb04421307@meta.com>
References:
 <CAOE4rSzjUzf66T0ZxuN-PJqjRuoXoC9-LBQqg4TJ+4Hvx4h9zQ@mail.gmail.com>
In-Reply-To:
 <CAOE4rSzjUzf66T0ZxuN-PJqjRuoXoC9-LBQqg4TJ+4Hvx4h9zQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|MN6PR15MB6050:EE_
x-ms-office365-filtering-correlation-id: bce2cf11-df1e-4648-f040-08dd315a803a
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UDZWb3lYQThraUpNMWNFWENhVUlWU0tkTzNBSXFaK3JlU0wyUFAxZmN1ZitH?=
 =?utf-8?B?RnVjZ1R6aFdFRTM1MHhzQzdkeDMyOUZlOEtScWx4MDFBeG4vWkk0T3RHSXVL?=
 =?utf-8?B?MzdpNVdDOFVzcXIvVHJqdzM3L2N5NFR3RlhNSGE4QVlPREpmbnRoMGwxcmJw?=
 =?utf-8?B?ZTJRUkhtVUkxNU9WbERaN0Z4S1ZhUHhwSmhINWZLN3pGeTcwNTlER2dmNmxz?=
 =?utf-8?B?N3dGZWN4Zy80RVZwTWFjeTI4S09KZFlXZ1R3VDZjM3FtU2lpeFJMOXNVN1Nz?=
 =?utf-8?B?RzNpcXM1Mno5U3ZML2JYMENrcGN2bFk1T2pxMS82KytkdmhzUDA4Yk5YSTBn?=
 =?utf-8?B?eTM4Z0E5RVU1WnBaNER1VDJ5VysydHArYWtWKy9ySHZNUDlXT1NLK0QwWlNk?=
 =?utf-8?B?d0Ewd2hqR3RBS0p3ODgvMGxYdytFejNDVGlKbElDSk95Q01BMy9YTDBwNUM0?=
 =?utf-8?B?WG1CWVFtREJ1L0JBaVZTY3RJQjBtdTd2bEQ5c09WaG13WVBITUV2cjZjSXV1?=
 =?utf-8?B?ZFBtZktWSHBQNTR5SmgzMWxibUFrL0xXUFVnTlk3a0lBV1RiVzI0WmtUSjNh?=
 =?utf-8?B?c3JhKzJva2FGUFFEQUpSSlY4KzhDZHNnVHNYclhuQXhxRzlyaGFUWDB6Q1c5?=
 =?utf-8?B?UENvUWNMczdtQ3VYVU00UnI0Z2xnZ1ZqdlF6a0hsTnVyRFJvWjlHSmRIM0lS?=
 =?utf-8?B?UTNYeExQT3YvZWNpYXFhWW5rUjk0ZWpWNVV5aWdOaDhMdkxwMFhSWTRSMFJC?=
 =?utf-8?B?NDlrZnJMVkNySzVFenNKak15clZrWUJqOWZjSGp6R3o0OE54cWVqY0pUbURy?=
 =?utf-8?B?WXpRMTRjYWgxMHMzWUZUTHpURnYwQi9vc2ZzZzZyMVB3d3dpL0pScmlJY25E?=
 =?utf-8?B?TE0xZmUyd0dIRTRLYkpOb3RQdmFqZUNwbWYwOTF1QURLOHRra2NWa0l3Y1Rx?=
 =?utf-8?B?RFZXRTVHNE4zN1k2VFFkWVgwLzRKZmdFV2hiMGtZVkxIbDE4cG5VcUxJZTdn?=
 =?utf-8?B?cVk5VHBqalp6MjFwVi92N0UxZmxvSXBpR2w0Q2xuY2RUUDdsR0RvQ1BQaC84?=
 =?utf-8?B?UXhxdlJneGd6eDg2M21ldHdGR3N6b3dRNUJ3MHJxSEJleXJ3eVk4aVk4eVFs?=
 =?utf-8?B?NCtjc2VHemJUU29KU3Y0NnJaQnZYS2RIdXdGS0dSbkVvcGZ1Sm1rbkk0dGxh?=
 =?utf-8?B?cVNDaWJwai9POENoZkQ3VzhsamNIUERVVVhMZHlqREJkcW54Y21DTFlobXNi?=
 =?utf-8?B?MkdVM1pSK0Fad052L1M0RFp4cHpvZjdvZlVYS3JJVjhQR3A4dklpVWJXVHJy?=
 =?utf-8?B?MFhiMk53U1poZUhyWWV4ZXBQa3pBOHVZM2tKUk55VjBEYkw1M1VKMXd0a1U4?=
 =?utf-8?B?anFiS2JQOVhWYm5xUit2dnpMekxDczVLZjIxUUhOdHF2ZHZ6SVpOWUxyWThj?=
 =?utf-8?B?SzF0RDNSSnQyOUhvT3NTa1pWaWVRZm16U2d4VkpndEhERmRHcFNoSFlucHNI?=
 =?utf-8?B?TXoyMmpZSFQvZjR6bjN4QXFFSFg0eldITzRXL04zVVNmL2FQODh4SGxPTHVG?=
 =?utf-8?B?bjBZNTg3NXM5TWJuNHV2cktlUXY0ejFIUnRlSEFWcVZ3YWRwT1NIZUk1VVo5?=
 =?utf-8?B?bW5sUlQrUTllRXBTcVl1REphL2lWK3NFMWF6NUI0U3grZlV4RTdlWmJINVEw?=
 =?utf-8?B?eWdjOXZzbWdmWG56blNYcmtHV1ptRmRCVURsSlgwM3dsQnZFNkZMZnREQjVx?=
 =?utf-8?B?dHlEUEd4Qmh5MGZkQnZOeU5RbktGWXc1QzROb21RL0doMmFMa2loY1BzeUdj?=
 =?utf-8?B?MllvZkVoR2lTelJaSW12ZVltRnFlR1FsdEpYeDJuNXJSdmlUcU1VMkladFFK?=
 =?utf-8?B?NzZtTFFXYWJMdFlQaFQ1L0JURGNjajkybjNubDg0bnhxdjY2a2hHZXVkSDIz?=
 =?utf-8?Q?6zA4JK0XwMXvTew3pK6/+QLXg6namN++?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UlR6V0krOUlqb2FQc2NWVUtIQVFqbEtvTTFwVkI3UWQ2aFhpV0ZRZ3N6WkZz?=
 =?utf-8?B?L2lqNFIzeElEb0tOb2tnZGY2ZU9heEhHNlNKVjRMWW05bXFQZ0NHUVRORmJF?=
 =?utf-8?B?ZmdQRGltaW9CNVVZUmFWV2RuVExPNG9uaGZLdXdlVEU2YlIwTEQ2emR2MHo2?=
 =?utf-8?B?YkhSZ3BJajZPc2lGRm4yNWlZS0NLNml3MEdxQktVd0xKWHVBVk52RC9WVitZ?=
 =?utf-8?B?K3lwYW5Sa1VVRVA3YjljOFZzVVVqRGg1UEpCbG5qSnR5M0dqN2R4YUJqcThU?=
 =?utf-8?B?Tmk5RkU1Q1lHMnZqcTkrRlRGU2xBWXRXdGdKakhrelRIZmVEMjZwRHJITXZt?=
 =?utf-8?B?N0ZKbFR1Ykx5R3J6b2IrYkxXOUpxTTNrWUdyMHphRS9iTDBQWnN5bTYzeW42?=
 =?utf-8?B?V29tdFYrOWxLZTdqNnFhYi9qSTB3K2k2NWZRQ3IzY0djZGttdDZZdjd1b245?=
 =?utf-8?B?TDA3QkpKOEZWWHNkNGVTT2ZhRENlL08wczNBbEdRK1lXTzVvQ3RhMHJMQ0pO?=
 =?utf-8?B?YXZFaG0xb3NVbTdDN1pCdG5uVUtYa2ZKS1hNd0RRaERWZFp3MnZIcWhua0w2?=
 =?utf-8?B?RFIwdGFqWGNobFRCT0NOdVgrK3Z5NmFBT2xBS3dUMGhnZG0wVWlwSGlWUnBE?=
 =?utf-8?B?d2xwWElhOXhkNXNFZXU0c2tJbFIzOFQ3WE15UVN4VFp6dWVJR3hZVTZFUDZQ?=
 =?utf-8?B?Z2tZMXdmaXEwSVViOCs1d0pVanB6TjUvRWJYeExjc21xdzlEYnBkcEZFcnoy?=
 =?utf-8?B?UlZGY2pQVTVzaGJvdWJFNkhFdWxnNEs3WW5MTm5BT0gveVQzaXQ4OEs3QVIy?=
 =?utf-8?B?L1JTOXZlL2tHUUd5OUg0L2M1dm1EZVJTTGV2WUlpd2dQcnBiQmNlYjY3Q2Zp?=
 =?utf-8?B?aklCZGt2bjN1YXVMZ2d0UW93SUQ3QnBCYWJhSTZQZDl2N2ZoaU9nUHVIOHh6?=
 =?utf-8?B?ZWhNZTZnNEZ6NmsrMW93S3R6VHo5YTc3TmpES3JtREVKdkpJaXlmQlQ3OFUw?=
 =?utf-8?B?SE5KZ2tyL1NwaVk2OUlkZW15UnJLdVA0b3lWbjZwSzRFZ0RGWFNoWnMvZkxF?=
 =?utf-8?B?TXQ3cXB2MmdSSWdIRU1FcVJvbGN6OUZNTUpRRkZRZ3lsUWVuSFQ1eHNpRVIz?=
 =?utf-8?B?NlFZOVBoMWhrU0ZlQmwrNFVIMG9xMTNDRTloZEhRUkZmaTRGYUZYOU9zWmJU?=
 =?utf-8?B?YzFOYkMzaUxVQmVxVEpBZzVLdzhiZ05CTjB4b1JwdlFuK1VGMUdNQ0xhTmJq?=
 =?utf-8?B?SkVaOWV1S2cwSHJHT0NpaUZwK0xoaWJTTTV0SzFPK3AwV2kvc3VnYTFqM1dF?=
 =?utf-8?B?S29RNTlTMnNSUUl1T2Q4MXJKVXhiRlNDQjE3dWhIOWJIYmRyTUNraXppL25M?=
 =?utf-8?B?YXJJcEZzLyswRGovZld3T0lYcS9DVkZLcDFMcllsM3BkNVg5SHJ3SHNkQ3k4?=
 =?utf-8?B?UXBGaVVIR2MwblpzcHNDQmVYWFBTam5pcEdydTlrUTlZRmtmTWthaGhtSm1S?=
 =?utf-8?B?N0U0aWpWMkNwS0R6NDQyKytJcVJESS9aUFVGZTdOMjNGck5QdE9vSDZyVTZY?=
 =?utf-8?B?ck9JN1hpMlF0eVZNanVnc3hFNXJkaEZPRmpPaTcxZ2JwNW0rK1cwcnlOZFlq?=
 =?utf-8?B?djBrZEN5R3Axc1hMNlVYVzJkaWZUSkRYVlluZ3hTYnhuTDNxcS9PM201UjlU?=
 =?utf-8?B?Tzk3NUJlZmlMbUtvMk5JM2NHYmtTWmRnWEd5TmVEREI0TWVRZm5Pa1JTM1pX?=
 =?utf-8?B?VmJsbjRZaUlpVjNuMzFSdVU3ZnRwZEkyNXhFYlZ4d2daMTUvd0thS2kwM2Zn?=
 =?utf-8?B?QW9tSldZMDNpb1JEK3R3VTlLWk9zaFIrUTFMVUlKTkFDTElTbzFDd1NtNlBF?=
 =?utf-8?B?R0M2MXBET05hZDVab3BVdkJRYi9taDhRbEJId0FwRE5mSTBUdWRiL1VMeFRM?=
 =?utf-8?B?THRyZm83bjdYWi83bU00L0V1U2owTWZBVkZBaXMzSnVkeDZLemhHOEM1MlU2?=
 =?utf-8?B?V0wxRUlVeEcxN3orUWlValZRQXpIcUk5RXZhK3pQbC9KdnJpTXhzYVlRVHNE?=
 =?utf-8?B?Q2s3eG9xWTFJU2phQ1ZuVmxSbDBSeE9hUDBDMmIrQmJPZXNxQlIrZFhlR2NT?=
 =?utf-8?B?a1ozK29xSlA4dE4wdTJ0bU4rSHJDbnU2aC9kTDVkbjRkTGh3ZDlYWGhiU3dp?=
 =?utf-8?Q?gYAHWDK1csNcPOdA2biDLHc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA2AF70CB835434D9ED59F8610F0C6CC@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bce2cf11-df1e-4648-f040-08dd315a803a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 09:38:12.4583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vha9DCGSzHy4WcOunJYhsMVSmQ6Rg9JlNZHhJ9uDLqYFRPlMQphyHYGtvq1T29CUTI9NpX17XU8yxO1bM1jwMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR15MB6050
X-Proofpoint-GUID: 4B5QgQx5Klo5F0tE9xkwHpmBT5kGkt3f
X-Proofpoint-ORIG-GUID: 4B5QgQx5Klo5F0tE9xkwHpmBT5kGkt3f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

T24gOS8xLzI1IDIyOjMyLCBExIF2aXMgTW9zxIFucyB3cm90ZToNCj4gQmVjYXVzZSBtb3N0IG9m
IHRoZSB0aW1lIGJsb2NrIGNoZWNrc3VtIGlzIGNvcnJlY3QgYnV0IG9ubHkgY29udGVudA0KPiBp
dHNlbGYgaXMgY29ycnVwdGVkLA0KPiB0aGF0IG1lYW5zIHlvdSBjYW4gZmluZCBlYXJsaWVyIGdl
bmVyYXRpb24gKHVucmVmZXJlbmNlZCkgYmxvY2sgYW5kDQo+IHRyeSB0byBndWVzcy9yZWNvbnN0
cnVjdCBjb3JydXB0ZWQgYmxvY2sgYnkgY29weWluZyBkYXRhIGZyb20gdGhlDQo+IGVhcmxpZXIg
Z2VuZXJhdGlvbiBibG9jay4NCj4gQW5kIGlmIGNoZWNrc3VtIG1hdGNoZXMgeW91IGtub3cgeW91
IGdvdCBpdCByaWdodC4NCg0KVGhpcyBpcyBhbiBpbnRlcmVzdGluZyBpZGVhICh0aG91Z2ggSSB0
aGluayBJJ2QgYmUgbG9va2luZyB0byByZXBsYWNlIA0KYW55IGhhcmR3YXJlIHRoYXQgaGFkIHF1
aXRlIHNvIG1hbnkgZXJyb3JzKS4gTWF5YmUgbG9vayBpbnRvIHRyYW5zbGF0aW5nIA0KICBpdCBp
bnRvIEMsIGFuZCBnZXR0aW5nIGl0IG1lcmdlZCBpbnRvIGJ0cmZzLWNoZWNrPw0KSSdtIG5vdCBz
dXJlIGlmIGl0IHdvdWxkIGJlIHF1aXRlIGFzIHVzZWZ1bCBmb3IgU1NEcyBhbmQgTlZNZSBkcml2
ZXMgDQp0aG91Z2gsIGFzIFRSSU0gbWFrZXMgaXQgZmFyIG1vcmUgbGlrZWx5IHRoYXQgcHJpb3Ig
Z2VuZXJhdGlvbnMgd2lsbCBiZSANCmluYWNjZXNzaWJsZS4NCg0KTWFyaw0K

