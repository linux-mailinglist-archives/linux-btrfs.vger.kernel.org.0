Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9833F225E93
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jul 2020 14:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgGTMbS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jul 2020 08:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgGTMbS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jul 2020 08:31:18 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8F0C061794
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jul 2020 05:31:17 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id e4so14253447oib.1
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jul 2020 05:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=VpSZvXKtIBjcBI5AyknBIPfuED7V3L2fP7F3wyF5Y14=;
        b=QQryprfR7ytvzZtDXGa1sVwMkLGx+7BuOAEGcu5j6B0iR9YQGGTLcD4KdOWUMVsLKj
         I+gv3BzgoVmjXa7oJfEMxKBlcxeeKL2QRsZFiN7X6QJHHMpMQmhI9AxVVfXAo7Ft7O+N
         FBxoATliqTk0EMGdGQ9M0eovmziM8PbdsT2m6TA6DmW/i3Mq/c52Z9eeODkzayQgsKjz
         s1Eg9iPzAr68/4/zY/IiYk/G8dmOdVuh7yMvGFMZQ6cvJApr/KZAKdVD6090KpAaCt2M
         nRe1+Gm6i/Veq7BvLr6DCX6IDn97Edv3OCTNSjz40f7twMoLSMO6FM9neCASgSdmhYeg
         dobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VpSZvXKtIBjcBI5AyknBIPfuED7V3L2fP7F3wyF5Y14=;
        b=Gz8gZiSmJ4NGkvclmewSswHptS1K6qyozqcRRmvybVWLLdQFwSEE/mpHX5hlXZPfBD
         rbrMpyPX5IZUE16poujZAzOCJTF5Xw19A/qrdxJc5AAfj82eNUT6lbcvDIf7EGBBsoJO
         y/mj69BDGGIByZdoZUAwHFLQ7pRe5E00CUdkTQ1S6vCRAOdpvqo3j0SP45oeRER/t/1+
         5quXrBXN0yk7ps7nr3wnB20aaW5d1fPC8SVFjZhbA3g8E2sGPoABVjGovMprm8d8/fbl
         yOa1xDOe1WDJpprQmGcYFOcEkO626k7QTMOKyZwWSGmK0Kr70YpzLdj22C1uwjL8XPlF
         5hDQ==
X-Gm-Message-State: AOAM531JCsAAdMQvZcQVHd3ie0x00awEldbVkb5XcVTieDoFrywi7CQ+
        fnXrzFlOM8yuMi1eV9Fzs4gn1MFvLLgl5/i52J5eGdCK
X-Google-Smtp-Source: ABdhPJxkmLQAJqOAmDGcovXs//QLhurQG299yNnoZHyfiddwpzFQKCwD3A+ctDl/fUpg7KCOnpoGR0b0qm+OKC/PnYY=
X-Received: by 2002:aca:75d1:: with SMTP id q200mr16661419oic.61.1595248276614;
 Mon, 20 Jul 2020 05:31:16 -0700 (PDT)
MIME-Version: 1.0
From:   Chiung-Ming Huang <photon3108@gmail.com>
Date:   Mon, 20 Jul 2020 20:31:05 +0800
Message-ID: <CAEOGEKHbFoZGuVHWCYAcKyArczmqjBAUVFvh8upe7vKTO0gVrQ@mail.gmail.com>
Subject: How to fix scrub aborted?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi everyone

I lost two disks and then I tried to scrub. But it's always aborted.
These are dmesg below. Thanks.

