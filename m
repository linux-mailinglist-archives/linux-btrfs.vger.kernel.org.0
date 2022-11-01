Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466B3615206
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 20:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiKATNW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 15:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiKATNO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 15:13:14 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8C81E3D4
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 12:13:10 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so19728155pjc.3
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Nov 2022 12:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p+YGCdw+JIAQVzMfGlWC2rEDC0KhB0MDiUQriS/Xc84=;
        b=gOT4aQ1wtRlP5XnuFR6OaZA02nfSVYmLyH0FEy1mAtmFh2a6MOWpN8ZARgwgqU4+oZ
         CxPXJnC+RSaSyCU3pyDotTvGD+3zblsDaqEqJRVwKUnQgH/hgEad9TyYPjen+1qXU9Go
         nenc3HYdrs+9EnX+V/zSTHJZnKw6dgN0mxqNY74FoMFio4XLICfnJPVZEDFJauqGPAwt
         ON9G/oyiN/lAB1l/zOHHX7/w5cgAjLCyCTG8ygwo+2GN2nLOOpcpzgqs8c2bWprttYOv
         onoWK0PnD4UGpRkqh9/L/K6E665bIOSbqNCWdZth/MJ+V5ZE2BzubYFmkXSDeaGFvNPC
         NOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p+YGCdw+JIAQVzMfGlWC2rEDC0KhB0MDiUQriS/Xc84=;
        b=vWqnBsbd1MU9nfVeeEj9MjVh6QKOMd1Bx+YUzQdt5lpiLHbTaznu0cgLQioC3eEuLk
         eb2eZPbd1vx4+cXfkEYZuclnIFuXESzZwdym2f6xQoZ7cM7vultqqW0qybsG6LF0YYSe
         DsXjH/3w7nHpMSxYxqMTgkaltdlj1mYl7BsAnguvY6QWCPQW+28S8cL04ZlfyvO1abHe
         WbqmgMiU5/GtPT7a8kcGXj/FgjjkYBlBUK5Ur2c9YsiodwzzNaaBolDcwUjDICRjpMRX
         ROE4TV9r7cTqiYC0B8O0Gl6RNEBczBOIZrRj12K0g7OJI0Gd2flvR13rhYsNfr5GwGa8
         5uRA==
X-Gm-Message-State: ACrzQf34MsjmmJINum06Rk9x1zZ4Q9tMZ9CJcuqx9A/QZfHeQr8DREgN
        Jog0ws85hY4dinOTc/i0PtX6jkzRasU=
X-Google-Smtp-Source: AMsMyM7Ka9lzMGxKw4sFW23z4JzB72YKlxUoaLpJYoSFpsjUIipPVQreJXL6r8MlVsYUcrw9vSernw==
X-Received: by 2002:a17:90a:5781:b0:20a:9962:bb4a with SMTP id g1-20020a17090a578100b0020a9962bb4amr37772723pji.185.1667329989309;
        Tue, 01 Nov 2022 12:13:09 -0700 (PDT)
Received: from ryzen3950 (c-208-82-98-189.rev.sailinternet.net. [208.82.98.189])
        by smtp.gmail.com with ESMTPSA id e1-20020a17090301c100b001869079d083sm6713281plh.90.2022.11.01.12.13.07
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 12:13:08 -0700 (PDT)
From:   Matt Huszagh <huszaghmatt@gmail.com>
To:     linux-btrfs@vger.kernel.org
Subject: How to replace a failing device
Date:   Tue, 01 Nov 2022 12:13:07 -0700
Message-ID: <87v8nyh4jg.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hi,

I have a failing device that's part of my my root filesystem. I'm not
using a data-redundant RAID configuration. I'd like to know how to
remove this device without corrupting the data I care about (more on
this momentarily).

To provide some background, the affected device is /dev/sdb:

$ sudo smartctl -a /dev/sdb
[...]
SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Short offline       Completed: read failure       90%     11729         3678402408
# 2  Short offline       Completed: read failure       90%     11729         3678402408
[...]

The only partition on this device is mapped to /dev/mapper/cryptsdd1,
which is part of my root filesystem:

$ sudo btrfs fi show /
Label: 'btrfs'  uuid: d31878d6-3a77-4f0f-9fdd-bb9a2c4e578b
        Total devices 4 FS bytes used 2.76TiB
        devid    1 size 931.01GiB used 928.99GiB path /dev/mapper/cryptnvme
        devid    2 size 931.50GiB used 931.50GiB path /dev/mapper/cryptnvme1
        devid    3 size 1.82TiB used 1.55TiB path /dev/mapper/cryptsdd1
        devid    4 size 15.88TiB used 0.00B path /dev/mapper/cryptsdc2

I *think* all data I care about is safe: I snapshot my home directory
every hour and backup these snapshots to a remote backup service
periodically. I haven't run into any issues doing that. I believe the
lost data is from an old snapshot, which I'm fine with (assuming that's
true).

I'd like to remove this failing device without corrupting any data I do
care about. How can I accomplish this?

I attempted scrubbing the partition, but that seems to have no
effect. Running

$ sudo btrfs scrub start /dev/mapper/cryptsdd1

doesn't produce any output and doesn't return. Opening another terminal
and using status doesn't return either. I'm also unable to terminate
either of these processes. I was hoping to use this to confirm that the
affected files are confined to old snapshots.

I tried removing the device, but that fails:

$ sudo btrfs device remove /dev/mapper/cryptsdd1 /
ERROR: error removing device '/dev/mapper/cryptsdd1': Input/output error

What can I do?

Thanks!
Matt

FYI:

$ uname -a
Linux ryzen3950 5.12.4 #1-NixOS SMP Fri May 14 08:53:07 UTC 2021 x86_64 GNU/Linux

$ btrfs --version
btrfs-progs v5.11.1

$ sudo btrfs fi show
Label: 'btrfs'  uuid: d31878d6-3a77-4f0f-9fdd-bb9a2c4e578b
        Total devices 4 FS bytes used 2.76TiB
        devid    1 size 931.01GiB used 928.99GiB path /dev/mapper/cryptnvme
        devid    2 size 931.50GiB used 931.50GiB path /dev/mapper/cryptnvme1
        devid    3 size 1.82TiB used 1.55TiB path /dev/mapper/cryptsdd1
        devid    4 size 15.88TiB used 0.00B path /dev/mapper/cryptsdc2

Label: 'backup'  uuid: 0bd10808-0330-4736-9425-059d4a0a300e
        Total devices 2 FS bytes used 1.08TiB
        devid    1 size 1.82TiB used 593.00GiB path /dev/mapper/cryptsdc1
        devid    2 size 1.82TiB used 588.00GiB path /dev/mapper/cryptsdb1

