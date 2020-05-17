Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBAE1D6D88
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 May 2020 23:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgEQVr0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 May 2020 17:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgEQVrZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 May 2020 17:47:25 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A91C05BD0A
        for <linux-btrfs@vger.kernel.org>; Sun, 17 May 2020 14:47:25 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id m185so3307370wme.3
        for <linux-btrfs@vger.kernel.org>; Sun, 17 May 2020 14:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=umFCQ4NMWCIE/enEbdR7IzBDkwF+7PPxVjQ7OU7ryME=;
        b=bc9JiCyNi2SaYl+btE6yrujudYyNLl78V5XpCyZ9/4KEKAxZRAkGj+1u6RtqkAg8km
         AqFdngrJgZ/406TlWA1lT6giJ9khHuUW7QONSzFjqtf58qeWHJGMxhP3aPHFDtf+2zaQ
         mydxAV6NRzV2r1+bfnNomk9OOUhPLAlSKRxC16WEBfx4jes9GyHem4xpgvJTiW5lWMUw
         vhTlktN5Wp5bdjPQy+ibqrcIY+uBMIk5JRsyjeodQ5f5J23sr5oITBr9zBlowO7pPGPZ
         VRPpox3R7Qe8bogft+q4bqukDp6Glyy0BZW8Wg4rtv5njYWjLb6gNugwrmJhNroIrloy
         qcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=umFCQ4NMWCIE/enEbdR7IzBDkwF+7PPxVjQ7OU7ryME=;
        b=RdBO+i7ee9y53JrLVuep2Hczj2tWbKP9MCbWfrL9+RUleeiXvEzihVwCesQXzz87mD
         WqwqKIyfA/i/NKXVtTbX1zCtrxivz/KZUsOonCBRskEYQhPwrXM4duT9cdv3gJcqA8UP
         7snvT93/HXdxQZjNKuWTm+UwX7VNkinBceCTrTg3jh0libllDG6M71tN77jSfguK0TqB
         2O5RagvVbUCy9yB69BKakajAfsmgzMLfwxFkjiTB32f5YOoowNl32Rh/neS8oXJtCPDn
         9yIoGSldPuZ5SlcPwgn2p9f2zUohWHsMUklOCflsJQWt605QneJpvD41c9iOnx4NMZQ5
         gobg==
X-Gm-Message-State: AOAM5310Jz7H+6+7ISfmlZZIlR1P1+J2dOc80eSKsuSfHT9kVzCybTJX
        yXJqdh978dTx1aUwMOYcPDrflA==
X-Google-Smtp-Source: ABdhPJw4f9DasVjg3UWnPvpGkYC6F50+B/J+YVBxdXzbXqEpee6TDkiCS9KiwItSk/Fp8hTBso6ChQ==
X-Received: by 2002:a1c:545e:: with SMTP id p30mr15205009wmi.20.1589752043827;
        Sun, 17 May 2020 14:47:23 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:bc3e:92a1:7010:2763])
        by smtp.gmail.com with ESMTPSA id v126sm14441244wmb.4.2020.05.17.14.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 14:47:23 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yafang Shao <laoar.shao@gmail.com>, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH 01/10] include/linux/pagemap.h: introduce attach/detach_page_private
Date:   Sun, 17 May 2020 23:47:09 +0200
Message-Id: <20200517214718.468-2-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The logic in attach_page_buffers and  __clear_page_buffers are quite
paired, but

1. they are located in different files.

2. attach_page_buffers is implemented in buffer_head.h, so it could be
   used by other files. But __clear_page_buffers is static function in
   buffer.c and other potential users can't call the function, md-bitmap
   even copied the function.

So, introduce the new attach/detach_page_private to replace them. With
the new pair of function, we will remove the usage of attach_page_buffers
and  __clear_page_buffers in next patches. Thanks for suggestions about
the function name from Alexander Viro, Andreas Grünbacher, Christoph
Hellwig and Matthew Wilcox.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Yafang Shao <laoar.shao@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: linux-raid@vger.kernel.org
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Cc: Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org
Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
Cc: Mike Marshall <hubcap@omnibond.com>
Cc: Martin Brandenburg <martin@omnibond.com>
Cc: devel@lists.orangefs.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Roman Gushchin <guro@fb.com>
Cc: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
No change since RFC V3.

RFC V2 -> RFC V3:
1. rename clear_page_private to detach_page_private.
2. updated the comments for the two functions.

RFC -> RFC V2:  Address the comments from Christoph Hellwig
1. change function names to attach/clear_page_private and add comments.
2. change the return type of attach_page_private.

 include/linux/pagemap.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index c6348c50136f..8e085713150c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -208,6 +208,43 @@ static inline int page_cache_add_speculative(struct page *page, int count)
 	return __page_cache_add_speculative(page, count);
 }
 
+/**
+ * attach_page_private - Attach private data to a page.
+ * @page: Page to attach data to.
+ * @data: Data to attach to page.
+ *
+ * Attaching private data to a page increments the page's reference count.
+ * The data must be detached before the page will be freed.
+ */
+static inline void attach_page_private(struct page *page, void *data)
+{
+	get_page(page);
+	set_page_private(page, (unsigned long)data);
+	SetPagePrivate(page);
+}
+
+/**
+ * detach_page_private - Detach private data from a page.
+ * @page: Page to detach data from.
+ *
+ * Removes the data that was previously attached to the page and decrements
+ * the refcount on the page.
+ *
+ * Return: Data that was attached to the page.
+ */
+static inline void *detach_page_private(struct page *page)
+{
+	void *data = (void *)page_private(page);
+
+	if (!PagePrivate(page))
+		return NULL;
+	ClearPagePrivate(page);
+	set_page_private(page, 0);
+	put_page(page);
+
+	return data;
+}
+
 #ifdef CONFIG_NUMA
 extern struct page *__page_cache_alloc(gfp_t gfp);
 #else
-- 
2.17.1

