Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE29896F8
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2019 07:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfHLFnr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Aug 2019 01:43:47 -0400
Received: from mout.gmx.net ([212.227.15.19]:33187 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfHLFnr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Aug 2019 01:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565588625;
        bh=qSRBd/ZjVAh6pvTEiD8K7O4/KBQ2Yjnl+E5vOcAWJ4s=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=hQriSG8XDaoV+Nyzg1S300BodPyHsmchKS5gLD36MmKKuq2sqMk4aFzJReJb/ixh/
         1DAtY5mI5OmAhCSRA2zppChGW4D9Iv7NRCg68AYHD9jbYL9PBIDD/WX+sHZjgNGr8X
         pC4Fbpe4tJl/2udzTemBce+cHU/uSYusNfB2d9to=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MI5UD-1i3JzU2h6d-00FCfI; Mon, 12
 Aug 2019 07:43:45 +0200
Subject: Re: many busy btrfs processes during heavy cpu and memory pressure
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtSZ=0p-hFFgFW6hXmAHF=3yv+29DQO_=coc1Kmtzh-bvg@mail.gmail.com>
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
Message-ID: <e70b4ea0-3416-14ce-79de-4a4c0bf2c9cd@gmx.com>
Date:   Mon, 12 Aug 2019 13:43:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSZ=0p-hFFgFW6hXmAHF=3yv+29DQO_=coc1Kmtzh-bvg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iMf8PVCxS7GxJ0VG1rlQSRSXbjTDggAfW"
X-Provags-ID: V03:K1:DDGM3/BKWASdkskOUi/lhVODnMGwBJIAStoX7nz/Kr9ejvy75W4
 8UYJ/jmv5Q+LElcDaTstym4IFF9PEkiXS13OiMDf55ut2JUfQFUub6A240tIf+62QHGLmUi
 jPTXScS6TMRebK+eWXBeT195Ig7v1CE4ARndHI4tgW2RB04tUIyOOLa9zXkzzgxwH9tUcQO
 1E5JPII2XLUqKhcuy0WQQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:r4SrzXIGU/s=:jM3HOsEOedoKJ5jzOFZdcW
 ao+72HD+v6fUYQHdPxHJHa0qsrrlH4pdLQ1OsqbVDsynFB2suRzaqmh6wkKxPhEg06YDZwd6M
 vK1liVApF+1op/cHsJ/X7xjeKgdhQi2V3g1cHf5UlCFJXJa/nBH8vqR/oMKOlbHGVkA+xWoBf
 0NfOJRSS4h7Ae1SN7HHh4QsJS60/TO5LuBa2AwDwi9Oc1IaK432Rjyi3zISXmLRwSCuNquMNx
 gQqLm4oyaZ24IDNeh5Fl2yOi2/Y1x9mN2ZcQEgnm7IVbB3u46T/+27J95IOFUxdiQdUnZcwq4
 /gK3MWqlchkSVlBOf5XIjg6obBlmmDrh06X+89Q7we9vpQsNfUpY0VxA3vQHBkHdqs+50jZos
 0DFD/H/5CZuj7M1k2vDzVZqt9zfg2OlmpHLzEpJDbI0esz5+kqGWzdXEIriNB8AeLT+2Gb5qc
 pX01U2jDupcCmdanKy0rAGbU0JT/TRd91dfwFRan8387y8B+VoiTJEgtT5tN8oenJGoXzuMoT
 U1K4KCCE7a+QP0hNtA1qTCvLsT8svJyxlE8wKNIDHAFHazXtjm2kONQt5nZFysZ3kXS/fGZKm
 F5EQkEEodvXJGIiaBI3HFdgPNhvF8uK+G8iO9vEcASxF6pigIuB/Y1JQGQELexnCUzsCgTO2f
 BZJsioxoTQMXLmcrzHHWWrzPVle/81NdMeeei6eF6S7n7Oz12ZIriwyws/cuRDjJTHvYOduZU
 R0WCMTRbegu2n7fqXwmtNQUIu8oHmxDZbCLTu9VY9PSksd+MhOgNeziVMTnh+uKC+C+J6jDVP
 qnx4XoPCXtAFbWD2tckssyachyIAdHh62eNbAjsv08KWyO2Eost26zWS+bkWh8ELpin2H6PFA
 oRoh2qHsw29S6YajPYdteVKFcJEWVWE9mgpJ0GOUHnpRJ1J9N6r2B8YPlpMod7083q/AnzcYT
 b3nLlwk67e/Yrq7AXNIkwchfpqntD+AOsBPZfWf9fc3p5MMUCKsaTA1nBttSDGLsCTseSm/Rk
 g7kbVXvGatYFi0NeyPAW+jVk2SHnFsLK0c9eJ7SQSsrt+g884by+vNxl9AHQaQPBLu3CX60Lj
 qjyJFVyDXRvrALTj1qzLZprZAmxQrwsMqarLY9wOIEyM8d+2vQUjiXA8Q==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iMf8PVCxS7GxJ0VG1rlQSRSXbjTDggAfW
Content-Type: multipart/mixed; boundary="B9OkindzTsNruhn5Mbfwuy1ELVP56fqmp";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Chris Murphy <lists@colorremedies.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <e70b4ea0-3416-14ce-79de-4a4c0bf2c9cd@gmx.com>
Subject: Re: many busy btrfs processes during heavy cpu and memory pressure
References: <CAJCQCtSZ=0p-hFFgFW6hXmAHF=3yv+29DQO_=coc1Kmtzh-bvg@mail.gmail.com>
In-Reply-To: <CAJCQCtSZ=0p-hFFgFW6hXmAHF=3yv+29DQO_=coc1Kmtzh-bvg@mail.gmail.com>

--B9OkindzTsNruhn5Mbfwuy1ELVP56fqmp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/12 =E4=B8=8A=E5=8D=8810:27, Chris Murphy wrote:
> I'm not sure this is a bug, but I'm also not sure if the behavior is ex=
pected.
>=20
> Test system as follows:
>=20
> Intel i7-2820QM, 4/8 cores
> 8 GiB RAM, 8 GiB swap on SSD plain partition
> Samsung SSD 840 EVO 250GB
> kernel 5.3.0-0.rc3.git0.1.fc31.x86_64+debug, but same behavior seen on =
5.2.6
>=20
> Test involves using a desktop, GNOME shell, while building webkitgtk.
> This uses all available RAM, and eventually all available swap.
>=20
> While the build fails on ext4 as well as on Btrfs, the difference on
> Btrfs is many btrfs processes taking up quite a lot of cpu resources.
> And iotop shows many processes with unexpectedly high read IO. I don't
> have enough data collected to be certain, but it does seem on Btrfs
> the oom killer is substantially delayed. Realistically, by the time
> the system is in this state, practically speaking it's lost.
>=20
> Screenshot shows iotop and top state information for this system, at
> the time sysrq+t is taken.
>=20
> Full 'journalctl -k' output is rather excessive, 13MB uncompressed,
> 714K zstd compressed
> https://drive.google.com/open?id=3D1bYYedsj1O4pii51MUy-7cWhnWGXb67XE
>=20
> from last sysrq+t
> https://drive.google.com/open?id=3D1vhnIki9lpiWK8T5Qsl81_RToQ8CFdnfU
>=20
> last screenshot, matching above sysrq+t
> https://drive.google.com/open?id=3D12jpQeskPsvHmfvDjWSPOwIWSz09JIUlk

This shows it's btrfs endio workqueue, which do the data verification
against csum tree.

So you see the point, ext* just doesn't support data csum.

Thanks,
Qu




--B9OkindzTsNruhn5Mbfwuy1ELVP56fqmp--

--iMf8PVCxS7GxJ0VG1rlQSRSXbjTDggAfW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1Q/IsACgkQwj2R86El
/qiHwgf/VCA3Ev29E3rLxSbFlYwoXKHUrXbh80zSop3l9HAOqxn+ihxAAtfZMfVb
PaMXC4dVJNM5pB1UznWWjE4uwIw4VZgDpH32awV7+APUaCwTOeFZhPgqUmuf8uCu
TO5Z/u0N8wOg8WhSNuF/t+OzNE1voCagVrMRfLBRjovFTTo5ZYszZCgbfADf+6iD
urgQb+OQaA52ODC/KSfHDzUW2NMnAbdWR3LQovTdrMO9TyfxOtp6aEtUQZ0O9QtY
/UxTzXovOOmcf+tdb7rrVAaWKQVS2vp6no5fxsgd+rFqgIIUn2cydhOfCvhYLGSc
C2GQgilR1xQfju2P+D95m9l2TSnbBA==
=776+
-----END PGP SIGNATURE-----

--iMf8PVCxS7GxJ0VG1rlQSRSXbjTDggAfW--
