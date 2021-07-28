Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F2C3D87DD
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 08:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbhG1G1a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 02:27:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61868 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232985AbhG1G1a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 02:27:30 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16S6GXpU001796;
        Wed, 28 Jul 2021 06:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xfo3GAHgQqmE0VhS7rmWgDnLZwvCObML8j1XKpLivUY=;
 b=PwmraRlVPE6UOAzYT9T0MHHhptZBmNxeooiOwz8ynQEAc+QjyMDbr6EOFAqb3o8JJHXa
 ke+BPF8F7GhZD8wjaFbbMzUB9m3FjV2Dp6gZFf8eIPSl4XlApmjzW4P6t1LGUqf3eGdm
 JP5CF40oGHxeDZqXN2xLf/IcD8fxL5nNSNNnrWh1qnFY7D76LSd/1KsgZ4b452uDGuUH
 Mx8yAygPauoWN5lVjPOJo6pCDcoX5cfMuYj3iccNSfiqlDX1sEDAOjHE9SkgrfWYCya2
 vpt3T9Falzg1Hk+mRHBqQjPwszaOb++AWfXKJzzjte0etr6yfshdmoa22ZZVMvzBfum7 iQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=xfo3GAHgQqmE0VhS7rmWgDnLZwvCObML8j1XKpLivUY=;
 b=z6r+vJ9uIo8xU6XqpBbCs3A9Dqlv+cMkUSvuV8jxDpjIDZKoG0aUYreIJnQUma6NMJXS
 TJ16ng6D1YfXckX9xWuSq8OlFWZMcNlTgk6g4EZn4L/EwPJgdgPGByaGyTGi0FcNtrKX
 frvpv5mXWJ/fXsQW7kZMFT0syPMzQw5wJ+Kup4Es/GO87GAZt928EdGTqNK0VxSM4MGq
 GtmTDT0HpKKflbpvyKqwq8syPCbBrdYs4qAGvHxBRm7RBYYWqkgC82kF4BRx5+GP4CsA
 XFBqOph5OOff8I8LT/zGC3SPvG0xLjLr7NTSFhwh5M7BKo2KIg4V+uFULayOpo9El88B jA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a2jkf9v6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 06:27:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16S6Exms003844;
        Wed, 28 Jul 2021 06:27:22 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
        by userp3030.oracle.com with ESMTP id 3a2354gnnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 06:27:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrfjM9m5awj4zDgGipqgE1iZOPMxIRIlEWDSPjulA3qYVrq3MQZmAhgsFPncMI9jfwDL/a5Pj6JTRmrlTXitKEc6wI89LbH3mlPFJcgtlkK41gp8+6i9ciLWBYCztYpKTjo6Mg7KEcYOmrGzJgc506iIuEzQemdsLz5Vr+oWYabohfUTuhPegwboESowGOC0pCPK7HLNU5e+9dO33QIheX75mb/fBq51zUJAsO9efT41IJ5nreEcQ2O/47jMnJ7VjiYHbQd3uOuxBvLQenJ2feSlf75dpNd/00pIFmpJALDwjxYeG+bfHqUCUsWfd4PGkFt7e9QAXkAa5+/g4trFow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfo3GAHgQqmE0VhS7rmWgDnLZwvCObML8j1XKpLivUY=;
 b=c4QhAnoxz52vW4CefEpRqS1mEaw3Jz9ebVH6hKcqboh6MUtsJbOS/NkgGR0zuY6pAhtzQc7n0HrnQpZWBxEe9mR3qxzrQKp9WbudiGPP12pBB5AxsLb8/vkExN+IJvSmygf/MG2PZXW+xsNA8BWXn2t229Sl/T/gvjdri0YyV930fIyQoA+NYYDfoYofxVC70G7+EGn16vq/D2WqWym2ms0lVhXYE201Jb3dsLujsIeqR/pw/odNIk75bI5w4Pr1te/wccZ9QTAW02jikE2cZ6NIbW1Pet08oeT34G6o74PBkba4DQU+e33aQ+P6Ef9Iqis6GNTly1R0RROdu1P9Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfo3GAHgQqmE0VhS7rmWgDnLZwvCObML8j1XKpLivUY=;
 b=uAerW04gd0e/jDrGh+jEX7cmMP9ZpAreCZnK929fXv3YlIaMIw1rokcOoT3gQc23sa4bRIaLwxfYEtJ7IS0KJNHvW14diOsXcPyo5UOzK8u8Dfn9mjWS57W6W4Lg8fdPtOPy+ftqYtVqhc+Qcr+Z354ElUFhneGsS3YidWzi6Mc=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5075.namprd10.prod.outlook.com (2603:10b6:208:322::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 28 Jul
 2021 06:27:20 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%4]) with mapi id 15.20.4373.019; Wed, 28 Jul 2021
 06:27:20 +0000
