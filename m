Return-Path: <linux-btrfs+bounces-7571-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB9D9617C3
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 21:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6731AB21B9F
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 19:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028F21D2F6E;
	Tue, 27 Aug 2024 19:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ij3cCnmc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9729181AD2
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785790; cv=none; b=jtaEN+Y5Rqj7BgcTLQe4x8UFti/HVSSqnyjgCHqLdAuDR5QZXDDNOZYXG2fPkvX1lyIEvbwJFRpVL3G4WTaca+ejarBgG9zPoWE6n1xVN6RXuZX3FYTB37FLY/DnIqK1dnLerczudhQkQmTKg6Jyflj3PL9yxp/myU/ObQ78wWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785790; c=relaxed/simple;
	bh=ZhN5vt284t/UHxWaOuyaUyqNDE8ElEPIAfOBggDjXLc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eODcUxovXLFBzjY1UUtYSG+q8/9dOU+k78KQ7YCV872j1AeEShRdm7aiKZ5Sl1XcGMQLRcPXsZr+yZ1yXBaZ0sKWX0CV0FynRaEPY3FsBUcYgno/K9gMNLs7MInT4daqOhUFxCo6iBiSlAY9V6k0o6Uv98oqA7YI5fTzo4PcQw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ij3cCnmc; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-3db157cb959so660243b6e.0
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 12:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724785787; x=1725390587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FjqsjT1Xp8+sFZpoDnJqkoI6gpVu39vVwwA4wlozZIw=;
        b=ij3cCnmckHxF7jT2JkD/Npp0yEaW0BrIjNm8vAJqfltO2YYypHUZUOnfbjioNPgaGG
         QJ0nQnu14DYpSYy7oGD7C+9GGC7PlBaTZlwKuIyI5Fx5+5evIlYl7crPGJYK8RABnNB6
         QzHSnKzk7N22PqqPrr1jJQTPFxKyQWb8o7CPKErdRl3U+PnhJkjQAg90nbPeilKLqcUj
         +t3kHSPHcUna3uKooovUhoe2ikdp32rc2IIPewq2wPApaZ3IPuoYMbkDx0VombxElgno
         lc4/OnvBdI3TFu6CxzzR49+Nf8gsHpvjCc0RRRGuM8U4hu0iT2gnHlj/mCPrmm/9lQ06
         yCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724785787; x=1725390587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FjqsjT1Xp8+sFZpoDnJqkoI6gpVu39vVwwA4wlozZIw=;
        b=MxcfRhF/st3L+AZAQcuEbqV/PjRsntakX3v7c3RKCsZGOJKKb6qmNfQJZtOGR8Brkm
         FM30+iwvZWr+3pOXJEynwStuKupf+ZrSJ/Uy7scO22MMNicf21dKQglhLUUqVlttyqbC
         uAmiKKzb/jL8W3E9b5OJHZCA5Ob+2M3GnENXKm9Qk9qr1RC6GrmxkmBd7Bw3ls6bmk/l
         xYD8Fx9BCqvmWjDf0foKGhpb9FbV9Aim1UacOWzL2nOJ564vzscpiZzZrg/u4OqkRrC5
         GIVDvJ4m2XqUbnNRa3zF55I1rGd3hsE3sqtjZd3/ynPQgMBJWc8qIvlKx9HQDK3j+XwX
         EuhA==
X-Gm-Message-State: AOJu0YzrQ2+6oB89rM+ZLqs+/uujbCDwbPT22pobnTGB4P834hQobpUg
	vOVEVszStRVJwGFE9AJvEQZeFNHr5QmO0Z/bQtk6TQVdJrQpDJJRfAOk/MFk
X-Google-Smtp-Source: AGHT+IHW/qwQTZmpd0+39sI0/3DvIvg1SvdZ35vmkMTUSCqUtulKOswzvGLsOP0PyJoce1e+zb4JTw==
X-Received: by 2002:a05:6808:10cf:b0:3d9:2373:e75d with SMTP id 5614622812f47-3de2a8ec9c7mr16657108b6e.35.1724785786895;
        Tue, 27 Aug 2024 12:09:46 -0700 (PDT)
Received: from localhost (fwdproxy-eag-008.fbsv.net. [2a03:2880:3ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de2252d4casm2692242b6e.9.2024.08.27.12.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 12:09:46 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 0/3] btrfs path auto free
Date: Tue, 27 Aug 2024 12:08:42 -0700
Message-ID: <cover.1724785204.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DEFINE_FREE macro defines a wrapper function for a given memory
cleanup function which takes a pointer as an argument and calls the
cleanup function with the value of the pointer. The __free macro adds
a scoped-based cleanup to a variable, using the __cleanup attribute
to specify the cleanup function that should be called when the variable
goes out of scope.

Using this cleanup code pattern ensures that memory is properly freed
when it's no longer needed, preventing memory leaks and reducing the
risk of crashes or other issues caused by incorrect memory management.
Even if the code is already memory safe, using this pattern reduces
the risk of introducing memory-related bugs in the future

In this series of patches I've added a DEFINE_FREE for btrfs_free_path
and created a macro BTRFS_PATH_AUTO_FREE to clearly identify path
declarations that will be automatically freed.

I've included some simple examples of where this pattern can be used.
The trivial examples are ones where there is one exit path and the only
cleanup performed is a call to btrfs_free_path.

There appear to be around 130 instances that would be a pretty simple to
convert to this pattern. Is it worth going back and updating
all trivial instances or would it be better to leave them and use the pattern
in new code? Another option is to have all path declarations declared
with BTRFS_PATH_AUTO_FREE and not remove any btrfs_free_path instances.
In theory this would not change the functionality as it is fine to call
btrfs_free_path on an already freed path.

Leo Martins (3):
  btrfs: DEFINE_FREE for btrfs_free_path
  btrfs: BTRFS_PATH_AUTO_FREE in zoned.c
  btrfs: BTRFS_PATH_AUTO_FREE in orphan.c

 fs/btrfs/ctree.c  |  2 +-
 fs/btrfs/ctree.h  |  4 ++++
 fs/btrfs/orphan.c | 19 ++++++-------------
 fs/btrfs/zoned.c  | 34 +++++++++++-----------------------
 4 files changed, 22 insertions(+), 37 deletions(-)

-- 
2.43.5


