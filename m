Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6808412865C
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Dec 2019 02:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLUBcb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Dec 2019 20:32:31 -0500
Received: from mout.gmx.net ([212.227.15.18]:34081 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbfLUBcb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Dec 2019 20:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576891945;
        bh=mTNG4rM3pk1WtnWT4WNx2FWdncWloUPJLGJ9mlEUxd4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LmByNzzXVjsDFb+9rVyErQVf+YRCrB1n0xpovEHVZpp5kzxdvWCtBw3yPVKuwAYfB
         FfsNc9rXgqTw72sFwiUygsNtc1/PKinOEdnlMGMsTGs6kYGNfzjxNmqAByqMTqqlNK
         mf7Y+CHNNMJBx+FNaE+wcn3L3Wspe8U0emVqrGjg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MCKBc-1iaBtC2EnS-009QRY; Sat, 21
 Dec 2019 02:32:25 +0100
Subject: Re: btrfs dev del not transaction protected?
To:     Marc Lehmann <schmorp@schmorp.de>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20191220040536.GA1682@schmorp.de>
 <b9e7f094-0080-ef08-68df-61ffbeaa9d19@gmx.com>
 <20191220063702.GE5861@schmorp.de>
 <1912b2a1-2aa9-bf4c-198f-c5e1565dd11f@gmx.com>
 <20191220132703.GA3435@schmorp.de>
 <204287e5-8aca-3a51-9bc9-be577299bfd6@gmx.com>
 <20191220165008.GA1603@schmorp.de>
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
Message-ID: <3c969ecd-9479-d440-a4f9-13c6f859d439@gmx.com>
Date:   Sat, 21 Dec 2019 09:32:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191220165008.GA1603@schmorp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZL8ESFiFwq9Bi81n7puXCk4DXVaIjblk2"
X-Provags-ID: V03:K1:sxTSWEd4HzMrxKHdRaU6AEPtlTtRYSNwE/lRlYOf/X1MN8f3Efv
 06VkoL6wuOrjHTjmKgn0jubPOEXYdasUfPD89kyfqy8QlnkvxcN103mfdqV0z1THaRIQ6Cf
 CCPsfpgJwmAXzWKM4TH7zjlw4kG56zfE76YH2hn3z1FkmFNg0u7WjvEDlV5piVt03nAcoa6
 fSjA/V58FJ23Pby//k5mg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:I9mnbjZ36Tc=:513cvnsdA7XBQlJpvQ5UBb
 8ppsYOSxj12oDhgfQ+232AqBxzRZ7lpPF0yNfWrHeHBoxn8QA7sNPRK2bUnilHdMyEJE/jnrr
 3FmFs06eVy8AEwOtFP/om2+c2uebOFX5ubTgkoKeNSasi8xx8WD0X34Hxr49qxozD0aXiQSur
 KV6u6GzNS+lP2kyRlx48nW37JmsUKKWsEuKKrbsRKgBc4vlVhfZUuPoTzmzIG2kj41K+v1LTn
 qWHxSpds38iDsf1OL2DltVwKAxecU3+jNgFbAgMVEofwbyjyW2TlkMBsh4wGDGPtRpT0r7MKl
 Bq7aaEIJJamXwo9a8NhKEiuhP3DqqxJpuri6WDEy2UWqW/NiUOtV6wKVT8RqKvZSxNxP7vXiV
 TuXxDmhd7Dp6QmoERcmIe2KKywnwtusOT5k2Qa2LS1jFXkbB0H0aawYOf1R7gIYM5y04B8YkG
 jtDwn5vbK1i+4OyjE1OZ3lmzEe6SgvFABTP3AiegLc3Hrx59a4bxmdJx59ihbTc+2Z2a8k9xa
 chn+iATi3oslQetst+Bjy28uLlUKhaHNa/D8TNwYLPgj9sV5upzKfXRxz8bHS96YyjdK3GP9a
 QtUN2fDq6pNI4DBNM0kKORI7d7WD0s/ROyCHZk+MDYHJO9uP3Bkn01HIVCHVW13mbUSNLe+bt
 syGABzYR1hxFnQOqBtseRJjOSqFE00buoQKIeguNl1a4biYvp3T+q5Kvt/3BH2zkPzbdvdHEI
 rNoFNO/fXzJLcoyQZAQ8kpswPeGhvxcAkEuufYYl+3rJF2WQguDOm8m8MNZe8u228hmbin1Ru
 6RI2Ezzt9vLFjGLoSmYjNZPUq5nqa4AbAjuqYGafLn8kCUGzw5kdJK5+VEAmCiK/IfdmjEiN9
 t2Q3N38YMl+o0Ef7cYjkhVZdXjDjR7+OUzzAFSNsW579Rml+KeRuG3up0q6L1pPpWDbL1f3FK
 lo8e4DnL39FtXczOotWoeYfjpzL1Mz7bI8KnUskvmuZWg3pkweI+Fqc+u7J3ZYGxSMlz8UEEd
 uASvtudMeETH07aUE7C2z26bt31zyXGDF8eU5TPRjyu2fGolJ9IUoMtlcuzuHpdAG+fEyhrn9
 44I12pS3bfxbyik3dXb2L9xO3jJtZmIUI3eDefXy8MglI/sN36sAaJWA51TG6B+4Atoy3roW3
 zQcQT51raS5HX9aiF/TTy6ENXYoXvF1ugsKxa3c8l+VkzCuMa13QB32KKliihfQlFT8CXaND+
 2vLngH5vs8xe/YXM6vxXbN0WH3Qg5GWuL4GfVPrmWRqJkKRnPwTbykC2LFGg=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZL8ESFiFwq9Bi81n7puXCk4DXVaIjblk2
Content-Type: multipart/mixed; boundary="q7afFEIDaNgmRCJvmEHpIIfhqi9aCaUUv"

--q7afFEIDaNgmRCJvmEHpIIfhqi9aCaUUv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/21 =E4=B8=8A=E5=8D=8812:53, Marc Lehmann wrote:
> On Fri, Dec 20, 2019 at 09:41:15PM +0800, Qu Wenruo <quwenruo.btrfs@gmx=
=2Ecom> wrote:
>> BTW, that chunk number is very small, and since it has 0 tolerance, it=

>> looks like to be SINGLE chunk.
>>
>> In that case, it looks like a temporary chunk from older mkfs, and it
>> should contain no data/metadata at all, thus brings no data loss.
>=20
> Well, there indeed should not have been any data or metadata left as th=
e
> btrfs dev del succeeded after lengthy copying.
>=20
>> BTW, "btrfs ins dump-tree -t chunk <dev>" would help a lot.
>> That would directly tell us if the devid 1 device is in chunk tree.
>=20
> Apologies if I wasn't too clear about it - I already had to mkfs and
> redo the filesystem. I understand that makes tracking this down hard or=

> impossible, but I did need that machine and filesystem.
>=20
>>> And if you want to hear more "insane" things, after I hard-reset
>>> my desktop machine (5.2.21) two days ago I had to "btrfs rescue
>>> fix-device-size" to be able to mount (can't find the kernel error atm=
=2E).
>>
>> Consider all these insane things, I tend to believe there is some
>> FUA/FLUSH related hardware problem.
>=20
> Please don't - I honestly think btrfs developers are way to fast to bla=
me
> hardware for problems. I currently lose btrfs filesystems about once ev=
ery
> 6 months, and other than the occasional user error, it's always the ker=
nel
> (e.g. 4.11 corrupting data, dmcache and/or bcache corrupting things,
> low-memory situations etc. - none of these seem to be centric to btrfs,=

> but none of those are hardware errors either). I know its the kernel in=

