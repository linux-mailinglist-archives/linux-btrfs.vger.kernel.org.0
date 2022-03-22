Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A3A4E44DC
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 18:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239477AbiCVRTS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 13:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235774AbiCVRTR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 13:19:17 -0400
Received: from mout.gmx.com (mout.gmx.com [74.208.4.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199C96FA0A
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 10:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.com;
        s=dbd5af2cbaf7; t=1647969466;
        bh=WCMMMMt5E35zj1McojiseAm5pHmcRYgnw10nanxHNc4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=cOX0aPURh0IXubIsDaNoADxa7cSMcvOYE6ZMlkNGCX9pIyU3cE3rvnZ5GdRDGHhfN
         KFMELE9ZpOVcCBoi6c4jnrCh60kQ28/A7qKXzCL9MtGLXduH1Vmhl+sky52Wc1iZfz
         rQ1vhEvToenyA2Iiy5nHqPDeSKhO7P/iBDd1SW7k=
X-UI-Sender-Class: 214d933f-fd2f-45c7-a636-f5d79ae31a79
Received: from [88.156.136.188] ([88.156.136.188]) by web-mail.mail.com
 (3c-app-mailcom-lxa08.server.lan [10.76.45.9]) (via HTTP); Tue, 22 Mar 2022
 18:17:46 +0100
MIME-Version: 1.0
Message-ID: <trinity-56388cba-8de1-43e3-8e32-a8f8b6d0d246-1647969466534@3c-app-mailcom-lxa08>
From:   Joseph Spagnol <joseph.spagnol@programmer.net>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: failed to read block groups: Input/output error; bad tree block
 - bytenr mismatch;
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 22 Mar 2022 18:17:46 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <f1159186-c73d-5102-549d-8e343f1bca0d@gmx.com>
References: <trinity-58cb51fa-9b3e-4fd0-9ff7-29da0dd13e14-1647953588232@3c-app-mailcom-lxa08>
 <f1159186-c73d-5102-549d-8e343f1bca0d@gmx.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:w2gV7zFslU5zWhngnW3qvxYyywlfqI60tt9oicBpgAlLU19B3nVUXAVwn4FBdJwHRn7Qm
 nEk4T5eKheVvHCbEfRid4/Hgiusr3dT0iFz5x6nHnoxvZiY6rm53EH9AZCEFJmnWX9WWRbNpynpU
 0gcpZIin822MDCpt24bDXUwxDhFr1i0RpaIyihv+YhS2WFjnHE44CofJfzW/YiOWLQt+WbEbYaAO
 ay0YQeUW37/SbSfQR1d7/eDqxTPtFohQkgKqJu9zlqL/Bl2EH7hjG599qhFAu64xZvzDqORPds0p
 n0=
X-UI-Out-Filterresults: notjunk:1;V03:K0:MryOGsyj1T0=:4RtUJhIdzEiDgf0i0MEug5
 KsrGUJwpXkwKo8Mgk8kXrZIVjCcMAtY+eNw5SawaIFYPeVzHZLD0CjPFLROoJLBR20Od/hG20
 JzDd4gjdqy3tzF3ThfFT9cVkl6WHL3nSpOB+x56AAbdohzO6w0DvFY/91O1LxBZGu6fzh5Vz2
 aSBK+M5kz3oT+z/wxPHwJFWwzZap55xRjppXwPahla5AOSMDW1SS18PB8KqG27s42d2wRhzrN
 BW35+YCWHoc5Cmcxiq6oPXfolkQCCJj4GRZ7okTKr3jlCN6s6LFodGcS+ZdgFgNFCXPHk7Bwe
 1JF6mUq3J9nvDfJtKu0FTVAHnd9N2AQN7N8qo7PciQNqBpOJtPGoh/K9rooLhyQpYK/74fy+/
 Z7qXJw7BEb8D/TJlg5QYw2XZZLMmjEw5eiZAkOLBa8/EFyqIhA2Zvyq10CxUR01l+6WRLuR1s
 gz/1pOgMfH/+fbVhOX5VSb5+GJJFU9Jf8J5RRj2SBNwow1leeHg+OThjuubAcBwwdc2CYg8tt
 YHeWjBlbQGN8x0IVXVUm8cYYk7w+DQYBhK/su1MhwUIVPYkBfIeb3k+yrv93hsep1ZPCHdGeg
 MfXGVVU4SmGw8oaknTwyJiiVoyIzG0kjxqQeD0VyIQskWrLNkPhIdxbi/dlr32fD4EwoyUbgw
 Br48CbzicLKwX0veLxqc1qHA1Z+JWYRqexj7X3I0f4kIa8ouOH1yY2hBhe2maM/9THtwMEAFx
 qI61+Dbw8UK65mbYB85HaBDkcgimPfWoEZzRz7dD4f8C2ud9WX4ouSv7IBLGiAxII0UNY6iW4
 FLCDrPy
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello, thanks for the quick response=2E
unfortunately the ro mount from a more recent kernel does not work as well
=C2=A0
# uname -r
5=2E16=2E11-1-default
# mount -t btrfs -o rescue=3Dall,ro /dev/sda4 /mnt/
mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sda4, missi=
ng codepage or helper program, or other error=2E

Am not sure this can help but this btrfs partition become like this after =
a sudden system freeze=2E

Is there a possibility to check an fix the partition size?
I believe it could be an issue with the actual size of the partition/parti=
tions=2E

Sent:=C2=A0Tuesday, March 22, 2022 at 2:05 PM
From:=C2=A0"Qu Wenruo" <quwenruo=2Ebtrfs@gmx=2Ecom>
To:=C2=A0"Joseph Spagnol" <joseph=2Espagnol@programmer=2Enet>, linux-btrfs=
@vger=2Ekernel=2Eorg
Subject:=C2=A0Re: failed to read block groups: Input/output error; bad tre=
e block - bytenr mismatch;

On 2022/3/22 20:53, Joseph Spagnol wrote:
> Hello, recently one of my btrfs partitions has become unavailable and am=
 not able to mount it=2E
>
> # mount -t btrfs /dev/sda4 /mnt/
> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sda4, mis=
sing codepage or helper program, or other error=2E
>
> # btrfs-find-root /dev/sda4
> Couldn't read tree root
> Superblock thinks the generation is 432440
> Superblock thinks the level is 1
> Well block 23235313664(gen: 432440 level: 0) seems good, but generation/=
level doesn't match, want gen: 432440 level: 1
> Well block 23231447040(gen: 432439 level: 1) seems good, but generation/=
level doesn't match, want gen: 432440 level: 1
> Well block 23229202432(gen: 432438 level: 0) seems good, but generation/=
level doesn't match, want gen: 432440 level: 1
> Well block 23192911872(gen: 432431 level: 1) seems good, but generation/=
level doesn't match, want gen: 432440 level: 1
> Well block 23177084928(gen: 432430 level: 1) seems good, but generation/=
level doesn't match, want gen: 432440 level: 1
> Well block 23149035520(gen: 432429 level: 1) seems good, but generation/=
level doesn't match, want gen: 432440 level: 1
> Well block 23124443136(gen: 432427 level: 1) seems good, but generation/=
level doesn't match, want gen: 432440 level: 1
> Well block 23113547776(gen: 432426 level: 1) seems good, but generation/=
level doesn't match, want gen: 432440 level: 1
> Well block 23080730624(gen: 432425 level: 1) seems good, but generation/=
level doesn't match, want gen: 432440 level: 1
> Well block 23048241152(gen: 432424 level: 1) seems good, but generation/=
level doesn't match, want gen: 432440 level: 1
> Well block 23013031936(gen: 432422 level: 1) seems good, but generation/=
level doesn't match, want gen: 432440 level: 1
> =2E=2E=2E=2E=2E=2E=2E
>
> # btrfsck -b -p /dev/sda4
> Opening filesystem to check=2E=2E=2E
> checksum verify failed on 23234035712 wanted 0x00000000 found 0x0810faf8
> checksum verify failed on 23234035712 wanted 0x00000000 found 0x0810faf8
> bad tree block 23234035712, bytenr mismatch, want=3D23234035712, have=3D=
0

Some range is completely wiped out=2E
And that wiped out range is in extent tree=2E


There are several two theories for it:

- Some discard related bug
It can be the firmware of disk, or btrfs itself=2E
Some range got wiped out even we're still needing it=2E

- Some missing writes
The write should reach disk but didn't=2E
This means the barrier is not working=2E
In that case, disk firmware may be the problem=2E


> ERROR: failed to read block groups: Input/output error
> ERROR: cannot open file system
>
> Here are some more details;
> # uname -a
> Linux msi-b17-manjaro 5=2E4=2E184-1-MANJARO #1 SMP PREEMPT Fri Mar 11 13=
:59:07 UTC 2022 x86_64 GNU/Linux
> # btrfs --version
> btrfs-progs v5=2E16=2E2
> # btrfs fi show
> Label: 'OLDDATA' uuid: 9bc104b4-c889-477f-aae1-4d865cdc0372
> Total devices 1 FS bytes used 34=2E20GiB
> devid 1 size 50=2E00GiB used 37=2E52GiB path /dev/sda3
> Label: 'OPENSUSE' uuid: c3632d30-a117-43ef-8993-88f1933f6676
> Total devices 1 FS bytes used 24=2E60GiB
> devid 1 size 150=2E00GiB used 31=2E05GiB path /dev/nvme0n1p4
> Label: 'DATA' uuid: 4ce61b29-8c8d-4c04-b715-96f0dda809a4
> Total devices 1 FS bytes used 118=2E67GiB
> devid 1 size 200=2E00GiB used 122=2E02GiB path /dev/sda4
> # btrfs fi df /dev/sda4
> ERROR: not a directory: /dev/sda4
> # btrfs fi df /data/
> ERROR: not a btrfs filesystem: /data/
> ## dmesg=2Elog ##
> [65500=2E890756] BTRFS info (device sda4): flagging fs with big metadata=
 feature
> [65500=2E890766] BTRFS warning (device sda4): 'recovery' is deprecated, =
use 'usebackuproot' instead
> [65500=2E890768] BTRFS info (device sda4): trying to use backup root at =
mount time
> [65500=2E890771] BTRFS info (device sda4): disabling disk space caching
> [65500=2E890773] BTRFS info (device sda4): force clearing of disk cache
> [65500=2E890775] BTRFS info (device sda4): has skinny extents
> [65500=2E893556] BTRFS error (device sda4): bad tree block start, want 2=
3235280896 have 0
> [65500=2E893593] BTRFS warning (device sda4): failed to read tree root
> [65500=2E893852] BTRFS error (device sda4): bad tree block start, want 2=
3235280896 have 0
> [65500=2E893856] BTRFS warning (device sda4): failed to read tree root
> [65500=2E908097] BTRFS error (device sda4): bad tree block start, want 2=
3234035712 have 0
> [65500=2E908111] BTRFS error (device sda4): failed to read block groups:=
 -5
> [65500=2E963167] BTRFS error (device sda4): open_ctree failed
>
> P=2ES=2E I must say that I get the same results when I try to mount the =
partition from another linux system OpenSuse tumbleweed

There are already at least two tree blocks got wiped=2E

I won't be surprised if there are more=2E

For now, only data salvage can be even attempted=2E

Using newer enough kernel (like from openSUSE tumbleweed), then mount
with -o rescue=3Dall,ro to see if it can be mounted=2E

That's more or less the same as btrfs-restore, but more convenient to
copy things out=2E

Thanks,
Qu
>
> Is there any way I could rebuild the tree?
>
> Thanks in advance
> Joseph
>
>
