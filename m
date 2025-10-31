Return-Path: <linux-btrfs+bounces-18429-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF3AC22FA5
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 03:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0B6D4EEFE6
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 02:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7BF27702D;
	Fri, 31 Oct 2025 02:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L+gUeQ4p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PKrqk3wj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L+gUeQ4p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PKrqk3wj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A84274643
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 02:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761877366; cv=none; b=igD3zTvnUyv3FryeJkUL4eFti/DEHyvM58idV8HHNJ3yBninmSP6k36sFY7F7Yorw6pViW1aenFJHIqTKHlHpsm6Zpgzm9VAM1ljiBnFZoeqNej1IDhoYFzztFsVf5Xo0wqevwSTaCM5Rb2lloM78jYS/H6/iZOkPMaMHJY+OhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761877366; c=relaxed/simple;
	bh=bHsOlf7qIydtN72kxsF4rT5fn6daemX/TsZ3MB8Tg5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AainOKCBLxmRUGcYkC0vxX6eEvJ1nFzif27vWUSnFJghw9aJNZEKdOv4G8rGbe7etuO+Qi9HfU9sQSyVw3AGx1WfZOqmRPdTtGkhKPQv4vAl5Jx8+3TBIuyFE9jIymvdMIualrIMoBcRb3L6pr5oBqripOgdtkT0QtdYhmNUXTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L+gUeQ4p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PKrqk3wj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L+gUeQ4p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PKrqk3wj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AA90E1F6E6;
	Fri, 31 Oct 2025 02:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761877362;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43cEOJYw/wdVi981J29tNB+K+2NPTIjDRN8cGyySw1g=;
	b=L+gUeQ4pQFc7ZQ+FSh4uGm7/IvN9wJYLdf4O+pmYV4MpiN6uWocm51JKJz7iWswWnCAbts
	CIuXQl7byj4ONjO96Wzy8hqUQcf0A28+9Xa4N5hcCRlJLQm5zPuIXx43kfVx1TzqUCfyhV
	XstASkA66aOPL8n5WFTEdAIgnn9vvS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761877362;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43cEOJYw/wdVi981J29tNB+K+2NPTIjDRN8cGyySw1g=;
	b=PKrqk3wjWLIT4ZEfhqx3aN6JWH0LXM1Ptr78WYJ+uDDeA9EsH+VF0vc6Ez5qT2HUsBughL
	k9Kh/7YMTEu9WkDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761877362;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43cEOJYw/wdVi981J29tNB+K+2NPTIjDRN8cGyySw1g=;
	b=L+gUeQ4pQFc7ZQ+FSh4uGm7/IvN9wJYLdf4O+pmYV4MpiN6uWocm51JKJz7iWswWnCAbts
	CIuXQl7byj4ONjO96Wzy8hqUQcf0A28+9Xa4N5hcCRlJLQm5zPuIXx43kfVx1TzqUCfyhV
	XstASkA66aOPL8n5WFTEdAIgnn9vvS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761877362;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43cEOJYw/wdVi981J29tNB+K+2NPTIjDRN8cGyySw1g=;
	b=PKrqk3wjWLIT4ZEfhqx3aN6JWH0LXM1Ptr78WYJ+uDDeA9EsH+VF0vc6Ez5qT2HUsBughL
	k9Kh/7YMTEu9WkDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A6B6134B3;
	Fri, 31 Oct 2025 02:22:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qsivHXIdBGlFSgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 31 Oct 2025 02:22:42 +0000
Date: Fri, 31 Oct 2025 03:22:41 +0100
From: David Sterba <dsterba@suse.cz>
To: Miquel =?iso-8859-1?Q?Sabat=E9_Sol=E0?= <mssola@mssola.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com,
	johannes.thumshirn@wdc.com, fdmanana@suse.com, boris@bur.io,
	wqu@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] btrfs: define and apply the AUTO_K(V)FREE_PTR
 macros
Message-ID: <20251031022241.GE13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251024102143.236665-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251024102143.236665-1-mssola@mssola.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Fri, Oct 24, 2025 at 12:21:39PM +0200, Miquel Sabaté Solà wrote:
> Changes since v1:
>   - Remove the _PTR suffix
>   - Rename the ipath cleanup function to inode_fs_paths, so it's more
>     explicit on the type.
>   - Improve git message in patch 1.
> 
> This patchset introduces and applies throughout the btrfs tree two new
> macros: AUTO_KFREE and AUTO_KVFREE. Each macro defines a pointer,
> initializes it to NULL, and sets the kfree/kvfree cleanup attribute. It was
> suggested by David Sterba in the review of a patch that I submitted here
> [1].
> 
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
> 
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
> 
> [1] https://lore.kernel.org/all/20250922103442.GM5333@twin.jikos.cz/
> [2] https://lore.kernel.org/all/20250925184139.403156-1-mssola@mssola.com/
> [3] https://lore.kernel.org/all/20250930130452.297576-1-mssola@mssola.com/
> [4] https://lore.kernel.org/all/20251008121859.440161-1-mssola@mssola.com/
> 
> Miquel Sabaté Solà (4):
>   btrfs: declare free_ipath() via DEFINE_FREE()
>   btrfs: define the AUTO_K(V)FREE helper macros
>   btrfs: apply the AUTO_K(V)FREE macros throughout the tree
>   btrfs: add ASSERTs on prealloc in qgroup functions

Thanks, patches now added to for-next with some minor adjustments. Feel
free to send more conversions, there are still some kvfree candidate
calls. I think we would not mind using it even for the short functions
(re what's mentioned in the 3rd patch), so it's established as a common
coding pattern. This change has net negative effect on lines and also
simplifies the control flow.

