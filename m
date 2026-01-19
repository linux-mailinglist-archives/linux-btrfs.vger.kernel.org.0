Return-Path: <linux-btrfs+bounces-20697-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5617FD3A743
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 12:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 770F1300BFAF
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 11:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF613318BB4;
	Mon, 19 Jan 2026 11:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jakstys.lt header.i=@jakstys.lt header.b="E/yjlMVD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6C7317702
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Jan 2026 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823203; cv=none; b=lFQrx/1EcXlq/iIcdIDGiJw5p+FeUd50wf/1TmB+gljDWXs4Bg6N7ISz3vZ9+BeK4qCn47i2cKIE7BqOiHWNvRzOvsf/vsuRogpncpwOjWBi7E4qU8F8d57zORk1x02HzI64JIjE/wlUc+uormjeULSgf45jKO+bag0nWhMJayM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823203; c=relaxed/simple;
	bh=W9tl5EGVQQ07JDbhxz9J9n5G9/s3ivfYD8n0emvwRYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLehELvxwscTaONJvBqdbOet/kM3Jtea+Bn6YonM1GrfQ3lW0k6tnniCJWaoFsyjH0++RE+73/QDQN06vJl1LBg1VIQQ5Chna1VAfJxIrtQzvZzC7F4bhWc1mA+qH2k0nyWg6Aca03uQ0G+1E1mTwYQH9bo6nEtk31KpzCzaWXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jakstys.lt; spf=pass smtp.mailfrom=jakstys.lt; dkim=pass (2048-bit key) header.d=jakstys.lt header.i=@jakstys.lt header.b=E/yjlMVD; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jakstys.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jakstys.lt
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64c893f3a94so9105259a12.0
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Jan 2026 03:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jakstys.lt; s=google; t=1768823199; x=1769427999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9tl5EGVQQ07JDbhxz9J9n5G9/s3ivfYD8n0emvwRYM=;
        b=E/yjlMVDmXUx+e77Rvjvj0Ti+rKdiQn6tAo3dlK3kpStIpSzRlrn1BFJEcr5RpWZx3
         d3cjPHABz+k7bL+siAuiQU8Unygx0tHIIDEnWRj/rjWt/VeCzlLzFlkWdCFx+rRk5ooy
         1R6S+FouZXqidTNP5D08ZwAaCz4KcsJeD/tgdc+D1jPJOQZSHl93oVKx7X5jhURgeWDQ
         VEIBXzJMStTZxTNuLOGOj+uQutHP4rNIK34R+IRADeRZ6tbHNYFgroznOWKOjyVU9PZ+
         CoYyNBcoHnTGl3gHn4HVDeXCbc6QMNgQw12D/K+OObpLxU/T/rDQcU0qEZFpO3Y7Zltq
         1xqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768823199; x=1769427999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W9tl5EGVQQ07JDbhxz9J9n5G9/s3ivfYD8n0emvwRYM=;
        b=B5ZvCNyPHIJ4HNIr2Mpxf6Gpomn8jtOj+PeF64Zd0Zo++pI1vuMevMW0vAdUaRBGfd
         dKkPCnPRh3XAP5XbqE0JFnBn73pyko9O373XDgh+7w3GnQQZwuhTUSX4JffsIUtqL0T0
         t85J0nFF4P0qj/VnCavO4nFxqHf2RBIlpoGOop+h1LGaiFe4bjKbq/LJVlXJ6Dz22qKl
         9cImNcPaScludOobJLyomqLxRll3WfsXdvQ1ihZiLswLCPFJKvnrGr+8Jv9PrOTCRCwy
         XBq/x/Sw4JDF4SLPLd8L8MKfZQQV4tVSLyiNKHFc0RiXYDNTJYumlk5zjJMyMntfxAtA
         xuJg==
X-Forwarded-Encrypted: i=1; AJvYcCUYXdkSURNhEjiG6o87OP9NcbMIMX92RldB7hIcC9w2Cna7ivaX0N1unyDBL7KrnYdMt+xOVycd0UWioQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiyrassSm88QISwf5RIW24yz9iu5NBD6Zs8nHxbgxwTOjPf/lo
	iv5YKAV9sx4yQe5HVBPB3e4DbbbcXuztMVdq15rIvxUMtN58DMrJZ1JNZOewhpkqXQ==
X-Gm-Gg: AY/fxX5QazLeNtLcJfONOc9K75WM1/1CLOtAE5sysK7jsnvS2qPzQIbhjGn1yYRQ3/0
	MJNbLiChNw8nZ26kitdkLZFLFP36Zq/4qpzNc0PfRlU8GOITMz/ylnrNVUIZ9WbRlYhSSzgdKV2
	nLTuajf26xBNFgrx+0C0yz03x3B3PKPzHigx5RxSFZT0Lifo8qFLP/93iU3zj/dc5xbhzQ0Xlc/
	iRlboXe4eLJE010E0ZZvkEk9vTIz181jnZytfCcbZK2yyZs7aPM2uXHNHm75hCllsTV6l/SnS8A
	p1ynLHGwETUGN8LazSnmqVWavkghJ57KUc26A8jPtlESK1zPESfImpSynEHzSRNxTC/SjtiGF5b
	q/NPAjt87JB8T8Q9KDG9feZZwKM8NC2IJPB81HAv6o26ehB9tojaSIov0hN6quq6s1rjqYa1/4H
	qa7bDfCzCOm5lyXYMS9LGHFKLgyDYL+0lh5BnlBeC/89XTRhFLgYVilIi1Qv0NNAGIuZXzv/Rw7
	27vDKn1IW3p57I5qLMQEqwsXsuY8M4=
X-Received: by 2002:a17:907:9694:b0:b87:191f:4fab with SMTP id a640c23a62f3a-b8793a23490mr1008761666b.26.1768823198863;
        Mon, 19 Jan 2026 03:46:38 -0800 (PST)
Received: from localhost ([185.104.176.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b879e2c1be7sm999058266b.67.2026.01.19.03.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 03:46:38 -0800 (PST)
From: =?UTF-8?q?Motiejus=20Jak=C5=A1tys?= <motiejus@jakstys.lt>
To: sashal@kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	fdmanana@suse.com,
	linux-btrfs@vger.kernel.org,
	patches@lists.linux.dev,
	robbieko@synology.com,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-5.10] btrfs: fix deadlock in wait_current_trans() due to ignored transaction type
Date: Mon, 19 Jan 2026 13:46:26 +0200
Message-ID: <20260119114626.1877729-1-motiejus@jakstys.lt>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260112145840.724774-5-sashal@kernel.org>
References: <20260112145840.724774-5-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear stable maintainers,

I was about to submit to stable@, but found this earlier email autosel.
However, I don't see it in the queue. What's the right process to get it
included to stable?

This specific patch fixes a production issue: we saw this happening at
least 3 times (across a few thousand servers over the past 4 months
we've moved to btrfs); the last time I was able to capture a kernel
stack trace, which was identical to the one in the patch.

Thanks,
Motiejus

