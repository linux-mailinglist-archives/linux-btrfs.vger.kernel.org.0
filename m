Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E99C601706
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 21:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiJQTJs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 15:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiJQTJn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 15:09:43 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75564120A0
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 12:09:40 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id a18so7309633qko.0
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 12:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKQta0HBGWzfonEHtISYSlTd/0kvcw3vIJGc0uHX9/M=;
        b=Tql5psuRXGpOHBSDExGqNDmOO8uVSXDYScWSk7tdJgPG1O+LaDmXwOK44N7x41Ll0V
         ybUodzXXuFlPW/vgCWNUZ1/MIIExrtsy0fhwX594Hd2hf0s2nX7k+a0dWT4Ocaghuw32
         cMvyNAHfnMPMiXAL+Nk+OlcfUvYy+FtySEwF1NIgp89Vo02Zdja7C5uZEOXRFL23FDVU
         0dQ4s5cEAh9uSrj1h4wCM0CL2f8dqMDugjATm7bSYV/IlW+USTU0197tPk6Ql7SOmoC5
         ybIKDhp2sSSEjpYi2ebCQlTPU5z2bbOsmF+zsdiNaWvOTr1icxkPkFu3Z8HdQ4EQCd43
         y+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKQta0HBGWzfonEHtISYSlTd/0kvcw3vIJGc0uHX9/M=;
        b=gT/mmoAiv/+90iF9IZr0KoEViF1bpF7Z+vtSF41CvHwTc6ON1lNKmW+umEOhnPzKUz
         ELH2T6ibgyr0KwfTPo6fmuoYHHRplRKy0nMTVihAcGHACnEOTQ9zoWYxPxd+PNjg8Oek
         ZlOwpURkCA3Gytbq4uC7U4nCSA1kBmbH/s8oX5BKAVBriJng4pYd0bYCvUv2lwQqmDvy
         FFlwGAR8HZe0MWAwKvP0jYCuk3hGpK1TIZICElBJSJVy/8Gr/w248OKsot9iDZLhNKr4
         mW5GSzAHS+WJ+oUTOPymdp4Vb9KL7WUgnfTjBnACMIgzQgGNPQN8EEHNmY85ZTAjg6ca
         gZvg==
X-Gm-Message-State: ACrzQf30QPKWkZU+Gwns3dCci8mVbHfgcnYywRpOSF//WNW+yJWeazBX
        39z0t/0BiGHhQEfasoo7xuBpEfdGkgRRDQ==
X-Google-Smtp-Source: AMsMyM4GtmTAgwOLztFnDb6zLVSBhS2OdiTG3BGRaYqLK301fqARNkKklqSHDGciKohvmQrmZQArIQ==
X-Received: by 2002:a05:620a:46a7:b0:6ee:e24f:7495 with SMTP id bq39-20020a05620a46a700b006eee24f7495mr5212174qkb.611.1666033779329;
        Mon, 17 Oct 2022 12:09:39 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id ay40-20020a05620a17a800b006bb78d095c5sm409521qkb.79.2022.10.17.12.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:09:38 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 16/16] btrfs: remove temporary btrfs_map_token declaration in ctree.h
Date:   Mon, 17 Oct 2022 15:09:13 -0400
Message-Id: <e6fcb751b030763fa6775a0646db992f714a4d1a.1666033501.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666033501.git.josef@toxicpanda.com>
References: <cover.1666033501.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This was added while I was moving this code to its new home, it can be
removed now.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index fcf809ca5842..1da8f1579e4f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -51,8 +51,6 @@ struct btrfs_balance_control;
 struct btrfs_delayed_root;
 struct reloc_control;
 
-struct btrfs_map_token;
-
 #define BTRFS_OLDEST_GENERATION	0ULL
 
 #define BTRFS_EMPTY_DIR_SIZE 0
-- 
2.26.3

