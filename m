Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1414B10A5CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 22:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfKZVL1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 16:11:27 -0500
Received: from smtp-35.italiaonline.it ([213.209.10.35]:52044 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726033AbfKZVL1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 16:11:27 -0500
Received: from venice.bhome ([94.37.221.184])
        by smtp-35.iol.local with ESMTPA
        id Zi7Hi1FoK4KqMZi7HiExV2; Tue, 26 Nov 2019 22:11:24 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1574802684; bh=GNoxJvq3Lkr8DDED4tr7mma2NNKz9I7bXF/pZwhfFS4=;
        h=Reply-To:Subject:To:References:From:Date:In-Reply-To;
        b=dkS2nBv+9WN7JBiDOSd/y/1U6M0xn4CNRbYkWsIuTK0bAi2NIMxlFdZne/5hbGu7I
         wu9jlRplkTlRHpvvgX+g5td0FhsOooAvhiwsU6jbWWiDssFpwUt8EHN7Wxv5VgYpZb
         ppbiHdHVTxMtM8wVBhT5jujfd0YtWvyaAz4gJoHpbsAw/J5CwrlQ2JuP+AlEaZwwSq
         F4UwTn8cwpiJolzyRyUjxrnTV0+dmJl3aX37YlTyUZZ2jZM0lOryJ76YfQRbwcINA3
         eKviRiwclEweLMMtMkacuYOBCjRx0++EHXUcBZwmYR8bZjMyJqv2ji5uxvzzsFa7IP
         np+ckxWZeuG9Q==
X-CNFS-Analysis: v=2.3 cv=UdUvt5aN c=1 sm=1 tr=0
 a=effWHHp4iGaMry7csNPTyg==:117 a=effWHHp4iGaMry7csNPTyg==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=3ETjRFQ5AAAA:20
 a=mDV3o1hIAAAA:8 a=r6hjTEEVknn_eEJTdc8A:9 a=hEqYFHTQn3TK_llP:21
 a=H0vAPlfmp8QX8SlD:21 a=QEXdDO2ut3YA:10 a=_FVE-zBwftR9WsbkzFJk:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=bWyr8ysk75zN3GCy5bjg:22
Reply-To: kreijack@inwind.it
Subject: Re: GRUB bug with Btrfs multiple devices
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtSeZu8fRzjABXh3wxvBDEajGutAU4LWu0RcJv-6pd+RGQ@mail.gmail.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <a48a6c50-3a03-0420-ad8c-f589fafe6035@libero.it>
Date:   Tue, 26 Nov 2019 22:11:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSeZu8fRzjABXh3wxvBDEajGutAU4LWu0RcJv-6pd+RGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFTswm6RGW4VTSbU9ymya0JHN2hOfhttWGBPBa2BV4lW0u0gckppn0BRqy7a6F6NxHmL3Inika46nIUQnP7EjsOhEEvb61rYYSsziwBadhQK6zSIGfsQ
 dl52Yml44o1oAeHfjj1Xpc97cR1AvWhQCZj3VWyKHzMDDfysmkBKp848jPo4bimWkAYAh1BhBKdMGi8fVeyhOzZemCk++6MPM9Y=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 26/11/2019 05.05, Chris Murphy wrote:
> grub2-efi-x64-2.02-100.fc31.x86_64
> kernel-5.3.13-300.fc31.x86_64
> 
> I've seen this before, so it isn't a regression in either of the above
> versions. But I'm also not certain when the regression occurred,
> because the last time I tested Btrfs multiple devices (specifically
> data single profile), was years ago and I didn't run into this.

 From the video, it seems that GRUB complaints about a "failure reading". However GRUB is capable to perform the boot and because the profiles are "single (no redundancy), it seems a "false positive" error.

When I added the RADID5/6 support to grub, I remember errors like what you showed. However it happened 1 year ago, so my remember may be wrong.
I noticed that GRUB test a lot of disks (hd0 ... hd3) . Could you be so kindly to share the disks layout ? Most error is something like "failure reading sector 0xXX". However I can't read the XX number: could you be so kindly to tell us which number is "XX" ? It seems 0x80... but my eyes are bad and your video is even worse :-)

I think that the errors is due to the "rescan" logic (see grub commit [1]). Could you try a more recent grub (2.04 instead of 2.02) ?

> The gist to reproduce:
> 1. btrfs single device, single profile data, single profile metadata
> 2. device starts to run out of space; no problem 'btrfs device add
> /dev/'  voila it works, reboots, keeps on working for a while, but
> then...
> 3. install a kernel or two or three or four
> 
> I suspect that at some point kernels end up on the newly added device
> due to new block groups eventually being created there, and GRUB
> subsequently gets confused, starts spewing a bunch of error
> information which I have to page through. Eventually it does find
> everything and does boot. But it's kinda ugly and I'm not really sure
> how to gather more information.
> 
> Shaky cam video of the boot is here:
> https://photos.app.goo.gl/wvJbB6kBEFzNwogo6
> 
> 

[1] http://git.savannah.gnu.org/cgit/grub.git/commit/grub-core/fs/btrfs.c?id=fd5a1d82f1d6a0482f5fe201ce646ddba8574bab


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
