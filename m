Return-Path: <linux-btrfs+bounces-7756-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9F296908B
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 02:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68AC1F235A0
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 00:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510DD18756E;
	Mon,  2 Sep 2024 23:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qAYWp/m+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gshsTGn9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qAYWp/m+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gshsTGn9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6A5185E68
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Sep 2024 23:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725321595; cv=none; b=KmXlRz8Iy5ixsq06iMRjOI33etQxMtP/zIOAyLJg/oBBZn6Z6RURGcAmVEKKvusMl2kfWV1Eos54qOUwr2etE8QAPkmlz8zaOe4P+Jz0/9rPTwpMb95Tb3oFBerNp7ZgkOkdTH9JLkseZcS+zKrtHL3q4De+0kXnE94RyaiWiEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725321595; c=relaxed/simple;
	bh=T1xp5gQunTClBS7vJIznjTMZwf3RDhBSNlL7fbZKJnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/WAD6xXTKzBD6WEagDf/Tp5P3Qkk+zq7Pz0mdZVt4Xj0WoWXzpGYFOE1rbi2sjSH+Qa1tGZWhTfeIuwk7QCYZOdf+73r6nO66sHvXFqY6mPcEtDUH0jDTIjhC3cKTk/n6vENDDcweDd1+plGNvFcBTR3EBgbNfbPB2uNwtk+0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qAYWp/m+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gshsTGn9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qAYWp/m+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gshsTGn9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CB0AD1FC85;
	Mon,  2 Sep 2024 23:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725321591;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=miwrDrcG4JFRE//VSk5He5o5aeTXod4F2YIfaa0Osuw=;
	b=qAYWp/m+z9++mEbEDpk2riL+bbxAs1hw7FILvWd1NYv84xQCnbk/6Mf2XpygTCT+L54WTq
	SZDL04N37uQ2hdnafQ/A810AYPBGboeg+XjAFdKiQi8YultYt/TK4+M5c/Jdombz9ThFGU
	b9up0zgt2Lzt1DvhhfNlaUoIvLoETTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725321591;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=miwrDrcG4JFRE//VSk5He5o5aeTXod4F2YIfaa0Osuw=;
	b=gshsTGn9+htFsN8dHhVUajhmow/I90g3v2uHJrp9wgB5P53TYMWbWr1slaadgftm+9YkI8
	zuiqiOoRGglYe9DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725321591;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=miwrDrcG4JFRE//VSk5He5o5aeTXod4F2YIfaa0Osuw=;
	b=qAYWp/m+z9++mEbEDpk2riL+bbxAs1hw7FILvWd1NYv84xQCnbk/6Mf2XpygTCT+L54WTq
	SZDL04N37uQ2hdnafQ/A810AYPBGboeg+XjAFdKiQi8YultYt/TK4+M5c/Jdombz9ThFGU
	b9up0zgt2Lzt1DvhhfNlaUoIvLoETTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725321591;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=miwrDrcG4JFRE//VSk5He5o5aeTXod4F2YIfaa0Osuw=;
	b=gshsTGn9+htFsN8dHhVUajhmow/I90g3v2uHJrp9wgB5P53TYMWbWr1slaadgftm+9YkI8
	zuiqiOoRGglYe9DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABC0913326;
	Mon,  2 Sep 2024 23:59:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5xVjKXdR1mbeTwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 02 Sep 2024 23:59:51 +0000
Date: Tue, 3 Sep 2024 01:59:46 +0200
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Leo Martins <loemra.dev@gmail.com>, kernel-team@fb.com,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/3] btrfs path auto free
Message-ID: <20240902235946.GI26776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1724792563.git.loemra.dev@gmail.com>
 <j1u38.er61zc06h8sh@gmail.com>
 <20240902234346.GH26776@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902234346.GH26776@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-1.50 / 50.00];
	REPLYTO_EQ_TO_ADDR(5.00)[];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,fb.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,twin.jikos.cz:mid];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Score: -1.50
X-Spam-Flag: NO

On Tue, Sep 03, 2024 at 01:43:46AM +0200, David Sterba wrote:
> On Fri, Aug 30, 2024 at 01:46:59PM -0700, Leo Martins wrote:
> > I think the only feedback I haven't addressed in this patchset was
> > moving the declaration to be next to the btrfs_path struct.
> > However, I don't think moving the declaration makes sense because
> > the DEFINE_FREE references btrfs_free_path which itself is only
> > declared after the structure.
> 
> As long as the definition of btrfs_free_path() is not needed to
> compile, because it's a macro, I'd really want to keep the auto freeing
> defininion next to the structure because it's closely related to the
> structure. So if I ever go to the definition of any structure I want to
> see right away if it does or does not support the auto free.

This diff demonstrates the idea:

--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -196,7 +196,7 @@ struct btrfs_path *btrfs_alloc_path(void)
 /* this also releases the path */
 void btrfs_free_path(struct btrfs_path *p)
 {
-       if (IS_ERR_OR_NULL(p))
+       if (!p)
                return;
        btrfs_release_path(p);
        kmem_cache_free(btrfs_path_cachep, p);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index fbf1f8644fae..fd5474770862 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -85,6 +85,9 @@ struct btrfs_path {
        unsigned int nowait:1;
 };
 
+#define BTRFS_PATH_AUTO_FREE(path_name) \
+       struct btrfs_path *path_name __free(btrfs_free_path) = NULL;
+
 /*
  * The state of btrfs root
  */
@@ -601,8 +604,6 @@ void btrfs_release_path(struct btrfs_path *p);
 struct btrfs_path *btrfs_alloc_path(void);
 void btrfs_free_path(struct btrfs_path *p);
 DEFINE_FREE(btrfs_free_path, struct btrfs_path *, btrfs_free_path(_T))
-#define BTRFS_PATH_AUTO_FREE(path_name) \
-       struct btrfs_path *path_name __free(btrfs_free_path) = NULL;
 
 int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
                   struct btrfs_path *path, int slot, int nr);
---

So, it's moving defintion of auto free capability next to the structure, while
keeping the DEFINE_FREE next to the function forward declaration, or eventually
definition if needed.

