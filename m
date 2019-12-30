Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8977412CD05
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 06:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfL3Fnp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Dec 2019 00:43:45 -0500
Received: from mout.gmx.net ([212.227.17.21]:57701 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfL3Fnp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 00:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577684621;
        bh=GiJTuLJC7EqXo5b7vRx4bFEe30UxGgqAOlKhxgmgXBU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Gcn/MX3Q4qCCYxPJP0cz8fNDoy5S98RqeOwoAZgnLGupxJnI6YNrSfUDOUr8l+/aT
         wlZ5AO5Xx5Y5oA3s9xSIgiKXnMNjfBmbrPcyWk9u5luz7LBtFpdSehsP5sUM8s59gW
         oN9QSU38lw5fiU7drRMfyS08l48kQaXIBSOshzAI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MqaxU-1jY76C2eXY-00mZw9; Mon, 30
 Dec 2019 06:43:41 +0100
Subject: Re: read time tree block corruption detected
To:     Patrick Erley <pat-lkml@erley.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAOB=O_jxu5JOe=JiYVW_VZ1rgs9+mdHpAHkscXkc4MVRLrBKDw@mail.gmail.com>
 <4bf17941-2ab0-15ca-b4c9-f6ba037624ee@gmx.com>
 <CAOB=O_jfwBVihtbNTF1xLNWNtf2_Mi=Bs_BCZ8VnXOKWosw7uQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <66d35620-160e-105a-6970-03c3de3f7c78@gmx.com>
Date:   Mon, 30 Dec 2019 13:43:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAOB=O_jfwBVihtbNTF1xLNWNtf2_Mi=Bs_BCZ8VnXOKWosw7uQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UQIt4ugBzyEkUEm0Kv6VGvNeNobK9jijg"
X-Provags-ID: V03:K1:afaOIKd7y/Etf5VHEyuMgq6pm/gRPvEuaGo+WlWa3bfsnpt493C
 NLkegxisHGh/7jxIc7OzbIa4pNfRtS5kwsfShiFsE6BqLixkHKbnPKFsUhtE8pbMxW1wM45
 GuTr+goYNKUB0HiqYoPtxuaNMMiNRuUGK65QTVJP/u7iu4cTfAMCt81ngSdCN3L72Vo7obW
 gGE9G3tu8NGZaMQ01U7OQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1AMxV4zLrWo=:XPaJ5tCrQeiEYNKd+icFqF
 +658NGvCbTDMIk0L8jM+/62VmWLMBt0Oj2+iSDhHMyUHPIGo1moC7Yr1QFO56a7NN4D91gUlz
 TwGbuRFtch28YN0J3EVZUd/E4m42mjbxdKUc1UYkS2SrD8bWgBo8g/yqjnCkrCsXoqF5yBFJp
 GofqFhngVscxZkZeUPCW6com+XZbBs/1TtOMqWTW4wPBFasRRJMscojbXgKejjbg+531vk2nL
 wEyxtmQow3qlzNslfS3CNEdmJBTV4Oqa+CPAMtnOBIs3WOAbbsak0+3KgZzvIVr3vrUNLcUe9
 xPwfeKqsGdabd6nZyR4IHctl1JyjYs8lwG5pVmJ4AsXgmNjQ4EUx0Mb1hSoyE80js+lXOZc+j
 r9a9xWwIdzAQUL+qli1BfFY03aU0qy3qCeDUfMJQ8bKFH47Bmssu9RZh2juv5kre9FMfJsSoB
 zzKMaw8ekdgWUof+NcoMoCEooGj2RJvc4Iz6UlJrWSZV/TD939JkhEv48xThHD/r0MulSQ9c/
 XM5E0FMYGVXNl3hNxJPCAkLIgu9vefB9bJLsAONSFbMFJNoC3NEP1isom+4BKYWRjX8EbeUXR
 rt322qmU3IT7oOaQ8643D+/I7vnkSNfiiWBhBWwI7S5kY7sUHGeolGk/8pqkboQk0i+o1yez8
 RsTjag4aXoHN8b41BrHGzrUPd81zt8+mMA1N285hD8P0abA6RDhIbYbaZuJoK4c5541ftboKy
 icdRdRUaIu8OwRIpgvKrGqOqycfMumGvVtmyMTodEhe12VPquEticPVmZ69zAOdXNfAxoDGYA
 ylXmxDHqJERdOnAp3jgZEnPR6AAtbXEDY9w9KJXXlwQ9NwVcuy3vJSnZbiUsvuWVFphZpbO7K
 WhUVq425HlGovvAduysidiT1Nm2eHCABICrijpKARxj0Bx+tM3bCIexAbcm+NjrklDTSgLigw
 iCuOfSMd8HMG6lHMk1DAUP7tMoOGAhjW6s8umpdA1EQduDyJrAnvCTXMmSCCNhNH4jv5+LyV9
 B0VS9JMtrmQt2m/AA0grzFkTKpKzxt+2ib/6PBQpt4+NrHZH35Ak1ui55ExUzeFYrqcYgjhm+
 v8YwLrBEx+/PsoU5oBAxxgLhBHnYSr5uv4MYovsa3lsFyK2ON/bobrc3iPLuM78PNPUwJBPeb
 j/ZHjjLsxXRNy3pFiVB2bTDggNotnTQy0Vyk2LwBgilkpfXQK3BNdeOM4ZCSwCrKQJ1ufWmuB
 tSPfjQHatfzm2N2dSTO936rO6yb/gLTAg8Kw5ph3aPxhaAUqadFQOddWBvb0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UQIt4ugBzyEkUEm0Kv6VGvNeNobK9jijg
Content-Type: multipart/mixed; boundary="U0XSIs0hMeBKW1GwZvalaqjOtSS3UVSOS"

--U0XSIs0hMeBKW1GwZvalaqjOtSS3UVSOS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/30 =E4=B8=8B=E5=8D=881:36, Patrick Erley wrote:
> (ugh, just realized gmail does top replies.  Sorry... will try to
> figure out how to make gsuite behave like a sane mail client before my
> next reply):
>=20
> here's btrfs check /dev/nvme0n1p2 (sda3, which is a mirror of it, has
> exactly the same output)
>=20
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> Opening filesystem to check...
> Checking filesystem on /dev/nvme0n1p2
> UUID: 815266d6-a8b9-4f63-a593-02fde178263f
> found 89383137280 bytes used, no error found
> total csum bytes: 85617340
> total tree bytes: 1670774784
> total fs tree bytes: 1451180032
> total extent tree bytes: 107905024
> btree space waste bytes: 413362851
> file data blocks allocated: 90769887232
>  referenced 88836960256

