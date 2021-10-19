Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FC84342BC
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 03:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhJTBM1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 21:12:27 -0400
Received: from eu-shark1.inbox.eu ([195.216.236.81]:43230 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhJTBM0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 21:12:26 -0400
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 122BD6C007F0;
        Wed, 20 Oct 2021 04:10:12 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1634692212; bh=tDh42Yu82z1BtKImxfA0ZJprj6XGNUNgtvu/86I/Ht4=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=GX0WJlA54aqFfKTC1pvznsoDli3bOsZIuePzNlVikuGR6CqWeWooj/utbRRQLvk0D
         p3M8Y1AQIn2mmSTz0azCm1V/lCIkkXvTRua9hE/dEnR3QLLbDmERTs8YmBVMyI4vMu
         4Zmp1RqEaBZCPs8dPTx8OTWBgCDoMDpgzRi60F5M=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 00BE06C007EA;
        Wed, 20 Oct 2021 04:10:12 +0300 (EEST)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id j9_o5FQVtuqj; Wed, 20 Oct 2021 04:10:11 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id C58F36C007DC;
        Wed, 20 Oct 2021 04:10:11 +0300 (EEST)
Received: from nas (unknown [121.237.227.114])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id CE1471BE01C4;
        Wed, 20 Oct 2021 04:10:09 +0300 (EEST)
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <da57d024-e125-bcea-7ac3-4e596e5341a2@suse.com>
 <debf9d63-0068-84db-dcd4-1d923742f989@gmx.com>
 <CAJCQCtSsLSwtNTrUKq_4Rs0tauT45iSA1+AkGWnS9Nmkb=0oWg@mail.gmail.com>
 <9b153cca-2d9a-e217-a83f-1a8e663fc587@suse.com>
 <CAJCQCtTAHmvwmypAgnLVr-wmuJpOxnmXzpxy-UdHcHO8L+5THw@mail.gmail.com>
 <e18c983f-b197-4fc5-8030-cc4273eda881@suse.com>
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
User-agent: mu4e 1.7.0; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
Date:   Wed, 20 Oct 2021 07:42:00 +0800
In-reply-to: <CAJCQCtSUDSvMvbk1RmfTzBQ=UiZHrDeG6PE+LQK5pi_ZMCSp6A@mail.gmail.com>
Message-ID: <35owijrm.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: +dBm1NUOBkfEh1+jQmXcBgEprShOQuzk//vYoxBcgBmOPC+CfkkPWBO2mWpqPg+1zUEX
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Tue 19 Oct 2021 at 14:26, Chris Murphy 
<lists@colorremedies.com> wrote:

> Still working on the kernel core dump and should have something 
> soon
> (I blew up the VM and had to start over); should I run the 
> 'crash'
> command on it afterward? Or upload the dump file to e.g. google 
> drive?
>
Dump file and vmlinu[zx] kernel file are needed.

> Also, I came across this ext4 issue happening on aarch64 
> (openstack
> too), but I have no idea if it's related. And if so, whether it 
> means
> there's a common problem outside of btrfs?
> https://github.com/coreos/fedora-coreos-tracker/issues/965
>
Already noticed the thing. Let's wait for the vmcore.

Any idea, Qu?

--
Su
> I mentioned this bug report up thread:
> https://bugzilla.redhat.com/show_bug.cgi?id=1949334
> but to summarize: it has the same btrfs call trace we've been 
> looking
> at in this email thread, but it's NOT on openstack, but actual
> hardware (amberwing).
