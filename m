Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A7F40316B
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 01:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343697AbhIGXQY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 19:16:24 -0400
Received: from mout.gmx.net ([212.227.17.20]:60855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234094AbhIGXQW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Sep 2021 19:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631056505;
        bh=mn+xZoZ55B9Gmegu2aMeR7Rf5jJXGDpy+E7Zr3RqzxI=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=Rv80V8hOakBEg4lDSrS9LoQcXj9OsiYGqt3qPID/MIve6/1SktMmc+1oSWVig+lSy
         r5/CR/thn4Qwpd4m8pHgGW03Jl0T5E1inORZR85/dYdiObzWMXacZ28wbI8k1rH4ZQ
         Rk7tRrfYtwb7I+uLUDSWF76dhCmAaK98MrI3bGjQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8ofO-1mzRD42NNO-015mZW; Wed, 08
 Sep 2021 01:15:05 +0200
To:     Robert Wyrick <rob@wyrick.org>
Cc:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CAA_aC9-ZAdGC15HY-Q0S-N2M1OukST5BjAk9=WsD+NArCkCFUA@mail.gmail.com>
 <3139b2df-438c-ba40-2565-1f760e6d1edb@gmx.com>
 <9c2afb5f-e854-d743-3849-727f527e877b@gmx.com>
 <CAA_aC99-C8xOf7EAvJAMk2ZkYSaN2vyK7YFMw06utQ0T+tsh9A@mail.gmail.com>
 <6e03129e-f8c8-a00b-2afe-97a82d06c11e@gmx.com>
 <CAA_aC98OWWQHT8vGMQcDMHmsCEVZ+Aw30SdMeqrAa=y1qrV72w@mail.gmail.com>
 <7f8fde51-f920-06be-fdad-0cf59816adca@gmx.com>
 <CAA_aC98-x6vKp53gbtw+Ds5gF+LH6yYn2vqK0TPLE4GduHjsEA@mail.gmail.com>
 <dbf70317-43af-4c70-b5d8-22a993228065@oracle.com>
 <CAA_aC9-2ZA2+MOYbzMK+Sm_iwyPGCoaZYotJ0gShJURFv0-Xog@mail.gmail.com>
 <362347bd-dca2-6074-c2c1-e453edd2a455@gmx.com>
 <CAA_aC98_gr2Gt+1YO=meG7b5mEofVLok88Hgf4605CN1zYp+ow@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Next steps in recovery?
Message-ID: <ddb57c10-3581-0089-d84a-4935644bef5a@gmx.com>
Date:   Wed, 8 Sep 2021 07:15:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAA_aC98_gr2Gt+1YO=meG7b5mEofVLok88Hgf4605CN1zYp+ow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9+bEWoyaWILcQ281U3/Q3ky0PmMjUqKcI9frSUFvDMtp8LofMwI
 +DUwM/qOYWkfOVuMj8D2+rGbISQ4z15iw/vUF31Vf2ddPVbQ5Qun8PMnVEnfIiT6+ubQPDo
 XRWhiVJBQPFNz6W5HbmoGD8ZMNOB8Zcu+lnVegn5yx+GcsOCEP2FpvDIZoMlz7RCt3eUyeI
 qs3My4ZN7Q9O6NM1Xq4Ew==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gkBkSHNfEXM=:e2A9Y6tG6Jwb02dhHxtN/+
 uOlRX43WtneW3dCsYP6e+hfjPu5mamQuGX5++A+jjFE0gjkWyEGkMtYS02U74MMjgpCFkzAnm
 qlEcpMlEQjyZXBY/c5H9+kT5hndtWChRxA2Gv37LE9MqlyczpbSuSugt1ur7pZUqFXQPi2dXk
 5uoSQZ/68MLfzh+P4gpIfYiPLzDgpiaJLuUBeMwdbmzmAP/p4iPJY8bHKW0XI0W0MwGK6MGeY
 sucHYgsJLTlrhc2ZOcl8X4Lk3cos2yFq6EzbSNKY8MPPgJ2ALZQTb8av2SGVF+Js/CgxKalcg
 PUMEuNRgMz2XYTrTLAr0En/DnCb4yFzw7TdGnIBKmngPN5p/T3A4V4OTzLybzof02QaUL8hPt
 6Em9IakT+OR9pyAtdYH7f2Gob2E5P9bvC+ZCpaWKwWzIR1MVc3o3zOMujnqfXBw4QA0TiOxkB
 cUTxL479UiIqf9OoCapigSMAiQoAEkhPqS5O8p4fr0y5LskhcNWqD0krjfOZRYD1xVSRqB+PT
 Hi+fCwOeP3N7wuwPH7jSaOt5E0N7zwEuTQRUx1waYnuDnHdrB9XEVcN+L/Gd+w9FaGkI+ARsT
 uX7paNHaJ7j/RtXieZK2inWerLmu6wFE1FO/fg5ybQhwhBTysZJhP3HjA/fW2z05uTkKXRGeO
 7tVlZQIX/kZ+RqDADAUQCvPAGogFqMfODJJER1tb0Oq7CnEtzPQy00FwH08I2k8bKFVL0cCfa
 lIsMO6ldR+/p/smvt1aRgvll+yrmeXvTl5ia0LdDCb5/TwHBQ5DdagjNQ/JD7NmMg9kTuCyCn
 sB1fQrIGAXS3Sko7YUEvf5W8h+XHKE2UHrz2P0GJ8yxOYGuRnagJIo6VmAqD3tKeqx67TZoVe
 xVnGNK540Vrtfu/1QpUS4Z5vWjcYxKVOnRd5FhK6GDrNWFg3mN8/sy8oYz1xFhB3nN+GxbogG
 YMlgDSzu0LJIwn6JWNYVXoYmnNweSCTHNJZ9BKL7B/fZa4JLMv4iCUJnWXGsT7YvWlPixAVAs
 ZgyVHMRdWydXAYmuyEC4SpNjEYbrsVfW6Yo2nyLZbLal3zGFDmmc3FzOOBQBc9ma3rgFBtp3L
 ln0R46haiGbX+4=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/8 =E4=B8=8A=E5=8D=881:02, Robert Wyrick wrote:
> Ran a repair:
>
> $ sudo ./btrfs check --repair -p /dev/sda  # I did NOT make install,
> just ran from the compiled directory
> enabling repair mode
> WARNING:
>
> Do not use --repair unless you are advised to do so by a developer
> or an experienced user, and then only after having accepted that no
> fsck can successfully repair all types of filesystem corruption. Eg.
> some software or hardware bugs can fatally damage a volume.
> The operation will start in 10 seconds.
> Use Ctrl-C to stop it.
> 10 9 8 7 6 5 4 3 2 1
> Starting repair.
> Opening filesystem to check...
> Checking filesystem on /dev/sda
> UUID: 75f1f45c-552e-4ae2-a56f-46e44b6647cf
> [1/7] checking root items                      (0:00:59 elapsed,
> 2649102 items checked)
> Fixed 0 roots.
> Reset extent item (38179182174208) generation to 4057084elapsed,
> 1116143 items checked)
> No device size related problem found           (0:02:22 elapsed,
> 1116143 items checked)
> [2/7] checking extents                         (0:02:23 elapsed,
> 1116143 items checked)
> cache and super generation don't match, space cache will be invalidated
> [3/7] checking free space cache                (0:00:00 elapsed)
> Deleting bad dir index [8348950,96,3] root 259 (0:00:25 elapsed,
> 106695 items checked)
> repairing missing dir index item for inode 834922400:26 elapsed,
> 108893 items checked)
> [4/7] checking fs roots                        (0:01:04 elapsed,
> 217787 items checked)
> [5/7] checking csums (without verifying data)  (0:00:04 elapsed,
> 12350321 items checked)
> [6/7] checking root refs                       (0:00:00 elapsed, 4
> items checked)
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 15729059057664 bytes used, no error found
> total csum bytes: 15313288548
> total tree bytes: 18286739456
> total fs tree bytes: 1791819776
> total extent tree bytes: 229130240
> btree space waste bytes: 1018844959
> file data blocks allocated: 51587230502912
>   referenced 15627926712320
>
> I can now mount the filesystem successfully!  Thank you for your help.
>
> I do have some additional questions if you don't mind...
> I am already using RAID 1 to handle single disk outages.

