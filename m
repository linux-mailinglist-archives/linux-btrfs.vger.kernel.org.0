Return-Path: <linux-btrfs+bounces-15890-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC99AB1C06E
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 08:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655A318A281B
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 06:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F29205AA8;
	Wed,  6 Aug 2025 06:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ii/q8egb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XETxRd4c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E171B7F4
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 06:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754461786; cv=fail; b=NLbhl790CK7HUW48BeTDNx/mLy8cls4Z4lpO3y4TWn8rM2gkLBuKF/yF9N4vW0DJPqazaeDlISCCuVTLNr0b50Bci1uar288Bs2F/I46Nd+xfaKBDN0my2y5dyStNelQUNquyk3D4l7gLc7OqTg2w85e+dMOOCbwBH8AlaLFeyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754461786; c=relaxed/simple;
	bh=Fq6aSGenbt1FvDrHxLP1Z8V903RXXsh/8AnQk6RWOes=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BWTIAJkMk4A6YpN2AjKb5AtOmo3fFOHwyzvq1eycReEhGR7XUyMQswRZhn1iP+M5qaB4DJjTub2ej/G7nasEtQNxLYYwkzXiQyc+Y05TFjKj1PLsZcVMyYam11LJ1O+arB/c6bLNsBd3cTKhby2/KbTvnrqFPQ6X//OiBJ2P900=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ii/q8egb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XETxRd4c; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5761u45w018571;
	Wed, 6 Aug 2025 06:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9r98cjNVIMf6gu8Rf9mko3P/sdATaGcgLx+2/JvpFz8=; b=
	ii/q8egbcTzsRpzydZNKOzB43QKk2MiURS1FfOYWaoIQN5mkSbxRlmVQCm9u9qk/
	8itLrFbMIMa8FjNLUL4KZ9tpHrMNSjWXyEoT8Z1ewWflgbslJp87K/UczW6SZ/O1
	1YKzNVHvWdHZTM71g8LU5DJtNTKZeyVO7F8A6NimTP2Wh8NcWfHtZlbdiHsA5RHX
	ufk8j/nO5UahDIbD83+BrbvKHuzGJMhbafeL1N6QL/V6blD5GttTjlgsie18tChB
	sglG22LvDpRUaQHGwmAOVv+wKCPZ8F8ZZBsTc4vCQQZ4xmEPAiXBm5ufs3gcEZ3G
	4t+KqmzAK7kvoyJJXwr3ig==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpve0ux5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 06:29:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5764etbJ009743;
	Wed, 6 Aug 2025 06:29:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwkkf32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 06:29:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lM0le1KCeC3tQyQOg619loUH1uOCOrQOOfRGpwCPAqtgEmOIobnq6SDsJP77ld1mxUE/eob2HPW7vK08e4B3QFiQQbwDqMgCyaG8h0L92EA7ygfLQfd8JXeUHZ34k4YFqGNfGfZe3PTFK9CqwqMfmFinBswC+eaq/1iqnMduU6cNnU6IFSDy+LPXx0Z2FFdVO8CEQREgzF1Uq2BbdLh+M+aW1gg6FWuV2hIHTuNY57G5Vu89l7EEGP9t+L41vjLpkEFTf2MkEgmh8VtnhUErQAOOVm/pfh3T7CQg26VWnneSlhjC83hzdMoloBOXlQCp/Me77lAZMhdxzg9V1bWyFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9r98cjNVIMf6gu8Rf9mko3P/sdATaGcgLx+2/JvpFz8=;
 b=aKd2K7egyECMrre7xDbxUBSdP4A3+CXHu0HL2dOdICTARYWxqTt8aSvik+RDFWMEyiVoZ+wsW6QP/dbsyY1UulhADfolyuoBFQ/yBQl4IxpgRFNJEaBt3qJUsyC0caycdrKW0450f/7tVchvd73XN1oc3w2xnsc9xNOZzw2OliMrsKBz2W0NTuytp+qFQ/AfoMzDNB7e6jOUUfs0lHPeostkuulie8LS9ErYwoGHzOusOKq9w43WJyFyQtKrFzvWOBnO7aYcEIhy3uNO6tdzvcZ0u4Op67JYftziSYs3Bv2D5y6f3siOxbV6bNWhbjX9copFUxtmism+ZZFdiueL4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9r98cjNVIMf6gu8Rf9mko3P/sdATaGcgLx+2/JvpFz8=;
 b=XETxRd4cApuXvJ99gfU1l7tG6b1dlH4DzhmmOXGScOOdacizRimxwTUfaO/x8uoAktorfI3wmnmxC0mdrP5b1392GRS3sfe2BSVb0bB5nS3ws6muAoYWN25md/Bjl3FMGe2+Oq0IrHfo8uUjesVho7NYxEmdp7G3tvpVRuMvXjU=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 IA3PR10MB8394.namprd10.prod.outlook.com (2603:10b6:208:580::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 06:29:37 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 06:29:37 +0000
Message-ID: <2f957fae-d12b-435f-bfef-5adf368fd82d@oracle.com>
Date: Wed, 6 Aug 2025 14:29:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs-progs: check discard_max_bytes in
 discard_supported()
Content-Language: en-GB
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <614684a6dfeafb1e4d2fe721b2b89f564449d223.1754413755.git.anand.jain@oracle.com>
 <4222f30c-8bd5-42a9-ab0a-f8c39d402256@suse.com>
 <6baaa8ad-5cbf-43b2-b7cd-c04572c9952d@oracle.com>
 <bfee8819-5a5b-47d8-90a5-66d053c90cab@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <bfee8819-5a5b-47d8-90a5-66d053c90cab@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::14) To DS0PR10MB6078.namprd10.prod.outlook.com
 (2603:10b6:8:ca::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|IA3PR10MB8394:EE_
X-MS-Office365-Filtering-Correlation-Id: be69d840-9bcf-451c-9d92-08ddd4b29d56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjBtT3UzYjcvenY3bHpTTWc0YzFCMkYwaVgrR0FRVU5DTkNMQzBrZEpteFhj?=
 =?utf-8?B?M3I3bzBvVmV3WmYyNmxpQkdsWmpMRDNYb1k5ek5pT2xRL3Z1ZUNoV0NsMW9P?=
 =?utf-8?B?bllnbFZtYWdaVXhubjdhdTg3d3hyYkI4amk0WURjdXhvd3ZsenhtTStHSElR?=
 =?utf-8?B?WmhDWGZqaWZGNWJZbHB6YlBYWVRrUVZ4bnkwS1lROGUrODlpVWFIcStDZFNW?=
 =?utf-8?B?OGhVam9JZmFoc3hiNCtxVm5NbjdOUlFMTzM0RWZYaHI5VktoOEVUTnNUL1FQ?=
 =?utf-8?B?MkpaSmZ4b2lXK0ZCQmpqbTFCNDBNaC95Ukx0YlF0R2hkV2E2SUN2WldHc1Az?=
 =?utf-8?B?dFI1cm9UbFpxYzBIU2ozTVZ1SmdpUUQyb2FicWUvL25kQzZ0ZTZZNnBkT1dE?=
 =?utf-8?B?TnUyWTArSzU5ZnQyZ3RyMWdtbTRUOVNtVWtHWDhtYmRmUUJDSHBoaWg4WUtu?=
 =?utf-8?B?U0thNGhWYmh0a1hVenk2WkxVa3prMW54dDUzd2luOVRpSUc4dWZFSUlGL0Na?=
 =?utf-8?B?U3k0aCtFU0RNbTdlYlZ3SndCOSsyekVnNU40OWt5Skx4RWFFT2hxUFhGb2hO?=
 =?utf-8?B?cEc3RUpyS0JBWStDK3NuM2UwQUg3QzI5NUx3Vk13UG5zKzhTdGFrVTdCL2Qx?=
 =?utf-8?B?V2tWSTFVeEtCMldpb24reWFvNGtwUTdld3R2MVhDM000c053L2lsRzkxVHBu?=
 =?utf-8?B?RlNXUXQ2bHFNd3gyTE9HOEM3TElPMkQ2KzVucFJiSzVJcUdsTmhHc25hM3JN?=
 =?utf-8?B?aDVXc2s2Mm0xMkdscjgzYXRrbS9FSytGN1BoM212Qng5alRnQ3g4MlU1S2Nu?=
 =?utf-8?B?S1NhdEdBaldRVWZwSGlkNTc5TnJhdFFMVFBXUnQ2T1VCNnUwc29XK0U3OTZl?=
 =?utf-8?B?NVEyS0wrbC9ybVpEMzVqRDdKc0UrVmlnK3dBRkEyU2l2Z3BrQlJMM2ZaYk5a?=
 =?utf-8?B?ZnZGN1hlOEQvTVJ0UkxoUCtEbVhMdWU4VnNmRHN5c2FlODdlU2o2TTVySzFL?=
 =?utf-8?B?K3lSQzltSDBoNC9jZFdEeEdNM3A5MFU5bjdYQzZrZDFROExUaExMUTFUb0NY?=
 =?utf-8?B?OWVoOFFhV0NDVm1CbDRPUmh0WVlFMndHUGJ3S0NQdVp4dkhrbTEra3pEN2J3?=
 =?utf-8?B?N2dEZFZERzhDVTBieEtmb3EyRjkyM0VMWEZvNWhSV2NPbjZpZFB6UitQMVh4?=
 =?utf-8?B?SnRoVDgzTnNDWEd0U3ZjTllWcGt4Z1paRHgxYzJUZitkSmhEUnc1aUhUM3Ro?=
 =?utf-8?B?eHZLd1RFTEJ1YkxhUVgwdW02OVZUR25obER5Mi9zUElxR2hEdDcvaEFyWFZQ?=
 =?utf-8?B?QmxRQTFOVEg2V3ZWK1NnSmZMalNNMzFzNk5Ka1BOaVhjK3hRd3dOcFBrK1U0?=
 =?utf-8?B?Z20wQ3d0bS90VFRNYW5yVHdZdG9DTGlCYWFWbDBtRXJhR3p1WGl5M0JPYUhV?=
 =?utf-8?B?U0d6ZHo0eG1LN2VKL2g3a0ovOUQ4NEoxOXlwdVpBM20yeUFscnM2cTQyNTBQ?=
 =?utf-8?B?eFlPbkZaYXM2TXA1QnlwbHErYjVidkQ0V201K2dCU3VUQVA5L3pqVS83S3Nv?=
 =?utf-8?B?ZUF0UlU5TytUVzFWK1RjdnpwZkJodUJ3emFTNExoeW0rb2x0Uy8xSjRsMTlL?=
 =?utf-8?B?T05KYkgxSTRJY0d6RWZRSXh3YndST0g4TXptY202enFrS1paeXI0Qm1mc2dM?=
 =?utf-8?B?YWdNSSthdytpTzAvWWd5OGVnTnIxS0dHeU5nZDlFN2FYQUxQRXA1ODExRlF2?=
 =?utf-8?B?QXVKU1N3OHE0MEZaNGZxaWhGUUN6cVB5NUd4OHpEa08rNmNQT2t3NDFtdG1o?=
 =?utf-8?B?ei9ZcWVuWE1Vd2NUNnB1R0ZvU0ZzR3lRT2xrRFNTcVZQa0FTYUlVUEdoMzVN?=
 =?utf-8?B?c2x1RFVIcEZ4UTNHbXN5SU44SE9FZ2Q0bkxnMHdoa1QyY1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzNvbW1NaWNGeE1DRHA4RkxKODcxdVQxcWpZT2FnTDArQ1MrdlVEc3RtT2w3?=
 =?utf-8?B?NmdKbTkydWVRTUZvTFJuS0dEcHptYVg5U0NSeWJzMGNEc0pBRVhVcEFXLzd3?=
 =?utf-8?B?NkZFWjA4NFFzNjBsUjF2YW00RmVWVGpsMXgwZXNaRlBrZTF4dDUvSzhsQm1X?=
 =?utf-8?B?NlgvSTFuSTZlNVJib0FRcXRrZ0Rwb0JnMWtDeVJkMWVhYkNSYnFKMDhoZlNU?=
 =?utf-8?B?eG5qUk1RY0NNc3VzdTFObFo1TWcvUkY0dnFKakREc0VuUEhuTldiUXlSUldh?=
 =?utf-8?B?bm84ZUdFQm1OdUd1UjdicCs4K3k2MmdvanBmUjRlajk5K091dUdnWW1LZEhI?=
 =?utf-8?B?OGlXdHpMY0tPTjlNbDR4NXAwdUttRzkraFdUOTBBbXdFbVBUUnpMbXg0QmVW?=
 =?utf-8?B?WWRna3lXYzJsVVFZNW5KaHZGL3lTSU1EYXBpT2VPTTNERHRidVhJdFVPTUZm?=
 =?utf-8?B?anUzMzVHaTdqa2c1Q2FGazRaSGpleDhPREtkOHVWQjZIZ1F4bGhYekdaTDJx?=
 =?utf-8?B?dmIvRTJPTndmaElyVnBxbkgrRzRoMVlFam9iS0pSdE1meEFCTU5lU01FS1ZF?=
 =?utf-8?B?V0xhcEhPVVcxZXF0dEtXSmwzL0pWeC9nSWFPMDFobTMwMWY1RzBNM2Z2aUhR?=
 =?utf-8?B?a2grQVd3MWNmV3d2SWJ2WmhncVdEY1hNa2NkcTRRRS9hY2NIbDBMbXlhc1Zr?=
 =?utf-8?B?YWE1TUg4Z1BzYlNtQTVsQ1pzS2E2eGp6cXhJd0ZvMmsyb3BMNENWQ2o1RkQ2?=
 =?utf-8?B?VTR1ZUQyRjZpUHc3YUExMndyUkp6SFlENGs0Rlc0T2VPcVVPSkwzRUpPeDFE?=
 =?utf-8?B?OEczRkNXeU9NNy9uMFBLVm5HdnRyUHhhLzdNWGhQZlArSlJNQW9MN3ZGRXJt?=
 =?utf-8?B?ZHdGMnRWa2l3djZSUXFiSnc0RnJMWmdCa2cvSTJvaDVneG14S2d6ZG0yWlMr?=
 =?utf-8?B?U1hIUEovOURUU0FDZVdWZElhODFTSnZOUkVpclZKWnBLaC83U1ZDWE9qV3BH?=
 =?utf-8?B?UHVlQkRwOHhHb2s3anR0TmJDeGpCVmttZDVOajN4NHNOMTdNSnBHNGI2OGJs?=
 =?utf-8?B?N0dUTk1OWFJNYVM1UnBVd3BNbGw2UFlxcXI3MzN5aDhWTTJ3NVBadFZ1bFNR?=
 =?utf-8?B?ZHVWeHNTUlBCYlBSdlE1Tk9xUEllRUtrUWRzcnV0UGppaDVWeTFsNmlYZllX?=
 =?utf-8?B?NmJSNEUwUHFweTRWVFJKdzBoSDkxdGVYNUpNSmtOU21obEM1ZnN6VE5FOEdt?=
 =?utf-8?B?ZmpvSGhWT05MSkN3ZVJRbzM2Tit5SzJPRUtFcUVPY29Gell4UEZHTU9VQmpF?=
 =?utf-8?B?YUVZUDFZWlBRKzA5WTJueXkzeGdadnYyWFRNczJsazNFUGQrdGhDSVJCY2RR?=
 =?utf-8?B?dFNtNXVPTzd0OWVRSUkwSUJlSGcxUXJEQkJqMlZmMndQV1VJNFA3T1BybkVY?=
 =?utf-8?B?Z0laUWlrVFJFMTFQV2JEZDZoQUpjRzVhM2ZFTmozTTVONVE5TzZhRnBiMXhz?=
 =?utf-8?B?ZDd3YWZVeE0wYStMM3VtVXdoSm02aXhSYUxLZURDYnNlbTdoMEcySHN4MTds?=
 =?utf-8?B?eEVFa3BkQWFBdnNRWjlDT2VEKzlEdFRkbmozUEhiVzBCb3lnU3BlMWd2Ymtz?=
 =?utf-8?B?NWJHU2xjdHUwUmp0TXlVeHdYM29WSE44ckpyR2FERXpIVFhKY3FYOVF0U1Rh?=
 =?utf-8?B?a2N6RHRhc0p2UC94Tk91akpNMTlNZU5HNjBpdUVIWFk2cWh0alpvYm5Od2k0?=
 =?utf-8?B?Ym9aOWlmVGREbWVwY2srRnZSRjVYZlc4Vnd5cVU0bzhySk5rcndUb25hTit6?=
 =?utf-8?B?UHhaRndBelR4eTRqSHVieS9iSEZtWWZQb3JvUFhzUXRaVlBiZWVJdXVoa2pr?=
 =?utf-8?B?YVhZaGdyc2VpdXdPMjNwelRaZUNRaEN2VklibVFZK2VZZHVHNUJaUnpsYVJh?=
 =?utf-8?B?NFNhMkpIMytTeEhzTVFnZkIrQlNveFpHZkU1MXJ3VS84ZTFTRTlSYXpoa2th?=
 =?utf-8?B?Nk5TcjkvMGNseS83VUM2TDVNbUlPeEV2RnFIZ1VXZ2Q5WkZxOWk0VThSdTVk?=
 =?utf-8?B?QXZ4aXJyK3pVM2ZYYTZaQ21KQTVmb0tZWERKVk1Ra3JTaEZWMzFPaHhUd1F4?=
 =?utf-8?B?WUtPcHVIS0dOL0xhL3J0ZTNmT3d5K1RYdTNFWDV4ci9lMmhENkhsYlZaT2NT?=
 =?utf-8?Q?c82lbVoM1TKroAH/pkyJDiT7tq7bRvbkSt+S+VnrqcV6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nUWaPfdybGAhFaslF6bQ9wOJlHYmFx8OFbUvZqWLQtseFaeBnwoeEAbluCjffkMcUyBD1nCI9v2Ok0DwxX12UK3OvPN2sTS8jg+MYExmpRE0WGLSUPRDIicboEeYPIvqGXkSYJU0TK5RQHYl9Kl7Dnrjv3et6ELw2wVmqYwBC4RtSvpf7MtgsbFqlzXSkM36FtfgIF5/O+WkTg1lYzX29Klk9BQ9rv0JiB6S1TKvfouMfk1sYb2/a88uMk3MGdbrFydnpJiT2nI2HmZxUi6SJenXE+AF0vKChygssYe1jDQ2cCDAjEGuXOWIcNbZ6T3InATHCKiGcimuKZSm25UEE5mtD8nage3HhAcI/hAvddv+zRZdLDgnaajoci1fDlNaUykocn2KKgerxbHzzuHPTrA4gvd5fkVJqRT4+zRqHmnAoa1/OOnsYo1zLNb5wVZ7MhhXvfpzshk04hMxH7vpebs/QGkaWRboymk/brr3KdTlRqJE024wW9EjRE4HHe16vKKtNAkESjFC78aHIIpBrHUthoRKYAvFQGjwscTpt3NoeAgoifzqs+eobzK+1F5sw6t0YO6VPVgzRD9M3ROm1UCJ0E3yJLwgmFQyhkrf0To=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be69d840-9bcf-451c-9d92-08ddd4b29d56
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6078.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 06:29:36.9258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: plnHH+btO2QLR8tPvM4N0uno9wDR6RdmoHz7ASQFk4Y6H0na+TXjz7Jv+632LkKpjLie2stAcBpkLQTf9TR1gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8394
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508060036
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAzNyBTYWx0ZWRfXxGuSDacKW+TU
 uewcTlClKCNmqiVvl0S9sQS3RqK38dJg4QJa7AVDi45DVqY2lHcPItC/alT4cxUV2qZxSvM2DyF
 hpET/IAEOtqw5lgFZJBrnxfvLL4lgFDKeq26/X29ew/1vbAvFfup02TuoTLxqQfJXjM7f2uZ3Gq
 EnGiJwG7TiCr9C4dSRjSFuNaYjPviRciTB+oLVL8mk4oEv7hPrMZpHSx4ijQj68F+ywSINwM+Z2
 pxoADs7IDz/fKRAytguB3YRl0Ak6BX0Xx0r+ibL6QaLD1Sijd1ty4rRcrV+CRiVbQqaXdFY2ur+
 JlZZMwurvslncv6Yov+Ct2etAgNKEVOyChiXufgJAmvYJ+C9tNzjtNShu4KhrqnemhwIidqNoL9
 wy3Ju3TUIsfj6voEhqmpVtM5r/OEMle3LRHxI1jRPB4QGNyQen2eqXKwU1JaZNMtGNATfiVB
X-Authority-Analysis: v=2.4 cv=ApPu3P9P c=1 sm=1 tr=0 ts=6892f656 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=sDobEFtXr3xUGJYo0YoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RfkEs1kJpLH6C1Kib5qdxuN1swjIc4zi
X-Proofpoint-GUID: RfkEs1kJpLH6C1Kib5qdxuN1swjIc4zi



On 6/8/25 14:15, Qu Wenruo wrote:
> 
> 
> 在 2025/8/6 15:31, Anand Jain 写道:
>>
>>
>> On 6/8/25 13:06, Qu Wenruo wrote:
>>>
>>>
>>> 在 2025/8/6 02:44, Anand Jain 写道:
>>>> Some devices may advertise discard support but have 
>>>> discard_max_bytes=0,
>>>> effectively disabling it. Add a check to read discard_max_bytes and
>>>> treat zero as no discard support.
>>>>
>>>> Example:
>>>> $ cat /sys/block/sda/queue/discard_granularity
>>>> 512
>>>>
>>>> $ ./mkfs.btrfs -vvv -f /dev/sda
>>>> ...
>>>> Performing full device TRIM /dev/sda (3.00GiB) ...
>>>> discard_range ret -1 errno Operation not supported
>>>
>>> Where does the error come from?
>>>
>>> In device_discard_blocks() it just calls discard_range() in steps, 
>>> nor discard_range() itself would output error message.
>>>
>>
>> Its from the my own added debug message at
>>
>>          if (ioctl(fd, BLKDISCARD, &range) < 0)
> 
> So you're only fixing a message caused by a patch not in upstream progs?
>>
>>>> ...
>>>>
>>>> Fix is to also check discard_max_bytes for a non-zero value.
>>>>
>>>> $ cat /sys/block/sda/queue/discard_max_bytes
>>>> 0
>>>>
>>>> Helps avoid false positives in discard capability detection.
>>>
>>> Since there is no error message and the error code is either ignored 
>>> (in btrfs_prepare_device()) or properly handled (in btrfs_reset_zones).
>>>
>>> So I didn't see how the false positives are even possible.
>>>
>>
>> discard_granularity suggests discard is supported, but it's actually not
>> discard_max_bytes is zero. So the discard_granularity check gives a
>> false positive.
>> ----
>> $ cat /sys/block/sda/queue/discard_granularity
>> 512
>>
>> $ cat /sys/block/sda/queue/discard_max_bytes
>> 0
>> ----
>>
>> If the line is confusing, I’ll remove it.
> 
> I understand the sysfs problem, but since there is no such error message 
> in the first place, it won't cause any confusion, thus I see nothing to 
> fix in progs.
> 

Please!
there are two messages...

1.
Performing full device TRIM /dev/sda (3.00GiB) ...

2.
discard_range ret -1 errno Operation not supported

#1 is in upstream
and
#2 is my own debug.



