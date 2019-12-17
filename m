Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2CF12306A
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfLQPgk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:36:40 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:41267 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfLQPgk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:36:40 -0500
Received: by mail-qk1-f169.google.com with SMTP id x129so1113322qke.8
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/mnZRjCmSTDeTgbGrjJ172DqwTKNljSe5Kc8XD2Rsus=;
        b=UHwMYszx0ses1lXMuatON/jHde8Qo6Q49kVvDcLZFkhmbDxyVEGFAvvUkkxyXfJJfK
         Sr7ICTkihmQJ7K6XDlze0q2xwbXeOqu0dbLmHUGOCEvC55+VQMImxPZ7AVbOyWLFA1O4
         +EKhRrRC+lJhAU/N6hi50gWe1n4sd5wnoigvMXO7lbqAUuxqn1XhdSRlYM5mlz88euQM
         MVXzho7BymNnn/L0Ri5BjbMqeOG1NPmTRGqBpW5/8jLh9j5XF+4Al95SQa7EbYr3/HRt
         ZdWC8oXgwCpOrZdsxVXAxLF24SsGyBY2suaLBn4LHwys5W14UgigG3CSCcF2VfbMCE3c
         4Osw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/mnZRjCmSTDeTgbGrjJ172DqwTKNljSe5Kc8XD2Rsus=;
        b=KZH84Q+IH51aTyOfCaJqNcTR9KaWVupZwY2PutoHgNexMJq04vxmg0pZP1Y7e7V6w0
         v6CwARC0q/4gzI3SIhFMSeUUt2WnCYPHYTaGec/O1ln3Jbj/zfr8L9NlkX25UrSjXNTu
         zImIiwRNX6KPAivbaQRrLAq6a0uChwZC3alU7AuzZ88tFwZUjPRl5VfWTJIrYvB/492W
         IHj1GDRTxEk8iv22iY0o02uM9qeYe3nim4eu+HC2Uiw0b4+LLZKZZUIAdcDLX776s9QI
         Xu/mGDyZRQRS3bgHVWjBNxyhh1UaxyTn5jtJDoO0gJZ4jW9cnQ8x8gULay0eHwzry14O
         CD5Q==
X-Gm-Message-State: APjAAAX/hzkbWDnBdSVkPg5FTrkXcTyuwVVFbuwhi/CQJnl8eIC/DADi
        YI4jqHKEY2npqVKBcGJ9dRluyJYRU0cwXw==
X-Google-Smtp-Source: APXvYqwtjlR77k1P+dOHgLsTL8EJbQsoCQpFxLYZQd62IMvLKSi4d+OBkb89JPBmv7WeD4HWzA5LzA==
X-Received: by 2002:a05:620a:a87:: with SMTP id v7mr5455895qkg.72.1576596998611;
        Tue, 17 Dec 2019 07:36:38 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o81sm7188672qke.33.2019.12.17.07.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:36:37 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/45][v2] Cleanup how we handle root refs, part 1
Date:   Tue, 17 Dec 2019 10:35:50 -0500
Message-Id: <20191217153635.44733-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- Fixed a error missed put in an error condition in relink_extent_backref
- Added "btrfs: make the init of static elements in fs_info" so that we could
  clean up fs_info init and make the leak detectors work for the self tests.

-- original email --
In testing with the recent fsstress I stumbled upon a deadlock in how we deal
with disappearing subvolumes.  We sort of half-ass a srcu lock to protect us,
but it's used inconsistently so doesn't really provide us with actual
protection, mostly it just makes us feel good.

In order to do away with this srcu thing we need to have proper ref counting for
our roots.  We currently refcount them, but only to handle the actual kfree, it
doesn't really control the lifetime of the root.  And again, this is not done in
any sort of consistent manner so it doesn't actually protect us.

This is the first set of patches, and yes I realize there are a lot of them.
Most of them are just "hold a ref on the root" in all of the call sites that
called btrfs_read_fs_root*() variations.  Now that we're going to actually hold
references to roots we need to make sure we put the reference when we're done
with them, so these patches go through each callsite and make sure we drop the
references appropriately.

Then there's a variety of cleanups and consolidations to make things clearer and
make it so we only have 1 place to get roots.

Finally there's the root leak detection patch.  I used this with a bunch of
testing to make sure I was never leaking roots with these patches.  I've been
testing these for several weeks cleaning up all the corners, so they should be
in relatively good shape.  Most of the patches are small so straightforward to
review.

This is just part 1, this is the prep work we need to make the root lifetime a
little saner, and will allow us to drop the subvol srcu, as well as the inode
rbtree.  It doesn't really fundamentally change how roots are handled other than
making the refcounting actually protect us from freeing the root while we're
using it.  That work will come later.  Thanks,

Josef


