Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A634216DB5
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 15:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgGGN3T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 09:29:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44380 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727044AbgGGN3T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Jul 2020 09:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594128557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=bpqV8ZGEfDigVwyXYOylVCt2pIZCMYHJKK1J8Iop6Ek=;
        b=PArKUsbfZMM77nVGGT0Q2e7Nq4lZ1SqUM1uTREjxuysCOvA52V1aOIGmcEecaJAMMX+59F
        k6cd6ZVFhclL4e3LQ4dWVP2xJiUCbj767XS/S/1pQQd3JMnsNAD4C1zZDJKlV8yyHo3LO6
        fc91SvatzHfMECTaMYpmfp+nvR0esmI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-OJvRzRAoO1qNyfo3gvlp4A-1; Tue, 07 Jul 2020 09:29:16 -0400
X-MC-Unique: OJvRzRAoO1qNyfo3gvlp4A-1
Received: by mail-qk1-f198.google.com with SMTP id a205so28497247qkc.16
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jul 2020 06:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bpqV8ZGEfDigVwyXYOylVCt2pIZCMYHJKK1J8Iop6Ek=;
        b=PqyeEqLPEDDe1V5ARAbCdC4XWsHD5L3U+ZxEvNs9YDmpA92q1QQZiehYkKOrVQt4V7
         WGinyp036d6ikYvqaqKLRjvEDNe/6Hu/OAdbZW0M39P/UsN6/3+6+yjKQlA8b2pQ3vlr
         MeaqW9/suMbUUVJ1Wi1zoIgzrqwEFOMZxWp1beJn7i5eosEXZK5j8bGpcsw8gvpcQF8Y
         rkrJlPWQeaG2mfQKTSY22hnnNesESvdBfXEhFHp3LxQFB+v12Hrg6Vs7wiWYeWRe8Z9P
         jTqAKlIUQrtaoXfQSXo4Xvxf+12ieeE3elguOAkO+seVFL7x4E4d3QudZTGcoA0RFBOD
         7EiA==
X-Gm-Message-State: AOAM530PzhvSU7DCWj6+okho4EFXFckReBXCxNOTX533rY6XZoXVba10
        nZu3ZFpqnV6/lETCZjRz2pZkCklLSPpEjM4LRXxMNWiBH8wYdukDRYuKEaDFjkmrj8p7fDD/Jub
        c8qsT9k9m2ncc5q9uwDJdk/g=
X-Received: by 2002:ac8:6d24:: with SMTP id r4mr30664725qtu.43.1594128555741;
        Tue, 07 Jul 2020 06:29:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2O03gNYLOwDLCkyXntBfC1UDiAP5Lv/FxSrI+aXh9M2U49IWAz9aERDIYqKOl2j/VlTt3pg==
X-Received: by 2002:ac8:6d24:: with SMTP id r4mr30664700qtu.43.1594128555462;
        Tue, 07 Jul 2020 06:29:15 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id g41sm28492912qtb.37.2020.07.07.06.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 06:29:14 -0700 (PDT)
From:   trix@redhat.com
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] btrfs : fix memory leak in add_block_entry
Date:   Tue,  7 Jul 2020 06:29:08 -0700
Message-Id: <20200707132908.10987-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis flags this error

fs/btrfs/ref-verify.c:290:3: warning: Potential leak of memory pointed to by 're' [unix.Malloc]
                kfree(be);
                ^~~~~
The problem is in this block of code

		if (root_objectid) {
			struct root_entry *exist_re;

			exist_re = insert_root_entry(&exist->roots, re);
			if (exist_re)
				kfree(re);
		}

There is no 'else' block freeing when root_objectid == 0

So add an 'else'

Fixes: fd708b81d972 ("Btrfs: add a extent ref verify tool")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/btrfs/ref-verify.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index af92525dbb16..7f03dbe5b609 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -286,6 +286,8 @@ static struct block_entry *add_block_entry(struct btrfs_fs_info *fs_info,
 			exist_re = insert_root_entry(&exist->roots, re);
 			if (exist_re)
 				kfree(re);
+		} else {
+			kfree(re);
 		}
 		kfree(be);
 		return exist;
-- 
2.18.1

