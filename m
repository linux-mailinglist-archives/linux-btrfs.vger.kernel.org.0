Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A352922F6BB
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jul 2020 19:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbgG0ReV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 13:34:21 -0400
Received: from smtp-32.italiaonline.it ([213.209.10.32]:36148 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726617AbgG0ReV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 13:34:21 -0400
Received: from venice.bhome ([78.12.13.37])
        by smtp-32.iol.local with ESMTPA
        id 0710kkrbfzS330710kSrQg; Mon, 27 Jul 2020 19:34:18 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1595871258; bh=MnQBo5AP7FhrWUr48KhOmM4RPEKUIcFUmArVN1my8VE=;
        h=From;
        b=Um5TUDpGMOjysdDxfABasL3r/pqjeRkaIYjVs74SiO4iI94MNeF7SJdEhtIOYPKXn
         TzIj+uVHInXkX2OUgAmLNlk2lMhuSpSu/kS/AdUWnwvtFOu8gmepN5IzSh6kLJ/uVf
         Oi3KXLNg47RRhCs9Vw7bV0OWxVfx7xCKNw2PGTqpDFuwZ4NVE/tgl7ONsspw86KEjE
         K5i70mPWLIyqsw9ft8WnLoaMyyuZJkw3sHW+F3P8LHV3Da3GRQgdJMHEe8qie+vZCA
         dcjWepbDzj/CVbgLG15yM4R4VaZl7An6aI41RK/P6/lnEXhB/RJZvPODTPOo2qiZ43
         zFCg0b3mz+dZg==
X-CNFS-Analysis: v=2.3 cv=PLVxBsiC c=1 sm=1 tr=0
 a=XJAbuhTEZzHZh8gzL9OeLg==:117 a=XJAbuhTEZzHZh8gzL9OeLg==:17
 a=IkcTkHD0fZMA:10 a=lfK5j9ZFtb8aFLwTU6MA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [RFC] btrfs: strategy to perform a rollback at boot time
From:   Goffredo Baroncelli <kreijack@inwind.it>
To:     dsterba@suse.cz, Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org, Chris Murphy <lists@colorremedies.com>
References: <20200721203340.275921-1-kreijack@libero.it>
 <20200723215325.GB5890@hungrycats.org>
 <a4074100-b006-7d64-e22d-779ad15191c0@libero.it>
 <20200727122647.GK3703@twin.jikos.cz>
 <80c668ae-d4c7-7cac-01bb-1c742797f06c@inwind.it>
Message-ID: <94f82478-a63a-c82c-31ff-3fe84243fbcc@inwind.it>
Date:   Mon, 27 Jul 2020 19:34:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <80c668ae-d4c7-7cac-01bb-1c742797f06c@inwind.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfEvmuH/ZkXgYraoBYVWt+YvYv01cZ0ILdaSrSi19JJca0OlNYnVbCy0dKnNnsG3aTdtpBYodCPDbS6KDEeaJyvcvOJGf44pFEJlXsNOKsbkm0I49E8NJ
 NmiePk4CnvTg4ufSvhFzl3/pehKRmbEsnWJjHEhxwUFtjLkri0r6nomhz0rarVT7YBODZiup+okQIFhhcdxxHbRLSHDObksh/CxwRaV2miXSl/wrUOe+z7Zw
 l/bFdhX4Ceat3yFv4HwYOIWtEYUFUglkAWvvTZCV3/I=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/27/20 7:25 PM, Goffredo Baroncelli wrote:
> On 7/27/20 2:26 PM, David Sterba wrote:
>> On Fri, Jul 24, 2020 at 01:56:58PM +0200, Goffredo Baroncelli wrote:
>>>> This could be done already from the initramfs.
>>>
>>> Ok, this means that we have three possibility:
>>> 1) do this at bootloder level (eg grub)
>>> 2) do this at initramfs
>>> 3) do this at kernel level (see my patch)
>>>
>>> All these possibilities are a viable solution. However I find 1) and
>>> 2) the more "intrusive", and distro specific. My fear is that each
>>> distro will take a different choice, leading to a more fragmentation.
>>> I hoped that the solution nr 3, could help to find a unique solution....
>>
>> IMO bootloader or initrd are the right places to do the mount test and
>> eventual rollback. What kernel provides is to mount the subvolume, it's
>> up the the user to supply the right one. When I read the proposal the
>> option 2 was the the first thought that can be implemented with the
>> existing kernel support already.
>>
>> Distros take different approach to various problems, and this is fine.
>> Here the list of fallback subvolumes, naming, where it's stored or
>> whatever may differ and the kernel provides the base functionality.
>>
>> It would make sense to push that down one level in case all distros have
>> to repeat the same code and there would be an established way to do the
>> main/rollback switch.
> 
> I am looking for another solution, which is based on some suggestions taken
> from Zygo and Chris. This solution requires no change to initrd, kernel and bootloader.
> 
> More or less the sequence is the following:
> 
> During the upgrade
> ==================
> 1 cleanup previous unclean subvolume and snapshot pairs (due to an unattended abort)
> 2 take a snapshot of the main subvolume
> 3 swap (atomically via renameat2) the original subvolume and its snapshot
>      this means that in case of an unattended reboot, the system starts
>      from the snapshot
> 4 update the filesystem
> 5 re-swap original subvolume and its snapshot
> 6 delete the snapshot (or collect it to provide a way to return to previous configuration)

Of course the devil is in the detail: with the process described above, during "grub" upgrade
the grub.cfg will be generated on the current root subvolume, which is the name of the snapshot

:-(


> 
> This procedure has three possible endings:
> 1) all ok, nothing to do
> 2) unattended reboot happened; at startup a cleanup of the subvolume is required
> 3) unattended abort happened without a reboot; we still have the two subvolumes, at least
> during the shutdown the subvolume and its snapshot have to be swapped (if required)
> 
> During the startup
> ==================
> A script checks if the system started from the snapshot, and if so
> delete the original subvolume (or collect it to provide an history)
> 
> 
> During the shutdown
> ===================
> a script checks if both the subvolume and its snapshot are present.
> This happens if the upgrade procedure abort for some reasons (but the system doesn't reboot).
> In this case I think that it is safe to swap snapshot and original subvolume and
> drop the snapshot (or collect it to provide....)
> 
> 
>>
> 
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
