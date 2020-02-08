Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C37D156830
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Feb 2020 00:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgBHX42 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 8 Feb 2020 18:56:28 -0500
Received: from mout.gmx.net ([212.227.17.21]:60733 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbgBHX42 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 8 Feb 2020 18:56:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581206185;
        bh=9Moa2LK8U9rv+AjRHR1GWibjz2i3tRMYQ920DmoUQ+8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=F7ckefbExgTPa+4oDaBLHiehqgqMTkbthn6htzzDJA0pDyre39lSJs5gwm3ySBPi6
         yC5zsxAuViZuyHCb3VB4StTC7xlEECgd+S2O7HmstMa4pTnaZ15Bbq062ILaKKgjyl
         aSnRBttIIr3fpkrxhTUriTvPg1B6FwEAkeNkrBak=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mzyuc-1jlPiw1YUI-00x55H; Sun, 09
 Feb 2020 00:56:25 +0100
Subject: Re: btrfs root fs started remounting ro
To:     John Hendy <jw.hendy@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CA+M2ft9zjGm7XJw1BUm364AMqGSd3a8QgsvQDCWz317qjP=o8g@mail.gmail.com>
 <CA+M2ft9ANwKT1+ENS6-w9HLtdx0MDOiVhi5RWKLucaT_WtZLkg@mail.gmail.com>
 <40b47145-f965-ec5f-2caf-68434c4fbc62@gmx.com>
 <CA+M2ft8zMv8nhs6VzZWnzgcP2nRasrwxLzjKgaZPnm_prtWQow@mail.gmail.com>
 <3e5f4de7-fec1-f8cd-c8b1-20b5a3f38f60@gmx.com>
 <CA+M2ft_6_1pkP75G79qj4dLxOjJr0bOGtATaGPTVQGn25sAo+A@mail.gmail.com>
 <CA+M2ft9dcMKKQstZVcGQ=9MREbfhPF5GG=xoMoh5Aq8MK9P8wA@mail.gmail.com>
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
Message-ID: <75f86be2-80fe-26c1-235f-1c6d3a618eeb@gmx.com>
Date:   Sun, 9 Feb 2020 07:56:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CA+M2ft9dcMKKQstZVcGQ=9MREbfhPF5GG=xoMoh5Aq8MK9P8wA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1w8t1aJwqrkYXlau2gpC4Hr9popOEVQ3b"
X-Provags-ID: V03:K1:lSKij903QuKo4bgizizYfq6Y2+QtReRP2tIdBjMSclQgZh1BIUD
 Zc0xo/SMPZsxE4J574q+5pS0tfM5QWunUDtQBcVdr6uXq9fL5V9Tw6y9gRk4Ral5rJYU3/P
 g0/DCH2wdOwh61H4+fBaBhRPkOFjd+X0SlNdW46wbWnwTe8rXUVAAM7lMTapXV6/5ZkbBPw
 9vTdN3CoGg8IXzoO2VyIA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mEtM5TZuogQ=:6yHUVKYcwUZ31N9rPa8SSs
 pPLHiMgZW10dLz7Z5o6AJqelkX2JXJd/RtAzM1gxZGPQ+EvfgViVGoY5oDfzUVj+akbqAaMfV
 dWYyURBXXHNTBk7KydBmN4nqqqamu4P8vbY+vVi9SbjRPitboxpHWvXKAbk6H3OMF8DNxvBw3
 iIkmkFwr3vUuXf0IsAZJHLBD9mkfh+5SrZTdwQFgVtiOXoZmN5hpjfMPSA/d3qLt9pYvgvCm4
 iQ8L66OPBtHo4hZ5oBQS1PrOjI6yda2rj2kkgeJrMYbJtZ03oYfMwbkRqgslWXM6GorCgALpn
 P6yuXmSldtEzQcMSimhmqB41atRQwcX5AHgO2KoHdceSpAtL+kKUq0h4lMCErfazfYx5Rc+Ql
 TIwFfYkgLsXr7IFqjniF5h1Bnl8dJtzO7ETwcOoevor8/PD0MWmVAN/vc4tetk5auHMbm+g6h
 ROk4UtdI+824l+pV9xVjUgmwsM2b9zGGayPAy0k0LRoLtN+6EsNrNKM9AyrJA3kpcLb9aLaP1
 bGfDFfqS6+IqDSfcqzn9bslA/beWRS+RGcxA1WDzrFoMVu3jiOnTiCiVXczJ+4kkHZs5tDBei
 HsKx5rcA5fKFb5Ap/aw9vEzWeCC/yz1dXjaYSg8gz+Tcsw3B4DPJuKqsL4Q4KlskWJYYG8jsv
 Td4VONPosfFH6aaI32QkzZ1o49peVxu6DVRzegmEcbUvkrvios6SZTbEC+GcUZmtvRqV9uHY9
 O/JLbDoRgA3wi0rZVjrTLa6il/VB7yAIuwC/rQCsr1smelGtkfGC847x34zcM4sT9S0B70aNz
 G9jLuo2ciY6XYR8xKQNVRgdaB/RMogRZV1amLHE9aL/gmnfiQEyAadcxBvDxizSu3l69gMfP8
 jsbb7gaaw0Z6GJapi4/znBF/umss8FMat+3e5FUHL1cSJ5NfDIiumBVFR5aVRu+KiZHAmS7xZ
 BjKC2DVo0+hf7UkHV5V0kcKc0lHu52IuARMbGMWaD15ZMqymcyOUvmjXutmaPbLKJ7R5amQFJ
 aw2ujwrldPb+uHbohsbLU6QQLEEC7f2oGd8vbkBaQXH8FnoMTO8UiWyHPtXSlgzz4goUCKmVc
 vz1KiGZLan4FllC5XXgWsmcBZ+Fi4vCduStDOui2hn33aFBLLHjgJvj/Rg38gh3MW905OR7/y
 o07rtDbteGK9WpS80leRbBB/qtX936Hmyva2bWZeL+fEYLKUSJ6n5lJ7svcuTRzBK140xc4Md
 v7cBQrOF5dVTeZpHNLG1RLcmtrf4BQ9f1AL4/YWhgMoqFZ4OswCzd2aK8vaS1rIbbR9QhJsrl
 3bYxNX6sfYGCOtsuUmzQemtDGblzXOkMy7PyUQNx94GSogh6NAOIipGTVqKM6+LCVquJ6x0K
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1w8t1aJwqrkYXlau2gpC4Hr9popOEVQ3b
Content-Type: multipart/mixed; boundary="FeEyA0neV28uWHq4wnXP3FfFbSmnXSdCj"

--FeEyA0neV28uWHq4wnXP3FfFbSmnXSdCj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/9 =E4=B8=8A=E5=8D=885:57, John Hendy wrote:
> On phone due to no OS, so apologies if this is in html mode. Indeed, I
> can't mount or boot any longer. I get the error:
>=20
> Error (device dm-0) in btrfs_replay_log:2228: errno=3D-22 unknown (Fail=
ed
> to recover log tree)
> BTRFS error (device dm-0): open_ctree failed

That can be easily fixed by `btrfs rescue zero-log`.

At least, btrfs check --repair didn't make things worse.

Thanks,
Qu
>=20
> John
>=20
> On Sat, Feb 8, 2020, 1:56 PM John Hendy <jw.hendy@gmail.com
> <mailto:jw.hendy@gmail.com>> wrote:
>=20
>     This is not going so hot. Updates:
>=20
>     booted from arch install, pre repair btrfs check:
>     - https://pastebin.com/6vNaSdf2
>=20
>     btrfs check --mode=3Dlowmem as requested by Chris:
>     - https://pastebin.com/uSwSTVVY
>=20
>     Then I did btrfs check --repair, which seg faulted at the end. I've=

>     typed them off of pictures I took:
>=20
>     Starting repair.
>     Opening filesystem to check...
>     Checking filesystem on /dev/mapper/ssd
>     [1/7] checking root items
>     Fixed 0 roots.
>     [2/7] checking extents
>     parent transid verify failed on 20271138064 wanted 68719924810 foun=
d
>     448074
>     parent transid verify failed on 20271138064 wanted 68719924810 foun=
d
>     448074
>     Ignoring transid failure
>     # ... repeated the previous two lines maybe hundreds of times
>     # ended with this:
>     ref mismatch on [12797435904 268505088] extent item 1, found 412
>     [1] 1814 segmentation fault (core dumped) btrfs check --repair
>     /dev/mapper/ssd
>=20
>     This was with btrfs-progs 5.4 (the install USB is maybe a month old=
).
>=20
>     Here is the output of btrfs check after the --repair attempt:
>     - https://pastebin.com/6MYRNdga
>=20
>     I rebooted to write this email given the seg fault, as I wanted to
>     make sure that I should still follow-up --repair with
>     --init-csum-tree. I had pictures of the --repair output, but Firefo=
x
>     just wouldn't load imgur.com <http://imgur.com> for me to post the
>     pics and was acting
>     really weird. In suspiciously checking dmesg, things have gone ro o=
n
>     me :(=C2=A0 Here is the dmesg from this session:
>     - https://pastebin.com/a2z7xczy
>=20
>     The gist is:
>=20
>     [=C2=A0 =C2=A040.997935] BTRFS critical (device dm-0): corrupt leaf=
: root=3D7
>     block=3D172703744 slot=3D0, csum end range (12980568064) goes beyon=
d the
>     start range (12980297728) of the next csum item
>     [=C2=A0 =C2=A040.997941] BTRFS info (device dm-0): leaf 172703744 g=
en 450983
>     total ptrs 34 free space 29 owner 7
>     [=C2=A0 =C2=A040.997942]=C2=A0 =C2=A0 =C2=A0item 0 key (18446744073=
709551606 128 12979060736)
>     itemoff 14811 itemsize 1472
>     [=C2=A0 =C2=A040.997944]=C2=A0 =C2=A0 =C2=A0item 1 key (18446744073=
709551606 128 12980297728)
>     itemoff 13895 itemsize 916
>     [=C2=A0 =C2=A040.997945]=C2=A0 =C2=A0 =C2=A0item 2 key (18446744073=
709551606 128 12981235712)
>     itemoff 13811 itemsize 84
>     # ... there's maybe 30 of these item n key lines in total
>     [=C2=A0 =C2=A040.997984] BTRFS error (device dm-0): block=3D1727037=
44 write time
>     tree block corruption detected
>     [=C2=A0 =C2=A041.016793] BTRFS: error (device dm-0) in
>     btrfs_commit_transaction:2332: errno=3D-5 IO failure (Error while
>     writing out transaction)
>     [=C2=A0 =C2=A041.016799] BTRFS info (device dm-0): forced readonly
>     [=C2=A0 =C2=A041.016802] BTRFS warning (device dm-0): Skipping comm=
it of aborted
>     transaction.
>     [=C2=A0 =C2=A041.016804] BTRFS: error (device dm-0) in cleanup_tran=
saction:1890:
>     errno=3D-5 IO failure
>     [=C2=A0 =C2=A041.016807] BTRFS info (device dm-0): delayed_refs has=
 NO entry
>     [=C2=A0 =C2=A041.023473] BTRFS warning (device dm-0): Skipping comm=
it of aborted
>     transaction.
>     [=C2=A0 =C2=A041.024297] BTRFS info (device dm-0): delayed_refs has=
 NO entry
>     [=C2=A0 =C2=A044.509418] systemd-journald[416]:
>     /var/log/journal/45c06c25e25f434195204efa939019ab/system.journal:
>     Journal file corrupted, rotating.
>     [=C2=A0 =C2=A044.509440] systemd-journald[416]: Failed to rotate
>     /var/log/journal/45c06c25e25f434195204efa939019ab/system.journal:
>     Read-only file system
>     [=C2=A0 =C2=A044.509450] systemd-journald[416]: Failed to rotate
>     /var/log/journal/45c06c25e25f434195204efa939019ab/user-1000.journal=
:
>     Read-only file system
>     [=C2=A0 =C2=A044.509540] systemd-journald[416]: Failed to write ent=
ry (23 items,
>     705 bytes) despite vacuuming, ignoring: Bad message
>     # ... then a bunch of these failed journal attempts (of note:
>     /var/log/journal was one of the bad inodes from btrfs check
>     previously)
>=20
>     Kindly let me know what you would recommend. I'm sadly back to an
>     unusable system vs. a complaining/worrisome one. This is similar to=

>     the behavior I had with the m2.sata nvme drive in my original
>     experience. After trying all of --repair, --init-csum-tree, and
>     --init-extent-tree, I couldn't boot anymore. After my dm-crypt
>     password at boot, I just saw a bunch of [FAILED] in the text splash=

>     output. Hoping to not repeat that with this drive.
>=20
>     Thanks,
>     John
>=20
>=20
>     On Sat, Feb 8, 2020 at 1:29 AM Qu Wenruo <quwenruo.btrfs@gmx.com
>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
>     >
>     >
>     >
>     > On 2020/2/8 =E4=B8=8B=E5=8D=8812:48, John Hendy wrote:
>     > > On Fri, Feb 7, 2020 at 5:42 PM Qu Wenruo <quwenruo.btrfs@gmx.co=
m
>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
>     > >>
>     > >>
>     > >>
>     > >> On 2020/2/8 =E4=B8=8A=E5=8D=881:52, John Hendy wrote:
>     > >>> Greetings,
>     > >>>
>     > >>> I'm resending, as this isn't showing in the archives. Perhaps=

>     it was
>     > >>> the attachments, which I've converted to pastebin links.
>     > >>>
>     > >>> As an update, I'm now running off of a different drive (ssd,
>     not the
>     > >>> nvme) and I got the error again! I'm now inclined to think
>     this might
>     > >>> not be hardware after all, but something related to my setup
>     or a bug
>     > >>> with chromium.
>     > >>>
>     > >>> After a reboot, chromium wouldn't start for me and demsg show=
ed
>     > >>> similar parent transid/csum errors to my original post below.=

