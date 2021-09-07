Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87FB4022EB
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 07:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhIGEy6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 00:54:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:52087 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229502AbhIGEy6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Sep 2021 00:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630990427;
        bh=V7OSeUqqo/TfpSFXNRCGVCFFlJbtDk4WpsvlWBO0G4c=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JZCpceL9CGJ15a7/y/6Yfq82IZGln4ey52VJWeIX5/sbYoMd1z5pDZgMigFQ7bKK+
         i3pNjF3siH0kvjEKKNeScH6uZ6lohetQJYqisnK6sJECshDAqpwet7Z2DLd5lPVpFZ
         7BnzEPCJ1q8Di68UUkYPvM7sSTMlKK12u+UBTJO4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MRCOE-1mZUBZ3eeS-00N7AF; Tue, 07
 Sep 2021 06:53:47 +0200
Subject: Re: Next steps in recovery?
To:     Robert Wyrick <rob@wyrick.org>, Anand Jain <anand.jain@oracle.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <362347bd-dca2-6074-c2c1-e453edd2a455@gmx.com>
Date:   Tue, 7 Sep 2021 12:53:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAA_aC9-2ZA2+MOYbzMK+Sm_iwyPGCoaZYotJ0gShJURFv0-Xog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:olkwnxR/D5gqOynAkgEQJ+VNuXVXzxoeLnfAAVC9FB6O0b6kwUk
 5To5n/LBbDxOP1ZkKASiKQI9Oe96fbRgrNr3s3fIuzA31TXyPC7DwgyXYDafk7dKukijYoR
 RjeUe0An1ukhgSuF95YWntiIqSODnk05WpRTL3RZ5VKAmwXW+yh3Dgj6gvF3I8NT4zrVYpE
 gP0bqmzfKCHGkZxJZj78g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gQrCU1v233w=:8us/kSEHNuoOfok46tsNhH
 x+pH0UzcsiNSRIvXOSlDh6OlVfrssPztm8Z9RtGoy0hxFXGxNIbks9+kTkZcunFWdDv64hggM
 xDUIL10UAoRVsIN6UtU4/9C/Yo9h2s0WgDg/XjERHcspJgFS1Mu1wgpGhjEPgK5Vna0tuKAid
 ibWXIp0/+wnp2KYTBAldkrIOf11kFbR49n/COga6ZkUcapEBV5qzXHEeeKbgt3LglgLDVGBsa
 8utPX2DvMKAhXM3nW8Uck+hzNxR8+/74MFTvcMiLjqlvm23MdWh3Lia3AiUEXau9uHl2qghKv
 2CflWO1e8jYQ7ErR/PIZ7rLZ41xWAjTY6WZI/QXtT3KAbFPy6pp992oDkp5sWe2QrsN4LFMbE
 Yo+w09dzoJVsvidBCXWlzehtxjR4XWMvwK7/WoAoJj1CKkL3Ek+Jka6MPRDIQc4zSpvmmvw8o
 pib7/qnDztJu42tmLRKIzsCg9Cw2jBKY2de/JJ0Em7TZ6IfIOyGfZXHA86LCT4dcjuDdN9cc2
 2C7j8dEgfMvjBJ4KN5blpShq6iuCoX3Yn5C1GSk9mhn+WcPNOk/IflCRx7nnb3cQytJ7elx6V
 sPwUZ7WD6sqJDQDxOdc7vR4eX7IKMdQhe2iAJWJUXctn4bG1u8oZ4tKA0Y6v+QxIvMGCAkvx7
 mLxb6gOKJQmjFrCTXMLE9cJ3gu9mMo1PMOtvrUxx5nC/sp5AdeiYkRIpXN0mGXbOpkEYXc73B
 XyYuNM/lcWYtz0XBHK0bC7tAh8cubeH7VgUFV15Q2Xb2uQclxsSQ0WwnAoT0rVq4ZkMBwh9gs
 OgY9rmnHXVJkklDGqRXxYPpYQ5N3bvX2lfmGZv5DUnHstwbRE+JDmEX4skqd6ZgFFBIX+9/xz
 jD8xp/HewWtW1ioA4DQCCrdZch62ObgjDn22g0u0gvOIfJSoT787yqp+W0WeHf6lu4vamSWGu
 2ueWN4bpWFgv6wi/kx1P/lVv2ocghWkrXVBJn4Q1AjdPNYWUqHWoQbmPejgqXV1H8297E6Tjz
 6jtVY2Qnfi1I5cV0RmKScTSeGFTebP7MO3r5YmS1FQlFF0amlCL+AFtufOAKCRZnQnz6flNv3
 V9/LUzchNO7ihophE26m32O6Aduy3gHJQT47mrPhQReL2+DGBOkbByUJA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/7 =E4=B8=8B=E5=8D=8812:36, Robert Wyrick wrote:
> What exactly would i be disabling?  I don't know what zoned does.

The zoned device support.

If you don't have any host-managed zoned device, there is no reason you
would like to enable it.

https://zonedstorage.io/introduction/

Thanks,
Qu

