Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85603172CCA
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2020 01:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbgB1AIa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Feb 2020 19:08:30 -0500
Received: from mout.gmx.net ([212.227.17.22]:57159 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729958AbgB1AIa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Feb 2020 19:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582848504;
        bh=wuo4wR5SWxhkWtsrMSGGqynr6HhAzLBSKBw7VxuA394=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=BdVhEkM8TIpmLVgnWHK37fNaqz7AwhUkeIcPerQ3qyGVOaOmfuBCREWbl3zwCbU/q
         HiHosk1JjaVtSkCKdxk/mWe81vzdK7BjPwAfZIH0TfEYlYf7ei1x9N5RJgP1hkECMF
         ryPbZnqlxNckiRXLZQTtGkMA1vBEYy0DhrTjy6GU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHXFx-1jCA1G1mhF-00DbYW; Fri, 28
 Feb 2020 01:08:24 +0100
Subject: Re: [PATCH 3/3] btrfs: relocation: Remove the open-coded goto loop
 for breadth-first search
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200224060200.31323-1-wqu@suse.com>
 <20200224060200.31323-4-wqu@suse.com>
 <72797bb0-b20c-3e80-6a15-131e33c9bd26@toxicpanda.com>
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
Message-ID: <013d9b26-d7b8-bc81-6d5b-1585924af4df@gmx.com>
Date:   Fri, 28 Feb 2020 08:08:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <72797bb0-b20c-3e80-6a15-131e33c9bd26@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kbLjURf0Lszc6Fo9YKpSi7PyRWvVQ3Vt4"
X-Provags-ID: V03:K1:S9KhAfvP/QeYVK2u2Kh8Qdif+8n5V9obVjEUqTdRFJ8Hk88TfJm
 oiMk+OPCs0wUMVL3NGbE6qkjHdgCVe2eDBNfpHYFJLWjJddmb7WwF7zrrOXmZrxaywgV1ZB
 P8P7vNZxd2xEgnCJ/AqfWtTBfonpwRE6ARSVbIGZNkZshdhbEcG9M5lrYR0HHra0hXK9SlC
 y7hAzTig1r/er3nKY14EQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:I4iDn2XzOhA=:JbI9P/CbOVguvUMqQijxS/
 T7mt2w+ZeU/fkNLbiLRg8TL8mtpebKjdSXA1bqHY8kxE6YeLBAT0LkdxQIaRh3gAEjyGdfYrz
 VYZnKFkB1joJ4b8gg60dQtTcx5BPqV8BSgkxymidQoaS3+W2HtRXKFaZS5zCR01fCXLwdUJnz
 RlxsM6+/S1tMOTAB50kBFeRbWE1/44HwlhqK+QXTuklmviz74ujEr+whLNBZ8bv+/r5F8+JuK
 NhC86Ly3n5Cq3Bp1wMhpOfFvkzqnvKOS86Zgz9ZbkWh2hWNSs7WW3xSp94q4YjD7SoiDpr0ra
 LYXlbiNMtJhqODppYJ+1qyZBCe+rc7v0SEtc49+TBFu8lgWJcCxRm1ldInVM5o1iIqzbQw6nt
 UXxhD90Z69TXsD77fHN2bqWj2HgCWEPviBNdPLitUIvvBQslgeowYhMLhDkKIeouuj+6AK9Gz
 nMgDRdnIJq3jBwy4pQrOsWskLxa1AJDdsson5tDjaPVcKRMItPzdze76DwHB2+NULUzZPvGYm
 GIA7hVvuAsmZk4Moaov3XuzIONEBStgGygnKjjUJatYNqcZSrTzUbw4Y9GnHPcjJ6lUiCt4xE
 QVdNDPZS7/rQndnV8+Tu6m/yF5mtL8yyEByClLf2kDJYsmGcK23Ms1DgvCkgl/WK2pSg8G57D
 FznkMhyoGDDrtbMh0QeZ/sZO2Z6HjoVCSJzsXlMk6wsdP53JKUDOKdxC2DXierX7ZSKjH9zeb
 2bmJAph9jM1w3PvizGdu1jQeCwysqe71lUYOtWXP/lRKfTFeUSi3iVdcCuALhvMFHugqImcDT
 PZshk9kkRTyeNKPnrRKTj67WGRaqPYS4CWi4DZDOcl3xRgCX/DtyXULyCcG5vfrMg/+/tmpsW
 bRyEuFAhP3YEi9HCs12neU+kPTUQ6vZE1gQGJL0sOWn0BVhGkxwJcd+WOYQt3NEEzoith1/Az
 qwzWDR1us1Bzmm/RwE42wUllw/aNmNdfyh9ENpcVLBDOYs5PEfG42g0nSabUmfs3KIDlUtZwU
 3fZ5IqcUKhY0b3wmqc52mlFhtQx8UQItGKUFmasAMi8rcf8xepph7gZf6gcrsIDDMiAUq9+9B
 oHKaBaoO2ROStuPvPfFtQTnIAE0/P6/BvPi9Z6mNnwCt6m/TfO7QVtixIaT0BPiWbduP7eHaf
 AxSopEPxn8paAEGWKIO88pkv+xCycPQViEX9uS+UUYdmMidMMytSecetLcoxokZGHnZdxA6S+
 cridXF/hO2v6Y4zPO
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kbLjURf0Lszc6Fo9YKpSi7PyRWvVQ3Vt4
Content-Type: multipart/mixed; boundary="6iRSnGDgOAAYfgHhVUb94rXrOyvl76Sz9"

--6iRSnGDgOAAYfgHhVUb94rXrOyvl76Sz9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/28 =E4=B8=8A=E5=8D=883:51, Josef Bacik wrote:
> On 2/24/20 1:02 AM, Qu Wenruo wrote:
>> build_backref_tree() uses "goto again;" to implement a breadth-first
>> search to build backref cache.
>>
>> This patch will extract most of its work into a wrapper,
>> handle_one_tree_block(), and use a while() loop to implement the same
>> thing.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> Do you have this in a tree somewhere that I can look at it?=C2=A0 I tri=
ed
> applying these but they don't apply cleanly to anything I have, and it'=
s
> hard to review this one without seeing how the code ends up after your
> diff.=C2=A0 Thanks,

Sure, here you go:
https://github.com/adam900710/linux/tree/backref_cache_new

But please ignore the latest 1 or 2 commits, as they are still under
development.

Every submitted patches will not undergo any extra modification in that
branch.

Thanks,
Qu

>=20
> Josef


--6iRSnGDgOAAYfgHhVUb94rXrOyvl76Sz9--

--kbLjURf0Lszc6Fo9YKpSi7PyRWvVQ3Vt4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5YWfQACgkQwj2R86El
/qiGYgf/Z2Em9FCESzMLt7jwumoR8TV5dAS9YJftmHasRi4La9nYFL9adzs+vCmd
iarK3HdOD6sHzh0WvSpNOIcjP21OVpgqzYh9GPTCwJb04J5hm3i2BKkHNR9Y+npA
xCfLWoeoqUZmaBQ+3exESxYCI8EKd5yP0vFWT/57OhWPpXmyHKi9sCLtsCFVc/UH
Oj/20NzZX4bpbpTE4p3tAZwx2q9sm+/jX5iiWcJKpKK1wk8XY+3+dyjt0MXIvuw5
3vXqL4XzIvt31lrME2/IEygkN5zIbTnkz+QL2rntdDGCqgn6ckaHC4+YhBHYi7ho
RX2xQnKuQS9VKiXQEvQ7uPpg342rBQ==
=5VTu
-----END PGP SIGNATURE-----

--kbLjURf0Lszc6Fo9YKpSi7PyRWvVQ3Vt4--