(the above is printed, but the command doesn't return...)

$ sudo btrfs fi df /
Data, single: total=3.15TiB, used=2.74TiB
System, RAID1: total=32.00MiB, used=432.00KiB
Metadata, RAID1: total=110.00GiB, used=18.25GiB
GlobalReserve, single: total=512.00MiB, used=0.00B


--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=dmesg.log

[1607156.657220] audit: type=1130 audit(1667312619.703:83145): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1607156.657225] audit: type=1131 audit(1667312619.703:83146): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1607156.657496] audit: type=1334 audit(1667312619.704:83147): prog-id=21720 op=UNLOAD
[1607156.657502] audit: type=1334 audit(1667312619.704:83148): prog-id=21721 op=UNLOAD
[1607156.657614] audit: type=1334 audit(1667312619.704:83149): prog-id=21722 op=LOAD
[1607156.657671] audit: type=1334 audit(1667312619.704:83150): prog-id=21723 op=LOAD
[1607157.222398] audit: type=1130 audit(1667312620.269:83151): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1607240.211150] audit: type=1131 audit(1667312703.259:83152): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1607240.405861] audit: type=1130 audit(1667312703.453:83153): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1607240.405864] audit: type=1131 audit(1667312703.453:83154): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1607240.406126] audit: type=1334 audit(1667312703.454:83155): prog-id=21722 op=UNLOAD
[1607240.406132] audit: type=1334 audit(1667312703.454:83156): prog-id=21723 op=UNLOAD
[1607240.406241] audit: type=1334 audit(1667312703.454:83157): prog-id=21724 op=LOAD
[1607240.406292] audit: type=1334 audit(1667312703.454:83158): prog-id=21725 op=LOAD
[1607241.308872] audit: type=1130 audit(1667312704.356:83159): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1607312.572133] audit: type=1131 audit(1667312775.621:83160): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1607312.904712] audit: type=1130 audit(1667312775.953:83161): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1607312.904719] audit: type=1131 audit(1667312775.953:83162): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1607312.904961] audit: type=1334 audit(1667312775.954:83163): prog-id=21724 op=UNLOAD
[1607312.904967] audit: type=1334 audit(1667312775.954:83164): prog-id=21725 op=UNLOAD
[1607312.905080] audit: type=1334 audit(1667312775.954:83165): prog-id=21726 op=LOAD
[1607312.905132] audit: type=1334 audit(1667312775.954:83166): prog-id=21727 op=LOAD
[1607447.452644] audit: type=1130 audit(1667312910.503:83167): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1607447.652639] audit: type=1130 audit(1667312910.703:83168): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1607447.652644] audit: type=1131 audit(1667312910.704:83169): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1607447.653056] audit: type=1334 audit(1667312910.704:83170): prog-id=21728 op=LOAD
[1607447.653108] audit: type=1334 audit(1667312910.704:83171): prog-id=21729 op=LOAD
[1607447.691687] audit: type=1334 audit(1667312910.743:83172): prog-id=21727 op=UNLOAD
[1607447.691691] audit: type=1334 audit(1667312910.743:83173): prog-id=21726 op=UNLOAD
[1607448.101580] audit: type=1130 audit(1667312911.152:83174): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1607520.500452] audit: type=1131 audit(1667312983.552:83175): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1607520.651493] audit: type=1130 audit(1667312983.704:83176): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1607520.651499] audit: type=1131 audit(1667312983.704:83177): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1607520.651778] audit: type=1334 audit(1667312983.704:83178): prog-id=21728 op=UNLOAD
[1607520.651780] audit: type=1334 audit(1667312983.704:83179): prog-id=21729 op=UNLOAD
[1607520.651903] audit: type=1334 audit(1667312983.704:83180): prog-id=21730 op=LOAD
[1607520.651954] audit: type=1334 audit(1667312983.704:83181): prog-id=21731 op=LOAD
[1607521.282215] audit: type=1130 audit(1667312984.334:83182): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1607595.591497] audit: type=1131 audit(1667313058.645:83183): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1607595.900358] audit: type=1130 audit(1667313058.954:83184): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1607595.900365] audit: type=1131 audit(1667313058.954:83185): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1607595.900672] audit: type=1334 audit(1667313058.954:83186): prog-id=21730 op=UNLOAD
[1607595.900678] audit: type=1334 audit(1667313058.954:83187): prog-id=21731 op=UNLOAD
[1607595.900797] audit: type=1334 audit(1667313058.954:83188): prog-id=21732 op=LOAD
[1607595.900851] audit: type=1334 audit(1667313058.954:83189): prog-id=21733 op=LOAD
[1607596.987966] audit: type=1130 audit(1667313060.041:83190): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1607669.436106] audit: type=1131 audit(1667313132.490:83191): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1607669.649196] audit: type=1130 audit(1667313132.704:83192): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1607669.649201] audit: type=1131 audit(1667313132.704:83193): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1607669.649521] audit: type=1334 audit(1667313132.704:83194): prog-id=21732 op=UNLOAD
[1607669.649528] audit: type=1334 audit(1667313132.704:83195): prog-id=21733 op=UNLOAD
[1607669.649695] audit: type=1334 audit(1667313132.704:83196): prog-id=21734 op=LOAD
[1607669.649745] audit: type=1334 audit(1667313132.704:83197): prog-id=21735 op=LOAD
[1607677.692969] audit: type=1130 audit(1667313140.747:83198): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1607745.645555] audit: type=1131 audit(1667313208.701:83199): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1607745.897904] audit: type=1130 audit(1667313208.954:83200): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1607745.897914] audit: type=1131 audit(1667313208.954:83201): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1607745.898206] audit: type=1334 audit(1667313208.954:83202): prog-id=21734 op=UNLOAD
[1607745.898211] audit: type=1334 audit(1667313208.954:83203): prog-id=21735 op=UNLOAD
[1607745.898331] audit: type=1334 audit(1667313208.954:83204): prog-id=21736 op=LOAD
[1607745.898391] audit: type=1334 audit(1667313208.954:83205): prog-id=21737 op=LOAD
[1607746.301604] audit: type=1130 audit(1667313209.357:83206): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1607838.643572] audit: type=1131 audit(1667313301.701:83207): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1607838.896464] audit: type=1130 audit(1667313301.954:83208): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1607838.896470] audit: type=1131 audit(1667313301.954:83209): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1607838.896840] audit: type=1334 audit(1667313301.954:83210): prog-id=21736 op=UNLOAD
[1607838.896846] audit: type=1334 audit(1667313301.954:83211): prog-id=21737 op=UNLOAD
[1607838.896951] audit: type=1334 audit(1667313301.954:83212): prog-id=21738 op=LOAD
[1607838.897001] audit: type=1334 audit(1667313301.954:83213): prog-id=21739 op=LOAD
[1607839.692286] audit: type=1130 audit(1667313302.749:83214): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1607932.486455] audit: type=1131 audit(1667313395.545:83215): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1607932.644877] audit: type=1130 audit(1667313395.703:83216): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1607932.644881] audit: type=1131 audit(1667313395.703:83217): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1607932.645159] audit: type=1334 audit(1667313395.704:83218): prog-id=21738 op=UNLOAD
[1607932.645165] audit: type=1334 audit(1667313395.704:83219): prog-id=21739 op=UNLOAD
[1607932.645273] audit: type=1334 audit(1667313395.704:83220): prog-id=21740 op=LOAD
[1607932.645323] audit: type=1334 audit(1667313395.704:83221): prog-id=21741 op=LOAD
[1607933.707824] audit: type=1130 audit(1667313396.766:83222): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608022.895106] audit: type=1131 audit(1667313485.955:83223): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1608023.143419] audit: type=1130 audit(1667313486.203:83224): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608023.143423] audit: type=1131 audit(1667313486.203:83225): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608023.143696] audit: type=1334 audit(1667313486.204:83226): prog-id=21740 op=UNLOAD
[1608023.143698] audit: type=1334 audit(1667313486.204:83227): prog-id=21741 op=UNLOAD
[1608023.143828] audit: type=1334 audit(1667313486.204:83228): prog-id=21742 op=LOAD
[1608023.143883] audit: type=1334 audit(1667313486.204:83229): prog-id=21743 op=LOAD
[1608024.367805] audit: type=1130 audit(1667313487.428:83230): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608114.787129] audit: type=1131 audit(1667313577.849:83231): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1608114.892001] audit: type=1130 audit(1667313577.953:83232): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608114.892007] audit: type=1131 audit(1667313577.954:83233): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608114.892322] audit: type=1334 audit(1667313577.954:83234): prog-id=21742 op=UNLOAD
[1608114.892326] audit: type=1334 audit(1667313577.954:83235): prog-id=21743 op=UNLOAD
[1608114.892449] audit: type=1334 audit(1667313577.954:83236): prog-id=21744 op=LOAD
[1608114.892503] audit: type=1334 audit(1667313577.954:83237): prog-id=21745 op=LOAD
[1608121.624289] audit: type=1130 audit(1667313584.686:83238): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608208.202758] audit: type=1131 audit(1667313671.266:83239): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1608208.390446] audit: type=1130 audit(1667313671.453:83240): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608208.390450] audit: type=1131 audit(1667313671.453:83241): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608208.390718] audit: type=1334 audit(1667313671.454:83242): prog-id=21744 op=UNLOAD
[1608208.390723] audit: type=1334 audit(1667313671.454:83243): prog-id=21745 op=UNLOAD
[1608208.390824] audit: type=1334 audit(1667313671.454:83244): prog-id=21746 op=LOAD
[1608208.390874] audit: type=1334 audit(1667313671.454:83245): prog-id=21747 op=LOAD
[1608208.816471] audit: type=1130 audit(1667313671.879:83246): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608306.758698] audit: type=1131 audit(1667313769.823:83247): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1608306.888980] audit: type=1130 audit(1667313769.954:83248): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608306.888984] audit: type=1131 audit(1667313769.954:83249): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608306.889286] audit: type=1334 audit(1667313769.954:83250): prog-id=21746 op=UNLOAD
[1608306.889292] audit: type=1334 audit(1667313769.954:83251): prog-id=21747 op=UNLOAD
[1608306.889424] audit: type=1334 audit(1667313769.954:83252): prog-id=21748 op=LOAD
[1608306.889473] audit: type=1334 audit(1667313769.954:83253): prog-id=21749 op=LOAD
[1608307.622512] audit: type=1130 audit(1667313770.687:83254): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608399.175246] audit: type=1131 audit(1667313862.241:83255): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1608399.387386] audit: type=1130 audit(1667313862.453:83256): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608399.387390] audit: type=1131 audit(1667313862.453:83257): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608399.387653] audit: type=1334 audit(1667313862.454:83258): prog-id=21748 op=UNLOAD
[1608399.387658] audit: type=1334 audit(1667313862.454:83259): prog-id=21749 op=UNLOAD
[1608399.387767] audit: type=1334 audit(1667313862.454:83260): prog-id=21750 op=LOAD
[1608399.387816] audit: type=1334 audit(1667313862.454:83261): prog-id=21751 op=LOAD
[1608399.797112] audit: type=1130 audit(1667313862.863:83262): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608494.549073] audit: type=1131 audit(1667313957.617:83263): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1608494.886004] audit: type=1130 audit(1667313957.954:83264): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608494.886008] audit: type=1131 audit(1667313957.954:83265): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608494.886326] audit: type=1334 audit(1667313957.954:83266): prog-id=21750 op=UNLOAD
[1608494.886331] audit: type=1334 audit(1667313957.954:83267): prog-id=21751 op=UNLOAD
[1608494.886462] audit: type=1334 audit(1667313957.954:83268): prog-id=21752 op=LOAD
[1608494.886513] audit: type=1334 audit(1667313957.954:83269): prog-id=21753 op=LOAD
[1608495.354213] audit: type=1130 audit(1667313958.422:83270): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608588.132241] audit: type=1131 audit(1667314051.201:83271): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1608588.384383] audit: type=1130 audit(1667314051.453:83272): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608588.384388] audit: type=1131 audit(1667314051.453:83273): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608588.384655] audit: type=1334 audit(1667314051.454:83274): prog-id=21752 op=UNLOAD
[1608588.384660] audit: type=1334 audit(1667314051.454:83275): prog-id=21753 op=UNLOAD
[1608588.384773] audit: type=1334 audit(1667314051.454:83276): prog-id=21754 op=LOAD
[1608588.384825] audit: type=1334 audit(1667314051.454:83277): prog-id=21755 op=LOAD
[1608588.978875] audit: type=1130 audit(1667314052.048:83278): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608682.548425] audit: type=1131 audit(1667314145.619:83279): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1608682.883020] audit: type=1130 audit(1667314145.954:83280): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608682.883025] audit: type=1131 audit(1667314145.954:83281): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608682.883342] audit: type=1334 audit(1667314145.954:83282): prog-id=21754 op=UNLOAD
[1608682.883344] audit: type=1334 audit(1667314145.954:83283): prog-id=21755 op=UNLOAD
[1608682.883457] audit: type=1334 audit(1667314145.954:83284): prog-id=21756 op=LOAD
[1608682.883508] audit: type=1334 audit(1667314145.954:83285): prog-id=21757 op=LOAD
[1608692.583613] audit: type=1130 audit(1667314155.654:83286): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608774.342884] audit: type=1131 audit(1667314237.415:83287): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1608774.631403] audit: type=1130 audit(1667314237.703:83288): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608774.631407] audit: type=1131 audit(1667314237.703:83289): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608774.631678] audit: type=1334 audit(1667314237.704:83290): prog-id=21756 op=UNLOAD
[1608774.631680] audit: type=1334 audit(1667314237.704:83291): prog-id=21757 op=UNLOAD
[1608774.631768] audit: type=1334 audit(1667314237.704:83292): prog-id=21758 op=LOAD
[1608774.631820] audit: type=1334 audit(1667314237.704:83293): prog-id=21759 op=LOAD
[1608781.676752] audit: type=1130 audit(1667314244.749:83294): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608866.547399] audit: type=1131 audit(1667314329.621:83295): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1608866.880182] audit: type=1130 audit(1667314329.954:83296): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608866.880190] audit: type=1131 audit(1667314329.954:83297): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608866.880573] audit: type=1334 audit(1667314329.954:83298): prog-id=21758 op=UNLOAD
[1608866.880581] audit: type=1334 audit(1667314329.954:83299): prog-id=21759 op=UNLOAD
[1608866.880708] audit: type=1334 audit(1667314329.954:83300): prog-id=21760 op=LOAD
[1608866.880777] audit: type=1334 audit(1667314329.954:83301): prog-id=21761 op=LOAD
[1608867.395801] audit: type=1130 audit(1667314330.469:83302): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608960.138583] audit: type=1131 audit(1667314423.214:83303): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1608960.378569] audit: type=1130 audit(1667314423.454:83304): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608960.378574] audit: type=1131 audit(1667314423.454:83305): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1608960.378881] audit: type=1334 audit(1667314423.454:83306): prog-id=21760 op=UNLOAD
[1608960.378883] audit: type=1334 audit(1667314423.454:83307): prog-id=21761 op=UNLOAD
[1608960.379004] audit: type=1334 audit(1667314423.454:83308): prog-id=21762 op=LOAD
[1608960.379055] audit: type=1334 audit(1667314423.454:83309): prog-id=21763 op=LOAD
[1608978.754915] audit: type=1130 audit(1667314441.830:83310): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609056.861910] audit: type=1131 audit(1667314519.938:83311): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1609057.126993] audit: type=1130 audit(1667314520.204:83312): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609057.126998] audit: type=1131 audit(1667314520.204:83313): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609057.127305] audit: type=1334 audit(1667314520.204:83314): prog-id=21762 op=UNLOAD
[1609057.127311] audit: type=1334 audit(1667314520.204:83315): prog-id=21763 op=UNLOAD
[1609057.127433] audit: type=1334 audit(1667314520.204:83316): prog-id=21764 op=LOAD
[1609057.127487] audit: type=1334 audit(1667314520.204:83317): prog-id=21765 op=LOAD
[1609058.333420] audit: type=1130 audit(1667314521.410:83318): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609152.693713] audit: type=1131 audit(1667314615.772:83319): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1609152.875481] audit: type=1130 audit(1667314615.954:83320): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609152.875487] audit: type=1131 audit(1667314615.954:83321): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609152.875866] audit: type=1334 audit(1667314615.954:83322): prog-id=21764 op=UNLOAD
[1609152.875870] audit: type=1334 audit(1667314615.954:83323): prog-id=21765 op=UNLOAD
[1609152.875999] audit: type=1334 audit(1667314615.954:83324): prog-id=21766 op=LOAD
[1609152.876058] audit: type=1334 audit(1667314615.954:83325): prog-id=21767 op=LOAD
[1609153.299106] audit: type=1130 audit(1667314616.377:83326): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609252.941448] audit: type=1131 audit(1667314716.021:83327): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1609253.123878] audit: type=1130 audit(1667314716.204:83328): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609253.123884] audit: type=1131 audit(1667314716.204:83329): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609253.124194] audit: type=1334 audit(1667314716.204:83330): prog-id=21766 op=UNLOAD
[1609253.124201] audit: type=1334 audit(1667314716.204:83331): prog-id=21767 op=UNLOAD
[1609253.124338] audit: type=1334 audit(1667314716.204:83332): prog-id=21768 op=LOAD
[1609253.124390] audit: type=1334 audit(1667314716.204:83333): prog-id=21769 op=LOAD
[1609254.187321] audit: type=1130 audit(1667314717.267:83334): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609337.372801] audit: type=1334 audit(1667314800.454:83335): prog-id=21696 op=UNLOAD
[1609337.372805] audit: type=1334 audit(1667314800.454:83336): prog-id=21697 op=UNLOAD
[1609337.372941] audit: type=1334 audit(1667314800.454:83337): prog-id=21770 op=LOAD
[1609337.373019] audit: type=1334 audit(1667314800.454:83338): prog-id=21771 op=LOAD
[1609337.373873] audit: type=1130 audit(1667314800.455:83339): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=update-locatedb comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609351.879648] audit: type=1131 audit(1667314814.961:83340): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1609352.122345] audit: type=1130 audit(1667314815.204:83341): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609352.122350] audit: type=1131 audit(1667314815.204:83342): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609352.122718] audit: type=1334 audit(1667314815.204:83343): prog-id=21768 op=UNLOAD
[1609352.122725] audit: type=1334 audit(1667314815.204:83344): prog-id=21769 op=UNLOAD
[1609352.122871] audit: type=1334 audit(1667314815.204:83345): prog-id=21772 op=LOAD
[1609352.122941] audit: type=1334 audit(1667314815.204:83346): prog-id=21773 op=LOAD
[1609364.985050] audit: type=1130 audit(1667314828.067:83347): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609373.613111] audit: type=1131 audit(1667314836.695:83348): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=update-locatedb comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609455.967684] audit: type=1131 audit(1667314919.051:83349): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1609456.120653] audit: type=1130 audit(1667314919.204:83350): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609456.120659] audit: type=1131 audit(1667314919.204:83351): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609456.121051] audit: type=1334 audit(1667314919.204:83352): prog-id=21772 op=UNLOAD
[1609456.121053] audit: type=1334 audit(1667314919.204:83353): prog-id=21773 op=UNLOAD
[1609456.121176] audit: type=1334 audit(1667314919.204:83354): prog-id=21774 op=LOAD
[1609456.121236] audit: type=1334 audit(1667314919.204:83355): prog-id=21775 op=LOAD
[1609457.147809] audit: type=1130 audit(1667314920.231:83356): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609558.424838] audit: type=1131 audit(1667315021.509:83357): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1609558.618887] audit: type=1130 audit(1667315021.703:83358): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609558.618891] audit: type=1131 audit(1667315021.703:83359): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609558.619167] audit: type=1334 audit(1667315021.704:83360): prog-id=21774 op=UNLOAD
[1609558.619172] audit: type=1334 audit(1667315021.704:83361): prog-id=21775 op=UNLOAD
[1609558.619291] audit: type=1334 audit(1667315021.704:83362): prog-id=21776 op=LOAD
[1609558.619342] audit: type=1334 audit(1667315021.704:83363): prog-id=21777 op=LOAD
[1609559.851784] audit: type=1130 audit(1667315022.936:83364): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609566.934222] audit: type=1333 audit(1667315030.020:83365): op=offset old=-1943057498 new=18862079024824
[1609566.934227] audit: type=1333 audit(1667315030.020:83365): op=freq old=69484669593536 new=75240638297659
[1609566.934230] audit: type=1333 audit(1667315030.020:83365): op=status old=8193 new=24577
[1609566.934232] audit: type=1300 audit(1667315030.020:83365): arch=c000003e syscall=305 success=yes exit=0 a0=0 a1=7fff67695dd0 a2=7 a3=0 items=0 ppid=1 pid=2490 auid=4294967295 uid=154 gid=154 euid=154 suid=154 fsuid=154 egid=154 sgid=154 fsgid=154 tty=(none) ses=4294967295 comm="systemd-timesyn" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd-timesyncd" subj=kernel key=(null)
[1609566.934235] audit: type=1327 audit(1667315030.020:83365): proctitle="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd-timesyncd"
[1609659.737626] audit: type=1131 audit(1667315122.825:83366): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1609659.866363] audit: type=1130 audit(1667315122.953:83367): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609659.866366] audit: type=1131 audit(1667315122.953:83368): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609659.866617] audit: type=1334 audit(1667315122.954:83369): prog-id=21776 op=UNLOAD
[1609659.866623] audit: type=1334 audit(1667315122.954:83370): prog-id=21777 op=UNLOAD
[1609659.866742] audit: type=1334 audit(1667315122.954:83371): prog-id=21778 op=LOAD
[1609659.866793] audit: type=1334 audit(1667315122.954:83372): prog-id=21779 op=LOAD
[1609661.573069] audit: type=1130 audit(1667315124.660:83373): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609761.513993] audit: type=1131 audit(1667315224.603:83374): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1609761.864092] audit: type=1130 audit(1667315224.954:83375): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609761.864098] audit: type=1131 audit(1667315224.954:83376): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609761.864414] audit: type=1334 audit(1667315224.954:83377): prog-id=21778 op=UNLOAD
[1609761.864419] audit: type=1334 audit(1667315224.954:83378): prog-id=21779 op=UNLOAD
[1609761.864540] audit: type=1334 audit(1667315224.954:83379): prog-id=21780 op=LOAD
[1609761.864592] audit: type=1334 audit(1667315224.954:83380): prog-id=21781 op=LOAD
[1609763.069748] audit: type=1130 audit(1667315226.159:83381): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609869.221103] audit: type=1131 audit(1667315332.313:83382): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1609869.361589] audit: type=1130 audit(1667315332.453:83383): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609869.361594] audit: type=1131 audit(1667315332.454:83384): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609869.361998] audit: type=1334 audit(1667315332.454:83385): prog-id=21782 op=LOAD
[1609869.362069] audit: type=1334 audit(1667315332.454:83386): prog-id=21783 op=LOAD
[1609869.413645] audit: type=1334 audit(1667315332.506:83387): prog-id=21781 op=UNLOAD
[1609869.413648] audit: type=1334 audit(1667315332.506:83388): prog-id=21780 op=UNLOAD
[1609887.533946] audit: type=1130 audit(1667315350.627:83389): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609972.308202] audit: type=1131 audit(1667315435.402:83390): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1609972.609458] audit: type=1130 audit(1667315435.704:83391): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609972.609466] audit: type=1131 audit(1667315435.704:83392): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1609972.609780] audit: type=1334 audit(1667315435.704:83393): prog-id=21782 op=UNLOAD
[1609972.609785] audit: type=1334 audit(1667315435.704:83394): prog-id=21783 op=UNLOAD
[1609972.609905] audit: type=1334 audit(1667315435.704:83395): prog-id=21784 op=LOAD
[1609972.609964] audit: type=1334 audit(1667315435.704:83396): prog-id=21785 op=LOAD
[1609984.856955] audit: type=1130 audit(1667315447.951:83397): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610074.721490] audit: type=1131 audit(1667315537.819:83398): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1610074.857169] audit: type=1130 audit(1667315537.954:83399): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610074.857172] audit: type=1131 audit(1667315537.954:83400): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610074.857571] audit: type=1334 audit(1667315537.955:83401): prog-id=21786 op=LOAD
[1610074.857620] audit: type=1334 audit(1667315537.955:83402): prog-id=21787 op=LOAD
[1610074.927258] audit: type=1334 audit(1667315538.025:83403): prog-id=21785 op=UNLOAD
[1610074.927260] audit: type=1334 audit(1667315538.025:83404): prog-id=21784 op=UNLOAD
[1610075.531407] audit: type=1130 audit(1667315538.628:83405): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610175.412560] audit: type=1131 audit(1667315638.511:83406): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1610175.605194] audit: type=1130 audit(1667315638.703:83407): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610175.605202] audit: type=1131 audit(1667315638.704:83408): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610175.605483] audit: type=1334 audit(1667315638.704:83409): prog-id=21786 op=UNLOAD
[1610175.605485] audit: type=1334 audit(1667315638.704:83410): prog-id=21787 op=UNLOAD
[1610175.605594] audit: type=1334 audit(1667315638.704:83411): prog-id=21788 op=LOAD
[1610175.605646] audit: type=1334 audit(1667315638.704:83412): prog-id=21789 op=LOAD
[1610176.793244] audit: type=1130 audit(1667315639.892:83413): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610274.410969] audit: type=1131 audit(1667315737.511:83414): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1610274.603211] audit: type=1130 audit(1667315737.703:83415): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610274.603220] audit: type=1131 audit(1667315737.703:83416): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610274.603490] audit: type=1334 audit(1667315737.704:83417): prog-id=21788 op=UNLOAD
[1610274.603492] audit: type=1334 audit(1667315737.704:83418): prog-id=21789 op=UNLOAD
[1610274.603603] audit: type=1334 audit(1667315737.704:83419): prog-id=21790 op=LOAD
[1610274.603655] audit: type=1334 audit(1667315737.704:83420): prog-id=21791 op=LOAD
[1610275.043203] audit: type=1130 audit(1667315738.143:83421): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610373.415621] audit: type=1131 audit(1667315836.519:83422): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1610373.601276] audit: type=1130 audit(1667315836.704:83423): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610373.601282] audit: type=1131 audit(1667315836.704:83424): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610373.601654] audit: type=1334 audit(1667315836.705:83425): prog-id=21792 op=LOAD
[1610373.601703] audit: type=1334 audit(1667315836.705:83426): prog-id=21793 op=LOAD
[1610373.611366] audit: type=1334 audit(1667315836.715:83427): prog-id=21791 op=UNLOAD
[1610373.611368] audit: type=1334 audit(1667315836.715:83428): prog-id=21790 op=UNLOAD
[1610380.988815] audit: type=1130 audit(1667315844.091:83429): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610475.006391] audit: type=1131 audit(1667315938.110:83430): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1610475.349473] audit: type=1130 audit(1667315938.454:83431): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610475.349481] audit: type=1131 audit(1667315938.454:83432): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610475.349822] audit: type=1334 audit(1667315938.454:83433): prog-id=21792 op=UNLOAD
[1610475.349823] audit: type=1334 audit(1667315938.454:83434): prog-id=21793 op=UNLOAD
[1610475.349949] audit: type=1334 audit(1667315938.454:83435): prog-id=21794 op=LOAD
[1610475.350008] audit: type=1334 audit(1667315938.454:83436): prog-id=21795 op=LOAD
[1610476.778885] audit: type=1130 audit(1667315939.884:83437): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610538.946104] audit: type=1006 audit(1667316002.051:83438): pid=1033107 uid=0 subj=kernel old-auid=4294967295 auid=1000 tty=(none) old-ses=4294967295 ses=54 res=1
[1610538.948462] audit: type=1334 audit(1667316002.054:83439): prog-id=21796 op=LOAD
[1610538.948512] audit: type=1334 audit(1667316002.054:83440): prog-id=21797 op=LOAD
[1610571.849280] audit: type=1131 audit(1667316034.955:83441): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1610572.097547] audit: type=1130 audit(1667316035.203:83442): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610572.097552] audit: type=1131 audit(1667316035.203:83443): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610572.097832] audit: type=1334 audit(1667316035.204:83444): prog-id=21794 op=UNLOAD
[1610572.097840] audit: type=1334 audit(1667316035.204:83445): prog-id=21795 op=UNLOAD
[1610572.098026] audit: type=1334 audit(1667316035.204:83446): prog-id=21798 op=LOAD
[1610572.098086] audit: type=1334 audit(1667316035.204:83447): prog-id=21799 op=LOAD
[1610572.784626] audit: type=1130 audit(1667316035.891:83448): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610669.128211] audit: type=1131 audit(1667316132.236:83449): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1610669.346185] audit: type=1130 audit(1667316132.454:83450): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610669.346193] audit: type=1131 audit(1667316132.454:83451): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610669.346644] audit: type=1334 audit(1667316132.454:83452): prog-id=21798 op=UNLOAD
[1610669.346652] audit: type=1334 audit(1667316132.454:83453): prog-id=21799 op=UNLOAD
[1610669.346871] audit: type=1334 audit(1667316132.455:83454): prog-id=21800 op=LOAD
[1610669.346946] audit: type=1334 audit(1667316132.455:83455): prog-id=21801 op=LOAD
[1610677.322380] audit: type=1130 audit(1667316140.430:83456): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610759.500204] audit: type=1334 audit(1667316222.610:83457): prog-id=21797 op=UNLOAD
[1610759.500209] audit: type=1334 audit(1667316222.610:83458): prog-id=21796 op=UNLOAD
[1610760.911009] audit: type=1131 audit(1667316224.020:83459): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1610761.094192] audit: type=1130 audit(1667316224.204:83460): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610761.094197] audit: type=1131 audit(1667316224.204:83461): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610761.094495] audit: type=1334 audit(1667316224.204:83462): prog-id=21800 op=UNLOAD
[1610761.094498] audit: type=1334 audit(1667316224.204:83463): prog-id=21801 op=UNLOAD
[1610761.094601] audit: type=1334 audit(1667316224.204:83464): prog-id=21802 op=LOAD
[1610761.094652] audit: type=1334 audit(1667316224.204:83465): prog-id=21803 op=LOAD
[1610766.079321] audit: type=1130 audit(1667316229.189:83466): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610766.459340] audit: type=1006 audit(1667316229.569:83467): pid=1034255 uid=0 subj=kernel old-auid=4294967295 auid=1000 tty=(none) old-ses=4294967295 ses=55 res=1
[1610766.461592] audit: type=1334 audit(1667316229.571:83468): prog-id=21804 op=LOAD
[1610766.461642] audit: type=1334 audit(1667316229.571:83469): prog-id=21805 op=LOAD
[1610860.908014] audit: type=1131 audit(1667316324.019:83470): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1610861.092351] audit: type=1130 audit(1667316324.204:83471): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610861.092356] audit: type=1131 audit(1667316324.204:83472): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610861.092655] audit: type=1334 audit(1667316324.204:83473): prog-id=21802 op=UNLOAD
[1610861.092660] audit: type=1334 audit(1667316324.204:83474): prog-id=21803 op=UNLOAD
[1610861.092809] audit: type=1334 audit(1667316324.204:83475): prog-id=21806 op=LOAD
[1610861.092865] audit: type=1334 audit(1667316324.204:83476): prog-id=21807 op=LOAD
[1610866.218908] audit: type=1130 audit(1667316329.330:83477): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610954.633036] audit: type=1131 audit(1667316417.746:83478): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1610954.840600] audit: type=1130 audit(1667316417.953:83479): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610954.840604] audit: type=1131 audit(1667316417.953:83480): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1610954.840892] audit: type=1334 audit(1667316417.954:83481): prog-id=21806 op=UNLOAD
[1610954.840895] audit: type=1334 audit(1667316417.954:83482): prog-id=21807 op=UNLOAD
[1610954.841121] audit: type=1334 audit(1667316417.954:83483): prog-id=21808 op=LOAD
[1610954.841175] audit: type=1334 audit(1667316417.954:83484): prog-id=21809 op=LOAD
[1610960.967991] audit: type=1130 audit(1667316424.081:83485): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1611001.619958] audit: type=1701 audit(1667316464.734:83491): auid=1000 uid=1000 gid=100 ses=4 subj=kernel pid=1035907 comm=".emacs-28.0.50-" exe="/nix/store/2qsaw18gfmfic2g1rhjpj03g5an325dn-emacs-gcc-20210722.0/bin/.emacs-28.0.50-wrapped" sig=6 res=1
[1611001.619973] audit: type=1701 audit(1667316464.734:83489): auid=1000 uid=1000 gid=100 ses=4 subj=kernel pid=1035935 comm=".emacs-28.0.50-" exe="/nix/store/2qsaw18gfmfic2g1rhjpj03g5an325dn-emacs-gcc-20210722.0/bin/.emacs-28.0.50-wrapped" sig=6 res=1
[1611001.619978] audit: type=1701 audit(1667316464.734:83486): auid=1000 uid=1000 gid=100 ses=4 subj=kernel pid=1035928 comm=".emacs-28.0.50-" exe="/nix/store/2qsaw18gfmfic2g1rhjpj03g5an325dn-emacs-gcc-20210722.0/bin/.emacs-28.0.50-wrapped" sig=6 res=1
[1611001.619984] audit: type=1701 audit(1667316464.734:83488): auid=1000 uid=1000 gid=100 ses=4 subj=kernel pid=1035954 comm=".emacs-28.0.50-" exe="/nix/store/2qsaw18gfmfic2g1rhjpj03g5an325dn-emacs-gcc-20210722.0/bin/.emacs-28.0.50-wrapped" sig=6 res=1
[1611001.619989] audit: type=1701 audit(1667316464.734:83490): auid=1000 uid=1000 gid=100 ses=4 subj=kernel pid=1035914 comm=".emacs-28.0.50-" exe="/nix/store/2qsaw18gfmfic2g1rhjpj03g5an325dn-emacs-gcc-20210722.0/bin/.emacs-28.0.50-wrapped" sig=6 res=1
[1611001.619992] audit: type=1701 audit(1667316464.734:83487): auid=1000 uid=1000 gid=100 ses=4 subj=kernel pid=1035942 comm=".emacs-28.0.50-" exe="/nix/store/2qsaw18gfmfic2g1rhjpj03g5an325dn-emacs-gcc-20210722.0/bin/.emacs-28.0.50-wrapped" sig=6 res=1
[1611001.619995] audit: type=1701 audit(1667316464.734:83492): auid=1000 uid=1000 gid=100 ses=4 subj=kernel pid=1035898 comm=".emacs-28.0.50-" exe="/nix/store/2qsaw18gfmfic2g1rhjpj03g5an325dn-emacs-gcc-20210722.0/bin/.emacs-28.0.50-wrapped" sig=6 res=1
[1611001.619998] audit: type=1701 audit(1667316464.734:83493): auid=1000 uid=1000 gid=100 ses=4 subj=kernel pid=1035899 comm=".emacs-28.0.50-" exe="/nix/store/2qsaw18gfmfic2g1rhjpj03g5an325dn-emacs-gcc-20210722.0/bin/.emacs-28.0.50-wrapped" sig=6 res=1
[1611001.620002] audit: type=1701 audit(1667316464.734:83494): auid=1000 uid=1000 gid=100 ses=4 subj=kernel pid=1035875 comm=".emacs-28.0.50-" exe="/nix/store/2qsaw18gfmfic2g1rhjpj03g5an325dn-emacs-gcc-20210722.0/bin/.emacs-28.0.50-wrapped" sig=6 res=1
[1611001.620008] audit: type=1701 audit(1667316464.734:83495): auid=1000 uid=1000 gid=100 ses=4 subj=kernel pid=1035849 comm=".emacs-28.0.50-" exe="/nix/store/2qsaw18gfmfic2g1rhjpj03g5an325dn-emacs-gcc-20210722.0/bin/.emacs-28.0.50-wrapped" sig=6 res=1
[1611006.758736] kauditd_printk_skb: 70 callbacks suppressed
[1611006.758739] audit: type=1334 audit(1667316469.873:83566): prog-id=21820 op=UNLOAD
[1611006.758742] audit: type=1334 audit(1667316469.873:83567): prog-id=21819 op=UNLOAD
[1611006.758743] audit: type=1334 audit(1667316469.873:83568): prog-id=21818 op=UNLOAD
[1611010.142663] audit: type=1334 audit(1667316473.257:83569): prog-id=21838 op=UNLOAD
[1611010.142667] audit: type=1334 audit(1667316473.257:83570): prog-id=21837 op=UNLOAD
[1611010.142669] audit: type=1334 audit(1667316473.257:83571): prog-id=21836 op=UNLOAD
[1611015.018591] audit: type=1334 audit(1667316478.133:83572): prog-id=21835 op=UNLOAD
[1611015.018596] audit: type=1334 audit(1667316478.133:83573): prog-id=21834 op=UNLOAD
[1611015.018598] audit: type=1334 audit(1667316478.133:83574): prog-id=21833 op=UNLOAD
[1611021.002474] audit: type=1334 audit(1667316484.117:83575): prog-id=21826 op=UNLOAD
[1611021.002479] audit: type=1334 audit(1667316484.117:83576): prog-id=21825 op=UNLOAD
[1611021.002481] audit: type=1334 audit(1667316484.117:83577): prog-id=21824 op=UNLOAD
[1611027.084383] audit: type=1334 audit(1667316490.199:83578): prog-id=21844 op=UNLOAD
[1611027.084388] audit: type=1334 audit(1667316490.199:83579): prog-id=21843 op=UNLOAD
[1611027.084391] audit: type=1334 audit(1667316490.199:83580): prog-id=21842 op=UNLOAD
[1611036.901190] audit: type=1334 audit(1667316500.016:83581): prog-id=21832 op=UNLOAD
[1611036.901195] audit: type=1334 audit(1667316500.016:83582): prog-id=21831 op=UNLOAD
[1611036.901197] audit: type=1334 audit(1667316500.016:83583): prog-id=21830 op=UNLOAD
[1611040.915129] audit: type=1334 audit(1667316504.030:83584): prog-id=21829 op=UNLOAD
[1611040.915134] audit: type=1334 audit(1667316504.030:83585): prog-id=21828 op=UNLOAD
[1611040.915136] audit: type=1334 audit(1667316504.030:83586): prog-id=21827 op=UNLOAD
[1611045.122952] audit: type=1334 audit(1667316508.237:83587): prog-id=21805 op=UNLOAD
[1611045.122956] audit: type=1334 audit(1667316508.237:83588): prog-id=21804 op=UNLOAD
[1611045.247047] audit: type=1334 audit(1667316508.362:83589): prog-id=21817 op=UNLOAD
[1611045.247051] audit: type=1334 audit(1667316508.362:83590): prog-id=21816 op=UNLOAD
[1611045.247052] audit: type=1334 audit(1667316508.362:83591): prog-id=21815 op=UNLOAD
[1611045.344033] audit: type=1334 audit(1667316508.459:83592): prog-id=21841 op=UNLOAD
[1611045.344036] audit: type=1334 audit(1667316508.459:83593): prog-id=21840 op=UNLOAD
[1611045.344037] audit: type=1334 audit(1667316508.459:83594): prog-id=21839 op=UNLOAD
[1611049.814519] audit: type=1131 audit(1667316512.929:83595): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1611050.089010] audit: type=1130 audit(1667316513.204:83596): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1611062.247994] kauditd_printk_skb: 5 callbacks suppressed
[1611062.247998] audit: type=1130 audit(1667316525.363:83602): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1611146.480371] audit: type=1131 audit(1667316609.597:83603): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1611146.587318] audit: type=1130 audit(1667316609.704:83604): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1611146.587325] audit: type=1131 audit(1667316609.704:83605): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1611146.587855] audit: type=1334 audit(1667316609.704:83606): prog-id=21849 op=LOAD
[1611146.587925] audit: type=1334 audit(1667316609.704:83607): prog-id=21850 op=LOAD
[1611146.602285] audit: type=1334 audit(1667316609.719:83608): prog-id=21848 op=UNLOAD
[1611146.602288] audit: type=1334 audit(1667316609.719:83609): prog-id=21847 op=UNLOAD
[1611147.351452] audit: type=1130 audit(1667316610.468:83610): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1611246.808530] audit: type=1131 audit(1667316709.927:83611): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1611247.085568] audit: type=1130 audit(1667316710.204:83612): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1611247.085575] audit: type=1131 audit(1667316710.204:83613): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1611247.085867] audit: type=1334 audit(1667316710.204:83614): prog-id=21849 op=UNLOAD
[1611247.085870] audit: type=1334 audit(1667316710.204:83615): prog-id=21850 op=UNLOAD
[1611247.086143] audit: type=1334 audit(1667316710.204:83616): prog-id=21851 op=LOAD
[1611247.086194] audit: type=1334 audit(1667316710.204:83617): prog-id=21852 op=LOAD
[1611252.100840] audit: type=1130 audit(1667316715.219:83618): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1611347.765672] audit: type=1131 audit(1667316810.885:83619): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1611348.083764] audit: type=1130 audit(1667316811.204:83620): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1611348.083771] audit: type=1131 audit(1667316811.204:83621): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1611348.084118] audit: type=1334 audit(1667316811.204:83622): prog-id=21851 op=UNLOAD
[1611348.084124] audit: type=1334 audit(1667316811.204:83623): prog-id=21852 op=UNLOAD
[1611348.084399] audit: type=1334 audit(1667316811.204:83624): prog-id=21853 op=LOAD
[1611348.084459] audit: type=1334 audit(1667316811.204:83625): prog-id=21854 op=LOAD
[1611412.456233] audit: type=1130 audit(1667316875.577:83626): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1611442.676587] audit: type=1131 audit(1667316905.798:83627): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1611442.831948] audit: type=1130 audit(1667316905.953:83628): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1611442.831954] audit: type=1131 audit(1667316905.953:83629): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1611442.832217] audit: type=1334 audit(1667316905.954:83630): prog-id=21853 op=UNLOAD
[1611442.832221] audit: type=1334 audit(1667316905.954:83631): prog-id=21854 op=UNLOAD
[1611442.832345] audit: type=1334 audit(1667316905.954:83632): prog-id=21855 op=LOAD
[1611442.832402] audit: type=1334 audit(1667316905.954:83633): prog-id=21856 op=LOAD
[1611444.819408] audit: type=1130 audit(1667316907.941:83634): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1611501.880490] audit: type=1701 audit(1667316965.003:83635): auid=1000 uid=1000 gid=100 ses=53 subj=kernel pid=1001841 comm=".emacs-28.0.50-" exe="/nix/store/2qsaw18gfmfic2g1rhjpj03g5an325dn-emacs-gcc-20210722.0/bin/.emacs-28.0.50-wrapped" sig=6 res=1
[1611502.086590] audit: type=1701 audit(1667316965.209:83636): auid=1000 uid=1000 gid=100 ses=53 subj=kernel pid=1001195 comm=".emacs-28.0.50-" exe="/nix/store/2qsaw18gfmfic2g1rhjpj03g5an325dn-emacs-gcc-20210722.0/bin/.emacs-28.0.50-wrapped" sig=6 res=1
[1611502.132985] audit: type=1334 audit(1667316965.256:83637): prog-id=21845 op=UNLOAD
[1611502.132990] audit: type=1334 audit(1667316965.256:83638): prog-id=21846 op=UNLOAD
[1611502.133113] audit: type=1334 audit(1667316965.256:83639): prog-id=21857 op=LOAD
[1611502.133182] audit: type=1334 audit(1667316965.256:83640): prog-id=21858 op=LOAD
[1611502.133546] audit: type=1334 audit(1667316965.256:83641): prog-id=21859 op=LOAD
[1611502.133633] audit: type=1334 audit(1667316965.256:83642): prog-id=21860 op=LOAD
[1611502.133671] audit: type=1334 audit(1667316965.256:83643): prog-id=21861 op=LOAD
[1611502.134427] audit: type=1130 audit(1667316965.257:83644): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-coredump@62-1040022-0 comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1611508.000921] kauditd_printk_skb: 5 callbacks suppressed
[1611508.000924] audit: type=1334 audit(1667316971.124:83650): prog-id=21861 op=UNLOAD
[1611508.000928] audit: type=1334 audit(1667316971.124:83651): prog-id=21860 op=UNLOAD
[1611508.000930] audit: type=1334 audit(1667316971.124:83652): prog-id=21859 op=UNLOAD
[1611521.492822] audit: type=1131 audit(1667316984.617:83653): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-coredump@63-1040023-0 comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1611521.493277] audit: type=1334 audit(1667316984.617:83654): prog-id=21857 op=UNLOAD
[1611521.493286] audit: type=1334 audit(1667316984.617:83655): prog-id=21858 op=UNLOAD
[1611521.493395] audit: type=1334 audit(1667316984.617:83656): prog-id=21865 op=LOAD
[1611521.493457] audit: type=1334 audit(1667316984.617:83657): prog-id=21866 op=LOAD
[1611521.536673] audit: type=1334 audit(1667316984.661:83658): prog-id=21354 op=UNLOAD
[1611521.536677] audit: type=1334 audit(1667316984.661:83659): prog-id=21353 op=UNLOAD
[1611524.498634] audit: type=1334 audit(1667316987.622:83660): prog-id=21864 op=UNLOAD
[1611524.498640] audit: type=1334 audit(1667316987.622:83661): prog-id=21863 op=UNLOAD
[1611524.498642] audit: type=1334 audit(1667316987.622:83662): prog-id=21862 op=UNLOAD
[1611539.587595] audit: type=1131 audit(1667317002.711:83663): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1611539.830596] audit: type=1130 audit(1667317002.954:83664): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1611539.830602] audit: type=1131 audit(1667317002.954:83665): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1611539.830962] audit: type=1334 audit(1667317002.954:83666): prog-id=21855 op=UNLOAD
[1611539.830968] audit: type=1334 audit(1667317002.954:83667): prog-id=21856 op=UNLOAD
[1611539.831084] audit: type=1334 audit(1667317002.954:83668): prog-id=21867 op=LOAD
[1611539.831139] audit: type=1334 audit(1667317002.954:83669): prog-id=21868 op=LOAD
[1611547.831409] audit: type=1130 audit(1667317010.955:83670): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1611615.144369] audit: type=1333 audit(1667317078.269:83671): op=offset old=344122411597 new=-2168829635461
[1611615.144375] audit: type=1333 audit(1667317078.269:83671): op=freq old=75240638297659 new=74711138874939
[1611615.144376] audit: type=1333 audit(1667317078.269:83671): op=status old=24577 new=8193
[1611615.144379] audit: type=1300 audit(1667317078.269:83671): arch=c000003e syscall=305 success=yes exit=0 a0=0 a1=7fff67695dd0 a2=7 a3=0 items=0 ppid=1 pid=2490 auid=4294967295 uid=154 gid=154 euid=154 suid=154 fsuid=154 egid=154 sgid=154 fsgid=154 tty=(none) ses=4294967295 comm="systemd-timesyn" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd-timesyncd" subj=kernel key=(null)
[1611615.144381] audit: type=1327 audit(1667317078.269:83671): proctitle="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd-timesyncd"
[1611643.825431] audit: type=1131 audit(1667317106.950:83672): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1611644.078516] audit: type=1130 audit(1667317107.204:83673): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1611644.078519] audit: type=1131 audit(1667317107.204:83674): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1611644.078826] audit: type=1334 audit(1667317107.204:83675): prog-id=21867 op=UNLOAD
[1611644.078832] audit: type=1334 audit(1667317107.204:83676): prog-id=21868 op=UNLOAD
[1611644.078949] audit: type=1334 audit(1667317107.204:83677): prog-id=21869 op=LOAD
[1611644.079002] audit: type=1334 audit(1667317107.204:83678): prog-id=21870 op=LOAD
[1611815.847442] audit: type=1006 audit(1667317278.976:83679): pid=1040259 uid=0 subj=kernel old-auid=4294967295 auid=1000 tty=(none) old-ses=4294967295 ses=56 res=1
[1611815.849755] audit: type=1334 audit(1667317278.979:83680): prog-id=21871 op=LOAD
[1611815.849812] audit: type=1334 audit(1667317278.979:83681): prog-id=21872 op=LOAD
[1612828.394004] ata4.00: exception Emask 0x0 SAct 0xffffffff SErr 0xc0000 action 0x0
[1612828.394010] ata4.00: irq_stat 0x40000008
[1612828.394011] ata4: SError: { CommWake 10B8B }
[1612828.394014] ata4.00: failed command: READ FPDMA QUEUED
[1612828.394015] ata4.00: cmd 60/50:c8:70:f6:3f/02:00:db:00:00/40 tag 25 ncq dma 303104 in
                          res 43/40:50:68:f7:3f/00:02:db:00:00/00 Emask 0x409 (media error) <F>
