Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644A51A7594
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Apr 2020 10:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407051AbgDNIMc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Apr 2020 04:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407026AbgDNIM0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Apr 2020 04:12:26 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F47FC0A3BDC
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Apr 2020 01:12:26 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id o127so12350864iof.0
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Apr 2020 01:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Dghx157mbbjpuuYCnrHtiHxwUzHEmcMeip8ZsNyZh10=;
        b=nzw2vhKyN3lYDtB3RHxND0Yq4JtbgWJvwRzIFAYO1BX++MO46Q3R/pNN6KC6/Tt+AB
         oDCTKCcOKuvJSwHhYE9a0GwWVYwvGj30IsQ6mryRSVb7dTCPZz25g1pmyWcAfsyirb5h
         fqPrEMKx+SIHCmnhgDYUgXirkObVqZv8n+mlXBrW4yEphjqUtbYn2z0S2ZPIjC64ZWXx
         bG3CKnFifb/qBcvGnfNWL+6PAJWlnyQs3VvYscWPtxH4ip43QKt0xEeiEpDj/sRwBx1G
         pzd432f6sTHEsE2GZlngeOUqV/IA8jD+6c0l+BcqV0FtLRYUPsUh8/cPXWewuY7G+hsP
         fisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Dghx157mbbjpuuYCnrHtiHxwUzHEmcMeip8ZsNyZh10=;
        b=Vy0bd5EW4lZbkLGui/6Z4EO7vmjQxvjIBkbFWStjChgZsX3L08uDCHOoD9p6+eilrm
         NLBCfWqD+JhMuI6FQTnh9mumaTNHhmec4kr9a14l+E4at2CLcMEKP0rMWpmPVlsMNbe9
         RM1/hiwoDD3JY7XxMRGRGM+9uFg+gARRjcLJt8SdgHNzARPijmT1xmTk6oALYPVMF3Wm
         G5cZGPi+y7ccDJRHbDR9MM4RpmD3ixgZSquwZmJcQjrgRNuTtU1jAqomsNU7j8S+PUnC
         ZMtV1cYt7S0Ftfo5tDeAsqTp4UjpbuLhm1AACdCwesWaMlWKIKFMhnsllMU1XMH6rPCQ
         AaKQ==
X-Gm-Message-State: AGi0PuaK/iDVesligUAkD0eBgtqToUYugwVvM1xcf45JlQSFPti4jaIX
        hoKQ8Qf8QCsvc0CoVuVhigSFlN7Mwa9kPE/Z/AjqmaQB
X-Google-Smtp-Source: APiQypISvlyaiNweBo62IBHL4QvgjRY3oKYT3HqPBM9lilUgAtSrNIByS2HSsnKDL2+OYyO3VtLt/VcKM42lndCLfhg=
X-Received: by 2002:a6b:7f48:: with SMTP id m8mr20569166ioq.142.1586851945005;
 Tue, 14 Apr 2020 01:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <CABzOi+cT5_Bx=U41U8_4gg2wLVg+M3FaCDqs2Sea_Mkrm1we8g@mail.gmail.com>
In-Reply-To: <CABzOi+cT5_Bx=U41U8_4gg2wLVg+M3FaCDqs2Sea_Mkrm1we8g@mail.gmail.com>
From:   Jan Beranek <jan233321@gmail.com>
Date:   Tue, 14 Apr 2020 10:12:13 +0200
Message-ID: <CABzOi+cwLmquRuTzBG_opmOZ+pMkHzgczpKT7yFhCe=99+k+xw@mail.gmail.com>
Subject: Fwd: BTRFS error (device sdb1): open_ctree failed
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear all,
after incorrectly unmounted SSD disc (which I use as portable and I
just by mistake unplug it) I've finished with partly crashed
partition.

Symptoms: impossible to mount RW/ possible to mount RO.

uname -a
Linux linux-foir 5.6.0-1-default #1 SMP Mon Mar 30 08:00:44 UTC 2020
(4de1111) x86_64 x86_64 x86_64 GNU/Linux
-------------------
dmesg when trying to mount rw:
[169971.382641] usb-storage 1-2:1.0: USB Mass Storage device detected
[169971.382942] scsi host3: usb-storage 1-2:1.0
[169972.396884] scsi 3:0:0:0: Direct-Access     ASMT     2115
   0    PQ: 0 ANSI: 6
[169972.397613] sd 3:0:0:0: Attached scsi generic sg1 type 0
[169972.399899] sd 3:0:0:0: [sdb] Spinning up disk...
[169973.419852] ...ready
[169975.468874] sd 3:0:0:0: [sdb] 250069680 512-byte logical blocks:
(128 GB/119 GiB)
[169975.469626] sd 3:0:0:0: [sdb] Write Protect is off
[169975.469633] sd 3:0:0:0: [sdb] Mode Sense: 43 00 00 00
[169975.470311] sd 3:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[169975.486356]  sdb: sdb1
[169975.488448] sd 3:0:0:0: [sdb] Attached SCSI disk
[169979.980390] BTRFS info (device sdb1): disk space caching is enabled
[169979.980399] BTRFS info (device sdb1): has skinny extents
[169980.094949] BTRFS warning (device sdb1): chunk 13631488 missing 1
devices, max tolerance is 0 for writable mount
[169980.094954] BTRFS warning (device sdb1): writable mount is not
allowed due to too many missing devices
[169980.115969] BTRFS error (device sdb1): open_ctree failed
------------------
btrfs --version
btrfs-progs v5.4.1
-------------------
btrfs fi show
Label: none  uuid: 17e5780b-2196-46e0-9cba-5c896a2eaa3d
Total devices 1 FS bytes used 108.44GiB
devid    1 size 119.24GiB used 111.02GiB path /dev/sdb1
--------------------
when mounted ro then
btrfs fi df brt/
Data, single: total=109.01GiB, used=108.29GiB
System, DUP: total=8.00MiB, used=16.00KiB
Metadata, DUP: total=1.00GiB, used=150.80MiB
GlobalReserve, single: total=124.33MiB, used=0.00B
-----------------------

Any ideas how to remount it RW? We can test anything on the disc...
(there are valuable data and I have backup).
Information about used data seems to be wrong as well...

Thanks!
Best Regards

Jan.