One thing to note is, RAID is not perfect, not even close to proper backup=
.

RAID is really only suitable to handle disk failures, nothing more than
that.

In a spectrum of backup, RAID is really just better than nothing.

In this particular case, all the corruption is from bitflips, thus all
copies are corrupted, no profile can save the day.

>  I assume
> things could have gone much worse and I could have lost the whole
> filesystem.

If you're using newer kernels all time, the kernel can detect the extent
generation problem before writing the corrupted data back to disk, thus
save the day.

>  Aside from backups (I know, I know), is there anything
> else I can do to prevent such issues or make them easier to recover
> from?

Newer kernel (v5.11 and newer) can prevent it.
Although when such rejection happens, it will not feel that comfort
though, as it would mostly result the fs to go RO.
But still way better than writing bad data onto disks.

>  Could this problem have been avoided/detected earlier?

Yes, newer kernel.

>  This
> wasn't a disk failure and according to memtest86+, it wasn't due to
> bad memory either....

I still don't believe, maybe you can try to run memtester (which is ran
in user space, and since we have kernel doing the page mapping, it may
expose a different workload on the memory controller than memtest86+)

Since the extent generation corruption is a super obvious bitflip.

>  I don't run scrubs very often.  Should I?

For newer kernels, the corruption can be rejected in first place, thus
the scrub is only going to detect problems already in the fs.

