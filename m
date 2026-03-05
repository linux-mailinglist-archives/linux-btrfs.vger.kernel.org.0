Return-Path: <linux-btrfs+bounces-22238-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHjRKi7qqGnAygAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22238-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 03:27:58 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 203B720A2F3
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 03:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 103B4301C6ED
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2026 02:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3176D25CC63;
	Thu,  5 Mar 2026 02:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sfCtFodz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N3QGiEFs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t/amTI1p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CSS7vtpF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607EBBA21
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Mar 2026 02:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772677667; cv=none; b=n23V+L14YWmymLKWegj9wI0eZV7eTQ895Mp0/8rcbl0pn8if7YOpAOUOblz7q6HODA+iozDast7whjdw/GI0SoTbxzdVeZkHuFmvcSeRMrAkUmJH/3ci8m6PLgutlzrQQcS+kgdFE0n+qAHPXgOwNvZl/G7zRqNj/chWq17OiqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772677667; c=relaxed/simple;
	bh=N1XLO7BLki0zxUisxGSZibIxkVNDHdqVDfkscKgx8uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRJXwZw+DRTxaX26aK1skJAIcHUm/AeJwgTJJOybFjkLSMYi4CpEQn/O3oyhjXQhRbddKOnZOYzAUUujZWd3tGyq4BL0xUzVFfvq7b4vKKNmhl+8xQouwhHpFyCOlmUjNF7m8bKdqbNbGDULQxb76G/ynpy+bjvPu95IExCtprI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sfCtFodz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N3QGiEFs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t/amTI1p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CSS7vtpF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 825255BD78;
	Thu,  5 Mar 2026 02:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772677664;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=18V83uUJz0v+5CLDnyARjekwMI/S1G9JjZOyGt05MJg=;
	b=sfCtFodzVEsYAAdKivVcaz80gyK70J1unf0HUYNouxiky+z/mRKNWwujIMWIylpdeJRKK0
	EghQM0223C4UTPvrXX/bBQGTOXo7PdwlSfdHfz7Q5MJVCAqcwXCCsKRVa87fnGs/1IvIFo
	1RoylLYrZAHc/4iPagYEFrxQZ6qo/WY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772677664;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=18V83uUJz0v+5CLDnyARjekwMI/S1G9JjZOyGt05MJg=;
	b=N3QGiEFs6q6lwuRcoEMw+2zBvgK398vNP35ARWMiZstJhwitRtYdXnAxRdbff1+ysScotj
	BeGkHDob2LmFyLCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772677663;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=18V83uUJz0v+5CLDnyARjekwMI/S1G9JjZOyGt05MJg=;
	b=t/amTI1pOWntQCZtz7vo6NSeNaxyKAD9YDB1sGbVirfGprJ+oAQRv757opVjR8PgXYmx94
	6mm6vDMj5d5Dz1d1WlidWWn/pbNpTGXfntXxUQxXLFd3hmCee5uc7JxELEea6ho59iRVGy
	Z/gd5ZOYwku0kB/H3qOHKVBJpp8eNUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772677663;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=18V83uUJz0v+5CLDnyARjekwMI/S1G9JjZOyGt05MJg=;
	b=CSS7vtpFi7QiBCx3RqTKGvq6eipj3AHiORaC0ugQBm87xJpxfr4puCCXTUsCUjibkEJH2/
	GLD38kY/SxBB0bBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65D933EA68;
	Thu,  5 Mar 2026 02:27:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ISSoGB/qqGmgegAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 05 Mar 2026 02:27:43 +0000
Date: Thu, 5 Mar 2026 03:27:38 +0100
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: torvic9@mailbox.org, "clm@meta.com" <clm@meta.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"dsterba@suse.com" <dsterba@suse.com>
Subject: Re: btrfs: fix periodic reclaim condition - missing patch in stable?
Message-ID: <20260305022738.GB5735@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1333479338.178488.1772632448830@app.mailbox.org>
 <8738c4c9-d8e2-4085-b68c-fc1adc49dd59@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8738c4c9-d8e2-4085-b68c-fc1adc49dd59@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -3.00
X-Spam-Level: 
X-Rspamd-Queue-Id: 203B720A2F3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22238-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.cz:dkim,suse.cz:replyto,mailbox.org:email,twin.jikos.cz:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[dsterba@suse.cz]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 10:15:43PM +0800, Sun YangKai wrote:
> 
> 
> On 2026/3/4 21:54, torvic9@mailbox.org wrote:
> > Hello,
> > 
> > Commit "btrfs: fix periodic reclaim condition" (25ecb24405928d3f5db48029c2237b2c7cefb479) was added to stable,
> > however it seems that a subsequent locking fix [1] to that patch was not added, possibly due to a missing stable tag.
> > Shouldn't that fix also be included in stable?
> 
> Yes, I think that fix should also be included in stable.

The patch is is the queue for -rc4 (or maybe rc3).

