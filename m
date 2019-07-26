Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAE5774F0
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jul 2019 01:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfGZXYb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 19:24:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:43089 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfGZXYa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 19:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564183456;
        bh=SNvyN2iD5lBxulOqDqWeE6quPnedzolWrtHqY9gWVTI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=W2KYODEsDUjgpdG1Uv00DgbmxSIj0F5ytidTc/b//MrB7r//5bfBzscaMdyOcSRVb
         X8GZVQPqhDLX6Ukf5XCazVKHbDQ2WfUNuFF9zV/eyV7LkiqrAGh+QhQjXEBKuMbkWh
         cQ0eOioy73IqVN/pd2ShG++lyiJD3YNrDWhb+M8U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LkfdE-1iRJjX2zm0-00aYRw; Sat, 27
 Jul 2019 01:24:16 +0200
Subject: Re: qgroup: Don't trigger backref walk at delayed ref insert time
 (Re: Kernel traces)
To:     "Stephen R. van den Berg" <srb@cuci.nl>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20181210120514.GA14828@cuci.nl>
 <CAJCQCtQxaAKMP9qSF1UnOG7cy8ya=4MckGt9kL0O8oGxD4fitg@mail.gmail.com>
 <20181211115226.GA20157@cuci.nl>
 <CAJCQCtRva5ZrF2pq93pb0_be7P+CE+0no-nJeQTXtEaq-LpfVQ@mail.gmail.com>
 <20181212072614.GA9188@cuci.nl>
 <CAJCQCtSCcM0YTtp0f1i=FmrFigsfJEsr+Excwm=YHx4_wN49gg@mail.gmail.com>
 <20181228092036.GA30363@cuci.nl>
 <9b81647b-66c2-9870-161f-084b7d41af9c@gmx.com>
 <20190726163132.GA29895@cuci.nl>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
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
Message-ID: <9c462f2e-9157-6bce-84f7-e70afa8bbe31@gmx.com>
Date:   Sat, 27 Jul 2019 07:24:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726163132.GA29895@cuci.nl>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="I3BlDjvx0ccCTSoxyn52SfboKeObgkibv"
X-Provags-ID: V03:K1:i9NImdKOPh10o2JErB1w7n6rz+/N0wxYhUKgY/HQLKYObBZhQC2
 jMK0sjTLB2UJqLfPJCxVJ61yGGmoid3wSW5wkoArgrUpk77DYT4O/+SShfSawRl9Bx/km9s
 XR0ggeeA8zLt1tVDFaxDcwisjSEwC8LAK3qTULWpEc4KemXor9XAsj2RkdXmOq1u1nzDDvK
 cODx0gwZ0emOu2J+MqW9A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6q250u1KXPo=:7pyL8kLboE1vKDvSfLCw6I
 6ueiIT5jnU97gKFdAKaUGyfRkvnepy+WsIwdh39diUZ44tEjn1748uuC1ObgZ8VDDxu0CjZ/Y
 76Ezlak/a4iDIstcPLQ1ZSWN7fkJrlVWCjtMKl/EUADxsdPVjd2MxSty0HLsHj+UrnmM98nUY
 XvtoZTe5jwQHcMC49XwWlPHj5XWoN8eTLkNDedujtKuk9o5wsBzsWB4P0T7Myjd4lCRA3BG+9
 LBvpo9vIvGh6ihsam0rkb95V4Or6HybXLvFqKN3C9MeV1kzGni1HCqu4pWvPREqNlxxRMknp9
 z/JDK015RDvzR1VsHM0N3F1smszxJb+zgKQkHPlCsfoJVyBEqKrpFC8D3pfJnyY3U3INJk2rD
 yoaSYC9JJAesE8w43yNNc0H8gQzsbAhDVrJqNPV3yHDek1tlXSZY2Y8gOEO1sLGkcb7qN/sfD
 j/PXA2/cp66UFFaF5po9OfzExG7ckMtqfysWE3YYle3/A4h3HBLwnmY8/xfcVVGUkojaarOiM
 pgFC/R553XUfEbZslU7+NKrN9rGztxXb6h+/g6orGm5AO/s8lmJtTWW4JnHl5Tc5r7MiegcIj
 l/fKxoR8b7b4/8/P0G2+Idm2XYIfsOeW26wZLx11+sxQqRA/Vq1SJuAgucc9pot1YSmlufTxK
 kepzybDFYLJoizfE6iXTyyaa09Lp9SOMkZdg5VXngFmtlEGIfh4JJpph0f8mA+84iBtaxDfRh
 kqXg4dut7/67HzFNFY1tjXILRkVvaHhGZ2hLBE4tkfuOXNXQlx7iO9j2XG6VBm+gto3Y/xzMt
 I/BBy4nwlo8d8j9vftpqq4gwDq0P6gMQ+yR1DDvwKiYXBkEJzJy9KxI4cHmT11vgcFR8V32bm
 hPeEwkhIcIImgLrMKESp2t+hJhwJG+v2pgdAmgHI2z0njPAomcQk5RzhTIfZrpaIo3pOY3HFR
 72H/ufnUrIUQGLsc83Rw/jQRpH8Kqmqd6Hp5cHhj7yFGq3EDiXfKxKlU5ZyJx0CvphLWw+K5Q
 pcNO5GbO933pqe9ZpiECMBRzbaqN1C+Kl7nt6KqRE03kCtrLIUwq77d3q5zOdo+pwNKdbbaWi
 FBFk6lO8GGw28E=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I3BlDjvx0ccCTSoxyn52SfboKeObgkibv
