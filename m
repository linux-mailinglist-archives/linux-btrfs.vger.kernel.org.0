Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91827437626
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Oct 2021 13:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbhJVLpU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Oct 2021 07:45:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49438 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbhJVLpT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Oct 2021 07:45:19 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AF34A212C5;
        Fri, 22 Oct 2021 11:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634902981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4j5OcygTfBnKyX46Ay1SwvvgzDUrs0FUL0XE+aWFEzU=;
        b=gIgmDb2NmEcJAQxE4GfuK7hkBqNDqAtMl9OVnCnIU3qY4ZtWgkV7aMQrpZwLcYpO0+vbB8
        ClldHAI4qrlyqvq6njuvEvoMPOUJEzjfw+hrhhgtbsSPD8nFeCQdFgwE8UAzi5lJ05lX8y
        y16wU7t2pEVuhevuBccSSUYiuh6yFMo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 69A3B13CD4;
        Fri, 22 Oct 2021 11:43:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0x1CF8WjcmFOKgAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 22 Oct 2021 11:43:01 +0000
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
From:   Nikolay Borisov <nborisov@suse.com>
To:     Chris Murphy <lists@colorremedies.com>, Su Yue <l@damenly.su>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <CAJCQCtSAWqeX_3kapDLr8AzNiGxyrNE7cO_tr3dM-syOKDsDgw@mail.gmail.com>
 <b1fccb42-da8a-c676-5f0b-1d80319e38ca@suse.com>
 <CAJCQCtSRxFuU4bTTa5_q6fAPuwf3pwrnUXM1CKgc+r69WSE9tQ@mail.gmail.com>
 <eae44940-48cb-5199-c46f-7db4ec953edf@suse.com>
 <CAJCQCtR+YQ2Xypz3KyHgD=TvQ8KcUsCf08YnhvLrVtgb-h9aMw@mail.gmail.com>
 <CAJCQCtQHugvMaeRc1A0EJnG4LDaLM5V=JzTO5FSU9eKQA8wxfA@mail.gmail.com>
 <CAJCQCtT12qUxYqJAf8q3t9cvbovoJdSG9kaBpvULQnwLw=rnMg@mail.gmail.com>
 <bl3mimya.fsf@damenly.su> <e75cf666-0b3a-9819-c6ac-a34835734bfb@gmx.com>
 <CAJCQCtT1+ocw-kQAKkX3wKjd4A1S1JV=wJre+UK5KY-weS33rQ@mail.gmail.com>
 <CAJCQCtTqqHFVH5YMOnRSesNs9spMb4QEPDa5wEH=gMDJ_u+yUA@mail.gmail.com>
 <7de9iylb.fsf@damenly.su>
 <CAJCQCtSUDSvMvbk1RmfTzBQ=UiZHrDeG6PE+LQK5pi_ZMCSp6A@mail.gmail.com>
 <35owijrm.fsf@damenly.su>
 <CAJCQCtS-QhnZm2X_k77BZPDP_gybn-Ao_qPOJhXLabgPHUvKng@mail.gmail.com>
 <ff911f0c-9ea5-43b1-4b8d-e8c392f0718e@suse.com>
Message-ID: <9e746c1c-85e5-c766-26fa-a4d83f1bfd34@suse.com>
Date:   Fri, 22 Oct 2021 14:43:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ff911f0c-9ea5-43b1-4b8d-e8c392f0718e@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22.10.21 г. 13:44, Nikolay Borisov wrote:
> 
> 
> On 22.10.21 г. 5:36, Chris Murphy wrote:
>> OK I have a vmcore file:
>> https://dustymabe.fedorapeople.org/bz2011928-vmcore/
>>
>> lib/modules/5.14.10-300.fc35.aarch64/vmlinuz
>> https://drive.google.com/file/d/1xXM8XGRi_Wzyupbm4MSNteF0rwUzO4GE/view?usp=sharing
>>
> 
> So the problem is we have a null inode:
> 
> 
> crash> struct async_chunk ffff00012a78eb08
> struct async_chunk {
>   inode = 0x0,
>   locked_page = 0xfffffc000508c240,
>   start = 0,
>   end = 4095,
>   write_flags = 0,
>   extents = {
>     next = 0xffff00012a78eb30,
>     prev = 0xffff00012a78eb30
>   },
>   blkcg_css = 0x0,
>   work = {
>     func = 0xffffd7c4c03c05c0 <async_cow_start>,
>     ordered_func = 0xffffd7c4c03c1bf0 <async_cow_submit>,
>     ordered_free = 0xffffd7c4c03be2e0 <async_cow_free>,
>     normal_work = {
>       data = {
>         counter = 256
>       },
>       entry = {
>         next = 0xffff00012a78eb68,
>         prev = 0xffff00012a78eb68
>       },
>       func = 0xffffd7c4c03f9e84 <btrfs_work_helper>
>     },
>     ordered_list = {
>       next = 0xffff00012a78ee80,
>       prev = 0xffff0000c6d83510
>     },
>     wq = 0xffff0000c6d83500,
>     flags = 3
>   },
>   pending = 0xffff00012a78eb00
> }
> 
> 
> But this makes no sense since before submit_compressed_extents is called
> we have an explicit check for async_hunk->inode presence but AFAICS this
> is not done in a concurrent context. So this either leaves some hw issue
> or some race which manifests due to ARM's weak mm.

I also looked at the assembly generated in async_cow_submit to see if
anything funny happens while the async_chunk->inode check is performed -
everything looks fine. Also given that the extents list is empty and the
inode is NULL I'd assume that the "write" side is also correct i.e the
code in async_cow_start. This pretty much excludes a codegen problem.

Chris can you add the following line in submit_compressed_extents right
before the BTRFS_I() function is called:

 WARN_ON(!async_chunk->inode);

And re-run the workload again?


> 
>>
>> --
>> Chris Murphy
>>
> 
