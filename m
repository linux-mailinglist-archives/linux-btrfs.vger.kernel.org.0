Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 319BA19E48C
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Apr 2020 12:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgDDKcX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Apr 2020 06:32:23 -0400
Received: from smtp-16.italiaonline.it ([213.209.10.16]:37549 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbgDDKcT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 4 Apr 2020 06:32:19 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-16.iol.local with ESMTPA
        id Kg63jDxJE6Q7RKg65jI6WS; Sat, 04 Apr 2020 12:32:17 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1585996338; bh=lMqD33KxfDP7FXbolls4YrJLt3TmQ4a8GsYEsin2uGY=;
        h=From;
        b=V0bRITJpe+0P9BHQ4uJc0re7sjNYEKIMshqGjaJkoO1oqtx0Q92j7IL7z+clHj6pt
         6wj+dM3Bu5weu7k8zXdSIBoo4sGcbAtjJ3wk1SHqLV5E9zrC5SscR/5H8kYwqAwIrV
         E1G/CcZEka+P16nLjBzDbL2cZsYejEXY0xAn7H9HKWgDVA6IUz2G7kw1gtb3Pv33Rt
         5KYg/r7VXYQa+TsyP4nAR8zkdTliYh87LLeHTKdv1dAt1k+KjkOYuWkLVUqrpjIJ9p
         QS0/WBdKDuew172Q0UhIhQwHZ6//oP0goXzkcdOqK9rGuDnyIiKXtmmp/dMv7MFemo
         0TS+DomnuQ0fA==
X-CNFS-Analysis: v=2.3 cv=LelCFQXi c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=RUdbwsFTIHsY3NEGO5kA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>,
        Graham Cobb <g.btrfs@cobb.uk.net>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 4/5] Add further check in btrfs subcommand
Date:   Sat,  4 Apr 2020 12:32:11 +0200
Message-Id: <20200404103212.40986-5-kreijack@libero.it>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200404103212.40986-1-kreijack@libero.it>
References: <20200404103212.40986-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKAGwLMXXr86U8TsKLPeJGlM+Q5SkBcu5LXuqJE0AUZ3SD8jePIyqFazIUOPNZKtP7UTnBT/YGIHndjwJAVetsrOQ8Cp2j97j7vaQVrpe/4YoqPkcRQc
 JtFUMFANXp6j0977pueoUYGdoc/cmd53kdzMaqQ3SyLf3tfq+qoPAO51P47QDAOJyabDXcrWovCwKw6/Dod3kPZZCCG2DDvjtaGVETf2mDylX7Y1/cki8mot
 71x3cl/Me0b3BfG7wM3s/nCekk9Mniw2FD26Wn7P8+bCkb7FpiaZLhhKFoCPNei2cbHrOX0732vS+D5dMzY7CcLpa59jxw2DgeA5Gn39sgI=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Signed-off-by: Goffredo Baroncelli <kreijack@inwid.it>
---
 cmds/device.c     | 1 +
 cmds/filesystem.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/cmds/device.c b/cmds/device.c
index 401b32b9..d83f92a7 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -661,6 +661,7 @@ static int cmd_device_usage(const struct cmd_struct *cmd, int argc, char **argv)
 		}
 
 		ret = _cmd_device_usage(fd, argv[i], unit_mode);
+		btrfs_check_for_mixed_profiles_by_fd(fd);
 		close_file_or_dir(fd, dirstream);
 
 		if (ret)
diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 4f22089a..c4bb13dd 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -111,6 +111,7 @@ static int cmd_filesystem_df(const struct cmd_struct *cmd,
 		error("get_df failed: %m");
 	}
 
+	btrfs_check_for_mixed_profiles_by_fd(fd);
 	close_file_or_dir(fd, dirstream);
 	return !!ret;
 }
-- 
2.26.0

