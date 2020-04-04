Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4842219E48A
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Apr 2020 12:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgDDKcU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Apr 2020 06:32:20 -0400
Received: from smtp-16.italiaonline.it ([213.209.10.16]:40101 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726077AbgDDKcT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 4 Apr 2020 06:32:19 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-16.iol.local with ESMTPA
        id Kg63jDxJE6Q7RKg65jI6W0; Sat, 04 Apr 2020 12:32:17 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1585996337; bh=59BuvjRcLOL1x6GYkCxK9VYmBAAs5KwXXoMRs59x1do=;
        h=From;
        b=TBZ+KxJV1zcXrqCe6rn8oM5MFo2seTwf9vlNQmXpWERcxStWC3EflJsT1goKAJq+H
         7pdX0UuirCr5O9dqAnZiaNZ3fEHEINh459Ab+7GtyFIhXdmwBUMthJQECmTtXUryWL
         yfyzstjqbEF76Le2BNw4qnkITalzytPX3KENt82uEnJtkqseXyb3IHAJqGuqUyoEZz
         ykL5tr5ni/oZA4COmcXyPcJFNxuY3Hz1XfKIJtl79hFkBfNrVuC2uCBRzwybAoCX7C
         /oL6lF1KBYK+3giTDQw/HLVGjKmiObPKuojYLpz5bdPKbOF5ecOdX3+2oasgYFyIq4
         vOs6YDgvt97aw==
X-CNFS-Analysis: v=2.3 cv=LelCFQXi c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=VPATK8qPJ3NAqgEWvUUA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>,
        Graham Cobb <g.btrfs@cobb.uk.net>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 2/5] btrfs-progs: Add mixed profiles check to some btrfs sub-commands.
Date:   Sat,  4 Apr 2020 12:32:09 +0200
Message-Id: <20200404103212.40986-3-kreijack@libero.it>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200404103212.40986-1-kreijack@libero.it>
References: <20200404103212.40986-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKdd+esTeTN1C6k7X/myqPWbWe6+kX1Hj+B7yA5/cGAS/y098Pi5sAxP2Ivr+Mw8PWGotyjzcFi18TquKi0VV1LGpgwLI3p7KRWWBldwOSeChSby4yvj
 rs9lg2SBauptvJwvxaNBSJH6p1ZQqPdfoBycG5pG+LJBctlNXaTj0SLp5JJH2TPp55NKuMnFpN5CM/ktX88YiNjkSG7Sf9wpkUr+SUH47bRLQUeed7DLZ1EM
 A6ur/S/C7uAAz1PJm66H3J9JehzM7LaxHxCOV0tqb5U+G5TkUol4zKdz7+RHiCAYsECykkMhLbjcuGbypK1EdkRBvzDGsIQFaKP94DKbOjs=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Add a check in some btrfs subcommands to detect if a filesystem
has mixed profiles for data/metadata/system. In this case
a warning is showed.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 cmds/balance.c | 2 ++
 cmds/device.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/cmds/balance.c b/cmds/balance.c
index 5392a604..20d0ebc1 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -716,6 +716,7 @@ static int cmd_balance_pause(const struct cmd_struct *cmd,
 			ret = 1;
 	}
 
+	btrfs_check_for_mixed_profiles_by_fd(fd);
 	close_file_or_dir(fd, dirstream);
 	return ret;
 }
@@ -756,6 +757,7 @@ static int cmd_balance_cancel(const struct cmd_struct *cmd,
 			ret = 1;
 	}
 
+	btrfs_check_for_mixed_profiles_by_fd(fd);
 	close_file_or_dir(fd, dirstream);
 	return ret;
 }
diff --git a/cmds/device.c b/cmds/device.c
index 24158308..401b32b9 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -143,6 +143,7 @@ static int cmd_device_add(const struct cmd_struct *cmd,
 	}
 
 error_out:
+	btrfs_check_for_mixed_profiles_by_fd(fdmnt);
 	close_file_or_dir(fdmnt, dirstream);
 	return !!ret;
 }
@@ -225,6 +226,7 @@ static int _cmd_device_remove(const struct cmd_struct *cmd,
 		}
 	}
 
+	btrfs_check_for_mixed_profiles_by_fd(fdmnt);
 	close_file_or_dir(fdmnt, dirstream);
 	return !!ret;
 }
-- 
2.26.0

