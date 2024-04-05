Return-Path: <linux-btrfs+bounces-3963-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B06589A1F6
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 17:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F951F21903
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 15:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B38816FF5D;
	Fri,  5 Apr 2024 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeLBhl1X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4289216F82C
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712332525; cv=none; b=FRfk7PNvcsv6cAXZFWD+OVwJ58ctpe63/xngT/5jQ+a1LV4FopIyKgVO1KmJMk63t2xZQ8U9HKTpDMl2pca9o2++EnHp6go6vIxnGXK92I9R5m4fS7mAb/3b2jwlHiVw4cbXCFbvG7oaAK8BvXYrnCZlWbhSTy6FTGDxWO9csJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712332525; c=relaxed/simple;
	bh=nVg1VveLZIzIj/0bPNAGDzQA5DPqpldWVBjc0RK6Bv8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=MJsVdEwYjc+/8zvFg5GKQgeyNjILVMx601tpGpRiTmAHtTuTwLF6Y/scu3vRESWsM5HOxiDjPjipaNrervR8n0daPax9iqE+n+3mEMR8Ikh7NoRVwBB1AFQqU/qmBOgrJDVG3RXj18O6bKoV1Sp6DO7iB/Q83iqGUZ2GvWTNrvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeLBhl1X; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e69a9c0eaeso1500481a34.3
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Apr 2024 08:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712332523; x=1712937323; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aaqeuVi5FYeirmQFpF5ZZ+2X9vTeFdhVlzSWpBbSnXQ=;
        b=TeLBhl1XbDxj3UULrMngDG4aPRQOEYAmobR5e25bLWeB6qTtBWeiIQDA3Ekrn4dQC1
         h05eWMCmfaqHcsWKIU6XaO5y83VxKVcjmCu71CP2e1YckXLOI057hZHosoFpWsqZGQTp
         QcMc99cQPQrtNuXLR5oKyYsY5JPfj+oEOFffrKLYeBQrIAxMDxFpJHZVt9PDbPp+bbLA
         i+BCCHowbdtyMXtlqvOjALkkE9cTKYneg5EKNMciBcd3QDruZdJvOpltTLBtdY4CkzDY
         Qs43NionFD3lUps6zjUhROcNKcjWUbNgwBYFmOTrsWmFYGaFURNi4qV5kxHMTt+zeMzI
         rL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712332523; x=1712937323;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aaqeuVi5FYeirmQFpF5ZZ+2X9vTeFdhVlzSWpBbSnXQ=;
        b=r9GATfS9c/+tH9OmvTwTPt2SWjDzKSPgiDOt+txfaEd7buuOlvtx6eowo8JepwpHS1
         115BmFiM0uJyjbWZCaYQKzwIStjbJZKXSZZytnZMSoK67lxWjvC62X/+pkLGcoEDNOVv
         9Syi4A/EdrMBnIPuF1GyM1RFrrXvIv7fkye6QYWciOEOjeqkFM+skwkBth9cFx+zQ3kZ
         8Qn+QnJpN4Z/+5zvzKyeoCthedN86Gqld6F/O/4vxWrJCS9FKDGYp6ybG6uGq0dxsg0U
         n9phFkUM65OE+ySLH4HBabr3cDKcO7UvB75I9H1kNkaguQhyaWg4c8ZY/3MS4Juc2qYp
         LXcQ==
X-Gm-Message-State: AOJu0YxLZ/wcbXMo4N+zNDKSiNa+sUp8GjFR9ThL7K6TJ21jUNFqPvuy
	EuszXXMz1uLVJErdXjPlOTCUqlNGPTCIP45mU/VEGaEAQnWMgjx18I9gSwXlD+B4BvpNKvKADiC
	KgKYRgwlvFquiJQq5c5JD5hd5yX/rlvJte4o=
X-Google-Smtp-Source: AGHT+IF2P2GoI1mg06sInndJMIdvDwsqOQW6UeUtwG3/DzGBPo81GAdFlBA7y85dAtdegeFNd9Y1ar+HnqJxxDo085E=
X-Received: by 2002:a05:6358:224d:b0:17f:870b:9dfb with SMTP id
 i13-20020a056358224d00b0017f870b9dfbmr2515198rwc.0.1712332523189; Fri, 05 Apr
 2024 08:55:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nathan Mills <the.true.nathan.mills@gmail.com>
Date: Fri, 5 Apr 2024 08:55:00 -0700
Message-ID: <CALjJ9cdoxY7E4omFtXcZigNV9Q8_+q95do=b=PrzsN+JbBK23Q@mail.gmail.com>
Subject: Inspect command leaks memory if realloc() fails
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In `cmd_inspect_list_chunks()` in Btrfs v6.8-g3793e987 on the master
branch, there is this code on line 1167:
```c
ctx.stats = realloc(ctx.stats, ctx.size * sizeof(ctx.stats[0]));
```

This is a "common realloc mistake" according to CppCheck. The fix is
to assign the result of realloc to a temporary variable and only
assign the original variable if the temp is non-NULL. That way we
don't lose the pointer to the old memory.

I found this by grepping the source for this regex:
`([A-Za-z_0-9->\.]+)\s*=\s*realloc\s*\(\s*\1` after noticing a
CppCheck warning for a different part of btrfs that already uses a
temporary to hold the reallocated memory.

Here's a patch to fix it (note: this patch probably won't apply to
devel because the goto label has been changed in `v6.8-19-g512fa7e6`):

commit 7f65051ee07a46a9cb7e0aa0134af0cc77db0a16 (HEAD ->
realloc-memory-leak, myfork/realloc-memory-leak)
Author: Nathan Mills <38995150+Quipyowert2@users.noreply.github.com>
Date:   Thu Apr 4 19:34:28 2024 -0700

    btrfs-progs: cmds: fix inspect memory leak.

diff --git a/cmds/inspect.c b/cmds/inspect.c
index 145196d0..e665a281 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -1162,12 +1162,15 @@ static int cmd_inspect_list_chunks(const
struct cmd_struct *cmd,

                                if (ctx.length == ctx.size) {
                                        ctx.size += 1024;
-                                       ctx.stats = realloc(ctx.stats, ctx.size
+                                       struct list_chunks_entry *tmp;
+                                       tmp = realloc(ctx.stats, ctx.size
                                                * sizeof(ctx.stats[0]));
-                                       if (!ctx.stats) {
+                                       if (!tmp) {
                                                ret = 1;

error_msg(ERROR_MSG_MEMORY, NULL);
                                                goto out_nomem;
+                                       } else {
+                                               ctx.stats = tmp;
                                        }
                                }
                        }

