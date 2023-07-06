Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5D9749CF9
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 15:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjGFNHG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jul 2023 09:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjGFNHF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jul 2023 09:07:05 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A1B12A
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jul 2023 06:07:04 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-c01e1c0402cso650989276.0
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Jul 2023 06:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1688648823; x=1691240823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2IsSEeYeUGj4eCmvg6/SCeeqJbMBA1M/eYA+eASrNpE=;
        b=uoc7k3TIKofr04+SIIsYkeOczTlzH05/ck9jpERZhr9U4xXtBTbyaYg1AAPshp8kCx
         5IlXMC7ir+hC7JzatOreXHLei+V9GLFDr4WbpmVsSJiRyVeeQ75eSg/SZEotNJ1KFP2J
         +XazeWW012IPzeFLmfi3DlT7DhlzlAFx91sj9F7q/LD6wZfoOfJot9Eku82hXO2uyGGg
         alYwD08M92XUl8zXlXd3z6QYyJVT4/lzTlTxSysIE6uwD+zghR0I6Hz5F6UNguNGtpXD
         88oJrHLhwEgHWhpKpiIl1P67nPjbphDv0+n6eVCjtRfah1YcN3oqFmisuD6OLf9M9IsS
         XwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688648823; x=1691240823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2IsSEeYeUGj4eCmvg6/SCeeqJbMBA1M/eYA+eASrNpE=;
        b=gWQWzVvzZ80OuRHUZwhldWbojYAfohFQWgXufcnbRWdXm5N0ME6oAB8ScMRSjFb4nj
         RtPZXX728g2ilzbHZmN5JLzqKhn3vIQ8PZXjtwJtyD/1ZjPa8lEkTrUkoSmEf8L26pD7
         CqevVW1ZqQNPG53YXx4A0bPFpevC7dRZxeMxWo2QYIiJYwEXICbhgHDNHcUxmYgvUK77
         wTKDLxesueO61zVqI9yXgVv1RvUC9hyUgPecRPKgewmJelzD6k57rbaYj00j3VAbJlaj
         v27rNsX7TUXFDIbfo/QK62MMLpjLJ8vRmMQJLnG8vsfD7F63QR0r6l4kBx/4DZ+A3JeU
         Byxg==
X-Gm-Message-State: ABy/qLYatzcWUF1wmzlsiaBfbsVJZpgCoK/K/49WMsAnXqcqIhwl3c/W
        NJfVbydakjY/D0N8ujMOnFIIrMnc66RJ7n25S/B8EA==
X-Google-Smtp-Source: APBJJlHe3f8yea6kGtMubpWA5EwjphuG6O9vryR86s9o47nkg1SJdOXo4bOhBqTpdL1PuHSXHRtDpA==
X-Received: by 2002:a25:5857:0:b0:c12:fb0e:52a0 with SMTP id m84-20020a255857000000b00c12fb0e52a0mr1585043ybb.19.1688648823018;
        Thu, 06 Jul 2023 06:07:03 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u15-20020a259f8f000000b00be865f3d4fdsm291983ybq.62.2023.07.06.06.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:07:02 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/2] btrfs-progs: print out the correct minimum size for zoned file systems
Date:   Thu,  6 Jul 2023 09:06:56 -0400
Message-ID: <8acbb798193016e630019e29212c2343e2920e84.1688648758.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688648758.git.josef@toxicpanda.com>
References: <cover.1688648758.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While trying to get the ZNS testing running I ran into a problem with
making a small file system for one of the tests, but the error output
didn't make sense because it said the minimum size was 114294784 bytes,
and I was trying to make a file system of size 419430400 bytes.  The
problem here is that we were spitting out min_dev_size, which isn't the
minimum size for the ZNS configuration.  Fix the output to match the
actual size limit.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 972ed111..e61ea959 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1446,7 +1446,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		error("size %llu is too small to make a usable filesystem",
 			block_count);
 		error("minimum size for a zoned btrfs filesystem is %llu",
-			min_dev_size);
+			5 * zone_size(file));
 		goto error;
 	}
 
-- 
2.41.0

