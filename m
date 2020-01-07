Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDAB5132FA8
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 20:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgAGTml (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 14:42:41 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:34047 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGTml (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jan 2020 14:42:41 -0500
Received: by mail-qt1-f176.google.com with SMTP id 5so779851qtz.1
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jan 2020 11:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uOUe50AQMPmlCxxQmhUbhAt4AGkQ8LJSdR5U9Vgm8ok=;
        b=fNLf5uXwAX9he7v/zBkI1z5tbKOwKkjCB6s0eNA0r/OBNrxhgf+0rhPU1e5hRfrgtS
         wsMUxwDbmnPmZkDEnPv2fsnmUvLf0xI6sLLLovWt5KW/VRrybQ0PYS3OK/kHlrzU+RWd
         7pGb5uLNw5CT06KLgq5eVM7G4ya3KG0UGLfNjuk3sGq2ZszxSPI+d0XcGFqguF6l5CvQ
         MqimoBxjCguGmI89G4KS+zh2a3RiwR/333z/FTZZll+eBCjKo3pwmPDAcpkRBJzNxRQr
         6iLpmREn+I3tLdRTFnf8dAsD0jTTR5QYhbbwae7V80KXoDohOiY80WX91aMgDkx9FStK
         Xlpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uOUe50AQMPmlCxxQmhUbhAt4AGkQ8LJSdR5U9Vgm8ok=;
        b=Wm7an09cFqCB1qVxIFBjzECatlo1+cdQwFvbjhdMoDThlOfB5qJhMQ7lua1QpJ61tH
         Tnns5hN9f4eowrCB83IqHCoCTMyK1aebG0wLtUcRaSjC13+a94M4DIdgTS1USu4l4wVF
         xgAskHHd7/21BTEHwlXWJFxepwHwcyB8a1mVF+azdAI1ieYYKFTkkUivUzqSx92eVsbX
         L2CDRFHplEPzf2Vu31SVm/rDDKE2YQGl3yTRd4fy61r975n99U2O0gaA5esEBiMAclcQ
         8n5RthE60C/JNDokgqRP3G/lMyOFi3I9aQye35RiWEbnrSXRCjKB0ym1DCeuL3V02/oi
         kwzA==
X-Gm-Message-State: APjAAAWzSfKw4TkgvYWnDO1NLOdA5hpZHErHYAbSlfnTj8nf8kBabOgr
        KHXYCgIyxYNN9ifGX3nm1uUnBCjL55646A==
X-Google-Smtp-Source: APXvYqzg2h3yFs/7msx/tUHRbSqY98KPd8CPTCiVkF75noiGB4yTKlHL8qothigOCKf1n7oVRK5zWg==
X-Received: by 2002:ac8:fae:: with SMTP id b43mr561067qtk.122.1578426160231;
        Tue, 07 Jan 2020 11:42:40 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e64sm360291qtd.45.2020.01.07.11.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 11:42:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/5][v2] btrfs: fix hole corruption issue with !NO_HOLES
Date:   Tue,  7 Jan 2020 14:42:32 -0500
Message-Id: <20200107194237.145694-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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

