Return-Path: <linux-btrfs+bounces-2053-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D79A846595
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 02:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA12428EBC4
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 01:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1737882F;
	Fri,  2 Feb 2024 01:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lzgGxTb6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Kau31IUQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C98E63BA
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 01:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706838775; cv=fail; b=tH8Rsty5oIxTCnqTzuRhvU5OsXlNNUuSAb0NjUQECboZjfENvb0lX89PvTGlAzHu3ip48EW+1/PPCFEHjJmO4NolI0FpCjfjTVh9ULaIBZMnniBSBV6M0Or/FTJUIut9VRHXHCvYeI7x+0pvN7TAcgNRmLwWJxON4gtSButQU7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706838775; c=relaxed/simple;
	bh=IIjlnSiyxlGfmTJbrMLghXnNLgl8qLpVXowtjWhfF08=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I1I9rMtsJKNw839PAH8ZBi7HuBu8GBnPdPPyewymW5suR22We9bopmWIV5XAjRUTr4K2dOI05tPKDBQDgin0VLzI/nLhPgRk2SR3xeJkvR9Tn36+XVCJPsiR/MC8v1G+Su30dHiDlF8ZLNCk38FPU3xl0UhoWDF/E5fh9e7ocEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lzgGxTb6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Kau31IUQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4120k596000490;
	Fri, 2 Feb 2024 01:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=TCBxO/HB0zQ2BYuFpeHzxbmxtXXg2GZ1M7wJVSzi3Tk=;
 b=lzgGxTb6+6df/cxeoTHN8ZewnGoQOxzzaCwS4/z+hbxgkxJXCUFf9SQyQucuE4z0UI37
 TkHT7QoTRiOsEaCcavUrVj1AWis1tWooRpHSLrKogI5Xe+bkPcfrMwAXvjdSNgQQSUzG
 vyWDHeDpe9Mk2EuxGrGN3terCXoPeicb43461+sy0aBZvygzy+/KifZjrpHlP4LVzQtV
 1bdsS0Eq7rbX3a+pr+FILopHX0UP37dntuXmH6KycDZqBb/WeOewyfBZ/yLUXp0Q9xyD
 dXCkJ6jAYPM/CrGtDO03Yu+EpEmGM2skMEOi1LcblkCH/uBLrUObpK3byqACWYDBNN+e WQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvtcv6egh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 01:52:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4120E1fa011648;
	Fri, 2 Feb 2024 01:52:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9b6r9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 01:52:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ap+SM2/x1rqo/R8qW1fQzWFgrK8a34kij47o2nJ5GUbIPjObUI0VdFVhMTy7VHpanLhA/0/3ddRtMfk6G8lE5T1a/FZqtQj6kkKepXYorKikbFxotK6r/YVOATds0ATKc2Np1ehhYugpoQSvgS8q17qwkU8tHs+qEpRMUX8Tqy4el6z69Yu0zjwKJe/bGwkx25il9aqZxlVgf7263uZUWkzf3fmqvaZugGoVK+1x3B2s8zom9ia2lTINu+UfHIthsAw2Gq5MomwzXpE6o6R4a6owNQpX/DUXcTdGhMstaD1xv3ic29DuWcCn3xnlNta+pC3JedCe9sxVQVbp7IAjsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCBxO/HB0zQ2BYuFpeHzxbmxtXXg2GZ1M7wJVSzi3Tk=;
 b=mwyE4Nml7iLXjUDoBWQf8W6r/JaZcxvoN4aPpY1ZMwstT4eli+198u1yzjsHHr3xAUpWHHd5S+we0iXQ2wf/XgdeuwsMbJ/SilmeBimB+UPO9u03nTKeg++hg1o171dncPc3d1gmVEygDDJ9Lv04hReJKLIXDqO80jKAA74eZCTONX2sLjbrD6FwZoFl/AyQstoy42otjmmcCkewzotLehHsYot31bvWQp8o/gVnEcimHdWP/FE6fCzKSEC4y6k5iV8Rm5C8FAEjl36782blNMbCI6s0Vlb4iiNjEIzYIb8+nmTO3LdP/0xm2tOtl1k3xeWXG24m1kd9HI3JRQ83hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCBxO/HB0zQ2BYuFpeHzxbmxtXXg2GZ1M7wJVSzi3Tk=;
 b=Kau31IUQQvCRn7b6tGvQqvj6LjUNi7Jw6sCHI9Z7VNXayyap5G80tFOR2Bk5FKhrzfccBvAge1Gfn1la4iN6TxmCBVFfjNUBoegphGx1npNruNnVfMK4Obku9+2P1nohC85uuJ8K9TekOx6pL/O9YXQN506Tm1ABWg2qMKM/HRA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB7359.namprd10.prod.outlook.com (2603:10b6:208:3fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.28; Fri, 2 Feb
 2024 01:52:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7249.025; Fri, 2 Feb 2024
 01:52:45 +0000
Message-ID: <3d693d91-0a6e-43ea-a114-43a25904022b@oracle.com>
Date: Fri, 2 Feb 2024 07:22:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] btrfs-progs: mkfs: optimize file descriptor usage in
 mkfs.btrfs
