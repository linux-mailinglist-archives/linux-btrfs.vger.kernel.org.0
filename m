Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05DB812CD2C
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 07:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfL3GJ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Dec 2019 01:09:59 -0500
Received: from mout.gmx.net ([212.227.17.21]:46047 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbfL3GJ7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 01:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577686196;
        bh=7p4UbXz05cIlnEdas3me9GbTE8cpy+HNuWENbumct5k=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QzkHW5SUfNebY1HLM3HGxF2lYH3QWkE+mzJv36JJFmfJgl6chj0H97qy9wC0B7G4w
         9JqU0mkY7+mvXv74a7qIWtcqYQxsQKWPmhdpSA0wFxgrfinKs8jylRvzJWbtVjk86c
         TgBOWa9xOyuswrlQkVtx5Oaac0H9W0xxjUIuflcY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLzBp-1j3Cg1090T-00HvLj; Mon, 30
 Dec 2019 07:09:56 +0100
Subject: Re: read time tree block corruption detected
To:     Patrick Erley <pat-lkml@erley.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAOB=O_jxu5JOe=JiYVW_VZ1rgs9+mdHpAHkscXkc4MVRLrBKDw@mail.gmail.com>
 <4bf17941-2ab0-15ca-b4c9-f6ba037624ee@gmx.com>
 <CAOB=O_jfwBVihtbNTF1xLNWNtf2_Mi=Bs_BCZ8VnXOKWosw7uQ@mail.gmail.com>
 <66d35620-160e-105a-6970-03c3de3f7c78@gmx.com>
 <CAOB=O_jpg0K4eDARfG+XDDRMHhm+yKp8XfhjqHsFxAswSPUfdQ@mail.gmail.com>
 <CAOB=O_hdjpNtNtMMi93CFh3wO048SDVxMgBQd_pC0wx0C_49Ug@mail.gmail.com>
 <a2f28c83-01c0-fce7-5332-2e9331f3c3df@gmx.com>
 <CAOB=O_gBBjT9EVduHWHbF8iOsA8ua-ZGGh4s1x6Lia24LAZEMg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <4c06d3a9-7f09-c97c-a6f3-c7f7419d16a7@gmx.com>
Date:   Mon, 30 Dec 2019 14:09:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAOB=O_gBBjT9EVduHWHbF8iOsA8ua-ZGGh4s1x6Lia24LAZEMg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mQuTeEvXxIyOCqhMb1vSWHuDcXbBBIHb1"
X-Provags-ID: V03:K1:LdZkESho3II1sNSoMYHbyckSBvQq1Cvgf4iiezFlg24OnOfKOUj
 LQ/S95CfB9x+pcJeyvafd68GtAUkRln86rRn410Rh914RtvOkHlWea0V5YBSOnn8/lXPj6U
 TAsOuJqMkAz+09EXICJzGKsISoUpQL6Ej0NEwpiVEFhOlIvHTQveGx7y56etxTntihlfmRN
 fx8G4zayrg6wGJKHGQlWw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:w59ZoVOqq94=:beRbeo2qmENtoWct8/RKmX
 w1bF/Q3CwjR2NNyi6TPAjoHbBbdEp/j7d+k9/Ug6RiPctuOXryZdhxIVFeD6wMJlOsdwfnvm7
 hkno12aCKTgl4UfhJhhh81Hfm4SsZAtYfBqiJvOwcmIXtd0hANyw2vDW76nlYqnbtv3bXxAlU
 iR4N0gB4zM3TjqHdYUI7eluPZbUhZlr7esiERqjoBHyXrKwpmDUVLr8lgCU4zmz/TeHwx3eNh
 /GVn7wrO5BQG29RyCwltIOIgGk/7eaKaHHtb3bTK6G8YftP9VxRgQ1uI7AYZuUwO9xkoXlBf5
 A6+oOlMWmHca2umtOEfK3byJFIirkk0xYDqtM9mZZb7NjqA57zG9aPmbUCk2xZ3qDUm8R+61K
 aGy/mHgpajSbA4pHLi36yMmWBwfjf3TUbfed5S1bCYAL2O9vRCIiiqG9bLVOq7qwObKlYfFwN
 NzWT33NRq9XdUJ7Vin/z1n+qz+Ivn8cVsL6a/YpcPwIJdFSU6q7MBg1ALvyYYNW4y27Vi1GAw
 esQUivEefODMMD7FYe9u11/68b9JLZZY24j8myahuLuXcNs4ABHZoXhaVbKGxA3OxI+7CDSBW
 122qTdMw8vt+AJ7SNwE8waKEHKMGuEYOsjEqcXr3XvuaipAp0xT2htENP61QUZko/iSiJuKtn
 pp12eTqbifjAnc5ylQd53XKZ0UkIz2OoMFqMW+fbFUeL6Tx0Nl9AbDaMWQxpzifw9rNFFIi02
 i8o6wqXxCfZ95hFYJwe2ymIU1CqUgaabhaean6yTTao6A1+J7ktS+Nb6x/nRotEXt6bjLbqok
 xTa15NQz+NDj3e1j09bLbG248NW66c6C03WuD2UGWaMKhvqIpbELoYDcri5M+BuezUavUJ6MH
 546p14GY0rd91cVzkvz0/76ukdp7gewnB7RfwGzXw/zRb8+40hFLpk2rIo8ohI16XyQMnUj8O
 h87Rpmgi5ZDSElK8RMjJXkzrRzAHY0Mx5gF7ylOxr5IHCEnW97RDkn+JgNrke7oZBBfqSCrim
 H4oxvePDoge3YgvLIGaAAmIXVmk1J9dlG55NzeJp6e1Tn+vhnjy1wY406McV5rr0ISrS7fUbi
 b+9cOvtnUhblWhuPm7YaA925d/2EEFT+alWO5Ub4lrMVOjoKeMl0A43X8nplyqaai5jImzqhH
 +azX7ilmOhLyPhacrsdzGEWaTwz0Cf5nVRxEtIPcpecf6B7xvHRZJv61lhVr3wCGicITN89Ve
 QjDof1VUn+1djy6YtTqI5hdLx50xFdwV+P1EV1Q3cc5Y0L8yccXs3x3JFwGE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mQuTeEvXxIyOCqhMb1vSWHuDcXbBBIHb1
Content-Type: multipart/mixed; boundary="4VfUMaXjUm1syj4GEoplFvPuSpScy7IhF"

--4VfUMaXjUm1syj4GEoplFvPuSpScy7IhF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/30 =E4=B8=8B=E5=8D=882:07, Patrick Erley wrote:
> On Sun, Dec 29, 2019 at 9:58 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>
>>
>>
>> On 2019/12/30 =E4=B8=8B=E5=8D=881:50, Patrick Erley wrote:
>>> On Sun, Dec 29, 2019 at 9:47 PM Patrick Erley <pat-lkml@erley.org> wr=
ote:
>>>>
>>>> On Sun, Dec 29, 2019 at 9:43 PM Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
>>>>>
>>>>>
>>>>>
>>>>> On 2019/12/30 =E4=B8=8B=E5=8D=881:36, Patrick Erley wrote:
>>>>>> (ugh, just realized gmail does top replies.  Sorry... will try to
>>>>>> figure out how to make gsuite behave like a sane mail client befor=
e my
>>>>>> next reply):
>>>>>>
>>>>>> here's btrfs check /dev/nvme0n1p2 (sda3, which is a mirror of it, =
has
>>>>>> exactly the same output)
>>>>>>
>>>>>> [1/7] checking root items
>>>>>> [2/7] checking extents
>>>>>> [3/7] checking free space cache
>>>>>> [4/7] checking fs roots
>>>>>> [5/7] checking only csums items (without verifying data)
>>>>>> [6/7] checking root refs
>>>>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>>>>> Opening filesystem to check...
>>>>>> Checking filesystem on /dev/nvme0n1p2
>>>>>> UUID: 815266d6-a8b9-4f63-a593-02fde178263f
>>>>>> found 89383137280 bytes used, no error found
>>>>>> total csum bytes: 85617340
>>>>>> total tree bytes: 1670774784
>>>>>> total fs tree bytes: 1451180032
>>>>>> total extent tree bytes: 107905024
>>>>>> btree space waste bytes: 413362851
>>>>>> file data blocks allocated: 90769887232
>>>>>>  referenced 88836960256
>>>>>
>>>>> It looks too good to be true, is the btrfs-progs v5.4? IIRC in v5.4=
 we
