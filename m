Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A192A1F13
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Nov 2020 16:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgKAPaR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Nov 2020 10:30:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38697 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726730AbgKAPaQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 1 Nov 2020 10:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604244615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=ng2C8bOdfypGJPdZd9Hy+rwWhjBkyur/122cQ3TG0CA=;
        b=BCk6Q6E/b3/oYXx+YMME+uAj5uOj62sjU0zUznV7DttSnYMLxSKm75XnjJJwhfw3LZIonL
        ujC3n5V5fzw+BFHd4W6kdBczU1WYNC8msCdp+B5UBTobwcwhlSjiQaNW09vr8mg5IRX3Rx
        wmx/6U41n93zIBFBuX0pkz5e/U4L4aE=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-jeKAw-0NMoKjpt9YpOvtpA-1; Sun, 01 Nov 2020 10:30:14 -0500
X-MC-Unique: jeKAw-0NMoKjpt9YpOvtpA-1
Received: by mail-ot1-f70.google.com with SMTP id k103so4830035otk.1
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Nov 2020 07:30:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ng2C8bOdfypGJPdZd9Hy+rwWhjBkyur/122cQ3TG0CA=;
        b=JQ82YCYJfTtCIaTAgSv4HzJJATyZcBFgvMDYxm/rU/tru9ndN+WwO1Hgg9c60kWOVm
         fsrO+G+DC48D1a29U6WiqbmfvwefWmbn7np4KJwaOlxePv/wzhKpsk/YsbwYJAJM4FVW
         C9tx7TdPIW4JS6TCzPcojZIgK3jyw/zR21TXioX39x7JVCHvzURnWTDZBbMQrJxTjWSg
         YPDivTTHCpKPLUXocIM2HUJj50ki8O2ZuHKAll/ZamTLB7jGaVC8Mt9OPrEeOJ9oZqLg
         KZZ6LrKRlE03VFtNPSvkG906NUJMaNb1p569z0Bqw1oIjwLDMNOfcwmqF87d2/H1krwm
         gWIQ==
X-Gm-Message-State: AOAM532hbBak5Y/tab2U2WV79wuXWB+NPg4TnUmp1dK+2tvwjGvF0WRE
        +pdxHPig8G2VpqB8Asn22r3bUlpDqmSTDuzwkvS31MRR+V9ZiVyfV3SQiWX00uUFENSxcoyuI4M
        4FSeeyJZPo1cZE6+Ho3m4OxY=
X-Received: by 2002:aca:1706:: with SMTP id j6mr7426079oii.82.1604244613403;
        Sun, 01 Nov 2020 07:30:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyc1EOdJdxYjg8nac4JwcA5GeWvi0QxXD1i9zdWiH6oy+lfa0NghV44C+xUR40uU3g1Pgo5BA==
X-Received: by 2002:aca:1706:: with SMTP id j6mr7426072oii.82.1604244613276;
        Sun, 01 Nov 2020 07:30:13 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 92sm207002otv.29.2020.11.01.07.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 07:30:12 -0800 (PST)
From:   trix@redhat.com
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] btrfs: sysfs: remove unneeded semicolon
Date:   Sun,  1 Nov 2020 07:30:08 -0800
Message-Id: <20201101153008.2291089-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/btrfs/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 279d9262b676..c96ecf951c86 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1207,7 +1207,7 @@ static const char *alloc_name(u64 flags)
 	default:
 		WARN_ON(1);
 		return "invalid-combination";
-	};
+	}
 }
 
 /*
-- 
2.18.1

