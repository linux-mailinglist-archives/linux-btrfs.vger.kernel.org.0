Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7EABEC73C
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2019 18:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfKARJe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Nov 2019 13:09:34 -0400
Received: from mail-yw1-f50.google.com ([209.85.161.50]:47022 "EHLO
        mail-yw1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbfKARJe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Nov 2019 13:09:34 -0400
Received: by mail-yw1-f50.google.com with SMTP id i2so3710455ywg.13
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Nov 2019 10:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=4w/wodrYk8kJaiVImEm/6ctDHk8Yw/RBKwY8/chp8pU=;
        b=Dr2cdKIzcpAwi5CVGrEZ6d1yWi85TMCMzLf+AliOIm3cLAgCx8zRL3rfXY9kGuGLMp
         sB84ToCLUeON8H5V3+vxmUWZ47sgRl4rakl/v4J0FB3woNGGcBERwaZfmbqNUdpN3A/a
         qKjxd04EYam6siCMbsueHb1jlh5YhQ8/djOahhmtJg1/Pv7+lstoVPCbY2AEuNxcrjz4
         DcOteW/pq78dSj64x8mzSctaEkDmsdgrO0UsCTITiwmF/Yyt+vQkipTSyVOW/7zByc7a
         a37b+QkSKKLkVf4XEN3Ao5CZ0T3CqKlrcX6dnyEN/amB6fgl+2MFgiw9OG6w/13O7Oq8
         IAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4w/wodrYk8kJaiVImEm/6ctDHk8Yw/RBKwY8/chp8pU=;
        b=jOpdOu5pIDqEhhKoBAkiRwaRlTT3xucTrpIX5TM7LmN+hbrQeoQShqaAvYwxil+jcB
         4N7719Kb2PrCdkfMP1IdeaDTGJY8aYMggjD1qA7D8iwPGjvoB7gpiCaN+snygBL7+dmz
         +1ofUDN08Neey1t10b+Lb+yHx2zVGCfIVjPkgIpFZlWh+W8Kmwse6ZNDG9Dt5bVhKy1A
         dH8lVpOrDvAwrYAzert32f4p0gGWOs0d85cIf2MDc/cWUPlzjIewwm0AiCq9hp7mPqqD
         TSJFaG6VDlQx4DvdVPSviTKuzKRGyQitQA+s4AmDIu71+CVRgDnaUDwnDIJUpwipweye
         rygQ==
X-Gm-Message-State: APjAAAXohbWCk1yvOm6b21824xmsMWNWyRthjHP01b+5x7wHd83ozKAQ
        o1SW4f9+9YiUKe9f+FnnAVu2DMx8
X-Google-Smtp-Source: APXvYqxRmCccrmnkBnfz+nNi78xR20GAwzxW/uz4lygDhHuXhSdjVj8fIWkwNxUmDFcQl/9PShkrdg==
X-Received: by 2002:a81:9302:: with SMTP id k2mr9457345ywg.222.1572628172976;
        Fri, 01 Nov 2019 10:09:32 -0700 (PDT)
Received: from [143.215.130.72] (meng.gtisc.gatech.edu. [143.215.130.72])
        by smtp.gmail.com with ESMTPSA id d127sm3707820ywe.108.2019.11.01.10.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 10:09:32 -0700 (PDT)
Subject: Re: potential data race on `delayed_rsv->full`
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, josef@toxicpanda.com
References: <CAAwBoOJDjei5Hnem155N_cJwiEkVwJYvgN-tQrwWbZQGhFU=cA@mail.gmail.com>
 <20191101154536.GW3001@twin.jikos.cz>
From:   Meng Xu <mengxu.gatech@gmail.com>
Message-ID: <c8aaa244-f0f3-0611-0b2d-13a78a57f9bd@gmail.com>
Date:   Fri, 1 Nov 2019 13:09:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191101154536.GW3001@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi David,

Thank you for the confirmation and the additional information.

I feel the same that this race may not lead to serious issues, but would 
rather prefer a confirmation from the developers. Thank you again for 
your time!

Best Regards,
Meng


On 11/1/19 11:45 AM, David Sterba wrote:
> On Tue, Oct 15, 2019 at 02:33:11PM -0400, Meng Xu wrote:
>> I am reporting a potential data race around the `delayed_rsv->full` field.
> Thanks for the report.
>
>> [thread 1] mount a btrfs image, a kernel thread of uuid_rescan will be created
>>
>> btrfs_uuid_rescan_kthread
>>    btrfs_end_transaction
>>      __btrfs_end_transaction
>>        btrfs_trans_release_metadata
>>          btrfs_block_rsv_release
>>            __btrfs_block_rsv_release
>>              --> [READ] else if (block_rsv != global_rsv && !delayed_rsv->full)
>>                                                              ^^^^^^^^^^^^^^^^^
>>
>>
>> [thread 2] do a mkdir syscall on the mounted image
>>
>> __do_sys_mkdir
>>    do_mkdirat
>>      vfs_mkdir
>>        btrfs_mkdir
>>          btrfs_new_inode
>>            btrfs_insert_empty_items
>>              btrfs_cow_block
>>                __btrfs_cow_block
>>                  alloc_tree_block_no_bg_flush
>>                    btrfs_alloc_tree_block
>>                      btrfs_add_delayed_tree_ref
>>                        btrfs_update_delayed_refs_rsv
>>                          --> [WRITE] delayed_rsv->full = 0;
>>                                      ^^^^^^^^^^^^^^^^^^^^^
>>
>>
>> I could confirm that this is a data race by manually adding and adjusting
>> delays before the read and write statements although I am not very sure
>> about the implication of such a data race (e.g., crashing btrfs or causing
>> violations of assumptions). I would appreciate if you could help check on
>> this potential bug and advise whether this is a harmful data race or it
>> is intended.
> The race is there, as the access is unprotected, but it does not seem to
> have serious implications. The race is for space, which happens all the
> time, and if the reservations cannot be satisfied there goes ENOSPC.
>
> In this particular case I wonder if the uuid thread is important or if
> this would happen with anything that calls btrfs_end_transaction.
>
> Depending on the value of ->full, __btrfs_block_rsv_release decides
> where to return the reservation, and block_rsv_release_bytes handles a
> NULL pointer for block_rsv and if it's not NULL then it double checks
> the full status under a lock.
>
> So the unlocked and racy access is only advisory and in the worst case
> the block reserve is found !full and becomes full in the meantime,
> but properly handled.
>
> I've CCed Josef to review the analysis.
