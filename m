Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912211F9C20
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jun 2020 17:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbgFOPmu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jun 2020 11:42:50 -0400
Received: from remote-3.kharan.ch ([163.172.214.34]:36562 "EHLO
        remote-3.kharan.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgFOPmu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jun 2020 11:42:50 -0400
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jun 2020 11:42:48 EDT
Received: from remote-3.kharan.ch (localhost [127.0.0.1])
        by remote-3.kharan.ch (Postfix) with ESMTPA id B36D26291D4
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Jun 2020 17:35:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kharan.ch; s=remote-3;
        t=1592235349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3mMt3LR0XOXpTcmmBMJUlygWs0YxyE1P+viwcUh7cto=;
        b=pw87IJ1hqt1qdUbfjuv5djyf6WVROpl5jxG2G7tyjiXjK0x/qhH0U6Txfg6WYFqL1cdLhk
        BzcuwqjxHNGPU/NCXuXcdtFYUqBn8LR821TbusMlgcs/O5ZPRI4C5A7/BCW7H4oW/96MDZ
        Y1d1bGaCeRjaMpP3iKOFyhQNJqQIRgLClmkp8u4x0aVDtenLnbhMTwjnWKrYeDLMt65pyE
        yYA7guDmkYT6mL/y2aMEqvri6vKXEp/+KoCKebw99RP2Z69Vpwl+AKLIH04eLwyTy5kc6y
        Xs2CUsca3TWnHiX3o7o6A4C+pTKdh3viGHTQWj7440RpVM+ycpdF3THAmyUzow==
MIME-Version: 1.0
Date:   Mon, 15 Jun 2020 17:35:49 +0200
From:   Andreas Egli <btrfs@kharan.ch>
To:     linux-btrfs@vger.kernel.org
Subject: BTRFS fails to mount: failed to read chunk tree: -22 / failed to read
 block groups: -5
User-Agent: Roundcube Webmail/1.4.3
Message-ID: <96c925837dc675d8f3c53a849f413d64@eglimail.net>
X-Sender: btrfs@kharan.ch
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi

Tonight my server was unexpectedly reset (probably a power failure) and 
after rebooting, the BTRFS storage fails to mount. Any tips how to 
recover the file system?

The initial mount during booting failed with this error:
[   42.652725] BTRFS info (device dm-10): disk space caching is enabled
[   42.652727] BTRFS info (device dm-10): has skinny extents
[   48.391412] BTRFS error (device dm-10): parent transid verify failed 
on 83880106754048 wanted 1169790 found 1061077
[   48.404444] BTRFS error (device dm-10): parent transid verify failed 
on 83880106754048 wanted 1169790 found 1061077
[   48.406191] BTRFS error (device dm-10): failed to read block groups: 
-5
[   48.438823] BTRFS error (device dm-10): open_ctree failed
[   48.455307] BTRFS info (device dm-10): disk space caching is enabled
[   48.455310] BTRFS info (device dm-10): has skinny extents
[   48.605760] BTRFS error (device dm-10): super_total_bytes 
70011474444288 mismatch with fs_devices total_rw_bytes 140022948888576
[   48.606835] BTRFS error (device dm-10): failed to read chunk tree: 
-22
[   49.024105] BTRFS error (device dm-10): open_ctree failed

Subsequent mount attempts fail with:
[49958.728511] BTRFS info (device dm-10): disk space caching is enabled
[49958.728512] BTRFS info (device dm-10): has skinny extents
[49963.631430] BTRFS error (device dm-10): parent transid verify failed 
on 83880106754048 wanted 1169790 found 1061077
[49963.631803] BTRFS error (device dm-10): parent transid verify failed 
on 83880106754048 wanted 1169790 found 1061077
[49963.631813] BTRFS error (device dm-10): failed to read block groups: 
-5
[49964.033692] BTRFS error (device dm-10): open_ctree failed

The filesystem spans multiple devices with all data & metadata stored as 
raid1.

$ sudo btrfs check /dev/mapper/b1d1crypt
Opening filesystem to check...
parent transid verify failed on 83880106754048 wanted 1169790 found 
1061077
parent transid verify failed on 83880106754048 wanted 1169790 found 
1061077
parent transid verify failed on 83880106754048 wanted 1169790 found 
1061077
Ignoring transid failure
leaf parent key incorrect 83880106754048
ERROR: failed to read block groups: Operation not permitted
ERROR: cannot open file system

$ sudo btrfs fi show
Label: 'cluster_storage'  uuid: 060fc2fb-5742-465f-898c-173b9db4b668
         Total devices 13 FS bytes used 20.75TiB
         devid    1 size 7.28TiB used 5.64TiB path /dev/mapper/b1d1crypt
         devid    3 size 2.73TiB used 1.09TiB path /dev/mapper/b1d3crypt
         devid    4 size 2.73TiB used 1.09TiB path /dev/mapper/b1d4crypt
         devid    6 size 2.73TiB used 1.09TiB path /dev/mapper/b1d6crypt
         devid    7 size 7.28TiB used 5.64TiB path /dev/mapper/b2d1crypt
         devid    9 size 2.73TiB used 1.09TiB path /dev/mapper/b2d3crypt
         devid   10 size 2.73TiB used 1.09TiB path /dev/mapper/b2d4crypt
         devid   12 size 2.73TiB used 1.09TiB path /dev/mapper/b2d6crypt
         devid   13 size 2.73TiB used 1.09TiB path /dev/mapper/b2d2crypt
         devid   14 size 7.28TiB used 5.64TiB path /dev/mapper/b1d2crypt
         devid   15 size 7.28TiB used 5.64TiB path /dev/mapper/b2d5crypt
         devid   16 size 12.73TiB used 11.09TiB path 
/dev/mapper/b1d7crypt
         devid   17 size 2.73TiB used 1.49TiB path /dev/mapper/b1d5crypt

$ uname -a
Linux htpc 5.4.0-37-generic #41-Ubuntu SMP Wed Jun 3 18:57:02 UTC 2020 
x86_64 x86_64 x86_64 GNU/Linux

$ btrfs --version
btrfs-progs v5.4.1
