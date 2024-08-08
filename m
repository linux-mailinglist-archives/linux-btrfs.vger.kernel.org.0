Return-Path: <linux-btrfs+bounces-7051-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A95F94C34E
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 19:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D2531F2158F
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 17:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4CD18EFD6;
	Thu,  8 Aug 2024 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Q8uJFQ3f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612E318B471
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2024 17:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723136689; cv=fail; b=Wk6LNFiyG5JZ7gqnymeBOgmvwj6yQ8XIrCrtgOuNb50A87Q1N0BTpUpdNiDHDCV4W5Rn6d22+qOA5lknObVDTrWRTX39hxXSSmzNDm9CyQA/z+J4V1uB8f3GpnTUo/Ee8soakiLvANp1yKjwCR3nfAq4RPITHHUNB+Ybi6UalX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723136689; c=relaxed/simple;
	bh=FFmGmzOGarTWC/QZfa9XpomyDrIk7kR3Gyow2qtK5s8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HM490mXtx3u86DtAd/LYJggqs5Fagb4UIfZyRD552LimZtl+me1i0FKlUNJU9IbjV6qKTMaE1netw5Y4ZJuYaHkqq1hN5yYLdOjYv2Lr2hmiS7UmPkH5gsxi5dc7fPx67qo+PXePqe8BepRtbpM/SNuuL4kycKUTOU6mppnEeRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Q8uJFQ3f; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478G9O7I021041
	for <linux-btrfs@vger.kernel.org>; Thu, 8 Aug 2024 10:04:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:subject:date:message-id:references:in-reply-to:content-type
	:content-id:content-transfer-encoding:mime-version; s=
	s2048-2021-q4; bh=FFmGmzOGarTWC/QZfa9XpomyDrIk7kR3Gyow2qtK5s8=; b=
	Q8uJFQ3fdAMOYeKueCRlnuNCOqfq9aISQaabxiXL5RJNcBQw0LtXRed7vme597Ew
	vxiyUAj3muXeXRqIxEN+eRKUyFo8KurGPUmPYwwTnnklR42XQnDhbXxP/ZGwFBOY
	CCwpeEMvNGygSBaYxhUKG85rMJG+0crz4NkG2TEzviH85bW8Kn3bPpu6VJCXLlNZ
	VL2Pf9QCEYmnicwRBF56bCcaQkI8O7THrtiM4yZfY3cLtJ475LsjKu5vd52Xqye6
	iZ8Pq0Aow8EMHXUS7nFBQGAuRxAFYEaM6A4CX3EEuRdGYQvPpjsxy2gpmyohXcRm
	ogXuv46V1eaCem7ivxRiAg==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40vjdudb3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 08 Aug 2024 10:04:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPsBt2LLpN9cW9g8YtDRPxfGNUWe5Cag9/hy7fUjbQryM0go7kgVw9MQaFkPYvFW9aYsHih9PMnNeGMPv+uyRq8NZUxLqSANR1WR/1VbaNvaN3t6eNqhVC68XyLeRatnT3nW6VcavLo04m99n9LZIRJRoYDLA5UyfvT5x5itp0HialrmX8yQ1AUbXlYpurFP1qFMDWG7S0FJG4z7kGHBbZV4M2T/G6QjfU3cttGnp9pz9N+PNVogeIEHLo2MP5QQHs3O79LrZSDbHvpiYYANquvOS5wzR9IZJGr6w0PiKTPp6zaL16YlaOSJjf9c+6IpDYOlX7eRYHtIhvvL4xU7GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFmGmzOGarTWC/QZfa9XpomyDrIk7kR3Gyow2qtK5s8=;
 b=cel9jSIuyuabVerI0cJjfBXLUQzp7Uaal7LQxNojuQG4x+/+khrXiU45mtYvo/qsbY8OnCWkeQUbAyt9xfPaWtXgD6Aa6aUAEOAVjjcbzR617tETfDenHzJhQcDYXNqnduYANeozFI/y8e8jPHAj3SwVLpNEeNgRMP7USEYEw61mDqIgiWjfR2ZY97JLkawBLQVG54GO4FKRxysgu5RD05q9pjhnJcBnSkDwvzGJFJUdAEQhIm9Hpha/jnTIImuYK6iN7SVg2VlM4/NUPxNHs+5ZTfrzsAVJfzjJdwUis1ARIw9eWBFGYv+l4AZNKgYkhxS4w8XNplYAZP4rBjK8ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by MW3PR15MB3865.namprd15.prod.outlook.com (2603:10b6:303:42::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 8 Aug
 2024 17:04:41 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%2]) with mapi id 15.20.7849.008; Thu, 8 Aug 2024
 17:04:41 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4] btrfs-progs: add --subvol option to mkfs.btrfs
