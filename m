Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEDEBBF8F
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 03:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391798AbfIXBEO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 21:04:14 -0400
Received: from mout.gmx.net ([212.227.17.21]:60725 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503775AbfIXBEO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 21:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569287051;
        bh=FrMPU4jhGplBJ8Pixj3crRihBTQ0qK7TTs5Ndf36eJY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=lluPUMaZ7bcDyqoYrgoVKresm6Yu5NA2hvpI+jGPIUGQkS84oaMiGpw9ocAP0QHD6
         V6Wz/zALUu9WhxskrGa+NW2EmFwLCeEoQbZP81P1ShWgxRdJrKXDtbfektIRNn+Q+5
         Bh2R7/Eg9KgtPLFM+J0iWKacAtrssqdc/cmQbBOY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mi2Jt-1hheDT1QsT-00e0n9; Tue, 24
 Sep 2019 03:04:11 +0200
Subject: Re: Tree checker
To:     Charles Wright <charles.v.wright@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAFN5=-NhtmJ5NTePqdyUPaWm2r0oTbbCrmC0dOhC5fm2EtWwHA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <400b4097-8e0d-cb3f-cd29-33a572a7cbeb@gmx.com>
Date:   Tue, 24 Sep 2019 09:04:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFN5=-NhtmJ5NTePqdyUPaWm2r0oTbbCrmC0dOhC5fm2EtWwHA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rNMwegy0Hls9dqrtFyz0Tsb0vWYmWardN"
X-Provags-ID: V03:K1:jkgbjyyDKY/2Gk2jchCpY81hSks3VJZvn6ikkBuas1FCW0RS17x
 w3S5zjZw2sYrwKpIaNsmGK1EeXgxXz5KoDn47H89lHUJR98O8VqactQ++Yqwf15H4ChnzQs
 P32dNB1zMa2eAx6GR1yZI8eOxTxeKwAmM+aDdtxQ69ISugPxwkJPMRYmtsV1O+4jTLrUIF7
 ofhjUDQKJIltX/y+gDM0g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+Q/c1Na+0Gs=:TWWUNvFp7msEdE/rktFtN3
 xxOyodMCbwqB6HhGpHe+RJCr2xIHAdXdWbBAT/Bk/6P9/m883EimWH2kObj3P8IZea4IIPUmQ
 CKIKOq14euQ+CMsniqqwkWH2Cs+QIFr/BcqT7dUG30rMuOZH5nIB2JtKNh4XMRK1W0WGoJw3e
 TRla/dj9ODpC81bhjf9IGv0TmoFn8Qi7+7aT8H+oGMrmSuK6TfrRw5P0XMoFVheLvVjyBQl8y
 qw55ji0FL0l1FtREzJMPqJORhp39EXa5O0MTlIw+Me4eua8dW4+lLedvKuTmuXoi/r9GZ4kx3
 UmFoK7A6uDZnuMYy/JVf7ukl1Xw3EcOeTfjHx5QNQtMisdAngUOOovRHXhT3bboCGY/ymZf9F
 hJKM1bIUGtUJiDV3b33moJnxq1lpuHV1bw1OYMGUfC90PQvDP0HDDPtrCOy0b8xn37HD9NraC
 p09353I5DqE/PBnhsfP9nB+K/REeyXpK4MX0wmA+g3gRG47balBn08nM8I2z7N0Wdb+/TU8xI
 OTvs4UxwehHWupBa9GuvEmjQWwlRorGvpXQvg0twAH6KSLBJ7QJHC43WQJIbEuCF+S1QdYMGA
 E37E1uZ1jCfSqCG23V36anDxC1gu1x2q7JYr5V+f09Lua7/CB6YgDT75o85GEA6129PEFPmAr
 kdHZElDBzRxf5sGkWNdbHS5V3JJw2CrLNYkTtSX+q5QxlxydQTvVPaEWPoeJ8+N3D1DYuzXKd
 icOhVFVqvEm7xFimDLni1ZelIeQVVuGgjIAy5gpFhdmPDU773dEDrowijjD0LXQB1AuDs/PlU
 fkMFFINivIyvV5Nr0Xqpyw93t9RQfSEjro6+9FbbZfprp+SF1GhpIdjjRJ7fLNbIqLjUC4xUw
 jOmJXweJkKu6OuerTSEXngcm+aqNpJky0B/KX8XJKK1KjWt7OlQMm8hWm3vjOvPpBZcbjE1zL
 7xEAtE0Uzz+zFE4Mt4c+RNEmnZoNFRhsSdHb4fm56RT8YBV48IUrgEi2voJ2G05atxaSDkZX0
 Sg/fC6bDtT7cdwhdxtiz8Zm3I39LhAMwDYd7eDsYMuZST1q6iucDtUF7Fjm4x+7kXkc2fH7vm
 /w3WmRbNEg2did/3oHjQ5RrgLxZBXlMmG2DmnwQ8OGX0P4khHNt7AYdMqCnrs/cS5+jb7bIzP
 XE7FSZGTmdttoVS0quz7Saf++zlJgHffru1RCiPjRgtF6TBGRoT6NNmeQyITuseOFOMqYS9Q6
 Uhkr9Cdt5YZN0MP2jcNStQlvPgd0somTwPD5823EjaWi5Dj2oXM6HfMb17wk=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rNMwegy0Hls9dqrtFyz0Tsb0vWYmWardN
Content-Type: multipart/mixed; boundary="ju879okojlZviWxT4HUtLyoGTp8tYGZH7"

--ju879okojlZviWxT4HUtLyoGTp8tYGZH7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/24 =E4=B8=8A=E5=8D=888:34, Charles Wright wrote:
> OK so I got an update to a 5.3.0-12 Ubuntu Kernel 3-4 day's ago and
> started having problems on my user data drive a 1TB drive that that I
> keep the usual ~/ directories (Documents , Downloads , Music, ect,ect)
> on and link back to ~/ in 4 installs on this box , so whatever install
> I'm booted to I have my data .
>=20
> story hear https://www.kubuntuforums.net/showthread.php/75909-strange-p=
roblem-on-testing-with-hwe-edge-5-3-0-12-kernel
>=20
> the error I get in dmesg ,,,
> [  476.437134] BTRFS error (device sdb1): block=3D150186876928 read tim=
e
> tree block corruption detected
> [  476.437323] BTRFS critical (device sdb1): corrupt leaf: root=3D5
> block=3D150186876928 slot=3D3 ino=3D49938688, invalid inode generation:=
 has
> 18446744073709551492 expect [0, 80501]

Just as it shows.
The expected range is [0, 80501], but you have a super large generation
number.

Doesn't that 18446744073709551492 looks strange? It's
0xffffffffffffff84, by somehow we overflow the generation number.

And tree-checker is doing its job, although not every user likes what
tree-checker is doing though. :(

>=20
> and
>=20
> [  762.622905] BTRFS error (device sdb1): block=3D150186876928 read tim=
e
> tree block corruption detected
> [  805.852391] BTRFS critical (device sdb1): corrupt leaf: root=3D5
> block=3D149315502080 slot=3D0 ino=3D49938701, invalid inode generation:=
 has
> 18446744073709551492 expect [0, 80501]
>=20
> this seems to be 2 directorys  the first "dwhelper" I can still see
> the directory but it lists as empty (it has 44 youtube videos in it )

Because the directory pointer (DIR_ITEM/DIR_INDEX) is in another leaf
with everything OK.
While to access the content of that dir, you need to read out the leaf
with the incorrect generation, thus triggering tree-checker, discarding
the rest content.

> the second you cant see the directory "steam" in Dolphin but "ls -la"
> shows this "d????????? ? ? ? ? ? steam"

Yep, similar reason.

>=20
> if I boot the 5.0.0-30 kernel and enter the "dwhelper" directory and
> do "dmesg" their is this
>=20
> [  199.522886] ata2.00: exception Emask 0x10 SAct 0x8000 SErr 0x2d0100
> action 0x6 frozen
> [  199.522891] ata2.00: irq_stat 0x08000000, interface fatal error
> [  199.522893] ata2: SError: { UnrecovData PHYRdyChg CommWake 10B8B Bad=
CRC }
> [  199.522897] ata2.00: failed command: READ FPDMA QUEUED
> [  199.522902] ata2.00: cmd 60/08:78:a8:57:f3/00:00:12:00:00/40 tag 15
> ncq dma 4096 in
>                         res 50/00:08:a8:57:f3/00:00:12:00:00/40 Emask
> 0x10 (ATA bus error)
> [  199.522904] ata2.00: status: { DRDY }
> [  199.522908] ata2: hard resetting link
> [  199.837384] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [  199.840579] ata2.00: configured for UDMA/133
> [  199.840771] ata2: EH complete
>=20
> but all works  as in I can access the files as normal
>=20
> and in the 5.0.0-29 and 4.15.0-65 kernels no errors at all .
>=20
> basic system info
>=20
> Operating System: KDE neon Testing Edition
> KDE Plasma Version: 5.16.90
> KDE Frameworks Version: 5.63.0
> Qt Version: 5.12.3
> Kernel Version: 5.0.0-30-generic
> OS Type: 64-bit
> Processors: 8 =C3=97 Intel=C2=AE Core=E2=84=A2 i7-4910MQ CPU @ 2.90GHz
> Memory: 15.6 GiB of RAM
>=20
> the web page https://btrfs.wiki.kernel.org/index.php/Tree-checker
> asked to report an error like this hear , so her I am :)

The page works!

Now let's talk about how to fix it.

Btrfs-check hasn't implement the repair yet, but since you can mount
with older kernel, you can fix it by your self.

Just create a new directory using v5.0 kernel, move all the contents of
that offending directory to the new directory, then deleting the old
directory, then call it a day.

You may need to do it several times for each problem you hit.
If you're no happy with that, you could try to do a full rsync of any
old directories which is not created by any recent kernels.


For reference, would you please provide the following info before doing
the recovery?
So that I could confirm it's caused by older kernels.

# btrfs ins dump-tree -b 150186876928
# btrfs ins dump-tree -b 149315502080

Please be careful about the above dump, as it contains filenames.
Feel free to anonymize them.

Thanks,
Qu

>=20
> any more info or tests you want me to run or provide I will ,,,,,, O
> hears some drive info
>=20
> vinny@vinny-Bonobo-Extreme:~$ sudo parted -l
> [sudo] password for vinny:
> Model: ATA HGST HTS725050A7 (scsi)
> Disk /dev/sda: 500GB
> Sector size (logical/physical): 512B/4096B
> Partition Table: msdos
> Disk Flags:
>=20
> Number  Start   End    Size    Type      File system     Flags
>  1      8225kB  323GB  323GB   primary   btrfs           boot
>  3      323GB   379GB  56.3GB  primary   ext4
>  4      379GB   496GB  117GB   extended
>  6      379GB   436GB  57.0GB  logical   ext4
>  5      436GB   496GB  59.8GB  logical   ext4
>  2      496GB   500GB  4295MB  primary   linux-swap(v1)
>=20
>=20
> Model: ATA HGST HTS721010A9 (scsi)
> Disk /dev/sdb: 1000GB
> Sector size (logical/physical): 512B/4096B
> Partition Table: gpt
> Disk Flags:
>=20
> Number  Start   End     Size    File system  Name     Flags
>  1      1049kB  1000GB  1000GB  btrfs        primary
>=20
>=20
> Model: ATA Samsung SSD 860 (scsi)
> Disk /dev/sdc: 250GB
> Sector size (logical/physical): 512B/512B
> Partition Table: loop
> Disk Flags:
>=20
> Number  Start  End    Size   File system  Flags
>  1      0.00B  250GB  250GB  btrfs
>=20
> hope we can help each other .
>=20
> Charles V. Wright
>=20


--ju879okojlZviWxT4HUtLyoGTp8tYGZH7--

--rNMwegy0Hls9dqrtFyz0Tsb0vWYmWardN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2Ja4YACgkQwj2R86El
/qhLdggAooucGqtruxHoq8cftU6Gn/KvFhmKTjICtevSI1+tG4B4zzfwnKL+hUft
B658Grq3sijBtGU09kvoN7WGB3+FBL1aowmKESaX5qZJGBGpyl22XZlxMfjfiKzR
l3pkCbiARpstE+A1+Kw5w0tXqf5T8L7TQk7x1sbla/68hCzSp4wytRS1ceXX93BJ
jdhxURKVs5Y95pxVlzPJ2dcKo6wvASQirt+CFiBGD6ffFswxc4Shnk8IX7lwYjlW
4FIi7Hfx54BgjnwubZUin8ARr8Rr9y5EYB6VTpFpRBfrLYfVzqK/eU+nIn4bRC5I
f56zZ24Il1PJml01zlTl68D8kKeHEw==
=HVOJ
-----END PGP SIGNATURE-----

--rNMwegy0Hls9dqrtFyz0Tsb0vWYmWardN--