> most cases because in those cases, I can identify the fix in a later
> kernel, or the mitigating circumstances don't appear (e.g. freezes).
>=20
> In any case if it is a hardware problem, then linux and/or btrfs has
> to work around them, because it affects many different controllers on
> different boards:
>=20
> - dell perc h740 on "doom" and "cerebro"
> - intel series 9 controller on "doom'" and "cerebro".
> - samsung nvme controller on "yoyo" and "yuna".
> - marvell sata controller on "doom".
>=20
> Just while I was writing this mail, on 5.4.5, the _newly created_ btrfs=

> filesystem I restored to went into readonly mode with ENOSPC. Another
> hardware problem?
>=20
> [41801.618772] ------------[ cut here ]------------
> [41801.618776] BTRFS: Transaction aborted (error -28)

According to your later replies, this bug turns out to be a problem in
over-commit calculation.

It doesn't really take disk requirement into consideration, thus can't
handle cases like 3 disks RAID1 with 2 full disks.
Now it acts just like we're using DUP profiles, thus causing the problem.=


To Josef, any idea to fix it?
I guess we could go the complex statfs() way to do a calculation on how
many bytes can really be allocated.

Or hugely reduce the over-commit threshold?

Thanks,
Qu

> [41801.618843] WARNING: CPU: 2 PID: 5713 at fs/btrfs/inode.c:3159 btrfs=
_finish_ordered_io+0x730/0x820 [btrfs]
> [41801.618844] Modules linked in: nfsv3 nfs fscache nvidia_modeset(POE)=
 nvidia(POE) btusb algif_skcipher af_alg dm_crypt nfsd auth_rpcgss nfs_ac=