>     I used
>     > >>> btrfs-inspect-internal to find the inode traced to
>     > >>> ~/.config/chromium/History. I deleted that, and got a new set=
 of
>     > >>> errors tracing to ~/.config/chromium/Cookies. After I deleted=

>     that and
>     > >>> tried starting chromium, I found that my btrfs /home/jwhendy
>     pool was
>     > >>> mounted ro just like the original problem below.
>     > >>>
>     > >>> dmesg after trying to start chromium:
>     > >>> - https://pastebin.com/CsCEQMJa
>     > >>
>     > >> So far, it's only transid bug in your csum tree.
>     > >>
>     > >> And two backref mismatch in data backref.
>     > >>
>     > >> In theory, you can fix your problem by `btrfs check --repair
>     > >> --init-csum-tree`.
>     > >>
>     > >
>     > > Now that I might be narrowing in on offending files, I'll wait
>     to see
>     > > what you think from my last response to Chris. I did try the ab=
ove
>     > > when I first ran into this:
>     > > -
>     https://lore.kernel.org/linux-btrfs/CA+M2ft8FpjdDQ7=3DXwMdYQazhyB95=
aha_D4WU_n15M59QrimrRg@mail.gmail.com/
>     >
>     > That RO is caused by the missing data backref.
>     >
>     > Which can be fixed by btrfs check --repair.
>     >
>     > Then you should be able to delete offending files them. (Or the w=
hole
>     > chromium cache, and switch to firefox if you wish :P )
>     >
>     > But also please keep in mind that, the transid mismatch looks
>     happen in
>     > your csum tree, which means your csum tree is no longer reliable,=
 and
