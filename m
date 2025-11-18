Return-Path: <linux-btrfs+bounces-19084-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8863DC6A404
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 16:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C6954F4E0D
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 15:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCB235A156;
	Tue, 18 Nov 2025 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1i2V3YkG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+aWnEBce";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1i2V3YkG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+aWnEBce"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8142E2FF64A
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763478289; cv=none; b=B0ZV76XBzzzjkWSJeuoQKFZ4JrAP3pSzkGqg9KNSOoCRHhDOwClTPQBef2VfmizjS4GjPTrETm6L7w3a9MhRCkP4GEUPXwXfd/pa++2iujoD81zkaSBkd1HypzB7rc5R4lgn2Nyqd4CUiRPC6QpX4QnN5wX++oTf9JKAezixuOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763478289; c=relaxed/simple;
	bh=FgjYHCBMfEvn3Lyq3OJy3jvzeXXjcVBBvpcyePskaWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBCs7/DXXYDsyVvPf/IDe4jfMAWqIdVSm4FnxlfWLni+/8bh8KtL4gJFyhlVdXk5Ts0RCPG0tqp8fZB0KfQ+fnWLxtbdBZK1y2HeVhlWVtDYQGmHciX79SgobHeGrreyffNUginSdr7JyC7Ho2MH8U/DFNL2I+w7ouZj3orDr4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1i2V3YkG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+aWnEBce; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1i2V3YkG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+aWnEBce; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B564921288;
	Tue, 18 Nov 2025 15:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763478285;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YL85RqxuuNMiv+2toC8cFYpNOaGLWMGO+bpNVINvVks=;
	b=1i2V3YkG8gZztJewY7X8n+gj6+PA+yXN0wlgVE2ctpd8J0hJnf+cogdIV2+BroAO7x9mdP
	RdttQzdSnBDIqzOFr1fpkRT/mnv4QE2TG9TioMfz4icpKZGebLoIB9A2ZP+ROls910OlVP
	YClmheTF0VQpMWb9/wMC5GmW7UGSQH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763478285;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YL85RqxuuNMiv+2toC8cFYpNOaGLWMGO+bpNVINvVks=;
	b=+aWnEBcevIejmBW9WGG1+gvxJE2vew7H4mIgDfUcugYBwfWNVQghd2VQ4odn0+iSU5ebGc
	FQqBtFOuelkpw8BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763478285;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YL85RqxuuNMiv+2toC8cFYpNOaGLWMGO+bpNVINvVks=;
	b=1i2V3YkG8gZztJewY7X8n+gj6+PA+yXN0wlgVE2ctpd8J0hJnf+cogdIV2+BroAO7x9mdP
	RdttQzdSnBDIqzOFr1fpkRT/mnv4QE2TG9TioMfz4icpKZGebLoIB9A2ZP+ROls910OlVP
	YClmheTF0VQpMWb9/wMC5GmW7UGSQH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763478285;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YL85RqxuuNMiv+2toC8cFYpNOaGLWMGO+bpNVINvVks=;
	b=+aWnEBcevIejmBW9WGG1+gvxJE2vew7H4mIgDfUcugYBwfWNVQghd2VQ4odn0+iSU5ebGc
	FQqBtFOuelkpw8BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1F783EA61;
	Tue, 18 Nov 2025 15:04:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3ydWJw2LHGklJAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 18 Nov 2025 15:04:45 +0000
Date: Tue, 18 Nov 2025 16:04:44 +0100
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/8] btrfs: add fscrypt support, PART 1
Message-ID: <20251118150444.GW13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251112193611.2536093-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112193611.2536093-1-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Wed, Nov 12, 2025 at 08:36:00PM +0100, Daniel Vacek wrote:
> This is a revive of former work [1] of Omar, Sweet Tea and Josef to bring
> native encryption support to btrfs.
> 
> It will come in more parts. The first part this time is splitting the simple
> and isolated stuff out first to reduce the size of the final patchset.
> 
> Changes since v5 [1] are mostly rebase to the latest for-next and cleaning
> up the conflicts.
> 
> The remaining part needs further cleanup and a bit of redesign and it will
> follow later.
> 
> [1] https://lore.kernel.org/linux-btrfs/cover.1706116485.git.josef@toxicpanda.com/
> 
> Josef Bacik (6):
>   btrfs: add a bio argument to btrfs_csum_one_bio
>   btrfs: add orig_logical to btrfs_bio
>   btrfs: don't rewrite ret from inode_permission
>   btrfs: move inode_to_path higher in backref.c
>   btrfs: don't search back for dir inode item in INO_LOOKUP_USER
>   btrfs: set the appropriate free space settings in reconfigure
> 
> Omar Sandoval (1):
>   btrfs: disable various operations on encrypted inodes
> 
> Sweet Tea Dorminy (1):
>   btrfs: disable verity on encrypted inodes

Please resend the series what is OK for merge right now, I'm counting
two dropped patches. For the signed-off we might need to add an
explanation why there are so many or only keep the first one as the
patch author, the others usually mean only the pass through and not
really doing any contribution. Eventually there could be Co-developed-by
but this would need more investigation in the previous patch iterations.
This can be done once the patches are in for-next.