l lockd grace cls_fw sch_htb sit tunnel4 ip_tunnel hidp act_police cls_u3=
2 sch_ingress sch_tbf 8021q garp mrp stp llc ip6t_REJECT nf_reject_ipv6 x=
t_CT xt_MASQUERADE xt_nat xt_REDIRECT nft_chain_nat nf_nat xt_owner xt_TC=
PMSS xt_DSCP xt_mark nf_log_ipv4 nf_log_common xt_LOG xt_state xt_conntra=
ck nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4 x=
t_length xt_mac xt_tcpudp nft_compat nft_counter nf_tables xfrm_user xfrm=
_algo nfnetlink cmac uhid bnep tda10021 snd_hda_codec_hdmi binfmt_misc nl=
s_iso8859_1 intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_p=
owerclamp kvm_intel kvm irqbypass tda827x tda10023 crct10dif_pclmul mei_h=
dcp crc32_pclmul btrtl btbcm rc_tt_1500 ghash_clmulni_intel snd_emu10k1 b=
tintel snd_util_mem snd_ac97_codec aesni_intel bluetooth snd_hda_intel bu=
dget_av snd_rawmidi snd_intel_nhlt crypto_simd saa7146_vv
> [41801.618864]  snd_hda_codec videobuf_dma_sg budget_ci videobuf_core s=
nd_seq_device budget_core cryptd ttpci_eeprom glue_helper snd_hda_core sa=
a7146 dvb_core intel_cstate ac97_bus snd_hwdep rc_core snd_pcm intel_rapl=
_perf mxm_wmi cdc_acm pcspkr videodev snd_timer ecdh_generic snd emu10k1_=
gp ecc mc gameport soundcore mei_me mei mac_hid acpi_pad tcp_bbr drm_kms_=
helper drm fb_sys_fops syscopyarea sysfillrect sysimgblt ipmi_devintf ipm=
i_msghandler hid_generic usbhid hid usbkbd coretemp nct6775 hwmon_vid sun=
rpc parport_pc ppdev lp parport msr ip_tables x_tables autofs4 btrfs zstd=
_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xo=
r async_tx xor raid6_pq raid1 raid0 multipath linear dm_cache_smq dm_cach=
e dm_persistent_data dm_bio_prison dm_bufio libcrc32c ahci megaraid_sas i=
2c_i801 libahci lpc_ich r8169 realtek wmi video [last unloaded: nvidia]
> [41801.618887] CPU: 2 PID: 5713 Comm: kworker/u8:15 Tainted: P         =
  OE     5.4.5-050405-generic #201912181630
