Return-Path: <linux-btrfs+bounces-16678-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FEBB45FC9
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 19:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9801E3BA703
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 17:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B810D31327C;
	Fri,  5 Sep 2025 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jBPTd06B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZCgelulG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jBPTd06B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZCgelulG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6406F15853B
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092403; cv=none; b=tIF8WldNESVu+TMonSd/M6WTXi6EuMpNP7XALAwl1Zgbqsys0RuMmZOR2S02e5Ia6NPyeOgXQj6zI1We1rAxa/2y9qB7JXIDLb1/cVqiuhyGYaLdgQfZKtv98Ai+/IBOeCqYj6SaCX1RRU4lWKhuZYSlimRLSb2w0eg9WhyIzi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092403; c=relaxed/simple;
	bh=kBokPeiie2wsNoBfgAPpAXujRwgOMyxLYbwBSsz+dM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9S3EwglmoUiJrUNb1shAne8Tl/JqTEpX8iIpik8M94j8Eu9WdEc2n6RsDUb/Nc73Ysxj0PyJiQm0RmQLxMAhNCPDOW02SSr0sircbooVkNxFijVxND/YZyvWB/yi6EX+qaFU4XHN6obv1FFFAAk8yB4jNq0q1cbzdjhsChxjmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jBPTd06B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZCgelulG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jBPTd06B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZCgelulG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 083F6774DE;
	Fri,  5 Sep 2025 17:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757092399;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u1GLYSc77ZAnp1H3DGUq8HlzZvLX+pr2Bz1d99YyVGw=;
	b=jBPTd06Bh1kj8XtY2/28K7C9Sr22U+EKKXVNWTQAavc1VEVUmg4rpNs66tpBmothlTHWFt
	TLk1NCHmYFnW4z7z+c53j1Kg3uwo1Bdq/sXWsIvaR/9HReceUR0XIlpPVYa+LxPYXDiiyA
	iXQzoGzbPmzehi2hq98xbxfpgpkTY0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757092399;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u1GLYSc77ZAnp1H3DGUq8HlzZvLX+pr2Bz1d99YyVGw=;
	b=ZCgelulGfNsPUBlcXqLSj5Klg9ZswCICtsu5WYqfrzf+zEUKRUODEIsNpsMmxpif/Mhvea
	N4Me3BOP39JcP+CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jBPTd06B;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZCgelulG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757092399;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u1GLYSc77ZAnp1H3DGUq8HlzZvLX+pr2Bz1d99YyVGw=;
	b=jBPTd06Bh1kj8XtY2/28K7C9Sr22U+EKKXVNWTQAavc1VEVUmg4rpNs66tpBmothlTHWFt
	TLk1NCHmYFnW4z7z+c53j1Kg3uwo1Bdq/sXWsIvaR/9HReceUR0XIlpPVYa+LxPYXDiiyA
	iXQzoGzbPmzehi2hq98xbxfpgpkTY0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757092399;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u1GLYSc77ZAnp1H3DGUq8HlzZvLX+pr2Bz1d99YyVGw=;
	b=ZCgelulGfNsPUBlcXqLSj5Klg9ZswCICtsu5WYqfrzf+zEUKRUODEIsNpsMmxpif/Mhvea
	N4Me3BOP39JcP+CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFDB413306;
	Fri,  5 Sep 2025 17:13:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /o41Ni4au2gMNwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 05 Sep 2025 17:13:18 +0000
Date: Fri, 5 Sep 2025 19:13:13 +0200
From: David Sterba <dsterba@suse.cz>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove redundant condition checks
Message-ID: <20250905171313.GO5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250905080103.382846-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905080103.382846-1-zhao.xichao@vivo.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 083F6774DE
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21

On Fri, Sep 05, 2025 at 04:01:03PM +0800, Xichao Zhao wrote:
> Remove redundant condition checks and replace else if with else.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  fs/btrfs/inode-item.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
> index f06cf701ae5a..3d0631bf7389 100644
> --- a/fs/btrfs/inode-item.c
> +++ b/fs/btrfs/inode-item.c
> @@ -531,7 +531,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
>  			if (extent_type != BTRFS_FILE_EXTENT_INLINE)
>  				item_end +=
>  				    btrfs_file_extent_num_bytes(leaf, fi);
> -			else if (extent_type == BTRFS_FILE_EXTENT_INLINE)
> +			else

I'd rather explicitly check for the values and add a separate fallback
statement that will catch unexpected values and propagates the errors.
As you did it we'd assume that everything "else" has to be
BTRFS_FILE_EXTENT_INLINE which may not be true in case of error.

>  				item_end += btrfs_file_extent_ram_bytes(leaf, fi);
>  
>  			btrfs_trace_truncate(control->inode, leaf, fi,

