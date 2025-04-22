Return-Path: <linux-btrfs+bounces-13218-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9F2A9672B
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 13:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7122817CA58
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 11:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBC727BF88;
	Tue, 22 Apr 2025 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J5M+1CcI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OT5DlPDn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yxKv83Ya";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G1K4y4+c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE0C27BF6C
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Apr 2025 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745320906; cv=none; b=loiURTQScEow0BPzEjt7PbOVkjEfFRIaV5D2+JLbDKTQTx86T677MNPDVyMYFgFhkYF7tF0Xpoq6xUbESzd/KEQAoQTn2dA+cvI4nGw+xO5g/4MjOzFj6yr8fnhmRQAPkLvkARDxYDhueKRmfOZK8DRgIiBQMzXzNN++ARnP/wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745320906; c=relaxed/simple;
	bh=WiiZl3gUW2Kc/bxNmFW2nM46LR9b5lgB1H/oOxRHse8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dL8g6iUNYLMcC4Be0pGnzL4d6o8OHcp1/SX2PgoKLiDsJXrsN9dMy3HKQPNNm+g3Z6c+m0w/uOreRfL/XVXdvRjiNrDBTdEXzFsUWhQPt0LI9z3NGMAfE2fauGtFI2yTYzk6VIJPXxuftVjJw3PBO/toegaGwiXQHBHsgb50JnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J5M+1CcI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OT5DlPDn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yxKv83Ya; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G1K4y4+c; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E1EEB1F38E;
	Tue, 22 Apr 2025 11:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745320903;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rRxRCM/jou9XRqkHvYeAadFDhU1eJ+igOntodp1BQew=;
	b=J5M+1CcI/zjyytOI+g8x2nQS6S4cX39bjqK6B4B2BdOjRnGtgIxyiED5TBn7+S5xm7Btqx
	2ghbWvL9lak1yII5Ift140Eo3BMM77JsHY90Y19IQbKReL/oHNHbIyNoVlMtnUc8ozUdcA
	wVdVq0s0YjCCW1wQ56tw/k66lukueG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745320903;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rRxRCM/jou9XRqkHvYeAadFDhU1eJ+igOntodp1BQew=;
	b=OT5DlPDnukxo43o5Xm9p5A8hW0c1nV3ACvxHgJLHU9WTKZIl/9/6+HgFsZsOLu0oB59iYA
	8dyXkwXGmH9T73Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745320902;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rRxRCM/jou9XRqkHvYeAadFDhU1eJ+igOntodp1BQew=;
	b=yxKv83YaecAmRflpMi0DCGx4WcuaAuAExW6k71JmmRJfH1Z4Gq78BUrZ2K2hzqTceQCUwy
	c93VoAXk2cZoFPEywW6YhwzEkjJIXx/NaenaEr00kLEvxizlcLM3upNm5aSWuYwo0OiCh7
	7tf3IENLcVB6zWagYPtyBYugZbA+vx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745320902;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rRxRCM/jou9XRqkHvYeAadFDhU1eJ+igOntodp1BQew=;
	b=G1K4y4+caExD+bjh1IDbDXzAaANOyYfIV/twLMSBRhpBrR/PWZ604l5+PqOr69IuHe5xMe
	XIr8o3gaMsNWlwCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC540139D5;
	Tue, 22 Apr 2025 11:21:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BOjELcZ7B2gHCgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 22 Apr 2025 11:21:42 +0000
Date: Tue, 22 Apr 2025 13:21:37 +0200
From: David Sterba <dsterba@suse.cz>
To: Yangtao Li <frank.li@vivo.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] btrfs: update btrfs_insert_inode_defrag to to use
 rb helper
Message-ID: <20250422112137.GA3659@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250422081504.1998809-1-frank.li@vivo.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422081504.1998809-1-frank.li@vivo.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:replyto,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Please post the series with a cover letter so comments that apply to the
whole series can be posted there.

The series looks good, tests are running OK so far, I have mostly coding
style comments.

- rephrase the subject line to

"btrfs: use rb_find_add() in btrfs_insert_inode_defrag(I)

here mentioning the rb helper also suggests what the patch does and is
obvious so it does not need a long description.

On Tue, Apr 22, 2025 at 02:14:52AM -0600, Yangtao Li wrote:
> Update btrfs_insert_inode_defrag() to use rb_find_add().

The following text can be used in most patches (adjusted accordingly)

"Use the rb-tree helper so we don't open code the search and insert
code."
> 
> Suggested-by: David Sterba <dsterba@suse.com>

Please drop this tag.

> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/btrfs/defrag.c | 52 +++++++++++++++++++++++------------------------
>  1 file changed, 25 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index d4310d93f532..d908bce0b8a1 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -60,6 +60,16 @@ static int compare_inode_defrag(const struct inode_defrag *defrag1,
>  		return 0;
>  }
>  
> +static int inode_defrag_cmp(struct rb_node *new, const struct rb_node *exist)

This is a bit confusing name because there's also compare_inode_defrag()
but I don't have a better suggestion.

> +{
> +	const struct inode_defrag *new_defrag =
> +		rb_entry(new, struct inode_defrag, rb_node);
> +	const struct inode_defrag *exist_defrag =
> +		rb_entry(exist, struct inode_defrag, rb_node);
> +
> +	return compare_inode_defrag(new_defrag, exist_defrag);
> +}
> +
>  /*
>   * Insert a record for an inode into the defrag tree.  The lock must be held
>   * already.
> @@ -71,37 +81,25 @@ static int btrfs_insert_inode_defrag(struct btrfs_inode *inode,
>  				     struct inode_defrag *defrag)
>  {
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> -	struct inode_defrag *entry;
> -	struct rb_node **p;
> -	struct rb_node *parent = NULL;
> -	int ret;
> +	struct rb_node *exist;

Please use 'node' for the rb_nodes.

>  
> -	p = &fs_info->defrag_inodes.rb_node;
> -	while (*p) {
> -		parent = *p;
> -		entry = rb_entry(parent, struct inode_defrag, rb_node);
> +	exist = rb_find_add(&defrag->rb_node, &fs_info->defrag_inodes, inode_defrag_cmp);
> +	if (exist) {
> +		struct inode_defrag *entry;
>  
> -		ret = compare_inode_defrag(defrag, entry);
> -		if (ret < 0)
> -			p = &parent->rb_left;
> -		else if (ret > 0)
> -			p = &parent->rb_right;
> -		else {
> -			/*
> -			 * If we're reinserting an entry for an old defrag run,
> -			 * make sure to lower the transid of our existing
> -			 * record.
> -			 */
> -			if (defrag->transid < entry->transid)
> -				entry->transid = defrag->transid;
> -			entry->extent_thresh = min(defrag->extent_thresh,
> -						   entry->extent_thresh);
> -			return -EEXIST;
> -		}
> +		entry = rb_entry(exist, struct inode_defrag, rb_node);
> +		/*
> +		 * If we're reinserting an entry for an old defrag run,
> +		 * make sure to lower the transid of our existing
> +		 * record.

Please reformat the comment to 80 columns.

> +		 */
> +		if (defrag->transid < entry->transid)
> +			entry->transid = defrag->transid;
> +		entry->extent_thresh = min(defrag->extent_thresh,
> +					   entry->extent_thresh);
> +		return -EEXIST;
>  	}
>  	set_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags);
> -	rb_link_node(&defrag->rb_node, parent, p);
> -	rb_insert_color(&defrag->rb_node, &fs_info->defrag_inodes);
>  	return 0;
>  }
>  
> -- 
> 2.39.0
> 

