Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E094CB34D
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Mar 2022 01:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiCCA0v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 19:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiCCA0u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 19:26:50 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BA336332;
        Wed,  2 Mar 2022 16:26:01 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 19so1919510wmy.3;
        Wed, 02 Mar 2022 16:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=VxEI28Cr8e8ubiVWpGpP4SGRn6ThHLfZQxCY6FGiDCA=;
        b=EgEch7eZSVOT6K8hou9M6EVOgL7Rvbo46ANeV9zWqm1PBXqRZyYLQpDi/6/uWTFw0b
         iudUjyXDpmEopqP4RL/MRcFcjsVqAkqh9O8XwOndrScwp0hK5u2b0kPp7/2/Ta8FCD8r
         yPWtfeLCJYm0H9Y0FYCSRigPgVyP7k66yk65y9KXQ/us8OMiskpEdxf00zOXfi+y1Lw1
         Xu5zImxJGiBNvBmXw5lQKxQFGAuouoLLtZTtlJLwzAnnnUm3gJBkFmopl6db/7ISTiE7
         Zzdpnwm8uOhQIjcDGP6HrMZ5N6ENFF/Xx9p4JpI6GC7F/f7LE7W8YAgumv+JYWOGqsAW
         mkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VxEI28Cr8e8ubiVWpGpP4SGRn6ThHLfZQxCY6FGiDCA=;
        b=CCc/e72bE6m0zKHOvrrVILgluK70ZrG68SpOUsqG14q0LfxGguM5UFRYkxrae8WMbU
         Rp9RgjpkHlPpGeZ1sFm016v+VuGqixN1/ZGfLTVmNndHKu3tI8Jjl2fe6abOXcT7Uxob
         pE/fF5zDeOgtDd3IYgwDQRpeF3lMQN4DYBJLDb7C9/Y57tna57unH07ntL6TIUCjLGLo
         W6ul29b29rVAXDCobfFm4jn2av14j6ltncHHAQ4LiCGFKB5YxeFaeYQtjX6A7px4wcLq
         V021Jxt8MVOQWxlhZJTgVckLLBifKM4dQAtYSVzIAf8nkzNwPeb/3v0NHb0MT7MqKgug
         LgjA==
X-Gm-Message-State: AOAM532d/1QH/GZ+mYoyWqYeqXhwdGEPm2OUCsFI68OM76auzrcB8ZlS
        bOu+r1qxHpSy0JGs9FrfqGY=
X-Google-Smtp-Source: ABdhPJyadMyaUuqCozzi2dxx9A7gPkdq7R3q5AcQUuRl7z1gMCAaqQE4EiOebR4qQTSF7XSBZr5VDQ==
X-Received: by 2002:a05:600c:2994:b0:387:3615:7b3a with SMTP id r20-20020a05600c299400b0038736157b3amr1280473wmd.142.1646267159755;
        Wed, 02 Mar 2022 16:25:59 -0800 (PST)
Received: from ?IPV6:2a02:1811:cc83:eef0:7bf1:a0f8:a9aa:ac98? (ptr-dtfv0pmq82wc9dcpm6w.18120a2.ip6.access.telenet.be. [2a02:1811:cc83:eef0:7bf1:a0f8:a9aa:ac98])
        by smtp.gmail.com with ESMTPSA id j34-20020a05600c1c2200b00381672f89d1sm8749308wms.39.2022.03.02.16.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 16:25:59 -0800 (PST)
Message-ID: <5eb61b82-6ed2-9386-b288-f57369de5adb@gmail.com>
Date:   Thu, 3 Mar 2022 01:25:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] btrfs: add lockdep_assert_held to need_preemptive_reclaim
Content-Language: en-US
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20220228225215.16552-1-dossche.niels@gmail.com>
 <20220302193042.GV12643@twin.jikos.cz>
From:   Niels Dossche <dossche.niels@gmail.com>
In-Reply-To: <20220302193042.GV12643@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/03/2022 20:30, David Sterba wrote:
> On Mon, Feb 28, 2022 at 11:52:16PM +0100, Niels Dossche wrote:
>> In a previous patch I extended the locking for member accesses of
>> space_info.
> 
> A reference to another patch would be by a subject or a specific commit
> id (not applicable in this case) or you can write it without any
> reference if the change is standalone. The changelog should describe the
> reason for the change, user visible effects, what can go wrong etc.
> 

I will make sure to do that in the future. Thanks.

>> It was then suggested to also add a lockdep assertion for
>> space_info->lock to need_preemptive_reclaim.
>>
>> Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>> Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
>> ---
>>  fs/btrfs/space-info.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>> index 294242c194d8..5464bd168d5b 100644
>> --- a/fs/btrfs/space-info.c
>> +++ b/fs/btrfs/space-info.c
>> @@ -734,9 +734,13 @@ static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
>>  {
>>  	u64 global_rsv_size = fs_info->global_block_rsv.reserved;
>>  	u64 ordered, delalloc;
>> -	u64 thresh = div_factor_fine(space_info->total_bytes, 90);
>> +	u64 thresh;
>>  	u64 used;
>>  
>> +	lockdep_assert_held(&space_info->lock);
>> +
>> +	thresh = div_factor_fine(space_info->total_bytes, 90);
> 
> I'm not sure this is necessary, as this is not locking where the
> initialization would have to be inside. The lockdep assertion is just a
> warning, so it does not matter where the intialization is done, I'd
> prefer to keep it as is.

I understand. Thank you for your feedback. I will send a v2 shortly.
