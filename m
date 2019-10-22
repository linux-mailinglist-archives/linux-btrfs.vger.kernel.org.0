Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA932DFAB3
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 04:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387723AbfJVCAg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 22:00:36 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:39888 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730711AbfJVCAf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 22:00:35 -0400
Received: by mail-qk1-f172.google.com with SMTP id 4so14803698qki.6
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 19:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/NZh7/4tliLAQTguKTusOm8JYsA9jfNfBnr9RwOlB0U=;
        b=hzaSX0zZglVTL84ewU00AKN1PkwcXT67jz51k9NFhFWE9CTcacRO4Pu5EOMCX7iKfo
         XtGjOZzqG6H91m13YCUXEtkP/henxO3SQM2YrmZwmWsIlZoccAnWGb/Fi/DYsXszJBqE
         D9nw5VuoS14aGqzwFSRJhO/vbPRYBdf+mv3yA1/jj7SWer842mTuPnZmNgLYT1ZR/c/m
         TpEptirfpOigJrWoqb+kEEoMv3ZbR3U3zrUSTbLcOstjnVxgHvbyjknyz1WsNCoRGZux
         xBS1OW9J8ALIhHjOHv5ERY0aKKWoK3eT3kvwnhuVEAlZAu6E4xlFNTLdEhjy1k2/I0ne
         5xUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/NZh7/4tliLAQTguKTusOm8JYsA9jfNfBnr9RwOlB0U=;
        b=LdxoBbsEQ/a4ZZhtbZaINcW140qVN6iQgmWFvAaPOunf/B+VvHkxrZMGfJS7Sb/XpY
         b5OxdIWmXO/TML5YsYjE+6v1Nqu7e5vFtbM08fQMO0WK38auZ3/WqxxJjzP7oVSaoG6F
         /FGiv4GaMRioao9+gWJTntjLM0kkf6k3tAKs9uAZj+is4lN+0z2ZILckTUjNADasBQpj
         TXWTAw5Idj8eOCQV9Z581Xnror+G8W+Cyfg7l2NxUMzBe4GtOwWRbT/1apnNHojOavqM
         ZKN1kGV3OxGK2RKl3ykhVdB8gD/yQf5/uZ3IdBu27tIv7sDxHxFQ3ubM80ATA30hkkRc
         uFiA==
X-Gm-Message-State: APjAAAVxmAaOn0E+g46C9p72niyqV9C7PX/7xJxnS5B8UXMLlKrGJAO2
        M3vHm3xzPZWSTu901jtMgiqNLxBT
X-Google-Smtp-Source: APXvYqzVTHUYgQqSsfdXTI8lXflfYi64pvjwREaLCT4bc9+K91fbPzrdC7I7w/ZlDX6hwnJt3958xA==
X-Received: by 2002:a05:620a:132b:: with SMTP id p11mr864786qkj.190.1571709632972;
        Mon, 21 Oct 2019 19:00:32 -0700 (PDT)
Received: from localhost.localdomain (189.26.180.57.dynamic.adsl.gvt.net.br. [189.26.180.57])
        by smtp.gmail.com with ESMTPSA id t65sm8511120qkh.23.2019.10.21.19.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 19:00:32 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 2/2] btrfs-progs: Makefile: Add -Wimplicit-fallthrough
Date:   Mon, 21 Oct 2019 23:02:28 -0300
Message-Id: <20191022020228.14117-3-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022020228.14117-1-marcos.souza.org@gmail.com>
References: <20191022020228.14117-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Avoid introducing new cases of implicit fallthrough by having this flag
always set.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 21bf2717..2f04e880 100644
--- a/Makefile
+++ b/Makefile
@@ -86,6 +86,7 @@ CFLAGS = $(SUBST_CFLAGS) \
 	 -D_XOPEN_SOURCE=700  \
 	 -fno-strict-aliasing \
 	 -fPIC \
+	 -Wimplicit-fallthrough \
 	 -I$(TOPDIR) \
 	 -I$(TOPDIR)/libbtrfsutil \
 	 $(DISABLE_WARNING_FLAGS) \
-- 
2.23.0