>     > may cause -EIO reading unrelated files.
>     >
>     > Thus it's recommended to re-fill the csum tree by --init-csum-tre=
e.
>     >
>     > It can be done altogether by --repair --init-csum-tree, but to be=

>     safe,
>     > please run --repair only first, then make sure btrfs check report=
s no
>     > error after that. Then go --init-csum-tree.
>     >
>     > >
>     > >> But I'm more interesting in how this happened.
>     > >
>     > > Me too :)
>     > >
>     > >> Have your every experienced any power loss for your NVME drive=
?
>     > >> I'm not say btrfs is unsafe against power loss, all fs should
>     be safe
>     > >> against power loss, I'm just curious about if mount time log
>     replay is
>     > >> involved, or just regular internal log replay.
>     > >>
>     > >> From your smartctl, the drive experienced 61 unsafe shutdown
>     with 2144
>     > >> power cycles.
>     > >
>     > > Uhhh, hell yes, sadly. I'm a dummy running i3 and every time I =
get
>     > > caught off gaurd by low battery and instant power-off, I kick m=
yself
>     > > and mean to set up a script to force poweroff before that
>     happens. So,
>     > > indeed, I've lost power a ton. Surprised it was 61 times, but m=
aybe
>     > > not over ~2 years. And actually, I mis-stated the age. I haven'=
t
>     > > *booted* from this drive in almost 2yrs. It's a corporate lapto=
p,
>     > > issued every 3, so the ssd drive is more like 5 years old.
>     > >
>     > >> Not sure if it's related.
>     > >>
>     > >> Another interesting point is, did you remember what's the
>     oldest kernel
>     > >> running on this fs? v5.4 or v5.5?
>     > >
>     > > Hard to say, but arch linux maintains a package archive. The nv=
me
>     > > drive is from ~May 2018. The archives only go back to Jan 2019
>     and the
>     > > kernel/btrfs-progs was at 4.20 then:
>     > > - https://archive.archlinux.org/packages/l/linux/
>     >
>     > There is a known bug in v5.2.0~v5.2.14 (fixed in v5.2.15), which =
could
>     > cause metadata corruption. And the symptom is transid error, whic=
h
>     also
>     > matches your problem.
>     >
>     > Thanks,
>     > Qu
>     >
>     > >
>     > > Searching my Amazon orders, the SSD was in the 2015 time frame,=

