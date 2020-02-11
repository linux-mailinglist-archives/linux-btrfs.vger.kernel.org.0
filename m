Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 150411589A7
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 06:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbgBKFf6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 00:35:58 -0500
Received: from mout.gmx.net ([212.227.17.20]:43915 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbgBKFf6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 00:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581399352;
        bh=YBAy8Ds0FeEwVEsSMnr8ySizSQiyhQYXW9yNL38KFl4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=RiyNzrgztqixSkx7BNbzUiFov32oly9AGDnVx3WpUMyw8swa+qJVLokCp025xyStq
         kIh9OdUGpCIyqVngxf+yYYkIH/sW9dAKTNLBHmNPAi0N+HEa/Ztfa8t4Dl4+jZFrP8
         9IaSvNDGKpxEqSeewvqfZ8KlIRJr+lkRHQs4ocMk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7JzQ-1j93iE3oE8-007iHD; Tue, 11
 Feb 2020 06:35:52 +0100
Subject: Re: [PATCH 0/4] btrfs: Make balance cancelling response faster
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191203064254.22683-1-wqu@suse.com>
 <20191204163954.GG2734@twin.jikos.cz>
 <fb81b112-3be5-f86a-3da8-621c1dae6bc1@gmx.com>
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
Message-ID: <380022b6-38f3-268d-850e-c9529c183930@gmx.com>
Date:   Tue, 11 Feb 2020 13:35:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <fb81b112-3be5-f86a-3da8-621c1dae6bc1@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ULvLojv8Hv9N6naIANs3J3XP7RcgJ93gf"
X-Provags-ID: V03:K1:6rK0QWkuU+WFtAZmo+ejqNTONoz1lxKb2gklfnlF7uWIXzIXvx4
 Iry2d3XedbCt0xtdHxiz+XDp//kvIwSHrULC/FeayaxhMqSvYs0amFSlx9LNr25IhNJxV63
 0Q120noHAJ8mBg43AYc5iXFNrl4d9t60TrQSx99gPbGpWc5Ws24WyK/6wrpigHgmxEFlGKJ
 j2Zjl4u5Rctm8DwXTzZeg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:T8YN8+I4q9I=:/LsIEmhPXl+C3qgxYwd0mG
 XJi4hYRScIhIzyy+VROcNzLdiz7Q/j1IkxLW+qMcWTkl7Et5PP2Lt+jqhkgwkZ4Py6gqF8Q72
 ZD99ackWDgAVdVDjfGdjZowwlFAfgk07hcik6FCuMiLiUaFP6jX80unXCyXpYEqrR1w7TJZjS
 5QDrj/G6kLIKwfYIOQGrCjPkLrPN26xzAO85Tuh/IWCeY5MdmVzUbuABmZgfxEq/GfMY/am8p
 F02Hw3TNv0PMcli5mZ2t+NJ0qP2rtbaStukguJYm1eHGBClN7cJ6ttVIggi0Tc4q/FxJDzzVE
 H3WCEWqE6tgH/tugPs4KgNA8Lw1+UYTja6ggTJF4xJaY3cIolvhGvfpEJRv3UkedD0cjgJSo2
 JtDmtQfeUjDCt6s/IBtp6NLrIhVhCFBivsyDngrZV2DgjPyRmeFmCwtJ/bYV1wQaACZSFk/UI
 pvPblPRPodfUOTmw9BtvjCOK+H+Jhvq/lJH6tvih15MV+eFmkS/i1/p2TQvpCwWmTzVvbq9fI
 +gX+RAdy0sUNEgm/08/ac0d0thqnon/NORfB4ZRUmsXDUaqMDpPf1MOpQn3nq0vCvAshWUmQq
 IgL3gypBwmSTyhVXQggGxxIgfxii0iMJMsYpf8eFjUARk2UK/5sF5mOnGTsOHlovcrxIyaa1s
 vp9OQuSZm4ovPWCvBSyAX9iUGG3//fUqAG55odmIMwExkrL892KIo/0bdta6DnvoqAU4nqJd4
 hlIAOJkiTTIS5XEM6RtxMZclFUyqlB+P63Nw9xulOB0uLe6pDfEBSLvA8VWgXwEaXBEr16GFc
 SQDhNQ+fpYNZQzRzBDnQr/8Mn//so+yy+UmYwy9lrjZ699carTHbJOaBYbB9icpgC2gqT0RES
 qE/MZ1oPt/cmCKAXAEuatC/odpnQkX2IzoXWStCBBVJV32kZ5cb/Kqun0Z9t06GUXZwUD0rxS
 QJVdZqRBy8RPVazm3/rafm8wC0RGYvVT6v9gGoXlAeaY+Rw9ENOakcKbnbf20X/YSKPl3/hrf
 ucq344v0raDiY31CGgvy/fOCHJTdCCBtqJ/E/5l0+C/oB5BL6VvDN7afKFqw+fsQPx443NM8V
 LDPfubfQ5fTIAswI+39rIZgL6v3+69lWMB8Gvmwa0tFazOE1bz6EfHOvjNv4l/cMojpUYc+ma
 PJSS8JxUX+xNzd5DQlzlAtaF4UaR0NEGKyHyqtnU5lvS0XTg0ZNmG238jwCA05yB73zg+A6wY
 oNAOtp0vBUw5m8xW8
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ULvLojv8Hv9N6naIANs3J3XP7RcgJ93gf
Content-Type: multipart/mixed; boundary="kYiMXgw7tMrDkLyL9pKgCnhiZnpMzf7bz"

--kYiMXgw7tMrDkLyL9pKgCnhiZnpMzf7bz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/11 =E4=B8=8B=E5=8D=881:21, Qu Wenruo wrote:
>=20
>=20
> On 2019/12/5 =E4=B8=8A=E5=8D=8812:39, David Sterba wrote:
>> On Tue, Dec 03, 2019 at 02:42:50PM +0800, Qu Wenruo wrote:
>>> [PROBLEM]
>>> There are quite some users reporting that 'btrfs balance cancel' slow=
 to
>>> cancel current running balance, or even doesn't work for certain dead=

>>> balance loop.
>>>
>>> With the following script showing how long it takes to fully stop a
>>> balance:
>>>   #!/bin/bash
>>>   dev=3D/dev/test/test
>>>   mnt=3D/mnt/btrfs
>>>
>>>   umount $mnt &> /dev/null
>>>   umount $dev &> /dev/null
>>>
>>>   mkfs.btrfs -f $dev
>>>   mount $dev -o nospace_cache $mnt
>>>
>>>   dd if=3D/dev/zero bs=3D1M of=3D$mnt/large &
>>>   dd_pid=3D$!
>>>
>>>   sleep 3
>>>   kill -KILL $dd_pid
>>>   sync
>>>
>>>   btrfs balance start --bg --full $mnt &
>>>   sleep 1
>>>
>>>   echo "cancel request" >> /dev/kmsg
>>>   time btrfs balance cancel $mnt
>>>   umount $mnt
>>>
>>> It takes around 7~10s to cancel the running balance in my test
>>> environment.
>>>
>>> [CAUSE]
>>> Btrfs uses btrfs_fs_info::balance_cancel_req to record how many cance=
l
>>> request are queued.
>>> However that cancelling request is only checked after relocating a bl=
ock
>>> group.
>>
>> Yes that's the reason why it takes so long to cancel. Adding more
>> cancellation points is fine, but I don't know what exactly happens whe=
n
>> the block group relocation is not finished. There's code to merge the
>> reloc inode and commit that, but that's only a high-level view of the
>> thing.
>=20
> When cancelled, we still merge the reloc roots with its source (if
> possible, as we still do the check for last_snapshot generation).
>=20
> That means, if balance is canceled halfway, we still merge what is
> relocated. Then do the regular cleanup (cleanup the reloc tree).

My bad, that's not the case. But it doesn't matter anyway.

Since we error out by setting @err to -ECANCELD, we won't go through the
merge part.

We just mark all related reloc roots as orphan, then go through the
cleanup path without doing the merge.

That's the existing error handling code, and we should have experienced
quite some of them for the random data reloc tree csum mismatch bug.

At least the error handling part looks pretty solid.

I'll add this explanation into the cover letter of next version.

Thanks,
Qu

>=20
> I see no problem doing faster canceling here.
>=20
> Or do you have any extra concern?
>=20
> Thanks,
> Qu
>=20


--kYiMXgw7tMrDkLyL9pKgCnhiZnpMzf7bz--

--ULvLojv8Hv9N6naIANs3J3XP7RcgJ93gf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5CPTIACgkQwj2R86El
/qg21ggAoL3JgntREaTImdyNrMKsn5s1bNTA6kY114kSAbTabyw6YuhjomxC9/BA
sbtki8ptpTLHFk/ynqY1j2hiaPMH/IgAso3chGkorWpwlo30iDnt+lJVNB+SpyN9
jGVbkWZbeUbigUbmctuDB2jUhZtxqcdFosbss8PKRbpuSlRiBGhdqgymlXaDQ1jB
C8u99UlEUcFneMw10b1rzmEmMgCWHO34E+EzQhgjjSfy5mEpP5V+eTtpaEOzTrzS
LTWaYeaieax+CBNVVLnsLGOs4do2m7svI9Rpoad2rYBxiuFm/HHTJPz+GLqXy3JJ
D1+PQaFgZl5z7BdBM1mui8iSIANEKA==
=fhjg
-----END PGP SIGNATURE-----

--ULvLojv8Hv9N6naIANs3J3XP7RcgJ93gf--
