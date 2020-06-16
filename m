Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476891FC1E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 00:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgFPWzS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 18:55:18 -0400
Received: from mail-db8eur05on2060.outbound.protection.outlook.com ([40.107.20.60]:6126
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725901AbgFPWzS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 18:55:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQfv28jJW51KmL4vjH/bdb06VXpg2CkMnM0iz6nl8UhTRVpaKpWBxaoIF/UQV6YzAjz9V6sO42DVcs5zzG7gEs+szaBqx9Pf1c8O9Nfw27CZyNYKmBBDE6Quk2wBeKfOW50xjX1wbVYvdcsAiz9Opx4yciq+K3WHuJDJLb2VEzvWi1+VCt7MHp7oLtRXdNQdHsBSlIq0itj63ptGmERTyC372reOBpMRRKCvGaZiActr/BfQMZcuTfyk/+5/psGp75BfLNpVL3g7EjKhdTqXSVAlm29kL+Ju/nVdD2w4WwY4TvaBlnCkRiEXekN3golc/Fc7fsTqukFpORLhjRvVMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsyNa2t/WzHCE69toHLg5YehjgXnFqbfFypt4jWPWhA=;
 b=mCHIECRdRcXenP0eERpE/piSpqE1/eWILyUZaVA1YEwjGCt1gGpuA7ymTFyRT6Uk96nn9VyM+w1dkonmRoyQ0ywyVopqUtjJxxCDgVAyskzLEYay20bM29+r6tXW8g6CNKFaZrM2Ibcy8LCHOjvvycRThIGLxi6I+lVf5EAxEbZw656v+9sPQDSCcoKfu5TyGmM3lUjg/cZO4FHpznZLu++Yz1hbWUhlAGbSofBQyJ8gZQj6tnVZCfjroe0LBu8wC+U/MPYFZGhJF33+cpgwhAPtPRTmjBZPVPMCfBXhLzaaNJg53Xbcq7rzPPhd/SkR4+aPtdqBXM1ksNuk+2fwfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mysuse.onmicrosoft.com; s=selector1-mysuse-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsyNa2t/WzHCE69toHLg5YehjgXnFqbfFypt4jWPWhA=;
 b=R7CN/dBgyK77D9wiaxMLYnSXhy54bsDwE5/1lI5Q6ri4wqzQ1niGtm/GgsXp2P2GT2H4fyXVm3ixfaJjZiBzaZQaMovxyQssIDNTnyjd2e2FwIbbZQZiEin8mEuvkfUdgLUgjqBD035c6FlRwYsnS28jPX1+2tAte53hCigsgjGdJHWV6nwpkCTBPgY9oJ62sAXtizuntiE2kiODT/WkpG6BINCoPtuku9B9XIzg71pnj2faqbP/YIt8PZzz6TjY08FZ45XUJTVCOAtQWthZqOQGsCYtzV09IcSZHj6hTBGYUqj4EXgBP5oRFSqkE8Yuc2a1pHaIc3V3ihXTIMiP/g==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB5906.eurprd04.prod.outlook.com (2603:10a6:208:130::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Tue, 16 Jun
 2020 22:55:14 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::3457:290d:6345:6961]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::3457:290d:6345:6961%7]) with mapi id 15.20.3088.028; Tue, 16 Jun 2020
 22:55:14 +0000
