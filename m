Return-Path: <linux-btrfs+bounces-7176-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7C9950F24
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 23:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668372839D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 21:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D661A76D5;
	Tue, 13 Aug 2024 21:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wxRaKbQw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BC6g0/FV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wxRaKbQw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BC6g0/FV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A721D1EA84
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2024 21:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723584552; cv=none; b=g2r0p6Msbl+JJnQ4J+ygjZ/oGR97PUGpYYQ4vm+oL3AAq6EFxiEmrYftqI1WpEV3DVTIa90udgLy3wUzl0ubJo+kBFTBOWukol3mZKednlN0gT9gxbu8zYufLD7V0gp8TyWJJZ623MAkNK0VsaB1vHqWh2y7Ks1ZUCHp7zZYSRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723584552; c=relaxed/simple;
	bh=FpF8UHd5EAL+FLDenDudhTIRhxD36dvwWnDONLGe6W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONxHYUWeNVLCPTnwPNgkuFilqUcOttsm4F4d/R3+isUiIofZomjXABrstscFCbNgEeJZ7pJzX0n9GQ8Pgz812uOHdNg5jicUPYmBC+CynUBf+E+yrG2aYIw7DuTMpIA6vUW4oKBheeTCjDw+IL4tVbHV+i9+uDlQYFTlWclbuF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wxRaKbQw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BC6g0/FV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wxRaKbQw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BC6g0/FV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B36B5223CD;
	Tue, 13 Aug 2024 21:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723584548;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9e3WdjJkNbxgbir3tB+LGXzEYsfOzrWioIvHo2j1EJ4=;
	b=wxRaKbQw14+9Q+I/oESxZWDkI2uFp2Vr4OXu5DIXZF49kxL9+63OFuBf/QlBLy+f3RU1zg
	81nYFyl08HtKrhZEFn3LbOdyTVY4b2oePxIgpf/jkKmoeZ1pEu+ghUQ3RnEJHaMvmYpyKY
	jqV+ti8twdhT1Vvuas6vdKcaMJK8t8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723584548;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9e3WdjJkNbxgbir3tB+LGXzEYsfOzrWioIvHo2j1EJ4=;
	b=BC6g0/FVcZuL2qrRWeZSXr7XuQHERhKfkRZTDhXi9DvQBAJ95lXPJYswWcBp9my1gjSX9N
	o1LzOZW5QrbbaQBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723584548;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9e3WdjJkNbxgbir3tB+LGXzEYsfOzrWioIvHo2j1EJ4=;
	b=wxRaKbQw14+9Q+I/oESxZWDkI2uFp2Vr4OXu5DIXZF49kxL9+63OFuBf/QlBLy+f3RU1zg
	81nYFyl08HtKrhZEFn3LbOdyTVY4b2oePxIgpf/jkKmoeZ1pEu+ghUQ3RnEJHaMvmYpyKY
	jqV+ti8twdhT1Vvuas6vdKcaMJK8t8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723584548;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9e3WdjJkNbxgbir3tB+LGXzEYsfOzrWioIvHo2j1EJ4=;
	b=BC6g0/FVcZuL2qrRWeZSXr7XuQHERhKfkRZTDhXi9DvQBAJ95lXPJYswWcBp9my1gjSX9N
	o1LzOZW5QrbbaQBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9985313983;
	Tue, 13 Aug 2024 21:29:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5vkIJSTQu2Y+GAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 13 Aug 2024 21:29:08 +0000
Date: Tue, 13 Aug 2024 23:29:03 +0200
From: David Sterba <dsterba@suse.cz>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/2] btrfs: add __free attribute and improve xattr cleanup
Message-ID: <20240813212903.GS25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1723245033.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723245033.git.loemra.dev@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Aug 09, 2024 at 04:11:47PM -0700, Leo Martins wrote:
> The first patch introduces the __free attribute to the btrfs code, allowing
> for automatic memory management of certain variables. This attribute enables
> the kernel to automatically call a specified function (in this case,
> btrfs_free_path()) on a variable when it goes out of scope, ensuring proper
> memory release and preventing potential memory leaks.
> 
> The second patch applies the __free attribute to the path variable in the
> btrfs_getxattr(), btrfs_setxattr(), and btrfs_listxattr() functions, ensuring
> that the memory allocated for this variable is properly released when it goes
> out of scope. This improves the memory management of xattr operations in
> btrfs, reducing the risk of memory-related bugs and improving overall system
> stability.
> 
> As a next step, I want to extend the use of the __free attribute to other
> instances where btrfs_free_path is being manually called.

Hold on. Adding the automatic memory management can be done but in the
example patches you sent it's IMHO making things worse on the code
level.

The btrfs_free_path (or btrfs_release_path for that matter) are not
simple free helpers but also part of the b-tree locking primitives,
pairing with btrfs_search_slot and nontrivial semantics depending on the
various setting flags.

Dropping the explicit marker from the code is obscuring where the
locked section is.

Another problem is that this will make any backports less obviously
correct from releases that use the __free attribue to older kernels.

In the second patch in btrfs_setxattr() you removed btrfs_free_path()
but there's still some code after that. In this case it's harmless and
only slightly extending the section covered by path, ie. just by a few
instructions, but this won't be always possible.

In some cases the placement of freeing the path unlocks the tree so it
has a strong reason to be there.

Overall, we could the automatic memory management, although for kernel,
for me, it's on the same level as trying to use other fancy C++
features. We could start using __free in new structures so it's used
consistently from the beginning and not mixing two styles namely when
not all instances of btrfs_path can use it.

In justified cases the auto freeing may make sense but not at the cost
of making the code confusing about the pairing free or extending the
locked section unnecessarily. The btrfs_path is not a good example where
to start with that.

