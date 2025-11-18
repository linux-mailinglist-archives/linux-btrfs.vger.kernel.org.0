Return-Path: <linux-btrfs+bounces-19090-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 765EEC6A7AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 17:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD5554F41A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 15:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C43D369977;
	Tue, 18 Nov 2025 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="ZYjr0bkw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4E5368282
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481581; cv=none; b=Zmgc2WXZ6kV+0Thji44bNVzT8fs6TglnJHj6aDaeQK90rDW1cgjftSbwZEN4hwAj6pz2dAsKhp5SfqIASDQkSziu8QeeeCTSCazR1vMO7gDzyV68f0Pj2k1lzJ48OXshjRPRvT5B6qaDeG7vKIQbgzkmcdRAddwqa4Emw2QX6NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481581; c=relaxed/simple;
	bh=8lICKDxYzudmGWexFW35D9YRbV3Y9AF/h14+XHFUVV4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nhk6/uX/rVNzLI/1D/nHLAxgwFLcIkBlS1tdNpy8XsOoBONWtZ7sLmA/rgsAreL3GFBIfepTerAatuF1fvHk3feB/A8qkp8Cg5KtR2vYiBMI/hE9HRf9kwOkX8+iQPGhXg3Y/jc+FSw2hIeTdLSUWbFYjmnhI5gOuR+bh6TLni4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=ZYjr0bkw; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ed66b5abf7so73222931cf.1
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 07:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1763481577; x=1764086377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=S6opeFdWTj8c9DP9PjQD4yprL7npcNPEXWqAX5GQy9o=;
        b=ZYjr0bkwKBwnakXz6eX7ycdhuvOWOs1+PdKDXNY6HVCOtc5nXEjKgFa60QRK3NRRvq
         6+SfKu28+MizXn6Qe65+7SEY9szhZZ9ZIs1/hOPiIzkaAi2w8W0RVcTUg3Y3NNzJRDVg
         Tq9ZXhJTLKbdFoGix+x9x9kv3lSFE+nNI90sjClmsRddYR1xHsrWTavWwyhoO3Z2OgGZ
         B83x8kYDf6/VkBDMMWRuHV8IRgSMCBbJ5GxllNRlimyyS7BSw/NwKkPWqSWifBjR8K9G
         yUXZ34hLXnRLx3sJXvTMXiwpHB2tS2A0lxwDAObWoDZs9IQGhZrDKQ0yFx4EOUMNKrOb
         lbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763481577; x=1764086377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6opeFdWTj8c9DP9PjQD4yprL7npcNPEXWqAX5GQy9o=;
        b=V+1s3j74t7shlwJ3QHgWkx/x5NLvFSLzNzqo3+1QItRmmligPWFZ0lqDKlEY3svMh1
         Lgde9jGr0pF9LyeftgCv/NunqZRmHGBJ4J2p7cpFYOzbkuTFcwDkiXqyhbstbz/9Xwj/
         /w6nulXH+e8MOpSe1skQpONxlI+7q66pzmWxGMvetHrwr1UK9GTfWlKewQXesPNweUD0
         5y6J7NONWEVp6NDda884ax6O6dq2Fp7f2zQEZBErLDFE/XK9ba+gtmUnR5///g+W/A02
         HJom1dlXOMimOjHZ7gqJjrSu1ALfPUGn883bEIZjo1e2YIr9vp4FVYtSeu+9NednaPFo
         NlXQ==
X-Gm-Message-State: AOJu0YxwfAVyHL42skvS2jwWoES2WJq3mFjC7IDZwdnv4xh42lz1X+y4
	A2vXGuwdCVIYqNtxLF4oxd2lTpCeJ6/RQU1nbdAT4x7xTbII0kqKVos0AUjDzNqQB4jpmbpEdkI
	zkl3lyytB0g==
X-Gm-Gg: ASbGnctWhqW7A2yc8CYqr2Ul6jUdiHz6n+tWFnFmvkzaxkNfZ212GhwDUpSOc/An+8D
	ncTqZaLV8Q10ItWz9myyPP/vbvxqM6+tGeWR+zjtJVOdFGwYqKdg8v0Kx8b5nxOkJw7ysOjEusC
	kDu14vFmsnMnYU5wllL0R8+O6B5XnJaFY9Fnv94rle9bKThs5bfRcw5GExHNAsTV0oqu2ETb398
	gNmkiFXQRjYY/VHCKjjg2G2VkmaydBhwKvGUxJQrNBGTwDZwpym0om9GZ9mQuenk0mjsSz/n5VD
	tHNZK+q+pXL7AwHcO5MP1qWBCZhf8KX5AtbUWNkvYqqpbNfBEFzeXG/6MtJOCD0CLXPD4Gjl/xc
	wUg1b1S2EXvjJq78r/Eq+JvzCFJoXzI0NVFoQxr7EOrar6VW0QH7/8S0nH+CnSo5Wslf+3XRjGw
	==
X-Google-Smtp-Source: AGHT+IHjuE1VEi3apvGj210ljUmbjL6441hLY8VyqJasuMKjKRC01w8PzFag0HO/muMNAariP++CdA==
X-Received: by 2002:ac8:5ac6:0:b0:4ee:2508:3952 with SMTP id d75a77b69052e-4ee308d881cmr46165591cf.40.1763481577423;
        Tue, 18 Nov 2025 07:59:37 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:f528:9f2f:44c:2c84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede86b3820sm108666531cf.4.2025.11.18.07.59.36
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 07:59:36 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] Fix data race with transaction->state
Date: Tue, 18 Nov 2025 10:59:27 -0500
Message-ID: <cover.1763481355.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've been setting up Claude to setup fstests and run vms automatically and I
kept hitting hangs. This turned out to be a bug with qemu's microvm, but at some
point I was convinced there was a deadlock with running out of block tags and
ordered extent completion and transaction commit. This actually wasn't the case,
however this data race is in fact real. We can easily miss wakeups if we have to
wait on transaction state to change because we do it outside of a lock and we do
not have proper barriers around transaction->state. I suspect this explains the
random hangs that I would see in production while at Meta that would clear up
eventually (we do call wakeup on the transaction wait thing a lot). In any case
this is a data race, even if it wasn't my particular bug, we should fix it.
I've run it through fstests a few times, but obviously spot check it since I'm a
little rusty with this stuff at the moment. Thanks,

Josef

Josef Bacik (2):
  btrfs: fix data race on transaction->state
  btrfs: remove useless smp_mb in start_transaction

 fs/btrfs/disk-io.c     |  8 ++++----
 fs/btrfs/qgroup.c      |  2 +-
 fs/btrfs/transaction.c | 29 +++++++++++++++--------------
 fs/btrfs/volumes.c     |  3 ++-
 4 files changed, 22 insertions(+), 20 deletions(-)

-- 
2.51.1


