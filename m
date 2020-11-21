Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60AA2BBD7E
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Nov 2020 07:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgKUGDB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Nov 2020 01:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgKUGDA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Nov 2020 01:03:00 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B86C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Nov 2020 22:03:00 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id 142so12330417ljj.10
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Nov 2020 22:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=/zXO3FjAmLSSTnyPFZbQ5AI9J1mrysuFwNFs1I+aHXA=;
        b=IPuMXsBScqz245pQw8hVjLeyJ8yLuNO8c3iP5eZsJISe+tTJL75ATDjW+CXK7V92dJ
         iKGtFewEuHcUYF9g/XqtUfQcWYWROFOv8POsRcRemPChXK87Tq9qoY5wnANeWGRn/LJg
         f0WacHjUnY5/Ft+z+CZUIs2ao+XzyVj9JWm5ku9NqnXWwNLVF3Qe1/rilZ3r5cpZnV+P
         jaSZqSjO6K34FkRZIlpS1qmm6SbfsTdhQ4OrlZ0tQqWO9FnFrWZCjm2+jygDyURX5Zl2
         t94Rv6/EpxsMFrWTZrPP9jRTadHdFNoKZYmErQWVnIaA/CvbPzbSEhwnFbP81HDptZ9r
         RPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=/zXO3FjAmLSSTnyPFZbQ5AI9J1mrysuFwNFs1I+aHXA=;
        b=QYMq4H9ToRyuLY1UUAMjUupD6Sxko2pqusDAoiLRq9l05Jh9eeHirfcWUQR7Y0+ZIe
         WjbjmqzNckR2RNe4fUC6UDL2SLEiGDN6aunjJselapShPfU/b0t9S1qWtx3OZjymcdbe
         ynt/Bfd7ftUd6BIuH31mFIuLalEXgZIaD34eXpcGulhLCerCjpUCja6lSkW6Jb51wnsr
         pV2c0z6IhMzFtYqID9+6LaTxeqvnb+t/g6z3dymAAdTPv8IndfNC4jhcA/US/anycCQI
         7WTHl6HwdNsCd0GMa+bgkDfa43pP0q0K3NVTNmPYinCo0nDoUhMVizS2i3hWjo6C3xOs
         c6sQ==
X-Gm-Message-State: AOAM533OdgUFDapTSyIovWsiVH7F2PQDpvcqtSXHVuKWu6IMQWDNcxHX
        qgAzRXSBycCDt1FUL75KFT88wMFwA1o=
X-Google-Smtp-Source: ABdhPJyiqbSaSR7qbSN9vbKO+AqrMTTBCRl1WcE9xC0y4coeFVVNZ4mmlhm4k4kxHAhJuYq8PMzqlw==
X-Received: by 2002:a2e:904e:: with SMTP id n14mr9587428ljg.299.1605938578347;
        Fri, 20 Nov 2020 22:02:58 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:a5f0:a226:8dec:c68b:2e4? ([2a00:1370:812d:a5f0:a226:8dec:c68b:2e4])
        by smtp.gmail.com with ESMTPSA id i7sm586951lfi.269.2020.11.20.22.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 22:02:57 -0800 (PST)
Subject: Re: Not enough space during conversion to raid5, filesystem fails to
 mount as RW
