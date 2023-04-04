Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBDE6D6664
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Apr 2023 16:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjDDO5f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Apr 2023 10:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbjDDO4t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Apr 2023 10:56:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC82449C5
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Apr 2023 07:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680620158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2wyXRFn15U7YuTtccu17S72kQxdrsvbnQJV5citpTBw=;
        b=f9rMXOWxDNdUIdaQPJxskMpRHn4rHA4effDRVSxw5JqaJsTzZeh8LcunplFQYKjeULRSn6
        8Zl3oVGyx7+D+Y9U1bnE+OB0z7n85uKG6W9oSJjfHEJDNjQ4UuNTcZsLY/6RoBwAbqXcHG
        1lODMnl891BqZYpkGIjHJ7otVvEmXRQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-EC0dh4kmOSedUEYpWRctlQ-1; Tue, 04 Apr 2023 10:55:57 -0400
X-MC-Unique: EC0dh4kmOSedUEYpWRctlQ-1
Received: by mail-qt1-f200.google.com with SMTP id u1-20020a05622a198100b003e12a0467easo22233310qtc.11
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Apr 2023 07:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wyXRFn15U7YuTtccu17S72kQxdrsvbnQJV5citpTBw=;
        b=lIwnzlcDayU0LbIGFVKTwlGcnPLM7qjbGkqSAQe9nbMFKGhGlO3o0KPxEosr5KlX1l
         ZW3IdcQLjbv6fKB8+y+Izv3CCqQtJSkvqN+LPYpaJzU0GOZAybFP+IypEAWLy1WvJ572
         pWX48euwmvj0F40HvHB94eCGVafkA1QFV6AcaiuDYldqSSC0Su4tdWEK7xGS+oJHN9qn
         1H4vKzdA5NkY+wZzn7R+cOmXCg4S0rKp+9bZ1EAGgesIBkWVAl/uUaA9IRY+GRE0uBHx
         XQ/UnNyGcsLlM5zV5ARMsTCL5tQhFXNNcPnZaCz8TrlTvus1pASMQfiMk5EVrZRFkoz3
         EuHw==
X-Gm-Message-State: AAQBX9fVs7rQpnUYN+czT8FknpP/a7tQcOr9Itv0iZ1zSUMeMYBtIyw5
        sdEq6tBQ3I0chtq8/H7W8jvMPKd38UuAKweRIKLp0YFt8Uq/jYf7d8CDD0CahBXHIP/gNCvHEVc
        T0iPITjm7AwXeZQQU9G0U6A==
X-Received: by 2002:a05:6214:202b:b0:57e:67c2:b9cd with SMTP id 11-20020a056214202b00b0057e67c2b9cdmr4447869qvf.27.1680620156124;
        Tue, 04 Apr 2023 07:55:56 -0700 (PDT)
X-Google-Smtp-Source: AKy350bJb0tNOFsr5rCdSnciXn4UvwnouNwwbFSTjZxZAVItCMscXXWD/V0CsYzmlqPKXH2vmnAZgg==
X-Received: by 2002:a05:6214:202b:b0:57e:67c2:b9cd with SMTP id 11-20020a056214202b00b0057e67c2b9cdmr4447836qvf.27.1680620155884;
        Tue, 04 Apr 2023 07:55:55 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j4-20020ac86644000000b003e6387431dcsm3296539qtp.7.2023.04.04.07.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:55:55 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     djwong@kernel.org, dchinner@redhat.com, ebiggers@kernel.org,
        hch@infradead.org, linux-xfs@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     rpeterso@redhat.com, agruenba@redhat.com, xiang@kernel.org,
        chao@kernel.org, damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2 22/23] xfs: add fs-verity ioctls
Date:   Tue,  4 Apr 2023 16:53:18 +0200
Message-Id: <20230404145319.2057051-23-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230404145319.2057051-1-aalbersh@redhat.com>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add fs-verity ioctls to enable, dump metadata (descriptor and Merkle
tree pages) and obtain file's digest.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_ioctl.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 3d6d680b6cf3..ffa04f0aed4a 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -42,6 +42,7 @@
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/fileattr.h>
+#include <linux/fsverity.h>
 
 /*
  * xfs_find_handle maps from userspace xfs_fsop_handlereq structure to
@@ -2154,6 +2155,22 @@ xfs_file_ioctl(
 		return error;
 	}
 
+	case FS_IOC_ENABLE_VERITY:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_enable(filp, (const void __user *)arg);
+
+	case FS_IOC_MEASURE_VERITY:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_measure(filp, (void __user *)arg);
+
+	case FS_IOC_READ_VERITY_METADATA:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_read_metadata(filp,
+						    (const void __user *)arg);
+
 	default:
 		return -ENOTTY;
 	}
-- 
2.38.4

