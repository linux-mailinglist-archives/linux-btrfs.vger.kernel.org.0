Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6452F1E5A
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 19:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390605AbhAKS5S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 13:57:18 -0500
Received: from smtp-33.italiaonline.it ([213.209.10.33]:39102 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726063AbhAKS5R (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 13:57:17 -0500
Received: from venice.bhome ([94.37.172.193])
        by smtp-33.iol.local with ESMTPA
        id z2MlkhpdE11DDz2MlksDDd; Mon, 11 Jan 2021 19:56:35 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1610391395; bh=UP1G2iwVU7LUmmDBm9KZipFz6Xpfcx7zRDZ2Qs38FZk=;
        h=From;
        b=gkN+ba2Az1HAD/0eldEMBncfpiXgPEmQN63owxSRcvDz9FGih/fdo7x8zDiZlCHmm
         XbQ8ym4CjFwLwtLt9QFQ7Lf/kHgqKiZapkdybzAorW7oBebz6a9XtDz/D/xizSKI2P
         PiKlfmPwh8RMdM1RBxvn+0PqYrgWtjvyo/s0Zkr4WfUjSm4+KHEGaKOI7z1s5lizWb
         xbLVm4Hhu9GGq6BzWRqvy66oDhNJPJrMI9AZYh7z6ZIA1lAnEUfzr3XtXyXOtqXX6/
         kcVr7pHA40UtPRcvlwYNf29bvvxOqqFNbLenzfzyY8JUwWQSzLqA4CmYsCNPQxUWVp
         Gf4Gnfc9Y1wjg==
X-CNFS-Analysis: v=2.4 cv=ba6u7MDB c=1 sm=1 tr=0 ts=5ffc9f63 cx=a_exe
 a=z1y4hvBwYU35dpVEhKc0WA==:117 a=z1y4hvBwYU35dpVEhKc0WA==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=tT62RjUPrgIUnLq2FDMA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
Reply-To: kreijack@inwind.it
Subject: Re: Reading files with bad data checksum
To:     David Woodhouse <dwmw2@infradead.org>, Forza <forza@tnonline.net>,
        linux-btrfs@vger.kernel.org
References: <1ad3962943592e9a60f88aecdb493f368c70bbe1.camel@infradead.org>
 <de013d75-7fa1-4cb6-ac1e-a67864c68bf3@tnonline.net>
 <0544b98786dbd980e8bdde58bd5713247178a74e.camel@infradead.org>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <3e309cce-d322-1df8-052a-f370ccbd2784@libero.it>
Date:   Mon, 11 Jan 2021 19:56:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <0544b98786dbd980e8bdde58bd5713247178a74e.camel@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBbxjUessjgf1oL62INSFgi78w4p5dRm8hDPBeJtmkkFM8HFaCRL2H1kOCT3zQqJH7engJoWcd48Bw1kMJJrMAHRGozIouXV0NtUwlEjwn2MEoH9FusO
 jlee2jrwiC9G/e/VZ5bRJTz4hXuqlT+Aw7k5pEI689f65FCgJWIC9AF3p6aD8miidshexor/kXWEWij1+MrmDrW16wbxt13SThcV3O3eCLb1E+thHelZQMQj
 zXO2NfY95a0Hf7NIbk8bEA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/10/21 1:36 PM, David Woodhouse wrote:
> On Sun, 2021-01-10 at 13:08 +0100, Forza wrote:
[...]
> 
> It showed up as errors. There appears to be a btrfs bug there but since

Yes, it is an old btrfs bug. And qemu is not the guilty.

https://lore.kernel.org/linux-btrfs/cf8a733f-2c9d-7ffe-e865-4c13d99dfb60@libero.it/

In my email there is a code to reproduce it.

Basically it is difficult to have the checksum sync with the data when O_DIRECT
is used. Even OpenZFS has problem with it. The OpenZFS solution is to lie about O_DIRECT:
it allows the flag however it doesn't honor.

I think that BTRFS should behave like ZFS: when csum are enable, O_DIRECT shouldn't be
honored (or returning an error or behaving like ZFS).


> I suspect it'll be easy to reproduce I'm more focused on recovery right
> now.
> 
>>> In the short term, all I want to do is make a copy of the file, using
>>> the data which are in the disk regardless of the fact that btrfs thinks
>>> the checksum doesn't match. Is there a way I can turn off *checking* of
>>> the checksum for that specific file (or file descriptor?).
>>>
>>> Or is the only way to do it with something like FIBMAP, reading the
>>> offending blocks directly from the underlying disk and then writing
>>> them into the appropriate offset in (a copy of) the file? A plan which
>>> is slightly complicated by the fact that of course btrfs doesn't
>>> support FIBMAP.
>>>
>>> What's the best way to recover the data?
>>>
>>
>> You can use GNU ddrescue to copy files. It can skip the offending blocks
>> and replace the bad data with zeroes. Not sure how well qemu will handle
>> that though.
> 
> Right. I've already copied the image with dd conv=sync,noerror to a new
> one with the +C flag. It passes 'qemu-img check', and in fact the guest
> is running just fine with it. I was expecting it to stop with
> catastrophic file system errors but I can't see anything wrong at all.
> I'm just paranoid that eventually I'll find out that the blocks belong
> to some file(s) I actually want, and I'd like to recover them.
> 
> Right now I have a horribly fragmented image file with these 'errors'
> cluttering up my file system and making backups of the host go
> extremely slow. I'd like to get those blocks back so I can make a clean
> copy of the image, and keep it around for reference in case I later
> *do* discover that I need the contents of those blocks.
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
