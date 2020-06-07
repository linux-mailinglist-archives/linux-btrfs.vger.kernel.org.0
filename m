Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A151F0A5B
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jun 2020 09:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgFGHfq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Jun 2020 03:35:46 -0400
Received: from mout.gmx.net ([212.227.15.19]:54177 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgFGHfp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 7 Jun 2020 03:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591515341;
        bh=/+SnWHr5RLS2A4NQ/o5I5LfCC2r7Z40IXQoe3rRyPpw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=R9zEuIgEiuspCMRm9md/s4abOJ1RoRkxpYnU28v89lTc7BWioGwnNIoGBLkXSfG4v
         dsyT+iPv0So4j9J70MTXQZ8iBStQ19CRqER9WZB+DOfB3EVT/KrUaAyLUAeZgq50RB
         iHZ4Esp53mUj4a1iqt1djqhwOZg+qy72kXgjHsOk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MpDJd-1jARNM3DF1-00qiQU; Sun, 07
 Jun 2020 09:35:40 +0200
Subject: Re: balance + ENOFS -> readonly filesystem
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-btrfs@vger.kernel.org
References: <20200607051217.GE12913@qmqm.qmqm.pl>
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
Message-ID: <88e8b58e-9a4c-1f3e-4b08-8a56de191dd4@gmx.com>
Date:   Sun, 7 Jun 2020 15:35:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200607051217.GE12913@qmqm.qmqm.pl>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LPLcCR7kcczQd5GOUwF8G1SeGT4sHV8N7"
X-Provags-ID: V03:K1:cJW+tEpUvbA8yWy3vu6H0wDe3EYuFHXo7tkMtzfpiwp7DHRcysc
 llC88JQoiIqKnUssefoD80k9uYrhj1xJ6E1kT2AlszjNdIX4+4YHbvtAmiP+C1GE3S2aVZV
 9OKTmhH1fWkv3PNGr+YeAqpPwSLOx+KlGZtSGaNDtflAyYdrYA/HmJkziDZ0361bsRqzrGZ
 CkLg1jnQUyaoFIPUwT31w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tu3iZDgvwnw=:3tG7LuvdSKpoi/qjovakNu
 YCkMANJwgB8r9VgVazmUqruq36D9WNPz78pi4zwrlH9pH1Zg8ezYbXV8wxE6pvmY6lEj7bFiz
 UGccRbgW0dX2EJx1eCAMqKXuZyQGvTe8zQJxfk2Di8D24v534MqQAWUaGaBiq9kzU8ngfD82j
 1bOnYe2Fr6xBm2vf1MwS9LP4xjgPz0UcNnwPS2vVE5RVYC8eQrie/e20PdRBQzXPZbB/wSsaV
 Wb8JAwVcTg1vG/8Av1K+hXwv7cLya2fpn0FFRLGNciVsnHJfDHSjuPQOlLcU1NnJU8uWPdMoZ
 Tk9eVfEmT6WUvm2Lr8XhTfZZuzraULuwFUp26aPbo31y7E55sQ3CLKrPbZu+XsXuh4HRq65Xw
 +371qTn4Cvc+Oj+x1aHxq3Z669AHd/B2rtKN+HgvjSykAYD+wGuqC8DelehkDqE+aGwzyIwsa
 18ClfrbgDofZAeX9HVZ+fVYC4h1k8K/OHPZ3AjUl8Urh6R1eqH41JKlFD/LWOo2RNP5Agh5NN
 6dQkb1ctHHji6h2B+TLYxOQ+o5dKieYgOM5WIvjyeCYuIAb4xtjIJCyPxyJh514/C5WtdDYkm
 N0hwGD8rRZbapYjD+8dSy1ZO0JFidKZ3zqqG2akq+rl0iCg5ksBYa0jptPdf6h6QBsAEC9ucW
 ghAh9FZfKPSn4CUxtnOzcs6Ai92k3niw28TPefVlEQYcROZb3uPTWLaDCuPNVF1/qd9lvwhxy
 tALZ348KT8E4Z9CBDZJLL0+uAWpkzwrBTwaKmFGQiPAk428DrwOwgpgTEZIwYavwHNCBFwxO6
 rPALfSA7wWZWhi9tkhyejT58wiWXVZPnh2Qq3qz5sIeUKQiqdO/FgfjhoNXkE+RgQvwFpPkr/
 oZh86yRXEloswLHMgsAkVSxkFNLTAvo6ViavQQ7BsdmBq8Y3PeCRKBGCDP1qDfReiU8dnHVLg
 b9r+cI+i2OPUDIGeXBkWjewvcDoqCqlRt5LYRJgmPil+ZU//sEblMRnTWAON9x9ICK9ZVxay1
 FOphg0MkNEnBHJ+2z3T6xdJ0G9sygCGjegIkIpTY7ZQ+IcYYdM3nFIdBg1hAHUINoLQM7REQe
 WCn6MA5E+TtRbyRyV39QQgLORp2Kp+SHMfxiZNtJvPbw34uCD3sJK2zrnVJQHAntEgnuxEk/S
 wyGpYlpsxlhCmCADn09LTBwuWFhhqrRp8lyJJFe8O60bvv8wKbfB8boiTAjodGbYUIeq/ZXCS
 URI2OV/G8I17FmW3o
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LPLcCR7kcczQd5GOUwF8G1SeGT4sHV8N7
Content-Type: multipart/mixed; boundary="7gOhekEOniMxfZtAARUQid8aM2ix3Obda"

--7gOhekEOniMxfZtAARUQid8aM2ix3Obda
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/7 =E4=B8=8B=E5=8D=881:12, Micha=C5=82 Miros=C5=82aw wrote:
> Dear btrfs developers,
>=20
> I just added a new disk to already almost full filesystem and tried to
> enable raid1 for metadata (transcript below).

May I ask for your per-disk usage?

There is a known bug (but rare to hit) that completely unbalance disk
usage can lead to unexpected ENOSPC (-28) error at certain critical code
and cause the transaction abort you're hitting.

If you have added a new disk to an almost full one, then I guess that
would be the case...

> The operation failed and
> left the filesystem in readonly state. Is this expected?

Definitely not.

If your disk layout fits my assumption, then the following patchset is
worth trying:
https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D297005

Thanks,
Qu

>=20
> Best Regards,
> Micha=C5=82 Miros=C5=82aw
>=20
> [on linux v5.6.15]
>=20
> # btrfs balance start -mconvert=3Draid1 -v .
> Dumping filters: flags 0x6, state 0x0, force is off
>   METADATA (flags 0x100): converting, target=3D16, soft is off
>   SYSTEM (flags 0x100): converting, target=3D16, soft is off
> ERROR: error during balancing '.': Read-only file system
> There may be more info in syslog - try dmesg | tail
>=20
> [dmesg: see below, first WARN]
>=20
> # umount ...
> # btrfs check /dev/mapper/btrfs1
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/jb1_crypt
> UUID: 01234567-abcd-0123-abcd-012345678901
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 994491097088 bytes used, no error found
> total csum bytes: 969796120
> total tree bytes: 1176272896
> total fs tree bytes: 134135808
> total extent tree bytes: 19972096
> btree space waste bytes: 59492903
> file data blocks allocated: 993314824192
>  referenced 993314824192
>=20
> # mount ...
> # btrfs balance start -mconvert=3Draid1 -v .
> Dumping filters: flags 0x6, state 0x0, force is off
>   METADATA (flags 0x100): converting, target=3D16, soft is off
>   SYSTEM (flags 0x100): converting, target=3D16, soft is off
> ERROR: error during balancing '.': Read-only file system
> There may be more info in syslog - try dmesg | tail
>=20
> [dmesg: second WARN, same as before]
>=20
>=20
> -----> first <-----
>=20
> [ 8532.719868] BTRFS info (device dm-5): disk added /dev/mapper/btrfs2
> [ 8532.726483] BTRFS info (device dm-5): device fsid 01234567-abcd-0123=
-abcd-012345678901 devid 2 moved old:/dev/mapper/btrfs2 new:/dev/dm-9
> [ 8532.726952] BTRFS info (device dm-5): device fsid 01234567-abcd-0123=
-abcd-012345678901 devid 2 moved old:/dev/dm-9 new:/dev/mapper/btrfs2
> [ 8909.439222] BTRFS info (device dm-5): balance: start -mconvert=3Drai=
d1 -sconvert=3Draid1
> [ 8909.589730] BTRFS info (device dm-5): relocating block group 9341857=
95584 flags metadata|dup
> [ 8910.080664] ------------[ cut here ]------------
> [ 8910.080669] BTRFS: Transaction aborted (error -28)
> [ 8910.080707] WARNING: CPU: 1 PID: 3067 at fs/btrfs/extent-tree.c:2210=
 btrfs_run_delayed_refs+0x18b/0x1e0 [btrfs]
> [ 8910.080708] Modules linked in: uas usb_storage rfcomm fuse cpufreq_p=
owersave cpufreq_userspace cpufreq_conservative nfc nf_conntrack_netlink =
overlay xfrm_user xfrm4_tunnel tunnel4 ipcomp xfrm_ipcomp esp4 ah4 af_key=
 xfrm_algo cmac vboxnetadp(O) vboxnetflt(O) bridge stp llc bnep vboxdrv(O=
) binfmt_misc dm_cache_smq dm_cache dm_persistent_data dm_bio_prison dm_b=
ufio usblp xfs btrfs blake2b_generic zstd_compress ftdi_sio usbserial joy=
dev squashfs zstd_decompress btusb btrtl btbcm btintel bluetooth ecdh_gen=
eric ecc wmi_bmof mxm_wmi kvm_intel kvm irqbypass ghash_clmulni_intel pcs=
pkr i2c_i801 snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hd=
mi iTCO_wdt sg snd_emu10k1 snd_util_mem snd_ac97_codec ac97_bus emu10k1_g=
p snd_rawmidi gameport snd_hda_intel snd_seq_device snd_intel_dspcfg snd_=
hda_codec snd_hda_core xhci_pci snd_hwdep xhci_hcd snd_pcm_oss snd_mixer_=
oss snd_pcm snd_timer snd soundcore nvidia_drm(O) nft_masq wmi drm_kms_he=
lper cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt
> [ 8910.080731]  fb_sys_fops cfbcopyarea fb font fbdev drm drm_panel_ori=
entation_quirks nvidia_modeset(O) nft_redir nvidia(O) i2c_core nf_tables_=
set nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_c=
ounter nf_tables nfnetlink nfsd auth_rpcgss nfs_acl lockd grace sunrpc lo=
op firewire_sbp2 firewire_core crc_itu_t ecryptfs autofs4 input_leds raid=
10 raid456 libcrc32c async_raid6_recov async_memcpy async_pq raid6_pq asy=
nc_xor xor async_tx raid0 multipath linear e1000e video backlight
> [ 8910.080747] CPU: 1 PID: 3067 Comm: btrfs Tainted: G           O     =
 5.6.15mq+ #376
> [ 8910.080748] Hardware name: System manufacturer System Product Name/P=
8Z68-V PRO, BIOS 3603 11/09/2012
> [ 8910.080759] RIP: 0010:btrfs_run_delayed_refs+0x18b/0x1e0 [btrfs]
> [ 8910.080761] Code: 41 5f c3 49 8b 54 24 50 f0 48 0f ba aa 90 1b 00 00=
 02 72 1b 83 f8 fb 74 34 89 c6 48 c7 c7 50 26 f0 a1 89 04 24 e8 90 0a 27 =
df <0f> 0b 8b 04 24 89 c1 ba a2 08 00 00 4c 89 e7 89 04 24 48 c7 c6 a0
> [ 8910.080763] RSP: 0018:ffffc90008e27ab8 EFLAGS: 00010286
> [ 8910.080764] RAX: 0000000000000000 RBX: ffff8882325361a0 RCX: 0000000=
000000001
> [ 8910.080765] RDX: 0000000080000001 RSI: ffffffff8112da21 RDI: 0000000=
0ffffffff
> [ 8910.080766] RBP: ffff8883f531c000 R08: 0000000000000000 R09: 0000000=
000000001
> [ 8910.080767] R10: 0000000000000000 R11: ffffc90008e27965 R12: ffff888=
2325361a0
> [ 8910.080768] R13: ffff888364331800 R14: ffff8882325361a0 R15: 0000000=
000001dc4
> [ 8910.080770] FS:  00007f93605b18c0(0000) GS:ffff88840ec40000(0000) kn=
lGS:0000000000000000
> [ 8910.080771] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 8910.080772] CR2: 00000000014ba2c8 CR3: 0000000260d86001 CR4: 0000000=
0000606e0
> [ 8910.080773] Call Trace:
> [ 8910.080790]  btrfs_commit_transaction+0x52/0xa40 [btrfs]
> [ 8910.080803]  ? start_transaction+0xcb/0x550 [btrfs]
> [ 8910.080819]  relocate_block_group+0x4d1/0x5c0 [btrfs]
> [ 8910.080838]  btrfs_relocate_block_group+0x194/0x310 [btrfs]
> [ 8910.080854]  btrfs_relocate_chunk+0x31/0xe0 [btrfs]
> [ 8910.080869]  btrfs_balance+0x899/0xf70 [btrfs]
> [ 8910.080889]  btrfs_ioctl_balance+0x2d4/0x390 [btrfs]
> [ 8910.080905]  btrfs_ioctl+0x1652/0x31d0 [btrfs]
> [ 8910.080909]  ? _raw_spin_unlock+0x24/0x40
> [ 8910.080911]  ? __handle_mm_fault+0xb8d/0x1210
> [ 8910.080918]  ? ksys_ioctl+0x81/0xc0
> [ 8910.080933]  ? btrfs_ioctl_get_supported_features+0x20/0x20 [btrfs]
> [ 8910.080935]  ksys_ioctl+0x81/0xc0
> [ 8910.080937]  __x64_sys_ioctl+0x11/0x20
> [ 8910.080939]  do_syscall_64+0x4f/0x210
> [ 8910.080941]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [ 8910.080943] RIP: 0033:0x7f93606a8427
> [ 8910.080945] Code: 00 00 90 48 8b 05 69 7a 0c 00 64 c7 00 26 00 00 00=
 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f =
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 7a 0c 00 f7 d8 64 89 01 48
> [ 8910.080946] RSP: 002b:00007ffe33acfc58 EFLAGS: 00000202 ORIG_RAX: 00=
00000000000010
> [ 8910.080947] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f9=
3606a8427
> [ 8910.080949] RDX: 00007ffe33acfce8 RSI: 00000000c4009420 RDI: 0000000=
000000003
> [ 8910.080950] RBP: 00007ffe33acfce8 R08: 0000564d2be846b0 R09: 0000000=
000000231
> [ 8910.080951] R10: fffffffffffffa4c R11: 0000000000000202 R12: 0000000=
000000003
> [ 8910.080952] R13: 00007ffe33ad2746 R14: 0000000000000001 R15: 0000000=
000000001
> [ 8910.080957] irq event stamp: 0
> [ 8910.080958] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [ 8910.080961] hardirqs last disabled at (0): [<ffffffff810aff62>] copy=
_process+0xa22/0x1da0
> [ 8910.080963] softirqs last  enabled at (0): [<ffffffff810aff62>] copy=
_process+0xa22/0x1da0
> [ 8910.080964] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [ 8910.080965] ---[ end trace 0d99142474b285f7 ]---
> [ 8910.080968] BTRFS: error (device dm-5) in btrfs_run_delayed_refs:221=
0: errno=3D-28 No space left
> [ 8910.080969] BTRFS info (device dm-5): forced readonly
> [ 8910.081553] BTRFS info (device dm-5): 1 enospc errors during balance=

