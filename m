Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA13397918
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jun 2021 19:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbhFARcR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Jun 2021 13:32:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53118 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbhFARcQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Jun 2021 13:32:16 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 53B3C1FD48;
        Tue,  1 Jun 2021 17:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622568634;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B7eJCORmTBEMzXQNN3OoaOrtx2vgCfr3M+vVxtmtTLU=;
        b=fmY0dRua9mfGxlgBGFJnmf/A/C5hVlf8r5cjsU19G/iX2+5vlgWgTa+Qj6OW+cdSPxuzxg
        FBmsS9DgY1kDvo8NIK2CnukMXBiGu3KL/rN7g5bC/CmlR9tuedzesbUnIOKkFUqKSW2tEk
        LM9FsxhuBTLeloWHV0KmHlFqNHRfcf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622568634;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B7eJCORmTBEMzXQNN3OoaOrtx2vgCfr3M+vVxtmtTLU=;
        b=mv3gng7iuw6cv6Q/Cw7njbW8BI/geWlTNfkcUh+QO4B7lr3wpc6rWBcFBNW86HkoB3KFlM
        S3sQ/fTI9dDRTCBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2A542A3B87;
        Tue,  1 Jun 2021 17:30:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 36009DA734; Tue,  1 Jun 2021 19:27:54 +0200 (CEST)
Date:   Tue, 1 Jun 2021 19:27:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+a6bf271c02e4fe66b4e4@syzkaller.appspotmail.com>,
        Chris Mason <clm@fb.com>, dsterba@suse.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] kernel BUG in assertfail
Message-ID: <20210601172754.GJ31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+a6bf271c02e4fe66b4e4@syzkaller.appspotmail.com>,
        Chris Mason <clm@fb.com>, dsterba@suse.com,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <000000000000f9136f05c39b84e4@google.com>
 <21666193-5ad7-2656-c50f-33637fabb082@suse.com>
 <CACT4Y+bqevMT3cD5sXjSv9QYM_7CwjYmN_Ne5LSj=3-REZ+oTw@mail.gmail.com>
 <224f1e6a-76fa-6356-fe11-af480cee5cf2@suse.com>
 <CACT4Y+ZJ7Oi9ChXJNuF_+e4FRnN1rJBde4tsjiTtkOV+MM-hgA@mail.gmail.com>
 <fcf25b03-e48e-8cda-3c87-25c2c3332719@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fcf25b03-e48e-8cda-3c87-25c2c3332719@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 31, 2021 at 12:27:05PM +0300, Nikolay Borisov wrote:
> On 31.05.21 г. 12:09, Dmitry Vyukov wrote:
> > On Mon, May 31, 2021 at 10:57 AM Nikolay Borisov <nborisov@suse.com> wrote:
> >> On 31.05.21 г. 11:55, Dmitry Vyukov wrote:
> >>> On Mon, May 31, 2021 at 10:44 AM 'Nikolay Borisov' via syzkaller-bugs
> >>> <syzkaller-bugs@googlegroups.com> wrote:
> >>>> On 31.05.21 г. 10:53, syzbot wrote:
> >>>>> Hello,
> >>>>>
> >>>>> syzbot found the following issue on:
> >>>>>
> >>>>> HEAD commit:    1434a312 Merge branch 'for-5.13-fixes' of git://git.kernel..
> >>>>> git tree:       upstream
> >>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=162843f3d00000
> >>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=9f3da44a01882e99
> >>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=a6bf271c02e4fe66b4e4
> >>>>>
> >>>>> Unfortunately, I don't have any reproducer for this issue yet.
> >>>>>
> >>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >>>>> Reported-by: syzbot+a6bf271c02e4fe66b4e4@syzkaller.appspotmail.com
> >>>>>
> >>>>> assertion failed: !memcmp(fs_info->fs_devices->fsid, fs_info->super_copy->fsid, BTRFS_FSID_SIZE), in fs/btrfs/disk-io.c:3282
> >>>>
> >>>> This means a device contains a btrfs filesystem which has a different
> >>>> FSID in its superblock than the fsid which all devices part of the same
> >>>> fs_devices should have. This can happen in 2 ways - memory corruption
> >>>> where either of the ->fsid member are corrupted or if there was a crash
> >>>> while a filesystem's fsid was being changed. We need more context about
> >>>> what the test did?
> >>>
> >>> Hi Nikolay,
> >>>
> >>> From a semantic point of view we can consider that it just mounts /dev/random.
> >>> If syzbot comes up with a reproducer it will post it, but you seem to
> >>> already figure out what happened, so I assume you can write a unit
> >>> test for this.
> >>
> >> Well no, under normal circumstances this shouldn't trigger. So if syzbot
> >> is doing something stupid as mounting /dev/random then I don't see a
> >> problem here. The assert is there to catch inconsistencies during normal
> >> operation which doesn't seem to be the case here.
> > 
> > Does this mean that CONFIG_BTRFS_ASSERT needs to be disabled in any testing?
> > What is it intended for? Or it can only be enabled when mounting known
> > good images? But then I assume even btrfs unit tests mount some
> > invalid images, so it would mean it can't be used even  during unit
> > testing?
> > 
> > Looking at the output of "grep ASSERT fs/btrfs/*.c" it looks like most
> > of these actually check for something that "must never happen". E.g.
> > some lists/pointers are empty/non-empty in particular states. And
> > "must never happen" checks are for testing scenarios...
> > 
> > Taking this particular FSID mismatch assert, should such corrupted
> > images be mounted for end users? Should users be notified? Currently
> > they are mounted and users are not notified, what is the purpose of
> > this assertion?
> > 
> > Perhaps CONFIG_BTRFS_ASSERT needs to be split into "must never happen"
> > checks that are enabled during testing and normal if's with pr_err for
> > user notifications?
> 
> After going through the code you've convinced me. I just sent a patch
> turning the 2 debugging asserts into full-fledged checks in
> validate_super. So now the correct behavior is to prevent mounting of
> such images.  How can I force syzbot to retest with the given patch applied?

Let me answer the points from the discussions:

- mounting /dev/random should never lead to a crash, this is effectively
  the same as crafting data that would get past the sanity checks

- the behaviour regarding assertions should not affect testing, same
  result with or without it

- input validation - for a filesystem everything that comes from the
  disk is input, so what we want to do with the data is unconditional
  runtime validation

- the 'must never happen' is two fold, depending what's the answer, but
  we namely use it to verify invariants and catch developer errors, eg.
  adding an object to list and then later assserting that it's there;
  excluding the cosmic rays type of bugs, the remaining reason is that
  the assert should be turned into a runtime check
