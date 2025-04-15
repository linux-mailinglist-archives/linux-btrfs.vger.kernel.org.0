Return-Path: <linux-btrfs+bounces-13045-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E84CDA8A640
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 20:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0685A17FB9E
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 18:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22128222595;
	Tue, 15 Apr 2025 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="id7uEHpB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z9mD24ut";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="id7uEHpB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z9mD24ut"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF0021B1B9
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 18:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744740063; cv=none; b=e/V305dq5suxeIinla1rOTC8mnXak3GmjE9jETCdbZ14ypIs7LMdRC21DmGCOX2yXhUO8XQhvHXwgy9m97CGYpmit/iRbdJlJM38yt+W2wqzZF13pxP3+/l5XwDPF+pgmzB2jvWnGVplF8S83IFi6MUIVrfJv6tbFnj66nV6ybE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744740063; c=relaxed/simple;
	bh=VIU3YOiY98/f9r8pgYFEwVekiGO4a/6jeSkcROssuaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duOJ+sKZdF+QS0ILJMxOQx3Km74GFAKRgENP0XPaBvlQz4GHJTK6vzN3eZHF17lltgf/IpSXxfEwkCx3rKeD0bd+yvvtR4cIATl/sbzFwGqMi5j02HEJWSfMkib1O1HAz9tDY32HPZj8PTiffgUVH1g2V4NPYe0/J0z4fPmbGJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=id7uEHpB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z9mD24ut; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=id7uEHpB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z9mD24ut; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD69C1F461;
	Tue, 15 Apr 2025 18:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744740059;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tqDzUeAHeeGUgPBZz4cnwRo1kx8yqknbBXRcS6TgjCE=;
	b=id7uEHpBccTvHsZak3MoZNMnxFC7UG4xA4s+XbSQ78U2OmS6u+DTKVgToDLQ9G68QZ+MMg
	M2Z+lMuJt3FkltuZjTvfLH/HKqVZjAjQGeDMmvh/pjQs4Nj6ALUXm9f7Lbun88FCVscdwV
	48mv55AVF+1uiysxyKm+026sTAuwSV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744740059;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tqDzUeAHeeGUgPBZz4cnwRo1kx8yqknbBXRcS6TgjCE=;
	b=z9mD24ut1cSunXEq2zrT/NyTgiRunihmTBMmIrQzlD/mU9ExEvTufClOQNeyYUs66ZXmqq
	zBjdL8vQQLtGyUCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=id7uEHpB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=z9mD24ut
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744740059;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tqDzUeAHeeGUgPBZz4cnwRo1kx8yqknbBXRcS6TgjCE=;
	b=id7uEHpBccTvHsZak3MoZNMnxFC7UG4xA4s+XbSQ78U2OmS6u+DTKVgToDLQ9G68QZ+MMg
	M2Z+lMuJt3FkltuZjTvfLH/HKqVZjAjQGeDMmvh/pjQs4Nj6ALUXm9f7Lbun88FCVscdwV
	48mv55AVF+1uiysxyKm+026sTAuwSV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744740059;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tqDzUeAHeeGUgPBZz4cnwRo1kx8yqknbBXRcS6TgjCE=;
	b=z9mD24ut1cSunXEq2zrT/NyTgiRunihmTBMmIrQzlD/mU9ExEvTufClOQNeyYUs66ZXmqq
	zBjdL8vQQLtGyUCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BF1E137A5;
	Tue, 15 Apr 2025 18:00:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zhCrIdue/md4fAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 15 Apr 2025 18:00:59 +0000
Date: Tue, 15 Apr 2025 20:00:58 +0200
From: David Sterba <dsterba@suse.cz>
To: Charles Han <hanchunchao@inspur.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix the incorrect description in comments.
Message-ID: <20250415180058.GM16750@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250410090723.10166-1-hanchunchao@inspur.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410090723.10166-1-hanchunchao@inspur.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: AD69C1F461
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Apr 10, 2025 at 05:07:22PM +0800, Charles Han wrote:
> Replace PTR_ERR(-ENOMEM) to ERR_PTR(-ENOMEM) in comments.
> 
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>  fs/btrfs/delayed-inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 3f1551d8a5c6..e35626270f2b 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -119,7 +119,7 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
>  	return NULL;
>  }
>  
> -/* Will return either the node or PTR_ERR(-ENOMEM) */
> +/* Will return either the node or ERR_PTR(-ENOMEM) */

Thanks, while this is correct it would be better to update the whole
function comment so it's more descriptive. I'll write someting when
adding the patch to for-next, thanks.

