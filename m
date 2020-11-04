Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60F62A681A
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 16:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbgKDPv1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 10:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729263AbgKDPv0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 10:51:26 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255A9C0613D3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 07:51:26 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id p22so2830720wmg.3
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 07:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6G1K+sNMu1KczkI6ZY7RlcyT/qf45HNUKCGNbbOvzo4=;
        b=XODXcLNSPXgFMg+Ld3MjgSyTI6g5F/ind4PxLRp7Rs6PEHZXHrsGMquPQh0jnNszLe
         B5310nYTdSbM6E1NVKBGnr7d+oI7S9/CNCQuaxZ07HKyPjbcH/x1c8LSvgbfaxvDTjfX
         eyjye/XBKWeGLKfoUTZK6IxVeTykVjdEVDcIDZmG/ioIBLQFvmZgF9xRtHR4e+zpNm4G
         RAkABmQMbnThywoS0oFCHhL0AiZZF4b+QGqs3iWPFleFRADGRfN7mYnA+7OHXEMyHqkE
         +o5SkdcEWsTu+AjHRvFN2tYJMd8qxiBaL5nQTHbyU5Feh9ye3IoWy7LSbeMmmyDihijI
         OJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6G1K+sNMu1KczkI6ZY7RlcyT/qf45HNUKCGNbbOvzo4=;
        b=Uu8+Xz0fxITZxT0+ucBKmhCc7NQ06CYC2pMYfe14HDpv1tYsyMr18v5BmH2qF4vJom
         dPkDZvSK7XsVNyudq6VvNfYgfBXQzAXNwM/a0bjPKzwobDsDNo+FrrQDKzvIhM7IbVa+
         Rq+DW2YKrupg3VvGgS6nPue06aLi3pD+GDf7egYuRqGtigWyWsIRmDUZ/puy+2xG0z5N
         uvoX/2YE+2Rpb72S+XYUR4FTE2nGfgiAeNZGj0aIZ6pYysj/RdU6G+bcOL5dGdMddb4M
         qvkjHB8oKqf7bI8vjrsnWPNxZDoLv5BdW1cYdlojqTVqI5RH+bYbX8WyKf5iA8RvMWJW
         1Klw==
X-Gm-Message-State: AOAM531KjTF6ILvywEDUBIDF3l/LxfEXruerR1uPKEOIyznLESJ8Wnxz
        Oek4SEKNJU9NfB401Z32LgeYQ+A2TT4w+A==
X-Google-Smtp-Source: ABdhPJyU99SqgoQwxCzEctirartsFcbC63jfVDpkKiKuk7aavxnLCodpbHRMaIVWgpPPwpMSIevnXw==
X-Received: by 2002:a1c:4302:: with SMTP id q2mr5476097wma.182.1604505084652;
        Wed, 04 Nov 2020 07:51:24 -0800 (PST)
Received: from [192.168.1.121] (host109-152-100-228.range109-152.btcentralplus.com. [109.152.100.228])
        by smtp.gmail.com with ESMTPSA id d20sm3342627wra.38.2020.11.04.07.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 07:51:24 -0800 (PST)
To:     Amy Parker <enbyamy@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <cover.1604444952.git.asml.silence@gmail.com>
 <5be2ccce4a6ebe7c96274f63091a04aeba9af9d8.1604444952.git.asml.silence@gmail.com>
 <CAE1WUT5k8e_twhb8yZX7=kYFX-ikzUuQwunRkPCCH-zJ80Q6TA@mail.gmail.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH 2/4] btrfs: discard: save discard delay as ns not jiffy
