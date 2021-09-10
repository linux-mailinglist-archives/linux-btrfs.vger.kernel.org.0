Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD44940670C
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Sep 2021 08:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhIJGEw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Sep 2021 02:04:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34204 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhIJGEw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Sep 2021 02:04:52 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C12D9223F5
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Sep 2021 06:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631253820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8duWbaQEC7bgs3aJEGnuN+MRzox/XR/4sORMlTgTQ68=;
        b=Fey8KPMNAMHlnwmODRgL1FEVM2adir2jtvETATHLIvHWABVqX3UDBCA8rO8ZMIecaEquSJ
        4VtXpc7lI3zw0w4Fr/kNaRi5iS6fmgpT5oXib7hKlBPwfJ93n+uimZ0hNmL5hmNvy83hQk
        WaSeXZk7K3WLZBghRyZEavX7VXkFPzA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2E1D13D02
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Sep 2021 06:03:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YD7fLDv1OmFMEwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Sep 2021 06:03:39 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: do extra warning when setting ro false on received subvolume
Date:   Fri, 10 Sep 2021 14:03:34 +0800
Message-Id: <20210910060335.38617-2-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910060335.38617-1-wqu@suse.com>
References: <20210910060335.38617-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When flipping received subvolume from RO to RW, any new write to the
subvolume could cause later incremental receive to fail or corrupt data.

Thus we're trying to clear received UUID when doing such RO->RW flip, to
prevent data corruption.

But unfortunately the old (and wrong) behavior has been there for a
while, and changing the kernel behavior will make existing users
confused.

Thus here we enhance subvolume read-only prop to do extra warning on
users to educate them about both the new behavior and the problems of
old behaviors.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 props.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/props.c b/props.c
index 81509e48cd16..b86ecc61b5b3 100644
--- a/props.c
+++ b/props.c
@@ -39,6 +39,15 @@
 #define ENOATTR ENODATA
 #endif
 
+static void do_warn_about_rorw_flip(const char *path)
+{
+	warning("Flipping subvolume %s from RO to RW will cause either:", path);
+	warning("- No more incremental receive based on this subvolume");
+	warning("  Newer kernels will remove the recevied UUID to prevent corruption");
+	warning("- Data corruption or receive corruption doing incremental receive");
+	warning("  Older kernels can't detect the modification, and cause corruption or receive failure");
+}
+
 static int prop_read_only(enum prop_object_type type,
 			  const char *object,
 			  const char *name,
@@ -48,6 +57,9 @@ static int prop_read_only(enum prop_object_type type,
 	bool read_only;
 
 	if (value) {
+		struct btrfs_util_subvolume_info subvol;
+		u8 empty_uuid[BTRFS_UUID_SIZE] = { 0 };
+
 		if (!strcmp(value, "true")) {
 			read_only = true;
 		} else if (!strcmp(value, "false")) {
@@ -57,6 +69,15 @@ static int prop_read_only(enum prop_object_type type,
 			return -EINVAL;
 		}
 
+		err = btrfs_util_subvolume_info(object, 0, &subvol);
+		if (err) {
+			warning("unable to get subvolume info for path %s",
+				object);
+		} else if (!read_only && memcmp(empty_uuid, subvol.received_uuid,
+				   BTRFS_UUID_SIZE)){
+			do_warn_about_rorw_flip(object);
+		}
+
 		err = btrfs_util_set_subvolume_read_only(object, read_only);
 		if (err) {
 			error_btrfs_util(err);
-- 
2.33.0

