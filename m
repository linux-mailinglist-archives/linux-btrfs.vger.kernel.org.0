Return-Path: <linux-btrfs+bounces-9626-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B810E9C7FC2
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 02:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7745928451B
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 01:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4CC1CD20A;
	Thu, 14 Nov 2024 01:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G10JJTFc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JdJe/1Qh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD8E1CD1E1;
	Thu, 14 Nov 2024 01:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731546646; cv=fail; b=ICxWGiU472IfCjvPTWZPkv615XHt0R1p/c8qqyi/vNHjUIAXyaYIG8zJpJRQEZYJxiGRTqbvfLRnjFajGmM8cmbhfzhm8EzYqYanUTjehsbpMwfCVWgaP5Fbl9JSFb0gMAwQqlqtu2Pa6nO9D2p/sb8DiqZnmwJblh8rl17rnRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731546646; c=relaxed/simple;
	bh=ZegAyE9OwGcxbPhWUsgy+qPEMRiqS50prGBv9suStWE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QJGLq4OOCVR90NFvgOZa7q57CkXF5BPq039fRSnBAkirnYnhWRWyaWXOVNf7P538ymEuDCS5TBILD6n30liqrhpSt8MaNwyddv01zA/Yp2JsnCNIqxrwl/54kidRjBoOSlNeQHtmjx932aijjPRs+TaQPucpclFqOZ1osD5Z23s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G10JJTFc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JdJe/1Qh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADNBm5G014970;
	Thu, 14 Nov 2024 01:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ZegAyE9OwGcxbPhWUsgy+qPEMRiqS50prGBv9suStWE=; b=
	G10JJTFcBr/FBzyN2+XwA3bt91YVEu1XVCyGDkYKk1rpZxS7WSnztfsH5VUsVmxq
	IP1LGhrUIgeKurjxtjQm0MljuxkSpD4nurP4znFJoA9DrRipF1D0bjQOxN5WP/Et
	QnRh+7iEbG1SK4GJ36jvu5BqJphnsH35oyCGHl5YsvV9H728jE/Kz7USyoc50mUD
	aV+h5yXVi7FzIaPyiYiBOJLkksNy6WrTQ++cJn9B2qiibLzUL6SiVtGf1Yexs6/0
	2VcVUSOFlAthDmPEixJ9LoB4LkXyaC6/Mr+wUG4OxEcvcrdaXnWnggoJ1WTTS511
	j08SbSPXYCrEmwefziYB5A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k5g218-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 01:10:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADMpXKa023918;
	Thu, 14 Nov 2024 01:10:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuw0ktfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 01:10:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puC0VWVis5grHTi5jEarXsDNnBEmIP3A6+fokLwiGnbLA4BrWh9TgYnPWEKAh2xEew/8QswAliGZFimQIQ9RDO5nJmuMhgn/FbV6D3OQSOku0gqjpQR6br31T6sxeIliHhNgWLSzUlP62yv7zM6bWjDm303Wes9+vGW7+1DiAfn9+hkzlmvH9E4WtOviRQhspjBHOszZINy7Sp4XFgBgmHisq7/HJe2TOvY3TLk/qni8HSpsksCX7b/870BC+tnf+tE9FmzJZU8oPxPUoyU8Qtp4Q7BRf4r8eoqFDSDO1O1DfyGcHUEMC86lwwUPXTD0RgDlo4xtmBsTEudoF+0ZfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZegAyE9OwGcxbPhWUsgy+qPEMRiqS50prGBv9suStWE=;
 b=Zx2Qr7jNS9E94daeQ/cD/87nQu1XEd+OdQwfLYRgCGkSnR+lfwiaCkXSe/NxZAgTZelOAmhKhrHMky6Lnvgq378ql22PfhR633qRG6Rcc2MbgDlATja7GHd/dbrUzAH22ziqUqETJ3+YtBmTOzxY1L77Q+Jc4EBVx3vQ9i9xPeEzOAeEb51gWerKBvaJFaVEOH+jgClQaorkQ2UPWIN5mxm6J0W6HMM4Xlw0EmFM7ZM6caVbgegyqLNSDqA2fJ0VyBxCd26DCWTJK2mN5gmAiPWb2dGCR2xRd2c7HOB+Ttgh/24r2cvY5diDyx6b8rhB+diiJXQTOkUpAMGIiPPEJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZegAyE9OwGcxbPhWUsgy+qPEMRiqS50prGBv9suStWE=;
 b=JdJe/1QhBkFN1oeEbsHCGiEmr7M+nNLo42I7qC0wwO/sHzN/ho/x9+xPVR4+EuRrqXoiKq/z3ut6K1nF+PG4Cj/O+0EGkX18QFFvL1XUUF0YsqB97P3OcNaxqiiIA/16cZYEq0f3cWqcoIaZfqoqZCHs1XMArZqV1aRFZMPmk+E=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB7475.namprd10.prod.outlook.com (2603:10b6:8:187::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 01:10:38 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 01:10:37 +0000
Message-ID: <9b8a78f2-a734-4412-bd34-84dac39617a3@oracle.com>
Date: Thu, 14 Nov 2024 09:10:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/321: make the filter to handle older btrfs-progs
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Cc: Long An <lan@suse.com>
References: <20241113092838.302247-1-wqu@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20241113092838.302247-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0076.apcprd02.prod.outlook.com
 (2603:1096:4:90::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: f25efe0c-72cc-40d9-3d85-08dd0449261b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDQyZmljRk9SQmV6TWkrWEVybUZoNkNSRjFxRktDWWx1MVY3ejdjVUZXYTFW?=
 =?utf-8?B?WVZFOHVSYXZnL003TGZyNEdQanhSS0RNT1RQKzhFM1J2MWY1LzhtUkIxRUY3?=
 =?utf-8?B?MW5PTDZBcHZSZHBSa2NLbU14Nkt4dEwvM0xnTTZWQzZ3eUZ1cFBVM0E5dGR1?=
 =?utf-8?B?dEJUQ0htMjdjU2RiYTFMSE1DU0dQN3UxQmdSMjQ1LzQxZzdiZnlQYW1neHJx?=
 =?utf-8?B?NDlnRHhZY0J6L2dLdTlJVXlrRXZwWjFQV1l0UENYY1VzRFhjbTdobmZMbHMr?=
 =?utf-8?B?dmFpemxQRGZGZ082L1o2Nzk0bTl5MUFJUXJVWWZDNStadGlvMGt0T3ZjcHIx?=
 =?utf-8?B?UXM5Mk9Za1VBVitKWTV5NnV0VUJsbDlnbjh3TE5WYldjWmxSbFM2eitwS1Bj?=
 =?utf-8?B?Qi90T05IL2kzSXBkVWFWQXhhUHd6eTQwOVNRaWRCZ1hmMTE1RDZkRG4zRkkv?=
 =?utf-8?B?MzJtVVlLQTl1YVRLZXJLbEJLSjgxaXM0YmNEeG8vb2dNekhHT0dLUCtZSFpN?=
 =?utf-8?B?cDlKVFhhZjRPaDh2b2gxeHFsUGo5QmQ3STFhbnFnZlljZUhXNmVUREFyeTgx?=
 =?utf-8?B?a0R2alpYZ3JvRkpkMzNrWm9xVDNkb2RXTG1INm0vRVNEckxPSWI1TDJBTGZ1?=
 =?utf-8?B?bE9KZTJwRUJ1clc0c0dDWWFCQWdNSVVjSlJJZ2E1UjZ2L25ZKzY1Z1JZU1Bz?=
 =?utf-8?B?Y0wxcFZUbkJrTVVLQzdleXJMRzlXb0FJVTIvaGNqWEwyQXFIMlFaUzM5THZC?=
 =?utf-8?B?Si9rbkZ0QUxOdmV0dThaZitkKzdtUUQ1VUtwNGZweG9oVkY2SGpSZFdxaVBP?=
 =?utf-8?B?ZC9GQmphT3lLTEhBMzlFd3ZIaFVlUldPdVkxTjN5T1lGQmhjVzA3eVc1azN6?=
 =?utf-8?B?bVllUXNseWxZWkdvUUY5RXgxQkMzcHFMcGt5d3Fkb1VMV1NjUmxpT0JZd2Ux?=
 =?utf-8?B?U0ZpMWgwdXRUb0c2RDBER2FxdG5WZEVMcUJXYXI1eXIrNFl1bm5NZmpQSUZG?=
 =?utf-8?B?VEhMaS8wY3NCZ0ROeTNPeVB2bys0eUhtTy9JY3B6UXEySVNEWFZFMGVMSVlv?=
 =?utf-8?B?RjZ6eXFHL3kwU0FLaFBKMEVHQ3Z1azRzaWtHL1Jod1ZvZEtOUFBFSElyVEE0?=
 =?utf-8?B?MnJkOGtRYmp4cnR2dzk1VTV4VmN2NHJtQmVoS1lwLzVnSUFSRUVpYVdxKzB2?=
 =?utf-8?B?Nm83TFBRSHR5dW9JaU5wWldLMHEzVXN5ZXYrdGErQmttdW84QlMrUlNBQmVL?=
 =?utf-8?B?aHNzVzBlYzVBMzY1WVNEK2RVOTZCaWhuOEFhb1l4TFJ0REd6MjBsUnhxVm9X?=
 =?utf-8?B?cTloSzVtemMxZFl4Um9hK1VEbGlLRlBReW83NkxpYnZ0K2FXT0owOVJYVDF0?=
 =?utf-8?B?UTROM3VJdDhPSGdZZHlySVhMbWltYng3TDM4RFVsSk80QWZkMDd5RFBmOWdm?=
 =?utf-8?B?b1huMVhNbGtzWFJQTDFzL3liS3MrVFY2QWovRzFHdTM5ZEIxSVhUT0NDc2ht?=
 =?utf-8?B?eXhqR29jNy8vYlZVYitscGJ3TWlpeWhicHJ0YjZJMlk0aW1zOHc5ZEZiUlhh?=
 =?utf-8?B?NmVDdllXWU1YdldRNXQrVTd1a05ZZVh3S3dXVDZzSnZZT3BFdWhZZ1dyUldP?=
 =?utf-8?B?ZXRxd3ljS2ZaRmlGMmFSajRIOHlpSURhdlkwZm1LM2xpSmY5eG8yUzZueUVN?=
 =?utf-8?B?NFRXNSsyQkNJREpSdElWZHB4c01vS0ExRmYvcnRDOVhoT1JuVzViQ2NjMmtl?=
 =?utf-8?Q?QeODJrTPOVEbWtPvRs40t9vjIA1/po0YlQImkOL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFJrdXRZbFJYVEt5RjROOXJVa2RtY1A1elpPQUVmRVpveDNnOGhKOUNXRUNs?=
 =?utf-8?B?RC9QeUlMZjl3Z1VudVFkdUc4OWliNkNOTGR4VmNSS0pHR1BDemxrVVcrLzhm?=
 =?utf-8?B?SEpwQzdtejByRmE2TlZVcllpai94TEdyY2kxajB6S1RteWtralRYMDZWckZF?=
 =?utf-8?B?S2w4K1RicW9vcVNVNXRVS1YvUUhJOEk3ckRFc3JLYVhQcXhQck5maG5EWHN5?=
 =?utf-8?B?eXJNaU9JaTVWTm1wVG50d1hLMGltUU9pdjc3V2lQRkFmSktRNGtvdmJ3N3Z3?=
 =?utf-8?B?WnI1enRDdnJrZUhJYldOWUYvVGRjT0hVRHp1eXo4U2N3Uk80OHVqaVd3WVNN?=
 =?utf-8?B?cDV6NjdOUmdyN1lScHl5U1hUaE9VQmVzalFEQTBEQjRzZkVCYXdVMjRkRlVC?=
 =?utf-8?B?MXFGb3M0czNiSVFSdzJnVi9ybVNYUXpHRG4xanpPYTBrQmx4N2VJNUlmckNU?=
 =?utf-8?B?NGY2OUVwZ1U1YnZPaXlkbzBUYlFZRm5EUWdxNVd0UStuOGNuZmFUM1piMTE1?=
 =?utf-8?B?d09GaVYxM2ZqR2NPQnU4VmYydzA4dVZYNHBUTEN5blltelYvbkNhTlFjMnFM?=
 =?utf-8?B?bVo5Wm5lZXFzS1p3ejRheERJeTMxc1NYT3N3VjZaRHZjc1QrNlRZci9vZE5n?=
 =?utf-8?B?WGp5MGpCSUhXdVY5UEllUXN4K2R5WWtHNytBamRSYXVCVXFNWCtSek9VTnIr?=
 =?utf-8?B?enlNbmJMQVd2QkpMZktJMFZjMVI4UXJIZ2ZoN3pkUklZZjNmbHJ5MGJINzJ2?=
 =?utf-8?B?RXpST0hsSjVveEJTa0dmUUc0ei9LZGVkUEhMRXp2cGVuY3Q5WnM4T0VleWNp?=
 =?utf-8?B?WWU0dlFCZ2R1TDR3d3RaeEttaHlWQ0FRVVlUMExGR1B4RWxBam9IUnRIUVlm?=
 =?utf-8?B?Ujk5bm1OanNnMzVkTlBNb3JYclJXSW5WZ0pTRVZ6cTBlNHl4cU1lWE1CWGpo?=
 =?utf-8?B?bVhMUjZIajRPOUJFZ1BzTVVCQ3I4WllMd1FRYUpoSUQ1OFlMK3NrVGRKRHdj?=
 =?utf-8?B?R1YwSFlFeHVKS3R6L04rejZrbkZUWmtVM21aVVhqSWh4bFM1K2J6SVQrM2p0?=
 =?utf-8?B?elNjSFZlVDg5amlYWEh4d2ltQkdqd01QaVgrZitEaGFyOVRwVm41ZUU0YXpG?=
 =?utf-8?B?SkpncU5CWFREZ01yWGlJUUFxZFlxSGI4bFBiNFBhVTloN01jQUJyeGZuMXhs?=
 =?utf-8?B?RHdhaTc5K2RvbTVpdmJ5bFVkVnhHMTRERDF3ZWd5Vk9RQkhSeE5SRmx5bW9L?=
 =?utf-8?B?ZmtaZFc3WnA5ZS8rZG5YTUsyUTBhdzc4RVZuM0grMnZtZGIrWUdNSk9WdEVZ?=
 =?utf-8?B?TW00NXdMOWxnSmxGb3F2ekRmbVFPMnczVHdPVGZuQ1M2WWZUYUJvb2FvK3dS?=
 =?utf-8?B?UkQ2WnFBZjNraXpYSU50aXJjeGxpWVJUNCtwMmlGN1lUdWN1WDZTMXNwckpF?=
 =?utf-8?B?ZU81MWF3K2hpRUQxeGFYVUppSlhzTmZDVlZSRWFjSlBmQ25meHdFT2N2OHBt?=
 =?utf-8?B?Q2JNN2h2QVBWK1YxeTZ3WDhlVWZsYWU3MG1NNTFNM0tPa0RWalg4Q1pabkov?=
 =?utf-8?B?MHpFTFYwSmlkZlpteHA5a0JiM09qU05IV0VmNFpxZTg5K0dHczFtYlhVVm0w?=
 =?utf-8?B?RDAwYThXL2YvcUNhaTRyZEx3UUt6SXhveHRsMEhWaEZJYUZza0ZVSndkczM5?=
 =?utf-8?B?ZFBiRkNSc3pGSkN2V1RDQmRCMjQ3MzNNRzhING5QOWJRT05EYTVqNGhMSVhD?=
 =?utf-8?B?TGhGSzdyMGpSUGVWMFR6QTdzaGF4U1VRWEw4RTA5bDNzTkRjMEdIUDlYcm9O?=
 =?utf-8?B?MXRvZWw0d0U4aFo4ZG9hczdUQ3FSTk4rM09UK0ZFNDRSS2V2WjZGYjhFWlpi?=
 =?utf-8?B?K1pzWDhKT2FtVXAxN0F3MFpIWkVQVXNpclAxcWJtMWdreE5FdVB0aEMrSFl4?=
 =?utf-8?B?bHIzY1ZYRGxHMnJzM1pxTGEzNkg2RkNONUlrN1Arblp0Yld3b3prbWhSdlNT?=
 =?utf-8?B?dytPbEhhSzF0Zy9wTUNFZFR4QzJGVFVqZ01ocGNPTENhZ2wreDBQbDRpQ3Rt?=
 =?utf-8?B?TnUrV0gyZThSOE1Ra1cyRmpvQlU1RkRTUDJIQjR1anIxSUF1WmR4dWdnUmo3?=
 =?utf-8?Q?mYKYqnGNK7QSuwMjlPyWEzsx0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ICV2Kh420GGDhIx/nIMGt8lQmdcmZRfFvJFvRNReiju+LbjcKiTN4gpRGG36NCOb7lYhvJOgTg5F31qMP4JPgCCtjJ1vNkr0ESpR/TLMSoiUN+PuRquYkh+PXG661S9B0i7XoeCgaKH28lRwXuHfu8Q/OURtwwxlA1ZtXFnDB2WR57ZNMksG6QA07FchT2Ztg4AO60aWjGFR8lM6Yurjjy/j8WQNL2N9AhVzXl3ubn74Ze4P5QF89C3UHUdjyiaY2GAZOLSL/ZVQYesRwHzmFLhLuZR76FkoNzi2DDClefWYGylrAKn7/PVgEla42Se5GNdVyhk8INH9L2Us2pJv17GCX8xCXpqhEzrGnLApl6TWv00BVK2dXjc/v0NYEFVJOpBgXhq7i1AcYp1Lo1lUqBiLlM/Eagj+POjMJPYjEImZhcgX1MyVLjnEd+FEekr1lTaATSbqdaAIH4E5+tb8IZXBNrCV/B1/7RMeMMj0mzi483AdumnNxNg3pHxkpo5Y7oXjO3UgyfZ+Fval+AURVVTPRY9RHwID9wvl+VQxFSBK+Ap4vjLVECMXvam8jkkYqdz8Ry6BuuqOVSaMPAMPICDTXTQDtb7GgxggiZ+Mb7w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f25efe0c-72cc-40d9-3d85-08dd0449261b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 01:10:37.8652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDblf9YidgufBmwpGhhgSl4txZ2w4LiWVfHoZjX+lodrzXQdeaIBz+cY6aYm7tT/ZSj82iIr2kCI94MoYD39Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7475
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_17,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411140006
X-Proofpoint-ORIG-GUID: R6aWuY5DCdrveHhnaQNjb_AbYBZVQOzo
X-Proofpoint-GUID: R6aWuY5DCdrveHhnaQNjb_AbYBZVQOzo



Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx.



