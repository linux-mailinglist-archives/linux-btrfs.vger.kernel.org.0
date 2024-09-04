Return-Path: <linux-btrfs+bounces-7828-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0455196C872
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 22:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B623D288E2B
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 20:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8EE1714D8;
	Wed,  4 Sep 2024 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="baH9sSF2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C283A154458
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Sep 2024 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481768; cv=none; b=e8TdQI/YyOeTog55gkJSo+f+vu0l++fvd243oMKEKlZTCe1/fXi/UJNOoDOH4/YD8zAfCPdkPHktIogvBTqbYo+4xjVKHCsCEE3LAbQqCLqTfiIFDfsBUoJnw7ynj9lpl8Be75ZlEbFnj6apm1yltXqEwtWSTRaUtMeofCxFPR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481768; c=relaxed/simple;
	bh=qausY9NaTn1Dmt/1fWvpjV6gSoo0TkpL7RjFx1j8ing=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRyBgSaz/+pvCNJAlLAHSQh3VMBh6IegZ5Xb9B1xjDW6hzRCU9f5m0JQCwVMqWFzlULixPdOT1fPGdkd0RDxoq4a2KlGEvYpSE3UOk2d1XgiX1xgXviaKJ5582pE3ZFW5XBsmGuvO6xTqLIBQ810LQiKlFdfdwSu8qN1LpP3lNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=baH9sSF2; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6c34c02ff1cso41106d6.2
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Sep 2024 13:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1725481766; x=1726086566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JmFE9zypkxWwtjgDkL/vbyJWxHrdDWRoGs2W5KUFOnA=;
        b=baH9sSF25BC9MoGa72zssTgL4tSh4NUw65xw5uzBY1Ah2S3c/4aaV3+ZPuuFsEo+vz
         VXOTNl8x4jAy0C7ecGAirSYKAmWXv4NzHV6yQJM4PqZS7aFREYL3eblUgynJY6L6nH0M
         szpM6SmlHWi42JXLOjCtPwA4gboAwY9v+R76KatEPunSWuj1G6RaiQmQxjS9CMR9Q6MP
         NodiiVjHaC/rxBfv9eRQNWQBW6wEgUWwwGtZxTjZFkwAMC3/h2lj3UuiMEE2Bl2lX8jW
         GXnrodJQ+MbQichckjWC8x+4m2knti2kBzLIR0r0GFkvkLQ69rbfn/lDMg6rWA8fS5Ws
         LoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725481766; x=1726086566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmFE9zypkxWwtjgDkL/vbyJWxHrdDWRoGs2W5KUFOnA=;
        b=qELaI3o0RtuCabdut/a+Fv5dgQl2SJS5QCFj4/36VLsS6rhKVZO/JUaPDllT0lYiDP
         hGaXbDhh6NF2Lpm3J59bwnpgKvwCwJh5rmi5jBjbNI+U4ADJv46sRXsCIDB2sXWMyYeA
         /jskVoYPy3bwNHF1fCPxOhG4USfNYAU275IhzELGQp7qrXWqG+M2F0ynHxDK5OE+GnHf
         MEmnb3YwzeXCTz0nFeG+cATYf23T64AmfwuqDfIWwdPqPuS2GwCVq0VT9q/B5oq/eUm3
         Nk/bxkqlz8d4IYiIWLga423yGvbDMilf6wX+qec6MI0FgyNYovhFOQ76XuhPeBrfbIew
         Vh9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmMWm0HhrvR2TXmr4h32jMxfiUxV8epmQ/dBz1c0uDB4+o7z4m8KJ1xXHIPPGRzxCLQ3wrIHqWCyD9iw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5YiFpNUQK5zA6zFozBJYYlkrgXN5TXYtmCr+oLj4I3E72bbZA
	9SSQ/hTAjusquBYkx/scALdIhNcZFu3Q8gct6V5ZrM+v5n2N8MU9Q+LdS123sNw=
X-Google-Smtp-Source: AGHT+IFz/IUidwqQ59xRLvRnlzpJcJ1KGg9KuPmXBEEett+13VoyzgSnYGWxrufSaJ5p3j4xy3X2+w==
X-Received: by 2002:a05:6214:4b09:b0:6c3:54fe:ebef with SMTP id 6a1803df08f44-6c3558359fbmr194853636d6.43.1725481765951;
        Wed, 04 Sep 2024 13:29:25 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5201dedd8sm1621726d6.7.2024.09.04.13.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 13:29:25 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5 07/18] fanotify: rename a misnamed constant
Date: Wed,  4 Sep 2024 16:27:57 -0400
Message-ID: <13c1df955c0e8af0aee2afce78b1ea1f2e3f8f66.1725481503.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725481503.git.josef@toxicpanda.com>
References: <cover.1725481503.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

FANOTIFY_PIDFD_INFO_HDR_LEN is not the length of the header.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
 fs/notify/fanotify/fanotify_user.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 3a7101544f30..5ece186d5c50 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -119,7 +119,7 @@ struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
 #define FANOTIFY_EVENT_ALIGN 4
 #define FANOTIFY_FID_INFO_HDR_LEN \
 	(sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
-#define FANOTIFY_PIDFD_INFO_HDR_LEN \
+#define FANOTIFY_PIDFD_INFO_LEN \
 	sizeof(struct fanotify_event_info_pidfd)
 #define FANOTIFY_ERROR_INFO_LEN \
 	(sizeof(struct fanotify_event_info_error))
@@ -174,14 +174,14 @@ static size_t fanotify_event_len(unsigned int info_mode,
 		dot_len = 1;
 	}
 
-	if (info_mode & FAN_REPORT_PIDFD)
-		event_len += FANOTIFY_PIDFD_INFO_HDR_LEN;
-
 	if (fanotify_event_has_object_fh(event)) {
 		fh_len = fanotify_event_object_fh_len(event);
 		event_len += fanotify_fid_info_len(fh_len, dot_len);
 	}
 
+	if (info_mode & FAN_REPORT_PIDFD)
+		event_len += FANOTIFY_PIDFD_INFO_LEN;
+
 	return event_len;
 }
 
@@ -511,7 +511,7 @@ static int copy_pidfd_info_to_user(int pidfd,
 				   size_t count)
 {
 	struct fanotify_event_info_pidfd info = { };
-	size_t info_len = FANOTIFY_PIDFD_INFO_HDR_LEN;
+	size_t info_len = FANOTIFY_PIDFD_INFO_LEN;
 
 	if (WARN_ON_ONCE(info_len > count))
 		return -EFAULT;
-- 
2.43.0


