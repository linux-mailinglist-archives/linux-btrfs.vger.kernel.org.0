Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC527631D8
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 11:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjGZJY7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 05:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjGZJY2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 05:24:28 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B5E2119
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 02:22:15 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-66d6a9851f3so1487687b3a.0
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 02:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690363335; x=1690968135;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xHFf+qIXuXcHU2hnpeM9isQldhnSqSauyHf1oBu4R8I=;
        b=jAMndxc3vAfZ9MlugwiN2m1td4+ENgo1ZcEkULNu4w0l2e+7SjL15Aj8xsnH/hg6mq
         Yuh7Pj+WIpy+9FKbmqcmIZPowwXwCsZ/HE/uYPa/USpf5RWRvsmKXdX1EOhGqDHtCRhA
         5Tx4ycmmPjyUjagwQ6weN00EPkG2yYEGVkFAeT+5NL38WWOxpIAWxDe7x+TtdzGSmFXw
         AaN6OIhFdWcuFQV9AajQEHTHNR/HQhAWIjBkgsz+1GmBQBDd2nNKfKbDgsLcpETIdF18
         CdbQtqtDxhcETBnzscklNfC8QDSVXvKpexDlKf4G6IIrjU6vkXpbe5y1T2yEBA/OqHN2
         vBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690363335; x=1690968135;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHFf+qIXuXcHU2hnpeM9isQldhnSqSauyHf1oBu4R8I=;
        b=jqnKy7mQmUNmyQcuk6qH5FxnHvkGKvr8eYgAH1fxkHk4x07gccQ5MxFdN6DBdM1s2T
         FQIcodqPwAGmBU1pWbyKzF2lSqVW4Vc5ww2VQ3SPEi09YYrRKRQ9wbXgIjJDdWaOaW+F
         qY/7PB3TZKX/SV7DA4v0kWlnLJQLvhdTJMcmIS2olHZMEcNxkJCT9wZ2m3EHnd2te1K2
         ENSPO6hhlUfFTRqT286jUKMLzNj//D3nyxnc30EKzBOJbTvKMTTpMK7XImVkNxVIpiJg
         lfgnzwyeVgR4NPB/n0FGxPI5JneqUuJyJNj7MTpIKF9PfGi6R1WLuQsaWZKdEmaxg9na
         Tt6A==
X-Gm-Message-State: ABy/qLY6GWDE8xrFRrGVP6h19sC6SDf2Q37rdiURXhy6rKB0upp3yg4d
        FlcFVm6YzmCPDN03B3GQhCcSOg==
X-Google-Smtp-Source: APBJJlGzKLkoeooTK7rnc1fJ6mfD6dUCrzzNETRC7Ci4c1Yh8zXhisYlXfajH5gn3qqQbLizO8XVQA==
X-Received: by 2002:a05:6a20:729a:b0:100:b92b:e8be with SMTP id o26-20020a056a20729a00b00100b92be8bemr1779967pzk.2.1690363335131;
        Wed, 26 Jul 2023 02:22:15 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id k11-20020aa790cb000000b006827c26f147sm10955045pfk.138.2023.07.26.02.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 02:22:14 -0700 (PDT)
Message-ID: <d96777ce-be8a-1665-dd00-1e696e5575a8@bytedance.com>
Date:   Wed, 26 Jul 2023 17:22:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 11/47] gfs2: dynamically allocate the gfs2-qd shrinker
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-12-zhengqi.arch@bytedance.com>
 <e7204276-9de5-17eb-90ae-e51657d73ef4@linux.dev>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <e7204276-9de5-17eb-90ae-e51657d73ef4@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/26 14:49, Muchun Song wrote:
