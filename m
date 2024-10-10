Return-Path: <linux-btrfs+bounces-8779-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F84C99855C
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 13:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B7D1F2282A
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 11:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C6E1C3F0F;
	Thu, 10 Oct 2024 11:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GdeeXvJu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b1S8niPx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cj9uBe/h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7nhUVg//"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64BA1BE23D;
	Thu, 10 Oct 2024 11:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728561217; cv=none; b=PmSf4nMWxjetdwWxmdeYmAidVsf3Yfy5hcA7+c+rNpezG4c8FiRxBoSfmb4ddm4o9f3wpJ275njeYM88N6vz+Rj0dqtJ8JiXcUSIQaREREPfVgONA+cJMIOrrfLaUcUSSttSLkh7iqMf884h/q0mqKn+pVKMRGcR+4JeiJevgiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728561217; c=relaxed/simple;
	bh=c2PBpEQaVCGGjvXlitYnnCFLAIoKMZaBYiJP2MkUj4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jb1sIe9cwNiMXVx7tKd54cUrl/r8+KanItpYhP0LvMk+7+ldBPjgbddi9E4lvKkDuawM1EIalweWY5R3B7mFegw9WdDjiwuG5Mskm8aLzfuEgKkV1LmuvJfYSnwICm4wcQa6XsDrAGtsgmK7dP+BFifc3OHtCfR2+tc7vqghQi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GdeeXvJu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b1S8niPx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cj9uBe/h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7nhUVg//; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CCAF421E30;
	Thu, 10 Oct 2024 11:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728561214;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5yYMuPFjh4KdzM3a/JrcSVg/IEXWiTpTxB74qAXsmFc=;
	b=GdeeXvJuqjRpcr2Wa1y2h0wIy06cpzIfvzphPz0Wwg3CbBumPPIU68T+OeEJGaDv2s6yF8
	ny9hlhRtnVyEjQbIbXj+R4q+8vIPUKCUkcN7TpM/FQF+9bnAoYTuR0ttjIyH/B75l6s5AF
	4R5rFHctgCf7w2mekst9oiMhaDy7tOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728561214;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5yYMuPFjh4KdzM3a/JrcSVg/IEXWiTpTxB74qAXsmFc=;
	b=b1S8niPxEKwEfZtipHeoVUJQQ9CFNEZk8PBUTLpv9gyqJCI/h/YL8lVztMd+K0wUzSLBpy
	3pDQ8tXXqBpRnPBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728561213;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5yYMuPFjh4KdzM3a/JrcSVg/IEXWiTpTxB74qAXsmFc=;
	b=cj9uBe/hQ8K5UG3oux0iZ5G/oDD4OPzqGZR9SBoePybzN4HYkGNT4+P0/Kko9xjAV4gjmb
	uZS4YPzGD7M313pJzrUh9L0UexcIXKjFmVix5zRJ4KMC+T2UFTAWw/QlMQpvHJX4iamAFv
	ZvzLw5U2wXbufkeiDqBe2vvMzT721Os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728561213;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5yYMuPFjh4KdzM3a/JrcSVg/IEXWiTpTxB74qAXsmFc=;
	b=7nhUVg//tfju0/sLCVbSrztu4ZWBZw4QcKdmfzYLX5hKvLEnCNUfZrKufNJQtS1XNLdcOQ
	IoxDv/lAu8UhkrDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB0D913A6E;
	Thu, 10 Oct 2024 11:53:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5/iKKT3AB2eGNQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 10 Oct 2024 11:53:33 +0000
Date: Thu, 10 Oct 2024 13:53:28 +0200
From: David Sterba <dsterba@suse.cz>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: fs/btrfs/send.c:6877:5-8: Unneeded variable: "ret". Return "0"
 on line 6883
Message-ID: <20241010115328.GP1609@suse.cz>
Reply-To: dsterba@suse.cz
References: <202410092305.WbyqspH8-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202410092305.WbyqspH8-lkp@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Thu, Oct 10, 2024 at 12:04:53AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   75b607fab38d149f232f01eae5e6392b394dd659
> commit: 38622010a6de3a62cc72688348548854ed82dcf5 btrfs: send: add support for fs-verity
> date:   2 years ago
> config: i386-randconfig-052-20241009 (https://download.01.org/0day-ci/archive/20241009/202410092305.WbyqspH8-lkp@intel.com/config)
> compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410092305.WbyqspH8-lkp@intel.com/
> 
> cocci warnings: (new ones prefixed by >>)
> >> fs/btrfs/send.c:6877:5-8: Unneeded variable: "ret". Return "0" on line 6883
> 
> vim +6877 fs/btrfs/send.c
> 
>   6874	
>   6875	static int changed_verity(struct send_ctx *sctx, enum btrfs_compare_tree_result result)
>   6876	{
> > 6877		int ret = 0;
>   6878	
>   6879		if (!sctx->cur_inode_new_gen && !sctx->cur_inode_deleted) {
>   6880			if (result == BTRFS_COMPARE_TREE_NEW)
>   6881				sctx->cur_inode_needs_verity = true;
>   6882		}
> > 6883		return ret;

Trivial fix if somebody wants to take it. All changed_ callbacks must
return a value but here the verity status is passed via the context so
this should be 'return 0'.