>>>>> should report inodes generation problems.
>>>>
>>>> Hurray Bottom Reply?
>>>>
>>>> /usr/src/initramfs/bin $ ./btrfs.static --version
>>>> btrfs-progs v5.4
>>
>> This is strange.
>>
>>
>> 6084adam|thinkpad|~$ btrfs check --mode=3Dlowmem test.img
>> Opening filesystem to check...
>> Checking filesystem on test.img
>> UUID: c6c6ddd2-01c1-47fc-b699-cacfae9d4bfd
>> [1/7] checking root items
>> [2/7] checking extents
>> [3/7] checking free space cache
>> cache and super generation don't match, space cache will be invalidate=
d
>> [4/7] checking fs roots
>> ERROR: invalid inode generation for ino 257, have 8858344568388091671
>> expect [0, 9)
>> ERROR: errors found in fs roots
>> found 131072 bytes used, error(s) found
>> total csum bytes: 0
>> total tree bytes: 131072
>> total fs tree bytes: 32768
>> total extent tree bytes: 16384
>> btree space waste bytes: 123409
>> file data blocks allocated: 0
>>  referenced 0
>> 6085adam|thinkpad|~$ btrfs --version
>> btrfs-progs v5.4
>>
>> As expected, v5.4 should detect such problem without problem.
>>
>> Would you please provide extra tree dump to help us to determine what
>> makes btrfs check unable to detect such problems?
>>
>> # btrfs ins dump-tree -b 303629811712 /dev/dm-1
> anvil ~ # btrfs ins dump-tree -b 303629811712 /dev/nvme0n1p2
> btrfs-progs v5.4
> Invalid mapping for 303629811712-303629815808, got 476092633088-4771663=
74912
> Couldn't map the block 303629811712
> Couldn't map the block 303629811712
> bad tree block 303629811712, bytenr mismatch, want=3D303629811712, have=
=3D0
> ERROR: failed to read tree block 303629811712
>=20
The bytenr is different from your initial report.

