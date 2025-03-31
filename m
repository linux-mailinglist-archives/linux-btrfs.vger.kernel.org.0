Return-Path: <linux-btrfs+bounces-12703-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97060A77194
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 01:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A023B188DAC5
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 23:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7098221CA17;
	Mon, 31 Mar 2025 23:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SsMOO7AW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HL9T067R";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="faRXuOG1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xXN1vspG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1E31DC9B8
	for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 23:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743465509; cv=none; b=XPXt7oiK3HmJLApMzZOIAIJLbsAeSNQJcDaQF+Wg4fJoDIXZ+XwmAnowTafY4ht5Ars+nU7CVcBVxHezoM6i4MhQWYb2wM/ihwF/7hFPmb3842FNl8pfS16rTiyCw+Mz/kaq45YgVEvlcV9y1tYq0ZwJvPUosLyFQx9efNydshw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743465509; c=relaxed/simple;
	bh=limW6wtbVip5v2t7KYfcA76jDNsE2btb+A9EmkK14LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnXruZtC98u5L2Th7UwaaSmgGs8t9vT7NNYC7A7qgVhLeYQIVVgvv8AMVOzt2hpEMr1m3pZYYK76CT3raimzT3CY9fXkD+dNTqa6sXUnaqA8jFp6iUJJxIJDhjT0+3/vTwk/27r+CjOb3TXLDgvrmZAMgndXhGV0Ylt3unKS3SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SsMOO7AW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HL9T067R; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=faRXuOG1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xXN1vspG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E79291F38D;
	Mon, 31 Mar 2025 23:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743465506;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EMCaXrwd3VpAFl/hAx/hrXyrQklmWipUpOs54tM7Phw=;
	b=SsMOO7AWv1C6D1RHxeAbmxolzAhxnQ/tp9nMMgDja5i7SJZjyP+6S2KRhy+rMzZoa9o4cr
	Kv9ldbb/TMHmonbwqf+sekIWaCBWayUw0LTzVuXzC97283lrLPqLkbtn17ynkWwfbcilrl
	PSfOSJSOxFObALzH1QY0sbPkQJ3x1BU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743465506;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EMCaXrwd3VpAFl/hAx/hrXyrQklmWipUpOs54tM7Phw=;
	b=HL9T067RaSvr2FbiCtZzwHtFE7sYtZSxr4hfCMaqZWfT0kSIxy4bIYevLanvXblj4oEUmM
	yt0k5MbnX02ss4Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743465505;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EMCaXrwd3VpAFl/hAx/hrXyrQklmWipUpOs54tM7Phw=;
	b=faRXuOG1qNUgQBxE8hyn3prhhwx1sUkWIhPjkjLFtEnUmbjI4/uDaDmMOOI88LZNffldHy
	cf5CIZXj6bnfUGn0xyaseqr+cJVu4n+JlWi+XELnvCRkHDSC5lXxlWrrj6abudvQo9Ciaz
	5LDIVl+BMzM+Gyb9wi0jBU7vBHuR1oY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743465505;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EMCaXrwd3VpAFl/hAx/hrXyrQklmWipUpOs54tM7Phw=;
	b=xXN1vspGuZzhotIvaFtnfcm0Q/E7Pk8k5d2GqacGSDCKeqTwhg97YAc7/NKBsxCugSO++5
	Dr7Fnyz7rXRDe/AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC65013393;
	Mon, 31 Mar 2025 23:58:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wYx/LSEs62fsWwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 31 Mar 2025 23:58:25 +0000
Date: Tue, 1 Apr 2025 01:58:20 +0200
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.cz>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: Re: [GIT PULL] Btrfs updates for 6.15
Message-ID: <20250331235820.GO32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1742834133.git.dsterba@suse.com>
 <20250328132751.GA1379678@perftesting>
 <20250328173644.GG32661@twin.jikos.cz>
 <20250328193927.GA1393046@perftesting>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328193927.GA1393046@perftesting>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Mar 28, 2025 at 03:39:27PM -0400, Josef Bacik wrote:
> On Fri, Mar 28, 2025 at 06:36:44PM +0100, David Sterba wrote:
> > On Fri, Mar 28, 2025 at 09:27:51AM -0400, Josef Bacik wrote:
> > > On Mon, Mar 24, 2025 at 05:37:51PM +0100, David Sterba wrote:
> > > > Hi,
> > > > 
> > > > please pull the following btrfs updates, thanks.
> > > > 
> > > > User visible changes:
> > > > 
> > > > - fall back to buffered write if direct io is done on a file that requires
> > > >   checksums
> > > 
> > > <trimming the everybody linux-btrfs from the cc list>
> > > 
> > > What?  We use this constantly in a bunch of places to avoid page cache overhead,
> > > it's perfectly legitimate to do DIO to a file that requires checksums.  Does the
> > > vm case mess this up?  Absolutely, but that's why we say use NOCOW for that
> > > case.  We've always had this behavior, we've always been clear that if you break
> > > it you buy it.  This is a huge regression for a pretty significant use case.
> > 
> > The patch has been up for like 2 months and you could have said "don't
> > because reasons" any time before the pull request. Now we're left with a
> > revert, or other alternatives making the use cases working.
> 
> Boris told me about this and I forgot.  I took everybody off the CC list because
> I don't want to revert it, in fact generally speaking I'd love to never have
> these style of bug reports again.
> 
> But it is a pretty significant change.  Are we ok going forward saying you don't
> get O_DIRECT unless you want NOCOW? Should we maybe allow for users to indicate
> they're not dumb and can be trusted to do O_DIRECT properly? I just think this
> opens us up to a lot more uncomfortable conversations than the other behavior.
> 
> I personally think this is better, if it's been sitting there for 2 months then
> hooray we're in agreement. But I'm also worried it'll come back to bite us.

I think we're in agreement where the fix is going and I also agree this
is a significant change and can indeed become worse in some sense than
what we have now. We already have exceptions for direct io when combined
with various features, most notably with compression where it falls back
to buffered right away.

We may need to enumerate and document the common combinations and decide
what to do about them and what are potential drawbacks. The upcoming
uncached IO support can possibly fill some gaps.

The fix is going towards correctness at the cost of performance and
arguably this should have been the default already. We ended up with
many people noticing checksum mismatches in syslog due to the VM setup.
It's rather bad usability to tell people to ignore certain errors that
would otherwise be quite significant.

Some of the combinations:

1) dio + no csum + no cow                  -> true direct io
2) dio + no csum +    cow                  -> almost direct io
3) dio +    csum +    cow + no compression -> fallback to buffered
4) dio +    csum +    cow      compression -> fallback to buffered

The changed case is 3.

Quoting your reply:

> We use this constantly in a bunch of places to avoid page cache overhead,
> it's perfectly legitimate to do DIO to a file that requires checksums.

So if you want to avoid page cache overhead the uncached mode does not
help that much I guess, the pages and related structures still need to
be set up.

I'm wondering if the use of direct io is more for convenience (not to
pollute the page cache) or for the real expectations of the performance
gains when the caching is done on the application side (e.g. databases).

The mutually exclusive feature is checksumming, so if the direct io is
for performance then the application could also turn off the checksums.

We don't have a magic bit and opening mode that can keep the dio + csum
working as before, and currently don't have a suggestion how to
implement it. Seems that one way or another the user application will
have to do some work to get best the performance.

