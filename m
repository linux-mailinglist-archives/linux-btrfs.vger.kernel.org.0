Return-Path: <linux-btrfs+bounces-6949-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB78494505F
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 18:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F00731C25830
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 16:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FFA1B3F05;
	Thu,  1 Aug 2024 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NHwAnOGP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E84E1B14F6
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Aug 2024 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529032; cv=fail; b=EWHYJ5nX9k/FXZNr5yDZkoxF2d7vc1U+4e86aDKO1VjGbus4Nf3Cpe4Jiae+t5YRnOwjsaDaRr6fVAd1NCHFQBc74yJPrabPJs7hrkaW2rm56VczD1uWS2NpJnY57CYYay7r6ILEqRksAjQE7Na1d1qMjp0a87lxy4WPCZmXV+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529032; c=relaxed/simple;
	bh=8dndwPzxfkAaGUgBQID/jN1C+6b3vp5b5dey5o1a9So=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TiJUl3+zgwL+j5xLVB+Bj7ew4aCkk2UcY8nsn8zNCd5/JN4gSPp3rvo6D6GVYeg9wnEgiL8em+n/urLapI7GxoKjsMq1j/RTk/sgQErPsDupxkKdvBaLK8NX5tTGyDCllh57CGOj0w6209tBajOYh6lG2rXDTeE4xHPuLrLg4kE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NHwAnOGP; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471ChjgF014215
	for <linux-btrfs@vger.kernel.org>; Thu, 1 Aug 2024 09:17:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:subject:date:message-id:references:in-reply-to:content-type
	:content-id:content-transfer-encoding:mime-version; s=
	s2048-2021-q4; bh=8dndwPzxfkAaGUgBQID/jN1C+6b3vp5b5dey5o1a9So=; b=
	NHwAnOGPET1pkU3q1F91s5oYJGwCpaM5GagnnFPKG7kYtzEAL/376CdiJu5haH30
	foQszDSIo6JrqIYn1WSJPJ9uy211vqm5AtiCBAuyVcrZx50V1ZEs/2Ycth35ntMP
	d0aMNR4I+JCE319d5+kGkNjsFLFDIDYG3IeU4W9L28excrbJNzI+vjv/qw15X8GK
	FHI3HV3grKodXml9ZkgzDTVAWJdYo8Akucy82sJmHRhrBth1GS91mpg4qgIWJ+tO
	cZexEvcX63LiuhJ6z+1WyrlJtlP52CVS/pLmA0CqMX3svGu+/cJWKQOnCD/w3+H1
	GJJ97mjx0L2o2Nkm62ogFQ==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40qvkje29d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 01 Aug 2024 09:17:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ieijk+4BDDGixgBN8LcqY1m/XDNrsYbwygQ/Bhoyfuq3vd673a4scczqexYgVBvoA1alOHohYddOxXO4gdUq1UJt68G4MQq9cuWjipiFFV/R1naHZ2rnkw1mseyzh4fwOmNyeQ3t+ljmhCJfP84Cxo3iOrNP09sC42/uxJvXo7Rjl8FVUzmrZsjy5zdG1/k/qSBM5V3EDbLqhIXvj4lJ2x/PHi57zqb5mQZFP72LdJ3ew8gDt5AMSUoy9uz+X1zGv6uWWAWxVISrcFQgYVX1YOer+Rg0MYxGv2/Zy/JRXF3tvt4biah+/Rug9lStKp9JHoOpuvfArviNF4aA9WdzjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dndwPzxfkAaGUgBQID/jN1C+6b3vp5b5dey5o1a9So=;
 b=j4wgwEIBYST4blW2va+SWyw7mn1e5hzgseqGET+v1zPGL4PZhPswTN+ChZkLYcDE2M9DxlWbYaBQ+uyfNIu+F28z3qLtq2ySF+is+fQv0D5flau3B248VO9pbj+drzKnRubi5EwsLmZmZL8NhPj2WjeleND9f0gxmLIL18oiKpZoSTJYO9Pm1jzqc1Qh3a4wvSu4YbF6O2GsMKzyN8W2uL7+W588IU/r0QD1i2cW9fLlLtnPGrVjzmOVAm2OzjDwPy+M01bXDoj7V5ZofTu07PvtQXo+Wf1bWVXMgDzGOr6Qr0AdeVRQpY9pioxexZ1anVyC5N0t1f15F6pe5bam+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by PH0PR15MB4414.namprd15.prod.outlook.com (2603:10b6:510:80::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 1 Aug
 2024 16:17:07 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%2]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 16:17:07 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: add recursive subvol delete
