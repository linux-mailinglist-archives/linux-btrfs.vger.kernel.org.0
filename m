Return-Path: <linux-btrfs+bounces-2855-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD9E86B12E
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 15:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53C0286C18
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 14:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06EA153513;
	Wed, 28 Feb 2024 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b/a0pE8X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cpQBFy2U";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b/a0pE8X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cpQBFy2U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC5F157E96
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Feb 2024 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128948; cv=none; b=ZPpJ8rilGvuQDulSgKi0RQUoGimzUChS7hIe+E68uaulKgO7TWWVVbusSAPC/POhI7lixCsnf37jC4fU3ReGhYykZiPFb8yhp4NCtxqavP9R2bp8RFDZ47S/I2YnRVuTAmRPlOXaNpVec0C/S1jUST5BnU4qj3BG/axBkhPJ6fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128948; c=relaxed/simple;
	bh=H6mFhWn5uQ07o45gNpe9XApSl4cV855YOSy8rn4CN0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ilrl2MG0fcYjj33m3EYivsh6nvKAQb2oTsHL7NlzBhTT8XStj921DglYgDBbxLosp4RJCGiQ8/8Zhmr+qk2Qb8lP4ioMqq+u7uDdZXhFvz6dCpfJ6P3uSHNDHndYxfBiLNew2lLUvNcngq2fFkf/9GIs/nRvhk6ULHZurLlojrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b/a0pE8X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cpQBFy2U; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b/a0pE8X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cpQBFy2U; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 112571F7A7;
	Wed, 28 Feb 2024 14:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709128944;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RWwdMbnbjyxyROzhhY+LfDF7kMwyGw5XDtFQKJVKh9A=;
	b=b/a0pE8XBpd0jAEFOEfEKj+XGTtdY4nd3Fc/+M+EyEPFOtBXLSPnfJB1RV38iEORmyLjA0
	C5fYwrU8Q9i2Z5M59gMF2Y6+8Gnwx2gEaq6UJNOJVkW773jpekvI3zIaqDNalkPTORykQu
	jWKQ01CHDnoqbPURCdOhLorRC2ZwsTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709128944;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RWwdMbnbjyxyROzhhY+LfDF7kMwyGw5XDtFQKJVKh9A=;
	b=cpQBFy2UPySwCfjwnFQT5NlRMU5DpDdtO+OLx2vLJIaN7g+vyQdu04AcsHQVCQDuw/SbBf
	3Kk1ktagL6KSB9DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709128944;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RWwdMbnbjyxyROzhhY+LfDF7kMwyGw5XDtFQKJVKh9A=;
	b=b/a0pE8XBpd0jAEFOEfEKj+XGTtdY4nd3Fc/+M+EyEPFOtBXLSPnfJB1RV38iEORmyLjA0
	C5fYwrU8Q9i2Z5M59gMF2Y6+8Gnwx2gEaq6UJNOJVkW773jpekvI3zIaqDNalkPTORykQu
	jWKQ01CHDnoqbPURCdOhLorRC2ZwsTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709128944;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RWwdMbnbjyxyROzhhY+LfDF7kMwyGw5XDtFQKJVKh9A=;
	b=cpQBFy2UPySwCfjwnFQT5NlRMU5DpDdtO+OLx2vLJIaN7g+vyQdu04AcsHQVCQDuw/SbBf
	3Kk1ktagL6KSB9DA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E9A9513A42;
	Wed, 28 Feb 2024 14:02:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id C4LhOO8832VpEQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 28 Feb 2024 14:02:23 +0000
Date: Wed, 28 Feb 2024 15:01:42 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: qgroup: allow quick inherit if a snapshot if
 created and added to the same parent
Message-ID: <20240228140142.GK17966@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <5dea98d4f3749f895402164c3cba61b176ff3b2e.1708919464.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dea98d4f3749f895402164c3cba61b176ff3b2e.1708919464.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.09 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWO(0.00)[2];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.11)[66.19%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.09

On Mon, Feb 26, 2024 at 02:21:13PM +1030, Qu Wenruo wrote:
> Currently "btrfs subvolume snapshot -i <qgroupid>" would always mark the
> qgroup inconsistent.
> 
> This can be annoying if the fs has a lot of snapshots, and needs qgroup
> to get the accounting for the amount of bytes it can free for each
> snapshot.
> 
> Although we have the new simple quote as a solution, there is also a
> case where we can skip the full scan, if all the following conditions
> are met:
> 
> - The source subvolume belongs to a higher level parent qgroup
> - The parent qgroup already owns all its bytes exclusively
> - The new snapshot is also added to the same parent qgroup
> 
> In that case, we only need to add nodesize to the parent qgroup and
> avoid a full rescan.

Sounds reasonable and safe.
> 
> This patch would add the extra quick accounting update for such inherit.

"Add th extra ..."

> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

>  fs/btrfs/qgroup.c | 74 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 67 insertions(+), 7 deletions(-)
> 
> +static int qgroup_snapshot_quick_inherit(struct btrfs_fs_info *fs_info,
> +					 u64 srcid, u64 parentid)
> +{
> +	struct btrfs_qgroup *src;
> +	struct btrfs_qgroup *parent;
> +	struct btrfs_qgroup_list *list;
> +	int nr_parents = 0;
> +
> +	src = find_qgroup_rb(fs_info, srcid);
> +	if (!src)
> +		return -ENOENT;
> +	parent = find_qgroup_rb(fs_info, parentid);
> +	if (!parent)
> +		return -ENOENT;
> +
> +	list_for_each_entry(list, &src->groups, next_group) {
> +		/* The parent is not the same, quick update not possible. */
> +		if (list->group->qgroupid != parentid)
> +			return 1;
> +		nr_parents++;
> +	}
> +	/*
> +	 * The source has multiple parents, do not bother it and require a
> +	 * full rescan.
> +	 */
> +	if (nr_parents != 1)
> +		return 1;

You can put the check to the list_for_each above so it does not continue
once it's known that there are more parent qgroups.

