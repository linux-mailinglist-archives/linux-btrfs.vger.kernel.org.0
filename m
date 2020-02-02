Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E74DA14FD15
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Feb 2020 13:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgBBMpc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Feb 2020 07:45:32 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:43712 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgBBMpc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 2 Feb 2020 07:45:32 -0500
Received: by mail-il1-f194.google.com with SMTP id o13so10268490ilg.10
        for <linux-btrfs@vger.kernel.org>; Sun, 02 Feb 2020 04:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=mjAxSWYAUKpv46qte5uY0Q4v8AqEQNfJB5vXNwEiQL4=;
        b=byZnqGZAU/auz/P6DPehSu+lMiCSJ+Gq93+zMhJKTIiZxpBIwObhYiVzaXmGAV93O4
         ccWFAsN8JLQHdfpN3fEMcttJJPTlXJ8axwG7W58J52xc9vWyE2rXywYIcaNs48HLL8wT
         KfUoBLMeOBqQ6X3fmNUe2aCQIZRg8FzpeKu/r/JOowNXU8ywPV52KZacIj8BEZ5kcL9o
         Mvp6xz1R9z9H4GPQnbJKW82r/vubVvORyYUwbb5lQCEVEXSlV2WsZTOP3KMEl4u+YNHT
         oEu6JqpDJKRdcJ12lOEluQThDUXjjmg4IH+tMJNynmuHCQrfsRpmepQeZA9VmSjGvvmx
         xJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=mjAxSWYAUKpv46qte5uY0Q4v8AqEQNfJB5vXNwEiQL4=;
        b=TAMUbN0d72HnCIxjKO2Uy00jEAlTNIeXdSW9KlRSzbRxWq86fAbZNTQvSiOzhu3fs0
         W7SPyIqCG+4D9NOs1+4Anjzg03IyiYJNcxJtgyb9QHGpO9WgYKo4UbT+sp1+Xeztvw91
         u0/SU7u59v2zeDMeSg8hvxxSJoN8K5O7V9gFfKlLOMxKD0K4uZy0JOWwdOGGR4FC8aaw
         tREnVaOpgtiQbA2b4Wocud5QtEBU2gQhMOXNPwh8Wtz9O0hjsc26XtCSYGlJHpSx6Q1Z
         05ng1Xysn3BhXiU6f7MJWc455G1sMxKst3/vObxFZ/Cgu6pnx7u2ELGGC5XBl2tjjb2g
         /KyA==
X-Gm-Message-State: APjAAAVaWmAdE+exUi5K5cQ3Jncw6WM04dDvMcgiruYl2DACZbnbtbeH
        H03ePNwrGpnxyRtj/wgDcgPYDXYCnj/46tNEN/c1+Cnz
X-Google-Smtp-Source: APXvYqzcwS+79bLg624PcCtyIVtiZKTLMBN8H7iG4c7zzTRRiU1WD9XCQv3B/h7iVD/5ZxcfPdJNFHitgV/GIfaclQc=
X-Received: by 2002:a92:d84c:: with SMTP id h12mr10357669ilq.127.1580647531393;
 Sun, 02 Feb 2020 04:45:31 -0800 (PST)
