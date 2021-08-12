Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AA83E9BE8
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 03:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbhHLBXt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 21:23:49 -0400
Received: from mout.gmx.net ([212.227.17.20]:59833 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229948AbhHLBXt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 21:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628731403;
        bh=x9AQiB8eSdbBy+sr7az7G/fcECTziDPB2X8vrF9GDwU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=JDdkMRTf081fk21NRPGbkp7y2EL75cMpQaNcSohhPMYBPquAXlJPtiEhFkZbOkDd9
         2yC6/Tq41YvTEsD36cKC02OcRCdKF8z8Sdy5LcL80fsEeJnIp821JzrFZY2YW7LKM2
         TjCBPumBC8eVLOdGl1pQjWAOws+aZxBowvmuPK5U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2V4J-1nFXrJ1S6J-013rFl; Thu, 12
 Aug 2021 03:23:23 +0200
Subject: Re: Files/Folders invisibles with 'ls -a' but can 'cd' to folder
To:     k g <klimaax@gmail.com>, linux-btrfs@vger.kernel.org
References: <94bf3fad-fd41-ecc0-404c-ccd087fca05d@gmail.com>
 <c11aea64-0f94-7cb1-886e-f6bc5050d7f2@gmx.com>
 <1bbcdbaf-ecf3-a116-f26e-a2edcc36e536@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <c0ae05e7-6e17-2f73-8d14-7f10ac1d817c@gmx.com>
Date:   Thu, 12 Aug 2021 09:23:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1bbcdbaf-ecf3-a116-f26e-a2edcc36e536@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HPyABF2pqlLVtzYqF6YbWEHm8VZ/xoe5s8rE1Ih1VO/QFRPuQCK
 +kZ1GBIs/nIk904Pa2gf6UpG9iameC28P2GuLFCkRF8ds3cJW+f1Sf4HNkHFCeTL6mUTvEC
 bcZJKVm9abLntmF5XgsE33zC2/f06YNaWr1UflBn0PpkbAOXdDyj2g6zUbmoe1Lu12hPyD0
 xEz5zsdyGE6FBz+htZJ0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0S1SDmT9hN4=:OS9zrrBz6Y9qEIOXrM+VSd
 MWhWqcDFk+RW9LicUy5nAJ49yhhd1ApubrN6LPtRYT0ARZstSI99GlSrU1v9jr2EhOTnOKZlZ
 5sq06v+dqEOseyQzhFQq4T6M4XXax1OngGneqcrBr/j4BdokfWbB3eYlgxHN6xc9G4K4AWuNp
 mv568M2HYfANFFwSW7YMu6lMd4R27SDx3VU65JzdCn+D91CuTCiEPY7MbaMfJIz9lzDvJUZov
 vTqDi0ZL4wdZ1d8jMuTGa+ZR8SRTk+GQiQ13Pz0DTkJ+xGJvEsLOhW68VJgEH2VOVvPaTiWd6
 /+pJPOuqp+D4hk8JY6ZvqUgIEwWN0FUskyCCRY0fptaUIgvrFEYm9dpWDotS2p6Lv4rDg+3hP
 ToeOb5W54dj7C0GnCOMl/bWV2cKeLAfley9ShNyHAgLoAj20vfAMmORYv2qnb5bF79dLpSOmJ
 4yQDmz1x61ubyD3MeKizBP0VEC53qWMFcK/TPVDe7y6lnM3rN1Zysm+uEx+f372SON22Ixqt9
 /McssUoMR/dFc2aoXn+lEclb3QLy9ubElGJvqPSVwzUDDFCuBMcjU4TQvmH450VSfY8IAvCT3
 uFs2UQihsp7eIr5a0Re8hC+TUe5Jjai8RmUuqO6cmf+deTHQ4SggP7DrB4uhG8Yi9xLizzMmg
 8huuRc8f8IfOONey782Dnpm39k1AhFi/P70WHt8x7Q4bxQwp4NU2ZUdYxeCAPBm5rYplgmKeh
 YzbaBtfcIzBkW6unIdfKI5KkNHO/7xv4rlur6TT/ggOmxnseMpUcGIFNDNvlF7mr0zXqxJBlo
 trTSKaeUGYFldImC/+uCtNWXIYP2H2gG3iQ1zJkmADExADEK2ovFCe/hPzcClSMhVdnxmz/vZ
 2pLTGBFoXshbtSwqkzwy/giuig9Eq8AkFoZqQHsnpPxstATWTUPo9c3pfVVXxJALdGAU8lcgV
 cTMfNS1WkDHqclNzUsnN2U9ehDiqaTzAZM8uc/ff2ScAH6uCr78u5P5pkT2C9S4UsbU9YrMet
 F7+sGMHF1/BWy4DrC6t/qe/38qRJOshJuALbWYvpAl1BD1Dn5yix6s+fLctqcoKA+PlGkG324
 SNI4m2/SrC+YJ98KWoqUlR8keG0MIG1PIJmWkPULljlgGPVFadvlTh9dg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/12 =E4=B8=8A=E5=8D=885:54, k g wrote:
> Hi Qu ,
>
>
> Thanks for your valuable answers,
>
>
> The synology system I'm using has btrfs tools v4. I compiled a v5
> version because "btrfs check" version 4 returns "Couldn't open file syst=
em"
>
>
> a little bit late, (I'm 1000 km away from my crashed server, I'm doing
> all of this remotly) ,Here is some output of btrfs check I made today
> (output is very long , here is some samples of the messages returned)
>
>
> Opening filesystem to check...
> Checking filesystem on /dev/md2
> UUID: 306faa08-9e17-406b-924e-57e06e2c2763
> [1/7] checking root items=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (0:03:47 elapsed, 4389038
> items checked)
> [2/7] checking extents=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (0:06:51 elapsed, 3092
> items checked)
> cache and super generation don't match, space cache will be invalidated
> [3/7] checking free space cache=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0:00:00 elapsed)
> [4/7] checking fs roots=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (0:00:00 elapsed, 2 items
> checked)
> found 196033421312 bytes used, error(s) found
> total csum bytes: 15533120
> total tree bytes: 50102272
> total fs tree bytes: 17711104
> total extent tree bytes: 31784960
> btree space waste bytes: 10681343
> file data blocks allocated: 0
>  =C2=A0referenced 0
>
>
> ERROR: child eb corrupted: parent bytenr=3D229829935104 item=3D4 parent
> level=3D2 child bytenr=3D229931827200 child level=3D0

