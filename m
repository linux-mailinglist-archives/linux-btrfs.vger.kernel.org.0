Return-Path: <linux-btrfs+bounces-4515-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 553A08B092D
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 14:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D051C23CB6
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 12:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BB715ADB3;
	Wed, 24 Apr 2024 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QFRYELDz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JqZNZjSl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QFRYELDz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JqZNZjSl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB90315AD9A;
	Wed, 24 Apr 2024 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961341; cv=none; b=NdJrEnXCr70sCHfJlI+8oeOf4eKbvAKRBFvLEgGdBGp6CQQuKcdZ2SSwfww6BxWb5AASa9FmhR3lxH30JgRtfeu3/4ujYalDj0Qh59tl1Hmln9opSpUaH8FvGpSFTezCPA3BfFjdxPUbos3dDVDte+0jvOBvSgugC9FORK1MZE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961341; c=relaxed/simple;
	bh=RNFMIGsJI88vo1qm0jd0HAOyWgVKl7wYglQwOsOUgi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVs/i7JDOPhQBs0RiYaX00l5ayjAbtDoES1zF0wf2/Ju13dGwP9XkcbFZn40wB0fauMCzubKgTsi0yOmqPr0byr0mFrnETlcN/icQLNndGWS8XilrQIyXkIcguj7xiAY8ZHtJfqTb5ke9IpoRql2CYkUuSnYQOYKB9jJd4gjK2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QFRYELDz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JqZNZjSl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QFRYELDz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JqZNZjSl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1930566D76;
	Wed, 24 Apr 2024 12:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713961338;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NPQiUe+KZuzXoThRfw9yAf3ItUBduY+5PfjWZmD2p48=;
	b=QFRYELDzdEJQh61BpbK3Nwo8G40NiawpBYOC0pAaXT9gUi0Z/HlWhI/fZcpCmFwhcWbrsS
	BLWyFXtGYxUM4OHHXe/+oWaC5QRjvNAdogHT0Jk8Lb8TN8U9d84QxdQ0L8nI8MpNSn+o/I
	CAKMW0U6p6qeaxOQT5LCRYGmqp2i+OU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713961338;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NPQiUe+KZuzXoThRfw9yAf3ItUBduY+5PfjWZmD2p48=;
	b=JqZNZjSln9tB99LX51Z9zTiLxMNAQOxVMT0GP0xLCYIA60UEmCka1AJobNzaz94tof9M5Q
	A7RxHWKY6hpNWSBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713961338;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NPQiUe+KZuzXoThRfw9yAf3ItUBduY+5PfjWZmD2p48=;
	b=QFRYELDzdEJQh61BpbK3Nwo8G40NiawpBYOC0pAaXT9gUi0Z/HlWhI/fZcpCmFwhcWbrsS
	BLWyFXtGYxUM4OHHXe/+oWaC5QRjvNAdogHT0Jk8Lb8TN8U9d84QxdQ0L8nI8MpNSn+o/I
	CAKMW0U6p6qeaxOQT5LCRYGmqp2i+OU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713961338;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NPQiUe+KZuzXoThRfw9yAf3ItUBduY+5PfjWZmD2p48=;
	b=JqZNZjSln9tB99LX51Z9zTiLxMNAQOxVMT0GP0xLCYIA60UEmCka1AJobNzaz94tof9M5Q
	A7RxHWKY6hpNWSBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C08F1393C;
	Wed, 24 Apr 2024 12:22:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MVu+Anr5KGbKbAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 24 Apr 2024 12:22:18 +0000
Date: Wed, 24 Apr 2024 14:14:36 +0200
From: David Sterba <dsterba@suse.cz>
To: Zorro Lang <zlang@redhat.com>
Cc: Anand Jain <anand.jain@oracle.com>, zlang@kernel.org,
	fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL] fstests: btrfs changes staged-20240418
Message-ID: <20240424121436.GK3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240423220656.4994-1-anand.jain@oracle.com>
 <20240424091243.72n37q2xlwf5hxky@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424091243.72n37q2xlwf5hxky@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]

On Wed, Apr 24, 2024 at 05:12:43PM +0800, Zorro Lang wrote:
> On Wed, Apr 24, 2024 at 06:06:43AM +0800, Anand Jain wrote:
> > (I just realized that the previous attempt to send this PR failed. Resending it now.)
> > 
> > Zorro,
> > 
> > Several of the btrfs test cases were failing due to a change in the golden
> > output. The commits here fix them. These patches are on top of the last PR
> > branch staged-20240414.
> 
> Hi Anand,
> 
> I found lots of patches in this branch doesn't have RVB. That's not safe, if
> we always do things like that. We need one single peer review at least, that
> requirement is low enough I think.
> 
> Better to ping btrfs-list or fstests-list or particular reviewers to get
> review, if some patches missed RVB.

Anand is maintainer within fstests and I guess he reviews the patches
when putting them to the branch for merge. Filipe is mentioned as
reviewer but please don't expect him to reivew each and every patch.

I have a feeling that you're following process of merging patches that
is maybe modeled after linux kernel, with the multiple branches and
even merge window (mentioned in previsous PR), but this is IMO
inadequate for a testsuite where we need quick fixups to test cases to
be released in a much shorter turnaround.

I was expecting that if there was a dedicated maintainer for a
filesystem then things would go smoothly and we could skip formalities
because the maintainer is expected to do reviews that count too.

