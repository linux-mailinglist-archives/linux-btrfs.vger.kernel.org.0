Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0AC81794D9
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 17:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbgCDQSf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 11:18:35 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:42177 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgCDQSf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Mar 2020 11:18:35 -0500
Received: by mail-qk1-f172.google.com with SMTP id e11so2150095qkg.9
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Mar 2020 08:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rA4IKhVljl3YyOHSLGRxDBEaaFUgYvtjK6eXVNPQMrw=;
        b=HYAh3MKxswhUuG+SveL3eSbsRqFD/Wf99K8IEXoe0ZtTimCx4CurtbJ/Oi1dqQctcQ
         Qa8mU3C961p+ZcrzbYa4sXto55EPBxOX/AgdHI8flsAMPM17LxYIN5bw5O1mPq4bhlQ8
         yLaHudOHz15zfQngcqmVagqoNcms6O3TXfqJzhy6XQ7q+PF6DHvLE8xN6upN0eP9lDZl
         TGsnr7Ayi+oMFd+qYXP01MgG9Qor/Z//r1kZSWn8O2agqcqSGAix92KSKDPYK8dzOy8O
         3LJmzHHNP/PpWmAE2t80T95LETNeB7OLwOmE+ro0ZRQ2MkELhBbNyiliBi2TQ1rg/oP3
         2+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rA4IKhVljl3YyOHSLGRxDBEaaFUgYvtjK6eXVNPQMrw=;
        b=XmBrl9TIvq50fm59fzoNzBJoWrRhBn4YCImTjC0bQAe5m0gtXmiY9j5aE8w8iVxhJg
         PDLvsh2+kCM3GJPf8ml8i/HUXq8JQFHwm2TXigUWLV/j4VdRypWxU5YSln+PhdVx4hCl
         DPbrZd4Mfzsue65BJp/q928hTRVAMzJul792CzOTkUWMzF1YpLt58PO/FVbs3kHRE15V
         JrngNfKUzGUzZHx6hFq5+eXCAiqdxsmC3kwdz0Nq7vBnIXUw7RRFLh2V1aYHXODYqa7m
         lBAHS9airVW2bP6lDXYIN9rEt8VweXFgjvw06Q9o6bcU3cbyXGA10fe4uSle/uv2bYyM
         8MDA==
X-Gm-Message-State: ANhLgQ2adCFlGe2gb7LkPPqC9FbE7cWFSxWAL0OSoAeDHS9bvx2X0lzo
        PUk9M0ZCVjsrpXnYVWkFP2WbDOvZHYc=
X-Google-Smtp-Source: ADFU+vuiMCklHYnQmGJNIaVunxTSMuugzWWa4upYEGspkL6Mi8cWxH8TrVTLZ1VHeEWXJFTt2xAIRQ==
X-Received: by 2002:a37:a00e:: with SMTP id j14mr3731543qke.464.1583338712820;
        Wed, 04 Mar 2020 08:18:32 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k5sm1714577qte.25.2020.03.04.08.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 08:18:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/8][v2] relocation error handling fixes
Date:   Wed,  4 Mar 2020 11:18:22 -0500
Message-Id: <20200304161830.2360-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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


