Return-Path: <linux-btrfs+bounces-11521-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283E4A38F96
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 00:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD303B2508
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 23:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9D61A841E;
	Mon, 17 Feb 2025 23:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G8Ih7nG+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RhMLcHWR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DCE14D444
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 23:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739834607; cv=fail; b=Zp7WTRnlNJL0H4iFWfgMIrq3k/gqW7D0UDgJ8E0FPTv89fZJjPeGZFbYnfiSMgE1kdSh1FZM34gNuqXHITgISHQ54Vb157iEPi1CoHjWXfDLioVVBjKLazcw4fmkmryrC+FJGbzotfcX+HqKUF6V4q9waKGek9A9I5KxVqbGn0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739834607; c=relaxed/simple;
	bh=T2odmZvBIWW3u5kCWmx5bW8G23DlBBk/T5C+9+W8ulM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gtl5gxHBdvO1Qz3cBhXezWeLBRyAAijoMpVE4Vi6lMH6Ahvg+VbC/IwdNVGkldcAxHcjN4bq3PtaXtkt1mlqwAQ43vfCXjQlF7AfIAx+av2XyMIaDntAWQDx/KHryNp4TVNY70/d4AcRRGLmNK4tO0h9PbuijQnMmo3h9N7vNJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G8Ih7nG+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RhMLcHWR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HLtV0L010858;
	Mon, 17 Feb 2025 23:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SljPNMSODEPltE1RoCCyE7AMgZXk+UgG5qpkxZm+fnk=; b=
	G8Ih7nG+bT9zipFx+KcjH/cOXVqYvbQJcoOAvrL9AFUyBUNdBHW2F8U0DTrJhQPH
	zJmmQn/HleFlAt/C468qYYkCj2RGCOhD2BMPNUyLIMhHNEG7HBW4RyHWO2FCq743
	Errrq0L+e9XIUybYKOo5777vRHoqOasZori5+VLAEu82X7TDpx/7ruTwKDvLv+gP
	r+iOk+u65S8TC8Undok5pIWlw7wjJ+lzLx4J6+LQxQuAbMZ1c6C5Ed8Dix2drC4Y
	VhrorPNbl9sWzBw+cK3nWkpvmz5ckRj4w6gEOC6qJUlTy5W60vRu7Z6Yzq4Cnzfl
	MBovTXzk9i5sCOoCUZQNgg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44thq2nbcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 23:23:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51HMVYJe036646;
	Mon, 17 Feb 2025 23:23:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44thc8bxfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 23:23:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfAgYyUm/oF5FS3h/Lax0XXbYd/WOt31Pdwf8wXaYNy/B0aYnDHNthsx1I3lxGoJyx2JjLM1aec3C84Gk825wPXLaZmevkGh/QSoIBjGtaheBsINZvkkUS9SC1NiUY2bEOwgtZOP9GXMifhD4EXsAb5+mtFabrDIz2N0GvR15J3yNpjJLVqCmjX7QNBRJFCcn7YiZWmliEE652nX5kDTPgxj+zO3Up+Bvi00sj+TYTh6KM23KSfXAQcacj+oBAzdrQYQMDjaNqAPYI0J14D7dj6HBFJBayxnD+QG2yzx4eqL+W1Pgaj7HPiqNYxvarQCDFIsqiMHa8kxpLclMmQN0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SljPNMSODEPltE1RoCCyE7AMgZXk+UgG5qpkxZm+fnk=;
 b=JRD/RigtnLOZtlQiVfV1T5sdf7CfB1KKsRPDmr/2f0NWDEjwF1L5R5bKiy67NfvXy6Pyt4S2K74bJfyoc5yoXp9RHHy77XF+l7HCHdrFU9YuoR1ZezraFnAaaJpzfo/jvsggRsHDFMVvwVwLumDbIqk6qmMmrhrku1ZScJlk91Hzkhc1WR4GDXDUd1VHCDcBo3jEUL8pbAxaSmawZ1jApDjrpOa1w6CVf/E8hqMemLwwfhOk9pcsq+bzdQebZZtODlcjSDUrx577OPeRE0nYLfCUhkuoZILK/AuNJUzb64jyv/oFrwRZROvrsUS8exSfLolAI9D1W9djnWGBGz2bJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SljPNMSODEPltE1RoCCyE7AMgZXk+UgG5qpkxZm+fnk=;
 b=RhMLcHWRbyYsIKDZ0YIgL+qCVJMC2nRqjZDKJKpRRhmR/c2pp7Sl1sWvNofVCr/+WhDESimht/bpAz3tOQbEKRGE5wIroqKze3Ez9FeBfZYmc8sbYuRLgnoU0ER96BJNp8L3B1YDPg3tCSZjibYtnJaxb3pqe3vI+9MFQotKDqs=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by SJ0PR10MB4765.namprd10.prod.outlook.com (2603:10b6:a03:2af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 23:23:19 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::a6fc:c6a3:7290:5d1d]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::a6fc:c6a3:7290:5d1d%4]) with mapi id 15.20.8445.013; Mon, 17 Feb 2025
 23:23:19 +0000