Subject: Re: [PATCH 3/4] btrfs: preallocate anon_dev for subvolume and
 snapshot creation
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Greed Rong <greedrong@gmail.com>
References: <20200616021737.44617-1-wqu@suse.com>
 <20200616021737.44617-4-wqu@suse.com> <20200616151004.GE27795@twin.jikos.cz>
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
Message-ID: <de0a6073-36e9-9b6a-18e2-21a4df793157@suse.com>
Date:   Wed, 17 Jun 2020 06:54:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200616151004.GE27795@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:74::32) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR05CA0055.namprd05.prod.outlook.com (2603:10b6:a03:74::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.9 via Frontend Transport; Tue, 16 Jun 2020 22:55:11 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48f19d03-6ec5-4693-b5b5-08d812485446
X-MS-TrafficTypeDiagnostic: AM0PR04MB5906:
X-Microsoft-Antispam-PRVS: <AM0PR04MB59065A0DA579CA6F2C4497DBD69D0@AM0PR04MB5906.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:466;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JdsHNn53IpxyCPWu9C9aGKLRWav+h+vkJgHd3wnt2lA5HnwGGOycKYuFf+KHDILLa+4kCGN48iJGxD6fZ/m3q8gDNpkN32YOij6JKAGfG0oTLZIROxTA5A2lkhJUT/QBY0hDXnFy0KrXm5BxPFMr33BRURVL3yE5ycJrwTkBAPyL/9AhHV1BRgQO0jssMULExvKmwQzs/ipsTIamfvJ6F8+GI+V/k1F32A3ANKopf3rISvK46NyBx7GX2wC0ImkSYEae3Z964j9LQmQLEZpFbiwjoyBQ8JsgLvnnnPR2SevUh+RsdNTICpJ95o5AkyAqd8K6rR42rLCkCZhdSqzJriybOlZGAQ2LsGeeV+HBMBtsjcva9rhy7kfzoQ2seFUDGemEBBsKFVO4DBN7FLSJWemm+kj5UmuRhZq+Bnik92Jj9EZKdKkZ0joy8LXzT0zBc6+2vcTqZNyq/AN6ex/2rKZn+jqwbLF4REG+kprGARf+Nnam1a8w+HTbHM9aHxoDBguKS7pgFtYD36oylfmvAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39860400002)(376002)(346002)(396003)(136003)(36756003)(83380400001)(186003)(16526019)(52116002)(508600001)(6916009)(26005)(86362001)(6486002)(31696002)(66556008)(66946007)(2906002)(66476007)(31686004)(316002)(8676002)(8936002)(16576012)(6706004)(5660300002)(966005)(2616005)(956004)(6666004)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Mh99bMcJFPRzANSJkXY+S2A0g6WMkZwx8+4vDQEkQDP85zQa5XuJsq/y+V3tj61NmmesoHOdgvuW6hUdS9CRHEsRPhSqzyIzplbS8sQK+m/Waa8V2c1DeUyVdv4e0asTqGizFzteeEgzyEpEqpkPAmdAqHKZ06LrRWc5GeEg6FHJgezjnv5oIb5iMPbBVs9Ski/272fKbh3+64X79srw9PYQcLYjHL03ZLUWs+dOwrg39imIjMKcgcdqwXx9VllpA30Fa+GrMmIjea8d0pZRqXPPEUA/2ICgyN94cVw34Cf1Rdiw85WsrFUbYjfzisPuu9VBRbEtmChSJ2UJ9Zp/QFH0ozPf5cPbGklg4weQEnJsK7n1pqAY9IEfydswxQ4I+LedGFNru/NnL2+0cRBYlx7qqTYrevVrRbOXQlx1fgg=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f19d03-6ec5-4693-b5b5-08d812485446
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 22:55:14.1596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HApB71mBI83HcreE0Rjr6j1DgoH6P4TNHjldmWMsJiANUIiTTUcDSBWMaMRVC5DI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5906
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/6/16 下午11:10, David Sterba wrote:
> On Tue, Jun 16, 2020 at 10:17:36AM +0800, Qu Wenruo wrote:
>> [BUG]
>> When a lot of subvolumes are created, there is a user report about
>> transaction aborted:
>>
>>   ------------[ cut here ]------------
>>   BTRFS: Transaction aborted (error -24)
>>   WARNING: CPU: 17 PID: 17041 at fs/btrfs/transaction.c:1576 create_pending_snapshot+0xbc4/0xd10 [btrfs]
>>   RIP: 0010:create_pending_snapshot+0xbc4/0xd10 [btrfs]
>>   Call Trace:
>>    create_pending_snapshots+0x82/0xa0 [btrfs]
>>    btrfs_commit_transaction+0x275/0x8c0 [btrfs]
>>    btrfs_mksubvol+0x4b9/0x500 [btrfs]
>>    btrfs_ioctl_snap_create_transid+0x174/0x180 [btrfs]
>>    btrfs_ioctl_snap_create_v2+0x11c/0x180 [btrfs]
>>    btrfs_ioctl+0x11a4/0x2da0 [btrfs]
>>    do_vfs_ioctl+0xa9/0x640
>>    ksys_ioctl+0x67/0x90
>>    __x64_sys_ioctl+0x1a/0x20
>>    do_syscall_64+0x5a/0x110
>>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>   ---[ end trace 33f2f83f3d5250e9 ]---
>>   BTRFS: error (device sda1) in create_pending_snapshot:1576: errno=-24 unknown
>>   BTRFS info (device sda1): forced readonly
>>   BTRFS warning (device sda1): Skipping commit of aborted transaction.
>>   BTRFS: error (device sda1) in cleanup_transaction:1831: errno=-24 unknown
>>
>> [CAUSE]
>> When the global anonymous block device pool is exhausted, the following
>> call chain will fail, and lead to transaction abort:
>>
>>  btrfs_ioctl_snap_create_v2()
>>  |- btrfs_ioctl_snap_create_transid()
>>     |- btrfs_mksubvol()
>>        |- btrfs_commit_transaction()
>>           |- create_pending_snapshot()
>>              |- btrfs_get_fs_root()
>>                 |- btrfs_init_fs_root()
>>                    |- get_anon_bdev()
>>
>> [FIX]
>> Although we can't enlarge the anonymous block device pool, at least we
>> can preallocate anon_dev for subvolume/snapshot creation.
>> So that when the pool is exhausted, user will get an error other than
>> aborting transaction later.
>>
>> Reported-by: Greed Rong <greedrong@gmail.com>
>> Link: https://lore.kernel.org/linux-btrfs/CA+UqX+NTrZ6boGnWHhSeZmEY5J76CTqmYjO2S+=tHJX7nb9DPw@mail.gmail.com/
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/disk-io.c     | 51 ++++++++++++++++++++++++++++++++++++------
>>  fs/btrfs/disk-io.h     |  2 ++
>>  fs/btrfs/ioctl.c       | 21 ++++++++++++++++-
>>  fs/btrfs/transaction.c |  3 ++-
>>  fs/btrfs/transaction.h |  2 ++
>>  5 files changed, 70 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index cfc0ff288238..14fd69b71cb8 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -1395,7 +1395,7 @@ struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
>>  	goto out;
>>  }
>>  
>> -static int btrfs_init_fs_root(struct btrfs_root *root)
>> +static int btrfs_init_fs_root(struct btrfs_root *root, dev_t anon_dev)
>>  {
>>  	int ret;
>>  	unsigned int nofs_flag;
>> @@ -1435,9 +1435,13 @@ static int btrfs_init_fs_root(struct btrfs_root *root)
>>  	 */
>>  	if (is_fstree(root->root_key.objectid) &&
>>  	    btrfs_root_refs(&root->root_item)) {
>> -		ret = get_anon_bdev(&root->anon_dev);
>> -		if (ret)
>> -			goto fail;
>> +		if (!anon_dev) {
>> +			ret = get_anon_bdev(&root->anon_dev);
>> +			if (ret)
>> +				goto fail;
>> +		} else {
>> +			root->anon_dev = anon_dev;
>> +		}
>>  	}
>>  
>>  	mutex_lock(&root->objectid_mutex);
>> @@ -1542,8 +1546,27 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
>>  }
>>  
>>  
>> -struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
>> -				     u64 objectid, bool check_ref)
>> +/*
>> + * Get a fs root.
>> + *
>> + * For essential trees like root/extent tree, we grab it from fs_info directly.
>> + * For subvolume trees, we check the cached fs roots first. If miss then
>> + * read it from disk and add it to cached fs roots.
>> + *
>> + * Caller should release the root by calling btrfs_put_root() after the usage.
>> + *
>> + * NOTE: Reloc and log trees can't be read by this function as they share the
>> + *	 same root objectid.
>> + *
>> + * @objectid:	Root (subvolume) id
>> + * @anon_dev:	Preallocated anonymous block device number for new roots.
>> + * 		Pass 0 for automatic allocation.
>> + * @check_ref:	Whether to check root refs. If true, return -ENOENT for orphan
>> + * 		roots.
>> + */
>> +static struct btrfs_root *__get_fs_root(struct btrfs_fs_info *fs_info,
>> +					u64 objectid, dev_t anon_dev,
>> +					bool check_ref)
> 
> 
>> +struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
>> +				     u64 objectid, bool check_ref)
>> +{
>> +	return __get_fs_root(fs_info, objectid, 0, check_ref);
>> +}
>> +
>> +struct btrfs_root *btrfs_get_new_fs_root(struct btrfs_fs_info *fs_info,
>> +					 u64 objectid, dev_t anon_dev)
>> +{
>> +	return __get_fs_root(fs_info, objectid, anon_dev, true);
>> +}
> 
> This does not look like a good API, we should keep btrfs_get_fs_root and
> add the anon_bdev initialization to the callers, there are only a few.
> 
OK, I'd go that direction.

Thanks,
Qu