Thread-Topic: [PATCH v4] btrfs-progs: add --subvol option to mkfs.btrfs
Thread-Index: AQHa6NzkMybiEKjqSUqwug5dkAqnGrIcYyKAgAE1QoA=
Date: Thu, 8 Aug 2024 17:04:41 +0000
Message-ID: <231c34dd-43fc-4829-82d7-94a6f9886691@meta.com>
References: <20240807151707.2828988-1-maharmstone@fb.com>
 <80981aba-5434-42d6-9180-5ecf2625b3ba@gmx.com>
In-Reply-To: <80981aba-5434-42d6-9180-5ecf2625b3ba@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|MW3PR15MB3865:EE_
x-ms-office365-filtering-correlation-id: 76e03c5f-6410-474b-8557-08dcb7cc31cb
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TGg4bWhWSytueno1ZEF4S3c0YlpWYXd6M0I5cTNZdzRWckJuTHVMRWgvUkJW?=
 =?utf-8?B?NXl5aXVGaVRMMGFxMHVzOUV2SFRjQytxRk1lRko5aHR2cGpra293VWg0K0Zi?=
 =?utf-8?B?Tk0rT1RKRUtNdmIwWDNtaGZIR095aTZDRm1TbUQ2VVRPcnFPaUI3Tlo5bzVv?=
 =?utf-8?B?MGR2b3Z5N1FHNjNnUnpHWi9EaDhFTkFhaHpZK01wOGtpdzE0Wk5BK1dNMFJJ?=
 =?utf-8?B?Y0d0cGNYVnB4MXR4eFdHdkVVN1ljdzJFK0JOOENUclRkcW5CNlhzdDlpanp6?=
 =?utf-8?B?YytzT0VTY2FXLzVsK0lEeWw2MWVES1JmZTZYRWVoTGpVU29WTDU2YWJDa082?=
 =?utf-8?B?VzBrRW9zYlpwOXFBbkw5aWJiTE9SZEU1eEZRVFZhZ05PZkZkMmF6VUd0UmpP?=
 =?utf-8?B?L3RVWnoyMS9PRlJ0MU9SYk14V1BOemlMQnF5WGs1dXJPSWdLdU0rdlJpY2k2?=
 =?utf-8?B?R0lMZzVWUjRnRkh2TDZvZkkwcUV2cEM0MDc4TG9oVzVDUVN3Z1hucjIxbGt4?=
 =?utf-8?B?UEordXM2U0ZhYTAxOFRBNG5vODNvd2VMeDZhbHlYQ2wrcy9ETVJmWHZQVjE4?=
 =?utf-8?B?L0ZyN3pONjFSVldhYjVwdGtHR09GYWFoNTNGTTVrL21MVWRVU2VHN0RkWGJC?=
 =?utf-8?B?d0lrMk1Rc0cyV01CUDk2WEpzTlhnQThxQTF2ZC9oZWQ5dmptTllwTG44YmhZ?=
 =?utf-8?B?Tk8wNU8xT3Qyc1g5cFliQlBnQmVSY0NZZm55T0hnNW5HUVJ6dUVCbVcwTDVS?=
 =?utf-8?B?MnVob3I3WGRaTzd3YzZXVjRIWEl2SWNGSjhpVTgwVGNZZm1mQ0hSa1g5cGE0?=
 =?utf-8?B?K1NCTmJoM0F5TzRYYkpuOFg5NTlBL2w1eStYbkttdHpzVW8zT1dZdC8vUmhk?=
 =?utf-8?B?N0tXeXVKb1YzSTFxQ0JCalc0alZoZWs5eHhqbmN1NEdWbUxLT2hXYlFpNHhw?=
 =?utf-8?B?U1daYUJpd0ZXZXl4NCtoMDl5RThMZ1Q3bUpSZE5PbTJ4Uk1PaWVtNENoOHJ1?=
 =?utf-8?B?Mmh6STJDNmx5c25sT0d1OStKaElwSUpRRUQ3bTZ5VGpYVUN1K21YL2haOEEx?=
 =?utf-8?B?dFdrNDVLMGs3RDJFUnJpY2xhTS94TnRlUWZhUU1PemJnTmptWE5USlZvMnBv?=
 =?utf-8?B?QVhtaEppYW1XVEtXOU5vQWlXMU0zQTB3VkI4dk5RWEpYRHVXdStKeTdOclBO?=
 =?utf-8?B?bGNWSHlhZzY0U1JEeGV6d1d6bHdieXprb3l6NjFiaU1HMEdJUFhTSFAzdWE4?=
 =?utf-8?B?SGlGR3FJRjlNaEFScDJHeE1HSjFnZzhHK3NoSTJZOVg3UCtFUGpWT2NPUUpH?=
 =?utf-8?B?WXJqclBwWFhvdmhrT1VCaUlvYVBPYWx3dFlaZlRiOHdLRDBsU1BZSExSVzdk?=
 =?utf-8?B?L2dVanZzRlBiV0hIbmZkSjkva0hrOEc1YnhKVktjS2ZUZGZablUvT01wR2k5?=
 =?utf-8?B?T0p2dVNtN2RTSDQ3UlAwTnIzeklobUNOMnJZcmt5UkJVNmdCc3hRdElRR2FE?=
 =?utf-8?B?OHpjQWNxN21FTXEzcllpRzVWa3R0T1pUWXcwS2svL1JPQnpBc1Z6Z2RFM0Ji?=
 =?utf-8?B?VlVrUnRYVEEzMkFZK0NRQWtPMndxalpEb0xQWlRlRldJMERaY2RhaVYvbmNr?=
 =?utf-8?B?dG1SZmZjVnF3QXdmdHhOenpCU1VCaThtMnN2S3Q1SmRaRVdWaklrd01IM3pK?=
 =?utf-8?B?Vk95d1R1bGFMd2F3K1g1akNZN2o3UFNrWkxOYVZWbDV1VU4vM2UyNU95YWE3?=
 =?utf-8?B?VklndmU5QmxQdmtsZEM3MjFsLzlra3F3cHVRN2RNU0hOTWNTTHI0Y0VrbVB5?=
 =?utf-8?B?dGJxZGlhVTdxZkIvTElYNGJ0SXBRdWhBcGJOZ2ZqMXJzdjBxdVVZK3FnTzV3?=
 =?utf-8?B?V2NrbXhkVXFxYzlDZ3pZeEwvTG9KZUxIbkx1ak1wb1FzRUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWxBMXlQUmd2TDRuMWdPSEtxaTlVVUJMbm0yWnQ4MDJydHNka1BXZG5hRnRu?=
 =?utf-8?B?WDhzdllRUzE1RVFlOVdPOHdYVEhBSHJiMkowWVFsTHVMR0dlS1Rod1U2bTdj?=
 =?utf-8?B?NWpqWUFqNTFTZ250VndIT2Q0YXBKWm1GMzR5aGsxYnA1RjBDN21kZmVRVW5Y?=
 =?utf-8?B?ZEp6WDI3MGhmTU5zc1l1QmkrelVjTmxNUzh3aU5pbldQUUZXNUNJdE9mRWQ5?=
 =?utf-8?B?ZHJBRHpiY0ZQczhlaGlyeWQ3OEkzaDZRM3BCdlNkNzBwL3BndWpRMWVoQzM5?=
 =?utf-8?B?OGtoY1hpNXFqNytTZVNubFBxRmk3ODhFVUpJK3drZTNGWHpDaEM0M1ZndllE?=
 =?utf-8?B?aHRSbFpWU0JKVDJSRHFac1pCd1VWYlhvRzR4Ukt6OE5GdzBKQ1VRYlRaZXlU?=
 =?utf-8?B?WU0ydDJueklPVE5SeWxnY2RpdlRMZG5WemdMQmFJU0NxT2kwQTJDQk5yS3Vj?=
 =?utf-8?B?SUN5eGUyekNsd2xzOENDVnJQbzhuMTU0eE44Mkx0a2pnWXRTckdLa1ltdXIv?=
 =?utf-8?B?SDhXMkpwTjBQcFBZVHlkMXdYSjVUYS9wSjY4RmNRTzB4OEs2VW83YlhQMjQv?=
 =?utf-8?B?TnViSWJmbzVKRmVzV0ZZdkcrTi9yOHQ2WXUxSU4rb0VpUmdyTjkwNnhNUmI3?=
 =?utf-8?B?Vnh6TFVzZk1hL0Jnb2lDZ0JxaTR6dGdnUS96WlFCMkFqcVpoVjg2Q2lvaVZ5?=
 =?utf-8?B?elN0RWVYck1kcmxJWXBTWFVJaHE4Z3NXTm1pQkVSUmFta2p0bkJkemVHQkox?=
 =?utf-8?B?bHd3ak9XeWJ5QXg4TVVIMFFGRVBGTHRnVnlYTzU3MThsZTRrSWltZ284NjdL?=
 =?utf-8?B?cSttT0VKMVlPSk9kVFFjbUNmSGNrQWdpVnJuaGFOWFBtd2p1bWNjcFl3Zk9U?=
 =?utf-8?B?YnlVNFU4YitYYWlueWttdFMwNlBmUUNRN1FQbnByU3JkMlo1M3IwUWo2UUd6?=
 =?utf-8?B?Y21zcVE4Y01iVEY3VkpXVHBFQUN0aWxZZXpld1VNS2NueTRJZHNONVFpa3pG?=
 =?utf-8?B?MXFseDJZVFp5YlFIakFNU2NXREhmc1U3eGM1SkJNZ2dOMzBldUFrazNodUZo?=
 =?utf-8?B?OFYrV2RXOXcyU3ZDYVNNUGtSZGhXbW5lYUlIUU1vLzBQamFvc1h0RFZQWE5H?=
 =?utf-8?B?L05rblhxVW04YXF0Umo1U09LY2ZnYWYzWUlST0RVbEozU0JyMHFNaERlNEFO?=
 =?utf-8?B?ZnZObjNuUjdmeVpaTEJKMk5MY05TSXJpZG1UZVFpek5TSzZRU0YyOUJqVUpD?=
 =?utf-8?B?eTZIQzZQdXlPa05yZTVPNDFLOGdUYUZlUmhzWmlFN2FiYTQ4bW82aWF5dGcr?=
 =?utf-8?B?VGFaT0VzMkpXQ3VwN09NMEFrUUM3TzkvT0ltREdKUHBRUVR5L1ZhYmVZZDRN?=
 =?utf-8?B?VitFOVBMSlA3b0RTaGVnaUMxalIwM0tCeUh2dmozVjdzRUdCalhsT3kwVlVY?=
 =?utf-8?B?NzBPSG5saTR0UG1CUTRIYUVISnRkSGdrMEtGTmttdFM5K0IvMmdLbzNEVHc5?=
 =?utf-8?B?ZFpNRVFQQ0cxUWR2ZUMrZytPUnA3VlZJWlRtTzdQOXdKOFdQYkphN3NmQUhJ?=
 =?utf-8?B?QXIvYW1ycU5sTnhJb3ozc2R2T090cTYzNnVBQkt2WUpWYlNkaEtFZjdYcHpo?=
 =?utf-8?B?Y3UzNEk5U1JrNWxhTXkzU1hydDZma3RmaWU5aHhEbjV1TEE0YXVuOGNFZW11?=
 =?utf-8?B?TWlLeW50YWk3UTYvOTRsYzMwU0VvWnZIUDJXREJWWkVnL05ZUHpQNWJpbGlC?=
 =?utf-8?B?eVJBVWJnQzJHdzVHZHgrUHlESFl5QnhVY0JmcDlNTlQ2ajV6UE40R2hjcnZ1?=
 =?utf-8?B?eGQ1d0R4KzNKOUQ0SjlGQS9scGU1VTFNaE5ydVNGQWRtWDRKWU1uQy9TcHd2?=
 =?utf-8?B?VGtnK1h6TnZBTWRjMXRnclpOSkMwaXVRUXd2VFA4aWdoVEZvdXNIaGNuVXVy?=
 =?utf-8?B?Vm81bGlHaTQ2RVZibnorWGJKcVZrYXZnUDB6UGVtbGJIcmRHdDlQMXVXZzVH?=
 =?utf-8?B?MVRkcFpvbnpIcGVub0xhRUlPZXVXd1VkRjF0YmdaSFludWRSdVFaQTRSRmww?=
 =?utf-8?B?Yjh1Q2NKSktTRXVsZElHSFNhNXY0cHgxc1NZbnFGS1J0eWZLOVRuVFZKZ0lh?=
 =?utf-8?Q?ij3k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32EE6959D5FAF34F9054FB616640B818@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e03c5f-6410-474b-8557-08dcb7cc31cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 17:04:41.5786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J5FzcrtqjyYTfnn1PPU/6OQpATTeO3nqG2sNEii3ZbZR+nq/HquRi5nbY58Cl8wBMc6rAWRMCoV3KVe9NnQqyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3865
