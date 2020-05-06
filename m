Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BF41C67BC
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 May 2020 07:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgEFF7D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 May 2020 01:59:03 -0400
Received: from mout.gmx.net ([212.227.15.18]:50983 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgEFF7D (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 May 2020 01:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588744738;
        bh=k/3kNsrvDRDzFmxxPE21fpPHFLmaKJPnI47mQNz3/XE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SnkdRG2cfYVUw3apl4WCDrfgy2ua5+RSi4QkJci7kPkBfOvEcXLmgtPHk3NDzj03P
         jxMBco8qBcYlJggnwm8Jxes2XAWGeVOpTuldvopZK6dH99dkww+8BMoQaUu3ADypZX
         JNsSZoc0mhi7ycAtI5K9lxpEqbUGpu7NQtOPGJOY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MacSe-1iyo4h2P98-00c5QP; Wed, 06
 May 2020 07:58:58 +0200
Subject: Re: Balance loops: what we know so far
To:     Andrea Gelmini <andrea.gelmini@gmail.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Linux BTRFS <linux-btrfs@vger.kernel.org>
References: <20200411211414.GP13306@hungrycats.org>
 <b3e80e75-5d27-ec58-19af-11ba5a20e08c@gmx.com>
 <20200428045500.GA10769@hungrycats.org>
 <ea42b9cb-3754-3f47-8d3c-208760e1c2ac@gmx.com>
 <CAK-xaQYvgXuUtX6DKpOZ2NrvkYBfW9qgGOvMUCovAjVBO2Ay7g@mail.gmail.com>
 <a7d16528-b5c2-0dcb-27fa-8eee455fee55@gmx.com>
 <CAK-xaQajcwVdwBZ6DhZ5EYax2FL28a6_+ZfsPjV7sqXeQ3RVKQ@mail.gmail.com>
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
Message-ID: <628479cc-9cc2-ac05-9a0f-20f3987284f3@gmx.com>
Date:   Wed, 6 May 2020 13:58:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAK-xaQajcwVdwBZ6DhZ5EYax2FL28a6_+ZfsPjV7sqXeQ3RVKQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="enFJD0tPJ4HoO6bz1rFooJHfVirdcFVej"
X-Provags-ID: V03:K1:9bxJckaQur3AYQYAbdf6JYNQK+pu/ybI0r5JSDGZP6C0J39uGZw
 hdGBC17NV2psVh6mJaLY5l5a9IDF645iUQSo/hWR9ofAkeVcDgpGOAy0ZCGnqS6sYjfB0NN
 cW/0iEd7z7zZacawvQHKqLnaK+so10fDi5ZB2Kw/vY5HfAls+7nPvQWWjffqELjRNm8xvS7
 1msBQV2IJm5Uhx7vtZnyQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HlIpmPBc66Y=:49HJbtHL3chJU0B14S/drW
 j0YGSClDDcxTLzG75VBbV+khSXmSxZ0aw7m+Gn0qNFzkN7KESK4wd40eu+vP0MAiZuok6Qa2Z
 JISXRvE+e7bUmBlcGtOa2r55PCVnNTfIQT/1VvBKkfMJ5buSlz2dQIeoOVAKOLH3AiV9Lf81k
 7qILyv/X+Nf5lT8wmqd6z+gU/NMQk7hZKGuQdoiDrAgNNnrg/5jwooeoI699zb5rLOJc9XZFq
 r7uTifxQNkYc2pJHuSB6WouLWc/N0uH89etS82RZEanNAw/JSKq7/MTMjr4unLCf5SEeEv8dQ
 gyb7+O6/lSM88KK0Nmz75FcuwZWBLDjM6JhGV9TxAKvRUxnx/oruutTuErcYdWGYDVL9yzeuL
 FvuAVdHWn6SlK/GeziXni9FzXjlGUWT0OOwESBqMdQrRPbdvyevGi5dmK3xPCKqywAOFOGaaM
 rCDpYfudTNp/GJQIE7qD/gG33Qeds+2coPOT5DLwiGoxrcjMMe8r78teObu130FXgjjXtoktv
 MMEU8H+pgY/RBjmBLLA54aZ/FDbE6j0f9NFqhhDJXArsvRJxtqCyQlOHfsVjxhtXLh/1zNWzs
 Db+EQw6aJJYPPAxAYdJchDOLQtICQuldF9AGz8HDR4u/RkBtWVEpoRgdaLGE4thXd+R8Byaoe
 hDmr4xQaYOEbHRvdJEXq14y5ai9hQZMqVIMMxZ+ByJGWh7+GAVO+YVmPz3H4w0l1k9sIa4/aG
 61UTA46iqJqzRNosPVm9q36JucRxUpNm4s4VbO6egjgJKqzxy5G8MS1lRQJbWcYtTZeoDdBS7
 kkjX1vSDOyxdkKaPWICN8KFue+51k9op4AHKJVWP0Ftz7YhmXffEkZP5zcSD9hESSecdcCF2x
 PYcZENyovhGVh832/1skXFKgF5CDeYGarsB4ZobfCMSTqTdXyopqiTQTMWt3bD9aHil1BkhPX
 W0zEG2bqg9eHo/OxUPgz9Igem8Fzfot/WC3rdObrrFudc8wN7Ycy+CXt5/I5UVLnZ/mKZ/fkG
 r/tcb45eNFXB2YGIeAjVFoN5qUsnudV2px77m51hVoNGDig9MPDLyT2Lyw1Y6ZqxQ7SBTBkd2
 sRWXJMcsiYuwy8tQY33zrYNSVbibH9F44AavZ60jXoaoztoE13JtpHrbzGiq/LE58eL9APsH1
 wGM/0e2yxqQO5ulvdPqiBu366fKZgxM27fGpkthnhOBWsYoVbaZKD3+4F5GNEquALWmAaiX31
 dBvf/slWIJXOq89Y+
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--enFJD0tPJ4HoO6bz1rFooJHfVirdcFVej
Content-Type: multipart/mixed; boundary="aBLPbvWTo4pbxNC9fEhg2C9th77PJVeAn"

--aBLPbvWTo4pbxNC9fEhg2C9th77PJVeAn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/5 =E4=B8=8B=E5=8D=885:10, Andrea Gelmini wrote:
> Il giorno mar 5 mag 2020 alle ore 01:48 Qu Wenruo
> <quwenruo.btrfs@gmx.com> ha scritto:
>=20
>> I mean, btrfs-image dump of the umounted fs.
>> (btrfs-image can compress the metadata, and won't include data, thus i=
t
>> can be way smaller than the image)
>=20
> No problem to give you complete image, data and metadata.

Thanks for your dump.

Do you still have the initial looping dmesg?
The point here is to locate the offending block group.

But anyway, your dump is already very interesting.

- The dump has no reloc tree
  Which means, the balance should already finished and all reloc tree
  already cleaned up.
  In theory, we should be able to continue to next chunk.
  But in reality we're not.

- There is a metadata chunk with data reloc tree leaf
  If we're looping on block group 12210667520, then it's possible that
  we're deadlooping on that block group, with "found 1 extents".
  From the bytenr it indeed looks like the case.
  But still, the initial dead loop dmesg would provide better proof to
  this.
  (Sorry, not sure if I could convert the vbox format to qcow2 nor how
   to resume it to KVM/qemu, thus I still have to bother you to dump the
   dmesg)

If that's the case, it would be very interesting in how we're handling
the data reloc tree.
It would be very worthy digging then.

Thanks,
Qu

>=20
>> At this stage, the image should be pretty small.
>> You can try restart the system and boot into liveCD and dump the image=
=2E
>=20
> Just to give you more possible info, here=C2=B9 you find all the files.=
 I
> guess you figure out how to
> use it without my explain, but anyway, just for the record:
>=20
> - video.mkv : show you how I re-up the save-state of vm at the moment
> I saw the loop;
> - Virtualbox-Files.tar.bz2 : contains all the Virtualbox VM files, so
> you can run it up on your own. You can also view the history command I
> did;
> - ubuntu-iso.tar : just to make it easier, it's simply the iso Ubuntu
> I'm using, with the right path, so if you want to replicate my side;
> - sda1.btrfs.dd.bz2 : is the dd of all the BTRFS partition, just after
> the reset of the VM, but without mount it. So, if I mount it, I see
> this:
>=20
> [268398.481278] BTRFS: device fsid
> cdbf6911-63f6-410e-9d22-a0376dfcc8ce devid 1 transid 32588 /dev/loop35
> scanned by systemd-udevd (392357)
> [268404.681217] BTRFS info (device loop35): disk space caching is enabl=
ed
> [268404.681221] BTRFS info (device loop35): has skinny extents
> [268404.694708] BTRFS info (device loop35): enabling ssd optimizations
> [268404.700398] BTRFS info (device loop35): checking UUID tree
> [268404.722430] BTRFS info (device loop35): balance: resume -musage=3D2=
 -susage=3D2
> [268404.722523] BTRFS info (device loop35): relocating block group
> 12546211840 flags metadata|dup
> [268404.752675] BTRFS info (device loop35): found 21 extents
> [268404.771509] BTRFS info (device loop35): relocating block group
> 12512657408 flags system|dup
> [268404.792802] BTRFS info (device loop35): found 1 extents
> [268404.819137] BTRFS info (device loop35): relocating block group
> 12210667520 flags metadata|dup
> [268404.858634] BTRFS info (device loop35): found 26 extents
> [268404.915321] BTRFS info (device loop35): balance: ended with status:=
 0
>=20
> Just in case:
> 1aced5ec23425845a79966d9a78033aa  sda1.btrfs.dd.bz2
> 93c9a2d50395383090dd031015ca8e89  ubuntu-iso.tar
> e9b3d49439cc41cd34fba078cf99c1b8  video.mkv
> 663b9a55bbfdb51fc8a77569445a9102  Virtualbox-Files.tar.bz2
>=20
> Hope it helps,
> Gelma
>=20
> =C2=B9 http://mail.gelma.net/btrfs-vm/
>=20


--aBLPbvWTo4pbxNC9fEhg2C9th77PJVeAn--

--enFJD0tPJ4HoO6bz1rFooJHfVirdcFVej
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6yUh4ACgkQwj2R86El
/qi0SQgAoF0fJ2BI0ViGCRf/4+L/4VcNww8tHpzdQ9m7FMHyQMxqJdDTF3ypbZvg
U9mNZ+BfpMBmutfeNUnqFRHRreb6Dcqs2cAZieLo6oQHVlcaK0Mi0PN2x6rL1oGN
zdFHmFqRsaESOGVm5BBFsjklD1wCaEu+GBb/zesOg7IctGUyXzhHgjGUiOG1bzPm
r/OVB9rhZQBSyiyNuBU5zOZkHqQsZGEVGVQC2FgfPSai96zaTjP/2pmjr5Vy62SZ
jKDENSyvh4XgpPNdyMSpWdLnFQBrBwc015KE8wjxTPz+sgxznh12ldymKWAFacwh
KPepscZlhIg+dFNxqWzpqjAyEWeZiw==
=YPOv
-----END PGP SIGNATURE-----

--enFJD0tPJ4HoO6bz1rFooJHfVirdcFVej--
