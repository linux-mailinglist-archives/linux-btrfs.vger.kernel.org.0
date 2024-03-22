Return-Path: <linux-btrfs+bounces-3515-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 397358873EC
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Mar 2024 20:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33A41F23CEE
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Mar 2024 19:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A147A151;
	Fri, 22 Mar 2024 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i4hlgaZA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Bi2Dc4s";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i4hlgaZA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Bi2Dc4s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DC27A13F;
	Fri, 22 Mar 2024 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711135770; cv=none; b=X7U1g+51ZkUUmmhMWDhA/ClI5cTvK1Ncyrc1g2LYnGib+Coe5XZYf7bhfSUAAWksXvgtGRXCKkukWld6BNuY8eOu4jFts2u3z8Dnm3IdjGHGbzo6I6oF0ZJ0GrurZkQ6LB+w3Laaky3rEpJ0oKCgD3wA2QCy/XmhPYokTt4rEW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711135770; c=relaxed/simple;
	bh=oklDj6U5/LTJT3ihNDzab3Tqa5Dr3WbJv3X1jhT5abE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goti0jz//0ZCZmJOUmk8aEBTIRt7fCUbZ8SfrcHmFH+w2jvKfZyWFjveOmFtVkZ0Ok3dpMp3JD3/8tQ2ktRnP9N1bh64QZ6w7W346RGNqnhFpU+DMJKpr+tp/IYx87SuTWElmOnWUmc0fZaj0sWHORICibB57b3o0u0g1Gimk/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i4hlgaZA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Bi2Dc4s; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i4hlgaZA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Bi2Dc4s; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BC32038920;
	Fri, 22 Mar 2024 19:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711135766;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WDBYbPR6/NMtSTPqLqOpeS79MMzIcadeQ6TPNXM4lkA=;
	b=i4hlgaZADy29ECHg1y7N46TpVjCijRYj9F5ZxBAMYW+0MU+quSaZn7toW8+tNmFpkuT0EM
	9DlykmGgRFLODK1mU5/hPwEG+ea3RRGjE4zDjRBTVMUWsdz/YENUtyOajYpONb4PcdldDQ
	zb4gIWP50LFWXO24VFrOKbfGRVItRVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711135766;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WDBYbPR6/NMtSTPqLqOpeS79MMzIcadeQ6TPNXM4lkA=;
	b=1Bi2Dc4sYrRxsc1KjhNBShVRFCAQOG3spXNE+k1n93NLNrva8pbuGWZQhSDtdsKc8GQ2cF
	t6L6qNrOytrafoBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711135766;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WDBYbPR6/NMtSTPqLqOpeS79MMzIcadeQ6TPNXM4lkA=;
	b=i4hlgaZADy29ECHg1y7N46TpVjCijRYj9F5ZxBAMYW+0MU+quSaZn7toW8+tNmFpkuT0EM
	9DlykmGgRFLODK1mU5/hPwEG+ea3RRGjE4zDjRBTVMUWsdz/YENUtyOajYpONb4PcdldDQ
	zb4gIWP50LFWXO24VFrOKbfGRVItRVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711135766;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WDBYbPR6/NMtSTPqLqOpeS79MMzIcadeQ6TPNXM4lkA=;
	b=1Bi2Dc4sYrRxsc1KjhNBShVRFCAQOG3spXNE+k1n93NLNrva8pbuGWZQhSDtdsKc8GQ2cF
	t6L6qNrOytrafoBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AB521138E8;
	Fri, 22 Mar 2024 19:29:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 7malKRbc/WWlKwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 22 Mar 2024 19:29:26 +0000
Date: Fri, 22 Mar 2024 20:22:11 +0100
From: David Sterba <dsterba@suse.cz>
To: Tavian Barnes <tavianator@tavianator.com>
Cc: linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] extent_buffer read cleanups
Message-ID: <20240322192211.GL14596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1710769876.git.tavianator@tavianator.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710769876.git.tavianator@tavianator.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -2.50
X-Spamd-Result: default: False [-2.50 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-0.998];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.972];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.50)[91.73%]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

On Mon, Mar 18, 2024 at 09:56:52AM -0400, Tavian Barnes wrote:
> This small series refactors some duplicated code introduced by a recent
> bugfix (which was intentionally duplicated to make stable backports
> easier), and adds a WARN_ON() to make it easier to debug similar issues
> in the future.
> 
> Link: https://lore.kernel.org/linux-btrfs/20240317203508.GA5975@lst.de/T/
> 
> Tavian Barnes (2):
>   btrfs: New helper to clear EXTENT_BUFFER_READING
>   btrfs: WARN if EXTENT_BUFFER_UPTODATE is set while reading

Thanks, patches added to for-next.

