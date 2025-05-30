Return-Path: <linux-btrfs+bounces-14312-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F2CAC8D08
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 13:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A271BA063A
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 11:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9093E226193;
	Fri, 30 May 2025 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JlfyPnCI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kSIexFGV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JlfyPnCI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kSIexFGV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31795433D1
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748605029; cv=none; b=vFlWcMgTLTEGgZtGt0FsdNbgv0DFNKp4ivkv6/NeKfIDvwBbSE0Bab1orNgMBNJifCPsESEv9SsoHgtmocrEkQyVEFjLPGmVViYlcVKMhw42u026KWMa7Mavyym7GEke0Ye1ooTEYOpa5ck16AGpPPVCpVR6eXdKuvma6JSDD7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748605029; c=relaxed/simple;
	bh=nKcfbpwxVwyyMY5so3XZeTVpjfzJoZgmcqaGxeY4SII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4BRspYhuPqxX2cZ0G8ykxuQql7ZUoU5j2MCPET7JTXQU0J1pZU195FK35vg/IMIHovndeuc0u/h8EgcPU/6FcL44oeRWSHOLiHN+uxlGV1XgnUXbyRVRurEgOQv6gD4SofxdxfpQgSn4BjloE5bXR1AW1w1kxJ+9m/O+IkqPxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JlfyPnCI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kSIexFGV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JlfyPnCI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kSIexFGV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 64F3821A4E;
	Fri, 30 May 2025 11:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748605026;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mLSg+boR/c3rwL1TijuZEcOVjF4HlX4L7YB258o+To8=;
	b=JlfyPnCIf/RDTYiw4INiJ2uGCzrTd6dn0M6s+XkeJg2vpQe+bKT77EYVQYK47KG9puq5xE
	laJ3Uc8HxgEJvsz8jDn1PHK5VjCyNaaoe6YMksxXySH4eOeXzUs/9cs1OadWNpewTmK6ec
	pfiMb1CRlBKCJRGTA4JdJ3HOyEQ18uk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748605026;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mLSg+boR/c3rwL1TijuZEcOVjF4HlX4L7YB258o+To8=;
	b=kSIexFGVMK7pwzvV3ojAFt+U/BhuDd4TuSNlAmO6TntdsChdLKWWz+PABx5pC+6uv4qZ/f
	DaPJmUfoogKNYFCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748605026;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mLSg+boR/c3rwL1TijuZEcOVjF4HlX4L7YB258o+To8=;
	b=JlfyPnCIf/RDTYiw4INiJ2uGCzrTd6dn0M6s+XkeJg2vpQe+bKT77EYVQYK47KG9puq5xE
	laJ3Uc8HxgEJvsz8jDn1PHK5VjCyNaaoe6YMksxXySH4eOeXzUs/9cs1OadWNpewTmK6ec
	pfiMb1CRlBKCJRGTA4JdJ3HOyEQ18uk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748605026;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mLSg+boR/c3rwL1TijuZEcOVjF4HlX4L7YB258o+To8=;
	b=kSIexFGVMK7pwzvV3ojAFt+U/BhuDd4TuSNlAmO6TntdsChdLKWWz+PABx5pC+6uv4qZ/f
	DaPJmUfoogKNYFCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4755A132D8;
	Fri, 30 May 2025 11:37:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XFfgEGKYOWjZFwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 30 May 2025 11:37:06 +0000
Date: Fri, 30 May 2025 13:37:01 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: fix an old bug in lowmem mode
Message-ID: <20250530113700.GW4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1748503407.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748503407.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Thu, May 29, 2025 at 04:58:18PM +0930, Qu Wenruo wrote:
> Inspired by Mark's recent enhanced super block dev item check against
> chunk tree device item, it turns out there are several existing images
> not passing the check.
> 
> One of the check is fsck/020/keyed_data_ref_with_reloc_leaf.img, which
> may be caused by some older kernels (the bug is already fixed a long
> time ago).
> 
> The first patch is to fix a lowmem mode check bug, that it doesn't
> correctly account the keyed backref with shared backref.
> 
> This is exposed by the image from the next patch.
> 
> Then the last patch is to update the image with a proper note on how to
> re-create it.
> And the new image also acts as a regression test for the above lowmem
> bug.
> 
> Please note this is not the last fsck image which has such problem,
> fsck/057 is another one, and will be addressed in a dedicated patch.
> 
> Qu Wenruo (2):
>   btrfs-progs: check/lowmem: fix a false alert when counting the refs
>   btrfs-progs: fsck-tests: fix an image which has incorrect super dev
>     item

Added to devel, thanks.

