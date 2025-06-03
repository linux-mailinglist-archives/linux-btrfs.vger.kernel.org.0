Return-Path: <linux-btrfs+bounces-14400-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5756ACC128
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 09:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06EBA3A3ABC
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 07:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7323C2690F2;
	Tue,  3 Jun 2025 07:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y/Wktw10";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hf6ujG1n";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y/Wktw10";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hf6ujG1n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18872690EB
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748935400; cv=none; b=Mt/acinikx4j2i6ra51Yt6oij+9mtkPYrjj/yRXXV7USEJm5VF0AAiVA7xL5wUif5EkyEBzn8DVh9Sd3BwGN9+0AsRZKIoS/q8NSCJwUY7ABBi0jIjNLmcnkHq6uRNIosHCDCRqkvfzRi+yQPlFwdSp+6BOqHnkSviMv7TM0m4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748935400; c=relaxed/simple;
	bh=0aCZ6WSNapRAFR2WZ2FRBxDQ/wQmUptZjeVcX6HN58s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cjh1+CHDzc96WXgmbSc5qMNQLtDzeo79X7gXARGIGvsYhEBmLAiQOxA+zmcvP5Ea+fCS1bnmTcZ3Pj0VaWNG30oTtyV/mCZ61c/SDwr5LZmtAbjbEkpP6ufoLq7rZZLlqvbeD9sRJzvu0W6C3CqeWUvFIRXR6YnPxJbzN1o6dKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y/Wktw10; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hf6ujG1n; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y/Wktw10; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hf6ujG1n; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AFFED218D6;
	Tue,  3 Jun 2025 07:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748935395;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8CXv2zctPE28IC/OCWZTuj+VRrLSZOb0nUwqESdRFTE=;
	b=y/Wktw10EG2DjWaIFmdijAnD/ckAZzioEkA0Sgh/nL1tZhYRGVi17pOTOitp3NBqGNtLW7
	wOei8X4oH51945tZgMjPJvoxrTENw4IURFQUBBXN3cazXwZUqt7Eu12pGYP+7qazJjobGe
	mJRG9BEgV1wbrVbKo+bLKdLbZ/vdHmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748935395;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8CXv2zctPE28IC/OCWZTuj+VRrLSZOb0nUwqESdRFTE=;
	b=Hf6ujG1nHF7jxdxScjhhLHF5O9ICvhsebEZhZ1FZ0vLScTie10D7ty0nlE2/7nrs4c1yU6
	SO+lIbU8c6QO3TBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="y/Wktw10";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Hf6ujG1n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748935395;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8CXv2zctPE28IC/OCWZTuj+VRrLSZOb0nUwqESdRFTE=;
	b=y/Wktw10EG2DjWaIFmdijAnD/ckAZzioEkA0Sgh/nL1tZhYRGVi17pOTOitp3NBqGNtLW7
	wOei8X4oH51945tZgMjPJvoxrTENw4IURFQUBBXN3cazXwZUqt7Eu12pGYP+7qazJjobGe
	mJRG9BEgV1wbrVbKo+bLKdLbZ/vdHmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748935395;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8CXv2zctPE28IC/OCWZTuj+VRrLSZOb0nUwqESdRFTE=;
	b=Hf6ujG1nHF7jxdxScjhhLHF5O9ICvhsebEZhZ1FZ0vLScTie10D7ty0nlE2/7nrs4c1yU6
	SO+lIbU8c6QO3TBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BA4613A92;
	Tue,  3 Jun 2025 07:23:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xfp6JeOiPmgmDgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 03 Jun 2025 07:23:15 +0000
Date: Tue, 3 Jun 2025 09:23:06 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/14] btrfs: directory logging bug fix and several
 updates
Message-ID: <20250603072305.GI4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1748789125.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748789125.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AFFED218D6
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.21
X-Spam-Level: 

On Mon, Jun 02, 2025 at 11:32:53AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> These fix a race between renames and directory logging and several cleanups
> and small optimizations. Details in the change logs.
> 
> Filipe Manana (14):
>   btrfs: fix a race between renames and directory logging
>   btrfs: assert we join log transaction at btrfs_del_inode_ref_in_log()
>   btrfs: free path sooner at __btrfs_unlink_inode()
>   btrfs: use btrfs_del_item() at del_logged_dentry()
>   btrfs: assert we join log transaction at btrfs_del_dir_entries_in_log()
>   btrfs: allocate path earlier at btrfs_del_dir_entries_in_log()
>   btrfs: allocate path earlier at btrfs_log_new_name()
>   btrfs: allocate scratch eb earlier at btrfs_log_new_name()
>   btrfs: pass NULL index to btrfs_del_inode_ref() where not needed
>   btrfs: switch del_all argument of replay_dir_deletes() from int to bool
>   btrfs: make btrfs_delete_delayed_insertion_item() return a boolean
>   btrfs: add details to error messages at btrfs_delete_delayed_dir_index()
>   btrfs: make btrfs_should_delete_dir_index() return a bool instead
>   btrfs: make btrfs_readdir_delayed_dir_index() return a bool instead

The cleanup patches look ok. Feel free to add the whole series to
for-next, I'm not sure how much review from others you'll get for the
lgging magic.

