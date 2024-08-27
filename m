Return-Path: <linux-btrfs+bounces-7538-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F9695FE18
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 02:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A2FB20D4B
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 00:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A658BE8;
	Tue, 27 Aug 2024 00:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JQHk4F1T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LmeWulGz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bll3QR5X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N7W4QcxQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F324C8E
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 00:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724720018; cv=none; b=LEe8GzOu8f6D/lWEXQmkWusc5URBn+QcOc1dWADmOKIc6rNdJmPU0XWebJvCljAcKiFJwGczvlpMnYjkRCGcpxNzsail6YHQq3EoYOF9dF2iSDclfwVBRGOfgnpHWf+QmLEj+41nAvUkRuLBoVUC/Rmvz9RhNDgInpsLsbYSoLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724720018; c=relaxed/simple;
	bh=Mdx1+T54pZbwZrPrMalSZVuche9OzjJDQfqUKDNkpp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDeepDKAVvVoaabfx3GXXHZ4ucV/oLAZXk4OWPQQXYT6ucViYEIdMm1HnOy2XgUJET5L4HorUNAUmpKqX3qQ5L2XaSkGtVJYR2bNEmnzhAaHavBSyiONWGnURKE7il0n8lbL4wiGL5vV53gf37TOALFUJGBzJ+a+AJvzay72QTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JQHk4F1T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LmeWulGz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bll3QR5X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N7W4QcxQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4D03E21AD0;
	Tue, 27 Aug 2024 00:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724720014;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9sP/bSiw7XbLt8nBlttOKKK2gZz8efciIGBbNcCsEVA=;
	b=JQHk4F1TH1AZiEadwNx0EFyd51aiyte9rh6ISIJWKN2TBCSQXJclHodQMHxb0T+LERjvqB
	bBr6rQYr9wjoY7iZxAWI2Ikjds6JAshNuCsv1TA2XGKz6g8uEYtOj1XJIEEQmEpWLjxwQI
	OGCggoVSxaA0duxiyqHKZlR2A18icYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724720014;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9sP/bSiw7XbLt8nBlttOKKK2gZz8efciIGBbNcCsEVA=;
	b=LmeWulGz6QZV1JbOf8coRk0JELdPiZ1AL/u8G6RmFJf3WGbEQIkNQhXRi/CHyFd1PDNFPr
	t5+f/8a6EFo6jsCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bll3QR5X;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=N7W4QcxQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724720013;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9sP/bSiw7XbLt8nBlttOKKK2gZz8efciIGBbNcCsEVA=;
	b=bll3QR5XUqUBfMw642iPcRxhvVeeP6QBmfVtXhJWsGEEs93PZj6bULjYy6vWCa3MoC8Vq0
	gcz3nTxZgDN6joCQfngnIoXy8EiJXoxiRUcQqFUM5D2bC+tgvZcV0DkR8uunXRCnALdZgX
	DtRXAroERECogU6rBLW+1ULJpMok3Dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724720013;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9sP/bSiw7XbLt8nBlttOKKK2gZz8efciIGBbNcCsEVA=;
	b=N7W4QcxQaicLNLO0ChZDSgrsVzh64teQV/gfp9JCOuu4XAGm5sFUNS2B51JlSL94odwgrS
	kvZOSj+f5RUux4Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E23213724;
	Tue, 27 Aug 2024 00:53:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5FvGCo0jzWbGEAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 27 Aug 2024 00:53:33 +0000
Date: Tue, 27 Aug 2024 02:53:31 +0200
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/3] btrfs: no longer hold the extent lock for the
 entire read
Message-ID: <20240827005331.GV25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1724690141.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724690141.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 4D03E21AD0
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:dkim,suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Mon, Aug 26, 2024 at 12:37:23PM -0400, Josef Bacik wrote:
> v1: https://lore.kernel.org/linux-btrfs/cover.1724255475.git.josef@toxicpanda.com/
> 
> v1->v2:
> - Added Goldwyn's bit to move the extent lock to only cover the part where we
>   look up the extent map, added his Co-developed-by to the patch.
> 
> -- Original email --
> Hello,
> 
> One of the biggest obstacles to switching to iomap is that our extent locking is
> a bit wonky.  We've made a lot of progress on the write side to drastically
> narrow the scope of the extent lock, but the read side is arguably the most
> problematic in that we hold it until the readpage is completed.
> 
> This patch series addresses this by no longer holding the lock for the entire
> IO.  This is safe on the buffered side because we are protected by the page lock
> and the checks for ordered extents when we start the write.
> 
> The direct io side is the more problematic side, since we could now end up with
> overlapping and concurrent direct writes in direct read ranges.  To solve this
> problem I'm introducing a new extent io bit to do range locking for direct IO.
> This will work basically the same as the extent lock did before, but only for
> direct IO.  We are saved by the normal inode lock and page cache in the mixed
> buffered and direct case, so this shouldn't carry the same iomap+locking
> reloated woes that the extent lock did.
> 
> This will also allow us to remove the page fault restrictions in the direct IO
> case, which will be done in a followup series.
> 
> I've run this through the CI and a lot of local testing, I'm keeping it small
> and targeted because this is a pretty big logical shift for us, so I want to
> make sure we get good testing on it before I go doing the other larger projects.
> Thanks,

We don't have anything that would interfere with that in for-next, the
folio conversions are mostly direct and there were no new problems
preported. The read locking change will probably lead to some
performance gain so I guess this is a good improvement for the next
release.
> 
> Josef
> 
> Josef Bacik (3):
>   btrfs: introduce EXTENT_DIO_LOCKED
>   btrfs: take the dio extent lock during O_DIRECT operations

Patches 1 and 2 are easy, so

Reviewed-by: David Sterba <dsterba@suse.com>

>   btrfs: do not hold the extent lock for entire read

I don't see anything obviously wrong here, the logic change makes sense
and code follows that.