> [41801.618888] Hardware name: MSI MS-7816/Z97-G43 (MS-7816), BIOS V17.8=
 12/24/2014
> [41801.618903] Workqueue: btrfs-endio-write btrfs_endio_write_helper [b=
trfs]
> [41801.618916] RIP: 0010:btrfs_finish_ordered_io+0x730/0x820 [btrfs]
> [41801.618917] Code: 49 8b 46 50 f0 48 0f ba a8 40 ce 00 00 02 72 1c 8b=
 45 b0 83 f8 fb 0f 84 d4 00 00 00 89 c6 48 c7 c7 48 33 62 c0 e8 eb 9c 91 =
d5 <0f> 0b 8b 4d b0 ba 57 0c 00 00 48 c7 c6 40 67 61 c0 4c 89 f7 bb 01
> [41801.618918] RSP: 0018:ffffc18b40edfd80 EFLAGS: 00010282
> [41801.618921] BTRFS: error (device dm-35) in btrfs_finish_ordered_io:3=
159: errno=3D-28 No space left
> [41801.618922] RAX: 0000000000000000 RBX: ffff9f8b7b2e3800 RCX: 0000000=
000000006
> [41801.618922] BTRFS info (device dm-35): forced readonly
> [41801.618924] RDX: 0000000000000007 RSI: 0000000000000092 RDI: ffff9f8=
bbeb17440
> [41801.618924] RBP: ffffc18b40edfdf8 R08: 00000000000005a6 R09: fffffff=
f979a4d90
> [41801.618925] R10: ffffffff97983fa8 R11: ffffc18b40edfbe8 R12: ffff9f8=
ad8b4ab60
> [41801.618926] R13: ffff9f867ddb53c0 R14: ffff9f8bbb0446e8 R15: 0000000=
000000000
> [41801.618927] FS:  0000000000000000(0000) GS:ffff9f8bbeb00000(0000) kn=
lGS:0000000000000000
> [41801.618928] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [41801.618929] CR2: 00007f8ab728fc30 CR3: 000000049080a002 CR4: 0000000=
0001606e0
> [41801.618930] Call Trace:
> [41801.618943]  finish_ordered_fn+0x15/0x20 [btrfs]
> [41801.618957]  normal_work_helper+0xbd/0x2f0 [btrfs]
> [41801.618959]  ? __schedule+0x2eb/0x740
> [41801.618973]  btrfs_endio_write_helper+0x12/0x20 [btrfs]
> [41801.618975]  process_one_work+0x1ec/0x3a0
> [41801.618977]  worker_thread+0x4d/0x400
> [41801.618979]  kthread+0x104/0x140
> [41801.618980]  ? process_one_work+0x3a0/0x3a0
> [41801.618982]  ? kthread_park+0x90/0x90
> [41801.618984]  ret_from_fork+0x1f/0x40
> [41801.618985] ---[ end trace 35086266bf39c897 ]---
> [41801.618987] BTRFS: error (device dm-35) in btrfs_finish_ordered_io:3=
159: errno=3D-28 No space left
>=20
> unmount/remount seems to make it work again, and it is full (df) yet ha=
s
> 3TB of unallocated space left. No clue what to do now, do I have to sta=
rt
> over restoring again?
>=20
>    Filesystem               Size  Used Avail Use% Mounted on
>    /dev/mapper/xmnt-cold15   27T   23T     0 100% /cold1
>=20
>    Overall:
>        Device size:                       24216.49GiB
>        Device allocated:                  20894.89GiB
>        Device unallocated:                 3321.60GiB
>        Device missing:                        0.00GiB
>        Used:                              20893.68GiB
>        Free (estimated):                   3322.73GiB      (min: 1661.9=
3GiB)
>        Data ratio:                               1.00
>        Metadata ratio:                           2.00
>        Global reserve:                        0.50GiB      (used: 0.00G=
iB)
>=20
>    Data,single: Size:20839.01GiB, Used:20837.88GiB (99.99%)
>       /dev/mapper/xmnt-cold15      9288.01GiB
>       /dev/mapper/xmnt-cold12      7427.00GiB
>       /dev/mapper/xmnt-cold13      4124.00GiB
>=20
>    Metadata,RAID1: Size:27.91GiB, Used:27.90GiB (99.97%)
>       /dev/mapper/xmnt-cold15        25.44GiB
>       /dev/mapper/xmnt-cold12        24.46GiB
>       /dev/mapper/xmnt-cold13         5.91GiB
>=20
>    System,RAID1: Size:0.03GiB, Used:0.00GiB (6.69%)
>       /dev/mapper/xmnt-cold15         0.03GiB
>       /dev/mapper/xmnt-cold12         0.03GiB
>=20
>    Unallocated:
>       /dev/mapper/xmnt-cold15         0.01GiB
>       /dev/mapper/xmnt-cold12         0.00GiB
>       /dev/mapper/xmnt-cold13      3321.59GiB
>=20
> Please, don't always chalk it up to hardware problems - btrfs is a
> wonderful filesystem for many reasons, one reason I like is that it can=

