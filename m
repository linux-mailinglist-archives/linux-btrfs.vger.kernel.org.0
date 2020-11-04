Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAE52A6F9F
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 22:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgKDV1B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 16:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgKDV1B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 16:27:01 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7E3C0613D3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 13:26:59 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 23so2715817wmg.1
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 13:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b3kNQj05We5+nR2alXATlPefjM836ILotyYZOaXNtuU=;
        b=LIKX+RLe2ArbyIX9LsUQApPv0LXEpHv8EUzPQXzpNbNEvYLYduf23NNzf0ZZYCiJll
         mcdH/RTTGHSDIH97AVRWohVOtnM3dtKgaIRtAWSeOMMLAkIiJsfbmJIEZ04MQ9Rs5hTr
         J2okQ66iDTMauPhoAFeYAnyuiptJIZZZh3MT5gGo4Etr1yvt4r0Eyye//Ii8sivu/OlN
         QaIVyiQ9rA2sPC6Is5sZ0KLI+gN+/Bz39xQ9GXRqeVlXE7vHS+Hgvzeb4zu0Ign1BRZD
         uQe2eRJr562h5zCz7/nRygX9/oOItmj1Fcj89XqG2TS7rL6AlSv7ZMR0z5mJkbEIS5ha
         bXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b3kNQj05We5+nR2alXATlPefjM836ILotyYZOaXNtuU=;
        b=c863gtlld7p9m3XfO0CUXGtkvr17lrS49neucP8OTngQsN2yApgiFULJh6blraKgp1
         L8U26UpA/USwsut3cH87535TlkZfifs+su+AeHBzjPsXuY9o0MWBdZO2XjNScd6gB+sW
         O+hrFK3e2vCLjxpi30l/cq1E8HMEit6iipf03cOKZhLYM4vEFFi/hbX90kriDIJ8t2b1
         vy9Sa9kZt37LxxtLkipxSzggVnyeRTcxTayII287lF639RvKvEptvpEMFSIdvKMu12W6
         XFqp6D6uy5pUlD6YMHsxTj/mR3XkH5BujmGak8bwbMh/04RYnpIq6bVW+3/B6IjfQaYz
         s83w==
X-Gm-Message-State: AOAM533eN4U6kXcBjxaLWnt4CxgLGCs6sibxbOkgOoFfIe1d02YE6NVX
        bvvKv2xorcLM7YTzHgcjvGDT97HJGFo=
X-Google-Smtp-Source: ABdhPJxrO1n5AiL8O5VixoME8AXQt0wuzw8HFVdg+SeAxXHg8bnpLsAuQjbLFplsi4z0GHhsE1PJuw==
X-Received: by 2002:a1c:3b87:: with SMTP id i129mr6948265wma.134.1604525218146;
        Wed, 04 Nov 2020 13:26:58 -0800 (PST)
Received: from [192.168.1.121] (host109-152-100-164.range109-152.btcentralplus.com. [109.152.100.164])
        by smtp.gmail.com with ESMTPSA id v8sm4075089wmg.28.2020.11.04.13.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 13:26:57 -0800 (PST)
