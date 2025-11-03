Return-Path: <linux-btrfs+bounces-18587-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 612BDC2CFBB
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 17:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2016C1895AA1
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 16:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E832314D03;
	Mon,  3 Nov 2025 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erqQzFya"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10C8283FF9
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Nov 2025 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185665; cv=none; b=pyyU9kHhX9CeFQgk7/kxuol/ZrvZP1mm9Xqb+5+H38mQ91qr2DtwMCGdIk2FGtrTbShREezSvADgiY4hb/hzVz/X9ojgDEkwK+g+JLmsiCnsm8dVUKIGYw4E+F8Rw9bh9TxXsyqjd0OxFmbpUgcPhAAU33oglGl+Sn4RpA9Z18o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185665; c=relaxed/simple;
	bh=oausMmPsZ+dnjkMLaZyQvuVYUCi3K7LrgIJK0YnBvWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZguLFuUSCHKR5fZQWGNu8XGX9r/8nmJ6nvsYPAtBblg14P4ERiApPuTOFORrlVNZsBffrbK2OP3LNimGPkVVlXh/rKFKchaL1hPG5VZlVKb7LumHTn6pvMHCE6QdbICmqYDon3O4SwIhrUdUHwDKvdlbx4JHr1vmgYfGu5ygVos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erqQzFya; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so37272585e9.0
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Nov 2025 08:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762185662; x=1762790462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqvWytGZ2s4a9qUQN0oYT7joij1/BdFZNGcsK+FMm5Q=;
        b=erqQzFya1RXGkUFjRlxZLbawcMyCLY1zQd+fuObmG/MV2Hr894nh8khvfwyrg20rAd
         5PyPZGxfUec3QnKVAsU8YLQflG3rwabmWJXUHyQuv6SjRaltFA01WoEZR3kopA+4iO7h
         Q9BbyTVGcyjCfjIm+NR7d2XRppTrlWA4N0fkzRCy36GTsXaqlzII8n2QkgkBX/asKwp1
         yWF6VHc3jnQlO/Z+U2oP2k6/htgJdxcSrYQ7K1LeXX5TOi8MsqV2d88Sp8Jq2AOqO9tD
         frGkjKrxntqqenLj0bBPm5zx61KWec3j67lEnOds/WghpSNmhYjmE/ZDWXwLKtRyaEv+
         CXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762185662; x=1762790462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqvWytGZ2s4a9qUQN0oYT7joij1/BdFZNGcsK+FMm5Q=;
        b=vC5bx3UQ3zUPBRrhmpmkLVvX6vhDGVYWEru9HVr2wfrFOnBGrKck9nSYkEtEawZrqt
         ml84+Y3kGhtaEctDopcJE03RRd4Efj/RXuALh28n9YF3bfik216rhxTFaanV114tVoBY
         LgBGw8EqN6Es85Xwq92pCLs04Xr/pbvZVl7qwRXCnk/9WO37IzqNeZRqVATtTeqvgBW4
         klJwS1WNCDCy/iVNeYQGJVPAzQghVeL1JWdjyroXoKHoTwn9K1bZ9hOZ3wnM9HwoSDpD
         YURDV9hOAhOmy10JE8S6pA083x8C20C5BcjRsIZw+t+6qxeuJh08whkhx7eZGpAe99E/
         LasA==
X-Forwarded-Encrypted: i=1; AJvYcCX8xHrRNcQ4eZkc4s3CO9CgYRgFC0ma5qnOz4l0i4Qm/iyJy+GgsySS2GNoxpm4ujGJ0I/OCTesvxeeSA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy95xmytN+dR3f8rZzgobzisCIayNETSS39t5YrOvaq4Du8xqY
	uT7dt8gRAFDdzQBDPM2GzyTls/fEyhpOVLLiXj4UVSJU8PRC1l4SlmFk
X-Gm-Gg: ASbGncs2XOOHLC8dnYVxPBbcjNyf40w9nq5WgNIwrbhsl0Z0/PJbFgikFR5TAEg+0go
	TjCbEbCIof5TlSVGiYVHZ1pIqa9+aAPR2QNgAyFSNFn1S9PaEJLmjiuI72Dm+CYbH8oRqBehmfK
	tR4Y9vnwKvtrong06cGLL/z7n3T3BVF8iPaeVFmtJfkAuEBFkFMhsDdoeFhX8ilUhXT7X1CkCeY
	/5sDGlchfccL1v9hGT6JUW5pr96cVVt0afEqvkEgwR8o/xRxv1U6msqMpaiiV0uka5ugeYkbNT9
	0s9Jsd35wVt7n1+5Ng2L29xGShQFTmGvEm/aEPLZlnGblEandfbWuCB3HkXSiVEQRtEUsi7rYY/
	mSolbtKHXLIjw6qseXAaND6yGWCmMdqj2QDNG64NvRpgE2XnKQlsHZspdCi1wDMz9F8oFrw8R
X-Google-Smtp-Source: AGHT+IFgI9+UJlRaWTMZvJVKvOi2KSbU5UoaEQKzf5dC8MbcMLHKWJBbkTAIDGnT9gXpw+caRRANUQ==
X-Received: by 2002:a05:600c:828f:b0:475:df91:ddf2 with SMTP id 5b1f17b1804b1-4773c7862cbmr77521625e9.17.1762185661579;
        Mon, 03 Nov 2025 08:01:01 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4773c48ee52sm165705805e9.2.2025.11.03.08.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:01:01 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: wqu@suse.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH RFC 0/2] fs: fully sync all fsese even for an emergency sync
Date: Mon,  3 Nov 2025 19:00:56 +0300
Message-ID: <20251103160056.1154138-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1762142636.git.wqu@suse.com>
References: <cover.1762142636.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qu Wenruo <wqu@suse.com>:
> The first patch is a cleanup related to sync_inodes_one_sb() callback.
> Since it always wait for the writeback, there is no need to pass any
> parameter for it.

I tested this patchset, and it indeed works (in Qemu).

-- 
Askar Safin

