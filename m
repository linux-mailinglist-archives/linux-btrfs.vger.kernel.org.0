Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD99F62C8C4
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Nov 2022 20:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbiKPTJN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Nov 2022 14:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiKPTJM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Nov 2022 14:09:12 -0500
Received: from libero.it (smtp-17.italiaonline.it [213.209.10.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D803E089
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Nov 2022 11:09:09 -0800 (PST)
Received: from [192.168.1.27] ([84.220.130.49])
        by smtp-17.iol.local with ESMTPA
        id vNmTotRzI5RyRvNmToeWzn; Wed, 16 Nov 2022 20:09:06 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1668625746; bh=mL9gpnpq4IZYhCNeOP4nJSBhKRwVkHEps6CWH31VB50=;
        h=From;
        b=cn9GJfzVK+/vn2h/lKfiCd9wNXQ4D2nqXUKynDYxrPZRCoRAakA1IbbPTWJr/2W0/
         XirTLTuFT5zp3LmKOm0rO7wxuDv0vGWp04VxjuXBxFZJcETMqPwKDO36mMsSbwyMjt
         F2fGPBsN8K3g8g2C1k24pPoxDGBrG/6cYtY01HMr5Vu5pxxy5dmnigRn8IxhqTMk88
         aDNXDMANRRxrknU7soIyu+8rF7f5+4pJ8aWe0dS0NyjKLJO13lBDMeE1VauqIhtr+M
         Ij3HUt5q5M4wyNDF4076RbcBb8wXZR+IflugBRQGF0yN3u0V1ebQPKKycqh5PzE0rv
         48iXIOJ8kPpVg==
X-CNFS-Analysis: v=2.4 cv=JtI0EO0C c=1 sm=1 tr=0 ts=63753552 cx=a_exe
 a=SdbLdwgxGF07xCE66nLfvA==:117 a=SdbLdwgxGF07xCE66nLfvA==:17
 a=IkcTkHD0fZMA:10 a=ITmfce3LwFxrsWqsT88A:9 a=QEXdDO2ut3YA:10
Message-ID: <b31bfe5a-ae85-2ea0-da65-698e095cc180@libero.it>
Date:   Wed, 16 Nov 2022 20:09:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Reply-To: kreijack@inwind.it
Subject: Re: property designating root subvolumes
Content-Language: en-US
To:     Eric Levy <contact@ericlevy.name>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <VB2DLR.FVM1D1665BSY2@ericlevy.name>
 <ba47a0c3-ae7b-8aa9-96fd-2f1eab6e3885@libero.it>
 <N3KELR.FXYFWHCH7XYX2@ericlevy.name>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <N3KELR.FXYFWHCH7XYX2@ericlevy.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfLM/Srvbhap0P9fW/SOi4znU+WYyrWRnQx5SSmO9e7c3y0t/IeTps6D33JSC0zOhd+IIbru9py5F2dY6Ft9YjCrIwkwjhN+N9eKN97LrLa9Boc2rRoXJ
 +zWZXpPhpdQAtQHA42IMDi0+nNc1EBGn1duhyTKBwuFy8ObWWrl6LaOMb0gH2Hs89M+FiYdHthwQYqnfs3Ykfspqny8bB8QQIKgU3fv0uptWlNR7lpBZj++S
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/11/2022 19.45, Eric Levy wrote:
> 
> On Tue, Nov 15 2022 at 07:23:21 PM +0100, Goffredo Baroncelli <kreijack@libero.it> wrote:
>> I don't know rEFInd very well, but I don't think that it is job of the bootloader to do the automatic OS discovery.
>>
>> If you want to perform an OS discovery, at first it would be enough to check the presence of "/bin/init" (or /init or ...) for linux and the equivalent for Windows and OS-X.
>> But this will not give the information like:
>>     - os name
>>     - initrd
>>     - the linux boot parameter...
>>
>> Some (most) setup have different boot entries for the same filesystem (e.g. the standard one, and the emergency one).
>>
>> I prefer the other way that it is used in the linux world: it is responsibility of the os to inform the bootloader about its existence.
>> Look at the BLS specification (even not so widespread adopted).
> 
> Yes, I respect the preference you have provided, but in a sense, merely affirming the preference is begging the larger question.
> 
> The intention of rEFInd is as a bootloader, though less advanced overall than Grub, that is more user friendly, supporting autodiscovery of resident operating systems without needing to be preconfigured by tools installed on one of those operating systems. rEFInd does support some static configuration, similar to the Grub configuration system, but it is not generally required, and supported primarily as an afterthought, for advanced use cases not currently possible through the main method of on-the-fly autodetection.
> 

My point is that the "on fly autodetection", is more complex than find the root of the filesystem, which is indeed quite trivial (e.g. looking ad /bin/init or /init or /sbin/init); the snapshot is a bit more challenging, but due the fact that these have a pointer to the parent (PARENT_UUID) is still doable.

What is not easily doable (and definitely is not a filesystem job) is discover the boot parameter; for example in my system I have the following cmdline:

$ cat /proc/cmdline
initrd=\e84907d099904117b355a99c98378dca\6.0.8\initrd.img-6.0.8 root=UUID=d7a06504-cc14-435d-a5df-674da09c2894 ro rootflags=subvol=@rootfs btrfsrollback=@rollback boot=btrfs quiet splash loglevel=0 vt.global_cursor_default=0 systemd.machine_id=e84907d099904117b355a99c98378dca

Also I have to point out again that some distribution have multiple pair of kernel/image for the same root filesystem (e.g. the fedora rescue images).

> Grub is planned primarily with the assumption that a single operating system, of some Linux variety, is the one dominantly used on a system, and all others, whether also Linux or not, are in some sense subordinate, installed only for occasional use. At times, such an assumption may be agreeable, but not always.
> 
> I think there is a place in the discussion for preferences about the design of the bootloader. However, I also think the discussion should not reject the historical observation, that due to demand for the feature, the default subvolume selector is being used, in a sense incorrectly, for detecting a root file system, because no better approach has been identified.

The concept of "default subvolume" doesn't mix well with "multiple os on the same filesystem"; in my setups  I prefer to pass the root subvolume in the commandline (e.g. 'rootflags=subvol=@rootfs'); recently I discovered that Debian does the same thing.


[...]
> 
> However, even so, I have concerns about desired handling of snapshots, as well as about the other reasons that a subvolume may appear internally as hosting a root tree, but not being desired for showing as an item in the boot menu.
> 
About this point I agree more, but from a different point of view:
- the subvolume is the unit of snapshot
- a filesystem may be composed by different subvolumes (e.g. @boot, @log, @portables mounted over @rootfs)
- each subvolume may have different snapshot policy
- assuming that the place of a subvolume doesn't change over the time in the filesystem, I would like to find a filesystem layout where it is possible to mount a full filesystem or its snapshot with only a command.

I am trying this layout:

In the root of the btrfs filesystem there are the different subvolumes and theirs snapshots:

/@rootfs
/@rootfs-20221017
/@rootfs-20220917
/@rootfs-20220817
/@home-foo
/@home-foo-20221001
/@home-foo-20220901
/@home-foo-20220801
/@boot
/@log
/@portable

When I "assemble" the filesystem I would like to have:
@rootfs -> /
@boot -> /boot
@log -> /var/log
@portable -> /var/lib/portable
@home-foo -> /home/foo


But if want to look at the past I would have also:

[20221017]
@rootfs-20221017 -> /
@boot -> /boot
@log -> /var/log
@portable -> /var/lib/portable
@home-foo-20221001 -> /home/foo

[20221001]
@rootfs-20220917 -> /
@boot -> /boot
@log -> /var/log
@portable -> /var/lib/portable
@home-foo-20221001 -> /home/foo

[20220901]
@rootfs-20220817 -> /
@boot -> /boot
@log -> /var/log
@portable -> /var/lib/portable
@home-foo-20220901 -> /home/foo


But also have the possibility to have also

[snapshot of the root filesystem only 20220901]
@rootfs-20220817 -> /
@boot -> /boot
@log -> /var/log
@portable -> /var/lib/portable
@home-foo -> /home/foo

[snapshot of the home only 20220901]
@rootfs -> /
@boot -> /boot
@log -> /var/log
@portable -> /var/lib/portable
@home-foo-20220901 -> /home/foo

Of course the key would be to have a mount.btrfs command that does the mounts on the basis of a config file


> Regardless, I suggest that the status quo deserves some inspection.
> 
> 

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


