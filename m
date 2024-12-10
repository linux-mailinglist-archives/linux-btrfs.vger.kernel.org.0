Return-Path: <linux-btrfs+bounces-10207-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC509EB9D4
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 20:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D952838ED
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 19:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E32214211;
	Tue, 10 Dec 2024 19:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLmkJiVb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6DE214225
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733857643; cv=none; b=BUNeNrfT8qe+/UfUiakRf6oJqCQdHGrDCbButdsUjLXybNbkmlubTzCG56CxY839DT9jvF8A3UhVV2KiUcxtgcrKNCHCRuHnlyYKegs0vKX/ZRuFrJ+EDbKd1LeEMEn3fclX9keXSvz7JhBBusWKY66K7wGi5bzzTnAKQNca0m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733857643; c=relaxed/simple;
	bh=rE2JRa2vMH1KTn+e8FshDcfFw2OgEUW8KQZil3zkeWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOTOYjTfWr3VjUdFxiTpiLyIHt8aYsBwJmeJtFI5119jkg8UZgjo0EO+/XvBn7VW4cinU1F5DJuMcQgsxN0xFQtbzT6Aya4YoxGx9vOtNuAfugv7OFEwIV2uctpA7rGfPufJcoqD09Rc7bZobY7tvn+2Vf/XFPV0OfNS7NdtKaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLmkJiVb; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b6cade6e1fso256545885a.2
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 11:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733857641; x=1734462441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+UKBoxgvQR92hnDJPw3s4sy11hDJlDFZCIASLiBTB4=;
        b=kLmkJiVblgoKiKP1O6tbHcRTUZRtcqLfNYCKA7T6rNPUtzaDps65bhRmvtjFArmQ4s
         nu6ILJ+aRueB95969j4pqtRAyMlIiaogqdMfHZ0wsbai/fSWdi+60J2qV340d+LI7rzF
         RDM1H6xaOgBEDpvCbyBljV9Jw36Xz8AYeaAZQa1Cz0bmZciyWdNHfNA3Xu0vbu/Dj2CW
         s2twgfyshwIREFYagNJ97GZBFZUdEhGTvcx2PQ8phCD7N+Ths75yRa5KZmtEt00z/ZMx
         l1zTt0Na9xVKV46c8TRBNida4B3UPSFS5GlwfBFad6O67h7ojrPFeK2krn9/EpJf6CjO
         TwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733857641; x=1734462441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+UKBoxgvQR92hnDJPw3s4sy11hDJlDFZCIASLiBTB4=;
        b=L6TkNWV+LqOF/teA74spbKRh8eWTPk9AdfgyJJqj03WAUv+ztiucibFmHz5siVbnIY
         Hq/ARs6K7WHPd+lR0c/S7KK0VmmqryZHxTQPzxG9IZcE30LbRC7bxR/DqAbl9tEYgddD
         96tHzQx4+I6A24XsYTDdA8ZX3nss3vu0DJAueui1s0MSx2EjtzXtLmWlColJLST1mCi3
         twnZiFvnyrHt7cfH14F2MThYeC9F1UxArjCQiwZw9WQ84wggxA/41emYcn9bxjIYSHOt
         exuAZo3WBVYcou6AigP/Ga2MlsKAYL22T+IYBhC7mDFCjuJshJTaDUvfnkVnv9IBnX+d
         aZPg==
X-Gm-Message-State: AOJu0YySAxTiHsKlBLdmtKqQJMJshjg+2snlkOJLvvPCYcOArrbnNHOg
	B+w1s3+Y3xuZC1F/zB7pFLQUK9SvAHDemnwwelhZ+SD6OFxODlpgcBqXXQ==
X-Gm-Gg: ASbGncslIErN2VaqSkLoh/zyodMeYvXs3aKsUCKqmQFGZDhBReIarLP67Q5vcOrY3NX
	A4iFKt+CRV35EDbtJDqKxEgbnH4ANmld3tdOlCWSiDy5p1JmS5bKMa257cSlBJD0nDJ8l3ScJAa
	2xEKM8XsrX0gQIKVznVEUyz/t+Xon2YGp5t6xFXO6hzKH9/AVGjdrScNeBeMbmO5xhiMxT56yZX
	FwehSUr+qvPA1/2WpNPBefLfPRxYPXf8vybpGx9YpS1yTQgZtwojlsiacTBzS8=
X-Google-Smtp-Source: AGHT+IHEZJK/H69fBW0J9f2VJo/fAEw/JQ3rfGQ1ULa1OY3F8Cct5LR08kj7EEosk+eQxxxQ3CVB2A==
X-Received: by 2002:a05:6602:29c7:b0:844:78e1:ea91 with SMTP id ca18e2360f4ac-844cb58f62cmr71348439f.3.1733857630192;
        Tue, 10 Dec 2024 11:07:10 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844cb2611b5sm7044839f.38.2024.12.10.11.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:07:09 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: [PATCH 0/6] reduce boilerplate code within btrfs
Date: Tue, 10 Dec 2024 13:06:06 -0600
Message-ID: <cover.1733850317.git.beckerlee3@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733695544.git.beckerlee3@gmail.com>
References: <cover.1733695544.git.beckerlee3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The goal of this patch series is to reduce boilerplate code
within btrfs. To accomplish this rb_find_add_cached() was added
to linux/include/rbtree.h. Any replaceable functions were then 
replaced within btrfs.

Roger L. Beckermeyer III (6):
  rbtree: add rb_find_add_cached() to rbtree.h
  btrfs: edit btrfs_add_block_group_cache() to use rb helper
  btrfs: edit prelim_ref_insert() to use rb helpers
  btrfs: edit __btrfs_add_delayed_item() to use rb helper
  btrfs: edit btrfs_add_chunk_map() to use rb helpers
  btrfs: edit tree_insert() to use rb helpers

 fs/btrfs/backref.c       | 71 ++++++++++++++++++++--------------------
 fs/btrfs/block-group.c   | 40 ++++++++++------------
 fs/btrfs/delayed-inode.c | 40 +++++++++-------------
 fs/btrfs/delayed-ref.c   | 39 +++++++++-------------
 fs/btrfs/volumes.c       | 39 ++++++++++------------
 include/linux/rbtree.h   | 37 +++++++++++++++++++++
 6 files changed, 140 insertions(+), 126 deletions(-)

-- 
2.45.2


