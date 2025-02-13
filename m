Return-Path: <linux-btrfs+bounces-11437-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94D0A336E9
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 05:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3103A6FD1
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 04:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2B32063E0;
	Thu, 13 Feb 2025 04:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z0sq9K52";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ypzula4T";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z0sq9K52";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ypzula4T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE83835949
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2025 04:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739420894; cv=none; b=GcmaEv43Xbaxna14MdpfTYLkAX9lU8nZrP1sw28Ir+IlyqOeUH0hUqRtvXZ74VKijwBcMeVaQkgspIqxYKsMUiLVAqymGh01f6fiT7kfFg2JQfVjlja2N+rndvJKHcQPV0r6Pdaa/nsaErom40cHxCCnRHlL8SkoxjRL9oYQFyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739420894; c=relaxed/simple;
	bh=2m9lCNWWX1XqH1PUrBYt9ZETPaaRb6CuJIM7vBeZh7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mj3U41YF23OJrXpc9HWjP6U8HaktlsbDn0jCRxd2cSlvOi5mBqozzQ9U4frcfni6OnpZgDLL/Buql75nR+ek3Cx3EsrvwA2mo9tnhi4CNSeq8mQ0gP3uHu2Bvc07CqZ23yeLldDh/+3dpM/edKc3DJVJYWOnTb0YenG/Yy4L9xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z0sq9K52; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ypzula4T; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z0sq9K52; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ypzula4T; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E7F9D1FB44;
	Thu, 13 Feb 2025 04:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739420890;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7WteoSK9gX46LV22m+NoJDn7ccs3fptH2bKcN31onMs=;
	b=Z0sq9K52Dr9+XYz08VQL7NfJ++Vwo/mgGtSwXN2AeZ7LPd5iCdjEZwTn7i1nlVJfwA0tsP
	OwDoHnV88SKoNPVqfPuvvyw41byeIK5/cXsSH1SUdVpOflykM0+reNnZeVlTeVbnBWaktK
	mCZaUO1YSkIdidSzgsMO03ab/r5Rn7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739420890;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7WteoSK9gX46LV22m+NoJDn7ccs3fptH2bKcN31onMs=;
	b=Ypzula4TPebSThMaE7B2s5dFsBTR8xG1D53PXg59SCo2g350UW8rnYTYBEmHe5p2BsiH9K
	HaCgc985xsWYyVDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739420890;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7WteoSK9gX46LV22m+NoJDn7ccs3fptH2bKcN31onMs=;
	b=Z0sq9K52Dr9+XYz08VQL7NfJ++Vwo/mgGtSwXN2AeZ7LPd5iCdjEZwTn7i1nlVJfwA0tsP
	OwDoHnV88SKoNPVqfPuvvyw41byeIK5/cXsSH1SUdVpOflykM0+reNnZeVlTeVbnBWaktK
	mCZaUO1YSkIdidSzgsMO03ab/r5Rn7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739420890;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7WteoSK9gX46LV22m+NoJDn7ccs3fptH2bKcN31onMs=;
	b=Ypzula4TPebSThMaE7B2s5dFsBTR8xG1D53PXg59SCo2g350UW8rnYTYBEmHe5p2BsiH9K
	HaCgc985xsWYyVDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBD3113AAB;
	Thu, 13 Feb 2025 04:28:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 76RKMdp0rWfcKgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 13 Feb 2025 04:28:10 +0000
Date: Thu, 13 Feb 2025 05:27:54 +0100
From: David Sterba <dsterba@suse.cz>
To: Racz Zoltan <racz.zoli@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: add duration format to fmt_print
Message-ID: <20250213042754.GB5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250211232918.153958-1-racz.zoli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211232918.153958-1-racz.zoli@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Feb 12, 2025 at 01:29:18AM +0200, Racz Zoltan wrote:
> Added "duration" format in seconds to fmt_print which will convert the
> input to one of the following strings:
> 
> 1. if number of seconds represents more than one day, the output will be 
> for example: "1 days, 01:30:00" (left the plural so parsing back the
> string is easier)
> 2. if less then a day: "23:30:10"

Makes sense to split it like that. I remember seeing the day formatted
as "1d" so this can be simplifed like that and it remains parseable.
I can adjust that or keep it as you sent it, this is more about how
it's expected to be than how we'd prefer it.  This is supposed to be in
the json format so some real examples would help to decide. Thanks.

