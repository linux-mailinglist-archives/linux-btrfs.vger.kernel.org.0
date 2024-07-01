Return-Path: <linux-btrfs+bounces-6086-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593A691DE23
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 13:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B48A1C225DA
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 11:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A996614B089;
	Mon,  1 Jul 2024 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="RoeswgVL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D98713DBB3
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719833650; cv=fail; b=L6QmtsoPF6ivlEXxr6ty4koMYk72uj+Q8pVvjE/NPukCbMxSQOmFtGRMYuJguhyFCVurHUZUdNRV8bBAgSJP3G9jGf9bPBbpmjM3Ox8XuUFp9LGks2gGc7epY4bmrCaWkS/AyFICu5wyQ73lxd646ASNp02oTPEamm34aor1gew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719833650; c=relaxed/simple;
	bh=KXna09NlqfdRYP1L4zKHRzkBW3K+RK7smBlw6xSZpcw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uhEyF+oevvA6ixHmZUYyiiGPMtRcu4WdSRvZG4Sq+GTkebUSXqJJIxD70dhg/+lh9K0q2pOmJfogX7YdoC8n+mby/WG+ozrJQ4scF6b/e8RWIefIr8M8kC+HvW17YCO39pVrQh/BG3ucam+sDVEpUEghgnbJ1EF+FXaSU/SXXX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=RoeswgVL; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UMp3oc004562
	for <linux-btrfs@vger.kernel.org>; Mon, 1 Jul 2024 04:34:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:subject:date:message-id:references:in-reply-to:content-type
	:content-transfer-encoding:mime-version; s=s2048-2021-q4; bh=KXn
	a09NlqfdRYP1L4zKHRzkBW3K+RK7smBlw6xSZpcw=; b=RoeswgVLNK8YCCKnOeg
	e/QJK6LZHkOyk/gVyfCp9RU2K+zhp4+xBSSIhs5v/HBWro+rrP0WDrvmnVQ7Ne/9
	7wi6h6icEfuKbJCHHEe25e52u0gWA5Y9yzgV2OI0oaPh4TU4RrQxZZRybSBHuoaf
	nFogHKfDc4A9mbsGYLIXq3LmmrBrc7t7omA4s6jdLWt9DwypWZahJfgBHc8W9aGB
	0VeoDj5r3dh5hkSD3htWkkjvW3qi1Ik9Ju5+tpsNJx9G7K+WfChqL9CCeWlF1jrA
	h721TB79v9hr02wMc8ia0r62UicK/kLnFA9hoPSoyZ0+j8LhMhAGt3Iw8udFWxZM
	r2g==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 402hk20a8d-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Mon, 01 Jul 2024 04:34:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvE/wKvFuHpRpwz/pclk/hPrzI6qHgn4TabDF2l4poinoQjP35nxwFB4rYFR/MPVcAMSjXRjJOfvjx/03aDaubV+bTyMtC+gVVmh3NmJBkUqQxQ6KCjOkUzr9ged5BntgV3c5aWmSvSlFdUPeM3SYwzLU7O9AboMQpzy9oQceIlrWKaqbR7fMThCaXIXN5J2eM3CMJvjqDRTOYAW9trp+CaXqcB4cGahOxnEDNtdaT9jUMKaxA0F70D4cNhD5MTPenzGSE9i2kfbIv9qXnUzXyAVdfunAJ8ClCCQPVSIJOU8n7prc6/6MCY+z6R0cyjuiCcRTtCUVGStW4Ts19aKVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXna09NlqfdRYP1L4zKHRzkBW3K+RK7smBlw6xSZpcw=;
 b=oaBErfnpKD0nhU4L913qhIAG9DwkAaNhq8FMvzO2UiNenCi5iut6y78PRU8q75ON3ze8zljG2f1YAwoJ3ejS41TQR+Ct+rLvIo4WYfAMF8ntRef/m7RVrIVdaj1daWceOrZJj3Nrb6ylqKxENNKeNg4BqlhyK4mkJLwCq/xbbdcMER7JC0QzEudiqAvEFUvTnzWK/05Q5j9yPoSOOatzSpmeuJyAlUtkRCNYCji/hMoy7q2PzUBkNEkEfDDwy5NdV3XoYHZbM4yLkm0h1aGo95dcsbwnN0t9/Cbq9JY7aZPbhOMUpX3RnCbRMFfsU60+INBMFJ9pZ3pi1qxHNkdbqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by PH0PR15MB4366.namprd15.prod.outlook.com (2603:10b6:510:9c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Mon, 1 Jul
 2024 11:34:05 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%6]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 11:34:05 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: "kreijack@inwind.it" <kreijack@inwind.it>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: RE: [PATCH] btrfs-progs: add --subvol option to mkfs.btrfs