> detect corruption much earlier than other filesystems. This featire alo=
ne
> makes it impossible for me to go back to xfs. However, I had corruption=

> on ext4, xfs, reiserfs over the years, but btrfs *is* simply way buggie=
r
> still than those - before btrfs (and even now) I kept md5sums of all
> archived files (~200TB), and xfs and ext4 _do_ a much better job at not=

> corrupting data than btrfs on the same hardware - while I get filesyste=
m
> problems about every half a year with btrfs, I had (silent) corruption
> problems maybe once every three to four years with xfs or ext4 (and not=

> yet on the bxoes I use currently).
>=20
> Please take these issues seriously - the trend of "it's a hardware
> problem" will not remove the "unstable" stigma from btrfs as long as bt=
rfs
> is clearly more buggy then other filesystems.
>=20
> Sorry to be so blunt, but I am a bit sensitive with always being told
> "it's probably a hardware problem" when it clearly affects practically =
any
> server and any laptop I administrate. I believe in btrfs, and detecting=

> corruption early is a feature to me.
>=20
> I understand it can be frustrating to be confronted with hard to explai=
n
> accidents, and I understand if you can't find the bug with the sparse i=
nfo
> I gave, especially as the bug might not even be in btrfs. But keep in m=
ind
> that the people who boldly/dumbly use btrfs in production and restore
> dozens of terabytes from backup every so and so many months are also be=
ing
> frustrated if they present evidence from multiple machines and get told=

> "its probably a hardware problem".
>=20


--q7afFEIDaNgmRCJvmEHpIIfhqi9aCaUUv--

--ZL8ESFiFwq9Bi81n7puXCk4DXVaIjblk2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl39diUACgkQwj2R86El
/qhlOQf/dKOi2oC2KRlIG8G1adoF5kwwXXaKROFf2X1eV1oXwyktMVwh8rLrn+oj
8llnjRn1MmtbF5znvYbg6roJxoseVxnwwlGizyVgHXVABPrjfgTb3dFmmOPHqPZH
SSwlvs30ABNov6TMoQpRZAXWhO/B78YUJWIrQi9VQG9VjSP8hkVPQG9WHPl5Aq6t
CYiAsWBtrk4YVhYeenRvZw9qk3nW/q50XpIK59fp+w4k1JQuiwNZf6Pm/g+Y64qZ
L3APf/AKMDRwQvqfoOXLNWrV2nsVMYh7ceW4rQjtsZIJQSKZNxv0dGsj5fdJU3x7
L7aVoemqc89h85kicJOYOT26F9xOgA==
=Wf6Q
-----END PGP SIGNATURE-----

--ZL8ESFiFwq9Bi81n7puXCk4DXVaIjblk2--
