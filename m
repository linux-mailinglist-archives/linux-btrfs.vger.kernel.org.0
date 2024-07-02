Return-Path: <linux-btrfs+bounces-6139-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F289240F7
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 16:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B934AB266E6
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 14:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0231BA08B;
	Tue,  2 Jul 2024 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="O0XQwKiY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qg7PbJ4m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E891DFE3
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jul 2024 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930725; cv=none; b=CP5rLOXTyGdmjpEymbH7zKG5whB/9Kql2n55oto6ttbvBti4zn+rFKcEGZGjWAougkxHJe6V/svmvahXBHxxrZT6f9ykZlickJ6AchiwnoehaAs5UuO9jv1uHL455xEwlSrsBUAvRdI1YqIyKZ1fEaKkxbrghuGMi2b2FKtxyX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930725; c=relaxed/simple;
	bh=/tsm4V51G13QrxfkciYciLZKP43xk9OBevQCrjqKpOQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPxaxQul39HRBCKjT91svV81gbr9Iq8UnMW9EJLr26Zxi8PnxTLRdxcW2TqxV2W6GAoyY9HQNaTNjekAq8GYLpAmXlYVZjek1GuZlQesqjDMCSbzlflrD5lGIs8L6m01dOgF8GnK1d1t6RLvKhWZf4vBDF1MQ9WwjDBbbb86A6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=O0XQwKiY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qg7PbJ4m; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5C29A11401E4;
	Tue,  2 Jul 2024 10:32:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 02 Jul 2024 10:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1719930722; x=
	1720017122; bh=y6OdRSiv2Ui5dJBBDg5JOZMJW2Ok+4PC3M1J4hBhVtg=; b=O
	0XQwKiYgBlq491ENJ1ZBI2ue0HrGaHpAvXdRfxuqYh0ulGDiOaRx7glkoSJfnOGk
	UaGnSOh+BgpsW+CHkYssTbOugHbgs6Gij92ZCFyxvtyErDfu2s/GqpbWLneFvJ+2
	zF4MAOP0uu9UklQPFzZP1+PQVu1sWom3UgVD42txSGvBocoG6X9717NkA3eYub0R
	KsphsmlqC0BlYa9aYgULm683dlG07fgH/8hR6t2JBr13Bctae9KGfBHNJakJOe6Z
	10pHxOCtodMRZT6VgCDrW8CLPu3P/H+uQWifPAhMIOVkBLH2vKrPQq8h6Knyg882
	QEQQW802w/3GuSqZ0VotQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1719930722; x=1720017122; bh=y6OdRSiv2Ui5d
	JBBDg5JOZMJW2Ok+4PC3M1J4hBhVtg=; b=qg7PbJ4m8cB9dCB6VGxrU721E3Z3I
	IRt2Ign2jZrE0GzSIFIakSB9LPv2NTynM+uehMxzQduAxVLZtCoNZnnbv9cv0yzI
	tHuMEgq5MFAD+71/Y0yEIk42PsALgQoxljHBrsw53d3c1L7PfjlflNz0wCdNqBz7
	ApQVTlYvOnKjFtrICeGn8bbBACVngPCvPGxxjEO6I1RVsvPsphCm5IdXN7/NOqn5
	ZBzQdDQT4+54wc+sKX2TD6TWzOwQSM792WZf08QGU3wtdmtOu5ZQn6Ti96nxKukr
	px8+Y8E9fRBr15B3wG8p3NPwCQqgviS+OZl34QzUF/jDpnDp4wqm8fdBA==
X-ME-Sender: <xms:Yg-EZhyWkh_rYhp344SUd-9UZ4FuZNnuoiDZPsdW5qviX7dfj8vG8w>
    <xme:Yg-EZhQuDRalzmieA_swB1XMRkT5caS3z0QXeL5eHjNrRLXjqP4X9878AS99wuw37
    ifzY4BJ_G_8k7cEuD0>
X-ME-Received: <xmr:Yg-EZrXu0gSMGii0_sYecnVt-8ppmp4bAtRHfRyYP51E8R2rw6uuLIajy3sHAHZp227FP57u7Rr3YT-anXA94BmIpa8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:Yg-EZjitBdq8C9OZqIEJYfRnGi_V7FpZ6Y4GeLwtLpUksh0JV6bdSg>
    <xmx:Yg-EZjDV7mntwDEAZrW3eJk_nzgCAiqUAPyBRQxw4fH7J-Y5PKbKJQ>
    <xmx:Yg-EZsKBYFebd8KvJZXxanqMKIfrgmAv9qklBQB2Rt6qoAo7-6huag>
    <xmx:Yg-EZiAdITaZcOoGcaQyudUlOhAPVdPNaNjouwxmq6IjQrAFGu3aRw>
    <xmx:Yg-EZmNY7VrHxwFOQ3bNdlQLqyCh5vOf_tXIXdqPgQEI3h5RmCzwNn-_>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jul 2024 10:32:01 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 1/2] btrfs: fix __folio_put refcount in btrfs_do_encoded_write
Date: Tue,  2 Jul 2024 07:31:13 -0700
Message-ID: <9e23e32fb945c3e1c43f8c0f8ca20552c48d5b65.1719930430.git.boris@bur.io>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719930430.git.boris@bur.io>
References: <cover.1719930430.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The conversion to folios switched __free_page to __folio_put in the
error path in btrfs_do_encoded_write.

However, this gets the page refcounting wrong. If we do hit that error
path (I reproduced by modifying btrfs_do_encoded_write to pretend to
always fail in a way that jumps to out_folios and running the xfstest
btrfs/281), then we always hit the following BUG freeing the folio:

BUG: Bad page state in process btrfs  pfn:40ab0b
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x61be5 pfn:0x40ab0b
 flags: 0x5ffff0000000000(node=0|zone=2|lastcpupid=0x1ffff)
raw: 05ffff0000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000061be5 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: nonzero _refcount
Call Trace:
<TASK>
dump_stack_lvl+0x3d/0xe0
bad_page+0xea/0xf0
free_unref_page+0x8e1/0x900
? __mem_cgroup_uncharge+0x69/0x90
__folio_put+0xe6/0x190
btrfs_do_encoded_write+0x445/0x780
? current_time+0x25/0xd0
btrfs_do_write_iter+0x2cc/0x4b0
btrfs_ioctl_encoded_write+0x2b6/0x340

It turns out __free_page dereferenced the page while __folio_put does
not. Switch __folio_put to folio_put which does dereference the folio
first.

Fixes: 400b172b8cdc ("btrfs: compression: migrate compression/decompression paths to folios")
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0a11d309ee89..12fb7e8056a1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9558,7 +9558,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 out_folios:
 	for (i = 0; i < nr_folios; i++) {
 		if (folios[i])
-			__folio_put(folios[i]);
+			folio_put(folios[i]);
 	}
 	kvfree(folios);
 out:
-- 
2.45.2


