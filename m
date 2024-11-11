Return-Path: <linux-btrfs+bounces-9407-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204BD9C3737
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 04:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE08281204
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 03:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4214514B08E;
	Mon, 11 Nov 2024 03:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YBF0mEkg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YBF0mEkg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F8A14AA9
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 03:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731297575; cv=none; b=rh6JYVEjWPPueXOPZypV7Pt4DWIi6cn/75bpeCoyowqSiINYw0Dhfwp3TgIIiyETTrTVjeH+lPOtV6LhdRx7qWnQKnB2XHX1p7DayY/R4Dvof6ux5J6vazXiK1eRadRqpvQLH0olbMB/v4smfPD0jEUOuhN5o+rVhqIQtJitXMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731297575; c=relaxed/simple;
	bh=VZ1phQXYU4rpnGaShftSJ8FJH3QgZAv1/yM5YqB0M/A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSdfrzXW6WqhqChHtof23Gz6BJ4zqkd/MzwkpVC9XzTkhYCUhyR5Xv3dG2VAtebhSXjul20MIsk1FWmiyM0Cpls9u73/UmOpI93iQ5SQIW+xMGdc/ekbfgjx5Xa2QzjNmcek2/0clcV/RZj2sftJxeRRcuPxhlSZvfNwIoiylZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YBF0mEkg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YBF0mEkg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ABF2B1F455
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 03:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731297569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5rqdvDCx/RFvKLssUn9GPyUNSqf47+oK+cVGX8cChXA=;
	b=YBF0mEkgvmz8UBzOCMsSxGisVx691BlCy6+5YiFGax5wUkaTkPS3fHoYzvy9f0FcQIFJyU
	ShYLXUX5ZDP+Ld8hFoQsVGUXV+96nhGVPlVAflRR4ELITDgqbQHFfHJhdKCzZjLSWme61a
	JheL5SJpxfJcZij+7MuziMRMaIgFMIg=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=YBF0mEkg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731297569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5rqdvDCx/RFvKLssUn9GPyUNSqf47+oK+cVGX8cChXA=;
	b=YBF0mEkgvmz8UBzOCMsSxGisVx691BlCy6+5YiFGax5wUkaTkPS3fHoYzvy9f0FcQIFJyU
	ShYLXUX5ZDP+Ld8hFoQsVGUXV+96nhGVPlVAflRR4ELITDgqbQHFfHJhdKCzZjLSWme61a
	JheL5SJpxfJcZij+7MuziMRMaIgFMIg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBA9B13967
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 03:59:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WAXqJiCBMWcbJgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 03:59:28 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: make buffered write to respect fatal signals
Date: Mon, 11 Nov 2024 14:29:07 +1030
Message-ID: <e4bde7c09f6be81eae71533fba5e06f24885f49d.1731297381.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731297381.git.wqu@suse.com>
References: <cover.1731297381.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ABF2B1F455
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

This is to follow the behavior of generic_perform_write() which checks
the signal after faulting in the pages.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 10d51c8dd360..a0fa8c36a224 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1142,6 +1142,10 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 			ret = -EFAULT;
 			break;
 		}
+		if (fatal_signal_pending(current)) {
+			ret = -EINTR;
+			break;
+		}
 
 		only_release_metadata = false;
 		sector_offset = pos & (fs_info->sectorsize - 1);
-- 
2.47.0