Thread-Topic: [PATCH] btrfs-progs: add recursive subvol delete
Thread-Index: AQHayKXGfscziKlHuUuwLVpZkhZegLISyzaA
Date: Thu, 1 Aug 2024 16:17:07 +0000
Message-ID: <f8d06d34-dc46-48fb-81ae-2ca3eda9881b@meta.com>
References: <20240627152156.1349692-1-maharmstone@fb.com>
In-Reply-To: <20240627152156.1349692-1-maharmstone@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|PH0PR15MB4414:EE_
x-ms-office365-filtering-correlation-id: eadaae15-abf0-45ec-4f52-08dcb24563db
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WFVHcWN6b2tuSGRlaDB0WVJmbTlTaE5ZYm53SWZZT2FiYWpNcFRXUTBSVk5i?=
 =?utf-8?B?dmdtOE9iYlhKQVdRbjZqU1R6Y3c2bXBUdkJaS2swamtLV1QxcVNRdjZsRTk5?=
 =?utf-8?B?dUJYOWlhQnBGckhldm9BSXBIUnBnSWY1MzFqa0hPak94UW1pK2NwdThkaWUz?=
 =?utf-8?B?RVNQMlE2S3JwUExQYlg0VXcvRVNmM3psRUFMWkdDMjVvazJzaXZJeXhJdDht?=
 =?utf-8?B?aUpPVDQ3eUJJT1pCYWVUd29LSkVFVWVyd0ZxZ20xS0lBZGZGSDN4dERhVzVZ?=
 =?utf-8?B?Z0ZmcUVTSjB5U1VjTkVxZStremg4S3ZZNFFhcmhlTWRBUUZxZHBlYTJjdFJm?=
 =?utf-8?B?T3ZyQ1JqcHFPY3htZnRMU1VOKzQybVhhaGRmb2hUMGtFZ1N0bEJtK0dSdXhs?=
 =?utf-8?B?eDNkNnBocGhtSXJucFI2UUV0dXdBRnQySlhVSFdWbUtyOXBTdUk0OTlNQlNF?=
 =?utf-8?B?ZXQ1RVc3T3JYdjFXeTFhNzJ6cFFHd1BSN0JTZnRGNHVEQk01Sm5GWnNZYkUv?=
 =?utf-8?B?TzE3b2owTHVnejNLeG0wR1pzaEVMRTJobkRYckVmMEdRdERjaHU4ZjdUdUsy?=
 =?utf-8?B?VmlremY0eVZsNkdkV05aYWhJUDQvSFhDelUwQm1MM0VndXZXTnVOSTNsbkNS?=
 =?utf-8?B?ZFI5TThuQm40c29nalBQcDBaNWNCTDR3UDI4S2QyZWlyYjhtbys1S3VKL2tW?=
 =?utf-8?B?NC84NERCZFExTnRTclV2NjdJQzdiRHZ3N3psY1FTTG45R2F6Um1SdktxcUts?=
 =?utf-8?B?dkdRK2ZYdVc0d2NKVjdhT0c3TDdoRXdtUjJBV0IrVXlUN0MyZE9DbDZ6TEFv?=
 =?utf-8?B?NldSNzgwRTRSYVZBMVBlQkYyNWJEY29JSktoOC9seFBmTHdXU0lJM2RRNUVV?=
 =?utf-8?B?ZXhJcXJvUUgvUHJ4alBqYXRRWkZDU1RBaUg5YU5RQkQ1bnJYMjdFVXQ3WFdr?=
 =?utf-8?B?Z3ZnVm9YQjdpb3NRNWljcXZiamZscHlDamk5Qm5VOTZQaHhOSWt3RmtxbDhF?=
 =?utf-8?B?Z0JiUVRzd0tMZ096YWowa2ZINjdkRXdldXFJbVJSK0dlWVoxZlhFL28xMEJa?=
 =?utf-8?B?VWFtbUp1Zi8rUElLL0E2Rk1VZWJreVJ0anFtY0tPd2dVQ1BHZExXU0tsY3Q0?=
 =?utf-8?B?amhIV3VTUGppOGpxY3lwRnk0QU90VE93cDk3NXJ4bWl5TEErVkFpRlNxbjVJ?=
 =?utf-8?B?bmdCTnU5QU1lOU9ReUc2dS84VEV1YklmRzlialZHNzVTYWZQWnNvNFhzVDgz?=
 =?utf-8?B?M3RLMWN2SEl0ZW5Cd0drTlNDc0FOQ3Zyd1MzQ2t4M1RZRkpJODZiRWQzMXpL?=
 =?utf-8?B?OHBXNEVyWHlDOFRNeHlRb3JkWFNyaWFTeEFjSDM4dmFiMjN2SnZmcFIwVjZ0?=
 =?utf-8?B?UmtxUTBFaVpCYVZmVUJHcE5KZlp6V08zWnBrNk1YdzdTVzRrTjhjZUFJODhX?=
 =?utf-8?B?Y2VsS2VPWEc5Y09rUEg1TVBlVFFISGZPeHlXQ2FMeU5QcXdvY2ZHeGUwYnhG?=
 =?utf-8?B?aEtSejhQQitKbSt3OExGWDVkM2NEL0tpaHg4clNvRzJjQ0o0Um5NUXBidGtV?=
 =?utf-8?B?THRIUVVLeDkzTW5qM25lTFppUHJzZXFpenNUYXpBWVZ5RW1jUmU2R2RWQ3Vk?=
 =?utf-8?B?Q2V1aGh6dEMyTTN4aisvTHFJazhOQVRMNmdiMDFTbit4RUxwWVRhSldzNU4r?=
 =?utf-8?B?c0xabU4wcUJYdUtmT0laZ0h3STZGOURVeCszdHRNK1I1YkRyQU15bFVLbnEx?=
 =?utf-8?B?UHFiYlRFOGN1L2FmNmg5ZVdobllTanp2K21MVGMzMkpFemptT2grZ2hveXA5?=
 =?utf-8?Q?IKTwWbCxlyPj0GxNh0L/EporuVIii++6AHgyY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L2dBVmVkUDludlZPWS94czdmL2JVcld3MUdwYnpRaitaQVZnZUhHc3NtRXow?=
 =?utf-8?B?Nk1qcU96S3IzYzlqSEFQWm5YbGpkY1NoYTNKYWFWMEI3bzcwZVBNcUVsZ1dn?=
 =?utf-8?B?cGEvTjVFNC9aV1hXKzZhNitoc2h1TzNjU3RVV25xTEJjQXJYMXlJUlJVTlYy?=
 =?utf-8?B?dmFlMlpxZzJXNFdTTW1zY3VNMlpFbGV4L0dzcEpwbGZiU3NyUTlmNE9JSm0v?=
 =?utf-8?B?aGxZMVdBMXNPUk11Q0JHZ3VTR2hKU2h3MzhhQWpoa2VkdzJTSk5uUlBOb1dP?=
 =?utf-8?B?RWdKdmdwdWl0MnJNbkhZZCtMcXVsZlVzcWN6aW92YkNYWkdSRmlkSTY5YldD?=
 =?utf-8?B?RmVqOHlnWktZVHRuMEpqU0Q0Z3E4YnJpdHBsdmplMzhYVUtEVjJWZ0ZrQ1hj?=
 =?utf-8?B?ZXd1YjZOeEJyMTNJUCtoVEMyZ25MbnA1R2taUEVRN245SnR2cnZha3JmYitp?=
 =?utf-8?B?R1BCR29PbjdqUEpZOVZKNkRQZk9iRGxnWHd6VzNzMmgzM3o4djJHK2VGcUNk?=
 =?utf-8?B?dTBSR0JsdGwycHBEZHpkZDJ2K2hDaWs1aDZIZGxEdkxOU2NMRVJLWmV6YmNR?=
 =?utf-8?B?eVhNb3kzYWZKS3hnbVl4YTZNSVpKb3dVREV6NDZlR1RiRmxQWEtsNUVvWnlO?=
 =?utf-8?B?M1N5V1V3RW55dTNTZDBWYmdWcktjUStMQi9vV3VrS0pyU3REZGFKNW9ibW85?=
 =?utf-8?B?NG43ZnlhV2J5a1VOZlV5UmxTT0VTMDRTc1FiMnFCcmdrNkoxSUIycHgvVVlR?=
 =?utf-8?B?MDJERkh1K3pUOHRaWlgyMGFnYmJqZVF5bEhnZDNSU1RqWHM4L1hQWXlIRkhG?=
 =?utf-8?B?bExFVmNDNGxaTDQ2Nkd3czhDY0hBZk1oblhYb1BHTE5mM3hWVlBtbjdqTjhp?=
 =?utf-8?B?cmV5eXFDRkJLVXllRUNRczdWc0xnME1sQWRwdUJ4RFk3MjlLSmJjc0hPc3dE?=
 =?utf-8?B?YUNFcXdER24wTGpJMC9TZGNCN1VNNDBneXlGYkprT3QxWTVDM0xMTm5aZExi?=
 =?utf-8?B?b0xSUitnNUQ2REhhd3JZekcySEorVHdGbWJDb01aMEV5TDFwRkNQYTlhOVpH?=
 =?utf-8?B?cGJVbGM4eTZobWJHYndydlRPTUVtL0VOblJWVGJYY09LQ0FocVRxclJhVlFs?=
 =?utf-8?B?UG84VGYxTGFuRDdabnFuQVEzak1JdVREendGbEU2S0V1MmdQdE0rVnZZQi91?=
 =?utf-8?B?SDU0MHlOUFBKb2wwYWMzQzgycnB2ekNnN1o1Tk40bCtTZ3MyWGF1S001TnNS?=
 =?utf-8?B?bkxEM09YZ2ZEMTgxOHUrMnEvSzFoVHZjQnhlVnJqRHNHdGFMaVYrNk1WRUtE?=
 =?utf-8?B?NFVIanZsRVlZejBsK0pzbUFsbThKSE91TUVXQndFVE1ud1RIR2Y5VXdZRFNl?=
 =?utf-8?B?a2hnRHRwOGxEbHZMUkttMVJ5dHhCMmJXckdLRzd6eHc1UlpYV29laFd2SlJO?=
 =?utf-8?B?L2JRUDVmUUpqSXliL3RWOHRYeTZJWGFRNHVqbUZMVjZqemtIak5BdTJpdmho?=
 =?utf-8?B?V2ZGanZXMFVhZi9nK08xamRDN05JYlN3NFpuOWZKVVhvTkk4REw1WExERkN6?=
 =?utf-8?B?bFdqZmdNK1dNTzE4L3N4bnU4MzBrSnF6eUtyRVlwT3N2ejNmTHowS3pRTXBj?=
 =?utf-8?B?VkFIR3F3V2ZDMjZtSXY4cWU2dnVKeWlocEh2R3hKRUxhM2RYRll1YlI5dTA2?=
 =?utf-8?B?ZUZWNEJ2QXp0Vkt6b1BmMndqVzlSTU15WkYxTitHTURlbjkvdE5qZ3FmYVV3?=
 =?utf-8?B?U0tiRTdqb2hiMk9BSXdoSkRCVVZnendUNFVUbG5menAzaWJ1T3V5ODQxbExh?=
 =?utf-8?B?Mkh3R21TOVI4NHRGc1VJZ2djbUNtTmxOanFHaUF4dFlGQVp6OG5ZL0kvUXRN?=
 =?utf-8?B?QlF2QmorMFBLMnlRTVNnSnN2eGV3ZXRqQ0crK2hxclhkVklvTEhtdTZpK1p0?=
 =?utf-8?B?eUxIYnNUVnpGOHByMGdZbys0L3BQQ2gzOGFuNmpibXVhQ2Vra1VkQ2tjeFRt?=
 =?utf-8?B?N2lKNWZrb3ZKcEd6eEE0dmJ5dnBGMUd6WisyRFVxMk5nc3JwOThMTy82VytV?=
 =?utf-8?B?a0tKRVN3aDkrSlEzUWRqR3I0UHZ3WG0wOVZDc0tGcG5veTNBMElGNXJaOHpp?=
 =?utf-8?Q?Asa1uB6juKOTjPgWlHJUSphEp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04C99A1273476445A16AAE9DEFDDE486@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eadaae15-abf0-45ec-4f52-08dcb24563db
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 16:17:07.7020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: woiHbBsS3ScQa7FnmcR1IGMPbkaFNWPrLDAGwa9TSanwluGwe0+6uM64POwgj9fjhfEBRlfuwORn8WeFXW6sBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4414
X-Proofpoint-ORIG-GUID: tvJWRSqybYjfXzDqROPXptAV3euW2vbw
X-Proofpoint-GUID: tvJWRSqybYjfXzDqROPXptAV3euW2vbw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_14,2024-08-01_01,2024-05-17_01

