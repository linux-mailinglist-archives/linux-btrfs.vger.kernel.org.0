Return-Path: <linux-btrfs+bounces-2528-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C0D85ABC9
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 20:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A078E285336
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 19:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F614F8A7;
	Mon, 19 Feb 2024 19:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ylizK438";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BKRi3Vm7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ylizK438";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BKRi3Vm7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25C44F60C
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708369855; cv=none; b=OvCvqpKFzJanffr8fBfJvCWqBezs0VxgL4nDPswxm2FdbAetSLpCh4y0t6hapNg5VFtv1kJ709bnlSGb+YTHBQvGMlkNPF3GBI879YC35bu5GrWelT4tmaUN1+VXBxcHiO3M8Q61Ebpzga313faZAb6ytxhQGyhC2UmiuVR1wYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708369855; c=relaxed/simple;
	bh=4LccE5qClJ/ClXJXFNQMHrkFVWzyBTYWVhRRp6Jnyl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obUQH19+Sv1GmUtVBfLwN1W/Ow1R6Hr4i6jrHdBq2I1I0zwCvQB60ZUrloDJc/x7fhwQ8kowVdLMTJck4vTMB0xgD6glRpZCbv/Mo7/uunwd1UTDKpZJJBjreb9LKOWCOyIYe9Qfe3ReG0/qYi0/nzTU9fcYFvTKdFuwJiwxnSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ylizK438; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BKRi3Vm7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ylizK438; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BKRi3Vm7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7B03F22165;
	Mon, 19 Feb 2024 19:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708369851;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=df4jRYL55dFZHvFTfs2Rn3gHvy4oIZ/q1cUHvbRMkgk=;
	b=ylizK4386jiStvxB2NEr+81Fow3piJw9SeNJtGAPJ0M6zHNOq3Z+FUMOh3VVjEgA+1+hRH
	nbBEN0gh+ILx51ZCR19VTqqhGMKiPekL8Hey7NKdcrGBlJcOeI9SxDDGvjpYZtWD02QWLV
	R3+rU94aoxSbNpVsu0Yqh9dLFJ8HXG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708369851;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=df4jRYL55dFZHvFTfs2Rn3gHvy4oIZ/q1cUHvbRMkgk=;
	b=BKRi3Vm7/ZqKPuoRakfHO8scEzGuQ6RsxMcoyzfbFfeUWAsFumLGLdg++4/6NTPDSgdHvo
	s3T/5o5zOL5cbOBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708369851;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=df4jRYL55dFZHvFTfs2Rn3gHvy4oIZ/q1cUHvbRMkgk=;
	b=ylizK4386jiStvxB2NEr+81Fow3piJw9SeNJtGAPJ0M6zHNOq3Z+FUMOh3VVjEgA+1+hRH
	nbBEN0gh+ILx51ZCR19VTqqhGMKiPekL8Hey7NKdcrGBlJcOeI9SxDDGvjpYZtWD02QWLV
	R3+rU94aoxSbNpVsu0Yqh9dLFJ8HXG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708369851;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=df4jRYL55dFZHvFTfs2Rn3gHvy4oIZ/q1cUHvbRMkgk=;
	b=BKRi3Vm7/ZqKPuoRakfHO8scEzGuQ6RsxMcoyzfbFfeUWAsFumLGLdg++4/6NTPDSgdHvo
	s3T/5o5zOL5cbOBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CDF5139C6;
	Mon, 19 Feb 2024 19:10:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ZUtpGrun02XKUAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 19 Feb 2024 19:10:51 +0000
Date: Mon, 19 Feb 2024 20:10:11 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: some optimizations for send
Message-ID: <20240219191011.GX355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1708260967.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1708260967.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ylizK438;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BKRi3Vm7
X-Spamd-Result: default: False [-0.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_NONE(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[30.09%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.01
X-Rspamd-Queue-Id: 7B03F22165
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Mon, Feb 19, 2024 at 11:59:29AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The following are two optimizations for send, one to avoid sending
> unnecessary holes (writes full of zeros), which can waste a lot of space
> at the receiver and increase stream size for cases where sparse files are
> used, such as images of thin provisioned filesystems for example as
> recently reported by a user. The second is just a small optimization to
> avoid repeating a btree search. More details in the respective change logs.
> 
> Filipe Manana (2):
>   btrfs: send: don't issue unnecessary zero writes for trailing hole
>   btrfs: send: avoid duplicated search for last extent when sending hole

Reviewed-by: David Sterba <dsterba@suse.com>

