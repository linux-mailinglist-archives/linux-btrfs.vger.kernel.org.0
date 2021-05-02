Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FC03709BD
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 May 2021 05:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhEBDXz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 May 2021 23:23:55 -0400
Received: from mout.gmx.net ([212.227.17.22]:54363 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230409AbhEBDXx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 1 May 2021 23:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619925780;
        bh=KQqocc1e5f2qJG4vyPPd2gcboaIx3oQzntdYrWmWEhs=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=BYEysOWWWq0I/TvmRPNJiQQaCAhDibVFA/tMeTFrDTDKw+VsdOUwApGoalARMk3Re
         Fwzge2K47nWWcUalycRWZRz5oHGwmgufxdmO0IVYlF/dSxqdnt/scdLE8G4sKcI6eF
         rJkdYRZRynx0t8l2FuMzWcgCfTTrzAWOWI2EooCw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFKKX-1loKAk3dBB-00FkOg; Sun, 02
 May 2021 05:23:00 +0200
To:     Abdulla Bubshait <darkstego@gmail.com>, linux-btrfs@vger.kernel.org
References: <CADOXG6E7Oh8W6su-GknxmnJ_TKmyo5xAhO+tRURO1XBMeiPKLw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: btrfs balance convert always fails with EIO
Message-ID: <525d8be8-ecd8-68b9-4649-3c0b6be75fc3@gmx.com>
Date:   Sun, 2 May 2021 11:22:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CADOXG6E7Oh8W6su-GknxmnJ_TKmyo5xAhO+tRURO1XBMeiPKLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T0/IvabBg7enTOY/huzKpD1D0nH2ahANp6aCW2Nk55wnhOiz+Ao
 u89cKn4Fjk3emRllvLk9PiS5DSSwi3U6KTUd/L6EDbTe1lKaGAIwcH8QYgCkeHwgt6arK3M
 TlL0/rFeiOpdQbe/o9/wd61MsDYJBctSYJbYUDDH0inc5nXCPlO/NDXks/3DZ535NQbfMnq
 Gupa1Mo7BPJG2mT/SBywg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:F6UXLdyJPyU=:B57/+0tKhA11X6FvK6mfvm
 Zb6qEgOurlvtjfJ2ZtqcQ7oluCydclYW1hnD72gsb4cPyHUd5bhkTSdMkB0SSUmnMvQoujkwN
 MIKx/zXy5K7rPQC9dv3+2//kMA4ikk4T3VugKtk/Jnx6f6/3KcrWwSqx/8iE+IvrISV7hT8xA
 310rkwkGpB+NYGCc+0MX/kLg3MHCjwF/Emmp3aKBWMIkdqg6dVjJS1WqC3hIn+q57vCL8ne2u
 eRl5svZizh9/Eos5h4Dq/1Uq5KTj44cD4Bf/E+x6tmAT7KJykqRqgKrw6gVJoRGoT7y+iE1pP
 zGD3ADiQOJUhHKFWCC0tm3hkjU+DjI705PdL0bJT7wihEGNKNlMqvLZuEAzLm3xMylUywoesJ
 BDZ2U50CWrxXMGiWuLiW3LcY8dDRGS56mfIVpinVNzenVU0KYKW/Ce/evnwL8ABilpJAeAGin
 r42A05ZEXEjtBE6pFZeCst/bN4S2cuTE6FHHM/cDYC+kmR/YizpGO5xQEKF38zYvi3kJlaBpQ
 BcXA5kvvz3YXAzshAsa48mk6TsbeZJ7R4YCsk5RQDFtyIE0awnKADjaaURUR/qwEKAoU7XEop
 w3z6gyUlygokQZRvZ9gc1GC36BsEg4XF1Z0Cmb7thOLunQ5Z4UoaQVW2+8gIIKD+yUA5ZVARI
 3fnsXkGzy9rtWum6SmEKxZLaOojdIZ45ptd7CtECeyiGGksNapKseyaZoXqVJ5EWLBr+rdp9n
 Wtr8Sxhq0uwTWGRizgmbwyYsx08bYS2/jixuAPq+hERXiGHMsIY97ZIozp/lwt9W1gAJPy1eF
 iWD2/BPfRACbppJurLmVXyNaQcoXXmgHLNea8/CtTCOA7uGPgcqcjb5g4FCHhEoPS7acVDe5f
 xThWGEDfn8lvi158eTT5FyJMuhseZ+0dLw8mvzUYA6nDPAYXhbqe2sPvFXUAPQst8BjEqMZRA
 7UaFnko6PQzSHt1p/mLPdR3tYWotmCEJh99FQVYomXVvkimLsV81n+86l4UAGAH5kBYpcpdEo
 W1Fi3e9XwX0VTwmtEy6HQtVTtQfGYhf9mOZxzDL8on9+I5p5Wb4ayHUUUjNznSYIzM0SqdYRS
 72Tk/mh03BYgsPbV80vHQBKjxI++v1ptDeAFVEl1J9NyCIMUxfaGJ+5YEmkFxWbBtuXHcSMCJ
 lbONdqxRvoyYeWWTnwMo0Ae5vHyPeXO+EDuzJPZkFoNFWGtBH4MjQAdQViyLUNxHkCGuES7vo
 lCL7d7g35eW5VjIm6
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/2 =E4=B8=8A=E5=8D=8811:02, Abdulla Bubshait wrote:
> I had a 3 disk single data setup that I decided to switch to a 4 disk
> raid 5 setup.
> Of the 30 TB, around 1.5TB remain unconverted and the balance will not
> complete due to (-5) EIO error.
>
> Here is the dmesg output of my balance attempt:
> [Sat May  1 22:09:42 2021] BTRFS info (device sdd): scrub: started on de=
vid 4
> [Sat May  1 22:11:51 2021] BTRFS info (device sdd): balance: start
> -dconvert=3Draid5,soft
> [Sat May  1 22:11:53 2021] BTRFS info (device sdd): relocating block
> group 4710535790592 flags data
> [Sat May  1 22:11:57 2021] BTRFS warning (device sdd): csum failed
> root -9 ino 257 off 460902400 csum 0x280ba365 expected csum 0x8c01678e
> mirror 1
> [Sat May  1 22:11:57 2021] BTRFS error (device sdd): bdev /dev/sdd
> errs: wr 0, rd 0, flush 0, corrupt 5, gen 0
> [Sat May  1 22:11:57 2021] BTRFS warning (device sdd): csum failed
> root -9 ino 257 off 460902400 csum 0x280ba365 expected csum 0x8c01678e
> mirror 1
> [Sat May  1 22:11:57 2021] BTRFS error (device sdd): bdev /dev/sdd
> errs: wr 0, rd 0, flush 0, corrupt 6, gen 0
> [Sat May  1 22:12:00 2021] BTRFS info (device sdd): balance: ended
> with status: -5
>
> I tried to check inode 257 with btrfs inspect-internal and it turns
> out to just be a folder
> /mnt/mntpoint//home

To locate an inode in btrfs, you can't just search the ino number, as
btrfs has subovolumes, meaning there can be several inodes with the same
ino number.

Thus in btrfs, you need (rootid, ino) to locate an inode.

In your case, it's data reloc tree, and all inodes inside data reloc
tree is not visible to end user, as such inodes are only used for data
relocation.

You need to locate the real file extent, which should has logical bytenr
(4710535790592 + 460902400).

You can use "btrfs ins logical-resolve -o" command to find the offending
file.
If the offending bytes are not really referred by the file(s), defraging
all the involved files can solve the problem.
If the offending bytes are really referred by the file(s), I'm afraid
you have to delete the file to continue balance.

Finally, RAID56 is not considered safe. Recommended to convert to other
raid profile.

Thanks,
Qu
>
> I am not sure why I keep getting EIO errors or how I can get the
> balance to complete.
>
> I ran a btrfs check on my drives and this is the result:
>
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space tree
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> Opening filesystem to check...
> Checking filesystem on /dev/sdc
> UUID: 26debbc1-fdd0-4c3a-8581-8445b99c067c
> cache and super generation don't match, space cache will be invalidated
> found 29351480897536 bytes used, no error found
> total csum bytes: 28628238180
> total tree bytes: 32005619712
> total fs tree bytes: 354713600
> total extent tree bytes: 283623424
> btree space waste bytes: 2529336259
> file data blocks allocated: 29325539180544
>   referenced 29318180474880
>
> btrfs filesystem usage gives:
> Overall:
>     Device size:                  60.03TiB
>     Device allocated:             46.97TiB
>     Device unallocated:           13.05TiB
>     Device missing:                  0.00B
>     Used:                         46.77TiB
>     Free (estimated):              7.58TiB      (min: 4.46TiB)
>     Free (statfs, df):           310.86GiB
>     Data ratio:                       1.75
>     Metadata ratio:                   3.00
>     Global reserve:              512.00MiB      (used: 0.00B)
>     Multiple profiles:                 yes      (data)
>
> Data,single: Size:1.61TiB, Used:1.44TiB (89.78%)
>    /dev/sdd        1.61TiB
>
> Data,RAID5: Size:25.23TiB, Used:25.22TiB (99.96%)
>    /dev/sdd        1.97TiB
>    /dev/sdc       14.22TiB
>    /dev/sdf       12.70TiB
>    /dev/sde       16.36TiB
>
> Metadata,RAID1C3: Size:35.00GiB, Used:29.80GiB (85.16%)
>    /dev/sdd       34.00GiB
>    /dev/sdc       35.00GiB
>    /dev/sdf       30.00GiB
>    /dev/sde        6.00GiB
>
> System,RAID1C3: Size:32.00MiB, Used:3.22MiB (10.06%)
>    /dev/sdd       32.00MiB
>    /dev/sdc       32.00MiB
>    /dev/sde       32.00MiB
>
> Unallocated:
>    /dev/sdd       12.76TiB
>    /dev/sdc      299.99GiB
>    /dev/sdf        1.00MiB
>    /dev/sde        1.00MiB
>
