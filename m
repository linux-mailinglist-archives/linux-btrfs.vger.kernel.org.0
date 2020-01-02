Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF9BF12E174
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 02:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgABB1C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jan 2020 20:27:02 -0500
Received: from mout.gmx.net ([212.227.17.22]:33599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgABB1C (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Jan 2020 20:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577928415;
        bh=f+kMcMTTMmQD4FiMp0PAeiTdIfPkIMphru3NlOFywjI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=lcAvlmqmCwLCJktf672LkGiT0kh8qy2JI1dQJGmw2G3dPpMIHcGERAMG5rROmEBmz
         Q+KnOn0VcyQooRLUlgYRf5BfeTW3H8w4eF0thITYZfI0Ed1+hyhQfEzvi+iLWTazJ5
         WQsb9QumkX5Uo10gNuJ+CK1ecrG7N95qMA6ljZRE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtOKc-1jawVM0d4w-00uqdf; Thu, 02
 Jan 2020 02:26:54 +0100
Subject: Re: Interrupted and resumed scrubs seem to have caused filesystem to
 go readonly (EFBIG error)
To:     Graham Cobb <g.btrfs@cobb.uk.net>, linux-btrfs@vger.kernel.org
References: <f15c0d2f-df61-17fc-667c-2b0eb5674be2@cobb.uk.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <7798d1f5-d54d-e756-973c-f2ebfa456315@gmx.com>
Date:   Thu, 2 Jan 2020 09:26:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <f15c0d2f-df61-17fc-667c-2b0eb5674be2@cobb.uk.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NeL4v11lbJGRaNKwFUMKnaC3yFbSbXl36"
X-Provags-ID: V03:K1:Lq1y1THy8kAXq7oAWewTSmu4ybyIOJ/zX9RC/AT7FjlkBgBlOzz
 i4G5Ff7A6yw0pyXenblHB3ndSxt/XG49snyfB9f+H9+M6bC42TNUHLrDq3o6JxRMAdX8T5U
 pUxvSv84rq4ahKZ6RY2ISDYWuctcPYWKGfcfwCOLe8X6UNW2epgNarCi1jyM5HD5WTU6XQu
 8v+9lkKoPaR7V7BJCeXAQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:z5+90QxaIJQ=:L7zzy9fYv0zaLCZIvKhuk1
 Pl8RrohtoM4X/oIxa8eiXwCeHIUcvqdBokmgjzI3If2UYpl73px51ZKY9qLPZiku7t0FBX4pB
 6wmL6c9+Hdoltaoc32ecZHjCatbxYazaWG11HTH/fj1ygBBIaEUxqFMiox+gI4nmIN7GftTgM
 Z0A5A5E83Mxi72nYfZbwm0+T14yqa9yJxlMbkhdYlHkLUADID/ak0QjiYCxKfXLcDaeQVU1fJ
 0Lr1o7bgFQG0YnK/KN5NRiC/x3Z5gyU2uYChkF8zQLpL6SMy+WnCi72V77B+rCcDItUcShbD3
 SZhcYjzrv6nDOXzuuWj0tS+I4p+5c4ZhlIZqDcuKUYGCFJ6UCKy4VBjcjbZv++nPyH4o0sG5F
 IRG4c1BYcrWqXVH/+vud2Pex8bScDM6KLIN5IxFliRKBuYTNmiC7AYW29KJTQrsii64g/d6fr
 u/FW7z6ciqnWNypp+OahrbEhAMTMiCLyzZovo8TnnWmhqnAOkIfCPKuEo+RVKhJHA/Z7Wk3dL
 hpnXezQgF3M2AXfTJ7xcqo5xwBdpEA8/tdSpw8V1e/QuDy+ZeiYsPKO70jKvcU8k6TqXI1Ul4
 5w92CD+sAJ3+arrNXamgRNpIKgiWENiCOraFw8tEaCoxG97vD4sZuekF/zH+twYNABG6uYyym
 F0QHO/I7iuMxVDkZZqFeQaNhK5hUl1Jax5avxOrvFJzZFjQitT8jWfutn+NjhLw+uOWScd4s3
 25lsU4S6MWY1/nz9OMWviy7jphl7sEUjXXRHG9D+AJmYYsVEqO+p6cytoB3BLkBZp9ElfgP/0
 zQGNZ3n9s0Kla2d+rqjUhrjI3SUxLueeH8CLq/yeHe9XjFONgo5zCmit7V8E7F+5tzjsyXKHj
 tcRCTF8foktd50J/2SFGL/RsGyWUcg/TxorEEANCsGpWWszjrDUVJrIWwKnjVv+d72qoOJ5d9
 umHCyiozrjOVctO/vcFRYglnAnRc+PKVLH6cf77Zpw/lOtxeyqrKmC6rT1wWfZnkCnQMq2JSQ
 NKmJu6yS2wPuz9u4m6zRjnJh6u02RktCwaj4lbK/pOlpVb+kpMI/Tl+xox7Isy3Go4bto5xsj
 TsSEcw2Bm9C5pXDucc494UyOKaMpKXLFUpQ5baC2qItXnanSCB/HOuW276GXSv0Q6yc8zmEz+
 7GEU+wX3rq4xTpFsZT0k95y5PnZ4BYwJYoGlazXnE8fF7In9JF3QNogC4qp8CS+fGsG3rPBsp
 2qkcHmtt8pmcFBf77R+J7A4EyJ048HeQTR/dblIL4J6AvVjAdI87GKfoo6fc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NeL4v11lbJGRaNKwFUMKnaC3yFbSbXl36
Content-Type: multipart/mixed; boundary="xP0u6K7D8PkNjLvjvHseXHcAnolfHTpqV"

--xP0u6K7D8PkNjLvjvHseXHcAnolfHTpqV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/2 =E4=B8=8A=E5=8D=887:35, Graham Cobb wrote:
> I have a problem on one BTRFS filesystem. It is not a critical
> filesystem (it is used for backups) and I have not yet tried even
> unmounting and remounting, let alone a "btrfs check".
>=20
> The problem seems to be that after several iterations of running 'btrfs=

> scrub' for 30 minutes, then pausing for a while, then resuming the
> scrub, I got a transaction aborted with an EFBIG error and a warning in=

> the kernel log. The fs went readonly, and transid verify errors are now=

> reported. The original log extract is available at
> http://www.cobb.uk.net/kern.log.bug-010120 but I have pasted the key
> part below.

EFBIG in btrfs is very rare, and can only be caused by too many system
chunks.

The most common reason is the chunk pre-alllocation for scrub, which
also matches your situation.

There is already a fix for it, and will land in v5.5 kernel.
It looks like we should backport it.

Thanks,
Qu


>=20
> The kernel is a Debian Testing kernel:
> Linux black 5.3.0-2-amd64 #1 SMP Debian 5.3.9-3 (2019-11-19) x86_64
> GNU/Linux
>=20
> I run this same script monthly, and I have not seen this problem before=
,
> so I cannot be certain it is caused by the scrub. I have not yet tried
> to reproduce it, or to investigate the filesystem (check, etc).
>=20
> Does anyone recognise this as a known/fixed problem? If not, is there
> any particular further information I could gather before or during my
> attempt to either recover the filesystem or just rebuild it?
>=20
> Here is the log (starting with the 7th resumed scrub):
>=20
>=20
> Jan  1 06:41:45 black kernel: [1930660.938782] BTRFS info (device sdc3)=
:
> scrub: started on devid 1
> Jan  1 06:41:45 black kernel: [1930660.939195] BTRFS info (device sdc3)=
:
> scrub: started on devid 4
> Jan  1 06:41:45 black kernel: [1930661.475557] ------------[ cut here
> ]------------
> Jan  1 06:41:45 black kernel: [1930661.475562] BTRFS: Transaction
> aborted (error -27)
> Jan  1 06:41:45 black kernel: [1930661.475667] WARNING: CPU: 0 PID:
> 771075 at fs/btrfs/extent-tree.c:8247 btrfs_create_pending_block_
> groups+0x1db/0x230 [btrfs]
> Jan  1 06:41:45 black kernel: [1930661.475669] Modules linked in: fuse
> nfsv3 rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache bnep nf_t
> ables snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> snd_seq_device cpufreq_userspace cpufreq_powersave cpufreq_cons
> ervative nfnetlink_queue nfnetlink_log nfnetlink bluetooth drbg
> ansi_cprng ecdh_generic ecc binfmt_misc hid_generic usbhid hid it87 h
> wmon_vid radeon edac_mce_amd kvm_amd eeepc_wmi ccp asus_wmi rng_core
> evdev sparse_keymap kvm snd_hda_codec_realtek rfkill irqbypass s
> nd_hda_codec_generic ttm video wmi_bmof ledtrig_audio pcspkr
> snd_hda_codec_hdmi drm_kms_helper fam15h_power k10temp snd_hda_intel sn=
d
> _hda_codec snd_hda_core snd_hwdep sp5100_tco drm snd_pcm_oss
> snd_mixer_oss watchdog snd_pcm snd_timer sg snd soundcore i2c_algo_bit =
b
> utton acpi_cpufreq eeprom i2c_nforce2 firewire_sbp2 firewire_core
> crc_itu_t psmouse nfsd parport_pc ppdev auth_rpcgss lp nfs_acl parp
> ort lockd grace sunrpc ip_tables x_tables autofs4 btrfs xor
> zstd_decompress zstd_compress raid6_pq libcrc32c
> Jan  1 06:41:45 black kernel: [1930661.475710]  ext4 crc16 mbcache jbd2=

> crc32c_generic sr_mod cdrom uas usb_storage sd_mod dm_crypt d
> m_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel
> ohci_pci aesni_intel ahci libahci xhci_pci aes_x86_64 xhci_hcd c
> rypto_simd libata ehci_pci ohci_hcd ehci_hcd cryptd glue_helper scsi_mo=
d
> usbcore r8169 i2c_piix4 realtek libphy usb_common wmi
> Jan  1 06:41:45 black kernel: [1930661.475737] CPU: 0 PID: 771075 Comm:=

> btrfs Not tainted 5.3.0-2-amd64 #1 Debian 5.3.9-3
> Jan  1 06:41:45 black kernel: [1930661.475739] Hardware name: To be
> filled by O.E.M. To be filled by O.E.M./M5A97, BIOS 0705 08/22/20
> 11
> Jan  1 06:41:45 black kernel: [1930661.475767] RIP:
> 0010:btrfs_create_pending_block_groups+0x1db/0x230 [btrfs]
> Jan  1 06:41:45 black kernel: [1930661.475770] Code: e9 26 ff ff ff 48
> 8b 45 50 f0 48 0f ba a8 38 17 00 00 02 72 17 41 83 fc fb 74 2d
>  44 89 e6 48 c7 c7 50 2e 7a c0 e8 23 9d 19 e3 <0f> 0b 44 89 e1 ba 37 20=

> 00 00 48 c7 c6 20 80 79 c0 48 89 ef e8 73
> Jan  1 06:41:45 black kernel: [1930661.475772] RSP:
> 0018:ffff9c69804cfb00 EFLAGS: 00010286
> Jan  1 06:41:45 black kernel: [1930661.475775] RAX: 0000000000000000
> RBX: ffff909444e7a520 RCX: 0000000000000006
> Jan  1 06:41:45 black kernel: [1930661.475777] RDX: 0000000000000007
> RSI: 0000000000000096 RDI: ffff90957aa17680
> Jan  1 06:41:45 black kernel: [1930661.475779] RBP: ffff90946c745d68
> R08: 0000000000010ec1 R09: 0000000000000007
> Jan  1 06:41:45 black kernel: [1930661.475781] R10: 0000000000000000
> R11: 0000000000000001 R12: 00000000ffffffe5
> Jan  1 06:41:45 black kernel: [1930661.475783] R13: ffff90946c745dc0
> R14: ffff909575d2e000 R15: ffff909574444000
> Jan  1 06:41:45 black kernel: [1930661.475786] FS:
> 00007ff2eb4c7700(0000) GS:ffff90957aa00000(0000) knlGS:0000000000000000=

> Jan  1 06:41:45 black kernel: [1930661.475788] CS:  0010 DS: 0000 ES:
> 0000 CR0: 0000000080050033
> Jan  1 06:41:45 black kernel: [1930661.475790] CR2: 00005634edab7008
> CR3: 00000000bd0f2000 CR4: 00000000000406f0
> Jan  1 06:41:45 black kernel: [1930661.475792] Call Trace:
> Jan  1 06:41:45 black kernel: [1930661.475826]
> __btrfs_end_transaction+0x3f/0x1b0 [btrfs]
> Jan  1 06:41:45 black kernel: [1930661.475855]
> btrfs_inc_block_group_ro+0x10e/0x150 [btrfs]
> Jan  1 06:41:45 black kernel: [1930661.475891]
> scrub_enumerate_chunks+0x162/0x560 [btrfs]
> Jan  1 06:41:45 black kernel: [1930661.475900]  ?
> remove_wait_queue+0x20/0x60
> Jan  1 06:41:45 black kernel: [1930661.475936]
> btrfs_scrub_dev+0x26b/0x590 [btrfs]
> Jan  1 06:41:45 black kernel: [1930661.475942]  ? _cond_resched+0x15/0x=
30
> Jan  1 06:41:45 black kernel: [1930661.475946]  ?
> __kmalloc_track_caller+0x16e/0x260
> Jan  1 06:41:45 black kernel: [1930661.475980]  ?
> btrfs_ioctl+0x82f/0x2e10 [btrfs]
> Jan  1 06:41:45 black kernel: [1930661.475984]  ?
> __check_object_size+0x136/0x147
> Jan  1 06:41:45 black kernel: [1930661.476019]  btrfs_ioctl+0x87a/0x2e1=
0
> [btrfs]
> Jan  1 06:41:45 black kernel: [1930661.476024]  ?
> tomoyo_path_number_perm+0x66/0x1d0
> Jan  1 06:41:45 black kernel: [1930661.476030]  ? do_vfs_ioctl+0x40e/0x=
670
> Jan  1 06:41:45 black kernel: [1930661.476033]  do_vfs_ioctl+0x40e/0x67=
0
> Jan  1 06:41:45 black kernel: [1930661.476036]  ?
> create_task_io_context+0x95/0x100
> Jan  1 06:41:45 black kernel: [1930661.476040]  ksys_ioctl+0x5e/0x90
> Jan  1 06:41:45 black kernel: [1930661.476044]  __x64_sys_ioctl+0x16/0x=
20
> Jan  1 06:41:45 black kernel: [1930661.476048]  do_syscall_64+0x53/0x14=
0
> Jan  1 06:41:45 black kernel: [1930661.476052]
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
> Jan  1 06:41:45 black kernel: [1930661.476055] RIP: 0033:0x7ff2eb5b95b7=

> Jan  1 06:41:45 black kernel: [1930661.476058] Code: 00 00 90 48 8b 05
> d9 78 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84=

> 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b
> 0d a9 78 0c 00 f7 d8 64 89 01 48
> Jan  1 06:41:45 black kernel: [1930661.476061] RSP:
> 002b:00007ff2eb4c6d38 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> Jan  1 06:41:45 black kernel: [1930661.476064] RAX: ffffffffffffffda
> RBX: 000055eeaf2e94b0 RCX: 00007ff2eb5b95b7
> Jan  1 06:41:45 black kernel: [1930661.476066] RDX: 000055eeaf2e94b0
> RSI: 00000000c400941b RDI: 0000000000000003
> Jan  1 06:41:45 black kernel: [1930661.476067] RBP: 0000000000000000
> R08: 00007ff2eb4c7700 R09: 0000000000000000
> Jan  1 06:41:45 black kernel: [1930661.476069] R10: 00007ff2eb4c7700
> R11: 0000000000000246 R12: 00007ffc4cfa511e
> Jan  1 06:41:45 black kernel: [1930661.476071] R13: 00007ffc4cfa511f
> R14: 00007ff2eb4c7700 R15: 00007ff2eb4c6e40
> Jan  1 06:41:45 black kernel: [1930661.476075] ---[ end trace
> 6429c1bf293fecb8 ]---
> Jan  1 06:41:45 black kernel: [1930661.476079] BTRFS: error (device
> sdc3) in btrfs_create_pending_block_groups:8247: errno=3D-27 unknown
> Jan  1 06:41:45 black kernel: [1930661.476082] BTRFS info (device sdc3)=
:
> forced readonly
> Jan  1 06:41:45 black kernel: [1930661.489816] BTRFS warning (device
> sdc3): failed setting block group ro: -30
> Jan  1 06:41:45 black kernel: [1930661.489821] BTRFS info (device sdc3)=
:
> scrub: not finished on devid 1 with status: -30
> Jan  1 06:41:52 black kernel: [1930668.052295] BTRFS warning (device
> sdc3): failed setting block group ro: -30
> Jan  1 06:41:52 black kernel: [1930668.052301] BTRFS info (device sdc3)=
:
> scrub: not finished on devid 4 with status: -30
> Jan  1 06:51:56 black kernel: [1931271.801468] BTRFS error (device
> sdc3): parent transid verify failed on 16216583520256 wanted 301800
> found 301756
> Jan  1 06:51:56 black kernel: [1931271.822215] BTRFS error (device
> sdc3): parent transid verify failed on 16216583520256 wanted 301800
> found 301756
> Jan  1 06:51:57 black kernel: [1931273.492798] BTRFS error (device
> sdc3): parent transid verify failed on 16216583520256 wanted 301800
> found 301756
> Jan  1 06:51:57 black kernel: [1931273.493041] BTRFS error (device
> sdc3): parent transid verify failed on 16216583520256 wanted 301800
> found 301756
>=20


--xP0u6K7D8PkNjLvjvHseXHcAnolfHTpqV--

--NeL4v11lbJGRaNKwFUMKnaC3yFbSbXl36
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4NRtoXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qhewQgAn8Lf371zstd5hQvWZ2+edE3G
tlak6ofXAf0xWqs0k5hmwEoo90JCq0Q5aevML5CQXke6RdHoxtuyh2d7rVDrE2vx
AKwEC4Pww69Ybeabbdaq9fP7JvYKRciqW+AeBs+M8EyAsWgtAXM0JFdjiJuVm+AF
Neb4ORzNbcDpEpDAERcQ3DpUof66Pe2sJCcDOnGfa6vvh57/3nnhjxs7G4VqWqBK
+sKoSv4NRdehnBYHk67nYpCYlc0Vf2INIaFiU2nNq4vm29+haUWqbyvQQ7+OvmkT
JW4TgsN3NL2zDvXZzb4RbaeTdqskThgW4XeSAupPYuPAf2gMMeuD3Ec2GgwHPw==
=Cxyv
-----END PGP SIGNATURE-----

--NeL4v11lbJGRaNKwFUMKnaC3yFbSbXl36--