[1612828.394019] ata4.00: status: { DRDY SENSE ERR }
[1612828.394021] ata4.00: error: { UNC }
[1612828.784982] ata4.00: configured for UDMA/133
[1612828.785020] sd 3:0:0:0: [sdb] tag#25 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=1s
[1612828.785023] sd 3:0:0:0: [sdb] tag#25 Sense Key : Medium Error [current] 
[1612828.785024] sd 3:0:0:0: [sdb] tag#25 Add. Sense: Unrecovered read error - auto reallocate failed
[1612828.785025] sd 3:0:0:0: [sdb] tag#25 CDB: Read(10) 28 00 db 3f f6 70 00 02 50 00
[1612828.785026] blk_update_request: I/O error, dev sdb, sector 3678402408 op 0x0:(READ) flags 0x80000 phys_seg 9 prio class 0
[1612828.785052] ata4: EH complete
[1612830.177874] ata4.00: exception Emask 0x0 SAct 0x24000000 SErr 0x0 action 0x0
[1612830.177880] ata4.00: irq_stat 0x40000008
[1612830.177882] ata4.00: failed command: READ FPDMA QUEUED
[1612830.177883] ata4.00: cmd 60/08:e8:68:f7:3f/00:00:db:00:00/40 tag 29 ncq dma 4096 in
                          res 43/40:08:68:f7:3f/00:00:db:00:00/00 Emask 0x409 (media error) <F>
