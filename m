Return-Path: <linux-btrfs+bounces-19250-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6DEC7A990
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 16:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 74D0E351616
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 15:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA122E541E;
	Fri, 21 Nov 2025 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lsVonA2V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GNXBiieI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lsVonA2V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GNXBiieI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C957155757
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763739540; cv=none; b=SQtS/7RW2He/BFRe0nh4iA6A3JgNlvT5kQrPJByWu3fcXB28IRk4HU4QZWBax+u1TCqelsUabAfNv+CKkY0NZ2ZlnOxgG8YlMBohKhYMNZoC2bl4S3qvqi2SZDM3Y1obkP8mI2N8xhiG/WwRSLtMeI2IxoH1H5ay3kJD7jipf7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763739540; c=relaxed/simple;
	bh=uCC09485aUCdsfgJH4KTdRb9TsMIXLR1AWmtoTnTWxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOJ5bVPsGj+UwvI78x/RLksWlMdDO3xH0ARXLLE+O7iUsY8K4MloXDcBJD3lY4QMhNtaB4BSTDNOFNbKG+y/etVNTlVuMKc8CBeH8MU1yhRlBLfeuOddErqWgXeW/QjYWlxaEuPFM3UMhssWIR+aL6tTtF0FfVIygVxvtpIM01o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lsVonA2V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GNXBiieI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lsVonA2V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GNXBiieI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3A1A9210B0;
	Fri, 21 Nov 2025 15:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763739536;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVGyEI6bOFOpROKHJf/pt/8yAnYTrIlHYbzMMeIdvSM=;
	b=lsVonA2VH0sKa2BnL+4mgWrlRToe6MgdwjEV40dDTXWPbMMPhT37e9UNmy0i4VRbElmQE7
	2cfD0yvutWyqTUTxwQSBQC5Ue2BoqiJ1/f5TMLUauOlClRuO/5V8j0eEvrYCqmuQTOS8ET
	0tgCPCtA0ZaI3S/MuKF1Ci+2kp7YH1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763739536;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVGyEI6bOFOpROKHJf/pt/8yAnYTrIlHYbzMMeIdvSM=;
	b=GNXBiieIJ1qepmmhQK37ZMyIZEhUri5Oz6nfyIqCfuNHaAyVA/sGi9Vo13htjZswJMkHPq
	9GDgG1iX5tirNnAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lsVonA2V;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GNXBiieI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763739536;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVGyEI6bOFOpROKHJf/pt/8yAnYTrIlHYbzMMeIdvSM=;
	b=lsVonA2VH0sKa2BnL+4mgWrlRToe6MgdwjEV40dDTXWPbMMPhT37e9UNmy0i4VRbElmQE7
	2cfD0yvutWyqTUTxwQSBQC5Ue2BoqiJ1/f5TMLUauOlClRuO/5V8j0eEvrYCqmuQTOS8ET
	0tgCPCtA0ZaI3S/MuKF1Ci+2kp7YH1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763739536;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVGyEI6bOFOpROKHJf/pt/8yAnYTrIlHYbzMMeIdvSM=;
	b=GNXBiieIJ1qepmmhQK37ZMyIZEhUri5Oz6nfyIqCfuNHaAyVA/sGi9Vo13htjZswJMkHPq
	9GDgG1iX5tirNnAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 243B13EA62;
	Fri, 21 Nov 2025 15:38:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mVKuCJCHIGmkWgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 21 Nov 2025 15:38:56 +0000
Date: Fri, 21 Nov 2025 16:38:50 +0100
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 1/4] btrfs: make sure all ordered extents beyond EOF
 is properly truncated
Message-ID: <20251121153850.GP13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1763629982.git.wqu@suse.com>
 <5960f3429b90311423a57beff157494698ab1395.1763629982.git.wqu@suse.com>
 <CAL3q7H6pV-pb6T70aOATXc2VBvA0PJZJcoo+B-SzK48qxzyqbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H6pV-pb6T70aOATXc2VBvA0PJZJcoo+B-SzK48qxzyqbg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 3A1A9210B0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21

On Fri, Nov 21, 2025 at 11:55:58AM +0000, Filipe Manana wrote:
> > +               /*
> > +                * We have just run delalloc before getting here, so there must
> > +                * be an ordered extent.
> > +                */
> > +               ASSERT(ordered != NULL);
> > +               scoped_guard(spinlock, &inode->ordered_tree_lock) {
> > +                       set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
> > +                       ordered->truncated_len = min(ordered->truncated_len,
> > +                                                    cur - ordered->file_offset);
> > +               }
> 
> I thought we had not made a decision yet to not use this new fancy locking yet.
> In this case where it's a very short critical section, it doesn't
> bring any advantage over using explicit spin_lock/unlock, and adds one
> extra level of indentation.

Agreed, this looks like an anti-pattern of the scoped locking.

