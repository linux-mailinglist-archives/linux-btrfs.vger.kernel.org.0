Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4F42D7B75
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Dec 2020 17:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390054AbgLKQtZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Dec 2020 11:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389806AbgLKQtI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Dec 2020 11:49:08 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE5AC0613CF
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Dec 2020 08:48:28 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id n7so7511498pgg.2
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Dec 2020 08:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5lF45uOPN8KRcmWLga3+WJCtnUF0zupTIlBCikoWblI=;
        b=dDblDXkb+7VuFKc2eA37Bh64jfO/ZEfQZbMBvrfFRVnagoB5wUld/2fnqoiH0IPSVy
         hOz8HSBY/tpGCLhuuwjALFpdQWPrX3KO1YjWdg1QY+SFCsw37W5Cj3yhA8MZOyYKjkB1
         3ATXQL2mMzW5CJkajLSl6fSOfbqpR06NPLDHq+FCFnvbRSEK9s6XXgSFp0saO216Rqo8
         kyCrTfUaf1SbsfUHrS379PBFg9vix424iA5fGRezO6kw30KnmhKZThXVvr1imfD/ceNh
         3N3PJArkBUK1N7UK95TUp6H1MrtOPBt3Y4ktICHrqNgByt2OMjLq1tE4pfgLdBXbQi06
         8U2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5lF45uOPN8KRcmWLga3+WJCtnUF0zupTIlBCikoWblI=;
        b=Mv5Z0Xhr9lc52jfnj+VI0aVWj3vJsKj+tVbxKxf/+Kw5hcpNtgq0t4nfGKR+vFHPYf
         PnqeELElIjB1ZsuQ7Y3OZvnSHTZ1Ar98Cjv3jAwO9AcKJjXRa9UdfPLrgS5ZQkTQ5yaM
         Rniix5qEmOWGXkw+6XaICWnx0ass1MUd59x1eLQoZLf/ZVOTsJKrPeTYOD7EXQj26NNq
         /pGUBHTZXtggcDL+nU0p0VMI0/5DK6cfsBgQATt+bCwmlcEce1psm9SEksn9p3AES7z+
         qEiO3x/RF2wcpKzcrPzwzzEL37qewrBAjRb3k/YGNHsfEXPkqM1J/I1aw6JeUP+Ne/Oj
         LG7Q==
X-Gm-Message-State: AOAM531VQcNa3poLh9c2Clg+V2fN3qDULhJOGIDSiFN5Z5/UAkGjVP5I
        ZfsqIBllzS3tFm8AeXR7B/fwg6GwMCSmrQ==
X-Google-Smtp-Source: ABdhPJy97TFIWIaMCzCcbxOlmyR7BIzQHhsFqQP39cAIn1sXxAgCyDmjHSAa8ud961C5W/S82QcbOg==
X-Received: by 2002:a63:4283:: with SMTP id p125mr12639215pga.26.1607705308222;
        Fri, 11 Dec 2020 08:48:28 -0800 (PST)
Received: from localhost.localdomain ([175.195.128.78])
        by smtp.googlemail.com with ESMTPSA id z20sm10353713pjq.16.2020.12.11.08.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 08:48:27 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v3 1/2] btrfs-progs: common: extend fmt_print_start_group handles unnamed group
Date:   Fri, 11 Dec 2020 16:48:11 +0000
Message-Id: <20201211164812.459012-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch extends fmt_print_start_group() that it can handle when name
argument is NULL. It is useful for printing unnamed array or map.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
v3:
 - extend fmt_print_start_group rather than writing new function
---
 common/format-output.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/common/format-output.c b/common/format-output.c
index 8df93ecb..2f74595c 100644
--- a/common/format-output.c
+++ b/common/format-output.c
@@ -181,17 +181,23 @@ void fmt_end_value(struct format_ctx *fctx, const struct rowspec *row)
 void fmt_print_start_group(struct format_ctx *fctx, const char *name,
 		enum json_type jtype)
 {
+	char bracket;
 	if (bconf.output_format == CMD_FORMAT_JSON) {
 		fmt_separator(fctx);
 		fmt_inc_depth(fctx);
 		fctx->jtype[fctx->depth] = jtype;
 		fctx->memb[fctx->depth] = 0;
 		if (jtype == JSON_TYPE_MAP)
-			printf("\"%s\": {", name);
+			bracket = '{';
 		else if (jtype == JSON_TYPE_ARRAY)
-			printf("\"%s\": [", name);
+			bracket = '[';
 		else
 			fmt_error(fctx);
+
+		if (name)
+			printf("\"%s\": %c", name, bracket);
+		else
+			putchar(bracket);
 	}
 }
 
-- 
2.25.1

