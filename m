Return-Path: <linux-btrfs+bounces-19414-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC8EC92D51
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 18:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF9824E4E2D
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 17:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8733133374D;
	Fri, 28 Nov 2025 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CptPCQCb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6312D23A5
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Nov 2025 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764352136; cv=none; b=IieFU2jtnCZ0/dZFAQdaSoC2OQy6a6JhZcVPa1o3fwasvZEQr7BXQnRkk7N22dqX8s/USlmA36uZfPCjXWYETP3l4m9S9dosYTI04b+W4zgrvP4XtwVsBFGpaessyLuQSKUfJLeWhAGxLa42CqIHH/aeK5GVUKlgo61zA5Gpj0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764352136; c=relaxed/simple;
	bh=7HVMDoaN20YhFrjeqb00IcjcKaCYwEDzP0Q5ujVulXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ChDZ6mXteSFHVVpKlaz96qA+ZfTfdu72QdKqD62XhjgkkeWlFUQnjMBWLYmgvwlwPZxKNFha6T8RsrY9njuYtoxdqwbdQMv65OzH7m1BGciWRnlfgOHg0zJhnKh2CRDnBm1rkyaSKI9k9CEE8C16RxN/4YhealD6vxTwE8dyDlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CptPCQCb; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso3466085a12.3
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Nov 2025 09:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764352133; x=1764956933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R+W5gOKvrPb0gok5bQ/OvKesKktbzAWVcFgy51PO4MI=;
        b=CptPCQCbwbczwL98it3/2zeDiGnC2uQ1KRi0xQ7mY7k0iEn4+bMxhD1Yvn7ZXHeOL/
         4NU95QCesPwq6qAYtkeF79JgaUcdsvCr4PrSg4L13YOt0q8p/nuv3+bA2c2uFn+uRpkb
         +ryemI5fXCqoRZtKvgeDC2Em805gOT6nXiI7hAfBjazuiIrFQwLj/M5tvWLC5gxbRohU
         M7MusiEukTr8RM4xkfSsXto4D6NJEXKsOWj7ArKy9d+dw9ewO/IE2zuotEz01rJSJ05R
         2rgqEqjCrGZcIfhUMKpCY9OsfVlOeZM/TbMSJ//1QYHzVlz0frr2AyQadN0b7KNpan7G
         GQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764352133; x=1764956933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+W5gOKvrPb0gok5bQ/OvKesKktbzAWVcFgy51PO4MI=;
        b=os+wuHvKi3/I47UlPNcEZqdk6c1uwrFw3V/fsVQM9o29+saOMp4z6TB7Wk3z76Qjy5
         hZPzzB57B0d533njZ7MPBAXfdXQPExnLUbOR7yBZYZfCub76RfFDvY2IWSpG+95e6yDm
         tPk/DeZ8EFcuvziVyhmRfsbhlHQT8mkAraCAl7Q/pSqGX8aOZnVq+jpg3vZh3S4GOnEM
         uuEOyLRHhFgFm10wf79I9C+tHPb3kUxpnXNq3LgVT96w2JOw76lqmOltoNZNHjGpmEYK
         KBMZ5NsWHeFagbMUyCVK4YN9Zfb6ZV/sR/hJmRbTRz3CKNyjSo0PU10M5kZMNWS/rn/5
         eeNg==
X-Gm-Message-State: AOJu0Yw4JszC01mTJzLDq6enidG8EjnqyagihLU85Yl2lXCzxBFtFR6f
	qvesTN5iLXiwDWyDmj8JdpEWfLrzK49aXpId2aAOcQtxR10ZqoXIq21T
X-Gm-Gg: ASbGncu0uwJR0AsLsvvwbpOmqSlsb7ssYvgSV6ARtKGc/9kFA7tGx051jqA7FDcQt/P
	0HvJOeeDHqxVPcSPzbGvZG4XnM3YxAyNyFgw8Y8mbMX5J4b2pX4J+TuUyaf9Y8uivasMwWZgp7+
	t/8ts34PL6XtDF9L+Do1bKdidZQRDMb4+DAgb5ybeR+I2xBp0bDNwcH6HYjY3zS2I+5bPC1jxHD
	LLmVuwZPnq7fR3SAjqZBQkWvrQ6QyJ1TN8zRPq/IZR8vXfGTBkhfdL1loIPaDFKE5qUDtARuFMJ
	X3HkWlwnkMRJzQfV+s2m95FZS3KFhfeOUPYiQtepIk15G2xb8YS1Lqv+2lGlOsRcx55CldG1i+g
	svmvf3EmzrU7/kuqc9DtKVM6jZluy1fmFEtJLYAeCDBfRlMBIQqPrl6Lt/s1QLmGzBVLAQsQT6v
	+Vhn11MzW6i9EWXQSI1ybghxyVyW2DcawkKulMI4MCrlYv+Cpgct+h0hMx4/cKew==
X-Google-Smtp-Source: AGHT+IE0PWRZLH8L2PdN8igQW7sen+hcXr7XzrBLRmRw9dCjU5BtxiVMv3i9wn/6cS0vUQP1r21zYg==
X-Received: by 2002:a05:6402:1ed2:b0:640:8348:6a82 with SMTP id 4fb4d7f45d1cf-645eb7872afmr13424761a12.24.1764352133153;
        Fri, 28 Nov 2025 09:48:53 -0800 (PST)
Received: from ubuntu-development (net-93-66-99-25.cust.vodafonedsl.it. [93.66.99.25])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64750a90d14sm4933982a12.10.2025.11.28.09.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 09:48:52 -0800 (PST)
From: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
To: clm@fb.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
Subject: [PATCH] btrfs: remove dead assignment in prepare_one_folio()
Date: Fri, 28 Nov 2025 17:47:55 +0000
Message-ID: <20251128174804.293605-1-mpellizzer.dev@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the error path of prepare_one_folio(), we assign ret = 0
before jumping to the again label to retry the operation.
However, ret is immediately overwritten by
ret = set_folio_extent_mapped(folio).

The zero assignment is never observerd by any code path,
therefore it can be safely removed.

No functional change.

Signed-off-by: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
---
 fs/btrfs/file.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 7a501e73d880..7d875aa261d1 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -877,7 +877,6 @@ static noinline int prepare_one_folio(struct inode *inode, struct folio **folio_
 		/* The folio is already unlocked. */
 		folio_put(folio);
 		if (!nowait && ret == -EAGAIN) {
-			ret = 0;
 			goto again;
 		}
 		return ret;
-- 
2.51.0