[1612830.177888] ata4.00: status: { DRDY SENSE ERR }
[1612830.177889] ata4.00: error: { UNC }
[1612831.583356] ata4.00: configured for UDMA/133
[1612831.583376] sd 3:0:0:0: [sdb] tag#29 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=2s
[1612831.583378] sd 3:0:0:0: [sdb] tag#29 Sense Key : Medium Error [current] 
[1612831.583380] sd 3:0:0:0: [sdb] tag#29 Add. Sense: Unrecovered read error - auto reallocate failed
[1612831.583381] sd 3:0:0:0: [sdb] tag#29 CDB: Read(10) 28 00 db 3f f7 68 00 00 08 00
[1612831.583382] blk_update_request: I/O error, dev sdb, sector 3678402408 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[1612831.583390] BTRFS error (device dm-0): bdev /dev/dm-5 errs: wr 0, rd 394, flush 0, corrupt 0, gen 0
[1612831.583398] ata4: EH complete
[1612833.537980] audit: type=1130 audit(1667318296.683:83682): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=btrfs-backup comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1612852.193246] audit: type=1130 audit(1667318315.339:83683): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1612852.308027] audit: type=1130 audit(1667318315.453:83684): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1612852.308031] audit: type=1131 audit(1667318315.453:83685): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1612852.308288] audit: type=1334 audit(1667318315.454:83686): prog-id=21869 op=UNLOAD
[1612852.308291] audit: type=1334 audit(1667318315.454:83687): prog-id=21870 op=UNLOAD
[1612852.308545] audit: type=1334 audit(1667318315.454:83688): prog-id=21873 op=LOAD
[1612852.308606] audit: type=1334 audit(1667318315.454:83689): prog-id=21874 op=LOAD
[1612852.467135] audit: type=1130 audit(1667318315.612:83690): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1612956.560035] audit: type=1131 audit(1667318419.707:83691): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1612956.560813] audit: type=1334 audit(1667318419.708:83692): prog-id=21770 op=UNLOAD
[1612956.560816] audit: type=1334 audit(1667318419.708:83693): prog-id=21771 op=UNLOAD
[1612956.560949] audit: type=1334 audit(1667318419.708:83694): prog-id=21875 op=LOAD
[1612956.561004] audit: type=1334 audit(1667318419.708:83695): prog-id=21876 op=LOAD
[1612956.561660] audit: type=1130 audit(1667318419.709:83696): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=update-locatedb comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1612956.806286] audit: type=1130 audit(1667318419.953:83697): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1612956.806291] audit: type=1131 audit(1667318419.953:83698): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1612956.806527] audit: type=1334 audit(1667318419.954:83699): prog-id=21873 op=UNLOAD
[1612956.806531] audit: type=1334 audit(1667318419.954:83700): prog-id=21874 op=UNLOAD
[1612987.556833] kauditd_printk_skb: 2 callbacks suppressed
[1612987.556842] audit: type=1131 audit(1667318450.704:83703): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=update-locatedb comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1612987.959727] audit: type=1130 audit(1667318451.107:83704): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613054.858456] audit: type=1131 audit(1667318518.007:83705): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1613055.054561] audit: type=1130 audit(1667318518.203:83706): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613055.054567] audit: type=1131 audit(1667318518.203:83707): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613055.054815] audit: type=1334 audit(1667318518.204:83708): prog-id=21877 op=UNLOAD
[1613055.054818] audit: type=1334 audit(1667318518.204:83709): prog-id=21878 op=UNLOAD
[1613055.054929] audit: type=1334 audit(1667318518.204:83710): prog-id=21879 op=LOAD
[1613055.054979] audit: type=1334 audit(1667318518.204:83711): prog-id=21880 op=LOAD
[1613055.851210] audit: type=1130 audit(1667318519.000:83712): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613159.161723] audit: type=1131 audit(1667318622.312:83713): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1613159.302871] audit: type=1130 audit(1667318622.453:83714): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613159.302875] audit: type=1131 audit(1667318622.453:83715): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613159.303170] audit: type=1334 audit(1667318622.454:83716): prog-id=21879 op=UNLOAD
[1613159.303172] audit: type=1334 audit(1667318622.454:83717): prog-id=21880 op=UNLOAD
[1613159.303287] audit: type=1334 audit(1667318622.454:83718): prog-id=21881 op=LOAD
[1613159.303344] audit: type=1334 audit(1667318622.454:83719): prog-id=21882 op=LOAD
[1613159.671879] audit: type=1130 audit(1667318622.822:83720): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613270.090892] audit: type=1131 audit(1667318733.243:83721): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1613270.300880] audit: type=1130 audit(1667318733.453:83722): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613270.300883] audit: type=1131 audit(1667318733.453:83723): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613270.301121] audit: type=1334 audit(1667318733.454:83724): prog-id=21881 op=UNLOAD
[1613270.301125] audit: type=1334 audit(1667318733.454:83725): prog-id=21882 op=UNLOAD
[1613270.301259] audit: type=1334 audit(1667318733.454:83726): prog-id=21883 op=LOAD
[1613270.301311] audit: type=1334 audit(1667318733.454:83727): prog-id=21884 op=LOAD
[1613272.523885] audit: type=1130 audit(1667318735.676:83728): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613376.332336] audit: type=1131 audit(1667318839.487:83729): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1613376.549099] audit: type=1130 audit(1667318839.703:83730): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613376.549107] audit: type=1131 audit(1667318839.703:83731): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613376.549390] audit: type=1334 audit(1667318839.704:83732): prog-id=21883 op=UNLOAD
[1613376.549397] audit: type=1334 audit(1667318839.704:83733): prog-id=21884 op=UNLOAD
[1613376.549504] audit: type=1334 audit(1667318839.704:83734): prog-id=21885 op=LOAD
[1613376.549560] audit: type=1334 audit(1667318839.704:83735): prog-id=21886 op=LOAD
[1613377.693557] audit: type=1130 audit(1667318840.848:83736): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613480.947103] audit: type=1131 audit(1667318944.103:83737): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1613481.297303] audit: type=1130 audit(1667318944.453:83738): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613481.297306] audit: type=1131 audit(1667318944.453:83739): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613481.297570] audit: type=1334 audit(1667318944.454:83740): prog-id=21885 op=UNLOAD
[1613481.297578] audit: type=1334 audit(1667318944.454:83741): prog-id=21886 op=UNLOAD
[1613481.297699] audit: type=1334 audit(1667318944.454:83742): prog-id=21887 op=LOAD
[1613481.297749] audit: type=1334 audit(1667318944.454:83743): prog-id=21888 op=LOAD
[1613482.423613] audit: type=1130 audit(1667318945.580:83744): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613582.563920] audit: type=1131 audit(1667319045.722:83745): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1613582.795519] audit: type=1130 audit(1667319045.953:83746): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613582.795525] audit: type=1131 audit(1667319045.953:83747): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613582.795769] audit: type=1334 audit(1667319045.954:83748): prog-id=21887 op=UNLOAD
[1613582.795773] audit: type=1334 audit(1667319045.954:83749): prog-id=21888 op=UNLOAD
[1613582.795903] audit: type=1334 audit(1667319045.954:83750): prog-id=21889 op=LOAD
[1613582.795959] audit: type=1334 audit(1667319045.954:83751): prog-id=21890 op=LOAD
[1613582.943790] audit: type=1130 audit(1667319046.102:83752): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613663.360961] audit: type=1333 audit(1667319126.520:83753): op=offset old=-39568431861 new=-3995646730174
[1613663.360966] audit: type=1333 audit(1667319126.520:83753): op=freq old=74711138874939 new=73735639184955
[1613663.360969] audit: type=1300 audit(1667319126.520:83753): arch=c000003e syscall=305 success=yes exit=0 a0=0 a1=7fff67695dd0 a2=7 a3=0 items=0 ppid=1 pid=2490 auid=4294967295 uid=154 gid=154 euid=154 suid=154 fsuid=154 egid=154 sgid=154 fsgid=154 tty=(none) ses=4294967295 comm="systemd-timesyn" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd-timesyncd" subj=kernel key=(null)
[1613663.360972] audit: type=1327 audit(1667319126.520:83753): proctitle="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd-timesyncd"
[1613685.471042] audit: type=1131 audit(1667319148.631:83754): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1613685.793839] audit: type=1130 audit(1667319148.953:83755): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613685.793843] audit: type=1131 audit(1667319148.953:83756): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613685.794115] audit: type=1334 audit(1667319148.954:83757): prog-id=21889 op=UNLOAD
[1613685.794117] audit: type=1334 audit(1667319148.954:83758): prog-id=21890 op=UNLOAD
[1613685.794244] audit: type=1334 audit(1667319148.954:83759): prog-id=21891 op=LOAD
[1613685.794297] audit: type=1334 audit(1667319148.954:83760): prog-id=21892 op=LOAD
[1613685.923187] audit: type=1130 audit(1667319149.083:83761): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613784.448295] audit: type=1131 audit(1667319247.609:83762): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1613784.792277] audit: type=1130 audit(1667319247.953:83763): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613784.792281] audit: type=1131 audit(1667319247.953:83764): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613784.792525] audit: type=1334 audit(1667319247.954:83765): prog-id=21891 op=UNLOAD
[1613784.792530] audit: type=1334 audit(1667319247.954:83766): prog-id=21892 op=UNLOAD
[1613784.792661] audit: type=1334 audit(1667319247.954:83767): prog-id=21893 op=LOAD
[1613784.792716] audit: type=1334 audit(1667319247.954:83768): prog-id=21894 op=LOAD
[1613785.712122] audit: type=1130 audit(1667319248.873:83769): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613884.268504] audit: type=1131 audit(1667319347.431:83770): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1613884.540708] audit: type=1130 audit(1667319347.704:83771): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613884.540712] audit: type=1131 audit(1667319347.704:83772): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613884.540969] audit: type=1334 audit(1667319347.704:83773): prog-id=21893 op=UNLOAD
[1613884.540971] audit: type=1334 audit(1667319347.704:83774): prog-id=21894 op=UNLOAD
[1613884.541101] audit: type=1334 audit(1667319347.704:83775): prog-id=21895 op=LOAD
[1613884.541157] audit: type=1334 audit(1667319347.704:83776): prog-id=21896 op=LOAD
[1613884.751252] audit: type=1130 audit(1667319347.914:83777): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613983.343399] audit: type=1131 audit(1667319446.508:83778): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1613983.539149] audit: type=1130 audit(1667319446.704:83779): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613983.539153] audit: type=1131 audit(1667319446.704:83780): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1613983.539401] audit: type=1334 audit(1667319446.704:83781): prog-id=21895 op=UNLOAD
[1613983.539408] audit: type=1334 audit(1667319446.704:83782): prog-id=21896 op=UNLOAD
[1613983.539537] audit: type=1334 audit(1667319446.704:83783): prog-id=21897 op=LOAD
[1613983.539595] audit: type=1334 audit(1667319446.704:83784): prog-id=21898 op=LOAD
[1613984.206921] audit: type=1130 audit(1667319447.371:83785): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614084.063505] audit: type=1131 audit(1667319547.229:83786): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1614084.287531] audit: type=1130 audit(1667319547.453:83787): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614084.287535] audit: type=1131 audit(1667319547.453:83788): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614084.287790] audit: type=1334 audit(1667319547.454:83789): prog-id=21897 op=UNLOAD
[1614084.287793] audit: type=1334 audit(1667319547.454:83790): prog-id=21898 op=UNLOAD
[1614084.287921] audit: type=1334 audit(1667319547.454:83791): prog-id=21899 op=LOAD
[1614084.287978] audit: type=1334 audit(1667319547.454:83792): prog-id=21900 op=LOAD
[1614084.412348] audit: type=1130 audit(1667319547.578:83793): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614191.540841] audit: type=1131 audit(1667319654.708:83794): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1614191.785891] audit: type=1130 audit(1667319654.954:83795): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614191.785896] audit: type=1131 audit(1667319654.954:83796): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614191.786192] audit: type=1334 audit(1667319654.954:83797): prog-id=21899 op=UNLOAD
[1614191.786198] audit: type=1334 audit(1667319654.954:83798): prog-id=21900 op=UNLOAD
[1614191.786334] audit: type=1334 audit(1667319654.954:83799): prog-id=21901 op=LOAD
[1614191.786389] audit: type=1334 audit(1667319654.954:83800): prog-id=21902 op=LOAD
[1614192.106619] audit: type=1130 audit(1667319655.274:83801): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614263.877623] audit: type=1131 audit(1667319727.046:83802): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1614264.034597] audit: type=1130 audit(1667319727.203:83803): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614264.034604] audit: type=1131 audit(1667319727.203:83804): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614264.034844] audit: type=1334 audit(1667319727.204:83805): prog-id=21901 op=UNLOAD
[1614264.034847] audit: type=1334 audit(1667319727.204:83806): prog-id=21902 op=UNLOAD
[1614264.034989] audit: type=1334 audit(1667319727.204:83807): prog-id=21903 op=LOAD
[1614264.035040] audit: type=1334 audit(1667319727.204:83808): prog-id=21904 op=LOAD
[1614264.297113] audit: type=1130 audit(1667319727.466:83809): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614371.535738] audit: type=1131 audit(1667319834.706:83810): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1614371.782874] audit: type=1130 audit(1667319834.953:83811): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614371.782879] audit: type=1131 audit(1667319834.953:83812): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614371.783214] audit: type=1334 audit(1667319834.954:83813): prog-id=21903 op=UNLOAD
[1614371.783216] audit: type=1334 audit(1667319834.954:83814): prog-id=21904 op=UNLOAD
[1614371.783348] audit: type=1334 audit(1667319834.954:83815): prog-id=21905 op=LOAD
[1614371.783403] audit: type=1334 audit(1667319834.954:83816): prog-id=21906 op=LOAD
[1614380.972747] audit: type=1130 audit(1667319844.143:83817): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614477.476364] audit: type=1131 audit(1667319940.649:83818): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1614477.781234] audit: type=1130 audit(1667319940.954:83819): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614477.781239] audit: type=1131 audit(1667319940.954:83820): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614477.781616] audit: type=1334 audit(1667319940.954:83821): prog-id=21905 op=UNLOAD
[1614477.781622] audit: type=1334 audit(1667319940.954:83822): prog-id=21906 op=UNLOAD
[1614477.781757] audit: type=1334 audit(1667319940.954:83823): prog-id=21907 op=LOAD
[1614477.781809] audit: type=1334 audit(1667319940.954:83824): prog-id=21908 op=LOAD
[1614483.002303] audit: type=1130 audit(1667319946.175:83825): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614556.662613] audit: type=1131 audit(1667320019.836:83826): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1614556.779744] audit: type=1130 audit(1667320019.953:83827): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614556.779748] audit: type=1131 audit(1667320019.953:83828): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614556.780014] audit: type=1334 audit(1667320019.954:83829): prog-id=21907 op=UNLOAD
[1614556.780020] audit: type=1334 audit(1667320019.954:83830): prog-id=21908 op=UNLOAD
[1614556.780147] audit: type=1334 audit(1667320019.954:83831): prog-id=21909 op=LOAD
[1614556.780199] audit: type=1334 audit(1667320019.954:83832): prog-id=21910 op=LOAD
[1614564.556453] audit: type=1130 audit(1667320027.730:83833): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614630.650563] audit: type=1131 audit(1667320093.825:83834): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1614630.778521] audit: type=1130 audit(1667320093.953:83835): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614630.778528] audit: type=1131 audit(1667320093.953:83836): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614630.778870] audit: type=1334 audit(1667320093.954:83837): prog-id=21909 op=UNLOAD
[1614630.778872] audit: type=1334 audit(1667320093.954:83838): prog-id=21910 op=UNLOAD
[1614630.779005] audit: type=1334 audit(1667320093.954:83839): prog-id=21911 op=LOAD
[1614630.779058] audit: type=1334 audit(1667320093.954:83840): prog-id=21912 op=LOAD
[1614631.330902] audit: type=1130 audit(1667320094.506:83841): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614706.370733] audit: type=1131 audit(1667320169.547:83842): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1614706.527230] audit: type=1130 audit(1667320169.704:83843): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614706.527234] audit: type=1131 audit(1667320169.704:83844): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614706.527471] audit: type=1334 audit(1667320169.704:83845): prog-id=21911 op=UNLOAD
[1614706.527472] audit: type=1334 audit(1667320169.704:83846): prog-id=21912 op=UNLOAD
[1614706.527597] audit: type=1334 audit(1667320169.704:83847): prog-id=21913 op=LOAD
[1614706.527657] audit: type=1334 audit(1667320169.704:83848): prog-id=21914 op=LOAD
[1614706.845830] audit: type=1130 audit(1667320170.022:83849): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614783.744424] audit: type=1131 audit(1667320246.922:83850): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1614784.025955] audit: type=1130 audit(1667320247.204:83851): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614784.025959] audit: type=1131 audit(1667320247.204:83852): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614784.026203] audit: type=1334 audit(1667320247.204:83853): prog-id=21913 op=UNLOAD
[1614784.026205] audit: type=1334 audit(1667320247.204:83854): prog-id=21914 op=UNLOAD
[1614784.026332] audit: type=1334 audit(1667320247.204:83855): prog-id=21915 op=LOAD
[1614784.026383] audit: type=1334 audit(1667320247.204:83856): prog-id=21916 op=LOAD
[1614786.759420] audit: type=1130 audit(1667320249.937:83857): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614859.554224] audit: type=1131 audit(1667320322.733:83858): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1614859.774693] audit: type=1130 audit(1667320322.953:83859): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614859.774697] audit: type=1131 audit(1667320322.953:83860): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614859.774934] audit: type=1334 audit(1667320322.954:83861): prog-id=21915 op=UNLOAD
[1614859.774935] audit: type=1334 audit(1667320322.954:83862): prog-id=21916 op=UNLOAD
[1614859.775070] audit: type=1334 audit(1667320322.954:83863): prog-id=21917 op=LOAD
[1614859.775124] audit: type=1334 audit(1667320322.954:83864): prog-id=21918 op=LOAD
[1614860.534087] audit: type=1130 audit(1667320323.713:83865): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614936.774282] audit: type=1131 audit(1667320399.954:83866): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1614937.023376] audit: type=1130 audit(1667320400.204:83867): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614937.023380] audit: type=1131 audit(1667320400.204:83868): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1614937.023743] audit: type=1334 audit(1667320400.204:83869): prog-id=21917 op=UNLOAD
[1614937.023746] audit: type=1334 audit(1667320400.204:83870): prog-id=21918 op=UNLOAD
[1614937.023874] audit: type=1334 audit(1667320400.204:83871): prog-id=21919 op=LOAD
[1614937.023927] audit: type=1334 audit(1667320400.204:83872): prog-id=21920 op=LOAD
[1614937.178167] audit: type=1130 audit(1667320400.358:83873): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615011.363951] audit: type=1131 audit(1667320474.545:83874): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1615011.522122] audit: type=1130 audit(1667320474.703:83875): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615011.522126] audit: type=1131 audit(1667320474.703:83876): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615011.522371] audit: type=1334 audit(1667320474.704:83877): prog-id=21919 op=UNLOAD
[1615011.522376] audit: type=1334 audit(1667320474.704:83878): prog-id=21920 op=UNLOAD
[1615011.522506] audit: type=1334 audit(1667320474.704:83879): prog-id=21921 op=LOAD
[1615011.522560] audit: type=1334 audit(1667320474.704:83880): prog-id=21922 op=LOAD
[1615011.830693] audit: type=1130 audit(1667320475.012:83881): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615084.587215] audit: type=1131 audit(1667320547.770:83882): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1615084.770889] audit: type=1130 audit(1667320547.953:83883): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615084.770895] audit: type=1131 audit(1667320547.953:83884): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615084.771146] audit: type=1334 audit(1667320547.954:83885): prog-id=21921 op=UNLOAD
[1615084.771150] audit: type=1334 audit(1667320547.954:83886): prog-id=21922 op=UNLOAD
[1615084.771263] audit: type=1334 audit(1667320547.954:83887): prog-id=21923 op=LOAD
[1615084.771315] audit: type=1334 audit(1667320547.954:83888): prog-id=21924 op=LOAD
[1615085.199611] audit: type=1130 audit(1667320548.382:83889): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615157.437813] audit: type=1131 audit(1667320620.622:83890): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1615157.769673] audit: type=1130 audit(1667320620.953:83891): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615157.769679] audit: type=1131 audit(1667320620.953:83892): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615157.769938] audit: type=1334 audit(1667320620.954:83893): prog-id=21923 op=UNLOAD
[1615157.769943] audit: type=1334 audit(1667320620.954:83894): prog-id=21924 op=UNLOAD
[1615157.770067] audit: type=1334 audit(1667320620.954:83895): prog-id=21925 op=LOAD
[1615157.770120] audit: type=1334 audit(1667320620.954:83896): prog-id=21926 op=LOAD
[1615158.716159] audit: type=1130 audit(1667320621.900:83897): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615231.227883] audit: type=1131 audit(1667320694.413:83898): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1615231.518502] audit: type=1130 audit(1667320694.704:83899): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615231.518515] audit: type=1131 audit(1667320694.704:83900): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615231.518800] audit: type=1334 audit(1667320694.704:83901): prog-id=21925 op=UNLOAD
[1615231.518806] audit: type=1334 audit(1667320694.704:83902): prog-id=21926 op=UNLOAD
[1615231.518935] audit: type=1334 audit(1667320694.704:83903): prog-id=21927 op=LOAD
[1615231.518989] audit: type=1334 audit(1667320694.704:83904): prog-id=21928 op=LOAD
[1615231.946500] audit: type=1130 audit(1667320695.131:83905): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615305.531211] audit: type=1131 audit(1667320768.717:83906): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1615305.767338] audit: type=1130 audit(1667320768.954:83907): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615305.767345] audit: type=1131 audit(1667320768.954:83908): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615305.767736] audit: type=1334 audit(1667320768.954:83909): prog-id=21927 op=UNLOAD
[1615305.767738] audit: type=1334 audit(1667320768.954:83910): prog-id=21928 op=UNLOAD
[1615305.767899] audit: type=1334 audit(1667320768.954:83911): prog-id=21929 op=LOAD
[1615305.767953] audit: type=1334 audit(1667320768.954:83912): prog-id=21930 op=LOAD
[1615305.978150] audit: type=1130 audit(1667320769.164:83913): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615381.878700] audit: type=1131 audit(1667320845.066:83914): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1615382.015934] audit: type=1130 audit(1667320845.203:83915): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615382.015941] audit: type=1131 audit(1667320845.203:83916): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615382.016278] audit: type=1334 audit(1667320845.204:83917): prog-id=21929 op=UNLOAD
[1615382.016280] audit: type=1334 audit(1667320845.204:83918): prog-id=21930 op=UNLOAD
[1615382.016414] audit: type=1334 audit(1667320845.204:83919): prog-id=21931 op=LOAD
[1615382.016467] audit: type=1334 audit(1667320845.204:83920): prog-id=21932 op=LOAD
[1615382.150404] audit: type=1130 audit(1667320845.338:83921): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615458.179273] audit: type=1131 audit(1667320921.369:83922): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1615458.514595] audit: type=1130 audit(1667320921.704:83923): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615458.514600] audit: type=1131 audit(1667320921.704:83924): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615458.514869] audit: type=1334 audit(1667320921.705:83925): prog-id=21931 op=UNLOAD
[1615458.514872] audit: type=1334 audit(1667320921.705:83926): prog-id=21932 op=UNLOAD
[1615458.515007] audit: type=1334 audit(1667320921.705:83927): prog-id=21933 op=LOAD
[1615458.515060] audit: type=1334 audit(1667320921.705:83928): prog-id=21934 op=LOAD
[1615465.013680] audit: type=1130 audit(1667320928.203:83929): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615530.371258] audit: type=1131 audit(1667320993.561:83930): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1615530.513336] audit: type=1130 audit(1667320993.704:83931): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615530.513340] audit: type=1131 audit(1667320993.704:83932): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615530.513598] audit: type=1334 audit(1667320993.704:83933): prog-id=21933 op=UNLOAD
[1615530.513601] audit: type=1334 audit(1667320993.704:83934): prog-id=21934 op=UNLOAD
[1615530.513753] audit: type=1334 audit(1667320993.704:83935): prog-id=21935 op=LOAD
[1615530.513809] audit: type=1334 audit(1667320993.704:83936): prog-id=21936 op=LOAD
[1615530.779973] audit: type=1130 audit(1667320993.970:83937): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615606.256699] audit: type=1131 audit(1667321069.448:83938): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1615606.512063] audit: type=1130 audit(1667321069.703:83939): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615606.512068] audit: type=1131 audit(1667321069.703:83940): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615606.512311] audit: type=1334 audit(1667321069.704:83941): prog-id=21935 op=UNLOAD
[1615606.512314] audit: type=1334 audit(1667321069.704:83942): prog-id=21936 op=UNLOAD
[1615606.512586] audit: type=1334 audit(1667321069.704:83943): prog-id=21937 op=LOAD
[1615606.512641] audit: type=1334 audit(1667321069.704:83944): prog-id=21938 op=LOAD
[1615610.668796] audit: type=1130 audit(1667321073.860:83945): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615682.550113] audit: type=1131 audit(1667321145.743:83946): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1615682.760773] audit: type=1130 audit(1667321145.953:83947): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615682.760777] audit: type=1131 audit(1667321145.953:83948): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615682.761026] audit: type=1334 audit(1667321145.954:83949): prog-id=21937 op=UNLOAD
[1615682.761028] audit: type=1334 audit(1667321145.954:83950): prog-id=21938 op=UNLOAD
[1615682.761191] audit: type=1334 audit(1667321145.954:83951): prog-id=21939 op=LOAD
[1615682.761244] audit: type=1334 audit(1667321145.954:83952): prog-id=21940 op=LOAD
[1615683.850801] audit: type=1130 audit(1667321147.043:83953): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615711.575815] audit: type=1333 audit(1667321174.769:83954): op=offset old=-72897138781 new=-2676735288016
[1615711.575819] audit: type=1333 audit(1667321174.769:83954): op=freq old=73735639184955 new=73082139358779
[1615711.575821] audit: type=1300 audit(1667321174.769:83954): arch=c000003e syscall=305 success=yes exit=0 a0=0 a1=7fff67695dd0 a2=7 a3=0 items=0 ppid=1 pid=2490 auid=4294967295 uid=154 gid=154 euid=154 suid=154 fsuid=154 egid=154 sgid=154 fsgid=154 tty=(none) ses=4294967295 comm="systemd-timesyn" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd-timesyncd" subj=kernel key=(null)
[1615711.575823] audit: type=1327 audit(1667321174.769:83954): proctitle="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd-timesyncd"
[1615757.404207] audit: type=1131 audit(1667321220.598:83955): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1615757.509551] audit: type=1130 audit(1667321220.704:83956): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615757.509555] audit: type=1131 audit(1667321220.704:83957): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615757.509804] audit: type=1334 audit(1667321220.704:83958): prog-id=21939 op=UNLOAD
[1615757.509806] audit: type=1334 audit(1667321220.704:83959): prog-id=21940 op=UNLOAD
[1615757.509931] audit: type=1334 audit(1667321220.704:83960): prog-id=21941 op=LOAD
[1615757.509984] audit: type=1334 audit(1667321220.704:83961): prog-id=21942 op=LOAD
[1615758.080881] audit: type=1130 audit(1667321221.275:83962): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615823.215271] BTRFS info (device dm-0): disk added /dev/mapper/cryptsdc2
[1615823.235683] BTRFS info (device dm-0): devid 4 device path /dev/mapper/cryptsdc2 changed to /dev/dm-4 scanned by systemd-udevd (1049195)
[1615846.429336] audit: type=1131 audit(1667321309.625:83963): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1615846.758144] audit: type=1130 audit(1667321309.953:83964): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615846.758148] audit: type=1131 audit(1667321309.953:83965): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615846.758416] audit: type=1334 audit(1667321309.954:83966): prog-id=21941 op=UNLOAD
[1615846.758419] audit: type=1334 audit(1667321309.954:83967): prog-id=21942 op=UNLOAD
[1615846.758577] audit: type=1334 audit(1667321309.954:83968): prog-id=21943 op=LOAD
[1615846.758633] audit: type=1334 audit(1667321309.954:83969): prog-id=21944 op=LOAD
[1615847.882809] audit: type=1130 audit(1667321311.078:83970): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615882.303234] BTRFS info (device dm-0): relocating block group 10086775783424 flags data
[1615882.529203] ata4.00: exception Emask 0x0 SAct 0x40000 SErr 0xc0000 action 0x0
[1615882.529209] ata4.00: irq_stat 0x40000008
[1615882.529210] ata4: SError: { CommWake 10B8B }
[1615882.529212] ata4.00: failed command: READ FPDMA QUEUED
[1615882.529214] ata4.00: cmd 60/d0:90:c0:f6:3f/02:00:db:00:00/40 tag 18 ncq dma 368640 in
                          res 43/40:d0:68:f7:3f/00:02:db:00:00/00 Emask 0x409 (media error) <F>
