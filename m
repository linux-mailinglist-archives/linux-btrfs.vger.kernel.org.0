Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658162158CA
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 15:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgGFNql convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 6 Jul 2020 09:46:41 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:39942 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729133AbgGFNqk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jul 2020 09:46:40 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2057.outbound.protection.outlook.com [104.47.12.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-10-QWjyctGaNYeYn4eRZiEXww-1; Mon, 06 Jul 2020 15:46:33 +0200
X-MC-Unique: QWjyctGaNYeYn4eRZiEXww-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/GoKDmClxhRFp5oDr8ZHkf+H5Tx2mGCgVywBKGW9vCcEeQCqYg9zAHU61ttGhJzYhLrxTleFxJnHUxUvE5Up+aNh4UGdPJ9DbyRhqKdTOSpT/0g2FGpqhhpTbrTRybwYEvUQ8aC6A4XMJpxKa0J2Vl453Cl/pA8SlWRw4JSKBimGy+BNUF7Jf4H2LQeu3scSwL4zct7EWIFuLaIkd755hSlfLUnTJxmNsfpF1d/yqgZgmFbFETzEB+S3e5newOlNZVMAp4v5hGLEDyqBGXUpX3lgYRa06ICdBQOnlSMjcyWyic2mUe2rSQBnIRfz4RFwqaM+HaM6xOQC/TjvUtZ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MZbudSAMPTnpXWnQ7Fc1CLXOWkYeEHqWl0ORMXXkQQ=;
 b=fhWdLbKdRJ+Q5ZZ5433amHkTNK226rkrXTUTpvvtH3FmEWsASuXQ86FRS/gkq9t+aTRTwyXSinsPztb0WJm2KbdJHoWgdcDC99QinTUZ5rVce5+VTatoOXzVCdgyEN8iGAsFLzWs6JiTHObxoODE6mpy2eFGgf+MtQlZsDRGzrQTChHTqAzYXf+89P+ZAEc0+iAGHN3QtXt1uEWpeGWBhlNp1vKlSLJFhCCjZIrzTEQUwdJX0/oLESazHjtETfl6MNROfrRbCt174jnvCClxxE2+P5lFcPhbtBsbHsPiSe2yEeiGR7Nkvl4zGi34EqNDSqPXw5hIk7jx+Tdrori6Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB5940.eurprd04.prod.outlook.com (2603:10a6:208:117::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Mon, 6 Jul
 2020 13:46:32 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::688e:afdb:90d9:bdef]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::688e:afdb:90d9:bdef%3]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 13:46:32 +0000
Subject: Re: [PATCH v2 2/3] btrfs: qgroup: Try to flush qgroup space when we
 get -EDQUOT
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20200703061902.33350-1-wqu@suse.com>
 <20200703061902.33350-3-wqu@suse.com>
 <3248eb25-5558-f5be-e15b-a16d39dd0cb1@toxicpanda.com>
From:   Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0GFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPokBTQQTAQgAOAIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJdnDWhAAoJEMI9kfOhJf6oZgoH
 90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tEdVPaKlcnTNAvZKWSit8VuocjrOFbTLwb
 vZ43n5f/l/1QtwMgQei/RMY2XhW+totimzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9N
 vZAAYVV7GesyyFpZiNm7GLvLmtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7
 J9pFgBrCn4hF83tPH2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/k
 F2oxqZBEQrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx7kBDQRZ1YGvAQgAqlPr
 YeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4KXk/kHw5h
 ieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T7RZwB69u
 VSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9fNN8e9c0
 MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/
 o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgBCAAmAhsM
 FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cNa4FCQlqTn8ACgkQwj2R86El/qhXBAf/eXLP
 HDNTkHRPxoDnwhscIHJDHlsszke25AFltJQ1adoaYCbsQVv4Mn5rQZ1Gon54IMdxBN3r/B08
 rGVPatIfkycMCShr+rFHPKnExhQ7Wr555fq+sQ1GOwOhr1xLEqAhBMp28u9m8hnkqL36v+AF
 hjTwRtS+tRMZfoG6n72xAj984l56G9NPfs/SOKl6HR0mCDXwJGZAOdtyRmqddi53SXi5N4H1
 jWX1xFshp7nIkRm6hEpISEWr/KKLbAiKKbP0ql5tP5PinJeIBlDv4g/0+aGoGg4dELTnfEVk
 jMC8cJ/LiIaR/OEOF9S2nSeTQoBmusTz+aqkbogvvYGam6uDYw==