Message-ID: <bcd88bb1-37e6-2b1d-6fe8-390d3aa68d29@gmail.com>
Date:   Wed, 4 Nov 2020 15:48:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAE1WUT5k8e_twhb8yZX7=kYFX-ikzUuQwunRkPCCH-zJ80Q6TA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04/11/2020 15:35, Amy Parker wrote:
> On Wed, Nov 4, 2020 at 1:52 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> Most of calculations are done in ns or ms, so store discard_ctl->delay
>> in ms and convert the final delay to jiffies only in the end.
> 
> Great idea.
> 
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>  fs/btrfs/ctree.h   |  2 +-
>>  fs/btrfs/discard.c | 14 +++++++-------
>>  2 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index aac3d6f4e35b..d43a82dcdfc0 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -472,7 +472,7 @@ struct btrfs_discard_ctl {
>>         atomic_t discardable_extents;
>>         atomic64_t discardable_bytes;
>>         u64 max_discard_size;
>> -       unsigned long delay;
>> +       u64 delay_ms;
> 
> Thanks for converting this from the ambiguous unsigned long to the
> more specific u64.
> 
>>         u32 iops_limit;
>>         u32 kbps_limit;
>>         u64 discard_extent_bytes;
>> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
>> index 76796a90e88d..b6c68e5711f0 100644
>> --- a/fs/btrfs/discard.c
>> +++ b/fs/btrfs/discard.c
>> @@ -355,7 +355,7 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
>>
>>         block_group = find_next_block_group(discard_ctl, now);
>>         if (block_group) {
>> -               unsigned long delay = discard_ctl->delay;
>> +               u64 delay = discard_ctl->delay_ms * NSEC_PER_MSEC;
> 
> I worry about a potential performance impact with this, but it should be
> minimal at most.

That's nothing, nsecs_to_jiffies() in the end is heavier, but this is not
in a hot path and by all means it's heavily amortised by actual discarding.

> 
>>                 u32 kbps_limit = READ_ONCE(discard_ctl->kbps_limit);
>>
>>                 /*
>> @@ -366,9 +366,9 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
>>                 if (kbps_limit && discard_ctl->prev_discard) {
>>                         u64 bps_limit = ((u64)kbps_limit) * SZ_1K;
>>                         u64 bps_delay = div64_u64(discard_ctl->prev_discard *
>> -                                                 MSEC_PER_SEC, bps_limit);
>> +                                                 NSEC_PER_SEC, bps_limit);
>>
>> -                       delay = max(delay, msecs_to_jiffies(bps_delay));
>> +                       delay = max(delay, bps_delay);
> 
> Great that we got this down to just passing max() a value. Same thing on
> the instance below.
> 
>>                 }
>>
>>                 /*
>> @@ -378,11 +378,11 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
>>                 if (now < block_group->discard_eligible_time) {
>>                         u64 bg_timeout = block_group->discard_eligible_time - now;
>>
>> -                       delay = max(delay, nsecs_to_jiffies(bg_timeout));
>> +                       delay = max(delay, bg_timeout);
>>                 }
>>
>>                 mod_delayed_work(discard_ctl->discard_workers,
>> -                                &discard_ctl->work, delay);
>> +                                &discard_ctl->work, nsecs_to_jiffies(delay));
>>         }
>>  out:
>>         spin_unlock(&discard_ctl->lock);
>> @@ -555,7 +555,7 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
>>
>>         delay = clamp(delay, BTRFS_DISCARD_MIN_DELAY_MSEC,
>>                       BTRFS_DISCARD_MAX_DELAY_MSEC);
>> -       discard_ctl->delay = msecs_to_jiffies(delay);
>> +       discard_ctl->delay_ms = delay;
>>
>>         spin_unlock(&discard_ctl->lock);
>>  }
>> @@ -687,7 +687,7 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
>>         atomic_set(&discard_ctl->discardable_extents, 0);
>>         atomic64_set(&discard_ctl->discardable_bytes, 0);
>>         discard_ctl->max_discard_size = BTRFS_ASYNC_DISCARD_DEFAULT_MAX_SIZE;
>> -       discard_ctl->delay = BTRFS_DISCARD_MAX_DELAY_MSEC;
>> +       discard_ctl->delay_ms = BTRFS_DISCARD_MAX_DELAY_MSEC;
>>         discard_ctl->iops_limit = BTRFS_DISCARD_MAX_IOPS;
>>         discard_ctl->kbps_limit = 0;
>>         discard_ctl->discard_extent_bytes = 0;
>> --
>> 2.24.0
>>
> 
> Looks all fine to me.


-- 
Pavel Begunkov