Subject: Re: [PATCH 3/4] btrfs: don't miss discards after override-schedule
To:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1604444952.git.asml.silence@gmail.com>
 <feb3b0aaf0d547aafcf08b6106ace158809117fd.1604444952.git.asml.silence@gmail.com>
 <9cfd00b4-1731-1f56-6b53-d3c210fd8453@toxicpanda.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFmKBOQBEAC76ZFxLAKpDw0bKQ8CEiYJRGn8MHTUhURL02/7n1t0HkKQx2K1fCXClbps
 bdwSHrhOWdW61pmfMbDYbTj6ZvGRvhoLWfGkzujB2wjNcbNTXIoOzJEGISHaPf6E2IQx1ik9
 6uqVkK1OMb7qRvKH0i7HYP4WJzYbEWVyLiAxUj611mC9tgd73oqZ2pLYzGTqF2j6a/obaqha
 +hXuWTvpDQXqcOZJXIW43atprH03G1tQs7VwR21Q1eq6Yvy2ESLdc38EqCszBfQRMmKy+cfp
 W3U9Mb1w0L680pXrONcnlDBCN7/sghGeMHjGKfNANjPc+0hzz3rApPxpoE7HC1uRiwC4et83
 CKnncH1l7zgeBT9Oa3qEiBlaa1ZCBqrA4dY+z5fWJYjMpwI1SNp37RtF8fKXbKQg+JuUjAa9
 Y6oXeyEvDHMyJYMcinl6xCqCBAXPHnHmawkMMgjr3BBRzODmMr+CPVvnYe7BFYfoajzqzq+h
 EyXSl3aBf0IDPTqSUrhbmjj5OEOYgRW5p+mdYtY1cXeK8copmd+fd/eTkghok5li58AojCba
 jRjp7zVOLOjDlpxxiKhuFmpV4yWNh5JJaTbwCRSd04sCcDNlJj+TehTr+o1QiORzc2t+N5iJ
 NbILft19Izdn8U39T5oWiynqa1qCLgbuFtnYx1HlUq/HvAm+kwARAQABtDFQYXZlbCBCZWd1
 bmtvdiAoc2lsZW5jZSkgPGFzbWwuc2lsZW5jZUBnbWFpbC5jb20+iQJOBBMBCAA4FiEE+6Ju
 PTjTbx479o3OWt5b1Glr+6UFAlmKBOQCGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQ
 Wt5b1Glr+6WxZA//QueaKHzgdnOikJ7NA/Vq8FmhRlwgtP0+E+w93kL+ZGLzS/cUCIjn2f4Q
 Mcutj2Neg0CcYPX3b2nJiKr5Vn0rjJ/suiaOa1h1KzyNTOmxnsqE5fmxOf6C6x+NKE18I5Jy
 xzLQoktbdDVA7JfB1itt6iWSNoOTVcvFyvfe5ggy6FSCcP+m1RlR58XxVLH+qlAvxxOeEr/e
 aQfUzrs7gqdSd9zQGEZo0jtuBiB7k98t9y0oC9Jz0PJdvaj1NZUgtXG9pEtww3LdeXP/TkFl
 HBSxVflzeoFaj4UAuy8+uve7ya/ECNCc8kk0VYaEjoVrzJcYdKP583iRhOLlZA6HEmn/+Gh9
 4orG67HNiJlbFiW3whxGizWsrtFNLsSP1YrEReYk9j1SoUHHzsu+ZtNfKuHIhK0sU07G1OPN
 2rDLlzUWR9Jc22INAkhVHOogOcc5ajMGhgWcBJMLCoi219HlX69LIDu3Y34uIg9QPZIC2jwr
 24W0kxmK6avJr7+n4o8m6sOJvhlumSp5TSNhRiKvAHB1I2JB8Q1yZCIPzx+w1ALxuoWiCdwV
 M/azguU42R17IuBzK0S3hPjXpEi2sK/k4pEPnHVUv9Cu09HCNnd6BRfFGjo8M9kZvw360gC1
 reeMdqGjwQ68o9x0R7NBRrtUOh48TDLXCANAg97wjPoy37dQE7e5Ag0EWYoE5AEQAMWS+aBV
 IJtCjwtfCOV98NamFpDEjBMrCAfLm7wZlmXy5I6o7nzzCxEw06P2rhzp1hIqkaab1kHySU7g
 dkpjmQ7Jjlrf6KdMP87mC/Hx4+zgVCkTQCKkIxNE76Ff3O9uTvkWCspSh9J0qPYyCaVta2D1
 Sq5HZ8WFcap71iVO1f2/FEHKJNz/YTSOS/W7dxJdXl2eoj3gYX2UZNfoaVv8OXKaWslZlgqN
 jSg9wsTv1K73AnQKt4fFhscN9YFxhtgD/SQuOldE5Ws4UlJoaFX/yCoJL3ky2kC0WFngzwRF
 Yo6u/KON/o28yyP+alYRMBrN0Dm60FuVSIFafSqXoJTIjSZ6olbEoT0u17Rag8BxnxryMrgR
 dkccq272MaSS0eOC9K2rtvxzddohRFPcy/8bkX+t2iukTDz75KSTKO+chce62Xxdg62dpkZX
 xK+HeDCZ7gRNZvAbDETr6XI63hPKi891GeZqvqQVYR8e+V2725w+H1iv3THiB1tx4L2bXZDI
 DtMKQ5D2RvCHNdPNcZeldEoJwKoA60yg6tuUquvsLvfCwtrmVI2rL2djYxRfGNmFMrUDN1Xq
 F3xozA91q3iZd9OYi9G+M/OA01husBdcIzj1hu0aL+MGg4Gqk6XwjoSxVd4YT41kTU7Kk+/I
 5/Nf+i88ULt6HanBYcY/+Daeo/XFABEBAAGJAjYEGAEIACAWIQT7om49ONNvHjv2jc5a3lvU
 aWv7pQUCWYoE5AIbDAAKCRBa3lvUaWv7pfmcEACKTRQ28b1y5ztKuLdLr79+T+LwZKHjX++P
 4wKjEOECCcB6KCv3hP+J2GCXDOPZvdg/ZYZafqP68Yy8AZqkfa4qPYHmIdpODtRzZSL48kM8
 LRzV8Rl7J3ItvzdBRxf4T/Zseu5U6ELiQdCUkPGsJcPIJkgPjO2ROG/ZtYa9DvnShNWPlp+R
 uPwPccEQPWO/NP4fJl2zwC6byjljZhW5kxYswGMLBwb5cDUZAisIukyAa8Xshdan6C2RZcNs
 rB3L7vsg/R8UCehxOH0C+NypG2GqjVejNZsc7bgV49EOVltS+GmGyY+moIzxsuLmT93rqyII
 5rSbbcTLe6KBYcs24XEoo49Zm9oDA3jYvNpeYD8rDcnNbuZh9kTgBwFN41JHOPv0W2FEEWqe
 JsCwQdcOQ56rtezdCJUYmRAt3BsfjN3Jn3N6rpodi4Dkdli8HylM5iq4ooeb5VkQ7UZxbCWt
 UVMKkOCdFhutRmYp0mbv2e87IK4erwNHQRkHUkzbsuym8RVpAZbLzLPIYK/J3RTErL6Z99N2
 m3J6pjwSJY/zNwuFPs9zGEnRO4g0BUbwGdbuvDzaq6/3OJLKohr5eLXNU3JkT+3HezydWm3W
 OPhauth7W0db74Qd49HXK0xe/aPrK+Cp+kU1HRactyNtF8jZQbhMCC8vMGukZtWaAwpjWiiH bA==
