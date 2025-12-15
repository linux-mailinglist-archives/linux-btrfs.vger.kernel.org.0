Return-Path: <linux-btrfs+bounces-19761-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7091CBFB9D
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 21:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 770D63030DA4
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 20:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF2530BF67;
	Mon, 15 Dec 2025 20:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eOYH/M43";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kGXpOJjF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WFYRB5et";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="twfJWbjK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ED630FC1F
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 20:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765829964; cv=none; b=V+/6dPUB5ryA8sepma1IgpNg/b1l5IF0ps5cbHarYA7EOe5ur1wPMS2QqIUUnW5C4UO6YcXfGm8iw2akdrcF8ysc8ZoZsJ2ydWNLyo+fQK7T2dWcTLMqrol9jF+ny1f1z2IZApSHN176ZcKSQ/70CTZ7nIxyD+X7iF9S+9sqqto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765829964; c=relaxed/simple;
	bh=sinAys6bq2KJC3vxlGZQCFKMDqj/3LESm5QLDquctEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ytc8q+wdEVbdseR0Nefqhilgy0Gj6KboH3Ct8eFilEeGqq2yFkXt0ibMwn6oX9taJB7MD6hUpLfEFL3XVrfyXnsOSToQyAqYR2Ub+LqXYoXEY9IIcr4i/8x0Dg9ht3NOJp1G6FdVHNrF7hZGMtSrguH6807hze2JVAULyt/IAFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eOYH/M43; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kGXpOJjF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WFYRB5et; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=twfJWbjK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 07FFD5BCD8;
	Mon, 15 Dec 2025 20:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765829959;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cv9V2EwVN4ACE8h9cWWL6vFLprpXoG7/70T/aQhm9Ms=;
	b=eOYH/M437n3uSzJU1pflh2TQAtPwCRYtb0bmTsy4bol2Ayg5SxDwv1QXOaGhGmnhpdDU4S
	OLPyWvS4klnYyoV/DCWWKFAjE4U/cEH2MuiS3KSI6045DkqCEFAEpCjV+ft6LcHGMFV8X0
	PJfPPZnGgayG1LxMpcw1qLzR81ng/PA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765829959;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cv9V2EwVN4ACE8h9cWWL6vFLprpXoG7/70T/aQhm9Ms=;
	b=kGXpOJjFdQJ+X/g6HzjDD+gtnTujPI8+MFJnUBROPvrOD/SYWWD11GEKstZVFQk1/VY1vE
	Hvg6r8mz/KD9tWDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765829958;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cv9V2EwVN4ACE8h9cWWL6vFLprpXoG7/70T/aQhm9Ms=;
	b=WFYRB5etkj8TbCRdyNQ+mcHiRKdLU2CZ3nYsSssumgiz0vq44mdUB0X0fCYcaJjLUqJVkw
	CN2WuEb3C/7E1nlpXiVD9M8u8mdzEh1eeBknm4yf7zMD33ABMuWSbC9HEYGP46yVAMOIjy
	JDzl7o4MifV3jLrL5GCMXr+iczHHf9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765829958;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cv9V2EwVN4ACE8h9cWWL6vFLprpXoG7/70T/aQhm9Ms=;
	b=twfJWbjKvGkl+DjwgU4vxEXjWp1ao3pkbNOF5UJejx+ij+FuftIamojwdSOPn7R9lm8fZh
	LAREdIDqw7Zn+zAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD7873EA63;
	Mon, 15 Dec 2025 20:19:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T0yONUVtQGmjWAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 15 Dec 2025 20:19:17 +0000
Date: Mon, 15 Dec 2025 21:19:16 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: avoid access-byoned-folio for bs > ps encoded
 writes
Message-ID: <20251215201916.GJ3195@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <79e1be995894f1c987a54c6298c36459a756b672.1765081384.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79e1be995894f1c987a54c6298c36459a756b672.1765081384.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -3.93
X-Spam-Level: 
X-Spamd-Result: default: False [-3.93 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.13)[-0.641];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]

On Sun, Dec 07, 2025 at 02:53:20PM +1030, Qu Wenruo wrote:
> [POTENTIAL BUG]
> If the system page size is 4K and fs block size is 8K, and max_inline
> mount option is set to 6K, we can inline a 6K sized data extent.
> 
> Then a encoded write submitted a compressed extent which is at file
> offset 0, and the compressed length is 6K, which is allowed to be inlined.
> 
> Now a read beyond page boundary is triggered inside write_extent_buffer()
> from insert_inline_extent().
> 
> [CAUSE]
> Currently the function __cow_file_range_inline() can only accept a
> single folio.
> 
> For regular compressed write path, we always allocate the compressed
> folios using the minimal order matching the block size, thus the
> @compressed_folio should always cover a full fs block thus it is fine.
> 
> But for encoded writes, they allocate page size folios, this means we
> can hit a case where the compressed data is smaller than block size but
> still larger than page size, in that case __cow_file_range_inline() will
> be called with @compressed_size larger than a page.
> 
> In that case we will trigger a read beyond the folio inside
> insert_inline_extent().
> 
> Thankfully this is not that common, as the default max_inline is only
> 2048 bytes, smaller than PAGE_SIZE, and bs > ps support is still
> experimental.
> 
> [FIX]
> We need to either allow insert_inline_extent() to accept a page array to
> properly support such case, or reject such inline extent.
> 
> The latter is a much simpler solution, and considering bs > ps will stay
> as a corner case and non-default max_inline will be even rarer, I don't
> think we really need to fulfill such niche.
> 
> So just reject any inline extent that's larger than PAGE_SIZE, and add
> an extra ASSERT() to insert_inline_extent() to catch such beyond-boundary
> access.
> 
> Fixes: ec20799064c8 ("btrfs: enable encoded read/write/send for bs > ps cases")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