To:     Kristupas Savickas <kristupas.savickas@pm.me>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <bzvIMgcJHYGZvBm4xa7bCl_20ql_b3sZtJ6zxcAVyw7eZ8jQYpRFCukGBshxLFF4cRJ-vwdkZgj7GkbqF8o9tKt25RU3xiz_ikIaejDuH90=@pm.me>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Autocrypt: addr=arvidjaar@gmail.com; prefer-encrypt=mutual; keydata=
 mQGiBDxiRwwRBAC3CN9wdwpVEqUGmSoqF8tWVIT4P/bLCSZLkinSZ2drsblKpdG7x+guxwts
 +LgI8qjf/q5Lah1TwOqzDvjHYJ1wbBauxZ03nDzSLUhD4Ms1IsqlIwyTLumQs4vcQdvLxjFs
 G70aDglgUSBogtaIEsiYZXl4X0j3L9fVstuz4/wXtwCg1cN/yv/eBC0tkcM1nsJXQrC5Ay8D
 /1aA5qPticLBpmEBxqkf0EMHuzyrFlqVw1tUjZ+Ep2LMlem8malPvfdZKEZ71W1a/XbRn8FE
 SOp0tUa5GwdoDXgEp1CJUn+WLurR0KPDf01E4j/PHHAoABgrqcOTcIVoNpv2gNiBySVsNGzF
 XTeY/Yd6vQclkqjBYONGN3r9R8bWA/0Y1j4XK61qjowRk3Iy8sBggM3PmmNRUJYgroerpcAr
 2byz6wTsb3U7OzUZ1Llgisk5Qum0RN77m3I37FXlIhCmSEY7KZVzGNW3blugLHcfw/HuCB7R
 1w5qiLWKK6eCQHL+BZwiU8hX3dtTq9d7WhRW5nsVPEaPqudQfMSi/Ux1kbQmQW5kcmV5IEJv
 cnplbmtvdiA8YXJ2aWRqYWFyQGdtYWlsLmNvbT6IYAQTEQIAIAUCSXs6NQIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAAoJEEeizLraXfeMLOYAnj4ovpka+mXNzImeYCd5LqW5to8FAJ4v
 P4IW+Ic7eYXxCLM7/zm9YMUVbrQmQW5kcmVpIEJvcnplbmtvdiA8YXJ2aWRqYWFyQGdtYWls
 LmNvbT6IZQQTEQIAJQIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AFAliWAiQCGQEACgkQ
 R6LMutpd94wFGwCeNuQnMDxve/Fo3EvYIkAOn+zE21cAnRCQTXd1hTgcRHfpArEd/Rcb5+Sc
 uQENBDxiRyQQBACQtME33UHfFOCApLki4kLFrIw15A5asua10jm5It+hxzI9jDR9/bNEKDTK
 SciHnM7aRUggLwTt+6CXkMy8an+tVqGL/MvDc4/RKKlZxj39xP7wVXdt8y1ciY4ZqqZf3tmm
 SN9DlLcZJIOT82DaJZuvr7UJ7rLzBFbAUh4yRKaNnwADBwQAjNvMr/KBcGsV/UvxZSm/mdpv
 UPtcw9qmbxCrqFQoB6TmoZ7F6wp/rL3TkQ5UElPRgsG12+Dk9GgRhnnxTHCFgN1qTiZNX4YI
 FpNrd0au3W/Xko79L0c4/49ten5OrFI/psx53fhYvLYfkJnc62h8hiNeM6kqYa/x0BEddu92
 ZG6IRgQYEQIABgUCPGJHJAAKCRBHosy62l33jMhdAJ48P7WDvKLQQ5MKnn2D/TI337uA/gCg
 n5mnvm4SBctbhaSBgckRmgSxfwQ=
Message-ID: <2a8c046c-78c3-9f62-e5b4-7a5c9909da5d@gmail.com>
Date:   Sat, 21 Nov 2020 09:02:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bzvIMgcJHYGZvBm4xa7bCl_20ql_b3sZtJ6zxcAVyw7eZ8jQYpRFCukGBshxLFF4cRJ-vwdkZgj7GkbqF8o9tKt25RU3xiz_ikIaejDuH90=@pm.me>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="RQWY6BbC8qYBlOHAnadkmivT8F01bz6uG"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RQWY6BbC8qYBlOHAnadkmivT8F01bz6uG
Content-Type: multipart/mixed; boundary="LlDm4kJZRdsxzlyUO5DHoFUojELSeovqd"

--LlDm4kJZRdsxzlyUO5DHoFUojELSeovqd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

20.11.2020 12:24, Kristupas Savickas =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Hello,
>=20
> I tried to convert my (nearly full) file system to raid5. The fs origin=
ally contained 3 8TB disks.
> After adding the forth disk I ran:
>     # btrfs balance start -dconvert=3Draid5,soft -mconvert=3Draid5,soft=
 -sconvert=3Draid5,soft -b /mnt/
>=20

Using raid5 for metadata is not recommended with current state of raid5
support in btrfs. See also

https://lore.kernel.org/linux-btrfs/20200627032414.GX10769@hungrycats.org=
/

> However, it looks like the conversion failed and the fs was left in RO =
state, with only part of the data being converted to raid5:
>=20
>     # btrfs fi show /dev/sdc
>     Label: 'array'  uuid: 6e95de0a-4b51-4aab-b935-469626c83036
>             Total devices 4 FS bytes used 21.52TiB
>             devid    1 size 7.28TiB used 7.28TiB path /dev/sdc
>             devid    2 size 7.28TiB used 7.28TiB path /dev/sdd
>             devid    3 size 7.28TiB used 7.28TiB path /dev/sda
>             devid    4 size 7.28TiB used 7.28TiB path /dev/sdb
>=20
>     # mount /dev/sdc /mnt/
>     # mount | grep /mnt
>     /dev/sdc on /mnt type btrfs (ro,relatime,space_cache,subvolid=3D5,s=
ubvol=3D/)
>=20
>     # btrfs fi df /mnt
>     Data, single: total=3D14.22TiB, used=3D14.06TiB
>     Data, RAID5: total=3D7.44TiB, used=3D7.43TiB
>     System, RAID1: total=3D32.00MiB, used=3D2.47MiB
>     System, RAID5: total=3D32.00MiB, used=3D128.00KiB
>     Metadata, RAID1: total=3D13.00GiB, used=3D11.67GiB
>     Metadata, RAID5: total=3D12.00GiB, used=3D11.90GiB
>     GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>     WARNING: Multiple block group profiles detected, see 'man btrfs(5)'=
=2E
>     WARNING:   Data: single, raid5
>     WARNING:   Metadata: raid1, raid5
>     WARNING:   System: raid1, raid5
>=20

