Return-Path: <linux-btrfs+bounces-961-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FBD813D68
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Dec 2023 23:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3C41C21D95
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Dec 2023 22:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FCB671E9;
	Thu, 14 Dec 2023 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Sq4W6YCp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494A166AD9
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Dec 2023 22:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-77f59fcb204so3919985a.3
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Dec 2023 14:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1702593583; x=1703198383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vRvi98Wm8PCsRancz6ftSljs9Q/E5UB8k2DC0NipNW4=;
        b=Sq4W6YCpC/7/mUJoRprzILLTx0+GgCVokGNvVGRB9YH2V75bWsiXbK04sRqD0IUKDY
         J9jchXGa2d0Rb4M+g7CxRHO8cBE5qavojbfOKuaJUU6QlQrprUASIUkeP8O8dSOIfLZZ
         0Cts9doL9/N6MOunLdFuxvIJ6PuIatB60HbiPszB5/zfTRr4JfQcQUm3HjiUHKrQrLi3
         gnUKTwUg3KTP517Ny7tbfeSvavL3eTIyt3kCD2PGF8xme2kHBl8MveW86XXJCkQj4/xk
         nfBLc8Dzd8KubGSzk7bwpW7n5P12NFp4s7y6igPJfjfX+j6ya4KcwXxJQpEs53IrJsHK
         D2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702593583; x=1703198383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vRvi98Wm8PCsRancz6ftSljs9Q/E5UB8k2DC0NipNW4=;
        b=Y3ZpVSqKQ/LgF3nPwJFw80v8tVsg2mVjZ24Bu8fxC+hdtpBySW+OZZ/2vDkJXdXzLC
         ryPITI6q1FGTIVs/4ZnC1I9NiJY+99m472UicgoOUQxF+iYxGXSkGu//jWQBfFRgHF8I
         45ICbsq6e1KhxhwKV2kyS92m4bYfBt6ZIo27df0XJk9PcuztV4EkIeMbBq9yW8Pw152t
         GILxj3DYQT8o+pzvBEgXlSB2i/HhQSN34q0mM1wrXknYMisMP/SGta+VtTxNmIYeyMFK
         mvhnJJzKkl9ijHaosqRTRu3B+34/ouUKlESah45xdgkRwB15jvkncdn5vuphw/fCoq+w
         g89Q==
X-Gm-Message-State: AOJu0Ywe7RdM2S/QBc7WtgjL/7O4TS32Zpn2fQN8blEd09U7TWaAfVWL
	8V5MZbtyhFt7uicX5XCIdTSnOt1f6rOGwuUpW0E=
X-Google-Smtp-Source: AGHT+IGNxa2U+cT/j5tqLR2PhwCQtHiNaO97VtwDBbhwmDxWOkDp0tTL20OsFUs3OTPTeeo3PQX8MQ==
X-Received: by 2002:a05:620a:349:b0:77e:fba3:7587 with SMTP id t9-20020a05620a034900b0077efba37587mr11176174qkm.127.1702593582935;
        Thu, 14 Dec 2023 14:39:42 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id g2-20020a37e202000000b00767dc4c539bsm5532869qki.44.2023.12.14.14.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:39:42 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH][RESEND] btrfs: don't double put our subpage reference in alloc_extent_buffer
Date: Thu, 14 Dec 2023 17:39:38 -0500
Message-ID: <dd32747467e46ee7ce4feb8a1c3a30d93fd4b133.1702593423.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

** Apologies if you're getting this twice, I fat fingered my email command **

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


