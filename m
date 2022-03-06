Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321864CEC2D
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Mar 2022 17:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbiCFQBM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Mar 2022 11:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiCFQBL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Mar 2022 11:01:11 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2880568F86
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 08:00:19 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id a6so12833789oid.9
        for <linux-btrfs@vger.kernel.org>; Sun, 06 Mar 2022 08:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=+9yjqc4OLmZ1GMgS9C6/YVbBoEgRBxkcVvtF/Z3s480=;
        b=Rerq8lqwwIjLlQ3ctf897M85VSvzylvoxIK0ut1fin7/pfbaW4sr1yPiL9NnucVIYG
         0jffbNOZq6Fmg2qPngjs8GUkKsE9rEa3Hy5nssAU4upvej7lkQtLp2/PJbIwEIKb1lac
         d+coGuBN2AGop4x/CXEhv/4e8cejX/ucc5lPxwCWLEtSo3WfzK95KZDfNX3q94mBB9Jc
         RCEWsYpVT+9jMeBxNMRTzmG7OLXYmIwqnQEob3cCnqAm5YwfOSMgZMnJjWf6rh9W6gOr
         3n1tmGwntl4XAZwKYWPWD1ZJvwX33Fhfsv5YrXjQJwkL6ifz3XByBJwsAR47IRwa6Xsk
         FdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+9yjqc4OLmZ1GMgS9C6/YVbBoEgRBxkcVvtF/Z3s480=;
        b=oHxbFHxa8RkQ5kKtCAztfOWPMhczJRfbbM/BYO0oKsxkiE/2X/cfKvOiWR+QJ+sT3L
         yJh2wiaGnRd5/ek8SaI+HY9BcxBaEokhrUYh8wEBpiXcDWjrHYRqRrnQey7NaIaTmygr
         yYtdOC0ppUGt+ci/XDrxe08wKew6wLBLHtOIMxayAfbtppZuSVpoRxrFwXHRZOfNz/oq
         2rLAmlyj3ypQfpxOXlp+cvQPLUX/3+osvlGZf3ARUAJItu2pR9SW/vLseOHmKu0+pCU0
         jg9QrfptYysEuLQvrnAwUbkn+SruQmy/1qdjFEnRkLueE1PSYdmeT9z4BkRv1bhtFpea
         awHw==
X-Gm-Message-State: AOAM533mnbcsPTk+IiLj1BPyJDIAcbXPlSSEtZOdFUU8yDp22/40XqwE
        RM2kaweIV852NJ2Cu+opw/bQaKlK2PwvDhfIlTTVgaO5k9c=
X-Google-Smtp-Source: ABdhPJwupQmQSZzSs9j360wIA/he+HijaIOTgm0v0QMnF88DHEdQrjDkytbi4IVUh5mtJxj7VMN5L4ISJOOaGH93XGQ=
X-Received: by 2002:a05:6808:2227:b0:2d9:c3c1:37bb with SMTP id
 bd39-20020a056808222700b002d9c3c137bbmr1953737oib.80.1646582418330; Sun, 06
 Mar 2022 08:00:18 -0800 (PST)
MIME-Version: 1.0
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Sun, 6 Mar 2022 16:59:42 +0100
Message-ID: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
Subject: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
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

I would like to report that btrfs in Linux kernel 5.16.12 mounted with
the autodefrag option wrote 5TB in a single day to a 1TB SSD that is
about 50% full.

Defragmenting 0.5TB on a drive that is 50% full should write far less than 5TB.

Benefits to the fragmentation of the most written files over the
course of the one day (sqlite database files) are nil. Please see the
data below. Also note that the sqlite file is using up to 10 GB more
than it should due to fragmentation.

CPU utilization on an otherwise idle machine is approximately 600% all
the time: btrfs-cleaner 100%, kworkers...btrfs 500%.

I am not just asking you to fix this issue - I am asking you how is it
possible for an algorithm that is significantly worse than O(N*log(N))
to be merged into the Linux kernel in the first place!?

Please try to avoid discussing no-CoW (chattr +C) in your response,
because it is beside the point. Thanks.

----

A day before:

$ smartctl -a /dev/nvme0n1 | grep Units
Data Units Read:                    449,265,485 [230 TB]
Data Units Written:                 406,386,721 [208 TB]

$ compsize file.sqlite
Processed 1 file, 1757129 regular extents (2934077 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%       46G          46G          37G
none       100%       46G          46G          37G

----

A day after:

$ smartctl -a /dev/nvme0n1 | grep Units
Data Units Read:                    473,211,419 [242 TB]
Data Units Written:                 417,249,915 [213 TB]

$ compsize file.sqlite
Processed 1 file, 1834778 regular extents (3050838 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%       47G          47G          37G
none       100%       47G          47G          37G

$ filefrag file.sqlite
(Ctrl-C after waiting more than 10 minutes, consuming 100% CPU)

----

Manual defragmentation decreased the file's size by 7 GB:

$ btrfs-defrag file.sqlite
$ sync
$ compsize file.sqlite
Processed 6 files, 13074 regular extents (20260 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%       40G          40G          37G
none       100%       40G          40G          37G

----

Sincerely
Jan
