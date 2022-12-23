Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345BA654AA7
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Dec 2022 03:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiLWCFQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Dec 2022 21:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLWCFP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Dec 2022 21:05:15 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1416E20BD9
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Dec 2022 18:05:14 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h16so3355771wrz.12
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Dec 2022 18:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NBYKMC9zLyWDwtGBVU+sPJ55sfr0H12QHduPIvKZ9p0=;
        b=kWn79Lu6+mqrjuKUT3/oJ87BJMXWqTnZVqmtO+XzbAPxmse/ZjEItbgtli2v4JzWml
         SMX+6/3oqs9k4EpcIzM3XATWPRVDwc1/cKBR55pUGSOND5lwIP5Dxp6lWIwD9+eSuJsG
         O0BMJxswE6PeBiSww4gvkbdX7mwPYJ+OgJLW7oHoAVuZBzpnhbnp60UjYSE4TwFoCUZM
         7pCs8nQ1xr1DJz6Y3DLDATnWKmOrjTYt9MTUmcLx8V3Tefo+L+KudtDWnoZbzKIqwjrL
         X07cXYfKlFJ9IH86u0XOep3nn0QO1pm5yqtdUVxYyE/aIu/mvJJIXtqMQVZfCFGMkUrX
         MLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NBYKMC9zLyWDwtGBVU+sPJ55sfr0H12QHduPIvKZ9p0=;
        b=q0lHqfet7qKITj1VeEjE4Tq4oUBGjF7285E7swvdIuIBCvVqAsy/K5IW4I2aSA91A/
         HFzjAz3+0yC/Uj1Yni8xyw/EqeJi1sILz/5t2sXrhgcOMjWn963+xkxfoQt6e7NERKRQ
         td/sGuoZD+X1idUIvydtzMraUKvU4cHuKLxto7uy3h61sdPruMnjdYOj21pHcfnS1fpV
         x7PrMBKQm3plPGm3a/4j4LyuJjD76QXewkbxqKa9hAtac8wuKntn1/xcaBfLWDvBIqh7
         8pCEBqCCwCaOOy9XMoV0ThJKYvjyL8XWOK6q0BZbKcGHJYxZ7zLthH8B8hLbI7Sgr1oA
         9Rmw==
X-Gm-Message-State: AFqh2kqijEXP2CKikd9RDpa0stJx5rYtZJxDbhUdO8cV6yUnjYxzhlsn
        0KJH2/wWQHT68nfPuPhJA/k=
X-Google-Smtp-Source: AMrXdXtq4T8DHu4CfEeVaSvzr+FQIo5D1rqgoslLWkTjz/vV0CP4RXR5OuK/0CduKx3fmW0JP96imw==
X-Received: by 2002:adf:eecf:0:b0:24a:852d:e292 with SMTP id a15-20020adfeecf000000b0024a852de292mr4803979wrp.46.1671761112535;
        Thu, 22 Dec 2022 18:05:12 -0800 (PST)
Received: from solpc.. (67.pool90-171-92.dynamic.orange.es. [90.171.92.67])
        by smtp.gmail.com with ESMTPSA id j13-20020a5d618d000000b002425dc49024sm1934221wru.43.2022.12.22.18.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 18:05:12 -0800 (PST)
From:   Joan Bruguera <joanbrugueram@gmail.com>
To:     fdmanana@suse.com
Cc:     linux-btrfs@vger.kernel.org,
        =?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>
Subject: Repression on lseek (holes) on 1-byte files since Linux 6.1-rc1
Date:   Fri, 23 Dec 2022 02:05:09 +0000
Message-Id: <20221223020509.457113-1-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Joan Bruguera Micó <joanbrugueram@gmail.com>

Hello,

I believe I have found a regression related to seeking file data and holes on
1-byte files since Linux 6.1-rc1:

Since Linux 6.1-rc1 I observe that, if I create a (non-sparse) 1-byte file and
immediately run `lseek(SEEK_DATA, 0)` or `lseek(SEEK_HOLE, 0)` on it, it will
act as if it was a sparse file, i.e. as if it had a hole from offset 0 to 1.

If I wait a while or run `sync`, the results are what I expect, i.e. no hole.

A simple reproducer is:
    #!/usr/bin/env sh
    set -eu

    rm -f test.bin
    echo "-----BEFORE SYNC-----"
    printf "x" > test.bin
    xfs_io -c "seek -d 0" test.bin
    echo "-----AFTER SYNC-----"
    sync
    xfs_io -c "seek -d 0" test.bin

Expected results (Linux <6.1-rc1):
    -----BEFORE SYNC-----
    Whence  Result
    DATA    0
    -----AFTER SYNC-----
    Whence  Result
    DATA    0

Actual results (Linux >=6.1-rc1):
    -----BEFORE SYNC-----
    Whence  Result
    DATA    EOF
    -----AFTER SYNC-----
    Whence  Result
    DATA    0

It doesn't reproduce 100% of the time due to the race between lseek and
background sync, but it's consistent and also reproduces on a clean VM or UML.
It also doesn't reproduce on larger (e.g. 2 bytes) files.

I've bisected the change in behaviour to commit
b6e833567ea12bc47d91e4b6497d49ba60d4f95f
"btrfs: make hole and data seeking a lot more efficient".

I tried to see if I could figure out the cause by looking at the btrfs kernel
code for lseek in fs/btrfs/file.c.

I believe everything is fine until this snippet (line 3947 in v6.1),
which is supposed to find whether there's a hole at the last extent:

    /* We have an implicit hole from the last extent found up to i_size. */
    if (!found && start < i_size) {
        found = find_desired_extent_in_hole(inode, whence, start,
                            i_size - 1, &start);
        if (!found)
            start = i_size;
    }

Here it calls `find_desired_extent_in_hole`, which immediately calls
`btrfs_find_delalloc_in_range` with a range of start=0 and end=0 (inclusive).
Supposedly it should find that there's a delalloc extent, but one can easily
see by looking at the function that it always returns false if start==end.
This explains why it only happens with 1-byte files, as on e.g. a 2 byte file
start=0 and end=1 (inclusive) and the function loops and finds the delalloc.

I'm not sure what the right fix is since I'm not very familiar with the btrfs
code base, but both replacing `i_size - 1` with `lockend` in the snippet above,
OR tightening the conditionals in `btrfs_find_delalloc_in_range` (and
`count_range_bits`) for the `start==end` case seem to work.

Regards,
- Joan Bruguera
