Return-Path: <linux-btrfs+bounces-2387-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F6F8551DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 19:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C051C28CC4
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 18:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E50129A82;
	Wed, 14 Feb 2024 18:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kZKthVG1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tnNEZuCU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kZKthVG1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tnNEZuCU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B238527F
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 18:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934341; cv=none; b=CXOE/8Fu/hXii3FHImwkMTtHJReshRnrdQY7GNSBXDMBp6XM10nsYbKuFsdVleuPE0bghtyDnyyzO3Adm3oiADk5KQMijg2nC6DogzER4xI1Oy9HLtTbb9tWPCdq3CYLrLkpcX/3Lh1eJIF4M/Cq2NpV5dkLF8fI7a97tK91Q90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934341; c=relaxed/simple;
	bh=tpmAAJ6RM2quuEt4xCnQLaefmyFyYookWXq2Nt/8WPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rb75X4cnb2fSfjLLsj5w67RWI9sRYBcvNi4hEKldSROmlqyMsDahyUlph04PL5s9coJXsf5VGPxcRhtpwYCxrKHL3cWdPTYWHh5GTmEJVg57/DiHfwLImjDn0Rl7jE3qJ3KCrBXVY+74uObzQWIu8AgL639//QJWhdpRJyvdFSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kZKthVG1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tnNEZuCU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kZKthVG1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tnNEZuCU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BA8511F815;
	Wed, 14 Feb 2024 18:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707934337;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NDZ2wFy5NX9E582XA/Z2VjQaMVtMmtTxVvm/ndSuIyI=;
	b=kZKthVG1nFp3ZN/Psa7C9JPA6RR/PttpTkVq2BUJCnVv8JLNbD0vr4ytfvmWgq9rb5hR2D
	sfdOx0FNs0c8lPQPpi5yUByHqYJiqqcQ7XcBnEhwD3rjM0Y3ObLemfBi5MbVT7eHnkBTR5
	ANOpF/Hrqh8yh7C4w4+25R3HReyty50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707934337;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NDZ2wFy5NX9E582XA/Z2VjQaMVtMmtTxVvm/ndSuIyI=;
	b=tnNEZuCUhIGMkCblgRuOpA6SLDYKjskmvXeytY/9W+G5e17+0/x0+jAUarKNKgrws61hs7
	zNPUTAWZpwx9+BAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707934337;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NDZ2wFy5NX9E582XA/Z2VjQaMVtMmtTxVvm/ndSuIyI=;
	b=kZKthVG1nFp3ZN/Psa7C9JPA6RR/PttpTkVq2BUJCnVv8JLNbD0vr4ytfvmWgq9rb5hR2D
	sfdOx0FNs0c8lPQPpi5yUByHqYJiqqcQ7XcBnEhwD3rjM0Y3ObLemfBi5MbVT7eHnkBTR5
	ANOpF/Hrqh8yh7C4w4+25R3HReyty50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707934337;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NDZ2wFy5NX9E582XA/Z2VjQaMVtMmtTxVvm/ndSuIyI=;
	b=tnNEZuCUhIGMkCblgRuOpA6SLDYKjskmvXeytY/9W+G5e17+0/x0+jAUarKNKgrws61hs7
	zNPUTAWZpwx9+BAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A6C8D13A35;
	Wed, 14 Feb 2024 18:12:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 2DhKKIECzWUkQQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 14 Feb 2024 18:12:17 +0000
Date: Wed, 14 Feb 2024 19:11:39 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Naohiro Aota <naohiro.aota@wdc.com>, HAN Yuwei <hrx@bupt.moe>
Subject: Re: [PATCH] btrfs: zoned: don't skip block group profile checks on
 conv zones
Message-ID: <20240214181139.GS355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0cd08a6b0f5285498811504d3713ced3afe3b8d2.1707812175.git.johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cd08a6b0f5285498811504d3713ced3afe3b8d2.1707812175.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.00
X-Spamd-Result: default: False [-1.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,suse.cz,gmx.com,wdc.com,bupt.moe];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[42.71%]
X-Spam-Flag: NO

On Tue, Feb 13, 2024 at 12:16:15AM -0800, Johannes Thumshirn wrote:
> On a zoned filesystem with conventional zones, we're skipping the block
> group profile checks for the conventional zones.
> 
> This allows converting a zoned filesystem's data block groups to RAID when
> all of the zones backing the chunk are on conventional zones.  But this
> will lead to problems, once we're trying to allocate chunks backed by
> sequential zones.
> 
> So also check for conventional zones when loading a block group's profile
> on them.
> 
> Reported-by: HAN Yuwei <hrx@bupt.moe>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: David Sterba <dsterba@suse.com>

Please add link to the report (as Link: tag), I think it is interesting
how the root cause was discovered.

