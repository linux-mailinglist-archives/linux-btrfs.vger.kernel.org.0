Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17EEB20F6A0
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 16:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388768AbgF3OAP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 10:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388626AbgF3OAM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 10:00:12 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D01DC061755
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 07:00:12 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l6so18626229qkc.6
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 07:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lim8CI6lg+mJedJh/Lpz8jxCpGnkjsJYsJSjoJQNZIU=;
        b=dDzcsr4SPXKKDBVRGaPOl90jsZYvamL/mxZDzCVQc8XC9irQKONvYAItyL2fb+kFK7
         Gy08I3EgFlmevIAGt3yQKIQwWKoqbD393wPvOkiePh78ETfcFsBQ+qD1j09CoUuKNIWG
         b6G9Rbh6/IvL7hTd1tKaK6OpKsEc6d75qx0UwIGLaV3yi04hrxlObG8moMcGf8P7lXPj
         VyBEk4dk/DJsi07y99jU2rj2x9WPZHO4JC9G9f8a59Jl4UbAssEeSbl9+CZ5gfCnZcoe
         5poysWzUxLSaKlCNCEfFL6cN6SkST1YZZiOfrc8smynDjrzV7GPpeXSQwEr2HeP3wNAw
         7ENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lim8CI6lg+mJedJh/Lpz8jxCpGnkjsJYsJSjoJQNZIU=;
        b=tBPlyIwAGTShTggF4lfhkVlQHYtx0beCt5rLEwve6cSV1vkkeYdnybOQplkaVQvWY5
         ZQm3TYJj7JEmiUBY461ZLtG7NJpcp4JOJe+Cq5z6PNFVlzmYIfdwGUWeDHcWbpHSfp89
         26TcweLZHVkUW0lsLzxrGNaElSv+wmy+QSlkkWj5a4oyJN7p4DnJzhhr0J15XHSOjYl0
         +wZkuldqKQnYA3yAUpNmkxzOCsxaTcLz1S1ddem6XT1Cg4/IEMhnRyNgjuoMtrWTLftn
         Lrahc7gU+nKe6qYJxLKrfSwGw45U00kZ/4DXVLFRojgin7W+CuKLbDGovBq+Qkd/nXfY
         DCiw==
X-Gm-Message-State: AOAM5321Fq8vfmFuL0ZF4ItwTlMIdxGclVh4lnn/eIBf+utU5at385iR
        Gv2q55hvUcr/qeH7VNIB5gQB5Go7ECJ2Fg==
X-Google-Smtp-Source: ABdhPJywjt1+jgt+lUu2oXtQNAFU9iR3oa7jEWKJPJv9ZDwrQGGl6OnJaxmtkqbFcWKumjG2ghsuKA==
X-Received: by 2002:a37:8905:: with SMTP id l5mr19135937qkd.302.1593525610425;
        Tue, 30 Jun 2020 07:00:10 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k45sm3663340qtc.62.2020.06.30.07.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 07:00:09 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 21/23] btrfs: flush delayed refs when trying to reserve data space
Date:   Tue, 30 Jun 2020 09:59:19 -0400
Message-Id: <20200630135921.745612-22-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200630135921.745612-1-josef@toxicpanda.com>
References: <20200630135921.745612-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can end up with free'd extents in the delayed refs, and thus
may_commit_transaction() may not think we have enough pinned space to
commit the transaction and we'll ENOSPC early.  Handle this by running
the delayed refs in order to make sure pinned is uptodate before we try
to commit the transaction.

Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index ba09085b6122..8b1a5b644d2f 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1021,6 +1021,7 @@ static const enum btrfs_flush_state evict_flush_states[] = {
 static const enum btrfs_flush_state data_flush_states[] = {
 	FLUSH_DELALLOC_WAIT,
 	RUN_DELAYED_IPUTS,
+	FLUSH_DELAYED_REFS,
 	COMMIT_TRANS,
 };
 
-- 
2.24.1

