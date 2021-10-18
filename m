Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9F8431787
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Oct 2021 13:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhJRLjG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 07:39:06 -0400
Received: from eu-shark1.inbox.eu ([195.216.236.81]:58426 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhJRLjF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 07:39:05 -0400
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 8C1C96C006B5;
        Mon, 18 Oct 2021 14:36:53 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1634557013; bh=JfdzXZKXfkwbmcztWdVVHAV/miQkeB7kDeVXkUa6mPs=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=TxB8qH4PUMHvfU6AuqvXZWJi5zYWJ6S9fvHM8QYlvbtLQBHSjxzH6KXCkilQSKXjj
         UGgEFoe9CB3hOQKT0tTPOb5PtFOuKfhnqEaBIghQ2Rylmk/wr9OZ+eZa7Qxf7NrCcM
         D4Ub3Y/CzhFkimnwjDuPfEeCVrr10ozb5TngkfH4=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 7D9B96C0064C;
        Mon, 18 Oct 2021 14:36:53 +0300 (EEST)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id nofNrepfqVDD; Mon, 18 Oct 2021 14:36:53 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 431526C005AB;
        Mon, 18 Oct 2021 14:36:53 +0300 (EEST)
Received: from nas (unknown [121.237.225.130])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 64FC41BE00C8;
        Mon, 18 Oct 2021 14:36:51 +0300 (EEST)
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
User-agent: mu4e 1.7.0; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
Date:   Mon, 18 Oct 2021 19:32:08 +0800
In-reply-to: <CAJCQCtT12qUxYqJAf8q3t9cvbovoJdSG9kaBpvULQnwLw=rnMg@mail.gmail.com>
Message-ID: <bl3mimya.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 6N1mkZY9ZDPk1R69MAjTdngr1kpEXe/k5eW51wNbnn7kMC2EYip5XRGxnW10RX+5ujkX
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Sun 17 Oct 2021 at 21:57, Chris Murphy 
<lists@colorremedies.com> wrote:

> Any update on this problem and whether+what more info is needed?
>
It's interesting the OOPS only happens in openstack environment.
Is it possiable to provide the kernel core dump?

--
Su
> Thanks,
> Chris Murphy
>
> On Wed, Oct 13, 2021 at 3:21 PM Chris Murphy 
> <lists@colorremedies.com> wrote:
>>
>> From the downstream bug:
>>
>> [root@openqa-a64-worker03 adamwill][PROD]#
>> /usr/src/kernels/5.14.9-300.fc35.aarch64/scripts/faddr2line
>> /usr/lib/debug/lib/modules/5.14.9-300.fc35.aarch64/vmlinux
>> submit_compressed_extents+0x38
>> submit_compressed_extents+0x38/0x3d0:
>> submit_compressed_extents at
>> /usr/src/debug/kernel-5.14.9/linux-5.14.9-300.fc35.aarch64/fs/btrfs/inode.c:845
>> [root@openqa-a64-worker03 adamwill][PROD]#
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=2011928#c26
>>
>> Also curious: this problem is only happening in openstack
>> environments, as if the host environment matters. Does that 
>> make
>> sense?
>>
>>
>> --
>> Chris Murphy
