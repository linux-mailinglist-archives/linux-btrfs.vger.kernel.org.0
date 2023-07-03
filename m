Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A944F7463F2
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 22:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjGCUUU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 16:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGCUUT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 16:20:19 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A13E47
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 13:20:17 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-78caeb69125so1861666241.3
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jul 2023 13:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688415617; x=1691007617;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E2a9Hc39RLGBzVbsXCu/bXxcYVJKJtj4dfjkF8mg4eY=;
        b=RgOqDCXkbFlOG1vhlvl8vFASw9MalEgyeVIwZo7pDpgM3sXqvo1wt9vQUgB3K60dau
         mnva91sA8DSiqHUKl9T3zYlrADdvcKHNdh8b6LDXYbKs5XXoc7M0HwHtTm5sdfOqRxlw
         3Fds7SGmFO2FUWAWi+DgRbXkBuO57szWQSnC5nCM4+t8ZTyf4Nx2AExSPhIWW15FLxr7
         Ja3ypgKJz/LptyGBvBlMMyjktunI1RAseBNfH9Y3/MwilqSg9Eugq5Z7JjoHJBApFoq8
         aPR0wq20gxS9Qe7rvXgy3ghBtWrXdwjYkajt/vLPUWNI3rA/2qDDXticEEW6watjKBKA
         ChQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688415617; x=1691007617;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E2a9Hc39RLGBzVbsXCu/bXxcYVJKJtj4dfjkF8mg4eY=;
        b=BDyDjkxiz8vakwd/gYN4WPh+Uq3h/Eu3DxG04v4kxgz3bBW+0kmQZWRU2Un6AHalg9
         a2xXLrbWTSLMVFHqyqVoMd1HlQndqJe+UH6MKixMY5RhFB9ePLp3YoT/D/9f6IFzZkLf
         XbePnHGIWGnVu5KBl9mzpP5b3Rcq+CnTYKCqFt2TeefncfiMQBpZUNzxLzx/VQtDT/BB
         SZZVHdEMxBUdtXWB09ToDiHhmj3oRrRwTgc/41ER4hQcTX/Fm3Or7kErSCmh4no6l1Al
         epw2bbOWPaKFhiiVAtqAJXGAkT4O0mWthMdcie4xm77HnCw6PY9Bs4m4i54J3JxBHY4l
         ziAA==
X-Gm-Message-State: ABy/qLbdDlkUttb0gEyRxpa/k6PvUPams3sD8KFVwY8iYgbIT8ra6UFb
        JARZi4PPoPpK5Fw3l3ZtREmtrd06EhBieZBJJ9JGkfTMVNE=
X-Google-Smtp-Source: APBJJlGlmaYY4zNHIrP0tc0jTNR8QGNow5HmGq0xuD2lF2Jr3R6xRRGFzhoQ6+Qa+375Ydl5lIxe+2CtgOdaJ7af3bM=
X-Received: by 2002:a67:ec84:0:b0:444:538f:414e with SMTP id
 h4-20020a67ec84000000b00444538f414emr5304283vsp.12.1688415616696; Mon, 03 Jul
 2023 13:20:16 -0700 (PDT)
MIME-Version: 1.0
From:   Tim Cuthbertson <ratcheer@gmail.com>
Date:   Mon, 3 Jul 2023 15:19:50 -0500
Message-ID: <CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com>
Subject: Scrub of my nvme SSD has slowed by about 2/3
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Yesterday, I noticed that a scrub of my main system filesystem has
slowed from about 2.9 gb/sec to about 949 mb/sec. My scrub used to run
in about 12 seconds, now it is taking 51 seconds. I had just installed
Linux kernel 6.4.1 on Arch Linux, upgrading from 6.3.9. At first I
suspected the new kernel, but now I am not so sure.

I have btrfs-progs v 6.3.2-1. It was last upgraded on June 23.

Here are the results of a recent scrub:

btrfs scrub status /mnt/nvme0n1p3/
UUID:             20db1fe2-60a4-4eb7-87ac-1953a55dda16
Scrub started:    Sun Jul  2 19:19:53 2023
Status:           finished
Duration:         0:00:51
Total to scrub:   47.28GiB
Rate:             948.61MiB/s
Error summary:    no errors found

