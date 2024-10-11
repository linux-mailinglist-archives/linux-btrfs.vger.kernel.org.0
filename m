Return-Path: <linux-btrfs+bounces-8858-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FE799A868
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 17:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D109B1F255EB
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 15:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AD5198851;
	Fri, 11 Oct 2024 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Sb08LRDm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ibnSY5JN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Sb08LRDm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ibnSY5JN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1E4194A74
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728662096; cv=none; b=K0Rf0eWF2njf50I74PtK+qhrh8FDyBQwHas5iv69EafC6EM7jI76ubK1WOM0BFb5EMok6nqDziEH/BdZmmtctKupQ74IvuNCxdWHRyY3TMxxK/xh3hkaYC/qQew0xhYwrywsG0u5MwhueoTwa7o9lUdJe5Oe/PJFINKLQsin4r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728662096; c=relaxed/simple;
	bh=Lm+eTPFvJEIxyZmymP5u1zzoxfh53QhoXC7SgHxoUQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcVa2EkK7Ue7/QUGQ9oFaDnAy7j8GJ+Lr24dxd6vk4pLRc3reKdRw5t1mByhpyVXfaewhYiVcfUHUt6mIoDUh746mQAdIQxHiNdXu1S8PW/N7QU2+a0Rr0uaNnp57zMDDzKzvunMLeJQvuyq1y6vkJgqHKxd/KW3buAdUuWG/vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Sb08LRDm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ibnSY5JN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Sb08LRDm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ibnSY5JN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 08C3D21EEA;
	Fri, 11 Oct 2024 15:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728662093;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/KlWPmZXxoa0WqjC0cA6cevcHquTyGLcClB1ekR3EWc=;
	b=Sb08LRDmjtGAMuWV8I1Eiwm+/zEShUwi7QMurKZxNRRLBd+897NcheH7MjnTlwPr1iAKvW
	KF3gQEKS8uYVaKWq4fwfecc44ZWNqB4c/Z8TwRpUpCPZEVytjxbTsQA9+9pivJjznF9/y2
	C+EhEx6Hg7A2mJbIHxNO/AIMJxYoNFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728662093;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/KlWPmZXxoa0WqjC0cA6cevcHquTyGLcClB1ekR3EWc=;
	b=ibnSY5JNTPJnpJCp5d6Z3W7WdQ91VhLK8uvU0XR012r67/wQllDoV6sfWSbkXJ1nx7UmuU
	ZvZ7H5ZSxX8QJEDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728662093;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/KlWPmZXxoa0WqjC0cA6cevcHquTyGLcClB1ekR3EWc=;
	b=Sb08LRDmjtGAMuWV8I1Eiwm+/zEShUwi7QMurKZxNRRLBd+897NcheH7MjnTlwPr1iAKvW
	KF3gQEKS8uYVaKWq4fwfecc44ZWNqB4c/Z8TwRpUpCPZEVytjxbTsQA9+9pivJjznF9/y2
	C+EhEx6Hg7A2mJbIHxNO/AIMJxYoNFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728662093;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/KlWPmZXxoa0WqjC0cA6cevcHquTyGLcClB1ekR3EWc=;
	b=ibnSY5JNTPJnpJCp5d6Z3W7WdQ91VhLK8uvU0XR012r67/wQllDoV6sfWSbkXJ1nx7UmuU
	ZvZ7H5ZSxX8QJEDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF5F51370C;
	Fri, 11 Oct 2024 15:54:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dIsGNkxKCWd0MAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 11 Oct 2024 15:54:52 +0000
Date: Fri, 11 Oct 2024 17:54:51 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/25] Unused parameter cleanups
Message-ID: <20241011155451.GX1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1728484021.git.dsterba@suse.com>
 <b2a617ac-5014-4a35-a231-6c150b34d2b6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2a617ac-5014-4a35-a231-6c150b34d2b6@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Fri, Oct 11, 2024 at 07:45:52PM +0800, Anand Jain wrote:
> On 9/10/24 8:00 pm, David Sterba wrote:
> > Assorted unused parameter removal, I tried to go to history where it was
> > last used and seemed important. Most of them look like leftovers after
> > other changes.
> > 
> 
> I'm curious, how did you come across them?
> Using `CFLAGS="-Wunused-parameter"` or `-C=1` doesn't seem to report them.

Passing custom flags works

  $ make ccflags-y=-Wunused-parameter fs/btrfs/

There are many out of btrfs code warnings so the rest was manual search
for 'fs.btrfs.*warning.*unused' and code inspection.

