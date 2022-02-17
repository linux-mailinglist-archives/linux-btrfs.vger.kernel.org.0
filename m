Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE4C4B95E4
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Feb 2022 03:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiBQC3k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Feb 2022 21:29:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiBQC3j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Feb 2022 21:29:39 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872F229E967
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 18:29:25 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id v186so10154853ybg.1
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 18:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=T8fnMEDGleDIi7WLBReFuq3o0zDoL3sq+Rbtr3CI1Rs=;
        b=fJcUhragoSOS7voQumxLUUsu1Fv2+dMHBAWb3c+5EE7k02hCFwC15NMZKLBmNsboNc
         wdHyvuSz2p1IQ3Ae1apGGTI5F8EEHk8CtdA+aw4oOYr0n2mo0fH8Ir7+kAmgVsDARI4e
         93olwtyBKBEy6VozbxJKP3vH6F+K8v4WHuK6zxc6R44pP0vyOP/kpZreU2tHszYI5+mu
         8LX8LOZAC/KHdGlv+bkucZ5a+y/YOTpIFGwXB5EGe6oQTJ15qtcCgzDMsyzgxGNtxt6k
         WxlvSqi3CV3DSwsq2eNNAXWyvHlGR0EPwW/4Ip8UoZKXYbpyCCTBH1J0ATtTEoDXfoyw
         XDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=T8fnMEDGleDIi7WLBReFuq3o0zDoL3sq+Rbtr3CI1Rs=;
        b=PVxKz4r1SHbf9kXotjgePLq1LmmkJjLsTwo5C4auElCwER1tpbFDhZi05O0u7pZaZe
         VuQi0DoAJSSHN2hdCyEEIW4zGbHHAYuchG+/Qc6mCxV7/1aS1UeXYVy9Qbnodt2/yS+E
         /pPhCpye3Cp4bywCIGeHtvgJ4Y8RxMQdNqKR6FaZfddmEnG1vEv10AqmbVMn21ePh5Lj
         DbW2XCyw8YI/JzwllkcNzGdjUrLn/LNvtgKasvHka5PBqcaLd0HcQfSNMXsdHBw9ZJk0
         0XSHeDkmG5ReplLuLxUL7aDGgA/biraaekKE9AqIhpBMRhoodQ39LOCCd/818j3TfGOp
         Gugg==
X-Gm-Message-State: AOAM533OXVG1iaxYjj1z8DSdsl+JPuTxCRTGIIEXqZyKsmYbkaj7SCsB
        Z9mhtH0wfghLsRUec9pVBboDApmbkrS0h6oN/C4PULKXyjau9QP7
X-Google-Smtp-Source: ABdhPJzTinzc147UXKLmfIADbXnG9s9imHOHZaHG0queWlwTR2b0lxiqqLfe6i4d5TAlpRNvmO8I5yCMGV0yGghezwM=
X-Received: by 2002:a25:d986:0:b0:624:ddc:ff9 with SMTP id q128-20020a25d986000000b006240ddc0ff9mr636104ybg.509.1645064964397;
 Wed, 16 Feb 2022 18:29:24 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 16 Feb 2022 19:29:08 -0700
Message-ID: <CAJCQCtSGV2SK8u-9p=W6vh5DJFdG2zRj+6qb_4K6pUYb+sfqYA@mail.gmail.com>
Subject: 5.17-rc4, oops, RIP: 0010:kyber_bio_merge+0x6e/0xd0
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Omar Sandoval <osandov@osandov.com>
Content-Type: multipart/mixed; boundary="000000000000d62a7005d82d885a"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--000000000000d62a7005d82d885a
Content-Type: text/plain; charset="UTF-8"

BOOT_IMAGE=(hd0,gpt4)/vmlinuz-5.17.0-0.rc4.96.fc36.x86_64+debug
root=UUID=b0cdab05-5632-4170-9610-d6ae158f8ec3 ro
rootflags=subvol=root3536 mitigations=off enforcing=0
systemd.debug-shell systemd.log_level=debug preempt=full
drm.debug=0x06

This seems to be a one off so far, early boot oops using kyber
scheduler. I've reverted to mq-deadline to see if it'll reproduce.

snippet (is also attached, and links to full dmesg at the bottom)

