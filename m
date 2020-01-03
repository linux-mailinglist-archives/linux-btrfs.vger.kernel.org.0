Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D59212F2D6
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 03:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgACCJk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 21:09:40 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:42873 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgACCJk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 21:09:40 -0500
Received: by mail-pf1-f177.google.com with SMTP id 4so22870235pfz.9
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 18:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KM8MyIufrsdk/fOIzS2qu4Ay7HNIN2UoCJNhtuHSwt8=;
        b=hKw8ALhcSG0QHh/wJksmbWe45jQwxWaBuB22Uy1/MClXk7He1hidJbTisEBoHIVtfg
         Wqb9GTkzAZ+/d3g7FKxVW08HPQq+EhGGRPeakzjBfuq9tqtFRI9jSucUMnkndlxrm3j9
         1kFzPsVWeNZ/6i48pafdmUtWHwRoG2tBwuZToETKBjWrxWa6oj2rH1NdII50KenQcx0v
         xoifvbL0h2S+4lZR6CrB0Rss6YMDYlH3QR/25cH0L4aSsBVITPyHCvRx5EIxx7f7y16c
         uqcr3YC6eA8UAso+0BP8QA54NkHQ4vBf77cdv352SqckQFP4+1SSUH/ZlhMnhyiKkfK5
         +gJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KM8MyIufrsdk/fOIzS2qu4Ay7HNIN2UoCJNhtuHSwt8=;
        b=LjG0iyMDnefZlcJIXK6oxSKfhfQ5J+7f24G4m8Yuvqz+MEfFu8rwsLXslyWd+wW1bh
         hsg1WsQwQj/0D9jkLzSKPuDpj4uLqD+92lpNXsKA0mX5C3694mKJ6sV4w4UQTftKBKGJ
         mmVVO+NoZ4CxuwYtH6dtRVU62Bqxm2Z40+K1OYkxyrmYdNQX7sSbvZ2FUbyz0y6EfUx+
         wF3vOwdipKYkrWrcSoAvfUSku78nr/qZJ9yx0OeCLBoR8U05jffT9vthzQQty9SDOnNB
         WeK81QtvvrEQKqNKITLTuocd0S2Cp+XSnYT/FEDNW49y3UCVP/2tWFEbg7wCIgaerSFQ
         vIAw==
X-Gm-Message-State: APjAAAW9FxgMn6xjwh5k93fOG6gG8LgojatC79bofmZHbB5UhjGqwIlA
        Bv/sqn4Voy1HBOjFj4Zk3Eo=
X-Google-Smtp-Source: APXvYqzBkboLBRerM/v3bZbnT9eWZvRjoUjrQAkXTpFdSEU4h+Yg4cXnqN1/lRqgJwI3PD95XHbYnA==
X-Received: by 2002:aa7:82ce:: with SMTP id f14mr92442277pfn.167.1578017379405;
        Thu, 02 Jan 2020 18:09:39 -0800 (PST)
Received: from localhost.localdomain ([191.248.111.235])
        by smtp.gmail.com with ESMTPSA id o6sm59764152pgg.37.2020.01.02.18.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 18:09:38 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com
Subject: [btrfs-progs PATCHv3 1/3] tests: common: Add check_dm_target_support helper
Date:   Thu,  2 Jan 2020 23:12:13 -0300
Message-Id: <20200103021215.30147-2-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200103021215.30147-1-marcos.souza.org@gmail.com>
References: <20200103021215.30147-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

This function will be used later to test if dm-thin is supported.
Inspired by fstests.

Suggested-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 tests/common | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tests/common b/tests/common
index ca098444..3ea8c260 100644
--- a/tests/common
+++ b/tests/common
@@ -322,6 +322,21 @@ check_global_prereq()
 	fi
 }
 
+# check if the targets passed as arguments are available, and if not just skip
+# the test
+check_dm_target_support()
+{
+	setup_root_helper
+
+	for target in "$@"; do
+		$SUDO_HELPER modprobe dm-$target >/dev/null 2>&1
+		$SUDO_HELPER dmsetup targets 2>&1 | grep -q ^$target
+		if [ $? -ne 0 ]; then
+			_not_run "This test requires dm $target support."
+		fi
+	done
+}
+
 check_image()
 {
 	local image
-- 
2.24.0

