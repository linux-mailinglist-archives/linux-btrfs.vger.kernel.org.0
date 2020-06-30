Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4587320FCE1
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 21:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgF3Tl4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 15:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgF3Tl4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 15:41:56 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F46FC061755
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 12:41:56 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id e4so10355876oib.1
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 12:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=34+mpThZ5WC6zz2zcOs0EY5NhVIfuj1flbmeBRnEMlM=;
        b=OdqCKfIR2cWzn6fay14GXIupE7PMahCm9M0z/YNG9Jvbl3IvTG83UrEPnGDE09aFcb
         nKW/oqq7WUhpwga9wwAdXYFb1TyEeEiGEc86sT9X7jMC6REkqv1DYWIFnblIsHhACEN5
         Hq9lcovol5za7gVioDTulXgvIrl2gajvrY27riDLmgYDX+IEMZbxYwCSIVTW5u59n9m9
         ZphrBOs2P9lobYuuqlUU1KDxwFtS5Vf0Rlz34SvSm6CWybr83fEJAP8MWiBy0I6E0u+j
         w2oNv7tsGVJdWZXMlQaymIU6HLA+CNbYb4xPJFJuxLbX5zibhikaT27xuurL/cKoUzAd
         ip6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=34+mpThZ5WC6zz2zcOs0EY5NhVIfuj1flbmeBRnEMlM=;
        b=cCHA8iO3VxbM7oF/sIPR/0X6HSWs9E8hZiZHs+rsgPMb61wsZzwo1A2Q4AvyEnHpqa
         SZouWRfrTqNJhs/6FsawBLvoxIcx7DTTpOQO2+Av+6DiEYNOGys48StVCtcz8vnicHyC
         llP+Mt9CrNkxET7h15zYPxI9sEHH53PFg7muTVmir4BJowA+4lvohUjKRFNhp2SMMqpb
         WvHkdotxFHRof3QGj8hPtxRJO0WjCbHuPV6ApkreLIIC+/ayrQQafHVrIB3TmtR1PjIa
         JI5U7WwraOHh0KkrFGiM8IKE5WVJMOJfIbhGzC0rvvoneJP9bBLddahpsxv/a7U6VF06
         5LRg==
X-Gm-Message-State: AOAM532GKi08LdO+2i5XL+c6aLTZ2T+aE+LgQZtDpA3YkaZajtsEDSEC
        CePAtLx3MfcS8BohrqkG9ev2YZSveeBa16MgkCUFBtodyzQ=
X-Google-Smtp-Source: ABdhPJzupAdgSdDve9zN9YFsR6tOAqM/NX+vKThjsYGbKsbpPw/9j7xW2e3KniVR9I5EsyVM2tKuHqCGNTTzqdYrfv8=
X-Received: by 2002:a05:6808:1d9:: with SMTP id x25mr17659916oic.62.1593546115361;
 Tue, 30 Jun 2020 12:41:55 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: ilya.bobir@gmail.com
From:   Illia Bobyr <illia.bobyr@gmail.com>
Date:   Tue, 30 Jun 2020 12:41:45 -0700
X-Google-Sender-Auth: 3Rf9-jiQVWMdbZ-4wztvcn2g9Sg
Message-ID: <CAHzXa9XOa1bppK44pKrqbSq50Xdsm63D_698gvo2G-JDWrNeLg@mail.gmail.com>
Subject: "parent transid verify failed" and mount usebackuproot does not seem
 to work
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I have a btrfs with bcache setup that failed during a boot yesterday.
There is one SSD with bcache that is used as a cache for 3 btrfs HDDs.

Reading through a number of discussions, I've decided to ask for advice here.
Should I be running "btrfs check --recover"?

The last message in the dmesg log is this one:

Btrfs loaded, crc32c=crc32c-intel
BTRFS: device label root devid 3 transid 138434 /dev/bcache2 scanned
by btrfs (341)
BTRFS: device label root devid 2 transid 138434 /dev/bcache1 scanned
by btrfs (341)
BTRFS: device label root devid 1 transid 138434 /dev/bcache0 scanned
by btrfs (341)
BTRFS info (device bcache0): disk space caching is enabled
BTRFS info (device bcache0): has skinny extents
BTRFS error (device bcache0): parent transid verify failed on
16984159518720 wanted 138414 found 138207
BTRFS error (device bcache0): parent transid verify failed on
16984159518720 wanted 138414 found 138207
BTRFS error (device bcache0): open_ctree failed

Trying to mount it in the recovery mode does not seem to work:

(initramfs) mount -t btrfs -o ro,usebackuproot /dev/bcache0 /mnt
BTRFS info (device bcache1): trying to use backup root at mount time
BTRFS info (device bcache1): disk space caching is enabled
BTRFS info (device bcache1): has skinny extents
BTRFS error (device bcache1): parent transid verify failed on
16984159518720 wanted 138414 found 138207
BTRFS error (device bcache1): parent transid verify failed on
16984159518720 wanted 138414 found 138207
BTRFS error (device bcache1): parent transid verify failed on
16984173199360 wanted 138433 found 138195
BTRFS error (device bcache1): parent transid verify failed on
16984173199360 wanted 138433 found 138195
BTRFS warning (device bcache1): failed to read tree root
BTRFS error (device bcache1): parent transid verify failed on
16984171298816 wanted 138431 found 131157
BTRFS error (device bcache1): parent transid verify failed on
16984171298816 wanted 138431 found 131157
BTRFS warning (device bcache1): failed to read tree root
BTRFS critical (device bcache1): corrupt leaf: block=16984183013376
slot=36 extent bytenr=11447166291968 len=262144 invalid generation,
have 138434 expect (0, 138433]
BTRFS error (device bcache1): block=16984183013376 read time tree
block corruption detected
BTRFS critical (device bcache1): corrupt leaf: block=16984183013376
slot=36 extent bytenr=11447166291968 len=262144 invalid generation,
have 138434 expect (0, 138433]
BTRFS error (device bcache1): block=16984183013376 read time tree
block corruption detected
BTRFS warning (device bcache1): failed to read tree root
BUG: kernel NULL pointer dereference, address: 000000000000001f
#PF: supervisor read access in kernel mode

<a stack trace follows>

(initramfs) btrfs --version
btrfs-progs v5.4.1

(initramfs) uname -a
Linux (none) 5.6.11-050611-generic #202005061022 SMP Wed May 6 10:27:04
UTC 2020 x86_64 GNU/Linux

(initramfs) btrfs fi show
Label: 'root' uuid: 0a3d051b-72ef-4a5d-8a48-eb0dbb960b56
        Total devices 3 FS bytes used 6.55TiB
        devid    1 size 3.64TiB used 1.62TiB path /dev/bcache1
        devid    2 size 7.28TiB used 5.21TiB path /dev/bcache0
        devid    3 size 12.73TiB used 6.80TiB path /dev/bcache2

I have tried booting using a live ISO with 5.8.0 kernel and btrfs v5.6.1
from http://defender.exton.net/.
After booting tried mounting the bcache using the same command as above.
The only message in the console was "Killed".
/dev/kmsg on the other hand lists messages very similar to the ones I've
seen in the initramfs environment: https://pastebin.com/Vhy072Mx

P.S. Please CC me, as I am not subscribed.

Thank you,
Illia Bobyr
