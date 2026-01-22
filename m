Return-Path: <linux-btrfs+bounces-20921-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCBbCTqVcmksmQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20921-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 22:23:06 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D99A06DB7A
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 22:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27AC1301842B
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 21:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3393BE4A5;
	Thu, 22 Jan 2026 21:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jingkai-info.20230601.gappssmtp.com header.i=@jingkai-info.20230601.gappssmtp.com header.b="nVWQyNfK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FDB37881C
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Jan 2026 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769116978; cv=none; b=Wqj25w3XWmTxivl0O5PtcANfqdIT9Qqmn6yiJO3+OHwfGqewcQFahyiny7JONHGr5n5I+sJzEahVufIJmTK2v2pENrmqGTY6e0ZX8weh7vDHKlUHdm2gbpwLZ6RCCeGqk+TcVC+4kqn++w7lnTsxMfRkG3fFnsInnvitYHCIkaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769116978; c=relaxed/simple;
	bh=rdGCfKHQB7MtPLRMSfcCLtNKr8uShXuBfd7yBYGPCAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8FQPQhV+C0mYUgnKPGWJ4uE7kcn/zUY1Q4HDBSSuD98REfM5I3Vmi0XUmmMDPp0O66S3LLDnIsHEije9lK2WwC2R7avyofS+2LiTWNH5+WnKD2tTyrBcii72hRxN583S5mtf6qsHod7CY/vpr9wQFij+MQcdem7N/mCMA9SUTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jingk.ai; spf=fail smtp.mailfrom=jingkai.info; dkim=pass (2048-bit key) header.d=jingkai-info.20230601.gappssmtp.com header.i=@jingkai-info.20230601.gappssmtp.com header.b=nVWQyNfK; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jingk.ai
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=jingkai.info
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-435a517be33so979974f8f.0
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jan 2026 13:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jingkai-info.20230601.gappssmtp.com; s=20230601; t=1769116968; x=1769721768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIpJ90o01Nm/KQlxcf6QRt/dVhIs/n+pCs62VYHafdY=;
        b=nVWQyNfKRZQZvK9NJaStKyrqmu6IqHGFVQyVIj7KSJJ/1wxBZYX6p9AMSQHf+PfIju
         P7p7qXS2RDZ6nOgQuTfnfnhoR2poDqNhGzJ+INLGqTd8LL1gmQUD0R2MaX31uPTDOIH4
         aNkEUl1EKyoUqwZhkC5unMNGnmTOua1M+2IfVGr129VsX3eOC8gcP549SVV2T1SU7ybp
         Zr9k23WcDdvAs5/6J0lzN/DbQ8JWohxBYs9DfDOyAYed62ef9lzRTXZo0qZedv5DcbhL
         3Jr/TBeQZQ3cLpN/dh4lpfSCkgFJpAWtPaO4h6gHHJ65D2Ssn6zgP06EjyDqqLcvjzji
         rXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769116968; x=1769721768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EIpJ90o01Nm/KQlxcf6QRt/dVhIs/n+pCs62VYHafdY=;
        b=DfPn33um0rek8vpAIz//H51aiqjV6wxZRqmwAYMXNJomk4PRZnl0eKuf7ASjJycYCw
         oaCHJCzi6q30a0PK7n/7CWFTrNVD4ZFRIbZkV82/oEeet0QJXfONKWQ4mvL+Xk5garr9
         6K/p3iaZ0RvMvw4uQfVEkcG0cHTTHEdPMuRlBevr7fARWimYljUcUsgsDOw/s9EH96qY
         2JA2FQalT1Inlj1BCRrljZHPeZfPIua3Ig/a+yU4BDhi1ZZ5IcX6MWvSV/IV6NdKrD7u
         hYDdYDb7wJfeN9cM3ZHGXACKOpX2yOqqXJZvsqjj0Pa2G0K8Bd+75gIzdAp8L0l0yXjw
         wdsg==
X-Forwarded-Encrypted: i=1; AJvYcCVaGhPBtbPKuNwwj8xTx0pzGICjHa+d5JxNm/1+dGYUkNHYOVUpXIof/S1l66hpQBi+xsqVBCT2ptb3lQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj+f3I+z4TgdR/wzE6ERKoaEqrosbCVon1BfOtyalBbx5XBTk0
	lj84ndmuSU7RQ6EkmwXPreO0XMEoRT3lt//bW6W1FW4U8QqN2oLy8ZqsPuxqZHpUAhw=
