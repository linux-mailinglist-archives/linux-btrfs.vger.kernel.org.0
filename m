Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADFD69313B
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Feb 2023 14:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjBKNZJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 11 Feb 2023 08:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBKNZJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Feb 2023 08:25:09 -0500
Received: from mail.lichtvoll.de (luna.lichtvoll.de [194.150.191.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B2922A07
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Feb 2023 05:25:07 -0800 (PST)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 4338E5EE389;
        Sat, 11 Feb 2023 14:25:06 +0100 (CET)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     waxhead@dirtcellar.net
Subject: Re: Never balance metadata?
Date:   Sat, 11 Feb 2023 14:25:05 +0100
Message-ID: <2622818.BddDVKsqQX@lichtvoll.de>
In-Reply-To: <c7c1eda1-d0a9-c924-2900-9158c34fc016@gmail.com>
References: <ad4de975-3d5f-4dbb-45a5-795626c53c61@dirtcellar.net>
 <1755726.VLH7GnMWUR@lichtvoll.de>
 <c7c1eda1-d0a9-c924-2900-9158c34fc016@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Andrei Borzenkov - 11.02.23, 12:42:49 CET:
> Balancing creates larger free space pool which allows large writes
> which is faster and requires less metadata. If every second 4K block
> in each chunk is free, you have exactly 50% free space like if half
> of chunks are free. But in the former case each write will be split
> into 4K pieces, each 4K becomes separate extent and needs additional
> metadata. Whether you will actually observe impact depends heavily on
> your workload.

Okay so it can save metadata size. And on a full BTRFS filesystem with no 
unallocated space it can reduce fragmentation of new writes. I get that 
much.

But what if I have for example

% btrfs filesystem usage -T /home
Overall:
    Device size:                 400.00GiB
    Device allocated:            300.02GiB
    Device unallocated:           99.98GiB
[…]
    Free (estimated):            113.60GiB      (min: 113.60GiB)
    Free (statfs, df):           113.60GiB
[…]

(metadata usage is 3.52GiB of 5.01 GiB)

on a filesystem that is heavily written to and

% btrfs filesystem usage -T /some/dir
Overall:
    Device size:                   1.20TiB
    Device allocated:              1.19TiB
    Device unallocated:            8.78GiB
[…]
    Free (estimated):             44.77GiB      (min: 44.77GiB)
    Free (statfs, df):            44.77GiB
[…]

(metadata usage is 2.88GiB of 4.01 GiB)

on a filesystem that is used mostly for the purpose of placing larger 
files there to archive them? Both are using single profiles. 

Why would I balance those? They are stored on the same 2TB NVMe SSD in 
this laptop and I did not yet see any performance related issues with 
them so far.

What I went with is this: If it is heavily written to leave enough space 
free to begin with. And if its just for storing larger files without 
receiving any regular writes by applications then I can fill it a bit 
more. Just similar to what I would do with XFS filesystem for example as 
well. Having "/home" on a 95% full XFS filesystem would not be a good 
idea either – mind you I had something like that with a BTRFS filesystem 
before and before kernel 4.5 or 4.6 actually sometimes the kernel came 
to a halt while with BTRFS searching for free space. These some times 
were related to no unallocated space free and then I balanced until next 
time it happened, but since kernel 4.5 or 4.6 this issue was gone for 
good. And before that as long as unallocated space was free it was 
working fine.

So if I plan like that, I still do not get why I would balance my 
filesystems regularly. And if I do not plan like that and let /home usage 
grow to 95% or even more… I am not sure how much "relief" balancing 
would really give to the filesystem. Is it more than the amount of work 
done during the regular balances?

Well probably that is the "depends heavily on your workload" thing you 
wrote about :)

Thanks,
-- 
Martin


