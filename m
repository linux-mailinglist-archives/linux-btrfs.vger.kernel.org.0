Return-Path: <linux-btrfs+bounces-4724-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6B58BABFE
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 13:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2796F28162A
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 11:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6E7152DE2;
	Fri,  3 May 2024 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QO/LXn7g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gcw5RzY6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QO/LXn7g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gcw5RzY6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F097B1514E4
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714737500; cv=none; b=SpX1lfKwuiSgi6ifd8ScUJBcmFBKj5kcXuuCvRCdTXR0o/x4TtmNL6wMayBRt88ZXsTAEF0fTG8AMRxBVfuS4BuNVto1Fug41sIClycpd/udXK3bL69dQlFVka5K0ka/iXbljGNCvx5CZ4niGwXnCniKSLkrwXkoQXtG9lL0/z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714737500; c=relaxed/simple;
	bh=0bwW8q9fnqOXRK3g0ln6hc3kvkBMxoUpFQ/yhtx+TKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVEED7Ac9l9YAjWWQ3rGXuSOfUdTtiaEEj9qQ4vDCggzfXgOccQ970WYsEtSee1QUCIXhKdCJ5JdopB2w7TvqvQBOsH9Cm2kbeRCEhj/z99XRRX0LD830x7uPEyKDDeoETK9nyHJnmUGbwR+QcX0By9eoK0KZDESJvgB78dEBUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QO/LXn7g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gcw5RzY6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QO/LXn7g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gcw5RzY6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0EDEA338F6;
	Fri,  3 May 2024 11:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714737496;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nP77N8N5YtvwzgSJgu4Kj+BtqKn3RRQ01kJyP8cq/4k=;
	b=QO/LXn7g2idH5tExLCk7JHMQK6DLxKjBSRNvDFaJe3qCGy+KtijVu0PBQZtUb5JNO+/eAZ
	AimE0G4XM1tlLrp0Jx2FP+lMFp7EqMLZaWcdwRGIwInbZZIgMqxBuhgd0s3NIJGCe6q2X/
	stq4bJFhEefagIDS6d8wpa/dNF01IbA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714737496;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nP77N8N5YtvwzgSJgu4Kj+BtqKn3RRQ01kJyP8cq/4k=;
	b=Gcw5RzY6m9qI3nVvlcrVu3Ak+TRTLacGuTnYqAp5cGyY6Ei6dqyNfKVLO2+ucbTe4Kn7G8
	LrUmPYAgXazIHeCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="QO/LXn7g";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Gcw5RzY6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714737496;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nP77N8N5YtvwzgSJgu4Kj+BtqKn3RRQ01kJyP8cq/4k=;
	b=QO/LXn7g2idH5tExLCk7JHMQK6DLxKjBSRNvDFaJe3qCGy+KtijVu0PBQZtUb5JNO+/eAZ
	AimE0G4XM1tlLrp0Jx2FP+lMFp7EqMLZaWcdwRGIwInbZZIgMqxBuhgd0s3NIJGCe6q2X/
	stq4bJFhEefagIDS6d8wpa/dNF01IbA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714737496;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nP77N8N5YtvwzgSJgu4Kj+BtqKn3RRQ01kJyP8cq/4k=;
	b=Gcw5RzY6m9qI3nVvlcrVu3Ak+TRTLacGuTnYqAp5cGyY6Ei6dqyNfKVLO2+ucbTe4Kn7G8
	LrUmPYAgXazIHeCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9B97139CB;
	Fri,  3 May 2024 11:58:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6YHrOFfRNGZ6YwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 03 May 2024 11:58:15 +0000
Date: Fri, 3 May 2024 13:50:59 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/4] btrfs-progs: convert: refactor
 __btrfs_record_file_extent to add a prealloc flag
Message-ID: <20240503115059.GX2585@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1714722726.git.anand.jain@oracle.com>
 <c4b3a3a5192fe56f7b2e1d1ec91046ec27eb1a02.1714722726.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4b3a3a5192fe56f7b2e1d1ec91046ec27eb1a02.1714722726.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0EDEA338F6
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Fri, May 03, 2024 at 05:08:54PM +0800, Anand Jain wrote:
> This preparatory patch adds an argument '%prealloc' to the function
> __btrfs_record_file_extent(), to be used in the following patches.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/extent-tree-utils.c | 11 +++++++----
>  common/extent-tree-utils.h |  2 +-
>  convert/main.c             |  9 +++++----
>  convert/source-fs.c        |  5 +++--
>  convert/source-reiserfs.c  |  2 +-
>  mkfs/rootdir.c             |  3 ++-
>  6 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/common/extent-tree-utils.c b/common/extent-tree-utils.c
> index 34c7e5095160..2ccac6b44cea 100644
> --- a/common/extent-tree-utils.c
> +++ b/common/extent-tree-utils.c
> @@ -122,7 +122,7 @@ static int __btrfs_record_file_extent(struct btrfs_trans_handle *trans,
>  				      struct btrfs_root *root, u64 objectid,
>  				      struct btrfs_inode_item *inode,
>  				      u64 file_pos, u64 disk_bytenr,
> -				      u64 *ret_num_bytes)
> +				      u64 *ret_num_bytes, bool prealloc)
>  {
>  	int ret;
>  	struct btrfs_fs_info *info = root->fs_info;
> @@ -229,7 +229,10 @@ static int __btrfs_record_file_extent(struct btrfs_trans_handle *trans,
>  	leaf = path->nodes[0];
>  	fi = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
>  	btrfs_set_file_extent_generation(leaf, fi, trans->transid);
> -	btrfs_set_file_extent_type(leaf, fi, BTRFS_FILE_EXTENT_REG);
> +	if (prealloc)
> +		btrfs_set_file_extent_type(leaf, fi, BTRFS_FILE_EXTENT_PREALLOC);
> +	else
> +		btrfs_set_file_extent_type(leaf, fi, BTRFS_FILE_EXTENT_REG);

The bool parameter makes it less clear what it means in all the callers,
as it is supposed to select the type of extent you could pass the
BTRFS_FILE_ExTENT_ constant directly.

