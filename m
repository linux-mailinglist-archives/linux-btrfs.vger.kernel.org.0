Return-Path: <linux-btrfs+bounces-12243-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55637A5DEED
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 15:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0331189F3F6
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 14:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C22224E002;
	Wed, 12 Mar 2025 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M1trXWaa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iygqG967";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M1trXWaa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iygqG967"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CCB645
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Mar 2025 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789609; cv=none; b=Shlk0pQbEzy43b2j0G2K8FLwwIKj8xxee+7r1arL7YT4xIf0rgRU1pyIe7PIxjSTyLP6jIln3yb3FNLwjfHSvRSmjnolXvjbhW8AqTEu+adVWPoLysL7jDakO7d7rcd0a03OtRJ7Qj1gfgsaQ6XyuR+9WPtnskxApHOHPYNudjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789609; c=relaxed/simple;
	bh=LQonx0W3pom1ky6XhcV5jLypusqWRPdG2nJrW/NY8uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWfFMpFXvw37aN+e1Qxd1ZwZF12or5sisfLzApXCHFJAi1xwufspCkjYcftjyahf/5dWTroNm1iR90tt3UFLbkkPUFTe9QK7Bgjh5CZEzCslT6UcwlK+uE1PBPZi5kuKTD7xzZEJ7iMzIVx/3pzDdqiqZ8F5LGwP9RWOgUbPRM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M1trXWaa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iygqG967; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M1trXWaa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iygqG967; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 31FB921182;
	Wed, 12 Mar 2025 14:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741789606;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gl1XmyQ0LAZ+roHqG0vFxSASOKNrFpdXV/AUeuztbj8=;
	b=M1trXWaaJqRjrqiB562SKgUNZxzd63YYXlr8Kdlgux5GvfJNsxvdR89EAklFY4Vak7d/TS
	+iAn6UgXZT8ey207G4wflnRLmt2gdMQknFQA1M/7T9SBvNq9gIbzLyKwIFUXCqJ01RgYJQ
	ZtBkzApucSwnxQCNEZzgDAgcAs8rIEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741789606;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gl1XmyQ0LAZ+roHqG0vFxSASOKNrFpdXV/AUeuztbj8=;
	b=iygqG967mvhceft4tjc7vfTKbFTcY9tBGIBw8xuMCsM0Qlrpk6xnii1xJGdDz6VTzVM3sX
	+sl6QDJCa5NJbmBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=M1trXWaa;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iygqG967
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741789606;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gl1XmyQ0LAZ+roHqG0vFxSASOKNrFpdXV/AUeuztbj8=;
	b=M1trXWaaJqRjrqiB562SKgUNZxzd63YYXlr8Kdlgux5GvfJNsxvdR89EAklFY4Vak7d/TS
	+iAn6UgXZT8ey207G4wflnRLmt2gdMQknFQA1M/7T9SBvNq9gIbzLyKwIFUXCqJ01RgYJQ
	ZtBkzApucSwnxQCNEZzgDAgcAs8rIEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741789606;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gl1XmyQ0LAZ+roHqG0vFxSASOKNrFpdXV/AUeuztbj8=;
	b=iygqG967mvhceft4tjc7vfTKbFTcY9tBGIBw8xuMCsM0Qlrpk6xnii1xJGdDz6VTzVM3sX
	+sl6QDJCa5NJbmBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 123E01377F;
	Wed, 12 Mar 2025 14:26:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hT9BBKaZ0WcqdwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 12 Mar 2025 14:26:46 +0000
Date: Wed, 12 Mar 2025 15:26:44 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs: don't clobber ret in btrfs_validate_super()
Message-ID: <20250312142644.GQ32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250311163931.1021554-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311163931.1021554-1-maharmstone@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 31FB921182
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.com:email,suse.cz:dkim,suse.cz:replyto,fb.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Tue, Mar 11, 2025 at 04:39:25PM +0000, Mark Harmstone wrote:
> Commit 2a9bb78cfd36 introduces a call to validate_sys_chunk_array() in

Please use full commit references in changelogs, like 

2a9bb78cfd36 ("btrfs: validate system chunk array at
btrfs_validate_super()")

there's a commonly used git alias:

[alias]
	one = show -s --pretty='format:%h (\"%s\")

> btrfs_validate_super(), which clobbers the value of ret set earlier.
> This has the effect of negating the validity checks done earlier, making
> it so btrfs could potentially try to mount invalid filesystems.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> Cc: Qu Wenruo <wqu@suse.com>
> Fixes: 2a9bb78cfd36 ("btrfs: validate system chunk array at btrfs_validate_super()")
> ---
>  fs/btrfs/disk-io.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 0afd3c0f2fab..4421c946a53c 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2562,6 +2562,9 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
>  		ret = -EINVAL;
>  	}
>  
> +	if (ret)
> +		return ret;
> +
>  	ret = validate_sys_chunk_array(fs_info, sb);

This is ok as a fix for the return value cloberring.

Tips for followup cleanups:

Right after the call to validate_sys_chunk_array() there are two checks
that duplicate the sys_array validation (maximum and minimum length). So
they can be removed from btrfs_validate_super(). Then there are two more
checks of generation of chunk tree and "cache_generation". Both can be
moved in front of the sys_array validation as they're simple like the
other checks.

As discussed in the thread, the magic check can return immediately as
its mismatch will likely trigger several other checks and would not
bring much help.

