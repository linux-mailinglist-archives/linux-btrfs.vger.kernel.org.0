Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA9B263012
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 16:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbgIIO7i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 10:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730104AbgIIMWW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Sep 2020 08:22:22 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDC4C061786
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Sep 2020 05:13:11 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z1so2702914wrt.3
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Sep 2020 05:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version;
        bh=FO2lrJmDW9bDUybmOp1mojDNpZUx5e9VpkJCJ/bQkMA=;
        b=GdPjTXlIiW6Y/CmvMb9WQ3Qh4JeAUVnd2l83tzDO1LZiQgMPB+v08x/KVv37yu2Gkc
         HHWQP0v7v8DM3K/d/B3UAGwBLW60e//UQ/RxDgOOg0sEYJoRXZE06U9iz+dWy4dZKa1z
         9d/HNRnggm8sCy216AyS9yKLfMrC1Y3ev603GWqni3gECmeRAkAEzzZ7rrwq/YrnEwBG
         wiBepF8n4cqCmocYtx5rDCpK9Eu16nSyRpkseoaYDg5vDMKOg77AB7U3xDdOiItjouHI
         TeGPrEMpWvQND7M9cg74qg8PFpQdG/3kfrkaS7JXm7XTCdPL8DMTaPoDCEMp85fjH86t
         Nyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version;
        bh=FO2lrJmDW9bDUybmOp1mojDNpZUx5e9VpkJCJ/bQkMA=;
        b=rbVmWFUTj6iDnP80x/h0Fvz1GYCqzySelB/8I8THQcrovphCWeyMzt93VKasAKDnAJ
         4AQYXHIrBjnFiDJuemPE0XUV6s2Z5IgMzlMxqncMmKqlPTAVBKJZRaFpuLYKFjkWvfAO
         mpKQwn5ARa3GzMYznVu0MjfUrm1gKwIlQvw/4fwn/mp+cvchw6Od/yGTjQumQxCN83ZY
         V6yfL1dRJl5HZLxdHiEVcV/nwjCU708SenW1NpYi9xgAqtF4iwrQ+UiboetlVtQXRKl9
         FEE8Wzge5MntbuqfXex6EtgDFP5n3mFNpjCOYJRvxndXE94EZI5HXKmf4I1ntcSSOkkM
         nBTg==
X-Gm-Message-State: AOAM531G+w0rGYEZ9ABRlfyOjEKJeq1Ucl5UqnnHg53JltF9nJuShkoQ
        T4TI7KIimiVBZtxW2dkr9gy2gJ8Hm5k=
X-Google-Smtp-Source: ABdhPJztjE2L4HcUCgduZKM0Zvu2NZi6IPzuz3j0gwX+Ij1FZuMeSOzMGAzp19HuwFogz6MsvdJtQw==
X-Received: by 2002:a5d:4811:: with SMTP id l17mr3863948wrq.252.1599653589576;
        Wed, 09 Sep 2020 05:13:09 -0700 (PDT)
Received: from orion.localnet (wl-pool2-ont-014.uni-muenster.de. [128.176.164.13])
        by smtp.gmail.com with ESMTPSA id y1sm4076681wru.87.2020.09.09.05.13.08
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 05:13:08 -0700 (PDT)
From:   Benedikt Rips <benedikt.rips@gmail.com>
To:     linux-btrfs@vger.kernel.org
Subject: Corrupted filesystem after power loss
Date:   Wed, 09 Sep 2020 14:13:04 +0200
Message-ID: <2080952.sO1OYyYaP7@orion>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3915394.vKPj23oxN1"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--nextPart3915394.vKPj23oxN1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Benedikt Rips <benedikt.rips@gmail.com>
To: linux-btrfs@vger.kernel.org
Subject: Corrupted filesystem after power loss
Date: Wed, 09 Sep 2020 14:13:04 +0200
Message-ID: <2080952.sO1OYyYaP7@orion>

Hi there,

two weeks ago, I forcibly shut down my system when it was frozen, by pressing
the power button for several seconds. At the next boot, I was not able to 
mount
the filesystem. I booted from a usb stick and at mounting my root filesystem
(which is btrfs), I got the following error messages:


