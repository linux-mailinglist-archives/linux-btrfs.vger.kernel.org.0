Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCEF8667C9
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2019 09:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfGLHe6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jul 2019 03:34:58 -0400
Received: from mout.gmx.net ([212.227.17.22]:47625 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfGLHe6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jul 2019 03:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562916890;
        bh=UWAU8vSjn/lofv3MEkpuROb7Kjd13mlL+249KlgIsd4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CWehJOhKn6sX43cdffQThAkb86u1AZ9CMZ3e5RCu2tJPQSqqZgvPx7KJl/oFGOW/E
         +D1RAhk4WhCSpIhufjGajPAn1V+D3/Q/g6I+Xn+tKWS/zmJVTls7iod2bD3Q6ge9rK
         HEdSE6KKIzQJe5af0Tj5x4qu7+YU3d7ypoItX1Ik=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdebB-1iLS0m3Rk9-00ZgTg; Fri, 12
 Jul 2019 09:34:50 +0200
Subject: Re: [PATCH] btrfs: free checksum hash on in close_ctree
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190711152304.11438-1-jthumshirn@suse.de>
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
Message-ID: <565cf2c9-6b97-349f-9540-655daa3c85f4@gmx.com>
Date:   Fri, 12 Jul 2019 15:34:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711152304.11438-1-jthumshirn@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Jk7dFQonq51qjopjeM5yFUNYQIF3jaYYX"
X-Provags-ID: V03:K1:yP3JQEds3+qASTUxeZIT7KYA6AM2nfpG4ud+Q6HXuX2bQfHqyRR
 EgLwDPqoAsaIJvuhbNDBSI7kulHAxUlVwSvPI9XYyP63gNJrLqjnmQ1furqFu4eM3vyBo5G
 Y5mg8KbrIvq1S3violIT+e9uHARuKU9i3v4kieHlPayGpWoXIDyrFnabCyXJsaoUun/bFQ6
 M97rc3vPZqkwZxelbMSVA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9RfBjsfG2Sw=:Y6jHlkwxqBmJFIQ1IBOA3d
 NiguNZ6bW6k13z+EJ+gZPYvRCNSE9Ui4dPDQOnJcqFhvCJXObpC6OSU+7RVopCa5vhkw9CLD0
 Gzyh5uIQlSslMC605/OIKS5j9v25tujp416ifCUinxIYfT0ec1a++D4JXFVkzULnDAQ8Aoshk
 wHjX2wWlV/jBS1wHyDR/CgQHp9kxRzf93nizkXHQqgamLQus+aSj21U0kKAha4h8xCZsow+jQ
 VDx7eU9KglUprnkvnI0tsljqS8m6+AkmfgHlSDC19W8OcXLi1vyosKS+A3p/dJqUIh60IaJIk
 InDYtB1ji3x7rL7R4k/knz8oV5kpaIoMoPoBtDgLaKvhBtnOmG34JfUIj0ND/HzoyIgQuQBrs
 EtS6+RQVe+5vq+laif2TW6fN1c1we6gIGyQDSBPBFW65bQ4A5uBl2iufHGxHf+2OgrLKtVEC2
 oM4hW/wnKYE+hPLHULaSkm85D768zHMJJv7ad9wpTwlzI1pyzG5h16qpAbsKJYAxBN5BbLxuS
 HK3izY5AL6WSHW0jEb9c6S05W7esXRQHM4AkaOtPHujSXJ5fYhgBSfEfbCp3/dlvKxu5oRKqQ
 LIqRJWtrdRHSvE8sb/vx/YkeryNSM242AHdQ0ch0IQ/mq9M/3qKUaqKAzpdSyQbkUuOX544d5
 OzY81YaiNauV2sGcQE0ko0SpDiiUOREIWqgDiWVz2s6YQUgDeSIZw/VI1cMxi35iByQdO+FPR
 K/HhkHZG9vHbV00f2QhZImpGbbQX6XuK5xGrsRv7BOu446OanmJWRyFrN/bmIxlWkpRgxFqej
 Reun6ZxKG5eKO3W7YPeZXDy2QhWYJBUybRzBz8SkMKUdsnuhVDjkB+iDKVLr1xTWtlwtQ67aC
 OTWhjlDAsCj11TBZao7ZE33/d1NYVo9RI+ARs2JiJ5DlDIBZc8BGFBmyOELFvVXiYqP/3DLnY
 5Jw5s/B/rL8uG9S2Ac6UhF4/2CXKz1yGPvb0GXIA8dfV+rTzegIWJU+fWPOKQMXytlKxYDi/H
 NTzpw5i/v2GmSU1xUsGlNTjVJ/AyvceAakLbjKVIc71LjUwgWRAdFaRi3L9lTDYKbKlszW4GC
 dEvGIpd3jSsI84=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Jk7dFQonq51qjopjeM5yFUNYQIF3jaYYX
Content-Type: multipart/mixed; boundary="AkJn2LcBBFrLcNCftmUxpc8zeJLgpLhgW";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>
Cc: Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Message-ID: <565cf2c9-6b97-349f-9540-655daa3c85f4@gmx.com>
Subject: Re: [PATCH] btrfs: free checksum hash on in close_ctree
References: <20190711152304.11438-1-jthumshirn@suse.de>
In-Reply-To: <20190711152304.11438-1-jthumshirn@suse.de>

--AkJn2LcBBFrLcNCftmUxpc8zeJLgpLhgW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/11 =E4=B8=8B=E5=8D=8811:23, Johannes Thumshirn wrote:
> fs_info::csum_hash gets initialized in btrfs_init_csum_hash() which is
> called by open_ctree().
>=20
> But it only gets freed if open_ctree() fails, not on normal operation.
>=20
> This leads to a memory leak like the following found by kmemleak:
> unreferenced object 0xffff888132cb8720 (size 96):
>   comm "mount", pid 450, jiffies 4294912436 (age 17.584s)
>   hex dump (first 32 bytes):
>     04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000000c9643d4>] crypto_create_tfm+0x2d/0xd0
>     [<00000000ae577f68>] crypto_alloc_tfm+0x4b/0xb0
>     [<000000002b5cdf30>] open_ctree+0xb84/0x2060 [btrfs]
>     [<0000000043204297>] btrfs_mount_root+0x552/0x640 [btrfs]
>     [<00000000c99b10ea>] legacy_get_tree+0x22/0x40
>     [<0000000071a6495f>] vfs_get_tree+0x1f/0xc0
>     [<00000000f180080e>] fc_mount+0x9/0x30
>     [<000000009e36cebd>] vfs_kern_mount.part.11+0x6a/0x80
>     [<0000000004594c05>] btrfs_mount+0x174/0x910 [btrfs]
>     [<00000000c99b10ea>] legacy_get_tree+0x22/0x40
>     [<0000000071a6495f>] vfs_get_tree+0x1f/0xc0
>     [<00000000b86e92c5>] do_mount+0x6b0/0x940
>     [<0000000097464494>] ksys_mount+0x7b/0xd0
>     [<0000000057213c80>] __x64_sys_mount+0x1c/0x20
>     [<00000000cb689b5e>] do_syscall_64+0x43/0x130
>     [<000000002194e289>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>=20
> Free fs_info::csum_hash in close_ctree() to avoid the memory leak.
>=20
> Fixes: 6d97c6e31b55 ("btrfs: add boilerplate code for directly includin=
g the crypto framework")

Not yet in upstream, thus I believe David could just fold this fix into
the original commit.

> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Although for the folding case, that reviewed-by won't make much sense.

Thanks,
Qu

> ---
>  fs/btrfs/disk-io.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 41a2bd2e0c56..5f7ee70b3d1a 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4106,6 +4106,7 @@ void close_ctree(struct btrfs_fs_info *fs_info)
>  	percpu_counter_destroy(&fs_info->dev_replace.bio_counter);
>  	cleanup_srcu_struct(&fs_info->subvol_srcu);
> =20
> +	btrfs_free_csum_hash(fs_info);
>  	btrfs_free_stripe_hash_table(fs_info);
>  	btrfs_free_ref_cache(fs_info);
>  }
>=20


--AkJn2LcBBFrLcNCftmUxpc8zeJLgpLhgW--

--Jk7dFQonq51qjopjeM5yFUNYQIF3jaYYX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0oOBUACgkQwj2R86El
/qgzEAf8DfPEezDR1wpqUkuog+JypJJHSCdKfUMFFR5lL/+jvdHwUJMuFSNLpGy/
k2Z53UxZma6mvIpOBGVK4OzACgtSAbZ+uVGGU1lOoPMJNwTmc9yitqOkSzIWwJ1T
oQlezSHVpgDZAH4wj/Gtuggi6hVCTkE7mDHDeiPVA/hkvQIGIH3x8Nertrlp9D+L
rp+Qj1NL//9UthfKCjDQOs5GujNzcTcSGAEkzC7nk+JBZAn8FPe3n0KxD2lde5Ty
tMPU4qZqyMdsTjPUl3+3ONRXoovQCZsz0DhMxGKrO/cm2CT4R37OLVXLPuosFhnx
txWje/jaVz4mTr55cVvefQvp8Tjg8Q==
=gTVc
-----END PGP SIGNATURE-----

--Jk7dFQonq51qjopjeM5yFUNYQIF3jaYYX--