>     so the
>     > > kernel version would have been even older.
>     > >
>     > > Thanks for your input,
>     > > John
>     > >
>     > >>
>     > >> Thanks,
>     > >> Qu
>     > >>>
>     > >>> Thanks for any pointers, as it would now seem that my purchas=
e
>     of a
>     > >>> new m2.sata may not buy my way out of this problem! While I d=
idn't
>     > >>> want to reinstall, at least new hardware is a simple fix. Now=
 I'm
>     > >>> worried there is a deeper issue bound to recur :(
>     > >>>
>     > >>> Best regards,
>     > >>> John
>     > >>>
>     > >>> On Wed, Feb 5, 2020 at 10:01 AM John Hendy <jw.hendy@gmail.co=
m
>     <mailto:jw.hendy@gmail.com>> wrote:
>     > >>>>
>     > >>>> Greetings,
>     > >>>>
>     > >>>> I've had this issue occur twice, once ~1mo ago and once a
>     couple of
>     > >>>> weeks ago. Chromium suddenly quit on me, and when trying to
>     start it
>     > >>>> again, it complained about a lock file in ~. I tried to dele=
te it
>     > >>>> manually and was informed I was on a read-only fs! I ended u=
p
>     biting
>     > >>>> the bullet and re-installing linux due to the number of dead=
 end
>     > >>>> threads and slow response rates on diagnosing these issues,
>     and the
>     > >>>> issue occurred again shortly after.
>     > >>>>
>     > >>>> $ uname -a
>     > >>>> Linux whammy 5.5.1-arch1-1 #1 SMP PREEMPT Sat, 01 Feb 2020
>     16:38:40
>     > >>>> +0000 x86_64 GNU/Linux
>     > >>>>
>     > >>>> $ btrfs --version
>     > >>>> btrfs-progs v5.4
>     > >>>>
>     > >>>> $ btrfs fi df /mnt/misc/ # full device; normally would be
>     mounting a subvol on /
>     > >>>> Data, single: total=3D114.01GiB, used=3D80.88GiB
>     > >>>> System, single: total=3D32.00MiB, used=3D16.00KiB
>     > >>>> Metadata, single: total=3D2.01GiB, used=3D769.61MiB
>     > >>>> GlobalReserve, single: total=3D140.73MiB, used=3D0.00B
>     > >>>>
>     > >>>> This is a single device, no RAID, not on a VM. HP Zbook 15.
>     > >>>> nvme0n1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0259:5=C2=A0 =C2=A0 0
>     232.9G=C2=A0 0 disk
>     > >>>> =E2=94=9C=E2=94=80nvme0n1p1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0259:6=C2=A0 =C2=A0 0=C2=A0
>     =C2=A0512M=C2=A0 0
>     > >>>> part=C2=A0 (/boot/efi)
>     > >>>> =E2=94=9C=E2=94=80nvme0n1p2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0259:7=C2=A0 =C2=A0 0=C2=A0 =C2=A0
>     =C2=A01G=C2=A0 0 part=C2=A0 (/boot)
>     > >>>> =E2=94=94=E2=94=80nvme0n1p3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0259:8=C2=A0 =C2=A0 0
>     231.4G=C2=A0 0 part (btrfs)
>     > >>>>
>     > >>>> I have the following subvols:
>     > >>>> arch: used for / when booting arch
>     > >>>> jwhendy: used for /home/jwhendy on arch
>     > >>>> vault: shared data between distros on /mnt/vault
>     > >>>> bionic: root when booting ubuntu bionic
>     > >>>>
>     > >>>> nvme0n1p3 is encrypted with dm-crypt/LUKS.
>     > >>>>
>     > >>>> dmesg, smartctl, btrfs check, and btrfs dev stats attached.
>     > >>>
>     > >>> Edit: links now:
>     > >>> - btrfs check: https://pastebin.com/nz6Bc145
>     > >>> - dmesg: https://pastebin.com/1GGpNiqk
>     > >>> - smartctl: https://pastebin.com/ADtYqfrd
>     > >>>
>     > >>> btrfs dev stats (not worth a link):
>     > >>>
>     > >>> [/dev/mapper/old].write_io_errs=C2=A0 =C2=A0 0
>     > >>> [/dev/mapper/old].read_io_errs=C2=A0 =C2=A0 =C2=A00
>     > >>> [/dev/mapper/old].flush_io_errs=C2=A0 =C2=A0 0
>     > >>> [/dev/mapper/old].corruption_errs=C2=A0 0
>     > >>> [/dev/mapper/old].generation_errs=C2=A0 0
>     > >>>
>     > >>>
>     > >>>> If these are of interested, here are reddit threads where I
>     posted the
>     > >>>> issue and was referred here.
>     > >>>> 1)
>     https://www.reddit.com/r/btrfs/comments/ejqhyq/any_hope_of_recoveri=
ng_from_various_errors_root/
>     > >>>> 2)=C2=A0
>     https://www.reddit.com/r/btrfs/comments/erh0f6/second_time_btrfs_ro=
ot_started_remounting_as_ro/
>     > >>>>
>     > >>>> It has been suggested this is a hardware issue. I've already=

