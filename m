Return-Path: <linux-btrfs+bounces-12238-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACE0A5DE9F
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 15:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C533A8620
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 14:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767A224BD00;
	Wed, 12 Mar 2025 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UB+GQ9Ls";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="218Cu5L2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z0TM6E07";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Cq55B62"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584D01E48A
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Mar 2025 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741788502; cv=none; b=H0Sxal6HTufxI3Yk8tJsAN+84UZc65e5oKYBLqF2VxKVtUWLa3EEdPjwUtbxw3a8BVSlx7ub9BqYQEa0GbranL7YT+xMFfddBIt7veuV9HQ2/JWtdeql6ocvU51LkwAw8FTuPLPzlD4IDMDcaPC2OIyIRkA+iiWWdPS8wuTrzo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741788502; c=relaxed/simple;
	bh=ukfCVCq+k90nHPMJOucKEG9b3D2idFa8Zmzqdwj2Fvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+YryRf1khm7WtOGWrwjhn3OJBggS0s8+qySNdu/lLkB6NcIFOFzO0z8g8l03bUdgMcLusqLJhVgk4BPU/4lTb63BDxmnsxte3wyybVy+xKMlOuZw9hlamXzOB/U1A2HlM/BdXKtqtO2RbGmbeFhi11PAdcA+nJI9ufsj90oXM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UB+GQ9Ls; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=218Cu5L2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z0TM6E07; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Cq55B62; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3A1D621167;
	Wed, 12 Mar 2025 14:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741788494;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IHtwZOkZVuUbmcHk+ZL659DUryKe8N5ez/23Ru3XSQQ=;
	b=UB+GQ9LsTmbPSD911cE0Orx+tg1v9YyuhL6EnaYWPLDoxjtxZaK7z/InWf7CjB4XRvbkdQ
	8rvlfZBaYKYeRpU3OmvBcsX9DzIzWsNMk0p46iXg+esQzoEyRVNWrfQdd52K+zEj7lYyTu
	Pa5WxgCD+G0C4TZm7D7zutnNcJkg6fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741788494;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IHtwZOkZVuUbmcHk+ZL659DUryKe8N5ez/23Ru3XSQQ=;
	b=218Cu5L2eXBERq+p2Yt+L2y1xCLJJm66HivR8Fain+iP2KhndhwLTxyfuAFZFCz2Dc4RU2
	81J5Jt29fEnYrmBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Z0TM6E07;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2Cq55B62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741788493;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IHtwZOkZVuUbmcHk+ZL659DUryKe8N5ez/23Ru3XSQQ=;
	b=Z0TM6E07BOt1W74Ltv4W7R0palf3D4f7Ux/Ixx/vDz/+5gQshuXzngeW1HFcg0A0BKl7cP
	55nkzt1DB/20ESaet0/JL4rLsK2ZBUYNLLn3ZHByiUlsL4/lzp3vgenfj9osO6r9IGPUIy
	+k1VoufZ7j/fshQMhuE1RDT0p8GdXiQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741788493;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IHtwZOkZVuUbmcHk+ZL659DUryKe8N5ez/23Ru3XSQQ=;
	b=2Cq55B62bO/1REL5RbIvQ8QB32rJ2+Tj0Qsr0gxeOrSFbv65Jkvi6HWjHPXoIMKEPHsTef
	EYx1wWBMFtGia0Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19EFC1377F;
	Wed, 12 Mar 2025 14:08:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lkkSBk2V0WcCcQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 12 Mar 2025 14:08:13 +0000
Date: Wed, 12 Mar 2025 15:08:07 +0100
From: David Sterba <dsterba@suse.cz>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>,
	wqu@suse.com
Subject: Re: [PATCH 2/2] btrfs: kill EXTENT_FOLIO_PRIVATE
Message-ID: <20250312140807.GO32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1741631234.git.rgoldwyn@suse.com>
 <9ebfbb2024c3c4bfb334a37cde0ecb0c4e26ee5c.1741631234.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ebfbb2024c3c4bfb334a37cde0ecb0c4e26ee5c.1741631234.git.rgoldwyn@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 3A1D621167
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[suse.cz:query timed out];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[suse.cz:query timed out];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim,twin.jikos.cz:mid]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Mar 10, 2025 at 03:29:07PM -0400, Goldwyn Rodrigues wrote:
> @@ -1731,30 +1711,7 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
>  	 */
>  	bio_ctrl->submit_bitmap = (unsigned long)-1;
>  
> -	/*
> -	 * If the page is dirty but without private set, it's marked dirty
> -	 * without informing the fs.
> -	 * Nowadays that is a bug, since the introduction of
> -	 * pin_user_pages*().
> -	 *
> -	 * So here we check if the page has private set to rule out such
> -	 * case.
> -	 * But we also have a long history of relying on the COW fixup,
> -	 * so here we only enable this check for experimental builds until
> -	 * we're sure it's safe.
> -	 */
> -	if (IS_ENABLED(CONFIG_BTRFS_EXPERIMENTAL) &&
> -	    unlikely(!folio_test_private(folio))) {
> -		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> -		btrfs_err_rl(fs_info,
> -	"root %lld ino %llu folio %llu is marked dirty without notifying the fs",
> -			     inode->root->root_key.objectid,
> -			     btrfs_ino(inode), folio_pos(folio));
> -		ret = -EUCLEAN;
> -		goto done;
> -	}
> -
> -	ret = set_folio_extent_mapped(folio);
> +	ret = btrfs_set_folio_subpage(folio);

The removed part is from a recent patch "btrfs: reject out-of-band dirty
folios during writeback" to make sure we don't really need the fixup
worker. So with the rework to remove EXTENT_FOLIO_PRIVATE it's changing
the logic a again. I'm not sure we should do both in one release, merely
from the point of caution and making 2 changes at once.

I can keep the 2 patches in misc-next and move them to for-next once the
6.15 pull request is out so you don't have to track them yourself.

Also question to Qu, if you think the risk is minimal we can take both
changes now.

