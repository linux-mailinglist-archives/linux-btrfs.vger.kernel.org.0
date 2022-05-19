Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EC552D0A2
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 12:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbiESKfW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 06:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236436AbiESKfT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 06:35:19 -0400
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C7B579A4
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 03:35:16 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 9B13E9B806; Thu, 19 May 2022 11:35:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1652956512;
        bh=qImytQ0vrgL3GlDxi8th+F0eEDCZedEwLB0ujPreQ7I=;
        h=Date:From:Subject:To:References:In-Reply-To:From;
        b=yO/azRBbeGSvOhoFGm3gQoTD8BIoXKi2G39Qjbt3Ab4bM+UDMexZzAqxF5LVBmlV/
         uS5pssnUcxqCKvfRnwyZEIJl2BVkHjt4wChyJsDlntAuHhvknmIkmD/MCCwV395vUO
         5BdELe+vPgpAFUGRTlvd3HBsACf0e8jvqLjkK6eDXNLaNdp+g1fB3G0dedGbJ3t/Jk
         rq83bF40RxIPba6mAickKYnLSOzIanmMh9YmXy0cgVItnufX+b8HN3fFjBM1SH9xKu
         ygNHe6h8uUzj1mGNzoQFFJSlKBLHs+0v29QO7aVDHJmRr6M7UDLNDJ1M0CWJpCTUhd
         teYajAtjNtb0A==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id DC92B9B6B1;
        Thu, 19 May 2022 11:34:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1652956492;
        bh=qImytQ0vrgL3GlDxi8th+F0eEDCZedEwLB0ujPreQ7I=;
        h=Date:From:Subject:To:References:In-Reply-To:From;
        b=nQnDdPPEfIpZV9yn1eM1G2fikpZEvdiuF3k9vLFSJ6llpeLOG7GXyN1+bBmlwVVcD
         i/jKXcuISxQyLxrEWGbmZm+CUyUhQfeKM1TWqZhczL8kucg/Xf7AovYVlwVg4Fr/XA
         y7fhSXLCvenV0kyqOo90QrjqlEACBNR8iRcfcj5Fc2u1uVsScvipJnvarphSwPKiz7
         Cur7fa7YfT6hKb4Bt7bq7JW9K1wpMjMCUAEN8QeDY9TJUJpIECnWe8K7aNp0R6IxDf
         Pkv+eygL7DE5rED7VIlkyQl3P4M2XUaVd58G6SR1dzMFUZGox5/jeGuLfTOCA5w54x
         X4eo05I6Hgu6g==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 922D716FC08;
        Thu, 19 May 2022 11:34:52 +0100 (BST)
Message-ID: <275444b7-de43-d0b5-dd4b-41670164e351@cobb.uk.net>
Date:   Thu, 19 May 2022 11:34:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Subject: Re: can't boot into filesystem
Content-Language: en-US
To:     arnaud gaboury <arnaud.gaboury@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAK1hC9sdifM=m3iH7YVh6Cd1ZKHaW69B+6Hz9=aO_r1fh3D7Tg@mail.gmail.com>
In-Reply-To: <CAK1hC9sdifM=m3iH7YVh6Cd1ZKHaW69B+6Hz9=aO_r1fh3D7Tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

You will probably get a much more useful reply from a developer later
but in the meantime...

Probably your rescue CD has an older kernel - new kernels do more
validation on the filesystem. In that case, there is something wrong
with the filesystem but the old kernel hasn't noticed.

You might want to try a rescue CD based on a newer kernel. And/or you
should do a "btrfs check" with the latest btrfs-progs that you can run.
You could even chroot into /mnt/@ (bind mounting dev, proc and sys, of
course) and see if you can run the btrfs image from /mnt/@/usr/bin/btrfs
while booted in your rescue CD. If so, try using it to do a "btrfs
check" on your filesystem. If not, use the btrfs check from the rescue
CD itself. In either case, DO NOT SPECIFY --repair UNLESS A DEVELOPER
TELLS YOU TO!!

By the way, /mnt/@ IS your root - it isn't a copy of it. You can see in
fstab that the "@" subvolume of your disk gets mounted into "/" on boot.

On 19/05/2022 10:58, arnaud gaboury wrote:
> My OS has been freshly installed on a btrfs filesystem. I am quite new
> to btrfs, especially when mounting specific partitions. After a change
> in my fstab, I couldn't boot into the filesystem. Booting from a
> rescue CD, I changed the fstab back to its original. Unfortunately I
> still can't boot.
> Here is part of the error message I have:
> devid 2 uuid XXYYY is missing
> failed to read chunk tree: -2
> 
> part of my fstab:
> LABEL=magnolia   / btrfs  rw,noatime.....,subvol=@
> LABEL=magnolia  /btrbk_pool  btrfs  noatime,....,subvolid=5
> LABEL=magnolia   /home   btrfs .....,subvol=/@home
> ......
> 
> 
> 
> I am now back to rescue CD. I can mount my filesystem with no error:
> # mount -t btrfs /dev/sdb2 /mnt
> # ls -al /mnt/
> @
> btrbk_snapshots
> @home
> home
> 
> I can see my filesystem when I ls the @ directory.
> What can I do to boot my filesystem which is perfectly reproduced in
> the @ subvolume? Shall I simply cp the whole filesystem stored in @ to
> the root of /mnt  when my device sdb2 is mounted?
> Sorry for the lack of formatting and info, but I can't use the browser
> from the rescue CD so I am writing from another computer.

