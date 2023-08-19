Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECBE78176E
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Aug 2023 07:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244083AbjHSFEy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Aug 2023 01:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244018AbjHSFEc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Aug 2023 01:04:32 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236E73AAF;
        Fri, 18 Aug 2023 22:04:31 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-640c5df2e6eso9299676d6.1;
        Fri, 18 Aug 2023 22:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692421470; x=1693026270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtK1oAuhBttNzRyy67XkfSx54w+cZ+dAiOd6z4pwQRk=;
        b=Ba8BuUAuiM9gzQtU5otRTk8pFp5BvXG3mW/gwpVVSpt2Nj1wnbLtOAVBpqNqmmR+BK
         ERZLVEfIw9ck7LN8Y15eAgMQMCP9HkK18OBmhiwjvwrs4D10uuxzZm7C3v2pIh4QroUz
         UJGBbEfOV8Xbf4KGCdhg/biozzxmuAYOpBX1RSw+ffXts4xTHyU1IvvgrxfzID35ZBEk
         p4haXP0AUaTy3MrBuomkvcISBlnm0mU6G/YeVUHSMlB0qGpVV/KaAJY3/gp9YfQIVWun
         kDFGLkarWeq60DJOZuVc+berBp/pKcRIoyLApBqOKbOuhlU7JQguBliIAQ4dGCUqbW7b
         e+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692421470; x=1693026270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtK1oAuhBttNzRyy67XkfSx54w+cZ+dAiOd6z4pwQRk=;
        b=c+HqbmnA/PjXFWsERh1pLcxL/hfKL1eoEBz7Ue2dL7LkexOIdNVMs0EYjBx/UMTj3H
         M/kOnjUQuzfTYPtZTnCHptMYMAAVNTGLG/DKbWu9Jp3zndd60mvdh8pxvJlAadfuRchy
         r0/PE9DMRH83e217xyRRwajnLcGNBnrS70a35fqnfc/PQWrhCeUfTHWl8jBST/ZJPn+1
         e01+N9VWQKGDlmoSmTXHHc3VZEVEi5yW0rYKjd5c+rG50mSJStw3yR9IhPqsoaxuNaxq
         wRwL/TMpOAsB0xjMoDuEHckaH734ES4z/7AQh/Ma1Ik5piKXjfVs1/6y8HXUSKRduX7h
         1rcQ==
X-Gm-Message-State: AOJu0YzlWReJTLYKRmuJuo6i5mavFIPMHpeQ2ZOnTjLSTHXgn8D74JJo
        Gs2Allp2bTwBBAGdt3bCw1dtrbUOEqVyCQ==
X-Google-Smtp-Source: AGHT+IGS+6BWF8/LxX6KK7fC35+ucaXK7FQnD1n/cICDiwGquKRaVp0R0UoJwLrrtBilmmoNeM+76A==
X-Received: by 2002:a0c:abc3:0:b0:63d:6138:1026 with SMTP id k3-20020a0cabc3000000b0063d61381026mr1149974qvb.21.1692421470290;
        Fri, 18 Aug 2023 22:04:30 -0700 (PDT)
Received: from Slackware.localdomain ([154.16.192.72])
        by smtp.gmail.com with ESMTPSA id d28-20020a0cb2dc000000b0063d0b792469sm1213356qvf.136.2023.08.18.22.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 22:04:30 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, corbet@lwn.net,
        linux-btrfs@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 1/3] btrfs: MAINTAINERS: Remove obsolete wiki link
Date:   Sat, 19 Aug 2023 10:23:03 +0530
Message-ID: <d2f12dde8a0ef7b57b551ba163248551c290b4cb.1692420752.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692420752.git.unixbhaskar@gmail.com>
References: <cover.1692420752.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Removed the obsolete link.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 06ea4dd1ea0e..bf02985e1c3d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4360,7 +4360,6 @@ M:	David Sterba <dsterba@suse.com>
 L:	linux-btrfs@vger.kernel.org
 S:	Maintained
 W:	https://btrfs.readthedocs.io
-W:	https://btrfs.wiki.kernel.org/
 Q:	https://patchwork.kernel.org/project/linux-btrfs/list/
 C:	irc://irc.libera.chat/btrfs
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git
--
2.41.0

