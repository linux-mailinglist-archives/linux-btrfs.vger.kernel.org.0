Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277233F5275
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 22:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhHWUw5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 16:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbhHWUw4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 16:52:56 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C32C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 13:52:13 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so852488pjt.0
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 13:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newfietech-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=cN4G448tw+MnnMUKER4HBXxxF05LVmiACEwf5tZflUA=;
        b=UG31eToLqq/9lKNk0xS708q8HBbfyheohIrzxqYgFKKLFBrmoOqx24dUtGIZMErEFc
         tQA4QwdOjDoP8chYp63KLz/sH9U6D+HEqmQRH8S8LCWUk/LXk0dnfgCsAV5pTmpW0gZR
         M+S6fbrrY9myLJuVDix1upKIftwnPvfo2F1WqAE8AIih/NmXwS2tvq3cqYzryrgLIzpn
         YZWh735BHIKuxMC8V92hKM/19vmw/Nz/susWI8EqGgFqatUztLr73T4lWTquhL79AnpG
         3xWCzmsTWcS18qnEjdaov94iXpD7Kd0I4sbx349bbzZimikmgftqZcb/INA0FhUDKE9P
         MV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=cN4G448tw+MnnMUKER4HBXxxF05LVmiACEwf5tZflUA=;
        b=uRtkqxzocpmoWbWqhChFa9hajRR+dNOUIAXdh+igwFYZJDQH0RcTxLeyS2RB+fJOVC
         JyHOQkIak3pLfAekyHo86eFCtME+35TwBhTWJmqQ80JVh7SXxJj9Voj3CK0iOE+uFcXI
         iljFMCZyK+AUY0loZJbdC68mKQ8iMo4cclT/z6A7mU8MAV5qP3TmuRIFQOJ1FDeQI4na
         pDsqWB3OMG1x0B+jpaP1mnBief8Kd3/9m+N5OVDzCBqK9mD1FccuVz+q7LIGlCre1RNS
         pa4YfScHrVsuaa8w94uechZJe9dIWqOHzmIXNih6W76hUsPAfqurNjeEZ93VFLt21br3
         reAA==
X-Gm-Message-State: AOAM531oDOG2SovcNWP4tOJ0upT3Qu+WnqUcp7Jile8SFOBDHzTjUr95
        cqnH6LdztmMDlSuuzsW2jYwk4Ii2df4kMxTM
X-Google-Smtp-Source: ABdhPJyiKzhGmOfFsWxLa5lVE39sJvUCiie5HfluQEtYmmjdQQuKm42YeuhHLtJUhPV/0K7skuClHg==
X-Received: by 2002:a17:902:7049:b0:131:bdef:522d with SMTP id h9-20020a170902704900b00131bdef522dmr14138140plt.85.1629751932684;
        Mon, 23 Aug 2021 13:52:12 -0700 (PDT)
Received: from R9 (d137-186-110-25.abhsia.telus.net. [137.186.110.25])
        by smtp.gmail.com with ESMTPSA id ge6sm128115pjb.52.2021.08.23.13.52.11
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Aug 2021 13:52:12 -0700 (PDT)
From:   <weldon@newfietech.com>
To:     <linux-btrfs@vger.kernel.org>
Subject: BTRFS fails mount after power failure
Date:   Mon, 23 Aug 2021 14:52:10 -0600
Message-ID: <005201d79860$befd1b60$3cf75220$@newfietech.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdeYYK13y5DIhpmsSQihSFnAc1knqg==
Content-Language: en-ca
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Good day folks,

I awoke this morning to find that my UPS had died overnight and my =
Ubuntu
server with a 14.5TB (Raid 5) BTRFS volume went down with it.=A0 The =
machine
rebooted fine and the hardware reports no errors, however the BTRFS =
volume
will no longer mount.  The OS boots fine, the 14.5TB volume is for data
storage only.=A0 gparted shows the volume/partition,=A0 and correctly =
reports
space used as well as total size.  I've never encountered this type of =
issue
over the past year while using btrfs and I'm not sure where to start.=A0 =
A
number of google search results express caution when attempting to
recover/repair, so I'm hoping for some expert advice.

