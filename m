Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBA4BD62E
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 03:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633672AbfIYBsU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 21:48:20 -0400
Received: from mout.gmx.net ([212.227.15.18]:41973 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbfIYBsU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 21:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569376098;
        bh=KcGuKj+cIHlmSQWAja9z+COF8pSv9V5nt2X4ow1dN/w=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=TCMTYyBpfl19pVy4kXNxkDpaj28eVsyWcT0ZtRhldyuTnP8SbexNrnDZUU2K3x8ZF
         AFuMEHANhPU2GEokl0qRjaG6FURMKawjh2V/jbyLdj5dFtnkEF3isgM0oy25Yt7CA6
         DPBCddptXvFFC53X4gGP63AU+0ltHR6pj4S7Z9b0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MzQkE-1hzYMj0dHM-00vM4G; Wed, 25
 Sep 2019 03:48:18 +0200
Subject: Re: error: invalid convert data profile single
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtS6uHcH3CmM5WpTOGrZ8EFPkFr8Xo92X+Q+VxvBiaW4ug@mail.gmail.com>
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
Message-ID: <dd2ed71d-df70-28e2-206d-afd16dad64a6@gmx.com>
Date:   Wed, 25 Sep 2019 09:48:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtS6uHcH3CmM5WpTOGrZ8EFPkFr8Xo92X+Q+VxvBiaW4ug@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OHITWCYjaq234IOYQzHFoMtpgtLiRJZ6l"
X-Provags-ID: V03:K1:LgjdOafoKbvqB7tZT8FcVxucKJTDhVD+XIwvj21rZsaKUdubuAe
 L0Hm1RlX5N5NO8F/l+aoyJkq1BA8lK0E0Ste2UGseflS5eXhQdb6aRSGBzedwUT2uf0OmCJ
 JyR8OQDGWUYdjkFS3RrzDpVa6quYFFrThdZn0H/wv9XDKS1uhZPFsW9MdIRoPvMrenF/iO2
 T6kmN4kxxRBEkeSoBzkqg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xU8yPIUENJQ=:aXt2iEAhniqa6e9bFfQWhl
 9C9uj3mnqtt99a1vKBAPrEKCxlHfbaBFZbLyVL4NmTPKxZzYM61XA/fU2aLoowh/wMcFoASpl
 jd6Jly16a4mchJYegAq2S7WHOZm1uGcIZT3uGeFqOZQVQfS+2Y/SOOPnmzanQw5G7tV7FZSyG
 GoddXCNmA0GsX1N3YnHLfGkUmPvE2QGsF1X49c+hBui2AxkBtoBuNvLJUXKlF5cb/+4t20nCY
 fzUzQSVUldkMh2n/8EN7mKXekRiKqF9riNmkgTw7V24afF0z/+PR0y+pAkj1nQODtxh7sm+ZQ
 fOPxU+agsHIxHbq1W8Ewr7GTApui6hLCuPtf7i5TKaohxL9bsk67gVM26edUQyCOopUKRRSr3
 XiNMqsG2znqEerH8pfZ6L+GNZCFYDGSEx58HC0s5XqcGCgV3w5/joOjLp/TTm2/6buoXrvc0m
 g1kMMdnVReSDwf8A6pp/Ol35tkwGRAXf8jvlPZB88FLNRtJy1m1SiuAPZBqLHM0LqtjYaJy50
 GB3V1M5fwzNxHzxh1LhjWDsihY0HdPe+5o6GxAfy1XutmDZzyLJKX+Q5C9pULXbW3jN5aUp+T
 jTkQOUFjDeKdZNPh5CWz4RNbRCPg8L/ytiiJKjr0zR8gp60rX3o5bFDpyU74/1gDvyZLWWEnI
 IljP3IR6pHsxLyV5WsqPeq2NzhF34rgl5BoaKLw0b1WfmXeHWsFvGnykx6rQR1AV70fejYMgG
 b8Iee3PM38Jkfah8CQJqc58gifLdTERXoVUzFiJzb1na81nrlzV9iF1HXRrPUoNcYS9sB4b+w
 ad0j/aaTMHaNtazVzh8kWsvuWFZedXaJX+um3yuX3bAitJdN7axYJutz5YJ3vtbvR/Eh1cGnX
 GguGGuMEMAT1h6sLmW4aLMGDP5a9k8NV3XWwozfQ1LFcF79sxC5zEQh8IGWyD8FSgTrwfDjsl
 Qb6cvDEjWnX0NnCORrA9Bgp95fFrpGwDMHnZLtvS3blRmsofrtLwCmjdZPcfQ7kjiNnMD8Wi4
 BaTgRNXHQyxCGoNUH4OTk1O74sPvgKUuRZ8rgZ/yR29WKI/L+CbVXO2QU8mb8AlLF6SbZzgzO
 sxczWP3V4/lc06lSzngiLSugNusQjHvKj40fygeBmaNeP67cL4XZryX7PoMa2Us7eC09oFkYJ
 eyVUr83kh/b5qPZJbUgmGOQTRxFRVngEgwcJ0BO50PasInWsRCegZritZJiPFYp6hR0ev0+xt
 2mVJOKaVp01LYbTs0MZzkXW5afJHRrf9r8/yWH6gjputCwai/ynERC9UXVJg=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OHITWCYjaq234IOYQzHFoMtpgtLiRJZ6l
Content-Type: multipart/mixed; boundary="NMf5vLDkvueHfQuePLvIqqNQRjbNteYk0"

--NMf5vLDkvueHfQuePLvIqqNQRjbNteYk0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/25 =E4=B8=8A=E5=8D=889:26, Chris Murphy wrote:
> kernel 5.3.0-1.fc31.x86_64
> btrfs-progs-5.2.1-1.fc31.x86_64
>=20
>  sudo btrfs balance start -dconvert=3Dsingle,soft /
> ERROR: error during balancing '/': Invalid argument
> There may be more info in syslog - try dmesg | tail
> $ sudo btrfs balance start -dconvert=3Dsingle /
> ERROR: error during balancing '/': Invalid argument
> There may be more info in syslog - try dmesg | tail
>=20
>=20
> [372342.643440] BTRFS error (device sdb3): balance: invalid convert
> data profile single
> [372378.271689] BTRFS error (device sdb3): balance: invalid convert
> data profile single
>=20
> Huh? I had just today accidentally started converting data to DUP. I
> had intended to change metadata to DUP. I cancelled the data DUP
> convert pretty early on. But now I appear stuck.

Oh, this indeed looks like a bug, even with -f, it still fails on v5.3
kernel.

I'll take a look into this bug.

Thanks for the report,
Qu

>=20
> $ sudo btrfs fi us /
> Overall:
>     Device size:                  25.00GiB
>     Device allocated:             19.57GiB
>     Device unallocated:            5.43GiB
>     Device missing:                  0.00B
>     Used:                         11.15GiB
>     Free (estimated):              7.82GiB      (min: 5.52GiB)
>     Data ratio:                       1.08
>     Metadata ratio:                   2.00
>     Global reserve:               43.34MiB      (used: 0.00B)
>=20
> Data,single: Size:11.01GiB, Used:8.98GiB
>    /dev/sdb3      11.01GiB
>=20
> Data,DUP: Size:1.00GiB, Used:508.62MiB
>    /dev/sdb3       2.00GiB
>=20
> Metadata,DUP: Size:3.25GiB, Used:603.25MiB
>    /dev/sdb3       6.50GiB
>=20
> System,DUP: Size:32.00MiB, Used:32.00KiB
>    /dev/sdb3      64.00MiB
>=20
> Unallocated:
>    /dev/sdb3       5.43GiB
> $ sudo btrfs balance start -v -dconvert=3Dsingle,soft /
> Dumping filters: flags 0x1, state 0x0, force is off
>   DATA (flags 0x300): converting, target=3D281474976710656, soft is on
> ERROR: error during balancing '/': Invalid argument
> There may be more info in syslog - try dmesg | tail
> $ sudo btrfs balance start -v -f -dconvert=3Dsingle,soft /
> Dumping filters: flags 0x9, state 0x0, force is on
>   DATA (flags 0x300): converting, target=3D281474976710656, soft is on
> ERROR: error during balancing '/': Invalid argument
> There may be more info in syslog - try dmesg | tail
> $ sudo btrfs insp dump-s /dev/sdb3
> superblock: bytenr=3D65536, device=3D/dev/sdb3
> ---------------------------------------------------------
> csum_type        0 (crc32c)
> csum_size        4
> csum            0xabe229b9 [match]
> bytenr            65536
> flags            0x1
>             ( WRITTEN )
> magic            _BHRfS_M [match]
> fsid            3d93d834-ab33-40d1-8468-26fdc3eac4e0
> metadata_uuid        3d93d834-ab33-40d1-8468-26fdc3eac4e0
> label            fedoraFIT
> generation        96541
> root            18306990080
> sys_array_size        129
> chunk_root_generation    96449
> root_level        0
> chunk_root        18141446144
> chunk_root_level    0
> log_root        0
> log_root_transid    0
> log_root_level        0
> total_bytes        26843545600
> bytes_used        10804428800
> sectorsize        4096
> nodesize        32768
> leafsize (deprecated)    32768
> stripesize        4096
> root_dir        6
> num_devices        1
> compat_flags        0x0
> compat_ro_flags        0x3
>             ( FREE_SPACE_TREE |
>               FREE_SPACE_TREE_VALID )
> incompat_flags        0x171
>             ( MIXED_BACKREF |
>               COMPRESS_ZSTD |
>               BIG_METADATA |
>               EXTENDED_IREF |
>               SKINNY_METADATA )
> cache_generation    7
> uuid_tree_generation    86563
> dev_item.uuid        f695e038-833e-4600-9a0c-0a13fb4d9f0e
> dev_item.fsid        3d93d834-ab33-40d1-8468-26fdc3eac4e0 [match]
> dev_item.type        0
> dev_item.total_bytes    26843545600
> dev_item.bytes_used    21021851648
> dev_item.io_align    4096
> dev_item.io_width    4096
> dev_item.sector_size    4096
> dev_item.devid        1
> dev_item.dev_group    0
> dev_item.seek_speed    0
> dev_item.bandwidth    0
> dev_item.generation    0
> $
>=20
>=20
>=20


--NMf5vLDkvueHfQuePLvIqqNQRjbNteYk0--

--OHITWCYjaq234IOYQzHFoMtpgtLiRJZ6l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2Kx1wACgkQwj2R86El
/qjtHwf/bmdZ9FYV6LQ/L/wrj7vanLPUt7GXg1zKTNSkH/u6jnyPA30QA9fqrpZ8
OsZ31cxUoAOsMAnPoB1DrGyz9uW6jWwxqOvxh61zZb8D2gRWPqPyaXpQCZHdZcPN
CfNQaPmiXNVuiMPEuHY/NGvMV1VGmiK6Abto67Gt0XTUkumSan4ZSpVs/Q+Kirz4
W5CHFHGV3Qi0VQVvmrEhIZIYPACnzkhv8qUGJqljYhabx5gqHlXnoZrn4mmRyphW
gicAXHKfvubS35OSr9GfoFLyVdGT3kvykd4RIxEza2pzF4G3u8JQwSZbGPhOfA8t
XkYNrp+O7SCC+aBzOWjng1Toi/ZUnA==
=dOTD
-----END PGP SIGNATURE-----

--OHITWCYjaq234IOYQzHFoMtpgtLiRJZ6l--
