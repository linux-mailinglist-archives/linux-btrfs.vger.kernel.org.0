Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82A47606A7
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jul 2023 05:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjGYD2t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 23:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjGYD2i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 23:28:38 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40F61735
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 20:28:10 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-66d6a9851f3so1183689b3a.0
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 20:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690255690; x=1690860490;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6wY4cILkEhsrpRf+mNddP0nleKOSU9sayj8Z5h0ToXM=;
        b=PknHptOa2Z8+2vaclzexjcjHcgGTKnQ0JRJ89LK+GvkJZyUzNmFYDaw4LaxhrbAB97
         Qlt49eA21cgLfip1YkLzQvNHl9NRE1uu+H3yLMzr5GUQw2R94ASja3LKRc7K2/IuJ877
         /rUQws3HOX4h/pSV0QLIC/txctttQBZDy4goWlpNGxYwzk8J6CttdGDNpskz9IiWFE6E
         W06R7YBvAlwN2Ll/k0WZ+e8J2UJKgy2rlagtK3lUaqPgpyCrwLsDTNoP/0MXBrAUaLK4
         fe8VXE6m3BmotnBeZ7KmASyzpGnPX5FsNzpJdMUNn5TjD0dfcmx5lygJuqraNOT+sjor
         yB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690255690; x=1690860490;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wY4cILkEhsrpRf+mNddP0nleKOSU9sayj8Z5h0ToXM=;
        b=FsBSG8JVnD0OmPZYdk1ZOd9+itU85mau+u9woUkj7CUgGQo3SKTot8VCEJAkuyZRD2
         XxTKplqDLkIoV4eUjDv1cL2g07XlR0Aj2c7yEFH+IF0rBPvsheq3xeyjRAIlK0LzmCU2
         wKcsbLsN+NEfLrWKqPGhPGfo/rACpthnqNJ9IVneA6/z7vLtbpgT/k9KYPlJ8UTsLvxB
         5emFX+bwGKKM14alpHGiigu71KELfNnQw0kfpIUR37V6BnjkoITr8ySudTPjOdbIFrE1
         Zx90xUaCoqNrdqUcVgPI1fyBjfIFB1l0o0EeruPlsLqyLZxJt+8+4VtQPBmgadRl/w4P
         ubAg==
X-Gm-Message-State: ABy/qLZQruil9XEsuB8M1s15Vjoj7ZOTEGsxorPFNowIfaNf7b6POAt1
        k56TR9j6YG86i8WGKTuSCoEphg==
X-Google-Smtp-Source: APBJJlHvnzRChS6v/nee9rDGEWxm9C29UVXVwYKOSH3HP5ue/guAsHAKmcdiSeukVqd30tCkGAz2cw==
X-Received: by 2002:a05:6a00:cd1:b0:677:bb4c:c321 with SMTP id b17-20020a056a000cd100b00677bb4cc321mr15272930pfv.0.1690255690395;
        Mon, 24 Jul 2023 20:28:10 -0700 (PDT)
Received: from ?IPV6:fdbd:ff1:ce00:1c25:884:3ed:e1db:b610? ([240e:694:e21:b::2])
        by smtp.gmail.com with ESMTPSA id s3-20020aa78283000000b00682a9325ffcsm8407714pfm.5.2023.07.24.20.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 20:28:10 -0700 (PDT)
Message-ID: <bbd36d96-b6b8-08c3-1092-e3d0b255134a@bytedance.com>
Date:   Tue, 25 Jul 2023 11:27:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 01/47] mm: vmscan: move shrinker-related code into a
 separate file
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, david@fromorbit.com,
        tkhai@ya.ru, Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, djwong@kernel.org,
        Christian Brauner <brauner@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        yujie.liu@intel.com, Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        x86@kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-2-zhengqi.arch@bytedance.com>
 <97E80C37-8872-4C5A-A027-A0B35F39152A@linux.dev>
 <d2621ad0-8b99-9154-5ff5-509dec2f32a3@bytedance.com>
 <6FE62F56-1B4E-4E2A-BEA9-0DA6907A2FA9@linux.dev>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <6FE62F56-1B4E-4E2A-BEA9-0DA6907A2FA9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/25 11:23, Muchun Song wrote:
> 
> 
>> On Jul 25, 2023, at 11:09, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>
>>
>>
>> On 2023/7/25 10:35, Muchun Song wrote:
>>>> On Jul 24, 2023, at 17:43, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>>>
>>>> The mm/vmscan.c file is too large, so separate the shrinker-related
>>>> code from it into a separate file. No functional changes.
>>>>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>> ---
>>>> include/linux/shrinker.h |   3 +
>>>> mm/Makefile              |   4 +-
>>>> mm/shrinker.c            | 707 +++++++++++++++++++++++++++++++++++++++
>>>> mm/vmscan.c              | 701 --------------------------------------
>>>> 4 files changed, 712 insertions(+), 703 deletions(-)
>>>> create mode 100644 mm/shrinker.c
>>>>
>>>> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
>>>> index 224293b2dd06..961cb84e51f5 100644
>>>> --- a/include/linux/shrinker.h
>>>> +++ b/include/linux/shrinker.h
>>>> @@ -96,6 +96,9 @@ struct shrinker {
>>>>   */
>>>> #define SHRINKER_NONSLAB (1 << 3)
>>>>
>>>> +unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
>>>> +    int priority);
>>> A good cleanup, vmscan.c is so huge.
>>> I'd like to introduce a new header in mm/ directory and contains those
>>> declarations of functions (like this and other debug function in
>>> shrinker_debug.c) since they are used internally across mm.
>>
>> How about putting them in the mm/internal.h file?
> 
> Either is fine to me.

OK, will do in the next version.

> 
>>
>>> Thanks.
> 
> 