My dmesg log exceeds the 100,000 bytes restriction, so I'm unable to =
attach
it, so please ask if there's anything specific I can include otherwise.

# uname -a
Linux onyx 5.4.0-81-generic #91-Ubuntu SMP Thu Jul 15 19:09:17 UTC 2021
x86_64 x86_64 x86_64 GNU/Linux

# btrfs --version
btrfs-progs v5.4.1

# btrfs fi show
Label: 'Data'  uuid: 7f500ee1-32b7-45a3-b1e9-deb7e1f59632
        Total devices 1 FS bytes used 7.17TiB
        devid    1 size 14.50TiB used 7.40TiB path /dev/sdb1

# dmesg | grep sdb
[    2.312875] sd 32:0:1:0: [sdb] Very big device. Trying to use READ
CAPACITY(16).
[    2.313010] sd 32:0:1:0: [sdb] 31138512896 512-byte logical blocks: =
(15.9
TB/14.5 TiB)
[    2.313062] sd 32:0:1:0: [sdb] Write Protect is off
[    2.313065] sd 32:0:1:0: [sdb] Mode Sense: 61 00 00 00
[    2.313116] sd 32:0:1:0: [sdb] Cache data unavailable
[    2.313119] sd 32:0:1:0: [sdb] Assuming drive cache: write through
[    2.333321] sd 32:0:1:0: [sdb] Very big device. Trying to use READ
CAPACITY(16).
[    2.396761]  sdb: sdb1
[    2.397170] sd 32:0:1:0: [sdb] Very big device. Trying to use READ
CAPACITY(16).
[    2.397261] sd 32:0:1:0: [sdb] Attached SCSI disk
[    4.709963] BTRFS: device label Data devid 1 transid 120260 /dev/sdb1
[   21.849570] BTRFS info (device sdb1): disk space caching is enabled
[   21.849573] BTRFS info (device sdb1): has skinny extents
[   22.023224] BTRFS error (device sdb1): parent transid verify failed =
on
7939752886272 wanted 120260 found 120262
[   22.047940] BTRFS error (device sdb1): parent transid verify failed =
on
7939752886272 wanted 120260 found 120265
[   22.047949] BTRFS warning (device sdb1): failed to read tree root
[   22.089003] BTRFS error (device sdb1): open_ctree failed

root@onyx:/home/weldon# btrfs-find-root /dev/sdb1
parent transid verify failed on 7939752886272 wanted 120260 found 120262
parent transid verify failed on 7939752886272 wanted 120260 found 120265
parent transid verify failed on 7939752886272 wanted 120260 found 120265
Ignoring transid failure
WARNING: could not setup extent tree, skipping it
Couldn't setup device tree
Superblock thinks the generation is 120260
Superblock thinks the level is 1
Well block 7939758882816(gen: 120264 level: 1) seems good, but
generation/level doesn't match, want gen: 120260 level: 1
Well block 7939747938304(gen: 120263 level: 1) seems good, but
generation/level doesn't match, want gen: 120260 level: 1
Well block 7939756146688(gen: 120262 level: 1) seems good, but
generation/level doesn't match, want gen: 120260 level: 1
Well block 7939751559168(gen: 120261 level: 0) seems good, but
generation/level doesn't match, want gen: 120260 level: 1

*** A large selection of block references was removed due to character
count... if needed, I can resend with the full output.

Well block 1316967743488(gen: 1293 level: 0) seems good, but
generation/level doesn't match, want gen: 120260 level: 1
Well block 1316909662208(gen: 1283 level: 0) seems good, but
generation/level doesn't match, want gen: 120260 level: 1
Well block 1316908711936(gen: 1283 level: 0) seems good, but
generation/level doesn't match, want gen: 120260 level: 1
root@onyx:/home#

Any help or assistance would be greatly appreciated.  Important data has
been backed up, however if it's possible to recover without thrashing =
the
entire volume, that would be preferred.

Regards,
Weldon

