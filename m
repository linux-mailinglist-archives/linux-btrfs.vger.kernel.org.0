Return-Path: <linux-btrfs+bounces-13043-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89690A8A60C
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 19:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06AE189CAA4
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 17:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13B722173F;
	Tue, 15 Apr 2025 17:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GCJnpF1v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+moUnHCA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GCJnpF1v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+moUnHCA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6379022128A
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744739593; cv=none; b=nGJPGed6b9jxkJPY6AUPqgNwQp7sSfBeRIQBnMj7OYfH6ZZjyA5NQfieSI7tkW42h4xw0JgftL7UwFi8dxYHatwtITrX/ym6UWbNKklUbBEGTeoibepLTekIedV1lHQkisYy74+dw9c8+DbDwMAcXYgKwLulHy0+Nw9VC/BB5Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744739593; c=relaxed/simple;
	bh=v50mZl5Q16V6X2sBYVxuaPflT4u0ApEJjaglVdchTEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyAwcXkTUrNmiv5g3gOVpnMysluoYu+O9hPIeKOy7R3QPRPJfVgiOMod2wQ1c+TbKkQlk0Y1gcOfrTGDXfGTG/vYJXc9xT/KHqRUR7eGSU/n34MvuR67rPfVSGkaSrd+DdNcKaNLayqSXpvKZSuyL2FVsYkGDslzqsjNrw8TZvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GCJnpF1v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+moUnHCA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GCJnpF1v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+moUnHCA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 808A71F6E6;
	Tue, 15 Apr 2025 17:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744739588;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cs2shrDNZ+9k5vXTaEF/DLz+6YP38cYDxKhyLNimBdk=;
	b=GCJnpF1vhAZd3v8Wky0WvN+tZLDG9hO/39Lok12erHvbPiUctgM4CTWwvIh5X7KVirlb23
	Go3PalE4Bwr0RxEG0yD6/eX0PG9AcifiiCMPC+DqFIXtHEnwwPwPVXQU2cpr6kdIOOB6p8
	bX4W6YkvJ4v6kasD9wn2YdT3lhnOng0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744739588;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cs2shrDNZ+9k5vXTaEF/DLz+6YP38cYDxKhyLNimBdk=;
	b=+moUnHCAmi1+W/Zne/VUnCkx0qxh93L6xWIXh0RbKeewFh94hHocXugcXDC+oIznES7/EM
	wDcXeSxRH6m1mlCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744739588;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cs2shrDNZ+9k5vXTaEF/DLz+6YP38cYDxKhyLNimBdk=;
	b=GCJnpF1vhAZd3v8Wky0WvN+tZLDG9hO/39Lok12erHvbPiUctgM4CTWwvIh5X7KVirlb23
	Go3PalE4Bwr0RxEG0yD6/eX0PG9AcifiiCMPC+DqFIXtHEnwwPwPVXQU2cpr6kdIOOB6p8
	bX4W6YkvJ4v6kasD9wn2YdT3lhnOng0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744739588;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cs2shrDNZ+9k5vXTaEF/DLz+6YP38cYDxKhyLNimBdk=;
	b=+moUnHCAmi1+W/Zne/VUnCkx0qxh93L6xWIXh0RbKeewFh94hHocXugcXDC+oIznES7/EM
	wDcXeSxRH6m1mlCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56F01137A5;
	Tue, 15 Apr 2025 17:53:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 60MAFQSd/mdWegAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 15 Apr 2025 17:53:08 +0000
Date: Tue, 15 Apr 2025 19:53:07 +0200
From: David Sterba <dsterba@suse.cz>
To: =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
Cc: "dsterba@suse.cz" <dsterba@suse.cz>, "clm@fb.com" <clm@fb.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"dsterba@suse.com" <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggMS8yXSBi?=
 =?utf-8?Q?trfs=3A_conver?= =?utf-8?Q?t?= to spinlock guards in
 btrfs_update_ioctl_balance_args()
Message-ID: <20250415175307.GK16750@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250409125724.145597-1-frank.li@vivo.com>
 <20250409183022.GG13292@suse.cz>
 <SEZPR06MB52695564F5DE73356D0EFF06E8B72@SEZPR06MB5269.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SEZPR06MB52695564F5DE73356D0EFF06E8B72@SEZPR06MB5269.apcprd06.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.988];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Thu, Apr 10, 2025 at 11:11:11AM +0000, 李扬韬 wrote:
> > Please don't do the guard() conversions in fs/btrfs/, the explicit locking is the preferred style. If other subsystems use the scoped locking guards then let them do it.
> 
> OK, is there anything we can do quickly in the btrfs code currently?

Yeah, there always is. The open coded rb_tree searches can be converted
to the rb_find() helpers. It ends up as the same asm code due to
inlining and reads a bit better when there's just one rb_find instead of
the while loop and left/right tree moves.

I have some WIP for that but I havent't tested it at all, but it should
give a good idea:

--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -160,23 +160,27 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 		   int init_flags);
 static void qgroup_rescan_zero_tracking(struct btrfs_fs_info *fs_info);
 
+static int qgroup_qgroupid_cmp(const void *key, const struct rb_node *node)
+{
+	const u64 *qgroupid = key;
+	const struct btrfs_qgroup *qgroup = rb_entry(n, struct btrfs_qgroup, node);
+
+	if (qgroup->qgroupid < qgroupid)
+		return -1;
+	else if (qgroup->qgroupid > qgroupid)
+		return 1;
+	return 0;
+}
+
 /* must be called with qgroup_ioctl_lock held */
 static struct btrfs_qgroup *find_qgroup_rb(const struct btrfs_fs_info *fs_info,
 					   u64 qgroupid)
 {
-	struct rb_node *n = fs_info->qgroup_tree.rb_node;
-	struct btrfs_qgroup *qgroup;
+	struct rb_node *node;
 
-	while (n) {
-		qgroup = rb_entry(n, struct btrfs_qgroup, node);
-		if (qgroup->qgroupid < qgroupid)
-			n = n->rb_left;
-		else if (qgroup->qgroupid > qgroupid)
-			n = n->rb_right;
-		else
-			return qgroup;
-	}
-	return NULL;
+	node = rb_find(&qgroupid, fs_info->qgroup_tree, qgroup_qgroupid_cmp);
+
+	return rb_entry_safe(n, struct btrfs_qgroup, node);
 }
 
 /*
---

So basically:
- add a comparator function
- replace the while loop with rb_find
- make sure it is equivalent and test it

There are easy conversions like __btrfs_lookup_delayed_item(),
potentially convertible too but with a comparator that takes an extra
parameter like prelim_ref_compare() or compare_inode_defrag(). There are
many more that do some additional things like remembering the last
parent pointer and for that the rb-tree API is not convenient so you can
skip that and do the straigtforward cases first.

If you decide not to take it then it's also fine, it's a cleanup and the
code will work as-is.

