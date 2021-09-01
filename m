Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4D03FD923
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 14:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243959AbhIAMCj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 08:02:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33700 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243901AbhIAMCi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Sep 2021 08:02:38 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1819j8Qf011420;
        Wed, 1 Sep 2021 12:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FYKV5sbQwMA7UkupYQsy2gkbYuxIq2lrH8YitIoI5EY=;
 b=dO2yq/wbVKpEYswCZp9pwibE6gY38AID/IeektuSNrSkn6L59AVfCwcN+EncQZ4PPQlo
 hHLRmCoLvdh3q9YgSwC8cgdDVt073VsGltYILkSU2G7UMEz45OC9/ImOgJyOxCe8KOsI
 JEfepDCDKEcfYm58+KcnNX7xL6OWVYBbHDKg1M7QI/xsLeskkYocBztTNIA4VDVdP2mF
 xBWUuW6KzmBVzi14mCL/3UggbwRFytR86TXcwWzPSyk8V5PvdXMsWSeid5F1fb5qQpCO
 QhzzUWoRbqVgyIQUT9WS67ZxX95YvGcOcdsQvfHxxHwpjmsFo8B0Jv4Fg3k5nHTiNrSc vQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=FYKV5sbQwMA7UkupYQsy2gkbYuxIq2lrH8YitIoI5EY=;
 b=p09KqWRZAv+B0Yd+jQeWlWSMWyKAq+9CTBqB+4ByNOGypVktfadHvMuRaWSN2SC13QvE
 jEcohGJ981yBFsfTlzraVvaoBupXEl8Ie1z1Uxqt9oXIalj4bB3ywYOju3YCqnnlm9hR
 l7wr74uNH5c/ScT9pDl6JrpB0nMF3Gd7xyBoTirK403DSVsLixdqs7lKZTLgQTq4GW+r
 zkdbLj/z3olzckqTCHmBs0mpu5xTTseCDdsHFAUOIUnPAHt50LiEIX801fgDdS1thM81
 uFTYMLUMFHrQWnnlOjrBKjVEbwXYhDB5851yDrO349KPWMNgI3zy1EUv6w4GFN+xle6l NQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3asf2mm9wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 12:01:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 181BtrTw006966;
        Wed, 1 Sep 2021 12:01:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by userp3020.oracle.com with ESMTP id 3aqxwvf981-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 12:01:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjAePO0Mxr9VnYXqI2l4mXUXyRYL6uLErLzTNb53gmLmFGS4HeUq2FpNimfmE3UhKVaXSnrkvMZKULJMDfSSe6ddO5Fc0jiSrOGnHd33uCMYpCTH0Yxd8A0xWIZMj7x2UWDHDvppTdn0umKdtpspjoyQ4Dy7AmTxfnfr4y4wrWMoJRswqvmKlbSqsZRbX94Y43IwenTuFtGDp6rqVgLZsKGfOmLl67E7WWUv8Q4T01fEd6++1rJxrShuKzd5PPCaTU6tLMoO0fyJjwJgL0QH5CU16nJO592AdOS5FtZtPd0wl9bRuG2po6AwBPQCeZrYYZAdotcaQwhiA6ZjY/nDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYKV5sbQwMA7UkupYQsy2gkbYuxIq2lrH8YitIoI5EY=;
 b=mpFuS+X9AuNanaw+vPxnTfkMhURmv0gTfBpTCjBah+VxP3LLDmm5S7t5K3d6v0TWTsAAJbvCgegerGikLdOLfVouBum+otDXbpvw9awAwBjGQkR+zMG33xnETQeUnGC9AA8dl/3eFJ9s+igR1isz43ImPgR5cP596ykxNnsbY1aMC7urxeizMJVuvrApnO/zdqYa0DVaA5Dhv95lOGjMjU/EwleDIYt4QpBMd9fTQfpPaG/UKm9HbYHNKIosqC8z3gWa5TM34B6dTQpt19sI3li8u3XS07bbuxQq5pJj2rOFGq3z4u05Nw1Kkz2mKBoK6qMQ6XXcfALLCVX09v3MCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYKV5sbQwMA7UkupYQsy2gkbYuxIq2lrH8YitIoI5EY=;
 b=aFCJVfzh35muMJc+MK4GzQncYtSs9nBuTJOWplm5lHyx6s/YaaBSN/IsUdiusnqA6HMUnpevzl8GtajFKDcjuLm6BS3LCxNo3vTAjrwd6jyb0KD3yNXEN9w25UFWQW4cVKjnsu0zILrktiM8qxxsg4cBus7ZX3DlymnmwLbpVEI=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5025.namprd10.prod.outlook.com (2603:10b6:208:30d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Wed, 1 Sep
 2021 12:01:34 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%6]) with mapi id 15.20.4478.020; Wed, 1 Sep 2021
 12:01:34 +0000