Here is hdparm performance output of the drive:

/dev/nvme0n1:
 Timing O_DIRECT cached reads:   3744 MB in  2.00 seconds = 1871.94 MB/sec
 Timing O_DIRECT disk reads: 9180 MB in  3.00 seconds = 3059.63 MB/sec

Here is an attempt at describing my system:
inxi -F
System:

  Host: tux Kernel: 6.4.1-arch1-1 arch: x86_64 bits: 64 Console: pty
pts/2 Distro: Arch Linux
Machine:
  Type: Desktop Mobo: ASUSTeK model: TUF GAMING X570-PLUS (WI-FI) v: Rev X.0x
    serial: 200771405807421 UEFI: American Megatrends v: 4602 date: 02/23/2023
CPU:
  Info: 12-core model: AMD Ryzen 9 3900X bits: 64 type: MT MCP cache: L2: 6 MiB
  Speed (MHz): avg: 2666 min/max: 2200/4672 cores: 1: 3800 2: 2200 3:
2200 4: 2200 5: 2200
    6: 3800 7: 2200 8: 3800 9: 2200 10: 2200 11: 3800 12: 2200 13:
3800 14: 2200 15: 2200 16: 2200
    17: 2200 18: 2200 19: 2200 20: 2200 21: 3800 22: 2200 23: 2200 24: 3800
Graphics:
  Device-1: NVIDIA TU104 [GeForce RTX 2060] driver: nvidia v: 535.54.03
  Display: server: X.org v: 1.21.1.8 driver: X: loaded: nvidia
unloaded: modesetting gpu: nvidia
    tty: 273x63
  API: OpenGL Message: GL data unavailable in console and glxinfo missing.
Audio:
  Device-1: NVIDIA TU104 HD Audio driver: snd_hda_intel
  Device-2: AMD Starship/Matisse HD Audio driver: snd_hda_intel
  API: ALSA v: k6.4.1-arch1-1 status: kernel-api
Network:
  Device-1: Intel Wireless-AC 9260 driver: iwlwifi
  IF: wlan0 state: up mac: cc:d9:ac:3a:b4:9d
  Device-2: Realtek RTL8111/8168/8411 PCI Express Gigabit Ethernet driver: r8169
  IF: enp5s0 state: down mac: 24:4b:fe:96:38:f9
Bluetooth:
  Device-1: N/A driver: btusb type: USB
  Report: rfkill ID: hci0 rfk-id: 0 state: down bt-service: disabled
rfk-block: hardware: no
    software: no address: see --recommends
Drives:
  Local Storage: total: 7.73 TiB used: 378.62 GiB (4.8%)
  ID-1: /dev/nvme0n1 vendor: Western Digital model: WDBRPG0010BNC-WRSN
size: 931.51 GiB
  ID-2: /dev/sda vendor: Samsung model: SSD 860 EVO 500GB size: 465.76 GiB
  ID-3: /dev/sdb vendor: Seagate model: ST2000DM008-2FR102 size: 1.82 TiB
  ID-4: /dev/sdc vendor: Western Digital model: WD50NDZW-11BGSS1 size:
4.55 TiB type: USB
Partition:
  ID-1: / size: 915.26 GiB used: 47.37 GiB (5.2%) fs: btrfs dev: /dev/nvme0n1p3
  ID-2: /boot size: 252 MiB used: 92.1 MiB (36.5%) fs: vfat dev: /dev/nvme0n1p1
  ID-3: /home size: 915.26 GiB used: 47.37 GiB (5.2%) fs: btrfs dev:
/dev/nvme0n1p3
Swap:
  ID-1: swap-1 type: partition size: 16 GiB used: 0 KiB (0.0%) dev:
/dev/nvme0n1p2
Sensors:
  System Temperatures: cpu: 27.5 C mobo: 26.0 C gpu: nvidia temp: 32 C
  Fan Speeds (RPM): fan-1: 847 fan-2: 1074 fan-3: 0 fan-4: 0 fan-5:
1002 fan-6: 0 fan-7: 782
Info:
  Processes: 407 Uptime: 23m Memory: available: 31.25 GiB used: 1.54
GiB (4.9%) Init: systemd
  Shell: Bash inxi: 3.3.27