> [ 8910.081554] BTRFS info (device dm-5): balance: ended with status: -3=
0
>=20
> -----> second <-----
>=20
> [ 9144.739758] BTRFS info (device dm-5): disk space caching is enabled
> [ 9144.739761] BTRFS info (device dm-5): has skinny extents
> [ 9146.898605] BTRFS info (device dm-5): checking UUID tree
> [ 9147.072175] BTRFS info (device dm-5): balance: resume -mconvert=3Dra=
id1,soft -sconvert=3Draid1,soft
> [ 9147.092146] BTRFS info (device dm-5): relocating block group 9341857=
95584 flags metadata|dup
> [ 9147.993117] ------------[ cut here ]------------
> [ 9147.993121] BTRFS: Transaction aborted (error -28)
> [ 9147.993158] WARNING: CPU: 1 PID: 8924 at fs/btrfs/extent-tree.c:3106=
 __btrfs_free_extent.isra.47+0x5a9/0x940 [btrfs]
> [ 9147.993159] Modules linked in: uas usb_storage rfcomm fuse cpufreq_p=
owersave cpufreq_userspace cpufreq_conservative nfc nf_conntrack_netlink =
overlay xfrm_user xfrm4_tunnel tunnel4 ipcomp xfrm_ipcomp esp4 ah4 af_key=
 xfrm_algo cmac vboxnetadp(O) vboxnetflt(O) bridge stp llc bnep vboxdrv(O=
) binfmt_misc dm_cache_smq dm_cache dm_persistent_data dm_bio_prison dm_b=
ufio usblp xfs btrfs blake2b_generic zstd_compress ftdi_sio usbserial joy=
dev squashfs zstd_decompress btusb btrtl btbcm btintel bluetooth ecdh_gen=
eric ecc wmi_bmof mxm_wmi kvm_intel kvm irqbypass ghash_clmulni_intel pcs=
pkr i2c_i801 snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hd=
mi iTCO_wdt sg snd_emu10k1 snd_util_mem snd_ac97_codec ac97_bus emu10k1_g=
p snd_rawmidi gameport snd_hda_intel snd_seq_device snd_intel_dspcfg snd_=
hda_codec snd_hda_core xhci_pci snd_hwdep xhci_hcd snd_pcm_oss snd_mixer_=
oss snd_pcm snd_timer snd soundcore nvidia_drm(O) nft_masq wmi drm_kms_he=
lper cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt
> [ 9147.993183]  fb_sys_fops cfbcopyarea fb font fbdev drm drm_panel_ori=
entation_quirks nvidia_modeset(O) nft_redir nvidia(O) i2c_core nf_tables_=
set nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_c=
ounter nf_tables nfnetlink nfsd auth_rpcgss nfs_acl lockd grace sunrpc lo=
op firewire_sbp2 firewire_core crc_itu_t ecryptfs autofs4 input_leds raid=
10 raid456 libcrc32c async_raid6_recov async_memcpy async_pq raid6_pq asy=
nc_xor xor async_tx raid0 multipath linear e1000e video backlight
> [ 9147.993199] CPU: 1 PID: 8924 Comm: btrfs-balance Tainted: G        W=
  O      5.6.15mq+ #376
