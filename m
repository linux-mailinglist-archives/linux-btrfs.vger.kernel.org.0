Return-Path: <linux-btrfs+bounces-14225-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA88AC3282
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 May 2025 07:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FF821894D77
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 May 2025 05:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA52816F8E9;
	Sun, 25 May 2025 05:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cK77Cj+z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uALZMJzN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0F84414;
	Sun, 25 May 2025 05:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748151694; cv=fail; b=nTwJ3eKtiqDxzSdTUJyCHweeZidkVdxJW8HWZ+cQ0vIfXHr31X6Uxj6oMKo5pnKI8VOg0+XmtOSAkKrC6ntrMCYZgIOPhPE0sXW1ZleA54boBD5fzAl7eSZf7i0KAgDTWE/n8cptwGIvydbbX00f2sdVaps/gBoX875N2YRQzmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748151694; c=relaxed/simple;
	bh=OqqkNCeKNcnraAOZvMtwaDaijqpoJSxBnuh7+tz9vBE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kru+M0baEX2rKonBanluduq1zXXwVEpefv0l+6aYwDh5jO/mUZfxrnY51D5SsUwIoV7wbI5u+cO3IeBtABkU7QRMozcnuQcFfRb/P6fZb3IWnAm0PO7GRINknTOpgnIZ8M8hpvLdnO19Iy9Txrqwvj5HLwLBiY+xVykOqdrygkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cK77Cj+z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uALZMJzN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54P5HtKO004913;
	Sun, 25 May 2025 05:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=i5yVcPZI4yYECkLdGNMIYxshF57RyilnclK6S13eG3g=; b=
	cK77Cj+zC0ZQp8RXUQm2ZacjWEwLlczboDAAHyV/o8L+rhIFXShwNR7+HC3KYnUA
	tzUd20CzByxP9q0gCXz2tR6wZQuRvkBebf+xlQeFFklnsTt6+FVS8C1hDTyjOrh/
	v5svKSx6uT0AFXN/O7BWvGelNW3Jm7RDAJ0XUh8mhZP9XvEZeqy5NlUct05FNptk
	ck3KFP4Kk0oywvN/lDbQ15BfwQFdQAZZcgt5qMRW0LMjXUgb5HL3sa3yqOLiTLag
	eRu54g+Wn5i9ZTbO6sifiHyNhegh2e0+aC3kp73OiSn+cL1upA12wvkTrftFLoI1
	WhSUBPvSd74G80KV8fpX0Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46uvqk00jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 May 2025 05:41:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54P0jZEs035682;
	Sun, 25 May 2025 05:41:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j7srg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 May 2025 05:41:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Do8HzKNo/OvJ7xz3Up0Yd8Hb5Fd78sXPuJPdvgF1a36KzsHsszzhb7zZWKUHYQP7D0TyjkJUua2Lgxcrx5lc4RkK+wnsraFePKk9c8GnK/gNgu9/Y7QHvD4D7b8rAv4la7ep+yl3r5QkQKHLNHEQdGASm3YtbRdgtMryyGBIBFQCHxQg2IXuO0XVkqQpQENY9LkOU7u6ACMKs6rI4yDwgRxIXGhaDKUOYwALVLUl/0gkNOjr0+g55lOdHjmSIHOPuzb2dSKGFoAI13FxtszxRbV9bL16y0VgCcWZTx/waC+yOhu8cwQi9hD766f9e4ge9/ouRtkD7KRukEB2Mfsehg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5yVcPZI4yYECkLdGNMIYxshF57RyilnclK6S13eG3g=;
 b=IT6NrZjuHf3dKqfeyMyAHHl872/WXGy7SiRk8Cy4CI9ESXbNITmQhsgO1ptyefz8hZCz+MAOZ9z+qL0yGsPiq8oBCNCqFPIWz8b2pEA3/CKvXb6xnMXDZT4TcGg0iLQO4WQyuIoljn4afo3cS6QCuahg89M7MhvotIQtHIHTqIL6BBsBtvgcou0FG7XoQx1BggqyjfWNpuxliAXbsUBBSelpCZosaXVlfiyfilRCA0mqEpKgHgHfjUL1WtJSUQT3wq+BcJnNU86EO9z9/Oj6+FJN00z138fBnSMaLrwxwigeLivqMRw7Hsuaq9Xb+ee63NpI+BLKkXNgNfM4QyXDCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5yVcPZI4yYECkLdGNMIYxshF57RyilnclK6S13eG3g=;
 b=uALZMJzNhPSs0mGrbov596gLDjBgcLyx1XIRn504MRZP56BWTEsCOVlDvyXg2TIDnQNeVaDudg0yrNimu4CFnf/kU3K3XiNGJPqM0Z4r9t7RZUMnpyodGKdtSYj0GrWeU6Tpr4a191ykGkdtkO2n4uV90mMwKpgXuSD6ah1H2zE=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DS0PR10MB7431.namprd10.prod.outlook.com (2603:10b6:8:15a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Sun, 25 May
 2025 05:41:17 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8746.030; Sun, 25 May 2025
 05:41:15 +0000
Message-ID: <97d6425e-dd3d-4949-b63e-a53a6e210069@oracle.com>
Date: Sun, 25 May 2025 13:41:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next staged-20250523
To: Zorro Lang <zlang@redhat.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20250524040850.832087-1-anand.jain@oracle.com>
 <26d4ea00-3ea0-469d-b6e1-a58f717f4013@gmx.com>
 <b8e4f687-809c-47d6-8534-e2ffe0e85596@gmx.com>
 <20250524065222.v5ivpxkh5q57ke2v@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <f4c2b83f-cc13-45f3-9f16-03095b56e175@oracle.com>
 <20250525052802.pwujhzxdyj3on6l3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250525052802.pwujhzxdyj3on6l3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0184.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::9) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DS0PR10MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: 2353afca-39ce-4172-3d0e-08dd9b4ec406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V28ycDZva3ZjQXE1SzdTU01aWE1NVmNacUpTOHJZVmE0aGVxRTRpQ3hkcFpu?=
 =?utf-8?B?aHdLdDJ0bVNzKzVpSUE4VThpSGhRTWVhNWdSSU0vcnNPT0RVSnY5bjNhKzBR?=
 =?utf-8?B?VVdlajJ1YVR4dFhZYjU2RGF4S2xVMVRYZ2V3Ri9xc2Y5SUl5MERENUdHaUxs?=
 =?utf-8?B?YlB4UUFNbUJZWWFJQjRzWmp5Snp5MXhaWUxRNTNYZTc2MUkrNlR2Z3psTlFX?=
 =?utf-8?B?OERwQS8wSWhqalNQa2E1RG9YY1dYemJNM1lpQ2VuQ3QwSERmaWpyWkw4TG4w?=
 =?utf-8?B?Sk13Nm83bUw5UEVqYkxEZzhjMFRVdW02QVdIQ1ZPaS9adEhwdk9UWkFCQWJO?=
 =?utf-8?B?QmFiNW1EcklZWEp3T2Fxd3FNN0ZlYTVIdXcyV0lPVm1Cb044NEg1dFMvZEhR?=
 =?utf-8?B?dXB0SmZBWkJmNjQ5Sy8vMndJSnhQRm5DTHZtK28ycFY5YUpzU3o3M1Y0Y3Rk?=
 =?utf-8?B?RGVPSnBHakJBbURlcnkzVTdyOWxueGNyOFBVRzc0TW5ZWk91bTM2YkpOUDNx?=
 =?utf-8?B?QnF6ZURnM2hXejEzSW54eFNWM3lZWUUyMHdWOWRrKzk4ajA4NTZkbU5WN1VU?=
 =?utf-8?B?bk1yeERpVnhZdDJrUE8vMFdjaEpiSE8xWFFtbzFQeWJTNHhoQ0Y2eHJXREwv?=
 =?utf-8?B?L3FGdUFyRU8xWnRxUEV3cEJJS1lrZHNoQ2xwdjE0Skdjb0QyZHY4TGhaenZq?=
 =?utf-8?B?SjVReGtTME1EaVRFU1hDcVZ2TFBhbFR2RzZ5VXVPZ0ZYaFNVUkpPKy9TTiti?=
 =?utf-8?B?QW9YUHFWYk81VW9XZlVzaW1kZ2FnWnBSbitCOFlFK1FwdjRmNXllcGgwQzJt?=
 =?utf-8?B?ZnQvT0haVWhEVGdqY1NpUzFrZjBaOThxYUlSYnR6R2lTR0Fnb29kc2Z1bU5C?=
 =?utf-8?B?MkhFSGVjV1FHUkZjR3VQODUvNlFiRVdBcWRQNFpDcTdNcVptcVRQTUNqc1VT?=
 =?utf-8?B?dHIzZFZxZFU1ckM0eGgzWmNCc3k5a3o1U1gzc1l1aVgzQmJTc2t6ajgzOWRi?=
 =?utf-8?B?RjhGQkJEdHNqQS8xYmxKWUVYQVp4ZkFwMDBFRi84YXUwenhwc3JUS0I4NFU4?=
 =?utf-8?B?cmo2b2JHUjJnSmM2R0l0dFY5eGRGSUVCeTlNUlVxdXU5VmFHeHZjcW9FM3FO?=
 =?utf-8?B?Y0lzdGtOM1VyS29YKy9adFZ3aEJVREFwVzNIT21BNXh5SUJDdDRXVTA2UnRD?=
 =?utf-8?B?MnRRbDFyL2VxdEdLejU2Y0c3R2p1aGpzMkU3RDd3WWtHanV1NVhTTUc5MVVp?=
 =?utf-8?B?aHhyQWZ0bU4vOGd4WVBGc2dYQkZaN0taaUdhNXFoZVYyaVlrVUtXeXN0UXBU?=
 =?utf-8?B?OFdYenJxR29WU28rYzcxN1Q0ZkdGLzdMRzNWQUdXSlFzeC91RkZ0NzRJd21D?=
 =?utf-8?B?cEhkMVpEY2pFZ1hYQXg1aXd1WEFFY3o4K21Ic1p2Rnl6czhJa2FPTW55S0s5?=
 =?utf-8?B?aDJBdmFaQ2djMVZ5ZHBDTklaUWxWU0Fjb3NqTTB2NzcrOUJlb1l1Vm80SXZ6?=
 =?utf-8?B?NWhhbkVQL2xSTFRHeURRdkRhU1F3VTNFeXdXcnI1RFQvcTRsaGptc3Q1cU5B?=
 =?utf-8?B?dTcvc2ZrSVhUb0lqMnAzK0lzMW5WWEd4UUxUck9uM3ZnVzBRdjViNGVzZXVi?=
 =?utf-8?B?aHRiMlpOdFVmUGllWmJZc3YxOGlhUTZsam41cDVSem0xMWVDRHNvSXpBNjRx?=
 =?utf-8?B?K2dYUENoT0hEUTlDNkVDN2V3UlF1QXFaUGdhQ3pTMUxCU25QemQyaDVYYk9j?=
 =?utf-8?B?VTlEQkU2WWk2QWJ4aDRKS1dQNE9VUlZ3KzF0UXdkRWV0SGRUdHdqSWI4S25u?=
 =?utf-8?Q?0dUzB0JK0eDLsVU2evdOY6w27HSajdHGoFmmk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnBBWE84MC9PVS80RUZ4VndRdWpoQ1lqTU1tVXVZL2VxOGZzdlNqTnhTWXQ4?=
 =?utf-8?B?T0wrU1JHZndiQ2kxSE4zR1RhQUtCU3NRY0xxRFoyc083cjRXc2pOd0NoMVk5?=
 =?utf-8?B?RExvNWF3dTYzT2JVaDZwc3FTN1h3NnJ0czZvd3hyQkxxVkg5NlhXK2wzMXY5?=
 =?utf-8?B?RWRTZEljakw1a2hQQnVzMXk0dU5lenZCcnhFZFpkVk1Gd1NSYWF2Ynl5QlFC?=
 =?utf-8?B?YTU0RUd0UGlkakpjZmgvS1RrOWFFazZNZXl2QmpTZkpHaCtFeHlMYisvdEww?=
 =?utf-8?B?T1ZqRndsZWlUb0xQMFd0YkxOc1lrbktJOHdNNm9MUmxzRmJsK0UzRnBQUzRa?=
 =?utf-8?B?WGxGMWVvTkJ4ZlppMEw1QmpMZEU3N3gvTVRiRzBybUZZOXJkQ1JjY1VBdXpR?=
 =?utf-8?B?MEhDbUUzd0h2amRYSWg0V0Zoeng4RWJ6d1YyUVRQd1lacXJiSWUrSFJsVytK?=
 =?utf-8?B?VURybTk2ZUE5ekJNak12a1ZhUm5xb0xwejcxWjlLL3NmdXkvclFHUk11MDJN?=
 =?utf-8?B?eGs1SnRKekEzZkliQUE5V2l5ZzcrRFg2bUtXQW15WE5CaENwQkcrbjdvbXpy?=
 =?utf-8?B?VWNKajZFNGFSWFNBN1Z1SjF5ZHhiZFgxUlM4R2w5eExZbFBHQ2poaU5xTFRR?=
 =?utf-8?B?T1l5eDRObnRHdmJwYWVSMmdpN293YVhXeEszVmxrMTg4emlLbjhKcUY3S09W?=
 =?utf-8?B?c25XQmUwSFhxWFJuSkNrOHdvblBlWUQ5N1ZHUDhoMDYyR2F3dkt0UDBKS0xj?=
 =?utf-8?B?QjJXc0paaUlQbTVYemR4L08vUE1rdEJiQ3p5VkNsK01hMDdHRDdzbTgwMi9o?=
 =?utf-8?B?MlBteTNRd2pEL2RvTnljVEpEREdsUFE0bmFrOVVFaXpWZTl5OWZ5a3IrV0h5?=
 =?utf-8?B?ZzlIeE9ucUMyK2tCOE5hd3pTZXBra3NleHRRVURWckgzY09pNnJSSHpST2NZ?=
 =?utf-8?B?anB1MDRxTXRuTWdRWWo0Tm1IRmlDNGFCTE9qN2toVnV5N091QWMxL0dhQ2xB?=
 =?utf-8?B?K3JjTGNoUDBkMTEzMnhPRzg4aGlKOVRtMEdUSFlVU0dkdXZSaDZiMnNyb1lL?=
 =?utf-8?B?Q1RQSDE0ZkI3T1ZxU1lvdEdBdEYxNTBPczM3UmNjK3prcXlnTUNscEhVdk93?=
 =?utf-8?B?V2hLNDM3NFp1dUhXNkJrVkdEZENhT0JYejlIQk83MHMvTkQyZ2lWZTdLSGxV?=
 =?utf-8?B?WTF4MHI4SldWRHNxTUpubUUxYm9oL1FFY2o3Nng1NnVCVXMwLzZ5V0g1SWxm?=
 =?utf-8?B?c1dBRVhqMGMzU0ZWWFZrUm1saXJleEtBM2dnK0dYeTFrelA3ZDl0em05N1JM?=
 =?utf-8?B?SHJLNllyM1BiR05IKzJaWXZtRHNibWZPWEpsdDZPZGF2Y2g1VG4rQU5hZWxO?=
 =?utf-8?B?VTYrVW1OSEZjZUNxamdESkIrZFZWZ2UxME5jTFdQcDZONTh2L1lsNTk3MFRn?=
 =?utf-8?B?WkFRUE4rUm1JcFJJS0F4RGViaUU1d3NTeXlvQ2tHOUh1RlBqdllFRlZwVnVW?=
 =?utf-8?B?Z3lkUWlhUmpYTFlwKzFHUTN3cU1ucDdYbXh5dGt2OE5VWUVwN3ZPenlBb1Zl?=
 =?utf-8?B?VE5WZ2ZGNC9ybm9tUGJIOTJjc1ExTm5xTTVmR2dpV013bVpQYjdCOFpLS3Bj?=
 =?utf-8?B?d2VXUGdUNW5ObUFDYWdQRFRYN2JCUldwVTQ4MU9uaVgraFpPYmI3TGVxMjRU?=
 =?utf-8?B?NGZOVUdUeW1KdXlueGhTYVJCN3ZqalpHbHV2RUlWN0FweXV1WDdhbUdabHpQ?=
 =?utf-8?B?VTk4ZnFKTnY1cVBNVUhxT0FET2xGSnRUMmtkZjJUNmhucHlNdXlUSXhZR2VN?=
 =?utf-8?B?Y0phQk1GVTQzYzZCR0FQcFJuN203QjdHbW5jNURsdU9ROXNnRlVUTVRQMlRZ?=
 =?utf-8?B?VmVRQzVMZVRtVXoxNG9MaDcya2JVTWdYY1pTTDBuMnZ4d1QyQk1kZnRISUkz?=
 =?utf-8?B?WWFlUGJOdTdZMktibjJwbDNyTVJtWTlNc284UmNZcHFJT1F3YnZHOFRlazR2?=
 =?utf-8?B?V3B2Q2VxRW1zUEJkOThIS05qclFmdkl5L09BQm8ySURNSUZhVXdRQnFibFIr?=
 =?utf-8?B?VnQwOWlUS1RUYkVzTGtoS0Q2ZytQc1NyVzB2N1VpNWEzZGt0ZjIweUVwYXRP?=
 =?utf-8?Q?7l1A5nv6o8oy8FCKMTSETZMk/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KuXKWH8PXli8fHESRXtAsM9Db0uQj1ZWzI86574sKb3H9vP6gKZrmxJJts0yH04KC/2fKq96byWWtJD3X0i42yho1s8NYmmJnddIt5NT9EOgwqzvnEVafx6BFvJziI+caSYFAC3zFZfbpcMOpw+GRRj9mBSJnCexaO2l7kBARDdT5IpTYegRo/Yas+y10uiRanDHjK3RCFhMdM4O+/y8/D5BRv6bACCK0Q3wHGLkWfbJKONE8dE1cxBRHCDxPo7bGnMY5PQqbsknwJ3EWTJq7/M7eQBxJMyyQBy89AvesIeBBk6gVEWZEWnUj71CkHj5DI2cMI/9ndqMkHmJBaHswOIwwI6q+9IHiuCQ4U6fvhAFI+uxWi9eq4ltsNNIKnCEVu84n6tKMYLZtFQRiFBnUEHj7aVCmAcvPeR51wGpqfy6s7MJuj9hX0C4aIG2laEzp6+nYGosrXYlsnUvozV9/ppjzunYanGYJ2eS/8hKnz2KWyfaRhD/3g9rLZKd1wfh7MfM1BQ53lQVy+WWTW1dbKRMN5+0b/cncVHmbXKHLrIKyCJXr5zyeKwkygF6pFuDN+K4eh1rglWnmepnfvq7JtMjbAaxloupVgAW3FwOD7w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2353afca-39ce-4172-3d0e-08dd9b4ec406
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 05:41:15.8275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pT/uwQbRiaZwhPuZJ8McWsxk25krYXbRVVK/hxh2Ghq3kG9uBjZr8AfwJIc9H0UDxKpULWLqPRUaI/KbZK5ivA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7431
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-25_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505250051
X-Proofpoint-GUID: tdzFfkwaFYuXrNvzhOTnHZqBD6Ao3KYg
X-Proofpoint-ORIG-GUID: tdzFfkwaFYuXrNvzhOTnHZqBD6Ao3KYg
X-Authority-Analysis: v=2.4 cv=S5zZwJsP c=1 sm=1 tr=0 ts=6832ad82 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=OLL_FvSJAAAA:8 a=nJY5XOggjgMwj8yjQMwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=e72awE5OOzsA:10 a=ubxQsdc_O_wA:10 a=zZCYzV9kfG8A:10
 a=oIrB72frpwYPwTMnlWqB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI1MDA1MSBTYWx0ZWRfX0dyPkNuSF1v4 eW6SJtCWuy3rFF0b5IWhhpYHIDIGexrFwHgU+O1UKr2o+gSvqUp9A3MW28nv5N5hVA+GU1IS2V+ kkmZv8EdhEJ82NMMpzR5ozia3AFf7W+m9LcIEwtrBmVvxFu8UYNoCi6kqyi3OahdNinmBLLVPsy
 ecIkK54ZQjuhzh+s3fJKVPxn8SOF/ArhgkwK0aPbtu5Xf+vLsqyULyq2FFaBsSVlq4b64DTTj4V wX6rIjwSqCHEpcQEwPIP542lCzflpAQJwgGKUVw0g6BnCpNHyUdPLIrsHipYSaNXKpmrVe3PdOJ tpLHxxUofU3hdCF7Qj+V0xS5+qzaV3UgnyiSnj4ocg+BwNU4I2rwTj2QOcli3nNIZP3CfnuqEyj
 tJ/QDg0J/5LhlNAYSjR51AjKvXdD0ibbeEulgtdmbywX0DaMIzu8pXcZOde/2/TbsIkOXmbK

On 25/5/25 13:28, Zorro Lang wrote:
> On Sat, May 24, 2025 at 03:52:54PM +0800, Anand Jain wrote:
>>
>>>     3bbdf4241 fstests: btrfs: a new test case to verify scrub and rescue=idatacsums
>>
>> There’s an additional fix on top of this patch that doesn’t have
>> an R-b yet, so I haven’t included it.
>>
>> https://www.spinics.net/lists/fstests/msg29195.html
> 
> I saw you talked about it with Qu, not sure if you've reached a
> consensus or will send a v2 :)

3bbdf4241 above has a bug, which the patch in the link also fixes.
Others need to comment for the RB. IMO, we should have the error
code in the golden output to make sure we're not breaking the KABI.



