Return-Path: <linux-btrfs+bounces-4496-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B1F8AE8C0
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 15:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579E51F23650
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 13:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF931136E30;
	Tue, 23 Apr 2024 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gg+UUjvA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZgltiMmQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gg+UUjvA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZgltiMmQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B3C64CCC
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Apr 2024 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880463; cv=none; b=FuZlWyFnyCyZS9Zc9QKre1pQNQq0g8G+YWh8QMTTXm2Uu0M5cjEqOcFBf1itYJ/A2n2iH+SmpiNqnjNeSYbFrNlKvGNrBeWfgJ1OiJILbA7FF1yAqtNMvhQ/j+Z3K3Bz4Kfzgl6mU5mPRNrMuzEoPCb5ps2+6/qO+MghpTZyWoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880463; c=relaxed/simple;
	bh=qWtyINI/6x4Uaoyyrrbe3JRzsRxQ63IoG2BJjmuu0u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mgloiohnbwp++QMhk5Zw3HQvtUMtGUpAP6ZtX3YYFfIBFiCKRb4/Pw5Yeu1CyO4fuTsqv7amvQURutioC3BsvCMw8ONtlOU/C0MN0vuyHjc1/VyjY5bu+QMQBPLOWXn7s5X1inFi1mGl9ESF/8cQZhX00b66/E+hw1KZ7YVPnnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gg+UUjvA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZgltiMmQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gg+UUjvA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZgltiMmQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 044DA5FFE6;
	Tue, 23 Apr 2024 13:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713880460;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MTbb/9ixPhdYPtJ+prccCmxTwcrVMtyNeOR3otX0RBc=;
	b=gg+UUjvASgEEo+S6p3Ew7ELtkBN0xgGk6aIpjhRM94RiZapoN37fI71g6Gd22Nl1LOPaat
	vPDvTYEslZYaAy6LFaZDzUXewCT1DaCKdsKA+K/7k7acKVTpjvrTi6qbSLNkKBzjiyMr9Q
	k0XdsiSra5LWGb6qzep8amgXj6SnThk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713880460;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MTbb/9ixPhdYPtJ+prccCmxTwcrVMtyNeOR3otX0RBc=;
	b=ZgltiMmQ6Apsjqy8tkmok7PM6FWvpD86hLHivL5GSHUwwevdQb/vCCCq9w96+Y6uPk6Z8G
	5bUItJskHA8v6QDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713880460;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MTbb/9ixPhdYPtJ+prccCmxTwcrVMtyNeOR3otX0RBc=;
	b=gg+UUjvASgEEo+S6p3Ew7ELtkBN0xgGk6aIpjhRM94RiZapoN37fI71g6Gd22Nl1LOPaat
	vPDvTYEslZYaAy6LFaZDzUXewCT1DaCKdsKA+K/7k7acKVTpjvrTi6qbSLNkKBzjiyMr9Q
	k0XdsiSra5LWGb6qzep8amgXj6SnThk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713880460;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MTbb/9ixPhdYPtJ+prccCmxTwcrVMtyNeOR3otX0RBc=;
	b=ZgltiMmQ6Apsjqy8tkmok7PM6FWvpD86hLHivL5GSHUwwevdQb/vCCCq9w96+Y6uPk6Z8G
	5bUItJskHA8v6QDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED5F213929;
	Tue, 23 Apr 2024 13:54:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gcLNOYu9J2YrcQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 23 Apr 2024 13:54:19 +0000
Date: Tue, 23 Apr 2024 15:46:47 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: qgroup: do not check qgroup inherit if qgroup is
 disabled
Message-ID: <20240423134647.GE3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <bd677611fcbd89c21d60585e22c8d4aed3b90090.1713599418.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd677611fcbd89c21d60585e22c8d4aed3b90090.1713599418.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Sat, Apr 20, 2024 at 05:20:27PM +0930, Qu Wenruo wrote:
> [BUG]
> After kernel commit 86211eea8ae1 ("btrfs: qgroup: validate
> btrfs_qgroup_inherit parameter"), user space tool snapper will fail to
> create snapshot using its timeline feature.
> 
> [CAUSE]
> It turns out that, if using timeline snapper would unconditionally pass
> btrfs_qgroup_inherit parameter (assigning the new snapshot to qgroup 1/0)
> for snapshot creation.
> 
> In that case, since qgroup is disabled there would be no qgroup 1/0, and
> btrfs_qgroup_check_inherit() would return -ENOENT and fail the whole
> snapshot creation.
> 
> [FIX]
> Just skip the check if qgroup is not enabled.
> This is to keep the older behavior for user space tools, as if the
> kernel behavior changed for user space, it is a regression of kernel.
> 
> Thankfully snapper is also fixing the behavior by detecting if qgroup is
> running in the first place, so the effect should not be that huge.
> 
> Link: https://github.com/openSUSE/snapper/issues/894
> Fixes: 86211eea8ae1 ("btrfs: qgroup: validate btrfs_qgroup_inherit parameter")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

> ---
>  fs/btrfs/qgroup.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 9aeb740388ab..2f55a89709b3 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3138,6 +3138,9 @@ int btrfs_qgroup_check_inherit(struct btrfs_fs_info *fs_info,
>  			       struct btrfs_qgroup_inherit *inherit,
>  			       size_t size)
>  {
> +	/* Qgroup not enabled, ignore the inherit parameter. */

Agreed with Filipe that the comment is not necessary.

