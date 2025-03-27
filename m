Return-Path: <linux-btrfs+bounces-12623-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4554EA73DF5
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 19:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1110B3B3444
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 18:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F72E21A928;
	Thu, 27 Mar 2025 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iLUphHYX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JQ96gtIp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iLUphHYX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JQ96gtIp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6A7F4F1
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743099705; cv=none; b=FVvmOHv5lsnTOtXngde1dubP5Qvuq9EtHjA5x88TyNEoWTNQrtpoXY2czs4CRz91G1tB7VyfcD3+Kxw6OiwwSQsZHHX/u+Xh/e8ulONcyRc+pFaLLrD/djXsQ8cVnCDFoqu4KYKRiZn//mHikC7Dl+ugJvymIThZ2YNgdawNvzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743099705; c=relaxed/simple;
	bh=199VpNAm+yF7EsohZVhPPZ4BsiROcwX7tp9UCuR/zzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoveioDEdfQN34/WE55y5nhKhCWq2tpzOcyV5meow5WjyTxbwIAqJdOYUnsOQ0IScUwxsamb6ciYQBWBIHN/+a8j35ZP8pq7tWfEZxa05Q1Nl65t5+wKvzCyG6DX7tOGAn9HK8JxHdPngtbZ96pyGDRomLMi6GPy2V1hnWafNxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iLUphHYX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JQ96gtIp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iLUphHYX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JQ96gtIp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 27E6B1F388;
	Thu, 27 Mar 2025 18:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743099702;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2XWpCmArxPVMC9szJ58OtRQY/ZG8So1o84kiMZQLggA=;
	b=iLUphHYXdFLLXIBT7eIa4Vm9pAXL0xQA+JGSrbJkN+Xy2N8Bc4OgIKmZPCAKRuFdalZ5tz
	ahMlA58CzqC/YQ9W6wyvvp+IQLnHviVZFkOob/lHzn1uCrLmftSPx4jMqYjL1iVY+feWs5
	9yCgPdTBOShFp3ofCTcE8ek718ndXBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743099702;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2XWpCmArxPVMC9szJ58OtRQY/ZG8So1o84kiMZQLggA=;
	b=JQ96gtIpHkHkVWw9Wm9DZJ4hYU5NvD9jeDrkk1HdfgeEDuyR/+sba7+3d5MoxJh8sUQZ5O
	VJxkrELh9RHTnVDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iLUphHYX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JQ96gtIp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743099702;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2XWpCmArxPVMC9szJ58OtRQY/ZG8So1o84kiMZQLggA=;
	b=iLUphHYXdFLLXIBT7eIa4Vm9pAXL0xQA+JGSrbJkN+Xy2N8Bc4OgIKmZPCAKRuFdalZ5tz
	ahMlA58CzqC/YQ9W6wyvvp+IQLnHviVZFkOob/lHzn1uCrLmftSPx4jMqYjL1iVY+feWs5
	9yCgPdTBOShFp3ofCTcE8ek718ndXBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743099702;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2XWpCmArxPVMC9szJ58OtRQY/ZG8So1o84kiMZQLggA=;
	b=JQ96gtIpHkHkVWw9Wm9DZJ4hYU5NvD9jeDrkk1HdfgeEDuyR/+sba7+3d5MoxJh8sUQZ5O
	VJxkrELh9RHTnVDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D654139D4;
	Thu, 27 Mar 2025 18:21:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cE4FAzaX5WfwKgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 27 Mar 2025 18:21:42 +0000
Date: Thu, 27 Mar 2025 19:21:36 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove call to btrfs_delete_unused_bgs() in
 close_ctree()
Message-ID: <20250327182136.GB32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250318155659.160150-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318155659.160150-1-maharmstone@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 27E6B1F388
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid,fb.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Mar 18, 2025 at 03:56:56PM +0000, Mark Harmstone wrote:
> btrfs_delete_unused_bgs() returns early if the filesystem is closing, so the
> call in close_ctree() will always do nothing.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
>  fs/btrfs/disk-io.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 1a916716cefe..7c114d5d0f77 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4412,12 +4412,6 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
>  	btrfs_discard_cleanup(fs_info);
>  
>  	if (!sb_rdonly(fs_info->sb)) {
> -		/*
> -		 * The cleaner kthread is stopped, so do one final pass over
> -		 * unused block groups.
> -		 */
> -		btrfs_delete_unused_bgs(fs_info);

I've checked the original commit that added it, e44163e17796 ("btrfs:
explictly delete unused block groups in close_ctree and ro-remount") and
this at that time it was cleaning the unused block groups.

This changed in 2f12741f81af ("btrfs: use btrfs_fs_closing for
background bg work") supposedly moving the work to a workque, so this
should be reviewed again if it works as expected.

