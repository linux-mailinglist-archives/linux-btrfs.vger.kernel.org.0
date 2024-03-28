Return-Path: <linux-btrfs+bounces-3699-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3D388F9EA
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 09:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8B10B248A4
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 08:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7078548EA;
	Thu, 28 Mar 2024 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qg1lV7wP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZReUH/Bs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A1A54775;
	Thu, 28 Mar 2024 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613834; cv=fail; b=NK78Up5hl2tvU2Tbr6Co2BSmHi7GZ5PkwZYJ1A6URT1k6Dfzeg8plU41X673G0ikGakzv6Pg+BBT/bqI7lwhBcwVitafuKL5kxJ00wa1kY6dMTyjmbpz5ZSJQUrytVPnridiJqldy4rAlmKjJHMehw/1tcWqjvw7CcTNO7BEymQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613834; c=relaxed/simple;
	bh=n+5+0MQ2BVwhyc+LD30PuIgc43e+4dkt2cEuput+syI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m+TKt2g+l2WIwacnYrhY43jr4gzWYb+VXF257OXfOeAcqtSPqzHxnNQuvngwqaGl221UZg+f2iCvqm8+mnsULD30NxoIhN3ChdOLJttnRF1xcm8zPgUhPuIvMg0CL2w2v+vxGbDXNSK9woJc17Tim+ks/EHcDsf45iRDmuVjyf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qg1lV7wP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZReUH/Bs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42S7EERp000491;
	Thu, 28 Mar 2024 08:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ve8qgIQ6UV1+Kcem92NrKQgumjWOmy0mhChMLzOuZ1o=;
 b=Qg1lV7wPyWfYBN6AtG8rd6fR/ypeeVRdLq0nmMu/MbGPz0Wx3zLb/YcoFdfTpGJ5HsuT
 z23aEKmuhG5Fbpn0AoR0S7wt6/b9xRNBPnSw6saM1iv1hb7fXwahib5ucQ4sVt29rxIc
 TnZQ0qirqqWMBn8gnzUclqqqLukMII+N4MB2fd2kSCt/CBqM86t6Az7W5+0fr7Mupw79
 K+xSwc1gsnAmrDrUYnjK/Zct03f/n/D8/sh5CL4iABENGr1Xl2qr0k6ncwXMjEB+Nztb
 wQvP5/QcL4Da6x8RU5FEOngdW5S3Z7OOcw6xnvO2CNjKbXdVHHImp9OAWnK3tJ/S4mZi wg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x2s9gymfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 08:17:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42S6FcP5019057;
	Thu, 28 Mar 2024 08:17:05 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhfxudr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 08:17:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2Y0a6frOgLnY8H/v/w4M/Xk+s85CBi9ckipRg2pYzhx1h34c3rRTmD+qauGXpWrW6VrN8jAS6Dz7NLkF4eSqE3Vo3i827e4kJvJxdCWPAQB/fJU76rYPZvyJi6T5IjBx7ZL1AyCnxN4uJQVmTV9s3LLIcwoTMUnXswwW2kmICStRmphMSDJt6wJqUorYjhOz2EGKr/I7MBEso9cpPsJEvxRMsFf7oUMwQAthkZv+FWo4arqw2z6T65YzGMHVCiCtIBWjF701v79E1668WGxnuama8TW/uaA2gjvBfDirdtu/PrJ2PqOO0OfvEZzDobYo1hxXSCGfeocNfJyV6zIpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ve8qgIQ6UV1+Kcem92NrKQgumjWOmy0mhChMLzOuZ1o=;
 b=Yua265vkLKJtMe/vnNkGEyzaka2wW23GvVZPPzLEnArTZykpVN6GVqi5Mz7fKqot+7HENreBILaWXhwSO51+Zr2SG5Y1gwdKnl/pu9MFdfuoPnXl2niOuESPzC5s49evogzqjjSnBRWfrT9kX1v4b8ng37gHP98OaQSFz0OpZRUEjFuPyGPnn07pD8D8ZQ/gNQFEDxmIMBO104W27dYT+W8exWBwVeh6jO4qs507hEqBY0R9MwX4lfxbocdMzRGyMVfc7IZ1xHiw5Giwxv9flagBh7rA2qbwma5JLZPeYhLD2T9QmkyLKS/RUZiv+ZQCtvJZtm7A8DTA4JEan8D86A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ve8qgIQ6UV1+Kcem92NrKQgumjWOmy0mhChMLzOuZ1o=;
 b=ZReUH/BsaJyUe/TngrcoiuHbZ6ncZammRDt8uD8/DuW77NZRuAVEFWtC0GolGELF/RHwf5xlCkM2f+KjhMKNn9pJjxXpLWdTrCO68YRN/EgY4+ZEME1yLPFXMEmwwEQbO7ktYNyNehCMGF3zJ7f0cvfcmMSGJUNblJmC8ydEbxY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB4992.namprd10.prod.outlook.com (2603:10b6:5:3a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 08:17:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 08:17:02 +0000
Message-ID: <15593268-e561-4054-865a-98c704fbf65e@oracle.com>
Date: Thu, 28 Mar 2024 16:16:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] btrfs: add helper to kill background process
 running _btrfs_stress_balance
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1711558345.git.fdmanana@suse.com>
 <e5f1141cbe307e6057554e1c8fb8cff188ab68f0.1711558345.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <e5f1141cbe307e6057554e1c8fb8cff188ab68f0.1711558345.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:4:188::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB4992:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d0ee57-ddb2-45d4-ed0e-08dc4eff722e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mYWq+MJMtDRoiSLlSgDMd299kQSIWCEpURQ5CT5fudDFROTjsFofvjnsQu8RADGzbqsU8V6e4gnTGr5A38P/v3mFm8RdoLo9bmqEWnhKhywWxvBEb+6w45wD02q1hNltSnASJqRfQRWIYpgUcSv2XbmnXEZQnufLl8slUmw+h1IZrhqiQBI/0n1bXe54Hs+up0KBFJtaHXfv2Wnd0Xt2y1uNpg4lNT5kFNovGIbjoktarMgHeK/iYq95KXHaychhvm6peRVxDeMbfHP9Mkq8laOF1Bgno7rXD6D/hLmgAlB/ppnOFzNVb8ZH2B9YNRuQ23HGzaOHXDEuzc+in5PKNsALeS1B/HDQ0BjxVA3G3b1YUgwX8B61G4LGB3wCCDO0rTTJtBN0ye0ynpyDTf4jkkfh28KxJl1yW2+4My5zLLa3kMe0/H70J+3VJSZKr4ti9TDZu7ZifaS1dhid4OP/zeb5R2MZFRcprIYXWURcVHAlMvEQ5kwwkkVvhAxeT+8QQV5RhygiRNgjhV3Kf8/DxHUkSnUgMi1g5pY9If0OKSxy6HJj6s535WUjWR5Ztc3E9u2MXFaNRcbrC7Tmt+fZy+fkjbUbG9Ze0MNtiAyDnlYCj6DEIral0cuBbt1ySutaUbNRBxJlgI6LD2BsYRq9b/BJrvfJbGufBlAwOwba75s=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bms1QzBCZUhXQ2FnMUtQNUVEd2ZlRUhxT01GR2ltRjdkK0hWRDZELzc4b0x0?=
 =?utf-8?B?a0J2S1kvVE45dE5xR0lOWXFQZy9tRFpJMzRtZFNaRzlhUUZQQkxaY0orYzAv?=
 =?utf-8?B?R0UwT3lpQ1h2S01FSG1LT0tzVmVFTVNwbFA3V2ZFKyt5UDR0TEl3NlRGRldE?=
 =?utf-8?B?c2NhWSs2WUJVYXZWZ2VLVG9XRzJCanFYSVoveUI3ZDRwaUVjSWdoY3dFaFFq?=
 =?utf-8?B?VVdKVjZtanRLajVETW1NVHV6azdOcWt3bCtUcjRFcksyQW9jODB3d2JhM2NE?=
 =?utf-8?B?cFZNekhkNDBxY3kydDI0U2JlQWZNV1N5VEF1OXE5RnBuTjBRRFRsek1HeVBh?=
 =?utf-8?B?ZUUxZU9jUVM1REt2SkgySE1keTZuSWhua1BNZzFQSVovQ2tUTVlpS1hZTnZ4?=
 =?utf-8?B?N2Z2REh1aFZnUWkra3NURVhQU2ZBZzd4OGxOcVlxYnZoVTRBeU1PUFlabHFJ?=
 =?utf-8?B?NE1FMlNSRFJYOHU5Q2RtT2hxeTRFUVhoR3kyYktSR0F4S0dzbG53dWVDTmZv?=
 =?utf-8?B?ZzZPdXYzM1VQNnpwLzhJdkdISHIvbXZjTjcwQXRxclNOU0ZsZWo5bVc3WXZH?=
 =?utf-8?B?OTBMWjl2SlBYZ0l4NWduS3pBSGlSNHozeEJPem9HYnFnUUhMOFNHMDRxUFZC?=
 =?utf-8?B?cnZvLzRVQ1hGTHo1RVNDVU14Ylo0SUtBZ0RwZ0x1YmhMTGpmelBTWVJYbFNl?=
 =?utf-8?B?TWxoVjd6UjJSVlNZV0tucmIvYm82YXQ3VEZMQ3RrOE5iNllQallzY2QvVnYx?=
 =?utf-8?B?NkpUNVVZTStmSVVMVjhHb3A0ZFRGZ05sOUJYTG9WYnJDOUhKZEIrbW41MWs0?=
 =?utf-8?B?Y21MTENkZlR6SWdiVlZMODVLWVBlV2NCOTVZaTU2VUlqYkh6dkF6RjdoRkxM?=
 =?utf-8?B?bTBpWmttdHh1TkFVcjByMlZPRUR6d1lvUGxyUVZFRUFwL1Jsb1VtZVpRRUVQ?=
 =?utf-8?B?YzNRc0s4UTA2U0pINEJ5bC9GeU12Q3M4V2c4TFRxdytNeWcrYThqOXNVQnRI?=
 =?utf-8?B?Q0JLb1g5MjF6ZXFDZms1L0dSK1UzejVrVnlOUSt3MjBQTktZdDBxS1c4cnRC?=
 =?utf-8?B?eDdqL053aFUwY2Ezd0ZZdHdNclg3d1F6dTZEYjBxMzI0SzdJaDArUFhoUGJ1?=
 =?utf-8?B?ODV4ZmJyZU54RHpGdjhBZ1dGenN2REMvZ0x2OGFYRlUvemZ6UWNMU0JxSm4y?=
 =?utf-8?B?VEtuNmwyNEE3KzJsYUtsSTMwTmZKeDdzQVNuM3NPN3haUmZjSnRSSTIzZEg0?=
 =?utf-8?B?dHU3d2dmeFJJT0U5RnM4aFZEVXZ4SnJsK1FKQ0ptdDVkOWIwRkFzSkJRL3di?=
 =?utf-8?B?aGF6L3l3ZUhkLzJzWEdERnpzZGcwY0g0akx5Mi80eUF2K3J3ZVlrbXZUR3Uy?=
 =?utf-8?B?dGh0U0dta3A4YzZrMXBEWGtjUlBDREpBMEk5TEQxV0srU2JoM1RESUdQVTNE?=
 =?utf-8?B?UVFFYStwM0liWjZLM3BVbTBKYlB6YTJlVjUxV0RyVWx2QnFxbWtjMHpjMmtU?=
 =?utf-8?B?cWNBai9OaExKS20zV3c4UXFKUlIzYTZkdjZBeHZJRDQvVmFJOGlmNEVaS0VO?=
 =?utf-8?B?THA0NmVDbDYyVVE5dEs2eGU4MkN1QTBRaFEwUGJqa3RON29NVU11NldXeUlH?=
 =?utf-8?B?N2h3K3krTTBLdmFGTlRjeC80NjRLVCtHU3dBc0JtSTBSaFVucm01anErczB0?=
 =?utf-8?B?bHVVbjUwQ0R3WnA4Mis0ZnVHSWgwYVpzY2dTRW8wV2hZeWpodW03MHp6NU9t?=
 =?utf-8?B?T1JMdUN3M1ZzZ216dW9hRFYwc0ppT05TU0ttMFFQeDhQVThubklxVHVYY2NQ?=
 =?utf-8?B?U29aZjJJTDdycTJEcVhtS0R6K3NMcnNZcXJKUWpSNlExaGpXVm1IeFdFbzUw?=
 =?utf-8?B?eE95ZnFNOUk1MWNHOGVXQTA4bmVqWU5OQWx6ZUc3UnJSTW1qZEdJcFkvNWNN?=
 =?utf-8?B?V2RuelBqbjVKdXhLWEN4NU40VVdGNVdtWDFRbzhycnE2bWpkbE1MeDNBdW85?=
 =?utf-8?B?a25ZMzFNaEFtMzZiRjN3T0YxMFd5c2lKU2hoSVpzamlSWGUvdEM3WlE3aXlJ?=
 =?utf-8?B?TDJGY3QrZ2twTWRYWGJWUm5yS3gxQWtwc2wxSW0yZUxzRnd5R2JTd0JEV1NS?=
 =?utf-8?B?bERCRkJxOE1jYlR3MURxeXFHZnVqRW9YbVl5cmc0azhKUFdwQ2p4bG9rL1Z1?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KuZkiiLVFbCXEEmsmpLoliZNPK2tieSO2ijfUJzTFu0qM4LJxgnAugTOOKVvQAczI2pqpV/mcYWX0kjmyYPEz9zUNkebcjXkBKsj13sBG+kbwfUT8KuyoBi2XAGnNqxz7ui1vdnoAKDHuLZkEsk/ZBL+0JH2AWfHTQ4+ZiT6z3PVren0CFPkcvWXBFY6asr+Iumhl6cVbyUAj17/2o+Mc26S1Wn5euOGrf/2w5p8juinToCgpIM1DAfJzaYrZUiZ3q+0N68AX8BeLmMjAn6fDtqvQTAprwKlJQeW4EVjT8OR2c9KHakhDbIVLiwmm4+Slr0F7R8LmOzBQH2hfRLFDcZ8QmPVxO14dGFXiewIUUoOw0SLceEbBsEdhq7CZRljA73jV44VJLVotXWvptx2dlLsu2MmmNWo5r1+9kfyAFX1EKHsB4dFPGkrsOK/Fll7y//OBdgMrqzSlD7sWvV2ipcuSI40SQo3idPYRRWs8Jx9SFjO5zdwPIYj8MW+X5JyE1lKD66M26on+UsFvQkRZC/uQJJtXzxRGnMZi6BkInFMR0luoRT4zOFclTMS5qwW8mlnsBLeHuFavxzGNUX28YRNaC4/41jId0GWke7YL78=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d0ee57-ddb2-45d4-ed0e-08dc4eff722e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 08:17:02.0571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0uFAsd444Xz/q/2dK02vxbT2mkTaoeoVMOpULrHieXK4awlnUqkF1DWzQy69R62hiXSVijV9R6qKio9nlM/pAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4992
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_07,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403280053
X-Proofpoint-GUID: AJnqGHMjPuKyYGIs-ZwBZa-_HyDG3ERu
X-Proofpoint-ORIG-GUID: AJnqGHMjPuKyYGIs-ZwBZa-_HyDG3ERu

