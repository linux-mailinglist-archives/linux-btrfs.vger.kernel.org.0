Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7812D2F7E
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbgLHQZp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730364AbgLHQZo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:25:44 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79519C061749
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:24:49 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id w79so5385458qkb.5
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rXkllivM/LlDIU6qMHpbw+hMYUQ5EKZq1LEuGXDx7tg=;
        b=k2mwtnk0YmfpvaLaaeSVY1GCyXk0xVSdHjbeKlnnWO2hy7ntfy9SnsFcYb1+ugigzI
         tQdOqf3xafjoEFtjC+ZksFtKGhTMxDiwqlWX77WwqFuPcTLFyAKm/VNGUTAEXvt0f+6r
         ZvoKC8tj+rptfPdSvapHG90N0+Y19QiqU/vH4uB5NHOnXxK7ZfZwfYVjn/LH6wcaTF8t
         xtof3IstJcAXxDnZCjXGFzWpF8iGQgeWLyBVN8p6Q/979jH7CR71h05crLMxDaD0VixB
         h1uxOuD++03FHUWPa00YGseCgIj0L0TTEcS3+rOrdfZce29WQw2AxBmPH/oCV+/3Gz6n
         njEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rXkllivM/LlDIU6qMHpbw+hMYUQ5EKZq1LEuGXDx7tg=;
        b=fSDc96X5kozb5N0jtv1W9gsL/CvrPowm5mfmeAjDV79jG8EhIBhk7N3TSUHIl/Gewz
         iOc256xKw23fIQvl6CRbHhXjN5tfCTQ75VZHg+vouzE+MBCAC36+KVKidqCBZwBga/pO
         DSuAQYlWMTw1USATDXMsswuBbnzl+w9/YlyJeCUTfnXLTrnjIRYGR8n4CpF8ZDuEhga8
         f0MNsJ5K/EMX0Zej58y+tJ4IlMvnERzMrUgqu7Vbl+B1oPPXRCZJRWdzd2jVyf3TbmFx
         uLSTTzxeAXbXiEgEz5H1a5YgE52Z/oGsnfVKf1zORukERHEp0hJFgY1c/aiI7JeD+gin
         Mb3w==
X-Gm-Message-State: AOAM533yDCtaapydeO9noNGaVNLkhlFhU5jbdGJMt+ZPQ6yelCYyMukd
        PglAqg4AgNCriR2mBa60nSkB6Qn299G/rrMB
X-Google-Smtp-Source: ABdhPJzNpIezimQz4bYkMJp/6TWD0cl61thThW13NX/I98EkvESZXoovAqwqKMuvRtKpnHdEVoSvwA==
X-Received: by 2002:a37:458:: with SMTP id 85mr22326373qke.61.1607444688439;
        Tue, 08 Dec 2020 08:24:48 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n2sm2018054qkf.37.2020.12.08.08.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:24:47 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 21/52] btrfs: handle btrfs_record_root_in_trans failure in create_subvol
Date:   Tue,  8 Dec 2020 11:23:28 -0500
Message-Id: <84a86e27e5966f58688f05a277c412358e0b9d08.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in create_subvol.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index af8d01659562..2d0782f7e0e0 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -714,7 +714,12 @@ static noinline int create_subvol(struct inode *dir,
 	/* Freeing will be done in btrfs_put_root() of new_root */
 	anon_dev = 0;
 
-	btrfs_record_root_in_trans(trans, new_root);
+	ret = btrfs_record_root_in_trans(trans, new_root);
+	if (ret) {
+		btrfs_put_root(new_root);
+		btrfs_abort_transaction(trans, ret);
+		goto fail;
+	}
 
 	ret = btrfs_create_subvol_root(trans, new_root, root, new_dirid);
 	if (!ret) {
-- 
2.26.2

