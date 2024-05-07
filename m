Return-Path: <linux-btrfs+bounces-4818-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008BF8BEDE4
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 22:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C462B238C8
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 20:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B33918732E;
	Tue,  7 May 2024 20:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="JJfTKXi2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9AA187320
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 20:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715112542; cv=none; b=RAf1w0W7VmTO+rhA6hDAMxxrhbtgWKgufVGhpIXsQ+TLNosHqrsKETJCOY0X4BAET0tE0njLEs7FRCu1grO70jyx40mtN/w8d7Lr1q4CuYkc0aVzvFGMeuCwM+oyrPexriXoh6fyMhREHSdnCJ3HC/zQ18o1mvx3BPNYwzU9s1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715112542; c=relaxed/simple;
	bh=jZ3U1Q871r6OkJ2Njb2rrJaKylS3FSiliBkBOejtF3c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bmbjtQOr3g3SwelrfcB4fSyJf91pTEovL+56UPBIyLE6v8QCVrKmkGRJ8JaRxg30I+866Wag0rZCi3aejQ4FEtKjSROwGX38M40BoOUhaobroiyjUuv1dpqsd1i5l+xhGpMYVHF4rcrcFBL9/0j8HMlZbYRc/bjRUk1bbeIGI6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=JJfTKXi2; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-62026f59233so1151497b3.1
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2024 13:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1715112539; x=1715717339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tbIHQekgsaQ5/Cm+qVmozu3CZtSxRReTFO8xYZYOjVY=;
        b=JJfTKXi23o+uQz+jsDxDBMnQ1UynCX2Rc9MByTymj8mEJ6rukXpG5XY6sJzhryFdvZ
         Tv8GCzd6Gp/xLy3E6PXFSvC1zeHx7NSAMHf8qw+hDroz4g+KDdFATAtCSfy3hZtlfoAv
         ei76iLL9V4dkx+GAEfApy4OHDNJ2oNunQkhV9pbajq2JB3rJ2ZqcrTu5y9teMNCz++TQ
         2bD5LNunQxnFfSSvMzsGH7GQ3x23pqiSm74rhz73WjSS2dnBiXBvZQHFTpj4kO9rg5/2
         XSsP/cslqUl0Cz6zRSL8u3X3kj7rz8AOaWI4J0ji0NRpgh0OJdqj50DCI8/wWcobVeOU
         EmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715112539; x=1715717339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tbIHQekgsaQ5/Cm+qVmozu3CZtSxRReTFO8xYZYOjVY=;
        b=aGK8xkVGYkIVuI/y+mGRvzV+UedZEn9U9D3Y8F9uzHFIy3X1DPm82rYMBH4Al8Y7CX
         xI3jHiw166XV9fi7hk01YI8j680HNqwnHyjSJaCvzK7HccuG8bxWTZUNTSzrTK0qEIYI
         IIh1g5fm3OIo38fjt4hFx4eUc5tGCTOqk2Q9lqJDi7CTJD608zK0DZYAwxnpdLlmc0za
         X77VClR4roi/PVeRw13pLgPxiiima2j4Syix7GxeL7O7lcgzf7SGqWwIQJG20Wxakt8s
         3MtbiEcDHLf2m0cpj5jNWipvYhp9TuN5AVjQ+MyeHxF30hf6fzGZQ3aaLIaKyFDM71Ff
         bU8A==
X-Forwarded-Encrypted: i=1; AJvYcCUL8wJ6FQVkQ4y5IoRPtDLZDfDR6RT3mDBG1rlbyUJLxph+dNkMlNhK5NlVOKT0flhyjVNwVFuHND8Sdy6HNyeJXbqE4FplaPYw4/k=
X-Gm-Message-State: AOJu0YxGSEdbe5LZnmMgu5boG1y0KmJksgLVFk8VrZUCjIWucWmarAx8
	/HbMAnmbk71meWEG6T9Kuz7yF55GL/LGKskzybUAiflLjHskJn2wQhfiXAWiGNQrKWTZXvRzm/q
	L
X-Google-Smtp-Source: AGHT+IGgb89OtzaPXuT0sJCrOv/hOba8x4kDLz1fk/CrBUZiBSX6TF+HlydZP4MRPw5Xwu38SsP+7w==
X-Received: by 2002:a81:4f58:0:b0:614:35a7:4c40 with SMTP id 00721157ae682-620766308a9mr26624847b3.22.1715112538188;
        Tue, 07 May 2024 13:08:58 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v67-20020a814846000000b0061b8e9593d4sm2912170ywa.3.2024.05.07.13.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 13:08:57 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] fstests: mkfs the scratch device if we have missing profiles
Date: Tue,  7 May 2024 16:08:53 -0400
Message-ID: <adcf935ecd3d44957ee244b91790ee7b73df134b.1715112528.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have a btrfs config where I specifically exclude raid56 testing, and
this resulted in btrfs/011 failing with an inconsistent file system.
This happens because the last test we run does a btrfs device replace of
the $SCRATCH_DEV, leaving it with no valid file system.  We then skip
the remaining profiles and exit, but then we go to check the device on
$SCRATCH_DEV and it fails because there is no file system.

Fix this to re-make the scratch device if we skip any of the raid
profiles.  This only happens in the case of some idiot user configuring
their testing in a special way, in normal runs of this test we'll never
re-make the fs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/011 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/btrfs/011 b/tests/btrfs/011
index d8b5a978..b8c14f3b 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -257,6 +257,12 @@ for t in "-m single -d single:1 no 64" \
 	workout_option=${t#*:}
 	if [[ "${_btrfs_profile_configs[@]}" =~ "${mkfs_option/ -M}"( |$) ]]; then
 		workout "$mkfs_option" $workout_option
+	else
+		# If we have limited the profile configs we could leave
+		# $SCRATCH_DEV in an inconsistent state (because it was
+		# replaced), so mkfs the scratch device to make sure we don't
+		# trip the fs check at the end.
+		_scratch_mkfs > /dev/null 2>&1
 	fi
 done
 
-- 
2.43.0


