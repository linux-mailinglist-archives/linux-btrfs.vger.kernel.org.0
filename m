Return-Path: <linux-btrfs+bounces-9103-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59B19AD44D
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 20:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A5C1C21904
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 18:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F76A1D14E4;
	Wed, 23 Oct 2024 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lN1avmHx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JnavtVbm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lN1avmHx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JnavtVbm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C051CC170
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2024 18:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729709621; cv=none; b=X0C7WnvmM4R6bQDnMr/Cf6cPAbvf+Z2VDFq2CCuvWANwsvCCvXSs2ZNsWEj1hDAZPMOWrO+JkbhEJLZbWvTI7Prc42mVdQwDO5h7BjvJ1BAclNsefuOjXHUZY5HbOUAmuCoHDdf+KkJp+By9UeJQXHy+WG4PjMx6tSkUW/X0rlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729709621; c=relaxed/simple;
	bh=p4uyfLrzTdtcRbyoDn8Wxgihhz9/233wIkDCG94BK8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYb3z32lwP2g7f9dBDX/qyV1cz/GDdPn4tJMyH3bq005wZJ8zUHHaf2W7gxlk3Q7HbVbNN++06+rl3G+t0DoSFgJFANyTvBR3ns1pqRrTNDdeKdPJ+SL+1MuXIRYDVtOBHu06I6gERTsU2GIkQg9olV0r4DTYRQ3sVsy8HyNW1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lN1avmHx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JnavtVbm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lN1avmHx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JnavtVbm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D6E121CCD;
	Wed, 23 Oct 2024 18:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729709618;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CCyjqh4pAA4OywtQ4mvzYxl9qDb1KOjHggIOSt19DU4=;
	b=lN1avmHxS6cgE0syTNKqqe5jiwZZ0e4Gi63IN5hvBPcJ9GYAS4yDQU3mg/88Hubt7rPGjf
	wbNyEJAPq/xuJUIdptjrUEvLhJK3K/pw52l0WuCbauWWmKcGcfN0BJ5IPkn2uOdMy/HPRP
	l8xjrlnuDK5t5ZhhgQTXtb2QHKsvZCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729709618;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CCyjqh4pAA4OywtQ4mvzYxl9qDb1KOjHggIOSt19DU4=;
	b=JnavtVbmePOJr4MjAf5Txyk63HD4Jhn5vvLPnQYccfMc/lnblpToStQ4PxS/LfT1e5PWqq
	MrGrWRhy4HpcvbCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729709618;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CCyjqh4pAA4OywtQ4mvzYxl9qDb1KOjHggIOSt19DU4=;
	b=lN1avmHxS6cgE0syTNKqqe5jiwZZ0e4Gi63IN5hvBPcJ9GYAS4yDQU3mg/88Hubt7rPGjf
	wbNyEJAPq/xuJUIdptjrUEvLhJK3K/pw52l0WuCbauWWmKcGcfN0BJ5IPkn2uOdMy/HPRP
	l8xjrlnuDK5t5ZhhgQTXtb2QHKsvZCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729709618;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CCyjqh4pAA4OywtQ4mvzYxl9qDb1KOjHggIOSt19DU4=;
	b=JnavtVbmePOJr4MjAf5Txyk63HD4Jhn5vvLPnQYccfMc/lnblpToStQ4PxS/LfT1e5PWqq
	MrGrWRhy4HpcvbCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E054313A63;
	Wed, 23 Oct 2024 18:53:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9DpFNjFGGWeqYwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 23 Oct 2024 18:53:37 +0000
Date: Wed, 23 Oct 2024 20:53:32 +0200
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v5 2/2] btrfs: implement self-tests for partial RAID
 srtipe-tree delete
Message-ID: <20241023185332.GE31418@suse.cz>
Reply-To: dsterba@suse.cz
References: <20241023132518.19830-1-jth@kernel.org>
 <20241023132518.19830-3-jth@kernel.org>
 <CAL3q7H7houfrJjOOnmpA6T4xQDa-y1AqsA1AKBQZuOV4ygUVMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7houfrJjOOnmpA6T4xQDa-y1AqsA1AKBQZuOV4ygUVMA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Oct 23, 2024 at 06:45:49PM +0100, Filipe Manana wrote:
> On Wed, Oct 23, 2024 at 2:25 PM Johannes Thumshirn <jth@kernel.org> wrote:
> > +                                          &io_stripe);
> > +       if (!ret) {
> > +               ret = -EINVAL;
> > +               test_err("lookup of RAID extent [%llu, %llu] succeeded, should fail",
> > +                        logical, logical + SZ_32K);
> > +               goto out;
> > +       }
> > +
> > +       ret = btrfs_delete_raid_extent(trans, logical + SZ_32K, SZ_32K);
> > +       btrfs_put_bioc(bioc);
> > + out:
> 
> The btrfs_put_bioc(bioc) call needs to be put under the 'out' label,
> otherwise we will leak it in case an error happens.
> It is correct in the next test function, but not in this one.

Fixed in for-next, thanks.

