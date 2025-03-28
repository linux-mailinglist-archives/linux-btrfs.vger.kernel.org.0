Return-Path: <linux-btrfs+bounces-12661-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF840A750AC
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 20:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B02F3B46E4
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 19:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377831E1DE8;
	Fri, 28 Mar 2025 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fs4H87uO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mcMaNP3X";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fs4H87uO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mcMaNP3X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FE81AAA1C
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743189136; cv=none; b=IQwClzFuX3bf126KLiF1zJGG3ZlVa8WaoVRNwtQJRQwf+QtJAUyItAjBDsyp8hFsosa9a9ARzyZCSus8JNYpT3sybPhai7iyLaegjpFxoTd46v8D9Cf/yjGpyb9U3sQytZ01nJJho49BkKBP0SyKeaXZwGbgVdnjAY1g2NK8vmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743189136; c=relaxed/simple;
	bh=VuSf5B5C6lPOSN8yhCuZIoQPdtYv3CLhdPqfs7AIdmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmnvaEfd3saMNBu1n70Clxqcl0KC5fqL7j+hk73fAdnnqTZDlGTHK3+GsCxTiuL5zmnwXRJAvSXhrevDqOhfM4s9EpYX4YkTYyuJ6Cn3YAB5/ynJfe2lWP3vKVckWOb6nfROmTjeHz0UqHL5j5sgeWywZFkM5n08S392YxkIh1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fs4H87uO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mcMaNP3X; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fs4H87uO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mcMaNP3X; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 96F741F388;
	Fri, 28 Mar 2025 19:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743189132;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xMRV5+LdqP2Wy7UIHRmT8VrsTWYdLNlp4PvPDczBzqE=;
	b=fs4H87uOJEOAn2Jqs4vgTTsYkoAa/9+BIuESoe0pCYK+wxDDx7blirgeaopPT3gKup9Por
	HVQchTqz8eCdSCWfJ4i9HoPoZF4rGaM0TqoEFpqa8SJK7ihK7gaON1qzzERfC5laVB+Up0
	8aTM2kpCLZy/cShpkJLkSk5OQcG1SZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743189132;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xMRV5+LdqP2Wy7UIHRmT8VrsTWYdLNlp4PvPDczBzqE=;
	b=mcMaNP3XDeeeS4W9/a0DqXVLJ8bM7UsR4ivYzfMSlPEVPJ0J7lD98jPeUu4QelY+moZ3Vv
	O2m2IhKL4yfJacAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fs4H87uO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mcMaNP3X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743189132;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xMRV5+LdqP2Wy7UIHRmT8VrsTWYdLNlp4PvPDczBzqE=;
	b=fs4H87uOJEOAn2Jqs4vgTTsYkoAa/9+BIuESoe0pCYK+wxDDx7blirgeaopPT3gKup9Por
	HVQchTqz8eCdSCWfJ4i9HoPoZF4rGaM0TqoEFpqa8SJK7ihK7gaON1qzzERfC5laVB+Up0
	8aTM2kpCLZy/cShpkJLkSk5OQcG1SZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743189132;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xMRV5+LdqP2Wy7UIHRmT8VrsTWYdLNlp4PvPDczBzqE=;
	b=mcMaNP3XDeeeS4W9/a0DqXVLJ8bM7UsR4ivYzfMSlPEVPJ0J7lD98jPeUu4QelY+moZ3Vv
	O2m2IhKL4yfJacAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7006413927;
	Fri, 28 Mar 2025 19:12:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0eDDGoz05mdzSAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 28 Mar 2025 19:12:12 +0000
Date: Fri, 28 Mar 2025 20:12:07 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: refactor btrfs_buffered_write() for the
 incoming large data folios
