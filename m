Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC63D432B82
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 03:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhJSBj5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 21:39:57 -0400
Received: from eu-shark1.inbox.eu ([195.216.236.81]:47724 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJSBj4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 21:39:56 -0400
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 2750E6C0077B;
        Tue, 19 Oct 2021 04:37:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1634607463; bh=1YZb09L3EXbrBz/UPtG+6W3Rl8mpCYaJeQrzFrGQHX8=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=KHmT0CCTf2dWsN0tKbZopCLTJKN7bJh1xd7UWFKoF+gUnqOrJpKSW3E5PyQtihHX0
         MIiU7JlG8dmitJqpljj2lbFEjMSeqTG3hJj1l4xemEZv4u61SYKArO6Ow1JFteFX28
         bLbz0vIB5Bf/HvbVW8xtOZfLg0oHbbbqE18tSUnw=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 18A6F6C00777;
        Tue, 19 Oct 2021 04:37:43 +0300 (EEST)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id sn2HK_kCX6Pd; Tue, 19 Oct 2021 04:37:43 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id D28426C00774;
        Tue, 19 Oct 2021 04:37:42 +0300 (EEST)
Received: from nas (unknown [121.237.225.130])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id C49141BE01C4;
        Tue, 19 Oct 2021 04:37:40 +0300 (EEST)
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
User-agent: mu4e 1.7.0; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
Date:   Tue, 19 Oct 2021 09:24:05 +0800
In-reply-to: <CAJCQCtTqqHFVH5YMOnRSesNs9spMb4QEPDa5wEH=gMDJ_u+yUA@mail.gmail.com>
Message-ID: <7de9iylb.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 6N1mkZY9ZDPk1R69IQ/TBAA3rihBX+zh/fvJoxAq4meDUSOFfEkTUhOwg250SGK5vT8X
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Mon 18 Oct 2021 at 14:24, Chris Murphy 
<lists@colorremedies.com> wrote:

> I've got kdump.service setup and ready, but I'm not sure about 
> two things:
>
> 1.
> $ git clone https://github.com/kdave/btrfs-devel
> Cloning into 'btrfs-devel'...
> fatal: error reading section header 'shallow-info'
>
> 2.
> How to capture the kernel core dump, if I need to do anything to
> trigger it other than reproducing the reported problem or if 
> I'll need
> to do sysrq+c or other.
>
No need to do other things, you can test if kdump works by
triggering a panic using sysrq.
Since it's just a kernel panic, rebuilding kernel rpm to reproduce 
is
enough.

Note: parameter crashkernel can be adjusted if there was no vmcore
produced.

--
Su

> If it's faster, I can also get any developer access to the VM...
