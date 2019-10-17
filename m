Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1780BDB60B
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 20:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438617AbfJQSXp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Oct 2019 14:23:45 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:60842 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbfJQSXo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Oct 2019 14:23:44 -0400
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 1A83B142BC3; Thu, 17 Oct 2019 19:23:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1571336622;
        bh=XChpu6wfrz7X2GUcDYOQAvGAiLwNoSl8diLRPIiUXf4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Zj8ETuiPNUqXV9NurFgKX42Q7C5mCNWDBb1PGK7y39RgzLnnzBwL4gH//igJagjhu
         ufbXOXHuyE6/MtlkfjckiIEnaGfUMrY1f86L+8Hs5PkEN6kvwAzKng5JLYxa+CBfNy
         G2Yae3FBcYaplWcu8a3mLGT7az/tIjQER8NFAF5TUzXeCRQA9//InjGRjUzq+niGFd
         JGQ5wIGh8JauPs8GYERtqiMegpUgA5VKRjqeQ9L6X3w9f3ocN7WbojGlsX/Tq/1a2K
         MutddRrUBgtlz6OmEHPYxiXLI6JqLqqJZo0BVFshLqaXpcJjDkwopXnw6wTf30eU81
         9YKHkXlv1Xpqg==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 2C1F0142BC2;
        Thu, 17 Oct 2019 19:23:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1571336621;
        bh=XChpu6wfrz7X2GUcDYOQAvGAiLwNoSl8diLRPIiUXf4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QykLsJCW59xnWeu63T8fQTHZNAFGNim/Rfix4bT/RFmfsGF3rabxNk2qMrLbqsUl5
         xr1IrzWwDtbSDKxyf3kuwUidrojmY5ATAyu7qSbu/3PsWlX7A+3KL2IrgHRrpvvtMB
         qDwimZDEL9KfPEhgdy5ivh3Rj8EIhvAW8WfbLjQvh4WYEtYkQ8FFEL3bDl16ZUOMtq
         Xon0W4EZLikEygOj2uusBS7i+pq7UA2dGFXE/vR4I9zQDbpNBwq1jXjcWrkH8bXusy
         yNxtyqzr5GoynC1FC+sQ/8cbmsYeY+h8vLTIVkonCgAqtdC2uGPcjLSkao7bmO/zOY
         kkqHFJ9fZhv6g==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id E147E5B973;
        Thu, 17 Oct 2019 19:23:40 +0100 (BST)
Subject: Re: MD RAID 5/6 vs BTRFS RAID 5/6
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <b665710c-5171-487b-ce38-5ea7075492e4@liland.com>
 <CACa3q1wUmgY9uTygYFVBer=QgZjtwX2NOvVT68kAYKAgoLpXRg@mail.gmail.com>
 <CAJCQCtR=NQd6uovvAhuTdxRNJtnMFDtkTma9u8-Ep9Nq+YQY=A@mail.gmail.com>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <be2aa15e-0539-219f-c2d6-fdb01297351e@cobb.uk.net>
Date:   Thu, 17 Oct 2019 19:23:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtR=NQd6uovvAhuTdxRNJtnMFDtkTma9u8-Ep9Nq+YQY=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/10/2019 16:57, Chris Murphy wrote:
> On Wed, Oct 16, 2019 at 10:07 PM Jon Ander MB <jonandermonleon@gmail.com> wrote:
>>
>> It would be interesting to know the pros and cons of this setup that
>> you are suggesting vs zfs.
>> +zfs detects and corrects bitrot (
>> http://www.zfsnas.com/2015/05/24/testing-bit-rot/ )
>> +zfs has working raid56
>> -modules out of kernel for license incompatibilities (a big minus)
>>
>> BTRFS can detect bitrot but... are we sure it can fix it? (can't seem
>> to find any conclusive doc about it right now)
> 
> Yes. Active fixups with scrub since 3.19. Passive fixups since 4.12.

Presumably this is dependent on checksums? So neither detection nor
fixup happen for NOCOW files? Even a scrub won't notice because scrub
doesn't attempt to compare both copies unless the first copy has a bad
checksum -- is that correct?

> 
>> I'm one of those that is waiting for the write hole bug to be fixed in
>> order to use raid5 on my home setup. It's a shame it's taking so long.
> 
> For what it's worth, the write hole is considered to be rare.
> https://lwn.net/Articles/665299/
> 
> Further, the write hole means a) parity is corrupt or stale compared
> to data stripe elements which is caused by a crash or powerloss during
> writes, and b) subsequently there is a missing device or bad sector in
> the same stripe as the corrupt/stale parity stripe element. The effect
> of b) is that reconstruction from parity is necessary, and the effect
> of a) is that it's reconstructed incorrectly, thus corruption. But
> Btrfs detects this corruption, whether it's metadata or data. The
> corruption isn't propagated in any case. But it makes the filesystem
> fragile if this happens with metadata. Any parity stripe element
> staleness likely results in significantly bad reconstruction in this
> case, and just can't be worked around, even btrfs check probably can't
> fix it. If the write hole problem happens with data block group, then
> EIO. But the good news is that this isn't going to result in silent
> data or file system metadata corruption. For sure you'll know about
> it.

If I understand correctly, metadata always has checksums so that is true
for filesystem structure. But for no-checksum files (such as nocow
files) the corruption will be silent, won't it?

Graham
