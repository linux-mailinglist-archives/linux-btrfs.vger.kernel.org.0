Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC6B380A78
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 15:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbhENNkj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 May 2021 09:40:39 -0400
Received: from eu-shark1.inbox.eu ([195.216.236.81]:46266 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhENNki (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 May 2021 09:40:38 -0400
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id C439C6C00679;
        Fri, 14 May 2021 16:39:25 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1620999565; bh=OoeRIQxOMKk9OgeySejE1KkccCc5yd0InyLOOKYO/8I=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=sCCUeLj3oWXf8dYqzgRaWdt6DPmGEflPRM0JqC5K33R5O90SvnMj0s92BSxHaIKSI
         uNNsA3Ry8DULfUZXT21+2ere49bYFay2LqtyhII8iYZDu2X4Jwx96nMYKrbJtDFk4l
         b1MuRd0XZvD2LAPRtgKqRyIehiI4TtdvQFy3mJWM=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id B6BEF6C00663;
        Fri, 14 May 2021 16:39:25 +0300 (EEST)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id 6L5vlgoI3L-m; Fri, 14 May 2021 16:39:25 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 3CD666C00606;
        Fri, 14 May 2021 16:39:25 +0300 (EEST)
Received: from nas (unknown [153.127.9.202])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id A5F9A1BE00F0;
        Fri, 14 May 2021 16:39:22 +0300 (EEST)
References: <20210511042501.900731-1-l@damenly.su>
 <20210512140135.GR7604@twin.jikos.cz> <k0o3lb1d.fsf@damenly.su>
 <20210514112243.GT7604@suse.cz>
User-agent: mu4e 1.5.8; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: do not BUG_ON if btrfs_add_to_fsid
 succeeded to write superblock
Date:   Fri, 14 May 2021 21:23:12 +0800
In-reply-to: <20210514112243.GT7604@suse.cz>
Message-ID: <eee9l9iy.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 6N1mlpY3ejOlj12/QnnZGw8prSpLQI+R9ua80BxblHj7NSiYDTYAEE/3gR8FQA/Gog==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Fri 14 May 2021 at 19:22, David Sterba <dsterba@suse.cz> wrote:

> On Thu, May 13, 2021 at 08:37:29AM +0800, Su Yue wrote:
>>
>> On Wed 12 May 2021 at 22:01, David Sterba <dsterba@suse.cz> 
>> wrote:
>>
>> > On Tue, May 11, 2021 at 12:25:01PM +0800, Su Yue wrote:
>> >> Commit 8ef9313cf298 ("btrfs-progs: zoned: implement
>> >> log-structured
>> >> superblock") changed to write BTRFS_SUPER_INFO_SIZE bytes to
>> >> device.
>> >> The before num of bytes to be written is sectorsize.
>> >> It causes mkfs.btrfs failed on my 16k pagesize kvm:
>> >
>> > What architecture is that?
>> >
>> The host chip is Apple m1 so it's arm64 but only supporting 16k 
>> and 4k
>> pagesize. Since btrfs subpage work cares 64k pagesize for now, 
>> I
>> usually run xfstests with 16k pagesize and 16k sectorsize. So 
>> far, so
>> good.
>
> Interesting, what's the distro? I haven't found one that would 
> be
> pre-built with 16k pages so I assume it's built from scratch. 
> Among all
>

Right, I initially booted the kvm using Ubuntu kernel built with 
4k
pages then compiled 16k pagesize kernel manully.

--
Su
> the page sizes we've seen so far 4k is almost everywhere, 64k is 
> ppc and
> arm (both native), and sparc has 8k. 16k is a new one, though I 
> don't
> think it would catch something we haven't seen so far it adds a 
> bit to
> the CPU capabilities coverage.
>

