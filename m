Return-Path: <linux-btrfs+bounces-18152-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D057BFA85B
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 09:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48EB74F24EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 07:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7824D2F7AC8;
	Wed, 22 Oct 2025 07:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rvSZlrmE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tXSOaS5R";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w9LrwRjN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lgF/5+4I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2258E2F6192
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Oct 2025 07:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761117788; cv=none; b=DbQM5CnW7P3sOx8gxW0PnRJPOU7G8KRcaPX5ULCMEd2r+qj7n4CMhXhAYkNFmxEnqCsbNcUpaC+ncvgEpSSoHthRdf8Q34lK0ib9uBWH7gHL3ymQoo5MtUwPsh6snxntJYeDPlqC204r+zwPN/OAZSGfnHlU0ZF9+Fan7Ph35qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761117788; c=relaxed/simple;
	bh=a9rFZGd+fa9swtXk/jttafqVx4kTKWoduThV6TVeUnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLNMMWNgy9Lii4fFn6YRaMwTw5AcrH1Iv1l48RG5yzroWqkjoTVHVmBiQ9q4hjgblmkVmrcZBFh5Jd5c2HtYnQXXkQ+FeXBHjiGciH+DNo0gzqblW829OHBnFSEj+C7RJkGJVpLrIJlEW697eDip/nOU9PccgSxp5OKcdQ/DBBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rvSZlrmE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tXSOaS5R; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w9LrwRjN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lgF/5+4I; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 384CF1F38D;
	Wed, 22 Oct 2025 07:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761117781;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9b3IuyBqKgW7YTIozv8P7GyOcqJTm68+eRJdhQMbOE=;
	b=rvSZlrmE/ckE8UOQ0jM6smrmxOEq+MEYXaczsBnmYHJaxRPHVWw3OwGmA2M01hn9kTnq+j
	hOLQ0j82ll6RGlWO9hwm73Pdgz0T2lEs6rgBB9VG7tNGTxgJCP/glCladMem7aLywmjuNL
	hMZLLO9jAFP5NyYFNTQ+F2Jj6v2Jgvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761117781;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9b3IuyBqKgW7YTIozv8P7GyOcqJTm68+eRJdhQMbOE=;
	b=tXSOaS5RCgX3pKOmyEwyrJaG3UzaKAnULIOG5mS4e4oEs4UcRXusnuEJLhBNp0YvPGHJwX
	a5Zhj2sYjFMdpLCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761117777;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9b3IuyBqKgW7YTIozv8P7GyOcqJTm68+eRJdhQMbOE=;
	b=w9LrwRjNfQCnnDaA/xEmuYELHdRBkGjjmPr+biNsJleMMP/bXvIMK+5fOH3NAu5+paGX71
	X+SgsWbGguzbWzbRuO+jvjw8rd8BC3KwZ+G0ENs8UnTUsmlc/Hg+dtTDhgGesI4Od1MXrF
	XAGR3yX6/U39orG/WbzGtL8Q5gkycvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761117777;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9b3IuyBqKgW7YTIozv8P7GyOcqJTm68+eRJdhQMbOE=;
	b=lgF/5+4I9cK2J09XH3n6PcUGmnN+Yo6QidyyR3Blvjqm9giQFI+VjTVNNdC18RCuDcN9tq
	yZOGm7lelG8kN1Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13ED61339F;
	Wed, 22 Oct 2025 07:22:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u2m1BFGG+GipDgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 22 Oct 2025 07:22:57 +0000
Date: Wed, 22 Oct 2025 09:22:40 +0200
From: David Sterba <dsterba@suse.cz>
To: Miquel =?iso-8859-1?Q?Sabat=E9_Sol=E0?= <mssola@mssola.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com,
	johannes.thumshirn@wdc.com, fdmanana@suse.com, boris@bur.io,
	wqu@suse.com, neal@gompa.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: define and apply the AUTO_K(V)FREE_PTR macros
Message-ID: <20251022072240.GW13776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251021142749.642956-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251021142749.642956-1-mssola@mssola.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,suse.cz:replyto];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Tue, Oct 21, 2025 at 04:27:45PM +0200, Miquel Sabaté Solà wrote:
> This patchset introduces and applies throughout the btrfs tree two new
> macros: AUTO_KFREE_PTR and AUTO_KVFREE_PTR. Each macro defines a pointer,
> initializes it to NULL, and sets the kfree/kvfree cleanup attribute. It was
> suggested by David Sterba in the review of a patch that I submitted here
> [1]. I have added the _PTR suffix because I think that it reads more easily
> and it makes things more explicit, but I don't have any strong feelings
> about the naming either.

I'd rather drop the _PTR part as it's not bringing new information
(kfree takes a pointer) and it makes the lines longer.

> I have not applied these macros blindly through the tree, but only when
> using a cleanup attribute actually made things easier for
> maintainers/developers, and didn't obfuscate things like lifetimes of
> objects on a given function. So, I've mostly avoided applying this when:
> 
> - The object was being re-allocated in the middle of the function
>   (e.g. object re-allocation in a loop).
> - The ownership of the object was transferred between functions.
> - The value of a given object might depend on functions returning ERR_PTR()
>   et al.
> - The cleanup section of a function was a bunch of labels with different
>   exit paths with non-trivial cleanup code (or code that depended on things
>   to go on a specific order).

This looks reasonable, some of them may be relaxed eventually.

> To come up with this patchset I have glanced through the tree in order to
> find where and how kfree()/kvfree() were being used, and while doing so I
> have submitted [2], [3] and [4] separately as they were fixing memory
> related issues. All in all, this patchset can be divided in three parts:
> 
> 1. Patch 1: transforms free_ipath() to be defined via DEFINE_FREE(), which
>    will be useful in order to further simplify some code in patch 3.
> 2. Patch 2 and 3: define and use the two macros.
> 3. Patch 4: removing some unneeded kfree() calls from qgroup.c as they were
>    not needed. Since these occurrences weren't memory bugs, and it was a
>    somewhat simple patch, I've refrained from sending this separately as I
>    did in [2], [3] and [4]; but I'll gladly do it if you think it's better
>    for the review.
> 
> Note that after these changes some 'return' statements could be made more
> explicit, and I've also written an explicit 'return 0' whenever it would
> make more explicit the "happy" path for a given branch, or whenever a 'ret'
> variable could be avoided that way.
> 
> Last, checkpatch.pl script doesn't seem to like patches 2 and 3; but so far
> it looks like false positives to me. But of course I might just be wrong :)

We take checkpatch as a recommendation but still a good base line, the
local btrfs coding style may diverge and is fixed manually at commit
time.