Message-ID: <7f9a3bec-5ce5-4f09-8936-01ca08c2b600@oracle.com>
Date: Tue, 18 Feb 2025 07:23:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: docs: add an extra note to btrfs data
 checksum and directIO
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <90a1ea4049bbf6d80163aa8116af722280c5d70c.1739771926.git.wqu@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <90a1ea4049bbf6d80163aa8116af722280c5d70c.1739771926.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:195::8) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|SJ0PR10MB4765:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f304ff-5a25-4a7e-cc84-08dd4faa1061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a25RY3d0WjBjSHZtMlBvaHBnT1dKVVFtK1pMU05LdHNUcytxMDBpWEtQYkVN?=
 =?utf-8?B?eUsyVlZESWdjVW11NWJRVEpyZ1JMSzNWQzEyeHhnTjQrbnJtL001SFZLOW9K?=
 =?utf-8?B?WWdKeElDQVhraExJVlQrRDZheFJPamJ1d1RYUWFsc2N0c0FkT1JxcGR0bE53?=
 =?utf-8?B?blV6VGk3OENQQzQ1TUdHamN4S3VyZ0U4dktsVWNyTjRuQ0V0OWlTUG5LeGlS?=
 =?utf-8?B?MjBjVVNHYm42NWQ5OTRuS002TUhDeCtreklqQ3ViNlE3QzNDbjVvZnQxNHRz?=
 =?utf-8?B?UWNHOE1OY2o0RzB4aFliMDl3WkpCRm5TQlZxMm50VXdsTUxPRkc0MGVjNzZm?=
 =?utf-8?B?eHBmQ1ZMUGNhUXJZc1MxOXRvZUZaT2Z1MEdXQzNHZGNUT0ZEcmEydWUrQXVB?=
 =?utf-8?B?U2FkZEFUdmRrSDdmYk9uVk1jWGhNaFdQc1orWmx1c2U1K1A0MzhPblE0YXd1?=
 =?utf-8?B?anpSOE1jTVh2a1NNdlF0YlIwSU0wOVkydWdnNEZNWUpNc1FoYVhpVEdrZmNV?=
 =?utf-8?B?UHR0UnFLUVdhZjhETXRpYU8yb3NEWXhGM3FLOWdMYjRqVjN4R3BGdzhZdE1y?=
 =?utf-8?B?QVdoNXRYUUk2WmFObUFyekRRbk5DbTBiY1Fhd0NXY1dCVTEwdjYyK1UzL3Iw?=
 =?utf-8?B?WlhtMjBWV3BDSUpnNGZMOUNsMTBOVFZRRExveWlRdU9Ld1JhV05ndXNJcmpt?=
 =?utf-8?B?K08zbUVWS1o1MmNmeGhIWDhGVWJuZzU1SFpzTXpBb05hT3JXdFZxTSt5WCtI?=
 =?utf-8?B?cjVxN3lNQUdjSlN0YmZTRzFNb0h0VTdac1UzRzhQWnM4L1Nuc0lEWlVsMXlI?=
 =?utf-8?B?NmMrM3RMUDF4R2FmRTFsanRqdFNIZkhiY3pjVW9ndDVNWEhVZHBhRy9JNTJo?=
 =?utf-8?B?N0hscU5ZZ3cySXNtMGorSjMxa1VuV2hjUk9VS253U1J4RDhyZUNISG1tMVhK?=
 =?utf-8?B?SnN3RjVOQThXN052eHhMSDkyZjF5YVdCL2hjbjZ4dUw2b0J4TlpvSlpnTWtE?=
 =?utf-8?B?dHl4YzRpL3JXa0RzVVpETkJmOUR2dzh0QUJ0S0NrMUpvK1dPdWFITHE1NnhW?=
 =?utf-8?B?SXhmNTd4cVBjU1ptemk0a2h6My9NMlBoTlArY1NxYVZyRGtTVU51QzRQa3M1?=
 =?utf-8?B?UFVETkQ3QjVRZHlyWWxpSDhQSUNJQllaMEJES0hsdEpKbGg0cDVPM09MR1RY?=
 =?utf-8?B?aElyckpvZzZzMlU1L2xFTC92cnlRM0VvY3BUMTNBTEIzbEllMExtUEtwbzJ2?=
 =?utf-8?B?L2J3THRhRWxJbHJzTzhFSDk0NDU1OGF2ZXNWeWxiOC9rWGdvNWl6RDFLemQ2?=
 =?utf-8?B?cnI5Q2E4RE9OMlZjQkNpY0paVHp6aTNjbys4MzJ2TVNESUhESW9RQ3BJelZx?=
 =?utf-8?B?N0tNSUE0UlFaMmtDSUJlT0hoQ3NLaFZrR3BXellEN3RQUmsxSEhqOXhFclVI?=
 =?utf-8?B?VlJtS2JHTTVBMHNPaXVHK0swemlnd0lYTHMzMG5CYkJGaFZDeXU5Q3QyeE1k?=
 =?utf-8?B?U0FIaGdiV01DVCtoNVVkK293RHkwaHlxU1hHNzNac0N3aTNhSUkzQ1BxeDFG?=
 =?utf-8?B?ZnNFUzJuNXExa3pUNUs4YUF1RU94NmRwVkxKWmp5Zm1VRFpkNExvdjZRMXYw?=
 =?utf-8?B?UE44Q2N0RlhWR0s1d2o4N1U1RDN1YXlscXVaN0xHRU9GcnR0REFsZW5KNFgw?=
 =?utf-8?B?anlzVWlxMHo1czNGVHZoR0tQRnFmR3I1Q0I1ZnZ0UmVsTWoxUHoycWl5MW9s?=
 =?utf-8?B?V0VxeHVmSGpOQXIzb2tsanQ4VXFjb0xEMzFDdk9lMWVWRmhtcmNjb1JIMEdE?=
 =?utf-8?B?ZER6UWJYQnM3SGtoYjhmaklDY3Z2SWdJSytWR01GNkRFd2tKZVNjbWFreFpz?=
 =?utf-8?Q?VRI9uhG465fL3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3MyVXQzMDdJa05FaCttRXBiMGhkQ3BrRExMSXMrN0k1RXd2OVE0aSs1K0RD?=
 =?utf-8?B?Mmo1Mm9nN0gwbEU2cldDVG9SK0tSS1NTVnpBc1B0U2IvNGtJQTh4NUNZTHBL?=
 =?utf-8?B?N3Y0dXNtZnk1VHpERE1vZVZ4elE0YzFXWU13a1MxRE1RVnA5SjRramdUaFA0?=
 =?utf-8?B?TjF0Uzd5T3BYd3RDRGZ5QUdFL3lkbXZHNGF4MHdTcWYrSzl5WENvN0NFbEho?=
 =?utf-8?B?REdzcjkyME5KS0pMQjU0S1E1ZEdZdkVNQnhHbkdzYlluQ2pUQzRveDVNT0p4?=
 =?utf-8?B?YzFWL0ZMM2k1NWxUYkdTMndhMGRwNjArSXVtWnFvQ0hyMTloSmVJbkthaXpG?=
 =?utf-8?B?T0pMaUJzVU1zOVJuaHBLVDExd3dmVFZjcjhaNytTM0I0SUhxWTdpNU1xVXpr?=
 =?utf-8?B?TXFWRGR2Zzg5cE9GcGFnUW9iSnJsWXJ6OTFESjJKRmNHWWdOT1dIenpwWnZP?=
 =?utf-8?B?MVI5cnRMalQ3YlBFckNwaHlzS1JFdktMc05hOGdaS0V4SFNFbTF6ZVlURkJo?=
 =?utf-8?B?dENMN2MrL3k3Z29aZ2F4T0kxQ09hVXdWeTBScGJnd1V1UjJ1Rk1kZ1JmUDN5?=
 =?utf-8?B?R1k3VGZ6cDZ0bWFTWE9qSHpPWFVpN0E0UC9IaGJWSENFUXR0KzVyK2MrNXRX?=
 =?utf-8?B?ZGZTT2NRd3lhWGtQWDJDQ3pnYlZpUDd1Ym9BTFdaQnByeTdWcllPalFDbjUx?=
 =?utf-8?B?QytnVWdSajVoNFlEcklTNDQrSGpsaGF1cUpjQWxRTzNXZVZOaThoSmdNbFRm?=
 =?utf-8?B?OGs2eHlPMVRiUG9QVk5KVHh2RzhOSFhtMHlTV29IazgxNjYvMzA1Y2thS2Ny?=
 =?utf-8?B?WHVlSmxrVDBFTk00UUVVVWRTbzN4RURDREtzT1lLVzc4SFZpVEJWUGxoTW1T?=
 =?utf-8?B?MnpuWnFkNm5FWGxXSkxWZkhWVWZxZTMwYy96NC9ad3E4SFVHOXJUWER1bjBu?=
 =?utf-8?B?akxicVlBVEQvQnZSVHBpdVFpby8rVEtLcDdQcTNsMmQvT3BHbFJsL1Bma1pB?=
 =?utf-8?B?SDU5dnhuRXBYK2JBeHc3Sm4wUFprc244MEQwbDNvTWxzRWtNRUlmOVVPdHhT?=
 =?utf-8?B?cUk1LzZhbE5ndVgrRWhxMmdFL3cwZVpQOFdMYjhSNzFoUW5mdnIxWHRoeDZM?=
 =?utf-8?B?a3Zob2M4RVRXUW1ub1ZMUGMyK2VHNGZpTHZIdlNaMzVwVUhicW9jcGdBM0p4?=
 =?utf-8?B?UG1sQjJlODFBVGVHWExpWk93TS9vR0Y2bkVKMHJ6bE0ycWtEQXFValF2dmhX?=
 =?utf-8?B?RGpyLytNWi9YdDNyWk82a3BkSWxaZUhGdWMwaGpTa1hOMGFaZEt6bGpkZEFC?=
 =?utf-8?B?Tlhhd2RSVGE2SnpZUDZUQ3FpS3ZKSDlEeEZBK3h3LzVXdzZqS3BEOWRlUWNC?=
 =?utf-8?B?c3ZCRVNscU02Tzk5bFlRRWw3TlJoQ1lyRHZHbTh0YVc5cndGdWxMczgrL2VC?=
 =?utf-8?B?ZWxqU05zZkhGbzVFNnFpK2hUdUx3bllrTXkvcUlJaTdLM1dXN0NSVjhVQVEr?=
 =?utf-8?B?MUtOcnlvbkxRSWppUWpTKzZuRGNqM3RNL0txTWJuaUVXRnZNVzZ2d21WUENG?=
 =?utf-8?B?ZUZoaWhwYWd3dHl3UnFHTTdlVFhqdGpvMC9uVnAzWkF3Njd3ZDd2TENnNEpr?=
 =?utf-8?B?VU1jSjErRHRjbVIxNUllWlV4OWJ0Z1BxaG9HTVdySkY2TWZDUzIya0YzZmF1?=
 =?utf-8?B?bE9PNmw0Z3kxZ1YvWUw2bFJ0bWs3M1lDMUhQYlR3M2dCUzFCVzN1SWZIb09G?=
 =?utf-8?B?SlFPN251eERLMXFKdit2d3F5aU1jOVJNVkhXd0ZXdy9wSTFJYVpDck1IVnFU?=
 =?utf-8?B?RUpOZUg3R2pybDUweGVxWjN0Y1JDSWpGMitwakNnVWRjcnN5TG13LzNKOUFC?=
 =?utf-8?B?SzJtckwvR1dkTFcxalp4NTBWVUxudFNvcGpiZHN5RWZOWmFiQ1RkcHo4Y3dq?=
 =?utf-8?B?LzVMRGRrTE9NMEJBYzlWOFJXanB3ZmdkZGV6MElVQ1dBM1JaV3hwL1lOVHJm?=
 =?utf-8?B?Z1YrVzl5ZkJsZUt6Nis0Yy9uaVVDcFZuR1NKMms0blNiNVYydEwxZnhLMnRo?=
 =?utf-8?B?aHVDSHlWNHRvNHA2Uk92bUFPSFN3M3N4ejI0b1NlK1Z5UTlTOHQzcGxQakRQ?=
 =?utf-8?B?NU5icmEvUEgreUdMOWRzRmQweTYyMS9QU1Q0Q0djS0EzaEozWG11ZEM5VFJ1?=
 =?utf-8?B?V0RQNGgvMDdzUjlsS3laaklDN3ExelZHdVZoR3R5VldSK3J3N29uTnNQNUFx?=
 =?utf-8?B?N2hucTI2QU1taDhudjJIYVc5ODVRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5Hz+j7l0eWwjDzTO84ZuEUldtIuBqNSaMMGFFRv+/eCJandROIvQEtAEIjjtS2yst4NvnjD+Ye4X98MbdytTCLMJw2fj+oZDCtbuAOe9AD/Nie0KHOujgkUcTLgrfkAJhZf4PxroEcDmI5rfOr0J6oMVajwnq8w10oo3+dRfHg6dVssNToUwaM68SfA3bxuOJccLS8Pu+BbvsVBQQ/1bS+CbPuQBTvw574flZ49izN6pOwZE02RJgMxIyslMOqEpZ2AkQZxcSDi3XcfFkmSXNvyulp6M7J/q9eLlgDztsDv94Nq9zAqCPlaKOCuqvQXe/WYAcztxcxbDxGo9e5NSR1uAVs8Yj2THllRaEoh82fhXW+BKDDlH4N9Y6OOc5NiNfIynprgPV/XdeAHOPgJxB17bobfbvp83AVpKvz/D67rI/Q/89aUCGrIZq6MC3jTYGSOVgQPGl5WLqyEi6c22M4zI8e8p9zJGdIukFSnRatFVDMHyBxWyA9XaZoX+71e48LMfY+XmQE4g2UFkO3SGcy1xhq54f+rFV1iwAAHb9dUb+aeahiP5Hu4YfJ8p5V7jqXIj9yepN8B47uefvqgHxp6g4h1r+tiF0koLA2+bG4E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f304ff-5a25-4a7e-cc84-08dd4faa1061
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 23:23:19.8039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQWIiBPj2QMHdXL6XiErLM5rUR6cBsfwWDdra6w+f89Ra1e03dq+11SresJkVDNA37pa8xxScNa6AbmHVPrLKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4765
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502170179
X-Proofpoint-ORIG-GUID: Z9bDNYy4LK4vtn-3QOaSBQRRSeTM5hqf
X-Proofpoint-GUID: Z9bDNYy4LK4vtn-3QOaSBQRRSeTM5hqf

