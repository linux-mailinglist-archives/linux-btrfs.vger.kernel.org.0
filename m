Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DBC285547
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Oct 2020 02:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgJGANo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Oct 2020 20:13:44 -0400
Received: from mout.gmx.net ([212.227.17.21]:45159 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgJGANn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Oct 2020 20:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602029618;
        bh=s8UWs6xNdDsMdM75CVtip3/pLN5UoylbTUNqFcJQIdw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Ayd3RF052NCPaGAB682fBror6S7FJTXf+Sn9l8afNCya2WcpYYyW+i2q6w5TCuWDJ
         st2zwK/fYGRRUkFWQw22L4+k6SLPxLBGQcWFeFcvV5l/x36R18v9agH8JRRvV6yDzi
         HbKh9m8fuIuNu7X6xc8HIOhzfqtXmwNxSyhQO0RI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBDnC-1kER1Y0kQg-00CgmP; Wed, 07
 Oct 2020 02:13:38 +0200
Subject: Re: Counts for qgroup id are different
To:     JMinson <minsonj2016@gmail.com>,
        BTRFS Kernel <linux-btrfs@vger.kernel.org>
References: <8547cc42-6768-d6f0-6336-fac1fc42b85d@gmail.com>
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
Message-ID: <9ded0048-a480-8873-899d-576210490606@gmx.com>
Date:   Wed, 7 Oct 2020 08:13:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <8547cc42-6768-d6f0-6336-fac1fc42b85d@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pA5cJZd997VhRHONE9mEyZARzlSTdX28h"
X-Provags-ID: V03:K1:S/exaUsTfHf1559L8RG3IGus3phhNRVJ9bWN5GQO90jxp1uCXeg
 Y3J+aVs0tmp3x4TEewC9DBmGwAiAcVydob+hwzZdTmJdVNIc3XVjWODNHvcCrOyZRKUfLo7
 8GO+c7h7+m5mI/OmZMwDrpHBNYlkD2c41LV75I73R+PLoLE44BuIpnN58CTmJBKo98k1Q1f
 4wMqwHeOm5+RjIiSBYKcg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oX8uaCvf98c=:0x3HQ8Kk72bAScfN4cFi8M
 nBNKi3xyFQ9YYV/aNS7Z44ruBC0WEotvs7xBhT+O4XZVOYuloMg05rcObMr1XtHDVM3oYegcK
 oKTZMjHUrZrSl4xK2jBZmoutq9FHAn/BH/ZduohYdbf6r/WJ5bXHTA17TswEWqNTYcpmyzPAd
 3FQ+1YxjfHwNaz92mL2XUqK2337UZIlyO6Ba28wRTp+vuKRg7x8pXVBdmGZIjDzqJKMSqHD8d
 RIC+wnlo940oJ0RVVpeLWIrMWucUrnSH1a5s/7Q8hcwtDYrT2CETePJqFd/feVluGEaTWjx73
 +HcpyHbIpBb9j/kVL6gzHFJ5s8/4dIS+RsoZbKcx8axbuNH9BlFGJj0q6xSiNezdgLI9Yhgd+
 PyHS+8RPfdYiWJSDmpRZ3sze8IjQpAR5ksJXBQzMhscru5WptVl/jkethw/25LWRvyD8bFHUK
 0Ki6Le0dtAh5wMmrvr8H99WD6PR0YSD4VgH99H+ess0OuJ9vAGbQWvxoYrJC+Z8DYHv9KR2go
 Joqhen3iPwvpZ4FoJOv133B1FeE7A5E/yq6ityE1fp8jzIKBARYoD5KEu2UPnJml1uDnOmyr4
 7trhlE058XEgkQ9xRP0xJvM4dULkV5yuMCfV4s+LCdw4+V2gO2POOP06OrjG09gawZh/ovW/8
 +JAblvgffODjruA5jNI3w6I1VVtFdjzqdFYPUSy2L5EIUMFH8w8k/j6nfVsrN+X/qVs78ZDE+
 kveaHed4Mz9XTch1jE24nvcb4JzyxdxFBrBWwDcy3g7+2lkZcKihbbmoeakA4/oSNtcKhrzYR
 SVt+2bYusKWlnglfylEZFOOUy3aPZgRu6dI0JBQPIeI9h2lDB1azAqjuL8HNdYGQy2czt4EWK
 PeBmZJuA5wemkRWlzE6EbWrpm6NtnzmOusxzFRo2h7V1hHSwdvS1m8/qO7rfwmIwdILAhL0l1
 zwHpC+VpAc+dZXY6z1P/rzUsBBorlevYdcIEucJLWZD5jfDT6O9pZ8wtUVTW2H5k6irO4JoQd
 qf5gFEHCgPd1TREqd1/TJI0Ttf4VxVIv4rWl8l8RyKipx16RZ2MjSIYrwqzg4PxvihKZKO0tv
 S/SW+e9/lxlorLnhEiVvm77GjD+0TjKz+/1E0gWe5OG8JLhfOSiz1bwciLZmdzoIxo2FF6ods
 yDo6Tk59momdGY47XJwAy7fruQSbHVttTE91Nm7Nc/kiwuISLc8Ri92UlGLydfB8yXHybDtiP
 SUX+tcAPUmo1R79Wj88nm2oyTLW3mV7feuHqyIg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pA5cJZd997VhRHONE9mEyZARzlSTdX28h
Content-Type: multipart/mixed; boundary="KKlstWaoR8Y41lwWTtugp6qdN5cITcPhX"

--KKlstWaoR8Y41lwWTtugp6qdN5cITcPhX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/6 =E4=B8=8B=E5=8D=8810:27, JMinson wrote:
> Linux linux-desktop 5.4.0-48-generic #52-Ubuntu SMP Thu Sep 10 10:58:49=

> UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
>=20
> btrfs-progs v5.4.1
>=20
> Label: 'Daily'=C2=A0 uuid: 1426edb8-4fed-419a-b0f1-d131b97224fd
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes use=
d 1.13TiB
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 si=
ze 1.82TiB used 1.14TiB path /dev/sdb
>=20
>=20
> I use rsync to backup to an external btrfs formatted usb drive . The
> process is :
>=20
>=20
> mount btrfs volume "/Daily"
>=20
> take a snapshot of subvolume "BackupRoot" and give the snapshot a name
> like "snap@BackupRoot-2020-10-05-Oct-1601938835"
>=20
> run rsync with the destination being "/Daily/BackupRoot"
>=20
> unmount the btrfs volume "/Daily"
>=20
> I've been using this procedure for about 6 months and is far as I know
> all the data is good . However I discovered yesterday that when I run
> btrfsck I get 1 or more of these
>=20
> Counts for qgroup id: 0/1561 are different
> our:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
referenced 1051233288192 referenced compressed
> 1051233288192
> disk:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refer=
enced 1046914453504 referenced compressed
> 1046914453504
> diff:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refer=
enced 4318834688 referenced compressed 4318834688

This means btrfs qgroup on-disk is smaller than what btrfs check think is=
=2E

Is there any subvolume deletion involved in this case?
IIRC btrfs kernel and btrfs-check has different opinion on half-dropped
subvolumes. But when the subvolume is fully dropped, then everything
goes back into sync again.

> our:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
exclusive 1206681600 exclusive compressed 1206681600
> disk:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exclu=
sive 1206681600 exclusive compressed 1206681600

But exclusive is correct, thus it doesn't look like regular qgroup error.=


>=20
>=20
> Is this something to be concerned about ?

Normally you don't need to be concerned.

If you really don't like this, you can just trigger a qgroup rescan and
it will be handled well.

Another thing is, if you're running btrfs check with --force, on running
fs, it could give false alert.

Thanks,
Qu

>=20


--KKlstWaoR8Y41lwWTtugp6qdN5cITcPhX--

--pA5cJZd997VhRHONE9mEyZARzlSTdX28h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl99CC4ACgkQwj2R86El
/qj59gf3TjhqFaV6OTX9K8FVYQVZ0YDED+DFst+L4XmpEMdrrj3XUcmq1UUeafq1
6VqQuHRa3qcWZnvzW3eso9GDb/w76H9UVrFkU+oLhsSMtWnq7U/DdWWsek5XY7iB
M2IiOR7QTusv1/enPQkIgtMFzg1EaHAn2a1KmF9toyC4juEkYldJnW53Kfnc72ug
f7X/VSRHEbnBji+Ki+0O2IwMnRmY5Y/TQFqNnCMQHo4j0ycrKZocpFL8Xp/yrPnn
M2/dDb4KB8FQ37zjeq762xwLyDIduaPA0CButg6xpMQAsaUyUh2d4opgnOrXAcKL
mKJyw3ha208sNAyt/ZndvbY9l88D
=VoCA
-----END PGP SIGNATURE-----

--pA5cJZd997VhRHONE9mEyZARzlSTdX28h--
