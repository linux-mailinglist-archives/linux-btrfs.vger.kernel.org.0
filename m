Return-Path: <linux-btrfs+bounces-4518-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E818B09D6
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 14:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E319283D47
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 12:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC28E142E91;
	Wed, 24 Apr 2024 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ymjqiyfW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CNsDCFKO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ymjqiyfW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CNsDCFKO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6911B33989
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713962361; cv=none; b=MfUk5Okjo1zNTKiTG2ynOkMHrz69oBLiAmS5l3rdXQZP8zgZnaeRga5BIn3VdG1jKQB7CQ2L8toW13ciRp6ONVK67/gzRJO/Bu59FPFP4omBRKlJ/rPrJIP6Qph7XKY7+B7PUpx1j+TMsMTD3PNdJXOLv1lZlEg0aveSAnxdxeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713962361; c=relaxed/simple;
	bh=f1Hzc0gcBlpa5bYd/d+53er3hL30tP0Lkm5cWLveb7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxvO+iRfBusyiTb6Igx8f4QApKy2Z+tkf7XtzIUwmsfwaZoHWBwpSwHLNya2jv902mqgXh+K/kLZ3WtZIGwBB3WKJMQjCenEd8kfZa4qQczAiXRxG8OOStt2mLcT67Dn0fqT358ZpIbP9VPc2ek4m2stv7RMW/lehObxJlfrJHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ymjqiyfW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CNsDCFKO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ymjqiyfW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CNsDCFKO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9D05866D92;
	Wed, 24 Apr 2024 12:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713962357;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DOZ5Hl5nzE+pzYJAq9HrGzkKIXQNtELvI3lKEI1OaXU=;
	b=ymjqiyfWLBjbk6E9YxonV9HRaLnN83Z3mNKaI4Vy3UKsNKn4w8N9MCnfuR9EZKnKN+f7YH
	RXbAlHbizq5OCbLIIs0wll8bpjHm7bEBqAUlwpEpG8OTc6qitzW4Yi1Cr7i/CHO1opaFYT
	7J8yNwFlCkbas1czHPTQu6TveRAQ7/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713962357;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DOZ5Hl5nzE+pzYJAq9HrGzkKIXQNtELvI3lKEI1OaXU=;
	b=CNsDCFKOA0R+PqtdX144VAgP1f43+r1iesu5wCDdPhr2KHTndzw4QCxLkiDZrmEs1cWugf
	6wRbhyUv0NdPlpAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713962357;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DOZ5Hl5nzE+pzYJAq9HrGzkKIXQNtELvI3lKEI1OaXU=;
	b=ymjqiyfWLBjbk6E9YxonV9HRaLnN83Z3mNKaI4Vy3UKsNKn4w8N9MCnfuR9EZKnKN+f7YH
	RXbAlHbizq5OCbLIIs0wll8bpjHm7bEBqAUlwpEpG8OTc6qitzW4Yi1Cr7i/CHO1opaFYT
	7J8yNwFlCkbas1czHPTQu6TveRAQ7/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713962357;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DOZ5Hl5nzE+pzYJAq9HrGzkKIXQNtELvI3lKEI1OaXU=;
	b=CNsDCFKOA0R+PqtdX144VAgP1f43+r1iesu5wCDdPhr2KHTndzw4QCxLkiDZrmEs1cWugf
	6wRbhyUv0NdPlpAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 919501393C;
	Wed, 24 Apr 2024 12:39:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +PFVI3X9KGYjcgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 24 Apr 2024 12:39:17 +0000
Date: Wed, 24 Apr 2024 14:31:44 +0200
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/15] btrfs: snapshot delete cleanups
Message-ID: <20240424123144.GN3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1713550368.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1713550368.git.josef@toxicpanda.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3]

On Fri, Apr 19, 2024 at 02:16:55PM -0400, Josef Bacik wrote:
> Hello,
> 
> In light of the recent fix for snapshot delete I looked around at the code to
> see if it could be cleaned up.  I still feel like this could be reworked to make
> the two stages clearer, but this series brings a lot of cleanups and
> re-factoring as well as comments and documentation that hopefully make this code
> easier for others to work in.  I've broken up the do_walk_down() function into
> discreet peices that are better documented and describe their use.  I've also
> taken the opportunity to remove a bunch of BUG_ON()'s in this code.  I've run
> this through the CI a few times as I made a couple of errors, but it's passing
> cleanly now.  Thanks,

We're past rc5, this series looks generally ok to me so I'd rather get
it merged to for-next. We can do minor refinements later (either still
within for-next or as separate cleanup pass).

There are some comments so I'd not send rev-by for the whole series but
consider it as such. My testing did not hit any problems either.

