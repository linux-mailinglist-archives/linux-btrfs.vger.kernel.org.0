Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E011F03B1
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jun 2020 01:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgFEX5O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jun 2020 19:57:14 -0400
Received: from mout.gmx.net ([212.227.17.22]:33873 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728381AbgFEX5N (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Jun 2020 19:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591401427;
        bh=ygOVgI7jkjsjB7iG4Da2rbMWugQBSnfLxsDf1qosmqE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=bYgz26lSHd2eoZ5Pb2q72bPpPRXWXC0nGFRX4MCHF/7TcwVMGny0oHtmBqNnKSvQw
         YOJ8CehH7UPJF7QsyCd1Kfusqsw/ALDpjU7FjJJCaCsBQYNlsVi/iIzevFSnFui5kT
         2nsaKz2J4al4XT5nlwA55pDjd8NNpkcqSPyLDRHU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mn2aN-1jHgJA0Tbz-00kBUf; Sat, 06
 Jun 2020 01:57:07 +0200
Subject: Re: readonly btrfs
To:     Matt Zagrabelny <mzagrabe@d.umn.edu>, linux-btrfs@vger.kernel.org
References: <CAOLfK3Wr9e+gE3v_=30etzxNr8=JgzUK5PEkq1wTDbaKCRKgZw@mail.gmail.com>
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
Message-ID: <8c06c98e-fcdb-0e13-7490-2f45646e20b8@gmx.com>
Date:   Sat, 6 Jun 2020 07:57:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAOLfK3Wr9e+gE3v_=30etzxNr8=JgzUK5PEkq1wTDbaKCRKgZw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ebew8f285N64AVUWDDzuSmfLaezM8fNmU"
X-Provags-ID: V03:K1:+OIJyXot7YYWGVxhqMY7u3Z4tMccGjLeeXhmWMc/6QvmU4q/atz
 c4yqRDji6LVy3dOGoJxBn2LeqfDCIm1JfhTKq2dccCDl6vn4jptY2qwPzu298iYK6JGU5r3
 Vik+G8BKTZxjzzHt/JvKpCv/2UV6jZ4g3odmJ3W0xrs7Mg5YNyIysyCViZ+K74pu7vXjAjp
 dSsKzI8dccz0ib8OVCSTw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:D/scacolY3Q=:P8Ebx2I2j3MShtVv5ExmGB
 +OARXVDiK1pR3KlovYijlqkcFzQLxD0GgXnKbncMhdyjmwlUrxhzrdLHx3MHphpqckDjOtJmI
 Qdt8ONWHgfwJStGI41sfuSc4jbTE0gfpEagPICVeeXinyY47V9z0RE30xqt96f36M91sy3Z11
 F3nex4Y437Uw8RtXi0IgT7ujgYSAuJcxWEq9DP37DTBPDgCQEyDCVmyrDQDJvNGGOrRoYNp9/
 T7IsqY4s4Rr7V05e4lBnFwNxpTtDZdfo/k0L9yBHGdwJK+O+g/RL4+QoM2Wl3bU0wkFlSMZli
 I5x+2cAqDlQxEqgvWF/teXQbQ2mxlfK/Wn5TpY+AVucBoxj0U0PFf25BDv/7M5DBCk7Oaee8G
 O39ALL6WIYBZfBP7SsGkwYSa5hyvBdJaS9/q4z85Nsy35XoXI8SrmmJNJvGGD30cIWJAAhD+I
 qHXp1GQC9o18goARti/zG+hp7aFyiimemdNEPOn6qwHTRMtMHZCXP4zeXng+yz3Uhx/SGADFT
 c7HQkBgcppPY2adO4M2+ebklGrkORSin72dD0HKBvjRJ1vZFd5ipkjBld0OK7ZklWblDnOB68
 NekuEnmdZvfxCTlg8bffw6MnFKFnyyg9zNJoer5S+bEvEIQzVzR/VtesMJhqembvuqORgMcEV
 BjKiIm47I6vyAU3UTccdlgz1mMO8OJI89Y/EPmQvolFbBvj6gqA4aNBduW5QxZ4f3aUjIANtB
 cSnoVQ6EUYHSmb+SZs0+5lODR/tdE1jkhde/TxMJ7ZRZZjyOEkg5dKOD+QkWa6oiB10BCYpnW
 CYej+uhq4rTjiy6+P+yXWRTLQcFXszPZ7EzpAuKeBc3DTOlV/CdKWjCiAmOMs5LAsqoFvHjUv
 WLSWxNxuIQ65bNrmX2bIhqeFwPA2MgIuwdjFHS5pLR/n2ssO31g6vCPE6rpCotLM7gs+IOPle
 3TU5DjGi6zE6ZeSSN4NCZ+HkLQ7zz+3cff2ou+m09fSKF1dC/APvyX4mStpG5HkREbA9R3DdX
 2Sf6DCdCHjrnwXFkfndITq7hvZzLkX2Kcpd4JQnME9fdipDa8j/Z8eIANpcbkoMI7yaTVfn8D
 cefSamSYIj4KdmKEGQWyG6GmGUTuz+0fF9SFYAgfa7FXzOS+EIO7OsNefjEsQY8MUbaq/qQhT
 o56wXmE1uo4kj56WzyWPJxCX+bgmOWJu5hRwd7grU0dqSvfJ56ZImG7hp+7G4zTzy50VaMFPI
 qkAD+N0XhWvcniSBa
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ebew8f285N64AVUWDDzuSmfLaezM8fNmU
Content-Type: multipart/mixed; boundary="fKvwKVUZtkG4nsDhrVzGDrW554md14MdW"

--fKvwKVUZtkG4nsDhrVzGDrW554md14MdW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/6 =E4=B8=8A=E5=8D=8812:26, Matt Zagrabelny wrote:
> Greetings,
>=20
> I'm getting a readonly btrfs filesystem. Here is the relevant dmesg:
>=20
> Linux version 5.5.0-1-amd64 (debian-kernel@lists.debian.org) (gcc
> version 9.3.0 (Debian 9.3.0-8)) #1 SMP Debian 5.5.13-2 (2020-03-30)
> [...]
> BTRFS error (device sda2): tree first key mismatch detected,
> bytenr=3D165532581888 parent_transid=3D2459281 key
> expected=3D(68186292224,169,1073741824) has=3D(68186292224,169,0)
> BTRFS error (device sda2): tree first key mismatch detected,
> bytenr=3D165532581888 parent_transid=3D2459281 key
> expected=3D(68186292224,169,1073741824) has=3D(68186292224,169,0)

Note 1073741824 =3D 0x40000000, which is just one bit flipped.

It looks like your memory is not reliable, thus one bit flipped and
cause the first key mismatch.

Btrfs is trying its best to detect any suspicious data, thus it rejects
the offending data and falls RO.

So I strongly recommend to do a full memtest.

> BTRFS error (device sda2): tree first key mismatch detected,
> bytenr=3D165532581888 parent_transid=3D2459281 key
> expected=3D(68186292224,169,1073741824) has=3D(68186292224,169,0)
> BTRFS error (device sda2): tree first key mismatch detected,
> bytenr=3D165532581888 parent_transid=3D2459281 key
> expected=3D(68186292224,169,1073741824) has=3D(68186292224,169,0)
> BTRFS error (device sda2): tree first key mismatch detected,
> bytenr=3D165532581888 parent_transid=3D2459281 key
> expected=3D(68186292224,169,1073741824) has=3D(68186292224,169,0)
> BTRFS error (device sda2): tree first key mismatch detected,
> bytenr=3D165532581888 parent_transid=3D2459281 key
> expected=3D(68186292224,169,1073741824) has=3D(68186292224,169,0)
> BTRFS error (device sda2): tree first key mismatch detected,
> bytenr=3D165532581888 parent_transid=3D2459281 key
> expected=3D(68186292224,169,1073741824) has=3D(68186292224,169,0)
> BTRFS error (device sda2): tree first key mismatch detected,
> bytenr=3D165532581888 parent_transid=3D2459281 key
> expected=3D(68186292224,169,1073741824) has=3D(68186292224,169,0)
> BTRFS error (device sda2): tree first key mismatch detected,
> bytenr=3D165532581888 parent_transid=3D2459281 key
> expected=3D(68186292224,169,1073741824) has=3D(68186292224,169,0)
> BTRFS error (device sda2): tree first key mismatch detected,
> bytenr=3D165532581888 parent_transid=3D2459281 key
> expected=3D(68186292224,169,1073741824) has=3D(68186292224,169,0)
> BTRFS error (device sda2): tree first key mismatch detected,
> bytenr=3D165532581888 parent_transid=3D2459281 key
> expected=3D(68186292224,169,1073741824) has=3D(68186292224,169,0)
> ------------[ cut here ]------------
> BTRFS: Transaction aborted (error -117)
> WARNING: CPU: 3 PID: 286 at fs/btrfs/extent-tree.c:2209
> btrfs_run_delayed_refs+0x1a1/0x1f0 [btrfs]
> Modules linked in: cmac bnep cpufreq_userspace cpufreq_powersave
> cpufreq_conservative binfmt_misc nls_ascii nls_cp437 vfat fat
> intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp
> coretemp uvcvideo kvm_intel kvm btusb videobuf2_vmalloc
> videobuf2_memops btrtl videobuf2_v4l2 btbcm irqbypass videobuf2_common
> btintel iwldvm mac80211 bluetooth videodev dell_laptop
> crct10dif_pclmul drbg ghash_clmulni_intel ansi_cprng
> snd_hda_codec_hdmi snd_hda_codec_idt ecdh_generic aesni_intel
> snd_hda_codec_generic ecc dell_smm_hwmon libarc4 crypto_simd crc16 mc
> ledtrig_audio cryptd ppdev snd_hda_intel glue_helper joydev mei_wdt
> iTCO_wdt snd_intel_dspcfg dell_wmi snd_hda_codec dell_smbios wmi_bmof
> iwlwifi dell_smo8800 snd_hda_core iTCO_vendor_support intel_cstate
> snd_hwdep intel_uncore snd_pcm watchdog sg intel_rapl_perf pcspkr
> snd_timer serio_raw sparse_keymap parport_pc dcdbas dell_rbtn cfg80211
> dell_wmi_descriptor mei_me efi_pstore snd ac efivars evdev mei parport
> soundcore
>  rfkill efivarfs ip_tables x_tables autofs4 btrfs blake2b_generic xor
> zstd_decompress zstd_compress raid6_pq libcrc32c crc32c_generic sr_mod
> cdrom sd_mod hid_generic usbhid hid nouveau mxm_wmi i2c_algo_bit ttm
> ahci libahci xhci_pci drm_kms_helper libata xhci_hcd sdhci_pci
> crc32_pclmul ehci_pci drm cqhci ehci_hcd psmouse crc32c_intel sdhci
> i2c_i801 e1000e scsi_mod usbcore mmc_core lpc_ich ptp mfd_core
> usb_common pps_core wmi battery video button
> CPU: 3 PID: 286 Comm: btrfs-transacti Tainted: G        W
> 5.5.0-1-amd64 #1 Debian 5.5.13-2
> Hardware name: Dell Inc. Latitude E6430/0H3MT5, BIOS A18 01/18/2016
> RIP: 0010:btrfs_run_delayed_refs+0x1a1/0x1f0 [btrfs]
> Code: 41 5f c3 49 8b 54 24 50 f0 48 0f ba aa 28 17 00 00 02 72 1b 83
> f8 fb 74 37 89 c6 48 c7 c7 40 c0 84 c0 89 04 24 e8 71 47 2f f3 <0f> 0b
> 8b 04 24 89 c1 ba a1 08 00 00 4c 89 e7 89 04 24 48 c7 c6 00
> RSP: 0018:ffffaec08084fe00 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 00000000000001a8 RCX: 0000000000000007
> RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff98501dcd9a40
> RBP: ffff984fb22e7d58 R08: 000000000000047c R09: 0000000000000004
> R10: 0000000000000000 R11: 0000000000000001 R12: ffff98501af1ae38
> R13: ffff98501bad1230 R14: ffff98501bad0378 R15: ffff984fb22e7c00
> FS:  0000000000000000(0000) GS:ffff98501dcc0000(0000) knlGS:00000000000=
00000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000563a7b0aa168 CR3: 000000028bc0a001 CR4: 00000000001606e0
> Call Trace:
>  btrfs_commit_transaction+0x57/0xa20 [btrfs]
>  ? start_transaction+0xbb/0x4c0 [btrfs]
>  transaction_kthread+0x13c/0x180 [btrfs]
>  kthread+0xf9/0x130
>  ? btrfs_cleanup_transaction+0x5c0/0x5c0 [btrfs]
>  ? kthread_park+0x90/0x90
>  ret_from_fork+0x35/0x40
> ---[ end trace 717f06ffcf003459 ]---
> BTRFS: error (device sda2) in btrfs_run_delayed_refs:2209: errno=3D-117=
 unknown
> BTRFS info (device sda2): forced readonly
>=20
> Is this a helpful message for the developers?
>=20
> Does it look like hardware failure?

Yep.

I recommend to check for memory, with that problem ruled out, btrfs
check to ensure there is no on-disk problem.
If any, backup your data asap.

Thanks,
Qu

>=20
> I can provide more details.
>=20
> Let me know what you think.
>=20
> Thanks,
>=20
> -Matt
>=20


--fKvwKVUZtkG4nsDhrVzGDrW554md14MdW--

--ebew8f285N64AVUWDDzuSmfLaezM8fNmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7a29AACgkQwj2R86El
/qjJxggAsBkNaDGXq0NGtngCDZ5Lm3mi5DR3MxdrHfJLqNn27jlD5vrsa9CBbowh
qVJMVGHtaDByEJ23Whd+lmi9qlEAjejGa/jfYzZuhPe6k3u8wEbopHYQdrJuzYNY
lRxVZW8vmlLWPt/KsSM7jCujPM/lXJ+ko+ogyKCkWGEZqiopDD8lcwJ71LuDLOgZ
m9EV+1SVL6opJqI0mVMQemnNbeBjHbytnqsET4wfcM5ioPaankjLOyr27MR7smqj
2xkfKiRdOYUpmpQ73ODdHvU4sGo0xmiLoIh7HLsFoekFArUwpt1qGYwYhgwUYSfs
9vF3ZrNQU5Qb7zViGlApxbDXsEBd9w==
=NVHS
-----END PGP SIGNATURE-----

--ebew8f285N64AVUWDDzuSmfLaezM8fNmU--
