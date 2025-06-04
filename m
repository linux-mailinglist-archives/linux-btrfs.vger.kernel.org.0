Return-Path: <linux-btrfs+bounces-14466-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA56ACE64A
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 23:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44E33A9EFE
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 21:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1DA213E76;
	Wed,  4 Jun 2025 21:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lw6v1CKH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0LTPGTQT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C775414E2E2
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 21:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749073745; cv=fail; b=NqTpa5f/wvHNwkyQNZpln1ouSJGcM0wox1XH9eZ+EEYjrcBUYTg3UPBmqvEsE627QM6qkfLDorNkoQzLzWSfvCNqxwiGNZXfNvE6mRXsRc38WANPO5++nk1npL+/W0IfL02yrDjGv2ncLbn2N6/wZ1X+gm2WhfgsBNZbPtVG7kQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749073745; c=relaxed/simple;
	bh=QZKgI7g1uHR6254M1kCv5W/e1F98m4085a0GXATDYsg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UZq6TzA3IkRO8TpRD4SlVGsvy/VKhexnw6jJMgvZd4VWxQ9NGNiS1zbOkPNJf7UcKnTA09DsuHL+W27aOOjYMgfnofi0sG11neGSX8EFpfERESRf/jemy7PyuzStOUEpIuX2UIJSUOeVQTFcAraYFm+QKgFLJfxWHSV6rqFENho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lw6v1CKH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0LTPGTQT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554JMbEN002532;
	Wed, 4 Jun 2025 21:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NjmxKVKCcD/ouvm7tB7tMfSlWux2zjHnQRyWRo7bhwk=; b=
	Lw6v1CKHdIzGrRzSmVFaF3nniNW7ZU9zWwxCY1W0GJNshWZT2kTpfyVhB4iV715E
	iAW3u7oawpXm0PdkPhPMGS8EiYNDR/Dz0B51qwNIHWMGvIUOaSsbGsSfRbA8md5w
	lgEc27fdilVPvOmeMTxzzHboR5ax7XqexIMWXfn1LLi7KBa+EtDhZ4b+edCX2KVu
	bqVMLRz3uQJZWK/tI8AodvpZ3wLvZ/6xij274pVeCMtWtNMe8pqcUWkNYXRduJC5
	H5ohGYfgEMblcMlaxGRztzP4IRpBCB3gpKz53QbKbF9F1oUORjQd+dL58PzGcojA
	fhUspGFfplXh+toAOVneQg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8bmw8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 21:48:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 554KP2Nw034422;
	Wed, 4 Jun 2025 21:48:54 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012047.outbound.protection.outlook.com [40.93.195.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7baed6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 21:48:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1QnxB3NTrxuqRafAr04vAS7SqQFXIfWL9OQ0ZFVn+Xe362aK8tor2V5bWwZgL0NtvQbObIrrYFm53WeoaSQXPXQ2GNDWTwvHweZFiPuREztERMerNDz6WiOH3fqgD/r6VzsJwcZWraAJa+gocWMgRDmg85HilRXVOhSUTFCQwsMiNJyG5O0WLlYL8JQ4y/4esJwBhEf+AfgYRFhiZMxCtdzB14fNghbG/jDynKkQJubhhy7pl/+tdiuuzHS5MmimQcW09FDp5MXnUCfAOj6NJXTFeago3ZHTg12LDNpjEI3JQ+gFfUh5TmjQfSdId4F0uljmxtTdP3UJZEBwMRMPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjmxKVKCcD/ouvm7tB7tMfSlWux2zjHnQRyWRo7bhwk=;
 b=fvVC2tYFDQBzYWdvgwI3cHwgBDniclHyxufmLZkKAqP00i0PrZ5VkABzKLt1aU7jP9NGt9Sccul/wBXWSVnYXBX0gH8Ip6KzG5dazr5ceXjT1FJivCFxOrSJF8O5nOHG0kIcblE8GJYOtAjVv2zGf/d1t0opYeJavHoQfxHpIjkNeb0RwNSnHDI3RFGaw/u+KUPsuF3YmPJ+IcRzNlcgOUOpwh8qztEAUTnM0qojVvfGMLtQCRgDYWjub2PdYc4zdjUuw0fnOUQMq6nObVnSTNa2cFgJup0aMhlzB02gRWJS4X1YUnUqZrt79FDveBlyfUYDNHVR8FJmWH4QMgQGEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjmxKVKCcD/ouvm7tB7tMfSlWux2zjHnQRyWRo7bhwk=;
 b=0LTPGTQTAFMesMGstCM7BZRQPvd7uvQOdmn45Z3Fw6dAvUTycXiFKwSl0pDRt3WAOnpJsqyDyM5MidwGy+nsq4nEP1hO+4JcVjj4FcmEDDQNjenBSzOPTDnS+jPZP6QNv6XhpbLxRolVBuzscEtrtxicf7wOKh22aRhrj9w9EQU=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by CO1PR10MB4801.namprd10.prod.outlook.com (2603:10b6:303:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 21:48:51 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8746.030; Wed, 4 Jun 2025
 21:48:51 +0000
Message-ID: <ae989905-7d21-43f6-b327-76c64c2c7658@oracle.com>
Date: Thu, 5 Jun 2025 05:48:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/10] btrfs: new performance-based chunk allocation
 using device roles
To: Ferry Toth <fntoth@gmail.com>, linux-btrfs@vger.kernel.org
References: <cover.1747070147.git.anand.jain@oracle.com>
 <fee4ece3-b5f6-4510-89d0-40f964da2720@gmail.com>
 <67bf4ef7-6718-4ab8-85c1-8b8035a8981e@oracle.com>
 <4ca355b0-f4d8-4e84-80b5-17e5a42e8273@gmail.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <4ca355b0-f4d8-4e84-80b5-17e5a42e8273@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|CO1PR10MB4801:EE_
X-MS-Office365-Filtering-Correlation-Id: b8939dbc-26a4-45dc-8bf7-08dda3b1981a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUU4cGtYTnRQZVoxQ25qR1dxdmNUWGs4UVdab2xNZlJVMnVnUC9rSDdUUXd6?=
 =?utf-8?B?S2dXdzk0MmNvUzVmMW96Vm1hQ0ZndHhUL2FnTUFQVXBraTI0Nkt5cXRuaG50?=
 =?utf-8?B?NEVKQ29jTTU2UmdVL1Arcmh1V1Urdjl6UkE3OTJ6VGpDQ3Q4RE5LTFF3bjBU?=
 =?utf-8?B?ekhrY3hzRUtBTlJ2Tm1USjNjcUkzQ05zbW9XcDJ5cnlQS1REaG9wSURIalE0?=
 =?utf-8?B?SVV4YlUvdlNkcmVTZlI1MnErWTBaTE5NRmZqNjVkSVF5YmI3RGp1U1lwZ3dl?=
 =?utf-8?B?VCtjN2JxV2Z4SVNJSWFEMnlHVUxURzRmZWNIQW9JaHQwcTFVbWRKR0JRS2Rz?=
 =?utf-8?B?NzhTZERlRDNpU2JTREszZGd2bzZEY0NBRUd0cGlGV2tFa0tQMTJGZFgyaGtL?=
 =?utf-8?B?eGFqOTRBbDdUb2JwWWtxdDgza1ZOcWdrV01mQUZYM1hNVUFpa3ZyaEk2Y0J1?=
 =?utf-8?B?djluVi9VWWF3aG85KzVSbjJqbkE1Z1JEb3hKUW4rWm4zTG12eXBUZlJQQVp0?=
 =?utf-8?B?cGk4TDJPWnJNR0JTVkVIcVZuZ1EwakFOSFhwSGF5bkRjY08yNXRHYjRvVzMx?=
 =?utf-8?B?S1RtSnF4NGJuTmRWSVFQVXpTOGJpYmRrdXczeS93S1YvYUxCOFV5d0lzUkxB?=
 =?utf-8?B?YjNYc0szN2dML3pXL3UyajVqdUFCUGJLR0VPYUZjLzRKZThIUldYYTF0YlR6?=
 =?utf-8?B?cWhDWDFQandrbXVrcG1BRmVhZnJwQTVOVGFBaS93M1l4U1MzZHppR2RLSHMy?=
 =?utf-8?B?Nk1hejdvZkt0YVVrN1hNYlNKblBMYXY3d296UTdMR3diRGxBWHBJcTZHSE0v?=
 =?utf-8?B?d04wQmpoZnBPeTI3NjRUUjFqRmxJanpHdjNVZmhoeGp4cGNiUEdWdjQ1S2cv?=
 =?utf-8?B?NVNZdXphQ09pTVJqM2JPcFliR0RxTFN3R1VqT1RWZDRuZVRUM3lqeVRsWEZY?=
 =?utf-8?B?SW1ia3hwbFRDVi9FTXVMWGxvSmhSWXYxYWlnSHkzU3pyOG9RVjJWb2ZXcUpm?=
 =?utf-8?B?QmFCOVZ4WEVZck95b3FxcWROUXNkaWRuZmRUckh0VGF4eGJrOEhFSzhDREpa?=
 =?utf-8?B?QWFOemx6bkwyNTVQOHhrUkxvME4rVkFiWDFtM0tWQUVoT1ZxY0hZYy9qYVJi?=
 =?utf-8?B?NHRaa0pMNHdtdFZ1UnM5QWlXNlJzLzBQc1o0MmplVG5jbzRtUlg5d0h6cDg0?=
 =?utf-8?B?NGhJaVlBamZZVk1VYU96NHRUZDM5L010MkZqanZiN3FBMGh5WnFqUEpzcDhz?=
 =?utf-8?B?L1FEYXRIWVYrWGoyeTVadlVzMUhMTkRWakZzUzJUYjNIczB4VUlZbk5KdnI4?=
 =?utf-8?B?YkxQZnFFNERTY3k2NUVlcHpjMmFTVTJBVC9xOU5TZTMyN3JTQVc0SmdrWjdY?=
 =?utf-8?B?NWRLWWN1N3hJblpTeDZ3bEZ1TW9tZkpMbU1NZEk4d29SWmJrOXJIaEd3T0JN?=
 =?utf-8?B?TGROUXFqRzRnenNJcjZEVEtHN1dFd0dlb0VNMkdwWTZlY2hBaHJRQVduZmFu?=
 =?utf-8?B?REVIVW5zcHZrUmxUNFFmQ3ppOG90bU9hNWJ0MmVsN3BBcEtBTEN1YlpaMUVM?=
 =?utf-8?B?R3FHUmFJSjBGKzM2L0Rab0RMVVdONVBlTFRoRkJ5MGdhWTlyOHVMVDBpazQ3?=
 =?utf-8?B?d25ZRHJIeU03YndDUk5wT3l0ZXB1bzQzNkVlb2Z3c3ZhUzBITWl6RnNzdjZ1?=
 =?utf-8?B?dlUzRkFxWVFvZDBkUTlJUGFoSTBSSnlSRmZCdUNpVGIvMzFuTjQwNmdMRTVm?=
 =?utf-8?B?UTNVYnNpdERzVEh6TlhUQTNKampIUGZTTnMwL2ZRQXltS3o0bEhxMG1WN0tn?=
 =?utf-8?B?YjFrMUFTWGZ6T3ZPeWFDK0Q2ZVJsak5INlhrakt6MFE2dkFPaDc5SlB4UzZz?=
 =?utf-8?B?eWF5NHpXUFZqb28zeVV2L2lleklrSENmZWlacHFFL3FQV2UrakxCRWRYcWM0?=
 =?utf-8?Q?25u+zUNBcy4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGtiOG9YOVQ4dTF2cm9iYnRScTBPTUN2ZTl3cHFNdnFvUngwL2R3VU45MWZS?=
 =?utf-8?B?TjMvZ3NIN3VRb3dRWXdPeU0xM3l6L0xnRWt6TzhLR2Z5QktFaGhPdU1wMlJZ?=
 =?utf-8?B?MkRLaVpMeEcxQkNpV0JqZURKQUcxNUw4VStJTmVlRklURzZlMjFnVnpXUWdi?=
 =?utf-8?B?OEdTRFkxQWUwM1lJMzVZNlFGTUtzb0dJeFZrWVZVOVBNQjNxdjNKV09WdU1F?=
 =?utf-8?B?bmRGdElGMW5MZDhGUW50bVFpbzNJMTJ5RVgyajlYbE9IQVFkZjhYejZZV1JS?=
 =?utf-8?B?UVJ4UjM2cjJ1cVdiMCtpbWpqallTUXV2eWUxNlRFakphSE9raTNFQ1Npbjl4?=
 =?utf-8?B?cUlZYXgvZVVLVTdrZ012K1M0ZzZuUWREeUtENzVNellGRWMrdVNiTytncUZM?=
 =?utf-8?B?M2tKODJta3BXd2Q0K2xKRWlRenNWdW9DbHB1L21DdWVRQkl3djBvMHJud3ZM?=
 =?utf-8?B?L1hTODhGdHlVeWdqU1o0SGpkVzNYTFZSbjdBYnJhdjQvclloenJwbmxGZ0lZ?=
 =?utf-8?B?VHhPT3Y5OVJYSVpLaytFUDNhWi90Z3QrK2ovdDVtbEg0cDhsaVJCUDNpaitw?=
 =?utf-8?B?ZzZGQk5RcFZNWmZNNzlGT2c5UmVpR0ZRUHNRak9NQ2QwNUxCMkRJZkM3OEJW?=
 =?utf-8?B?WFNwSTgrVkZ5ZEFGUkUvK3JGc0R2MlBUUXB2K21oQ2FmWlFXVnpBUUNCNHFn?=
 =?utf-8?B?M0ExcElZZlM1SktlN0oxanB4Rmg5STBmNmNaK25pSGVEaE40NkczUkkrL3dB?=
 =?utf-8?B?cHFDWmNjZzdYWFVrNlJJMjdPQThuVnhheit4YnB2SkVET0dZODZiMC9nY0pl?=
 =?utf-8?B?L0picXNkdS9WVDk5WHhwZng4eVNlTVh0eXpza3hvREoxWHVnU1Q0aVBBTzIz?=
 =?utf-8?B?MTlhUXlSRk95Y0hteDNrT05WRHNySnM4T1dlNXV5aTNBTktvRWFZSWdlNGQ3?=
 =?utf-8?B?eDdTdXNxNmFPdFdIT1l1NXJwdjhUdFFQc2FULzdNRGQvbkxqNWt3Z3A0MjZt?=
 =?utf-8?B?VHQ2RXlPa0VTUWdwZTFXa0NkcDZVaUFmckJEU1NSVDk3S0FMUmlHQVBZeEM2?=
 =?utf-8?B?eUtFWnlnSVA4Z0VPR1gzRTRsK01OT2ZQdnZCcStwd3pPQUdHcERiQ3NwVXZT?=
 =?utf-8?B?dXdWZ2dCZ0Q4ME5IMlFXRFV3WTNvNlRSa2hPcTRrbEpuWTB0RDBlYjdxRVFu?=
 =?utf-8?B?Y1FKOHU4S0ExSWw0WDArSEEzZEpPSjNuSGhQUmNoUi9wcXRpV0tBYW5VTlFX?=
 =?utf-8?B?QThZWE01MGNRdStDMzJvWGRUcDFROXRaeXhxN1FWcllLTnJKUXhESmJPcUM5?=
 =?utf-8?B?Rjg2R0FpeWZrWS9LV0sxT1d3WkFXK05id01xTmxMZHQ0UXNZUzlGV1hhZHlC?=
 =?utf-8?B?TVY3TFg5Smh4VlFaZW1YbFIvUDFpaUVPNDJyZ05mWERyM1YvT0N6Y2hUekhJ?=
 =?utf-8?B?cTdCNUpGOSs5U3dTOXRwQXl2QmVscU94VDBCVm9VNUZiVWNJOGVaaTVYZjFt?=
 =?utf-8?B?NEc1Wi9RcXRaM3JpQXQ1N20zQWxGeXJmT09KcFhNNTNBcjdsSkZhdXdEM0FD?=
 =?utf-8?B?Y1BnSld6cW5tNVNTM2t5VDlDR04zcHVlQ1piS29OYWk4dUJjbHZRbWRuYWtP?=
 =?utf-8?B?UzdGeDRGS1BSenZmQnZvbm9YdTBaMEFjMzdvc1h2Z0JpYjJkb0F6S015cnNN?=
 =?utf-8?B?RTlOYXJLc2dMZ3p4K0VrMEdzZGpTcko5MC9hcjl2ZHk2S1dMZHJHZldRcy85?=
 =?utf-8?B?cHozZGRwQlZsZm9EMGVCQURsb3R3VjZxbU5FeWtKbHNRMlhaeDNYQzZXcFMx?=
 =?utf-8?B?ZXRRVENDZ3RQYU1MenI1Y0dnUGsyeDFUREJZYnJSUkgwM29QcFNOVE9SVnor?=
 =?utf-8?B?dFF5dDhNQTZ0TzZZb21wdXZuRHVvM2Z3bkhIb0RGTE4rS3ZOMmdEMHBWS3dr?=
 =?utf-8?B?UW9OamszZ25ORzJQdk1hQTJhUGZ3ZzVFd0k5Qi9WY0NlWHZSNmhuaVFJREY2?=
 =?utf-8?B?OVZSclhGZm9BQjFMK2E4U0YwVWlIWnd4THB6dk9PQTZkRXlmb3BUN3I1bzR6?=
 =?utf-8?B?ODF5UkRpcmN3UTFVZDU3c2pBaVJNUFJ2R1RPWXZsenIzWDhCWDBQYVF3d0l6?=
 =?utf-8?Q?g9BSQRGPDSU7Qs9jYz2J8vZEs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LYyVefr3mmiOxUpEfQqy8T3T4lJPhnVnPb7wx0McVTRXuj6RhXWtfOaPAnA4mvLmyeWQgMrfLQAY0iA0o3uZUsb5kzc8wAY1REAFpNdUnyCQK2M0OmsQX5xcPTTpK6YQHr8nUddwtair4TAX6v2Be0O9MOu1jq4/Q4gE0Q1kqzwAyWzbp8iISXrXlJb7vumBt1/IZhxb4IrH591wYujZiIK3XHODyCelwqY2omJZuN13vVaFYIP0IpKeI65EOxLmSEPQ50J/+ZSI95Td+G4fNQqw/+eJXLw5NyPBaAgPyDDL2V6MjH+970WbF1a4uXbegPJdVyMzclVj269hK2Ow/sgOKnP3JGcncX3gpQcl00HtEp3fOF3uef9qHp2topWYqlefNAm3LmyFc1iLFE1Sf2+97505LhNPa8e+us6BcfLhn6SC+/ZsCxow3kh+A8ZG9dKY4hiu3woBxdWBsMTsBThJ1xVG2BInJH6aCeRbEdOXQ4xxpvqfC7MhUky4//2hH1BKv92UQIfFVXH2Zo8iwHRIVxqb5/C6YqS3ytSkX2fxwfIkPI2VHYBKcR12WQJgybE0lot+lG7Tws6DEfgcb3yrfQlPwZYDTll80Wgq3KI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8939dbc-26a4-45dc-8bf7-08dda3b1981a
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 21:48:51.6758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNLKfnnqloEA5e4rQP2AlaJ89hCtmtCYuOdxgxcOthCj1eAt84ZFFuM9I8ibEtTTgL5j1902i47VR6HBRf/dmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4801
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506040178
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE3OCBTYWx0ZWRfX2owIa3TPlOPW jcV2ADmzvcJFZyiJDD6nftRPK+YNDUZqQCNHr24NgDVPz1bwCK9gvbUZFCMPBRy4FugztAP4KjI yZ1xaxsety1tOMTqLRJG+/Qf0or9Q0XbFGTNxcd3S8ABEy7xr6q2yiVz1wAiN142U/Hsw92jtyR
 cM5tCmHRVKhdT2xmKxCotsd+CCT26Tu+J7VrnWAppvEQedVQBDmL4IWY4dxlQ7ILuACEFLQt9ty IZCX0vfQd3mBRuqGgKL+w6ji1bUKHmxcSN56ynxDGA8HLxLpqG+8sfsKOKgK5nFHTMn/Y569f3c wLYtJKsxf3SuFP4Wq2KJFltb8VUYgHjMUpHESZrIJ1Etac7tPcwHVC6qTiVToJnz9elA+EBk3Le
 RWnp2JSdO/1ue3k1Wla5Ra+X0x9lZR3NYTAr+gG9inbYPGy4TN3SzTqnrakGaUhM/mPgdmsD
X-Proofpoint-GUID: rmkaqH8F6m3ywU8KfPloQCZ4CVjp1sD2
X-Proofpoint-ORIG-GUID: rmkaqH8F6m3ywU8KfPloQCZ4CVjp1sD2
X-Authority-Analysis: v=2.4 cv=H+Dbw/Yi c=1 sm=1 tr=0 ts=6840bf47 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=KFsDDCnklirGOTBOj74A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207


>>
>> Yeah, for desktop setups with SSDs and HDDs, the distinction is clear
>> and stable, so assigning data or metadata based on device type makes
>> sense. It’s straightforward to handle statically, and a
>> --set-roles-by-type mkfs option will make it automatic.
>>
>> Even if the SSD temporarily slows down during a balance, we’d still
>> prefer to keep metadata on it, assuming the slowdown is short-lived.
>> SSD performance typically recovers, so there's no need to overreact
>> to transient dips.
>>
>> For virtual devices, mkfs --set-roles-by-iostat should also work well.
>> And later if performance characteristics change permanently, a
>> balance-time option like --recalibrate-role-by-iostat could
>> re-evaluate based on I/O stats, confirm with the user, and relocate
>> chunks accordingly.
>>
>> Also, I'm trying not to introduce too many options or configuration
>> paths, just enough to keep Btrfs simple to use.
>>
>> Does that sound reasonable?
> 
> That sounds very good.
> 
> I  am curious what happens when the fast device fills up, what will the 
> allocator do? I guess it will fall back to allocating to the slow device?
> 
> If so, we're going to need some periodic or just in time "move files 
> that have for a long time not been written / read" to the slow disk.
> 
> While that file my be referenced from multiple subvolumes, and you 
> wouldn't want those duped (like happens with defragmenting).

Currently, if the devices are non-exclusive, the allocator will fall
back to using the other device type, slower or faster for metadata or
data, respectively. However, if they are marked as exclusive, allocation
will fail with ENOSPC.

Dynamic rebalancing based on chunk usage isn’t part of this patch set.
That would probably require a heuristic to make smart relocation
decisions. We can look into it further and potentially provide it as a
separate mode.

Thanks, Anand

