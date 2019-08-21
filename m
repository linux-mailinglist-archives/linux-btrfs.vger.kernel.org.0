Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E45AB97366
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 09:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfHUHaD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 03:30:03 -0400
Received: from mout.gmx.net ([212.227.15.15]:55781 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbfHUHaD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 03:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566372601;
        bh=nD/z964BDuqZsXGtcxWbJTwST7K0RujUPmnkLr9JWlU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=gC1IDacQp2SmTeQSy4txBGtyC+qHOksR9QroH5V2phkCJqnC2JoufKxi4gI5z+msl
         3cHUnVulJdoJdlFtMpLGOYSanUrJVCTYj4vJGexnbL9UNyhEOXvIywJHFP7A/DNLW5
         J28AT3i1Vjnt+U+99hicFl0VudepWQSybmXAwS3w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LkgAG-1iYIq11Sjs-00aT0O; Wed, 21
 Aug 2019 09:30:01 +0200
Subject: Re: Chasing IO errors. BTRFS: error (device dm-2) in
 btrfs_run_delayed_refs:2907: errno=-5 IO failure
To:     Peter Chant <pete@petezilla.co.uk>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <fc2b166a-4466-4a5a-ee88-da5e57ee89b6@petezilla.co.uk>
 <CAJCQCtSWi+PUbOWXNwv0guCLRuSgZunWdvRBB4TKMG_X48jHFw@mail.gmail.com>
 <2433d4cb-e7f7-72c5-977b-02f51e9717b3@petezilla.co.uk>
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
Message-ID: <e439aafe-8836-b761-3b72-b9215b463c09@gmx.com>
Date:   Wed, 21 Aug 2019 15:29:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2433d4cb-e7f7-72c5-977b-02f51e9717b3@petezilla.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9LCUMDUGbHorfKm8jlTtdjq8ChHhO8TDG"
X-Provags-ID: V03:K1:Wcso6xVpPdVLKtC5ZZGYIcVbBBp96CyZhIIbkMtPy/7Y1oaTFRI
 cOVR2LLCbrLpxtpgoFBGXpMmUtDvkyEAgw+cOmwxBHJiTMY7kEvDYqmYnOaneAl/c8c6ZGD
 yYnTVUnhjDO9kN/NF6L/DFLKwEesZqBHzj0eLga1RmU5YGKAQf7DJDmN3XJETOzo44rw/xm
 1IZQQM4Bsl3hRtUqE9wQQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2myS+WUCkoM=:ApoUtJs83GBRS/u+RZSn8r
 2aP1qN29URv2LEiiyACG4QTIaAjv669Sc/aKe31Hts4QhSWhN1KS7Y+xqinOThwSN1wl4q4AW
 lW9UFYfZBJfPI3dnd/eTeGwuM7N6lWCTvXopsLXPrpAigmVjCuw6PVB9tg5tPXwpwVy5EtUy1
 ly6HRS8fWGECpC3x52WE04++vToZI2N/Y16CH8SNWTEHzwIjgcGGyukrZWdbWKNYuJ5c2SHLd
 AD4L1IfAoyv81tXEohDMNneRTnsBNsjhMBwkyTCH0X9WsHkjt4p7NTZoSSZp/N7KNUnzJc2Pp
 Oo43pwqvJSBBZ3qnji+gOUUWYXMZL2zG/M5stBwgi2sXhDXeBFJsV55dtxnuZKjkSC5VcDW7i
 h0dqFbxR/uePJp05N2FTNr8WPLLtSfdPDrEU86cGv98pWtqYGZhuailvT27vNzuG0WJJ7PLLU
 c+pzM/Hc8xE2CofwayW0H1ia/rQPgBq+KbyFuzmrIIvxf/syc0F2wxwkdRpWhTaV4UvK2u2N4
 FOoyiLUhHuCKF9dyFoBALXJwlIgBSbQoHqTw6b4rqqd0Qin9t3V0lJNSiUjWH7Q5eRV4htgL0
 hMbxpo7WA4lMNetOMFjuMbAQoMdLb6gqVL92E7k632rsNoFvfUTEjJVIGcMAMT9ZcH/efGide
 BvlZ9NBpMZPW/Vz2BvoytbgFvSNsrXW7YQLay0xxEWKtmfoXwJT6DFknkmFNx8KNcGdqGL0p3
 EJD3Bp3pnBmdv9youszkDLF10+qMlCxj70ipoU3dt8Rt35EmHlZGxG731If61bIAv861wKq5R
 cR38mS/r5222LUCRMKJ3FI/nlWX2Z2IdF/6phg08eip6fjDUGJwZB+iKf/VfMEGLqDnRpNz/y
 3aH2VagvfUfOqORpDDFgXNfGx/x76GFhcnAHHr3qGAcl9rnOX0YcAmM+dJbUvCfWtwZZ8ua13
 ye/OeOdlSPsMxTZsk2P3eCBR9eITdaL7KRyPEnYQtHeNTDM0Q2dheicYxeMKXXJMVwi5f0Xn+
 ptypdwx4Ww3fZvm6/JKEwtNv8sQeSj9eDsLf1bpCpfzVXriP0/GqM58mPlFgM1jHrQ3njLSl4
 PR6Oe67HKTZWbtRQXvS77t2o/wjXjOIlp2xVzNMagjPI5nurjBlFqecJw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9LCUMDUGbHorfKm8jlTtdjq8ChHhO8TDG
Content-Type: multipart/mixed; boundary="IvOEFl2tCbCiBXjsfbFw3Bm9zeUvZ67un";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Peter Chant <pete@petezilla.co.uk>, Chris Murphy
 <lists@colorremedies.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <e439aafe-8836-b761-3b72-b9215b463c09@gmx.com>
Subject: Re: Chasing IO errors. BTRFS: error (device dm-2) in
 btrfs_run_delayed_refs:2907: errno=-5 IO failure
References: <fc2b166a-4466-4a5a-ee88-da5e57ee89b6@petezilla.co.uk>
 <CAJCQCtSWi+PUbOWXNwv0guCLRuSgZunWdvRBB4TKMG_X48jHFw@mail.gmail.com>
 <2433d4cb-e7f7-72c5-977b-02f51e9717b3@petezilla.co.uk>
In-Reply-To: <2433d4cb-e7f7-72c5-977b-02f51e9717b3@petezilla.co.uk>

--IvOEFl2tCbCiBXjsfbFw3Bm9zeUvZ67un
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/21 =E4=B8=8B=E5=8D=884:05, Peter Chant wrote:
> hings
> On 8/20/19 10:59 PM, Chris Murphy wrote:
>> On Tue, Aug 20, 2019 at 3:10 PM Peter Chant <pete@petezilla.co.uk> wro=
te:
>>>
>>> Chasing IO errors.  BTRFS: error (device dm-2) in
>>> btrfs_run_delayed_refs:2907: errno=3D-5 IO failure
>>>
>>>
>>> I've just had an odd one.
>>>
>>> Over the last few days I've noticed a file system blocking, if that i=
s
>>> the correct term, and this morning go read only.  This resulted in a =
lot
>>> of checksum errors.
>>
>> That doesn't sound good. Checksum errors where? A complete start to
>> finish dmesg is most useful in this case.
>>
> Things to note:
> System has five drives:
> SSD for boot eith ext4 and btrfs partitions - no issues.
> NVME for lxc and a database, via lvm it carries a btrfs and xfs file
> systems, no issue.
> Various overlayfs for lxc containers.
>=20
> Three WD reds, 2x3TB, 1x4TB, RAID1 problematic.
>=20
> I'll run the checks shortly.

Well, check will also report that transid mismatch, and possibly a lot
of extent tree corruption.


[...]
> [   48.540518] BTRFS: device label Data devid 3 transid 2265510 /dev/dm=
-2

> [   62.219602] BTRFS info (device dm-2): allowing degraded mounts
> [   62.220612] BTRFS info (device dm-2): use zstd compression, level 3
> [   62.221339] BTRFS info (device dm-2): enabling auto defrag
> [   62.222031] BTRFS info (device dm-2): disk space caching is enabled
> [   62.223323] BTRFS warning (device dm-2): devid 5 uuid
> 89195df2-4e3d-4856-aab0-2aa9f59b3846 is missing
> [   62.232894] BTRFS warning (device dm-2): devid 5 uuid
> 89195df2-4e3d-4856-aab0-2aa9f59b3846 is missing
> [   95.956952] BTRFS info (device dm-2): checking UUID tree
> [   99.232089] BTRFS info (device dm-2): device fsid
> 159b8826-8380-45be-acb6-0cb992a8dfd7 devid 4 moved
> old:/dev/mapper/data_disk_1 new:/dev/dm-1
> [   99.232146] BTRFS info (device dm-2): device fsid
> 159b8826-8380-45be-acb6-0cb992a8dfd7 devid 3 moved
> old:/dev/mapper/data_disk_2 new:/dev/dm-2
> [   99.237670] BTRFS info (device dm-2): device fsid
> 159b8826-8380-45be-acb6-0cb992a8dfd7 devid 4 moved old:/dev/dm-1
> new:/dev/mapper/data_disk_1
> [   99.242692] BTRFS info (device dm-2): device fsid
> 159b8826-8380-45be-acb6-0cb992a8dfd7 devid 3 moved old:/dev/dm-2
> new:/dev/mapper/data_disk_2

> [   99.710315] EDAC amd64: Node 0: DRAM ECC disabled.
> [   99.710317] EDAC amd64: ECC disabled in the BIOS or no ECC
> capability, module will not load.
>                 Either enable ECC checking or force module loading by
> setting 'ecc_enable_override'.
>                 (Note that use of the override may cause unknown side
> effects.)
Not sure what the ECC part is doing, but it repeats quite some times.
I'd assume it's unrelated though.

[...]
> [  142.507291] BTRFS error (device dm-2): parent transid verify failed
> on 13395960053760 wanted 2265296 found 2263090
> [  142.544548] BTRFS error (device dm-2): parent transid verify failed
> on 13395960053760 wanted 2265296 found 2263090
> [  142.544561] BTRFS: error (device dm-2) in
> btrfs_run_delayed_refs:2907: errno=3D-5 IO failure

This means, btrfs is trying to read extent tree for CoW, but at that
time, extent tree is already corrupted, thus it returns -EIO.

And btrfs_run_delayed_refs just returns error.

Not sure if it's related to device replace, but anyway the corruption
just happened.
The device replace may be an interesting clue, as currently our
dm-log-writes are mostly focused on single device usage.

Then I'd recommend to do regular rescue procedure:
- Try that skip_bg patchset if possible
  This provides the best salvage method so far, full subvolume
  available, although needs out-of-tree patches.
  https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D130637

- btrfs-restore
  The regular unmounted recover, needs extra space. Latest btrfs-progs
  recommended.

Thanks,
Qu

> [  142.544564] BTRFS info (device dm-2): forced readonly
> [  144.108801] lxc-int: port 2(veth4OH9N0) entered disabled state
> [  144.144061] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> [  144.144110] lxc-int: port 2(veth4OH9N0) entered blocking state
> [  144.144113] lxc-int: port 2(veth4OH9N0) entered forwarding state
> [  145.973587] NFSD: attempt to initialize umh client tracking in a
> container ignored.
> [  145.973629] NFSD: attempt to initialize legacy client tracking in a
> container ignored.
> [  145.973629] NFSD: Unable to initialize client recovery tracking! (-2=
2)
> [  145.973631] NFSD: starting 90-second grace period (net f0000492)
> [  146.341292] lxc-int: port 4(vethNJGFQC) entered disabled state
> [  146.379910] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> [  146.379947] lxc-int: port 4(vethNJGFQC) entered blocking state
> [  146.379949] lxc-int: port 4(vethNJGFQC) entered forwarding state
> [  156.039660] lxc-int: port 3(veth70VEEM) entered disabled state
> [  156.069863] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> [  156.069900] lxc-int: port 3(veth70VEEM) entered blocking state
> [  156.069902] lxc-int: port 3(veth70VEEM) entered forwarding state
>=20
>=20


--IvOEFl2tCbCiBXjsfbFw3Bm9zeUvZ67un--

--9LCUMDUGbHorfKm8jlTtdjq8ChHhO8TDG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1c8vAACgkQwj2R86El
/qhtkggAgHLun5WgWWn5kIc/JWBISE5RbxWSq672zBHoZKkwWYdsZJHjZVKL6AIz
8dzry7f20q8VT4jOwkNFjknHIXFBLgKg/VMTP0jOz+gWi/8nxB4eCv4rE2q0qzHU
Zrf2t8GM9OR4u1SGn1/0oTqlC/XKuvLchQsmuWEHxkphAONfM2Ha+GxSMOjlpJa7
aIxJPOXHYUQ90mtwqIVTtuExSVFFPNsq95OpFUFhTGQahcXa00JNKGOZmshfyQ4Z
QZbSR0/wfnNtcZ30rDbljXP0rlPvf/H61xpWpKmNO+VTzkCOF1KX5uw6lLWya0Ig
7RZgGIHdWZq7hDALIeVyfBDlg/F5Eg==
=KL57
-----END PGP SIGNATURE-----

--9LCUMDUGbHorfKm8jlTtdjq8ChHhO8TDG--
