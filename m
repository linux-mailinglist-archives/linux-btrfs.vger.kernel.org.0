Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845104BE455
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Feb 2022 18:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377789AbiBUO2L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Feb 2022 09:28:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377781AbiBUO2K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Feb 2022 09:28:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946372196;
        Mon, 21 Feb 2022 06:27:47 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 49F9D1F391;
        Mon, 21 Feb 2022 14:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645453666;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NjZBMF4KSfSjtXSNJFRt7R0dNqUjE2BB19wTYJv5KjU=;
        b=sGUkyHg+Ij3/UmqJYo8eqn9ulHZ7Pdn+Ld4XrC7DJdPgCs1xN9E/oDyx8Sj+gj++5QHiVj
        vJKH9iS3xKYhlkyaB/2rdhXPEMv73PBVUqEdy2yrWj+zNl6NNhpgQAnCi5hwnThkU1Dfkg
        YwfEd5sEW1Jnfv1+VF/SQQxZ7Si8mJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645453666;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NjZBMF4KSfSjtXSNJFRt7R0dNqUjE2BB19wTYJv5KjU=;
        b=f6kn75rSbv3F33bIJFHz0JfOB9u7knYyqqNgW0j1mrecOrQIg/atsgq14CM8pKIdurHWiv
        R+PC9tbTpUdKQzBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0CF18A3B81;
        Mon, 21 Feb 2022 14:27:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 947CCDA823; Mon, 21 Feb 2022 15:23:58 +0100 (CET)
Date:   Mon, 21 Feb 2022 15:23:58 +0100
From:   David Sterba <dsterba@suse.cz>
To:     syzbot <syzbot+087b7effddeec0697c66@syzkaller.appspotmail.com>
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in kthread_bind_mask
Message-ID: <20220221142358.GE12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        syzbot <syzbot+087b7effddeec0697c66@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000005ca92705d877448c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000005ca92705d877448c@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Feb 20, 2022 at 10:27:23AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c5d9ae265b10 Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11daf74a700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=da674567f7b6043d
> dashboard link: https://syzkaller.appspot.com/bug?extid=087b7effddeec0697c66
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+087b7effddeec0697c66@syzkaller.appspotmail.com
> 
> BTRFS info (device loop3): disk space caching is enabled
> BTRFS info (device loop3): has skinny extents
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 10327 at kernel/kthread.c:525 __kthread_bind_mask kernel/kthread.c:525 [inline]

 520 static void __kthread_bind_mask(struct task_struct *p, const struct cpumask *mask, unsigned int state)
 521 {
 522         unsigned long flags;
 523
 524         if (!wait_task_inactive(p, state)) {
 525                 WARN_ON(1);
 526                 return;
 527         }

That seems to be some internal task state inconsistency.
