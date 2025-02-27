Return-Path: <linux-btrfs+bounces-11901-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E57A9A479A3
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 10:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCDBA3B39DA
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 09:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49F1228CA3;
	Thu, 27 Feb 2025 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KQrmIAxg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uQbD26nD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KQrmIAxg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uQbD26nD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E835225A34
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740650135; cv=none; b=CVE1h7bWYkvztiIEttELJMCIQ2sqB77ZdmW1I+RUKv0RJZwrAij4DfCcc70aEeJW3sil2kHz+SNPToKHsGGCqdQKokEa3YI/EBbT3eGtph3NT3Na28AvOrD06PIwN4zNFz6/uPmMlahAlKHwSCZg9T5jl+qOJ1wqTmIGB5YoUpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740650135; c=relaxed/simple;
	bh=3J9hTQ0zGTAtOl9EADcHNKFSvlNwA1lzYQmY4zH8E3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+dl7JwVAyAHPLmKXgB72WSo8/FrzzfHo94qeXbXyrUkfJc3fpBVycDx4oSiGPS1ciL+sQlUFsR5FpIM/oVmoj4WKBbPUHfvUSCfRirY3dHJ5z/uPoULydKYpaEGexdrPZv3RXfpdv4BzTgTVCPQ9DUyu6C78SU1EwTILeUgEqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KQrmIAxg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uQbD26nD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KQrmIAxg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uQbD26nD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BEE05211A1;
	Thu, 27 Feb 2025 09:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740650131;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LOdsgIFAVerAWy3OtSx5FWccrs6CMcIqn4P0NNUBoi8=;
	b=KQrmIAxgngvbbcOScDz25Mu7gYAdQ8QmTn9fMg7Ml+pA338atBTenmIkUlkJs2kah56JiN
	hCZBQBr5nx/4Vt9eYr46OsrqRuKtP+bsiWCh17rowjy26Scoj53C3lv3e+3eXbpuL3d+W+
	VgzbEmf17pUiuuaWiXkTnVgzRaoQ33c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740650131;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LOdsgIFAVerAWy3OtSx5FWccrs6CMcIqn4P0NNUBoi8=;
	b=uQbD26nDmlHkR5HVSf1Mgx2U5r3o1bg4nRw6cZscT167FEmYrHD/vOcNGIeB1Vs3h1utW0
	i/B1k5gFuieKY+Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740650131;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LOdsgIFAVerAWy3OtSx5FWccrs6CMcIqn4P0NNUBoi8=;
	b=KQrmIAxgngvbbcOScDz25Mu7gYAdQ8QmTn9fMg7Ml+pA338atBTenmIkUlkJs2kah56JiN
	hCZBQBr5nx/4Vt9eYr46OsrqRuKtP+bsiWCh17rowjy26Scoj53C3lv3e+3eXbpuL3d+W+
	VgzbEmf17pUiuuaWiXkTnVgzRaoQ33c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740650131;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LOdsgIFAVerAWy3OtSx5FWccrs6CMcIqn4P0NNUBoi8=;
	b=uQbD26nDmlHkR5HVSf1Mgx2U5r3o1bg4nRw6cZscT167FEmYrHD/vOcNGIeB1Vs3h1utW0
	i/B1k5gFuieKY+Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A96AC1376A;
	Thu, 27 Feb 2025 09:55:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pc0RKZM2wGceHQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 27 Feb 2025 09:55:31 +0000
Date: Thu, 27 Feb 2025 10:55:22 +0100
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/27] Struct btrfs_path auto cleaning conversions
Message-ID: <20250227095522.GA5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1740562070.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740562070.git.dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Feb 26, 2025 at 10:50:40AM +0100, David Sterba wrote:
> We have the scoped freeing for struct btrfs_path but it's not used as
> much as it could. This patchset converts the easy cases and it's also a
> preview if we really want to do that. It makes understanding the exit
> paths a bit less obvious, but so far I think it's manageable.
> 
> The path is used in many functions and following a few simple patterns,
> with the macro BTRFS_PATH_AUTO_FREE quite visible among the
> declarations, so it's nothing hard to be aware of that when reading the
> code.
> 
> The conversion has been done on half of the files, so if somebody wants
> to continue, feel free. I've skipped functions with more complicated
> branching where the auto freeing would make it worse.
> 
> David Sterba (27):
>   btrfs: use BTRFS_PATH_AUTO_FREE in sample_block_group_extent_item()
>   btrfs: use BTRFS_PATH_AUTO_FREE in insert_dev_extent()
>   btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_setup_space_cache()
>   btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_start_dirty_block_groups()
>   btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_write_dirty_block_groups()
>   btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_insert_item()
>   btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_commit_inode_delayed_items()
>   btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_init_dev_replace()
>   btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_run_dev_replace()
>   btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_check_dir_item_collision()
>   btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_read_tree_root()
>   btrfs: use BTRFS_PATH_AUTO_FREE in load_global_roots()
>   btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_init_root_free_objectid()
>   btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_get_name()
>   btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_lookup_data_extent()
>   btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_lookup_extent_info()
>   btrfs: use BTRFS_PATH_AUTO_FREE in __btrfs_inc_extent_ref()
>   btrfs: use BTRFS_PATH_AUTO_FREE in run_delayed_extent_op()
>   btrfs: use BTRFS_PATH_AUTO_FREE in check_ref_exists()
>   btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_drop_subtree()
>   btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_insert_hole_extent()
>   btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_lookup_bio_sums()
>   btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_del_csums()
>   btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_remove_free_space_inode()
>   btrfs: use BTRFS_PATH_AUTO_FREE in populate_free_space_tree()
>   btrfs: use BTRFS_PATH_AUTO_FREE in clear_free_space_tree()
>   btrfs: use BTRFS_PATH_AUTO_FREE in load_free_space_tree()

Daniel noted that the trivial patches are maybe too trivial and should
be grouped into fewer patches. I agree after looking at the series now,
so I'll rework it

