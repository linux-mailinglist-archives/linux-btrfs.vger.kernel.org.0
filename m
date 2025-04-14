Return-Path: <linux-btrfs+bounces-13007-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B261A88C51
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 21:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3821B1898750
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 19:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EC818DB20;
	Mon, 14 Apr 2025 19:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="J5YGIGcx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA111C8FE
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 19:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744659163; cv=none; b=sffzo9f17Ddph44v4Jmu3Grl9PPX9IqPoRnEpLZY3elCLQNsAjnoiPk83Shxstq2XwErLu2dGgnLKGFJmIn3wUWAWY7BqM8mfpbPMBcGJZ7WhjbH1SlrA8bTVFs68TlGjBr04gGOvVymTuAie4t0fSDMnPuBmB5VlA6lqXb9EuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744659163; c=relaxed/simple;
	bh=lu4B6ClnaH8lUrhzrqyWB8b84duS9imDeeIgVYzIVWc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=c0ZM631IHIuUhO4GKTF+3lrhi/RugoWsEAQsGTPHCggS5CJSpIN9pX75i30968z3NTaL6gG7MGPnGFe/cfvJFtdkXPHtQlppdz3Ta4VhcBWcDT/3DELiSsTGeMWCmiDxh1bpkrLXvBT4g8sujE7UoZsBiqS3eI7SB4LMH92PBqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=J5YGIGcx; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-70433283ba7so44908007b3.2
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 12:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1744659159; x=1745263959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kqkodj3jh1cmaZJoJNvt6pcNHeToqbo6gsDFHgYXRA8=;
        b=J5YGIGcxjN5h+mLWxy/j6vX3ZOikBRZN6S2Tj0bUJ9MsNxZrc5V/IIDGiqkNHp7x9q
         KMjwFXRMSUPf8C24PbgMR6ChCmcvIzk78r8DdSMmyLLEOojMTLm8Fmnnue8gAXyG98/A
         BRD0e3c8ArOy0hE2DI9rmXHQx4Vt4eFTq0PNnFx1+raHX0DrM812nsAsOpVzlfMEZt7k
         e/c+6u4zsOBKezpMTIcVgGyaoi15ZFnBnb3fDJq8A78+BHzfuNrBvpzAtI/u6P6IAbFq
         YiLOryPuLHrFh43a5yVLBazNypE+1sDARN/U+Z7OYmmCe0vMVbeyVch7G5j8qIG+aiJ3
         /SPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744659159; x=1745263959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kqkodj3jh1cmaZJoJNvt6pcNHeToqbo6gsDFHgYXRA8=;
        b=Ia/dwPc0G6Ebak6uubJObRtBoqLfDwvYbdVffScw6xf1q6TsqGdzNho4MU0aAOFRnu
         Wj+tB2GZVRq5jl+xfC6TAwtwinF5p0Yn9dNtkkvIT9TwnZX4klB53dzrS2HtkdfS6C1d
         OFpBluXER6fUwnqCMA7MiT1M9QLoRmQu2uke5YfK8j/gFVtvHLUnLxgf+97vqmdbo/GN
         PMqNAPBnmEObCCcGFpLHMpGQJPE00nSeV1sUTvR46QFN1iHSmZJxQ7tvM0GUxtswnW0P
         9p1jRCfUpmBBwoOfvEtY5cO4wYTDYt3SYU9Jfj8TX61jI68iAeBDGt64INpHlnbeBP56
         jKaw==
X-Gm-Message-State: AOJu0YxESRiYa8nS7RLgAnWA6AwDCvDb7ix2aVPIKQT0QULiVeDnxyjr
	/OzS1mj5azy9JNnKQMXg1E0YvHuvJScw/Epok6aHPRHdCgVTJACOM5BZdPU9lydnvoLklVlj/4q
	k
X-Gm-Gg: ASbGncvgcfdcbCzxbsc/PWVDWtnuV7Z3RzcwSfW/39043MyAKrv8hpRt9a6AB8AiYkx
	bWzdWlItAQTVXs1ku5jKIeDyczASLOFzK0LOCmkmW2fHHohQjIUaDlfXtQO1o9bqau9Y2vad8re
	GIEVw3OqVvkYeADKSktg8c33kpaYeyzFkCsBJfzxY+PVJpgjkdn2+13Ql3KqXJM5yFJ7ZxZRFwY
	0OlaPnZMuT6BzT1cIWxCdlpqhia5Vy7HO4uytksqzEegjNcNIikh6zGJRN6vOymZMC/i6xDsTl9
	UgKq78KSGQgcXbOErmUZAIXwKmGF8k3bPL/oDX+PZnGzHFL5N8SQkmI3/1/u5sp3m0+GFGP6lbz
	xtmlRbFuHdp3p