Anyway, you can try mount with v5.4, and use the bytenr from the dmesg.

Then please provide both dmeg (including the "corrupted leaf" line), and
the `btrfs ins dump-tree -b` output.

Thanks,
Qu


--4VfUMaXjUm1syj4GEoplFvPuSpScy7IhF--

--mQuTeEvXxIyOCqhMb1vSWHuDcXbBBIHb1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4JlLEXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qgNCAf9EyG/vyIewl9aJ00fjlY6O2db
yTF0dZscwhgzKvhYZD7NFrYYQlBHfU8z3imjY89blo8N8tbdoHefwaDUe/OV2gL1
tfBYX5ypGICAf4ntZGDAHhbxJOjPTGm8x5AUyXooovxbLuuEfZ7HhATPvbjba7p0
s18bOomL/Tq5Ku1NW6bwvdA+asdMMb6zTwTBldrLESxgClY7Uz/KWYrEV21fgtpn
0dRj32tkLtFN05eaYNxc+DKvlAEFgjltqO8eXk2mN0j23CgHtORdoO14Ki7YX5HE
m8NSIqXi1AtBKTz/iZp5pX5XgS0cZfjqSF/65gjtbh+QiQtUgTILI2BzjrM8bQ==
=9mnH
-----END PGP SIGNATURE-----

--mQuTeEvXxIyOCqhMb1vSWHuDcXbBBIHb1--
