Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0AA3B693C
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 21:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbhF1Tm3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 15:42:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44094 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbhF1Tm3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 15:42:29 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BEA9720327;
        Mon, 28 Jun 2021 19:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624909202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=orw4V/C6voSWPUbPwntGQoGuxvwFxGoNhnAQkh+piiA=;
        b=RSKn7TXg3wj4NgCRWemprdJNZLaZr+6VPsvdm2Wi0AUpLFW9Ve8M/5EY9ic0I2S9+jP4tf
        FaucJmRVbVTYV4Szh8vpxT+CwW8sD36bbMjI99QDkLLeFY2P6b77XeSslnvtzN9Aqvpso0
        7RQfS+Sv3s05c21w+9YYzFflpn7iOUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624909202;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=orw4V/C6voSWPUbPwntGQoGuxvwFxGoNhnAQkh+piiA=;
        b=B0UEMA9otJQ1LrMYQ3sN38S1tIE24IMxFs+gJRL4mv3ibCq6QMai2QyP5fvKC2Y57cFjOP
        Pq/QwTFm80TP8qDA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 5867D11906;
        Mon, 28 Jun 2021 19:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624909202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=orw4V/C6voSWPUbPwntGQoGuxvwFxGoNhnAQkh+piiA=;
        b=RSKn7TXg3wj4NgCRWemprdJNZLaZr+6VPsvdm2Wi0AUpLFW9Ve8M/5EY9ic0I2S9+jP4tf
        FaucJmRVbVTYV4Szh8vpxT+CwW8sD36bbMjI99QDkLLeFY2P6b77XeSslnvtzN9Aqvpso0
        7RQfS+Sv3s05c21w+9YYzFflpn7iOUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624909202;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=orw4V/C6voSWPUbPwntGQoGuxvwFxGoNhnAQkh+piiA=;
        b=B0UEMA9otJQ1LrMYQ3sN38S1tIE24IMxFs+gJRL4mv3ibCq6QMai2QyP5fvKC2Y57cFjOP
        Pq/QwTFm80TP8qDA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 1lj1CpIl2mDTIgAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Mon, 28 Jun 2021 19:40:02 +0000
Date:   Mon, 28 Jun 2021 14:40:00 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Dave Sterba <DSterba@suse.com>
Subject: [PATCH] btrfs-progs: Correct check_running_fs_exclop() return value
Message-ID: <20210628194000.org5zuvytk34yvwy@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

check_running_fs_exclop() can return 1 when exclop is changed to "none"
The ret is set by the return value of the select() operation. Checking
the exclusive op changes just the exclop variable while ret is still
set to 1.

Set ret = 0 if exclop is set to BTRFS_EXCL_NONE or BTRFS_EXCL_UNKNOWN.
Remove unnecessary continue statement at the end of the block.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 common/utils.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/utils.c b/common/utils.c
index 1627913a..3c562247 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -1771,7 +1771,8 @@ int check_running_fs_exclop(int fd, enum exclusive_operation start, bool enqueue
 			tv.tv_sec /= 2;
 			ret = select(sysfs_fd + 1, NULL, NULL, &fds, &tv);
 			exclop = get_fs_exclop(fd);
-			continue;
+			if (exclop <= 0)
+				ret = 0;
 		}
 	}
 out:
-- 
2.32.0


-- 
Goldwyn
