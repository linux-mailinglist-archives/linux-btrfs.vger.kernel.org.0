Return-Path: <linux-btrfs+bounces-2329-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F536851770
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 16:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16135B20E95
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 15:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC1B3BB27;
	Mon, 12 Feb 2024 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pziNjwn+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0obzGFFE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pziNjwn+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0obzGFFE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4A6F9F6
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Feb 2024 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750007; cv=none; b=Z90EXBRWhFgI5Ln3DRyQy5TyqZINpXoKp8xKpZutbTbax/IMLZV5AF5TG/awAK7uZVyZzT7HFDXZBXpBO3yggz+y1oDCelfXFbqUhhsd33jclS9RNsMXZXzTuluisrJUuV2OdcplnJ/9/fVXutZpTIPzmVvelz7+Xmp3sTIIDPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750007; c=relaxed/simple;
	bh=tXufJa9hAAaO/r/0Dgmb9X6TlSHxLrHgeaiMUd3nbLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jnef4wzZcKeeZIZzvI5BqExfOXPInt3IUXtu4qFbfDMZ49xiQpUdEkALzt4vd6kRR+VjNegwFg+UVoLA0PxnU8ZP3crnboUDf4PbeLnbsPiczKLZotVQL7hPAFJ9gPkMDl091wlmJ7/ZkPiuk41Z9i+vd96ejSPxb/qb9dCJPP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pziNjwn+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0obzGFFE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pziNjwn+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0obzGFFE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C66AE1FD51;
	Mon, 12 Feb 2024 15:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707750003;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=INJ/Nrwr7+1AOt9r+nyYbkEZMTMuOlp1Qz+kbthfC2U=;
	b=pziNjwn+KJ44lSNQieYJ6BOdAyR2HbiEFZhM+nZ/OurawqqdWFcZoSuyGxl5xRnTXeOFc9
	aYq9k4142rpQoZH/wT4kAWXHi2ZvNk5yLISVR5r/qXVuTvqMh7dWx2KQo87IUE8G1eghmn
	eYEmDFtspNzG3ZyPF/aZqpbaBkkSyOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707750003;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=INJ/Nrwr7+1AOt9r+nyYbkEZMTMuOlp1Qz+kbthfC2U=;
	b=0obzGFFEJMtN5ObyzKcHvo/3wzbhEIJ5nO0tfCs/+Y4QeS9MNRseap65xm18IB+46W9GUB
	t95GCT2RPnCgBzAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707750003;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=INJ/Nrwr7+1AOt9r+nyYbkEZMTMuOlp1Qz+kbthfC2U=;
	b=pziNjwn+KJ44lSNQieYJ6BOdAyR2HbiEFZhM+nZ/OurawqqdWFcZoSuyGxl5xRnTXeOFc9
	aYq9k4142rpQoZH/wT4kAWXHi2ZvNk5yLISVR5r/qXVuTvqMh7dWx2KQo87IUE8G1eghmn
	eYEmDFtspNzG3ZyPF/aZqpbaBkkSyOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707750003;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=INJ/Nrwr7+1AOt9r+nyYbkEZMTMuOlp1Qz+kbthfC2U=;
	b=0obzGFFEJMtN5ObyzKcHvo/3wzbhEIJ5nO0tfCs/+Y4QeS9MNRseap65xm18IB+46W9GUB
	t95GCT2RPnCgBzAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AC83013212;
	Mon, 12 Feb 2024 15:00:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id G6fsKXMyymV3SgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 12 Feb 2024 15:00:03 +0000
Date: Mon, 12 Feb 2024 15:59:31 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, aromosan@gmail.com,
	bernd.feige@gmx.net
Subject: Re: [PATCH] btrfs: do not skip re-registration for the mounted device
Message-ID: <20240212145931.GD355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <8dd1990114aabb775d4631969f1beabeadaac5b7.1707132247.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dd1990114aabb775d4631969f1beabeadaac5b7.1707132247.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pziNjwn+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0obzGFFE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.24 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,gmail.com,gmx.net];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.03)[55.66%]
X-Spam-Score: -1.24
X-Rspamd-Queue-Id: C66AE1FD51
X-Spam-Flag: NO

On Mon, Feb 05, 2024 at 07:45:05PM +0800, Anand Jain wrote:
> We skip device registration for a single device. However, we do not do
> that if the device is already mounted, as it might be coming in again
> for scanning a different path.
> 
> This patch is lightly tested; for verification if it fixes.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> I still have some unknowns about the problem. Pls test if this fixes
> the problem.

Seems that we have that tested by some reportes, I checked it in my VM
setup that it works (fstests and grub2-probe) so let's add it to
for-next. Please use the changelog from my patch that describes the
problem and then add description of how you fixed it. Thanks.

