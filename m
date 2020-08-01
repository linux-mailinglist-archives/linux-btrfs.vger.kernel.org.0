Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F031D2350DA
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Aug 2020 09:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgHAHCo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Aug 2020 03:02:44 -0400
Received: from mout.gmx.net ([212.227.17.22]:60541 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgHAHCo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 1 Aug 2020 03:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596265361;
        bh=v3pyjgVa0wXL6VmH7Qudc7b5tOHb+PM73CP50p/me6I=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=dzUH57TVo6HsCWgnu3rbqvVaBT3qR9TEZyn6tBTx7DKsM2vr1zhjwwvgC8JDE0Cns
         eX++oJhHobF0EgruYXpE3OOlhzTL+dAQbg/uhM2PrMhY8ejoZqdv3IXHQEHWdaGMIi
         KLz9XWoEXITeVrO3oXu8X1ndf89osEP3/3JfFXHs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmULx-1kS3kX0MLp-00iX4O; Sat, 01
 Aug 2020 09:02:40 +0200
Subject: Re: Access Beyond End of Device & Input/Output Errors
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Justin Brown <Justin.Brown@fandingo.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAKZK7uwRs_tf6htRtJvw3kNhyNPMJ-juA6_WSJo+PbQA7f40Cg@mail.gmail.com>
 <8e17a4d1-6555-15ba-808c-dd867d7ecbcb@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <4f21b4c4-430e-59eb-068c-231cf3bc492d@gmx.com>
Date:   Sat, 1 Aug 2020 15:02:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8e17a4d1-6555-15ba-808c-dd867d7ecbcb@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0pXu43eADfrSZijgqVJOlrzE0wEQcfQji"
X-Provags-ID: V03:K1:aTo14dr7V+CDRN9GAMQzZVqaDqy95CiFNPfANRH6iP/7sbnKMDJ
 NK16eLLGLNruC0vd+iDMhY9HQvLjY+rZw+EW6svYnvKMGUSCoAB0l73Gk6cMPZ5x3MpwaD7
 Odoi4eL3CelcvwM8vTa7H3ljhudoI7LaLWr1OKV5nO87d7ZMWGWlaaR2q8EOC33bxGq8B6C
 1S+PMMEYWixyqW2x8ky9w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gs3PpldPV4c=:ny3pVB+WoBVml+fLdd+F96
 iqOkH8SC41fQgGWWvb+ki6HdJCmrGPVAsjNiqQ2V0MFJ7YzeEUCu9ynqC13Lq/1RDc7ZXINR5
 FFpsyE27A46uJTvaAXB18Z26VTmjSTiGPX14jITDi3K2KkzFDkteERS6TBb+qp1G46fK9du9S
 4LXYlp1ChTLSl5QhF68s4u7WHEf5UT1AdoZ1bwgl3Mgspf4MOrxTZoelwiLRKbjyQOqORZT/H
 Owoh45mKL5NOMTq+sxtYFj5rWBdzeQkKi/xNYwjO0hL+xDwsa+vLU+PiSCG0nUcnQ1b9u1nPU
 DZEyy1h35wo7rZbNhhzAXByi5Rc0+59TnXuI3KeCWfuoFXcojbp2A9xXi9VaZXeYuSAwgVWf+
 YGxzVp8oniBTgDo55P7ZFA2j3ACxZAPlCaf7NBW4zpxJNAhkA3GEGb43rX7dM2ugc0p+RdD39
 5YD4aptqXCQfmRZF34iTmilKjkq9OldjmYd9RbGfOjVwGvd28H/zXTbkCZWNi31jaX+jpmdFS
 nM5Yn0/nyNpR8e1MeWC6D/k5hDcHRGfqaTt1xZCEuJ50ja8f3vs0sCiFenhHVJzmBwukqncSP
 NUMjpEWDfexi6XIlzxAF2i8nX95zyWOQ7y0+DP0nw7CRDTHT9agNJdGXBNuAwibUIF7Yf+Lk2
 RIp+qZj4tPwenxw79W5Y/MK8JMbHgfBmaSFTf8waaUviU3kckO7jLMXI+ItH6kPKYP3TKLcm6
 cSzf2iwF1RQHhFsaA6cRiDb23GOMTE7mLX/rqoya+d9CRr1LJLEH3S76VBKtJHQ9cX9vpIrNY
 /nq31zyk14qNKCLclpJM/26ioJBtXfxd6urp+anf0ZGkE7/CHnDG4YmiI/qMAsfJ5OcZC3idy
 DHnOQGuGuHVYtYvAWk9o75EDzjr3a16erw6QqsNlZ3T+eaSA+Ayn5LTgO+FdpC2o2s1sF8ckq
 MLiqnM8sfT+U/48dwbp5MS+shTLh5RYfpjW8bruClXrKQscRjLn31WsQvdhPlcUiKx6Xgc8RH
 ZnGSerW80HZPzerUThVjGmiJKPzTAYAfYN2uH7t2de4EzWSgAB2Q6VjuXG1rbLlBo0VdCdVFT
 A8YOQHl5Q0smJe9dwrfOEvkFt4gLyPshRgWBmRk0SQzngghq+faecTea39O8lVmrCHQ2XdOzl
 Em6KglITN/xUWL5FdiewRiAtGS0qtd3ol7a5lC4l2AQS4sz6IkKfu98FZeBqJO3NUKPV3lmrq
 Qz2nilEXBdpjQcxLdYpHBln4aqJbTu/ni/vqDCw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0pXu43eADfrSZijgqVJOlrzE0wEQcfQji
Content-Type: multipart/mixed; boundary="g6n99o1atatv0dVDOIbxSVYuPGui5zYSW"

--g6n99o1atatv0dVDOIbxSVYuPGui5zYSW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/1 =E4=B8=8B=E5=8D=882:58, Qu Wenruo wrote:
>=20
>=20
> On 2020/8/1 =E4=B8=8B=E5=8D=882:51, Justin Brown wrote:
>> Hello,
>>
>> I've run into a strange problem that I haven't seen before, and I need=

>> some help. I started getting generic "input/output" errors on a couple=

>> of files, and when I looked deeper, the kernel logs are full of
>> messages like:
>>
>>     sd 5:0:0:0: [sdf] tag#29 access beyond end of device
>=20
> We had a new fix for trim. But according to your kernel message, it
> doesn't look like the case.
>=20
> (No obvious tag showing it's trim/discard)
>=20
>>
>> I've never seen anything like this before with any FS, so I figured it=

>> was worth asking before I consider running the standard btrfs tools.
>> (I briefly started a scrub, but it was going crazy with uncorrectable
>> errors, so I cancelled it.)
>>
>> Here's my system info:
>>
>> Fedora 32, kernel 5.7.7-200.fc32.x86_64
>> btrfs-progs v5.7
>>
>> /etc/fstab entry:
>> LABEL=3Dmedia /var/media btrfs subvol=3Dmedia,discard 0 2
>>
>> btrfs fi show /var/media/
>> Label: 'media' uuid: 51eef0c7-2977-4037-b271-3270ea22c7d9
>> Total devices 6 FS bytes used 4.68TiB
>> devid 1 size 1.82TiB used 963.00GiB path /dev/sdf1
>> devid 2 size 1.82TiB used 962.00GiB path /dev/sde1
>> devid 4 size 1.82TiB used 963.00GiB path /dev/sdg1
>> devid 6 size 1.82TiB used 962.03GiB path /dev/sda1
>> devid 7 size 7.28TiB used 967.03GiB path /dev/sdb1
>> devid 8 size 7.28TiB used 967.03GiB path /dev/sdd1
>>
>> btrfs fi df /var/media/
>> Data, RAID5: total=3D4.69TiB, used=3D4.68TiB
>> System, RAID1C3: total=3D32.00MiB, used=3D304.00KiB
>> Metadata, RAID1C3: total=3D6.00GiB, used=3D4.94GiB
>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>>
>> I can only mount -o degraded now. Here are the logs when mounting:
>>
>> Aug 01 01:15:26 spaceman.fandingo.org sudo[275572]: justin : TTY=3Dpts=
/0
>> ; PWD=3D/home/justin ; USER=3Droot ; COMMAND=3D/usr/bin/mount -t btrfs=
 -o
>> degraded /dev/sda1 /var/media/
>> Aug 01 01:15:26 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#30=

>> access beyond end of device
>> Aug 01 01:15:26 spaceman.fandingo.org kernel: blk_update_request: I/O
>> error, dev sdf, sector 2176 op 0x0:(READ) flags 0x0 phys_seg 1 prio
>> class 0
>=20
> OK, it's read, not DISCARD, thus a completely different problem.
>=20
>=20
>> Aug 01 01:15:26 spaceman.fandingo.org kernel: Buffer I/O error on dev
>> sdf1, logical block 16, async page read
>> Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS info (device
>> sde1): allowing degraded mounts
>> Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS info (device
>> sde1): disk space caching is enabled
>> Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS warning (device
>> sde1): devid 1 uuid cb05aae6-6c03-49d3-b46d-bf51a0eb8cd0 is missing
>> Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS info (device
>> sde1): bdev /dev/sdf1 errs: wr 4458026, rd 14571, flush 0, corrupt 0,
>> gen 0
>>
>> It seems like only relatively recently written files are encountering
>> I/O errors. If I `cat` one of the problematic files when the FS is
>> mounted normally, I see a ton of this:
>>
>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#26=

>> access beyond end of device
>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#27=

>> access beyond end of device
>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#28=

>> access beyond end of device
>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#29=

>> access beyond end of device
>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#30=

>> access beyond end of device
>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#0
>> access beyond end of device
>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#1
>> access beyond end of device
>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#13=

>> access beyond end of device
>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#2
>> access beyond end of device
>>
>> Now that I'm remounted in -o degraded, I'm getting more comprehensible=

>> warnings, but it still results in I/O read failures:
>>
>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
>> sde1): csum failed root 2820 ino 747435 off 99942400 csum 0x8941f998
>> expected csum 0xbe3f80a4 mirror 2
>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
>> sde1): csum failed root 2820 ino 747435 off 99946496 csum 0x8941f998
>> expected csum 0x9c36a6b4 mirror 2
>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
>> sde1): csum failed root 2820 ino 747435 off 99950592 csum 0x8941f998
>> expected csum 0x44d30ca2 mirror 2
>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
>> sde1): csum failed root 2820 ino 747435 off 99958784 csum 0x8941f998
>> expected csum 0xc0f08acc mirror 2
>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
>> sde1): csum failed root 2820 ino 747435 off 99954688 csum 0x8941f998
>> expected csum 0xcb11db59 mirror 2
>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
>> sde1): csum failed root 2820 ino 747435 off 99962880 csum 0x8941f998
>> expected csum 0x8a4ee0aa mirror 2
>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
>> sde1): csum failed root 2820 ino 747435 off 99971072 csum 0x8941f998
>> expected csum 0xdfb79e85 mirror 2
>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
>> sde1): csum failed root 2820 ino 747435 off 99966976 csum 0x8941f998
>> expected csum 0xc14921a0 mirror 2
>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
>> sde1): csum failed root 2820 ino 747435 off 99975168 csum 0x8941f998
>> expected csum 0xf2fe8774 mirror 2
>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
>> sde1): csum failed root 2820 ino 747435 off 99979264 csum 0x8941f998
>> expected csum 0xae1cafd6 mirror 2
>>
>> Why trying to research this problem, I came across a Github issue
>> https://github.com/kdave/btrfs-progs/issues/282 and a patch from Qu
>> from yesterday ([PATCH] btrfs: trim: fix underflow in trim length to
>> prevent access beyond device boundary). I do use the discard mount
>> option, and I have a weekly fstrim.timer enabled. I did replace 2x2TB
>> drives with the 2x8TB drives about 1 month ago, which involved a
>> conversion to -d raid5 -m raid1c3, which I suppose could hit the same
>> code paths that resize2fs would?
>=20
> The problem doesn't look like a trim one, but more likely some device
> boundary bug.
>=20
> Would you please provide the following info?
> - btrfs ins dump-tree -t chunk /dev/sde1
>   This contains the device info and chunk tree dump. Doesn't contain
>   any confidential info.
>   We can use this info to determine if there is some chunk really beyon=
d
>   device boundary.
>   I guess some chunks are already beyond device boundary by somehow.