Subject: Re: [PATCH v2 2/7] btrfs: do not take the uuid_mutex in
 btrfs_rm_device
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1627419595.git.josef@toxicpanda.com>
 <4f7529acd33594df9b0b06f7011d8cd4d195fc29.1627419595.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <495dbc7e-dd93-e43a-3af1-6597f35d38e8@oracle.com>
Date:   Wed, 1 Sep 2021 20:01:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <4f7529acd33594df9b0b06f7011d8cd4d195fc29.1627419595.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR0302CA0006.apcprd03.prod.outlook.com
 (2603:1096:3:2::16) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.109] (39.109.186.25) by SG2PR0302CA0006.apcprd03.prod.outlook.com (2603:1096:3:2::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.8 via Frontend Transport; Wed, 1 Sep 2021 12:01:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe44dc07-fc19-4733-4846-08d96d403e30
X-MS-TrafficTypeDiagnostic: BLAPR10MB5025:
X-Microsoft-Antispam-PRVS: <BLAPR10MB50255BE480D316BAD2108E73E5CD9@BLAPR10MB5025.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J7lfJILuOdY//i/eYI5dKWJCB3gbzUSWKflmDvSmL+j2/F80X4lGTTNB9pXcnK+FeL/SJYU3b1lP1AEyJ4l7rmiKB1n6eqkI/a5SDb+DdxHRozjhAilBLZu8m0nLGB04CWn2ZGNhmxKROFcEX/sM6klQDglZsnrfpaxYZiOhowf8jJ1cfUfJ+h1M0kmgr6bHIgdNXqd3s91W8VStdbtBH52MHuGyhaAHPld9BCJQQMKLDK4ZaAS00OW9h5RW6Ouy9k8QrWxtMtMT3vfED4UT/vV1MdrK9KHjsh47qQA4Q5VAPQSHvh5/al6B5uxhJmkADzTV5ul8kHniS0tgIoBV8wBgeTPP/thw5kWXBdVZArTwI7eoZ8pm3hECvVJoHVJSFcES2apl4ZwAXyCvwYdp16i8ACLZJs3EQSgmhWn43+zclCm+IaIidmd/xqoTXwbJ4Q4zj2y8Sl9WKcDOxqEYPzn0jQ3vUc38+iLCUZxNGGrHsR3TF4Lx+21W0hm2Md08rVEI0ynCy3ckxDeCjHUHDLCVwjKoFCqTQqxYW/sZEhveqrUUe2d51VSP9HNcFB1ObNjEfsH6AYQN0Ug0H4oeb5b2mHyXR8lzJN7dxrYdWFwjOxYrOPZh8/IHuZ1I3KbrvUjMiT2oLF8hHaoLSAyiMBt91xQeW6lwTyut55q2jDe0cUubUlTMaND11Mj5JwedxGokmCal1ps0G8fIpvOWVhXDf7wqrpUj0qTCT+456J8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(36756003)(2906002)(86362001)(6666004)(508600001)(53546011)(44832011)(38100700002)(66476007)(5660300002)(31686004)(83380400001)(186003)(26005)(6486002)(2616005)(316002)(8936002)(66946007)(8676002)(66556008)(16576012)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajlrZWQrSnJudlZnRERyOXdrSW9UN1hYYnpKU3E0UjdxbU5COFhRTmt3YjNz?=
 =?utf-8?B?TzBSYXZIR0hMVEp4TUZ4aWk5WHBMSHJONEl4RkY1RUdpSTRCdG5IcDZ6UTI3?=
 =?utf-8?B?OFBBeFQzVEJQd0lZY1Rra2FpYzhXZmJlOHMxR1ltc2t5c01ZblgwN25XQkIv?=
 =?utf-8?B?Q1ZZVEhiTnlUbDJIYndtWmgwbnN6VTZTN0FaOVRWeTdJRHozdXVQNjA2MDBz?=
 =?utf-8?B?ZUp0T05CbXBVNkhSMEJmMGl5UHFacXN1TnNaSndXMnYxZjRPaU9reVJKaE9M?=
 =?utf-8?B?WnpuQ2h1Si9XSTdlOHpwWW9xZ0ZVTkk4WGRYdXFYdzB5TkxZSTc3UDc2ZmU2?=
 =?utf-8?B?MmFCdlFxV2VzWXdnV3J6cHNqdkNVUEFTZmY1WmlEYnhUVmZMOWxNTEx0emUx?=
 =?utf-8?B?MGQ3TWtLbWRIb3d4dXJJY0o4K1ZEMlEyeEIwaDkwU3k2TnJ1aCtHQ2JXY29U?=
 =?utf-8?B?U1p2aDRTdXBqUklUUXEvd2J1bkZNZWlSVTFWQ3pTaGpGZVVtTzVSbGNjRkRu?=
 =?utf-8?B?bklXSDB2R0FZOEMrUTVNdzdKcTRpak1sbHRFaFRrR1lBQWdnZ3puUlJEWXB4?=
 =?utf-8?B?SDV3S2xhSUoreFhCaDk3b0lUNEt4U1hyN3dRVWE1OVdzaThYeHkySnk2V1Bq?=
 =?utf-8?B?bm1iZzBsWWF6NHhrRXcwbndNZ1VoV1Fub1VxYjloQUVTdklTNzl6QWdwTUxa?=
 =?utf-8?B?MWFsM3lJcFVmMHQ0a1dnRjZXU2ZFQXRWYWZLZlM4MXVlb21QbitrZDNvRjZa?=
 =?utf-8?B?TUlDb1pQSUthMWJUOHRWVTFGb3hFK2JyTCtBQ0VRN2QvNk1RY2doN1o1TUgw?=
 =?utf-8?B?TndIeHJhbjZSZWt0R0RjR250ZVVKai81TEpNS053anI2SnpXekllWVQyTFg4?=
 =?utf-8?B?YjdEblk0NmZLN1FaNWtIek9PbmJRaXRYbUp5cXJMcW0ySjIvMU13WmFoNURL?=
 =?utf-8?B?elZtR2xQUXNoTmlLZmdJeUQ2NGxSSW1rNVJ4dndEaHUvQ0tuckd1QmhEcXd3?=
 =?utf-8?B?MXgydCttUW9KWDMxS0Z6TTBNaWFiUWRFN3N2NnRhQzZmVlJKS1R4MXo3R2ls?=
 =?utf-8?B?aTZldjBxTldtSnpuc2k0NHdubzZZaGc5RFpVSmtGNzdWd2ROMCtvRUt6UitL?=
 =?utf-8?B?c05GS052aFNaa2VRbmRZcDA3Syt2dVFBNDNwREdlMWk2UkRFWjBsTFlxblNo?=
 =?utf-8?B?dFptR202ekN1aldQTEF6bEtGd1RsZWlWMGJLTHZKR0Q5bEY1c1k4WlBZR2Rw?=
 =?utf-8?B?TVgzcER6UGdZTFdwbnJsdDJFTmR3aVF3QTBVT1A2SUtCc1RoekI1MW0wZkp6?=
 =?utf-8?B?c2dhM2R6TzM3WTRsdG5FYnRGT0pzZFcvKzRyMHZ0MTRCUWVuQWpqOXljeWQ4?=
 =?utf-8?B?UGExSkEwb0M2a0pSZnlkYnZidWRXcTJjdVorYjFhOUszNzRYTG9VZjhjamdM?=
 =?utf-8?B?emFEODQvU2VRNTNHV2pDQXRPVDliSWx1c3crMzlHVllRV0lzcy9leXNpUDBx?=
 =?utf-8?B?eUdsMitZOWl6WU9LdzBRUUFUTGJ3aUVoUS9UNFE1elVIS3NsTVBydFF3Zisx?=
 =?utf-8?B?SG8yQ1UxZXZwWXZDREdqcmhla2xDQ2Y0bHgzUFVReVVvanVnbHJvYWxOOVY2?=
 =?utf-8?B?bUt1b3hPNFhNdEF3cHhBZm1tVzRpdFh0TEdZOEkzdkxXRG9tRGdBYWxZRzF1?=
 =?utf-8?B?emN4NFV1cXBQUnAvRnFHZzRKd2JndUJua3N5aENjYUVjYXVmeER6RkVreFB3?=
 =?utf-8?Q?c+zFQ2oE9G/v5wJVu/XneE0h6EgS1t+PESOxwSk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe44dc07-fc19-4733-4846-08d96d403e30
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 12:01:34.6406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABEMj2dSzjtIFNATmPUbicHMfsv3mEbQS8y7L8fTIC9hqbb3896ux1xRyLiNgVKFL9/MGfsvJiEg/+KX8s79Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5025
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10093 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2109010071
X-Proofpoint-GUID: f-nrt2hdHqE7_uydpBc39Kipzzxr7EsX
X-Proofpoint-ORIG-GUID: f-nrt2hdHqE7_uydpBc39Kipzzxr7EsX
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/07/2021 05:01, Josef Bacik wrote:
> We got the following lockdep splat while running xfstests (specifically
> btrfs/003 and btrfs/020 in a row) with the new rc.  This was uncovered
> by 87579e9b7d8d ("loop: use worker per cgroup instead of kworker") which
> converted loop to using workqueues, which comes with lockdep
> annotations that don't exist with kworkers.  The lockdep splat is as
> follows
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.14.0-rc2-custom+ #34 Not tainted
> ------------------------------------------------------
> losetup/156417 is trying to acquire lock:
> ffff9c7645b02d38 ((wq_completion)loop0){+.+.}-{0:0}, at: flush_workqueue+0x84/0x600
> 
> but task is already holding lock:
> ffff9c7647395468 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x650 [loop]
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #5 (&lo->lo_mutex){+.+.}-{3:3}:
>         __mutex_lock+0xba/0x7c0
>         lo_open+0x28/0x60 [loop]
>         blkdev_get_whole+0x28/0xf0
>         blkdev_get_by_dev.part.0+0x168/0x3c0
>         blkdev_open+0xd2/0xe0
>         do_dentry_open+0x163/0x3a0
>         path_openat+0x74d/0xa40
>         do_filp_open+0x9c/0x140
>         do_sys_openat2+0xb1/0x170
>         __x64_sys_openat+0x54/0x90
>         do_syscall_64+0x3b/0x90
>         entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #4 (&disk->open_mutex){+.+.}-{3:3}:
>         __mutex_lock+0xba/0x7c0
>         blkdev_get_by_dev.part.0+0xd1/0x3c0
>         blkdev_get_by_path+0xc0/0xd0
>         btrfs_scan_one_device+0x52/0x1f0 [btrfs]
>         btrfs_control_ioctl+0xac/0x170 [btrfs]
>         __x64_sys_ioctl+0x83/0xb0
>         do_syscall_64+0x3b/0x90
>         entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #3 (uuid_mutex){+.+.}-{3:3}:
>         __mutex_lock+0xba/0x7c0
>         btrfs_rm_device+0x48/0x6a0 [btrfs]
>         btrfs_ioctl+0x2d1c/0x3110 [btrfs]
>         __x64_sys_ioctl+0x83/0xb0
>         do_syscall_64+0x3b/0x90
>         entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #2 (sb_writers#11){.+.+}-{0:0}:
>         lo_write_bvec+0x112/0x290 [loop]
>         loop_process_work+0x25f/0xcb0 [loop]
>         process_one_work+0x28f/0x5d0
>         worker_thread+0x55/0x3c0
>         kthread+0x140/0x170
>         ret_from_fork+0x22/0x30
> 
> -> #1 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
>         process_one_work+0x266/0x5d0
>         worker_thread+0x55/0x3c0
>         kthread+0x140/0x170
>         ret_from_fork+0x22/0x30
> 
> -> #0 ((wq_completion)loop0){+.+.}-{0:0}:
>         __lock_acquire+0x1130/0x1dc0
>         lock_acquire+0xf5/0x320
>         flush_workqueue+0xae/0x600
>         drain_workqueue+0xa0/0x110
>         destroy_workqueue+0x36/0x250
>         __loop_clr_fd+0x9a/0x650 [loop]
>         lo_ioctl+0x29d/0x780 [loop]
>         block_ioctl+0x3f/0x50
>         __x64_sys_ioctl+0x83/0xb0
>         do_syscall_64+0x3b/0x90
>         entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> other info that might help us debug this:
> Chain exists of:
>    (wq_completion)loop0 --> &disk->open_mutex --> &lo->lo_mutex
>   Possible unsafe locking scenario:
>         CPU0                    CPU1
>         ----                    ----
>    lock(&lo->lo_mutex);
>                                 lock(&disk->open_mutex);
>                                 lock(&lo->lo_mutex);
>    lock((wq_completion)loop0);
> 
>   *** DEADLOCK ***
> 1 lock held by losetup/156417:
>   #0: ffff9c7647395468 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x650 [loop]
> 
> stack backtrace:
> CPU: 8 PID: 156417 Comm: losetup Not tainted 5.14.0-rc2-custom+ #34
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> Call Trace:
>   dump_stack_lvl+0x57/0x72
>   check_noncircular+0x10a/0x120
>   __lock_acquire+0x1130/0x1dc0
>   lock_acquire+0xf5/0x320
>   ? flush_workqueue+0x84/0x600
>   flush_workqueue+0xae/0x600
>   ? flush_workqueue+0x84/0x600
>   drain_workqueue+0xa0/0x110
>   destroy_workqueue+0x36/0x250
>   __loop_clr_fd+0x9a/0x650 [loop]
>   lo_ioctl+0x29d/0x780 [loop]
>   ? __lock_acquire+0x3a0/0x1dc0
>   ? update_dl_rq_load_avg+0x152/0x360
>   ? lock_is_held_type+0xa5/0x120
>   ? find_held_lock.constprop.0+0x2b/0x80
>   block_ioctl+0x3f/0x50
>   __x64_sys_ioctl+0x83/0xb0
>   do_syscall_64+0x3b/0x90
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f645884de6b
> 
> Usually the uuid_mutex exists to protect the fs_devices that map
> together all of the devices that match a specific uuid.  In rm_device
> we're messing with the uuid of a device, so it makes sense to protect
> that here.
> 
> However in doing that it pulls in a whole host of lockdep dependencies,
> as we call mnt_may_write() on the sb before we grab the uuid_mutex, thus
> we end up with the dependency chain under the uuid_mutex being added
> under the normal sb write dependency chain, which causes problems with
> loop devices.
> 
> We don't need the uuid mutex here however.  If we call
> btrfs_scan_one_device() before we scratch the super block we will find
> the fs_devices and not find the device itself and return EBUSY because
> the fs_devices is open.  If we call it after the scratch happens it will
> not appear to be a valid btrfs file system.
> 
> We do not need to worry about other fs_devices modifying operations here
> because we're protected by the exclusive operations locking.
> 
> So drop the uuid_mutex here in order to fix the lockdep splat.


I think uuid_mutex should stay. Here is why.

  While thread A takes %device at line 816 and deref at line 880.
  Thread B can completely remove and free that %device.
  As of now these threads are mutual exclusive using uuid_mutex.

Thread A

btrfs_control_ioctl()
   mutex_lock(&uuid_mutex);
     btrfs_scan_one_device()
       device_list_add()
       {
  815                 mutex_lock(&fs_devices->device_list_mutex);

  816                 device = btrfs_find_device(fs_devices, devid,
  817                                 disk_super->dev_item.uuid, NULL);

  880         } else if (!device->name || strcmp(device->name->str, path)) {

  933                         if (device->bdev->bd_dev != path_dev) {

  982         mutex_unlock(&fs_devices->device_list_mutex);
        }


Thread B

btrfs_rm_device()

2069         mutex_lock(&uuid_mutex);  <-- proposed to remove

2150         mutex_lock(&fs_devices->device_list_mutex);

2172         mutex_unlock(&fs_devices->device_list_mutex);

2180                 btrfs_scratch_superblocks(fs_info, device->bdev,
2181                                           device->name->str);

2183         btrfs_close_bdev(device);
2184         synchronize_rcu();
2185         btrfs_free_device(device);

2194         mutex_unlock(&uuid_mutex);  <-- proposed to remove


Well, I don't have a better option to fix this issue as of now.


> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/volumes.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 5217b93172b4..0e7372f637eb 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2082,8 +2082,6 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
>   	u64 num_devices;
>   	int ret = 0;
>   
> -	mutex_lock(&uuid_mutex);
> -
>   	num_devices = btrfs_num_devices(fs_info);
>   
>   	ret = btrfs_check_raid_min_devices(fs_info, num_devices - 1);
> @@ -2127,11 +2125,9 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
>   		mutex_unlock(&fs_info->chunk_mutex);
>   	}
>   
> -	mutex_unlock(&uuid_mutex);
>   	ret = btrfs_shrink_device(device, 0);
>   	if (!ret)
>   		btrfs_reada_remove_dev(device);
> -	mutex_lock(&uuid_mutex);
>   	if (ret)
>   		goto error_undo;
>   
> @@ -2215,7 +2211,6 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
>   	}
>   
>   out:
> -	mutex_unlock(&uuid_mutex);
>   	return ret;
>   
>   error_undo:
> 