[Sat Jul 18 16:08:49 2020] Btrfs loaded, crc32c=crc32c-intel
[Sat Jul 18 16:08:49 2020] BTRFS: device fsid
76f7c004-2684-4956-a614-43472049ea06 devid 6 transid 417627
/dev/mapper/disk-hn
[Sat Jul 18 16:08:49 2020] BTRFS: device fsid
76f7c004-2684-4956-a614-43472049ea06 devid 5 transid 417627
/dev/mapper/disk-w6
[Sat Jul 18 16:08:49 2020] BTRFS: device fsid
76f7c004-2684-4956-a614-43472049ea06 devid 4 transid 417627
/dev/mapper/disk-te
[Sat Jul 18 16:08:49 2020] BTRFS: device fsid
4d52cb05-0e1e-47b1-9ddc-ce440eed0f56 devid 1 transid 613
/dev/mapper/boot
[Sat Jul 18 16:08:49 2020] BTRFS: device fsid
25814f60-8609-48b1-8b94-8abbf616dc7a devid 1 transid 11440656
/dev/mapper/rescue
[Sat Jul 18 16:08:50 2020] BTRFS info (device dm-0): disk space
caching is enabled
[Sat Jul 18 16:08:50 2020] BTRFS info (device dm-0): has skinny extents
[Sat Jul 18 16:08:50 2020] BTRFS info (device dm-0): enabling ssd optimizations
[Sat Jul 18 16:08:50 2020] BTRFS info (device dm-0): disk space
caching is enabled
[Sat Jul 18 16:08:51 2020] BTRFS info (device dm-0): device fsid
25814f60-8609-48b1-8b94-8abbf616dc7a devid 1 moved
old:/dev/mapper/rescue new:/dev/dm-0
[Sat Jul 18 16:08:51 2020] BTRFS info (device dm-0): device fsid
25814f60-8609-48b1-8b94-8abbf616dc7a devid 1 moved old:/dev/dm-0
new:/dev/mapper/rescue
[Sat Jul 18 16:11:16 2020] BTRFS info (device dm-2): disk space
caching is enabled
[Sat Jul 18 16:11:16 2020] BTRFS info (device dm-2): has skinny extents
[Sat Jul 18 16:11:16 2020] BTRFS error (device dm-2): devid 2 uuid
6a42b1ec-a0fe-47d7-8cdc-9835672430ea is missing
[Sat Jul 18 16:11:16 2020] BTRFS error (device dm-2): failed to read
the system array: -2
[Sat Jul 18 16:11:16 2020] BTRFS error (device dm-2): open_ctree failed
[Sat Jul 18 16:18:02 2020] BTRFS info (device dm-2): disk space
caching is enabled
[Sat Jul 18 16:18:02 2020] BTRFS info (device dm-2): has skinny extents
[Sat Jul 18 16:18:02 2020] BTRFS error (device dm-2): devid 2 uuid
6a42b1ec-a0fe-47d7-8cdc-9835672430ea is missing
[Sat Jul 18 16:18:02 2020] BTRFS error (device dm-2): failed to read
the system array: -2
[Sat Jul 18 16:18:02 2020] BTRFS error (device dm-2): open_ctree failed
[Sat Jul 18 16:19:25 2020] BTRFS info (device dm-2): allowing degraded mounts
[Sat Jul 18 16:19:25 2020] BTRFS info (device dm-2): disk space
caching is enabled
[Sat Jul 18 16:19:25 2020] BTRFS info (device dm-2): has skinny extents
[Sat Jul 18 16:19:25 2020] BTRFS warning (device dm-2): devid 2 uuid
6a42b1ec-a0fe-47d7-8cdc-9835672430ea is missing
[Sat Jul 18 16:19:25 2020] BTRFS warning (device dm-2): devid 1 uuid
b572e9b0-4ef3-4006-b300-e145b72c3945 is missing
[Sat Jul 18 16:19:25 2020] BTRFS warning (device dm-2): devid 2 uuid
6a42b1ec-a0fe-47d7-8cdc-9835672430ea is missing
[Sat Jul 18 16:19:26 2020] BTRFS info (device dm-2): bdev (efault)
errs: wr 167491685, rd 147424524, flush 182654, corrupt 0, gen 0
[Sat Jul 18 16:19:26 2020] BTRFS info (device dm-2): bdev
/dev/mapper/disk-te errs: wr 0, rd 0, flush 0, corrupt 0, gen 3
[Sat Jul 18 16:20:02 2020] BTRFS info (device dm-2): enabling ssd optimizations
[Sat Jul 18 16:20:02 2020] BTRFS info (device dm-1): disk space
caching is enabled
[Sat Jul 18 16:20:02 2020] BTRFS info (device dm-1): has skinny extents
[Sat Jul 18 16:20:02 2020] BTRFS info (device dm-1): enabling ssd optimizations
[Sat Jul 18 16:27:48 2020] BTRFS info (device dm-2): scrub: started on devid 6
[Sat Jul 18 22:07:33 2020] BTRFS: Transaction aborted (error -17)
[Sat Jul 18 22:07:33 2020] WARNING: CPU: 3 PID: 2970 at
/build/linux-hwe-eg6_iE/linux-hwe-5.3.0/fs/btrfs/extent-tree.c:2795
btrfs_run_delayed_refs+0x152/0x1a0 [btrfs]
[Sat Jul 18 22:07:33 2020] Modules linked in: rfcomm cmac bnep
nls_iso8859_1 snd_hda_codec_hdmi snd_hda_codec_realtek
snd_hda_codec_generic edac_mce_amd ledtrig_audio kvm_amd btusb ccp
btrtl kvm snd_hda_intel btbcm irqbypass snd_intel_dspcfg btintel
joydev snd_seq_midi snd_seq_midi_event input_leds snd_hda_codec
bluetooth mxm_wmi snd_hda_core snd_rawmidi fam15h_power k10temp
snd_hwdep snd_pcm snd_seq ecdh_generic ecc snd_seq_device snd_timer
snd soundcore mac_hid nvidia_uvm(OE) sch_fq_codel parport_pc ppdev lp
parport ip_tables x_tables autofs4 btrfs xor zstd_compress raid6_pq
libcrc32c algif_skcipher af_alg dm_crypt hid_logitech_hidpp
hid_logitech_dj hid_generic usbhid hid nvidia_drm(POE)
nvidia_modeset(POE) bcache crc64 crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel nvidia(POE) drm_kms_helper syscopyarea aesni_intel
sysfillrect sysimgblt fb_sys_fops aes_x86_64 crypto_simd drm cryptd
glue_helper r8169 ipmi_devintf nvme realtek ahci nvme_core i2c_piix4
libahci ipmi_msghandler wmi
[Sat Jul 18 22:07:33 2020] CPU: 3 PID: 2970 Comm: btrfs-transacti
Tainted: P           OE     5.3.0-62-generic #56~18.04.1-Ubuntu
[Sat Jul 18 22:07:33 2020] RIP: 0010:btrfs_run_delayed_refs+0x152/0x1a0 [btrfs]
[Sat Jul 18 22:07:33 2020]  commit_cowonly_roots+0xe7/0x2d0 [btrfs]
[Sat Jul 18 22:07:33 2020]  ? btrfs_qgroup_account_extents+0x11c/0x260 [btrfs]
[Sat Jul 18 22:07:33 2020]  btrfs_commit_transaction+0x506/0x980 [btrfs]
[Sat Jul 18 22:07:33 2020]  transaction_kthread+0x148/0x170 [btrfs]
[Sat Jul 18 22:07:33 2020]  ? btrfs_cleanup_transaction+0x570/0x570 [btrfs]
[Sat Jul 18 22:07:33 2020] BTRFS: error (device dm-2) in
btrfs_run_delayed_refs:2795: errno=-17 Object already exists
[Sat Jul 18 22:07:33 2020] BTRFS info (device dm-2): forced readonly
[Sat Jul 18 22:07:33 2020] BTRFS warning (device dm-2): Skipping
commit of aborted transaction.
[Sat Jul 18 22:07:33 2020] BTRFS: error (device dm-2) in
cleanup_transaction:1839: errno=-17 Object already exists
[Sat Jul 18 22:07:33 2020] BTRFS warning (device dm-2): failed setting
block group ro: -30
[Sat Jul 18 22:07:33 2020] BTRFS info (device dm-2): scrub: not
finished on devid 6 with status: -30

Ubuntu 18.04
btrfs-progs v5.7

Regards,
Chiung-Ming Huang
