Return-Path: <linux-btrfs+bounces-6741-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EC093D901
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549051F24802
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D435588E;
	Fri, 26 Jul 2024 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="i6a30GNr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32372210EC
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022600; cv=none; b=FB+89Dv2BN/PmAISNIC+ld8DNhG13PjmBQ/ENrelXkcWCXEjM6RbqMNCG+oKl//OHPQs1CS/4APZcHyePYF+uptU0zENC+gJq2SbZZXnlCMBFk4zKoQ3Alf7K4hReNyuEWRs1KrSanaIUsQ5FetgIO/WXx2Lm9a6DQMz6N3QTYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022600; c=relaxed/simple;
	bh=h4rAgk2xnDaQA7nvwBS7TZf698HDAXIGj7CmnFxqmu0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VrXY8txVrJ84qBtkMQ0nskHcsgoBhZ9yPqn0DFAJj64c37Uj83dVAbK4Jq2+35RJP1VekE/I3wah7ce5lhXexMGfA8LZzqfnB97gGTw5ACFw8Rly4Y1FeYIO1CqgnLBFBoijobRXuXnYvyYuAlJRld0+Z/fpcbfUCyMSzKpeG4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=i6a30GNr; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-67682149265so377647b3.2
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022597; x=1722627397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=u8EfvJqPcAVqT+iRcFxmKC6dz02kmHX1ZGGBzZn/2s8=;
        b=i6a30GNrmq8qqdN3aodbz/mhhciEJKRlhNMCyVWNKOoWJAhzBe/e4CzbapGdgfV9Ye
         L5ORLhEzg75RwbBOlwwt22JFFALqld6VA2Fytb7iwFrH+Ycys7OuS0ZT2zRRQqo7AFm9
         +/wIoqI2SeDwfGGLKxfxxzM66RqrS09szykGdS+UNx+19ihEFGr1HR72dIoJCibI76Fz
         tbr65qB2eeAjXczRw1Lzol39vhBM3hiceho94YqC8/7XKFQsVX++kebHuDsZ6zVh1f7U
         xiBm9ipx4nB+FcjP9zn2drbWe2gJj29TNMTJmMJLGCfEkHOWvVIAwligTg9UTYjt3LAf
         GO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022597; x=1722627397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8EfvJqPcAVqT+iRcFxmKC6dz02kmHX1ZGGBzZn/2s8=;
        b=bIbDxWsZcFjO/pjSYA5T7rrgA9g9x/vwCg4MisR8Bs20XlCVItifii2TtNHXitFKbn
         R06Z05kjq2MV1o4W9r93L9gCV8V+hGch3RPeuDjyT0FQFKPY4j6fycPj0ijVpMxT9DC6
         5vTgWjnyn8Es8lLCHOimSTb34CsY9QRaDqz7yV9teObnINYxkWUnq/n+I8bkqaAwW0hM
         PtO01e9dL5R+vYw4JBPvwdaBXWW1PQp4j1fWjbr4QcGws92Hk4N/GxC9ddJE50iTfSD+
         qCS3nfnAO4SWuEqrqri9t8I8BoZakzYpW+86zht/8BNb5JByIpGxffhHYvCfs4hYtnDa
         AeMg==
X-Gm-Message-State: AOJu0YyytNUkS0HvtRWHiEeCidQN7lftrtpZTuC+z0c/6Hz1cyIzo7C6
	cKcgbR6rnciPqo+2po1Ec9UKBGclJunBciKIJ4NN6PiM7zb5K0vO368CSeZhdZU0aQM918zLkCP
	9
X-Google-Smtp-Source: AGHT+IGuSkFomyO4njyYhpHgDfqQ20PFqMiRc2tky2MjnWJeOHeoCkM5GAiY6rI4wVgfasuC0m74DQ==
X-Received: by 2002:a0d:eec2:0:b0:63b:f919:2e89 with SMTP id 00721157ae682-67a057b905emr9737397b3.2.1722022596982;
        Fri, 26 Jul 2024 12:36:36 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67566dda562sm10073057b3.5.2024.07.26.12.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:36:36 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 00/46] btrfs: convert most of the data path to use folios
Date: Fri, 26 Jul 2024 15:35:47 -0400
Message-ID: <cover.1722022376.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Willy indicated that he wants to get rid of page->index in the next merge
window, so I went to look at what that would entail for btrfs, and I got a
little carried away.

