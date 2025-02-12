Return-Path: <linux-btrfs+bounces-11424-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CD3A3334E
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 00:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88A3188B087
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 23:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3BF25E46B;
	Wed, 12 Feb 2025 23:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vL/KPy1Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lB+rsrmt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vL/KPy1Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lB+rsrmt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF25E24C692;
	Wed, 12 Feb 2025 23:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739402469; cv=none; b=hSjjoQnnHqH1/Qy+rUPgi9YjmAORx2MoM/FnZbfVJUO1wQ4EFxdFx48IMRTzhbbR5dsfMNpuhc3hN7ibqpbw1lVY+mbYa2gSlA62jERAmfqlZqk3IJIUfbSSS1ySKKusun0gL/dYOj2w5FtK+crS53z/fqJS4y12daqXKdX+76M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739402469; c=relaxed/simple;
	bh=6vA57+SnVQ7IcXb7xrdBjT5V+DmIuykUZ8ud0pW9v4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+IvDabaqLVZ1sphKfnx4MkaI0COdc72BDCdxtIXT0QGPilD3h5w0KRlSkntu47u7/a0qMyfOUluiYUlhcqnEpMAbXMMo+iexmZVkJliFTJR7slac5Fu2IELXh63eebOwiE4Hl0wMUD8QTT+6v7fEtyQi3fyntnt6v02gvxWh3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vL/KPy1Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lB+rsrmt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vL/KPy1Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lB+rsrmt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1BC0B22C4A;
	Wed, 12 Feb 2025 23:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739402465;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nl7Ij2Ygq+TMhheYgwnKzWPb9ujmG4EdpFUt6jzzOMc=;
	b=vL/KPy1Zf8aYzOD2LxSM5/XQ5nZMFsRH79BLWGhpAcRHY+CQ92LbZwTmmLmWgc74FeS3nl
	xxger3+WE7JbzQCDvQR8SovNm8oG1j7qOnaP39xJoNtxynJYwEvg8i9gqRKZrbAA1cxuNn
	aE1azqd2jGCsFLL11eL5tnddvEyiO7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739402465;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nl7Ij2Ygq+TMhheYgwnKzWPb9ujmG4EdpFUt6jzzOMc=;
	b=lB+rsrmtrHllem5+o97DBWZbvNsHhaQrNWwUmv5Abj4cZIPeEouxcB9A9QYEHAPf99LAcF
	kcJCIR1HHMV3U7CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="vL/KPy1Z";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lB+rsrmt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739402465;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nl7Ij2Ygq+TMhheYgwnKzWPb9ujmG4EdpFUt6jzzOMc=;
	b=vL/KPy1Zf8aYzOD2LxSM5/XQ5nZMFsRH79BLWGhpAcRHY+CQ92LbZwTmmLmWgc74FeS3nl
	xxger3+WE7JbzQCDvQR8SovNm8oG1j7qOnaP39xJoNtxynJYwEvg8i9gqRKZrbAA1cxuNn
	aE1azqd2jGCsFLL11eL5tnddvEyiO7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739402465;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nl7Ij2Ygq+TMhheYgwnKzWPb9ujmG4EdpFUt6jzzOMc=;
	b=lB+rsrmtrHllem5+o97DBWZbvNsHhaQrNWwUmv5Abj4cZIPeEouxcB9A9QYEHAPf99LAcF
	kcJCIR1HHMV3U7CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F12F313874;
	Wed, 12 Feb 2025 23:21:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y3GfOuAsrWcbWAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 12 Feb 2025 23:21:04 +0000
Date: Thu, 13 Feb 2025 00:21:03 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 7/8] btrfs/281: skip test when running with nodatasum
 mount option
Message-ID: <20250212232103.GY5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1739379182.git.fdmanana@suse.com>
 <39ba965d983d0344f605ff01744304ba579527af.1739379186.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39ba965d983d0344f605ff01744304ba579527af.1739379186.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 1BC0B22C4A
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Feb 12, 2025 at 05:01:55PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The test exercises compression and compression doesn't happen on inodes
> with checksums disabled (nodatasum), making the test fail the expectations
> if getting compressed extents. So skip the test if nodatasum is present.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