Thread-Topic: [PATCH] btrfs-progs: add --subvol option to mkfs.btrfs
Thread-Index: AQHayHgUH+kou+8ibE2JS8l3fzZlt7Hdaf8AgARYPrA=
Date: Mon, 1 Jul 2024 11:34:04 +0000
Message-ID: 
 <SJ2PR15MB56696C02FD4EC239A668A083D1D32@SJ2PR15MB5669.namprd15.prod.outlook.com>
References: <20240627095455.315620-1-maharmstone@fb.com>
 <eb3642fd-963b-4a14-9cd2-8339adcb58b7@libero.it>
In-Reply-To: <eb3642fd-963b-4a14-9cd2-8339adcb58b7@libero.it>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|PH0PR15MB4366:EE_
x-ms-office365-filtering-correlation-id: 5a86f3c5-2817-4b53-713c-08dc99c1b691
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?NXp1b1M5SDFqNWFxMmxGKzdDQy9IUU9Bd3BqRE5rT3h3T0t2dkZhdFRKSXRU?=
 =?utf-8?B?UTNvNmpiZm1aa204QXhuOVordGhWdExiL2lBR3QrUzVqTWdDT3RGd01PVEts?=
 =?utf-8?B?Yk80SG5VdWd5UHRaTzNEYzZrVXdkS0xRK29zNmcyNVNac3diOG9YdkNQdE5H?=
 =?utf-8?B?ZVhjQ21iVWQvTDI2c2t5R2Q0S2h2V2l6L2xNVi9xeGIyQmR4allOdHgvd3Mv?=
 =?utf-8?B?VHptY0d2VkNRcUJRZTZEdVFBVDBvcGZGK3pPbndvTS9qblFudDY0azlkclNz?=
 =?utf-8?B?TFpoL0pXR0t0TlFCMHJ6QmJvUklwaGd5ellpUk5SWCtWOU1vQStnK0pXUDFz?=
 =?utf-8?B?VXYybzBxUTkzN0lnYTA3S0FPZzQ1K3NuUURGenIxWHZaK3pnMnB2V1ZZUVZF?=
 =?utf-8?B?S2g5UVdQM2JOOEdXRGV1NU4rR2NiaVRad1NGK2Y5MkJBMDNuSWN1eXRHbmtl?=
 =?utf-8?B?aDRrZVV2UUpQTDJ3RUxkT29HWEFiTk4zQzU1Q3FpU3NjVTdNVE1McVhHdE5a?=
 =?utf-8?B?RDhvVmlQQnQyMVJtRHpDeThvSERaanU0VGVqR0VOUmRoSHhObDRuYjMyeGR6?=
 =?utf-8?B?RkNKOXBkOEdtbzJibEIreCtqMkRsY2lPSTFKdTlXeTRBeWJpcXQxT1VBSmp2?=
 =?utf-8?B?OVdMdUY4bWhoMWhCeStjZEhEY2JnQ2FQRjJidEhyeGdGVk44TU1HVE95QVNN?=
 =?utf-8?B?SVZJRllvOXV0SjZicXJhTm9LRElYb2UvS2ZJamxtRERsaHoxQmJOZ0tPYkl5?=
 =?utf-8?B?SjVoMDdncnpmTGtQOEtyaytLdWFCTitPY0tvejBLVlZBVnhmWnFUa21iSWk3?=
 =?utf-8?B?K1JFVTdYYkNBcVhzRDEwTzhybGh6ZHRZbkVuekFNc2s5SldyWk9rQkxobHZZ?=
 =?utf-8?B?NzNzOVF1YUNId0NBUEFBalB1bTlwQ080WC9DUXk1MkdLZzAyV0ZqaldvNjJs?=
 =?utf-8?B?cGlyWEJDOTNOcWlmUFFteEFwMzlLU2FHZDlOMFlIOGxQb25XSFpTZnAzS0Zk?=
 =?utf-8?B?YU11U2ZvVWdkUy83MGhwb3NVc1JTbEIzYTZtSkdyeUZHWFlMa2doQldyMlZC?=
 =?utf-8?B?RVlnNGlPME9DYkhIWEsvZG4zclIyWElqOVBCckZ4bHVSaWNySFB4Vk02aEt6?=
 =?utf-8?B?anZsMThMUXUzVGNLNTZLR2M4aXpEbWUwN1MxRnNIeHFuRlBhYnc0dkl2VExV?=
 =?utf-8?B?blFybGZPU2RIVGdkMklPWUpLUWFMU3RvSGtEbXI0UTFNUnRqYTR6T1pXd2Y2?=
 =?utf-8?B?YlJkWFJQeXFRb1BWbWZxQjBJT2Y4RTRwc3kxa3BjaE5Id0ZFQW8wVWRoZFdw?=
 =?utf-8?B?RXdCWlN2aW1YcFlKS1NJRUxzNll3dlFyUTRVeGlEMEt2eER6enlmT2pIUEtX?=
 =?utf-8?B?bi9aRjFHWVR0dlBQWU1ianFKQTEwN0VJMzJsTnNrbkVmZzlYTkQyL0J2bHIw?=
 =?utf-8?B?dklwWHcyUlE3NHp0R3NjaFFBb3VZeG15V1JYaFMwSkQyM2p5UmFVTFQ3TmYz?=
 =?utf-8?B?Y04zSFc3M1lCOFhuNXcvRWJUdlRzZ1ZUdkRFV1g1c05YU0ZDSklndnl5eExu?=
 =?utf-8?B?NittN0FjSkNlV3l5YmZGUnlDUXFnUjMzSFlJdks1ejBLVjJCdGRWK0Q3YXJa?=
 =?utf-8?B?cUxuTkM2U2t6UlY0Skdwd2NXZnRzUHdwTjE3NllKUXhGTjZRZGl2SHd2WTFF?=
 =?utf-8?B?SEJvYy9DWnFNQ01RSitRcE5tUGgyU3F1bVM1MGphSU1vL0gzQWoxOEdaMVAz?=
 =?utf-8?B?eS9la2dGM3B5L2lFVk1FVEJPMGluOEp2dXVQbzNpYTNmcFVERTI2a2FFa0NZ?=
 =?utf-8?B?cHBrR2doaG1SaGVYM0RtR3MyU0JzR200OE4xVmVjazRaUHQ5eUxISmQrSDVE?=
 =?utf-8?B?Sm9UcXhBSW1iT2RMSGdNRG85a1RRTnZxRFN0bzZZU1dONlE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?U2c1OGN5ZjU4SG5xc3V6WC95NW9EVUNDenJuTCtZb05RVWo4UnphQzBaQ2xr?=
 =?utf-8?B?VkVnYzhPS0tuUlZpZng0Tzh4ZVJzeEo3NDBwVWNJLytkdTB4QlBKWFRXUE40?=
 =?utf-8?B?Ui9vT0d0MjdNTkV3dFZYWlhnVUVLZ0VMeUJJMi9iRXlZWjJxK0c0aGR5WWZB?=
 =?utf-8?B?Vk0vVldkeDJpdVhmYVhzM1IvODl5eUc0eDhKWVN1MGRBYmNyc2RuMFpycmdz?=
 =?utf-8?B?eXVOenNrckJUTGxoVUVXb1FpdG9jeWxDMmRGZHdnZGtxcWtBYTRYRnQ4eGFn?=
 =?utf-8?B?K29BbEFhYUxSWStuZHg4YzJBc3V2ZGtqelNXdXZIY2dpcWVLdXY5UlZRUmJH?=
 =?utf-8?B?QVgwNFc5V2lpS2tUNFZYNFdTLytpMk4wdHFXQVZBU2kzMXFjaEFXNWRSNXhs?=
 =?utf-8?B?NVZMWWNDMGlQM0swWDBQSWdHNTFwL2p1QUZGK3BUZXdrRVN0M2p3OHVWeDlH?=
 =?utf-8?B?dXRZeUhUOW5iTW5STGgvNmkwYzZlVDE0ZUFQUWYxY1lNcjR6bHFYbEx3SGlD?=
 =?utf-8?B?YXM2SWxsVTlFa2wxS3poazhNaW9waWN1cklKaDJPclNlNzM2NVNNL211eDFS?=
 =?utf-8?B?VzZoNXo2T2Y4VHprVWE4M1prV1hVT0Y3M3hvSUpMbExTTVdESUttZm9rWk9I?=
 =?utf-8?B?SjRDRW5FK3BiQXBJb2kvblcrY2Y1YWd1MEc4NVYydVJ3NHFqUDBNSEJrV0lQ?=
 =?utf-8?B?bHNpWCs1UE5oT2dWTlZTR3ZCOXZIQjJZcHk0MTlXdTZVK1pzQ3JQbVZkQS9h?=
 =?utf-8?B?b00raEdVWU5ETU9COXdocHJ1UmtKQlppb0lBRU8wNzBYOVllLzFhWnJLeXh4?=
 =?utf-8?B?M1NUWkJabDVEYnEyck91NUs2MFVCSWdsVTFmSGRJd2poVkJNRzN4cld2Uzgx?=
 =?utf-8?B?UTZhYVpRRlhVS2ZLZW10VFEyUWg5VDA3RFRpaEs4Y2x3NVFJY0pOTGpnUGFT?=
 =?utf-8?B?RG1JdXdmRTduVG91UFk4QzhCYmd0NTNEZ1BWdktlNkN5WGM0Yi9hOXljaXVl?=
 =?utf-8?B?MGMzSVU5ckR2QUlMVCswOHg2Yk8vUklyMkYzTFlBOTVCVFdpaWxoYkhrYmNS?=
 =?utf-8?B?S1EzWGhPbWpuR0htVnNCbFk2QTdGaG9GNTQ2dHNySW5mTnBJNnR4RnAwZWxI?=
 =?utf-8?B?UDE1dSs3SW85bUExL2V2cEExVjJYVDhjeU5oaWlaaXRRcndyU201MGRBdDYv?=
 =?utf-8?B?Y0UrZ3ZOa2NJMnpUMklSWFhIOGRPaGY0Qnd5VFY1OTJnT0lUVVpieDg5N1Vl?=
 =?utf-8?B?RzdKTG85aEt0SUF5Znp3ZTdrNStXWkxBQVZYVWN6VGkwa2xIcTFWaldUOVJt?=
 =?utf-8?B?bFNCNUg0T3pGcnp1T2lmaUN0T0s4ZHY4bXg5a1FURjlKalRwdjdkbzNtYXRw?=
 =?utf-8?B?N1B6R1pZYW4vb3lKNTVVRnRmODMwSVg1ODdyZ1Flc3ZIWjdEY2xJNUNZM3Bk?=
 =?utf-8?B?WUhlaElJKzU3MVNRdHp0TXd0by9CUEN2cmx5OWoyRmgvL1k4ZHJQNDFGZlRR?=
 =?utf-8?B?VDI1ZUprWk1BamZoRHhDWlpwTWkyWXVtampteE1HUWE3SzZBTklEYTVmWmhw?=
 =?utf-8?B?WmUzRmVsK3pRYUFUdGY1cmhuYm9GbmczWTJISWd3WWdjZjFMOTVoc1hKNWwv?=
 =?utf-8?B?cnprTWY2TzFsWXNKUDFjOWpSbDRZSGJ5SCtaeXpaeUJLVXlFbS9hSHBTcU8x?=
 =?utf-8?B?YVhqWjE5TGswVmtYRUVmUnFCbVUrRkxWZ3M1K0NlU24rRzZLRVNCY2RBTi9p?=
 =?utf-8?B?NTcyTW51SkZ4R3JKWVlFNzZJSVZwVk1uenYvTktjd01JMHRRV0s5MjRxWm43?=
 =?utf-8?B?T0JPTGIzOXNkUUtCQ0JwU29PM2RkTXAxSVVOdjhLQmVqdnRYakNRMWdMdzlk?=
 =?utf-8?B?M0p1dDJwdTJwUmMxZzM5VDBzb25wRkVDQjFzN2xYOHNFM29CMm1OV09seEVt?=
 =?utf-8?B?bFJGSHJLY05PbzlBVTBNRkpxeG5aYlhIT1YzTFduRjA2UXhVK2dpa2thU1VC?=
 =?utf-8?B?Y3lDUjVLV3hxaVhvdExEclgxakp2SVdVbGNGYTFxbDBTMlIwVy9wdFNtY0xh?=
 =?utf-8?B?UGZTWStOMWc0ajF2Y0ZEa2VKM0dVSEl4a2dVaHIvRTNuQ25nNnhDK25VVy9z?=
 =?utf-8?B?bFRtMDlPeUdYMDl1WEV2MlJZc3dPTDdiZEJPNzJnOWd3TFB2UXYzRURiOXNh?=
 =?utf-8?Q?B7/6KT/XPjHIXWP9WTYpwoovS7yMqoV8irVP17Mee1IF?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a86f3c5-2817-4b53-713c-08dc99c1b691
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 11:34:04.9905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U0KH4j8UGGngls3e2Om4kiijB9Nm6OUskBggxF7qmaTkqim6fOns7SbattIpLvqGKaxvRmg2ZGhSvChQWyiqgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4366
X-Proofpoint-GUID: PsyJmRENtzcv1xFP48lYonjIYBQCA3fv
X-Proofpoint-ORIG-GUID: PsyJmRENtzcv1xFP48lYonjIYBQCA3fv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_09,2024-06-28_01,2024-05-17_01

