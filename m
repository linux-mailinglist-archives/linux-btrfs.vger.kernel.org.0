Return-Path: <linux-btrfs+bounces-15163-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C192AEFCE0
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 16:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 066587AB146
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 14:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786AB277807;
	Tue,  1 Jul 2025 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kOR5ZP+K";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rl158Nl1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xFN1ma1V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rztqDt3r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C98C1B0F0A
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751381006; cv=none; b=VsPGWI3r6ysHWXVmFJxndOQmjqHxLHGGByzaaFPdsjIZosJnA83sIxpMrhjHzF4N3NsaxL77jbm+GzHUosDkHmoSxpVAOcaHEIjTo5E6+H7h5gb6hoAI2HzGafAGyUttNkU4hDDN2Ds0p+9Z9QEvlC0TdHvaMKyUFTcGqJZS0uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751381006; c=relaxed/simple;
	bh=YOZBmb1OC5PLg7Aiu/shEnWYqg/Zt481woVBiavtAnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFKMUCbadRubI3sxBCx567Z2IL3DAjMTbzLmG8BNsyr5wY4r3KyXMTti9C2KW7jAKW2KndQhsQKzrHed0zM2ZgIIXPG0biLJ63uf5D2dwgckKdU0WFbcQ1Jz9WgALc3HeOnmx32zbxTJ9ELXPMKstmv1KrtOkPsIYMJlvgSlUHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kOR5ZP+K; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rl158Nl1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xFN1ma1V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rztqDt3r; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 38BF521163;
	Tue,  1 Jul 2025 14:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751381003;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26XJMH52myW5tJG1gvqRbN2bAgba8bd65ZVkwHSobac=;
	b=kOR5ZP+KKvzJKx00AzGU4ZWBWE4kbK4ZIL8EeWwSn2KyZQYPXjG4Iiet8zNiENKB3o/uiw
	pvqtZwf8PEtXkOz61gfYP/AwBPLkh5GvcOZpAYFsunZikpw+eZuBls4+xMJem8NbwmRSqF
	ONlEOKZLXHfdbkxGzAGyWwsBqJUh+fE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751381003;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26XJMH52myW5tJG1gvqRbN2bAgba8bd65ZVkwHSobac=;
	b=rl158Nl1glzNlsXN1uUaGd/tn/m01vekirHJWCz3Dkg5RVDq+3BO0LhTrQ2iLaPEfHhFZM
	KvYYS3HQwXQ7yNCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751381002;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26XJMH52myW5tJG1gvqRbN2bAgba8bd65ZVkwHSobac=;
	b=xFN1ma1VrYrD50wzcz3qS/TGk4oFPExgg24ejcEi9lHN78nvf+ImONo4bh4vR0PG5kqBJ3
	blPBQ6VRDjuRTGXqOe1GzRy248JgxyHinwjsjgBzuHxOgS01vvtLe6mcVyuuGgvEZ8PzMK
	cIvT6XsTvl+S3bAJ55vH0Hn7wbv3naU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751381002;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26XJMH52myW5tJG1gvqRbN2bAgba8bd65ZVkwHSobac=;
	b=rztqDt3ri0OmTJpGBwLOivWPM3xyk3lrlkVi0UXkttKCPz5tUcPSgD1PKiHI+zyvitHwMQ
	LXsBolQDCH+zLTDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13A0D1364B;
	Tue,  1 Jul 2025 14:43:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Sa2PBAr0Y2hEFQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 01 Jul 2025 14:43:22 +0000
Date: Tue, 1 Jul 2025 16:43:20 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "dsterba@suse.cz" <dsterba@suse.cz>,
	Johannes Thumshirn <jth@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <Naohiro.Aota@wdc.com>,
	David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH RFC 8/9] btrfs: lower log level of relocation messages
Message-ID: <20250701144320.GQ31241@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250627091914.100715-1-jth@kernel.org>
 <20250627091914.100715-9-jth@kernel.org>
 <20250630171214.GO31241@twin.jikos.cz>
 <be89847a-c3d9-4f8e-a468-c98d150ef361@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be89847a-c3d9-4f8e-a468-c98d150ef361@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,wdc.com:email,twin.jikos.cz:mid,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 

On Tue, Jul 01, 2025 at 05:09:06AM +0000, Johannes Thumshirn wrote:
> On 30.06.25 19:12, David Sterba wrote:
> > On Fri, Jun 27, 2025 at 11:19:13AM +0200, Johannes Thumshirn wrote:
> >> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >>
> >> When running a system with automatic reclaim/balancing enabled, there are
> >> lots of info level messages like the following in the kernel log:
> >>
> >>   BTRFS info (device nvme2n1): relocating block group 629212708864 flags data
> >>   BTRFS info (device nvme2n1): found 510 extents, stage: move data extents
> >>
> >> Lower the log level to debug for these messages.
> >>
> >> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > 
> > I kind of like that the message is in the system log on the info level,
> > it's a high level operation and tracks the progress. Also it's been
> > there forever and I don't think I'm the only one used to seeing it
> > there. We have many info messages and vague guidelines when to use it,
> > but I think "once per block group" is still within the intentions.
> > 
> 
> Yes but now that automatic balancing is in place this is spamming all 
> over dmesg.

We could distinguish the reason of relocation so the one started
manually will print what we have now and the automatic only say two
messages like "starting automatic bg cleanup" and once it finishes some
kind of summary "bg cleanup removed 123 block groups". If you want
additional debugging just for the automatic reclaim then it's OK.