It looks too good to be true, is the btrfs-progs v5.4? IIRC in v5.4 we
should report inodes generation problems.

But anyway, your fs looks pretty OK to have a --repair run on it.
Please note that, only v5.4 has inode generation repair, older ones
can't really repair such problem.

>=20
> And here's the 'lowmen' variant:
>=20
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> ERROR: root 5 EXTENT_DATA[266 1409024] csum missing, have: 0, expected:=
 65536
> ERROR: root 5 INODE[266] nbytes 1437696 not equal to extent_size 150323=
2
> ERROR: root 5 EXTENT_DATA[4731008 4096] csum missing, have: 0, expected=
: 2093056
> ERROR: root 5 EXTENT_DATA[4731008 2101248] csum missing, have: 0, expec=
ted: 8192
> ERROR: root 5 INODE[4731008] nbytes 73728 not equal to extent_size 2174=
976
> ERROR: root 5 EXTENT_DATA[4731012 4096] csum missing, have: 0, expected=
: 8192
> ERROR: root 5 INODE[4731012] nbytes 8192 not equal to extent_size 16384=

> ERROR: root 5 EXTENT_DATA[6563647 8192] csum missing, have: 0, expected=
: 4096
> ERROR: root 5 INODE[6563647] nbytes 12288 not equal to extent_size 1638=
4
> ERROR: root 5 EXTENT_DATA[7090739 131072] csum missing, have: 0, expect=
ed: 24576
> ERROR: root 5 INODE[7090739] nbytes 139264 not equal to extent_size 163=
840

Those are all minor problems, and still no generation problem reported.
All these minor problem can also be repaired, or they are just false
reported in older lowmem mode.

It should be pretty OK to have a v5.4 repair run.

Thanks,
Qu

