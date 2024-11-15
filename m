Return-Path: <linux-btrfs+bounces-9711-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D679CF0D5
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 16:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1246B2AF7C
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 15:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB5B1E2614;
	Fri, 15 Nov 2024 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="WgCxMT83"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A031D517B
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684690; cv=none; b=ZtyoTzbukwYalgxLN4JX2dxX9dXdy3+7idrx6oCEiF7eIIJyYI12Awkd8211kkzqiW/PUKjAr7nhmu5BSxHpb0vQNlbNgLeZAe5UAVbakoblY8Fh1NTMAdcux6Oc85MkH8Sstcku6u8KT4CHMfPiMSC43MJ1xl9rXmfi0Q06mbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684690; c=relaxed/simple;
	bh=lJOFXxVHcZLI+SjVd+0f1jV7QzcPV4Ai9MyZQsFymWc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ttGGsPQ68zL4Lm4Oz7V6ITProkAhhEqR4MGtxrQsvaDwVdrIPS1yR+pdSMBz8QAIHEPl9Re52WWCnPCuR249A2Ki+tnDAPcBnlyjMvKgqkdt7CM/GChhjcicGkfGZKITokmsZ3xPuPT9oIGkl0kc0K/WgFmSBAdDPX/Fstc2JHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=WgCxMT83; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e38232fc4d8so937703276.2
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 07:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731684688; x=1732289488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jVczlJ/TW6EECuU4gj9yYFP++VZ/oJUqPiY9P+PdPU=;
        b=WgCxMT83OJndjUPd1bpnut4k1njFzRSZT+45Xv3MOuEfIXNhQ8xGLPxT0GqdDQHzNP
         3FAWKaE95mHY8cUM+/Z5QrkWB0K2NYjSpt+ynKmwctxgJinxlfalSnXxa8fOhVKxfb/r
         tf9/isOH+Yy4aOI396zxw1OlUitAZJj1uMr/FmQMmtcFWRgeXhdZF1/+5AnF88+K0ilc
         MC9tIpVfjIx/NdV9UCRqJaDktOuFLyAn5ypGjSbY6Kzd8xez0CWvSR9ZXhOdtDojIykm
         hIY+HUEro6Ry3Z00n1ne4KcwAg4GG0CxfnafkIR/PjPfO5G+FTo/yMRJ4Yjgj1LodC5Q
         NxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684688; x=1732289488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jVczlJ/TW6EECuU4gj9yYFP++VZ/oJUqPiY9P+PdPU=;
        b=ZhjLMO3tvqZ78wVwX1eMIeWXbiu/ggDj1fEr85OwPsaVWpCrYFgjdBJqvbFpdPcaWT
         Bl+PYh5Pmn9fwFx41z4OSM4et33t3s6Cou3stUqJphaWW2n7gT73n0lzw2MArdBKOdD8
         u+WUBzhiz4CVH0qBZ119G6xKfBfJfllxvvumGXVZK5pqnBEVq8ud5gyxSlmgJuFKScGo
         fHX/M96VgLsuH3Eh9KBgtgy6wX8/BTybMamPB3RiH/7XFhSg4uDBm0mRAQzrzKTZdXtw
         2OovlzN105IwBu+dUKIZgQQnGV+/f218OzvgovX8TTuU6U+g2hx4yUpH/ahADXZn9vd/
         hbpw==
X-Forwarded-Encrypted: i=1; AJvYcCXfne9eueqhy9/v/Kjt5WKKHzvtpobWzOeucYJRageHRgcg0Tx2eb2+r2oFj/DzoSXmIYhXpTQpP88RUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJaxSVeWbnaDtydvQaDLaB81PioNXaRXHPoJNj5DJSDWq3v7iV
	P0Z0lBf8FGHDDJQQXSr0qkxFIFCbeDX9PjlorgDgmKF0/cboVWuyp43oKRED0O8=
X-Google-Smtp-Source: AGHT+IEWEdrPnRli1gv+jVnLYsORdUcuZyTi/FsZKRBYcdcM64Io8ydfsi1gmscyy1vF3dAQcsDh6w==
X-Received: by 2002:a05:690c:4c02:b0:6ea:2ac4:9df6 with SMTP id 00721157ae682-6ee55bbade0mr37073597b3.3.1731684688405;
        Fri, 15 Nov 2024 07:31:28 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee4449516asm7602087b3.124.2024.11.15.07.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:31:27 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v8 04/19] fanotify: don't skip extra event info if no info_mode is set
Date: Fri, 15 Nov 2024 10:30:17 -0500
Message-ID: <afcbc4e4139dee076ef1757918b037d3b48c3edb.1731684329.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731684329.git.josef@toxicpanda.com>
References: <cover.1731684329.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

Previously we would only include optional information if you requested
it via an FAN_ flag at fanotify_init time (FAN_REPORT_FID for example).
However this isn't necessary as the event length is encoded in the
metadata, and if the user doesn't want to consume the information they
don't have to.  With the PRE_ACCESS events we will always generate range
information, so drop this check in order to allow this extra
information to be exported without needing to have another flag.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/notify/fanotify/fanotify_user.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 919ff59cb802..8fca5ec442e4 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -158,9 +158,6 @@ static size_t fanotify_event_len(unsigned int info_mode,
 	int fh_len;
 	int dot_len = 0;
 
-	if (!info_mode)
-		return event_len;
-
 	if (fanotify_is_error_event(event->mask))
 		event_len += FANOTIFY_ERROR_INFO_LEN;
 
@@ -754,12 +751,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	buf += FAN_EVENT_METADATA_LEN;
 	count -= FAN_EVENT_METADATA_LEN;
 
-	if (info_mode) {
-		ret = copy_info_records_to_user(event, info, info_mode, pidfd,
-						buf, count);
-		if (ret < 0)
-			goto out_close_fd;
-	}
+	ret = copy_info_records_to_user(event, info, info_mode, pidfd,
+					buf, count);
+	if (ret < 0)
+		goto out_close_fd;
 
 	if (f)
 		fd_install(fd, f);
-- 
2.43.0


