Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C69E010CE29
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2019 18:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfK1R6P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Nov 2019 12:58:15 -0500
Received: from smtp-35.italiaonline.it ([213.209.10.35]:53387 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726582AbfK1R6P (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Nov 2019 12:58:15 -0500
Received: from venice.bhome ([94.37.221.184])
        by smtp-35.iol.local with ESMTPA
        id aO3QiOLp74KqMaO3QiTizA; Thu, 28 Nov 2019 18:58:13 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1574963893; bh=XpquxJOUdmb8zOYyddgrdFAmMQKQ8Y7WVMNfXhOI6eE=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fw3GndfGdrPefb64ER31VWPakfU67q/VuQ6kyLkfdz29LzbLdn45tfjDajnggM9Rb
         9AE8/JWg9RRW+4Nz1WDAyAjyQWt0AcGwhSpPkAwr1u6y0TjbCiAdgpuif31XzSMs1k
         /zEqxDUtZQfKx0jvhS8Pmd9kA3rzBTAoQlU9Wo3dmeqMO3YNcXjoxZxhCQi/g+he7P
         DKVUMzi2fdAU+1P5H40bdfWdg3A9o8XbZiZ0k2xQ8L5tEKy+BupjITn7VdRxAp3Qty
         k3BDSL7pwaX5/e7Wr6N4aA4+ZcqjGN9o8dSKzYDGxb+piDNBQlwo3g4DI6olG8sTTD
         nDUla0NA1r7bA==
X-CNFS-Analysis: v=2.3 cv=UdUvt5aN c=1 sm=1 tr=0
 a=effWHHp4iGaMry7csNPTyg==:117 a=effWHHp4iGaMry7csNPTyg==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=tkrP8xuf2Ik_dzhH4ZUA:9
 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: GRUB bug with Btrfs multiple devices
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtSeZu8fRzjABXh3wxvBDEajGutAU4LWu0RcJv-6pd+RGQ@mail.gmail.com>
 <a48a6c50-3a03-0420-ad8c-f589fafe6035@libero.it>
 <CAJCQCtR6zMNKnhL7OZ8ZGCDwPfjC9a1cBOg+wt2VqoJTA_NbCQ@mail.gmail.com>
 <CAJCQCtS2CP75JTT4a6y=rzqVtkMTqTRoCvJK9z3mMwLRfKo9Xw@mail.gmail.com>
 <12f98aaa-14f0-a059-379a-1d1a53375f97@inwind.it>
 <CAJCQCtQF6xtBDWc+i3FezWZUqGsj8hJrAzYpWG+=huFkmOK==g@mail.gmail.com>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <69aaf772-9eb0-945a-5277-40895e6901de@inwind.it>
Date:   Thu, 28 Nov 2019 18:58:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQF6xtBDWc+i3FezWZUqGsj8hJrAzYpWG+=huFkmOK==g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBxMwdJw7YporKCFAAF/dQ4/BCPvDZj2bCLp4SPa/ROOOBGbdlxjiWoLaUhKZr3kCCxv5h5wj7Pnb4AYGNh2kyOSpZpGhsdlEakb0wuOVTDSSaWERHeD
 YcNpq/d+2yJ43KyUgJVrD+CUp4nt6hHcDw1/jMlt0YpYXtplRbc/Hdsm16kHGHibSBYoR8zmdbZIg+88BL5sE9oy//fqG14JFsY=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/11/2019 01.42, Chris Murphy wrote:
> On Tue, Nov 26, 2019 at 11:07 PM Goffredo Baroncelli <kreijack@inwind.it> wrote:
>>
[...]
>> Could you enable the debug, doing
>>
>>          set pager=1
>>          set debug=all
> 
> I need to narrow the scope. Adding 'set debug=all', there's just way
> too much to video, minutes of pages just holding down space bar full
> time which is even too fast to video. There must be over 1000 pages, a
> tiny minority contain efidisk.c references, the vast majority are
> btrfs.c references. As many pages as there are, I was never able to
> stop right on a boundary between efidisk.c and btrfs.c. So I gave up
> on that approach.

If I remember correctly, in the previous email you reports that even a simple "ls" at the grub prompt raises an error.
So you could watch what happens when doing something simpler like "ls" or "ls (hd0)"


> 
> Since the errors happen with efidisk.c I've enabled 'set
> debug=efidisk' and captured 74 photos, available at the link below
> (they are in pager order)
> 
> 
> 
> It does seem that the errors only happen in efidisk.c and only when
> trying to read from what might be phantom devices; I do not know how a
> second device in a Btrfs volume triggers this though. There must be
> some interaction between efidisk.c and btrfs.c? The grubx64.efi,
> grubenv, grub.cfg, and grub modules are all on an HFS+ (no journal)
> file system acting as the EFI System partition (as is the default
> behavior in Fedora on Macs for many years now). Only vmlinuz and
> initramfs are on Btrfs. So I'm not really even sure why btrfs.c gets
> called before the GRUB menu is displayed.
> 
> I'll see about reproducing this with a VM using edk2 UEFI and two
> virtio devices, at least get to a cleaner environment so we're not
> confusing multiple system specific weird things. And I can also leave
> this particular Mac laptop as it is for further study.
> 
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
