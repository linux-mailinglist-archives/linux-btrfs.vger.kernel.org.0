Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B644E6F40
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Mar 2022 09:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350301AbiCYIF6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Mar 2022 04:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiCYIF5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Mar 2022 04:05:57 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D910C6ED1;
        Fri, 25 Mar 2022 01:04:24 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o6-20020a17090a9f8600b001c6562049d9so7578419pjp.3;
        Fri, 25 Mar 2022 01:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=k5SnJKnSQgGm03pK1Rh/ppKUUZMIIQhJLBgtty0XG1k=;
        b=ncEX2tduPQxfe666yaF2BPwotrIpqV5jgAfWvQ+PtynqDjyWOG/IGJbkFrWj3zCjUF
         zj5IBWNMmLY9/94ODSz0/xTRYk7Z7w5HLq/M8l60TigmY4+ze5riZixoXT1LxTrOZf9c
         UayRztgYOYVkAM8mQsfHI32NuNg+8cBAGRfbBLggjwWgDdhvd8lbc5OJu8adh0f278+m
         jGFdEXHVFxKL3ReAT//OkWFR4hnqq6wv100e1EvnhW/5EV7/WeaqkvAQDb5eRBa58Bbp
         bsOWBdzU7GN/hgUKOl0ZRQCa+5ANbXZACUd2PqJCOgcuDdRSzvADmJZ2mLdYfd+/knx4
         O33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=k5SnJKnSQgGm03pK1Rh/ppKUUZMIIQhJLBgtty0XG1k=;
        b=WbePkyNoc1PzaxsZ8XiidvUqSJp3lVhUWSm0fq3jzuhmWBgR6IX5Lwmmf/B92esfKU
         2x7eSpcbbKxij9s+kb+e7AutZOm78s9dSvBYyzBK4FfUrDJwg7AvlJpNKlzvUSwNpp8h
         DUmw+c8chTFxXg3TwULLgquaSKLz8OeReM5Xud58P6FOOo5B5+tSAbV7z5i3rM1mSSPn
         KnOY+DRy39BfEkyv2lvPXN6dJnzPm3fdiP2H8VSE7FEN9hGdXLN37RckKaPNO/jkoS2k
         8PcIfD9xhTDv4etFHY7xJC+yJ5USNGbnHduBc7bsWbA35MhpmnYXxf4M58Uaa/lk3/8w
         0U5Q==
X-Gm-Message-State: AOAM5310wkyd3d2qYaw0CdpALNYd3NyQL6GYZYeJoLRzGxhTQjE9RMdu
        DdyaNWStINuXfkTDgz4BArlSfSQaHW4=
X-Google-Smtp-Source: ABdhPJx4tjKSGFU3Bu+QExdfCrRJE5x9JE9tK6OSaA5S9dk4p2HIihfkm04FfjJCOshLwFUiiXpxGg==
X-Received: by 2002:a17:902:f68b:b0:154:76c2:f7cf with SMTP id l11-20020a170902f68b00b0015476c2f7cfmr10432032plg.160.1648195463177;
        Fri, 25 Mar 2022 01:04:23 -0700 (PDT)
Received: from [10.110.0.6] ([194.5.48.145])
        by smtp.gmail.com with ESMTPSA id y4-20020a056a00190400b004fac0896e35sm5478063pfi.42.2022.03.25.01.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 01:04:22 -0700 (PDT)
Subject: Re: [PATCH] fs: btrfs: fix possible use-after-free bug in error
 handling code of btrfs_get_root_ref()
To:     dsterba@suse.cz
References: <20220324134454.15192-1-baijiaju1990@gmail.com>
 <20220324181940.GK2237@suse.cz>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <84720b1d-831e-4a2e-e2c5-4f20ac7bb778@gmail.com>
Date:   Fri, 25 Mar 2022 16:04:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20220324181940.GK2237@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/25 2:19, David Sterba wrote:
> On Thu, Mar 24, 2022 at 06:44:54AM -0700, Jia-Ju Bai wrote:
>> In btrfs_get_root_ref(), when btrfs_insert_fs_root() fails,
>> btrfs_put_root() will be called to possibly free the memory area of
>> the variable root. However, this variable is then used again in error
>> handling code after "goto fail", when ret is not -EEXIST.
>>
>> To fix this possible bug, btrfs_put_root() is only called when ret is
>> -EEXIST for "goto again".
>>
>> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>   fs/btrfs/disk-io.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index b30309f187cf..126f244cdf88 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -1850,9 +1850,10 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
>>   
>>   	ret = btrfs_insert_fs_root(fs_info, root);
>>   	if (ret) {
>> -		btrfs_put_root(root);
>> -		if (ret == -EEXIST)
>> +		if (ret == -EEXIST) {
>> +			btrfs_put_root(root);
> I think this fix is correct, though it's not that clear. If you look how
> the code changed, there was the unconditional put and then followed by a
> free:
>
> 8c38938c7bb0 ("btrfs: move the root freeing stuff into btrfs_put_root")
>
> Here it's putting twice where one will be the final free.
>
> And then the whole refcounting gets updated in
>
> 4785e24fa5d2 ("btrfs: don't take an extra root ref at allocation time")
>
> which could be removing the wrong put, I'm not yet sure.

Thanks for the reply!

I think the bug should be introduced by this commit:
bc44d7c4b2b1 ("btrfs: push btrfs_grab_fs_root into btrfs_get_fs_root")

This commit has a change:
      ret = btrfs_insert_fs_root(fs_info, root);
      if (ret) {
+      btrfs_put_fs_root(root);
          if (ret == -EEXIST) {
              btrfs_free_fs_root(root);
              goto again;
          }

I could add a Fixes tag of this commit in my V2 patch.
Is it okay?


Best wishes,
Jia-Ju Bai