>     ordered a
>     > >>>> replacement m2.sata, but for sanity it would be great to kno=
w
>     > >>>> definitively this was the case. If anything stands out above=
 that
>     > >>>> could indicate I'm not setup properly re. btrfs, that would
>     also be
>     > >>>> fantastic so I don't repeat the issue!
>     > >>>>
>     > >>>> The only thing I've stumbled on is that I have been mounting=
 with
>     > >>>> rd.luks.options=3Ddiscard and that manually running fstrim i=
s
>     preferred.
>     > >>>>
>     > >>>>
>     > >>>> Many thanks for any input/suggestions,
>     > >>>> John
>     > >>
>     >
>=20


--FeEyA0neV28uWHq4wnXP3FfFbSmnXSdCj--

--1w8t1aJwqrkYXlau2gpC4Hr9popOEVQ3b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4/SqUACgkQwj2R86El
/qjrpAf+Liai/5hRDR+B3PY0gVYJldXpGqAJjhHVs7uTHDY5k2n26ptmny2+ys9X
dxxr/F8e/aNvTNnXjr9GpYFN1hPlWs+cW+ehuxvqHf90oWraU1vLMDq61EfOaECm
D3Y5sHxdlUu0qV4YUphebLFbrJlR73ld59UQBYWF14s9fkD08lfw1vVVbevj45RI
AIgrInfqzSnJsoZlpBf6Fu8+3tErWV6QiD78BgufPEUzMPFjNfTJXNmDrSrQIHMp
6OOm6YqHKRsadlBxxhk+mmVJmSmNS1ZblAuqoF+jgAwNVP/Oh2lN7q9dVv1DQIK6
H5pNISdFiDFf8yF/56RKgOBcVbRShw==
=UDdt
-----END PGP SIGNATURE-----

--1w8t1aJwqrkYXlau2gpC4Hr9popOEVQ3b--