[   13.073692] kernel: BUG: kernel NULL pointer dereference, address:
0000000000000090
[   13.074531] kernel: videodev: Linux video capture interface: v2.00
[   13.076620] kernel: #PF: supervisor read access in kernel mode
[   13.076622] kernel: #PF: error_code(0x0000) - not-present page
[   13.076623] kernel: PGD 0 P4D 0
[   13.084269] kernel: Oops: 0000 [#1] PREEMPT SMP NOPTI
[   13.088740] kernel: Hardware name: LENOVO 20QDS3E200/20QDS3E200,
BIOS N2HET66W (1.49 ) 11/10/2021
[   13.091595] kernel: RIP: 0010:kyber_bio_merge+0x6e/0xd0
[   13.094276] kernel: Code: b4 d0 90 00 00 00 41 0f b7 b6 9c 01 00 00
49 8b 96 50 01 00 00 0f b7 84 70 84 00 00 00 be 78 00 00 00 48 8d 1c
40 48 c1 e3 06 <48> 03 9a 90 00 00 00 81 e1 fc 00 00 00 75 0f 8b 04 bd
c0 bf 4a ad
[   13.096640] kernel: RSP: 0018:ffffbc22c14276d8 EFLAGS: 00010246
[   13.099229] kernel: RAX: 0000000000000000 RBX: 0000000000000000
RCX: 0000000000001000
[   13.101858] kernel: RDX: 0000000000000000 RSI: 0000000000000078
RDI: 0000000000000000
[   13.104491] kernel: RBP: ffff9c0587dba2f0 R08: 0000000000000001
R09: 0000000000140000
[   13.107479] kernel: R10: ffffbc22c14276b0 R11: ffffbc22c14276a8
R12: 0000000000000001
[   13.110413] kernel: R13: 0000000000000001 R14: ffff9c05813ba000
R15: ffff9c05fea49358
[   13.111217] kernel: mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[   13.113313] kernel: FS:  00007fca06344580(0000)
GS:ffff9c08eda00000(0000) knlGS:0000000000000000
[   13.113316] kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.113318] kernel: CR2: 0000000000000090 CR3: 000000010c60e003
CR4: 00000000003706e0
[   13.124310] kernel: DR0: 0000000000000000 DR1: 0000000000000000
DR2: 0000000000000000
[   13.126901] kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0
DR7: 0000000000000400
[   13.129458] kernel: Call Trace:
[   13.132014] kernel:  <TASK>
[   13.134350] kernel:  blk_mq_submit_bio+0x35b/0x8c0
[   13.136882] kernel:  ? lock_is_held_type+0xea/0x140
[   13.138644] kernel:  submit_bio_noacct+0x1f4/0x2a0
[   13.140330] kernel:  btrfs_map_bio+0x18b/0x4e0
[   13.141956] kernel:  ? rcu_read_lock_sched_held+0x3b/0x70
[   13.143682] kernel:  btrfs_submit_metadata_bio+0x89/0x120
[   13.145337] kernel:  submit_one_bio+0x6a/0x80
[   13.147054] kernel:  read_extent_buffer_pages+0x254/0x730
[   13.148755] kernel:  btree_read_extent_buffer_pages+0x97/0x110
[   13.150349] kernel:  read_tree_block+0x37/0x60
[   13.151959] kernel:  read_block_for_search+0x184/0x210
[   13.153500] kernel:  btrfs_search_slot+0x35c/0xc30
[   13.155044] kernel:  btrfs_lookup_inode+0x2a/0x90
[   13.156420] kernel:  btrfs_read_locked_inode+0x4cf/0x600
[   13.158092] kernel:  ? btrfs_attach_transaction_barrier+0x50/0x50
[   13.159530] kernel:  btrfs_iget_path+0x6b/0xc0
[   13.161122] kernel:  btrfs_lookup_dentry+0x3c2/0x4f0
[   13.162688] kernel:  btrfs_lookup+0xe/0x30
[   13.163984] kernel:  __lookup_slow+0x10c/0x1e0
[   13.165397] kernel:  ? lock_is_held_type+0xea/0x140
[   13.167408] kernel:  ? lock_is_held_type+0xea/0x140
[   13.168706] kernel:  walk_component+0x103/0x180
[   13.169948] kernel:  link_path_walk.part.0.constprop.0+0x22c/0x3b0
[   13.171298] kernel:  path_openat+0xa1/0xcd0
[   13.172585] kernel:  do_filp_open+0xa1/0x130
[   13.173840] kernel:  ? __lookup_hash+0xa0/0xa0
[   13.174992] kernel:  ? _raw_spin_unlock+0x29/0x40
[   13.176169] kernel:  ? alloc_fd+0x14b/0x1f0
[   13.177378] kernel:  do_sys_openat2+0x74/0x130
[   13.178581] kernel:  __x64_sys_openat+0x5c/0x70
[   13.179728] kernel:  do_syscall_64+0x37/0x80
[   13.181325] kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   13.182697] kernel: RIP: 0033:0x7fca06eeecd8
[   13.184246] kernel: Code: f0 25 00 00 41 00 3d 00 00 41 00 74 45 64
8b 04 25 18 00 00 00 85 c0 75 69 89 da 48 89 ee bf 9c ff ff ff b8 01
01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 8c 00 00 00 48 8b 54 24 28 64
48 2b 14 25
[   13.185910] kernel: RSP: 002b:00007ffcda8ad6a0 EFLAGS: 00000246
ORIG_RAX: 0000000000000101
[   13.187604] kernel: RAX: ffffffffffffffda RBX: 0000000000080000
RCX: 00007fca06eeecd8
[   13.189122] kernel: RDX: 0000000000080000 RSI: 000055f4bb3f3130
RDI: 00000000ffffff9c
[   13.190908] kernel: RBP: 000055f4bb3f3130 R08: 0000000000000040
R09: 0000000000000000
[   13.192734] kernel: R10: 0000000000000000 R11: 0000000000000246
R12: 000055f4bb4d5b40
[   13.194753] kernel: R13: 000055f4bb3ed470 R14: 0000000000000000
R15: 0000000000000000
[   13.196603] kernel:  </TASK>
[   13.197913] kernel: Modules linked in: pcc_cpufreq(+) videodev
fjes(-) acpi_cpufreq(-) mei_me mc cfg80211
processor_thermal_device_pci_legacy processor_thermal_device mei
idma64 ecdh_generic processor_thermal_rfim processor_thermal_mbox
processor_thermal_rapl intel_rapl_common intel_soc_dts_iosf
intel_pch_thermal thinkpad_acpi ledtrig_audio platform_profile rfkill
snd int3403_thermal soundcore int340x_thermal_zone int3400_thermal
acpi_thermal_rel acpi_pad acpi_tad zram i915 hid_multitouch
crct10dif_pclmul crc32_pclmul nvme crc32c_intel ucsi_acpi
ghash_clmulni_intel e1000e serio_raw typec_ucsi nvme_core ttm typec
wmi i2c_hid_acpi i2c_hid video pinctrl_cannonlake ipmi_devintf
ipmi_msghandler fuse
[   13.203747] kernel: CR2: 0000000000000090
[   13.205740] kernel: ---[ end trace 0000000000000000 ]---
[   13.207913] kernel: RIP: 0010:kyber_bio_merge+0x6e/0xd0
[   13.210178] kernel: Code: b4 d0 90 00 00 00 41 0f b7 b6 9c 01 00 00
49 8b 96 50 01 00 00 0f b7 84 70 84 00 00 00 be 78 00 00 00 48 8d 1c
40 48 c1 e3 06 <48> 03 9a 90 00 00 00 81 e1 fc 00 00 00 75 0f 8b 04 bd
c0 bf 4a ad
[   13.212479] kernel: RSP: 0018:ffffbc22c14276d8 EFLAGS: 00010246
[   13.214831] kernel: RAX: 0000000000000000 RBX: 0000000000000000
RCX: 0000000000001000
[   13.217283] kernel: RDX: 0000000000000000 RSI: 0000000000000078
RDI: 0000000000000000
[   13.219612] kernel: RBP: ffff9c0587dba2f0 R08: 0000000000000001
R09: 0000000000140000
[   13.221851] kernel: R10: ffffbc22c14276b0 R11: ffffbc22c14276a8
R12: 0000000000000001
[   13.224164] kernel: R13: 0000000000000001 R14: ffff9c05813ba000
R15: ffff9c05fea49358
[   13.226308] kernel: FS:  00007fca06344580(0000)
GS:ffff9c08eda00000(0000) knlGS:0000000000000000
[   13.228430] kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.230420] kernel: CR2: 0000000000000090 CR3: 000000010c60e003
CR4: 00000000003706e0
[   13.232329] kernel: DR0: 0000000000000000 DR1: 0000000000000000
DR2: 0000000000000000
[   13.232330] kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0
DR7: 0000000000000400
[   13.241317] kernel: Bluetooth: Core ver 2.22

