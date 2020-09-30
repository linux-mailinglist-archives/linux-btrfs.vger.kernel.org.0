Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B54827DE4C
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 04:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbgI3CID (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 22:08:03 -0400
Received: from mout.gmx.net ([212.227.15.15]:42847 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729811AbgI3CID (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 22:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601431678;
        bh=QCEd6RZO1WgTBmPaJgsP/0qjL75gGnX7A2peRZVWuZg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=FcMTDaU3n/1Muxo+NUyyxKrC8SJIWThLT52KwcufOMGW2UJDIKJZ/OTxM1SAU7s0F
         0jUx2TWGwrxCZrVQXXLDBEwxWPPyr1Nxp8NR9PWVGLfoGL9XG8V/e7s/XO86WhlU4Q
         IrTJKgssUlDUE0pKxR1remSMNnJDxsNeBocZibuo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MLiCo-1k5m7p3Qzg-00Hhdh; Wed, 30
 Sep 2020 04:07:58 +0200
Subject: Re: RAID 5 disk full, can't balance
To:     gumbi 2400 <gumbi2400@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAPw8+313EMnUXRWcacFqUqpOSQ2N1oQ2Fq0ubykzTy0F+t_ykA@mail.gmail.com>
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
Message-ID: <6e6565b2-58c6-c8c1-62d0-6e8357e41a42@gmx.com>
Date:   Wed, 30 Sep 2020 10:07:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAPw8+313EMnUXRWcacFqUqpOSQ2N1oQ2Fq0ubykzTy0F+t_ykA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RX9Tkw4QtjZLOV8U3UKqXU6SIXzApMY3K"
X-Provags-ID: V03:K1:HctCYqv8sodSsAiW1KaPHeeZi9Tm+ifAmxBXA0BIpqfeZdC8S8X
 nwiYg3vskgIDnaE37aXTSHHExYqCpyI6kzVsiHRul6Ou9mmGxBFlfV6g/ww74Dk5Rojfkw/
 w9i45k3N4zaXUsjy8FUcWEYtwG3MPpxmlRW/Fe0Rt5u6L3Ts3w1phbn/fjj8ZLjR5QFlCld
 c2P9qB9vb0cDsTYngKlwA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+WMFRemFmZg=:ORdw/1lyYYdq5l5l2KOi1m
 Iw5Tin3sZIP29C/oTRdyLLoor2NJuLkMqif6Kt6TrnJukxyZnOuQeT3H9QsjUE7auadVNLmrN
 qkddEX4y9RTSgVddVIbTi5mbO/FCejxOptanddCzt7NRBgYAiV+oPtSivw3QgybwOJ4vnOHIi
 E8+nv9XcSY+Fo77ZpLAGsPDzsiQW7tP5RJr0R8GnBFNUZIkqx9PjYd0pzdxnOEQOhpqrI/aZm
 AT9BOBaBleQ4JTxcsdRNITV8lmSrwK+TzA5kHnKB6gIQ/bnNCj9plvVrapR6Xoa0kRZdCTFd9
 rNNCcRE0CCLAeR3gyxSf4KQaZe5K90jVy7scPcgpZTPZL0N+vND1vc8JX6HONJd+Wx2X474qn
 L5OUOwg0B8nbLp1o+vNJVDmEc6b+K50SflvNGoeanIREQde78fJTvEQZfsiD4wQSrf+NQsfXr
 5s+xu8OAUdUxXIZ0Y39AWSDgxV5vAQvMsNRbiCGXuWQ4RYIdr0jBqgUQDMtsAcQetMdqn7MPE
 LsAKpuDKgncDsBMOuuxTv7VHkDpkyBzUgVI/Ou1nEhi/ftJ6UGnn6ODGkjlGwYQZp71WvjvKy
 IhUi/0rc8jFuPBXotIEEbR69DtJkp6ijcR2oadaxKyXX14NaH3jN1tsGZbMqMNezDk5EP2brd
 LuCiULhSZ+gwz3IkzCRcD1SWmcIfkeIKoWXXYlT77CWB4q+nUEDUeuacfneM8Ckul1UJ9zBJM
 Qmzphwy8Y9Mg+BIGOcwg5rcZnT8e6xP59jyTp++nSLFQfaEN7elUXT6DDXXZXOPzo4S1vv1+X
 ES5/OgZcf/Tzrf2eAt2/bo7u1IVCYaI5BbvE/Iuwcs5Rr3inuGpIbIgFMNQccq3TKx+SWrUlq
 EQrIstWBiQubIvhAf2QPMdg3i2/HEjCO+Bh5kvkg2dnOHWV1PZS/wop7dlRTaM8DTAMJKFSUY
 Ng9Z+4M/hXgIAnY/FYeZEBWWUmoTmNaOIrLVXhbBF6IHIsAoba992aS7ldWzAbGkULjqE+ya8
 7Wo4QreeikaZWmn1Dxr3d0/CFLlb0wHsKPYAQRhJXxLdZlhITXt7ZGvlJ2BTbKj2mhbloeGUG
 5fg0kCZsvBWjzJj49f7DXvKzjNch6uCY6lFx88nJ98+PGkM09neQo7tGYXRwcPcmL0zzmQDK/
 jvUWvRwNsbCjSxmPbwDvJpmq9J1lfKuy1GHMn15NNV6nDEQR1k+mtj0SqP42VNlAAIozG+g0o
 b4v0iMaRgPdOsBcrHMeRgmfwPNK55SwloGlOW3A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RX9Tkw4QtjZLOV8U3UKqXU6SIXzApMY3K
Content-Type: multipart/mixed; boundary="PDLXQW5RUk9yZpYvKAg6g7n7JWegakuq5"

--PDLXQW5RUk9yZpYvKAg6g7n7JWegakuq5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/30 =E4=B8=8A=E5=8D=883:11, gumbi 2400 wrote:
> Hello all,
>=20
> I have a RAID5 array of mixed disks as follows:
>=20
> Label: 'MEDIA'  uuid: e59ff456-aa03-4954-887f-b616ae0dc270
> Total devices 5 FS bytes used 13.07TiB
> devid    1 size 3.64TiB used 3.64TiB path /dev/mapper/crypt-sdb
> devid    2 size 7.28TiB used 4.54TiB path /dev/mapper/crypt-sdd
> devid    3 size 7.28TiB used 4.54TiB path /dev/mapper/crypt-sde
> devid    4 size 1.36TiB used 1.36TiB path /dev/mapper/crypt-sdf
> devid    5 size 3.64TiB used 3.64TiB path /dev/mapper/crypt-sdc
>=20
> I had a full server rebuild recently and when setting everything back
> up needed to run a chown across the array to reflect new UIDs. This
> failed due to not enough space and dropped into read-only. I'm aware
> that this is a common issue that is usually fixed by a rebalance and
> proceeded to kick off the following:
>=20
> btrfs balance start -dusage=3D90 /media
>=20
> This ran briefly and rebalanced a couple of chunks before I realised I
> had mistakenly not put this into the background. I canceled the
> balance and attempted to start a new one after remounting. However, on
> mount the previous balance tried to start again, which immediately
> kicked the fs back into read-only. At which point I attempted the
> following:
>=20
> mount -o skip_balance /media && btrfs balance cancel /media
>=20
> This again kicked it back into read-only as it couldn't wrote to
> cancel the balance. Next step was to try a temp 10G loopback device.
>=20
> mount -o skip_balance /media && btrfs device add /dev/loop3 /media &&
> btrfs balance cancel /media
>=20
> Again, back into read-only.
>=20
> Last attempt. It was suggested on reddit that running zero-log may
> blow out any pending transactions getting in the way, tried this and
> again back into read-only.
>=20
> btrfs rescue zero-log /dev/crypt-sdb
> mount -o skip_balance /media&& btrfs device add /dev/loop3 /media&&
> btrfs balance cancel /media
>=20
> At this point, I'm wondering if it's possible to figure out what
> transaction is causing issues even without trying to run anything
> other than a skip_balance it still drops into read-only after about 30
> seconds. I'd like to add a device and rebalance, but it can't seem to
> get that far. Any suggestions on what to look at next?

In theory, btrfs should not start balance if it knows it can no longer
allocate new chunks any more.

But unfortunately due to a bug in over-commit calculation, btrfs can't
distinguish raid5 complex space calculation from SINGLE, and believe we
can continue (since we still have 2 device with some space).

There is a patchset to address this, but not yet merged.

The only solution I guess now is just delete, delete, delete, until you
deleted enough files to free space for a proper balance.

Thanks,
Qu

>=20
> uname -a:
> Linux magickbrick 5.8.0-19-generic #20-Ubuntu SMP Fri Sep 11 09:08:26
> UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
>=20
> btrfs --version: btrfs-progs v5.7
>=20
> btrfs fi show:
>=20
> Data, RAID5: total=3D13.16TiB, used=3D13.05TiB
> System, RAID1C3: total=3D32.00MiB, used=3D960.00KiB
> Metadata, RAID1C3: total=3D14.00GiB, used=3D13.86GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D656.00KiB
>=20
> Label: 'MEDIA'  uuid: e59ff456-aa03-4954-887f-b616ae0dc270
> Total devices 5 FS bytes used 13.07TiB
> devid    1 size 3.64TiB used 3.64TiB path /dev/mapper/crypt-sdb
> devid    2 size 7.28TiB used 4.54TiB path /dev/mapper/crypt-sdd
> devid    3 size 7.28TiB used 4.54TiB path /dev/mapper/crypt-sde
> devid    4 size 1.36TiB used 1.36TiB path /dev/mapper/crypt-sdf
> devid    5 size 3.64TiB used 3.64TiB path /dev/mapper/crypt-sdc
>=20
>=20
>=20
> Most recent dmesg:
>=20
> BTRFS info (device dm-4): use lzo compression, level 0
> BTRFS info (device dm-4): disk space caching is enabled
> BTRFS info (device dm-4): has skinny extents
> BTRFS info (device dm-4): bdev /dev/mapper/crypt-sdb errs: wr 0, rd 1,
> flush 0, corrupt 0, gen 0
> BTRFS info (device dm-4): bdev /dev/mapper/crypt-sdf errs: wr 18, rd
> 136, flush 0, corrupt 0, gen 0
> BTRFS info (device dm-4): disk space caching is enabled
> BTRFS info (device dm-4): balance: resume skipped
> ------------[ cut here ]------------
> BTRFS: Transaction aborted (error -28)
> WARNING: CPU: 3 PID: 11529 at fs/btrfs/extent-tree.c:3070
> __btrfs_free_extent.isra.0+0x589/0x930 [btrfs]
> Modules linked in: binfmt_misc xfs nls_iso8859_1 reiserfs dm_multipath
> scsi_dh_rdac scsi_dh_emc scsi_dh_alua snd_hda_codec_realtek
> snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel
> snd_intel_dspcfg edac_mce_amd snd_hda_codec snd_hda_core snd_hwdep
> snd_pcm kvm snd_timer snd rapl efi_pstore wmi_bmof soundcore k10temp
> ccp input_leds joydev mac_hid sch_fq_codel ip_tables x_tables autofs4
> btrfs blake2b_generic dm_crypt raid10 raid456 async_raid6_recov
> async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1
> raid0 multipath linear hid_generic usbhid hid nouveau crct10dif_pclmul
> mxm_wmi crc32_pclmul video i2c_algo_bit ttm ghash_clmulni_intel
> drm_kms_helper aesni_intel syscopyarea sysfillrect sysimgblt
> fb_sys_fops crypto_simd cec cryptd glue_helper rc_core drm i2c_piix4
> r8169 realtek ahci xhci_pci libahci xhci_pci_renesas nvme nvme_core
> wmi gpio_amdpt gpio_generic
> CPU: 3 PID: 11529 Comm: btrfs-transacti Tainted: G        W
> 5.8.0-19-generic #20-Ubuntu
> Hardware name: Gigabyte Technology Co., Ltd. B450M GAMING/B450M
> GAMING, BIOS F50 11/27/2019
> RIP: 0010:__btrfs_free_extent.isra.0+0x589/0x930 [btrfs]
> Code: 84 48 8b 7d 88 ba 5c 0c 00 00 48 c7 c6 c0 30 8a c0 e8 4e f7 0a
> 00 e9 af fe ff ff 44 89 ee 48 c7 c7 08 dc 8a c0 e8 5c 31 2c fa <0f> 0b
> 48 8b 7d 88 44 89 e9 ba fe 0b 00 00 48 c7 c6 c0 30 8a c0 e8
> RSP: 0018:ffffb7a0413d3b70 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff91bb168d8cd8
> RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff91bb168d8cd0
> RBP: ffffb7a0413d3c20 R08: 0000000000000004 R09: 0000000000000c8d
> R10: 0000000000000000 R11: 0000000000000001 R12: 00002177776b4000
> R13: 00000000ffffffe4 R14: ffff91b99abc00e0 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff91bb168c0000(0000) knlGS:00000000000=
00000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa3e5cdcb20 CR3: 0000000212ae8000 CR4: 00000000003406e0
> Call Trace:
>  run_delayed_tree_ref+0x7f/0x160 [btrfs]
>  btrfs_run_delayed_refs_for_head+0x2e1/0x480 [btrfs]
>  __btrfs_run_delayed_refs+0x8c/0x1d0 [btrfs]
>  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
>  btrfs_start_dirty_block_groups+0x2c0/0x480 [btrfs]
>  btrfs_commit_transaction+0xc6/0x9e0 [btrfs]
>  ? start_transaction+0xd7/0x550 [btrfs]
>  ? __next_timer_interrupt+0xa0/0xe0
>  transaction_kthread+0x146/0x190 [btrfs]
>  kthread+0x12f/0x150
>  ? btrfs_cleanup_transaction.isra.0+0x2a0/0x2a0 [btrfs]
>  ? __kthread_bind_mask+0x70/0x70
>  ret_from_fork+0x22/0x30
> ---[ end trace 5734fd11b340fd6d ]---
> BTRFS: error (device dm-4) in __btrfs_free_extent:3070: errno=3D-28 No =
space left
> BTRFS info (device dm-4): forced readonly
> BTRFS: error (device dm-4) in btrfs_run_delayed_refs:2174: errno=3D-28
> No space left
>=20


--PDLXQW5RUk9yZpYvKAg6g7n7JWegakuq5--

--RX9Tkw4QtjZLOV8U3UKqXU6SIXzApMY3K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9z6HsACgkQwj2R86El
/qgJ8gf/SivAuFPyMu7AGxZL+nd7X/FyWEl2nZQJ7OFwTB+zXQwtXDLhErlS6yEU
PvmE0Yf6YVE04ccl6CXEcXVD5y1l2UNzKimlSXELvo794418bMwZR6pHj+3hmLo6
C7hCRKxYq/tQa66tVc2EVAiZqjj+54tOCBsW4bVi6TyeM449qnVxsA4E9nfW7/yP
VgwFLTwQfA42C4G/WWakA+kpGcxPRx4D+UYWpZRljY2FAUASO5UpsDixFNCCUB+m
FRVB/K99FCL0WJTOX2DE2uAqTeqQ84cUZ0T4ZMZc5dGgexIWbgkfPaBEg5oS5ZcJ
en3wbzhgBwdbnd1uxoatHbT3UiIYjg==
=tLP9
-----END PGP SIGNATURE-----

--RX9Tkw4QtjZLOV8U3UKqXU6SIXzApMY3K--
