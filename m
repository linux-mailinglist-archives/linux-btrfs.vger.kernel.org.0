Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78F4012CD22
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 06:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfL3F6p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Dec 2019 00:58:45 -0500
Received: from mout.gmx.net ([212.227.15.19]:40205 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbfL3F6p (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 00:58:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577685522;
        bh=o57mF0WLXQqEGrjbEqEoHRbu/5GR3MhOHvmEG2K7qbc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XyhsZ5f9cWnXaPvbPoDB+9WmvH1ExllIV8hzMDKHMTceXhc+UPkffN/nDP0JEai8s
         LnDW4vW+CWHHRw89kfX/dG6E3SHSKjM5QK1W3WRnGRB18uT7dQyaCZbtWpBdIzq0Yc
         Tu1tWm1i+v1Qo947k1o46GpIYUE0Rhd639CySyC0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MIMbO-1j07xG0ZZk-00EO2y; Mon, 30
 Dec 2019 06:58:42 +0100
Subject: Re: read time tree block corruption detected
To:     Patrick Erley <pat-lkml@erley.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAOB=O_jxu5JOe=JiYVW_VZ1rgs9+mdHpAHkscXkc4MVRLrBKDw@mail.gmail.com>
 <4bf17941-2ab0-15ca-b4c9-f6ba037624ee@gmx.com>
 <CAOB=O_jfwBVihtbNTF1xLNWNtf2_Mi=Bs_BCZ8VnXOKWosw7uQ@mail.gmail.com>
 <66d35620-160e-105a-6970-03c3de3f7c78@gmx.com>
 <CAOB=O_jpg0K4eDARfG+XDDRMHhm+yKp8XfhjqHsFxAswSPUfdQ@mail.gmail.com>
 <CAOB=O_hdjpNtNtMMi93CFh3wO048SDVxMgBQd_pC0wx0C_49Ug@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <a2f28c83-01c0-fce7-5332-2e9331f3c3df@gmx.com>
Date:   Mon, 30 Dec 2019 13:58:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAOB=O_hdjpNtNtMMi93CFh3wO048SDVxMgBQd_pC0wx0C_49Ug@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="re3H170yxvBFDQROR7mp1XmxME4SailmR"
X-Provags-ID: V03:K1:gFAfd+veKJnC1KlunSlDubF0V2Of57LrVYM6aUlga5GEDZy0bM2
 HEOVjvtI4urXceNp6tJD9ICzjsbxL173D3372uT4nDxKVMb5SwMu8vsfGgproNJgTDucpLN
 TN+LRSXrEOBnrkmrPlwyFOzjXna7qQKXqY2QxPxjc+PrfbtamzzEW0kh5hvNarAcA0/qYB+
 +8UNqLoREdDhx/XsIEFSg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IXeakgNcz1U=:m/K1Tp3o5vSZfw966Dbqnd
 Rfgt2hFTwKF9reI3R4Sm1NJiXJ5SHMNvUVLuIzpGqekLeOEgetG33JYzYCTxbd/u8gOes0UPk
 VDjseKhXS/qjhcxMihw+i7ghcRdZLsLDjJaY9lG9BAeRncZ2mY5G1HE29HHJlz0ThbhMNXzuk
 4Ay6hnR8zLz3stDofpA+ZPvEW+VXIgK3is4z5fR4+9ZF3/7MhhZwiKu5zueKyv2gaulglGtmK
 HBwOTg0Knys5dGiTHrlzy/K4gACrisAcyRlbZK4UCKtW8XF/WuituPQT0vl2ZMJo1CkTbFdF7
 5oY0I6ib4vdWy9RwbwbaxgKLf2ucm+5c2tTmD60GJhSmvMwzVfxztIvP9YS5+I0l654CK5tNN
 4WJBo+dZeVctlfAaIG8fS4g8mihWTh/IwFCHYJlthbTp04+t46+dYth+n2/zFFI9J4juhp5we
 ZQHBPjxvXZap2hG16/4CsS4d31JmEgFQekuECzbK3SApnsPfIEQRK3+KJkABSEyXHB7apwkDD
 yoG2H+09DArsE3XqBCce9UsypfOzGFPPWd6DEFWWSQXXHzXf2bsnNRdFwafyJ471hmoU/XUBZ
 XXKTMoF9CW0ln+04ESD+gUieyZvObWjKov2LQVWEAkQI4bPGRFl/4BRIS4C1pwbBJMH10I4F0
 ZVJk7ukoboQ//BItzTxEgcIcD5KhuP2iq6G6ooqJk3YYpvuc0JpLJ97uDj9kuBO82hTvYG72/
 lwYH9Mx2Pm1p2mUsYvHNyQYz0HXcDQaTUQJcZNwXRwotSmQV+OwxIGGvjLmkhqH3+/EmQg5I3
 g5Dumd4oVluShUYReGi68jMiucsFi7oOsV7dyKuI9/skuu9B5KJxKIltIs98IZ0gDv32Z/bDG
 /AqP4VItAmHVgvvq2k8AEchJcQADSao2Hed+JYK7ie4QD3jP5lR8PVdBvQ5YzP6GSI6K1rxjm
 /MhI6jvxCVJb47ndgNvfJveNm1DHaCJO21dP66pgZn3z/3WmYEX8Q4N8X/FSD3CRuDLHyb0cs
 XK5LvCsT63EOv8va9rpPbpiV1FD2Tf0/yxK8dV/TD4lD4aNi2AQTvhskgnRyjeqdeqWCxWL0k
 IVodh/WUg/ALc7mRKNJ5y9mo8b0Em1nsTqHlzRCKLLKNw88jjm9ZMDmd6sbOePVglKB7OfZu0
 N2jZ9OZ2TvASBatilTuJDg7wwSMWjop+XD2SnQmEZwiYen8rFsGAFRbZhncxtAw6GS3ySf7w9
 aDoWXLlIUSvlytJYQw2P93izAIdi90tqud8xf3j9JTcR1S+DEC9m1rxD9Uc4=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--re3H170yxvBFDQROR7mp1XmxME4SailmR
Content-Type: multipart/mixed; boundary="YeAbPT5VJKgZB3tVDa9ugb8p9J3St4Hd4"

--YeAbPT5VJKgZB3tVDa9ugb8p9J3St4Hd4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/30 =E4=B8=8B=E5=8D=881:50, Patrick Erley wrote:
> On Sun, Dec 29, 2019 at 9:47 PM Patrick Erley <pat-lkml@erley.org> wrot=
e:
>>
>> On Sun, Dec 29, 2019 at 9:43 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
>>>
>>>
>>>
>>> On 2019/12/30 =E4=B8=8B=E5=8D=881:36, Patrick Erley wrote:
>>>> (ugh, just realized gmail does top replies.  Sorry... will try to
>>>> figure out how to make gsuite behave like a sane mail client before =
my
>>>> next reply):
>>>>
>>>> here's btrfs check /dev/nvme0n1p2 (sda3, which is a mirror of it, ha=
s
>>>> exactly the same output)
>>>>
>>>> [1/7] checking root items
>>>> [2/7] checking extents
>>>> [3/7] checking free space cache
>>>> [4/7] checking fs roots
>>>> [5/7] checking only csums items (without verifying data)
>>>> [6/7] checking root refs
>>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>>> Opening filesystem to check...
>>>> Checking filesystem on /dev/nvme0n1p2
>>>> UUID: 815266d6-a8b9-4f63-a593-02fde178263f
>>>> found 89383137280 bytes used, no error found
>>>> total csum bytes: 85617340
>>>> total tree bytes: 1670774784
>>>> total fs tree bytes: 1451180032
>>>> total extent tree bytes: 107905024
>>>> btree space waste bytes: 413362851
>>>> file data blocks allocated: 90769887232
>>>>  referenced 88836960256
>>>
>>> It looks too good to be true, is the btrfs-progs v5.4? IIRC in v5.4 w=
e
>>> should report inodes generation problems.
>>
>> Hurray Bottom Reply?
>>
>> /usr/src/initramfs/bin $ ./btrfs.static --version
>> btrfs-progs v5.4

This is strange.


6084adam|thinkpad|~$ btrfs check --mode=3Dlowmem test.img
Opening filesystem to check...
Checking filesystem on test.img
UUID: c6c6ddd2-01c1-47fc-b699-cacfae9d4bfd
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
cache and super generation don't match, space cache will be invalidated
[4/7] checking fs roots
ERROR: invalid inode generation for ino 257, have 8858344568388091671
expect [0, 9)
ERROR: errors found in fs roots
found 131072 bytes used, error(s) found
total csum bytes: 0
total tree bytes: 131072
total fs tree bytes: 32768
total extent tree bytes: 16384
btree space waste bytes: 123409
file data blocks allocated: 0
 referenced 0
6085adam|thinkpad|~$ btrfs --version
btrfs-progs v5.4

As expected, v5.4 should detect such problem without problem.

Would you please provide extra tree dump to help us to determine what
makes btrfs check unable to detect such problems?

# btrfs ins dump-tree -b 303629811712 /dev/dm-1

>=20
> Dumb question, did I need to do that while booting a post 5.1 kernel?
> I ran these while not having the filesystem mounted, but against
> kernel 5.1.  I can easily repeat against 5.4.

Kernel version doesn't affect at all. All the detection and repair
should be able to be done by btrfs-progs.

But it would be better to use v5.4 to quick verify the fix is working.

Thanks,
Qu


--YeAbPT5VJKgZB3tVDa9ugb8p9J3St4Hd4--

--re3H170yxvBFDQROR7mp1XmxME4SailmR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4Jkg8XHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qjJQgf/dovl9NJNQCb4amrVY5MEaCxA
e/jXvIrvWY9fooGbVAz3CUWZvhNJWc8PTIN2DuGyK8jXB4q0gMyjJgfllKjq2suq
wlSXA7jzuIs9mOun8xdfgPFzgroTx//ZTQtukksXYI2g/iiWRo4pusMHBwIv/u9U
JLXZ53eNcD1OlSX4zxz0y4BI18nt5cXUyCHbczQofMWs3/hweakBv7Ux4vSHyQvT
8KMZerS8zSeurnMceY5LV/X0Z1razLPO76coqru2wFp/5RRAKFE92b2dbCj3z0QQ
ZhHkgQSr85yoJ0w1+cYT9MxENzzhokUN71/kos5bacGOmBfapuoJPOmbcNmlEg==
=u/ZU
-----END PGP SIGNATURE-----

--re3H170yxvBFDQROR7mp1XmxME4SailmR--