X-Gm-Gg: AZuq6aIyzCSCHzA0b3IXXpnApX7ULbJ821q0yYD7U1Xg+Xd2qh3hza8TCdR44lwByiF
	8yfONcUXrjBEnC3URSWOwp/20K68EBNF8wsUIMriTaC6kG46jbWCXE48+hFxxMAz13nRvjSvQVw
	GYHWB5SnEYhh/cE/8eS675Yt4YnoxS4wvz0ZvfG5BsY00/zzV/DGFMzjeP9BxVOGl4IUbojZALn
	yIkmik1o77cVX/gLyNVvg0VuZprrLihuaDx1doXMWcUxuNzEK8RqrLtr1MUSXRh4RGZEzj88BJn
	wgcK6jqap985Ik5SFwFMTHFanoqNIUBpw3yCZ6ujJHjt9pVpriZKsSkXaeWbsBiGqM8P/zNwT3O
	v1+ftMjlqLwqjZEl/IXqEaeYYHHs5JoUwAhtHkY0iT3Q1AW+XWFZBV8JjPDq9B6yuzUNG0xExDt
	AzuWfxP3Fqdk0zHu0gXoGQkl63yoGbfmcINvb2kwnn4CZPkRdHaPLHpkGLN2Da/44Yw3lh+SIz2
	otFTiSDGoPYVY3dmNotnbuWWHaGI/UqUJ1pRi/gv3o=
X-Received: by 2002:a05:6000:2dc4:b0:429:b751:7935 with SMTP id ffacd0b85a97d-435b16280damr1625650f8f.56.1769116968488;
        Thu, 22 Jan 2026 13:22:48 -0800 (PST)
Received: from localhost.localdomain ([2a01:4b00:b002:8300:6d4:c4ff:fe4e:6522])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f74b15sm1488683f8f.35.2026.01.22.13.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 13:22:47 -0800 (PST)
From: Jingkai Tan <contact@jingk.ai>
To: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org,
	Jingkai Tan <contact@jingk.ai>
Subject: [PATCH v2] btrfs: handle return value assignment in btrfs_finish_extent_commit()
Date: Thu, 22 Jan 2026 21:14:10 +0000
Message-ID: <20260122212244.19518-1-contact@jingk.ai>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <3de1ff71-2c74-4dd8-a69f-25c80a313425@suse.com>
References: <3de1ff71-2c74-4dd8-a69f-25c80a313425@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[jingkai-info.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[jingk.ai];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20921-lists,linux-btrfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[contact@jingk.ai,linux-btrfs@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[jingkai-info.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,jingk.ai:mid,jingk.ai:email]
X-Rspamd-Queue-Id: D99A06DB7A
X-Rspamd-Action: no action

Coverity (ID: 1226842) reported that the return value of
btrfs_discard_extent() is assigned to ret but is immediately
overwritten by unpin_extent_range() without being checked.

Use the same error handling that is used for btrfs_discard_extent
in extent-tree.c

Signed-off-by: Jingkai Tan <contact@jingk.ai>
---
 Thanks for the feedback Wenruo. Updated to use the same error handling
 as the call to btrfs_discard_extent further down in
 btrfs_finish_extent_commit.
 
 Apologies as I have just started learning how to contribute to the linux
 kernel and am looking for relatively simple low hanging fruits to
 familarize myself with the process.

 fs/btrfs/extent-tree.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e4cae34620d1..67d6afb04bc1 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2837,9 +2837,17 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 	while (!TRANS_ABORTED(trans) && cached_state) {
 		struct extent_state *next_state;
 
-		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
+		if (btrfs_test_opt(fs_info, DISCARD_SYNC)) {
 			ret = btrfs_discard_extent(fs_info, start,
 						   end + 1 - start, NULL);
+			if (ret) {
+				const char *errstr = btrfs_decode_error(ret);
+
+				btrfs_warn(fs_info,
+					   "discard failed for extent [%llu, %llu]: errno=%d %s",
+					   start, end, ret, errstr);
+			}
+		}
 
 		next_state = btrfs_next_extent_state(unpin, cached_state);
 		btrfs_clear_extent_dirty(unpin, start, end, &cached_state);
-- 
2.52.0


