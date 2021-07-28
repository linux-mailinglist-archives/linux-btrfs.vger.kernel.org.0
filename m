Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE34A3D8729
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 07:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbhG1F31 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 01:29:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:29826 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233828AbhG1F3Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 01:29:24 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16S5RJxa017356;
        Wed, 28 Jul 2021 05:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LfuN1QquycAI7bHr+7LJAuBwMdRLQBY5NVZNiUAF9W0=;
 b=BcLUmqnPeK9N50siEPl+48OB3oVnm5+QbQmK82O77ipLporitXbh3B56l2/oA0Rc2mdx
 hq5U4gQDSMFmAOVCx6FyUzdMO98ITKs2SQ0372YLwjkThqDzsoyrp7BCTFxGwZt/c4qY
 ftTHbwijGJdPueYiClVzAnfi/ircffZ0QBojka3KS3mjQSlMgv2a7RYzmgnqg1rzpljt
 7Q83zwH40F/NDXjkKLOvPa4UP0DDNd3N4jpUIKmODwcyyuzCIXwQcVyFZlgwkmnOZmh3
 KajYrMSC4fv8MWYqIN9RsvaOdfHzARpqRsj4Y+1WXtKqZkZjItIDbvTmR0/KIpGV/6Ol FQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=LfuN1QquycAI7bHr+7LJAuBwMdRLQBY5NVZNiUAF9W0=;
 b=YEjYbVZVYymy3k7VQHWDbLF19+8IQIZhzYVbuTw3tzXhmN6k+6Eo1nxd+rwyfCkvmiEd
 qfbBkJddfVuojp/tolP0JI3rf5IDC0AfqrIU6eSg1A3NrN/wUNpjyIpcf3PMMY7j6Ibl
 AsqxVnjqB7gtf6Do1dpmX8U6C6mDq6YvlOzD+SEbEoyNZqJbtSeEpZGzcPTcvx4XmULF
 1U1bhqj9VKrxBikpqgzZm7jWReptzXk6rNEoQzut4cTpLLGODw5Fvnfwmiya6gpZ2+Dk
 LXc+63PLMGdRj/IUxjydjbEdIYdObjHaGQUwNaQzwEiDjAHl8NdGKBFwzEU++fZpyOLu kw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a234w3hpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 05:29:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16S5Pjwv034614;
        Wed, 28 Jul 2021 05:29:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by aserp3030.oracle.com with ESMTP id 3a234bqqbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 05:29:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cORTD5sIv2rCmdcXnC6+s005feA4vBFU4yfcd9d2VTovbD6ySyDgXdFSwm8jh0If/ZhozET81iU9Z47ShnGKXxToAK2GYy1UC2aEeVNb6kRsfqHveRPhrTuZXwbSk2a8tTVu2gMOcgz6sHQDW8YygsqrxVpjnpMuTSUQ5n1WPWMBwOL61VJfUydBcEyH+0KyEF725shzGnlTMpEgCrJKgCit+dEINrZkhg8skbb1+YWgcS5XsHd3/EiEpy6d5OTa4Qqm+trbXXIuO1XF6O2g6X3PDIkgHzlaGydmAXmzu6yLAL/soFi9SHckWV67QVMeVPT05JYVa7Bzmt/Cr0DHnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfuN1QquycAI7bHr+7LJAuBwMdRLQBY5NVZNiUAF9W0=;
 b=hUzOb3FZ8bPwTcQWzh2xuKsa/sr9qKCAqU4OJs2158t6RUVX1lLuoYNiKXt0xlAnVCuTbA3vyjw236tUOgChhVefMUxwmhPAQL9AvxMslD+V2sk3PYxLP64BTmB34ztjWASXZ5YvtfZBFV9fydZDqznOpNrSYZlEcymHMhDqwExocb49EZY2f1VOBc3JhY5vB1L0waAxTBg/uLejHh/vyaq1fV+zdsbz/O8vhA/6By1dHy4LLkG4Rfg7piF2/eXGjlvnGbuL8khOeA6nmppfX06Avh6RAJuA4oUpSaGvw0CKXgYpsMtrKQ+jeuuez1M9+QCQz5r0tQO+UD8Y8MXXPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfuN1QquycAI7bHr+7LJAuBwMdRLQBY5NVZNiUAF9W0=;
 b=C5vtAbUhR7ErM82ICpzdK6yXBd50UYRDvMIDyMSeO/Y1+awj242dJiwS4o3BcVwKdNCAHyYfi7jt6mdrMvs1l5RJ3BfAZkC+Z2Cd+0OqxFNXJuVQFxYICVLugPMNchShHrFH11FOYT0kqHCWzN9iq/n1FnOVLwLDuK2stnOJLZU=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 28 Jul
 2021 05:29:15 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%4]) with mapi id 15.20.4373.019; Wed, 28 Jul 2021
 05:29:15 +0000
Subject: Re: [PATCH 2/7] btrfs: Allocate file_ra_state on stack
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <cover.1627418762.git.rgoldwyn@suse.com>
 <2bb91af815d028ed3231910fcc5d8c6779ebf79c.1627418762.git.rgoldwyn@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <9b44492d-67df-c2c8-294d-05f70b205fe5@oracle.com>
