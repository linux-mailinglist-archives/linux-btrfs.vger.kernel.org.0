Return-Path: <linux-btrfs+bounces-11971-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE855A4B9BE
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 09:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8671890EAD
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 08:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571581E5701;
	Mon,  3 Mar 2025 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eaDURMmO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e45Q63On";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IEpbM+Vu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EwNiZB9F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA3018FC6B
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Mar 2025 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991645; cv=none; b=knEozE0+c/kijoOFPLPRkJ6elKR+VyRD0EBhmTX2MPcjJIydV7E3IwPkt+WWXLTWqNmgeDOjMbNYQ4oVrvjlMhX25ssC5azMaMedVnWvSM3GuzO+zK6sXpADTIah+V4uT+viQz+b7U8Q8P1kvbHxjajIINKoVOYy3/G9KbTZhJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991645; c=relaxed/simple;
	bh=UqfrES/xlPpcrHbDRz6/0EB9bIlsKXbnE0RUNGwpc6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2n+weEHtc6J0tVhPgHYba9R8hJxMsrnRKhmHC4p/IjiGNyBsavCDBdk89Y259NK/olfM1ZgZ686jsByBMnSJwRYUptEV5nT2VHxuDnT0jIaFEqhOVTOxArHKAT44PIBwijdl9t/kXKuNbVco+ugjlnez1X2ykE6biVLbAthXdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eaDURMmO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e45Q63On; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IEpbM+Vu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EwNiZB9F; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D9EA721171;
	Mon,  3 Mar 2025 08:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740991642;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PHl8mX/kSy4Pb8ScFdkyXjzvcW8c7YdMc20xtAOYfv4=;
	b=eaDURMmOl6GO9QHgtgxw59jptUsPfBfusNj5ql2vVTA8VtKNPbID5QBa8i5Y1ky1LSGREF
	OgH5nnuBcJxx5/Gnc5Tpe3NJx+ialpUfV+wJo0YPRijdHAn6xjKLqrAuzI20dBqXchbZCR
	MFt5TN0Hlv2nmeZFIPGjl5IKNfmAv6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740991642;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PHl8mX/kSy4Pb8ScFdkyXjzvcW8c7YdMc20xtAOYfv4=;
	b=e45Q63OnDFR6FG4iVhLNG15MpnSG3L3GhgehzLEghDOhwnMgGSUMDd9QORWcrmQOMufOjV
	FGMjRuh8mV1X4JCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740991640;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PHl8mX/kSy4Pb8ScFdkyXjzvcW8c7YdMc20xtAOYfv4=;
	b=IEpbM+VuEHDboKrA5LAAh5qhvubLNVtJY3ew/LMv2T0V0xUJbvqC1z3+czMNkUcqdh+2Nm
	9XJCQvv7tPd/rSIsyg+xrgSAer1jLGemgp8sJVVw379ve2+7oyCfpwSsiEbgRsS5JIxFwc
	PsgQYiV/UisRPClo7jAuuVFDg4UxHOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740991640;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PHl8mX/kSy4Pb8ScFdkyXjzvcW8c7YdMc20xtAOYfv4=;
	b=EwNiZB9FqGgQorvTjzDsUJgVSSYoPlI+nX5P/b7OdGiwsctnyLdAI2QCkPP0ukGNeocPXq
	p6TFn47fnJeovICA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDEF913939;
	Mon,  3 Mar 2025 08:47:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Mo7TLZhsxWc7cwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 03 Mar 2025 08:47:20 +0000
Date: Mon, 3 Mar 2025 09:47:19 +0100
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/5] btrfs: add new ioctl CLEAR_FREE
Message-ID: <20250303084719.GS5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1740753608.git.dsterba@suse.com>
 <ecc43a72997ae7836c2d227b69924d364698e665.1740753608.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecc43a72997ae7836c2d227b69924d364698e665.1740753608.git.dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Fri, Feb 28, 2025 at 03:49:31PM +0100, David Sterba wrote:
> @@ -1200,6 +1218,8 @@ enum btrfs_clear_op_type {
>  				   struct btrfs_ioctl_vol_args_v2)
>  #define BTRFS_IOC_LOGICAL_INO_V2 _IOWR(BTRFS_IOCTL_MAGIC, 59, \
>  					struct btrfs_ioctl_logical_ino_args)
> +#define BTRFS_IOC_CLEAR_FREE _IOW(BTRFS_IOCTL_MAGIC, 90, \
> +				struct btrfs_ioctl_clear_free_args)

This will be moved to the end and renumbered to nr. 66. This just shows
the age of the patchset when this was the last one.

>  #define BTRFS_IOC_GET_SUBVOL_INFO _IOR(BTRFS_IOCTL_MAGIC, 60, \
>  				struct btrfs_ioctl_get_subvol_info_args)
>  #define BTRFS_IOC_GET_SUBVOL_ROOTREF _IOWR(BTRFS_IOCTL_MAGIC, 61, \
> -- 
> 2.47.1
> 