Content-Type: multipart/mixed; boundary="WPFNyzHqdQYT31hntbIISagUCvhSyTLxv";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: "Stephen R. van den Berg" <srb@cuci.nl>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <9c462f2e-9157-6bce-84f7-e70afa8bbe31@gmx.com>
Subject: Re: qgroup: Don't trigger backref walk at delayed ref insert time
 (Re: Kernel traces)
References: <20181210120514.GA14828@cuci.nl>
 <CAJCQCtQxaAKMP9qSF1UnOG7cy8ya=4MckGt9kL0O8oGxD4fitg@mail.gmail.com>
 <20181211115226.GA20157@cuci.nl>
 <CAJCQCtRva5ZrF2pq93pb0_be7P+CE+0no-nJeQTXtEaq-LpfVQ@mail.gmail.com>
 <20181212072614.GA9188@cuci.nl>
 <CAJCQCtSCcM0YTtp0f1i=FmrFigsfJEsr+Excwm=YHx4_wN49gg@mail.gmail.com>
 <20181228092036.GA30363@cuci.nl>
 <9b81647b-66c2-9870-161f-084b7d41af9c@gmx.com>
 <20190726163132.GA29895@cuci.nl>
In-Reply-To: <20190726163132.GA29895@cuci.nl>

--WPFNyzHqdQYT31hntbIISagUCvhSyTLxv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/27 =E4=B8=8A=E5=8D=8812:31, Stephen R. van den Berg wrote:
> Qu Wenruo wrote:
>> It's caused by qgroup, and a dead lock on btrfs_drop_snapshot().
>=20
>> This is one of the easiest way to trigger an ABBA deadlock.
>=20
>> Please either disable qgroup or apply this patch to solve it:
>> https://patchwork.kernel.org/patch/10725371/
>=20
> Can anyone confirm that patch https://patchwork.kernel.org/patch/107253=
71/
> (qgroup: Don't trigger backref walk at delayed ref insert time)
> is present in mainline Linux kernel v5.2.2 ?

Upstream goes with a better solution:
Fixes: 38e3eebff643 ("btrfs: honor path->skip_locking in backref code")

Thanks,
Qu

>=20
> I seem to be getting a conflict on merging that patch with this kernel.=

>=20


--WPFNyzHqdQYT31hntbIISagUCvhSyTLxv--

--I3BlDjvx0ccCTSoxyn52SfboKeObgkibv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl07i5wACgkQwj2R86El
/qj6Ugf9HLOS1rJj8tMpacwMEyQpQw/RZT40uRa8l9VQENgTz7tXvJovLuvHCN4C
DhRU0hBGXYRPfA00ncwHuni8wl5LxSsjaIG44Xli7s557D4LTaP+qWEuuxpqPZKN
mmmx0oBpSM7JY8ijdDCBjxPmGf+kSfP18q9Wy8ZBdC4s/BRPDqgok7pmA19dYT/v
ChNH9s6Yd9GEKhv4z/O8tSRobx/Vcp+/YMzsMzRbQW9xPKK4ZvGMk+im2NuUv/bV
Ee7rMIGb9gDnriwbSIj/dlMKhiSzDrlUjb2xDRK5LUZiYB9J3xJFumrf/jpPMsCD
nUAOwbB/aS+5p5qbRNEytpkbt3tj+A==
=xmLh
-----END PGP SIGNATURE-----

--I3BlDjvx0ccCTSoxyn52SfboKeObgkibv--