MIME-Version: 1.0
From:   Skibbi <skibbi@gmail.com>
Date:   Sun, 2 Feb 2020 13:45:58 +0100
Message-ID: <CACN+yT_AYiLc29M41U+WrQHtk4t==D-4AkH+wRROKJY=WstGAA@mail.gmail.com>
Subject: My first attempt to use btrfs failed miserably
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,
So I decided to try btrfs on my new portable WD Password Drive
attached to Raspberry Pi 4. I created GPT partition, created luks2
volume and formatted it with btrfs. Then I created 3 subvolumes and
started copying data from other disks to one of the subvolumes. After
writing around 40GB of data my filesystem crashed. That was super fast
and totally discouraged me from next attempts to use btrfs :(
But I would like to help with development so before I reformat my
drive I can help you identifying potential issues with this filesystem
by providing some debugging info.

Here are some details:

root@rpi4b:~# uname -a
Linux rpi4b 4.19.93-v7l+ #1290 SMP Fri Jan 10 16:45:11 GMT 2020 armv7l GNU/Linux

root@rpi4b:~# btrfs --version
btrfs-progs v4.20.1

root@rpi4b:~# btrfs fi show
Label: 'NAS'  uuid: b16b5b3f-ce5e-42e6-bccd-b48cc641bf96
        Total devices 1 FS bytes used 42.48GiB
        devid    1 size 4.55TiB used 45.02GiB path /dev/mapper/NAS

root@rpi4b:~# dmesg |grep btrfs
[223167.290255] BTRFS: error (device dm-0) in
btrfs_run_delayed_refs:2935: errno=-5 IO failure
[223167.389690] BTRFS: error (device dm-0) in
btrfs_run_delayed_refs:2935: errno=-5 IO failure
root@rpi4b:~# dmesg |grep BTRFS
[201688.941552] BTRFS: device label NAS devid 1 transid 5 /dev/sda1
[201729.894774] BTRFS info (device sda1): disk space caching is enabled
[201729.894789] BTRFS info (device sda1): has skinny extents
[201729.894801] BTRFS info (device sda1): flagging fs with big metadata feature
[201729.902120] BTRFS info (device sda1): checking UUID tree
[202297.695253] BTRFS info (device sda1): disk space caching is enabled
[202297.695271] BTRFS info (device sda1): has skinny extents
[202439.515956] BTRFS info (device sda1): disk space caching is enabled
[202439.515976] BTRFS info (device sda1): has skinny extents
[202928.275644] BTRFS error (device sda1): open_ctree failed
[202934.389346] BTRFS info (device sda1): disk space caching is enabled
[202934.389361] BTRFS info (device sda1): has skinny extents
[203040.718845] BTRFS info (device sda1): disk space caching is enabled
[203040.718863] BTRFS info (device sda1): has skinny extents
[203285.351377] BTRFS error (device sda1): bad tree block start, want
31457280 have 0
[203285.368602] BTRFS error (device sda1): bad tree block start, want
31457280 have 0
[203285.369340] BTRFS error (device sda1): bad tree block start, want
31440896 have 0
[203285.380616] BTRFS error (device sda1): bad tree block start, want
31440896 have 0
[203285.381100] BTRFS error (device sda1): bad tree block start, want
31440896 have 0
[203285.381540] BTRFS error (device sda1): bad tree block start, want
31440896 have 0
[203285.382061] BTRFS error (device sda1): bad tree block start, want
31506432 have 0
[203285.382409] BTRFS error (device sda1): bad tree block start, want
31506432 have 0
[203285.382836] BTRFS error (device sda1): bad tree block start, want
31506432 have 0
[203285.383180] BTRFS error (device sda1): bad tree block start, want
31506432 have 0
[203285.466743] BTRFS info (device sda1): read error corrected: ino 0
off 32735232 (dev /dev/sda1 sector 80320)
[203285.466982] BTRFS info (device sda1): read error corrected: ino 0
off 32739328 (dev /dev/sda1 sector 80328)
[203285.467215] BTRFS info (device sda1): read error corrected: ino 0
off 32743424 (dev /dev/sda1 sector 80336)
[203285.467713] BTRFS info (device sda1): read error corrected: ino 0
off 32747520 (dev /dev/sda1 sector 80344)
[203285.468820] BTRFS info (device sda1): read error corrected: ino 0
off 32751616 (dev /dev/sda1 sector 80352)
[203285.469053] BTRFS info (device sda1): read error corrected: ino 0
off 32755712 (dev /dev/sda1 sector 80360)
[203285.469285] BTRFS info (device sda1): read error corrected: ino 0
off 32759808 (dev /dev/sda1 sector 80368)
[203285.469515] BTRFS info (device sda1): read error corrected: ino 0
off 32763904 (dev /dev/sda1 sector 80376)
[204448.566295] BTRFS: device label NAS devid 1 transid 5 /dev/dm-0
[204464.083776] BTRFS info (device dm-0): disk space caching is enabled
[204464.083792] BTRFS info (device dm-0): has skinny extents
[204464.083804] BTRFS info (device dm-0): flagging fs with big metadata feature
[204464.099978] BTRFS info (device dm-0): checking UUID tree
[218811.383208] BTRFS error (device dm-0): bad tree block start, want
50659328 have 7653333615399691647
[218811.458203] BTRFS error (device dm-0): bad tree block start, want
50659328 have 11439613481626299565
[222717.551578] BTRFS error (device dm-0): bad tree block start, want
69222400 have 13548117933796719565
[222717.563137] BTRFS error (device dm-0): bad tree block start, want
69222400 have 7380016245193299115
[223167.098981] BTRFS error (device dm-0): bad tree block start, want
73252864 have 13360254792515176285
[223167.162808] BTRFS error (device dm-0): bad tree block start, want
73252864 have 11805635508241231341
[223167.269483] BTRFS error (device dm-0): bad tree block start, want
73252864 have 13360254792515176285
[223167.290178] BTRFS error (device dm-0): bad tree block start, want
73252864 have 11805635508241231341
[223167.290255] BTRFS: error (device dm-0) in
btrfs_run_delayed_refs:2935: errno=-5 IO failure
[223167.299414] BTRFS info (device dm-0): forced readonly
[223167.322053] BTRFS error (device dm-0): bad tree block start, want
73252864 have 13360254792515176285
[223167.389598] BTRFS error (device dm-0): bad tree block start, want
73252864 have 11805635508241231341
[223167.389690] BTRFS: error (device dm-0) in
btrfs_run_delayed_refs:2935: errno=-5 IO failure
[223167.399958] BTRFS error (device dm-0): bad tree block start, want
73433088 have 3620493785417914802
[223167.413347] BTRFS error (device dm-0): bad tree block start, want
73433088 have 13303833022607090580
[223167.487687] BTRFS error (device dm-0): bad tree block start, want
73433088 have 3620493785417914802
[223167.499337] BTRFS error (device dm-0): bad tree block start, want
73433088 have 13303833022607090580
[260285.601565] BTRFS error (device dm-0): bad tree block start, want
73433088 have 3620493785417914802
[260285.602742] BTRFS error (device dm-0): bad tree block start, want
73433088 have 13303833022607090580
[260285.604070] BTRFS error (device dm-0): bad tree block start, want
73433088 have 3620493785417914802
[260285.605224] BTRFS error (device dm-0): bad tree block start, want
73433088 have 13303833022607090580
[260288.795773] BTRFS error (device dm-0): bad tree block start, want
73433088 have 3620493785417914802
[260288.797000] BTRFS error (device dm-0): bad tree block start, want
73433088 have 13303833022607090580
[260288.798206] BTRFS error (device dm-0): bad tree block start, want
73433088 have 3620493785417914802
[260288.799380] BTRFS error (device dm-0): bad tree block start, want
73433088 have 13303833022607090580
[260301.047239] BTRFS error (device dm-0): bad tree block start, want
73433088 have 3620493785417914802
[260301.048437] BTRFS error (device dm-0): bad tree block start, want
73433088 have 13303833022607090580
[260301.049638] BTRFS error (device dm-0): bad tree block start, want
73433088 have 3620493785417914802
[260301.050800] BTRFS error (device dm-0): bad tree block start, want
73433088 have 13303833022607090580
[260309.107260] BTRFS error (device dm-0): bad tree block start, want
73433088 have 3620493785417914802
[260309.108396] BTRFS error (device dm-0): bad tree block start, want
73433088 have 13303833022607090580
[260309.109563] BTRFS error (device dm-0): bad tree block start, want
73433088 have 3620493785417914802
[260309.110674] BTRFS error (device dm-0): bad tree block start, want
73433088 have 13303833022607090580
[260309.371483] BTRFS error (device dm-0): bad tree block start, want
73433088 have 3620493785417914802
[260309.372615] BTRFS error (device dm-0): bad tree block start, want
73433088 have 13303833022607090580
[260309.373923] BTRFS error (device dm-0): bad tree block start, want
73433088 have 3620493785417914802
[260309.391169] BTRFS error (device dm-0): bad tree block start, want
73433088 have 13303833022607090580
[260389.358616] BTRFS info (device dm-0): disk space caching is enabled
[260389.358631] BTRFS info (device dm-0): has skinny extents
[260389.430962] BTRFS error (device dm-0): bad tree block start, want
73252864 have 13360254792515176285
[260389.432087] BTRFS error (device dm-0): bad tree block start, want
73252864 have 11805635508241231341
[260389.432146] BTRFS error (device dm-0): failed to read block groups: -5
[260389.474656] BTRFS error (device dm-0): open_ctree failed
[276102.707458] BTRFS warning (device dm-0): 'recovery' is deprecated,
use 'usebackuproot' instead
[276102.707475] BTRFS info (device dm-0): trying to use backup root at
mount time
[276102.707493] BTRFS info (device dm-0): disabling disk space caching
[276102.707506] BTRFS info (device dm-0): force clearing of disk cache
[276102.707518] BTRFS info (device dm-0): has skinny extents
[276102.731022] BTRFS error (device dm-0): bad tree block start, want
73252864 have 13360254792515176285
[276102.732407] BTRFS error (device dm-0): bad tree block start, want
73252864 have 11805635508241231341
[276102.732472] BTRFS error (device dm-0): failed to read block groups: -5
[276102.781625] BTRFS error (device dm-0): open_ctree failed

--
Best regards
