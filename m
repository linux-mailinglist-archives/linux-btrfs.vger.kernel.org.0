Return-Path: <linux-btrfs+bounces-5070-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C848C89DD
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 18:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03CC31C21767
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 16:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B61D12FB07;
	Fri, 17 May 2024 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Roh0k7Nx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="237GUIOl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Roh0k7Nx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="237GUIOl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA92127471
	for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2024 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715962547; cv=none; b=lGHI/UzAH0g842B3MMhqTZKNZ4KIL1aestOspXHFXG6BEZBatG/MV7lQQ4ohakjzDUBAx0ebBJfFrxq9SVo9h750oGpQ/AQitY1GVLl+ITbhcQw6GA9mTpdeLHWfJ/pDK2QJ9YmO4dr8zsyldUfPjutLqknkV0drH2Rew0CSZPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715962547; c=relaxed/simple;
	bh=DUqJd5ccM8sqxUoLHguz4IP2qpUw7hDz2sSApKddb+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmwwxzR7m6qVDg4MMZsZt+M5QpUyhJdfvWLpYVIzS+ukfipvc/KxQo9G4TzpbiSSuQY4Hr9KQAsU+XaBSKL0GKJpeiFaM/wZIPzEbXvu2y/uSceCdrrdQ/5uLgNIUcusnLvehUMH/0lyto+56yCQPfMAeWKYGl1PDJVOK7u8Ddc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Roh0k7Nx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=237GUIOl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Roh0k7Nx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=237GUIOl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A5F0D5D564;
	Fri, 17 May 2024 16:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715962543;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UMizo+ZzAq43Bjs6XpV4EI8OzaQFSL5tQPvBmbHDlhk=;
	b=Roh0k7NxKAvRpKS2bC43w3YM7/vfFXf/HZXOEBvQgjLytt61YsPyuiysmXuZurRi7YDGzF
	iJjlcFoSA/PjkoORtVUM9zqXscLJ3pMiG0Tl3rd0cgQAkeAXiMED8mrMkqqL4NXaOJiJgp
	SysYASBsg6i+Oi3ON/PcNuhA8ya/51Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715962543;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UMizo+ZzAq43Bjs6XpV4EI8OzaQFSL5tQPvBmbHDlhk=;
	b=237GUIOlSO3JWK5n84nk9rB2NJJvKF8+jS2X9eiAvnivCNdL1wKyTOH9CUdKowcdpa/1t+
	mWDE28m5X/cALlAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Roh0k7Nx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=237GUIOl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715962543;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UMizo+ZzAq43Bjs6XpV4EI8OzaQFSL5tQPvBmbHDlhk=;
	b=Roh0k7NxKAvRpKS2bC43w3YM7/vfFXf/HZXOEBvQgjLytt61YsPyuiysmXuZurRi7YDGzF
	iJjlcFoSA/PjkoORtVUM9zqXscLJ3pMiG0Tl3rd0cgQAkeAXiMED8mrMkqqL4NXaOJiJgp
	SysYASBsg6i+Oi3ON/PcNuhA8ya/51Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715962543;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UMizo+ZzAq43Bjs6XpV4EI8OzaQFSL5tQPvBmbHDlhk=;
	b=237GUIOlSO3JWK5n84nk9rB2NJJvKF8+jS2X9eiAvnivCNdL1wKyTOH9CUdKowcdpa/1t+
	mWDE28m5X/cALlAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 959D913942;
	Fri, 17 May 2024 16:15:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c01bJK+CR2a+dgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 17 May 2024 16:15:43 +0000
Date: Fri, 17 May 2024 18:15:38 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs-progs: cmds/qgroup: enhance stale qgroups
 handling
Message-ID: <20240517161538.GC17126@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1715245781.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1715245781.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A5F0D5D564
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Thu, May 09, 2024 at 06:42:29PM +0930, Qu Wenruo wrote:
> Currently the `<stale>` label is give incorrectly for a lot of qgroups
> that can not and should not be deleted.
> 
> The patchset would address the problem for `btrfs qgroup show` and
> `btrfs qgroup clear-stale` commands, so that:
> 
> - `clear-stale` would not try to delete incorrect qgroups
>   Thus it should not return false errors.
> 
> - `show` would show extra types of qgroups
>   Including `<under deletion>` and `<squota space holder>`
> 
> Qu Wenruo (4):
>   btrfs-progs: cmds/qgroup: sync the fs before doing qgroup search
>   btrfs-progs: cmds/qgroup: add qgroup_lookup::flags member
>   btrfs-progs: cmds/qgroup: handle stale qgroup deleteion more
>     accurately
>   btrfs-progs: cmds/qgroup: add more special status for qgroups

Added to devel, thanks. Please use the subjects that match the style
used in progs, ie. no 'cmds/' prefix.

