Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5F711A22C4
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Apr 2020 15:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgDHNPX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Apr 2020 09:15:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41111 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgDHNPX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Apr 2020 09:15:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9so7766579wrc.8
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Apr 2020 06:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=q5NRqQ/Pd7yu7xBdLNTwU7Nrqby8mAe+y6vZEBSVJ5o=;
        b=YOxSpxq4UcAuqgwbEtJTFkLmkw0O6IePuC6bF6QrvZjQ+tGRQq/vKaNdcP+hSvvhAh
         8BkJ/ClyHElgNpCHar678dQ6xrqLN9GywMR5aJymrHwcM2UqXuraVrBFw2npNQ1+8mPI
         WwyhdQSz5qTNbcLnR/ngdCOjjLDV5XbbmaAMNYpFQ+00XuVNiFNR1HEO2kQhql4XdNR/
         8AKoPw/LfXF1PQJmDkna0ZPjFv4owpU2PXLYG+QGlqEP02eJjdtXnYHkXSpw2Wru4Sxq
         A9RLko792+bWaB/gwjQycOq3dXbyIe8AXJ4F01pwcFiP1LbOobmUym9O7Hh7o9ALxHk3
         GcEA==
X-Gm-Message-State: AGi0PuZcNhBbOgr+oUtkBrxfIfG3qQZmmx6pqrJNzImzJOC2gJVLV205
        bUHtgVRmBxyU6sgvISl6puyP8W4V
X-Google-Smtp-Source: APiQypKAzvd4TvFEOfHXK/0yaVJ9lZgPHlB7a3fUNeSb1zhLFeL4PJUNC8FgCcz+uh7oGhsuHbMKCQ==
X-Received: by 2002:adf:d4ce:: with SMTP id w14mr8649481wrk.135.1586351721054;
        Wed, 08 Apr 2020 06:15:21 -0700 (PDT)
Received: from jkm (79-98-75-217.sys-data.com. [79.98.75.217])
        by smtp.gmail.com with ESMTPSA id b191sm6573999wmd.39.2020.04.08.06.15.20
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 06:15:20 -0700 (PDT)
Date:   Wed, 8 Apr 2020 15:15:19 +0200
From:   Petr Janecek <janecek@ucw.cz>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 2/3] btrfs_progs: _PROGRESS ioctl for error output in
 do_balance()
Message-ID: <20200408131517.GC19101@jkm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With 'btrfs balance start --background ...', all the potential error
messages are lost.  Add ioctl() to check for basic permission denied
and balance in progress conditions.
---
 cmds/balance.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/cmds/balance.c b/cmds/balance.c
index fada2ab3..3d4deb27 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -444,6 +444,24 @@ static int do_balance(const char *path, struct btrfs_ioctl_balance_args *args,
 		return 1;
 
 	if (flags & BALANCE_START_BACKGROUND) {
+		/*
+		 * We are not going to see any error output from the
+		 * forked process.  So do a sanity check that the
+		 * balance is likely to start.
+		 */
+	        struct btrfs_ioctl_balance_args stat_args;
+		ret = ioctl(fd, BTRFS_IOC_BALANCE_PROGRESS, &stat_args);
+		if (ret == 0) {
+			error("error during balancing '%s': "
+				"Operation now in progress", path);
+			ret = 1;
+			goto out;
+		} else if (errno != ENOTCONN) {
+			error("error during balancing '%s': %m", path);
+			ret = 1;
+			goto out;
+		}
+
 		switch (fork()) {
 		case (-1):
 			error("unable to fork to run balance in background");
-- 
2.26.0