Message-ID: <20250328191207.GI32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1742443383.git.wqu@suse.com>
 <20250327164713.GV32661@twin.jikos.cz>
 <0ca94ef9-7626-48e5-8417-0c1efa4d6832@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ca94ef9-7626-48e5-8417-0c1efa4d6832@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 96F741F388
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmx.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Mar 28, 2025 at 07:17:39AM +1030, Qu Wenruo wrote:
> 在 2025/3/28 03:17, David Sterba 写道:
> > On Thu, Mar 20, 2025 at 04:04:07PM +1030, Qu Wenruo wrote:
> >> The function btrfs_buffered_write() is implementing all the complex
> >> heavy-lifting work inside a huge while () loop, which makes later large
> >> data folios work much harder.
> >>
> >> The first patch is a patch that already submitted to the mailing list
> >> recently, but all later reworks depends on that patch, thus it is
> >> included in the series.
> >>
> >> The core of the whole series is to introduce a helper function,
> >> copy_one_range() to do the buffer copy into one single folio.
> >>
> >> Patch 2 is a preparation that moves the error cleanup into the main loop,
> >> so we do not have dedicated out-of-loop cleanup.
> >>
> >> Patch 3 is another preparation that extract the space reservation code
> >> into a helper, make the final refactor patch a little more smaller.
> >>
> >> And patch 4 is the main dish, with all the refactoring happening inside
> >> it.
> >>
> >> Qu Wenruo (4):
> >>    btrfs: remove force_page_uptodate variable from btrfs_buffered_write()
> >>    btrfs: cleanup the reserved space inside the loop of
> >>      btrfs_buffered_write()
> >>    btrfs: extract the space reservation code from btrfs_buffered_write()
> >>    btrfs: extract the main loop of btrfs_buffered_write() into a helper
> >
> > I'm looking at the committed patches in for-next and there are still too
> > many whitespace and formatting issues, atop those pointed out in the
> > mail discussion. It's probably because the code moved and inherited the
> > formatting but this is one of the oportunities to fix it in the final
> > version.
> >
> > I fixed what I saw, but plase try to reformat the code according to the
> > best pratices. No big deal if something slips, I'd rather you focus on
> > the code than on formattig but in this patchset it looked like a
> > systematic error.
> >
> > In case of factoring out code and moving it around I suggest to do it in
> > two steps, first move the code, make sure it's correct etc, commit, and
> > then open the changed code in editor in diff mode. If you're using
> > fugitive.vim the command ":Gdiff HEAD^" clearly shows the changed code
> > and doing the styling and formatting pass is quite easy.
> >
> This is a little weird, IIRC the workflow hooks should detect those
> whitespace errors at commit time, e.g:
> 
> $ git commit  -a --amend
> ERROR:TRAILING_WHITESPACE: trailing whitespace
> #9: FILE: fs/btrfs/file.c:2207:
> +^I$
> 
> total: 1 errors, 0 warnings, 7 lines checked
> Checkpatch found errors, would you like to fix them up? (Yn)
> 
> But it was never triggered at any of the code move.
> 
> I know I missed a lot of style changes when moving the code, but I
> didn't expect any whitespace errors.
> 
> Mind to provide some examples where the git hooks didn't catch them?

I don't use the git hooks for checks so I'll copy it from the patches:

https://lore.kernel.org/linux-btrfs/b0bd320dba85d72a34a4f7e5ba6b6c42caedbe41.1742443383.git.wqu@suse.com/

@@ -1074,6 +1074,27 @@ int btrfs_write_check(struct kiocb *iocb, size_t count)
 	return 0;
 }
 
+static void release_space(struct btrfs_inode *inode,
+			  struct extent_changeset *data_reserved,
+			  u64 start, u64 len,
+			  bool only_release_metadata)
+{
+	const struct btrfs_fs_info *fs_info = inode->root->fs_info;
+
+	if (!len)
+		return;
+
+	if (only_release_metadata) {
+		btrfs_check_nocow_unlock(inode);
+		btrfs_delalloc_release_metadata(inode, len, true);
+	} else {
+		btrfs_delalloc_release_space(inode,
+				data_reserved,
+				round_down(start, fs_info->sectorsize),
+				len, true);
+	}
+}
---

The parameters of btrfs_delalloc_release_space(), matching its origin:

-	if (release_bytes) {
-		if (only_release_metadata) {
-			btrfs_check_nocow_unlock(BTRFS_I(inode));
-			btrfs_delalloc_release_metadata(BTRFS_I(inode),
-					release_bytes, true);
-		} else {
-			btrfs_delalloc_release_space(BTRFS_I(inode),
-					data_reserved,
-					round_down(pos, fs_info->sectorsize),
-					release_bytes, true);
-		}
-	}
---

Maybe the checks ignore possible whitespace adjustments in moved code,
e.g. comparing the - and + change literally and not taking the new
location into account.

Basically the same pattern in https://lore.kernel.org/linux-btrfs/522bfb923444f08b2c68c51a05cb5ca8b3ac7a77.1742443383.git.wqu@suse.com/

code moved to reserve_space() from btrfs_buffered_write(), parameters passed to
btrfs_free_reserved_data_space().

I remember fixing more code like this, but hopefully the two examples would be
sufficient to test the hook checks.