Content-Language: en-US
To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
References: <06b40e351b544a314178909772281994bb9de259.1706714983.git.anand.jain@oracle.com>
 <20240131204800.GB3203388@perftesting> <20240201191811.GX31555@twin.jikos.cz>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240201191811.GX31555@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: b0087e2e-5494-4938-1f9c-08dc2391a6a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uMihchr3gXRL7kXMF80jDwR/4JyQNBWgM+rq4BNrXnB/X6oYotcjju2CMg9g3RoiGBUeSiIhde0G+qw0dF90v2q1PjqULgrctVLqtD8PM8CcKDU/aSYzeOE3EuWSh6Yafq/bhff5EDSs/Ga5vL5ahWJCXiQeuCSC3CPc94Xr4ECoFeNycmzjj8qLxHODffirFE+wFX/fAZI9kChEoSsI4NgwOQMNEXVC5KCCBeotNw7WoGbXKKzKMof3so4bqCeT/Dflu6zfWxWJFnluoduF/bqOxo5xwaLBXoPsES93FVoM0SDhD74dlx68GUUKlkD8jBgjKHOwGoiHmg24clGCmpRopu8i2ktUecOgI5snnm9MeBMHxSRw3ZGCmEXrZ5hZxItLQxowNUtanWUgJaiTRoXUvR2XNpHzi9zNo/PdXDmUpuhOT58W1BFytZiwhTKM7Osx5yKWHIvI5tAb/vW3rrAdIM/fU/tizqhRwC2Vz+Q1u7oztsUpSV7aI3VsUAW6xrtlmS2CgYIxiTQkjnQDqFHa6G4VhftW2vpoF0dAXEXaDnSPoHJLULSIx4C8GsFNKpRKgeWqXHM6YNlD99al+DGqs/c4KGFgaY/56SSelqyRno2VGbgVPP03SYjV/k6IVKPQKK84Tw/ieUICMHAteQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(2616005)(6512007)(26005)(38100700002)(66556008)(8936002)(6916009)(5660300002)(44832011)(8676002)(6666004)(478600001)(6486002)(6506007)(2906002)(53546011)(66476007)(4326008)(66946007)(316002)(36756003)(31696002)(41300700001)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cU94WGpIM3dwZVYvOWlOMzZISCswRGwvTE8vVDgyaWJKN0pYRFErNWdUU0hu?=
 =?utf-8?B?Y05VZ2NaaS92SzZJSGZVVGZZREI2TjFCL0xmQ2REK0dQeEg3UmxTSUtKMXZt?=
 =?utf-8?B?bFhGVTVOYTY0akxrQVJwQWpKZHJWVW1JWFluYjFlUTdPMXdYUXBmZ1VHR2FY?=
 =?utf-8?B?dHpVby95WWU3Q3ZGNGttd1pVdEorOE1CUEltT1pBREQ3VzNwL1lqblJVajN4?=
 =?utf-8?B?V3kwRldZMm1vZHRmR2w5N0NSZTREVTV6VjZSS2hMcngrSDU3UWJaRkVSbkky?=
 =?utf-8?B?ek9qVWRHd0VjLzZLK2xQVGJFRjE1cjZJUSt0djd0TGhVMWlnK3dDSmpwU2Jy?=
 =?utf-8?B?bWM5bHoxQ24vSllsd2ZnWWFHS2JLMGFYR243R2VpeGptZDQvNzlpQjR0VEk4?=
 =?utf-8?B?Q3owRVQ4dk5jVUdXVUhLRTJhVnlIS3hhTiszVjBFcjB2SXF5QnN4aWR1VU9M?=
 =?utf-8?B?bk5Xb3hEZW0vcUgzYmp3WEUxVjZoYVZBSkZ0S0NqaTFCMnFqek5Zekc1endw?=
 =?utf-8?B?Ry9jYXo5UVpYYXpFY1NVR2daZGVTWmtESklJcGJVWGxua2ovYjUrQU5zZFZ1?=
 =?utf-8?B?bEl1SjVrRlJjUW0xSnozdVR1NS9hbExHR2cydnFFOWkxUGl5S3VPSHUrZjVB?=
 =?utf-8?B?R2hsY09EQmo2bXl0d0xReTBZSlVoR05mL0w4aWlhYnZHK21uMlJ6NWk2dy9o?=
 =?utf-8?B?dW1QZ0s4OFJFK2JpeE02K2F4L1lWYjQ2Q00rNTdQbnI4YjR4c2FPc1hBL0R4?=
 =?utf-8?B?WVdVTUNoNjkyNlNQQjhSYjh5eDhYNTlYVGxnbGw5Q1VwVWpyNDI1eE9JUi9K?=
 =?utf-8?B?SnB2TE5rQi9rUXBUVXBVN0RxV3BOckxneVQxN05oc1lVRTlYN2pYRElNOWhU?=
 =?utf-8?B?ckFFaWdrV3RicnE2QmZybk5XMzVrSisra09rR3J5UDB2R05EVy9IWkFVdGE1?=
 =?utf-8?B?Q0pyK3h1SDJrODN4WHZPS2dCUUNXMVRlTGRWNzBmL3VWU2JLNUZlS2VvZGRV?=
 =?utf-8?B?bTVjYVAwV1pEcXdLYWpveXMyaDlEQ1NSbGptOWxRWDBCMjBITWt1eGxKaTE3?=
 =?utf-8?B?VGNCajhSSk1mVGtSTTFIdStTSmpJVW9rL1Rmd2hEMTFaellhcU9OY0Zzamd6?=
 =?utf-8?B?U3B1TmRhL1NWaVN3dTJZdXZCTGN3VEpuYmFKWXpjSFBLUVFtMjdrVHRhWGFG?=
 =?utf-8?B?VEdpU1A1TmVuT1NvZm11V2s3S28xbG03OHJFdlhmeHlFWkx1NFVKKy9CcUh1?=
 =?utf-8?B?d1BqZ05wMEZtbjdWcWNHMy90MGllZ0xvTnZ4QWpsRjdxUGYyMlZTWEh6S2dm?=
 =?utf-8?B?M0l4U0Q1WWVvc3RIUUU3VnlneVhpb2ttamloZXVkbHpJWW9oaVZaNXdKZWw5?=
 =?utf-8?B?dnovNFVCcWxwdGJZMHZxK20xV2tLL3pYKzJGd1hnZHlFY0szOU9RQ2FhdXRx?=
 =?utf-8?B?WmZWQnIxNlQwVDBTODV4NGJuQXRFQkFrNVowbkdSVGRpemJLQ29sNzBDR1RF?=
 =?utf-8?B?Qm1PU3lJYWtQckQzK3FmSXc0cUR2M3lrdDMzZ1JmczBKM1ZpN2NRY2dvcnRZ?=
 =?utf-8?B?TklwcUNBTnpUNGZoalZ4dlRuTDhWdVpoMTEzV2JRMlRYWjU2STlOdlM1Wnk5?=
 =?utf-8?B?MGtrRTdkMUsvOStZdkM2Y3VqRjZ5eUhUd0J2SmpjS1BnODNqWmk1UHRrNCs2?=
 =?utf-8?B?bmU2bVNyb0o1akM1WTlCd2xLTVl0SmN4OXFCckt4SVpJV25Ta1o5di9jTndp?=
 =?utf-8?B?YXErUVY0bVNiK3VuVDdWTWtwZDBZU1VEd1AweFBoWTZmRkZCV2FDSWdpVFVm?=
 =?utf-8?B?Q1FRTkxFWVJyRjl0eTZTUkwzaXNGYy9iejFhOENsS2FtbmpXSDRFeHhrL2RM?=
 =?utf-8?B?eFBlZWRtODZ0RE5rNDRWeWJsZjhJZ0tyU0toOEx5K2VFTWI5ZE5zOFVRNUls?=
 =?utf-8?B?cXp1UXJKUU5XVXVIcjl3UmVoS1ZtV2ViVFdJN2M1UzNPMG5IK3FkbkVhajhY?=
 =?utf-8?B?S2lrbmlLeXN6L2JVeFBjeTl4ZVpLUm4wUXQwWWtKNE8xVFVkc1NiYkh5aEdK?=
 =?utf-8?B?aWxTSkl0WW8vSU1ZeWY0WTBIRXNRRGdpVHJTVEczRXpMVHVNSmsvai9KdG1P?=
 =?utf-8?Q?RJS8rct3H/kn7MGOHN1yTjIPn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tcR7K4W5yi9QnOvbofEOqUqp4QaDI4uxfyOgfcVoR6FbR7QQ1sPqsxygkTqN77dtKme5/wYA6gEeXay+kQAMnNu9P/UU6Ue8SJm0prSLyGwgeMXxDrNc3Ew7ERlOyJgrlj8Kr0qGOuKk4Phomtj91mqSXXJWWhFT0D0iBaGuuKZsqww2rNgm2Ak38GabQykAqCJaNJEIz/neopHZ/qtmadi6v31VfxugHZoN3b6ZdwGMf83DpvNAOtSJgzWcfWQmupxY6polyKpGc2fxAs1ZYafxMmOXiH3gxilEhX3f8VL2a2Dg3rsbZBMZCNNQXQ1B+zDIsX+YoxE/YEEeN2s++ImJJutGS4wNDyZKs+GVa2h2bskZl0W9ZXWLQOyXVDF2bsQhl5V84xOkGY63xpWnQNmCFFOkpyyuq74WSPXyJEj99WZht4xTx9lT83WMhrv4rFG+MFXOIqc+AbhAdRpll+/3210zLZqtUYjCUkaqO46uXCOMn3NbE8jkjVSZn5hXDfHkycOeaT0c5aIvdUd7oHwZksP9HriA6p84+TM9yJMJONsIR4uxlFL6Udtgkv8aovcawJdms4EySIdjuMiGZ+8xXQuLJHOhvBZEUoKWGLk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0087e2e-5494-4938-1f9c-08dc2391a6a2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 01:52:45.5935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /uiPfhFCM3Y9eljRqbg384UGrQaWZcwzz9/KpoYkMUYGWM3cPdI9zpIBrokZChh1PHC+3Gt0P28ardipeGvbmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7359
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402020010
X-Proofpoint-ORIG-GUID: l12KCsZZ1q_G0YJVM84LTv4YZ8FenzMC
X-Proofpoint-GUID: l12KCsZZ1q_G0YJVM84LTv4YZ8FenzMC



