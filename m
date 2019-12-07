Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED25115B84
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2019 08:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbfLGH2i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Dec 2019 02:28:38 -0500
Received: from mout.gmx.net ([212.227.17.20]:48979 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfLGH2i (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 7 Dec 2019 02:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575703714;
        bh=pMl4ficwhAYZPBl4NcV5KRMtdXK2VivuTfSAEkQ7dzw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=hakD5AP0EVcdwtN218R47knhE/m5hpr0ceZm/nTJQ7mt5cfwfUuzKonNbanaGq4XR
         4rgX1XCHK3HyOjaYY+gj5xK3XWoAKKk/pscXQrPEwaOzWz2V8h3w9Hp7ZXPS2rgbWR
         Mc4+wtzBG9v4i8QUcz27XqdIgfQwJRQJieEaFXLM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeCtj-1i4hjK47y3-00bJdR; Sat, 07
 Dec 2019 08:28:34 +0100
Subject: Re: df shows no available space in 5.4.1
To:     Martin Raiber <martin@urbackup.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <0102016edd1b0184-848d9b6d-6b80-4ce3-8428-e472a224e554-000000@eu-west-1.amazonses.com>
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
Message-ID: <784074e1-667a-a2c7-5b47-7cbe36f5fdf5@gmx.com>
Date:   Sat, 7 Dec 2019 15:28:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <0102016edd1b0184-848d9b6d-6b80-4ce3-8428-e472a224e554-000000@eu-west-1.amazonses.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EWauJQGhzHgkdkHdliSAylMjitGDDWQGf"
X-Provags-ID: V03:K1:QNSYcXwFOMaONAac7FOhsJp2q0T7DqhTImNVdB7Ye/4P+5Rpl4d
 kOIJJ2nzIYpnIVlLAXFKPk7IwQnqpkbJsE3DFpxMjDsz+nEZwsakbWA8Mv/G/7i3CtpcByI
 4AuxVWhCALD3B0q34zMSm9iLyD8SpJuG2UVL9RKJjmq/T6BmY9sgC9LBNY7f1p0pbCYOB/o
 2qld8sWOnFzDwrzpbTgmw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TSl1App/5Gg=:sI/gxuqHCxTi0U+tU6sEng
 FPDK7Jft0/Ad3DZQl4+jNVX8OWTSbm5aw89J+1lghtF9TiAExSyAGxpxEkFtgVpcxjiPRrqTI
 yKPRgMRCbwpNAMbqnq2Lnymxs5dEv1eKZiXnzd15tyCJNG4/iQcBJQhhYH47n4kgYl17lP6Zf
 i6u1r8vbuyNbDiaR91rn6XaE7Rjv89u+hkG9MnYgUlcCBJ9WRQBWQw04GzN8ygEQNeYQNw5gv
 ZwU/A51rIjdvJl/srXwE8QSIdgMtePVSFaOfMRKsIb/hc2Wxa53vOdSQxy1cHPb0rHtOAk+Aj
 AwBTH8EC2GQLtmJaKVtXSdDd9w7+2Y7I+KBfG5kDhxGvpKDEocWFv09VwVkMFVJlPv/fVo/PE
 Vq5tV/9uAyJhccleBeHuOIrloXxN6B1OJLORr7dlbOfWvMb4LFIsq+g0VIz9ItS9Xda98Zi4Y
 LWKmGuqcI39VXo6+r8xBdBXq4Yx2496kI6Bi0vba73RZlrS8KCtz08v8qdVWixpuDK9dfroNo
 ZHyNXyooNQ37DoYFUBMKqFJIsbVqfLjUp+ExdAKSVX/uKtvGT8N/OTP9NVoKkBVYbrsLWOkYW
 46yANbiyNNy2QdF4fYfn4W74A4zZOHuRiHrBB7tiIm/CNKUfxZowYpAZd4cVfkAZqUrxo5xvd
 kyX7vy0+SPQgCJ0IsBEL83PXzHJ65UUcmB+C29/aYqXbzGI74xlHZ/KwhQKGkmGuQB9tCreMx
 LGJYsZkOBEOfIkm+m3ReeDNUsJ4FzrbdOBvOrcOQtTIJqlqys1NUOcAuG+871XUp0tVL1/9Ie
 kQx+k934M9hCXOb+OsIDZ8eeCUGM6tVcOYAEC2GSLTjII+6kT/JAfXbZmcD5kHE3D2HE/FQse
 y+Ia5XopZy1bNDku0qMgHIBeGExpbm4DKSprj9jLL8ZK+UWyo43/QKy4U85FKDlAyk0SNXlQZ
 8AiuQnfOP5VNmgK2jg0zmjEjjTDUrztVKAy69UagmQTTpZG3k1S/LQdwFsTN9b7FNzU5jL40j
 NKkv00sAy59wDOc72oLrWYt/b+NSgnF0vBM9U2jfuno70dqRLqtdltcvQZRIA1vBK4lfszj51
 rxTfHyqMMzdu/q6rl9wwPk/BHuqiHs5bo5nUo/nZ2mp/1Q5ybr4a4HSJ1Lm1gCEmeJmjmUsJy
 9f5fJGhhTnCdKWEC7a1h0Sxro7X1Qw/Dsz//+D5MM1dxSyNNHTSvv2gx4Go1KWW50OZu6hiX1
 /xTX1x/Wx2mRVld63uoLQd0FQwGLo77ewor+6r4PHjUtL/q1MUteJglqc1WY=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EWauJQGhzHgkdkHdliSAylMjitGDDWQGf
Content-Type: multipart/mixed; boundary="N3eSZn0Brw8FDCmRSZZF8MiE29VaxlxDI"

--N3eSZn0Brw8FDCmRSZZF8MiE29VaxlxDI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/7 =E4=B8=8A=E5=8D=885:26, Martin Raiber wrote:
> Hi,
>=20
> with kernel 5.4.1 I have the problem that df shows 100% space used. I
> can still write to the btrfs volume, but my software looks at the
> available space and starts deleting stuff if statfs() says there is a
> low amount of available space.

If the bug still happens, mind to try the snippet to see why this happene=
d?

You will need to:
- Apply the patch to your kernel code
- Recompile the kernel or btrfs module
  So this needs some experience in kernel compile.
- Reboot to newly compiled kernel or load the debug btrfs module

Thanks,
Qu

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 23aa630f04c9..cf34c05b16d7 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -523,7 +523,8 @@ static int should_ignore_root(struct btrfs_root *root=
)
 {
        struct btrfs_root *reloc_root;

-       if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
+       if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state) ||
+           test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
                return 0;

        reloc_root =3D root->reloc_root;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f452a94abdc3..c2b70d97a63b 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2064,6 +2064,8 @@ static int btrfs_statfs(struct dentry *dentry,
struct kstatfs *buf)
                                        found->disk_used;
                }

+               pr_info("%s: found type=3D0x%llx disk_used=3D%llu factor=3D=
%d\n",
+                       __func__, found->flags, found->disk_used, factor)=
;
                total_used +=3D found->disk_used;
        }