V291bGQgc29tZW9uZSBtaW5kIGhhdmluZyBhIGxvb2sgYXQgdGhpcyBwbGVhc2U/IEkgdGhpbmsg
aXQncyBiZWVuIG1pc3NlZC4NCg0KVGhhbmtzDQoNCk9uIDI3LzYvMjQgMTY6MjEsIE1hcmsgSGFy
bXN0b25lIHdyb3RlOg0KPiBGcm9tOiBPbWFyIFNhbmRvdmFsIDxvc2FuZG92QGZiLmNvbT4NCj4g
DQo+IEFkZHMgYSAtLXJlY3Vyc2l2ZSBvcHRpb24gdG8gYnRyZnMgc3Vidm9sIGRlbGV0ZSwgY2F1
c2luZyBpdCB0byBwYXNzIHRoZQ0KPiBCVFJGU19VVElMX0RFTEVURV9TVUJWT0xVTUVfUkVDVVJT
SVZFIGZsYWcgdGhyb3VnaCB0byBsaWJidHJmc3V0aWwuDQo+IA0KPiBUaGlzIGlzIGEgcmVzdWJt
aXNzaW9uIG9mIHBhcnQgb2YgYSBwYXRjaCB0aGF0IE9tYXIgU2FuZG92YWwgc2VudCBpbg0KPiAy
MDE4LCB3aGljaCBhcHBlYXJzIHRvIGhhdmUgYmVlbiBvdmVybG9va2VkOg0KPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC1idHJmcy9lNDJjZGM1ZDUyODcyNjlmYWY0ZDA5ZThjOTc4NmQw
YjNhZGViNjU4LjE1MTY5OTE5MDIuZ2l0Lm9zYW5kb3ZAZmIuY29tLw0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogTWFyayBIYXJtc3RvbmUgPG1haGFybXN0b25lQG1ldGEuY29tPg0KPiBDby1hdXRob3Jl
ZC1ieTogTWFyayBIYXJtc3RvbmUgPG1haGFybXN0b25lQG1ldGEuY29tPg0KPiAtLS0NCj4gICBE
b2N1bWVudGF0aW9uL2J0cmZzLXN1YnZvbHVtZS5yc3QgfCAgNCArKysrDQo+ICAgY21kcy9zdWJ2
b2x1bWUuYyAgICAgICAgICAgICAgICAgIHwgMTUgKysrKysrKysrKysrKy0tDQo+ICAgMiBmaWxl
cyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vYnRyZnMtc3Vidm9sdW1lLnJzdCBiL0RvY3VtZW50YXRpb24v
YnRyZnMtc3Vidm9sdW1lLnJzdA0KPiBpbmRleCBkMWU4OWYxNS4uYjFmMjIzNDQgMTAwNjQ0DQo+
IC0tLSBhL0RvY3VtZW50YXRpb24vYnRyZnMtc3Vidm9sdW1lLnJzdA0KPiArKysgYi9Eb2N1bWVu
dGF0aW9uL2J0cmZzLXN1YnZvbHVtZS5yc3QNCj4gQEAgLTExMiw2ICsxMTIsMTAgQEAgZGVsZXRl
IFtvcHRpb25zXSBbPHN1YnZvbHVtZT4gWzxzdWJ2b2x1bWU+Li4uXV0sIGRlbGV0ZSAtaXwtLXN1
YnZvbGlkIDxzdWJ2b2xpZD4NCj4gICAgICAgICAgIC1pfC0tc3Vidm9saWQgPHN1YnZvbGlkPg0K
PiAgICAgICAgICAgICAgICAgICBzdWJ2b2x1bWUgaWQgdG8gYmUgcmVtb3ZlZCBpbnN0ZWFkIG9m
IHRoZSA8cGF0aD4gdGhhdCBzaG91bGQgcG9pbnQgdG8gdGhlDQo+ICAgICAgICAgICAgICAgICAg
IGZpbGVzeXN0ZW0gd2l0aCB0aGUgc3Vidm9sdW1lDQo+ICsNCj4gKyAgICAgICAgLVJ8LS1yZWN1
cnNpdmUNCj4gKyAgICAgICAgICAgICAgICBkZWxldGUgc3Vidm9sdW1lcyBiZW5lYXRoIGVhY2gg
c3Vidm9sdW1lIHJlY3Vyc2l2ZWx5DQo+ICsNCj4gICAgICAgICAgIC12fC0tdmVyYm9zZQ0KPiAg
ICAgICAgICAgICAgICAgICAoZGVwcmVjYXRlZCkgYWxpYXMgZm9yIGdsb2JhbCAqLXYqIG9wdGlv
bg0KPiAgIA0KPiBkaWZmIC0tZ2l0IGEvY21kcy9zdWJ2b2x1bWUuYyBiL2NtZHMvc3Vidm9sdW1l
LmMNCj4gaW5kZXggNTJiYzg4NTAuLmI0MTUxYWYyIDEwMDY0NA0KPiAtLS0gYS9jbWRzL3N1YnZv
bHVtZS5jDQo+ICsrKyBiL2NtZHMvc3Vidm9sdW1lLmMNCj4gQEAgLTM0Nyw2ICszNDcsNyBAQCBz
dGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IGNtZF9zdWJ2b2x1bWVfZGVsZXRlX3VzYWdlW10gPSB7
DQo+ICAgCU9QVExJTkUoIi1jfC0tY29tbWl0LWFmdGVyIiwgIndhaXQgZm9yIHRyYW5zYWN0aW9u
IGNvbW1pdCBhdCB0aGUgZW5kIG9mIHRoZSBvcGVyYXRpb24iKSwNCj4gICAJT1BUTElORSgiLUN8
LS1jb21taXQtZWFjaCIsICJ3YWl0IGZvciB0cmFuc2FjdGlvbiBjb21taXQgYWZ0ZXIgZGVsZXRp
bmcgZWFjaCBzdWJ2b2x1bWUiKSwNCj4gICAJT1BUTElORSgiLWl8LS1zdWJ2b2xpZCIsICJzdWJ2
b2x1bWUgaWQgb2YgdGhlIHRvIGJlIHJlbW92ZWQgc3Vidm9sdW1lIiksDQo+ICsJT1BUTElORSgi
LVJ8LS1yZWN1cnNpdmUiLCAiZGVsZXRlIHN1YnZvbHVtZXMgYmVuZWF0aCBlYWNoIHN1YnZvbHVt
ZSByZWN1cnNpdmVseSIpLA0KPiAgIAlPUFRMSU5FKCItdnwtLXZlcmJvc2UiLCAiZGVwcmVjYXRl
ZCwgYWxpYXMgZm9yIGdsb2JhbCAtdiBvcHRpb24iKSwNCj4gICAJSEVMUElORk9fSU5TRVJUX0dM
T0JBTFMsDQo+ICAgCUhFTFBJTkZPX0lOU0VSVF9WRVJCT1NFLA0KPiBAQCAtMzY3LDYgKzM2OCw3
IEBAIHN0YXRpYyBpbnQgY21kX3N1YnZvbHVtZV9kZWxldGUoY29uc3Qgc3RydWN0IGNtZF9zdHJ1
Y3QgKmNtZCwgaW50IGFyZ2MsIGNoYXIgKiphDQo+ICAgCWNoYXIJKnBhdGggPSBOVUxMOw0KPiAg
IAlpbnQgY29tbWl0X21vZGUgPSAwOw0KPiAgIAlib29sIHN1YnZvbF9wYXRoX25vdF9mb3VuZCA9
IGZhbHNlOw0KPiArCWludCBmbGFncyA9IDA7DQo+ICAgCXU4IGZzaWRbQlRSRlNfRlNJRF9TSVpF
XTsNCj4gICAJdTY0IHN1YnZvbGlkID0gMDsNCj4gICAJY2hhciB1dWlkYnVmW0JUUkZTX1VVSURf
VU5QQVJTRURfU0laRV07DQo+IEBAIC0zODMsMTEgKzM4NSwxMiBAQCBzdGF0aWMgaW50IGNtZF9z
dWJ2b2x1bWVfZGVsZXRlKGNvbnN0IHN0cnVjdCBjbWRfc3RydWN0ICpjbWQsIGludCBhcmdjLCBj
aGFyICoqYQ0KPiAgIAkJCXsiY29tbWl0LWFmdGVyIiwgbm9fYXJndW1lbnQsIE5VTEwsICdjJ30s
DQo+ICAgCQkJeyJjb21taXQtZWFjaCIsIG5vX2FyZ3VtZW50LCBOVUxMLCAnQyd9LA0KPiAgIAkJ
CXsic3Vidm9saWQiLCByZXF1aXJlZF9hcmd1bWVudCwgTlVMTCwgJ2knfSwNCj4gKwkJCXsicmVj
dXJzaXZlIiwgbm9fYXJndW1lbnQsIE5VTEwsICdSJ30sDQo+ICAgCQkJeyJ2ZXJib3NlIiwgbm9f
YXJndW1lbnQsIE5VTEwsICd2J30sDQo+ICAgCQkJe05VTEwsIDAsIE5VTEwsIDB9DQo+ICAgCQl9
Ow0KPiAgIA0KPiAtCQljID0gZ2V0b3B0X2xvbmcoYXJnYywgYXJndiwgImNDaTp2IiwgbG9uZ19v
cHRpb25zLCBOVUxMKTsNCj4gKwkJYyA9IGdldG9wdF9sb25nKGFyZ2MsIGFyZ3YsICJjQ2k6UnYi
LCBsb25nX29wdGlvbnMsIE5VTEwpOw0KPiAgIAkJaWYgKGMgPCAwKQ0KPiAgIAkJCWJyZWFrOw0K
PiAgIA0KPiBAQCAtNDAxLDYgKzQwNCw5IEBAIHN0YXRpYyBpbnQgY21kX3N1YnZvbHVtZV9kZWxl
dGUoY29uc3Qgc3RydWN0IGNtZF9zdHJ1Y3QgKmNtZCwgaW50IGFyZ2MsIGNoYXIgKiphDQo+ICAg
CQljYXNlICdpJzoNCj4gICAJCQlzdWJ2b2xpZCA9IGFyZ19zdHJ0b3U2NChvcHRhcmcpOw0KPiAg
IAkJCWJyZWFrOw0KPiArCQljYXNlICdSJzoNCj4gKwkJCWZsYWdzIHw9IEJUUkZTX1VUSUxfREVM
RVRFX1NVQlZPTFVNRV9SRUNVUlNJVkU7DQo+ICsJCQlicmVhazsNCj4gICAJCWNhc2UgJ3YnOg0K
PiAgIAkJCWJjb25mX2JlX3ZlcmJvc2UoKTsNCj4gICAJCQlicmVhazsNCj4gQEAgLTQxNiw2ICs0
MjIsMTEgQEAgc3RhdGljIGludCBjbWRfc3Vidm9sdW1lX2RlbGV0ZShjb25zdCBzdHJ1Y3QgY21k
X3N0cnVjdCAqY21kLCBpbnQgYXJnYywgY2hhciAqKmENCj4gICAJaWYgKHN1YnZvbGlkID4gMCAm
JiBjaGVja19hcmdjX2V4YWN0KGFyZ2MgLSBvcHRpbmQsIDEpKQ0KPiAgIAkJcmV0dXJuIDE7DQo+
ICAgDQo+ICsJaWYgKHN1YnZvbGlkID4gMCAmJiBmbGFncyAmIEJUUkZTX1VUSUxfREVMRVRFX1NV
QlZPTFVNRV9SRUNVUlNJVkUpIHsNCj4gKwkJZXJyb3IoIm9wdGlvbiAtLXJlY3Vyc2l2ZSBub3Qg
c3VwcG9ydGVkIHdpdGggLS1zdWJ2b2xpZCIpOw0KPiArCQlyZXR1cm4gMTsNCj4gKwl9DQo+ICsN
Cj4gICAJcHJfdmVyYm9zZShMT0dfSU5GTywgIlRyYW5zYWN0aW9uIGNvbW1pdDogJXNcbiIsDQo+
ICAgCQkgICAhY29tbWl0X21vZGUgPyAibm9uZSAoZGVmYXVsdCkiIDoNCj4gICAJCSAgIGNvbW1p
dF9tb2RlID09IENPTU1JVF9BRlRFUiA/ICJhdCB0aGUgZW5kIiA6ICJhZnRlciBlYWNoIik7DQo+
IEBAIC01MjgsNyArNTM5LDcgQEAgYWdhaW46DQo+ICAgDQo+ICAgCS8qIFN0YXJ0IGRlbGV0aW5n
LiAqLw0KPiAgIAlpZiAoc3Vidm9saWQgPT0gMCkNCj4gLQkJZXJyID0gYnRyZnNfdXRpbF9kZWxl
dGVfc3Vidm9sdW1lX2ZkKGZkLCB2bmFtZSwgMCk7DQo+ICsJCWVyciA9IGJ0cmZzX3V0aWxfZGVs
ZXRlX3N1YnZvbHVtZV9mZChmZCwgdm5hbWUsIGZsYWdzKTsNCj4gICAJZWxzZQ0KPiAgIAkJZXJy
ID0gYnRyZnNfdXRpbF9kZWxldGVfc3Vidm9sdW1lX2J5X2lkX2ZkKGZkLCBzdWJ2b2xpZCk7DQo+
ICAgCWlmIChlcnIpIHsNCg0K