This is the worst case, metadata corruption between nodes and leaves.

> ERROR: extent[193738493952, 16384] referencer count mismatch (root: 257,
> owner: 226748, offset: 0) wanted: 1, have: 0
> parent transid verify failed on 229931827200 wanted 11406678 found 11406=
670
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D229829935104 item=3D4 parent
> level=3D2 child bytenr=3D229931827200 child level=3D0
> ERROR: extent[193738510336, 16384] referencer count mismatch (root: 257,
> owner: 226749, offset: 0) wanted: 1, have: 0
>
> ERROR: extent [197244026880 16384] referencer bytenr mismatch, wanted:
> 197244026880, have: 229859393536
> ERROR: extent [197244043264 16384] referencer bytenr mismatch, wanted:
> 197244043264, have: 229859393536
>
> parent transid verify failed on 229931827200 wanted 11406678 found 11406=
670
> Ignoring transid failure

Furthermore, transid mismatch...

>
>
> WARNING: tree block [197151997952, 197152014336) crosses 64K page
> boudnary, may cause problem for 64K page system
> WARNING: tree block [197152063488, 197152079872) crosses 64K page
> boudnary, may cause problem for 64K page system
>
> Wrong key of child node/leaf, wanted: (197244633088, 169, 0), have:
> (40699577, 108, 0)
> Wrong generation of child node/leaf, wanted: 11406682, have: 11406670
> parent transid verify failed on 229934661632 wanted 11406672 found 11406=
677
> Ignoring transid failure
>
> ERROR: block group[9778059280384 10737418240] used 0 but extent items
> used 10735706112
> ERROR: block group[9788796698624 10737418240] used 0 but extent items
> used 10736922624
>
> leaf parent key incorrect 229908168704
> parent transid verify failed on 229908168704 wanted 11406668 found 11406=
678
> Ignoring transid failure
>
>
> ERROR: free space cache inode 41584067 has invalid mode: has 0100644
> expect 0100600
> parent transid verify failed on 229926993920 wanted 11406669 found 11406=
676
> Ignoring transid failure
> parent transid verify failed on 229958598656 wanted 11406672 found 11406=
678
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D229823332352 item=3D5 parent
> level=3D1 child bytenr=3D229958598656 child level=3D1
> ERROR: errors found in fs roots
> extent buffer leak: start 229934661632 len 16384
> extent buffer leak: start 229823561728 len 16384
> extent buffer leak: start 229931532288 len 16384
> extent buffer leak: start 229931827200 len 16384