For older kernels, scrub won't detect the problem anyw.

So I guess you don't need that frequent scrub, but it's still recommended.
Maybe monthly?

>  I
> guess the more general question is:  What are the best practices for
> maintaining a healthy btrfs file system?

Well, healthy hardware, balanced kernel version between cutting edge and
stable.
Personally I'm more towards cutting edge thought.

Thanks,
Qu

>
> Thanks again!
>
> On Mon, Sep 6, 2021 at 10:53 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2021/9/7 =E4=B8=8B=E5=8D=8812:36, Robert Wyrick wrote:
>>> What exactly would i be disabling?  I don't know what zoned does.
>>
>> The zoned device support.
>>
>> If you don't have any host-managed zoned device, there is no reason you
>> would like to enable it.
>>
>> https://zonedstorage.io/introduction/
>>
>> Thanks,
>> Qu
>>
>>>
>>> On Mon, Sep 6, 2021, 9:07 PM Anand Jain <anand.jain@oracle.com> wrote:
>>>>
>>>> On 07/09/2021 10:36, Robert Wyrick wrote:
>>>>> Trying to build latest btrfs-progs.  I'm seeing errors in the config=
ure script.
>>>>>
>>>>> $ cat /etc/os-release
>>>>> NAME=3D"Linux Mint"
>>>>> VERSION=3D"20.2 (Uma)"
>>>>> ID=3Dlinuxmint
>>>>> ID_LIKE=3Dubuntu
>>>>> PRETTY_NAME=3D"Linux Mint 20.2"
>>>>> VERSION_ID=3D"20.2"
>>>>> HOME_URL=3D"https://www.linuxmint.com/"
>>>>> SUPPORT_URL=3D"https://forums.linuxmint.com/"
>>>>> BUG_REPORT_URL=3D"http://linuxmint-troubleshooting-guide.readthedocs=
.io/en/latest/"
>>>>> PRIVACY_POLICY_URL=3D"https://www.linuxmint.com/"
>>>>> VERSION_CODENAME=3Duma
>>>>> UBUNTU_CODENAME=3Dfocal
>>>>>
>>>>> $ uname -a
>>>>> Linux bigbox 5.11.0-27-generic #29~20.04.1-Ubuntu SMP Wed Aug 11
>>>>> 15:58:17 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
>>>>>
>>>>> $ ./configure
>>>>> checking for gcc... gcc
>>>>> checking whether the C compiler works... yes
>>>>> checking for C compiler default output file name... a.out
>>>>> checking for suffix of executables...
>>>>> checking whether we are cross compiling... no
>>>>> checking for suffix of object files... o
>>>>> checking whether we are using the GNU C compiler... yes
>>>>> checking whether gcc accepts -g... yes
>>>>> checking for gcc option to accept ISO C89... none needed
>>>>> checking how to run the C preprocessor... gcc -E
>>>>> checking for grep that handles long lines and -e... /bin/grep
>>>>> checking for egrep... /bin/grep -E
>>>>> checking for ANSI C header files... yes
>>>>> checking for sys/types.h... yes
>>>>> checking for sys/stat.h... yes
>>>>> checking for stdlib.h... yes
>>>>> checking for string.h... yes
>>>>> checking for memory.h... yes
>>>>> checking for strings.h... yes
>>>>> checking for inttypes.h... yes
>>>>> checking for stdint.h... yes
>>>>> checking for unistd.h... yes
>>>>> checking minix/config.h usability... no
>>>>> checking minix/config.h presence... no
>>>>> checking for minix/config.h... no
>>>>> checking whether it is safe to define __EXTENSIONS__... yes
>>>>> checking for gcc... (cached) gcc
>>>>> checking whether we are using the GNU C compiler... (cached) yes
>>>>> checking whether gcc accepts -g... (cached) yes
>>>>> checking for gcc option to accept ISO C89... (cached) none needed
>>>>> checking whether C compiler accepts -std=3Dgnu90... yes
>>>>> checking build system type... x86_64-pc-linux-gnu
>>>>> checking host system type... x86_64-pc-linux-gnu
>>>>> checking for an ANSI C-conforming const... yes
>>>>> checking for working volatile... yes
>>>>> checking whether byte ordering is bigendian... no
>>>>> checking for special C compiler options needed for large files... no
>>>>> checking for _FILE_OFFSET_BITS value needed for large files... no
>>>>> checking for a BSD-compatible install... /usr/bin/install -c
>>>>> checking whether ln -s works... yes
>>>>> checking for ar... ar
>>>>> checking for rm... /bin/rm
>>>>> checking for rmdir... /bin/rmdir
>>>>> checking for openat... yes
>>>>> checking for reallocarray... yes
>>>>> checking for clock_gettime... yes
>>>>> checking linux/perf_event.h usability... yes
>>>>> checking linux/perf_event.h presence... yes
>>>>> checking for linux/perf_event.h... yes
>>>>> checking linux/hw_breakpoint.h usability... yes
>>>>> checking linux/hw_breakpoint.h presence... yes
>>>>> checking for linux/hw_breakpoint.h... yes
>>>>> checking for pkg-config... /usr/bin/pkg-config
>>>>> checking pkg-config is at least version 0.9.0... yes
>>>>> checking execinfo.h usability... yes
>>>>> checking execinfo.h presence... yes
>>>>> checking for execinfo.h... yes
>>>>> checking for backtrace... yes
>>>>> checking for backtrace_symbols_fd... yes
>>>>> checking for xmlto... /usr/bin/xmlto
>>>>> checking for mv... /bin/mv
>>>>> checking for a sed that does not truncate output... /bin/sed
>>>>> checking for asciidoc... /usr/bin/asciidoc
>>>>> checking for asciidoctor... no
>>>>> checking for EXT2FS... yes
>>>>> checking for COM_ERR... yes
>>>>> checking for REISERFS... yes
>>>>> checking for FIEMAP_EXTENT_SHARED defined in linux/fiemap.h... yes
>>>>> checking for EXT4_EPOCH_MASK defined in ext2fs/ext2_fs.h... yes
>>>>> checking linux/blkzoned.h usability... yes
>>>>> checking linux/blkzoned.h presence... yes
>>>>> checking for linux/blkzoned.h... yes
>>>>> checking for struct blk_zone.capacity... no
>>>>> checking for BLKGETZONESZ defined in linux/blkzoned.h... yes
>>>>
>>>>> configure: error: linux/blkzoned.h does not provide blk_zone.capacit=
y
>>>>
>>>>
>>>>>
>>>>> ---
>>>>>
>>>>> Info on the file in question (linux/blkzoned.h):
>>>>>
>>>>> $ dpkg -S /usr/include/linux/blkzoned.h
>>>>> linux-libc-dev:amd64: /usr/include/linux/blkzoned.h
>>>>>
>>>>> $ dpkg -l linux-libc-dev
>>>>> Desired=3DUnknown/Install/Remove/Purge/Hold
>>>>> | Status=3DNot/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWa=
it/Trig-pend
>>>>> |/ Err?=3D(none)/Reinst-required (Status,Err: uppercase=3Dbad)
>>>>> ||/ Name                 Version      Architecture Description
>>>>> +++-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>> ii  linux-libc-dev:amd64 5.4.0-81.91  amd64        Linux Kernel
>>>>> Headers for development
>>>>>
>>>>>
>>>>> So it appears that linux-libc-dev is way out-dated compared to my
>>>>> kernel.  I don't know how to update it, though... there doesn't appe=
ar
>>>>> to be a newer version available.
>>>>
>>>> You could disable the zoned.
>>>>
>>>>      ./configure --disable-zoned
>>>>
>>>>
>>>>
>>>>
>>>>
