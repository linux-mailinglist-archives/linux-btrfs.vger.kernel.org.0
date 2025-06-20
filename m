Return-Path: <linux-btrfs+bounces-14831-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28901AE208F
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 19:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC185A1DAD
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 17:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483282E717B;
	Fri, 20 Jun 2025 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0YQyyelk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="erN16kLX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="trJBK67Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xkuUVEn+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC940223DFA
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Jun 2025 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750439310; cv=none; b=Shf9oNbKz9MPH621FavNlX4EdKErJsYn9tSWI/C5J9qJx++3p8vDb/7831gM/fbAwvXdQ/t9Kko+J6c5aKR1istuDBStH1pQPLnvmfqdXGr6Nd1vlMi/GcmjArSCH4tGnVZSqi7dJ1iIaiyem27Bst1z/MtOA8Sc8/V1VDsciMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750439310; c=relaxed/simple;
	bh=LzXH5Ciy6E4XfLAHKhjn7hZ367r8oYIE24EO12Y7tW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEJ30MaI9sbz+gwuS8egxlzwZ1usFE81go6lzUAVjWVJ3jkcogmKVsBaNm1uY6lM7TF0tE69Zr5ESLh3+lIBjPt6TP/n0ROuk3HXxsNoY+dv0dbXLEj8v6liE+x3YE2c+WtqY+bIddqKNaLIJhuaOu6BbBr+XYoy30zoXNmKYH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0YQyyelk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=erN16kLX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=trJBK67Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xkuUVEn+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6B35E1F395;
	Fri, 20 Jun 2025 17:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750439307;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pv+moqrX7NMsOH+bQCIi4ujzIjdbeJbqM3P3BekVPzA=;
	b=0YQyyelkJK06H4SRK4wu56BjG2M/a8Ad4d3om7aFPrfvWhC6A3H+NNXIEz81bQHrHZKurN
	0/gYY8Chf9OQCABdnEXtykZzL2wMgmXc71gy7wdwAbu4vVQT1wkufK1bKMHpokJYOl/6KK
	FL8KuccoUAGio/pta1U9OKASUk/2ZrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750439307;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pv+moqrX7NMsOH+bQCIi4ujzIjdbeJbqM3P3BekVPzA=;
	b=erN16kLXeQb2++dO00Wj7XKuiIDVX2ajLghP3K9AQ6lwlQZiwq/npRnAdjF7c3Cte/QYGt
	LwR20mcFRJ+rjQCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750439306;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pv+moqrX7NMsOH+bQCIi4ujzIjdbeJbqM3P3BekVPzA=;
	b=trJBK67Zu+gsLBliVHXuE6AP4EPyRYog5JpiFGtX3JFzHLzLStSQtkI8JI3PR+t55gstq+
	Cz0SysY8OzmDNu6zL2GGM8zxo+6MvE22BVRDcSJocT3FHjPFRSBwiaw7Qc5pdKDPRPbBzJ
	EDZVvvG8W/muSnByWUaa/n/aJf3/JSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750439306;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pv+moqrX7NMsOH+bQCIi4ujzIjdbeJbqM3P3BekVPzA=;
	b=xkuUVEn+4fc91l7+dmGBNTuHMa9ZTcrwtsyUXFHUW5nOqOPJrIpNY8RJFl9OU+V2djmv1b
	aJ6JFbW4rFVt9YDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 522B3136BA;
	Fri, 20 Jun 2025 17:08:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U+nXE4qVVWgLfAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 20 Jun 2025 17:08:26 +0000
Date: Fri, 20 Jun 2025 19:08:25 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs-progs: misc-tests: add an image for btrfstune
 bgt conversion
Message-ID: <20250620170825.GC4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1750223785.git.wqu@suse.com>
 <7c9fe963270c9fea38a8ce5a1625957a09aa10d5.1750223785.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c9fe963270c9fea38a8ce5a1625957a09aa10d5.1750223785.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 

On Wed, Jun 18, 2025 at 02:53:41PM +0930, Qu Wenruo wrote:
> The image has a half converted fs, unfortunately btrfs-image can not
> properly maintain the CHANGING_BG_TREE super block flags, thus we have
> to go raw image.
> 
> And since we're here, also introduce the support for the .raw.zst suffix
> for ZSTD compressed raw images.

Why? XZ is there because it can get us the best results and I don't see
any benefit using zstd. Also I've recompressed some images with "xz -e
-9" in the past.

I've noticed the test image size as the mail took some time to load, the
image being 3M.

uncompressed: 	268435456
zstd:             2760068
xz -9:            2634928
xz -e -9:         2219716

Which saves like 0.5M. In the long run the .git dir will only grow and I
don't want to limit us to add more crafted images, rather to make them
minimal.

