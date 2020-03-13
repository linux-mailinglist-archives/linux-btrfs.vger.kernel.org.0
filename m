Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20641184B61
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 16:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgCMPoy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 11:44:54 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:33258 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbgCMPox (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 11:44:53 -0400
Received: by mail-qk1-f179.google.com with SMTP id p62so13252903qkb.0
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 08:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pDn0hxoQ4OTEyfaxajy2ZaHV0eSkb/uvcxLQnw+4EuQ=;
        b=dV3+GahRQe7+P7/1smOcZbLJavLw1bhLz9fXnMpKKukhcC9YZtgZJ68S2LyeZH7BI4
         LsHfwK18tZfB5wyWYf3p65PRXNUHA7WeTkAEw5wJD6Pl4/yyVgOksFDh/cyf2VjknZRB
         75eUHrjQ5dXRvlXTXtLgBdGR6qWkM46Pf9GmhGYJ3ejVoifHEtVc9XY4d1LMKxPFcyKh
         s1t7O/Bh1NaUneM7OakF+yyVFbJdajS3sosvO+CDdcPCpJQ58YX1O1JiSL8i1HiwC1xn
         5I2LWfEqVwsmdgfbFnP2T0cdMl4eMXdSAB/z84wz8zxDuCp8bRduXayqr6rhgOByMDuV
         KN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pDn0hxoQ4OTEyfaxajy2ZaHV0eSkb/uvcxLQnw+4EuQ=;
        b=rWXNLZM9IMco7iCTQtkKj/fN3vexrSI34Tqu1dedTQimlC7xXIFyH4Obwq7CMqU/2Q
         eNOrXScXn+UYohZg5kmQNQVGz1LBZ6bxHybu2KQmorsVkDU0Xht67gHn8KNBpqon4CEe
         Jg7kCJOsC64RF5MmjML686mmaHc4aUbwMC4LUdipq/r6UrcEfJazQUNETD8wfuOo1K2r
         KX6D8oU7cSUKnRudSpY1qMg4XRhVyHoLp4HTxXv/hBxVvCQ0Wo8oPjCYJQ5/d4UQpX8/
         UtRzaKM7VYmcMG4q7I22Qh3nXWGHpHaSz6u4THVEZhEJPwUu4VnC8KkLYD99D4FtfueN
         G3sg==
X-Gm-Message-State: ANhLgQ0K+e9wtPLcH/BIjNYo2Y7y1yCC4Od/pI1AI3v0z1/ni1znnEfV
        j09fPaHFWxTgab8dSySukjRKmbnwNDY=
X-Google-Smtp-Source: ADFU+vt0avACjeEzRSmqaCI7GwnscKFC8iIPCYFGtGDMvo8vJzfe+9yUhZZmiAJo6St6cL5A4vNPHw==
X-Received: by 2002:ae9:dec7:: with SMTP id s190mr12859811qkf.303.1584114291291;
        Fri, 13 Mar 2020 08:44:51 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 199sm11434573qkm.7.2020.03.13.08.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 08:44:50 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/8][v3] relocation error handling fixes
Date:   Fri, 13 Mar 2020 11:44:40 -0400
Message-Id: <20200313154448.53461-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2->v3:
- Updated the free reloc control to use the rbtree postorder thing.
- Updated the changelog for patch 6.
- Fixed the error goto in patch 5.
- Added the reviewed-bys.

v1->v2:
- Incorporated the various feedback, tweaked some things, adjusted commit
  messages, added some more comments.  Hopefully I got everything.
- Added "btrfs: do not init a reloc root if we aren't relocating", this is to
  oddress the weird handling of DEAD_ROOT and the use-after-free that Qu had
  originally attempted to fix.
- Reworked "btrfs: splice rc->reloc_roots onto reloc roots in recover" to simply
  handle cleaning up any remaining bigs on the reloc_control, since errors can
  mean we'll have some things left pending on the reloc_control.

------------------------------ Original email ---------------------------------
My root ref patches have uncovered weird failures in some of our xfstests,
particularly those that do balance while having errors.

I ran relocation through my eio-stress bpf script and loads of things fell out,
these are the fixes required to make the stress test run to completion.

Dave this is just based on my master, I assume it'll apply cleanly to what you
have, but if not let me know which branch you want me to rebase onto to get it
to work right.

Most of these are straightforward, the only tricky/subtle one is 7/7, and I've
added a lot of explanation there around my reasoning.  6/7 is also a little bit
more complicated as it changes the rules slightly for reference holding for
roots.  Before we just sort of hoped and prayed we go the right reference
dropped when we dropped root->reloc_root.  Now we hold one ref for the list of
reloc roots and one ref for root->reloc_root, so it's more clear when we need to
be dropping references.  Everything else is relatively straightforward.  Thanks,

Josef

