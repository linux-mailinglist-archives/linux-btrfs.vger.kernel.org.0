Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8D5214D0D
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jul 2020 16:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgGEOVK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jul 2020 10:21:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34489 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726781AbgGEOVK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Jul 2020 10:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593958868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=x1Iud6K4rDmN/FDvTgcgeFfvkXG/zP8SYWAjvE24riE=;
        b=SNMaDET+UdmQPgH2dUS1uuUuewyuiEcJYBunNy4j4WrBwhwgfivxKU96BJ/RZDYw+gg9yr
        pA3a2kxKTQamQo/9beGMAk91LtQIPDbHI+80naO3CUC36O8VCX3djAdoqw/PxzbAoGqec4
        F/OysolibrvPcfRQdCcFUUG+wQAiihU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-VUa-VzQzPCONK0uDmC8K5w-1; Sun, 05 Jul 2020 10:21:06 -0400
X-MC-Unique: VUa-VzQzPCONK0uDmC8K5w-1
Received: by mail-qt1-f199.google.com with SMTP id q7so7927883qtq.14
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Jul 2020 07:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x1Iud6K4rDmN/FDvTgcgeFfvkXG/zP8SYWAjvE24riE=;
        b=keXl37EefArzrc/VdexNthc71uerPzjXsnrC3i7MOF9LYp9jwxU1iNi8GuPth8tqlq
         jb9SWXa0smlcOQ7ToM4tufNRw9ebRWRQy1+/t3M/Sq+esLc3e96+R6fSwiazGhADEoOE
         VQoj8FDIof5dtKaUM5JQ8PLBEr9u47ojNIK4zA3x+6FwIi4N62se0Hr4xx+BB82iuZdB
         /ZSc8pwWyOaPuFIZtNgpMzg5GXb9a/CGnQaqQ9FePcR5077KZifv/jTMGWggSe0Qtukg
         +gs3bhst2o26b7UozJnqb2g6wuz3QyTmJ/GvIV2n3YVAQk2PDUpZRNUHdH/m2QYOa9dO
         kJGQ==
X-Gm-Message-State: AOAM530a7SVbXlj0EARZ8V2jJwBWVInJzU5ni7DrfFvzY7hj9yejUsZx
        LsHqD+T0Ne2mX0iylP7L5Jm2jEBnUEwRv5Ul2Mc8avqpJ5wp835UyfLHw3/Zmn5qioyjucuuIwE
        lX56dOIIaX4F/OXPdEB+9r4Y=
X-Received: by 2002:aed:3386:: with SMTP id v6mr46763992qtd.187.1593958866371;
        Sun, 05 Jul 2020 07:21:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqLT8l+X8+IIDTGgRATWGOoMqAoWnwXKY1M0zgzdVJt+57plmmrH1oECkWQan9yUcfCkA7wQ==
X-Received: by 2002:aed:3386:: with SMTP id v6mr46763977qtd.187.1593958866161;
        Sun, 05 Jul 2020 07:21:06 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d53sm16474232qtc.47.2020.07.05.07.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 07:21:05 -0700 (PDT)
From:   trix@redhat.com
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] btfrs: initialize return of btrfs_extent_same
Date:   Sun,  5 Jul 2020 07:20:58 -0700
Message-Id: <20200705142058.28305-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis flags a garbage return

fs/btrfs/reflink.c:611:2: warning: Undefined or garbage value returned to caller [core.uninitialized.UndefReturn]
        return ret;
        ^~~~~~~~~~
ret will not be set when olen is 0
When olen is 0, this function does no work.

So initialize ret to 0

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/btrfs/reflink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 040009d1cc31..200a80fcbecb 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -572,7 +572,7 @@ static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
 static int btrfs_extent_same(struct inode *src, u64 loff, u64 olen,
 			     struct inode *dst, u64 dst_loff)
 {
-	int ret;
+	int ret = 0;
 	u64 i, tail_len, chunk_count;
 	struct btrfs_root *root_dst = BTRFS_I(dst)->root;
 
-- 
2.18.1

