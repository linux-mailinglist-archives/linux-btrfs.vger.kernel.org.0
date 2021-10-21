Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741B24364C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 16:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhJUOxi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 10:53:38 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60648 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhJUOxf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 10:53:35 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3A3491FDB7;
        Thu, 21 Oct 2021 14:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634827876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9fnPAfqHETDHYDIE3scy4zDiPpTPACrwMRJfpHFfGYY=;
        b=sbZQoxitl4PxtFqrnLjTtxNPYQMRlMY+74rWAnlDckbILlfG/CTEt3upWtIIiflARYkdKZ
        1x4N0/OMnfIlbw3fvrC9lumOtaABf6FlzCHRWQa+52XUKmWnCTcI8RXvh04iTKTwMTHi3e
        5hxQbHlX8KQGBl8O26xhq5hqeyKiafM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E315913BA5;
        Thu, 21 Oct 2021 14:51:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n2vrNGN+cWFDSAAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 21 Oct 2021 14:51:15 +0000
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
 <CAJCQCtR3upV0tEgdNOThMdQRE+fGH60vcbTeKagzXsw1wx9wMQ@mail.gmail.com>
 <y26ngqqg.fsf@damenly.su>
 <CAJCQCtScczmps7+NfNEObqOnsU64QHhjRRy0Fmj7W8z=ZJNK0g@mail.gmail.com>
 <CAJCQCtQuuzrzLDDZZ0jExeZ6RbDXH3wF7WFq02W77REMn4YJNA@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <2e18d933-a56e-198d-20c8-ab3038d3f390@suse.com>
Date:   Thu, 21 Oct 2021 17:51:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQuuzrzLDDZZ0jExeZ6RbDXH3wF7WFq02W77REMn4YJNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21.10.21 г. 17:48, Chris Murphy wrote:
> [  287.139760] Call trace:
> [  287.141784]  submit_compressed_extents+0x38/0x3d0
> [  287.145620]  async_cow_submit+0x50/0xd0
> [  287.148801]  run_ordered_work+0xc8/0x280
> [  287.152005]  btrfs_work_helper+0x98/0x250
> [  287.155450]  process_one_work+0x1f0/0x4ac
> [  287.161577]  worker_thread+0x188/0x504
> [  287.167461]  kthread+0x110/0x114
> [  287.172872]  ret_from_fork+0x10/0x18
> [  287.178558] Code: a9056bf9 f8428437 f9401400 d108c2fa (f9400356)
> [  287.186268] ---[ end trace 41ec405ced3786b6 ]---
> [61620.974232] audit: audit_backlog=2976 > audit_backlog_limit=64
> [61620.978698] audit: audit_lost=1 audit_rate_limit=0 audit_backlog_limit=64
> 
> 
> So it's at least 17 hours later since the splat. Is it worth sysrq+c
> now this long after? Or should I set it up like Nikolay suggests with
> kernel.panic_on_warn = 1? Maybe I should also put /var/crash on XFS to
> avoid problems dumping the kernel core file?

Doing sysrq+c would not have yileded any useful information it was a red
herring. In order to have actionable information the core dump needs to
be initiated from offending context, this means either having a BUG_ON
or a WARN which triggers the panic.

> 
> --
> Chris Murphy
> 