[1615882.529218] ata4.00: status: { DRDY SENSE ERR }
[1615882.529219] ata4.00: error: { UNC }
[1615882.626531] ata4.00: configured for UDMA/133
[1615882.626540] sd 3:0:0:0: [sdb] tag#18 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
[1615882.626542] sd 3:0:0:0: [sdb] tag#18 Sense Key : Medium Error [current] 
[1615882.626544] sd 3:0:0:0: [sdb] tag#18 Add. Sense: Unrecovered read error - auto reallocate failed
[1615882.626546] sd 3:0:0:0: [sdb] tag#18 CDB: Read(10) 28 00 db 3f f6 c0 00 02 d0 00
[1615882.626546] blk_update_request: I/O error, dev sdb, sector 3678402408 op 0x0:(READ) flags 0x80700 phys_seg 69 prio class 0
[1615882.626555] ata4: EH complete
[1615882.708944] ata4.00: exception Emask 0x0 SAct 0x2000 SErr 0x0 action 0x0
[1615882.708947] ata4.00: irq_stat 0x40000008
[1615882.708948] ata4.00: failed command: READ FPDMA QUEUED
[1615882.708950] ata4.00: cmd 60/08:68:68:f7:3f/00:00:db:00:00/40 tag 13 ncq dma 4096 in
                          res 43/40:08:68:f7:3f/00:00:db:00:00/00 Emask 0x409 (media error) <F>
