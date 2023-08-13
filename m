Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A6777A5E4
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Aug 2023 11:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjHMJvU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Aug 2023 05:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjHMJvQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Aug 2023 05:51:16 -0400
Received: from mail-108-mta39.mxroute.com (mail-108-mta39.mxroute.com [136.175.108.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BF71700
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Aug 2023 02:51:16 -0700 (PDT)
Received: from mail-111-mta2.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta39.mxroute.com (ZoneMTA) with ESMTPSA id 189ee49e5fa00023b6.001
 for <linux-btrfs@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 13 Aug 2023 09:46:07 +0000
X-Zone-Loop: aa6b3f83f03e9767c3ae162c5cfac81d8d3a2f952aa7
X-Originating-IP: [136.175.111.2]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=c8h4.io;
        s=x; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=NDLLnyGyq/UIsbHA2VT4Kr9AGL//iNQbw4+KF4VcVuc=; b=OgCGXfPNe8l/cKB49yjfsgppWE
        SMBVQLsStOxmu3DKbe06EIBvgvRxpKpGhCAhd0rdLeh4hOgbvuaH0Py/aOPjSOaqx6pl99b89ke3A
        FBPQ370pdPnPBqEQ0Ng0ReELpF/TzP1hehtsq34rf/RK6UGh8EHAs10Mjd7yLf7vd/9QY2ockHf4Q
        jHKgsEoKoKybbvqIFrhXjx0q0e6VwGX8aC6z3oXgUb8Gl3wYzXsHGGtMkkEQB5OMtUzfrjTmlW2uM
        kSbEtF2d7tCocA7xJa7xdUPHG5yilGXzEjAMriEFU9zAU1i4mlb+yHqsZM7FDjSA4nDzQPUtH6qmO
        NZ8yB56A==;
From:   Christoph Heiss <christoph@c8h4.io>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/7] btrfs-progs: subvol: introduce rowspec definition for json output
Date:   Sun, 13 Aug 2023 11:44:59 +0200
Message-ID: <20230813094555.106052-5-christoph@c8h4.io>
In-Reply-To: <20230813094555.106052-1-christoph@c8h4.io>
References: <20230813094555.106052-1-christoph@c8h4.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: christoph@c8h4.io
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Includes all fields that are needed by the various `btrfs subvolume`
subcommands.

Signed-off-by: Christoph Heiss <christoph@c8h4.io>
---
 cmds/subvolume.c | 25 +++++++++++++++++++++++++
 cmds/subvolume.h | 19 +++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 cmds/subvolume.h

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 65cff24b..cb863ac7 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -41,9 +41,34 @@
 #include "common/open-utils.h"
 #include "common/string-utils.h"
 #include "common/units.h"
+#include "common/format-output.h"
 #include "cmds/commands.h"
 #include "cmds/qgroup.h"
 
+const struct rowspec btrfs_subvolume_rowspec[] = {
+	{ .key = "ID", .fmt = "%llu", .out_json = "id" },
+	{ .key = "name", .fmt = "%s", .out_json = "name" },
+	{ .key = "gen", .fmt = "%llu", .out_json = "gen" },
+	{ .key = "cgen", .fmt = "%llu", .out_json = "cgen" },
+	{ .key = "parent", .fmt = "%llu", .out_json = "parent" },
+	{ .key = "top level", .fmt = "%llu", .out_json = "top_level" },
+	{ .key = "otime", .fmt = "time-long", .out_json = "otime" },
+	{ .key = "parent_uuid", .fmt = "uuid", .out_json = "parent_uuid" },
+	{ .key = "received_uuid", .fmt = "uuid", .out_json = "received_uuid" },
+	{ .key = "uuid", .fmt = "uuid", .out_json = "uuid" },
+	{ .key = "path", .fmt = "%s", .out_json = "path" },
+	{ .key = "flag-list-item", .fmt = "%s" },
+	{ .key = "stransid", .fmt = "%llu", .out_json = "stransid" },
+	{ .key = "stime", .fmt = "time-long", .out_json = "stime" },
+	{ .key = "rtransid", .fmt = "%llu", .out_json = "rtransid" },
+	{ .key = "rtime", .fmt = "time-long", .out_json = "rtime" },
+	{ .key = "snapshot-list-item", .fmt = "%s" },
+	{ .key = "quota-group", .fmt = "qgroupid", .out_json = "group" },
+	{ .key = "quota-ref", .fmt = "%llu", .out_json = "referenced" },
+	{ .key = "quota-excl", .fmt = "%llu", .out_json = "exclusive" },
+	ROWSPEC_END
+};
+
 static int wait_for_subvolume_cleaning(int fd, size_t count, uint64_t *ids,
 				       int sleep_interval)
 {
diff --git a/cmds/subvolume.h b/cmds/subvolume.h
new file mode 100644
index 00000000..041ea865
--- /dev/null
+++ b/cmds/subvolume.h
@@ -0,0 +1,19 @@
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License v2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public
+ * License along with this program; if not, write to the
+ * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+ * Boston, MA 021110-1307, USA.
+ */
+
+struct rowspec;
+
+extern const struct rowspec btrfs_subvolume_rowspec[];
-- 
2.41.0

