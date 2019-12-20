Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F77E127586
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2019 07:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfLTGFN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Dec 2019 01:05:13 -0500
Received: from mout.gmx.net ([212.227.17.22]:53183 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfLTGFM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Dec 2019 01:05:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576821908;
        bh=eAZcNUQZJ1YzbD9CrGl/RXMHniOsBPVvq6s3wDQ+j9U=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=BcYhJzpIZutUfKkoAfWtMw4JWd5wbtCAyV+SqW0tbcBl+Lj/hikiYtxN7qk4NJshJ
         RhvGklG/m7SkcEP/pPkF04vUH1Z839wCDeG6EFCn/9E6V59v6CfpGwWbZtRDhrU4bL
         9PJaXipfmPQGtWFccLY8XOLY+DGaEyOD9+YfGa4w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4z6q-1hhW7C1boy-010y0Q; Fri, 20
 Dec 2019 07:05:07 +0100
Subject: Re: How to heel this btrfs fi corruption?
To:     Ralf Zerres <Ralf.Zerres@networkx.de>,
        "'linux-btrfs@vger.kernel.org'" <linux-btrfs@vger.kernel.org>
References: <C439384E8BF26546BDDE396FFA246D1001921619EB@NWXSBS11.networkx.de>
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
Message-ID: <19940557-c91a-145d-4885-8e8c59e8b32f@gmx.com>
Date:   Fri, 20 Dec 2019 14:05:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <C439384E8BF26546BDDE396FFA246D1001921619EB@NWXSBS11.networkx.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aogVygDbZIkyRjgYpLIock0ySajrsAy5i"
X-Provags-ID: V03:K1:zxCu7/F9cYgR+m79tJmpw/Ho5GpC5GDfvBuJSbTxsow13ZvRgrQ
 iGTA/y+l3+Nus82tocMzZ5edr6rDcvNDMnK4FajbmdkeOpngYQpcKGaQuaWlBXfWdKPLGuL
 6v6kSJnpxXjO+NPtOF7s1GhtwjCsUEnmUNmGdxRrs3dKHAEYGQpTRTlE3lkC6oPvsiunDuk
 +IZmjmuuwsFnJlLOmjgEw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:M/e0IG5WUpM=:1cZkRofsz1rKk1kA2Tsxz1
 XxQu/a8gon825S5SmmMh2DrfbfzYLQJ5461y1Ceg+lR+PIVHXdndARl2biFG6HUhehPQFVb4J
 H9pMcxJ/hI+QCnaZ81I2Llfx7pyd6G3Gvz/8VgEkG424YKhwQ+1oeoJtsWsQSl0ZSsrUJ2QU4
 rEGkSLvv+mIpVXGEVk8wY+Cq5Sr0hTrBR/PE7KdpWghLsQqhFOH/Z4+eTH4GjOJUX7nssm6W6
 8isc5FLMhnEADm+4KFOZ621zhcLJEPcwBuzpYZYzozUstiL9bOhnNyBXT3gZH7jehdlSKW5tL
 /L7/hpsMnnH58HsTsCtMF9bw11BoRWoq6G2NU23HUKmDKF6E233Ljgs7eoz3dZFTLqmmIL+3C
 BO9DPnHfisMqkmNUkMWxGsZicQ/X9nBxGiGriPJBP9kJUU327K7wAKZo11zBuwmSLvPuzJPZn
 Ttf4+Gpv57KpwlNqN2tBd/6h/WHAjYsZVVMoTBvdt8oRGrmrVp6mlI0GXYmC8kUlzL7OE8Zrv
 pv18mdXuICFchSiFiaePLeCln3/czac9cvy86yU+aIHat2dD+uPUiixPbTi5sds5v1q0wPTJr
 3PIAa1Bq1zBM6Owm0uF9LrPIfPGdcMtij/aC9hiGmsFoYuUVwVz4pu7k5/lxV5U1gJ7I7BfSB
 t/gyp2VwynGNwjLC1dwLdSJd+pEvmmTcpoEGmRu3NDI296OW+NgrdEgowNP1zpvsbph9A14or
 +82aaqxCAj0G/6OFACenPbXPpejbep4MyxYbJB9VCMMNpPZseuuoYdEaQJD0XtqE5fNyJBMhr
 u+QvjiY1aWt5PA5zsKzZzNvJIZYXE8ekMyZbYz4NQylJGaVmUuR87HBS2Z+QsPWwQlp/LpngL
 TKh0RAMgAizsxvS07gZU2OWFzPeFKuL1gn4LL19eNuCN1+/mAFT5S30ApyD+fRZUDXySp4V4L
 /RTp+m6jtN2C+KgHKIsx6QbonDHB3/z5TQlMS2bcxfanicxjsZU6M5AYHQQnmrUXl9JL3BLgd
 GITvnMi7m6DJcGVJWour+8RXDsfEhlW22QnPQAEKXBc2CG+aDNeIpelPSpuocr6qyXRp8lkIG
 BLhVELt67SSXd6O2s+Etbbyglocym5VtOEzo56XaDrJ04F5jsLGcFGdEOpEAJzo/SdP9JmMid
 BPTUkkmNT3v8b+6bPImc+mOZMOxP18EdoYCs13Q3nu+KTwsK2/uMeHn5ksxbkaEwglRQNNLi4
 yAjp6l5ZoF0Pyg99zk+3gs6GClHsV+boxwOrYCfqy2THj6tyiTzKDPNllz+w=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aogVygDbZIkyRjgYpLIock0ySajrsAy5i
Content-Type: multipart/mixed; boundary="s45S4RKoyBX5aDraNwYye1kMNldsB0hU6"

--s45S4RKoyBX5aDraNwYye1kMNldsB0hU6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/20 =E4=B8=8A=E5=8D=884:00, Ralf Zerres wrote:
> Dear list,
>=20
> at customer site i can't mount a given btrfs device in rw mode.
> this is production data and i do have a backup and managed to mount the=
 filesystem in ro mode. I did copy out relevant stuff.
> Having said this, if btrfs --repair can't heal the situation, i could r=
eformat the filesystem and start all over.
> But i would prefere to save the time and take the heeling as a proof of=
 "production ready" status of btrfs-progs.
>=20
> Here are the details:
>=20
> kernel: 5.2.2 (Ubuntu 18.04.3)
> btrfs-progs: 5.2.1
> HBA: DELL Perc
> # storcli /c0/v0
> # 0/0   RAID5 Optl  RW     Yes     RWBD  -   OFF 7.274 TB SSD-Data
> #btrfs fi show /dev/sdX
> #Label: 'Data-Ssd'  uuid: <my uuid>
> #        Total devices 1 FS bytes used 7.12TiB
> #        devid    1 size 7.27TiB used 7.27TiB path /dev/<mydev>
>=20
> What happend:
> Customer filled up the filesystem (lots of snapshots in a couple of sub=
volumes).
> System was working with kernel 4.15 and btrfs-progs 4.15. I updated ker=
nel and btrfs-progs with the assumption
> more mainlined/actual tools could do a better job. Since they have seen=
 lots of fixups.
>=20
> 1) As a first step, i did run
>=20
> # btrfs check --mode lowmem --progress /dev/<mydev>

