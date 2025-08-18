Return-Path: <linux-btrfs+bounces-16124-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076B7B2AC59
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 17:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30CE3BF551
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 15:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D7E2494C2;
	Mon, 18 Aug 2025 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ewRNr6Ib";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GoC15SoE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ewRNr6Ib";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GoC15SoE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EFC233133
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529714; cv=none; b=TMiKbOdXoalF6tJK68s/0T+A3w5uDGNYkmPkcDf/vwgxjXDEwU6gmqv70oy1siiC4bx4Z0cxLpOpsesYS5J0GV97EGvpzlP5vqaseJuia03M1/xWfta6HB4LPixIKRUvvhvN+yNoaPzPky1vdRYbRSAjhvdLWNMokdFOYefQVro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529714; c=relaxed/simple;
	bh=9Df7rYpFUHD/ddDNjJHVxJIR/9Zfhj2n0qYROM7hjxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvXwMsGpc7JmKJLHkxvAF2l+MvIlvaDF07rwelkC9YLXhf11PtxOQCgMbdaeed8lEzDzXFtBpk9X2TyoYLrzcoq8NSAk70knQk8ldOf13PmCObtH6SNZK3Oye4rHzF9hFAXTIHvN+RKDk+iRP17JIJrMZrF16qBpJrE2rOXRtCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ewRNr6Ib; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GoC15SoE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ewRNr6Ib; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GoC15SoE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 49FE92121E;
	Mon, 18 Aug 2025 15:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755529710;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Idiezhlv65tgV0KrnTOXST1gxZFp8BxaXOkvuR6IuuU=;
	b=ewRNr6IbCaEkLa1TrGMblO11Hs1EkgweKiF/qCakCp9IQEsqPg0YchcIBWNW5lEIzlzKKs
	a0Q3fhqsddfu+eXz1a9+qdAcTq/6ONhy4K6FJyO8MXiImyXAwv2qt+eGtxeuLWobIVI+Dp
	KtIdnQwFcDeD2We2awti3m6DiMh1glI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755529710;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Idiezhlv65tgV0KrnTOXST1gxZFp8BxaXOkvuR6IuuU=;
	b=GoC15SoEip1cBCcnSwVE0qZZG2WRa5aN4xwZ3hQbsVoleWkpSIaGHSMVqL+mzSOs+BC2Yk
	VydpvGM6cqWMHWAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755529710;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Idiezhlv65tgV0KrnTOXST1gxZFp8BxaXOkvuR6IuuU=;
	b=ewRNr6IbCaEkLa1TrGMblO11Hs1EkgweKiF/qCakCp9IQEsqPg0YchcIBWNW5lEIzlzKKs
	a0Q3fhqsddfu+eXz1a9+qdAcTq/6ONhy4K6FJyO8MXiImyXAwv2qt+eGtxeuLWobIVI+Dp
	KtIdnQwFcDeD2We2awti3m6DiMh1glI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755529710;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Idiezhlv65tgV0KrnTOXST1gxZFp8BxaXOkvuR6IuuU=;
	b=GoC15SoEip1cBCcnSwVE0qZZG2WRa5aN4xwZ3hQbsVoleWkpSIaGHSMVqL+mzSOs+BC2Yk
	VydpvGM6cqWMHWAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A23113A97;
	Mon, 18 Aug 2025 15:08:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eRAEDu5Bo2hzKwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 18 Aug 2025 15:08:30 +0000
Date: Mon, 18 Aug 2025 17:08:29 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/7] btrfs: add workspace manager initialization for zstd
Message-ID: <20250818150829.GL22430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1755148754.git.wqu@suse.com>
 <db54546adb1bb51b2b9d1841520dbf9dc64adbed.1755148754.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db54546adb1bb51b2b9d1841520dbf9dc64adbed.1755148754.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Thu, Aug 14, 2025 at 03:03:21PM +0930, Qu Wenruo wrote:
> This involves:
> 
> - Add zstd_alloc_workspace_manager() and zstd_free_workspace_manager()
>   Those two functions will accept an fs_info pointer, and alloc/free
>   fs_info->compr_wsm[BTRFS_COMPRESS_ZSTD] pointer.
> 
> - Add btrfs_alloc_compress_wsm() and btrfs_free_compress_wsm()
>   Those are helpers allocating the workspace managers for all
>   algorithms.
>   For now only zstd is supported, and the timing is a little unusual,
>   the btrfs_alloc_compress_wsm() should only be called after the
>   sectorsize being initialized.
> 
>   Meanwhile btrfs_free_fs_info_compress() is called in
>   btrfs_free_fs_info().
> 
> - Move the definition of btrfs_compression_type to "fs.h"
>   The reason is that "compression.h" has already included "fs.h", thus
>   we can not just include "compression.h" to get the definition of
>   BTRFS_NR_COMPRESS_TYPES to define fs_info::compr_wsm[].

This is a bit unfortunate, I'd like to keep the subystems in their own
files but we'd have to add another kind of indirection to resolve that.
Either a new header or another structure for the compression types that
is not embedded in fs_info. But the type definitions are short and used
in a lot of code anyway so no big deal.