> [ 9147.993200] Hardware name: System manufacturer System Product Name/P=
8Z68-V PRO, BIOS 3603 11/09/2012
> [ 9147.993211] RIP: 0010:__btrfs_free_extent.isra.47+0x5a9/0x940 [btrfs=
]
> [ 9147.993213] Code: 3c 24 44 89 e9 ba 55 0c 00 00 48 c7 c6 20 a1 ef a1=
 e8 09 c3 0a 00 e9 23 ff ff ff 44 89 ee 48 c7 c7 50 26 f0 a1 e8 b2 29 27 =
df <0f> 0b 48 8b 3c 24 44 89 e9 ba 22 0c 00 00 48 c7 c6 20 a1 ef a1 e8
> [ 9147.993214] RSP: 0018:ffffc9000a2cfa80 EFLAGS: 00010282
> [ 9147.993216] RAX: 0000000000000000 RBX: ffff8882ec2bc540 RCX: 0000000=
000000001
> [ 9147.993217] RDX: 0000000080000001 RSI: ffffffff8112da21 RDI: 0000000=
0ffffffff
> [ 9147.993218] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000=
000000001
> [ 9147.993219] R10: 0000000000000000 R11: ffffc9000a2cf92d R12: 0000000=
00e5b8000
> [ 9147.993220] R13: 00000000ffffffe4 R14: 0000000000000000 R15: 0000000=
000000007
> [ 9147.993222] FS:  0000000000000000(0000) GS:ffff88840ec40000(0000) kn=
lGS:0000000000000000
> [ 9147.993223] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 9147.993224] CR2: 000056196ee73230 CR3: 00000003a5056005 CR4: 0000000=
0000606e0
> [ 9147.993225] Call Trace:
> [ 9147.993233]  ? _raw_read_unlock+0x24/0x40
> [ 9147.993248]  ? btrfs_merge_delayed_refs+0x3b3/0x460 [btrfs]
> [ 9147.993260]  __btrfs_run_delayed_refs+0x7a0/0x1310 [btrfs]
> [ 9147.993277]  btrfs_run_delayed_refs+0x5b/0x1e0 [btrfs]
> [ 9147.993290]  btrfs_commit_transaction+0x52/0xa40 [btrfs]
> [ 9147.993303]  ? start_transaction+0xcb/0x550 [btrfs]
> [ 9147.993319]  relocate_block_group+0x4d1/0x5c0 [btrfs]
> [ 9147.993337]  btrfs_relocate_block_group+0x194/0x310 [btrfs]
> [ 9147.993353]  btrfs_relocate_chunk+0x31/0xe0 [btrfs]
> [ 9147.993368]  btrfs_balance+0x899/0xf70 [btrfs]
> [ 9147.993388]  ? btrfs_balance+0xf70/0xf70 [btrfs]
> [ 9147.993402]  balance_kthread+0x31/0x50 [btrfs]
> [ 9147.993405]  kthread+0x10e/0x130
> [ 9147.993406]  ? kthread_park+0x80/0x80
> [ 9147.993409]  ret_from_fork+0x3a/0x50
> [ 9147.993414] irq event stamp: 0
> [ 9147.993415] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [ 9147.993418] hardirqs last disabled at (0): [<ffffffff810aff62>] copy=
_process+0xa22/0x1da0
> [ 9147.993420] softirqs last  enabled at (0): [<ffffffff810aff62>] copy=
_process+0xa22/0x1da0
> [ 9147.993421] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [ 9147.993422] ---[ end trace 0d99142474b285f8 ]---
> [ 9147.993424] BTRFS: error (device dm-5) in __btrfs_free_extent:3106: =
errno=3D-28 No space left
> [ 9147.993426] BTRFS info (device dm-5): forced readonly
> [ 9147.993429] BTRFS: error (device dm-5) in btrfs_run_delayed_refs:221=
0: errno=3D-28 No space left
> [ 9147.994013] BTRFS info (device dm-5): 1 enospc errors during balance=