X-Google-Smtp-Source: AGHT+IGJscizLdqpM1JaYkSgdGW0YEgVWi3agpX4gnakU5Id01ZKTLPnSYVZVD/xcbEklUtrJifu/A==
X-Received: by 2002:a05:690c:45c2:b0:6fe:c803:b471 with SMTP id 00721157ae682-705599d7d6amr229480597b3.16.1744659159358;
        Mon, 14 Apr 2025 12:32:39 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7053e11a6f3sm32261987b3.40.2025.04.14.12.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 12:32:38 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: fix race in subpage sync writeback handling
Date: Mon, 14 Apr 2025 15:32:34 -0400
Message-ID: <ff2b56ecb70e4db53de11a019530c768a24f48f1.1744659146.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While debugging a fs corruption with subpage we noticed a potential race
in how we do tagging for writeback.  Boris came up with the following
diagram to describe the race potential

EB1                                                       EB2
btree_write_cache_pages
  tag_pages_for_writeback
  filemap_get_folios_tag(TOWRITE)
  submit_eb_page
    submit_eb_subpage
      for eb in folio:
        write_one_eb
                                                          set_extent_buffer_dirty
                                                          btrfs_meta_folio_set_dirty
                                                          ...
                                                          filemap_fdatawrite_range
                                                            btree_write_cache_pages
                                                            tag_pages_for_writeback
          folio_lock
          btrfs_meta_folio_clear_dirty
          btrfs_meta_folio_set_writeback // clear TOWRITE
          folio_unlock
                                                            filemap_get_folios_tag(TOWRITE) //missed

The problem here is that we'll call folio_start_writeback() the first
time we initiate writeback on one extent buffer, if we happened to dirty
the extent buffer behind the one we were currently writing in the first
task, and race in as described above, we would miss the TOWRITE tag as
it would have been cleared, and we will never initiate writeback on that
EB.

This is kind of complicated for us, the best thing to do here is to
simply leave the TOWRITE tag in place, and only clear it if we aren't
dirty after we finish processing all the eb's in the folio.

Fixes: c4aec299fa8f ("btrfs: introduce submit_eb_subpage() to submit a subpage metadata page")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 23 +++++++++++++++++++++++
 fs/btrfs/subpage.c   |  2 +-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6cfd286b8bbc..5d09a47c1c28 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2063,6 +2063,29 @@ static int submit_eb_subpage(struct folio *folio, struct writeback_control *wbc)
 		}
 		free_extent_buffer(eb);
 	}
+	/*
+	 * Normally folio_start_writeback() will clear TAG_TOWRITE, but for
+	 * subpage we use __folio_start_writeback(folio, true), which keeps it
+	 * from clearing TOWRITE.  This is because we walk the bitmap and
+	 * process each eb one at a time, and then locking the folio when we
+	 * process the eb.  We could have somebody dirty behind us, and then
+	 * subsequently mark this range as TOWRITE.  In that case we must not
+	 * clear TOWRITE or we will skip writing back the dirty folio.
+	 *
+	 * So here lock the folio, if it is clean we know we are done with it,
+	 * and we can clear TOWRITE.
+	 */
+	folio_lock(folio);
+	if (!folio_test_dirty(folio)) {
+		XA_STATE(xas, &folio->mapping->i_pages, folio_index(folio));
+		unsigned long flags;
+
+		xas_lock_irqsave(&xas, flags);
+		xas_load(&xas);
+		xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
+		xas_unlock_irqrestore(&xas, flags);
+	}
+	folio_unlock(folio);
 	return submitted;
 }
 
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index d4f019233493..53140a9dad9d 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -454,7 +454,7 @@ void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
 	spin_lock_irqsave(&subpage->lock, flags);
 	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	if (!folio_test_writeback(folio))
-		folio_start_writeback(folio);
+		__folio_start_writeback(folio, true);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
-- 
2.48.1


