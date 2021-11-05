Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F09446A04
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhKEUtB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbhKEUs4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:48:56 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AF4C061205
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:46:16 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id bm28so9873473qkb.9
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4XzByVSpKV9OqOEh1My2p7NA+CpPZXI4dSUcfK+/bCY=;
        b=RKy/Gc6FGNPVaEfCjn/FHJaQ6xoKXVV+T1pNN+QLjGQCUZjGOuhG2UaJLIqyeyvZ9K
         nzxWYmcuDPx6hlHoxB86hHMOi/w9PU6N1fxRcdOwfh8nEkDgBcduHTxJjpR+fguTP6yv
         Sb35girh1ehiLE6cj4HNTJ3wlpGQqXgyErH7YNBdidhNfjN9NEV032R7ANRE85/4gKMS
         r8ZCSJVUZ1YBb/hZc+HHXZU2PzeCnxAFxSSLoM0EIDqpsL9oTVT9fScVIAOVPiJkp9WF
         9P5dSeJG1GBIfh+ukrLGLo6Ki9kffJlIiZonVpT2zTtXSKuUJ4cnpS/6ga+qd/+Hrk0m
         o0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4XzByVSpKV9OqOEh1My2p7NA+CpPZXI4dSUcfK+/bCY=;
        b=N0PgYt5df5Gbt2RtizfkHs+E78u+Dov/EbXHEFUNi30O2CYNrlkZO8HHQ2H7O9FRKf
         9jSl1O0m3JeKIofODeVy8OBcmhVyxw4YBKDeoSg8iqdoaZNWk7LQ6GCT+5es5/Rzl9Zp
         nMX8EgV7WGQVgAyE3Z9/vSb3Re+ar0x8Fh78jcBw2ALRVRbyGfZARarKttW2K9sw2rk0
         M9+SD45V+VJGhkNFIVXrr1ud5ozUTWW2Ud+ihNZWaISgR+0hEDB0yvi/ARxm93G40fOj
         lWpmljkYakB3NWDx+MTV5bGVEOvrN12QqnJXr6ZhH/QHHyOKDDkLyNNOHBV0/t2MBEiv
         JVcw==
X-Gm-Message-State: AOAM530sqGArcdBheWdlurk69vIAc4yhboa9ZfEa3X3PQgmdRHNmhzgp
        08sblztjxtmKGrojiJCI9J13zp/cfeSawA==
X-Google-Smtp-Source: ABdhPJwGo33YO+4fa853MxeeJVpv7FrurkTON3M4QX5m9XlTNghdgliRXD00TBA3tIKygjwy8iud7Q==
X-Received: by 2002:a37:27cf:: with SMTP id n198mr12023564qkn.146.1636145175291;
        Fri, 05 Nov 2021 13:46:15 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y8sm6826238qtx.0.2021.11.05.13.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:46:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 16/25] btrfs: don't use extent_root in iterate_extent_inodes
Date:   Fri,  5 Nov 2021 16:45:42 -0400
Message-Id: <534f9c43d3a3f2a99d2f0b008c2791982f464b1a.1636144971.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144971.git.josef@toxicpanda.com>
References: <cover.1636144971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are going to have many extent_roots soon, and we don't need a root
here necessarily as we're not modifying anything, we're just getting the
trans handle so we can have an accurate view of references, so use the
tree_root here.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 72ca4334186c..0c5c7cc14604 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1969,7 +1969,7 @@ int iterate_extent_inodes(struct btrfs_fs_info *fs_info,
 			extent_item_objectid);
 
 	if (!search_commit_root) {
-		trans = btrfs_attach_transaction(fs_info->extent_root);
+		trans = btrfs_attach_transaction(fs_info->tree_root);
 		if (IS_ERR(trans)) {
 			if (PTR_ERR(trans) != -ENOENT &&
 			    PTR_ERR(trans) != -EROFS)
-- 
2.26.3