> [ 9147.994015] BTRFS info (device dm-5): balance: ended with status: -3=
0
>=20


--7gOhekEOniMxfZtAARUQid8aM2ix3Obda--

--LPLcCR7kcczQd5GOUwF8G1SeGT4sHV8N7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7cmMgACgkQwj2R86El
/qjhYQgAmNzWycmLPlIqtsjaGn3+3pC7IvNncJk7YsNkuDMpN+13cuLewv9Oq1aO
9UggIR+ZhnRerXA/zQGWhvsiWqFXWaa6gFWdV6Q/QH2q45wUvbjZ/wwpHoKEhlvC
S8rFp0A3L7NrAamepzqZa2X29XTwyDczLlb6ODtZUqWqK/Qlf9OKu+uVCaYF4S08
xeII18UeUm924bWN3m7Nx1kgscLX2A0MvVXsL/y3p3ob/u+II6MX04plOk1hY8Ko
aMYI0IRZJ2tlfJrXsKJCTQXcqdDamPqMvrI6oGZ/0/VdFaAjpkGpk5SfOuWW5EgA
qnbIyxnwNPa/eZOoPWWvr6t9bJTr7Q==
=z/I1
-----END PGP SIGNATURE-----

--LPLcCR7kcczQd5GOUwF8G1SeGT4sHV8N7--
