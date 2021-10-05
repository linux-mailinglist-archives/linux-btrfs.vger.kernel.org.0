Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67CF421CD5
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 05:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhJEDUQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 23:20:16 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:46798 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229659AbhJEDUP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Oct 2021 23:20:15 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1953EWd2023902;
        Tue, 5 Oct 2021 03:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=r3RBonhCmy0dZYnPAOBZgjxKob6EwpwJ5+GR9R+sAFg=;
 b=biOobT87BF+ZDR1LYR/S2TAMswKZ71mQi2sMTCfSELTAN/13QM7IfGqVXdJ+LVXIyUkp
 rmllR/OlJu54RVWKlgrndO9XlA8sooAsv9SMu9X2wljxZCGymqNvdQ5eh7yF+amEdSul
 wIdnOz3wZQGpGewzmjha9KjIzLcJAG+1UrMOVew/kl5Uz+6768nNkNLURhXETTrF6+qn
 Kr3Ln5rW/8v9UUyg7YlhBe0FdNn6WoB31gbyn2dHlnCtPFi2p/TyH5K8lRwl2iKhrqdU
 ZO8H8DtoGaNqg63RmK+q9sRkFfQCwzwFSQFlYRPTU1C28AkXaNPgVC4NbFjyhWIIZqxi UQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43gm2yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 03:18:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1953AHMQ172239;
        Tue, 5 Oct 2021 03:18:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by aserp3020.oracle.com with ESMTP id 3bev8w2r9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 03:18:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRUO+xVpGwglya2ALPnCqk0Q2ylHUYrqQtyQGGzvm9sKq0xH4qvB6Dqwyzf5LFfHYT317JK/019a8AI5y5kGTqch/xu7cs7tD3wmVg3nLEbRCMe+sqKtvFZD4IRi2T1+DzFA6zgNd8iTBrQRVxdmzxVznxHYBuyhlkdTz1N5s55l9sYrfsDq5UYtzwt9LmDyxcZWTsiLRZxevG5uvkLgVJcPBXO391s924yxgI/O7ofLjcQ5ofJTgnUbC6cTpVqyrl8tPSQxn46BJuqCbfmhBYYgQFA46CUZx8rN/3ez0OXuWB/dRwkKXutWXWE+UNcaZvH9mIwHRp1wNV2dW0NmtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3RBonhCmy0dZYnPAOBZgjxKob6EwpwJ5+GR9R+sAFg=;
 b=SZ5xDw4ZtcTOXJKKgoyvisL4ryhIDoBE6/f0AX6l9t/ojC3ER4KGzKR5aDEiAZw15aoS5tW9ibZ59pmOxkQqCezAsuyzbWdyMUOmq1atmscURik23m7fOYZH2JGo15iBCaEaPeiGQDN1DR6mxRtOhHcYwLAsu0WvTzvgF06ZKXyRSkYRQnN1lzHARZcyoMAk3m+t2F+FJRiGNcKMVzwn2F40eHhQz6KtBU3nzX8eOd5xscXSDt1i45dy+1a0UTUFSMqTsvAllzuCqhnVlfKBNqnJGWc/DtamU92OuRNCHZttv3qp6Z2yHeqKqBxjgUpheJb7WFDNlNA5VsooFdzOaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3RBonhCmy0dZYnPAOBZgjxKob6EwpwJ5+GR9R+sAFg=;
 b=pFv7ffrMfykwIPTeK0uA7LDuCtncpL3RbPz02L+/gIr0xJ5i8mKMpKnZCCivyMlgIldr3rID/ojrHK1R1OUG4XAR3lBoxA9N8Iu2xbs9NkzNiEpXKcI7HtghM+G65tdgty6wseDByP49xPYFUvSGFkIoMu9uYMMOJdaFoFZLmE4=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4093.namprd10.prod.outlook.com (2603:10b6:208:114::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 03:18:17 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 03:18:17 +0000
Subject: Re: [PATCH v3 3/6] btrfs: do not call close_fs_devices in
 btrfs_rm_device
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
References: <cover.1633367810.git.josef@toxicpanda.com>
 <326bb4ecde587f0f3f4884b65d17951661a0ca77.1633367810.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Message-ID: <f1f5ea81-1914-16d7-4d1b-5e4d83a9265f@oracle.com>
Date:   Tue, 5 Oct 2021 11:18:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <326bb4ecde587f0f3f4884b65d17951661a0ca77.1633367810.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0188.apcprd06.prod.outlook.com (2603:1096:4:1::20)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR06CA0188.apcprd06.prod.outlook.com (2603:1096:4:1::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend Transport; Tue, 5 Oct 2021 03:18:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab82c7ee-e5e8-4262-f0f8-08d987aec65e
X-MS-TrafficTypeDiagnostic: MN2PR10MB4093:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4093636E66F9440B41CE02E5E5AF9@MN2PR10MB4093.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0TCFn3rZwzu9vqH1/y1Xbf+jYNK74dssGCmu3yJRO15qcXOJ0KuAVr9S3VsKf7GoMfVXQtRrK6/45rAAVkumZkMW59+zsOMkxefVm9BgqyvROr6zjcD6qRmBzpCSR2kJ3uftbH75/KPt9XkC4t4SjW0pCf+SzWV2eQ8/YmdbSXaZHx6emTJeFbvTpSsbMvL2OWGGwKI8/K3fKbCNSd4UT7NoZpxPbrsLw0XiwyTDD1Uko0LhskpNlgaA/MwHHUh6B38TKPHUknaEaS/AnPWUbwJ6c3ebelKFOagRYSUNzVshbUwMQjzTmgCO6I/9d71PQsuS9O1soMZKumQwk8syCJHj5bfZavB8xU5oacoteuWrfO4Ko7SQ1UmNtz3PF/Jmeolv5dZqMPcuvtGDqeqPf2JBN+6kNwDe2YzRHKTgVvjR3rDDgF654nh2RpiWDpskqJnDzN3Jjb3yPDGluc7LKHvArbFe21wpT8Im2nMXFyNNqLYkjYFx0lYjvRP85KY0OqLpEaorQ2nrrL4YoqutYWpMBrPzaPrWv6u4OIB75Xe+WJk4OdOi1XgMLR54ECDx9B0XCjy8NrktvDjHAUpDCjSoBMA7mO2GOkSvegRpURoHUorR8ak4sit5lIO5nizjXBJnTisNvpaBErnJQ077e8UjGLwe49gH15Z8Xx5CTr7DkJyYXUMCjSXO0ZzYQ/vA6cMfh1Rab2rjSeXXYv0WFpxlNB33yk6gfSUXko2gj43x69Z0+WgHvuc2JoAnX2uc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(5660300002)(316002)(38100700002)(6666004)(16576012)(4326008)(36756003)(2906002)(186003)(6486002)(2616005)(956004)(31686004)(83380400001)(8936002)(8676002)(86362001)(44832011)(53546011)(31696002)(508600001)(66476007)(26005)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXd6eXl3YXVEWG5aRGlSR0piTnpOaW54V3A3cjF6emZhaldoZ1M4SmN2d3Bv?=
 =?utf-8?B?TjRCR3hEbDZWOXljM2wvQk9NbmZidEJnNFZFNCtSWHNSeUJ1UzBEaWZaTVFB?=
 =?utf-8?B?VDN3UHhlOFZaNVpoT3NJaUdacFdjZ25iUjhjSFlKZE9hcXk1R2l0NnR2T0Qx?=
 =?utf-8?B?UjA5QVhLSlJmS1VVZnhPaE9valVRd0pGeUlZdmE1ZzZFOWowY1k2NW95bzh2?=
 =?utf-8?B?c0NJcTRKY0ZqTGVPWnM0c2pqWjhQc1cvVUNZWDVZdDhUd2ZvYW5MQ3kva1Zn?=
 =?utf-8?B?Rk9rMkFNdzZCUUJZU090eVA2bGtHZmNSZUl3R3QxcnIvb1hwNDV5Q1FMTElB?=
 =?utf-8?B?T2RvYVduRTJ3VExIQlpzUUo4UmtvMStEYmN6Yzl1UlJpZHRtMnE4eVREcWZH?=
 =?utf-8?B?RGs3Z0QwbTVmeWRXMUZSbTNLMzNML1UwVW8wWEwwNjkxeDRhVFA0ZHdhWEJx?=
 =?utf-8?B?LzMrOU1GeDFMSE80VXNzVGcvam9KMlJhcEJLa2JHL1ZpeDVBYml2cElIWXZB?=
 =?utf-8?B?eW5DMFVMNGROWDIycTFvRlVTM1Z3WmsvNWc2cWR6WG0vTVAzbEpSaFRxeUI1?=
 =?utf-8?B?VkpoVTl4dGFnejVsWDg0cUVrelJhOEdUY3BjRFJNRDFKcXdNb3BWd1VrUE53?=
 =?utf-8?B?V3E4UzRuajBXUlh4YXVNN3YwSXh1OUpSaElNY0c4NEVhemNOSnliREtkc2VQ?=
 =?utf-8?B?N21nZUVZMnFOb3RYaEhGWGZWL3MxaWhYWnFjK3VVOHQ2dzlKSEZRVU4vck9x?=
 =?utf-8?B?SE1FVmk5Nzk1YzNDZlE4cGl1L3ZUYlpvZUp5d0N3SnFVSjZFUEVnYktTaS95?=
 =?utf-8?B?M09RNFVWRHBIV0krT25UcVpaMnN2OGF1ZEZSbHVpSnMvOEw1RXpZTjRBODQ2?=
 =?utf-8?B?Z21OVU1mampOcVRrL0ZsVmFMQUlYdyt6bFJrcHFycGxYTkxnTGFYVDBLRGti?=
 =?utf-8?B?YXBWOTY0aU9iR0FERUtyNU54YUxZMzF4T3Jab2dMRDJCdzgybTljTDZrd2NR?=
 =?utf-8?B?em5Sb1ZGMDJtNDkyU096MDlIREZFN2FqYUNsZEpjTkhRdW1Od0NOTE10VVE4?=
 =?utf-8?B?ejFEb3ZkL0VuSFJFQmJLM1E0WFJxQUU1MGg3eFg2eHRXSlc2MkFTWHpPWVh1?=
 =?utf-8?B?aGNubU9wdVR3TXR2SEl2ZHJGZk55RkRhNUtRN3pMYWVBZWRHbnBYVVU2OGNz?=
 =?utf-8?B?Nkp3clY4MWRENzEzMFVRMHlJSk5USkZVNDd2ald1bTE1Y3hTdksyVnc3cm1C?=
 =?utf-8?B?ajcyMklJTkEyRUJ3M3NEdU1TU1Y5NkpvZnBmVmI3dnBPUG9uK0MxajBmNGxt?=
 =?utf-8?B?SVVkTlpma3RacUNXejMzVWFHZnQ5bzlSQ0xhdW1PMFJOT2VsMmg1MEpCRjBn?=
 =?utf-8?B?ckR6VkVpMGtKamFUZjFRVXJ6UTZDc21OTnpjMHdCdU1ibkNHRUpNZWpuZXV5?=
 =?utf-8?B?SFhjRzg1UHBJZitrUUdtaWZ1OHNuSHJRcHljcWN2bjJEcTRUcm52aVRsZk9J?=
 =?utf-8?B?ZXIyS0EwMVZKMHl3VVRIdG5mcTN0TjM3RHJBWXkybDNvdjQ4N1l5QXNpb2RT?=
 =?utf-8?B?WGt1Z1pkd3A5SkQrL1RXdEdYL3kzWGN1SXNwaGxlVjllb3RaWmQzRHRtTmx2?=
 =?utf-8?B?TnVDUjBCTEZHWnNzakJzR1NpTXhlaGE5by9OUHBML0pIWjQzejdzNjg0c2NX?=
 =?utf-8?B?UVo5N3VaeWpab2wwMGJjQU1Oa1Z1cTkvbnpnTUJwNHBEbXp2Rjdyd2NqcjBP?=
 =?utf-8?Q?KkDxsMMYDgy8kYh1aV4Y/FfSZZxN51N+GOoKrby?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab82c7ee-e5e8-4262-f0f8-08d987aec65e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 03:18:17.5330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2a6J9S8N2rkMcPdB4KQe4rLOGH4pRdo5c2ZFSO3OzN8DL7SjNjG9exlLCGkB4kbKNc8HymyJhxtM/acFCez7cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4093
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050016
X-Proofpoint-GUID: bUS8CnlG1a6oi_BJbxiacahORiEx7A51
X-Proofpoint-ORIG-GUID: bUS8CnlG1a6oi_BJbxiacahORiEx7A51
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 05/10/2021 01:19, Josef Bacik wrote:
> There's a subtle case where if we're removing the seed device from a
> file system we need to free its private copy of the fs_devices.  However
> we do not need to call close_fs_devices(), because at this point there
> are no devices left to close as we've closed the last one.  The only
> thing that close_fs_devices() does is decrement ->opened, which should
> be 1.  We want to avoid calling close_fs_devices() here because it has a
> lockdep_assert_held(&uuid_mutex), and we are going to stop holding the
> uuid_mutex in this path.
> 
> So simply decrement the  ->opened counter like we should, and then clean
> up like normal.  Also add a comment explaining what we're doing here as
> I initially removed this code erroneously.
> 

David,

  You might want to add this patch before commit e197aab25da2 (btrfs: do 
not take the uuid_mutex in btrfs_rm_device) in the misc-next. As this 
patch is preparatory of it.

> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

  Reviewed-by: Anand Jain <anand.jain@oralce.com>

Thx, Anand

> ---
>   fs/btrfs/volumes.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 0941f61d8071..5f19d0863094 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2211,9 +2211,16 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
>   	synchronize_rcu();
>   	btrfs_free_device(device);
>   
> +	/*
> +	 * This can happen if cur_devices is the private seed devices list.  We
> +	 * cannot call close_fs_devices() here because it expects the uuid_mutex
> +	 * to be held, but in fact we don't need that for the private
> +	 * seed_devices, we can simply decrement cur_devices->opened and then
> +	 * remove it from our list and free the fs_devices.
> +	 */
>   	if (cur_devices->num_devices == 0) {
>   		list_del_init(&cur_devices->seed_list);
> -		close_fs_devices(cur_devices);
> +		cur_devices->opened--;
>   		free_fs_devices(cur_devices);
>   	}
>   
> 