Date:   Wed, 28 Jul 2021 13:29:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <2bb91af815d028ed3231910fcc5d8c6779ebf79c.1627418762.git.rgoldwyn@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0136.apcprd06.prod.outlook.com
 (2603:1096:1:1f::14) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR06CA0136.apcprd06.prod.outlook.com (2603:1096:1:1f::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 05:29:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0383bcde-62f5-4a0d-bbd4-08d95188a3a4
X-MS-TrafficTypeDiagnostic: MN2PR10MB4128:
X-Microsoft-Antispam-PRVS: <MN2PR10MB412850C568B97E8CB966EB8BE5EA9@MN2PR10MB4128.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:339;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HIDM4OKnfwsdWISiWO8PKBfDQhdnYLGFfT97HKapKl5VC3HFufKPK4+5hlESZsm2rlBlXELAxME4maynrIVXtnWcpY4vGlwo7BGOnJnccDwNGbqKD/CTKuiHLiyAT5FvfpSQ12I7DNsSaTFVRntWT7I0LQWWjbqEJ7fpWUBZh4jTz/w25JMSmkmQPymv3emHVci+0qtjmWO0p35kVWukZdLJa6LpI18GGrL1NJ3z98UFe50O925eNM0C3W8MNAszEnRYUeCGpqJp+4KK02em/WgdWxA//QuAGJuUFiSDs8X3OuK0aDaXyLntBM+5/Jm+UTdG2Nt5awcYZ3LRZ/6IPSegV5JXwOE5g/j0LVHw5yD1XjNtkXTRJ8/yVV9sMgtKNLZjIOMV0hvXJcZzx0/Joa3s/HG7dwZD0Go9sed++a5CoyJeetYZ+jNG3CbWbFT0mww9EYIIXExbCLPvOpy4l4sIknvNOcldKYh4lXxx8jPL6dbRayyDtL4S9UM8OLkYRqq7594MN0EhGbZNqbLQLMOpYG47XkTMOOB250iOZZ2ETDB0SzKi1lNuhSI71rQAbGa3EGhzWiO2lVA7Ql9ReT+Y9qnJ2Cgd0Ne82pNzHVE/7MXM9BydizI8DfAeDSw4eUqaWbHcZ6o89CD7rQgzLMPTz3w0m5bSjy3JJzQJii7qQOdeRsuDGpHbqmodL+2T+RogftTBrmjMGYKqqdOx74Rpn3NujxxzMxHdC4m2bl8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(396003)(346002)(39860400002)(136003)(36756003)(2906002)(31696002)(86362001)(186003)(2616005)(956004)(31686004)(4326008)(26005)(38100700002)(6666004)(44832011)(83380400001)(8936002)(8676002)(66476007)(66556008)(6486002)(478600001)(5660300002)(53546011)(316002)(16576012)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTRKTVJ3ZkRhTXlzMURYSXFFZUI2dW0xaU9weUpUTHVRU2t2NDZTQ0hadU4r?=
 =?utf-8?B?Wk9XcktBZ2lXZTZlY21ITDBYbE1SVVQ0N0RkZURsR2hHakJwR2o2WVgvZE1D?=
 =?utf-8?B?RjJZYkh0VjhQZmZrbzRPa1F4MEJ1NFdLOWtSWEx2ZldBY3R2aTk2L3ZlaHNB?=
 =?utf-8?B?b0hsOXJ2WGVYdzNUUTlvVWJ2Y29pbTZPczJOc29Ub1JlWUNyNURmK1hrNFhl?=
 =?utf-8?B?UWVKd0pXcTQ1bzZwcFp6Y0FqNkdSRmE4bXI5Vkp0VWMvaGxKYzJWMTd4UTFq?=
 =?utf-8?B?aGlmWWNodlJQQ0J2MmpJTkdkckpPMGliUE9oUGxUbTdLVTRGdWNsTXZCc3hR?=
 =?utf-8?B?NFdpV1NHd1pvUzJHaVV2M1h2Rm9oQ0R2amhMQm5NK3UrT3lUQW9nYjgybEUw?=
 =?utf-8?B?cFFTVFV6QnYrMHFIeTBmamV6ZmtQYjNMOUFGWVh3d1ZhOHRQNlZRdkxvYjF4?=
 =?utf-8?B?VFFFT1NPbmZOa0JKcUlGd2lKSUErS2RKOEZUQlRCbmtnM0laZE1uckVEdnVH?=
 =?utf-8?B?ZTFYRHlLZm1MUkk1YndYc0lzYXhUN2p0azFSZXA2QStUNlhURTIyL0hGM0Fn?=
 =?utf-8?B?UnBUalNaRk15azJHQkRsaHRTcnVLMDQ1cGwvcUt3SG40N0Q5SUo0dk5RODVG?=
 =?utf-8?B?UjdsU3RHQy9HcVRTYTZuNWdlbkdaVWFLWHVCOXNNRjNVSG9nYTdnclVPYmxp?=
 =?utf-8?B?YWpOd3hMc0VoQ1NwMC9ib2NHdk94SXFqKzUydzRTR0JVbjMyeTBVcVIyRWI5?=
 =?utf-8?B?OXUzRWJiYW8vWDYvMlgzcE5LT0FZbSsrNVk0RnJFV0Q5RFlYbi8wYVdTK1Nw?=
 =?utf-8?B?UDhqK1dQZnpVL3FlQVJoZEtMejF5UE9uTWxRVW9Wd3hQWDRnQ1FlaG5mcnZs?=
 =?utf-8?B?YUtFY3dRRnRFcHJ2WS9pbFdLREQ3T3hZRW9oUnRhbU9NNkFUV0tSeXJsOFNS?=
 =?utf-8?B?eXJMQmd1TldLMDNkZ3ZKajB1a1g5bE5TU3ZJTGh4bEJzSk1EZGJzMWhlRzZT?=
 =?utf-8?B?TlRpWDZUVXRrYlJmciszd29zMSsrZUxWaTIwVTkrZ1RxdEV3cGVIdHQ3eHlZ?=
 =?utf-8?B?a1RBUmZGOEpjRFNyQUh4M0E5UUtvT1ZoZFlGUU96SGhFa0xxaXBiS1hFSHY1?=
 =?utf-8?B?L0pXN3c4V0QrNkpxN3Q5NVZOd3NreEcwL0oxa3R6VHBZeHp0dmJPc20xNTBz?=
 =?utf-8?B?dVlTcHhyclJGMUZySVhWZmlyeTZGdXdrL3FlaTI5YjFLaUtVc09LdllDa2xo?=
 =?utf-8?B?MUU0MXlVb2JUTHJBV0xUWDZRdldDZ2FYRFhuNlFQRkhTeXNGdmNCSXFvcTAy?=
 =?utf-8?B?MGdYZkt1RnVBOUg2K3lhaEdKbWpjU21pZ1FRckxtUXoyTWNHNzNaSkdkTFpT?=
 =?utf-8?B?eUtTbzBjWStjWDBTQm01S2ZmQS9tQ0FzMUR4a1Uya3JjZFg0RmpOSUEraDJx?=
 =?utf-8?B?V0J6M0RYeTc1VjN2N2pWenpyK3FGd2xxamFjV3YvbFZkejNITno5emNMWDI2?=
 =?utf-8?B?THg1YlFHcUFZRzNHeFgvalB1WEt3bThsUXd5eC81QjJ1TXFSZnFDRlRuWStO?=
 =?utf-8?B?RHBsbFp0NEZDTGNyc1NUVDUxb3FsOElNV2FyU1pHaG5mTGZPK0x1Rll6VjZi?=
 =?utf-8?B?Mk91S3RNcHpHS1g2STJWUnhaSXNiaCtOdWRZNFoyc0UrKzFpZUJjd3pFMW9k?=
 =?utf-8?B?MlZHc2lOREpZanhzbm9ZWHFlYXplUzkvRG0rUXJFWmpBY2tZZkJveitONDh4?=
 =?utf-8?Q?qiuBaiX+7szfpam+Cg7/gAeS16iH+ULTmgeYKF+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0383bcde-62f5-4a0d-bbd4-08d95188a3a4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 05:29:15.4810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwsVCLapW+Tjb7rRPMRJJpPy6/e8CnVGIQX3IMmw5JFzWYh5YkRAXNX5odmNN1EZ2oW6FSu5hKbjZYdKHKzlIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4128
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10058 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107280030
X-Proofpoint-ORIG-GUID: qJrjfclwTxdDKTWY5SbKL5mz3anq3v31
X-Proofpoint-GUID: qJrjfclwTxdDKTWY5SbKL5mz3anq3v31
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/07/2021 05:17, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Instead of allocating file_ra_state using kmalloc, allocate on stack.
> sizeof(struct readahead) = 32 bytes
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Looks good.
  Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
>   fs/btrfs/free-space-cache.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 2131ae5b9ed7..8eeb65278ac0 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -344,19 +344,13 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
>   
>   static void readahead_cache(struct inode *inode)
>   {
> -	struct file_ra_state *ra;
> +	struct file_ra_state ra;
>   	unsigned long last_index;
>   
> -	ra = kzalloc(sizeof(*ra), GFP_NOFS);
> -	if (!ra)
> -		return;
> -
> -	file_ra_state_init(ra, inode->i_mapping);
> +	file_ra_state_init(&ra, inode->i_mapping);
>   	last_index = (i_size_read(inode) - 1) >> PAGE_SHIFT;
>   
> -	page_cache_sync_readahead(inode->i_mapping, ra, NULL, 0, last_index);
> -
> -	kfree(ra);
> +	page_cache_sync_readahead(inode->i_mapping, &ra, NULL, 0, last_index);
>   }
>   
>   static int io_ctl_init(struct btrfs_io_ctl *io_ctl, struct inode *inode,
> 

