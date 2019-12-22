Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4695128D55
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Dec 2019 11:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfLVKNS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Dec 2019 05:13:18 -0500
Received: from mout.gmx.net ([212.227.17.21]:57043 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfLVKNR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Dec 2019 05:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577009592;
        bh=RCWDGN61rvOU1Yfxl7Ufxd7UezSO8/V3ndsBQYLAX/U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=iV9+8vQdIfyrqrUgs1dEARSIENY8pIYqvyV2NTDCSc4y+9SRP+THncR7Ax/I4fk8j
         EGTuA01kF5xW8wUSc7FoP737pQLivTrKb7r3rzdZaZznljCrqAT/UnATlcOECm7wUe
         K9fiaiLyvAC8eucgrpMY94SmeJH1TXHOrNiZIeGs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MrhUK-1hvfN52rWm-00ni5r; Sun, 22
 Dec 2019 11:13:12 +0100
Subject: Re: read time block corruption on root partition, Not booting
To:     jollemeyer@gmx.de
Cc:     linux-btrfs@vger.kernel.org
References: <af9d16c9-2bf5-46fa-a146-84c4f8f6cc31.maildroid@localhost>
 <a29a69bd-d3f3-44d2-af62-bb0b7a364ba5.maildroid@localhost>
 <249711d9-5cbc-b56c-2226-33a9d42af521@gmx.com>
 <3512999.4HXIEJrTBV@bukephalos>
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
Message-ID: <993a1765-6825-bccc-c645-1a89985b5113@gmx.com>
Date:   Sun, 22 Dec 2019 18:13:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <3512999.4HXIEJrTBV@bukephalos>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZkgDJjnNJ72WQYiT8tO1FGhOSDdIfutYC"
X-Provags-ID: V03:K1:t8nMchWpU1t/Ip0pguXc9+Zz8N5SGjm99mejLQEjF1JMFL7QxiR
 f9tBvuwKUIqCPyaKyq8N16nishhL8KJBD0wpSH5JMqezNQW3JXXaFlM7StLyfFPvql9l29j
 iAGOo509r2UIycP+I98JZScbKi8GlBSAEi8jX3+KBQ3a6K3/UNJu9nqKzhzpaiAKIUGfuA8
 GFGCQ40Mg8Ajx29pUuuZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:F0TUSwjBGOM=:QXOHfGS5ljWD/XAPRfl7fd
 aJaXVSszK6zqpWS+uQ+C2pu2EGrqqVjPv6b1w08EmTS+qsmiHkSxGGrvrQscQJpRPwdhUiLsm
 i78E4+RainEdc5ikLiWFLR86lcPaXPbe4gIzJ0xVj3L0uFIohCL5vh1xc30ez9nMK96uIn5/b
 XdKE7AFp+4FH8pSldOuK7SU3hCzngbO3UfJLyi7boCfaaC9ryLax+shzRQrhXW0+Ksq4/FEOl
 GP/YEMfTn9aus/tVDU5JYqxg6ub27MRIKsEA9dlMsAv0jEvlSH4tkHeYWt4ayeeA00ZqUuGY7
 AiZrOkPG1WpbLq3s8POOIf8rofU0GhGrbhlqn9tzKuaJbGYMyf95d4Cj/nYWFnre9vPO6x+zD
 wu3ONHSxrvF01gksw6XWeeOrIBhMEZhe1IihnAvJ5UzEpmt9Xg5Coc3VLenqmwa0gVxJ+g1Fg
 hzSvAuGFrY0nv9lAvQ8XFrjS51A3jinx27GnEolSnKXTI+j4f/y8mlSV7YxdG58uojbhL964t
 XUsiDJv9NBphcQi72VN+NkOAEFMSQgdgzBtRGlJimCtDqflqvBp4FKJb0+sQjP/iIxt5ydg3C
 wMUVNpN5OvGLdRRZKPndCElScoG8+keNIbX0ji4vNr7CwOu7w2+Naa93P6YdO8rcADGSqoJOV
 ZtrHG3ZAYN9F9K9rnZ/APWbwrMMh0hj6ha5OoIuL9+tacXi4/n44sMS3ZKTyh0lMhf4dUvi57
 rlFek4slMOW6eMdMiKlwEn+9hjtO4C0Ym3GBeIlL7pEnmM7tPprx+1oYaAI9TcG8KtDh4UdiX
 xHbbeBlrpRXqR6hLwVlG9h3CCYQHXhkU/ujWTn9Q43dgX0MEnBTOkm2sL8dAspYTw8eNIDu71
 48NRR07P4decehJtoM+HdowcixV3ifL/7kNxjLboF6VTwa/MclC+LFRC1DhtLNmS5Y1Sy5xIs
 vza7qQFLXBLweLCfDavAelu6iwjH4uJgydzdcqdOeJHhkoezOHAFnn7AbbGKvldw78IRGg8g5
 KFWCCHlKojtmRWoMq4A2M6XhHcP2qFBZl5jrSKfqftohveWQwgo8Pvp7kgJZK9KVM8BckChSB
 ZhWV2eoIDqlhNtDqWedktN6WYaZVkEH09Z1TEwYCDrr6cgBtgGZUhmf2j1GgEcE7/+abSmd16
 dvnzJ5Oa9ffGRQEoa8RftXT31hS3Scb/7rrRlCFdlqOUNGn4DtO5JNedZK6Z6uX+8zf5roc0N
 4hI2DCIYqKWXrNCTw8qxX7K3Aj56yMPDWcx/vx+70e1dGPLexw47Ydnv9MKU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZkgDJjnNJ72WQYiT8tO1FGhOSDdIfutYC
Content-Type: multipart/mixed; boundary="qQXtXQxzrtL3y0P4Mj54841ecEMeTP9VQ"

--qQXtXQxzrtL3y0P4Mj54841ecEMeTP9VQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/22 =E4=B8=8B=E5=8D=886:03, jollemeyer@gmx.de wrote:
> Dear Qu,
>=20
> I had a typo in my previous "btrfs dump tree" command (/dev/sda1 instea=
d of /
> dev/sda). Now I got the output below:

No wonder.

>=20
> btrfs-progs v5.4=20
> leaf 2089035464704 items 145 free space 4973 generation 75450 owner=20
> EXTENT_TREE
> leaf 2089035464704 flags 0x1(WRITTEN) backref revision 1
> fs uuid 014bdf0a-bcb3-4a7c-b58d-c1fc17281f7e
> chunk uuid d4aae6e9-9832-4da5-a269-0a46e54a4e33
[...]
> 	item 85 key (1937096425472 EXTENT_ITEM 4096) itemoff 11725 itemsize=20
> 53
> 		refs 1 gen 41267 flags DATA
> 		extent data backref root FS_TREE objectid 17045 offset=20
> 212492288 count 1048577

I can't be more proud of the tree-checker, it's always right to catch
memory bit flip.

That extent item has only 1 ref ("refs 1"), but its inlined data ref has
a count of 1048577.

Note that 1048577, it's 0x100001.

It's almost 100% sure it's a bit flip in your memory. A full memtest run
is highly recommended.
Since the extra check is only introduced in v5.4, btrfs didn't detect it
earlier.

If could craft a dirty hack to fix your problem, but it may need some
time (several hours), and you need to compile btrfs-progs.
(The safest way)

Or you can try btrfs check --repair, the possibility to screw up the fs
should be pretty low.
(The fastest way)

Thanks,
Qu
>=20
>=20
> The full output of "btrfs check --readonly /dev/sda" command is as belo=
w:
>=20
> [1/7] checking root items
> [2/7] checking extents
> incorrect local backref count on 1937096425472 root 5 owner 17045 offse=
t=20
> 212492288 found 1 wanted 1048577 back 0x55f258caa470
> backpointer mismatch on [1937096425472 4096]
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> Opening filesystem to check...
> Checking filesystem on /dev/sda
> UUID: 014bdf0a-bcb3-4a7c-b58d-c1fc17281f7e
> found 1386975199232 bytes used, error(s) found
> total csum bytes: 1352697008
> total tree bytes: 1508327424
> total fs tree bytes: 61161472
> total extent tree bytes: 37421056
> btree space waste bytes: 55303865
> file data blocks allocated: 1388605296640
>  referenced 1385670742016
>=20
>=20
> I did "btrfs rescue zero-log /dev/sda" but that did not change the outp=
ut of=20
> "btrfs check" performed afterwards.
>=20
> regards,
>=20
> J=C3=B6rg
>=20
> Am Sonntag, 22. Dezember 2019, 01:59:16 CET schrieben Sie:
>> On 2019/12/21 =E4=B8=8B=E5=8D=8810:55, jollemeyer@gmx.de wrote:
>>> Dear Qu,
>>>
>>> the output is as follows:
>>> #btrfs ins dump-tree - b 2089035464704 /dev/sda1
>>> btrfs-progs v5.4
>>> No mapping for 2089035464704 - 2089035481088
>>> Couldn't map the block 2089035464704
>>> Couldn't map the block 2089035464704
>>> Bad tree Block 2089035464704, bytenr mismatch, want 2089035464704, ha=
ve 0
>>> ERROR: failed to read tree Block 2089035464704
>>
>> That's strange. The tree block isn't even mapped.
>>
>> But from the dmesg, it shows there is an extent item in log tree, whic=
h
>> doesn't look sane.
>>
>> BTW, what's the stderr from `btrfs check` I guess you have only patesd=

>> the stdout thus no real error message.
>>
>> Anyway, you can solve it by `btrfs rescue zero-log`, but I doubt there=

>> are more problems than we expect.
>>
>> Thanks,
>> Qu
>>
>>> Many thanks.
>>>
>>> J=C3=B6rg
>>>
>>> -----Original Message-----
>>> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
>>> To: jollemeyer@gmx.de, linux-btrfs@vger.kernel.org
>>> Sent: Sa., 21 Dez. 2019 15:19
>>> Subject: Re: read time block corruption on root partition, Not bootin=
g
>>>
>>> On 2019/12/21 =E4=B8=8B=E5=8D=8810:06, jollemeyer@gmx.de wrote:
>>>> Dear all,
>>>>
>>>> on my BTRFS root partition (/dev/sda), a "read time block corruption=
" was
>>>> detected. The system refuses to boot. Current kernel is 5.4.2-1-Manj=
aro.
>>>>
>>>> Systemd's journalctl generated the following output:
>>>>
>>>> Dez 21 10:46:41 Phoenix kernel: BTRFS critical (device sda): corrupt=

>>>> leaf: block=3D2089035464704 slot=3D85 extent bytenr=3D1937096425472 =
len=3D4096
>>>> invalid extent refs, have 1 expect >=3D inline 1048577 Dez 21 10:46:=
41
>>>> Phoenix kernel: BTRFS error (device sda): block=3D2089035464704 read=
 time
>>>> tree block corruption detected Dez 21 10:46:41 Phoenix kernel: BTRFS=

>>>> critical (device sda): corrupt leaf: block=3D2089035464704 slot=3D85=
 extent
>>>> bytenr=3D1937096425472 len=3D4096 invalid extent refs, have 1 expect=
 >=3D
>>>> inline 1048577 Dez 21 10:46:41 Phoenix kernel: BTRFS error (device s=
da):
>>>> block=3D2089035464704 read time tree block corruption detected Dez 2=
1
>>>> 10:46:41 Phoenix kernel: BTRFS critical (device sda): corrupt leaf:
>>>> block=3D2089035464704 slot=3D85 extent bytenr=3D1937096425472 len=3D=
4096 invalid
>>>> extent refs, have 1 expect >=3D inline 1048577 Dez 21 10:46:41 Phoen=
ix
>>>> kernel: BTRFS error (device sda): block=3D2089035464704 read time tr=
ee
>>>> block corruption detected Dez 21 10:46:41 Phoenix kernel: BTRFS crit=
ical
>>>> (device sda): corrupt leaf: block=3D2089035464704 slot=3D85 extent
>>>> bytenr=3D1937096425472 len=3D4096 invalid extent refs, have 1 expect=
 >=3D
>>>> inline 1048577 Dez 21 10:46:41 Phoenix kernel: BTRFS error (device s=
da):
>>>> block=3D2089035464704 read time tree block corruption detected Dez 2=
1
>>>> 10:46:41 Phoenix kernel: BTRFS: error (device sda) in
>>>> btrfs_replay_log:2293: errno=3D-5 IO failure (Failed to recover log =
tree)>=20
>>> "btrfs ins dump-tree -b 2089035464704 /dev/sda" output please.
>>>
>>> Thanks,
>>> Qu
>>>
>>>> Dez 21 10:46:41 Phoenix kernel: ------------[ cut here ]------------=

>>>> Dez 21 10:46:41 Phoenix kernel: WARNING: CPU: 7 PID: 621 at
>>>> fs/btrfs/block-group.c:132 btrfs_put_block_group+0x42/0x50 [btrfs] D=
ez
>>>> 21 10:46:41 Phoenix kernel: Modules linked in: usblp snd_hda_codec_h=
dmi
>>>> intel_rapl_msr snd_hda_codec_realtek intel_rapl_common
>>>> snd_hda_codec_generic ext4 ledtrig_audio x86_pkg_temp_thermal
>>>> intel_powerclamp coretemp crc16 kvm_intel mbcache i915 jbd2 kvm
>>>> snd_hda_intel snd_intel_nhlt i2c_algo_bit irqbypass drm_kms_helper
>>>> snd_hda_codec crct10dif_pclmul crc32_pclmul snd_hda_core mousedev
>>>> ghash_clmulni_intel drm snd_hwdep snd_pcm aesni_intel crypto_simd cr=
yptd
>>>> glue_helper mei_hdcp intel_cstate iTCO_wdt intel_gtt snd_timer
>>>> iTCO_vendor_support intel_uncore mei_me intel_rapl_perf input_leds
>>>> agpgart i2c_i801 snd syscopyarea mei sysfillrect lpc_ich r8168(OE)
>>>> sysimgblt soundcore fb_sys_fops evdev ie31200_edac mac_hid vboxpci(O=
E)
>>>> vboxnetflt(OE) vboxnetadp(OE) vboxdrv(OE) sg crypto_user ip_tables
>>>> x_tables hid_generic usbhid hid btrfs libcrc32c crc32c_generic xor u=
as
>>>> usb_storage raid6_pq sr_mod cdrom sd_mod ahci serio_raw atkbd libahc=
i
>>>> libps2 libata xhci_pci scsi_mod xhci_hcd ehci_pci crc32c_intel ehci_=
hcd
>>>> i8042 serio Dez 21 10:46:41 Phoenix kernel: CPU: 7 PID: 621 Comm: mo=
unt
>>>> Tainted: G           OE     5.4.2-1-MANJARO #1 Dez 21 10:46:41 Phoen=
ix
>>>> kernel: Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M.=
/H77
>>>> Pro4/MVP, BIOS P1.40 09/04/2012 Dez 21 10:46:41 Phoenix kernel: RIP:=

>>>> 0010:btrfs_put_block_group+0x42/0x50 [btrfs] Dez 21 10:46:41 Phoenix=

>>>> kernel: Code: 2d 48 83 7d 50 00 75 22 48 8b 85 e8 01 00 00 48 85 c0 =
75
>>>> 1e 48 8b bd d8 00 00 00 e8 a8 08 66 d9 48 89 ef 5d e9 9f 08 66 d9 c3=

>>>> <0f> 0b eb da 0f 0b eb cf 0f 0b eb de 66 90 0f 1f 44 00 00 31 d2 e9 =
Dez
>>>> 21 10:46:41 Phoenix kernel: RSP: 0018:ffffa95900f47ae8 EFLAGS: 00010=
206
>>>> Dez 21 10:46:41 Phoenix kernel: RAX: 0000000000000001 RBX:
>>>> ffff8a1eb7bfe0e0 RCX: 0000000000000000 Dez 21 10:46:41 Phoenix kerne=
l:
>>>> RDX: 0000000000000001 RSI: ffff8a1ecf5f0250 RDI: ffff8a1eb7bfe000 De=
z 21
>>>> 10:46:41 Phoenix kernel: RBP: ffff8a1eb7bfe000 R08: 0000000000000000=

>>>> R09: 0000000000000001 Dez 21 10:46:41 Phoenix kernel: R10:
>>>> 00000000003f6c00 R11: 0000000000000000 R12: ffff8a1ec81b0080 Dez 21
>>>> 10:46:41 Phoenix kernel: R13: ffff8a1ec81b0090 R14: ffff8a1eb7bfe000=

>>>> R15: dead000000000100 Dez 21 10:46:41 Phoenix kernel: FS:=20
>>>> 00007f77003d7500(0000) GS:ffff8a1ecf5c0000(0000) knlGS:0000000000000=
000
>>>> Dez 21 10:46:41 Phoenix kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
>>>> 0000000080050033 Dez 21 10:46:41 Phoenix kernel: CR2: 00005596523644=
60
>>>> CR3: 00000003fbaec005 CR4: 00000000001606e0 Dez 21 10:46:41 Phoenix
>>>> kernel: Call Trace:
>>>> Dez 21 10:46:41 Phoenix kernel:  btrfs_free_block_groups+0x11c/0x260=

>>>> [btrfs] Dez 21 10:46:41 Phoenix kernel:  open_ctree+0x187a/0x1bc0
>>>> [btrfs]
>>>> Dez 21 10:46:41 Phoenix kernel:  btrfs_mount_root+0x57b/0x670 [btrfs=
]
>>>> Dez 21 10:46:41 Phoenix kernel:  legacy_get_tree+0x27/0x40
>>>> Dez 21 10:46:41 Phoenix kernel:  vfs_get_tree+0x25/0xb0
>>>> Dez 21 10:46:41 Phoenix kernel:  fc_mount+0xe/0x30
>>>> Dez 21 10:46:41 Phoenix kernel:  vfs_kern_mount.part.0+0x71/0x90
>>>> Dez 21 10:46:41 Phoenix kernel:  btrfs_mount+0x18e/0x930 [btrfs]
>>>> Dez 21 10:46:41 Phoenix kernel:  ? filename_lookup+0x105/0x190
>>>> Dez 21 10:46:41 Phoenix kernel:  ? legacy_get_tree+0x27/0x40
>>>> Dez 21 10:46:41 Phoenix kernel:  ? btrfs_remount+0x4d0/0x4d0 [btrfs]=

>>>> Dez 21 10:46:41 Phoenix kernel:  legacy_get_tree+0x27/0x40
>>>> Dez 21 10:46:41 Phoenix kernel:  vfs_get_tree+0x25/0xb0
>>>> Dez 21 10:46:41 Phoenix kernel:  do_mount+0x77a/0xa30
>>>> Dez 21 10:46:41 Phoenix kernel:  ksys_mount+0x7e/0xc0
>>>> Dez 21 10:46:41 Phoenix kernel:  __x64_sys_mount+0x21/0x30
>>>> Dez 21 10:46:41 Phoenix kernel:  do_syscall_64+0x4e/0x140
>>>> Dez 21 10:46:41 Phoenix kernel:  entry_SYSCALL_64_after_hwframe+0x44=
/0xa9
>>>> Dez 21 10:46:41 Phoenix kernel: RIP: 0033:0x7f770055ae4e
>>>> Dez 21 10:46:41 Phoenix kernel: Code: 48 8b 0d 35 00 0c 00 f7 d8 64 =
89 01
>>>> 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca=
 b8
>>>> a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 02 00 0c 00 =
f7
>>>> d8 64 89 01 48 Dez 21 10:46:41 Phoenix kernel: RSP:
>>>> 002b:00007ffedb3135c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5 De=
z 21
>>>> 10:46:41 Phoenix kernel: RAX: ffffffffffffffda RBX: 00007f7700681204=

>>>> RCX: 00007f770055ae4e Dez 21 10:46:41 Phoenix kernel: RDX:
>>>> 000055d9705f5650 RSI: 000055d9705f56f0 RDI: 000055d9705f73d0 Dez 21
>>>> 10:46:41 Phoenix kernel: RBP: 000055d9705f5440 R08: 000055d9705f5670=

>>>> R09: 0000000000000000 Dez 21 10:46:41 Phoenix kernel: R10:
>>>> 0000000000000000 R11: 0000000000000246 R12: 0000000000000000 Dez 21
>>>> 10:46:41 Phoenix kernel: R13: 000055d9705f73d0 R14: 000055d9705f5650=

>>>> R15: 000055d9705f5440 Dez 21 10:46:41 Phoenix kernel: ---[ end trace=

>>>> 71465d442bb4c509 ]--- Dez 21 10:46:41 Phoenix kernel: ------------[ =
cut
>>>> here ]------------ Dez 21 10:46:41 Phoenix kernel: WARNING: CPU: 0 P=
ID:
>>>> 621 at fs/btrfs/block-group.c:3166 btrfs_free_block_groups+0x1ea/0x2=
60
>>>> [btrfs] Dez 21 10:46:41 Phoenix kernel: Modules linked in: usblp
>>>> snd_hda_codec_hdmi intel_rapl_msr snd_hda_codec_realtek
>>>> intel_rapl_common snd_hda_codec_generic ext4 ledtrig_audio
>>>> x86_pkg_temp_thermal intel_powerclamp coretemp crc16 kvm_intel mbcac=
he
>>>> i915 jbd2 kvm snd_hda_intel snd_intel_nhlt i2c_algo_bit irqbypass
>>>> drm_kms_helper snd_hda_codec crct10dif_pclmul crc32_pclmul snd_hda_c=
ore
>>>> mousedev ghash_clmulni_intel drm snd_hwdep snd_pcm aesni_intel
>>>> crypto_simd cryptd glue_helper mei_hdcp intel_cstate iTCO_wdt intel_=
gtt
>>>> snd_timer iTCO_vendor_support intel_uncore mei_me intel_rapl_perf
>>>> input_leds agpgart i2c_i801 snd syscopyarea mei sysfillrect lpc_ich
>>>> r8168(OE) sysimgblt soundcore fb_sys_fops evdev ie31200_edac mac_hid=

>>>> vboxpci(OE) vboxnetflt(OE) vboxnetadp(OE) vboxdrv(OE) sg crypto_user=

>>>> ip_tables x_tables hid_generic usbhid hid btrfs libcrc32c crc32c_gen=
eric
>>>> xor uas usb_storage raid6_pq sr_mod cdrom sd_mod ahci serio_raw atkb=
d
>>>> libahci libps2 libata xhci_pci scsi_mod xhci_hcd ehci_pci crc32c_int=
el
>>>> ehci_hcd i8042 serio Dez 21 10:46:41 Phoenix kernel: CPU: 0 PID: 621=

>>>> Comm: mount Tainted: G        W  OE     5.4.2-1-MANJARO #1 Dez 21
>>>> 10:46:41 Phoenix kernel: Hardware name: To Be Filled By O.E.M. To Be=

>>>> Filled By O.E.M./H77 Pro4/MVP, BIOS P1.40 09/04/2012 Dez 21 10:46:41=

>>>> Phoenix kernel: RIP: 0010:btrfs_free_block_groups+0x1ea/0x260 [btrfs=
]
>>>> Dez 21 10:46:41 Phoenix kernel: Code: 49 bd 22 01 00 00 00 00 ad de =
e8
>>>> 51 13 d1 d9 e8 0c d3 4e d9 48 89 ef e8 64 9b ff ff 48 8b 85 00 10 00=
 00
>>>> 49 39 c4 75 3c eb 5f <0f> 0b 31 c9 31 d2 4c 89 fe 48 89 ef e8 55 85 =
ff
>>>> ff 48 8b 43 08 48 Dez 21 10:46:41 Phoenix kernel: RSP:
>>>> 0018:ffffa95900f47af8 EFLAGS: 00010206 Dez 21 10:46:41 Phoenix kerne=
l:
>>>> RAX: ffff8a1eca367488 RBX: ffff8a1eca367488 RCX: 0000000000000000 De=
z 21
>>>> 10:46:41 Phoenix kernel: RDX: 0000000000000001 RSI: ffff8a1eca364200=

>>>> RDI: 00000000ffffffff Dez 21 10:46:41 Phoenix kernel: RBP:
>>>> ffff8a1ec81b0000 R08: 0000000000000000 R09: 0000000020000000 Dez 21
>>>> 10:46:41 Phoenix kernel: R10: 0000000000000005 R11: ffffffffffd5ce37=

>>>> R12: ffff8a1ec81b1000 Dez 21 10:46:41 Phoenix kernel: R13:
>>>> dead000000000122 R14: dead000000000100 R15: ffff8a1eca367400 Dez 21
>>>> 10:46:41 Phoenix kernel: FS:  00007f77003d7500(0000)
>>>> GS:ffff8a1ecf400000(0000) knlGS:0000000000000000 Dez 21 10:46:41 Pho=
enix
>>>> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 Dez 21
>>>> 10:46:41 Phoenix kernel: CR2: 0000559006e55d68 CR3: 00000003fbaec006=

>>>> CR4: 00000000001606f0 Dez 21 10:46:41 Phoenix kernel: Call Trace:
>>>> Dez 21 10:46:41 Phoenix kernel:  open_ctree+0x187a/0x1bc0 [btrfs]
>>>> Dez 21 10:46:41 Phoenix kernel:  btrfs_mount_root+0x57b/0x670 [btrfs=
]
>>>> Dez 21 10:46:41 Phoenix kernel:  legacy_get_tree+0x27/0x40
>>>> Dez 21 10:46:41 Phoenix kernel:  vfs_get_tree+0x25/0xb0
>>>> Dez 21 10:46:41 Phoenix kernel:  fc_mount+0xe/0x30
>>>> Dez 21 10:46:41 Phoenix kernel:  vfs_kern_mount.part.0+0x71/0x90
>>>> Dez 21 10:46:41 Phoenix kernel:  btrfs_mount+0x18e/0x930 [btrfs]
>>>> Dez 21 10:46:41 Phoenix kernel:  ? filename_lookup+0x105/0x190
>>>> Dez 21 10:46:41 Phoenix kernel:  ? legacy_get_tree+0x27/0x40
>>>> Dez 21 10:46:41 Phoenix kernel:  ? btrfs_remount+0x4d0/0x4d0 [btrfs]=

>>>> Dez 21 10:46:41 Phoenix kernel:  legacy_get_tree+0x27/0x40
>>>> Dez 21 10:46:41 Phoenix kernel:  vfs_get_tree+0x25/0xb0
>>>> Dez 21 10:46:41 Phoenix kernel:  do_mount+0x77a/0xa30
>>>> Dez 21 10:46:41 Phoenix kernel:  ksys_mount+0x7e/0xc0
>>>> Dez 21 10:46:41 Phoenix kernel:  __x64_sys_mount+0x21/0x30
>>>> Dez 21 10:46:41 Phoenix kernel:  do_syscall_64+0x4e/0x140
>>>> Dez 21 10:46:41 Phoenix kernel:  entry_SYSCALL_64_after_hwframe+0x44=
/0xa9
>>>> Dez 21 10:46:41 Phoenix kernel: RIP: 0033:0x7f770055ae4e
>>>> Dez 21 10:46:41 Phoenix kernel: Code: 48 8b 0d 35 00 0c 00 f7 d8 64 =
89 01
>>>> 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca=
 b8
>>>> a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 02 00 0c 00 =
f7
>>>> d8 64 89 01 48 Dez 21 10:46:41 Phoenix kernel: RSP:
>>>> 002b:00007ffedb3135c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5 De=
z 21
>>>> 10:46:41 Phoenix kernel: RAX: ffffffffffffffda RBX: 00007f7700681204=

>>>> RCX: 00007f770055ae4e Dez 21 10:46:41 Phoenix kernel: RDX:
>>>> 000055d9705f5650 RSI: 000055d9705f56f0 RDI: 000055d9705f73d0 Dez 21
>>>> 10:46:41 Phoenix kernel: RBP: 000055d9705f5440 R08: 000055d9705f5670=

>>>> R09: 0000000000000000 Dez 21 10:46:41 Phoenix kernel: R10:
>>>> 0000000000000000 R11: 0000000000000246 R12: 0000000000000000 Dez 21
>>>> 10:46:41 Phoenix kernel: R13: 000055d9705f73d0 R14: 000055d9705f5650=

>>>> R15: 000055d9705f5440 Dez 21 10:46:41 Phoenix kernel: ---[ end trace=

>>>> 71465d442bb4c50a ]--- Dez 21 10:46:41 Phoenix kernel: BTRFS info (de=
vice
>>>> sda): space_info 1 has 733175808 free, is not full Dez 21 10:46:41
>>>> Phoenix kernel: BTRFS info (device sda): space_info total=3D13862006=
94784,
>>>> used=3D1385467318272, pinned=3D0, reserved=3D4096, may_use=3D0, read=
only=3D196608
>>>> Dez 21 10:46:41 Phoenix kernel: BTRFS info (device sda):
>>>> global_block_rsv: size 0 reserved 0 Dez 21 10:46:41 Phoenix kernel:
>>>> BTRFS info (device sda): trans_block_rsv: size 0 reserved 0 Dez 21
>>>> 10:46:41 Phoenix kernel: BTRFS info (device sda): chunk_block_rsv: s=
ize
>>>> 0 reserved 0 Dez 21 10:46:41 Phoenix kernel: BTRFS info (device sda)=
:
>>>> delayed_block_rsv: size 0 reserved 0 Dez 21 10:46:41 Phoenix kernel:=

>>>> BTRFS info (device sda): delayed_refs_rsv: size 0 reserved 0 Dez 21
>>>> 10:46:41 Phoenix kernel: BTRFS error (device sda): open_ctree failed=
 --
>>>> Subject: Unit process exited
>>>> -- Defined-By: systemd
>>>>
>>>> Btrfs check --readonly /dev/sda also found errors:
>>>>
>>>> Opening filesystem to check...
>>>> Checking filesystem on /dev/sda
>>>> UUID: 014bdf0a-bcb3-4a7c-b58d-c1fc17281f7e
>>>> found 1386975199232 bytes used, error(s) found
>>>> total csum bytes: 1352697008
>>>> total tree bytes: 1508327424
>>>> total fs tree bytes: 61161472
>>>> total extent tree bytes: 37421056
>>>> btree space waste bytes: 55303865
>>>> file data blocks allocated: 1388605296640
>>>>
>>>>  referenced 1385670742016
>>>>
>>>> Btrfs scrub does not recognize any errors.
>>>>
>>>> Kindly help me to recover this error.
>>>>
>>>> many thanks,
>>>>
>>>> J=C3=B6rg Meyer
>=20
>=20
>=20
>=20


--qQXtXQxzrtL3y0P4Mj54841ecEMeTP9VQ--

--ZkgDJjnNJ72WQYiT8tO1FGhOSDdIfutYC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3/QbUACgkQwj2R86El
/qgM7gf/eRcuWX7YaVjO6B5/wEQK4HzI8uM3T5jq5gzt7T736ZPt5ZDwCQM2Jhoc
07Sql+5x0lVRnHkbZAkozyDTZlMVvYbkTAXIf+UE+bZ/dEmW6vBjdiTcjJZD21bK
rLkvHDKQ73YssSsBaLAeodcDb0+1jTqam/PUnJwCxWqNviaCUrWUNpUYXwEPPzMI
ISuiyFDJQkLmOFGnXoW/EnAfR8whH5jx4nh1YghIgG+/nazXzf5K5gjwOe4qLPIM
TycS2o28RhiiZN5wzfYvfZYfrRAl5MDRUEIFgOxfRHylu5tpmYewximpC2Qhj4nI
Z/aQvNP12qoxCTrELEnBarpDu3lqDA==
=3zoa
-----END PGP SIGNATURE-----

--ZkgDJjnNJ72WQYiT8tO1FGhOSDdIfutYC--
