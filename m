Return-Path: <linux-btrfs+bounces-9338-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 110EC9BD3C4
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2024 18:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE0E281A7B
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2024 17:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53721E379F;
	Tue,  5 Nov 2024 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nPfm6SVg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LodVRw3A";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nPfm6SVg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LodVRw3A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806DC84D02
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Nov 2024 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730829099; cv=none; b=rGy3+CBDUdnCBpp9pXSVFLseZ8dKr56iHLCK3nf40VGeFsjmnR42Es7Er248s6uqyzzkBz/MVs7tDWqc2P0kY7D8JnSZseavMTACkdxN6OFQuKM0DTrlGnE2FMn74xO+mTQLD0Vb/Y8wMRzL60dxDdf8agSIeA4AXfKsFRnvhOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730829099; c=relaxed/simple;
	bh=gJVcED4VF4G0xplqgQLF/GUktrQqDzPA9WWWy2rpGOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IT9gXmmh6MSTySj+XDz16B/SZsdd84haQoSOM4xp06yHs+O0lBWg99D/ZGKtDHB2cTSft7LAB3MfyO6cpUzM20x/LwQiztl9ID1oC9vZK5ZIUklP1+W4yA7mUc1TJAdQIAoS0wR7jiahAoPOi8AMPFaQTOC4+oapcLdpG1uPEgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nPfm6SVg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LodVRw3A; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nPfm6SVg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LodVRw3A; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 703B51FBDD;
	Tue,  5 Nov 2024 17:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730829095;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2iJPtnnlG5ZO1GEXSe1fw4164m311oOW/oJ8eXGLqAg=;
	b=nPfm6SVg/VXczDLdtzOcykkgYpOoYFjI/s5a5+t2QyTOK0PGIwObCVAnHywqQkvpP20Ut5
	8xczPeUO89biVNCQ0Q8SGvgigOVydVn5YRm6rA4zOqjpWYFm1C5X31MSf3WOcmLQK4N9k5
	A4C3eX5Zf/RxgFtAw7vB+hqeZzNQHwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730829095;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2iJPtnnlG5ZO1GEXSe1fw4164m311oOW/oJ8eXGLqAg=;
	b=LodVRw3AMnoljLc6GLpp0NM4tJ4S/Pj3MyE73sDunUVX1v2zJxh37DeWU45VVH80JrZZ1o
	CDzIvS2VgFp+WqCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nPfm6SVg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LodVRw3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730829095;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2iJPtnnlG5ZO1GEXSe1fw4164m311oOW/oJ8eXGLqAg=;
	b=nPfm6SVg/VXczDLdtzOcykkgYpOoYFjI/s5a5+t2QyTOK0PGIwObCVAnHywqQkvpP20Ut5
	8xczPeUO89biVNCQ0Q8SGvgigOVydVn5YRm6rA4zOqjpWYFm1C5X31MSf3WOcmLQK4N9k5
	A4C3eX5Zf/RxgFtAw7vB+hqeZzNQHwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730829095;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2iJPtnnlG5ZO1GEXSe1fw4164m311oOW/oJ8eXGLqAg=;
	b=LodVRw3AMnoljLc6GLpp0NM4tJ4S/Pj3MyE73sDunUVX1v2zJxh37DeWU45VVH80JrZZ1o
	CDzIvS2VgFp+WqCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52E521394A;
	Tue,  5 Nov 2024 17:51:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gXu4EydbKmd9YgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 05 Nov 2024 17:51:35 +0000
Date: Tue, 5 Nov 2024 18:51:26 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: simplify logic to decrement snapshot counter at
 btrfs_mksnapshot()
Message-ID: <20241105175126.GD31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <e2938504101b0832739b3421f8d07b809a9f5232.1730818481.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2938504101b0832739b3421f8d07b809a9f5232.1730818481.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 703B51FBDD
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
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_TLS_ALL(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Nov 05, 2024 at 02:57:23PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There's no point in having a 'snapshot_force_cow' variable to track if we
> need to decrement the root->snapshot_force_cow counter, as we never jump
> to the 'out' label after incrementing the counter. Simplify this by
> removing the variable and always decrementing the counter before the 'out'
> label, right after the call to btrfs_mksubvol().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

