Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DCE1C2155
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 01:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgEAXoZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 May 2020 19:44:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgEAXoY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 May 2020 19:44:24 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51BCC2184D
        for <linux-btrfs@vger.kernel.org>; Fri,  1 May 2020 23:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588376664;
        bh=HsGz60nfWw6vsHt4t5wHnBYIijGvDBsVNptCbEJHGcU=;
        h=From:To:Subject:Date:From;
        b=zc66qp15uWnmebbeqAjed5Lp3SSZ3P8wwjHeuyXJCGsLdi+rWK7SxoUJHyI0wVoJS
         BB3TPSb4QZEtCGaiAvmfnnj7hWOfj/hMeQF7GB2yVPFcEW2riNd0/8f/uqXXlYTXde
         0OgMlAvvMGZOsnOARy7U22dkwjCQKZMnAPT48ptI=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] MAINTAINERS: btrfs: fix git repo URL
Date:   Fri,  1 May 2020 16:44:17 -0700
Message-Id: <20200501234417.52402-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The git repo listed for btrfs hasn't been updated in over a year.
List the current one instead.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9271068bde639b..1afa64544a8c6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3653,7 +3653,7 @@ M:	David Sterba <dsterba@suse.com>
 L:	linux-btrfs@vger.kernel.org
 W:	http://btrfs.wiki.kernel.org/
 Q:	http://patchwork.kernel.org/project/linux-btrfs/list/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mason/linux-btrfs.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git
 S:	Maintained
 F:	Documentation/filesystems/btrfs.rst
 F:	fs/btrfs/
-- 
2.26.2