This patch series does in fact accomplish that, but it takes almost the entirety
of the data write path and makes it work with only folios.  I was going to
convert everything, but there's some weird gaps that need to be handled in their
own chunk.

1. Scrub.  We're still passing around page pointers.  Not a huge deal, it was
   just another 10ish patches just for that work, so I decided against it.

2. Buffered writes.  Again, I did most of this work and it wasn't bad, but then
   I realized that the free space cache uses some of this code, and I really
   don't want to convert that code, I want to delete it, so I'll do that first.

3. Metadata.  Qu has been doing this consistently and I didn't want to get in
   the way of his work so I just left most of that.

This has run through the CI and didn't cause any issues.  I've made everything
as easy to review as possible and as small as possible.  My eyes started to
glaze over a little bit with the changelogs, so let me know if there's anything
you want changed.  Thanks,

Josef

Josef Bacik (46):
  btrfs: convert btrfs_readahead to only use folio
  btrfs: convert btrfs_read_folio to only use a folio
  btrfs: convert end_page_read to take a folio
  btrfs: convert begin_page_folio to take a folio instead
  btrfs: convert submit_extent_page to use a folio
  btrfs: convert btrfs_do_readpage to only use a folio
  btrfs: update the writepage tracepoint to take a folio
  btrfs: convert __extent_writepage_io to take a folio
  btrfs: convert extent_write_locked_range to use folios
  btrfs: convert __extent_writepage to be completely folio based
  btrfs: convert add_ra_bio_pages to use only folios
  btrfs: utilize folio more in btrfs_page_mkwrite
  btrfs: convert can_finish_ordered_extent to use a folio
  btrfs: convert btrfs_finish_ordered_extent to take a folio
  btrfs: convert btrfs_mark_ordered_io_finished to take a folio
  btrfs: convert writepage_delalloc to take a folio
  btrfs: convert find_lock_delalloc_range to use a folio
  btrfs: convert lock_delalloc_pages to take a folio
  btrfs: convert __unlock_for_delalloc to take a folio
  btrfs: convert __process_pages_contig to take a folio
  btrfs: convert process_one_page to operate only on folios
  btrfs: convert extent_clear_unlock_delalloc to take a folio
  btrfs: convert extent_write_locked_range to take a folio
  btrfs: convert run_delalloc_cow to take a folio
  btrfs: convert cow_file_range_inline to take a folio
  btrfs: convert cow_file_range to take a folio
  btrfs: convert fallback_to_cow to take a folio
  btrfs: convert run_delalloc_nocow to take a folio
  btrfs: convert btrfs_cleanup_ordered_extents to use folios
  btrfs: convert btrfs_cleanup_ordered_extents to take a folio
  btrfs: convert run_delalloc_compressed to take a folio
  btrfs: convert btrfs_run_delalloc_range to take a folio
  btrfs: convert async_chunk to hold a folio
  btrfs: convert submit_uncompressed_range to take a folio
  btrfs: convert btrfs_writepage_fixup_worker to use a folio
  btrfs: convert btrfs_writepage_cow_fixup to use folio
  btrfs: convert btrfs_writepage_fixup to use a folio
  btrfs: convert uncompress_inline to take a folio
  btrfs: convert read_inline_extent to use a folio
  btrfs: convert btrfs_get_extent to take a folio
  btrfs: convert __get_extent_map to take a folio
  btrfs: convert find_next_dirty_byte to take a folio
  btrfs: convert wait_subpage_spinlock to only use a folio
  btrfs: convert btrfs_set_range_writeback to use a folio
  btrfs: convert insert_inline_extent to use a folio
  btrfs: convert extent_range_clear_dirty_for_io to use a folio

 fs/btrfs/btrfs_inode.h           |   6 +-
 fs/btrfs/compression.c           |  62 +++--
 fs/btrfs/extent_io.c             | 436 +++++++++++++++----------------
 fs/btrfs/extent_io.h             |   6 +-
 fs/btrfs/file.c                  |  24 +-
 fs/btrfs/inode.c                 | 342 ++++++++++++------------
 fs/btrfs/ordered-data.c          |  28 +-
 fs/btrfs/ordered-data.h          |   6 +-
 fs/btrfs/tests/extent-io-tests.c |  10 +-
 include/trace/events/btrfs.h     |  10 +-
 10 files changed, 467 insertions(+), 463 deletions(-)

-- 
2.43.0


