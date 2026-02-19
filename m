Return-Path: <linux-btrfs+bounces-21770-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHigHnNslmlofAIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21770-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 02:50:43 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1993E15B721
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 02:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D6C0303DD70
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 01:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C077925CC40;
	Thu, 19 Feb 2026 01:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fA+xBhBC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5rgt7+nD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ci9eqOcF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c96FfoJg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9964A243968
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771465810; cv=none; b=G8/hwKhLE3f3VgfK4VVE2OI5bIWH8257TGixt7Zdj4JAAfBvuq25X6WiF1lHEkXxG+p4nhowOnh5OLiZVWH1nJu81kMJaBT6H6WjadWbHO6WrHQ47du9lBkOf3g/GJb1gp3BnbTeQAh3S5HrvkyMbdn9iQXokh/BmKLWKUSWNkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771465810; c=relaxed/simple;
	bh=dCfg4uixRFv+wK+iwNgelIFRYO4mNA1/9sjq4lgB+74=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XAuDjj4TJ0k5BE5qJ62Ha1V0jMNYmHaceoOTCIcKz4MrZzP6n7PeXtO+YOtNVXgXqmahVxARJa7Zo+3xfkPR7sWhS9m5FSlBeNCAva6dp7mGA79ZHVORDjDKhy67TYyQE4tPwizyhFUzuPKPTcRJ9flo6vqrD5/f7uP6n2pk9Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fA+xBhBC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5rgt7+nD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ci9eqOcF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c96FfoJg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4B7955BCCA
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 01:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771465806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=iK6AZ7GmVb8LEjEwewUDB9JDkJbQVRUvfScBPqm+Gt4=;
	b=fA+xBhBCPRBEmaaOsClvLJeL2ghDJ8fmcQ7VwvC/UYwVAyo0UOLDNqXoxNFyxM6lgbgkLQ
	jb2etk+F1esjB1PaKGe4EG36yj5+O4ob4n8rh+ixqC1508DIcLAahFgB3vywYpYYiWji8O
	s0rhznM949h4CoIftzEpZYNoXvnPjow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771465806;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=iK6AZ7GmVb8LEjEwewUDB9JDkJbQVRUvfScBPqm+Gt4=;
	b=5rgt7+nDq18nhLiq53AHMD6oqUFREImA8cQDcsK1sLYVFVsg5G2qbpnLJcfdeEukZkoteC
	VBmANfFHtfZhGWDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ci9eqOcF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=c96FfoJg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771465805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=iK6AZ7GmVb8LEjEwewUDB9JDkJbQVRUvfScBPqm+Gt4=;
	b=ci9eqOcFlXk3y/g1CKZRg9AbHv0Z+Bu7B5CkcHclwu+/haQIceVw/L85GtztFVaFLmtmqW
	LaYYs3NoQZOrDXAR4LwLAhF1udTcr3oxJAp5hPABal1dHCiuB5caaH9NLGhKfkF580pvTv
	EO+kvNhUO1y3rsb6J4FljWn6Evfz6mw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771465805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=iK6AZ7GmVb8LEjEwewUDB9JDkJbQVRUvfScBPqm+Gt4=;
	b=c96FfoJgZ27xCdjTfiqAy7tdduHp5ml7byLV0Rw7KH7Yc7da1kG5VdSxnDfnqCO2X9m/7l
	ED6wvunDyHdO0NAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CADA43EA65
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 01:50:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f2EuJUxslmkBWwAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>)
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 01:50:04 +0000
Date: Wed, 18 Feb 2026 20:49:55 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: trace use file_inode(file)->i_sb to calculate
 fs_info
Message-ID: <apsgauiwdj2exslcb7wmy2womtf6suyzfwatnxk75tzseivm4q@e7wktzgzxmsd>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21770-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rgoldwyn@suse.de,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:dkim,suse.com:email]
X-Rspamd-Queue-Id: 1993E15B721
X-Rspamd-Action: no action

If overlay is used on top of btrfs, dentry->d_sb translates to overlay's
super block and fsid assignment will lead to a crash.

Use file_inode(file)->i_sb to always get btrfs_sb.

Changes since v1:
  Changed subject to include trace
  Use file_inode() to get inode pointer

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
---
 include/trace/events/btrfs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 125bdc166bfe..92118df217b4 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -770,9 +770,9 @@ TRACE_EVENT(btrfs_sync_file,
 
 	TP_fast_assign(
 		const struct dentry *dentry = file->f_path.dentry;
-		const struct inode *inode = d_inode(dentry);
+		const struct inode *inode = file_inode(file);
 
-		TP_fast_assign_fsid(btrfs_sb(file->f_path.dentry->d_sb));
+		TP_fast_assign_fsid(btrfs_sb(inode->i_sb));
 		__entry->ino		= btrfs_ino(BTRFS_I(inode));
 		__entry->parent		= btrfs_ino(BTRFS_I(d_inode(dentry->d_parent)));
 		__entry->datasync	= datasync;
-- 
2.53.0


-- 
Goldwyn