>
> On Mon, Sep 6, 2021, 9:07 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> On 07/09/2021 10:36, Robert Wyrick wrote:
>>> Trying to build latest btrfs-progs.  I'm seeing errors in the configur=
e script.
>>>
>>> $ cat /etc/os-release
>>> NAME=3D"Linux Mint"
>>> VERSION=3D"20.2 (Uma)"
>>> ID=3Dlinuxmint
>>> ID_LIKE=3Dubuntu
>>> PRETTY_NAME=3D"Linux Mint 20.2"
>>> VERSION_ID=3D"20.2"
>>> HOME_URL=3D"https://www.linuxmint.com/"
>>> SUPPORT_URL=3D"https://forums.linuxmint.com/"
>>> BUG_REPORT_URL=3D"http://linuxmint-troubleshooting-guide.readthedocs.i=
o/en/latest/"
>>> PRIVACY_POLICY_URL=3D"https://www.linuxmint.com/"
>>> VERSION_CODENAME=3Duma
>>> UBUNTU_CODENAME=3Dfocal
>>>
>>> $ uname -a
>>> Linux bigbox 5.11.0-27-generic #29~20.04.1-Ubuntu SMP Wed Aug 11
>>> 15:58:17 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
>>>
>>> $ ./configure
>>> checking for gcc... gcc
>>> checking whether the C compiler works... yes
>>> checking for C compiler default output file name... a.out
>>> checking for suffix of executables...
>>> checking whether we are cross compiling... no
>>> checking for suffix of object files... o
>>> checking whether we are using the GNU C compiler... yes
>>> checking whether gcc accepts -g... yes
>>> checking for gcc option to accept ISO C89... none needed
>>> checking how to run the C preprocessor... gcc -E
>>> checking for grep that handles long lines and -e... /bin/grep
>>> checking for egrep... /bin/grep -E
>>> checking for ANSI C header files... yes
>>> checking for sys/types.h... yes
>>> checking for sys/stat.h... yes
>>> checking for stdlib.h... yes
>>> checking for string.h... yes
>>> checking for memory.h... yes
>>> checking for strings.h... yes
>>> checking for inttypes.h... yes
>>> checking for stdint.h... yes
>>> checking for unistd.h... yes
>>> checking minix/config.h usability... no
>>> checking minix/config.h presence... no
>>> checking for minix/config.h... no
>>> checking whether it is safe to define __EXTENSIONS__... yes
>>> checking for gcc... (cached) gcc
>>> checking whether we are using the GNU C compiler... (cached) yes
>>> checking whether gcc accepts -g... (cached) yes
>>> checking for gcc option to accept ISO C89... (cached) none needed
>>> checking whether C compiler accepts -std=3Dgnu90... yes
>>> checking build system type... x86_64-pc-linux-gnu
>>> checking host system type... x86_64-pc-linux-gnu
>>> checking for an ANSI C-conforming const... yes
>>> checking for working volatile... yes
>>> checking whether byte ordering is bigendian... no
>>> checking for special C compiler options needed for large files... no
>>> checking for _FILE_OFFSET_BITS value needed for large files... no
>>> checking for a BSD-compatible install... /usr/bin/install -c
>>> checking whether ln -s works... yes
>>> checking for ar... ar
>>> checking for rm... /bin/rm
>>> checking for rmdir... /bin/rmdir
>>> checking for openat... yes
>>> checking for reallocarray... yes
>>> checking for clock_gettime... yes
>>> checking linux/perf_event.h usability... yes
>>> checking linux/perf_event.h presence... yes
>>> checking for linux/perf_event.h... yes
>>> checking linux/hw_breakpoint.h usability... yes
>>> checking linux/hw_breakpoint.h presence... yes
>>> checking for linux/hw_breakpoint.h... yes
>>> checking for pkg-config... /usr/bin/pkg-config
>>> checking pkg-config is at least version 0.9.0... yes
>>> checking execinfo.h usability... yes
>>> checking execinfo.h presence... yes
>>> checking for execinfo.h... yes
>>> checking for backtrace... yes
>>> checking for backtrace_symbols_fd... yes
>>> checking for xmlto... /usr/bin/xmlto
>>> checking for mv... /bin/mv
>>> checking for a sed that does not truncate output... /bin/sed
>>> checking for asciidoc... /usr/bin/asciidoc
>>> checking for asciidoctor... no
>>> checking for EXT2FS... yes
>>> checking for COM_ERR... yes
>>> checking for REISERFS... yes
>>> checking for FIEMAP_EXTENT_SHARED defined in linux/fiemap.h... yes
>>> checking for EXT4_EPOCH_MASK defined in ext2fs/ext2_fs.h... yes
>>> checking linux/blkzoned.h usability... yes
>>> checking linux/blkzoned.h presence... yes
>>> checking for linux/blkzoned.h... yes
>>> checking for struct blk_zone.capacity... no
>>> checking for BLKGETZONESZ defined in linux/blkzoned.h... yes
>>
>>> configure: error: linux/blkzoned.h does not provide blk_zone.capacity
>>
>>
>>>
>>> ---
>>>
>>> Info on the file in question (linux/blkzoned.h):
>>>
>>> $ dpkg -S /usr/include/linux/blkzoned.h
>>> linux-libc-dev:amd64: /usr/include/linux/blkzoned.h
>>>
>>> $ dpkg -l linux-libc-dev
>>> Desired=3DUnknown/Install/Remove/Purge/Hold
>>> | Status=3DNot/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait=
/Trig-pend
>>> |/ Err?=3D(none)/Reinst-required (Status,Err: uppercase=3Dbad)
>>> ||/ Name                 Version      Architecture Description
>>> +++-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> ii  linux-libc-dev:amd64 5.4.0-81.91  amd64        Linux Kernel
>>> Headers for development
>>>
>>>
>>> So it appears that linux-libc-dev is way out-dated compared to my
>>> kernel.  I don't know how to update it, though... there doesn't appear
>>> to be a newer version available.
>>
>> You could disable the zoned.
>>
>>     ./configure --disable-zoned
>>
>>
>>
>>
>>