@@ -2071,6 +2073,8 @@ static int btrfs_statfs(struct dentry *dentry,
struct kstatfs *buf)

        buf->f_blocks =3D div_u64(btrfs_super_total_bytes(disk_super),
factor);
        buf->f_blocks >>=3D bits;
+       pr_info("%s: super_total_bytes=3D%llu total_used=3D%llu
factor=3D%d\n", __func__,
+               btrfs_super_total_bytes(disk_super), total_used, factor);=

        buf->f_bfree =3D buf->f_blocks - (div_u64(total_used, factor) >>
bits);

        /* Account global block reserve as used, it's in logical size
already */



>=20
> # df -h
> Filesystem=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Size=C2=A0 Used Avail
> Use% Mounted on
> ...
> /dev/loop0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7.4T=C2=A0 623G=C2=A0=C2=A0=
=C2=A0=C2=A0 0
> 100% /media/backup
> ...
>=20
> statfs("/media/backup", {f_type=3DBTRFS_SUPER_MAGIC, f_bsize=3D4096,
> f_blocks=3D1985810876, f_bfree=3D1822074245, f_bavail=3D0, f_files=3D0,=

> f_ffree=3D0, f_fsid=3D{val=3D[3667078581, 2813298474]}, f_namelen=3D255=
,
> f_frsize=3D4096, f_flags=3DST_VALID|ST_NOATIME}) =3D 0
>=20
> # btrfs fi usage /media/backup
> Overall:
> =C2=A0=C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7.40Ti=
B
> =C2=A0=C2=A0=C2=A0 Device allocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 671.02GiB
> =C2=A0=C2=A0=C2=A0 Device unallocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.74TiB
> =C2=A0=C2=A0=C2=A0 Device missing:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
> =C2=A0=C2=A0=C2=A0 Used:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 622.49GiB
> =C2=A0=C2=A0=C2=A0 Free (estimated):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.79TiB=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (min: 6.79TiB)
> =C2=A0=C2=A0=C2=A0 Data ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 1.00
> =C2=A0=C2=A0=C2=A0 Metadata ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.0=
0
> =C2=A0=C2=A0=C2=A0 Global reserve:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 512.00MiB=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (used: 0.00B)
>=20
> Data,single: Size:666.01GiB, Used:617.95GiB
> =C2=A0=C2=A0 /dev/loop0=C2=A0=C2=A0=C2=A0 666.01GiB
>=20
> Metadata,single: Size:5.01GiB, Used:4.54GiB
> =C2=A0=C2=A0 /dev/loop0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.01GiB
>=20
> System,single: Size:4.00MiB, Used:96.00KiB
> =C2=A0=C2=A0 /dev/loop0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4.00MiB
>=20
> Unallocated:
> =C2=A0=C2=A0 /dev/loop0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.74TiB
>=20
> # btrfs fi df /media/backup
> Data, single: total=3D666.01GiB, used=3D617.95GiB
> System, single: total=3D4.00MiB, used=3D96.00KiB
> Metadata, single: total=3D5.01GiB, used=3D4.54GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>=20
> # mount
>=20
> ...
> /dev/loop0 on /media/backup type btrfs
> (rw,noatime,nossd,discard,space_cache=3Dv2,enospc_debug,skip_balance,co=
mmit=3D86400,subvolid=3D5,subvol=3D/)
> ...
>=20
> (I remounted with enospc_debug and the available space did not change..=
=2E)
>=20
> Regards,
> Martin Raiber
>=20


--N3eSZn0Brw8FDCmRSZZF8MiE29VaxlxDI--

--EWauJQGhzHgkdkHdliSAylMjitGDDWQGf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3rVJ0ACgkQwj2R86El
/qgJFwf/fDC1dBiHNNqP38ku8X+6V55C4M3nqQEbsqVuxNJVNwnd6NbhXK6qT9JS
9mSwm/rkr3D3cNoW6mQsyLiFhK9ir0WCqdLamzTWR2Kr1d10lAc1tClTarKh0d+I
FKv/ZYZPqkm+ZB8rmR6RYjn08AuLyQGMczozf23yHBvPviYX6FDNoCeHDH9a2S61
gM7tYgL38+SsNmcQAQ1Qvn/CuJACAMbtEwGqWhE1BlIoPvKEBP1VSraIiHxHa4a4
c1ZuShZbhn3as4OzwlTopKbIReIqH+U0V+kJ8Y6mvjqZQSngFAclzNvtfYRVC62w
f8PCiksl9xZUesnJ16kErNBdepDD7A==
=p69v
-----END PGP SIGNATURE-----

--EWauJQGhzHgkdkHdliSAylMjitGDDWQGf--
