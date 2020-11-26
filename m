Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB872C529F
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Nov 2020 12:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388651AbgKZLJy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Nov 2020 06:09:54 -0500
Received: from mout.gmx.net ([212.227.17.22]:33315 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbgKZLJx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Nov 2020 06:09:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606388978;
        bh=MmCeN5YV1OURsXrout9HEz1mzgP2eNTTXFcgShPSCn4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lP6zXQN3JkD9OLgi5s+04FO+LGVWGleNlepm3XiendVHn/NVJPOofqZgrIUEySejO
         1zjboHkWMjYh1x8bPZdAgQJU3hq4iYtN55dgjt6MbEngqyHYLbM6/5ffMHPOpoDxKX
         fNVbIEwEozhDfy1lmFtuMc4a8iVejH9M9Kr8x+7M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6ll8-1ka05P3Qic-008IUc; Thu, 26
 Nov 2020 12:09:38 +0100
Subject: Re: [btrfs] ccb0edc68b: xfstests.btrfs.179.fail
To:     kernel test robot <oliver.sang@intel.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com, linux-btrfs@vger.kernel.org
References: <20201126085618.GA14546@xsang-OptiPlex-9020>
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
Message-ID: <e8402d80-0255-ff89-f6a0-d0fc8b4ad827@gmx.com>
Date:   Thu, 26 Nov 2020 19:09:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201126085618.GA14546@xsang-OptiPlex-9020>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DUkPSf7xUDrrdwDYNRWRfHookxVrVlaFj"
X-Provags-ID: V03:K1:yK3mbehoha8QXyrPEqoZo8Z/MtYXd7ZvjuluYfz8a1tPIEmG2Se
 cMA5AoFe4cLeSAxKcPn5jkgr+WHWRHOnBtonk0mgSUZwivsbeDe74lYxwbFbekpxbhiKRiC
 vkQM+4V232de/t9jPN6p3NCtOuqTxCZlOnCQi1diZzjiKrsRPxTry9O153lTclV9SPsVjgm
 Jq50fB3IkliAaOMgPPBow==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:j4HZlottEtI=:LPTCs6WkonvuGLkKwj+9nE
 BT48wtP0BzmFITjOpx8wElBb3ufTMUFEKTv1bRyf9kRaWwdf8iwp3R8MK/9k30qrKzHNGVVIn
 ylifwPnB7pyXrIG+qo+Ny4ecemX04PPU55WrBBUUgY9bTcZjNwGwIv5KwP+LB7lODK37If3Yt
 gC6g6WiCFv0hiCuOSbN8k3Q3+6jPoBA/FNuOfo8jqYdThD+pl6q2tVJ3kwtuzzws0wjBFh0tq
 rytIcCDIqzAQvovfuaHmiNhszQ2vTy/zwK+kBPl+XglH6dmnYFIO8OK+c7prE0CNCYslMPMMH
 FEvAyifaxVdIcG/jBgahrr5R2HEJbLN0qganq8AMA5rLkLVWRygC3rJoTy4pbnKXil0p49ce6
 owO7mZADo/K4B09l0IeYbfIbEMxsEgSpguGgXoh1QkQMxScYnwoUXWu9rx2xu9UYeHJAhhpXl
 uscDBafwN+EmEyuXk+NR1UyqvgjxwvBvC0TR2QMDLxSkhA3ArMrmA0yG/SuuFAp+X41IN4CeI
 D5yuU/fsuKRHYzUDZZa3XCwsslaL9Mx40RY7271EEdL/azofQ3kHK3AFJaSMT9RQuFZl/0IuP
 kAjjGn5jXOKmoElL9qrrke11bHsS7JkSEqH916yvFIK8cbapjuJ8aiq4p645aOUACMPwqRlVc
 YZrZFOZdcCczfdmqQ/6HlQf0HvxwVZWVLb4OecfT35mlp2axIEBPNc/Tk9c2d96oZpkxSy5/l
 0orpdtmrDPnnaOT/Mwq1ZJPS4K79Z/vyb+dGuSCq5+H/MWJ4bhyFPX5bWgUCmYlq4Y4RyCZlL
 48LOcQ4vG3Vh9n56QTz0FUer0rPe3DXviHdTk9pjyDW7VvNFYoShin0r4pBEAjbGnZaeQ1R+C
 j++mEskxjQaNVg8Ld+Jw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DUkPSf7xUDrrdwDYNRWRfHookxVrVlaFj
Content-Type: multipart/mixed; boundary="zP1QjdMf2GUgiiZnAu4QLd2NJFqtDh0bW"

--zP1QjdMf2GUgiiZnAu4QLd2NJFqtDh0bW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/26 =E4=B8=8B=E5=8D=884:56, kernel test robot wrote:
>=20
> Greeting,
>=20
> FYI, we noticed the following commit (built with gcc-9):
>=20
> commit: ccb0edc68b690d0a62e9377ab509eb2f7cb610d3 ("btrfs: stop running =
all delayed refs during snapshot")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master=

>=20
>=20
> in testcase: xfstests
> version: xfstests-x86_64-d41dcbd-1_20201116
> with following parameters:
>=20
> 	disk: 6HDD
> 	fs: btrfs
> 	test: btrfs-group-03
> 	ucode: 0x28
>=20
> test-description: xfstests is a regression test suite for xfs and other=
 files ystems.
> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>=20
>=20
> on test machine: 8 threads Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz with=
 8G memory
>=20
> caused below changes (please refer to attached dmesg/kmsg for entire lo=
g/backtrace):
>=20
>=20
>=20
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>=20
> 2020-11-25 22:50:45 export TEST_DIR=3D/fs/sdb1
> 2020-11-25 22:50:45 export TEST_DEV=3D/dev/sdb1
> 2020-11-25 22:50:45 export FSTYP=3Dbtrfs
> 2020-11-25 22:50:45 export SCRATCH_MNT=3D/fs/scratch
> 2020-11-25 22:50:45 mkdir /fs/scratch -p
> 2020-11-25 22:50:45 export SCRATCH_DEV_POOL=3D"/dev/sdb2 /dev/sdb3 /dev=
/sdb4 /dev/sdb5 /dev/sdb6"
> 2020-11-25 22:50:45 sed "s:^:btrfs/:" //lkp/benchmarks/xfstests/tests/b=
trfs-group-03
> 2020-11-25 22:50:45 ./check btrfs/150 btrfs/151 btrfs/152 btrfs/153 btr=
fs/155 btrfs/156 btrfs/157 btrfs/158 btrfs/159 btrfs/160 btrfs/161 btrfs/=
162 btrfs/163 btrfs/164 btrfs/165 btrfs/166 btrfs/167 btrfs/168 btrfs/169=
 btrfs/170 btrfs/171 btrfs/172 btrfs/173 btrfs/174 btrfs/175 btrfs/176 bt=
rfs/177 btrfs/178 btrfs/179 btrfs/180 btrfs/181 btrfs/182 btrfs/183 btrfs=
/184 btrfs/185 btrfs/186 btrfs/187 btrfs/188 btrfs/189 btrfs/190 btrfs/19=
1 btrfs/192 btrfs/193 btrfs/194 btrfs/195 btrfs/196 btrfs/197 btrfs/198 b=
trfs/199
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 lkp-hsw-d01 5.10.0-rc5-00155-gccb0edc68b6=
9 #1 SMP Thu Nov 26 04:34:38 CST 2020
> MKFS_OPTIONS  -- /dev/sdb2
> MOUNT_OPTIONS -- /dev/sdb2 /fs/scratch
>=20
> btrfs/150	 1s
> btrfs/151	 2s
> btrfs/152	 6s
> btrfs/153	 3s
> btrfs/155	 1s
> btrfs/156	[not run] FITRIM not supported on /fs/scratch
> btrfs/157	 2s
> btrfs/158	 2s
> btrfs/159	 11s
> btrfs/160	 2s
> btrfs/161	 1s
> btrfs/162	 3s
> btrfs/163	- output mismatch (see /lkp/benchmarks/xfstests/results//btrf=
s/163.out.bad)
>     --- tests/btrfs/163.out	2020-11-16 06:09:57.000000000 +0000
>     +++ /lkp/benchmarks/xfstests/results//btrfs/163.out.bad	2020-11-25 =
22:51:22.553853766 +0000
>     @@ -1,8 +1,10 @@
>      QA output created by 163
>     +./common/btrfs: line 405: _require_loadable_fs_module: command not=
 found
>      -- golden --
>      0000000 abab abab abab abab abab abab abab abab
>      *
>      20000000
>     +./common/btrfs: line 412: _reload_fs_module: command not found
>     ...
>     (Run 'diff -u /lkp/benchmarks/xfstests/tests/btrfs/163.out /lkp/ben=
chmarks/xfstests/results//btrfs/163.out.bad'  to see the entire diff)
> btrfs/164	[not run] Require module btrfs to be unloadable
> btrfs/165	 1s
> btrfs/166	 1s
> btrfs/167	 2s
> btrfs/168	 1s
> btrfs/169	 2s
> btrfs/170	 0s
> btrfs/171	 1s
> btrfs/172	[not run] This test requires a valid $LOGWRITES_DEV
> btrfs/173	 1s
> btrfs/174	 1s
> btrfs/175	 15s
> btrfs/176	 6s
> btrfs/177	 8s
> btrfs/178	 1s
> btrfs/179	_check_btrfs_filesystem: filesystem on /dev/sdb2 is inconsist=
ent
> (see /lkp/benchmarks/xfstests/results//btrfs/179.full for details)

This is known false alert.

When we have half dropped snapshots/subvolumes, btrfs check will report
false qgroup mismatch.
But if the kernel has fully dropped the subvolume/snapshot, the
btrfs-progs will report the same accounting as kernel.

I can workaround it by adding a "btrfs subv sync" to solve it for now.

The root fix is to make btrfs-check to do the same qgroup accounting for
half dropped subvolumes.

Thanks,
Qu

>=20
> btrfs/180	 4s
> btrfs/181	 3s
> btrfs/182	 3s
> btrfs/183	 1s
> btrfs/184	 2s
> btrfs/185	 1s
> btrfs/186	 1s
> btrfs/187	 192s
> btrfs/188	 1s
> btrfs/189	 2s
> btrfs/190	[not run] This test requires a valid $LOGWRITES_DEV
> btrfs/191	 2s
> btrfs/192	[not run] This test requires a valid $LOGWRITES_DEV
> btrfs/193	 2s
> btrfs/194	 181s
> btrfs/195	 489s
> btrfs/196	[not run] This test requires a valid $LOGWRITES_DEV
> btrfs/197	 7s
> btrfs/198	 3s
> btrfs/199	 10s
> Ran: btrfs/150 btrfs/151 btrfs/152 btrfs/153 btrfs/155 btrfs/156 btrfs/=
157 btrfs/158 btrfs/159 btrfs/160 btrfs/161 btrfs/162 btrfs/163 btrfs/164=
 btrfs/165 btrfs/166 btrfs/167 btrfs/168 btrfs/169 btrfs/170 btrfs/171 bt=
rfs/172 btrfs/173 btrfs/174 btrfs/175 btrfs/176 btrfs/177 btrfs/178 btrfs=
/179 btrfs/180 btrfs/181 btrfs/182 btrfs/183 btrfs/184 btrfs/185 btrfs/18=
6 btrfs/187 btrfs/188 btrfs/189 btrfs/190 btrfs/191 btrfs/192 btrfs/193 b=
trfs/194 btrfs/195 btrfs/196 btrfs/197 btrfs/198 btrfs/199
> Not run: btrfs/156 btrfs/164 btrfs/172 btrfs/190 btrfs/192 btrfs/196
> Failures: btrfs/163 btrfs/179
> Failed 2 of 49 tests
>=20
>=20
>=20
>=20
> To reproduce:
>=20
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
>=20
>=20
>=20
> Thanks,
> Oliver Sang
>=20


--zP1QjdMf2GUgiiZnAu4QLd2NJFqtDh0bW--

--DUkPSf7xUDrrdwDYNRWRfHookxVrVlaFj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+/jOsACgkQwj2R86El
/qhM7Qf/ffgKD4Ft8zGhAjS8F09EawVuOmEKISRKzJtml4WJifVTdoPmoXIO7d+Y
KIBbPmVZ0hPnjV0Rd3wb1AxT2vVu6wdZJaUcnjjNjG2TUGMRoxCLFBeemtkweDT2
ilsxWBKL94Ljn14t6ozJr3tOY1MYMCCIXtKcc6W+h1BKWKalSf4islHBhVhJgmnO
CIxnEomIxh/+/ZKZLUo5XuafPgHqlFLVYn4XaTX6BhztVo3w+F1Z4eZp0u64+TAY
Kn/HNHN8t7Egd4Cqb8q7YsN7I8xB1hwnZC/JInk4oi7YqjFJv5Dy2fXKgsU3A0M/
XBNGmnOT0qpvtDhNUBIqEJIge1xW/w==
=qiUP
-----END PGP SIGNATURE-----

--DUkPSf7xUDrrdwDYNRWRfHookxVrVlaFj--
