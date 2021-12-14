Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02719474590
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 15:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhLNOt4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 09:49:56 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37746 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230403AbhLNOty (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 09:49:54 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BEED1uH004564;
        Tue, 14 Dec 2021 14:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=CtX6FuzZwFZo6bmdyqZoZI7YC4jKW3o9FbGDSTjAzd4=;
 b=O9+R35NUmw+XzWskLOUEDuzWB0AnENXvYJ3sY+4bLJjYpTCA0S22Sm0Kp2hnjGeuMuM8
 vj6MBzFxvhxl7Izxo6IuMttlJoUxS2Z1wzAI/WccmKRPCkcwEzjB4kD4X3qBO3N+Opeg
 QnA4ZZLLZ/bGi/+xRlv2cj93fdzOYc46oY32ppzrhwlr53oVQYnli3diPnTyGmNRlE3B
 dVeqcSaV2kq+8qEC5FyVye+oPyUTT/HqjzpR+aGidRcWwWS9e20UrfHs3B3n5hXIcEZ5
 sz38xfyQTJarH85aNmDcHZMfY23O2eFrmI9mccvg8eZcqk3oUA8ORj8IkK5T6tEyxe5Q 7Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx3mrv1sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 14:49:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BEEkSaC102990;
        Tue, 14 Dec 2021 14:49:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by aserp3020.oracle.com with ESMTP id 3cxmraccaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 14:49:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8VbuNstQIUny4xKk/TEEDzzsx/+B19kkd1bLxE08/8PqCfmFp8IGyqHYCuvy3vkONXKVQu++o2CWw+g7LNbmcKFB+gHExaYJ9hjOGB+a29w63V0c8ceKaCqXJCXE3n3CSYMsmBv9tBHXncAXtWEw9EFBURbsEkNtDFOi1gkK9FBPqayTSP1hWsXbKK7xDreHpt9cwwlplRk4tB6dTFzbs+Ip87/GpS4NaRHjLjBEGugqRyl/rs2idzQ27AS+181S6yeFxoEOUP9PiWOcuGP5c/GS4ggErTinjP7PeCXqer72EloqkZ28uyQbGaBUwDMALbtJf9pBNGwM9TEGhygpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtX6FuzZwFZo6bmdyqZoZI7YC4jKW3o9FbGDSTjAzd4=;
 b=Z9WzFQWwCI2vETDydJr2TenK2pHS68Ck4e4WhxUlfik34PG4qM1IK+7FP4R2gifKwc5G3oCOBLvWjPczQqPy/vt4f4HQqpGX8UsPTlrvOvazZSf9LEAaHx3ipyTpNlBlUmGnBDqyWNmG3xh+JWEihfF2/XYCwAnv5d10VlGMSVV6BLA+jgsmNA2NX+Qzn0OjFz41LHx1LDwTk6+IbpX7HE1HR17jVal+yg8ZyBsLEJ3eKhphnej0LcZyd6aBH4ohyCX8AgMat7BUHJCuuSz0aKKKODMh5LWkZVLYUXArzX6v6yoL6c1wQoNmXpgAn46TnBJY69OQW4+M6jZjB9Qpsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtX6FuzZwFZo6bmdyqZoZI7YC4jKW3o9FbGDSTjAzd4=;
 b=ACSRhCTYXl49ECh151Px62gOMuO9ACav9WC4HW69VdU5HmHcDfMqYf1WTSMea8E7TxJjf5My/Vi9rD000eQj7Csb/xG5iHJw28PuTM8iGONWQQt5UDWU5qFN/UVFsAqPdHnHhewz7iQI1/Id2oI9jRE6NBYsaGE6zLgbIPqvbl0=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3027.namprd10.prod.outlook.com (2603:10b6:208:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Tue, 14 Dec
 2021 14:49:48 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 14:49:48 +0000
Message-ID: <8af5cc22-bc1f-907b-2447-d60f9587c887@oracle.com>
Date:   Tue, 14 Dec 2021 22:49:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 0/6] Support resize and device delete cancel ops
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1621526221.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cover.1621526221.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::21)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fd5e32b-1e50-4271-7d62-08d9bf10f9eb
X-MS-TrafficTypeDiagnostic: BL0PR10MB3027:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB3027AE03F5F37D0F939AF44EE5759@BL0PR10MB3027.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VFzdJwTGXHleAsChBr7fXT5VlDFqb6765f2GxNHoY/MZe9rWE2YnTpcASntX8VJRURQFPf8ch+f5IRPP7MVrhc/q4uHkmerk3Y3N9Pv6NpNNmvjDPeX8Kk8oLow/O5cLy98iNvlnrZWWVL+B8bjezJ4ZUsIOchkVR2X/UaY0+Rh82pHO1GQrE70u93aOT9X6x6r4VkJ4t01rDZWbZSW26vqBPsUTfpIpMm4GSfDPOWDdmVJqtuJD99XL8JOF37qywpW2zAkJslx1jjtFtKPvmErK3e8ssnkR7qJ59/ncAZVpiXn6bpFV7YcghQ0HwfmKgLiZjXYdfES8Y1fme61Z3Fk+kVZTaImWRNYTYdrvVBrxaOuwzSY/ZJ8sZ2OJ5cxBU7UpXVLPFAqwm/OwxXQ7Ddev+N5fnQ8Vx2bDh9idm5WVyo4xCNNJWfS75xWBYa86ntn6ozSSMVyB2zLhG9WF6Xjwbv3wo8bYTGLuy7dvEj0Qty4EbyKpKRhfrT/pY2CIV/lYhEmLII7xJrUTS+5Tn9OmAUwMx9m4ll/9yefegbaIDaYtjmr9qceze8MpyChv8CkNQAHX7Gs8pMh18M2TcvUoiLk6f73siWWJmM3rdF/9wnb5SYklPSy0oAwKc17Vqij2278XynBeWNEfvccoGS56hd8b2dHzjvGYg/EkQ2oSkkG2gbgDyEfF3TwsoRyOh4ez0RkEeVAQZPx/M/Q6mosUz9TNXvUBmyvMRNxW6rPI+aChwB+9QLgIOdVAlOpJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(6506007)(66946007)(6486002)(508600001)(36756003)(5660300002)(44832011)(66476007)(8936002)(31686004)(31696002)(2616005)(2906002)(83380400001)(8676002)(26005)(6512007)(66556008)(6666004)(38100700002)(186003)(316002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RndJU3hmSHBsRVFmbzN3ejRZSTNKM010TXI1d1VJMXVFdFd3WE9Rb29yRmtz?=
 =?utf-8?B?czdnSTJsZjVpU0NrMUNhaDZhcW53UkZXZVR6a3VHbDNVM1ExTmd4WlNxL3Iw?=
 =?utf-8?B?WEQ0aUkzb3dCeXltaDVwYitJTS9DZk1FZWVIOUxjNTAzUHhCd2prMnZCdlhT?=
 =?utf-8?B?Wmx3enNDeXJldlpiR2pTeXRmcU1EMUNESksrem9McHVYc3hEb3QxcmZiUUE5?=
 =?utf-8?B?U3JuN2dpNjFlUHhoVVYyZXVOTmhDSHU3cVNhc1YzWE9mZ1MrZ3VtRWRoUW81?=
 =?utf-8?B?aFFtWnhkMHFWdGFkak1RU2Evbm1JYXJ6ZUNTOTArcUNXZFpjS2tsMVZ3TFQ0?=
 =?utf-8?B?SGxTdmZDSUJuZHdhWXZwcnl0VXZ0WmQzWUZFc2dkWjV3bEZVTFVYckZCbzdO?=
 =?utf-8?B?RmlOblFxc096STRsLy9VVTc1eWxCb3BacDE4WjdTUW4yUzVLMld5NCtDc3Bm?=
 =?utf-8?B?dGg5QVpzZEVVNUVZOFhTMnBIOUhDNmEwMWs3aGdLcjg5SlNPR1c3Uk5OVDdi?=
 =?utf-8?B?VllOV1FYU3lZbHo4L1l3SGozYW5pN3VoUVM2TE1ZNDZKRlNaU0JrVTNUbWJV?=
 =?utf-8?B?VzJKL3dPQkRIMGw3Q3IwbEtTSFdwUzR3OElZNUJZTTNLT09xbnR1cGlFdy81?=
 =?utf-8?B?SkR4NGwxb2hnRDZiSW1CT3N6NEE3V2RwU0N2RUpsWXlXNGFJaEVTUWVGYkhS?=
 =?utf-8?B?eXJHT0YvdnkzMXNqenUyc2NKeUw2Zk5scDZuMXhEWWhlK2dzK3ZuRllTbU9H?=
 =?utf-8?B?ZmlITVdaNXVjejY0RUdJTnpsWFpzZXFKaSsxcndyY09SNDZwM1BHZUluUmty?=
 =?utf-8?B?cm05VzMyWTVwQ3R0VlltNUN1ZXU4YzhXRmZNQzI3T3hDemZaV3JnZDlRZ2R3?=
 =?utf-8?B?LzJVa0xMMVhsMFpYd29Xc3NPc1RRZ083bWtTUG9FY21meVZDRmZncHZwbktE?=
 =?utf-8?B?WHk4bUNYd1BGQUlyaHFRSHliSDdMMzlTWVFVZG5yVlQ4OEcrRnErZE40SDZN?=
 =?utf-8?B?WFltL2ExbDBvc3BlN2NFdWg4SlhZNERUN2IvUysrUnpHVnZIY2NuSVc4TlNL?=
 =?utf-8?B?c3ozNkJTS1ZDOThTNS9rSW1uK1V5SzNsU0tjc2xMU3M4TStGampYMytSREsz?=
 =?utf-8?B?dmpMSVFBUERnNWVtVzNFWnc1TFRjRXAzM1lENmZIeXJjTTRFY3laY2Rzb21X?=
 =?utf-8?B?aEVKUWNHY0NRUXhTNmUxdFRncE1YWnBGa2l4V3FuM2R6SUI2N0lGVnA2dXJi?=
 =?utf-8?B?MFpFUGRQUjMxVkxDbExlVHFScFYzb0ExaVdKWGJGZWFZaDJLWFcvdFZMTWh1?=
 =?utf-8?B?UW94OGtreUdzVzhEcFBWQmxGZTkzd1JPcmlFc0s3YnJsQ1N2SzdFUWtHQnlh?=
 =?utf-8?B?cGFtU0dPU0FQL2F3ZSt4VnBXcUkyc3NvTWFyTUpXWG55ZGxNOS83Qi9RRHJJ?=
 =?utf-8?B?NUZyQWczeTJqdmxYbFAwR2JXWWVhMUhUcXRmbk1VU1ByNzFEV081NXEzcXlP?=
 =?utf-8?B?em10SE1VVC9JdXRqRDdFNjFQK2RFT3Vjb0dtSVZoVUY0bmtzd1o5VUNZaHVh?=
 =?utf-8?B?b2k0bWt5MTBWakJzaSs3amZiM2NVMWlMelVwSjhUeDJGY2RUaCswaitweXNH?=
 =?utf-8?B?L1EvaVZSVTJXQ0p3K3B0S3BaMzVrYzVMZDl6MkkvdzM0WUlTQVJUVWE3aGx2?=
 =?utf-8?B?YTRZSXRkR2haeWp5SFVQalFUNUQySmlpUCtVRU1jWVdRWlE5VVpkN2dDdkVq?=
 =?utf-8?B?dzkvYzFqaCs4NlBmTkhyem9oamtBdE1SUlZrY3RZOEVTVEwxdHFOZllnVkFt?=
 =?utf-8?B?dXd3TC82NDBGMzJDWHJJdnMvNDBVZkgrV3JlekFUbnQ0Z0pZUWMrTUxQcSt3?=
 =?utf-8?B?UGsyc0wzQjlGSFNHWnM5M1dGRWtrWXBzZ3BHbTlGaXVPL1A0ZWhoYUlMUDVU?=
 =?utf-8?B?NDhlT1NMdGk0ZE1oSVV5M3gyZWpNYWlBSE1LbWh0V2k0Sk4xNzNVN0R0OW9G?=
 =?utf-8?B?SDU1ZDBtN0YrYTc3MHNCQU1xYVE0L2lBRGhUd0ljMi9UbndRLytzcGdCQ3pm?=
 =?utf-8?B?WW5tREdKUmRPTnlINjE4bzU3RDBxN2hBQXYwM2ZUZ0hmbTR5QkF4cUZIYW1a?=
 =?utf-8?B?VHAybFE5Mk5YTS9VYkMxVGpuODZDL2l6RDROaCtESzhBTHlURld3WnlpYSth?=
 =?utf-8?Q?Ds87snFCca9sfwE/RubsZcI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd5e32b-1e50-4271-7d62-08d9bf10f9eb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 14:49:48.6570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGhIz7a3EsFeprsLlxMkSMVVIeh7c04QGJY+rOId1riwRTfk87sTX9d68KjkAOct3GrMjp52KNMO8rs7DhfaLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3027
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112140085
X-Proofpoint-ORIG-GUID: ki-Bf0jpNWgrxpxheZeY1rqUyaMKzfj_
X-Proofpoint-GUID: ki-Bf0jpNWgrxpxheZeY1rqUyaMKzfj_
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 21/05/2021 20:06, David Sterba wrote:
> We don't have a nice interface to cancel the resize or device deletion
> from a command. Since recently, both commands can be interrupted by a
> signal, which also means Ctrl-C from terminal, but given the long
> history of absence of the commands I think this is not yet well known.
> 
> Examples:
> 
>    $ btrfs fi resize -10G /mnt
>    ...
>    $ btrfs fi resize cancel /mnt
> 
>    $ btrfs device delete /dev/sdx /mnt
>    ...
>    $ btrfs device delete cancel /mnt


David,

These cancel commands don't fail with un-supported ioctl error codes on 
the older kernels as we didn't define a new ioctl for this purpose.

Generally, the latest btrfs-progs are compatible with the older kernels, 
especially useful for the fsck fixes.

Moving forward does the newer btrfs-progs version will continue to be 
compatible with the older kernels?

Thanks Anand

> 
> The cancel request returns once the resize/delete command finishes
> processing of the currently relocated chunk. The btrfs-progs needs to be
> updated as well to skip checks of the sysfs exclusive_operation file
> added in 5.10 (raw ioctl would work).
> 
> David Sterba (6):
>    btrfs: protect exclusive_operation by super_lock
>    btrfs: add cancelable chunk relocation support
>    btrfs: introduce try-lock semantics for exclusive op start
>    btrfs: add wrapper for conditional start of exclusive operation
>    btrfs: add cancelation to resize
>    btrfs: add device delete cancel
> 
>   fs/btrfs/ctree.h      |  16 +++-
>   fs/btrfs/disk-io.c    |   1 +
>   fs/btrfs/ioctl.c      | 174 ++++++++++++++++++++++++++++++++----------
>   fs/btrfs/relocation.c |  60 ++++++++++++++-
>   4 files changed, 207 insertions(+), 44 deletions(-)
> 