On 3/28/24 01:11, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Killing a background process running _btrfs_stress_balance() is not as
> simple as sending a signal to the process and waiting for it to die.
> Therefore we have the following logic to terminate such process:
> 
>     kill $pid
>     wait $pid
>     # Wait for the balance operation to finish.
>     while ps aux | grep "balance start" | grep -qv grep; do


>         sleep 1
>     done
> 
> Since this is repeated in several test cases, move this logic to a common
> helper and use it in all affected test cases. This will help to avoid
> repeating the same code again several times in upcoming changes.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

A few minor things below.

> ---
>   common/btrfs    | 14 ++++++++++++++
>   tests/btrfs/060 |  8 ++------
>   tests/btrfs/061 | 10 ++++------
>   tests/btrfs/062 | 10 ++++------
>   tests/btrfs/063 | 10 ++++------
>   tests/btrfs/064 | 10 ++++------
>   tests/btrfs/255 |  8 ++------
>   7 files changed, 34 insertions(+), 36 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index aa344706..e95cff7f 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -308,6 +308,20 @@ _btrfs_stress_balance()
>   	done
>   }
>   
> +# Kill a background process running _btrfs_stress_balance()
> +_btrfs_kill_stress_balance_pid()
> +{
> +	local balance_pid=$1
> +
> +	# Ignore if process already died.
> +	kill $balance_pid &> /dev/null
> +	wait $balance_pid &> /dev/null
> +	# Wait for the balance operation to finish.
> +	while ps aux | grep "balance start" | grep -qv grep; do


  We can use pgrep instead. I will make the following changes before
  merging if you are okay with it.

-       while ps aux | grep "balance start" | grep -qv grep; do
+       while pgrep -f "btrfs balance start" > /dev/null; do



> +		sleep 1
> +	done
> +}
> +
>   # stress btrfs by creating/mounting/umounting/deleting subvolume in a loop
>   _btrfs_stress_subvolume()
>   {
> diff --git a/tests/btrfs/060 b/tests/btrfs/060
> index a0184891..58167cc6 100755
> --- a/tests/btrfs/060
> +++ b/tests/btrfs/060
> @@ -57,12 +57,8 @@ run_test()
>   	wait $fsstress_pid
>   
>   	touch $stop_file
> -	kill $balance_pid
> -	wait
> -	# wait for the balance operation to finish
> -	while ps aux | grep "balance start" | grep -qv grep; do
> -		sleep 1
> -	done
> +	wait $subvol_pid
> +	_btrfs_kill_stress_balance_pid $balance_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> diff --git a/tests/btrfs/061 b/tests/btrfs/061
> index c1010413..d0b55e48 100755
> --- a/tests/btrfs/061
> +++ b/tests/btrfs/061
> @@ -51,12 +51,10 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> -	kill $balance_pid $scrub_pid
> -	wait
> -	# wait for the balance and scrub operations to finish
> -	while ps aux | grep "balance start" | grep -qv grep; do
> -		sleep 1
> -	done
> +	_btrfs_kill_stress_balance_pid $balance_pid
> +	kill $scrub_pid
> +	wait $scrub_pid
> +	# wait for the crub operation to finish

s/crub/scrub/

Thanks, Anand

>   	while ps aux | grep "scrub start" | grep -qv grep; do
>   		sleep 1
>   	done
> diff --git a/tests/btrfs/062 b/tests/btrfs/062
> index 818a0156..a2639d6c 100755
> --- a/tests/btrfs/062
> +++ b/tests/btrfs/062
> @@ -52,12 +52,10 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> -	kill $balance_pid $defrag_pid
> -	wait
> -	# wait for the balance and defrag operations to finish
> -	while ps aux | grep "balance start" | grep -qv grep; do
> -		sleep 1
> -	done
> +	_btrfs_kill_stress_balance_pid $balance_pid
> +	kill $defrag_pid
> +	wait $defrag_pid
> +	# wait for the defrag operation to finish
>   	while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; do
>   		sleep 1
>   	done
> diff --git a/tests/btrfs/063 b/tests/btrfs/063
> index 2f771baf..baf0c356 100755
> --- a/tests/btrfs/063
> +++ b/tests/btrfs/063
> @@ -51,12 +51,10 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> -	kill $balance_pid $remount_pid
> -	wait
> -	# wait for the balance and remount loop to finish
> -	while ps aux | grep "balance start" | grep -qv grep; do
> -		sleep 1
> -	done
> +	_btrfs_kill_stress_balance_pid $balance_pid
> +	kill $remount_pid
> +	wait $remount_pid
> +	# wait for the remount loop to finish
>   	while ps aux | grep "mount.*$SCRATCH_MNT" | grep -qv grep; do
>   		sleep 1
>   	done
> diff --git a/tests/btrfs/064 b/tests/btrfs/064
> index e9b46ce6..58b53afe 100755
> --- a/tests/btrfs/064
> +++ b/tests/btrfs/064
> @@ -63,12 +63,10 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> -	kill $balance_pid $replace_pid
> -	wait
> -	# wait for the balance and replace operations to finish
> -	while ps aux | grep "balance start" | grep -qv grep; do
> -		sleep 1
> -	done
> +	_btrfs_kill_stress_balance_pid $balance_pid
> +	kill $replace_pid
> +	wait $replace_pid
> +	# wait for the replace operation to finish
>   	while ps aux | grep "replace start" | grep -qv grep; do
>   		sleep 1
>   	done
> diff --git a/tests/btrfs/255 b/tests/btrfs/255
> index 7e70944a..aa250467 100755
> --- a/tests/btrfs/255
> +++ b/tests/btrfs/255
> @@ -41,12 +41,8 @@ for ((i = 0; i < 20; i++)); do
>   	$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
>   	$BTRFS_UTIL_PROG quota disable $SCRATCH_MNT
>   done
> -kill $balance_pid &> /dev/null
> -wait
> -# wait for the balance operation to finish
> -while ps aux | grep "balance start" | grep -qv grep; do
> -	sleep 1
> -done
> +
> +_btrfs_kill_stress_balance_pid $balance_pid
>   
>   echo "Silence is golden"
>   status=0


