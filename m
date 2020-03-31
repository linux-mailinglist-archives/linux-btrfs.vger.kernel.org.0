Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87349199EB2
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Mar 2020 21:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgCaTKy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Mar 2020 15:10:54 -0400
Received: from smtp-16.italiaonline.it ([213.209.10.16]:56339 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727575AbgCaTKy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Mar 2020 15:10:54 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-16.iol.local with ESMTPA
        id JMHijXV70jfNYJMHkj3qIq; Tue, 31 Mar 2020 21:10:52 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1585681852; bh=at9o5w250skn0GTKQQ8ooc9pRYpcGLL8iMwCqqqupEM=;
        h=From;
        b=hu6AkePhRX5wDSlFr440yrGGMmMoJZCaq+kc9uFA3Z1504M2zo2ykDcGpor/CZLmg
         1OGApe7IcPsJjaqzlUydao13Qwbp0EYWoyNz+fO/SPSzGTO2zlywsLzE3cS9wyell0
         5A4ljqGYykyFODJ6TH0rE0jjUihG8SvVkWBuSfk27REQR4gTdyiLTCraoVAxj2TeL6
         fkjfRgq7nuJFTD8iZnHG9dLuLdaH48JmWuaEo2Z2kPfGBkzrv+/r7FwtDMDH0YLsNT
         xj2pVGb6TaaclcTUguF260pOQ0rd4HF8U7XM3nuH+zXQZqGmKbuDEbvGcDGHnvi+Bz
         q8t7DJ7wYK9Iw==
X-CNFS-Analysis: v=2.3 cv=av7M9hRV c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=mUxrmllu26sYn3iLKTUA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 4/4] btrfs-progs: Add mixed profiles check to some btrfs sub-commands.
Date:   Tue, 31 Mar 2020 21:10:45 +0200
Message-Id: <20200331191045.8991-5-kreijack@libero.it>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331191045.8991-1-kreijack@libero.it>
References: <20200331191045.8991-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfDNnDyr6Or4O2Gr6C/oqRlRS2OV+OrtORSLl/djSPY53+IHTiAnavn0FwbDscIeMzoXxMMrYcHUZAY9up/WvQt6khxHQXHEFQehJ9EMYlK8bqb3HXmF2
 bYaXZRjSpuZ2yoEadSBCxEAkZKZYSqFgoN0umsdY83rSbIj5GiPzcBbK6NjasLLVjZ/BcNtwpBNJGaGEsqc2ZkZNeK3NofeMbQTz4EafrrPosH0acWRLRJ5Z
 AXsLJppxXx72MWLQE/gyY6SznOMN9Ad1ZBcwWsVEVLh36zG0JxKvxocVEudzWa8d8D5SlPfDZm+lu99FyZK7NQ==
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
 cmds/balance.c          | 2 ++
 cmds/device.c           | 3 +++
 cmds/filesystem-usage.c | 1 +
 cmds/filesystem.c       | 1 +
 4 files changed, 7 insertions(+)

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
index 24158308..d83f92a7 100644
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
@@ -659,6 +661,7 @@ static int cmd_device_usage(const struct cmd_struct *cmd, int argc, char **argv)
 		}
 
 		ret = _cmd_device_usage(fd, argv[i], unit_mode);
+		btrfs_check_for_mixed_profiles_by_fd(fd);
 		close_file_or_dir(fd, dirstream);
 
 		if (ret)
diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index aa7065d5..ce07d80f 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -1043,6 +1043,7 @@ static int cmd_filesystem_usage(const struct cmd_struct *cmd,
 		ret = print_filesystem_usage_by_chunk(fd, chunkinfo, chunkcount,
 				devinfo, devcount, argv[i], unit_mode, tabular);
 cleanup:
+		btrfs_check_for_mixed_profiles_by_fd(fd);
 		close_file_or_dir(fd, dirstream);
 		free(chunkinfo);
 		free(devinfo);
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

