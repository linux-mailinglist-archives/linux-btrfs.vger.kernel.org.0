Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF042285DEF
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Oct 2020 13:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgJGLOP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Oct 2020 07:14:15 -0400
Received: from mout.gmx.net ([212.227.17.21]:33119 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgJGLOO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Oct 2020 07:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602069250;
        bh=MKKaDKlC0Y0hF2kenEpaXyh4bKGXdmXT5ppRkrBMYYM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=KRcb/XzQWRPXQ1NRFrEZFcBXy+bQmE/ehxT62xLUc6ABoajuuf+ImHOB1pTVO/bL8
         q55Ka/gf/Vsg6i9ftt9W+uy+Z5LI18GiRuKfVMNHyWNIhtjPQuWy3Q3AOmymAbjm/S
         Ff+oRh1XDZKwlIUmvCqVrlf6uGfVRS3mszoiR92k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McpNy-1kzj871l7S-00Zte2; Wed, 07
 Oct 2020 13:14:10 +0200
Subject: Re: Counts for qgroup id are different
To:     JMinson <minsonj2016@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        BTRFS Kernel <linux-btrfs@vger.kernel.org>
References: <8547cc42-6768-d6f0-6336-fac1fc42b85d@gmail.com>
 <9ded0048-a480-8873-899d-576210490606@gmx.com>
 <91df37d7-d173-f264-6a2b-22649b0f7e68@gmail.com>
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
Message-ID: <c7e12280-0a86-6677-2cf9-de32bf68b07d@gmx.com>
Date:   Wed, 7 Oct 2020 19:14:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <91df37d7-d173-f264-6a2b-22649b0f7e68@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lJfOxUdAQgyh1zPSiiEN9OvJv50D1LILv"
X-Provags-ID: V03:K1:XT5bruZ0NpiXxLQ/h0OLCEcjcgTXEsDihwGIVgkmaeYU1w5Ve9B
 YrR+RC9DjzJaN+m/BvUpT5VmOKRZ20MhDPhDO7GMTeYgMLbEhS/CfXDGTBLWYvCPjBjZmAP
 hni3ndaHMK/PCHRyQFhliMi+WwHDS29fNAzsiBzP5a2XFdWSxeeg5npKKbDu6fVdFrbWsAk
 bcekqtBTgEP0qmlcbci9w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jrIPWEjTCFc=:3oVEhD+YRF3JuTSpWQYg/y
 Gbw2VCrcFwTD6cra04yIjuQjob7l+RD4E7bplgfOq335zwbCo1xWEtBt+4xi7b1MWaIUZ/oBk
 0llvPgTUkYPbNX/WfVUNjRMN5YzOPaBU+CQ/KUX6fRM1cIfYRUT44S6a/THy+1UqwiiHDWsyQ
 U8zUAStaXV3ZWg+RUe1xTT3nEwd6AIJtf9hpAdsa1bUqDcJus1JbpiWr96osJToZDAbZ4yB9T
 8ZmDF4TG8J3iS7oU+o+4VSBx7Lja0j7+6U58VttqAvgr8wtwjIp8qWOjBSKPZX1TDsXp1ZW4I
 yLY4lL92S1a7V/tde6fHzSGiilWscoSDD4lD74GBfXMGw2FWP+ZZpu7oEzLds6uJJPIfAAZJ7
 /kYUGEcr1nUHyk1KMMb+Y2kcX116SNCf3ZIlmyJNoCUh6ltmGcFZts7h++Jsms1zlLjej0Cam
 uh3JlWGRT/pS1ktOH/2bo5+o8fUKHNcU75g2olyKVlDED+vzpHXCSstTQ9WpMTaPHHm9qrFOp
 4kS3SZkTz/eiO4DUqDROZYeCC/IJ3hfapnfeIwnSa0UjA0B/nhB8eUtvD4ZazWB5gJVbvE+zu
 1N6oNB0omnns4PBghuJ+ZMXdFC8UI90jbi1plgWROhxvyba4Zz5LBZHKz71L5rsWBBB0QUkiM
 i4EtKegqD22GkS2ANXdcALFj+yvtDvsKmynqCEzExrRl1d0C3jtGJh2UKngHg+5Bq6r7GLHmg
 QZZaR2jgvhWuSIVwKIhHOb08qrIx0kEmElJ3wPKi+YrwUiKu/VV6WtJDvuS5t1b+JGZdl7bSx
 UgFaO8re8iiU1sVeSGxMdsuftAuaZ4rnUUnJbsT/zGD0Nze1E1UNGDPSF4zZyBVjMJIfFxLX9
 q3D8juQDX/zVjT4SGVFTLsJdDwIRHGd54Z2mUJ9C9ZJ7480kbSvD7hzibQcmvj+M7d0XMZAeh
 VJfhGyc2AkyiAZwZOODhusq8QtiNvjiK97laIxzguu6fjRSN9B0OtdWHmjRmluQDFshx+Ioel
 //0pDxRY2YjY5/hVEGLLDCEr05QRvXggyPwEhqcgKEdugFzascTl1mp0SK7sFImG68+U7S3Kt
 GyiUM74euQ2U51p3Udi60US/GyhvfD8cA1b/YkjRsi8y2GrokTguppqmVB2nyjDKTaHUrKB6y
 eXMrhXkQpm3rHL6GSNXucHhJXgx2I1TPVUjQBBXhLnRMeDvjmUmpw6Q/puLBBG4rQu25kAZqs
 vfpaI4I6HF9sW3KU6FsHO02ZouYQ0DR5GNbrH+A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lJfOxUdAQgyh1zPSiiEN9OvJv50D1LILv
Content-Type: multipart/mixed; boundary="RjEzow0WqA52xjUVVIa80K99F8bUcgqYT"

--RjEzow0WqA52xjUVVIa80K99F8bUcgqYT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/7 =E4=B8=8B=E5=8D=886:58, JMinson wrote:
> Good News / Bad News
>=20
> The good news is that btrfs quota rescan /Daily cleared the Counts for
> qgroup id are different error .
>=20
> The bad news is that during the rescan these errors are being generated=
:
>=20
>=20
> Oct=C2=A0 7 06:25:27 linux-desktop kernel: [ 4001.145760] ------------[=
 cut
> here ]------------
> Oct=C2=A0 7 06:25:27 linux-desktop kernel: [ 4001.145766] WARNING: CPU:=
 4
> PID: 4850 at fs/fs-writeback.c:2466 __writeback_inodes_sb_nr+0xbf/0xd0

This is completely unrelated to qgroup then.

According to the code, it looks like some lock schema problem.
At least for the qgroup part it should be fine now.

For the new part, unless you're a developer, you can just ignore it.
Or could you provide the workload for us to reproduce?
Just your regular backup workload?

Thanks,
Qu

> Oct=C2=A0 7 06:25:27 linux-desktop kernel: [ 4001.145766] Modules linke=
d in:
> ccm rfcomm cmac algif_hash algif_skcipher af_alg bnep
> snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio
> snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_hda_codec
> snd_hda_core snd_hwdep snd_pcm snd_seq_midi snd_seq_midi_event
> nls_iso8859_1 snd_rawmidi snd_seq iwlmvm snd_seq_device edac_mce_amd
> mac80211 kvm_amd ccp snd_timer libarc4 kvm eeepc_wmi iwlwifi asus_wmi
> sparse_keymap wmi_bmof btusb snd k10temp cfg80211 btrtl btbcm btintel
> joydev soundcore input_leds bluetooth ecdh_generic ecc mac_hid
> sch_fq_codel parport_pc ppdev lp parport ip_tables x_tables autofs4
> btrfs zstd_compress raid10 raid456 async_raid6_recov async_memcpy
> async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipat=
h
> linear hid_logitech_hidpp uas usb_storage hid_logitech_dj hid_generic
> usbhid hid amdgpu crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
> amd_iommu_v2 gpu_sched aesni_intel i2c_algo_bit ttm crypto_simd
> drm_kms_helper cryptd glue_helper syscopyarea
> Oct=C2=A0 7 06:25:27 linux-desktop kernel: [ 4001.145791]=C2=A0 sysfill=
rect
> sysimgblt nvme fb_sys_fops i2c_piix4 drm nvme_core ahci libahci wmi
> video gpio_amdpt gpio_generic
> Oct=C2=A0 7 06:25:27 linux-desktop kernel: [ 4001.145796] CPU: 4 PID: 4=
850
> Comm: btrfs-transacti Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 W 5.4.0-48-generic #52-Ubuntu
> Oct=C2=A0 7 06:25:27 linux-desktop kernel: [ 4001.145797] Hardware name=
:
> System manufacturer System Product Name/PRIME B450M-A, BIOS 2202 07/14/=
2020
> Oct=C2=A0 7 06:25:27 linux-desktop kernel: [ 4001.145799] RIP:
> 0010:__writeback_inodes_sb_nr+0xbf/0xd0
> Oct=C2=A0 7 06:25:27 linux-desktop kernel: [ 4001.145800] Code: b6 d1 4=
8 8d
> 75 b0 e8 80 fc ff ff 4c 89 e7 e8 e8 fb ff ff 48 8b 45 f0 65 48 33 04 25=

> 28 00 00 00 75 0c 48 83 c4 58 41 5c 5d c3 <0f> 0b eb ce e8 48 c4 d8 ff
> 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
> Oct=C2=A0 7 06:25:27 linux-desktop kernel: [ 4001.145800] RSP:
> 0018:ffffb9ac82a5fdb0 EFLAGS: 00010246
> Oct=C2=A0 7 06:25:27 linux-desktop kernel: [ 4001.145801] RAX:
> 0000000000000000 RBX: 0000000000000125 RCX: 0000000000000000
> Oct=C2=A0 7 06:25:27 linux-desktop kernel: [ 4001.145802] RDX:
> 0000000000000002 RSI: 00000000000122ba RDI: ffff9a07f0396800
> Oct=C2=A0 7 06:25:27 linux-desktop kernel: [ 4001.145802] RBP:
> ffffb9ac82a5fe10 R08: ffff9a07f0395800 R09: ffffb9ac82a5fdd0
> Oct=C2=A0 7 06:25:27 linux-desktop kernel: [ 4001.145803] R10:
> 0000000000000000 R11: 0000000000000000 R12: ffffb9ac82a5fdb0
> Oct=C2=A0 7 06:25:27 linux-desktop kernel: [ 4001.145803] R13:
> 0000000000000002 R14: ffff9a0842aba800 R15: 0000000000000000
> Oct=C2=A0 7 06:25:27 linux-desktop kernel: [ 4001.145804] FS:
> 0000000000000000(0000) GS:ffff9a0850900000(0000) knlGS:0000000000000000=

> Oct=C2=A0 7 06:25:27 linux-desktop kernel: [ 4001.145804] CS:=C2=A0 001=
0 DS: 0000
> ES: 0000 CR0: 0000000080050033
> Oct=C2=A0 7 06:25:27 linux-desktop kernel: [ 4001.145805] CR2:
> 00007fe990379000 CR3: 00000003fff9e000 CR4: 00000000003406e0
> Oct=C2=A0 7 06:25:27 linux-desktop kernel: [ 4001.145805] Call Trace:
> Oct=C2=A0 7 06:25:27 linux-desktop kernel: [ 4001.145808]
> writeback_inodes_sb+0x4b/0x60
> Oct=C2=A0 7 06:25:27 linux-desktop kernel: [ 4001.145820]
> btrfs_commit_transaction+0x2f6/0x960 [btrfs]
> Oct=C2=A0 7 06:25:27 linux-desktop kernel: [ 4001.145828]=C2=A0 ?
> start_transaction+0xb7/0x510 [btrfs]
> Oct=C2=A0 7 06:25:27 linux-desktop kernel: [ 4001.145830]=C2=A0 ?
> del_timer_sync+0x30/0x40
> Oct=C2=A0 7 06:25:27 linux-desktop kernel: [ 4001.145838]
> transaction_kthread+0x146/0x190 [btrfs]
> Oct=C2=A0 7 06:25:27 linux-desktop kernel: [ 4001.145840] kthread+0x104=
/0x140
> Oct=C2=A0 7 06:25:27 linux-desktop kernel: [ 4001.145847]=C2=A0 ?
> btrfs_cleanup_transaction+0x530/0x530 [btrfs]
> Oct=C2=A0 7 06:25:27 linux-desktop kernel: [ 4001.145848]=C2=A0 ?
> kthread_park+0x90/0x90
> Oct=C2=A0 7 06:25:27 linux-desktop kernel: [ 4001.145850]
> ret_from_fork+0x22/0x40
> Oct=C2=A0 7 06:25:27 linux-desktop kernel: [ 4001.145851] ---[ end trac=
e
> 21d9e8c753568b19 ]---
>=20
> On 10/6/20 8:13 PM, Qu Wenruo wrote:
>>
>> On 2020/10/6 =E4=B8=8B=E5=8D=8810:27, JMinson wrote:
>>> Linux linux-desktop 5.4.0-48-generic #52-Ubuntu SMP Thu Sep 10 10:58:=
49
>>> UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
>>>
>>> btrfs-progs v5.4.1
>>>
>>> Label: 'Daily'=C2=A0 uuid: 1426edb8-4fed-419a-b0f1-d131b97224fd
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS b=
ytes used 1.13TiB
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=
=A0 1 size 1.82TiB used 1.14TiB path /dev/sdb
>>>
>>>
>>> I use rsync to backup to an external btrfs formatted usb drive . The
>>> process is :
>>>
>>>
>>> mount btrfs volume "/Daily"
>>>
>>> take a snapshot of subvolume "BackupRoot" and give the snapshot a nam=
e
>>> like "snap@BackupRoot-2020-10-05-Oct-1601938835"
>>>
>>> run rsync with the destination being "/Daily/BackupRoot"
>>>
>>> unmount the btrfs volume "/Daily"
>>>
>>> I've been using this procedure for about 6 months and is far as I kno=
w
>>> all the data is good . However I discovered yesterday that when I run=

>>> btrfsck I get 1 or more of these
>>>
>>> Counts for qgroup id: 0/1561 are different
>>> our:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 referenced 1051233288192 referenced compressed
>>> 1051233288192
>>> disk:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ref=
erenced 1046914453504 referenced compressed
>>> 1046914453504
>>> diff:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ref=
erenced 4318834688 referenced compressed 4318834688
>> This means btrfs qgroup on-disk is smaller than what btrfs check think=

>> is.
>>
>> Is there any subvolume deletion involved in this case?
>> IIRC btrfs kernel and btrfs-check has different opinion on half-droppe=
d
>> subvolumes. But when the subvolume is fully dropped, then everything
>> goes back into sync again.
>>
>>> our:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 exclusive 1206681600 exclusive compressed 1206681600
>>> disk:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exc=
lusive 1206681600 exclusive compressed 1206681600
>> But exclusive is correct, thus it doesn't look like regular qgroup err=
or.
>>
>>>
>>> Is this something to be concerned about ?
>> Normally you don't need to be concerned.
>>
>> If you really don't like this, you can just trigger a qgroup rescan an=
d
>> it will be handled well.
>>
>> Another thing is, if you're running btrfs check with --force, on runni=
ng
>> fs, it could give false alert.
>>
>> Thanks,
>> Qu
>>
>=20


--RjEzow0WqA52xjUVVIa80K99F8bUcgqYT--

--lJfOxUdAQgyh1zPSiiEN9OvJv50D1LILv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl99ov4ACgkQwj2R86El
/qjwXwf/bLK5FkT91XcSYkh4ESS+CUr+KbYIFqOZ1gzsyGedJeyfB4e2otfb45J4
G8sYEgLdRX010s+qVGQZAePLyc4FdPGVFWes6KnJ9cDmhVjel8NPJRqbscsWk3AM
2cNGnKTFqjdKanufcbFRBr6+BTllFjCJAOgtzRYnj/xCRUbOt6oOQfNysAh69gOn
uY5m++jWrT1gTsojGTVhK3DQxqL5GWR0EeELr4tHNvBQ9502Zur0ontBCuqtI8iU
4bJ13O07LtxFonQpStE59EYgkJ48x044Mg/0syd8Kqr32UVOjtfYHgsrcienMtjC
gfJBSJY6AG+GsH+zcek0T1dCDHfPfw==
=FMT4
-----END PGP SIGNATURE-----

--lJfOxUdAQgyh1zPSiiEN9OvJv50D1LILv--
