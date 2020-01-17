Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7D6140BE9
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 15:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgAQOC2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 09:02:28 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]:36542 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQOC2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 09:02:28 -0500
Received: by mail-qk1-f176.google.com with SMTP id a203so22758016qkc.3
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 06:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BWqDIISilEOyIIhUAEMSJUpOl3VqUEtk0rxE/2iAdiU=;
        b=gnpOGaE0PjXWzzVWY5+vvADYoiRU3sBhXG8aPqCRmd5tl78HwHjcDkI2+KA4qz0cJe
         1gxNrpEiIND6BevUK3C4OxWDgMWPCmUjmWpNWnFv4MWe6cpvEsmzP+q0Qfk4PQzWh/X6
         sHh8XN6q4cCF2vwBIOMUaAffG5s4xQ7ivYe/HBKXrmyjCUpcmq6kSJxuthqjYgPhsMjh
         akRLkfnZ1FrbU9/AI5IL6xbysfomZxFGX0fp4/wUMM8N03NOjkpYuXwZ5hB7s7M/G/gE
         CwhqjHWDbR1mpuSRB8uyNTRcd2mBIhRO+lvlyeV4gu1Jh1h2xKRGGwlCdLBclp8lFNWM
         OISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BWqDIISilEOyIIhUAEMSJUpOl3VqUEtk0rxE/2iAdiU=;
        b=EOIatWkrVKIUgWIY9DHo4ms/AVqn/+JXe39E0EkkLDTcY+wCX5uKMEE4Hg+YP+1FAZ
         Mj0rwJAsEjL8ERMnjw8s+LpRV8BTjyC+pIXFZFoPUgGRqieIXg8Ze6hcgx1TbcGHRNM6
         PJ+QTkyKEiX3aJq0od9u86uq/TPcEaKUUQpxL4hN36VykVtneCdj/5W1Om9rQ5EqCAIV
         rxpDYnGveqhWt3jH7d6GmqzM5iAxo3XvQ+BNIq2AkKW+Yp2UgUbj0e6kitPKvOtGNR2L
         gwxOC+5N8AmurD4IPUh1VurPTxVwOwBGjvh3yQhcedcMkDYErlN1ROhcXJA9/b6SvNTO
         r/uQ==
X-Gm-Message-State: APjAAAWZdwA0E/2FasG8QSlG0M008Tru+r6+el8RjUo9boSvU6OH/mAX
        J2Gp6/dU15eJaaKpkuUKAfOF/qvt8GFU3g==
X-Google-Smtp-Source: APXvYqxAaV2PjuOgH+ttzcY+/C1bUmBYZ/tO2wQXIU4JAfOFQUpnyOAvTaKrqtgr/zXEW8Z6hbFQXQ==
X-Received: by 2002:a05:620a:224:: with SMTP id u4mr557093qkm.239.1579269747239;
        Fri, 17 Jan 2020 06:02:27 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l49sm13230183qtk.7.2020.01.17.06.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 06:02:26 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/6][v3] btrfs: fix hole corruption issue with !NO_HOLES
Date:   Fri, 17 Jan 2020 09:02:18 -0500
Message-Id: <20200117140224.42495-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2->v3:
- Rebased onto misc-next.
- Added a patch to stop using ->leave_spinning in truncate_inode_items.

v1->v2:
- fixed a bug in 'btrfs: use the file extent tree infrastructure' that would
  result in 0 length files because btrfs_truncate_inode_items() was clearing the
  file extent map when we fsync'ed multiple times.  Validated this with a
  modified fsx and generic/521 that reproduced the problem, those modifications
  were sent up as well.
- dropped the RFC

----------------- Original Message -----------------------
We've historically had this problem where you could flush a targeted section of
an inode and end up with a hole between extents without a hole extent item.
This of course makes fsck complain because this is not ok for a file system that
doesn't have NO_HOLES set.  Because this is a well understood problem I and
others have been ignoring fsck failures during certain xfstests (generic/475 for
example) because they would regularly trigger this edge case.

However this isn't a great behavior to have, we should really be taking all fsck
failures seriously, and we could potentially ignore fsck legitimate fsck errors
because we expect it to be this particular failure.

In order to fix this we need to keep track of where we have valid extent items,
and only update i_size to encompass that area.  This unfortunately means we need
a new per-inode extent_io_tree to keep track of the valid ranges.  This is
relatively straightforward in practice, and helpers have been added to manage
this so that in the case of a NO_HOLES file system we just simply skip this work
altogether.

I've been hammering on this for a week now and I'm pretty sure its ok, but I'd
really like Filipe to take a look and I still have some longer running tests
going on the series.  All of our boxes internally are btrfs and the box I was
testing on ended up with a weird RPM db corruption that was likely from an
earlier, broken version of the patch.  However I cannot be 100% sure that was
the case, so I'm giving it a few more days of testing before I'm satisfied
there's not some weird thing that RPM does that xfstests doesn't cover.

This has gone through several iterations of xfstests already, including many
loops of generic/475 for validation to make sure it was no longer failing.  So
far so good, but for something like this wider testing will definitely be
necessary.  Thanks,

Josef

