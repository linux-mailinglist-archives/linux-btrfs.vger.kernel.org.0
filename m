Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75C8912D080
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 15:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfL3OFk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Dec 2019 09:05:40 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:14281 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfL3OFk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 09:05:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1577714738;
        s=strato-dkim-0002; d=nezwerg.de;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=UdPrpm65EDUzy/OC98yeaFjKVaK475zhwofuUtTME94=;
        b=njnPfjdqJ9XmJ+IMVv+gCnjvqXi/bfUtolPdUmdMi87OyMujknP5d4n1x3+Isrwdkt
        B94/YceB5Z3NhRA56EeCYJPYlYOMz8bSghneSeTwUpP4ZijZPi0zaZHhlI9PsPSPCzau
        GPmLF41280Nss0U5Jn0EHXmO7LMxbyL/zoO/87k7vjXbXkZFj2KfXAO0iOOQezDmr8bd
        s2I+Bs5cXiz2GeHfmdeWNvM0myH1j50xHwYToa6mZq6HSa6NVOd3g6uUEYPBWSiBfFj/
        xTcbbFc2lGxPZ3TDN7HJHnygd1QSpB3vgzOsufjjOOv2/245tbeDQCRD5Vp28SeyeQRm
        tEbA==
X-RZG-AUTH: ":IGUXYWCmfuWscPL1D1JO6dFpyf1vPb4ynTLEQ3AnwxYpaMfYGxWjqjPE6tdStKZqMqKJww=="
X-RZG-CLASS-ID: mo00
Received: from mail
        by smtp.strato.de (RZmta 46.1.3 DYNA|AUTH)
        with ESMTPSA id z06983vBUE5bCgv
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 30 Dec 2019 15:05:37 +0100 (CET)
Subject: Re: Intregrity of files restored with btrfs restore
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <7fe8e3e1-ebea-7c61-cf3b-a0e0c6493577@nezwerg.de>
 <8d55e263-3dda-5f9e-77aa-f6b3801d7ea6@gmx.com>
From:   Alexander Veit <list@nezwerg.de>
Message-ID: <6d8c044b-5bea-5cd1-c1d9-964db0a5dc22@nezwerg.de>
Date:   Mon, 30 Dec 2019 15:05:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <8d55e263-3dda-5f9e-77aa-f6b3801d7ea6@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 30.12.2019 um 02:38 schrieb Qu Wenruo:
> 
> Normally crash shouldn't corrupt btrfs, it's either btrfs bug or
> something else causing corruption.

The file system had been corrupted after the hard disk (WD Gold 6 TB
WD6002FRYZ) that had been transfered from a PC to an external enclosure
that failed during read operations. The disk could not be mounted
anymore. According to SMART the drive itself does not have errors.

# dmesg
 BTRFS info (device sdc1): disk space caching is enabled
 BTRFS info (device sdc1): has skinny extents
 BTRFS error (device sdc1): parent transid verify failed on 97288192
wanted 248243 found 248241
 BTRFS error (device sdc1): parent transid verify failed on 97288192
wanted 248243 found 248241
 BTRFS error (device sdc1): failed to read block groups: -5
 BTRFS error (device sdc1): open_ctree failed

Mounting with

 mount -t btrfs -o rootflags=recovery,nospace_cache
 mount -t btrfs -o ro,rescue=skip_bg
 mount -t btrfs -o ro,usebackuproot

did not work either.

Similar error with btrfs-find-root
# btrfs-find-root /dev/sdc1
parent transid verify failed on 97288192 wanted 248243 found 248241
parent transid verify failed on 97288192 wanted 248243 found 248241
parent transid verify failed on 97288192 wanted 248243 found 248241
parent transid verify failed on 97288192 wanted 248243 found 248241
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=71925760 item=38 parent level=2
child level=0
Superblock thinks the generation is 248274
Superblock thinks the level is 1
Found tree root at 71794688 gen 248274 level 1
Well block 43712512(gen: 248228 level: 1) seems good, but
generation/level doesn't match, want gen: 248274 level: 1
Well block 34603008(gen: 247269 level: 0) seems good, but
generation/level doesn't match, want gen: 248274 level: 1
Well block 34078720(gen: 247269 level: 0) seems good, but
generation/level doesn't match, want gen: 248274 level: 1
Well block 33931264(gen: 247269 level: 0) seems good, but
generation/level doesn't match, want gen: 248274 level: 1
Well block 33325056(gen: 247269 level: 0) seems good, but
generation/level doesn't match, want gen: 248274 level: 1
Well block 30375936(gen: 247269 level: 0) seems good, but
generation/level doesn't match, want gen: 248274 level: 1
Well block 30425088(gen: 247268 level: 0) seems good, but
generation/level doesn't match, want gen: 248274 level: 1
Well block 30408704(gen: 247268 level: 0) seems good, but
generation/level doesn't match, want gen: 248274 level: 1

btrfs rescue zero-log with a file copy of the partition also gave errors.


I've also tried to apply the patch you have provided with
 https://patchwork.kernel.org/project/linux-btrfs/list/?series=130637
but unfortunately it does not apply to the Linux kernel sources I've
used (5.3.13).


During btrfs restore I encountered errors of the form

offset is ...
We seem to be looping a lot on /path/to/file.dat, do you want to keep
going on ? (y/N/a): y
...
offset is ...
ERROR: cannot map block logical 1643391221760 length 3221225472: -2
Error copying data for /path/to/file.dat
Error searching /path/to/file.dat
Error searching /path/to/file.dat

This led me to the conclusion that the file system is being corrupted.


> The restore doesn't check data csum. And by default it reads the first
> copy of data.
> 
> If the read succeeded, btrfs-restore just call it a day, thus no data
> csum verification or anything else.
> 
> So it's not as good as you would expect.

This sounds bad. What is the rationale behind btrfs restore not
verifying checksums?

I would expect a file with errors not to be restored (without opting for
doing so).

And even worse, there are cases where a "restored" file could be
synchronized with other storage locations and spread corruption this way.


> Anyway, btrfs-restore is the last resort method, before that RO mount
> and various rescue mount options should be tried before it.
> Kernel will always verify data csum.

Are there any options left to get all files that have not been corrupted
back?


-- 
Thank you very much,
Alex
