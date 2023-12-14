Return-Path: <linux-btrfs+bounces-960-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7A0813D5B
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Dec 2023 23:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCEFF1C21E3C
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Dec 2023 22:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D38666AD4;
	Thu, 14 Dec 2023 22:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="XTlWxBaD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F56C3FE5B
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Dec 2023 22:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5918f11099dso83198eaf.0
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Dec 2023 14:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1702593455; x=1703198255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mB4WMXaz7dFyTEmQyFn/PgpW9lKUPIZQtgrXyoigau0=;
        b=XTlWxBaD8U3A/evs3uOZfplemtzlQSM6RX4K7HMndKg+H8+vQbqhOC28inrXQSvMwn
         rNCxFHZ4qaDp0js8IVYpvLu8SkPJuAqJXC/KBVoIzUzolNP+QV71LFA7Q9WOx2UzHHCe
         vagzrTrecuH8eN8mGbCrwqewVx5dDZHAAwBScRMheqg0bzSTofyAuKT9cajqA2mMeKmV
         lWVNjkSZ31rVx7qReqW23H5FL07jC+nHAdjc7oAmQ1PJH7aoq4K+P1uemjN6UbJqwFqY
         tTgYieoM/05lrqb75FHcfNM2aBrJmTtfWV4S8WSbT97hYG5v9LqyTNyT2+ZhiwTVgokI
         aZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702593455; x=1703198255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mB4WMXaz7dFyTEmQyFn/PgpW9lKUPIZQtgrXyoigau0=;
        b=PYkZ53z7KSbZOUtBCYduA4z/nI9VX/5OYebgxViC6hmDhnMqVTM0Ak8K2QUo8MddSU
         CgrSW1qvIqKo6jJsdUvyYzidDbNjSYhWNFMIweZVw0PXnle9OXM4segqWEGE3/9gHo71
         CkpHIgJNVVcvuX40hcVWjR1x9r0f7Tdaw1lDHR6jDt/d32tYQdnIO3RiR2wqscNdA5y0
         XUXozgP2N4uh2sJra7lFETtSQNaGvyhHby9CdAi6attDK+A5aCLrzT9lPOO43nG7m2JX
         PSJCCeH7U48yVz95o9XG1eYhv+oGNtDZ3VoT8NQvmbVYVdtVpJiOLoQJQ1q/WdfTP+On
         TBgA==
X-Gm-Message-State: AOJu0YxXVmrwhUQsOCG4rRJqBjdV6YaUKc/cxOjqiC4GnSWRqLs0lL+i
	q0dAXXXkDBCEi2E+4hVgKB3j6MFGFZQeSG8RL1o=
X-Google-Smtp-Source: AGHT+IHd+PsXJCjWKtAU1bi6Z2988r5PAh1yjtLwkEY3gPi946u3Bp5v3FDe2k2h9SVK0psxUZmsQQ==
X-Received: by 2002:a05:6359:7385:b0:170:accb:e22c with SMTP id uz5-20020a056359738500b00170accbe22cmr8332043rwb.54.1702593454992;
        Thu, 14 Dec 2023 14:37:34 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id ec15-20020ad44e6f000000b0067f0306b4c7sm1277604qvb.105.2023.12.14.14.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:37:33 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: ","@web.codeaurora.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: don't double put our subpage reference in alloc_extent_buffer
Date: Thu, 14 Dec 2023 17:37:29 -0500
Message-ID: <dd32747467e46ee7ce4feb8a1c3a30d93fd4b133.1702593420.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fix can be folded into "btrfs: refactor alloc_extent_buffer() to
allocate-then-attach method".

We have been seeing panics in the CI for the subpage stuff recently, it
happens on btrfs/187 but could potentially happen anywhere.

In the subpage case, if we race with somebody else inserting the same
extent buffer, the error case will end up calling
detach_extent_buffer_page() on the page twice.

This is done first in the bit

for (int i = 0; i < attached; i++)
	detach_extent_buffer_page(eb, eb->pages[i];

and then again in btrfs_release_extent_buffer().

This works fine for !subpage because we're the only person who ever has
ourselves on the private, and so when we do the initial
detach_extent_buffer_page() we know we've completely removed it.

However for subpage we could be using this page private elsewhere, so
this results in a double put on the subpage, which can result in an
early free'ing.

The fix here is to clear eb->pages[i] for everything we detach.  Then
anything still attached to the eb is freed in
btrfs_release_extent_buffer().

Because of this change we must update
btrfs_release_extent_buffer_pages() to not use num_extent_folios,
because it assumes eb->folio[0] is set properly.  Since this is only
interested in free'ing any pages we have on the extent buffer we can
simply use INLINE_EXTENT_BUFFER_PAGES.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7898e17e8d84..b42603098b6b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3185,11 +3185,9 @@ static void detach_extent_buffer_folio(struct extent_buffer *eb, struct folio *f
 /* Release all pages attached to the extent buffer */
 static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
 {
-	int num_folios = num_extent_folios(eb);
-
 	ASSERT(!extent_buffer_under_io(eb));
 
-	for (int i = 0; i < num_folios; i++) {
+	for (int i = 0; i < INLINE_EXTENT_BUFFER_PAGES; i++) {
 		struct folio *folio = eb->folios[i];
 
 		if (!folio)
@@ -3754,10 +3752,28 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 
 out:
 	WARN_ON(!atomic_dec_and_test(&eb->refs));
+
+	/*
+	 * Any attached folios need to be detached before we unlock them.  This
+	 * is because when we're inserting our new folios into the mapping, and
+	 * then attaching our eb to that folio.  If we fail to insert our folio
+	 * we'll lookup the folio for that index, and grab that EB.  We do not
+	 * want that to grab this eb, as we're getting ready to free it.  So we
+	 * have to detach it first and then unlock it.
+	 *
+	 * We have to drop our reference and NULL it out here because in the
+	 * subpage case detaching does a btrfs_folio_dec_eb_refs() for our eb.
+	 * Below when we call btrfs_release_extent_buffer() we will call
+	 * detach_extent_buffer_folio() on our remaining pages in the !subpage
+	 * case.  If we left eb->folios[i] populated in the subpage case we'd
+	 * double put our reference and be super sad.
+	 */
 	for (int i = 0; i < attached; i++) {
 		ASSERT(eb->folios[i]);
 		detach_extent_buffer_folio(eb, eb->folios[i]);
 		unlock_page(folio_page(eb->folios[i], 0));
+		folio_put(eb->folios[i]);
+		eb->folios[i] = NULL;
 	}
 	/*
 	 * Now all pages of that extent buffer is unmapped, set UNMAPPED flag,
-- 
2.43.0