The initial report would help a lot to determine the root cause of
corruption in first place.

But if btrfs check (both modes) report error, you'd better not to think
--repair can do a better job.

Currently btrfs check is only good at finding problems, not really
fixing them.

As there are too many things to consider when doing repair, so at least
--repair is far from "production ready".
That's why in v5.4 progs, we add extra wait time for --repair.

>=20
> got extend mismatches and wrong extend CRC's
>=20
> 2) As a second step i did try to mount in recovery mode
>=20
> # mount -t btrfs -o defaults, recovery, skip_balance /dev/<mydev> /mnt
>=20
> I included skip_balance, since there might be an unfinished balance run=
=2E But this didn't work out.

The dmesg would help to find out what went wrong.

Just a tip for such report, the initial error message is always the most
important thing.

>=20
> 3) As a third step, got it mounted with ro mode
>=20
> # mount -t  btrfs -o ro /dev/<mydev> /mnt
>=20
> And filed data received via usage:
>=20
> # btrfs fi usage /mnt
> # Overall:
> #    Device size:                   7.27TiB
> #    Device allocated:              7.27TiB
> #    Device unallocated:            1.00MiB
> #    Device missing:                  0.00B
> #    Used:                          7.13TiB
> #    Free (estimated):            134.13GiB      (min: 134.13GiB)
> #    Data ratio:                       1.00
> #    Metadata ratio:                   2.00
> #    Global reserve:              512.00MiB      (used: 0.00B)
> #
> # Data,single: Size:7.23TiB, Used:7.10TiB
> #   /dev/<mydev>        7.23TiB
> #
> # Metadata,DUP: Size:21.50GiB, Used:14.31GiB
> #   /dev/<mydev>       43.00GiB
> #
> # System,DUP: Size:8.00MiB, Used:864.00KiB
> #   /dev/<mydev>       16.00MiB
>=20
> # Unallocated:
> #   /dev/<mydev>        1.00MiB
>=20
> Obviously, totally filled up.
> At that time i copied out all relevant data - you never know ... Finish=
ed!
>=20
> Then tried to unmout, but that got to nowhere. Leads to a reboot .
>=20
>=20
> 4) As a forth step, i tried to repair it
>=20
> # btrfs check --mode lowmem --progress --repair /dev/<mydev>
> # enabling repair mode
> # WARNING: low-memory mode repair support is only partial
> # Opening filesystem to check...
> # Checking filesystem on /dev/<mydev>
> # UUID: <my UUID>
> # [1/7] checking root items                      (0:00:33 elapsed, 2085=
3512 items checked)
> # Fixed 0 roots.
> # ERROR: extent[1988733435904, 134217728] referencer count mismatch (ro=
ot: 261, owner: 286, offset: 5905580032) wanted: # 28, have: 34
> # ERROR: fail to allocate new chunk No space left on device
> # Try to exclude all metadata blcoks and extents, it may be slow
> # Delete backref in extent [1988733435904 134217728]07:16 elapsed, 4043=
5 items checked)
> # ERROR: extent[1988733435904, 134217728] referencer count mismatch (ro=
ot: 261, owner: 286, offset: 5905580032) wanted: 27, have: 34
> # Delete backref in extent [1988733435904 134217728]
> # ERROR: extent[1988733435904, 134217728] referencer count mismatch (ro=
ot: 261, owner: 286, offset: 5905580032) wanted: 26, have: 34
> # ERROR: commit_root already set when starting transaction
> # ERROR: fail to start transaction: Invalid argument
> # ERROR: extent[2017321811968, 134217728] referencer count mismatch (ro=
ot: 261, owner: 287, offset: 2281701376) wanted: 3215, have: 3319
> # ERROR: commit_root already set when starting transaction
> # ERROR: fail to start transaction Invalid argument
>=20
> This ends with a core-dump.
>=20
> Last not least my question:
>=20
> I'm not experienced enough to solve this issue myself and need your hel=
p.=20
> Is it worth the time and effort to solve this issue?