Message-ID: <207968f3-891c-28cd-4dcd-51fae1d890ab@gmail.com>
Date:   Wed, 4 Nov 2020 21:23:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <9cfd00b4-1731-1f56-6b53-d3c210fd8453@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04/11/2020 20:59, Josef Bacik wrote:
> On 11/4/20 4:45 AM, Pavel Begunkov wrote:
>> If btrfs_discard_schedule_work() is called with override=true, it sets
>> delay anew regardless how much time left until the timer should have
>> fired. If delays are long (that can happen, for example, with low
>> kbps_limit), they might be constantly overriden without having a chance
>> to run the discard work.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>   fs/btrfs/ctree.h   |  1 +
>>   fs/btrfs/discard.c | 11 +++++++++++
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index d43a82dcdfc0..ad71c8c769de 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -469,6 +469,7 @@ struct btrfs_discard_ctl {
>>       struct btrfs_block_group *block_group;
>>       struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
>>       u64 prev_discard;
>> +    u64 prev_discard_time;
>>       atomic_t discardable_extents;
>>       atomic64_t discardable_bytes;
>>       u64 max_discard_size;
>> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
>> index b6c68e5711f0..c9018b9ccf99 100644
>> --- a/fs/btrfs/discard.c
>> +++ b/fs/btrfs/discard.c
>> @@ -381,6 +381,15 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
>>               delay = max(delay, bg_timeout);
>>           }
>>   +        if (override && discard_ctl->prev_discard) {
>> +            u64 elapsed = now - discard_ctl->prev_discard_time;
>> +
>> +            if (delay > elapsed)
>> +                delay -= elapsed;
>> +            else
>> +                delay = 0;
>> +        }
>> +
>>           mod_delayed_work(discard_ctl->discard_workers,
>>                    &discard_ctl->work, nsecs_to_jiffies(delay));
>>       }
>> @@ -466,6 +475,7 @@ static void btrfs_discard_workfn(struct work_struct *work)
>>       }
>>         discard_ctl->prev_discard = trimmed;
>> +    discard_ctl->prev_discard_time = ktime_get_ns();
> 
> I noticed these weren't protected by the discard_ctl->lock, so I went to look at if that was ok.  It appears to be ok, since this is the workfn, and we only read them if there's no pending work, so we're protected there.  Just a note for anybody else who finds it weird, though I wouldn't argue with protecting it with a lock just to remove any ambiguity.

Agree, together with ->prev_discard. Or at least there should be
a comment.

> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Thanks

-- 
Pavel Begunkov
