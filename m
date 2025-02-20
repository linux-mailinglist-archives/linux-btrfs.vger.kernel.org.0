Return-Path: <linux-btrfs+bounces-11676-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7FEA3E8C0
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 00:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B337217CD65
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 23:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560C51F152F;
	Thu, 20 Feb 2025 23:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D4TqIo0p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RpblLNuy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D4TqIo0p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RpblLNuy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0ED2862A5
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 23:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740095204; cv=none; b=KEYeY4UgL8SMfEyZwaVchmcOZjfPnofIiNgI2vUBp8g5N+edy9Dd48yCetXnrLQEybFOPhzVgCRETfLDETtcpvp83aqDQrBUaK/UKx+T3mCITWrmeX8vY4iLMfWzeW3Ie0BimeBPuewGl1ARyO0sMhoi7SFnq2iwlECKw1Af3qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740095204; c=relaxed/simple;
	bh=FFFAVn7soaER7Vq6I25XNkIBwEvkHcvGpmgqwcawbos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbPy1gJTIgCL9o1RVvhB2DBHu4x3qoquwSSsMGlYNLmGCQuc6XsyemqRoa/6kg/rG5JIXQ3lMcxRYEb/0sIY7XGGCBOXFbxlA9TUwBaRS0XXHkC5VJJGuE1SqA3iJ4DiPxMoDIE7TcUsBQ/b8tLpMyDomCwpIZoi33lUGijrciY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D4TqIo0p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RpblLNuy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D4TqIo0p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RpblLNuy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A37881F390;
	Thu, 20 Feb 2025 23:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740095200;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z4JvqceLFvuoi5HbO76HrKkmQgfgdK/ikJ+vYoJL39U=;
	b=D4TqIo0pSZWz6zlGBWGoBHBRW/hiXGWBq4CNhS2bQkM9Fzol+fS7z7jNSzxzXg2LDX9je2
	ugiEXUNrUpwwPYJzZtV4/NRy0OZJngYuRzKV+7UAXe500MG39ui2zpoL9q8/76VbL8sF/q
	OAuBynCXz2SwJtwtIzREwFK4h5uOREs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740095200;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z4JvqceLFvuoi5HbO76HrKkmQgfgdK/ikJ+vYoJL39U=;
	b=RpblLNuyCSusq7sQb30Q64nu06h7LPqmW0bJwppxfWzfkVs3l2NZ3yDvHjLiBxCH5gQDYZ
	stkB1BnhQvdHR5Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740095200;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z4JvqceLFvuoi5HbO76HrKkmQgfgdK/ikJ+vYoJL39U=;
	b=D4TqIo0pSZWz6zlGBWGoBHBRW/hiXGWBq4CNhS2bQkM9Fzol+fS7z7jNSzxzXg2LDX9je2
	ugiEXUNrUpwwPYJzZtV4/NRy0OZJngYuRzKV+7UAXe500MG39ui2zpoL9q8/76VbL8sF/q
	OAuBynCXz2SwJtwtIzREwFK4h5uOREs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740095200;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z4JvqceLFvuoi5HbO76HrKkmQgfgdK/ikJ+vYoJL39U=;
	b=RpblLNuyCSusq7sQb30Q64nu06h7LPqmW0bJwppxfWzfkVs3l2NZ3yDvHjLiBxCH5gQDYZ
	stkB1BnhQvdHR5Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88E4F13301;
	Thu, 20 Feb 2025 23:46:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +7DuIOC+t2fuAgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 20 Feb 2025 23:46:40 +0000
Date: Fri, 21 Feb 2025 00:46:35 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/30] btrfs: avoid repeated path computations and
 allocations for send
Message-ID: <20250220234635.GI5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1740049233.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740049233.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.977];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Thu, Feb 20, 2025 at 11:04:13AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This eleminates repeated path allocations and computations for send when
> processing the current inode. The bulk of this is done in patches 28/30
> and 29/30, while the remainder are cleanups and simplifications, some of
> them to simplify the actual work related to avoiding the repeated path
> allocations and computations.
> 
> A test, and its result, is described in the change log of patch 29/30.
> 
> V2: Add 4 missing patches (cleanups).
> 
> Filipe Manana (30):
>   btrfs: send: remove duplicated logic from fs_path_reset()
>   btrfs: send: make fs_path_len() inline and constify its argument
>   btrfs: send: always use fs_path_len() to determine a path's length
>   btrfs: send: simplify return logic from fs_path_prepare_for_add()
>   btrfs: send: simplify return logic from fs_path_add()
>   btrfs: send: implement fs_path_add_path() using fs_path_add()
>   btrfs: send: simplify return logic from fs_path_add_from_extent_buffer()
>   btrfs: send: return -ENAMETOOLONG when attempting a path that is too long
>   btrfs: send: simplify return logic from __get_cur_name_and_parent()
>   btrfs: send: simplify return logic from is_inode_existent()
>   btrfs: send: simplify return logic from get_cur_inode_state()
>   btrfs: send: factor out common logic when sending xattrs
>   btrfs: send: only use booleans variables at process_recorded_refs()
>   btrfs: send: add and use helper to rename current inode when processing refs
>   btrfs: send: simplify return logic from send_remove_xattr()
>   btrfs: send: simplify return logic from record_new_ref_if_needed()
>   btrfs: send: simplify return logic from record_deleted_ref_if_needed()
>   btrfs: send: simplify return logic from record_new_ref()
>   btrfs: send: simplify return logic from record_deleted_ref()
>   btrfs: send: simplify return logic from record_changed_ref()
>   btrfs: send: remove unnecessary return variable from process_new_xattr()
>   btrfs: send: simplify return logic from process_changed_xattr()
>   btrfs: send: simplify return logic from send_verity()
>   btrfs: send: simplify return logic from send_rename()
>   btrfs: send: simplify return logic from send_link()
>   btrfs: send: simplify return logic from send_unlink()
>   btrfs: send: simplify return logic from send_rmdir()
>   btrfs: send: keep the current inode's path cached
>   btrfs: send: avoid path allocation for the current inode when issuing commands
>   btrfs: send: simplify return logic from send_set_xattr()

Reviewed-by: David Sterba <dsterba@suse.com>