Not filtered
https://drive.google.com/file/d/1P504ZTp85VYgFRnF0dM8R6tizuqmkOA9/view?usp=sharing

DRM messages filtered out
https://drive.google.com/file/d/1OrBYLAvlXnV6aUDTwCMYqcYkrEzpEiUm/view?usp=sharing



-- 
Chris Murphy

--000000000000d62a7005d82d885a
Content-Type: text/plain; charset="US-ASCII"; name="hangdmesg-snippet.txt"
Content-Disposition: attachment; filename="hangdmesg-snippet.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kzqd5mws0>
X-Attachment-Id: f_kzqd5mws0

WyAgIDEzLjA3MzY5Ml0ga2VybmVsOiBCVUc6IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVu
Y2UsIGFkZHJlc3M6IDAwMDAwMDAwMDAwMDAwOTAKWyAgIDEzLjA3NDUzMV0ga2VybmVsOiB2aWRl
b2RldjogTGludXggdmlkZW8gY2FwdHVyZSBpbnRlcmZhY2U6IHYyLjAwClsgICAxMy4wNzY2MjBd
IGtlcm5lbDogI1BGOiBzdXBlcnZpc29yIHJlYWQgYWNjZXNzIGluIGtlcm5lbCBtb2RlClsgICAx
My4wNzY2MjJdIGtlcm5lbDogI1BGOiBlcnJvcl9jb2RlKDB4MDAwMCkgLSBub3QtcHJlc2VudCBw
YWdlClsgICAxMy4wNzY2MjNdIGtlcm5lbDogUEdEIDAgUDREIDAgClsgICAxMy4wODQyNjldIGtl
cm5lbDogT29wczogMDAwMCBbIzFdIFBSRUVNUFQgU01QIE5PUFRJClsgICAxMy4wODg3NDBdIGtl
cm5lbDogSGFyZHdhcmUgbmFtZTogTEVOT1ZPIDIwUURTM0UyMDAvMjBRRFMzRTIwMCwgQklPUyBO
MkhFVDY2VyAoMS40OSApIDExLzEwLzIwMjEKWyAgIDEzLjA5MTU5NV0ga2VybmVsOiBSSVA6IDAw
MTA6a3liZXJfYmlvX21lcmdlKzB4NmUvMHhkMApbICAgMTMuMDk0Mjc2XSBrZXJuZWw6IENvZGU6
IGI0IGQwIDkwIDAwIDAwIDAwIDQxIDBmIGI3IGI2IDljIDAxIDAwIDAwIDQ5IDhiIDk2IDUwIDAx
IDAwIDAwIDBmIGI3IDg0IDcwIDg0IDAwIDAwIDAwIGJlIDc4IDAwIDAwIDAwIDQ4IDhkIDFjIDQw
IDQ4IGMxIGUzIDA2IDw0OD4gMDMgOWEgOTAgMDAgMDAgMDAgODEgZTEgZmMgMDAgMDAgMDAgNzUg
MGYgOGIgMDQgYmQgYzAgYmYgNGEgYWQKWyAgIDEzLjA5NjY0MF0ga2VybmVsOiBSU1A6IDAwMTg6
ZmZmZmJjMjJjMTQyNzZkOCBFRkxBR1M6IDAwMDEwMjQ2ClsgICAxMy4wOTkyMjldIGtlcm5lbDog
UkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogMDAwMDAwMDAwMDAwMDAwMCBSQ1g6IDAwMDAwMDAw
MDAwMDEwMDAKWyAgIDEzLjEwMTg1OF0ga2VybmVsOiBSRFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJ
OiAwMDAwMDAwMDAwMDAwMDc4IFJESTogMDAwMDAwMDAwMDAwMDAwMApbICAgMTMuMTA0NDkxXSBr
ZXJuZWw6IFJCUDogZmZmZjljMDU4N2RiYTJmMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDEgUjA5OiAw
MDAwMDAwMDAwMTQwMDAwClsgICAxMy4xMDc0NzldIGtlcm5lbDogUjEwOiBmZmZmYmMyMmMxNDI3
NmIwIFIxMTogZmZmZmJjMjJjMTQyNzZhOCBSMTI6IDAwMDAwMDAwMDAwMDAwMDEKWyAgIDEzLjEx
MDQxM10ga2VybmVsOiBSMTM6IDAwMDAwMDAwMDAwMDAwMDEgUjE0OiBmZmZmOWMwNTgxM2JhMDAw
IFIxNTogZmZmZjljMDVmZWE0OTM1OApbICAgMTMuMTExMjE3XSBrZXJuZWw6IG1laV9tZSAwMDAw
OjAwOjE2LjA6IGVuYWJsaW5nIGRldmljZSAoMDAwMCAtPiAwMDAyKQpbICAgMTMuMTEzMzEzXSBr
ZXJuZWw6IEZTOiAgMDAwMDdmY2EwNjM0NDU4MCgwMDAwKSBHUzpmZmZmOWMwOGVkYTAwMDAwKDAw
MDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDAKWyAgIDEzLjExMzMxNl0ga2VybmVsOiBDUzogIDAw
MTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzClsgICAxMy4xMTMzMThd
IGtlcm5lbDogQ1IyOiAwMDAwMDAwMDAwMDAwMDkwIENSMzogMDAwMDAwMDEwYzYwZTAwMyBDUjQ6
IDAwMDAwMDAwMDAzNzA2ZTAKWyAgIDEzLjEyNDMxMF0ga2VybmVsOiBEUjA6IDAwMDAwMDAwMDAw
MDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAwMDAwIERSMjogMDAwMDAwMDAwMDAwMDAwMApbICAgMTMu
MTI2OTAxXSBrZXJuZWw6IERSMzogMDAwMDAwMDAwMDAwMDAwMCBEUjY6IDAwMDAwMDAwZmZmZTBm
ZjAgRFI3OiAwMDAwMDAwMDAwMDAwNDAwClsgICAxMy4xMjk0NThdIGtlcm5lbDogQ2FsbCBUcmFj
ZToKWyAgIDEzLjEzMjAxNF0ga2VybmVsOiAgPFRBU0s+ClsgICAxMy4xMzQzNTBdIGtlcm5lbDog
IGJsa19tcV9zdWJtaXRfYmlvKzB4MzViLzB4OGMwClsgICAxMy4xMzY4ODJdIGtlcm5lbDogID8g
bG9ja19pc19oZWxkX3R5cGUrMHhlYS8weDE0MApbICAgMTMuMTM4NjQ0XSBrZXJuZWw6ICBzdWJt
aXRfYmlvX25vYWNjdCsweDFmNC8weDJhMApbICAgMTMuMTQwMzMwXSBrZXJuZWw6ICBidHJmc19t
YXBfYmlvKzB4MThiLzB4NGUwClsgICAxMy4xNDE5NTZdIGtlcm5lbDogID8gcmN1X3JlYWRfbG9j
a19zY2hlZF9oZWxkKzB4M2IvMHg3MApbICAgMTMuMTQzNjgyXSBrZXJuZWw6ICBidHJmc19zdWJt
aXRfbWV0YWRhdGFfYmlvKzB4ODkvMHgxMjAKWyAgIDEzLjE0NTMzN10ga2VybmVsOiAgc3VibWl0
X29uZV9iaW8rMHg2YS8weDgwClsgICAxMy4xNDcwNTRdIGtlcm5lbDogIHJlYWRfZXh0ZW50X2J1
ZmZlcl9wYWdlcysweDI1NC8weDczMApbICAgMTMuMTQ4NzU1XSBrZXJuZWw6ICBidHJlZV9yZWFk
X2V4dGVudF9idWZmZXJfcGFnZXMrMHg5Ny8weDExMApbICAgMTMuMTUwMzQ5XSBrZXJuZWw6ICBy
ZWFkX3RyZWVfYmxvY2srMHgzNy8weDYwClsgICAxMy4xNTE5NTldIGtlcm5lbDogIHJlYWRfYmxv
Y2tfZm9yX3NlYXJjaCsweDE4NC8weDIxMApbICAgMTMuMTUzNTAwXSBrZXJuZWw6ICBidHJmc19z
ZWFyY2hfc2xvdCsweDM1Yy8weGMzMApbICAgMTMuMTU1MDQ0XSBrZXJuZWw6ICBidHJmc19sb29r
dXBfaW5vZGUrMHgyYS8weDkwClsgICAxMy4xNTY0MjBdIGtlcm5lbDogIGJ0cmZzX3JlYWRfbG9j
a2VkX2lub2RlKzB4NGNmLzB4NjAwClsgICAxMy4xNTgwOTJdIGtlcm5lbDogID8gYnRyZnNfYXR0
YWNoX3RyYW5zYWN0aW9uX2JhcnJpZXIrMHg1MC8weDUwClsgICAxMy4xNTk1MzBdIGtlcm5lbDog
IGJ0cmZzX2lnZXRfcGF0aCsweDZiLzB4YzAKWyAgIDEzLjE2MTEyMl0ga2VybmVsOiAgYnRyZnNf
bG9va3VwX2RlbnRyeSsweDNjMi8weDRmMApbICAgMTMuMTYyNjg4XSBrZXJuZWw6ICBidHJmc19s
b29rdXArMHhlLzB4MzAKWyAgIDEzLjE2Mzk4NF0ga2VybmVsOiAgX19sb29rdXBfc2xvdysweDEw
Yy8weDFlMApbICAgMTMuMTY1Mzk3XSBrZXJuZWw6ICA/IGxvY2tfaXNfaGVsZF90eXBlKzB4ZWEv
MHgxNDAKWyAgIDEzLjE2NzQwOF0ga2VybmVsOiAgPyBsb2NrX2lzX2hlbGRfdHlwZSsweGVhLzB4
MTQwClsgICAxMy4xNjg3MDZdIGtlcm5lbDogIHdhbGtfY29tcG9uZW50KzB4MTAzLzB4MTgwClsg
ICAxMy4xNjk5NDhdIGtlcm5lbDogIGxpbmtfcGF0aF93YWxrLnBhcnQuMC5jb25zdHByb3AuMCsw
eDIyYy8weDNiMApbICAgMTMuMTcxMjk4XSBrZXJuZWw6ICBwYXRoX29wZW5hdCsweGExLzB4Y2Qw
ClsgICAxMy4xNzI1ODVdIGtlcm5lbDogIGRvX2ZpbHBfb3BlbisweGExLzB4MTMwClsgICAxMy4x
NzM4NDBdIGtlcm5lbDogID8gX19sb29rdXBfaGFzaCsweGEwLzB4YTAKWyAgIDEzLjE3NDk5Ml0g
a2VybmVsOiAgPyBfcmF3X3NwaW5fdW5sb2NrKzB4MjkvMHg0MApbICAgMTMuMTc2MTY5XSBrZXJu
ZWw6ICA/IGFsbG9jX2ZkKzB4MTRiLzB4MWYwClsgICAxMy4xNzczNzhdIGtlcm5lbDogIGRvX3N5
c19vcGVuYXQyKzB4NzQvMHgxMzAKWyAgIDEzLjE3ODU4MV0ga2VybmVsOiAgX194NjRfc3lzX29w
ZW5hdCsweDVjLzB4NzAKWyAgIDEzLjE3OTcyOF0ga2VybmVsOiAgZG9fc3lzY2FsbF82NCsweDM3
LzB4ODAKWyAgIDEzLjE4MTMyNV0ga2VybmVsOiAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2Zy
YW1lKzB4NDQvMHhhZQpbICAgMTMuMTgyNjk3XSBrZXJuZWw6IFJJUDogMDAzMzoweDdmY2EwNmVl
ZWNkOApbICAgMTMuMTg0MjQ2XSBrZXJuZWw6IENvZGU6IGYwIDI1IDAwIDAwIDQxIDAwIDNkIDAw
IDAwIDQxIDAwIDc0IDQ1IDY0IDhiIDA0IDI1IDE4IDAwIDAwIDAwIDg1IGMwIDc1IDY5IDg5IGRh
IDQ4IDg5IGVlIGJmIDljIGZmIGZmIGZmIGI4IDAxIDAxIDAwIDAwIDBmIDA1IDw0OD4gM2QgMDAg
ZjAgZmYgZmYgMGYgODcgOGMgMDAgMDAgMDAgNDggOGIgNTQgMjQgMjggNjQgNDggMmIgMTQgMjUK
WyAgIDEzLjE4NTkxMF0ga2VybmVsOiBSU1A6IDAwMmI6MDAwMDdmZmNkYThhZDZhMCBFRkxBR1M6
IDAwMDAwMjQ2IE9SSUdfUkFYOiAwMDAwMDAwMDAwMDAwMTAxClsgICAxMy4xODc2MDRdIGtlcm5l
bDogUkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDAwMDAwMDA4MDAwMCBSQ1g6IDAwMDA3
ZmNhMDZlZWVjZDgKWyAgIDEzLjE4OTEyMl0ga2VybmVsOiBSRFg6IDAwMDAwMDAwMDAwODAwMDAg
UlNJOiAwMDAwNTVmNGJiM2YzMTMwIFJESTogMDAwMDAwMDBmZmZmZmY5YwpbICAgMTMuMTkwOTA4
XSBrZXJuZWw6IFJCUDogMDAwMDU1ZjRiYjNmMzEzMCBSMDg6IDAwMDAwMDAwMDAwMDAwNDAgUjA5
OiAwMDAwMDAwMDAwMDAwMDAwClsgICAxMy4xOTI3MzRdIGtlcm5lbDogUjEwOiAwMDAwMDAwMDAw
MDAwMDAwIFIxMTogMDAwMDAwMDAwMDAwMDI0NiBSMTI6IDAwMDA1NWY0YmI0ZDViNDAKWyAgIDEz
LjE5NDc1M10ga2VybmVsOiBSMTM6IDAwMDA1NWY0YmIzZWQ0NzAgUjE0OiAwMDAwMDAwMDAwMDAw
MDAwIFIxNTogMDAwMDAwMDAwMDAwMDAwMApbICAgMTMuMTk2NjAzXSBrZXJuZWw6ICA8L1RBU0s+
ClsgICAxMy4xOTc5MTNdIGtlcm5lbDogTW9kdWxlcyBsaW5rZWQgaW46IHBjY19jcHVmcmVxKCsp
IHZpZGVvZGV2IGZqZXMoLSkgYWNwaV9jcHVmcmVxKC0pIG1laV9tZSBtYyBjZmc4MDIxMSBwcm9j
ZXNzb3JfdGhlcm1hbF9kZXZpY2VfcGNpX2xlZ2FjeSBwcm9jZXNzb3JfdGhlcm1hbF9kZXZpY2Ug
bWVpIGlkbWE2NCBlY2RoX2dlbmVyaWMgcHJvY2Vzc29yX3RoZXJtYWxfcmZpbSBwcm9jZXNzb3Jf
dGhlcm1hbF9tYm94IHByb2Nlc3Nvcl90aGVybWFsX3JhcGwgaW50ZWxfcmFwbF9jb21tb24gaW50
ZWxfc29jX2R0c19pb3NmIGludGVsX3BjaF90aGVybWFsIHRoaW5rcGFkX2FjcGkgbGVkdHJpZ19h
dWRpbyBwbGF0Zm9ybV9wcm9maWxlIHJma2lsbCBzbmQgaW50MzQwM190aGVybWFsIHNvdW5kY29y
ZSBpbnQzNDB4X3RoZXJtYWxfem9uZSBpbnQzNDAwX3RoZXJtYWwgYWNwaV90aGVybWFsX3JlbCBh
Y3BpX3BhZCBhY3BpX3RhZCB6cmFtIGk5MTUgaGlkX211bHRpdG91Y2ggY3JjdDEwZGlmX3BjbG11
bCBjcmMzMl9wY2xtdWwgbnZtZSBjcmMzMmNfaW50ZWwgdWNzaV9hY3BpIGdoYXNoX2NsbXVsbmlf
aW50ZWwgZTEwMDBlIHNlcmlvX3JhdyB0eXBlY191Y3NpIG52bWVfY29yZSB0dG0gdHlwZWMgd21p
IGkyY19oaWRfYWNwaSBpMmNfaGlkIHZpZGVvIHBpbmN0cmxfY2Fubm9ubGFrZSBpcG1pX2Rldmlu
dGYgaXBtaV9tc2doYW5kbGVyIGZ1c2UKWyAgIDEzLjIwMzc0N10ga2VybmVsOiBDUjI6IDAwMDAw
MDAwMDAwMDAwOTAKWyAgIDEzLjIwNTc0MF0ga2VybmVsOiAtLS1bIGVuZCB0cmFjZSAwMDAwMDAw
MDAwMDAwMDAwIF0tLS0KWyAgIDEzLjIwNzkxM10ga2VybmVsOiBSSVA6IDAwMTA6a3liZXJfYmlv
X21lcmdlKzB4NmUvMHhkMApbICAgMTMuMjEwMTc4XSBrZXJuZWw6IENvZGU6IGI0IGQwIDkwIDAw
IDAwIDAwIDQxIDBmIGI3IGI2IDljIDAxIDAwIDAwIDQ5IDhiIDk2IDUwIDAxIDAwIDAwIDBmIGI3
IDg0IDcwIDg0IDAwIDAwIDAwIGJlIDc4IDAwIDAwIDAwIDQ4IDhkIDFjIDQwIDQ4IGMxIGUzIDA2
IDw0OD4gMDMgOWEgOTAgMDAgMDAgMDAgODEgZTEgZmMgMDAgMDAgMDAgNzUgMGYgOGIgMDQgYmQg
YzAgYmYgNGEgYWQKWyAgIDEzLjIxMjQ3OV0ga2VybmVsOiBSU1A6IDAwMTg6ZmZmZmJjMjJjMTQy
NzZkOCBFRkxBR1M6IDAwMDEwMjQ2ClsgICAxMy4yMTQ4MzFdIGtlcm5lbDogUkFYOiAwMDAwMDAw
MDAwMDAwMDAwIFJCWDogMDAwMDAwMDAwMDAwMDAwMCBSQ1g6IDAwMDAwMDAwMDAwMDEwMDAKWyAg
IDEzLjIxNzI4M10ga2VybmVsOiBSRFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJOiAwMDAwMDAwMDAw
MDAwMDc4IFJESTogMDAwMDAwMDAwMDAwMDAwMApbICAgMTMuMjE5NjEyXSBrZXJuZWw6IFJCUDog
ZmZmZjljMDU4N2RiYTJmMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDEgUjA5OiAwMDAwMDAwMDAwMTQw
MDAwClsgICAxMy4yMjE4NTFdIGtlcm5lbDogUjEwOiBmZmZmYmMyMmMxNDI3NmIwIFIxMTogZmZm
ZmJjMjJjMTQyNzZhOCBSMTI6IDAwMDAwMDAwMDAwMDAwMDEKWyAgIDEzLjIyNDE2NF0ga2VybmVs
OiBSMTM6IDAwMDAwMDAwMDAwMDAwMDEgUjE0OiBmZmZmOWMwNTgxM2JhMDAwIFIxNTogZmZmZjlj
MDVmZWE0OTM1OApbICAgMTMuMjI2MzA4XSBrZXJuZWw6IEZTOiAgMDAwMDdmY2EwNjM0NDU4MCgw
MDAwKSBHUzpmZmZmOWMwOGVkYTAwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDAKWyAg
IDEzLjIyODQzMF0ga2VybmVsOiBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAw
MDAwMDgwMDUwMDMzClsgICAxMy4yMzA0MjBdIGtlcm5lbDogQ1IyOiAwMDAwMDAwMDAwMDAwMDkw
IENSMzogMDAwMDAwMDEwYzYwZTAwMyBDUjQ6IDAwMDAwMDAwMDAzNzA2ZTAKWyAgIDEzLjIzMjMy
OV0ga2VybmVsOiBEUjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAwMDAwIERS
MjogMDAwMDAwMDAwMDAwMDAwMApbICAgMTMuMjMyMzMwXSBrZXJuZWw6IERSMzogMDAwMDAwMDAw
MDAwMDAwMCBEUjY6IDAwMDAwMDAwZmZmZTBmZjAgRFI3OiAwMDAwMDAwMDAwMDAwNDAwClsgICAx
My4yNDEzMTddIGtlcm5lbDogQmx1ZXRvb3RoOiBDb3JlIHZlciAyLjIyCg==
--000000000000d62a7005d82d885a--