PiBDb3VsZCBiZSBwb3NzaWJsZSB0byBkZWNvdXBsZSB0aGUgIi0tcm9vdGRpciIgYW5kIHRoZSAi
LS1zdWJ2b2wiIG9wdGlvbnMgPw0KPiBJLmUuIGRvaW5nIGEgZmlyc3QgaXRlcmF0aW9uIHdoZXJl
IG9ubHkgdGhlIHN1YnZvbHVtZS9zdWJkaXIgYXJlIGNyZWF0ZWQgYW5kDQo+IGEgc2Vjb25kIG9u
ZSB3aGVyZQ0KPiBhbGwgdGhlIHN1YnZvbHVtZSBhcmUgcG9wdWxhdGVkLg0KPiANCj4gVGhlIHVz
ZSBjYXNlIGlzIGNyZWF0aW5nIG9ubHkgdGhlIHN1YnZvbCB3aXRob3V0IC0tcm9vdGRpci4gTXkg
Z29hbCBpcyB0bw0KPiBwdXB1bGF0ZSBhIGJ0cmZzDQo+IGZpbGVzeXN0ZW0gd2l0aCBhInJvb3Qi
IHN1YnZvbCwgYW5kIG1ha2UgaXQgZGVmYXVsdC4gVGhpcyB0byBzaW1wbGlmeSB0aGUNCj4gbmV4
dCBzbmFwc2hvdHMuDQo+IA0KPiBVbnRpbCBub3cgdGhlIHN1YnZvbD0wIGlzIHNwZWNpYWwgYmVj
YXVzZSBpdCBjYW4gYmUgc25hcHNob3R0ZWQsIGJ1dCBpdA0KPiBjYW5ub3QgYmUgZGVsZXRlZC4N
Cg0KSSBkbyBwbGFuIHRvIHN1Ym1pdCBhIGxhdGVyIHBhdGNoIHdoaWNoIGFsbG93cyB5b3UgdG8g
bWFyayB0aGUgY3JlYXRlZCBzdWJ2b2wNCmFzIGRlZmF1bHQuDQoNCj4gQmVjYXVzZSBpdCBpcyBj
YWxsZWQgbW9yZSB0aGFuIG9uY2UsIHRoaXMgcGFydCBjYW4gYmUgcmVmYWN0b3JlZCBpbiBhDQo+
IGRlZGljYXRlZCBmdW5jdGlvbjoNCj4gDQo+IHZvaWQgZnJlZV9zdWJ2b2xzX2xpc3QobGlzdF9o
ZWFkICpzdWJ2b2xzKSB7DQoNClllcywgeW91J3JlIHJpZ2h0IC0gb3IgdGhlIGVycm9yIGxhYmVs
IGNvdWxkIGJlIGNvbnZlcnRlZCB0byBhbiBvdXQgbGFiZWwsDQphbmQgdGhlIGV4aXN0aW5nIGNv
ZGUgYWxzbyBkZWR1cGxpY2F0ZWQuIEknbGwgc3VibWl0IGEgcGF0Y2ggZm9yIHRoaXMNCnJlZmFj
dG9yaW5nIG9uY2UgdGhpcyBjb21taXQgaXMgaW4uDQoNClRoYW5rcw0KDQpNYXJrDQo=