[1615882.708954] ata4.00: status: { DRDY SENSE ERR }
[1615882.708955] ata4.00: error: { UNC }
[1615882.809253] ata4.00: configured for UDMA/133
[1615882.809258] sd 3:0:0:0: [sdb] tag#13 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
[1615882.809259] sd 3:0:0:0: [sdb] tag#13 Sense Key : Medium Error [current] 
[1615882.809260] sd 3:0:0:0: [sdb] tag#13 Add. Sense: Unrecovered read error - auto reallocate failed
[1615882.809262] sd 3:0:0:0: [sdb] tag#13 CDB: Read(10) 28 00 db 3f f7 68 00 00 08 00
[1615882.809262] blk_update_request: I/O error, dev sdb, sector 3678402408 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[1615882.809267] ata4: EH complete
[1615882.809324] BTRFS error (device dm-0): bdev /dev/dm-5 errs: wr 0, rd 395, flush 0, corrupt 0, gen 0
[1615922.318381] audit: type=1131 audit(1667321385.515:83971): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1615922.506989] audit: type=1130 audit(1667321385.703:83972): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615922.506993] audit: type=1131 audit(1667321385.703:83973): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1615922.507279] audit: type=1334 audit(1667321385.704:83974): prog-id=21943 op=UNLOAD
[1615922.507286] audit: type=1334 audit(1667321385.704:83975): prog-id=21944 op=UNLOAD
[1615922.507425] audit: type=1334 audit(1667321385.704:83976): prog-id=21945 op=LOAD
[1615922.507477] audit: type=1334 audit(1667321385.704:83977): prog-id=21946 op=LOAD
[1615924.965702] audit: type=1130 audit(1667321388.162:83978): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616006.310561] audit: type=1131 audit(1667321469.508:83979): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1616006.505798] audit: type=1130 audit(1667321469.704:83980): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616006.505804] audit: type=1131 audit(1667321469.704:83981): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616006.506151] audit: type=1334 audit(1667321469.704:83982): prog-id=21945 op=UNLOAD
[1616006.506157] audit: type=1334 audit(1667321469.704:83983): prog-id=21946 op=UNLOAD
[1616006.506315] audit: type=1334 audit(1667321469.704:83984): prog-id=21947 op=LOAD
[1616006.506371] audit: type=1334 audit(1667321469.704:83985): prog-id=21948 op=LOAD
[1616007.266711] audit: type=1130 audit(1667321470.465:83986): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616091.548063] audit: type=1131 audit(1667321554.747:83987): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1616091.754208] audit: type=1130 audit(1667321554.953:83988): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616091.754214] audit: type=1131 audit(1667321554.953:83989): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616091.754459] audit: type=1334 audit(1667321554.954:83990): prog-id=21947 op=UNLOAD
[1616091.754463] audit: type=1334 audit(1667321554.954:83991): prog-id=21948 op=UNLOAD
[1616091.754591] audit: type=1334 audit(1667321554.954:83992): prog-id=21949 op=LOAD
[1616091.754646] audit: type=1334 audit(1667321554.954:83993): prog-id=21950 op=LOAD
[1616092.126627] audit: type=1130 audit(1667321555.326:83994): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616165.477667] audit: type=1131 audit(1667321628.678:83995): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1616165.753142] audit: type=1130 audit(1667321628.954:83996): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616165.753147] audit: type=1131 audit(1667321628.954:83997): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616165.753462] audit: type=1334 audit(1667321628.954:83998): prog-id=21949 op=UNLOAD
[1616165.753467] audit: type=1334 audit(1667321628.954:83999): prog-id=21950 op=UNLOAD
[1616165.753599] audit: type=1334 audit(1667321628.954:84000): prog-id=21951 op=LOAD
[1616165.753652] audit: type=1334 audit(1667321628.954:84001): prog-id=21952 op=LOAD
[1616165.941553] audit: type=1130 audit(1667321629.142:84002): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616240.280001] audit: type=1131 audit(1667321703.483:84003): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1616240.501789] audit: type=1130 audit(1667321703.704:84004): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616240.501792] audit: type=1131 audit(1667321703.704:84005): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616240.502043] audit: type=1334 audit(1667321703.705:84006): prog-id=21951 op=UNLOAD
[1616240.502049] audit: type=1334 audit(1667321703.705:84007): prog-id=21952 op=UNLOAD
[1616240.502187] audit: type=1334 audit(1667321703.705:84008): prog-id=21953 op=LOAD
[1616240.502240] audit: type=1334 audit(1667321703.705:84009): prog-id=21954 op=LOAD
[1616240.656282] audit: type=1130 audit(1667321703.859:84010): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616315.616029] audit: type=1131 audit(1667321778.819:84011): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1616315.750549] audit: type=1130 audit(1667321778.953:84012): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616315.750553] audit: type=1131 audit(1667321778.953:84013): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616315.750797] audit: type=1334 audit(1667321778.954:84014): prog-id=21953 op=UNLOAD
[1616315.750802] audit: type=1334 audit(1667321778.954:84015): prog-id=21954 op=UNLOAD
[1616315.750929] audit: type=1334 audit(1667321778.954:84016): prog-id=21955 op=LOAD
[1616315.750982] audit: type=1334 audit(1667321778.954:84017): prog-id=21956 op=LOAD
[1616329.042475] audit: type=1130 audit(1667321792.246:84018): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616391.955974] audit: type=1131 audit(1667321855.160:84019): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1616392.249437] audit: type=1130 audit(1667321855.454:84020): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616392.249442] audit: type=1131 audit(1667321855.454:84021): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616392.249742] audit: type=1334 audit(1667321855.454:84022): prog-id=21955 op=UNLOAD
[1616392.249748] audit: type=1334 audit(1667321855.454:84023): prog-id=21956 op=UNLOAD
[1616392.249895] audit: type=1334 audit(1667321855.454:84024): prog-id=21957 op=LOAD
[1616392.249948] audit: type=1334 audit(1667321855.454:84025): prog-id=21958 op=LOAD
[1616395.876595] audit: type=1130 audit(1667321859.081:84026): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616467.479100] audit: type=1131 audit(1667321930.684:84027): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1616467.748196] audit: type=1130 audit(1667321930.954:84028): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616467.748202] audit: type=1131 audit(1667321930.954:84029): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616467.748539] audit: type=1334 audit(1667321930.954:84030): prog-id=21957 op=UNLOAD
[1616467.748546] audit: type=1334 audit(1667321930.954:84031): prog-id=21958 op=UNLOAD
[1616467.748694] audit: type=1334 audit(1667321930.954:84032): prog-id=21959 op=LOAD
[1616467.748766] audit: type=1334 audit(1667321930.954:84033): prog-id=21960 op=LOAD
[1616468.407475] audit: type=1130 audit(1667321931.613:84034): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616543.871217] audit: type=1131 audit(1667322007.078:84035): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1616543.872023] audit: type=1334 audit(1667322007.079:84036): prog-id=21875 op=UNLOAD
[1616543.872027] audit: type=1334 audit(1667322007.079:84037): prog-id=21876 op=UNLOAD
[1616543.872186] audit: type=1334 audit(1667322007.079:84038): prog-id=21961 op=LOAD
[1616543.872239] audit: type=1334 audit(1667322007.079:84039): prog-id=21962 op=LOAD
[1616543.872901] audit: type=1130 audit(1667322007.080:84040): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=update-locatedb comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616543.996760] audit: type=1130 audit(1667322007.204:84041): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616543.996764] audit: type=1131 audit(1667322007.204:84042): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616543.996978] audit: type=1334 audit(1667322007.204:84043): prog-id=21959 op=UNLOAD
[1616543.996981] audit: type=1334 audit(1667322007.204:84044): prog-id=21960 op=UNLOAD
[1616563.806208] kauditd_printk_skb: 3 callbacks suppressed
[1616563.806212] audit: type=1131 audit(1667322027.013:84048): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=update-locatedb comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616623.521826] audit: type=1131 audit(1667322086.730:84049): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1616623.745660] audit: type=1130 audit(1667322086.954:84050): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616623.745665] audit: type=1131 audit(1667322086.954:84051): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616623.745933] audit: type=1334 audit(1667322086.954:84052): prog-id=21963 op=UNLOAD
[1616623.745935] audit: type=1334 audit(1667322086.954:84053): prog-id=21964 op=UNLOAD
[1616623.746063] audit: type=1334 audit(1667322086.954:84054): prog-id=21965 op=LOAD
[1616623.746113] audit: type=1334 audit(1667322086.954:84055): prog-id=21966 op=LOAD
[1616623.943432] audit: type=1130 audit(1667322087.151:84056): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616703.358180] audit: type=1131 audit(1667322166.567:84057): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1616703.494264] audit: type=1130 audit(1667322166.704:84058): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616703.494269] audit: type=1131 audit(1667322166.704:84059): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616703.494558] audit: type=1334 audit(1667322166.704:84060): prog-id=21965 op=UNLOAD
[1616703.494565] audit: type=1334 audit(1667322166.704:84061): prog-id=21966 op=UNLOAD
[1616703.494687] audit: type=1334 audit(1667322166.704:84062): prog-id=21967 op=LOAD
[1616703.494739] audit: type=1334 audit(1667322166.704:84063): prog-id=21968 op=LOAD
[1616703.631166] audit: type=1130 audit(1667322166.840:84064): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616786.300979] audit: type=1131 audit(1667322249.512:84065): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1616786.492729] audit: type=1130 audit(1667322249.704:84066): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616786.492734] audit: type=1131 audit(1667322249.704:84067): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616786.492978] audit: type=1334 audit(1667322249.704:84068): prog-id=21967 op=UNLOAD
[1616786.492983] audit: type=1334 audit(1667322249.704:84069): prog-id=21968 op=UNLOAD
[1616786.493125] audit: type=1334 audit(1667322249.704:84070): prog-id=21969 op=LOAD
[1616786.493178] audit: type=1334 audit(1667322249.704:84071): prog-id=21970 op=LOAD
[1616787.989225] audit: type=1130 audit(1667322251.200:84072): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616867.565604] audit: type=1131 audit(1667322330.778:84073): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1616867.741390] audit: type=1130 audit(1667322330.953:84074): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616867.741393] audit: type=1131 audit(1667322330.953:84075): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616867.741633] audit: type=1334 audit(1667322330.954:84076): prog-id=21969 op=UNLOAD
[1616867.741638] audit: type=1334 audit(1667322330.954:84077): prog-id=21970 op=UNLOAD
[1616867.741755] audit: type=1334 audit(1667322330.954:84078): prog-id=21971 op=LOAD
[1616867.741807] audit: type=1334 audit(1667322330.954:84079): prog-id=21972 op=LOAD
[1616874.965633] audit: type=1130 audit(1667322338.178:84080): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616957.868666] audit: type=1131 audit(1667322421.082:84081): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1616957.989895] audit: type=1130 audit(1667322421.203:84082): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616957.989899] audit: type=1131 audit(1667322421.203:84083): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1616957.990164] audit: type=1334 audit(1667322421.204:84084): prog-id=21971 op=UNLOAD
[1616957.990169] audit: type=1334 audit(1667322421.204:84085): prog-id=21972 op=UNLOAD
[1616957.990312] audit: type=1334 audit(1667322421.204:84086): prog-id=21973 op=LOAD
[1616957.990364] audit: type=1334 audit(1667322421.204:84087): prog-id=21974 op=LOAD
[1616960.710147] audit: type=1130 audit(1667322423.924:84088): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1617067.618191] audit: type=1131 audit(1667322530.834:84089): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1617067.738146] audit: type=1130 audit(1667322530.953:84090): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1617067.738150] audit: type=1131 audit(1667322530.954:84091): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1617067.738439] audit: type=1334 audit(1667322530.954:84092): prog-id=21973 op=UNLOAD
[1617067.738445] audit: type=1334 audit(1667322530.954:84093): prog-id=21974 op=UNLOAD
[1617067.738562] audit: type=1334 audit(1667322530.954:84094): prog-id=21975 op=LOAD
[1617067.738618] audit: type=1334 audit(1667322530.954:84095): prog-id=21976 op=LOAD
[1617078.901207] audit: type=1130 audit(1667322542.117:84096): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1617172.589469] audit: type=1131 audit(1667322635.807:84097): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1617172.736313] audit: type=1130 audit(1667322635.953:84098): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1617172.736317] audit: type=1131 audit(1667322635.953:84099): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1617172.736641] audit: type=1334 audit(1667322635.954:84100): prog-id=21975 op=UNLOAD
[1617172.736643] audit: type=1334 audit(1667322635.954:84101): prog-id=21976 op=UNLOAD
[1617172.736809] audit: type=1334 audit(1667322635.954:84102): prog-id=21977 op=LOAD
[1617172.736883] audit: type=1334 audit(1667322635.954:84103): prog-id=21978 op=LOAD
[1617184.553691] audit: type=1130 audit(1667322647.771:84104): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1617279.302222] audit: type=1131 audit(1667322742.521:84105): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1617279.484580] audit: type=1130 audit(1667322742.703:84106): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1617279.484585] audit: type=1131 audit(1667322742.703:84107): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1617279.484866] audit: type=1334 audit(1667322742.704:84108): prog-id=21977 op=UNLOAD
[1617279.484869] audit: type=1334 audit(1667322742.704:84109): prog-id=21978 op=UNLOAD
[1617279.485026] audit: type=1334 audit(1667322742.704:84110): prog-id=21979 op=LOAD
[1617279.485096] audit: type=1334 audit(1667322742.704:84111): prog-id=21980 op=LOAD
[1617284.159414] audit: type=1130 audit(1667322747.378:84112): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1617390.787243] audit: type=1131 audit(1667322854.008:84113): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1617390.982659] audit: type=1130 audit(1667322854.203:84114): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1617390.982664] audit: type=1131 audit(1667322854.203:84115): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1617390.982930] audit: type=1334 audit(1667322854.204:84116): prog-id=21979 op=UNLOAD
[1617390.982933] audit: type=1334 audit(1667322854.204:84117): prog-id=21980 op=UNLOAD
[1617390.983072] audit: type=1334 audit(1667322854.204:84118): prog-id=21981 op=LOAD
[1617390.983127] audit: type=1334 audit(1667322854.204:84119): prog-id=21982 op=LOAD
[1617402.595792] audit: type=1130 audit(1667322865.817:84120): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1617503.694005] audit: type=1131 audit(1667322966.917:84121): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1617503.980802] audit: type=1130 audit(1667322967.204:84122): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1617503.980807] audit: type=1131 audit(1667322967.204:84123): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1617503.981100] audit: type=1334 audit(1667322967.204:84124): prog-id=21981 op=UNLOAD
[1617503.981102] audit: type=1334 audit(1667322967.204:84125): prog-id=21982 op=UNLOAD
[1617503.981235] audit: type=1334 audit(1667322967.204:84126): prog-id=21983 op=LOAD
[1617503.981293] audit: type=1334 audit(1667322967.204:84127): prog-id=21984 op=LOAD
[1617515.200911] audit: type=1130 audit(1667322978.424:84128): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1617614.728066] audit: type=1131 audit(1667323077.953:84129): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1617614.978865] audit: type=1130 audit(1667323078.203:84130): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1617614.978869] audit: type=1131 audit(1667323078.203:84131): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1617614.979120] audit: type=1334 audit(1667323078.204:84132): prog-id=21983 op=UNLOAD
[1617614.979122] audit: type=1334 audit(1667323078.204:84133): prog-id=21984 op=UNLOAD
[1617614.979261] audit: type=1334 audit(1667323078.204:84134): prog-id=21985 op=LOAD
[1617614.979314] audit: type=1334 audit(1667323078.204:84135): prog-id=21986 op=LOAD
[1617615.397066] audit: type=1130 audit(1667323078.622:84136): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1617727.286728] audit: type=1131 audit(1667323190.513:84137): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1617727.476979] audit: type=1130 audit(1667323190.704:84138): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1617727.476982] audit: type=1131 audit(1667323190.704:84139): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1617727.477218] audit: type=1334 audit(1667323190.704:84140): prog-id=21985 op=UNLOAD
[1617727.477224] audit: type=1334 audit(1667323190.704:84141): prog-id=21986 op=UNLOAD
[1617727.477365] audit: type=1334 audit(1667323190.704:84142): prog-id=21987 op=LOAD
[1617727.477419] audit: type=1334 audit(1667323190.704:84143): prog-id=21988 op=LOAD
[1617732.881156] audit: type=1130 audit(1667323196.108:84144): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1617759.792111] audit: type=1333 audit(1667323223.019:84145): op=offset old=-48739353379 new=-1851388602613
[1617759.792117] audit: type=1333 audit(1667323223.019:84145): op=freq old=73082139358779 new=72404250900443
[1617759.792119] audit: type=1333 audit(1667323223.019:84145): op=status old=8193 new=24577
[1617759.792120] audit: type=1300 audit(1667323223.019:84145): arch=c000003e syscall=305 success=yes exit=0 a0=0 a1=7fff67695dd0 a2=7 a3=0 items=0 ppid=1 pid=2490 auid=4294967295 uid=154 gid=154 euid=154 suid=154 fsuid=154 egid=154 sgid=154 fsgid=154 tty=(none) ses=4294967295 comm="systemd-timesyn" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd-timesyncd" subj=kernel key=(null)
[1617759.792123] audit: type=1327 audit(1667323223.019:84145): proctitle="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd-timesyncd"
[1617823.982558] audit: type=1131 audit(1667323287.211:84146): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1617824.225474] audit: type=1130 audit(1667323287.453:84147): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1617824.225478] audit: type=1131 audit(1667323287.453:84148): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1617824.225761] audit: type=1334 audit(1667323287.454:84149): prog-id=21987 op=UNLOAD
[1617824.225763] audit: type=1334 audit(1667323287.454:84150): prog-id=21988 op=UNLOAD
[1617824.225905] audit: type=1334 audit(1667323287.454:84151): prog-id=21989 op=LOAD
[1617824.225960] audit: type=1334 audit(1667323287.454:84152): prog-id=21990 op=LOAD
[1617830.762288] audit: type=1130 audit(1667323293.990:84153): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1617917.576794] audit: type=1131 audit(1667323380.806:84154): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1617917.723904] audit: type=1130 audit(1667323380.953:84155): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1617917.723908] audit: type=1131 audit(1667323380.953:84156): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1617917.724144] audit: type=1334 audit(1667323380.954:84157): prog-id=21989 op=UNLOAD
[1617917.724149] audit: type=1334 audit(1667323380.954:84158): prog-id=21990 op=UNLOAD
[1617917.724277] audit: type=1334 audit(1667323380.954:84159): prog-id=21991 op=LOAD
[1617917.724331] audit: type=1334 audit(1667323380.954:84160): prog-id=21992 op=LOAD
[1617919.847200] audit: type=1130 audit(1667323383.077:84161): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618010.284266] audit: type=1131 audit(1667323473.515:84162): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1618010.472431] audit: type=1130 audit(1667323473.703:84163): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618010.472434] audit: type=1131 audit(1667323473.703:84164): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618010.472685] audit: type=1334 audit(1667323473.704:84165): prog-id=21991 op=UNLOAD
[1618010.472690] audit: type=1334 audit(1667323473.704:84166): prog-id=21992 op=UNLOAD
[1618010.472820] audit: type=1334 audit(1667323473.704:84167): prog-id=21993 op=LOAD
[1618010.472880] audit: type=1334 audit(1667323473.704:84168): prog-id=21994 op=LOAD
[1618015.726701] audit: type=1130 audit(1667323478.958:84169): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618101.297455] audit: type=1131 audit(1667323564.530:84170): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1618101.470930] audit: type=1130 audit(1667323564.704:84171): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618101.470934] audit: type=1131 audit(1667323564.704:84172): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618101.471170] audit: type=1334 audit(1667323564.704:84173): prog-id=21993 op=UNLOAD
[1618101.471174] audit: type=1334 audit(1667323564.704:84174): prog-id=21994 op=UNLOAD
[1618101.471277] audit: type=1334 audit(1667323564.704:84175): prog-id=21995 op=LOAD
[1618101.471330] audit: type=1334 audit(1667323564.704:84176): prog-id=21996 op=LOAD
[1618105.339475] audit: type=1130 audit(1667323568.572:84177): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618195.388982] audit: type=1131 audit(1667323658.623:84178): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1618195.719511] audit: type=1130 audit(1667323658.953:84179): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618195.719521] audit: type=1131 audit(1667323658.954:84180): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618195.719814] audit: type=1334 audit(1667323658.954:84181): prog-id=21995 op=UNLOAD
[1618195.719818] audit: type=1334 audit(1667323658.954:84182): prog-id=21996 op=UNLOAD
[1618195.719951] audit: type=1334 audit(1667323658.954:84183): prog-id=21997 op=LOAD
[1618195.720006] audit: type=1334 audit(1667323658.954:84184): prog-id=21998 op=LOAD
[1618196.895639] audit: type=1130 audit(1667323660.130:84185): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618265.953878] BTRFS info (device dm-0): relocating block group 10086775783424 flags data
[1618266.137879] ata4.00: exception Emask 0x0 SAct 0x40000000 SErr 0xc0000 action 0x0
[1618266.137886] ata4.00: irq_stat 0x40000008
[1618266.137887] ata4: SError: { CommWake 10B8B }
[1618266.137890] ata4.00: failed command: READ FPDMA QUEUED
[1618266.137891] ata4.00: cmd 60/d0:f0:c0:f6:3f/02:00:db:00:00/40 tag 30 ncq dma 368640 in
                          res 43/40:d0:68:f7:3f/00:02:db:00:00/00 Emask 0x409 (media error) <F>
[1618266.137896] ata4.00: status: { DRDY SENSE ERR }
[1618266.137897] ata4.00: error: { UNC }
[1618266.235358] ata4.00: configured for UDMA/133
[1618266.235366] sd 3:0:0:0: [sdb] tag#30 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
[1618266.235368] sd 3:0:0:0: [sdb] tag#30 Sense Key : Medium Error [current] 
[1618266.235370] sd 3:0:0:0: [sdb] tag#30 Add. Sense: Unrecovered read error - auto reallocate failed
[1618266.235371] sd 3:0:0:0: [sdb] tag#30 CDB: Read(10) 28 00 db 3f f6 c0 00 02 d0 00
[1618266.235372] blk_update_request: I/O error, dev sdb, sector 3678402408 op 0x0:(READ) flags 0x80700 phys_seg 69 prio class 0
[1618266.235382] ata4: EH complete
[1618266.317625] ata4.00: exception Emask 0x0 SAct 0x200000 SErr 0x0 action 0x0
[1618266.317629] ata4.00: irq_stat 0x40000008
[1618266.317630] ata4.00: failed command: READ FPDMA QUEUED
[1618266.317632] ata4.00: cmd 60/08:a8:68:f7:3f/00:00:db:00:00/40 tag 21 ncq dma 4096 in
                          res 43/40:08:68:f7:3f/00:00:db:00:00/00 Emask 0x409 (media error) <F>
