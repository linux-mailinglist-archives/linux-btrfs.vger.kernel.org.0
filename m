Return-Path: <linux-btrfs+bounces-8390-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED1298C15A
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 17:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769231F244CE
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 15:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FE81CB31D;
	Tue,  1 Oct 2024 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hiq7s7wy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="McMNfiwD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hiq7s7wy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="McMNfiwD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065C81C9EB8
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Oct 2024 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727795696; cv=none; b=cfJWT5LrtBQfr3gcCmIVoyg0F2cJQw278sFKF1VIxCOgEHlNZHRoYwZgweK17V7CqZNhdjfh8ERutjSrxX4dEwFTk/BN2i+oGd9vTa/QWOqMJ+sn0yiJZwh/w4q5q/vdftFLJ5guz4u9LbpCmv2BgG4d6xIemgFOOqqi2TAkR1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727795696; c=relaxed/simple;
	bh=o1f28Izc8JdMTB4XKBEVXIudsqX4u8fmLtlwRmcXCew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdVKP8VdzoTprsYkNqtaOVDIu4FqzZFwzxkp2FhGZjS8FU+G4aG6hRHgYH4B8YC/SZ6vq0DhfAQ1dx/fibZsG7u8y5JizT0NmaBSGYRFLKvRDEb7P+OXRQ9PS18PYzVPwXDc/pUfThIeVPHFwZ0bmYQsS6MPL4w441NeNyUajx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hiq7s7wy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=McMNfiwD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hiq7s7wy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=McMNfiwD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 17F101F88A;
	Tue,  1 Oct 2024 15:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727795693;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PZOLbdDlZVcc/azcY9Z6/qjTE357aaC+XTF5HGdiaQU=;
	b=Hiq7s7wyPVUNI1Bq8D9UEMlTa6qZP77Fn7lAjh4Gd99cQPRg04mwVBp8ANCEEggqCvccC1
	C67F9VU8vRtUlAirlTsgUwc1y3tv9PpNx6UxK5AfGm3P80S286/DbWrhsNhfg58DexlvRL
	JlujADGO5Q7yrSI5uoCFyRISguiP1No=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727795693;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PZOLbdDlZVcc/azcY9Z6/qjTE357aaC+XTF5HGdiaQU=;
	b=McMNfiwDU25dUtJnSxoYVOue4xz0jiKyATSDS+CWiXzTTKwTSrXYcif/gHt5fT4ChhXDvm
	B9P3RspQGt3qjDCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727795693;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PZOLbdDlZVcc/azcY9Z6/qjTE357aaC+XTF5HGdiaQU=;
	b=Hiq7s7wyPVUNI1Bq8D9UEMlTa6qZP77Fn7lAjh4Gd99cQPRg04mwVBp8ANCEEggqCvccC1
	C67F9VU8vRtUlAirlTsgUwc1y3tv9PpNx6UxK5AfGm3P80S286/DbWrhsNhfg58DexlvRL
	JlujADGO5Q7yrSI5uoCFyRISguiP1No=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727795693;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PZOLbdDlZVcc/azcY9Z6/qjTE357aaC+XTF5HGdiaQU=;
	b=McMNfiwDU25dUtJnSxoYVOue4xz0jiKyATSDS+CWiXzTTKwTSrXYcif/gHt5fT4ChhXDvm
	B9P3RspQGt3qjDCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 030B713A6E;
	Tue,  1 Oct 2024 15:14:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fCyDAO0R/GYXMAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 01 Oct 2024 15:14:53 +0000
Date: Tue, 1 Oct 2024 17:14:43 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: wait for fixup workers before stopping cleaner
 kthread during umount
Message-ID: <20241001151443.GC28777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <91b0cff4e87fbc01a7a6fd7d068c6e54ea7296ea.1727777967.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91b0cff4e87fbc01a7a6fd7d068c6e54ea7296ea.1727777967.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Oct 01, 2024 at 11:21:35AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During unmount, at close_ctree(), we have the following steps in this order:
> 
> 1) Park the cleaner kthread - this doesn't destroy the kthread, it basically
>    halts its execution (wake ups against it work but do nothing);
> 
> 2) We stop the cleaner kthread - this results in freeing the respective
>    struct task_struct;
> 
> 3) We call btrfs_stop_all_workers() which waits for any jobs running in all
>    the work queues and then free the work queues.
> 
> Syzbot reported a case where a fixup worker resulted in a crash when doing
> a delayed iput on its inode while attempting to wake up the cleaner at
> btrfs_add_delayed_iput(), because the task_struct of the cleaner kthread
> was already freed. This can happen during unmount because we don't wait
> for any fixup workers still running before we call kthread_stop() against
> the cleaner kthread, which stops and free all its resources.

What a lucky shot by syzbot, getting the fixup + delayed iput + umount
lined up.

Reviewed-by: David Sterba <dsterba@suse.com>