Subject: Re: [PATCH 6/7] btrfs: Allocate btrfs_ioctl_defrag_range_args on
 stack
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <cover.1627418762.git.rgoldwyn@suse.com>
 <4b5d49128b43de57f5abfa9c922eb6cef3be9cba.1627418762.git.rgoldwyn@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <a3c30a94-a2ef-1cda-a3f7-67ed839ba4c7@oracle.com>
Date:   Wed, 28 Jul 2021 14:27:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <4b5d49128b43de57f5abfa9c922eb6cef3be9cba.1627418762.git.rgoldwyn@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR02CA0064.apcprd02.prod.outlook.com (2603:1096:4:54::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 06:27:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d786e0a9-0165-4699-54f0-08d95190c0d3
X-MS-TrafficTypeDiagnostic: BLAPR10MB5075:
X-Microsoft-Antispam-PRVS: <BLAPR10MB5075E33F48392D5EDB8D431DE5EA9@BLAPR10MB5075.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SxjwDHhtPPYskzpkhAd+7gTsukiWJMOmrcwDRd1T8Xog781ePjzIt8/gmP4p8zgbQfSPkkmVf/jhStvziqGFGEqJ0d+GQQf2R3c3Hsc6YTni/Pxg/5raMxRjuFjUFBwJGy9jzLGoacweDMnxC0RO5aOJb5VWipmgbVRqE7bT/ce2idfm6bB/eP5UmGmnvVB7HNdUArFx49st9SGNBzhCvuTnQStTiSQB2QfCh/SLJUrt3uGxwCXRJzPvfaQ0+i9Gr8USUfZoQ8SCf65rNJpzxxpdV1d9teBIZ2qs0Z95OZbG0ELa3OFjhYPgpexmicBjoNYxhea8ZDqiqd9BEh5XaYi2vulgeVzLVZgSoJBV4U7bi+zAgUHqr63szViQ16657OxFB592z0+U/iJik5gWBjTEdJY07ae/u+9+uNwpqv4VuRjygkbbLqsO7imKjVroa2wtBUDHKSr+Ig9sdpBzoiYg3xklHINUZL3FeqwC7HqwjZPHOVvUDTayB1AkzfdkqcUVL4PxSSj//gnYDwFGDIND0L7YBzE4Z7HkWsNfrSBDJtMupEhixMwbKtZ4wX+6ZqtIZ+M/gri1jnTNWy5l1D68dDDqP20DqqOjXbfs/rXUzINy68o4uZwSwhpLg0JMdunqRMA8EVA4rJ3LHZm+QbNwWLfbVsggdmVGtjmq7wQFuSOosLzaabHNwLT920ctXMW5owdxjRmGZuWFI/FWSZ86RuYO0sJRqgu4UboVz78=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(136003)(39860400002)(396003)(66476007)(83380400001)(8936002)(2906002)(478600001)(31686004)(316002)(16576012)(66556008)(186003)(44832011)(6486002)(956004)(66946007)(8676002)(4326008)(53546011)(26005)(5660300002)(38100700002)(6666004)(36756003)(31696002)(2616005)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3VocExnTGV2NnFVUXE1ejBiZTlCMVZldzVPK1BUTHZUVC9jNTRXWExkN0Iv?=
 =?utf-8?B?YXZiVkVMWm83RUlxS0pabFpEQzB4NW4xZkdHRFNsM0diczRjN3BoY2JDbHFS?=
 =?utf-8?B?S2YxVHBiUnAzYkFKTzhTNUFDbUxSYXdjbFZFMmw4bk9pUmlodHBOSkRSOTlS?=
 =?utf-8?B?MDBlbjVISExRbjU5Q3JKM3A5Rko2ZE54YWkzV05yVGpwd1JIM1gvbUZKejFU?=
 =?utf-8?B?ZXVMK0VmcStoMzBzd1ZGSkUvN250R3FFQnU0M0VzeVJ6RmFUUjZraTZFZHhY?=
 =?utf-8?B?R3JDMjVlQU1aRU5JdnR2d2k1SkhOcEZXcE1kc3VHMmJCYis5NmJwUU1LbklJ?=
 =?utf-8?B?dkdjM1IxZkdmOTlWcUtiRWFRRlFHTjVZUHBMWWhKVTVSRG52VXpyRzZKYk4z?=
 =?utf-8?B?OVVGZ1ZFckliN2hHMkZwbUlVOE42cElnRmJodnlyTnlrcWlOMnp4OFA5NEpJ?=
 =?utf-8?B?Z1Ixd0w4UFliZi9jVVVmUFVQVWdkdU1XcFZhbUFiQWkyNG4zUTF6QU9OejNu?=
 =?utf-8?B?VWRycTJDSXcvOERWR1pzYjd1M0VrS2REODNsTkZidzZ1VUIvdnJUelpqSUpT?=
 =?utf-8?B?U2JyMmp6YkdLY1JBVW4vZG40M0ovRVVYbkdmVjdDdFZzYktIZm5WOU9kcTZj?=
 =?utf-8?B?YjZhN0FIeFhoc1lSdHBiOTBscGt6YVlNb0RjUHRhbVZIV24rQ0xIRTF0T0pI?=
 =?utf-8?B?MS8yYjZaaDBCTWRDMG13L1RyUlArRzl2ejU2UHdjeEExZm15dWtjK3lhTGo4?=
 =?utf-8?B?QVlMOFJHZE11YlJ1N0pzdlVoU3FxeEwwL2h6cGZVLzJmV0ovVlhDUGI4NXZM?=
 =?utf-8?B?eFJqblVvNUp4ZGwwRXp1NUQxZ1JLSVlsWkJoRUZGRjdtNjF6Ylh1OHlHM2Zi?=
 =?utf-8?B?MDF5RmIxYkdWOCs3NUkrVWFVcTBsajk0R3ZWNU0rMDVpOVBLRE1nTE10SFdS?=
 =?utf-8?B?anlZT254amVtSnp1bVRpWGlQWlNqOHBYdTc4WmgzTlZoYW1IRVp2MFp0WU9M?=
 =?utf-8?B?UVhBN3QxRjdTM3VmQWZGOWFja09ncGpmZ21yUkVCVGlpaElGTThTSWFFZXp0?=
 =?utf-8?B?VVNQZjM2YkEycnFzdjV3RHI0RHNLN2lHaW9nRjZoVUNKejZLNit4NEE0RlFs?=
 =?utf-8?B?dlQxM0pFbHFhVWlCbkdSeGIxQzNBZFFxZ3piZEJEcG5SM2VMV0J6YnB2Zkgx?=
 =?utf-8?B?MmxJNXNRb0xkdTdvSDBxaGROa2p1VkgweTd3eENpTTFzY2xrdUd2YlhqWE1U?=
 =?utf-8?B?SnBZcDY4ZFltdEN0ZE9CcWU3dyszaWxoaC9DcGxmNTRJQ0puSnk2SXZISVky?=
 =?utf-8?B?M2ZwQVMxLzJoSENKdDE3MlFiejBKd0Z5cXVXbDZBZ2Y0WktjejQ3VVhWTWdx?=
 =?utf-8?B?cGN1djMxaG1mcVd5M1Fyblc4NWdSMmczRUw3TFhEcWFVNnNkc3F6d2dLNGZR?=
 =?utf-8?B?TFV0TFNMaldmSFVCT2dLcjg0emZTdnY1NnVvVVpOL0wrUVZ5ZENZVklqZ2ZR?=
 =?utf-8?B?UVk0OGpqZUN1a29HMytjeEtydlBmcUxCMHdxRk92QXJ3VTBvNHNJQnJLNWJa?=
 =?utf-8?B?eTdRR1k2TWd5cFY3RXovc2t6WGxhNi8xZXN4cHVlbDJLcXRZZ2twUDg5Y2Iy?=
 =?utf-8?B?dXZRSXhRU2ZVQldXcE5zRThJd0FUelRHRVpPaEUwbkJ0WGNyTDZ2c3JDTVdO?=
 =?utf-8?B?aGRsT3VuQ1haWFZOc1NQV0pKYTNUblIyL3BIcjBYZVEyb0NSNFNWSXBVU2FE?=
 =?utf-8?Q?9zKiVhBXE7bxcIMWr/Z3TTH/sVdNw9BN+SgoKag?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d786e0a9-0165-4699-54f0-08d95190c0d3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 06:27:20.3882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OvgZ8VV4IRy2W26Fb/JHfbRvQWFmXCQPpWfLGiBnS+SlFJIs4oowtLdVFIo18ExzUUeL+7OXF3I6UfDu/6d56Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5075
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10058 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107280036
X-Proofpoint-GUID: 6Jwfo4bvnhNppI4upWgpcpVuvWj7Pe3D
X-Proofpoint-ORIG-GUID: 6Jwfo4bvnhNppI4upWgpcpVuvWj7Pe3D
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/07/2021 05:17, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Instead of using kmalloc() to allocate btrfs_ioctl_defrag_range_args,
> allocate btrfs_ioctl_defrag_range_args on stack.
> 
> sizeof(btrfs_ioctl_defrag_range_args) = 48
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Looks good. A nit is below.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

> ---
>   fs/btrfs/ioctl.c | 24 ++++++++----------------
>   1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 291c16d8576b..bc38a1af45c7 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3096,7 +3096,7 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
>   {
>   	struct inode *inode = file_inode(file);
>   	struct btrfs_root *root = BTRFS_I(inode)->root;
> -	struct btrfs_ioctl_defrag_range_args *range;
> +	struct btrfs_ioctl_defrag_range_args range = {0};
>   	int ret;
>   
>   	ret = mnt_want_write_file(file);
> @@ -3128,33 +3128,25 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
>   			goto out;
>   		}
>   
> -		range = kzalloc(sizeof(*range), GFP_KERNEL);
> -		if (!range) {
> -			ret = -ENOMEM;
> -			goto out;
> -		}
> -
>   		if (argp) {
> -			if (copy_from_user(range, argp,
> -					   sizeof(*range))) {
> +			if (copy_from_user(&range, argp,
> +					   sizeof(range))) {

Nit.
This fits in a line.


>   				ret = -EFAULT;
> -				kfree(range);
>   				goto out;
>   			}
>   			/* compression requires us to start the IO */
> -			if ((range->flags & BTRFS_DEFRAG_RANGE_COMPRESS)) {
> -				range->flags |= BTRFS_DEFRAG_RANGE_START_IO;
> -				range->extent_thresh = (u32)-1;
> +			if ((range.flags & BTRFS_DEFRAG_RANGE_COMPRESS)) {
> +				range.flags |= BTRFS_DEFRAG_RANGE_START_IO;
> +				range.extent_thresh = (u32)-1;
>   			}
>   		} else {
>   			/* the rest are all set to zero by kzalloc */
> -			range->len = (u64)-1;
> +			range.len = (u64)-1;
>   		}
>   		ret = btrfs_defrag_file(file_inode(file), file,
> -					range, BTRFS_OLDEST_GENERATION, 0);
> +					&range, BTRFS_OLDEST_GENERATION, 0);
>   		if (ret > 0)
>   			ret = 0;
> -		kfree(range);
>   		break;
>   	default:
>   		ret = -EINVAL;
> 