"btrfs filesystem usage -T" fives better overview, but it appears there
are is not enough space to allocate new raid5 chunks.

>     # dmesg
>     [65134.312783] BTRFS info (device sdc): disk space caching is enabl=
ed
>     [65134.312784] BTRFS info (device sdc): has skinny extents
>     [65136.207839] BTRFS info (device sdc): bdev /dev/sdd errs: wr 0, r=
d 4, flush 0, corrupt 0, gen 0
>     [65172.993492] BTRFS alert (device sdc): btrfs RAID5/6 is EXPERIMEN=
TAL and has known data-loss bugs
>     [65204.813036] BTRFS info (device sdc): checking UUID tree
>     [65211.733565] ------------[ cut here ]------------
>     [65211.733567] BTRFS: Transaction aborted (error -28)
>     [65211.733583] BTRFS: error (device sdc) in __btrfs_free_extent:306=
9: errno=3D-28 No space left
>     [65211.733629] WARNING: CPU: 2 PID: 19980 at fs/btrfs/extent-tree.c=
:3069 __btrfs_free_extent.isra.0+0x57e/0x8f0 [btrfs]
>     [65211.735427] BTRFS info (device sdc): forced readonly
>     [65211.735427] Modules linked in: xt_recent fuse ufs
>     [65211.735430] BTRFS: error (device sdc) in btrfs_run_delayed_refs:=
2173: errno=3D-28 No space left
>     [65211.735431]  qnx4 hfsplus hfs cdrom minix msdos jfs xfs dm_mod u=
as usb_storage xt_nat veth xt_MASQUERADE nf_conntrack_netlink xfrm_user x=
frm_algo nft_chain_nat nf_nat br_netfilter bridge stp llc overlay hid_log=
itech_hidpp joydev hid_logitech_dj hid_generic usbhid hid amdgpu edac_mce=
_amd kvm_amd kvm irqbypass ip6t_REJECT nf_reject_ipv6 xt_hl ip6_tables gh=
ash_clmulni_intel nls_ascii nls_cp437 ppdev snd_hda_codec_realtek snd_hda=
_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_d=
spcfg ip6t_rt snd_hda_codec vfat fat gpu_sched snd_hda_core ttm snd_hwdep=
 ipt_REJECT nf_reject_ipv4 efi_pstore aesni_intel xt_comment wmi_bmof lib=
aes crypto_simd cryptd snd_pcm xt_multiport glue_helper rapl drm_kms_help=
er ccp snd_timer sp5100_tco efivars pcspkr k10temp watchdog nft_limit snd=
 cec rng_core soundcore i2c_algo_bit sg parport_pc parport evdev xt_limit=
 xt_addrtype xt_tcpudp acpi_cpufreq button xt_conntrack nf_conntrack nf_d=
efrag_ipv6 nf_defrag_ipv4 nft_compat nft_counter nf_tables
>     [65211.735467]  nfnetlink drm efivarfs ip_tables x_tables autofs4 e=
xt4 crc16 mbcache jbd2 btrfs blake2b_generic xor zstd_compress raid6_pq l=
ibcrc32c crc32c_generic sd_mod nvme nvme_core crc32_pclmul t10_pi ahci li=
bahci r8169 realtek mdio_devres crc_t10dif libphy i2c_piix4 crct10dif_gen=
eric libata crc32c_intel xhci_pci xhci_hcd usbcore scsi_mod crct10dif_pcl=
mul crct10dif_common usb_common wmi video gpio_amdpt gpio_generic
>     [65211.737278] CPU: 2 PID: 19980 Comm: btrfs-transacti Tainted: G  =
      W      X  5.9.0-1-amd64 #1 Debian 5.9.1-1
