Return-Path: <linux-btrfs+bounces-14308-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA81AC8CC3
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 13:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800134E5B69
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 11:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620CB22AE7B;
	Fri, 30 May 2025 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OZuUn0m1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bgjbWnSp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OZuUn0m1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bgjbWnSp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0BF2288D6
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 11:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748603990; cv=none; b=QtLhC6E4lSd8bBztkt9rnYvMn3ESCN4JfvKEZezPx0sChkEdeecYfIC92R9yjsj3d9h6KYHNZ3s3qZ1a0Yn3F+joQSjW02YHxQFvEuK7LlhMTtFGWUaMahdFZ5wc2Dz0odP7WgfdctrxOQuBLqS1Ybdp+9sKlOTbBKheM8qG+ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748603990; c=relaxed/simple;
	bh=UIMfFgrxAVxxZM9TuxTkwsnxdO9T7Hkrptu+O+dB1fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TB27tNHqSnsoyPwORoy7MD3CUroO5gba1lZ88HTPrSBAVbNxmxQF0nPcAE1yiKTez72ZDE6HyQmwJ6yUPvWSFasv5xIfmf0vhdFuNO6av/f2sDOzPFjSqO6LNk1KIZht+mTliDkkBaSFd3IxxT5z5MeO4UK0h1uJWWR9cvwVZgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OZuUn0m1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bgjbWnSp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OZuUn0m1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bgjbWnSp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 34D1A21981;
	Fri, 30 May 2025 11:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748603987;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0x7W1qmMz+J1xfympDDlaYGWclGTzKblIgCl5CQfOCE=;
	b=OZuUn0m1vlVMO48kU5iFBD2J28aIDzy6hKYnc61qpAsOpT0lP/xtI/MRP9o56fSGYJb6LJ
	NK57bzAzu+xCCeEKzI3xNUciPKqH7naSRmhTAiFfdp+U5Rc6nWf7o9pZBudlg8YfZERtJX
	X1/JIAiqWnGUN+Z3Jc6rLUD4T2+OU1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748603987;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0x7W1qmMz+J1xfympDDlaYGWclGTzKblIgCl5CQfOCE=;
	b=bgjbWnSpNGjdtBF0PvLRBIElHUwOfVDAv1rUgq36xCwJ+1TdIj1r+DO8oqdZKe/rvqvUCW
	mYIobWMvtu1fVyCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OZuUn0m1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bgjbWnSp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748603987;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0x7W1qmMz+J1xfympDDlaYGWclGTzKblIgCl5CQfOCE=;
	b=OZuUn0m1vlVMO48kU5iFBD2J28aIDzy6hKYnc61qpAsOpT0lP/xtI/MRP9o56fSGYJb6LJ
	NK57bzAzu+xCCeEKzI3xNUciPKqH7naSRmhTAiFfdp+U5Rc6nWf7o9pZBudlg8YfZERtJX
	X1/JIAiqWnGUN+Z3Jc6rLUD4T2+OU1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748603987;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0x7W1qmMz+J1xfympDDlaYGWclGTzKblIgCl5CQfOCE=;
	b=bgjbWnSpNGjdtBF0PvLRBIElHUwOfVDAv1rUgq36xCwJ+1TdIj1r+DO8oqdZKe/rvqvUCW
	mYIobWMvtu1fVyCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1AB1013889;
	Fri, 30 May 2025 11:19:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k1RZBlOUOWjjEgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 30 May 2025 11:19:47 +0000
Date: Fri, 30 May 2025 13:19:45 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 5/6] btrfs-progs: fix-data-checksum: update csum items
 to fix csum mismatch
Message-ID: <20250530111945.GU4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1747295965.git.wqu@suse.com>
 <c78f6903cbb952acad86ac026dd597645d0af31b.1747295965.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c78f6903cbb952acad86ac026dd597645d0af31b.1747295965.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,twin.jikos.cz:mid,suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 34D1A21981
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.21

On Thu, May 15, 2025 at 05:30:20PM +0930, Qu Wenruo wrote:
> +static int update_csum_item(struct btrfs_fs_info *fs_info, u64 logical,
> +			    unsigned int mirror)
> +{
> +	struct btrfs_trans_handle *trans;
> +	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, logical);
> +	struct btrfs_path path = { 0 };
> +	struct btrfs_csum_item *citem;
> +	u64 read_len = fs_info->sectorsize;
> +	u8 csum[BTRFS_CSUM_SIZE] = { 0 };
> +	u8 *buf;
> +	int ret;
> +
> +	buf = malloc(fs_info->sectorsize);
> +	if (!buf)
> +		return -ENOMEM;

Not fixed, but the block buffers can be on stack as well if they're just
for the single function, the size is bounded.

> +	ret = read_data_from_disk(fs_info, buf, logical, &read_len, mirror);
> +	if (ret < 0) {
> +		errno = -ret;
> +		error("failed to read block at logical %llu mirror %u: %m",
> +			logical, mirror);
> +		goto out;
> +	}
> +	trans = btrfs_start_transaction(csum_root, 1);
> +	if (IS_ERR(trans)) {
> +		ret = PTR_ERR(trans);
> +		errno = -ret;
> +		error_msg(ERROR_MSG_START_TRANS, "%m");
> +		goto out;
> +	}
> +	citem = btrfs_lookup_csum(trans, csum_root, &path, logical,
> +				  BTRFS_EXTENT_CSUM_OBJECTID, fs_info->csum_type, 1);
> +	if (IS_ERR(citem)) {
> +		ret = PTR_ERR(citem);
> +		errno = -ret;
> +		error("failed to find csum item for logical %llu: $m", logical);
> +		btrfs_abort_transaction(trans, ret);
> +		goto out;
> +	}
> +	btrfs_csum_data(fs_info, fs_info->csum_type, buf, csum, fs_info->sectorsize);
> +	write_extent_buffer(path.nodes[0], csum, (unsigned long)citem, fs_info->csum_size);
> +	btrfs_release_path(&path);
> +	ret = btrfs_commit_transaction(trans, csum_root);
> +	if (ret < 0) {
> +		errno = -ret;
> +		error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
> +	}
> +	printf("Csum item for logical %llu updated using data from mirror %u\n",
> +		logical, mirror);
> +out:
> +	free(buf);
> +	btrfs_release_path(&path);
> +	return ret;
>  }
>  
>  static void report_corrupted_blocks(struct btrfs_fs_info *fs_info,

