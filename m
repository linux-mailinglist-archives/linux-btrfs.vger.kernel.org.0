Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0A70DDBC1
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Oct 2019 02:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfJTAi2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Oct 2019 20:38:28 -0400
Received: from mout.gmx.net ([212.227.15.15]:51947 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfJTAi2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Oct 2019 20:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571531904;
        bh=eV72zwv536rlcgSwzjepd2qfq6dNnL6t4w8rxZR/NdA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=eb6UtovqTXkE4X5U0nzTjyldBO49p3yR1KjQBfqa7gIpUUBDCF1nWu6zFweBf6mbl
         0S4Yv2QBuWE5nG9q0DzrQbekHjW7e+3G7sLMn7XzuFi9rnkEdDPx1fXS1AQ1+irbV+
         mBUPvZuHzug37ZAVQyjnQ0Dozluqtg8FYpgouR5Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MO9zH-1ifaY23HLN-00OWfJ; Sun, 20
 Oct 2019 02:38:24 +0200
Subject: Re: first it froze, now the (btrfs) root fs won't mount ...
To:     Christian Pernegger <pernegger@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAKbQEqE7xN1q3byFL7-_pD=_pGJ0Vm9pj7d-g+rRgtONeH-GrA@mail.gmail.com>
 <CAKbQEqG35D_=8raTFH75-yCYoqH2OvpPEmpj2dxgo+PTc=cfhA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
Message-ID: <4608b644-0fa3-7212-af45-0f4eebfb0be9@gmx.com>
Date:   Sun, 20 Oct 2019 08:38:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAKbQEqG35D_=8raTFH75-yCYoqH2OvpPEmpj2dxgo+PTc=cfhA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kdmeqfpgNvLulWfQ7BwCLJ2b3vQl0qvbX"
X-Provags-ID: V03:K1:3LAj8kj9pEnMmKe0kphFq/9IkB6ar+2MEvxsqfTKEUoiYG0O5C9
 PhEhQ8yvtybHa4IFNU8RZmbi3T0E5YjNj+qs6OVvwC5WpN6BTUZJCMJftpD6UUupeMQ+/1O
 0Lk6U/Xkt7GiCX5F2LB0EWigwHuePL9ve8ik3646mPiPPC3vOF65gjwrCWodXK7LoJej2LZ
 Ajm5KdrrBFUx+pj5AbitA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:41JQguGCbrw=:9QnQf097VHMWs5l8jRTtRw
 Vax7bqcnnmAV2HnxbIzWWHkMOI+dhUaaqOJgXCmUZpFm34qUB+CI+cBKG9OdVc0ldu9LCHJLb
 dPdsLWDfDWBtN58B9eWvI0Jl5aCpj64FxFKshC6iu6lfskKdUwj3XnwHpqgNpbSAVnwKUa/nr
 S7ldDDnx20HkbYV9ASYcQkOw7aKEMe4ASO8TaXwxE6FtyUUpZUHDQUy07T08+5ZYJ9WpxPMYk
 lqUXVLZlF6ty271U8mN/jYlqVnt++EHdI4PKKQYidjFM1B5Uhy6OmwHohaz4Gesddk+DZ42Rm
 kJin0tu4TtSd3tlPbCwY8Yja8JcM2qWzNViiY/OlGTWwL8AoBGfoa4lgGsHweGOH98DbXifqZ
 mmpvUFlhKPI2gOAtB7YZ9eOS+MIZ605dJC06Pojyi79mdpLIXbimLZK+vc1xB8G/0VCn4lZsn
 m708oPwy1/hqfuj0q30w1ylbCS83KJQ9wewdUaKIZ9j7h2/W1yzGbr2NR7JgAEGraIxuALcST
 jTrz9NWoPTOHE6x1ksGxMomT5J8VhO5TLp5OktyYVlF9KL3YWkX4vdbcHVCvWtCropoQ3Ufsb
 YRCMtpokZGheu7B8bvZ/U0PLc3EBU5RrEUgodes3mLL+hfxZorHcsYaZbBCFHLdavV/Rg6F9e
 54rJ5Zc5nLoxJR9GAB0fb4wQr45Lu6EpbJ9qzSNmONfniAAN4nwIzdCG+6aRqK1gL/IoQu12z
 C0OV5dP9oXEoLAEfauu6SNNTW+eX0cOBMOxleOOtW5/RFRq06oTu0YZ8P2RlTtN3YqffbhGSt
 1puf5kFv34LRIYU98jSURZL4tfxnTFWtAAw96dJ+tGlK/C/oZNJCJJyml06Q9oZYT4ITTKZ0S
 +K7rukPfyC0qLB5dKIbUZn2t+ntLYuIAc6IlP7ryEC48uTdPebVDdZth6OCmqDVI2g+8H/SmR
 gWVkD/4haq43YCl/5AlkXmez0HjL/NeeDWt5QyVu6VIN9vx1QNiGkOcomU+MTwtIdLpu7gQmG
 HKd1h4YOmoo/41LADx5tWiuRy3yMKW3oCGzUhayFs55IjZr6trzF9eoz6cM0fgLwlH5RipAZi
 +zhAsaNzBwwffdfNgJNxxpjw/YuzBH1ZkzlAOmICJ9Ovz10+PnMqYPBpbzkCoBnDH29T4vQOz
 cu5bXYdcnEP47hah7FsXXdS360PIY6JDuxolLUd5/0u8jpBhSrUppesTU7gxxyxsBYyq7sJTj
 /bx9aY7vqiOn1xzCatqSfmh6BMoaEFFbjMiYfg2dXoDl1QoxiFxBWae3Y2UI=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kdmeqfpgNvLulWfQ7BwCLJ2b3vQl0qvbX
Content-Type: multipart/mixed; boundary="TOOXMhGwDYi3ZQVGmre5VpICh8bReOluZ"

--TOOXMhGwDYi3ZQVGmre5VpICh8bReOluZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/20 =E4=B8=8A=E5=8D=886:34, Christian Pernegger wrote:
> [Please CC me, I'm not on the list.]
>=20
> Hello,
>=20
> I'm afraid I could use some help.
>=20
> The affected machine froze during a game, was entirely unresponsive
> locally, though ssh still worked. For completeness' sake, dmesg had:
> [110592.128512] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma0
> timeout, signaled seq=3D3404070, emitted seq=3D3404071
> [110592.128545] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process
> information: process Xorg pid 1191 thread Xorg:cs0 pid 1204
> [110592.128549] amdgpu 0000:0c:00.0: GPU reset begin!
> [110592.138530] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx
> timeout, signaled seq=3D13149116, emitted seq=3D13149118
> [110592.138577] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process
> information: process Overcooked.exe pid 4830 thread dxvk-submit pid
> 4856
> [110592.138579] amdgpu 0000:0c:00.0: GPU reset begin!

It looks like you're using eGPU and the thunderbolt 3 connection disconne=
ct?
That would cause a kernel panic/hang or whatever.

>=20
> Oh well, I thought, and "shutdown -h now" it. That quit my ssh session
> and locked me out, but otherwise didn't take, no reboot, still frozen.
> Alt-SysRq-REISUB it was. That did it.
>=20
> Only now all I get is a rescue shell, the pertinent messages look to
> be [everything is copied off the screen by hand]:
> [...]
> BTRFS info [...]: disk space caching is enabled
> BTRFS info [...]: has skinny extents
> BTRFS error [...]: bad tree block start, want [big number] have 0
> BTRFS error [...]: failed to read block groups: -5
> BTRFS error [...]: open_ctree failed

This means some tree blocks didn't reach disk or just got wiped out.

Are you using discard mount option?

>=20
> Mounting with -o ro,usebackuproot doesn't change anything.
>=20
> running btrfs check gives:
> checksum verify failed on [same big number] found [8 digits hex] wanted=
 00000000
> checksum verify failed on [same big number] found [8 digits hex] wanted=
 00000000

Again, some old tree blocks got wiped out.

BTW, you don't need to wipe the numbers, sometimes it help developer to
find some corner problem.

> bytenr mismatch, want=3D[same big number], have=3D0
> ERROR: cannot open filesystem.
>=20
> That's all I've got, I'd really appreciate some help. There's hourly
> snapshots courtesy of Timeshift, though I have a feeling those won't
> help ...

If it's the only problem, you can try this kernel branch to at least do
a RO mount:
https://github.com/adam900710/linux/tree/rescue_options

Then mount the fs with "rescue=3Dskipbg,ro" option.
If the bad tree block is the only problem, it should be able to mount it.=


If that mount succeeded, and you can access all files, then it means
only extent tree is corrupted, then you can try btrfs check
--init-extent-tree, there are some reports of --init-extent-tree fixed
the problem.

>=20
> Oh, it's a recent Linux Mint 19.2 install, default layout (@, @home),
> Timeshift enabled; on a single device (NVMe). HWE kernel (Kernel
> 5.0.0-31-generic), btrfs-progs 4.15.1.

About the cause, either btrfs didn't write some tree blocks correctly or
the NVMe doesn't implement FUA/FLUSH correctly (which I don't believe is
the case).

So it's recommended to update the kernel to 5.3 kernel.

Thanks,
Qu

>=20
> TIA,
> Christian
>=20


--TOOXMhGwDYi3ZQVGmre5VpICh8bReOluZ--

--kdmeqfpgNvLulWfQ7BwCLJ2b3vQl0qvbX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2rrHwACgkQwj2R86El
/qgtoAgAoXHVqYGVTeOqrghOYItpewQM1sadKMHYW7yH+gKjE2pbsj5HZqs/hsSk
4jou7/18HxpNIvbIVEZizfaxdyzixoc0qH2HIzn6aLwgJvyK+4SdMhoI6bym2Zib
Uo0UqFGmpectNVW2qqMlIPIEQRIdkv4/HvyXruNhUu5VDRpc4LMeDN1hao+bRygL
XyFKRFR+Ko15Nbk/UUkMQ8buKucog94JjKLyI1aD2Sr4u5P/+BcTPubihY0lzQ4/
11s+zw/64S0jeu2ZiK19wQLb5DSLRLzyuPaYdNnqXrXjI/1r/wDxAA59Pekd7zV8
iXyrfiBe4knx1yZ1TLIWdET8rXXf4A==
=HtNK
-----END PGP SIGNATURE-----

--kdmeqfpgNvLulWfQ7BwCLJ2b3vQl0qvbX--