On 2/2/24 00:48, David Sterba wrote:
> On Wed, Jan 31, 2024 at 03:48:00PM -0500, Josef Bacik wrote:
>> On Wed, Jan 31, 2024 at 11:49:28PM +0800, Anand Jain wrote:
>>> This cleanup patch reuses the main file descriptor (fd1) in open_ctree(),
>>> and with this change both the test cases (with partition and without
>>> partition) now runs fine.
>>>
>>> I've done an initial tests only, not validated with the multi-device mkfs.
>>> More cleanup is possible but pending feedback;  marking this patch as an RFC.
>>
>> I'd like to see the cleaned up version of this patch, but I have a few comments.
>>
>> 1) I think re-using the fd is reasonable, tho could this just be reworked to
>>     create the temp-sb and write this to all the devs, close the file
>>     descriptors, and then call open_ctree?


Multiple sequential open-close maybe fine.

> This would trigger the udev unnecessarily and could let other processes
> to eg. try to mount the device (like systemd did or maybe still does).

> This could fail the second open_ctree.

I think you are missing the point that when we write the temp-sb, there 
is no valid BTRFS magic. As a result, the kernel won't get the scan, and 
systemd won't attempt to mount.

However, there will be a udev event (due to the write-close), and in 
this udev event, we shall have:

ID_FS_UUID=<blank>

This action cleans the /dev/disk/by-uuid directory, which is fine.

> That it's all done with one fd
> open reduces possible interactions that could be problematic.

Hmm reduced possible interactions is problematic? I didn't get this.

Here is the sequence of events to help discuss:

Consider a single device, for now:

  fd1 writes zero and temp-sb.
  fd2 writes good-sb.
  fd2 closes.
  fd1 closes.

Please note that the fd which wrote zero/temp-sb (fd1) closes last.

Per udevadm monitor the change event OR the UUID is missing (depending 
on the systemd version).

ID_FS_UUID=<blank> instead of ID_FS_UUID=<UUID>

>> 2) I hate adding another thing into a core file that we'll have to figure out
>>     how to undo later as we sync more code from the kernel into btrfs-progs, I'm
>>     not sure if there's a way around this, but thinking harder about adding
>>     something to disk-io.c that is for userspace only would be good.
> 
> Yeah the open_ctree functions in progs are misplaced in disk-io.c and
> are there for historical reasons. We'd need separate file (or maybe
> whole compat directory) but for now let it be there, the cleanup is
> going to be big.


Thanks, Anand