I don't think it would be worthy, unless you're a really super kind guy
who want to make btrfs-progs better.
The time to repair the image could easily be more than just restoring
the backup, not to mention it's not ensured to save it.

> Developers might be interested while having a real live testbed?
> Do you need any further info that will help to solve the issue?

In this case, the history of the corruption would be more useful.

But since it's 4.15 kernel which may not have enough fixes backported
(since it's Ubuntu, not SUSE kernel), and the 5.2.2 is not safe at all
(you need 5.3.0 or 5.2.15) we can't even determine if it's 5.2.2 causing
the corruption in the first place.

So I'm not sure if we can get more juice from the report.

Thanks,
Qu

>=20
>=20
> Best regards
> Ralf
>=20
>=20
>=20
>=20
>=20


--s45S4RKoyBX5aDraNwYye1kMNldsB0hU6--

--aogVygDbZIkyRjgYpLIock0ySajrsAy5i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl38ZI8ACgkQwj2R86El
/qg8wwf/TA8KodeS7sS9IVSu6Sz4470/bTVbqZdwZRigwPd0LvsNcixLuN46Gvum
QElYZOvxAVjtlxdymQ66qd5QLOZhFaP4TNAE6Kh21iRPu8JhPvZk+8MhCQg+mohG
nBNjGGWy/MK16ND1IdFmChU4eroF6vLRKZu2oow2YPXL2GpXlL620ExacXiKXZc/
9Q/IHyas7Nyh84/KMBelG2JjXPrWs3S4BhLei43JN8Hjc1Lus659lmCt2GwnhiTE
yhasVSGqqj6EmCVaDmRI6z6NOa2GLQTFc/E4rDR59Z/WpOa0qh2RnpmvFukX9sD3
BwuJFKeXECN40rqzzQD5JK1YYspDkA==
=TWuz
-----END PGP SIGNATURE-----

--aogVygDbZIkyRjgYpLIock0ySajrsAy5i--
