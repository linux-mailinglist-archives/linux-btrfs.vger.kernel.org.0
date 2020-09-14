Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064442690E9
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Sep 2020 17:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgINP6h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 11:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgINP6T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 11:58:19 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7051C06174A
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Sep 2020 08:58:18 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id cy2so9230799qvb.0
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Sep 2020 08:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QIQNPWH849c6SHm912sYhLuTpgZUG/uOySu+2Dr9V8M=;
        b=p5BEFogf2KYdy1iE9uYP2nVlxxUnrO78I394LwKl+LOIUhJmd77C9HPuwiZEXArhC+
         e7PucHc/T5rLy2ioT5pVxW4Wupx2rozHz+JapFYUEOlp8U0PPI0xxhfB+RlSVsoVuodH
         Z2pHBO7COhmjEcgH/J81T0Y6g0zZiNVHWC11c2+9x5Ml7+Cfu6xZl3s+/hphUt4MYcTE
         SSin3y2WQOVON6B4ArhnHU5gGFgAx3PDYTruxCjibhaOqSA2qwnDC13sBp8G/UgG3xmL
         EFHTgoKFyNWzJZGQMi2EwHo+48P40R/Efe6IoD0hpKbNjjU5l850O2fwkeo4mNRHKlh5
         qEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QIQNPWH849c6SHm912sYhLuTpgZUG/uOySu+2Dr9V8M=;
        b=qnDPenlU/WoGthBL/7Nryf1wWltOFOkHVw3yelfhS9uOrnBzaugsgXbCYpek32R3xi
         ftHH1dcr0/SdjN4SYpAgDZa3dc97ll76Hxs7F0qnOWVV5teeM8BbHv/25fECDokVcmTj
         YhL5j/29FIurTUL6eYhEieniNUokbFvCUVnfoBKkGETTLHxzuJXHD1GXC1S7FpVQpfwe
         CdrpKKcdIHGXskBte1+gDJaf5Bj80RsL5ZwHHRqpc6chOEduUnRnWXBDsum+DpQFEUsi
         js/NtKw9V1uPPNMwHxz7zyxHQaZq4i4vlNwGpfctCw/hhbeSkWx5DXNz+cyF5qyFalFa
         jBPA==
X-Gm-Message-State: AOAM533/eHIOofJnmrA5HIiE5DqU8STHT79BmqH7AZ0syX6LxQUUhvOn
        8YDuMYyjJawdz9aEYDX1dzjpXNfoucvWbJH2
X-Google-Smtp-Source: ABdhPJwVi9PLB0b/7eKQfIkqQszO6FsHuTecgx2MIpGRU+jY4wDfuE2ie/JBJ0zT3U0AxXKqwRNXOg==
X-Received: by 2002:a0c:a085:: with SMTP id c5mr14458173qva.30.1600099096215;
        Mon, 14 Sep 2020 08:58:16 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c1::111c? ([2620:10d:c091:480::1:9b22])
        by smtp.gmail.com with ESMTPSA id d76sm14405869qkc.81.2020.09.14.08.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 08:58:15 -0700 (PDT)
Subject: Re: [PATCH] btrfs: fix wrong address when faulting in pages in the
 search ioctl
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <78bf853ef63f2dbd62587bb02bb723fbaa77c198.1600070418.git.fdmanana@suse.com>
 <8c2f5f20-3868-4291-5bed-b571c8ae61a0@toxicpanda.com>
 <CAL3q7H6p2PEQhCM+zhMGvawJgJiTsfRLsirMoANH3p8h3f5N2A@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <eecea3a5-5da4-913b-5e2a-88e78a0cb286@toxicpanda.com>
Date:   Mon, 14 Sep 2020 11:58:14 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H6p2PEQhCM+zhMGvawJgJiTsfRLsirMoANH3p8h3f5N2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/14/20 11:47 AM, Filipe Manana wrote:
> On Mon, Sep 14, 2020 at 4:23 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> On 9/14/20 4:01 AM, fdmanana@kernel.org wrote:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> When faulting in the pages for the user supplied buffer for the search
>>> ioctl, we are passing only the base address of the buffer to the function
>>> fault_in_pages_writeable(). This means that after the first iteration of
>>> the while loop that searches for leaves, when we have a non-zero offset,
>>> stored in 'sk_offset', we try to fault in a wrong page range.
>>>
>>> So fix this by adding the offset in 'sk_offset' to the base address of the
>>> user supplied buffer when calling fault_in_pages_writeable().
>>>
>>> Several users have reported that the applications compsize and bees have
>>> started to operate incorrectly since commit a48b73eca4ceb9 ("btrfs: fix
>>> potential deadlock in the search ioctl") was added to stable trees, and
>>> these applications make heavy use of the search ioctls. This fixes their
>>> issues.
>>>
>>> Link: https://lore.kernel.org/linux-btrfs/632b888d-a3c3-b085-cdf5-f9bb61017d92@lechevalier.se/
>>> Link: https://github.com/kilobyte/compsize/issues/34
>>> Tested-by: A L <mail@lechevalier.se>
>>> Fixes: a48b73eca4ceb9 ("btrfs: fix potential deadlock in the search ioctl")
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>> ---
>>>    fs/btrfs/ioctl.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>> index 5f06aeb71823..b91444e810a5 100644
>>> --- a/fs/btrfs/ioctl.c
>>> +++ b/fs/btrfs/ioctl.c
>>> @@ -2194,7 +2194,8 @@ static noinline int search_ioctl(struct inode *inode,
>>>        key.offset = sk->min_offset;
>>>
>>>        while (1) {
>>> -             ret = fault_in_pages_writeable(ubuf, *buf_size - sk_offset);
>>> +             ret = fault_in_pages_writeable(ubuf + sk_offset,
>>> +                                            *buf_size - sk_offset);
>>>                if (ret)
>>>                        break;
>>>
>>>
>>
>> Eesh, can we get an xfstest for this?
> 
> I would have written one if it were simple to trigger.
> I don't think it's easy to trigger it deterministically or close
> enough to deterministic.
> 
> How do you guarantee that a call to the ioctl will cause the pages to
> fault in at any iteration of the loop?
> That the pages aren't already faulted in, and then if you need to
> fault them in, that happens on an iteration other than the first one?
> 

Yeah I was thinking about it after I wrote it.  I guess mmap a few pages worth, 
and stick the first entry at the end of the first page?  A stress test is 
probably in order for this stuff so we don't have this sort of problem again. 
Thanks,

Josef
