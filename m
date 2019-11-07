Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D740F256F
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Nov 2019 03:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732876AbfKGCal (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Nov 2019 21:30:41 -0500
Received: from mout.gmx.net ([212.227.15.18]:43899 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732699AbfKGCak (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 Nov 2019 21:30:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573093818;
        bh=RaLpifsJFI+jmPNwwbLCff18PGGk8QtYHSxR6CkpiYo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=KSqq9U9/JGLdKFo3GS3Pw8uEGpOTtkWwtLZGnePptSS+kYAsukITUKEsZtlqJM1mp
         zjSBIx1NmTQ8dYUVca6w60jl/0TThaMGf5sOBVEjYOgs03NGwaUQz6aTWW2OVxLhIK
         W2vvG5cyFtsqNVjnE0oBOPh4haWceLVVTRV01nNg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZTqW-1iOok30Ojm-00WUhS; Thu, 07
 Nov 2019 03:30:18 +0100
Subject: Re: __btrfs_free_extent error after suspend resume
To:     Leonard Lausen <leonard@lausen.nl>, linux-btrfs@vger.kernel.org
References: <878sotrhyi.fsf@lausen.nl> <87blto1lwx.fsf@lausen.nl>
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
Message-ID: <7d16efdd-f6f9-9580-d361-a00251b6634c@gmx.com>
Date:   Thu, 7 Nov 2019 10:30:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <87blto1lwx.fsf@lausen.nl>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="toCPwoRBqvQEh04Aw9LNI3hAxpViugOi1"
X-Provags-ID: V03:K1:QrOWaeqtj67vMzizCTiGozglAKRZ9aaGp6gROW9tY0fJ2tBEDJa
 xtxQ1UmnqqLD50cScy2GeDVPY+gK+is5W1ieqK55M8j9gmAc21NMj/IbDYRnt4igQWTEvQn
 Jiwv4dzdE4j3aY/YHtf3Rg/Dmu7C9uR6hdBFW+lqoSCoEJ0pZK02KVXhkjXYHMVrmyqxZxz
 ZblKp8SEL4FkzCdPGGxqg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gbi7A4wVQBY=:mH08WcedqzeFgb0ky4njMZ
 WZpxx0nKnOOKLr7a4xLIsNhoHH79jP0fxs1+1CqE6Ivqk+zsJlzZtXhzNCLiwQv4iwWINH5TP
 tm4yJTNImEA/lroRSywCTLY4ZmsRuA5ArsmTiifDbP3zO2GPAIOHL2FnqUwImtSvuHG5oHqdo
 Gko9Puqzmu+8GgffFrQdXu0naFN3QdbKFp8Hb2jIkSKW9ZzWy5AltS+wBSpFLVcunfFQtKj+X
 mrQOqslbVPvFCYh3aVQklgMeQcbEACQtnmL4/nTGl8QWx4HK/w1BFQ8iu2+zv87orFSluoG/v
 MEQWV2jAY6uBYgwhit63NYXJxICT79iBqwQkElagkbHMPQTJMCKKI1xg7RLhVXzxdomdfPgUU
 eTAN7QDKg6kYmkSAVvNC7y83UyNbzsdcO403RF/JFRu4gzCveULjvC96prXNz7vzSKZD57ooN
 pHsy9RkSfLcvtY9+WPgIPf1UoKrEslxpkA17awSIoCE8cdeJNMuqow5GE6IMr9nCLto2lH2Kb
 ztwXX0vVtM/NNT1Tk8O3O39bCRhAEir5NpUykdFVTB2loe4S+XPwle4vihQtQi9AlRfUfzDG+
 xqqIS0dxkxa6IHCqvFuf8HFduBVgMHHppdlzVOMu+uQ4U3b1AFcEaKIGOnnSIWaFWhKFVTS+w
 qlxzLV2SaXSnto5GH4hg/cP79HNWggZjQg5QXcHc+5KXIjSLhGi0EpP7IJ+bwairFUrFl/n7Y
 DTsld6ml1FR0+1K8MAFvVznz6LuerOIOFy/K6LkLO0BypHIkw1Zbat5k+gZSvuNxAp69RDzY0
 wGvNxaihmU8CHsY/jFFEvcpftyCJ8DQzdd/Z/bXhc+43/FVfuy9IOkVvLD7sLDxollUKP/yM2
 nBb6af1sSnIVYjUerM9UqgFkieDsfGUwnu/SGW/Em8V59T74cpOL7KNFDj6mbeWBDLLfx6ChZ
 3WuHc0Ow5EzQFNnVSgGfHQ3AMZrK/SihasFZqxAOv2L/RmAGpwClJNTJtEmGYkEsSCKLSCQaF
 plwBfBOUBt68AAVv5wpuo0gAA3aXsHtsQP5/Bld9+5Dtm1RWJorsqqrOL9HJPAdwivB8kwyHm
 KuyQGuP6FCwXjt9xTqciaBWih8Rf9pv3CLhs+8DOSwsiVq5q+UXNqx6QUBNQjc8NAE4tOKDJ9
 BBk3cVoCqMfmF+H4H3WfiiBxLbOAz3QschhYpB8a32tbr3tX5Uds+5xfs58me6NAmGwejjnPU
 ys5F4YzzJJhCEA+x6j8sCq3Ch8aFkBr1uHroZRim5yhNKS3brXlDS2zqNEEU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--toCPwoRBqvQEh04Aw9LNI3hAxpViugOi1
Content-Type: multipart/mixed; boundary="t8q4o106zbo2oj3oRd699PAGzn6A7Z1f6"

--t8q4o106zbo2oj3oRd699PAGzn6A7Z1f6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/7 =E4=B8=8A=E5=8D=8810:05, Leonard Lausen wrote:
> It seems this bug is indeed similar to <20191018025604.GA31526@merlins.=
org>.
> Running
>=20
>     btrfs check --readonly /dev/$NAME
>=20
> runs out of 16GB of memory within 20 seconds and is killed by the
> kernel.

That's why we have btrfs check --mode=3Dlowmem

Thanks,
Qu
>=20
> No errors are displayed and the only output is
>=20
>   [1/7] checking root items
>   [2/7] checking extents
>=20
> btrfs check does not seem to contain a verbose mode? Is there anything
> you would like me to do to help debug btrfs check, if not help debug th=
e
> root cause of this bug in the first place?
>=20
> Please let me know.
>=20
> Best regards
> Leonard
>=20
> Leonard Lausen <leonard@lausen.nl> writes:
>> Hi,
>>
>> I just found my btrfs filesystem to be remounted read-only with the
>> stacktrace below. (Similar experience to 87d0oyw46b.fsf@lausen.nl
>> earlier this year). Similar to <20191018025604.GA31526@merlins.org>, I=

>> experience the following stacktrace following a suspend / resume cycle=
=2E
>> The system runs Linux 5.3.8 (unlike 5.1.21 in the previous report),
>> suggesting that the bug is around for a few months already.
>> Prior to suspension, I ran several compilation jobs. They all finished=

>> without error.
>>
>> You may find the output of
>>
>>   sudo btrfs inspect dump-tree -t root
>>
>> and
>>
>>   sudo btrfs inspect dump-super
>>
>> at http://termbin.com/ddxq and http://termbin.com/4mqt
>>
>> The stacktrace is pasted below at the complete dmesg output at http://=
termbin.com/kr2j
>>
>> As the bug affects the root partition, I suspect I won't be able to
>> boot the system after turning it off. Thus I leave it running for now
>> and can provide you with further information if so instructed.
>>
>> Please also let me know if you suspect any chance to repair this
>> filesystem.
>>
>> Best regards
>> Leonard
>>
>>
>> [354437.150593] ------------[ cut here ]------------
>> [354437.150639] WARNING: CPU: 3 PID: 9095 at fs/btrfs/extent-tree.c:48=
51 __btrfs_free_extent+0x20d/0x8fd [btrfs]
>> [354437.150641] Modules linked in: rfcomm cmac bnep msr bridge stp llc=
 ip_tables x_tables serpent_sse2_x86_64 serpent_avx2 serpent_avx_x86_64 a=
lgif_skcipher dm_zero dm_thin_pool dm_persistent_data dm_bio_prison dm_se=
rvice_time dm_round_robin dm_queue_length dm_multipath dm_log_userspace d=
m_flakey dm_delay virtio_scsi virtio_console sha1_generic iscsi_tcp libis=
csi_tcp libiscsi scsi_transport_iscsi ixgb ixgbe samsung_sxgbe tulip cxgb=
3 cxgb mdio cxgb4 vxge vxlan ip6_udp_tunnel udp_tunnel macvlan vmxnet3 vi=
rtio_net net_failover failover tg3 sky2 r8169 libphy pcnet32 mii igb dca =
e1000 bnx2 atl1c fuse overlay nfs lockd grace sunrpc btrfs zstd_decompres=
s zstd_compress xxhash multipath linear raid10 raid1 raid0 dm_raid raid45=
6 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq=
 dm_snapshot dm_bufio dm_mirror dm_region_hash dm_log firewire_sbp2 firew=
ire_ohci firewire_core hid_sunplus hid_sony hid_samsung hid_pl hid_petaly=
nx hid_monterey hid_microsoft hid_gyration hid_ezkey
>> [354437.150664]  hid_cypress hid_chicony hid_cherry hid_belkin hid_a4t=
ech sl811_hcd xhci_plat_hcd usb_storage mpt3sas raid_class aic94xx libsas=
 lpfc qla2xxx megaraid_sas megaraid_mbox megaraid_mm megaraid aacraid sx8=
 hpsa 3w_9xxx 3w_xxxx mptsas mptfc scsi_transport_fc mptspi mptscsih mptb=
ase atp870u dc395x qla1280 dmx3191d sym53c8xx gdth initio BusLogic arcmsr=
 aic7xxx aic79xx scsi_transport_spi sg pdc_adma sata_inic162x sata_mv ata=
_piix ahci libahci sata_qstor sata_vsc sata_uli sata_sis sata_sx4 sata_nv=
 sata_via sata_svw sata_sil24 sata_sil sata_promise pata_sl82c105 pata_vi=
a pata_jmicron pata_marvell pata_sis pata_netcell pata_pdc202xx_old pata_=
triflex pata_atiixp pata_amd pata_ali pata_it8213 pata_pcmcia pcmcia pcmc=
ia_core pata_ns87415 pata_ns87410 pata_serverworks pata_artop pata_it821x=
 pata_hpt3x2n pata_hpt3x3 pata_hpt37x pata_hpt366 pata_cmd64x pata_efar p=
ata_rz1000 pata_sil680 pata_radisys pata_pdc2027x pata_mpiix snd_hda_code=
c_hdmi btusb btrtl btbcm btintel uvcvideo bluetooth
>> [354437.150694]  videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 vid=
eodev ecdh_generic ecc videobuf2_common x86_pkg_temp_thermal intel_powerc=
lamp coretemp kvm_intel kvm irqbypass snd_hda_codec_realtek snd_hda_codec=
_generic crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel a=
th10k_pci ath10k_core ath mac80211 i915 i2c_algo_bit aesni_intel snd_hda_=
intel dell_laptop dell_wmi ledtrig_audio snd_hda_codec drm_kms_helper del=
l_smbios rtsx_pci_sdmmc intel_rapl_msr wmi_bmof sparse_keymap dell_wmi_de=
scriptor aes_x86_64 cfg80211 input_leds crypto_simd snd_hda_core snd_hwde=
p cryptd drm dcdbas snd_pcm glue_helper i2c_i801 mmc_core rfkill processo=
r_thermal_device libarc4 pcspkr serio_raw intel_rapl_common intel_pch_the=
rmal intel_soc_dts_iosf iosf_mbi wmi int3403_thermal int340x_thermal_zone=
 int3400_thermal acpi_thermal_rel joydev
>> [354437.150717] CPU: 3 PID: 9095 Comm: kworker/3:1 Tainted: G        W=
         5.3.6-gentoo-r1 #2
>> [354437.150718] Hardware name: Dell Inc. XPS 13 9360/06CC14, BIOS 2.11=
=2E0 03/14/2019
>> [354437.150729] Workqueue: events do_async_commit [btrfs]
>> [354437.150737] RIP: 0010:__btrfs_free_extent+0x20d/0x8fd [btrfs]
>> [354437.150739] Code: 48 83 eb 19 44 29 e8 83 f8 05 0f 8f a7 04 00 00 =
41 ff cd eb 88 83 fb fe 0f 85 9d 06 00 00 48 c7 c7 44 d5 17 c1 e8 47 6f f=
b d3 <0f> 0b 48 8b 7d 00 e8 26 26 00 00 4d 89 f0 4c 89 e9 48 c7 c6 4f dd
>> [354437.150740] RSP: 0018:ffff8e0b8605fc28 EFLAGS: 00010246
>> [354437.150741] RAX: 0000000000000024 RBX: 00000000fffffffe RCX: 00000=
00000000000
>> [354437.150742] RDX: 0000000000000000 RSI: ffff8ae42e397338 RDI: ffff8=
ae42e397338
>> [354437.150743] RBP: ffff8ae2a2bac310 R08: 0000000000000006 R09: fffff=
fff9f4db100
>> [354437.150744] R10: 0000000000003388 R11: ffff8e0b8605fad0 R12: ffff8=
ae2e9ec0208
>> [354437.150745] R13: 000001426cccc000 R14: 0000000000000101 R15: 00000=
000956e0000
>> [354437.150746] FS:  0000000000000000(0000) GS:ffff8ae42e380000(0000) =
knlGS:0000000000000000
>> [354437.150746] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [354437.150747] CR2: 00000000008c5487 CR3: 000000046a108001 CR4: 00000=
000003606e0
>> [354437.150748] Call Trace:
>> [354437.150758]  __btrfs_run_delayed_refs+0x690/0xc6c [btrfs]
>> [354437.150762]  ? __switch_to_asm+0x40/0x70
>> [354437.150770]  btrfs_run_delayed_refs+0x5e/0x149 [btrfs]
>> [354437.150778]  btrfs_commit_transaction+0x78/0x8a0 [btrfs]
>> [354437.150780]  ? __switch_to_asm+0x34/0x70
>> [354437.150781]  ? __switch_to_asm+0x40/0x70
>> [354437.150782]  ? __switch_to_asm+0x34/0x70
>> [354437.150783]  ? __switch_to_asm+0x40/0x70
>> [354437.150784]  ? __switch_to_asm+0x34/0x70
>> [354437.150792]  do_async_commit+0x1d/0x27 [btrfs]
>> [354437.150795]  process_one_work+0x16e/0x24e
>> [354437.150797]  ? rescuer_thread+0x28c/0x28c
>> [354437.150798]  worker_thread+0x1dc/0x2ac
>> [354437.150799]  kthread+0x10b/0x113
>> [354437.150801]  ? kthread_park+0x89/0x89
>> [354437.150802]  ret_from_fork+0x35/0x40
>> [354437.150804] ---[ end trace 85833d33b2b02bcf ]---
>> [354437.150807] BTRFS info (device dm-2): leaf 1426551308288 gen 24020=
58 total ptrs 138 free space 3656 owner 2
>> [354437.150808] 	item 0 key (1776065458176 168 262144) itemoff 16233 i=
temsize 50
>> [354437.150808] 		extent refs 2 gen 2399043 flags 1
>> [354437.150809] 		ref#0: shared data backref parent 1385529737216 coun=
t 1
>> [354437.150809] 		ref#1: shared data backref parent 1383731085312 coun=
t 1
>> [354437.150810] 	item 1 key (1776065720320 168 262144) itemoff 16157 i=
temsize 76
>> [354437.150811] 		extent refs 4 gen 2399043 flags 1
>> [354437.150811] 		ref#0: shared data backref parent 1478537773056 coun=
t 1
>> [354437.150812] 		ref#1: shared data backref parent 1469189111808 coun=
t 1
>> [354437.150812] 		ref#2: shared data backref parent 1385529737216 coun=
t 1
>> [354437.150813] 		ref#3: shared data backref parent 1384804827136 coun=
t 1
>> [354437.150814] 	item 2 key (1776066007040 168 4526080) itemoff 16104 =
itemsize 53
>> [354437.150814] 		extent refs 1 gen 1220365 flags 1
>> [354437.150814] 		ref#0: extent data backref root 2829 objectid 28509 =
offset 55762944 count 1
>> [354437.150816] 	item 3 key (1776070533120 168 262144) itemoff 16041 i=
temsize 63
>> [354437.150816] 		extent refs 3 gen 2399043 flags 1
>> [354437.150816] 		ref#0: shared data backref parent 1469189111808 coun=
t 1
>> [354437.150817] 		ref#1: shared data backref parent 1385529737216 coun=
t 1
>> [354437.150817] 		ref#2: shared data backref parent 1384804827136 coun=
t 1
>> [354437.150818] 	item 4 key (1776070795264 168 262144) itemoff 16004 i=
temsize 37
>> [354437.150819] 		extent refs 1 gen 2399043 flags 1
>> [354437.150819] 		ref#0: shared data backref parent 1384804827136 coun=
t 1
>> [354437.150820] 	item 5 key (1776071057408 168 262144) itemoff 15889 i=
temsize 115
>> [354437.150820] 		extent refs 7 gen 2399043 flags 1
>> [354437.150820] 		ref#0: shared data backref parent 1571827269632 coun=
t 1
>> [354437.150821] 		ref#1: shared data backref parent 1515792695296 coun=
t 1
>> [354437.150822] 		ref#2: shared data backref parent 1483800084480 coun=
t 1
>> [354437.150822] 		ref#3: shared data backref parent 1478537773056 coun=
t 1
>> [354437.150823] 		ref#4: shared data backref parent 1469189111808 coun=
t 1
>> [354437.150823] 		ref#5: shared data backref parent 1385529737216 coun=
t 1
>> [354437.150824] 		ref#6: shared data backref parent 1384804827136 coun=
t 1
>> [354437.150824] 	item 6 key (1776071319552 168 262144) itemoff 15761 i=
temsize 128
>> [354437.150825] 		extent refs 8 gen 2399043 flags 1
>> [354437.150825] 		ref#0: shared data backref parent 1571827269632 coun=
t 1
>> [354437.150826] 		ref#1: shared data backref parent 1515792695296 coun=
t 1
>> [354437.150826] 		ref#2: shared data backref parent 1483800084480 coun=
t 1
>> [354437.150827] 		ref#3: shared data backref parent 1478537773056 coun=
t 1
>> [354437.150827] 		ref#4: shared data backref parent 1469189111808 coun=
t 1
>> [354437.150828] 		ref#5: shared data backref parent 1385529737216 coun=
t 1
>> [354437.150828] 		ref#6: shared data backref parent 1385250930688 coun=
t 1
>> [354437.150829] 		ref#7: shared data backref parent 1384804827136 coun=
t 1
>> [354437.150830] 	item 7 key (1776071581696 168 262144) itemoff 15685 i=
temsize 76
>> [354437.150830] 		extent refs 4 gen 2399043 flags 1
>> [354437.150830] 		ref#0: shared data backref parent 1478537773056 coun=
t 1
>> [354437.150831] 		ref#1: shared data backref parent 1469189111808 coun=
t 1
>> [354437.150831] 		ref#2: shared data backref parent 1385529737216 coun=
t 1
>> [354437.150832] 		ref#3: shared data backref parent 1384804827136 coun=
t 1
>> [354437.150833] 	item 8 key (1776071843840 168 262144) itemoff 15596 i=
temsize 89
>> [354437.150833] 		extent refs 5 gen 2399043 flags 1
>> [354437.150833] 		ref#0: shared data backref parent 1483800084480 coun=
t 1
>> [354437.150834] 		ref#1: shared data backref parent 1478537773056 coun=
t 1
>> [354437.150834] 		ref#2: shared data backref parent 1469189111808 coun=
t 1
>> [354437.150835] 		ref#3: shared data backref parent 1385529737216 coun=
t 1
>> [354437.150835] 		ref#4: shared data backref parent 1384804827136 coun=
t 1
>> [354437.150836] 	item 9 key (1776072105984 168 262144) itemoff 15520 i=
temsize 76
>> [354437.150837] 		extent refs 4 gen 2399043 flags 1
>> [354437.150837] 		ref#0: shared data backref parent 1478537773056 coun=
t 1
>> [354437.150837] 		ref#1: shared data backref parent 1469189111808 coun=
t 1
>> [354437.150838] 		ref#2: shared data backref parent 1385529737216 coun=
t 1
>> [354437.150838] 		ref#3: shared data backref parent 1384804827136 coun=
t 1
>> [354437.150839] 	item 10 key (1776072368128 168 262144) itemoff 15444 =
itemsize 76
>> [354437.150840] 		extent refs 5 gen 2399043 flags 1
>> [354437.150840] 		ref#0: shared data backref parent 1478537773056 coun=
t 2
>> [354437.150841] 		ref#1: shared data backref parent 1469189111808 coun=
t 1
>> [354437.150841] 		ref#2: shared data backref parent 1385529737216 coun=
t 1
>> [354437.150842] 		ref#3: shared data backref parent 1384804827136 coun=
t 1
>> [354437.150842] 	item 11 key (1776072630272 168 262144) itemoff 15329 =
itemsize 115
>> [354437.150843] 		extent refs 7 gen 2399043 flags 1
>> [354437.150843] 		ref#0: shared data backref parent 1571827269632 coun=
t 1
>> [354437.150844] 		ref#1: shared data backref parent 1515792695296 coun=
t 1
>> [354437.150844] 		ref#2: shared data backref parent 1483800084480 coun=
t 1
>> [354437.150845] 		ref#3: shared data backref parent 1478537773056 coun=
t 1
>> [354437.150845] 		ref#4: shared data backref parent 1469189111808 coun=
t 1
>> [354437.150846] 		ref#5: shared data backref parent 1385529737216 coun=
t 1
>> [354437.150846] 		ref#6: shared data backref parent 1384804827136 coun=
t 1
>> [354437.150847] 	item 12 key (1776072892416 168 262144) itemoff 15240 =
itemsize 89
>> [354437.150847] 		extent refs 5 gen 2399043 flags 1
>> [354437.150848] 		ref#0: shared data backref parent 1483800084480 coun=
t 1
>> [354437.150848] 		ref#1: shared data backref parent 1478537773056 coun=
t 1
>> [354437.150849] 		ref#2: shared data backref parent 1469189111808 coun=
t 1
>> [354437.150849] 		ref#3: shared data backref parent 1385529737216 coun=
t 1
>> [354437.150850] 		ref#4: shared data backref parent 1384804827136 coun=
t 1
>> [354437.150851] 	item 13 key (1776073154560 168 262144) itemoff 15125 =
itemsize 115
>> [354437.150851] 		extent refs 7 gen 2399043 flags 1
>> [354437.150851] 		ref#0: shared data backref parent 1571827286016 coun=
t 1
>> [354437.150852] 		ref#1: shared data backref parent 1515792728064 coun=
t 1
>> [354437.150852] 		ref#2: shared data backref parent 1483638177792 coun=
t 1
>> [354437.150853] 		ref#3: shared data backref parent 1478537805824 coun=
t 1
>> [354437.150853] 		ref#4: shared data backref parent 1469189111808 coun=
t 1
>> [354437.150854] 		ref#5: shared data backref parent 1385529737216 coun=
t 1
>> [354437.150854] 		ref#6: shared data backref parent 1384804827136 coun=
t 1
>> [354437.150855] 	item 14 key (1776073416704 168 262144) itemoff 15088 =
itemsize 37
>> [354437.150856] 		extent refs 1 gen 2399043 flags 1
>> [354437.150856] 		ref#0: shared data backref parent 1384804892672 coun=
t 1
>> [354437.150857] 	item 15 key (1776073678848 168 262144) itemoff 15012 =
itemsize 76
>> [354437.150857] 		extent refs 4 gen 2399043 flags 1
>> [354437.150857] 		ref#0: shared data backref parent 1478537805824 coun=
t 1
>> [354437.150858] 		ref#1: shared data backref parent 1469188898816 coun=
t 1
>> [354437.150858] 		ref#2: shared data backref parent 1385534652416 coun=
t 1
>> [354437.150859] 		ref#3: shared data backref parent 1384804892672 coun=
t 1
>> [354437.150860] 	item 16 key (1776073940992 168 393216) itemoff 14884 =
itemsize 128
>> [354437.150860] 		extent refs 8 gen 2399043 flags 1
>> [354437.150860] 		ref#0: shared data backref parent 1571827286016 coun=
t 1
>> [354437.150861] 		ref#1: shared data backref parent 1515792728064 coun=
t 1
>> [354437.150861] 		ref#2: shared data backref parent 1483638177792 coun=
t 1
>> [354437.150862] 		ref#3: shared data backref parent 1478537805824 coun=
t 1
>> [354437.150862] 		ref#4: shared data backref parent 1469188898816 coun=
t 1
>> [354437.150863] 		ref#5: shared data backref parent 1385534652416 coun=
t 1
>> [354437.150864] 		ref#6: shared data backref parent 1385251684352 coun=
t 1
>> [354437.150864] 		ref#7: shared data backref parent 1384804892672 coun=
t 1
>> [354437.150865] 	item 17 key (1776074334208 168 262144) itemoff 14626 =
itemsize 258
>> [354437.150865] 		extent refs 19 gen 2399043 flags 1
>> [354437.150866] 		ref#0: shared data backref parent 1571827286016 coun=
t 1
>> [354437.150866] 		ref#1: shared data backref parent 1571768385536 coun=
t 1
>> [354437.150867] 		ref#2: shared data backref parent 1515792728064 coun=
t 1
>> [354437.150867] 		ref#3: shared data backref parent 1483744641024 coun=
t 1
>> [354437.150868] 		ref#4: shared data backref parent 1483638177792 coun=
t 1
>> [354437.150868] 		ref#5: shared data backref parent 1478537805824 coun=
t 1
>> [354437.150869] 		ref#6: shared data backref parent 1469188898816 coun=
t 1
>> [354437.150869] 		ref#7: shared data backref parent 1468957556736 coun=
t 1
>> [354437.150870] 		ref#8: shared data backref parent 1468373499904 coun=
t 2
>> [354437.150870] 		ref#9: shared data backref parent 1452915392512 coun=
t 1
>> [354437.150871] 		ref#10: shared data backref parent 1452214419456 cou=
nt 1
>> [354437.150871] 		ref#11: shared data backref parent 1385534652416 cou=
nt 1
>> [354437.150872] 		ref#12: shared data backref parent 1385251684352 cou=
nt 1
>> [354437.150872] 		ref#13: shared data backref parent 1384934653952 cou=
nt 1
>> [354437.150873] 		ref#14: shared data backref parent 1384831401984 cou=
nt 1
>> [354437.150873] 		ref#15: shared data backref parent 1384804892672 cou=
nt 1
>> [354437.150874] 		ref#16: shared data backref parent 1321904685056 cou=
nt 1
>> [354437.150874] 		ref#17: shared data backref parent 1321555132416 cou=
nt 1
>> [354437.150875] 	item 18 key (1776074596352 168 262144) itemoff 14576 =
itemsize 50
>> [354437.150876] 		extent refs 2 gen 2399043 flags 1
>> [354437.150876] 		ref#0: shared data backref parent 1385534652416 coun=
t 1
>> [354437.150877] 		ref#1: shared data backref parent 1384804892672 coun=
t 1
>> [354437.150877] 	item 19 key (1776074907648 168 262144) itemoff 14474 =
itemsize 102
>> [354437.150878] 		extent refs 6 gen 2399058 flags 1
>> [354437.150878] 		ref#0: shared data backref parent 1571827236864 coun=
t 1
>> [354437.150879] 		ref#1: shared data backref parent 1515792482304 coun=
t 1
>> [354437.150879] 		ref#2: shared data backref parent 1483799920640 coun=
t 1
>> [354437.150880] 		ref#3: shared data backref parent 1478537527296 coun=
t 1
>> [354437.150880] 		ref#4: shared data backref parent 1469187604480 coun=
t 1
>> [354437.150881] 		ref#5: shared data backref parent 1385522872320 coun=
t 1
>> [354437.150881] 	item 20 key (1776075169792 168 262144) itemoff 14411 =
itemsize 63
>> [354437.150882] 		extent refs 3 gen 2399058 flags 1
>> [354437.150882] 		ref#0: shared data backref parent 1478537576448 coun=
t 1
>> [354437.150883] 		ref#1: shared data backref parent 1469187604480 coun=
t 1
>> [354437.150883] 		ref#2: shared data backref parent 1385522872320 coun=
t 1
>> [354437.150884] 	item 21 key (1776075431936 168 262144) itemoff 14322 =
itemsize 89
>> [354437.150884] 		extent refs 5 gen 2399058 flags 1
>> [354437.150885] 		ref#0: shared data backref parent 1515792482304 coun=
t 1
>> [354437.150885] 		ref#1: shared data backref parent 1483800068096 coun=
t 1
>> [354437.150886] 		ref#2: shared data backref parent 1478537576448 coun=
t 1
>> [354437.150886] 		ref#3: shared data backref parent 1469187604480 coun=
t 1
>> [354437.150887] 		ref#4: shared data backref parent 1385522872320 coun=
t 1
>> [354437.150888] 	item 22 key (1776075694080 168 524288) itemoff 14259 =
itemsize 63
>> [354437.150888] 		extent refs 4 gen 2399058 flags 1
>> [354437.150888] 		ref#0: shared data backref parent 1478537691136 coun=
t 1
>> [354437.150889] 		ref#1: shared data backref parent 1469188751360 coun=
t 2
>> [354437.150889] 		ref#2: shared data backref parent 1385526755328 coun=
t 1
>> [354437.150890] 	item 23 key (1776076218368 168 262144) itemoff 14196 =
itemsize 63
>> [354437.150890] 		extent refs 3 gen 2399058 flags 1
>> [354437.150891] 		ref#0: shared data backref parent 1478537691136 coun=
t 1
>> [354437.150891] 		ref#1: shared data backref parent 1469188751360 coun=
t 1
>> [354437.150892] 		ref#2: shared data backref parent 1385526755328 coun=
t 1
>> [354437.150893] 	item 24 key (1776076480512 168 524288) itemoff 14094 =
itemsize 102
>> [354437.150893] 		extent refs 6 gen 2399058 flags 1
>> [354437.150893] 		ref#0: shared data backref parent 1571827335168 coun=
t 1
>> [354437.150894] 		ref#1: shared data backref parent 1515792531456 coun=
t 1
>> [354437.150894] 		ref#2: shared data backref parent 1483800100864 coun=
t 1
>> [354437.150895] 		ref#3: shared data backref parent 1478537691136 coun=
t 1
>> [354437.150895] 		ref#4: shared data backref parent 1469188751360 coun=
t 1
>> [354437.150896] 		ref#5: shared data backref parent 1385526755328 coun=
t 1
>> [354437.150897] 	item 25 key (1776077004800 168 262144) itemoff 13992 =
itemsize 102
>> [354437.150897] 		extent refs 6 gen 2399058 flags 1
>> [354437.150897] 		ref#0: shared data backref parent 1571827335168 coun=
t 1
>> [354437.150898] 		ref#1: shared data backref parent 1515792531456 coun=
t 1
>> [354437.150898] 		ref#2: shared data backref parent 1483800100864 coun=
t 1
>> [354437.150899] 		ref#3: shared data backref parent 1478537691136 coun=
t 1
>> [354437.150899] 		ref#4: shared data backref parent 1469188751360 coun=
t 1
>> [354437.150900] 		ref#5: shared data backref parent 1385526755328 coun=
t 1
>> [354437.150901] 	item 26 key (1776077266944 168 524288) itemoff 13903 =
itemsize 89
>> [354437.150901] 		extent refs 5 gen 2399058 flags 1
>> [354437.150901] 		ref#0: shared data backref parent 1515792531456 coun=
t 1
>> [354437.150902] 		ref#1: shared data backref parent 1483800084480 coun=
t 1
>> [354437.150902] 		ref#2: shared data backref parent 1478537773056 coun=
t 1
>> [354437.150903] 		ref#3: shared data backref parent 1469188751360 coun=
t 1
>> [354437.150903] 		ref#4: shared data backref parent 1385526755328 coun=
t 1
>> [354437.150904] 	item 27 key (1776077791232 168 262144) itemoff 13840 =
itemsize 63
>> [354437.150905] 		extent refs 3 gen 2399058 flags 1
>> [354437.150905] 		ref#0: shared data backref parent 1478537773056 coun=
t 1
>> [354437.150905] 		ref#1: shared data backref parent 1469189111808 coun=
t 1
>> [354437.150906] 		ref#2: shared data backref parent 1385529737216 coun=
t 1
>> [354437.150907] 	item 28 key (1776078053376 168 262144) itemoff 13777 =
itemsize 63
>> [354437.150907] 		extent refs 3 gen 2399058 flags 1
>> [354437.150907] 		ref#0: shared data backref parent 1478537773056 coun=
t 1
>> [354437.150908] 		ref#1: shared data backref parent 1469189111808 coun=
t 1
>> [354437.150908] 		ref#2: shared data backref parent 1385529737216 coun=
t 1
>> [354437.150909] 	item 29 key (1776078315520 168 262144) itemoff 13740 =
itemsize 37
>> [354437.150910] 		extent refs 1 gen 2399058 flags 1
>> [354437.150910] 		ref#0: shared data backref parent 1385529737216 coun=
t 1
>> [354437.150911] 	item 30 key (1776078577664 168 262144) itemoff 13703 =
itemsize 37
>> [354437.150911] 		extent refs 1 gen 2399058 flags 1
>> [354437.150911] 		ref#0: shared data backref parent 1385529737216 coun=
t 1
>> [354437.150912] 	item 31 key (1776078839808 168 262144) itemoff 13601 =
itemsize 102
>> [354437.150913] 		extent refs 6 gen 2399058 flags 1
>> [354437.150913] 		ref#0: shared data backref parent 1571827269632 coun=
t 1
>> [354437.150914] 		ref#1: shared data backref parent 1515792695296 coun=
t 1
>> [354437.150914] 		ref#2: shared data backref parent 1483800084480 coun=
t 1
>> [354437.150915] 		ref#3: shared data backref parent 1478537773056 coun=
t 1
>> [354437.150915] 		ref#4: shared data backref parent 1469189111808 coun=
t 1
>> [354437.150916] 		ref#5: shared data backref parent 1385529737216 coun=
t 1
>> [354437.150916] 	item 32 key (1776079101952 168 524288) itemoff 13538 =
itemsize 63
>> [354437.150917] 		extent refs 3 gen 2399058 flags 1
>> [354437.150917] 		ref#0: shared data backref parent 1478537773056 coun=
t 1
>> [354437.150918] 		ref#1: shared data backref parent 1469189111808 coun=
t 1
>> [354437.150918] 		ref#2: shared data backref parent 1385529737216 coun=
t 1
>> [354437.150919] 	item 33 key (1776079626240 168 262144) itemoff 13462 =
itemsize 76
>> [354437.150919] 		extent refs 4 gen 2399058 flags 1
>> [354437.150920] 		ref#0: shared data backref parent 1483800084480 coun=
t 1
>> [354437.150920] 		ref#1: shared data backref parent 1478537773056 coun=
t 1
>> [354437.150921] 		ref#2: shared data backref parent 1469189111808 coun=
t 1
>> [354437.150921] 		ref#3: shared data backref parent 1385529737216 coun=
t 1
>> [354437.150922] 	item 34 key (1776079888384 168 262144) itemoff 13373 =
itemsize 89
>> [354437.150922] 		extent refs 5 gen 2399058 flags 1
>> [354437.150923] 		ref#0: shared data backref parent 1515792728064 coun=
t 1
>> [354437.150923] 		ref#1: shared data backref parent 1483638177792 coun=
t 1
>> [354437.150924] 		ref#2: shared data backref parent 1478537805824 coun=
t 1
>> [354437.150924] 		ref#3: shared data backref parent 1469189111808 coun=
t 1
>> [354437.150925] 		ref#4: shared data backref parent 1385529737216 coun=
t 1
>> [354437.150926] 	item 35 key (1776080150528 168 262144) itemoff 13310 =
itemsize 63
>> [354437.150926] 		extent refs 3 gen 2399058 flags 1
>> [354437.150926] 		ref#0: shared data backref parent 1478537805824 coun=
t 1
>> [354437.150927] 		ref#1: shared data backref parent 1469189111808 coun=
t 1
>> [354437.150927] 		ref#2: shared data backref parent 1385529737216 coun=
t 1
>> [354437.150928] 	item 36 key (1776080412672 168 262144) itemoff 13208 =
itemsize 102
>> [354437.150928] 		extent refs 7 gen 2399058 flags 1
>> [354437.150929] 		ref#0: shared data backref parent 1571827286016 coun=
t 1
>> [354437.150929] 		ref#1: shared data backref parent 1515792728064 coun=
t 1
>> [354437.150930] 		ref#2: shared data backref parent 1483638177792 coun=
t 1
>> [354437.150930] 		ref#3: shared data backref parent 1478537805824 coun=
t 2
>> [354437.150931] 		ref#4: shared data backref parent 1469188898816 coun=
t 1
>> [354437.150931] 		ref#5: shared data backref parent 1385534652416 coun=
t 1
>> [354437.150932] 	item 37 key (1776080674816 168 262144) itemoff 13132 =
itemsize 76
>> [354437.150933] 		extent refs 4 gen 2399058 flags 1
>> [354437.150933] 		ref#0: shared data backref parent 1483638177792 coun=
t 1
>> [354437.150933] 		ref#1: shared data backref parent 1478537805824 coun=
t 1
>> [354437.150934] 		ref#2: shared data backref parent 1469188898816 coun=
t 1
>> [354437.150934] 		ref#3: shared data backref parent 1385534652416 coun=
t 1
>> [354437.150935] 	item 38 key (1776080936960 168 262144) itemoff 13004 =
itemsize 128
>> [354437.150936] 		extent refs 8 gen 2399058 flags 1
>> [354437.150936] 		ref#0: shared data backref parent 1571827286016 coun=
t 1
>> [354437.150936] 		ref#1: shared data backref parent 1515792728064 coun=
t 1
>> [354437.150937] 		ref#2: shared data backref parent 1483638177792 coun=
t 1
>> [354437.150937] 		ref#3: shared data backref parent 1478537805824 coun=
t 1
>> [354437.150938] 		ref#4: shared data backref parent 1469188898816 coun=
t 1
>> [354437.150938] 		ref#5: shared data backref parent 1452915392512 coun=
t 1
>> [354437.150939] 		ref#6: shared data backref parent 1385534652416 coun=
t 1
>> [354437.150939] 		ref#7: shared data backref parent 1385251684352 coun=
t 1
>> [354437.150940] 	item 39 key (1776081199104 168 262144) itemoff 12941 =
itemsize 63
>> [354437.150941] 		extent refs 3 gen 2399058 flags 1
>> [354437.150941] 		ref#0: shared data backref parent 1478520881152 coun=
t 1
>> [354437.150941] 		ref#1: shared data backref parent 1469117497344 coun=
t 1
>> [354437.150942] 		ref#2: shared data backref parent 1426539839488 coun=
t 1
>> [354437.150943] 	item 40 key (1776081461248 168 262144) itemoff 12904 =
itemsize 37
>> [354437.150943] 		extent refs 1 gen 2399071 flags 1
>> [354437.150943] 		ref#0: shared data backref parent 1426547474432 coun=
t 1
>> [354437.150944] 	item 41 key (1776081723392 168 262144) itemoff 12867 =
itemsize 37
>> [354437.150945] 		extent refs 1 gen 2399058 flags 1
>> [354437.150945] 		ref#0: shared data backref parent 1426539839488 coun=
t 1
>> [354437.150946] 	item 42 key (1776081985536 168 262144) itemoff 12830 =
itemsize 37
>> [354437.150946] 		extent refs 1 gen 2399058 flags 1
>> [354437.150946] 		ref#0: shared data backref parent 1426539839488 coun=
t 1
>> [354437.150947] 	item 43 key (1776082247680 168 262144) itemoff 12767 =
itemsize 63
>> [354437.150948] 		extent refs 4 gen 2399058 flags 1
>> [354437.150948] 		ref#0: shared data backref parent 1478520881152 coun=
t 2
>> [354437.150948] 		ref#1: shared data backref parent 1469117497344 coun=
t 1
>> [354437.150949] 		ref#2: shared data backref parent 1426539839488 coun=
t 1
>> [354437.150950] 	item 44 key (1776082509824 168 65536) itemoff 12730 i=
temsize 37
>> [354437.150950] 		extent refs 1 gen 2401926 flags 1
>> [354437.150950] 		ref#0: shared data backref parent 1322133110784 coun=
t 1
>> [354437.150951] 	item 45 key (1776082591744 168 262144) itemoff 12693 =
itemsize 37
>> [354437.150952] 		extent refs 1 gen 2395510 flags 1
>> [354437.150952] 		ref#0: shared data backref parent 1516486574080 coun=
t 1
>> [354437.150953] 	item 46 key (1776083095552 168 6983680) itemoff 12640=
 itemsize 53
>> [354437.150953] 		extent refs 1 gen 1220364 flags 1
>> [354437.150953] 		ref#0: extent data backref root 2829 objectid 28509 =
offset 48783360 count 1
>> [354437.150954] 	item 47 key (1776090079232 168 262144) itemoff 12590 =
itemsize 50
>> [354437.150955] 		extent refs 2 gen 2399058 flags 1
>> [354437.150955] 		ref#0: shared data backref parent 1427069976576 coun=
t 1
>> [354437.150956] 		ref#1: shared data backref parent 1426543263744 coun=
t 1
>> [354437.150956] 	item 48 key (1776090341376 168 262144) itemoff 12553 =
itemsize 37
>> [354437.150957] 		extent refs 1 gen 2395510 flags 1
>> [354437.150957] 		ref#0: shared data backref parent 1516486574080 coun=
t 1
>> [354437.150958] 	item 49 key (1776090603520 168 262144) itemoff 12503 =
itemsize 50
>> [354437.150958] 		extent refs 2 gen 2399058 flags 1
>> [354437.150959] 		ref#0: shared data backref parent 1427069976576 coun=
t 1
>> [354437.150959] 		ref#1: shared data backref parent 1426543263744 coun=
t 1
>> [354437.150960] 	item 50 key (1776090865664 168 262144) itemoff 12440 =
itemsize 63
>> [354437.150960] 		extent refs 3 gen 2399058 flags 1
>> [354437.150961] 		ref#0: shared data backref parent 1469117497344 coun=
t 1
>> [354437.150961] 		ref#1: shared data backref parent 1427069976576 coun=
t 1
>> [354437.150962] 		ref#2: shared data backref parent 1426543263744 coun=
t 1
>> [354437.150962] 	item 51 key (1776091127808 168 262144) itemoff 12351 =
itemsize 89
>> [354437.150963] 		extent refs 5 gen 2399068 flags 1
>> [354437.150963] 		ref#0: shared data backref parent 1483789565952 coun=
t 1
>> [354437.150964] 		ref#1: shared data backref parent 1478521192448 coun=
t 1
>> [354437.150964] 		ref#2: shared data backref parent 1469117497344 coun=
t 1
>> [354437.150965] 		ref#3: shared data backref parent 1427069976576 coun=
t 1
>> [354437.150965] 		ref#4: shared data backref parent 1426543263744 coun=
t 1
>> [354437.150966] 	item 52 key (1776091389952 168 262144) itemoff 12301 =
itemsize 50
>> [354437.150966] 		extent refs 2 gen 2399058 flags 1
>> [354437.150967] 		ref#0: shared data backref parent 1427069976576 coun=
t 1
>> [354437.150967] 		ref#1: shared data backref parent 1426543263744 coun=
t 1
>> [354437.150968] 	item 53 key (1776091652096 168 262144) itemoff 12264 =
itemsize 37
>> [354437.150969] 		extent refs 1 gen 2399070 flags 1
>> [354437.150969] 		ref#0: shared data backref parent 1426547474432 coun=
t 1
>> [354437.150970] 	item 54 key (1776091914240 168 524288) itemoff 12188 =
itemsize 76
>> [354437.150970] 		extent refs 4 gen 2399058 flags 1
>> [354437.150970] 		ref#0: shared data backref parent 1478521192448 coun=
t 1
>> [354437.150971] 		ref#1: shared data backref parent 1469117497344 coun=
t 1
>> [354437.150971] 		ref#2: shared data backref parent 1427069976576 coun=
t 1
>> [354437.150972] 		ref#3: shared data backref parent 1426543263744 coun=
t 1
>> [354437.150973] 	item 55 key (1776092438528 168 262144) itemoff 12073 =
itemsize 115
>> [354437.150973] 		extent refs 7 gen 2399058 flags 1
>> [354437.150973] 		ref#0: shared data backref parent 1571788210176 coun=
t 1
>> [354437.150974] 		ref#1: shared data backref parent 1515779391488 coun=
t 1
>> [354437.150974] 		ref#2: shared data backref parent 1483789565952 coun=
t 1
>> [354437.150975] 		ref#3: shared data backref parent 1478521192448 coun=
t 1
>> [354437.150975] 		ref#4: shared data backref parent 1469117513728 coun=
t 1
>> [354437.150976] 		ref#5: shared data backref parent 1427069976576 coun=
t 1
>> [354437.150976] 		ref#6: shared data backref parent 1426543263744 coun=
t 1
>> [354437.150977] 	item 56 key (1776092700672 168 524288) itemoff 12010 =
itemsize 63
>> [354437.150978] 		extent refs 3 gen 2399058 flags 1
>> [354437.150978] 		ref#0: shared data backref parent 1469117513728 coun=
t 1
>> [354437.150978] 		ref#1: shared data backref parent 1427069976576 coun=
t 1
>> [354437.150979] 		ref#2: shared data backref parent 1426543263744 coun=
t 1
>> [354437.150980] 	item 57 key (1776093224960 168 262144) itemoff 11973 =
itemsize 37
>> [354437.150980] 		extent refs 1 gen 2401179 flags 1
>> [354437.150981] 		ref#0: shared data backref parent 1478027067392 coun=
t 1
>> [354437.150981] 	item 58 key (1776093487104 168 262144) itemoff 11936 =
itemsize 37
>> [354437.150982] 		extent refs 1 gen 2400976 flags 1
>> [354437.150982] 		ref#0: shared data backref parent 1426427920384 coun=
t 1
>> [354437.150983] 	item 59 key (1776093880320 168 262144) itemoff 11834 =
itemsize 102
>> [354437.150983] 		extent refs 6 gen 2399068 flags 1
>> [354437.150984] 		ref#0: shared data backref parent 1571793436672 coun=
t 1
>> [354437.150984] 		ref#1: shared data backref parent 1515777327104 coun=
t 1
>> [354437.150985] 		ref#2: shared data backref parent 1483791351808 coun=
t 1
>> [354437.150985] 		ref#3: shared data backref parent 1478528368640 coun=
t 1
>> [354437.150986] 		ref#4: shared data backref parent 1469123837952 coun=
t 1
>> [354437.150986] 		ref#5: shared data backref parent 1426547474432 coun=
t 1
>> [354437.150987] 	item 60 key (1776094142464 168 262144) itemoff 11771 =
itemsize 63
>> [354437.150987] 		extent refs 3 gen 2399058 flags 1
>> [354437.150988] 		ref#0: shared data backref parent 1469117513728 coun=
t 1
>> [354437.150988] 		ref#1: shared data backref parent 1427069976576 coun=
t 1
>> [354437.150989] 		ref#2: shared data backref parent 1426543263744 coun=
t 1
>> [354437.150989] 	item 61 key (1776094404608 168 262144) itemoff 11695 =
itemsize 76
>> [354437.150990] 		extent refs 4 gen 2399058 flags 1
>> [354437.150990] 		ref#0: shared data backref parent 1478521192448 coun=
t 1
>> [354437.150991] 		ref#1: shared data backref parent 1469117513728 coun=
t 1
>> [354437.150991] 		ref#2: shared data backref parent 1427069976576 coun=
t 1
>> [354437.150992] 		ref#3: shared data backref parent 1426543263744 coun=
t 1
>> [354437.150992] 	item 62 key (1776094666752 168 262144) itemoff 11645 =
itemsize 50
>> [354437.150993] 		extent refs 2 gen 2399058 flags 1
>> [354437.150993] 		ref#0: shared data backref parent 1427069976576 coun=
t 1
>> [354437.150994] 		ref#1: shared data backref parent 1426543263744 coun=
t 1
>> [354437.150994] 	item 63 key (1776095080448 168 7868416) itemoff 11592=
 itemsize 53
>> [354437.150995] 		extent refs 1 gen 1220367 flags 1
>> [354437.150995] 		ref#0: extent data backref root 2829 objectid 28509 =
offset 60284928 count 1
>> [354437.150996] 	item 64 key (1776102948864 168 262144) itemoff 11503 =
itemsize 89
>> [354437.150997] 		extent refs 5 gen 2399058 flags 1
>> [354437.150997] 		ref#0: shared data backref parent 1483789565952 coun=
t 1
>> [354437.150997] 		ref#1: shared data backref parent 1478521192448 coun=
t 1
>> [354437.150998] 		ref#2: shared data backref parent 1469117513728 coun=
t 1
>> [354437.150998] 		ref#3: shared data backref parent 1427069976576 coun=
t 1
>> [354437.150999] 		ref#4: shared data backref parent 1426543263744 coun=
t 1
>> [354437.151000] 	item 65 key (1776103211008 168 262144) itemoff 11427 =
itemsize 76
>> [354437.151000] 		extent refs 4 gen 2399058 flags 1
>> [354437.151000] 		ref#0: shared data backref parent 1478521192448 coun=
t 1
>> [354437.151001] 		ref#1: shared data backref parent 1469117513728 coun=
t 1
>> [354437.151001] 		ref#2: shared data backref parent 1427069976576 coun=
t 1
>> [354437.151002] 		ref#3: shared data backref parent 1426543263744 coun=
t 1
>> [354437.151003] 	item 66 key (1776103473152 168 262144) itemoff 11390 =
itemsize 37
>> [354437.151003] 		extent refs 1 gen 2399058 flags 1
>> [354437.151003] 		ref#0: shared data backref parent 1426544558080 coun=
t 1
>> [354437.151004] 	item 67 key (1776103735296 168 262144) itemoff 11353 =
itemsize 37
>> [354437.151005] 		extent refs 1 gen 2399058 flags 1
>> [354437.151005] 		ref#0: shared data backref parent 1426544558080 coun=
t 1
>> [354437.151006] 	item 68 key (1776103997440 168 262144) itemoff 11303 =
itemsize 50
>> [354437.151006] 		extent refs 2 gen 2399058 flags 1
>> [354437.151006] 		ref#0: shared data backref parent 1469117513728 coun=
t 1
>> [354437.151007] 		ref#1: shared data backref parent 1426544558080 coun=
t 1
>> [354437.151008] 	item 69 key (1776104259584 168 262144) itemoff 11253 =
itemsize 50
>> [354437.151008] 		extent refs 2 gen 2399058 flags 1
>> [354437.151008] 		ref#0: shared data backref parent 1427070844928 coun=
t 1
>> [354437.151009] 		ref#1: shared data backref parent 1426554535936 coun=
t 1
>> [354437.151010] 	item 70 key (1776104521728 168 262144) itemoff 11190 =
itemsize 63
>> [354437.151010] 		extent refs 3 gen 2399058 flags 1
>> [354437.151010] 		ref#0: shared data backref parent 1469123805184 coun=
t 1
>> [354437.151011] 		ref#1: shared data backref parent 1427070844928 coun=
t 1
>> [354437.151011] 		ref#2: shared data backref parent 1426554535936 coun=
t 1
>> [354437.151012] 	item 71 key (1776104783872 168 655360) itemoff 11140 =
itemsize 50
>> [354437.151013] 		extent refs 2 gen 2399058 flags 1
>> [354437.151013] 		ref#0: shared data backref parent 1427070844928 coun=
t 1
>> [354437.151014] 		ref#1: shared data backref parent 1426554535936 coun=
t 1
>> [354437.151014] 	item 72 key (1776105439232 168 262144) itemoff 11051 =
itemsize 89
>> [354437.151015] 		extent refs 5 gen 2399058 flags 1
>> [354437.151015] 		ref#0: shared data backref parent 1483790827520 coun=
t 1
>> [354437.151016] 		ref#1: shared data backref parent 1478528303104 coun=
t 1
>> [354437.151016] 		ref#2: shared data backref parent 1469123805184 coun=
t 1
>> [354437.151017] 		ref#3: shared data backref parent 1427070844928 coun=
t 1
>> [354437.151017] 		ref#4: shared data backref parent 1426554535936 coun=
t 1
>> [354437.151018] 	item 73 key (1776105701376 168 262144) itemoff 11001 =
itemsize 50
>> [354437.151018] 		extent refs 2 gen 2399058 flags 1
>> [354437.151019] 		ref#0: shared data backref parent 1427070844928 coun=
t 1
>> [354437.151019] 		ref#1: shared data backref parent 1426554535936 coun=
t 1
>> [354437.151020] 	item 74 key (1776105963520 168 262144) itemoff 10925 =
itemsize 76
>> [354437.151020] 		extent refs 4 gen 2399058 flags 1
>> [354437.151021] 		ref#0: shared data backref parent 1478528303104 coun=
t 1
>> [354437.151021] 		ref#1: shared data backref parent 1469123805184 coun=
t 1
>> [354437.151022] 		ref#2: shared data backref parent 1427070844928 coun=
t 1
>> [354437.151022] 		ref#3: shared data backref parent 1426554535936 coun=
t 1
>> [354437.151023] 	item 75 key (1776106225664 168 262144) itemoff 10875 =
itemsize 50
>> [354437.151023] 		extent refs 2 gen 2399058 flags 1
>> [354437.151024] 		ref#0: shared data backref parent 1427070844928 coun=
t 1
>> [354437.151024] 		ref#1: shared data backref parent 1426554535936 coun=
t 1
>> [354437.151025] 	item 76 key (1776106618880 168 393216) itemoff 10838 =
itemsize 37
>> [354437.151025] 		extent refs 1 gen 2395510 flags 1
>> [354437.151026] 		ref#0: shared data backref parent 1516486868992 coun=
t 1
>> [354437.151027] 	item 77 key (1776107012096 168 655360) itemoff 10710 =
itemsize 128
>> [354437.151027] 		extent refs 8 gen 2399058 flags 1
>> [354437.151027] 		ref#0: shared data backref parent 1571793436672 coun=
t 1
>> [354437.151028] 		ref#1: shared data backref parent 1515777327104 coun=
t 1
>> [354437.151028] 		ref#2: shared data backref parent 1483790827520 coun=
t 1
>> [354437.151029] 		ref#3: shared data backref parent 1478528303104 coun=
t 1
>> [354437.151029] 		ref#4: shared data backref parent 1469123805184 coun=
t 1
>> [354437.151030] 		ref#5: shared data backref parent 1427070844928 coun=
t 1
>> [354437.151030] 		ref#6: shared data backref parent 1426554535936 coun=
t 1
>> [354437.151031] 		ref#7: shared data backref parent 1385237086208 coun=
t 1
>> [354437.151032] 	item 78 key (1776107667456 168 524288) itemoff 10634 =
itemsize 76
>> [354437.151032] 		extent refs 4 gen 2399058 flags 1
>> [354437.151032] 		ref#0: shared data backref parent 1483790827520 coun=
t 1
>> [354437.151033] 		ref#1: shared data backref parent 1478528303104 coun=
t 1
>> [354437.151033] 		ref#2: shared data backref parent 1469123805184 coun=
t 1
>> [354437.151034] 		ref#3: shared data backref parent 1426547474432 coun=
t 1
>> [354437.151035] 	item 79 key (1776108191744 168 262144) itemoff 10597 =
itemsize 37
>> [354437.151035] 		extent refs 1 gen 2399058 flags 1
>> [354437.151035] 		ref#0: shared data backref parent 1426547474432 coun=
t 1
>> [354437.151036] 	item 80 key (1776108453888 168 262144) itemoff 10469 =
itemsize 128
>> [354437.151037] 		extent refs 8 gen 2399058 flags 1
>> [354437.151037] 		ref#0: shared data backref parent 1571793436672 coun=
t 1
>> [354437.151037] 		ref#1: shared data backref parent 1515777327104 coun=
t 1
>> [354437.151038] 		ref#2: shared data backref parent 1483790827520 coun=
t 1
>> [354437.151038] 		ref#3: shared data backref parent 1478528303104 coun=
t 1
>> [354437.151039] 		ref#4: shared data backref parent 1469123805184 coun=
t 1
>> [354437.151040] 		ref#5: shared data backref parent 1452904038400 coun=
t 1
>> [354437.151040] 		ref#6: shared data backref parent 1426547474432 coun=
t 1
>> [354437.151041] 		ref#7: shared data backref parent 1385237086208 coun=
t 1
>> [354437.151041] 	item 81 key (1776108716032 168 262144) itemoff 10419 =
itemsize 50
>> [354437.151042] 		extent refs 2 gen 2399058 flags 1
>> [354437.151042] 		ref#0: shared data backref parent 1469123837952 coun=
t 1
>> [354437.151043] 		ref#1: shared data backref parent 1426547474432 coun=
t 1
>> [354437.151043] 	item 82 key (1776108978176 168 524288) itemoff 10369 =
itemsize 50
>> [354437.151044] 		extent refs 2 gen 2399058 flags 1
>> [354437.151044] 		ref#0: shared data backref parent 1469123837952 coun=
t 1
>> [354437.151045] 		ref#1: shared data backref parent 1426547474432 coun=
t 1
>> [354437.151045] 	item 83 key (1776109502464 168 262144) itemoff 10332 =
itemsize 37
>> [354437.151046] 		extent refs 1 gen 2399058 flags 1
>> [354437.151046] 		ref#0: shared data backref parent 1426547474432 coun=
t 1
>> [354437.151047] 	item 84 key (1776109764608 168 524288) itemoff 10295 =
itemsize 37
>> [354437.151047] 		extent refs 1 gen 2399058 flags 1
>> [354437.151048] 		ref#0: shared data backref parent 1426547474432 coun=
t 1
>> [354437.151048] 	item 85 key (1776110288896 168 393216) itemoff 10258 =
itemsize 37
>> [354437.151049] 		extent refs 1 gen 2399058 flags 1
>> [354437.151049] 		ref#0: shared data backref parent 1426547474432 coun=
t 1
>> [354437.151050] 	item 86 key (1776110682112 168 262144) itemoff 10208 =
itemsize 50
>> [354437.151050] 		extent refs 2 gen 2399058 flags 1
>> [354437.151051] 		ref#0: shared data backref parent 1469123837952 coun=
t 1
>> [354437.151051] 		ref#1: shared data backref parent 1426547474432 coun=
t 1
>> [354437.151052] 	item 87 key (1776110944256 168 262144) itemoff 10171 =
itemsize 37
>> [354437.151052] 		extent refs 1 gen 2399058 flags 1
>> [354437.151053] 		ref#0: shared data backref parent 1426547474432 coun=
t 1
>> [354437.151053] 	item 88 key (1776111333376 168 262144) itemoff 10118 =
itemsize 53
>> [354437.151054] 		extent refs 1 gen 1151293 flags 1
>> [354437.151054] 		ref#0: extent data backref root 257 objectid 1099449=
7 offset 682188800 count 1
>> [354437.151055] 	item 89 key (1776111595520 168 262144) itemoff 9938 i=
temsize 180
>> [354437.151056] 		extent refs 12 gen 2399067 flags 1
>> [354437.151056] 		ref#0: shared data backref parent 1571787866112 coun=
t 1
>> [354437.151056] 		ref#1: shared data backref parent 1571557933056 coun=
t 1
>> [354437.151057] 		ref#2: shared data backref parent 1515777179648 coun=
t 1
>> [354437.151057] 		ref#3: shared data backref parent 1483789385728 coun=
t 1
>> [354437.151058] 		ref#4: shared data backref parent 1478519947264 coun=
t 1
>> [354437.151058] 		ref#5: shared data backref parent 1469117284352 coun=
t 1
>> [354437.151059] 		ref#6: shared data backref parent 1452902154240 coun=
t 1
>> [354437.151059] 		ref#7: shared data backref parent 1452166561792 coun=
t 1
>> [354437.151060] 		ref#8: shared data backref parent 1426536103936 coun=
t 1
>> [354437.151061] 		ref#9: shared data backref parent 1385234546688 coun=
t 1
>> [354437.151061] 		ref#10: shared data backref parent 1384539193344 cou=
nt 1
>> [354437.151062] 		ref#11: shared data backref parent 1321419735040 cou=
nt 1
>> [354437.151062] 	item 90 key (1776111857664 168 262144) itemoff 9862 i=
temsize 76
>> [354437.151063] 		extent refs 4 gen 2399058 flags 1
>> [354437.151063] 		ref#0: shared data backref parent 1483791351808 coun=
t 1
>> [354437.151064] 		ref#1: shared data backref parent 1478528368640 coun=
t 1
>> [354437.151064] 		ref#2: shared data backref parent 1469123837952 coun=
t 1
>> [354437.151065] 		ref#3: shared data backref parent 1426547474432 coun=
t 1
>> [354437.151066] 	item 91 key (1776112119808 168 262144) itemoff 9825 i=
temsize 37
>> [354437.151066] 		extent refs 1 gen 2399071 flags 1
>> [354437.151066] 		ref#0: shared data backref parent 1426548834304 coun=
t 1
>> [354437.151067] 	item 92 key (1776112381952 168 262144) itemoff 9788 i=
temsize 37
>> [354437.151067] 		extent refs 1 gen 2399058 flags 1
>> [354437.151068] 		ref#0: shared data backref parent 1426547474432 coun=
t 1
>> [354437.151069] 	item 93 key (1776112644096 168 262144) itemoff 9751 i=
temsize 37
>> [354437.151069] 		extent refs 1 gen 2399058 flags 1
>> [354437.151069] 		ref#0: shared data backref parent 1426547474432 coun=
t 1
>> [354437.151070] 	item 94 key (1776112906240 168 524288) itemoff 9714 i=
temsize 37
>> [354437.151070] 		extent refs 1 gen 2399058 flags 1
>> [354437.151071] 		ref#0: shared data backref parent 1426547474432 coun=
t 1
>> [354437.151072] 	item 95 key (1776113430528 168 262144) itemoff 9677 i=
temsize 37
>> [354437.151072] 		extent refs 1 gen 2399058 flags 1
>> [354437.151072] 		ref#0: shared data backref parent 1426547474432 coun=
t 1
>> [354437.151073] 	item 96 key (1776113692672 168 262144) itemoff 9640 i=
temsize 37
>> [354437.151073] 		extent refs 1 gen 2399058 flags 1
>> [354437.151074] 		ref#0: shared data backref parent 1426547474432 coun=
t 1
>> [354437.151075] 	item 97 key (1776113954816 168 262144) itemoff 9603 i=
temsize 37
>> [354437.151075] 		extent refs 1 gen 2399071 flags 1
>> [354437.151075] 		ref#0: shared data backref parent 1426579374080 coun=
t 1
>> [354437.151076] 	item 98 key (1776114216960 168 262144) itemoff 9566 i=
temsize 37
>> [354437.151076] 		extent refs 1 gen 2399072 flags 1
>> [354437.151077] 		ref#0: shared data backref parent 1426579374080 coun=
t 1
>> [354437.151078] 	item 99 key (1776114479104 168 262144) itemoff 9529 i=
temsize 37
>> [354437.151078] 		extent refs 1 gen 2399058 flags 1
>> [354437.151078] 		ref#0: shared data backref parent 1426547474432 coun=
t 1
>> [354437.151079] 	item 100 key (1776114741248 168 262144) itemoff 9401 =
itemsize 128
>> [354437.151079] 		extent refs 8 gen 2399058 flags 1
>> [354437.151080] 		ref#0: shared data backref parent 1714666438656 coun=
t 1
>> [354437.151080] 		ref#1: shared data backref parent 1515779833856 coun=
t 1
>> [354437.151081] 		ref#2: shared data backref parent 1483791351808 coun=
t 1
>> [354437.151081] 		ref#3: shared data backref parent 1478528368640 coun=
t 1
>> [354437.151082] 		ref#4: shared data backref parent 1469123837952 coun=
t 1
>> [354437.151082] 		ref#5: shared data backref parent 1452904153088 coun=
t 1
>> [354437.151083] 		ref#6: shared data backref parent 1426547474432 coun=
t 1
>> [354437.151083] 		ref#7: shared data backref parent 1385237217280 coun=
t 1
>> [354437.151084] 	item 101 key (1776115003392 168 262144) itemoff 9364 =
itemsize 37
>> [354437.151085] 		extent refs 1 gen 2399058 flags 1
>> [354437.151085] 		ref#0: shared data backref parent 1426547474432 coun=
t 1
>> [354437.151086] 	item 102 key (1776115265536 168 262144) itemoff 9327 =
itemsize 37
>> [354437.151086] 		extent refs 1 gen 2399058 flags 1
>> [354437.151086] 		ref#0: shared data backref parent 1426547474432 coun=
t 1
>> [354437.151087] 	item 103 key (1776115527680 168 262144) itemoff 9290 =
itemsize 37
>> [354437.151088] 		extent refs 1 gen 2399058 flags 1
>> [354437.151088] 		ref#0: shared data backref parent 1426547474432 coun=
t 1
>> [354437.151096] 	item 104 key (1776115789824 168 262144) itemoff 9227 =
itemsize 63
>> [354437.151097] 		extent refs 3 gen 2399058 flags 1
>> [354437.151098] 		ref#0: shared data backref parent 1478528368640 coun=
t 1
>> [354437.151099] 		ref#1: shared data backref parent 1469123837952 coun=
t 1
>> [354437.151099] 		ref#2: shared data backref parent 1426547474432 coun=
t 1
>> [354437.151101] 	item 105 key (1776116051968 168 262144) itemoff 9190 =
itemsize 37
>> [354437.151101] 		extent refs 1 gen 2399058 flags 1
>> [354437.151102] 		ref#0: shared data backref parent 1426547474432 coun=
t 1
>> [354437.151103] 	item 106 key (1776116314112 168 262144) itemoff 9114 =
itemsize 76
>> [354437.151103] 		extent refs 4 gen 2399058 flags 1
>> [354437.151104] 		ref#0: shared data backref parent 1478528368640 coun=
t 1
>> [354437.151104] 		ref#1: shared data backref parent 1469123837952 coun=
t 1
>> [354437.151105] 		ref#2: shared data backref parent 1427070894080 coun=
t 1
>> [354437.151106] 		ref#3: shared data backref parent 1426590777344 coun=
t 1
>> [354437.151107] 	item 107 key (1776116576256 168 262144) itemoff 9064 =
itemsize 50
>> [354437.151108] 		extent refs 2 gen 2399058 flags 1
>> [354437.151108] 		ref#0: shared data backref parent 1427070894080 coun=
t 1
>> [354437.151109] 		ref#1: shared data backref parent 1426590777344 coun=
t 1
>> [354437.151110] 	item 108 key (1776116838400 168 524288) itemoff 8988 =
itemsize 76
>> [354437.151110] 		extent refs 4 gen 2399058 flags 1
>> [354437.151111] 		ref#0: shared data backref parent 1478528368640 coun=
t 1
>> [354437.151111] 		ref#1: shared data backref parent 1469123837952 coun=
t 1
>> [354437.151112] 		ref#2: shared data backref parent 1427070894080 coun=
t 1
>> [354437.151113] 		ref#3: shared data backref parent 1426590777344 coun=
t 1
>> [354437.151114] 	item 109 key (1776117493760 168 262144) itemoff 8935 =
itemsize 53
>> [354437.151114] 		extent refs 1 gen 1151293 flags 1
>> [354437.151115] 		ref#0: extent data backref root 257 objectid 1099449=
7 offset 683573248 count 1
>> [354437.151116] 	item 110 key (1776117755904 168 262144) itemoff 8846 =
itemsize 89
>> [354437.151117] 		extent refs 5 gen 2399058 flags 1
>> [354437.151117] 		ref#0: shared data backref parent 1483791351808 coun=
t 1
>> [354437.151118] 		ref#1: shared data backref parent 1478528368640 coun=
t 1
>> [354437.151119] 		ref#2: shared data backref parent 1469123837952 coun=
t 1
>> [354437.151119] 		ref#3: shared data backref parent 1427070894080 coun=
t 1
>> [354437.151120] 		ref#4: shared data backref parent 1426590777344 coun=
t 1
>> [354437.151121] 	item 111 key (1776118018048 168 262144) itemoff 8770 =
itemsize 76
>> [354437.151122] 		extent refs 4 gen 2399058 flags 1
>> [354437.151122] 		ref#0: shared data backref parent 1478528483328 coun=
t 1
>> [354437.151123] 		ref#1: shared data backref parent 1469123969024 coun=
t 1
>> [354437.151124] 		ref#2: shared data backref parent 1427070894080 coun=
t 1
>> [354437.151125] 		ref#3: shared data backref parent 1426590777344 coun=
t 1
>> [354437.151127] 	item 112 key (1776118280192 168 262144) itemoff 8720 =
itemsize 50
>> [354437.151128] 		extent refs 2 gen 2399068 flags 1
>> [354437.151128] 		ref#0: shared data backref parent 1469123837952 coun=
t 1
>> [354437.151129] 		ref#1: shared data backref parent 1426547474432 coun=
t 1
>> [354437.151130] 	item 113 key (1776118542336 168 262144) itemoff 8657 =
itemsize 63
>> [354437.151131] 		extent refs 3 gen 2399058 flags 1
>> [354437.151131] 		ref#0: shared data backref parent 1469123969024 coun=
t 1
>> [354437.151132] 		ref#1: shared data backref parent 1427070894080 coun=
t 1
>> [354437.151132] 		ref#2: shared data backref parent 1426590777344 coun=
t 1
>> [354437.151133] 	item 114 key (1776118804480 168 262144) itemoff 8607 =
itemsize 50
>> [354437.151134] 		extent refs 2 gen 2399058 flags 1
>> [354437.151135] 		ref#0: shared data backref parent 1427070894080 coun=
t 1
>> [354437.151135] 		ref#1: shared data backref parent 1426590777344 coun=
t 1
>> [354437.151136] 	item 115 key (1776119066624 168 262144) itemoff 8557 =
itemsize 50
>> [354437.151137] 		extent refs 2 gen 2399058 flags 1
>> [354437.151137] 		ref#0: shared data backref parent 1427070894080 coun=
t 1
>> [354437.151138] 		ref#1: shared data backref parent 1426590777344 coun=
t 1
>> [354437.151139] 	item 116 key (1776119328768 168 262144) itemoff 8507 =
itemsize 50
>> [354437.151140] 		extent refs 2 gen 2399070 flags 1
>> [354437.151140] 		ref#0: shared data backref parent 1469123837952 coun=
t 1
>> [354437.151141] 		ref#1: shared data backref parent 1426547474432 coun=
t 1
>> [354437.151142] 	item 117 key (1776119590912 168 262144) itemoff 8457 =
itemsize 50
>> [354437.151143] 		extent refs 2 gen 2399058 flags 1
>> [354437.151143] 		ref#0: shared data backref parent 1427070894080 coun=
t 1
>> [354437.151144] 		ref#1: shared data backref parent 1426590777344 coun=
t 1
>> [354437.151145] 	item 118 key (1776119853056 168 262144) itemoff 8290 =
itemsize 167
>> [354437.151146] 		extent refs 11 gen 2399058 flags 1
>> [354437.151146] 		ref#0: shared data backref parent 1571793682432 coun=
t 1
>> [354437.151147] 		ref#1: shared data backref parent 1571572596736 coun=
t 1
>> [354437.151147] 		ref#2: shared data backref parent 1515779866624 coun=
t 1
>> [354437.151148] 		ref#3: shared data backref parent 1483791384576 coun=
t 1
>> [354437.151149] 		ref#4: shared data backref parent 1478528483328 coun=
t 1
>> [354437.151150] 		ref#5: shared data backref parent 1469123969024 coun=
t 1
>> [354437.151150] 		ref#6: shared data backref parent 1468514566144 coun=
t 1
>> [354437.151151] 		ref#7: shared data backref parent 1452904169472 coun=
t 1
>> [354437.151152] 		ref#8: shared data backref parent 1427070894080 coun=
t 1
>> [354437.151153] 		ref#9: shared data backref parent 1426590777344 coun=
t 1
>> [354437.151154] 		ref#10: shared data backref parent 1385237430272 cou=
nt 1
>> [354437.151155] 	item 119 key (1776120115200 168 262144) itemoff 8188 =
itemsize 102
>> [354437.151156] 		extent refs 6 gen 2399058 flags 1
>> [354437.151156] 		ref#0: shared data backref parent 1515779866624 coun=
t 1
>> [354437.151157] 		ref#1: shared data backref parent 1483791384576 coun=
t 1
>> [354437.151158] 		ref#2: shared data backref parent 1478528483328 coun=
t 1
>> [354437.151158] 		ref#3: shared data backref parent 1469123969024 coun=
t 1
>> [354437.151159] 		ref#4: shared data backref parent 1427070894080 coun=
t 1
>> [354437.151160] 		ref#5: shared data backref parent 1426590777344 coun=
t 1
>> [354437.151161] 	item 120 key (1776120377344 168 262144) itemoff 8138 =
itemsize 50
>> [354437.151162] 		extent refs 2 gen 2399070 flags 1
>> [354437.151162] 		ref#0: shared data backref parent 1427070894080 coun=
t 1
>> [354437.151163] 		ref#1: shared data backref parent 1426590777344 coun=
t 1
>> [354437.151164] 	item 121 key (1776120639488 168 524288) itemoff 8075 =
itemsize 63
>> [354437.151164] 		extent refs 3 gen 2399058 flags 1
>> [354437.151165] 		ref#0: shared data backref parent 1469123969024 coun=
t 1
>> [354437.151165] 		ref#1: shared data backref parent 1427070894080 coun=
t 1
>> [354437.151166] 		ref#2: shared data backref parent 1426590777344 coun=
t 1
>> [354437.151168] 	item 122 key (1776121163776 168 524288) itemoff 8025 =
itemsize 50
>> [354437.151168] 		extent refs 2 gen 2399058 flags 1
>> [354437.151169] 		ref#0: shared data backref parent 1427070894080 coun=
t 1
>> [354437.151169] 		ref#1: shared data backref parent 1426590777344 coun=
t 1
>> [354437.151171] 	item 123 key (1776121688064 168 778240) itemoff 7910 =
itemsize 115
>> [354437.151171] 		extent refs 9 gen 2399058 flags 1
>> [354437.151171] 		ref#0: shared data backref parent 1571793682432 coun=
t 1
>> [354437.151172] 		ref#1: shared data backref parent 1515779866624 coun=
t 1
>> [354437.151173] 		ref#2: shared data backref parent 1483791384576 coun=
t 1
>> [354437.151173] 		ref#3: shared data backref parent 1478528483328 coun=
t 2
>> [354437.151174] 		ref#4: shared data backref parent 1469123969024 coun=
t 2
>> [354437.151175] 		ref#5: shared data backref parent 1427070894080 coun=
t 1
>> [354437.151175] 		ref#6: shared data backref parent 1426590777344 coun=
t 1
>> [354437.151177] 	item 124 key (1776122466304 168 262144) itemoff 7860 =
itemsize 50
>> [354437.151177] 		extent refs 2 gen 2399058 flags 1
>> [354437.151178] 		ref#0: shared data backref parent 1427070894080 coun=
t 1
>> [354437.151178] 		ref#1: shared data backref parent 1426590777344 coun=
t 1
>> [354437.151179] 	item 125 key (1776122728448 168 262144) itemoff 7797 =
itemsize 63
>> [354437.151180] 		extent refs 3 gen 2399058 flags 1
>> [354437.151180] 		ref#0: shared data backref parent 1469123969024 coun=
t 1
>> [354437.151181] 		ref#1: shared data backref parent 1427070894080 coun=
t 1
>> [354437.151182] 		ref#2: shared data backref parent 1426590777344 coun=
t 1
>> [354437.151183] 	item 126 key (1776122990592 168 262144) itemoff 7708 =
itemsize 89
>> [354437.151183] 		extent refs 5 gen 2399058 flags 1
>> [354437.151184] 		ref#0: shared data backref parent 1483791384576 coun=
t 1
>> [354437.151184] 		ref#1: shared data backref parent 1478528483328 coun=
t 1
>> [354437.151185] 		ref#2: shared data backref parent 1469123969024 coun=
t 1
>> [354437.151186] 		ref#3: shared data backref parent 1427070894080 coun=
t 1
>> [354437.151186] 		ref#4: shared data backref parent 1426590777344 coun=
t 1
>> [354437.151188] 	item 127 key (1776123252736 168 262144) itemoff 7632 =
itemsize 76
>> [354437.151188] 		extent refs 4 gen 2399058 flags 1
>> [354437.151189] 		ref#0: shared data backref parent 1483791384576 coun=
t 1
>> [354437.151189] 		ref#1: shared data backref parent 1478528483328 coun=
t 1
>> [354437.151190] 		ref#2: shared data backref parent 1469123969024 coun=
t 1
>> [354437.151191] 		ref#3: shared data backref parent 1426549227520 coun=
t 1
>> [354437.151192] 	item 128 key (1776123514880 168 262144) itemoff 7595 =
itemsize 37
>> [354437.151192] 		extent refs 1 gen 2399058 flags 1
>> [354437.151193] 		ref#0: shared data backref parent 1426549227520 coun=
t 1
>> [354437.151194] 	item 129 key (1776123777024 168 262144) itemoff 7558 =
itemsize 37
>> [354437.151195] 		extent refs 1 gen 2399058 flags 1
>> [354437.151195] 		ref#0: shared data backref parent 1426549227520 coun=
t 1
>> [354437.151197] 	item 130 key (1776124039168 168 262144) itemoff 7469 =
itemsize 89
>> [354437.151197] 		extent refs 5 gen 2399070 flags 1
>> [354437.151198] 		ref#0: shared data backref parent 1515779899392 coun=
t 1
>> [354437.151199] 		ref#1: shared data backref parent 1483791171584 coun=
t 1
>> [354437.151199] 		ref#2: shared data backref parent 1478528548864 coun=
t 1
>> [354437.151200] 		ref#3: shared data backref parent 1469124231168 coun=
t 1
>> [354437.151201] 		ref#4: shared data backref parent 1426548834304 coun=
t 1
>> [354437.151202] 	item 131 key (1776124301312 168 262144) itemoff 7419 =
itemsize 50
>> [354437.151203] 		extent refs 2 gen 2399058 flags 1
>> [354437.151203] 		ref#0: shared data backref parent 1469123969024 coun=
t 1
>> [354437.151204] 		ref#1: shared data backref parent 1426549227520 coun=
t 1
>> [354437.151205] 	item 132 key (1776124563456 168 262144) itemoff 7356 =
itemsize 63
>> [354437.151206] 		extent refs 3 gen 2399070 flags 1
>> [354437.151206] 		ref#0: shared data backref parent 1469126475776 coun=
t 1
>> [354437.151207] 		ref#1: shared data backref parent 1427073351680 coun=
t 1
>> [354437.151208] 		ref#2: shared data backref parent 1426582634496 coun=
t 1
>> [354437.151209] 	item 133 key (1776124825600 168 262144) itemoff 7319 =
itemsize 37
>> [354437.151210] 		extent refs 1 gen 2399058 flags 1
>> [354437.151210] 		ref#0: shared data backref parent 1426549227520 coun=
t 1
>> [354437.151211] 	item 134 key (1776125087744 168 524288) itemoff 7256 =
itemsize 63
>> [354437.151212] 		extent refs 3 gen 2399058 flags 1
>> [354437.151212] 		ref#0: shared data backref parent 1478528483328 coun=
t 1
>> [354437.151213] 		ref#1: shared data backref parent 1469123969024 coun=
t 1
>> [354437.151214] 		ref#2: shared data backref parent 1426549227520 coun=
t 1
>> [354437.151215] 	item 135 key (1776125612032 168 262144) itemoff 7193 =
itemsize 63
>> [354437.151215] 		extent refs 4 gen 2399058 flags 1
>> [354437.151216] 		ref#0: shared data backref parent 1478528483328 coun=
t 2
>> [354437.151216] 		ref#1: shared data backref parent 1469123969024 coun=
t 1
>> [354437.151217] 		ref#2: shared data backref parent 1426549227520 coun=
t 1
>> [354437.151218] 	item 136 key (1776125874176 168 262144) itemoff 7156 =
itemsize 37
>> [354437.151219] 		extent refs 1 gen 2399058 flags 1
>> [354437.151219] 		ref#0: shared data backref parent 1426549227520 coun=
t 1
>> [354437.151221] 	item 137 key (1776126136320 168 262144) itemoff 7106 =
itemsize 50
>> [354437.151221] 		extent refs 2 gen 2399058 flags 1
>> [354437.151222] 		ref#0: shared data backref parent 1469123969024 coun=
t 1
>> [354437.151222] 		ref#1: shared data backref parent 1426549227520 coun=
t 1
>> [354437.151225] BTRFS error (device dm-2): unable to find ref byte nr =
1776065458176 parent 1384804827136 root 257  owner 10994873 offset 250701=
4144
>> [354437.151226] ------------[ cut here ]------------
>> [354437.151227] BTRFS: Transaction aborted (error -2)
>> [354437.151262] WARNING: CPU: 3 PID: 9095 at fs/btrfs/extent-tree.c:48=
57 __btrfs_free_extent+0x260/0x8fd [btrfs]
>> [354437.151263] Modules linked in: rfcomm cmac bnep msr bridge stp llc=
 ip_tables x_tables serpent_sse2_x86_64 serpent_avx2 serpent_avx_x86_64 a=
lgif_skcipher dm_zero dm_thin_pool dm_persistent_data dm_bio_prison dm_se=
rvice_time dm_round_robin dm_queue_length dm_multipath dm_log_userspace d=
m_flakey dm_delay virtio_scsi virtio_console sha1_generic iscsi_tcp libis=
csi_tcp libiscsi scsi_transport_iscsi ixgb ixgbe samsung_sxgbe tulip cxgb=
3 cxgb mdio cxgb4 vxge vxlan ip6_udp_tunnel udp_tunnel macvlan vmxnet3 vi=
rtio_net net_failover failover tg3 sky2 r8169 libphy pcnet32 mii igb dca =
e1000 bnx2 atl1c fuse overlay nfs lockd grace sunrpc btrfs zstd_decompres=
s zstd_compress xxhash multipath linear raid10 raid1 raid0 dm_raid raid45=
6 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq=
 dm_snapshot dm_bufio dm_mirror dm_region_hash dm_log firewire_sbp2 firew=
ire_ohci firewire_core hid_sunplus hid_sony hid_samsung hid_pl hid_petaly=
nx hid_monterey hid_microsoft hid_gyration hid_ezkey
>> [354437.151288]  hid_cypress hid_chicony hid_cherry hid_belkin hid_a4t=
ech sl811_hcd xhci_plat_hcd usb_storage mpt3sas raid_class aic94xx libsas=
 lpfc qla2xxx megaraid_sas megaraid_mbox megaraid_mm megaraid aacraid sx8=
 hpsa 3w_9xxx 3w_xxxx mptsas mptfc scsi_transport_fc mptspi mptscsih mptb=
ase atp870u dc395x qla1280 dmx3191d sym53c8xx gdth initio BusLogic arcmsr=
 aic7xxx aic79xx scsi_transport_spi sg pdc_adma sata_inic162x sata_mv ata=
_piix ahci libahci sata_qstor sata_vsc sata_uli sata_sis sata_sx4 sata_nv=
 sata_via sata_svw sata_sil24 sata_sil sata_promise pata_sl82c105 pata_vi=
a pata_jmicron pata_marvell pata_sis pata_netcell pata_pdc202xx_old pata_=
triflex pata_atiixp pata_amd pata_ali pata_it8213 pata_pcmcia pcmcia pcmc=
ia_core pata_ns87415 pata_ns87410 pata_serverworks pata_artop pata_it821x=
 pata_hpt3x2n pata_hpt3x3 pata_hpt37x pata_hpt366 pata_cmd64x pata_efar p=
ata_rz1000 pata_sil680 pata_radisys pata_pdc2027x pata_mpiix snd_hda_code=
c_hdmi btusb btrtl btbcm btintel uvcvideo bluetooth
>> [354437.151313]  videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 vid=
eodev ecdh_generic ecc videobuf2_common x86_pkg_temp_thermal intel_powerc=
lamp coretemp kvm_intel kvm irqbypass snd_hda_codec_realtek snd_hda_codec=
_generic crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel a=
th10k_pci ath10k_core ath mac80211 i915 i2c_algo_bit aesni_intel snd_hda_=
intel dell_laptop dell_wmi ledtrig_audio snd_hda_codec drm_kms_helper del=
l_smbios rtsx_pci_sdmmc intel_rapl_msr wmi_bmof sparse_keymap dell_wmi_de=
scriptor aes_x86_64 cfg80211 input_leds crypto_simd snd_hda_core snd_hwde=
p cryptd drm dcdbas snd_pcm glue_helper i2c_i801 mmc_core rfkill processo=
r_thermal_device libarc4 pcspkr serio_raw intel_rapl_common intel_pch_the=
rmal intel_soc_dts_iosf iosf_mbi wmi int3403_thermal int340x_thermal_zone=
 int3400_thermal acpi_thermal_rel joydev
>> [354437.151333] CPU: 3 PID: 9095 Comm: kworker/3:1 Tainted: G        W=
         5.3.6-gentoo-r1 #2
>> [354437.151334] Hardware name: Dell Inc. XPS 13 9360/06CC14, BIOS 2.11=
=2E0 03/14/2019
>> [354437.151347] Workqueue: events do_async_commit [btrfs]
>> [354437.151360] RIP: 0010:__btrfs_free_extent+0x260/0x8fd [btrfs]
>> [354437.151361] Code: e8 b7 8d 08 00 49 8b 44 24 50 f0 48 0f ba a8 c0 =
0c 00 00 02 0f 92 c0 5a 84 c0 75 10 89 de 48 c7 c7 05 d6 17 c1 e8 a6 fc f=
6 d3 <0f> 0b b9 fe ff ff ff ba f9 12 00 00 48 c7 c6 10 99 17 c1 4c 89 e7
>> [354437.151363] RSP: 0018:ffff8e0b8605fc28 EFLAGS: 00010282
>> [354437.151364] RAX: 0000000000000000 RBX: 00000000fffffffe RCX: 00000=
00000000007
>> [354437.151365] RDX: 00000000000010b2 RSI: 0000000000000002 RDI: ffff8=
ae42e397330
>> [354437.151366] RBP: ffff8ae2a2bac310 R08: 0000000000000006 R09: 00000=
00000020500
>> [354437.151367] R10: 0000000000011630 R11: 0000000c1993c1e5 R12: ffff8=
ae2e9ec0208
>> [354437.151368] R13: 000001426cccc000 R14: 0000000000000101 R15: 00000=
000956e0000
>> [354437.151370] FS:  0000000000000000(0000) GS:ffff8ae42e380000(0000) =
knlGS:0000000000000000
>> [354437.151371] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [354437.151372] CR2: 00000000008c5487 CR3: 000000046a108001 CR4: 00000=
000003606e0
>> [354437.151373] Call Trace:
>> [354437.151387]  __btrfs_run_delayed_refs+0x690/0xc6c [btrfs]
>> [354437.151391]  ? __switch_to_asm+0x40/0x70
>> [354437.151403]  btrfs_run_delayed_refs+0x5e/0x149 [btrfs]
>> [354437.151416]  btrfs_commit_transaction+0x78/0x8a0 [btrfs]
>> [354437.151418]  ? __switch_to_asm+0x34/0x70
>> [354437.151419]  ? __switch_to_asm+0x40/0x70
>> [354437.151420]  ? __switch_to_asm+0x34/0x70
>> [354437.151421]  ? __switch_to_asm+0x40/0x70
>> [354437.151422]  ? __switch_to_asm+0x34/0x70
>> [354437.151431]  do_async_commit+0x1d/0x27 [btrfs]
>> [354437.151433]  process_one_work+0x16e/0x24e
>> [354437.151435]  ? rescuer_thread+0x28c/0x28c
>> [354437.151436]  worker_thread+0x1dc/0x2ac
>> [354437.151437]  kthread+0x10b/0x113
>> [354437.151438]  ? kthread_park+0x89/0x89
>> [354437.151439]  ret_from_fork+0x35/0x40
>> [354437.151441] ---[ end trace 85833d33b2b02bd0 ]---
>> [354437.151446] BTRFS: error (device dm-2) in __btrfs_free_extent:4857=
: errno=3D-2 No such entry
>> [354437.151447] BTRFS info (device dm-2): forced readonly
>> [354437.151449] BTRFS: error (device dm-2) in btrfs_run_delayed_refs:2=
795: errno=3D-2 No such entry


--t8q4o106zbo2oj3oRd699PAGzn6A7Z1f6--

--toCPwoRBqvQEh04Aw9LNI3hAxpViugOi1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3DgbMACgkQwj2R86El
/qjLegf/a4CWGFYzGSXD9PXyoTYweEPFp2WMCCkYyiscs6w5suqRd6tKzGc0YOn/
GSgr3h5w7gAVvYr9EPp1Hu/ydatv+WCzU8fdqCIYXvxNYk+k6Sscdz35kUJ6qRYM
UXvqkL+LMAUnrawm+vuQFj2xJ3QDlSLXySPNNZVZL7ppg9lO+bwVor9mdpivFO5s
4wMqaVsboRX7xebUahRMkEGAgoh9XgrmU5vAracuLC7HDc3g/WLxO9YRKY4WOopA
d0yf6HTxbHxW/mwlXM5CVHtFN06fj5waf2wiqddFX0xp1B2731SWP2QxG4yuyGLp
VCUYM7qZJMjg4mvpEOZCQo/YOQOYdA==
=JYX7
-----END PGP SIGNATURE-----

--toCPwoRBqvQEh04Aw9LNI3hAxpViugOi1--