X-Proofpoint-GUID: Mf56SwRGbkuK7ufMDM24xDRqGjf1fvgL
X-Proofpoint-ORIG-GUID: Mf56SwRGbkuK7ufMDM24xDRqGjf1fvgL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_17,2024-08-07_01,2024-05-17_01

VGhhbmtzIFF1Lg0KDQpPbiA3LzgvMjQgMjM6MzcsIFF1IFdlbnJ1byB3cm90ZToNCj4+IEBAIC0x
MjcyLDYgKzEyOTEsNzcgQEAgaW50IEJPWF9NQUlOKG1rZnMpKGludCBhcmdjLCBjaGFyICoqYXJn
dikNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSAxOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKg
IGdvdG8gZXJyb3I7DQo+PiDCoMKgwqDCoMKgIH0NCj4+ICvCoMKgwqAgaWYgKCFsaXN0X2VtcHR5
KCZzdWJ2b2xzKSAmJiBzb3VyY2VfZGlyID09IE5VTEwpIHsNCj4+ICvCoMKgwqDCoMKgwqDCoCBl
cnJvcigidGhlIG9wdGlvbiAtLXN1YnZvbCBtdXN0IGJlIHVzZWQgd2l0aCAtLXJvb3RkaXIiKTsN
Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXQgPSAxOw0KPj4gK8KgwqDCoMKgwqDCoMKgIGdvdG8gZXJy
b3I7DQo+PiArwqDCoMKgIH0NCj4+ICsNCj4+ICvCoMKgwqAgaWYgKHNvdXJjZV9kaXIpIHsNCj4+
ICvCoMKgwqDCoMKgwqDCoCBjaGFyICpjYW5vbmljYWwgPSByZWFscGF0aChzb3VyY2VfZGlyLCBO
VUxMKTsNCj4+ICsNCj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIWNhbm9uaWNhbCkgew0KPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZXJyb3IoImNvdWxkIG5vdCBnZXQgY2Fub25pY2FsIHBhdGgg
dG8gJXMiLCBzb3VyY2VfZGlyKTsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IDE7
DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycm9yOw0KPj4gK8KgwqDCoMKgwqDC
oMKgIH0NCj4+ICsNCj4+ICvCoMKgwqDCoMKgwqDCoCBmcmVlKHNvdXJjZV9kaXIpOw0KPj4gK8Kg
wqDCoMKgwqDCoMKgIHNvdXJjZV9kaXIgPSBjYW5vbmljYWw7DQo+PiArwqDCoMKgIH0NCj4+ICsN
Cj4+ICvCoMKgwqAgaWYgKCFsaXN0X2VtcHR5KCZzdWJ2b2xzKSkgew0KPiANCj4gV2UgY2FuIHNr
aXAgdGhlIGxpc3RfZW1wdHkoKSBjaGVjaywgYXMgdGhlIGxhdGVyIGxpc3RfZm9yX2VhY2hfZW50
cnkoKQ0KPiBjYW4gaGFuZGxlIGVtcHR5IGxpc3QgcHJldHR5IHdlbGwuDQoNCkkgZGlkIHRoaXMg
dG8gYXZvaWQgYSBzdHJsZW4gY2FsbCBpZiB0aGVyZSdzIG5vIHN1YnZvbHMsIGJ1dCB0aGF0J3Mg
bm90IA0KdmVyeSBpbXBvcnRhbnQuDQoNCj4+ICvCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qgcm9vdGRp
cl9zdWJ2b2wgKnM7DQo+PiArDQo+PiArwqDCoMKgwqDCoMKgwqAgbGlzdF9mb3JfZWFjaF9lbnRy
eShzLCBnX3N1YnZvbHMsIGxpc3QpIHsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICgh
c3RyY21wKGZ1bGxfcGF0aCwgcy0+ZnVsbF9wYXRoKSkgew0KPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gZnR3X2FkZF9zdWJ2b2woZnVsbF9wYXRoLCBzdCwgdHlwZWZs
YWcsDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBmdHdidWYsIHMpOw0KPiANCj4gQW5vdGhlciBvcHRpbWl6YXRpb24gY2FuIGJl
LCB0byByZW1vdmUgQHMgZnJvbSB0aGUgZ19zdWJ2b2xzIGxpc3QuDQo+IFNvIHRoYXQgdGhlIG5l
eHQgc2VhcmNoIHdpbGwgc3BlbmQgYSBsaXR0bGUgbGVzcyB0aW1lIHRvIGRvIHRoZSBzZWFyY2gu
DQoNClVuZm9ydHVuYXRlbHkgeW91IGNhbid0IGRvIHRoYXQsIGFzIGl0IG1lYW5zIHRoYXQgdGhl
IHBvaW50ZXIgd2lsbCBiZSANCm1pc3NlZCBpbiB0aGUgbWtmc19tYWluIGNsZWFudXAuDQoNCk1h
cmsNCg0K