Message-ID: <283f9203-e8f8-1f97-1c99-a746d308cacc@suse.com>
Date:   Mon, 6 Jul 2020 21:46:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <3248eb25-5558-f5be-e15b-a16d39dd0cb1@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BY3PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:254::14) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY3PR05CA0009.namprd05.prod.outlook.com (2603:10b6:a03:254::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.8 via Frontend Transport; Mon, 6 Jul 2020 13:46:30 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b24628b1-1301-48da-2f64-08d821b2fdce
X-MS-TrafficTypeDiagnostic: AM0PR04MB5940:
X-Microsoft-Antispam-PRVS: <AM0PR04MB594024EF9C80483CC295D081D6690@AM0PR04MB5940.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Fa+2A6nQKsATl5ht7PfM6WY7nYLdvLsOZQkF+W1uivNvHCVcyYL5upIh3gVyeTVS99/N5OLwcWraTd+w8VqnpVU4bvNDmOzc2PQuGMQWsbXHW+pDh5K1AcN/2Uo6AbUm3laPoWhId/jbcVCUWbErUpVmNVri/Zw388w+FnPAcuiZ7R/8k+qgEoiYs/9rU7OB5ijg8qLaPQG9sc/GPqD5Gvem8pmmeGjUgDUGOzKFaSr0Px67rdhDvRmXmKOgu0/hK4HM0S2Pqr2WePv3fapXBv/WQHXrQJgOJos6dWE1x+uANYidXMFRYqcX4+68dUy2wHSoqXvlhDIyGp25ppoPZsyrG+nPqNYyUzILhhh2Ts8BrZ8Kw8d9g8Kd3uCc7ozuAs/hDR3T4kRf0v+0TPU4arD5aIMo7vCJzYjsz7/SwfHaDsuRcyVumJ4dgyVqAnW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(346002)(136003)(366004)(396003)(6706004)(956004)(2616005)(16576012)(16526019)(186003)(5660300002)(66476007)(316002)(8936002)(86362001)(66556008)(26005)(4001150100001)(6666004)(2906002)(8676002)(31696002)(66946007)(6486002)(36756003)(31686004)(478600001)(53546011)(52116002)(83380400001)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: a2Lq1B3EEup7Lttn/eJ+Ao9S+4mU9wHr04WkD0TJR69jdx8e2hZAZOuIGdaqRQnKvD+O6X7FxFCXjjq8tkgXaS2161x0LQXWUHeLJyexfChO5W8bmeBGu77emwdKYwj8phFLT1uMzIXxl5XLHHpvZ3WZh+dtmr2HAClvBF3IDOIZJggbZDJM6TZTFOBAcO9vf0gBYyja8ZRXbZydAPgUY1pDwXDirEi7nX0XleE4eP1ZOUVqQPeOq96DWmlnV57J8oRHLEUZmtrd5BDrahW4tk2sgUsgsW81+Z+wsWww8Io6YsmRly1xB6Fag6FX+KdnjcBU0+ypZ3jZZ/Ka7a73jONGDMpZekCREfwzOt/GTJWcd1qQmPgBiR7+mUFubvfomyCHFNuwlXhAUdDWIoiteocABkz4GMdgQIpM19v0D9MzcdZXV430uVFMzL39RmxWCMBOKdr29YeLIW5uMbEugt/rlgh5Rv/PNGbMV9iG2c8=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b24628b1-1301-48da-2f64-08d821b2fdce
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 13:46:32.1407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/HHZbIEDWlqqc8YOJN2+yi1vk47oIPsI57PHaZpJGTx2CwVYEaY21g4yTLOB4/Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5940
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/7/6 下午9:41, Josef Bacik wrote:
> On 7/3/20 2:19 AM, Qu Wenruo wrote:
>> [PROBLEM]
>> There are known problem related to how btrfs handles qgroup reserved
>> space.
>> One of the most obvious case is the the test case btrfs/153, which do
>> fallocate, then write into the preallocated range.
>>
>>    btrfs/153 1s ... - output mismatch (see
>> xfstests-dev/results//btrfs/153.out.bad)
>>        --- tests/btrfs/153.out     2019-10-22 15:18:14.068965341 +0800
>>        +++ xfstests-dev/results//btrfs/153.out.bad      2020-07-01
>> 20:24:40.730000089 +0800
>>        @@ -1,2 +1,5 @@
>>         QA output created by 153
>>        +pwrite: Disk quota exceeded
>>        +/mnt/scratch/testfile2: Disk quota exceeded
>>        +/mnt/scratch/testfile2: Disk quota exceeded
>>         Silence is golden
>>        ...
>>        (Run 'diff -u xfstests-dev/tests/btrfs/153.out
>> xfstests-dev/results//btrfs/153.out.bad'  to see the entire diff)
>>
>> [CAUSE]
>> Since commit c6887cd11149 ("Btrfs: don't do nocow check unless we have
>> to"),
>> we always reserve space no matter if it's COW or not.
>>
>> Such behavior change is mostly for performance, and reverting it is not
>> a good idea anyway.
>>
>> For preallcoated extent, we reserve qgroup data space for it already,
>> and since we also reserve data space for qgroup at buffered write time,
>> it needs twice the space for us to write into preallocated space.
>>
>> This leads to the -EDQUOT in buffered write routine.
>>
>> And we can't follow the same solution, unlike data/meta space check,
>> qgroup reserved space is shared between data/meta.
>> The EDQUOT can happen at the metadata reservation, so doing NODATACOW
>> check after qgroup reservation failure is not a solution.
>>
>> [FIX]
>> To solve the problem, we don't return -EDQUOT directly, but every time
>> we got a -EDQUOT, we try to flush qgroup space by:
>> - Flush all inodes of the root
>>    NODATACOW writes will free the qgroup reserved at run_dealloc_range().
>>    However we don't have the infrastructure to only flush NODATACOW
>>    inodes, here we flush all inodes anyway.
>>
>> - Wait ordered extents
>>    This would convert the preallocated metadata space into per-trans
>>    metadata, which can be freed in later transaction commit.
>>
>> - Commit transaction
>>    This will free all per-trans metadata space.
>>
>> Also we don't want to trigger flush too racy, so here we introduce a
>> per-root mutex to ensure if there is a running qgroup flushing, we wait
>> for it to end and don't start re-flush.
>>
>> Fixes: c6887cd11149 ("Btrfs: don't do nocow check unless we have to")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/ctree.h   |   1 +
>>   fs/btrfs/disk-io.c |   1 +
>>   fs/btrfs/qgroup.c  | 118 ++++++++++++++++++++++++++++++++++++++++-----
>>   3 files changed, 108 insertions(+), 12 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index 4dd478b4fe3a..891f47c7891f 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -1162,6 +1162,7 @@ struct btrfs_root {
>>       spinlock_t qgroup_meta_rsv_lock;
>>       u64 qgroup_meta_rsv_pertrans;
>>       u64 qgroup_meta_rsv_prealloc;
>> +    struct mutex qgroup_flushing_mutex;
>>         /* Number of active swapfiles */
>>       atomic_t nr_swapfiles;
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index c27022f13150..0116e0b487c9 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -1116,6 +1116,7 @@ static void __setup_root(struct btrfs_root
>> *root, struct btrfs_fs_info *fs_info,
>>       mutex_init(&root->log_mutex);
>>       mutex_init(&root->ordered_extent_mutex);
>>       mutex_init(&root->delalloc_mutex);
>> +    mutex_init(&root->qgroup_flushing_mutex);
>>       init_waitqueue_head(&root->log_writer_wait);
>>       init_waitqueue_head(&root->log_commit_wait[0]);
>>       init_waitqueue_head(&root->log_commit_wait[1]);
>> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
>> index 398de1145d2b..bf9076bc33eb 100644
>> --- a/fs/btrfs/qgroup.c
>> +++ b/fs/btrfs/qgroup.c
>> @@ -3481,13 +3481,14 @@ static int qgroup_revert(struct btrfs_inode
>> *inode,
>>           int clear_ret;
>>             entry = rb_entry(n, struct ulist_node, rb_node);
>> -        if (entry->val >= start + len)
>> -            break;
>> -        if (entry->val + entry->aux <= start)
>> -            goto next;
>>           start = entry->val;
>>           end = entry->aux;
>>           len = end - start + 1;
>> +
>> +        if (start >= start + len)
>> +            break;
>> +        if (start + len <= start)
>> +            goto next;
> 
> This is unrelated to the change at hand, put this in the 1st patch.
> 
>>           /*
>>            * Now the entry is in [start, start + len), revert the
>>            * EXTENT_QGROUP_RESERVED bit.
>> @@ -3512,17 +3513,62 @@ static int qgroup_revert(struct btrfs_inode
>> *inode,
>>   }
>>     /*
>> - * Reserve qgroup space for range [start, start + len).
>> + * Try to free some space for qgroup.
>>    *
>> - * This function will either reserve space from related qgroups or doing
>> - * nothing if the range is already reserved.
>> + * For qgroup, there are only 3 ways to free qgroup space:
>> + * - Flush nodatacow write
>> + *   Any nodatacow write will free its reserved data space at
>> + *   run_delalloc_range().
>> + *   In theory, we should only flush nodatacow inodes, but it's
>> + *   not yet possible, so we need to flush the whole root.
>>    *
>> - * Return 0 for successful reserve
>> - * Return <0 for error (including -EQUOT)
>> + * - Wait for ordered extents
>> + *   When ordered extents are finished, their reserved metadata
>> + *   is finally converted to per_trans status, which can be freed
>> + *   by later commit transaction.
>>    *
>> - * NOTE: this function may sleep for memory allocation.
>> + * - Commit transaction
>> + *   This would free the meta_per_trans space.
>> + *   In theory this shouldn't provide much space, but any more qgroup
>> space
>> + *   is needed.
>>    */
>> -int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
>> +static int try_flush_qgroup(struct btrfs_root *root)
>> +{
>> +    struct btrfs_trans_handle *trans;
>> +    int ret;
>> +
>> +    if (!is_fstree(root->root_key.objectid))
>> +        return 0;
>> +
> 
> This will just retry the reservation again without having done
> anything.  Is it even possible to end up here with a !fs_tree?

You're right, it's impossible.

The existing btrfs_qgroup_reserve_data() has extra check for root
objectid, and just return 0 for non fs trees.
So it's impossible to hit the !is_fstree() branch.

>  If it is
> then maybe we should return -EDQUOT here so we don't retry the
> reservation again.
> 
>> +    /*
>> +     * We don't want to run flush again and again, so if there is a
>> running
>> +     * one, we won't try to start a new flush, but exit directly.
>> +     */
>> +    ret = mutex_trylock(&root->qgroup_flushing_mutex);
>> +    if (!ret) {
>> +        mutex_lock(&root->qgroup_flushing_mutex);
>> +        mutex_unlock(&root->qgroup_flushing_mutex);
>> +        return 0;
>> +    }
>> +
>> +    ret = btrfs_start_delalloc_snapshot(root);
>> +    if (ret < 0)
>> +        goto unlock;
>> +    btrfs_wait_ordered_extents(root, U64_MAX, 0, (u64)-1);
>> +
>> +    trans = btrfs_join_transaction(root);
>> +    if (IS_ERR(trans)) {
>> +        ret = PTR_ERR(trans);
>> +        goto unlock;
>> +    }
>> +
>> +    ret = btrfs_commit_transaction(trans);
>> +unlock:
>> +    mutex_unlock(&root->qgroup_flushing_mutex);
>> +    return ret;
>> +}
> 
> I still hate this but implementing tickets for quotas probably doesn't
> make sense right now.

Yep. But I'm pretty open to integrating this into the tickets system.

Thanks,
Qu
> 
> <snip>
> 
>> +
>> +    ret = qgroup_reserve_meta(root, num_bytes, type, enforce);
>> +    if (!ret)
>> +        return ret;
>> +    if (ret < 0 && ret != -EDQUOT)
>> +        return ret;
> 
> if (ret <= 0 && ret != -EDQUOT)
>     return ret;
> 
> Thanks,
> 
> Josef
> 

