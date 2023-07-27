Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A3C76514A
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jul 2023 12:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbjG0KdT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 06:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbjG0Kcw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 06:32:52 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9CE19A4
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 03:32:27 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2659b1113c2so160337a91.1
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 03:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690453945; x=1691058745;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4VsKgOIlO7JTMbURB3u+V7Qr/QzOpc+0Bt56AjhAYAM=;
        b=Zr/NhsMbDbdIdSqoueTQTw00LusmUmyLrdR7MeDx+ZO5Q+75jdmzv373GL0Ee5CtKr
         W6fluKiuFJCg5ZU3kW0Km101UvphMU1vBCY7hDEO6TFqab4XzqrIV8fVDPR2Owpqim7U
         N3OX4eAxVQVjc5z6Zvv7YweV9TAIgzv2mVUZoaytYD45Z4tHHiC7Kn023GaYmi5v6RKy
         g9n+r/2KPb5qfD2ZK/MDUQIwCLsfUVl7c4q/2XRu1uefpNinWMEwlZLohyik+zojbFUF
         urJtl81vW3ulTBjRT5ht+WLfC03kh8PaMNuzZ2kESl6uu5dT49u0KrVoAN4kKuQ8SPSD
         k2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690453945; x=1691058745;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4VsKgOIlO7JTMbURB3u+V7Qr/QzOpc+0Bt56AjhAYAM=;
        b=IKJQeFYSoTT/fBKkDn4Yb6S9cpFiIPM5HHtseyzy4E0kB1PyEk4iyZJXsTJTvs2kma
         WKXY/QSeaCRLCxz3VHC/083ohq6vnACYSJcbonOiECV8XxOh+0M/0n/o0CwhbFvmBJeQ
         gCh7BqiCJS1TDaTk+SzPXBK0Cd7LFP+P6DIu2Ggz7u8aiccDuOOiHoOTvNdXw67CtgJH
         Bs8/OWRqepOT+UtRRVUcDHVyJ6Ej99785efJfrfTPnjPwttqmEGAyBpGHN7ECrULXjT9
         iBGOwBKaJkvU+CkUDtBahYvAiEkMyB/NCldVL+FyPJ2cobBakaMuDOdYL5WRS8krBGAW
         q6MQ==
X-Gm-Message-State: ABy/qLY76i3IBLN15QY6x9X0a+Cc3C02ZVI/1DV5oYNAR4dJfWurv4z1
        FH7sCLYnAwCddLBlt4dOmk2HOw==
X-Google-Smtp-Source: APBJJlGmzPZn88CMJAqpsojyTb97uikW28yo5O3pi8rH8SDlSH8BwjASuoOudfeGFyxgCSRxAf0mLA==
X-Received: by 2002:a17:90a:1b06:b0:263:2312:60c2 with SMTP id q6-20020a17090a1b0600b00263231260c2mr4299433pjq.3.1690453945653;
        Thu, 27 Jul 2023 03:32:25 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a018800b0026309d57724sm2755058pjc.39.2023.07.27.03.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 03:32:25 -0700 (PDT)
Message-ID: <cc819e13-cb25-ddaa-e0e3-7328f5ea3a4f@bytedance.com>
Date:   Thu, 27 Jul 2023 18:32:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 28/49] dm zoned: dynamically allocate the dm-zoned-meta
 shrinker
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>
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
        Muchun Song <songmuchun@bytedance.com>,
        akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
 <20230727080502.77895-29-zhengqi.arch@bytedance.com>
 <baaf7de4-9a0e-b953-2b6a-46e60c415614@kernel.org>
 <56ee1d92-28ee-81cb-9c41-6ca7ea6556b0@bytedance.com>
 <ba0868b2-9f90-3d81-1c91-8810057fb3ce@kernel.org>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <ba0868b2-9f90-3d81-1c91-8810057fb3ce@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/27 18:20, Damien Le Moal wrote:
> On 7/27/23 17:55, Qi Zheng wrote:
>>>>            goto err;
>>>>        }
>>>>    +    zmd->mblk_shrinker->count_objects = dmz_mblock_shrinker_count;
>>>> +    zmd->mblk_shrinker->scan_objects = dmz_mblock_shrinker_scan;
>>>> +    zmd->mblk_shrinker->seeks = DEFAULT_SEEKS;
>>>> +    zmd->mblk_shrinker->private_data = zmd;
>>>> +
>>>> +    shrinker_register(zmd->mblk_shrinker);
>>>
>>> I fail to see how this new shrinker API is better... Why isn't there a
>>> shrinker_alloc_and_register() function ? That would avoid adding all this code
>>> all over the place as the new API call would be very similar to the current
>>> shrinker_register() call with static allocation.
>>
>> In some registration scenarios, memory needs to be allocated in advance.
>> So we continue to use the previous prealloc/register_prepared()
>> algorithm. The shrinker_alloc_and_register() is just a helper function
>> that combines the two, and this increases the number of APIs that
>> shrinker exposes to the outside, so I choose not to add this helper.
> 
> And that results in more code in many places instead of less code + a simple
> inline helper in the shrinker header file... So not adding that super simple

It also needs to be exported to the driver for use.

> helper is not exactly the best choice in my opinion.

Hm, either one is fine for me. If no one else objects, I can add this
helper. ;)

> 
