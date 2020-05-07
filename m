Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CBF1C9DAF
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 23:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgEGVoW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 17:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgEGVoV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 May 2020 17:44:21 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAD2C05BD0B
        for <linux-btrfs@vger.kernel.org>; Thu,  7 May 2020 14:44:19 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id y24so6893109edo.0
        for <linux-btrfs@vger.kernel.org>; Thu, 07 May 2020 14:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mR5KN3Pz1n6bpXv2DNeSraShlVTsxJWNxOu3C85SoMg=;
        b=NAbAsbcCbcOXGfgGm7ahZi0o5gzd0TsLfygSJrNrVrw5vLmqVRWfCI3isz5iFR5mbA
         STvZy0Ini+hckNV2WvZupD+LtTplGUSiOCIH9BQ4aOETcgeCdIpI3Mj4WzqQem9CXLDe
         qYqvI/C+O08KvR+8KRty0U7zvjbl56T9lDhJogFf/OcHKnQJ9/6T7DcnRmFb0xuydSVo
         OCcwBscdI31qgR35JMlzx4rHo/+NUlCVj0gEvFfy2Ss+woreUw2pfXnuKNU5iEfww/Em
         QGboLZniwFBp/2tvxFy9cYEauvwdXj+tBAzwiJzCfCEprECi1B8+ab9SEyFXMnVToH+E
         +Dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mR5KN3Pz1n6bpXv2DNeSraShlVTsxJWNxOu3C85SoMg=;
        b=L4fSyGZPtN9PmFj0vyg85KHDAmfq+5vrTnWCp9piqEEor4LL08tOpkks7qvATJ5qQ3
         p49FcQiezOBJDkNpPooBf6OmyhPW+c6Hizxkh5oElrVvvXr239qgExHi4AM2+Fj2y6Ku
         fvBZ1pef8Lv86Z/yfO1GFoA0tT4gfYfQ81TgpAIvCBjmKG+KIkolGIhaRI3+XogZV39V
         zOXtUg71yItQaIrMp3lBhvSfEfBj5CUdhy48K+MODx5AOGzYZlUs2kEH/QuPTbBprtRa
         5qfT5kyb4nxOIhRThqNhkkeZbG6S9fGggnAe0d7Vwz/dMe58pOOQQEjK5YvjeeOBm41N
         amfA==
X-Gm-Message-State: AGi0PuYvJMBZ8RwSuedCqzxGYerIme9rECD+gNA7A4sDfHuxBTKwUccY
        2F8nz7teQK8GQXmXmXj4gecj1Q==
X-Google-Smtp-Source: APiQypLmX8YHBXb7kua9dEsVAJulVEp2exuqcsxlWLEdtzHF8lGn1ZzGxVKJFdK6oe8J4dems5+T3w==
X-Received: by 2002:a05:6402:221c:: with SMTP id cq28mr13246566edb.50.1588887857976;
        Thu, 07 May 2020 14:44:17 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a1ee:a39a:b93a:c084])
        by smtp.gmail.com with ESMTPSA id k3sm613530edi.60.2020.05.07.14.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:44:17 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yafang Shao <laoar.shao@gmail.com>, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
Subject: [RFC PATCH V3 01/10] include/linux/pagemap.h: introduce attach/detach_page_private
Date:   Thu,  7 May 2020 23:43:51 +0200
Message-Id: <20200507214400.15785-2-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
References: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
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
Cc: linux-mm@kvack.org
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
RFC V2 -> RFC V3:
1. rename clear_page_private to detach_page_private.
2. updated the comments for the two functions.

RFC -> RFC V2:  Address the comments from Christoph Hellwig
1. change function names to attach/clear_page_private and add comments.
2. change the return type of attach_page_private.

 include/linux/pagemap.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a8f7bd8ea1c6..99dd93188a5e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -205,6 +205,43 @@ static inline int page_cache_add_speculative(struct page *page, int count)
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