> 
> 
> On 2023/7/24 17:43, Qi Zheng wrote:
>> Use new APIs to dynamically allocate the gfs2-qd shrinker.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   fs/gfs2/main.c  |  6 +++---
>>   fs/gfs2/quota.c | 26 ++++++++++++++++++++------
>>   fs/gfs2/quota.h |  3 ++-
>>   3 files changed, 25 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/gfs2/main.c b/fs/gfs2/main.c
>> index afcb32854f14..e47b1cc79f59 100644
>> --- a/fs/gfs2/main.c
>> +++ b/fs/gfs2/main.c
>> @@ -147,7 +147,7 @@ static int __init init_gfs2_fs(void)
>>       if (!gfs2_trans_cachep)
>>           goto fail_cachep8;
>> -    error = register_shrinker(&gfs2_qd_shrinker, "gfs2-qd");
>> +    error = gfs2_qd_shrinker_init();
>>       if (error)
>>           goto fail_shrinker;
>> @@ -196,7 +196,7 @@ static int __init init_gfs2_fs(void)
>>   fail_wq2:
>>       destroy_workqueue(gfs_recovery_wq);
>>   fail_wq1:
>> -    unregister_shrinker(&gfs2_qd_shrinker);
>> +    gfs2_qd_shrinker_exit();
>>   fail_shrinker:
>>       kmem_cache_destroy(gfs2_trans_cachep);
>>   fail_cachep8:
>> @@ -229,7 +229,7 @@ static int __init init_gfs2_fs(void)
>>   static void __exit exit_gfs2_fs(void)
>>   {
>> -    unregister_shrinker(&gfs2_qd_shrinker);
>> +    gfs2_qd_shrinker_exit();
>>       gfs2_glock_exit();
>>       gfs2_unregister_debugfs();
>>       unregister_filesystem(&gfs2_fs_type);
>> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
>> index 704192b73605..bc9883cea847 100644
>> --- a/fs/gfs2/quota.c
>> +++ b/fs/gfs2/quota.c
>> @@ -186,13 +186,27 @@ static unsigned long gfs2_qd_shrink_count(struct 
>> shrinker *shrink,
>>       return vfs_pressure_ratio(list_lru_shrink_count(&gfs2_qd_lru, sc));
>>   }
>> -struct shrinker gfs2_qd_shrinker = {
>> -    .count_objects = gfs2_qd_shrink_count,
>> -    .scan_objects = gfs2_qd_shrink_scan,
>> -    .seeks = DEFAULT_SEEKS,
>> -    .flags = SHRINKER_NUMA_AWARE,
>> -};
>> +static struct shrinker *gfs2_qd_shrinker;
>> +
>> +int gfs2_qd_shrinker_init(void)
> 
> It's better to declare this as __init.

OK, Will do.

> 
>> +{
>> +    gfs2_qd_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE, "gfs2-qd");
>> +    if (!gfs2_qd_shrinker)
>> +        return -ENOMEM;
>> +
>> +    gfs2_qd_shrinker->count_objects = gfs2_qd_shrink_count;
>> +    gfs2_qd_shrinker->scan_objects = gfs2_qd_shrink_scan;
>> +    gfs2_qd_shrinker->seeks = DEFAULT_SEEKS;
>> +
>> +    shrinker_register(gfs2_qd_shrinker);
>> +    return 0;
>> +}
>> +
>> +void gfs2_qd_shrinker_exit(void)
>> +{
>> +    shrinker_unregister(gfs2_qd_shrinker);
>> +}
>>   static u64 qd2index(struct gfs2_quota_data *qd)
>>   {
>> diff --git a/fs/gfs2/quota.h b/fs/gfs2/quota.h
>> index 21ada332d555..f9cb863373f7 100644
>> --- a/fs/gfs2/quota.h
>> +++ b/fs/gfs2/quota.h
>> @@ -59,7 +59,8 @@ static inline int gfs2_quota_lock_check(struct 
>> gfs2_inode *ip,
>>   }
>>   extern const struct quotactl_ops gfs2_quotactl_ops;
>> -extern struct shrinker gfs2_qd_shrinker;
>> +int gfs2_qd_shrinker_init(void);
>> +void gfs2_qd_shrinker_exit(void);
>>   extern struct list_lru gfs2_qd_lru;
>>   extern void __init gfs2_quota_hash_init(void);
> 