On 17/2/25 13:58, Qu Wenruo wrote:
> In v6.14 kernel release, btrfs will force a direct IO to fall back to
> a buffered one if the inode requires a data checksum.
> 
> This will cause a small performance drop, to solve the false data
> checksum mismatch problem caused by direct IOs.
> 
> Although such a change is small to most end users, for those requiring
> such a zero-copy direct IO this will be a behavior change, and this
> requires a proper documentation update.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Grammar fixes sugguested by Johannes
> ---
>   Documentation/ch-checksumming.rst | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/ch-checksumming.rst b/Documentation/ch-checksumming.rst
> index 5e47a6bfb492..b7fde46fe902 100644
> --- a/Documentation/ch-checksumming.rst
> +++ b/Documentation/ch-checksumming.rst
> @@ -3,6 +3,24 @@ writing and verified after reading the blocks from devices. The whole metadata
>   block has an inline checksum stored in the b-tree node header. Each data block
>   has a detached checksum stored in the checksum tree.
>   
> +.. note::
> +   Since a data checksum is calculated just before submitting to the block
> +   device, btrfs has a strong requirement that the coresponding data block must
> +   not be modified until the writeback is finished.
> +
> +   This requirement is met for a buffered write as btrfs has the full control on
> +   its page caches, but a direct write (``O_DIRECT``) bypasses page caches, and
> +   btrfs can not control the direct IO buffer (as it can be in user space memory),
> +   thus it's possible that a user space program modifies its direct write buffer
> +   before the buffer is fully written back, and this can lead to a data checksum mismatch.
> +

> +   To avoid such a checksum mismatch, since v6.14 btrfs will force a direct
> +   write to fall back to a buffered one, if the inode requires a data checksum.
> +   This will bring a small performance penalty, and if the end user requires true
> +   zero-copy direct writes, they should set the ``NODATASUM`` flag for the inode
> +   and make sure the direct IO buffer is fully aligned to btrfs block size.

This section covers how the bug was fixed in v6.14, but that makes
you wonder—what about earlier versions? It’d be helpful to add a
paragraph on that.

Thx.


> +
> +
>   There are several checksum algorithms supported. The default and backward
>   compatible algorithm is *crc32c*. Since kernel 5.5 there are three more with different
>   characteristics and trade-offs regarding speed and strength. The following list


