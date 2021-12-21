Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8318647C8A6
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Dec 2021 22:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbhLUVHG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Dec 2021 16:07:06 -0500
Received: from smtp-34.italiaonline.it ([213.209.10.34]:42543 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230326AbhLUVHG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Dec 2021 16:07:06 -0500
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Dec 2021 16:07:05 EST
Received: from [192.168.1.27] ([78.12.29.103])
        by smtp-34.iol.local with ESMTPA
        id zmDkmQWB3xASIzmDkmsS2R; Tue, 21 Dec 2021 21:58:54 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1640120334; bh=bGN4OiGo5rAz037O9k6yWmpv5/0Tri8SmffBsLiUIt8=;
        h=From;
        b=bnfCVhW2IWcyudi7acW+fi3AVnXZ57+jE8pWk446non4KigA4iXoEal2Yb256bjvd
         uLGGx1wcUqhiGF1Pi5iDeQZFjEaVQOaVElKsDA2QrF1eQHZ15syfQTUmnOAR4u67dZ
         cyeZvdmV5OHPzI91CgZVa1TKoIY+1dq5rA5qnMj6pPH9tjCL0VwKXOzIIbhhPCG2GO
         PYZHw98NsjOIif4FAsQ6eYnupwIohHWUwN3LBzFc1SeH0wvyEaTMW5q2rf8SB7WHLs
         JnZVR2/ich3bYENmAvv4csKaj7hTR0siAwogGgwVvt6WBj8q7Ipl3YHeyY+AfNBewu
         aa50UWb+kmw4Q==
X-CNFS-Analysis: v=2.4 cv=d64wdTvE c=1 sm=1 tr=0 ts=61c2400e cx=a_exe
 a=VgbZ0xkbG+fWpNcKYgCcrg==:117 a=VgbZ0xkbG+fWpNcKYgCcrg==:17
 a=IkcTkHD0fZMA:10 a=JLGhq52oNz1wbGGyxLYA:9 a=QEXdDO2ut3YA:10
Message-ID: <39ec824b-4c01-a7b0-23cb-cf314a703857@libero.it>
Date:   Tue, 21 Dec 2021 21:58:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
From:   Goffredo Baroncelli <kreijack@libero.it>
Subject: Re: Script to test allocation_hint - [Was Re: [PATCH 0/2][V9]
 btrfs-progs: allocation_hint disk property]
Reply-To: kreijack@inwind.it
To:     Paul Jones <paul@pauljones.id.au>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1639766708.git.kreijack@inwind.it>
 <b2236689-fd1d-c5bb-0be9-4a62a308d938@libero.it>
 <SYXPR01MB1918C21391070CCC6F12E1DF9E7C9@SYXPR01MB1918.ausprd01.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <SYXPR01MB1918C21391070CCC6F12E1DF9E7C9@SYXPR01MB1918.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJsyVlnxD7DW1OclPTpGANQ5ACMgR56llewi8u7Ik99YCI0HVjBCmhX7M0ggOEHlS4FHURrQ3J1UgOKdplsptwo93kcV/jpbqaW7p+Jkuz9giomSYyXP
 VDMMUSeTK2pWDCIjPe3U5Jfw4x5p++AdV6nYpzkyS56MHeSEwkkWl0QCLC7GeCbWVPZPLgf8XDHsUwIW8IJZxRHMafd7UNoTqOpUXCTwzYPKl89bcsGco9Vg
 InfESUBeInSMidmDNy06V6Vsbi0vK4I5lsl7Z1aEjmfXsK3UeBhz8Be+Guwy4oCzVGSESOuGt+Y4+EWFITjiY6CcBss5cMRKeErN3jWFn1Yx9YVFHYTM+hTi
 aTSHJk4L
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/21/21 06:36, Paul Jones wrote:

> 
> FYI something has broken in 5.15 - Only the first device in a raid set gets allocation_hint set
> 
> server /media/storage/peejay/linux/btrfs-progs # cat .err.log
> dd: error writing 'mnt/giant-file-x': No space left on device
> 110+0 records in
> 109+0 records out
> 1828716544 bytes (1.8 GB, 1.7 GiB) copied, 4.4846 s, 408 MB/s
> File too big: check mnt/
> server /media/storage/peejay/linux/btrfs-progs # ./btrfs-hint prop get /dev/loop1
> label=
> devid=1, path=/dev/loop1: allocation_hint=METADATA_ONLY
> server /media/storage/peejay/linux/btrfs-progs # ./btrfs-hint prop get /dev/loop2
> label=
> server /media/storage/peejay/linux/btrfs-progs # ./btrfs-hint prop get /dev/loop3
> label=
> server /media/storage/peejay/linux/btrfs-progs # ./btrfs-hint prop get /dev/loop4
> label=
> 

Yes, I can reproduce it. However the strange if I do

# sudo ./btrfs prop get /dev/loop1 allocation_hint
devid=2, path=/dev/loop1: allocation_hint=DATA_PREFERRED

it works; instead if I do (no property name)

# sudo ./btrfs prop get /dev/loop1
label=

it doesn't work.


My suspect is that the guilty is get_label() and how the "global" internal state of btrfs is not re-entrant.

Let me to explain what (I think) happens: if you don't pass a property name to "btrfs get prop", btrfs-progs iterates over all the "get" properties handlers.
One of these handlers is the manager of the "label" property. This handler check the kind of object passed. If the object is a device (like this case), it assume that the filesystem is not mounted and call get_label_unmounted (otherwise it calls the get_label_mounted, which in turn ask the label using an ioctl).
get_label_unmounted() instead calls open_ctree() (anyway I suspect that this is not a good thing on an mounted filesystem).

My *suspect* is that open_ctree()/close_ctree() (called by get_label) and btrfs_scan_devices() (called by the allocation_hint handler) interact badly.
In fact if I comment the code of get_label_unmounted(), the bug goes away.

In conclusion, yes there is a BUG. The bug is raise when "btrfs get prop <obj>" is called without a specific property. It seems not related to the code of the allocation_hint property, but how the internal state of btrfs is handled in general. But a more deeper analysis is needed.

BR

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
