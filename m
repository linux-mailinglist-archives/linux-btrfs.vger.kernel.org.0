Return-Path: <linux-btrfs+bounces-10904-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 464A6A0971B
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 17:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E87165B8C
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 16:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0037D212D7C;
	Fri, 10 Jan 2025 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m7/7yMqB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V/0v9K3y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m7/7yMqB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V/0v9K3y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB7F211A19
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736526064; cv=none; b=RID3hWbhe9jrzLkKw/iBgYj0JfY8Zkznra4GbgMU3LBOWmUeIM09KdNgj+JWpPcu9i5A9XTwkXby0zgbQCbWOwxfoDIYaZHprZMiQI2lj4s0Z8fZTxHrQX4wSx7MKo63f/9HttfAW9WtZhNuOLuAL7p9gYu28yhH5eI11qB6nbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736526064; c=relaxed/simple;
	bh=5Q1XbHKpBPiSsQrGKZ+vwy9UnVzUTdjLpW1Ut41+IYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpRRMgQofDTtCPMcnHpF3TGoVPr5LGjbYnR7wntyxSKlnLPr1nlYX68Ea+3GLW5hVK7pPq+I5bLLNnpxBvu4h/7ufDtcKu8thoL5WXJ5aZyMNJe9EXM5ac7lmdcombreDItVgZSoIfIG2/rtpVhSxMBcwfX0i9Rs3juV5trhHXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m7/7yMqB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V/0v9K3y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m7/7yMqB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V/0v9K3y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0841321175;
	Fri, 10 Jan 2025 16:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736526060;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ws1A1UfJTi7ryGCnemWG84gzzr6MTRxODPjfhBaXcw0=;
	b=m7/7yMqBGESRgE3Sb7qaHg8oHF0c49dRgLaqaklfrMsp4MOTigh0kPDKQtnCW1CvehhEfi
	dNVD4WUJxsrLsLYsCdKmTlBq5hY2y68idFvLtpjpky9y/iy/qkY2mw1++cEgsbRmhrFPne
	iIxQBrjVJ7sLpC8nj3ppm6UZYbnWiLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736526060;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ws1A1UfJTi7ryGCnemWG84gzzr6MTRxODPjfhBaXcw0=;
	b=V/0v9K3yNkQJ+ybcrjFZMXb9u+MWRKnkBGHfwDwvk4b9bvBimjcq2M9NQ94zc3joMSjIKN
	FO+26fEyWgmHdXCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736526060;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ws1A1UfJTi7ryGCnemWG84gzzr6MTRxODPjfhBaXcw0=;
	b=m7/7yMqBGESRgE3Sb7qaHg8oHF0c49dRgLaqaklfrMsp4MOTigh0kPDKQtnCW1CvehhEfi
	dNVD4WUJxsrLsLYsCdKmTlBq5hY2y68idFvLtpjpky9y/iy/qkY2mw1++cEgsbRmhrFPne
	iIxQBrjVJ7sLpC8nj3ppm6UZYbnWiLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736526060;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ws1A1UfJTi7ryGCnemWG84gzzr6MTRxODPjfhBaXcw0=;
	b=V/0v9K3yNkQJ+ybcrjFZMXb9u+MWRKnkBGHfwDwvk4b9bvBimjcq2M9NQ94zc3joMSjIKN
	FO+26fEyWgmHdXCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB99213A86;
	Fri, 10 Jan 2025 16:20:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r95JOetIgWdvGAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 10 Jan 2025 16:20:59 +0000
Date: Fri, 10 Jan 2025 17:20:58 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH v3 08/10] btrfs: add extra error messages for delalloc
 range related errors
Message-ID: <20250110162058.GC12628@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1736479224.git.wqu@suse.com>
 <ac9345c0d31fc1b669ccfe436e49883ed998ab07.1736479224.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac9345c0d31fc1b669ccfe436e49883ed998ab07.1736479224.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Fri, Jan 10, 2025 at 02:01:39PM +1030, Qu Wenruo wrote:
> @@ -1561,6 +1570,13 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
>  				  PAGE_SIZE, bio_ctrl, i_size);
>  	if (ret == 1)
>  		return 0;
> +	if (ret < 0)
> +		btrfs_err_rl(fs_info,
> +"failed to submit blocks, root=%lld inode=%llu folio=%llu submit_bitmap=%*pbl: %d",
> +			     BTRFS_I(inode)->root->root_key.objectid,
> +			     btrfs_ino(BTRFS_I(inode)),
> +			     folio_pos(folio), fs_info->sectors_per_page,
> +			     &bio_ctrl->submit_bitmap, ret);

I've merged my cleanup series, and there will be a minor conflict in
this hunk,

@@ -1565,8 +1565,7 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
        if (ret < 0)
                btrfs_err_rl(fs_info,
 "failed to submit blocks, root=%lld inode=%llu folio=%llu submit_bitmap=%*pbl: %d",
-                            BTRFS_I(inode)->root->root_key.objectid,
-                            btrfs_ino(BTRFS_I(inode)),
+                            inode->root->root_key.objectid, btrfs_ino(inode),
                             folio_pos(folio), fs_info->sectors_per_page,
                             &bio_ctrl->submit_bitmap, ret);
---

