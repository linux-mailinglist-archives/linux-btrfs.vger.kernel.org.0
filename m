Return-Path: <linux-btrfs+bounces-16515-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AC9B3AE85
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 01:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B1E8985C9E
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 23:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7BF25CC58;
	Thu, 28 Aug 2025 23:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1ZiMG3qE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KijOttaF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1ZiMG3qE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KijOttaF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C667130CD97
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 23:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756424747; cv=none; b=DCqAG6ffb0kiCX0X8QIUrfL0wwamB5erLyl9m2QXV9YJaY7LlqWOewiNG42A8uSTXBFwa+VugK3XQ16ONPmxWbA09EpqbPePYBWqIAT0OB+w6qTKfNqpDl3WvxzFUWp2JM2uzZtqeOmKgXOswBIU8c8mTVlZIE8AAg3ekjbJ4c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756424747; c=relaxed/simple;
	bh=a7mnY//QtZSXWs9ch+Etvi5h1al8vtDWdbnA0AwQ4E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWM/Y9UJvzOy/983SXAfXrnAkhVZ1DlLIGrw1LDs89dOtBF97OhsX/8tBM9f7UwgDOAjjntgK07+AlA49LZuTezpDZHNAL8uZTVDBYriTQ2cllFnvT3tJyol2FqGsnssrh817PzE5t4w4hCbyCuCFeFaN/ozAxM8aK4sKiyIADU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1ZiMG3qE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KijOttaF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1ZiMG3qE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KijOttaF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B4CF433A14;
	Thu, 28 Aug 2025 23:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756424743;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a3eAIJRSK1izW5pnt8ZyDfTuXq0/jT/KMxCZxOWPYZI=;
	b=1ZiMG3qE31Y8NJEs7HHZUo76JhQPbMqy4BREEdO4ZjjgeSXVHulAR3UM6NNfw0zdbwUpQG
	QnJ7oD8G1WxYLjmskTecqph06UGGz9qm+NaSkq5+U/PX0voAS+XIWTe0VmhYBWUrKnxvoG
	g79rT3QT03S5G8fWPbmof3LaoLwf6F8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756424743;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a3eAIJRSK1izW5pnt8ZyDfTuXq0/jT/KMxCZxOWPYZI=;
	b=KijOttaF/0GQgCvBXmK3DiIKspG08UXgEgwqBZD8MQQ5JOkSW6s0dC6apKqqTU0fY6NxYa
	IAl/gAcMwTwBTbAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756424743;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a3eAIJRSK1izW5pnt8ZyDfTuXq0/jT/KMxCZxOWPYZI=;
	b=1ZiMG3qE31Y8NJEs7HHZUo76JhQPbMqy4BREEdO4ZjjgeSXVHulAR3UM6NNfw0zdbwUpQG
	QnJ7oD8G1WxYLjmskTecqph06UGGz9qm+NaSkq5+U/PX0voAS+XIWTe0VmhYBWUrKnxvoG
	g79rT3QT03S5G8fWPbmof3LaoLwf6F8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756424743;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a3eAIJRSK1izW5pnt8ZyDfTuXq0/jT/KMxCZxOWPYZI=;
	b=KijOttaF/0GQgCvBXmK3DiIKspG08UXgEgwqBZD8MQQ5JOkSW6s0dC6apKqqTU0fY6NxYa
	IAl/gAcMwTwBTbAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2CDB1368B;
	Thu, 28 Aug 2025 23:45:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ArWRJyfqsGjBSwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 28 Aug 2025 23:45:43 +0000
Date: Fri, 29 Aug 2025 01:45:42 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: add 16K and 64K slabs for extent buffers
Message-ID: <20250828234542.GG29826@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1756417687.git.dsterba@suse.com>
 <8c448bf2fcf0c2e7b52c05234d420b78cfe4b1d7.1756417687.git.dsterba@suse.com>
 <e776e393-896c-4d96-89bb-dd8b18042caa@gmx.com>
 <20250828233011.GE29826@twin.jikos.cz>
 <5a261aae-d172-4481-bde2-633184f285f2@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a261aae-d172-4481-bde2-633184f285f2@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmx.com,suse.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Fri, Aug 29, 2025 at 09:04:01AM +0930, Qu Wenruo wrote:
> >>> There are 5 node sizes supported in total, but not all of them are used.
> >>> Create slabs only for 2 sizes where 16K is for the default size on
> >>> x86_64 and 64K. The one that contains the node size will be used,
> >>> possibly with some slack space.
> >>
> >> I'm not a fan of two magic numbers.
> > 
> > It's not magic rather than optimizing for the most common case which is
> > default of 16k and a fallback. It does not make sense to create a slab
> > for each supported node size while only 16k would be in use.
> 
> It is. And all the two magic numbers are all based on 4K page sized systems.

No, it's based on default nodesize in mkfs.btrfs 16k.

> This doesn't look good for anything with larger page sizes.

Which is either 16k on macs and mayb ARMs or 64K on ARMs and Powerpcs.

> E.g. on 64K page size systmes, the 16K makes no sense and will not 
> allocate any space for the folios[] array.
> 
> That's why I hate this two magic numbers based solution.

On 16k page systems the array will have one entry, similar to what we
have now with 64k page systems because of how INLINE_EXTENT_BUFFER_PAGES
is calculated as BTRFS_MAX_METADATA_BLOCKSIZE / PAGE_SIZE

