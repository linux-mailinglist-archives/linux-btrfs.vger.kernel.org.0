Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57170115381
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfLFOq0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:26 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37450 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfLFOq0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:26 -0500
Received: by mail-qv1-f68.google.com with SMTP id t7so2733213qve.4
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HVdhY+4MBd3q4kmJauYMe/pxqfd41KkKzQ6A+3l8tLk=;
        b=heiSqc+AkvZKV4YluGqum4iLf0yhrl2RRyu8u3KmIzcIzAPuoYcGtqfKhJB3rOnfhk
         WJiIH+pnoHK478ZPG+APWOoSAgHXMq1pDsXwj106uyEOAA1KsEFm8W5UrmRfdaGVv0J+
         a6vCE/3z22nUGRDketgva6Wdpkb48hMrVuIAX7bNQfBgsvP/8GBP18DzMqym7qSwobUp
         ExgDHxHLgBHwBylc1xslREevDSXeS1rTU76zMkjk8gJZ+RBi0eBmpxMnWW3WrvPfJXf8
         /OxOJImasA+RoW8+5fA8S8jtaaYCwti2UOGv+r0SIjUNRB5/sG9h45318seUISrd0+M2
         eReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HVdhY+4MBd3q4kmJauYMe/pxqfd41KkKzQ6A+3l8tLk=;
        b=BYO+rMYCa76BOFP8XEbIWaea5o3eGae8MMBB6RuBsmoOKX5VABMLjjh6KEHi9MndFY
         vhqoLQ6Y0mdfx2hdV6LZq0YZnfUhGzf9U1BkWsuWNUGUd0iannAgg0UDRE/kyDf5NhDR
         4ZrMLho7Kxkxjg3PxvEC8VS6LFk9NqFl9kWEqLcgyjhsTAueDNLBXyKtmvlANi/U0YHB
         0Cb1cRmCDyQmEe3A5LC3RWBZpTMQrVlKvUZty9jvCnlb8tWl0pjT+bKhWoWAh9DOYVco
         mrjl2M+aV8JPODHcS74SNhA80A6gFFGVXvEfPcdOI73knFsq12BqdOvn6w2ntx3DuHUn
         9Tgw==
X-Gm-Message-State: APjAAAUc22H58lKfN1Lz3M2ihm4z4dqSgSXHsuoL8TcIJV/uxMu6LbaK
        KmYwJxDvsF3RZdYTCZPMHrbJToitNI84MQ==
X-Google-Smtp-Source: APXvYqxD3za0WHsHuBQZNrwMdSeQrA9+J0vT/bi4a/f8KJAIUGgWli4SVazZKVVJQQiiQMuP7bnSLA==
X-Received: by 2002:a0c:e806:: with SMTP id y6mr12605668qvn.148.1575643585094;
        Fri, 06 Dec 2019 06:46:25 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y3sm234039qti.57.2019.12.06.06.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 25/44] btrfs: hold a ref on the root in merge_reloc_roots
Date:   Fri,  6 Dec 2019 09:45:19 -0500
Message-Id: <20191206144538.168112-26-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We look up the corresponding root for the reloc root, we need to hold a
ref while we're messing with it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 19d69ce41f06..dfd3d9053301 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2505,10 +2505,13 @@ void merge_reloc_roots(struct reloc_control *rc)
 		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
 			root = read_fs_root(fs_info,
 					    reloc_root->root_key.offset);
+			if (!btrfs_grab_fs_root(root))
+				BUG();
 			BUG_ON(IS_ERR(root));
 			BUG_ON(root->reloc_root != reloc_root);
 
 			ret = merge_reloc_root(rc, root);
+			btrfs_put_fs_root(root);
 			if (ret) {
 				if (list_empty(&reloc_root->root_list))
 					list_add_tail(&reloc_root->root_list,
-- 
2.23.0