[1618266.317636] ata4.00: status: { DRDY SENSE ERR }
[1618266.317637] ata4.00: error: { UNC }
[1618266.418097] ata4.00: configured for UDMA/133
[1618266.418103] sd 3:0:0:0: [sdb] tag#21 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
[1618266.418105] sd 3:0:0:0: [sdb] tag#21 Sense Key : Medium Error [current] 
[1618266.418106] sd 3:0:0:0: [sdb] tag#21 Add. Sense: Unrecovered read error - auto reallocate failed
[1618266.418107] sd 3:0:0:0: [sdb] tag#21 CDB: Read(10) 28 00 db 3f f7 68 00 00 08 00
[1618266.418108] blk_update_request: I/O error, dev sdb, sector 3678402408 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[1618266.418113] BTRFS error (device dm-0): bdev /dev/dm-5 errs: wr 0, rd 396, flush 0, corrupt 0, gen 0
[1618266.418120] ata4: EH complete
[1618298.772835] audit: type=1131 audit(1667323762.008:84186): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1618298.967823] audit: type=1130 audit(1667323762.203:84187): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618298.967828] audit: type=1131 audit(1667323762.203:84188): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618298.968111] audit: type=1334 audit(1667323762.204:84189): prog-id=21997 op=UNLOAD
[1618298.968115] audit: type=1334 audit(1667323762.204:84190): prog-id=21998 op=UNLOAD
[1618298.968233] audit: type=1334 audit(1667323762.204:84191): prog-id=21999 op=LOAD
[1618298.968296] audit: type=1334 audit(1667323762.204:84192): prog-id=22000 op=LOAD
[1618302.969241] audit: type=1130 audit(1667323766.205:84193): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618400.692637] audit: type=1131 audit(1667323863.930:84194): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1618400.966103] audit: type=1130 audit(1667323864.203:84195): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618400.966107] audit: type=1131 audit(1667323864.203:84196): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618400.966395] audit: type=1334 audit(1667323864.204:84197): prog-id=21999 op=UNLOAD
[1618400.966397] audit: type=1334 audit(1667323864.204:84198): prog-id=22000 op=UNLOAD
[1618400.966534] audit: type=1334 audit(1667323864.204:84199): prog-id=22001 op=LOAD
[1618400.966585] audit: type=1334 audit(1667323864.204:84200): prog-id=22002 op=LOAD
[1618404.546224] audit: type=1130 audit(1667323867.784:84201): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618503.379729] audit: type=1131 audit(1667323966.620:84202): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1618503.714364] audit: type=1130 audit(1667323966.954:84203): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618503.714368] audit: type=1131 audit(1667323966.954:84204): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618503.714604] audit: type=1334 audit(1667323966.955:84205): prog-id=22001 op=UNLOAD
[1618503.714607] audit: type=1334 audit(1667323966.955:84206): prog-id=22002 op=UNLOAD
[1618503.714731] audit: type=1334 audit(1667323966.955:84207): prog-id=22003 op=LOAD
[1618503.714783] audit: type=1334 audit(1667323966.955:84208): prog-id=22004 op=LOAD
[1618507.378365] audit: type=1130 audit(1667323970.617:84209): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618603.676702] audit: type=1131 audit(1667324066.917:84210): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1618603.962707] audit: type=1130 audit(1667324067.203:84211): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618603.962710] audit: type=1131 audit(1667324067.203:84212): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618603.962945] audit: type=1334 audit(1667324067.204:84213): prog-id=22003 op=UNLOAD
[1618603.962948] audit: type=1334 audit(1667324067.204:84214): prog-id=22004 op=UNLOAD
[1618603.963114] audit: type=1334 audit(1667324067.204:84215): prog-id=22005 op=LOAD
[1618603.963167] audit: type=1334 audit(1667324067.204:84216): prog-id=22006 op=LOAD
[1618604.205535] audit: type=1130 audit(1667324067.446:84217): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618705.799643] audit: type=1131 audit(1667324169.042:84218): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1618705.961162] audit: type=1130 audit(1667324169.204:84219): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618705.961167] audit: type=1131 audit(1667324169.204:84220): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618705.961461] audit: type=1334 audit(1667324169.204:84221): prog-id=22005 op=UNLOAD
[1618705.961466] audit: type=1334 audit(1667324169.204:84222): prog-id=22006 op=UNLOAD
[1618705.961599] audit: type=1334 audit(1667324169.204:84223): prog-id=22007 op=LOAD
[1618705.961656] audit: type=1334 audit(1667324169.204:84224): prog-id=22008 op=LOAD
[1618707.244422] audit: type=1130 audit(1667324170.487:84225): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618806.388347] audit: type=1131 audit(1667324269.632:84226): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1618806.709373] audit: type=1130 audit(1667324269.953:84227): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618806.709378] audit: type=1131 audit(1667324269.953:84228): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618806.709610] audit: type=1334 audit(1667324269.954:84229): prog-id=22007 op=UNLOAD
[1618806.709614] audit: type=1334 audit(1667324269.954:84230): prog-id=22008 op=UNLOAD
[1618806.709719] audit: type=1334 audit(1667324269.954:84231): prog-id=22009 op=LOAD
[1618806.709770] audit: type=1334 audit(1667324269.954:84232): prog-id=22010 op=LOAD
[1618816.372331] audit: type=1130 audit(1667324279.617:84233): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618909.362176] audit: type=1131 audit(1667324372.608:84234): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1618909.707646] audit: type=1130 audit(1667324372.953:84235): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618909.707651] audit: type=1131 audit(1667324372.953:84236): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1618909.707898] audit: type=1334 audit(1667324372.954:84237): prog-id=22009 op=UNLOAD
[1618909.707903] audit: type=1334 audit(1667324372.954:84238): prog-id=22010 op=UNLOAD
[1618909.708035] audit: type=1334 audit(1667324372.954:84239): prog-id=22011 op=LOAD
[1618909.708089] audit: type=1334 audit(1667324372.954:84240): prog-id=22012 op=LOAD
[1618910.644326] audit: type=1130 audit(1667324373.890:84241): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1619007.458592] audit: type=1131 audit(1667324470.706:84242): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1619007.706034] audit: type=1130 audit(1667324470.954:84243): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1619007.706040] audit: type=1131 audit(1667324470.954:84244): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1619007.706291] audit: type=1334 audit(1667324470.954:84245): prog-id=22011 op=UNLOAD
[1619007.706297] audit: type=1334 audit(1667324470.954:84246): prog-id=22012 op=UNLOAD
[1619007.706412] audit: type=1334 audit(1667324470.954:84247): prog-id=22013 op=LOAD
[1619007.706463] audit: type=1334 audit(1667324470.954:84248): prog-id=22014 op=LOAD
[1619018.664936] audit: type=1130 audit(1667324481.912:84249): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1619111.059388] audit: type=1131 audit(1667324574.308:84250): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1619111.204410] audit: type=1130 audit(1667324574.453:84251): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1619111.204416] audit: type=1131 audit(1667324574.454:84252): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1619111.204704] audit: type=1334 audit(1667324574.454:84253): prog-id=22013 op=UNLOAD
[1619111.204710] audit: type=1334 audit(1667324574.454:84254): prog-id=22014 op=UNLOAD
[1619111.204855] audit: type=1334 audit(1667324574.454:84255): prog-id=22015 op=LOAD
[1619111.204917] audit: type=1334 audit(1667324574.454:84256): prog-id=22016 op=LOAD
[1619125.659497] audit: type=1130 audit(1667324588.909:84257): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1619214.359761] audit: type=1131 audit(1667324677.611:84258): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1619214.702737] audit: type=1130 audit(1667324677.954:84259): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1619214.702742] audit: type=1131 audit(1667324677.954:84260): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1619214.703033] audit: type=1334 audit(1667324677.954:84261): prog-id=22015 op=UNLOAD
[1619214.703039] audit: type=1334 audit(1667324677.954:84262): prog-id=22016 op=UNLOAD
[1619214.703168] audit: type=1334 audit(1667324677.954:84263): prog-id=22017 op=LOAD
[1619214.703221] audit: type=1334 audit(1667324677.954:84264): prog-id=22018 op=LOAD
[1619215.534359] audit: type=1130 audit(1667324678.786:84265): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1619317.104307] audit: type=1131 audit(1667324780.357:84266): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1619317.451041] audit: type=1130 audit(1667324780.704:84267): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1619317.451046] audit: type=1131 audit(1667324780.704:84268): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1619317.451362] audit: type=1334 audit(1667324780.704:84269): prog-id=22017 op=UNLOAD
[1619317.451369] audit: type=1334 audit(1667324780.704:84270): prog-id=22018 op=UNLOAD
[1619317.451500] audit: type=1334 audit(1667324780.704:84271): prog-id=22019 op=LOAD
[1619317.451564] audit: type=1334 audit(1667324780.704:84272): prog-id=22020 op=LOAD
[1619318.880157] audit: type=1130 audit(1667324782.133:84273): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1619429.949988] audit: type=1131 audit(1667324893.204:84274): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1619430.199126] audit: type=1130 audit(1667324893.454:84275): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1619430.199130] audit: type=1131 audit(1667324893.454:84276): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1619430.199456] audit: type=1334 audit(1667324893.454:84277): prog-id=22019 op=UNLOAD
[1619430.199459] audit: type=1334 audit(1667324893.454:84278): prog-id=22020 op=UNLOAD
[1619430.199589] audit: type=1334 audit(1667324893.454:84279): prog-id=22021 op=LOAD
[1619430.199646] audit: type=1334 audit(1667324893.454:84280): prog-id=22022 op=LOAD
[1619431.348026] audit: type=1130 audit(1667324894.602:84281): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1619555.569317] audit: type=1131 audit(1667325018.826:84282): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1619555.697024] audit: type=1130 audit(1667325018.953:84283): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1619555.697030] audit: type=1131 audit(1667325018.954:84284): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1619555.697309] audit: type=1334 audit(1667325018.954:84285): prog-id=22021 op=UNLOAD
[1619555.697318] audit: type=1334 audit(1667325018.954:84286): prog-id=22022 op=UNLOAD
[1619555.697472] audit: type=1334 audit(1667325018.954:84287): prog-id=22023 op=LOAD
[1619555.697531] audit: type=1334 audit(1667325018.954:84288): prog-id=22024 op=LOAD
[1619561.176027] audit: type=1130 audit(1667325024.433:84289): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1619679.951210] audit: type=1131 audit(1667325143.210:84290): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1619680.194823] audit: type=1130 audit(1667325143.453:84291): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1619680.194826] audit: type=1131 audit(1667325143.453:84292): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1619680.195063] audit: type=1334 audit(1667325143.454:84293): prog-id=22023 op=UNLOAD
[1619680.195069] audit: type=1334 audit(1667325143.454:84294): prog-id=22024 op=UNLOAD
[1619680.195192] audit: type=1334 audit(1667325143.454:84295): prog-id=22025 op=LOAD
[1619680.195249] audit: type=1334 audit(1667325143.454:84296): prog-id=22026 op=LOAD
[1619681.240491] audit: type=1130 audit(1667325144.499:84297): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1619797.347420] audit: type=1131 audit(1667325260.608:84298): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1619797.692883] audit: type=1130 audit(1667325260.953:84299): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1619797.692887] audit: type=1131 audit(1667325260.953:84300): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1619797.693125] audit: type=1334 audit(1667325260.954:84301): prog-id=22025 op=UNLOAD
[1619797.693127] audit: type=1334 audit(1667325260.954:84302): prog-id=22026 op=UNLOAD
[1619797.693255] audit: type=1334 audit(1667325260.954:84303): prog-id=22027 op=LOAD
[1619797.693308] audit: type=1334 audit(1667325260.954:84304): prog-id=22028 op=LOAD
[1619800.163968] audit: type=1130 audit(1667325263.425:84305): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1619808.008340] audit: type=1333 audit(1667325271.270:84306): op=offset old=-33776993202 new=237567526043
[1619808.008346] audit: type=1333 audit(1667325271.270:84306): op=freq old=72404250900443 new=72462250784731
[1619808.008347] audit: type=1333 audit(1667325271.270:84306): op=status old=24577 new=8193
[1619808.008349] audit: type=1300 audit(1667325271.270:84306): arch=c000003e syscall=305 success=yes exit=0 a0=0 a1=7fff67695dd0 a2=7 a3=0 items=0 ppid=1 pid=2490 auid=4294967295 uid=154 gid=154 euid=154 suid=154 fsuid=154 egid=154 sgid=154 fsgid=154 tty=(none) ses=4294967295 comm="systemd-timesyn" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd-timesyncd" subj=kernel key=(null)
[1619808.008352] audit: type=1327 audit(1667325271.270:84306): proctitle="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd-timesyncd"
[1619918.165826] audit: type=1131 audit(1667325381.428:84307): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1619918.441043] audit: type=1130 audit(1667325381.704:84308): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1619918.441050] audit: type=1131 audit(1667325381.704:84309): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1619918.441390] audit: type=1334 audit(1667325381.704:84310): prog-id=22027 op=UNLOAD
[1619918.441393] audit: type=1334 audit(1667325381.704:84311): prog-id=22028 op=UNLOAD
[1619918.441549] audit: type=1334 audit(1667325381.704:84312): prog-id=22029 op=LOAD
[1619918.441628] audit: type=1334 audit(1667325381.704:84313): prog-id=22030 op=LOAD
[1619919.012754] audit: type=1130 audit(1667325382.275:84314): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620044.641717] audit: type=1131 audit(1667325507.907:84315): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1620044.938913] audit: type=1130 audit(1667325508.205:84316): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620044.938918] audit: type=1131 audit(1667325508.205:84317): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620044.939260] audit: type=1334 audit(1667325508.205:84318): prog-id=22029 op=UNLOAD
[1620044.939267] audit: type=1334 audit(1667325508.205:84319): prog-id=22030 op=UNLOAD
[1620044.939436] audit: type=1334 audit(1667325508.205:84320): prog-id=22031 op=LOAD
[1620044.939510] audit: type=1334 audit(1667325508.205:84321): prog-id=22032 op=LOAD
[1620045.840814] audit: type=1130 audit(1667325509.105:84322): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620138.050889] audit: type=1334 audit(1667325601.317:84323): prog-id=21961 op=UNLOAD
[1620138.050894] audit: type=1334 audit(1667325601.317:84324): prog-id=21962 op=UNLOAD
[1620138.051043] audit: type=1334 audit(1667325601.317:84325): prog-id=22033 op=LOAD
[1620138.051122] audit: type=1334 audit(1667325601.317:84326): prog-id=22034 op=LOAD
[1620138.051947] audit: type=1130 audit(1667325601.318:84327): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=update-locatedb comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620158.368661] audit: type=1131 audit(1667325621.635:84328): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1620158.437003] audit: type=1131 audit(1667325621.704:84329): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=update-locatedb comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620158.686858] audit: type=1130 audit(1667325621.953:84330): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620158.686862] audit: type=1131 audit(1667325621.953:84331): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620158.687123] audit: type=1334 audit(1667325621.954:84332): prog-id=22031 op=UNLOAD
[1620158.687125] audit: type=1334 audit(1667325621.954:84333): prog-id=22032 op=UNLOAD
[1620158.687245] audit: type=1334 audit(1667325621.954:84334): prog-id=22035 op=LOAD
[1620158.687299] audit: type=1334 audit(1667325621.954:84335): prog-id=22036 op=LOAD
[1620196.029399] audit: type=1130 audit(1667325659.297:84336): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620253.675835] audit: type=1131 audit(1667325716.944:84337): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1620253.935325] audit: type=1130 audit(1667325717.203:84338): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620253.935328] audit: type=1131 audit(1667325717.203:84339): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620253.935612] audit: type=1334 audit(1667325717.204:84340): prog-id=22035 op=UNLOAD
[1620253.935614] audit: type=1334 audit(1667325717.204:84341): prog-id=22036 op=UNLOAD
[1620253.935737] audit: type=1334 audit(1667325717.204:84342): prog-id=22037 op=LOAD
[1620253.935791] audit: type=1334 audit(1667325717.204:84343): prog-id=22038 op=LOAD
[1620257.890312] audit: type=1130 audit(1667325721.159:84344): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620337.787537] audit: type=1131 audit(1667325801.058:84345): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1620337.933906] audit: type=1130 audit(1667325801.204:84346): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620337.933913] audit: type=1131 audit(1667325801.204:84347): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620337.934189] audit: type=1334 audit(1667325801.205:84348): prog-id=22037 op=UNLOAD
[1620337.934191] audit: type=1334 audit(1667325801.205:84349): prog-id=22038 op=UNLOAD
[1620337.934315] audit: type=1334 audit(1667325801.205:84350): prog-id=22039 op=LOAD
[1620337.934370] audit: type=1334 audit(1667325801.205:84351): prog-id=22040 op=LOAD
[1620338.077542] audit: type=1130 audit(1667325801.348:84352): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620425.612763] audit: type=1131 audit(1667325888.884:84353): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1620425.932370] audit: type=1130 audit(1667325889.203:84354): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620425.932376] audit: type=1131 audit(1667325889.203:84355): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620425.932622] audit: type=1334 audit(1667325889.204:84356): prog-id=22039 op=UNLOAD
[1620425.932624] audit: type=1334 audit(1667325889.204:84357): prog-id=22040 op=UNLOAD
[1620425.932750] audit: type=1334 audit(1667325889.204:84358): prog-id=22041 op=LOAD
[1620425.932801] audit: type=1334 audit(1667325889.204:84359): prog-id=22042 op=LOAD
[1620426.870518] audit: type=1130 audit(1667325890.142:84360): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620512.722961] audit: type=1131 audit(1667325975.996:84361): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1620512.930904] audit: type=1130 audit(1667325976.204:84362): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620512.930910] audit: type=1131 audit(1667325976.204:84363): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620512.931145] audit: type=1334 audit(1667325976.205:84364): prog-id=22041 op=UNLOAD
[1620512.931150] audit: type=1334 audit(1667325976.205:84365): prog-id=22042 op=UNLOAD
[1620512.931277] audit: type=1334 audit(1667325976.205:84366): prog-id=22043 op=LOAD
[1620512.931331] audit: type=1334 audit(1667325976.205:84367): prog-id=22044 op=LOAD
[1620520.382468] audit: type=1130 audit(1667325983.655:84368): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620597.164722] audit: type=1131 audit(1667326060.439:84369): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1620597.429589] audit: type=1130 audit(1667326060.703:84370): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620597.429595] audit: type=1131 audit(1667326060.703:84371): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620597.429895] audit: type=1334 audit(1667326060.704:84372): prog-id=22043 op=UNLOAD
[1620597.429898] audit: type=1334 audit(1667326060.704:84373): prog-id=22044 op=UNLOAD
[1620597.430029] audit: type=1334 audit(1667326060.704:84374): prog-id=22045 op=LOAD
[1620597.430086] audit: type=1334 audit(1667326060.704:84375): prog-id=22046 op=LOAD
[1620597.600081] audit: type=1130 audit(1667326060.874:84376): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620701.318571] audit: type=1131 audit(1667326164.594:84377): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1620701.427807] audit: type=1130 audit(1667326164.703:84378): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620701.427814] audit: type=1131 audit(1667326164.703:84379): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620701.428135] audit: type=1334 audit(1667326164.704:84380): prog-id=22045 op=UNLOAD
[1620701.428141] audit: type=1334 audit(1667326164.704:84381): prog-id=22046 op=UNLOAD
[1620701.428284] audit: type=1334 audit(1667326164.704:84382): prog-id=22047 op=LOAD
[1620701.428355] audit: type=1334 audit(1667326164.704:84383): prog-id=22048 op=LOAD
[1620712.268530] audit: type=1130 audit(1667326175.544:84384): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620790.519464] audit: type=1131 audit(1667326253.797:84385): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1620790.676451] audit: type=1130 audit(1667326253.954:84386): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620790.676455] audit: type=1131 audit(1667326253.954:84387): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620790.676787] audit: type=1334 audit(1667326253.954:84388): prog-id=22047 op=UNLOAD
[1620790.676792] audit: type=1334 audit(1667326253.954:84389): prog-id=22048 op=UNLOAD
[1620790.676917] audit: type=1334 audit(1667326253.954:84390): prog-id=22049 op=LOAD
[1620790.676970] audit: type=1334 audit(1667326253.954:84391): prog-id=22050 op=LOAD
[1620791.996343] audit: type=1130 audit(1667326255.273:84392): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620875.245095] audit: type=1131 audit(1667326338.524:84393): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1620875.424850] audit: type=1130 audit(1667326338.704:84394): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620875.424853] audit: type=1131 audit(1667326338.704:84395): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620875.425101] audit: type=1334 audit(1667326338.704:84396): prog-id=22049 op=UNLOAD
[1620875.425103] audit: type=1334 audit(1667326338.704:84397): prog-id=22050 op=UNLOAD
[1620875.425237] audit: type=1334 audit(1667326338.704:84398): prog-id=22051 op=LOAD
[1620875.425288] audit: type=1334 audit(1667326338.704:84399): prog-id=22052 op=LOAD
[1620876.807470] audit: type=1130 audit(1667326340.086:84400): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620962.982207] audit: type=1131 audit(1667326426.262:84401): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1620963.173393] audit: type=1130 audit(1667326426.453:84402): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620963.173397] audit: type=1131 audit(1667326426.453:84403): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1620963.173648] audit: type=1334 audit(1667326426.454:84404): prog-id=22051 op=UNLOAD
[1620963.173650] audit: type=1334 audit(1667326426.454:84405): prog-id=22052 op=UNLOAD
[1620963.173782] audit: type=1334 audit(1667326426.454:84406): prog-id=22053 op=LOAD
[1620963.173833] audit: type=1334 audit(1667326426.454:84407): prog-id=22054 op=LOAD
[1620988.775101] audit: type=1130 audit(1667326452.056:84408): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621050.687790] audit: type=1131 audit(1667326513.969:84409): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1621050.922043] audit: type=1130 audit(1667326514.203:84410): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621050.922047] audit: type=1131 audit(1667326514.204:84411): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621050.922332] audit: type=1334 audit(1667326514.204:84412): prog-id=22053 op=UNLOAD
[1621050.922337] audit: type=1334 audit(1667326514.204:84413): prog-id=22054 op=UNLOAD
[1621050.922469] audit: type=1334 audit(1667326514.204:84414): prog-id=22055 op=LOAD
[1621050.922524] audit: type=1334 audit(1667326514.204:84415): prog-id=22056 op=LOAD
[1621063.131067] audit: type=1130 audit(1667326526.413:84416): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621138.707797] audit: type=1131 audit(1667326601.991:84417): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1621138.920579] audit: type=1130 audit(1667326602.203:84418): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621138.920585] audit: type=1131 audit(1667326602.204:84419): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621138.920866] audit: type=1334 audit(1667326602.204:84420): prog-id=22055 op=UNLOAD
[1621138.920869] audit: type=1334 audit(1667326602.204:84421): prog-id=22056 op=UNLOAD
[1621138.921002] audit: type=1334 audit(1667326602.204:84422): prog-id=22057 op=LOAD
[1621138.921055] audit: type=1334 audit(1667326602.204:84423): prog-id=22058 op=LOAD
[1621139.082662] audit: type=1130 audit(1667326602.366:84424): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621232.581478] audit: type=1131 audit(1667326695.866:84425): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1621232.919001] audit: type=1130 audit(1667326696.204:84426): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621232.919007] audit: type=1131 audit(1667326696.204:84427): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621232.919293] audit: type=1334 audit(1667326696.204:84428): prog-id=22057 op=UNLOAD
[1621232.919295] audit: type=1334 audit(1667326696.204:84429): prog-id=22058 op=UNLOAD
[1621232.919424] audit: type=1334 audit(1667326696.204:84430): prog-id=22059 op=LOAD
[1621232.919478] audit: type=1334 audit(1667326696.204:84431): prog-id=22060 op=LOAD
[1621247.515075] audit: type=1130 audit(1667326710.800:84432): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621328.266440] audit: type=1131 audit(1667326791.553:84433): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1621328.417286] audit: type=1130 audit(1667326791.703:84434): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621328.417290] audit: type=1131 audit(1667326791.703:84435): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621328.417524] audit: type=1334 audit(1667326791.704:84436): prog-id=22059 op=UNLOAD
[1621328.417526] audit: type=1334 audit(1667326791.704:84437): prog-id=22060 op=UNLOAD
[1621328.417636] audit: type=1334 audit(1667326791.704:84438): prog-id=22061 op=LOAD
[1621328.417695] audit: type=1334 audit(1667326791.704:84439): prog-id=22062 op=LOAD
[1621331.359630] audit: type=1130 audit(1667326794.646:84440): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621410.731821] audit: type=1131 audit(1667326874.019:84441): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1621410.915994] audit: type=1130 audit(1667326874.203:84442): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621410.915999] audit: type=1131 audit(1667326874.203:84443): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621410.916283] audit: type=1334 audit(1667326874.204:84444): prog-id=22061 op=UNLOAD
[1621410.916285] audit: type=1334 audit(1667326874.204:84445): prog-id=22062 op=UNLOAD
[1621410.916416] audit: type=1334 audit(1667326874.204:84446): prog-id=22063 op=LOAD
[1621410.916477] audit: type=1334 audit(1667326874.204:84447): prog-id=22064 op=LOAD
[1621412.638418] audit: type=1130 audit(1667326875.926:84448): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621496.861072] audit: type=1131 audit(1667326960.150:84449): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1621497.164615] audit: type=1130 audit(1667326960.454:84450): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621497.164621] audit: type=1131 audit(1667326960.454:84451): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621497.164911] audit: type=1334 audit(1667326960.454:84452): prog-id=22063 op=UNLOAD
[1621497.164913] audit: type=1334 audit(1667326960.454:84453): prog-id=22064 op=UNLOAD
[1621497.165043] audit: type=1334 audit(1667326960.454:84454): prog-id=22065 op=LOAD
[1621497.165100] audit: type=1334 audit(1667326960.454:84455): prog-id=22066 op=LOAD
[1621497.307853] audit: type=1130 audit(1667326960.597:84456): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621588.436332] audit: type=1131 audit(1667327051.727:84457): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1621588.663125] audit: type=1130 audit(1667327051.954:84458): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621588.663131] audit: type=1131 audit(1667327051.954:84459): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621588.663439] audit: type=1334 audit(1667327051.954:84460): prog-id=22065 op=UNLOAD
[1621588.663441] audit: type=1334 audit(1667327051.954:84461): prog-id=22066 op=UNLOAD
[1621588.663566] audit: type=1334 audit(1667327051.954:84462): prog-id=22067 op=LOAD
[1621588.663619] audit: type=1334 audit(1667327051.954:84463): prog-id=22068 op=LOAD
[1621592.298319] audit: type=1130 audit(1667327055.589:84464): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621680.150092] audit: type=1131 audit(1667327143.442:84465): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1621680.411521] audit: type=1130 audit(1667327143.703:84466): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621680.411535] audit: type=1131 audit(1667327143.703:84467): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621680.411807] audit: type=1334 audit(1667327143.704:84468): prog-id=22067 op=UNLOAD
[1621680.411809] audit: type=1334 audit(1667327143.704:84469): prog-id=22068 op=UNLOAD
[1621680.411941] audit: type=1334 audit(1667327143.704:84470): prog-id=22069 op=LOAD
[1621680.411992] audit: type=1334 audit(1667327143.704:84471): prog-id=22070 op=LOAD
[1621680.733140] audit: type=1130 audit(1667327144.025:84472): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621777.603932] audit: type=1131 audit(1667327240.898:84473): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1621777.909810] audit: type=1130 audit(1667327241.204:84474): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621777.909818] audit: type=1131 audit(1667327241.204:84475): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621777.910048] audit: type=1334 audit(1667327241.204:84476): prog-id=22069 op=UNLOAD
[1621777.910052] audit: type=1334 audit(1667327241.204:84477): prog-id=22070 op=UNLOAD
[1621777.910175] audit: type=1334 audit(1667327241.204:84478): prog-id=22071 op=LOAD
[1621777.910227] audit: type=1334 audit(1667327241.204:84479): prog-id=22072 op=LOAD
[1621815.651532] audit: type=1130 audit(1667327278.946:84480): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621856.224187] audit: type=1333 audit(1667327319.519:84481): op=offset old=4334215467 new=26620207300
[1621856.224192] audit: type=1333 audit(1667327319.519:84481): op=freq old=72462250784731 new=72468749858779
[1621856.224195] audit: type=1300 audit(1667327319.519:84481): arch=c000003e syscall=305 success=yes exit=0 a0=0 a1=7fff67695dd0 a2=7 a3=0 items=0 ppid=1 pid=2490 auid=4294967295 uid=154 gid=154 euid=154 suid=154 fsuid=154 egid=154 sgid=154 fsgid=154 tty=(none) ses=4294967295 comm="systemd-timesyn" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd-timesyncd" subj=kernel key=(null)
[1621856.224198] audit: type=1327 audit(1667327319.519:84481): proctitle="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd-timesyncd"
[1621859.553617] audit: type=1131 audit(1667327322.849:84482): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1621859.658519] audit: type=1130 audit(1667327322.953:84483): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621859.658522] audit: type=1131 audit(1667327322.953:84484): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621859.658811] audit: type=1334 audit(1667327322.954:84485): prog-id=22071 op=UNLOAD
[1621859.658813] audit: type=1334 audit(1667327322.954:84486): prog-id=22072 op=UNLOAD
[1621859.658945] audit: type=1334 audit(1667327322.954:84487): prog-id=22073 op=LOAD
[1621941.399947] kauditd_printk_skb: 2 callbacks suppressed
[1621941.399949] audit: type=1131 audit(1667327404.696:84490): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1621941.657104] audit: type=1130 audit(1667327404.953:84491): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621941.657110] audit: type=1131 audit(1667327404.953:84492): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1621941.657373] audit: type=1334 audit(1667327404.954:84493): prog-id=22073 op=UNLOAD
[1621941.657379] audit: type=1334 audit(1667327404.954:84494): prog-id=22074 op=UNLOAD
[1621941.657519] audit: type=1334 audit(1667327404.954:84495): prog-id=22075 op=LOAD
[1621941.657568] audit: type=1334 audit(1667327404.954:84496): prog-id=22076 op=LOAD
[1621972.161696] audit: type=1130 audit(1667327435.459:84497): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1622031.734034] audit: type=1131 audit(1667327495.032:84498): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1622031.905827] audit: type=1130 audit(1667327495.204:84499): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1622031.905835] audit: type=1131 audit(1667327495.204:84500): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1622031.906190] audit: type=1334 audit(1667327495.204:84501): prog-id=22075 op=UNLOAD
[1622031.906196] audit: type=1334 audit(1667327495.204:84502): prog-id=22076 op=UNLOAD
[1622031.906324] audit: type=1334 audit(1667327495.204:84503): prog-id=22077 op=LOAD
[1622031.906377] audit: type=1334 audit(1667327495.204:84504): prog-id=22078 op=LOAD
[1622192.674128] audit: type=1130 audit(1667327655.975:84505): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1622192.902997] audit: type=1130 audit(1667327656.204:84506): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1622192.903001] audit: type=1131 audit(1667327656.204:84507): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1622192.903316] audit: type=1334 audit(1667327656.204:84508): prog-id=22077 op=UNLOAD
[1622192.903317] audit: type=1334 audit(1667327656.204:84509): prog-id=22078 op=UNLOAD
[1622192.903471] audit: type=1334 audit(1667327656.204:84510): prog-id=22079 op=LOAD
[1622192.903526] audit: type=1334 audit(1667327656.204:84511): prog-id=22080 op=LOAD
[1622196.122357] audit: type=1130 audit(1667327659.423:84512): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1622277.657014] audit: type=1131 audit(1667327740.959:84513): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1622277.901582] audit: type=1130 audit(1667327741.204:84514): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1622277.901592] audit: type=1131 audit(1667327741.204:84515): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1622277.901903] audit: type=1334 audit(1667327741.204:84516): prog-id=22079 op=UNLOAD
[1622277.901906] audit: type=1334 audit(1667327741.204:84517): prog-id=22080 op=UNLOAD
[1622277.902051] audit: type=1334 audit(1667327741.204:84518): prog-id=22081 op=LOAD
[1622277.902108] audit: type=1334 audit(1667327741.204:84519): prog-id=22082 op=LOAD
[1622321.412296] audit: type=1130 audit(1667327784.715:84520): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1622364.600366] audit: type=1131 audit(1667327827.904:84521): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1622364.900009] audit: type=1130 audit(1667327828.204:84522): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1622364.900013] audit: type=1131 audit(1667327828.204:84523): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1622364.900290] audit: type=1334 audit(1667327828.204:84524): prog-id=22081 op=UNLOAD
[1622364.900292] audit: type=1334 audit(1667327828.204:84525): prog-id=22082 op=UNLOAD
[1622364.900432] audit: type=1334 audit(1667327828.204:84526): prog-id=22083 op=LOAD
[1622364.900485] audit: type=1334 audit(1667327828.204:84527): prog-id=22084 op=LOAD
[1622397.683040] audit: type=1130 audit(1667327860.987:84528): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1622467.835151] audit: type=1131 audit(1667327931.140:84529): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1622468.148287] audit: type=1130 audit(1667327931.453:84530): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1622468.148291] audit: type=1131 audit(1667327931.453:84531): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1622468.148548] audit: type=1334 audit(1667327931.454:84532): prog-id=22083 op=UNLOAD
[1622468.148550] audit: type=1334 audit(1667327931.454:84533): prog-id=22084 op=UNLOAD
[1622468.148677] audit: type=1334 audit(1667327931.454:84534): prog-id=22085 op=LOAD
[1622468.148729] audit: type=1334 audit(1667327931.454:84535): prog-id=22086 op=LOAD
[1622471.088763] audit: type=1130 audit(1667327934.394:84536): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1622575.702121] audit: type=1131 audit(1667328039.009:84537): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1622575.896550] audit: type=1130 audit(1667328039.203:84538): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1622575.896554] audit: type=1131 audit(1667328039.203:84539): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1622575.896856] audit: type=1334 audit(1667328039.204:84540): prog-id=22085 op=UNLOAD
[1622575.896861] audit: type=1334 audit(1667328039.204:84541): prog-id=22086 op=UNLOAD
[1622575.896989] audit: type=1334 audit(1667328039.204:84542): prog-id=22087 op=LOAD
[1622575.897043] audit: type=1334 audit(1667328039.204:84543): prog-id=22088 op=LOAD
[1622634.055071] audit: type=1130 audit(1667328097.363:84544): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1622683.202454] audit: type=1131 audit(1667328146.511:84545): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1622683.394680] audit: type=1130 audit(1667328146.703:84546): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1622683.394685] audit: type=1131 audit(1667328146.703:84547): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1622683.394932] audit: type=1334 audit(1667328146.704:84548): prog-id=22087 op=UNLOAD
[1622683.394936] audit: type=1334 audit(1667328146.704:84549): prog-id=22088 op=UNLOAD
[1622683.395079] audit: type=1334 audit(1667328146.704:84550): prog-id=22089 op=LOAD
[1622683.395134] audit: type=1334 audit(1667328146.704:84551): prog-id=22090 op=LOAD
[1622686.169445] audit: type=1130 audit(1667328149.478:84552): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1622792.398505] audit: type=1131 audit(1667328255.709:84553): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1622792.642870] audit: type=1130 audit(1667328255.953:84554): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1622792.642876] audit: type=1131 audit(1667328255.953:84555): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1622792.643136] audit: type=1334 audit(1667328255.954:84556): prog-id=22089 op=UNLOAD
[1622792.643141] audit: type=1334 audit(1667328255.954:84557): prog-id=22090 op=UNLOAD
[1622792.643262] audit: type=1334 audit(1667328255.954:84558): prog-id=22091 op=LOAD
[1622792.643314] audit: type=1334 audit(1667328255.954:84559): prog-id=22092 op=LOAD
[1622793.971972] audit: type=1130 audit(1667328257.283:84560): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1622906.293010] audit: type=1131 audit(1667328369.605:84561): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1622906.641072] audit: type=1130 audit(1667328369.953:84562): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1622906.641080] audit: type=1131 audit(1667328369.954:84563): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1622906.641444] audit: type=1334 audit(1667328369.954:84564): prog-id=22091 op=UNLOAD
[1622906.641449] audit: type=1334 audit(1667328369.954:84565): prog-id=22092 op=UNLOAD
[1622906.641578] audit: type=1334 audit(1667328369.954:84566): prog-id=22093 op=LOAD
[1622906.641632] audit: type=1334 audit(1667328369.954:84567): prog-id=22094 op=LOAD
[1622906.764392] audit: type=1130 audit(1667328370.077:84568): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1623020.595050] audit: type=1131 audit(1667328483.909:84569): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1623020.889187] audit: type=1130 audit(1667328484.204:84570): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1623020.889191] audit: type=1131 audit(1667328484.204:84571): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1623020.889498] audit: type=1334 audit(1667328484.204:84572): prog-id=22093 op=UNLOAD
[1623020.889503] audit: type=1334 audit(1667328484.204:84573): prog-id=22094 op=UNLOAD
[1623020.889631] audit: type=1334 audit(1667328484.204:84574): prog-id=22095 op=LOAD
[1623020.889696] audit: type=1334 audit(1667328484.204:84575): prog-id=22096 op=LOAD
[1623024.396895] audit: type=1130 audit(1667328487.711:84576): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1623131.122336] audit: type=1131 audit(1667328594.438:84577): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1623131.387240] audit: type=1130 audit(1667328594.704:84578): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1623131.387243] audit: type=1131 audit(1667328594.704:84579): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1623131.387519] audit: type=1334 audit(1667328594.704:84580): prog-id=22095 op=UNLOAD
[1623131.387523] audit: type=1334 audit(1667328594.704:84581): prog-id=22096 op=UNLOAD
[1623131.387654] audit: type=1334 audit(1667328594.704:84582): prog-id=22097 op=LOAD
[1623131.387714] audit: type=1334 audit(1667328594.704:84583): prog-id=22098 op=LOAD
[1623134.178554] audit: type=1130 audit(1667328597.495:84584): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1623240.793535] audit: type=1131 audit(1667328704.112:84585): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1623241.135398] audit: type=1130 audit(1667328704.454:84586): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1623241.135404] audit: type=1131 audit(1667328704.454:84587): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1623241.135637] audit: type=1334 audit(1667328704.454:84588): prog-id=22097 op=UNLOAD
[1623241.135643] audit: type=1334 audit(1667328704.454:84589): prog-id=22098 op=UNLOAD
[1623241.135772] audit: type=1334 audit(1667328704.454:84590): prog-id=22099 op=LOAD
[1623241.135826] audit: type=1334 audit(1667328704.454:84591): prog-id=22100 op=LOAD
[1623242.901307] audit: type=1130 audit(1667328706.219:84592): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1623352.004594] audit: type=1131 audit(1667328815.324:84593): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1623352.133528] audit: type=1130 audit(1667328815.454:84594): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1623352.133531] audit: type=1131 audit(1667328815.454:84595): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1623352.133781] audit: type=1334 audit(1667328815.454:84596): prog-id=22099 op=UNLOAD
[1623352.133783] audit: type=1334 audit(1667328815.454:84597): prog-id=22100 op=UNLOAD
[1623352.133921] audit: type=1334 audit(1667328815.454:84598): prog-id=22101 op=LOAD
[1623352.133975] audit: type=1334 audit(1667328815.454:84599): prog-id=22102 op=LOAD
[1623528.707154] audit: type=1130 audit(1667328992.030:84600): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1623528.880614] audit: type=1130 audit(1667328992.203:84601): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1623528.880617] audit: type=1131 audit(1667328992.203:84602): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1623528.880888] audit: type=1334 audit(1667328992.204:84603): prog-id=22101 op=UNLOAD
[1623528.880892] audit: type=1334 audit(1667328992.204:84604): prog-id=22102 op=UNLOAD
[1623528.881027] audit: type=1334 audit(1667328992.204:84605): prog-id=22103 op=LOAD
[1623528.881077] audit: type=1334 audit(1667328992.204:84606): prog-id=22104 op=LOAD
[1623572.916097] audit: type=1130 audit(1667329036.240:84607): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1623661.820890] audit: type=1131 audit(1667329125.146:84608): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1623662.128446] audit: type=1130 audit(1667329125.453:84609): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1623662.128451] audit: type=1131 audit(1667329125.453:84610): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1623662.128751] audit: type=1334 audit(1667329125.454:84611): prog-id=22103 op=UNLOAD
[1623662.128754] audit: type=1334 audit(1667329125.454:84612): prog-id=22104 op=UNLOAD
[1623662.128891] audit: type=1334 audit(1667329125.454:84613): prog-id=22105 op=LOAD
[1623662.128947] audit: type=1334 audit(1667329125.454:84614): prog-id=22106 op=LOAD
[1623663.841575] audit: type=1130 audit(1667329127.167:84615): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1623738.090431] audit: type=1334 audit(1667329201.417:84616): prog-id=22033 op=UNLOAD
[1623738.090434] audit: type=1334 audit(1667329201.417:84617): prog-id=22034 op=UNLOAD
[1623738.090561] audit: type=1334 audit(1667329201.417:84618): prog-id=22107 op=LOAD
[1623738.090613] audit: type=1334 audit(1667329201.417:84619): prog-id=22108 op=LOAD
[1623738.091325] audit: type=1130 audit(1667329201.418:84620): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=update-locatedb comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1623765.535790] audit: type=1131 audit(1667329228.863:84621): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=update-locatedb comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1623796.984847] audit: type=1131 audit(1667329260.312:84622): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1623797.126093] audit: type=1130 audit(1667329260.453:84623): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1623797.126097] audit: type=1131 audit(1667329260.453:84624): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1623797.126351] audit: type=1334 audit(1667329260.454:84625): prog-id=22105 op=UNLOAD
[1623797.126353] audit: type=1334 audit(1667329260.454:84626): prog-id=22106 op=UNLOAD
[1623797.126476] audit: type=1334 audit(1667329260.454:84627): prog-id=22109 op=LOAD
[1623797.126527] audit: type=1334 audit(1667329260.454:84628): prog-id=22110 op=LOAD
[1623811.878864] audit: type=1130 audit(1667329275.206:84629): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1623904.439913] audit: type=1333 audit(1667329367.770:84630): op=offset old=485663040 new=-2746365297819
[1623904.439919] audit: type=1333 audit(1667329367.770:84630): op=freq old=72468749858779 new=71798250518491
[1623904.439921] audit: type=1300 audit(1667329367.770:84630): arch=c000003e syscall=305 success=yes exit=0 a0=0 a1=7fff67695dd0 a2=7 a3=0 items=0 ppid=1 pid=2490 auid=4294967295 uid=154 gid=154 euid=154 suid=154 fsuid=154 egid=154 sgid=154 fsgid=154 tty=(none) ses=4294967295 comm="systemd-timesyn" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd-timesyncd" subj=kernel key=(null)
[1623904.439923] audit: type=1327 audit(1667329367.770:84630): proctitle="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd-timesyncd"
[1623921.942170] audit: type=1131 audit(1667329385.271:84631): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1623922.124207] audit: type=1130 audit(1667329385.454:84632): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1623922.124213] audit: type=1131 audit(1667329385.454:84633): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1623922.124582] audit: type=1334 audit(1667329385.454:84634): prog-id=22109 op=UNLOAD
[1623922.124585] audit: type=1334 audit(1667329385.454:84635): prog-id=22110 op=UNLOAD
[1623922.124709] audit: type=1334 audit(1667329385.454:84636): prog-id=22111 op=LOAD
[1623922.124763] audit: type=1334 audit(1667329385.454:84637): prog-id=22112 op=LOAD
[1623927.754335] audit: type=1130 audit(1667329391.084:84638): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1624049.112948] audit: type=1131 audit(1667329512.444:84639): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1624049.372236] audit: type=1130 audit(1667329512.704:84640): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1624049.372241] audit: type=1131 audit(1667329512.704:84641): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1624049.372578] audit: type=1334 audit(1667329512.704:84642): prog-id=22111 op=UNLOAD
[1624049.372583] audit: type=1334 audit(1667329512.704:84643): prog-id=22112 op=UNLOAD
[1624049.372725] audit: type=1334 audit(1667329512.704:84644): prog-id=22113 op=LOAD
[1624049.372780] audit: type=1334 audit(1667329512.704:84645): prog-id=22114 op=LOAD
[1624247.255600] audit: type=1130 audit(1667329710.590:84646): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1624247.368955] audit: type=1130 audit(1667329710.703:84647): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1624247.368958] audit: type=1131 audit(1667329710.703:84648): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1624247.369200] audit: type=1334 audit(1667329710.704:84649): prog-id=22113 op=UNLOAD
[1624247.369206] audit: type=1334 audit(1667329710.704:84650): prog-id=22114 op=UNLOAD
[1624247.369344] audit: type=1334 audit(1667329710.704:84651): prog-id=22115 op=LOAD
[1624247.369398] audit: type=1334 audit(1667329710.704:84652): prog-id=22116 op=LOAD
[1624274.827751] audit: type=1130 audit(1667329738.163:84653): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1624392.017262] audit: type=1131 audit(1667329855.354:84654): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[1624392.366780] audit: type=1130 audit(1667329855.704:84655): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1624392.366784] audit: type=1131 audit(1667329855.704:84656): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[1624392.367096] audit: type=1334 audit(1667329855.704:84657): prog-id=22115 op=UNLOAD
[1624392.367098] audit: type=1334 audit(1667329855.704:84658): prog-id=22116 op=UNLOAD
[1624392.367226] audit: type=1334 audit(1667329855.704:84659): prog-id=22117 op=LOAD
[1624392.367280] audit: type=1334 audit(1667329855.704:84660): prog-id=22118 op=LOAD
[1624396.568942] audit: type=1130 audit(1667329859.906:84661): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=mbsync comm="systemd" exe="/nix/store/iriz2f82dq1sbkzjkjy6cggbb7wnrpz4-systemd-247.6/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'

--=-=-=--
