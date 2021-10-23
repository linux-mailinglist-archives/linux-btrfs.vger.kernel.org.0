Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D312C43830C
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Oct 2021 12:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhJWKMi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Oct 2021 06:12:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34502 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhJWKMh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Oct 2021 06:12:37 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B81FF21961;
        Sat, 23 Oct 2021 10:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634983817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L+YuMhNQ8yWz/x0r4XI9OAcaAghuZAgWukacs9DP7j0=;
        b=TAZYv5FwU93lDOrq8p4IYks3IhezUk2qXsRdbVbyZ25Jwkb/KU1r9aYaGwrOaIvQ0TU2WK
        WhGi0/tEZGCG805HyATiUk2yUxEWCOyBSW5NbRSvVqoJ/mC1RgKYR2Ngsk3qt9gUn5sKFy
        bHkZ4YctBrr2KHDhuTRIS9zUaDK6sbo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6FC601332F;
        Sat, 23 Oct 2021 10:10:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MbbCF4nfc2E9VAAAMHmgww
        (envelope-from <nborisov@suse.com>); Sat, 23 Oct 2021 10:10:17 +0000
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Su Yue <l@damenly.su>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
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
 <9e746c1c-85e5-c766-26fa-a4d83f1bfd34@suse.com>
 <CAJCQCtTHPAHMAaBg54Cs9CRKBLD9hRdA2HwOCBjsqZCwWBkyvg@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <91185758-fdaf-f8da-01eb-a9932734fc09@suse.com>
Date:   Sat, 23 Oct 2021 13:09:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTHPAHMAaBg54Cs9CRKBLD9hRdA2HwOCBjsqZCwWBkyvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22.10.21 г. 20:18, Chris Murphy wrote:
> On Fri, Oct 22, 2021 at 7:43 AM Nikolay Borisov <nborisov@suse.com> wrote:
>>
>> I also looked at the assembly generated in async_cow_submit to see if
>> anything funny happens while the async_chunk->inode check is performed -
>> everything looks fine. Also given that the extents list is empty and the
>> inode is NULL I'd assume that the "write" side is also correct i.e the
>> code in async_cow_start. This pretty much excludes a codegen problem.
>>
>> Chris can you add the following line in submit_compressed_extents right
>> before the BTRFS_I() function is called:
>>
>>  WARN_ON(!async_chunk->inode);
>>
>> And re-run the workload again?
> 
> I'll look into how we can do this. I build kernels per
> https://kernelnewbies.org/KernelBuild but maybe it's better to do it
> within Fedora infrastructure to keep things more the same and
> reproducible? I'm not really sure, so I've asked in the bug
> https://bugzilla.redhat.com/show_bug.cgi?id=2011928#c41 - if you have
> two cents to add let me know in this thread or that one.
> 
> Any other configs to change while we're building a new kernel?
> CONFIG_BTRFS_ASSERT=y ?
> 
> inode.c
> 849:static noinline void submit_compressed_extents(struct async_chunk
> *async_chunk)
> 850-{
> 851-    struct btrfs_inode *inode = BTRFS_I(async_chunk->inode);
> 
> becomes
> 
> 849:static noinline void submit_compressed_extents(struct async_chunk
> *async_chunk)
> 850-{
> 851-    WARN_ON(!async_chunk->inode);
> 852-    struct btrfs_inode *inode = BTRFS_I(async_chunk->inode);
> 
> ?
> (I'm looking at 5.15-rc6)

Yes.

> 
> 
> 