# journalctl -qxeb | tail ... | head ...
Aug 28 16:43:21 archiso kernel: BTRFS info (device dm-2): trying to use backup 
root at mount time
Aug 28 16:43:21 archiso kernel: BTRFS info (device dm-2): use zstd 
compression, level 3
Aug 28 16:43:21 archiso kernel: BTRFS info (device dm-2): disk space caching 
is enabled
Aug 28 16:43:21 archiso kernel: BTRFS info (device dm-2): has skinny extents
Aug 28 16:43:21 archiso kernel: BTRFS warning (device dm-2): dm-2 checksum 
verify failed on 95634915328 wanted 59c7037e found 97021a59 level 0
Aug 28 16:43:21 archiso kernel: BTRFS warning (device dm-2): failed to read 
root (objectid=2): -5
Aug 28 16:43:21 archiso kernel: BTRFS critical (device dm-2): corrupt leaf: 
root=18446744073709551610 block=95602491392 slot=0 ino=10363009, invalid inode 
generation: has 1518459 expect [0, 1518458]
Aug 28 16:43:21 archiso kernel: BTRFS error (device dm-2): block=95602491392 
read time tree block corruption detected
Aug 28 16:43:21 archiso kernel: BTRFS warning (device dm-2): failed to read 
tree root
Aug 28 16:43:21 archiso kernel: BTRFS error (device dm-2): parent transid 
verify failed on 95599607808 wanted 1518455 found 1518457
Aug 28 16:43:21 archiso kernel: BTRFS info (device dm-2): bdev /dev/mapper/
lvm-linux errs: wr 0, rd 2, flush 0, corrupt 0, gen 0
Aug 28 16:43:21 archiso kernel: BTRFS critical (device dm-2): corrupt leaf: 
root=261 block=95596232704 slot=112 ino=11473161, invalid inode generation: 
has 1518457 expect (0, 1518456]
Aug 28 16:43:21 archiso kernel: BTRFS error (device dm-2): block=95596232704 
read time tree block corruption detected
Aug 28 16:43:21 archiso kernel: BTRFS error (device dm-2): failed to read 
block groups: -5
Aug 28 16:43:21 archiso kernel: BTRFS error (device dm-2): open_ctree failed


The filesystem is on an SSD, my kernel version at the time of the failure was
v5.8.5 and my btrfs-progs version is v5.7.  The information regarding the SSD
are:


# smartctl --info /dev/nvme0
smartctl 7.1 2019-12-30 r5022 [x86_64-linux-5.8.7-arch1-1] (local build)
Copyright (C) 2002-19, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Model Number:                       THNSN5256GPUK NVMe TOSHIBA 256GB
Serial Number:                      Y6EB70N0KMBU
Firmware Version:                   5KDA4103
PCI Vendor/Subsystem ID:            0x1179
IEEE OUI Identifier:                0x00080d
Controller ID:                      0
Number of Namespaces:               1
Namespace 1 Size/Capacity:          256.060.514.304 [256 GB]
Namespace 1 Formatted LBA Size:     512
Namespace 1 IEEE EUI-64:            00080d 0300085baf
Local Time is:                      Wed Sep  9 00:18:09 2020 CEST


After reading through the btrfs wiki (btrfs-restore, btrfs-rescue, btrfs-
check),
I asked on the IRC channel for help.  With the advice of cmurf and darkling I
ran the following commands, trying to find the cause of this error and a
suitable backup root to restore data from: http://cwillu.com:
8080/37.201.170.65/1

Kind regards,
Benedikt
--nextPart3915394.vKPj23oxN1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRNa2IWj2/+M7hCC8vtf8uBTLbBVwUCX1jG0AAKCRDtf8uBTLbB
V54pAP9i3gbP+F/z4uGgpoiFKtqKTLDpgq4Ku13HQ3CAVkmUawD+No+Yffu/R0j6
NX7XWa5ubSEJvZdQqLxh29jBx5dOLAc=
=Dxnq
-----END PGP SIGNATURE-----

--nextPart3915394.vKPj23oxN1--



