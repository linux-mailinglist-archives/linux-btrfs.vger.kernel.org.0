Return-Path: <linux-btrfs+bounces-20297-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DD6D05EDF
	for <lists+linux-btrfs@lfdr.de>; Thu, 08 Jan 2026 20:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33CB6300EE46
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 19:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2972732B9AA;
	Thu,  8 Jan 2026 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1tgoGvWe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+ymlF32j";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1tgoGvWe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+ymlF32j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10787326944
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767902152; cv=none; b=aIR9LlxqniUvZYxETisJbAUm2QAwxp/lPwtEgvmp2s5GwZSdQS1HnnURoSjl5Vnn+uLLgGVTudBzoKxHG4E0gHl5HVeGDh/8SPkz7NppWhPtpGknkqmbQKYBzuCaWC1NyW0dbY9UeBwuGRn3rsaK+sces6tz9AL2Qx8+PwzIdH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767902152; c=relaxed/simple;
	bh=G/8qM/LUXOiV9KzHYxFmGMS+vNcKeD4KlRuB8V+1WC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ho9Y2rXaYzfAV7CbsZ4wjXyhXke+YXI8vl/iE7zKyogXYNIxFhaQZ84gaceJIZP0qltZ1U+wtWS8AcYyhyE6hSxnsxgYMMcTG9YgXhrz8KnqIISgr07Wmci67owwN+Ee8q55T4SwcfWSep3ZjuMpj01LSdo/AAa3WmrhirfoEVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1tgoGvWe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+ymlF32j; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1tgoGvWe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+ymlF32j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 46F1834948;
	Thu,  8 Jan 2026 19:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767902149;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wqitaupfwl8pdHkaQaGRYip14ObW2iqhqXepCKFaSNg=;
	b=1tgoGvWey+GvoMZ8o6n3Y1IkfefIwASCnRpageFJtTNCKhDdWHrKvtZdX+3gSb3al6lpuO
	FWT8/i2jTuLiiWEqcIkV92S46ZXOsXccnp+/iBuiaTCnpAMfMOtdU0tgcGqxcN6kfiRmmx
	ELvVVszmMNBUtxcmJv1UfHCEFk1u81Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767902149;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wqitaupfwl8pdHkaQaGRYip14ObW2iqhqXepCKFaSNg=;
	b=+ymlF32jMk4e+gw0EbMDMXtd2qv9akm8+oxrIU9eBv9WhSRyJKjmJvdRZSTdbS6vYoDHWD
	rqiba/Pa59e1oeCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767902149;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wqitaupfwl8pdHkaQaGRYip14ObW2iqhqXepCKFaSNg=;
	b=1tgoGvWey+GvoMZ8o6n3Y1IkfefIwASCnRpageFJtTNCKhDdWHrKvtZdX+3gSb3al6lpuO
	FWT8/i2jTuLiiWEqcIkV92S46ZXOsXccnp+/iBuiaTCnpAMfMOtdU0tgcGqxcN6kfiRmmx
	ELvVVszmMNBUtxcmJv1UfHCEFk1u81Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767902149;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wqitaupfwl8pdHkaQaGRYip14ObW2iqhqXepCKFaSNg=;
	b=+ymlF32jMk4e+gw0EbMDMXtd2qv9akm8+oxrIU9eBv9WhSRyJKjmJvdRZSTdbS6vYoDHWD
	rqiba/Pa59e1oeCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B50A3EA63;
	Thu,  8 Jan 2026 19:55:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ohQgCsULYGmqBQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 08 Jan 2026 19:55:49 +0000
Date: Thu, 8 Jan 2026 20:55:47 +0100
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: split btrfs_fs_closing() and change return type
 to bool
Message-ID: <20260108195547.GH21071@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20260106123028.3105367-1-dsterba@suse.com>
 <CAL3q7H40sMw0H7Z73mhReRB6FzdsRW6tnjG7tRdHjZfKkC0ucQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H40sMw0H7Z73mhReRB6FzdsRW6tnjG7tRdHjZfKkC0ucQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.989];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Tue, Jan 06, 2026 at 05:00:46PM +0000, Filipe Manana wrote:
> On Tue, Jan 6, 2026 at 12:30 PM David Sterba <dsterba@suse.com> wrote:
> >
> > There are two tests in btrfs_fs_closing() but checking the
> > BTRFS_FS_CLOSING_DONE bit is done only in one place
> > load_extent_tree_free(). As this is an inline we can reduce size of the
> > generated code. The types can be also changed to bool as this becomes a
> > simple condition.
> 
> Can you mention here how much was the reduction?

   text    data     bss     dec     hex filename
   1674006  146704   15560 1836270  1c04ee pre/btrfs.ko
   1673772  146704   15560 1836036  1c0404 post/btrfs.ko

   DELTA: -234

The code seems to be reorganized in bigger blocks where the unlikely
hint applies and in summary it's shorter also due the function aligment
removals.

The stack diff is not notable:

  btrfs_qgroup_rescan_worker                  -8 (72 -> 64)
  btrfs_add_inode_defrag                      +8 (48 -> 56)

> > -static inline int btrfs_fs_closing(const struct btrfs_fs_info *fs_info)
> > +static inline bool btrfs_fs_closing(const struct btrfs_fs_info *fs_info)
> >  {
> > -       /* Do it this way so we only ever do one test_bit in the normal case. */
> > -       if (test_bit(BTRFS_FS_CLOSING_START, &fs_info->flags)) {
> > -               if (test_bit(BTRFS_FS_CLOSING_DONE, &fs_info->flags))
> > -                       return 2;
> > -               return 1;
> > -       }
> > -       return 0;
> > +       if (unlikely(test_bit(BTRFS_FS_CLOSING_START, &fs_info->flags)))
> > +               return true;
> > +
> > +       return false;
> 
> This can simply be:
> 
> return unlikely(test_bit(BTRFS_FS_CLOSING_START, &fs_info->flags));

Ah of course, thanks. I'll fix it for-next.