Overall, the metadata is mostly screwed up, thus the DIR_ITEM/DIR_INDEX
mismatch happens.

>
>
>
> By "luck" I have a sql dump that contain 80% of the paths of the lost
> files, so I can make a bash or python script to recover them (by doing a
> copy elsewhere or mv two times the hidden folders)
>
> unfortunately, these path are samba paths and some of them are mangled
> (I did not manage, or had the time to reverse engineer the samba source
> code to rebuild linux paths from samba mangled path despite that I asked
> some help in stackoverflow...)
>
> But before starting building these scripts , I want to have=C2=A0 your
> feedback before launching any maintenance operation, or at best a
> procedure to relink these DIR_INDEX

It's way worse than just DIR_INDEX/DIR_ITEM missing, it's some metadata
corruption that mostly screw up the filesystem.

I would go btrfs-restore directly to salvage as much data as possible.

Thanks,
Qu

>
>
> all the best.
>
> .k.
>
>
>
> On 05/08/2021 00:55, Qu Wenruo wrote:
>>
>>
>> On 2021/8/4 =E4=B8=8B=E5=8D=889:19, k g wrote:
>>> Hi
>>>
>>>
>>> As I say in my subject, I'm facing a weird problem with my btrfs
>>> partition (I already sent this message on reddit /r/btrfs/ )
>>
>> Sorry, reddit is not really the go-to place for technical discussion no=
r
>> bug report.
>>
>>>
>>> It's in fact a btrfs partition in a raid5 synology system.
>>
>> We don't know how heavily backported the synology kernel is, thus it's
>> normally better to ask for help from synology.
>>
>>>
>>>
>>>
>>> 3 days ago, the volume 'crashed' (synology terms) ,however SMART data =
is
>>> ok and I don't have sector relcocation errors or CRC.... I rebooted
>>> several times , and after dozen of reboots my partition shows up , but=
 3
>>> TB of 10 TB are missing, I made a scrub but it did made my missing fil=
es
>>> appears.
>>>
>>>
>>>
>>> desperately I made a 'cd xyz' in a directory (I remember some of the
>>> folder names) and it works ; and inside this folder I can do "ls" and
>>> all files and subfolders appears .
>>>
>>> I made a copy elsewhere of some files and these ones are not corrupted
>>> or bit roted.
>>>
>>>
>>>
>>> I don't want to make a btrfs check --repair of course.
>>
>> But "btrfs check" without --repair should be the best tool to show
>> what's going wrong.
>>
>> Alternatively, "btrfs check --mode=3Dlowmem" could provide a better hum=
an
>> readable output.
>>
>>>
>>>
>>>
>>> Is there a way to "relink" indexes/root or whatever it is called to
>>> bring back these files/folder visible and accessible with a safe
>>> command ?
>>
>> It's not that simple, from your description, it looks like the dir has
>> some DIR_ITEM but no DIR_INDEX, thus it doesn't shows up in ls, but cd
>> still work.
>>
>> This normally indicates much bigger problem.
>>
>> Thanks,
>> Qu
>>>
>>> I'm planning to backup all , is 'btrfs restore' will access to these
>>> "non visible" directories ?
>>>
>>>
>>>
>>> "I saw similar case here : The Directory Who Wasn't There : btrfs
>>> (reddit.com) , but I can't find a reply that solve the problem"
>>>
>>>
>>>
>>> cdly
>>>