> ERROR: errors found in fs roots
> Opening filesystem to check...
> Checking filesystem on /dev/nvme0n1p2
> UUID: 815266d6-a8b9-4f63-a593-02fde178263f
> found 89383137280 bytes used, error(s) found
> total csum bytes: 85617340
> total tree bytes: 1670774784
> total fs tree bytes: 1451180032
> total extent tree bytes: 107905024
> btree space waste bytes: 413362851
> file data blocks allocated: 90769887232
>  referenced 88836960256
>=20
> On Sun, Dec 29, 2019 at 4:46 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>
>>
>>
>> On 2019/12/30 =E4=B8=8A=E5=8D=884:43, Patrick Erley wrote:
>>> On a system where I've been tinkering with linux-next for years, my /=

>>> has got some errors.  When migrating from 5.1 to 5.2, I saw these
>>> errors, but just ignored them and went back to 5.1, and continued my
>>> tinkering.  Over the holidays, I decided to try to upgrade the kernel=
,
>>> saw the errors again, and decided to look into them, finding the
>>> tree-checker page on the kernel docs, and am writing this e-mail.
>>>
>>> My / does not contain anything sensitive or important, as /home and
>>> /usr/src are both subvolumes on a separate larger drive.
>>>
>>> btrfs fi show:
>>> Label: none  uuid: 815266d6-a8b9-4f63-a593-02fde178263f
>>> Total devices 2 FS bytes used 93.81GiB
>>> devid    1 size 115.12GiB used 115.11GiB path /dev/nvme0n1p2
>>> devid    3 size 115.12GiB used 115.11GiB path /dev/sda3
>>>
>>> Label: none  uuid: 4bd97711-b63c-40cb-bfa5-aa9c2868cf98
>>> Total devices 1 FS bytes used 536.48GiB
>>> devid    1 size 834.63GiB used 833.59GiB path /dev/sda5
>>>
>>> Booting a more recent kernel, I get spammed with:
>>> [    8.243899] BTRFS critical (device nvme0n1p2): corrupt leaf: root=3D=
5
>>> block=3D303629811712 slot=3D30 ino=3D5380870, invalid inode generatio=
n: has
>>> 13221446351398931016 expect [0, 2997884]
>>
>> Inode generation repair is introduced in v5.4. So feel free to use
>> `btrfs check --repair` to repair such problems.
>>
>> But please run a `btrfs check` without --repair and paste the output,
>> just in case there are extra problems which may screw up repair.
>>
>> Thanks,
>> Qu
>>
>>> [    8.243902] BTRFS error (device nvme0n1p2): block=3D303629811712 r=
ead
>>> time tree block corruption detected
>>>
>>> There are 6 corrupted inodes:
>>> cat dmesg.foo  | grep "BTRFS critical" | sed -re
>>> 's:.*block=3D([0-9]*).*ino=3D([0-9]+).*:\1 \2:' | sort | uniq
>>> 303629811712 5380870
>>> 303712501760 3277548
>>> 303861395456 5909140
>>> 304079065088 2228479
>>> 304573444096 3539224
>>> 305039556608 1442149
>>>
>>> and they all have the same value for the inode generation.  Before I
>>> reboot into a livecd and btrfs check --repair, is there anything
>>> interesting that a snapshot of the state would show?  I have 800gb
>>> unpartitioned on the nvme, so backing up before is already in the
>>> plans, and I could just as easily grab an image of the partitions
>>> while I'm at it.
>>>
>>


--U0XSIs0hMeBKW1GwZvalaqjOtSS3UVSOS--

--UQIt4ugBzyEkUEm0Kv6VGvNeNobK9jijg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4JjokXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qiQjAf+M/5jSwSG61PIuVOcJ2kJxs85
dlgo0lpij49Rvduw1AlRnMZ1PW4ND2UO9u2svduuoeLRDChMocONnOEwZ4tqsf9T
7VLxKQxjzKYWEu6OMYbYE9dj2dXu7NHaGQp5hqFjBal+lK9/dJnQYlGyImccuXwE
zvxg3jNP5Sj7dSJYSimSA/6Sbrhuh9OlQrf0cwn3RWh9BmQ1c8gJSebKLuGvoqzw
Kr99qP0RkVRIlfOSmbnW+djTPhBzaSCgTOFwHAU8GIRpRe7RZeTT/VN6MjOCoArB
OWQtC+NKCJ8i1o5e9m1ssrcosFV1U+RZAPvm/MCDYIygaRQ2NSHrYjNRiJbIDA==
=Qvrj
-----END PGP SIGNATURE-----

--UQIt4ugBzyEkUEm0Kv6VGvNeNobK9jijg--