>     [65211.737280] BTRFS info (device sdc): balance: resume -dconvert=3D=
raid5,soft -mconvert=3Draid5,soft -sconvert=3Draid5,soft
>     [65211.737281] Hardware name: Gigabyte Technology Co., Ltd. AB350M-=
D3H/AB350M-D3H-CF, BIOS F51c 07/02/2020
>     [65211.737300] RIP: 0010:__btrfs_free_extent.isra.0+0x57e/0x8f0 [bt=
rfs]
>     [65211.737302] Code: 24 0c ba 5b 0c 00 00 48 c7 c6 40 01 5d c0 4c 8=
9 f7 e8 12 c2 0a 00 e9 b1 fe ff ff 44 89 e6 48 c7 c7 80 a5 5d c0 e8 98 c5=
 16 d1 <0f> 0b 44 89 e1 ba fd 0b 00 00 48 c7 c6 40 01 5d c0 4c 89 f7 e8 e=
5
>     [65211.737303] RSP: 0018:ffffa398c192bc50 EFLAGS: 00010282
>     [65211.737305] RAX: 0000000000000000 RBX: 000026d0f54f8000 RCX: fff=
f969590898ac8
>     [65211.737305] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: fff=
f969590898ac0
>     [65211.737306] RBP: 0000259405cbd000 R08: 0000000000000995 R09: 000=
0000000000004
>     [65211.737307] R10: 0000000000000000 R11: 0000000000000001 R12: 000=
00000ffffffe4
>     [65211.737308] R13: ffff96955d4f0310 R14: ffff9692ab751d00 R15: 000=
0000000000005
>     [65211.737309] FS:  0000000000000000(0000) GS:ffff969590880000(0000=
) knlGS:0000000000000000
>     [65211.737310] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     [65211.737311] CR2: 000055ff8d180cb0 CR3: 00000003b621a000 CR4: 000=
00000003506e0
>     [65211.737312] Call Trace:
>     [65211.737333]  ? __btrfs_run_delayed_refs+0xfd3/0x1060 [btrfs]
>     [65211.737351]  __btrfs_run_delayed_refs+0x27a/0x1060 [btrfs]
>     [65211.737371]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
>     [65211.737391]  btrfs_commit_transaction+0x57/0xa30 [btrfs]
>     [65211.737411]  ? start_transaction+0xd2/0x540 [btrfs]
>     [65211.737415]  ? try_to_wake_up+0x130/0x5e0
>     [65211.737434]  transaction_kthread+0x14c/0x170 [btrfs]
>     [65211.737453]  ? btrfs_cleanup_transaction.isra.0+0x5a0/0x5a0 [btr=
fs]
>     [65211.737455]  kthread+0x11b/0x140
>     [65211.737457]  ? __kthread_bind_mask+0x60/0x60
>     [65211.737460]  ret_from_fork+0x22/0x30
>     [65211.737462] ---[ end trace 2f4a1b25242944de ]---
>     [65211.737463] BTRFS: error (device sdc) in __btrfs_free_extent:306=
9: errno=3D-28 No space left
>     [65211.738722] BTRFS: error (device sdc) in btrfs_run_delayed_refs:=
2173: errno=3D-28 No space left
>     [65211.748466] BTRFS info (device sdc): balance: ended with status:=
 -30
>=20
> Looking at the dmesg output, I see:
>     [65211.737280] BTRFS info (device sdc): balance: resume -dconvert=3D=
raid5,soft -mconvert=3Draid5,soft -sconvert=3Draid5,soft
>=20
> This indicates that the balance is ran again after remounting. Looking =
at the last line it says that:
>     [65211.748466] BTRFS info (device sdc): balance: ended with status:=
 -30
>=20
> I suppose this is what causes the fs to be mounted read only.
>=20
> Trying to remount the system as RW results in:
>     [68268.865313] BTRFS info (device sdc): disk space caching is enabl=
ed
>     [68268.865316] BTRFS error (device sdc): Remounting read-write afte=
r error is not allowed
>=20
> My question is how can I recover from a situation like this?
> I could definitely reduce the file system usage if I could mount it as =
RW, but
> the balance is ran immediately after mounting and fails, which results =
in a RO mount.
> Would it be possible to cancel the balance, so it doesn't run on mounti=
ng?
>=20

Mount with skip_balance mount option.

> Additional information:
>     # uname -a
>     Linux s 5.9.0-1-amd64 #1 SMP Debian 5.9.1-1 (2020-10-17) x86_64 GNU=
/Linux
>=20
>     # btrfs --version
>     btrfs-progs v5.9
>=20



--LlDm4kJZRdsxzlyUO5DHoFUojELSeovqd--

--RQWY6BbC8qYBlOHAnadkmivT8F01bz6uG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTsPDUXSW5c6iqbJulHosy62l33jAUCX7itkQAKCRBHosy62l33
jFDZAJ4xS7MlD8cX745oMmgYRoNjlXd2agCgnONc2UslzBcPeibTz9hYfMylaC4=
=XhLq
-----END PGP SIGNATURE-----

--RQWY6BbC8qYBlOHAnadkmivT8F01bz6uG--
