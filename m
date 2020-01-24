Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6CFF14893B
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404140AbgAXOdl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:41 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:36755 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404546AbgAXOdk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:40 -0500
Received: by mail-qv1-f68.google.com with SMTP id m14so986523qvl.3
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=79SwE5YlG/SPO84o5TzSObabEBwnaBR1h21On1MbvN8=;
        b=J2eEkiZMv8a8zeR2FoFjp3I1aLA8pEo8klZmMQcpa2/OvQonQX7ymxm1CWRzhwwBi9
         5ol+vHuEfSVJrezI1dx1Q4F+BOiCY6/ShzSXRIqgQT+6ZUALHpnPWJRSWUbbnazoCUfo
         g9Gy6au0ptEACd1LqEyhP+DdPAx+kzZf9vWG+dI4Cx2t31bI0qc0GeNnxvnQGlbvSmpq
         o26hPOgIw879DtqmKjC4MBcY/bTIiwhskg60xa3oF8nSTmP2CR6ROmp8nf5gWBRGFW+N
         zm2jVM5Fh26gEPPMW6Dvzv6IYQ9oTAl1lkgDM5c8IFM4AzA/hT2X0+SnwIuhP7WHK7yQ
         318g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=79SwE5YlG/SPO84o5TzSObabEBwnaBR1h21On1MbvN8=;
        b=rgYDxHuJumHgNOsTYu1GSVxIEsZJ0+34duQnDkALLl3rY655Pkba/0KyPOiAP21Kk1
         rZtFLgILFhmdonZtf9xJu2rWVR5L94GV6/z+fTRLzAdLYhncl0MgJB0Ara5KY7zIyILv
         1Ga+CK06xWfYt7hTjPJGX9gl8gxsHIIaJIy93PXyUhgu/h3UKuZU6aXO13VMPMF+8c4M
         39NeBKzkSsIkSqDg5HZJi8eq3OhZtd0lIaGR0fFm4JAvdoLNuXepUK4DafpOuc0iZ1vt
         VvlK3mOnySlPmOqX3yETTfTsIwzQTFdBwA1QAYsV9iAOa2rft8lwn2JBAx4TioviQ1rX
         M9vg==
X-Gm-Message-State: APjAAAWLElNejNzJVpQ1imkmAKUg3OvXp1wwaXWnsYpa8sgTngEp3uZn
        p4ceXFE5M6euvkcsatzQclHPPN88wPIGmQ==
X-Google-Smtp-Source: APXvYqys/S1ti8RC6IzUNTRaHHKWHH5pij0yO/Hw/38MD4izMqNqpkOks+eFak0qTdg2gOhEHYOoMQ==
X-Received: by 2002:a05:6214:c3:: with SMTP id f3mr2969779qvs.226.1579876419784;
        Fri, 24 Jan 2020 06:33:39 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g62sm3140057qkd.25.2020.01.24.06.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 22/44] btrfs: hold a ref on the root in prepare_to_merge
Date:   Fri, 24 Jan 2020 09:32:39 -0500
Message-Id: <20200124143301.2186319-23-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We look up the reloc roots corresponding root, we need to hold a ref on
that root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 990595a27a15..53df57b59bc3 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2474,6 +2474,8 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 		list_del_init(&reloc_root->root_list);
 
 		root = read_fs_root(fs_info, reloc_root->root_key.offset);
+		if (!btrfs_grab_fs_root(root))
+			BUG();
 		BUG_ON(IS_ERR(root));
 		BUG_ON(root->reloc_root != reloc_root);
 
@@ -2486,6 +2488,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 		btrfs_update_reloc_root(trans, root);
 
 		list_add(&reloc_root->root_list, &reloc_roots);
+		btrfs_put_fs_root(root);
 	}
 
 	list_splice(&reloc_roots, &rc->reloc_roots);
-- 
2.24.1