And `lsblk -b` output.

It may be possible that device size in btrfs doesn't match with the real
device...
>=20
> Thanks,
> Qu
>=20
>>
>> Any advice on how to proceed would be greatly appreciated.
>>
>> Thanks,
>> Justin
>>
>=20


--g6n99o1atatv0dVDOIbxSVYuPGui5zYSW--

--0pXu43eADfrSZijgqVJOlrzE0wEQcfQji
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8lE4sACgkQwj2R86El
/qgCGQf/ZlUesZBavFQg8G1Rxz8WbBLESscgxnOiIz/QN/BlDOKJH4fEM84audY3
1rHteitsARikPlzLuWuagtU+Jy1Nv+ruWYa8ZlEyPHWW3zvQkIz5BKV03tRK87cm
6hgwzrBSbeVDE2io+Msb1xT+lg5RxCVDa4xtgp6sGKCcjKT9NlUXim+D2hqHDhgC
/S7pzVdvrEKMiN3Pn54OxYHiNhN75jV/Uw/zK3LcnWbaACnhrvnuZeIlT7XxZna6
3zT7z4nQBIBm3XlWrCqMnYFLFAExOrqKSIL3sySo7JgBgtflukQaKH5Z0ecQImAo
Vsmd3X+ZDvGHHFHP1ykD+WQNBeDOog==
=aeUh
-----END PGP SIGNATURE-----

--0pXu43eADfrSZijgqVJOlrzE0wEQcfQji--
