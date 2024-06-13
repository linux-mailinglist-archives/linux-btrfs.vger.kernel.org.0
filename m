Return-Path: <linux-btrfs+bounces-5695-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B36905FD7
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 02:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15CBC2840A3
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 00:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEF38F62;
	Thu, 13 Jun 2024 00:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FEdM+Dxl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rOeIa6Ig";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FEdM+Dxl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rOeIa6Ig"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1D58BEC
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 00:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718239984; cv=none; b=KHDXaICCXDc+kpv8JSP4CYWdGOr0qBvmigj1dERwW5aLHcXCGmBhrtvFcs2TZH41NDNFgIpqrvUnOiUyZQOz1H9m1HNImsMlQC/PROdsrXBKXHlkejdFwFnxnvq1vY7o9UbRWrQ1j3zI3kBiF8ihBEuswc4KFr7UxZPjQ+3BVv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718239984; c=relaxed/simple;
	bh=ElR0GkD4XGgweFTpiMXtopMKws1dBllg32saqIcT2jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mINI7AOPEGFkrJ9fLNNpm1ew8OFqbV9reAxh3a8VQ4XCf66MwGvRjfck5ZYCMMS4OHpgWuc3nBEIKJXmq0LroURVHOie1NqbCO5B62/Zv/Q3bViDa/6wz33+EMMp3iqR+dcVljB8hDD35+PMlQhfeHQ0SGK/1rS3c9a8Na2+CII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FEdM+Dxl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rOeIa6Ig; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FEdM+Dxl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rOeIa6Ig; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0C10434BC8;
	Thu, 13 Jun 2024 00:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718239981;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pUU6opuocu21o75jmlZF6Pccru/GxQOb8nYlNIGYE60=;
	b=FEdM+DxlJcx4qxyZPzhhlHFr7wN+1gXSNlYEe4EMuA8aHSOj6Lo22E0iSYn8EkSlVC8E/Q
	jYi2ycXCk4fcUhlaNy+q6LpVv6b9UnUSbCIs4ooPIqs2hhL5wG9OQ8XUgGLmpvKtveegWM
	IWaXwY3pOQS2L7zvSSu6rAm9n0YGAsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718239981;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pUU6opuocu21o75jmlZF6Pccru/GxQOb8nYlNIGYE60=;
	b=rOeIa6IgtHrSSo1OW1bwbYOgdhplo9GPHc+8I1RhnAO3R+TCZTyks9Grqdx9WEYV6o6Ehn
	ZQJAJUw/MAbB1XBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718239981;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pUU6opuocu21o75jmlZF6Pccru/GxQOb8nYlNIGYE60=;
	b=FEdM+DxlJcx4qxyZPzhhlHFr7wN+1gXSNlYEe4EMuA8aHSOj6Lo22E0iSYn8EkSlVC8E/Q
	jYi2ycXCk4fcUhlaNy+q6LpVv6b9UnUSbCIs4ooPIqs2hhL5wG9OQ8XUgGLmpvKtveegWM
	IWaXwY3pOQS2L7zvSSu6rAm9n0YGAsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718239981;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pUU6opuocu21o75jmlZF6Pccru/GxQOb8nYlNIGYE60=;
	b=rOeIa6IgtHrSSo1OW1bwbYOgdhplo9GPHc+8I1RhnAO3R+TCZTyks9Grqdx9WEYV6o6Ehn
	ZQJAJUw/MAbB1XBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC77B137DF;
	Thu, 13 Jun 2024 00:53:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nUKmNexCambbZwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 13 Jun 2024 00:53:00 +0000
Date: Thu, 13 Jun 2024 02:52:55 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Srivathsa Dara <srivathsa.d.dara@oracle.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
	Junxiao Bi <junxiao.bi@oracle.com>, "clm@fb.com" <clm@fb.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"dsterba@suse.com" <dsterba@suse.com>
Subject: Re: [PATCH v2] btrfs-progs: convert: Add 64 bit block numbers support
Message-ID: <20240613005255.GU18508@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240606102215.3695032-1-srivathsa.d.dara@oracle.com>
 <c3060faf-f0e8-4bd2-865b-332e423a8801@gmx.com>
 <DM6PR10MB4347A0EADF68B973447C5591A0C72@DM6PR10MB4347.namprd10.prod.outlook.com>
 <20240612203743.GQ18508@twin.jikos.cz>
 <20240613000200.GS18508@twin.jikos.cz>
 <cd0fca3a-94bf-4913-882f-ee433a61e06f@gmx.com>
 <20240613002301.GT18508@twin.jikos.cz>
 <2d1a8153-274b-481e-bb0a-63504d1cbe01@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d1a8153-274b-481e-bb0a-63504d1cbe01@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]

On Thu, Jun 13, 2024 at 09:55:56AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/6/13 09:53, David Sterba 写道:
> [...]
> >>
> >> Any good idea to go forward?
> >> Update CI (which seems impossible) or make the mke2fs part as mayfail
> >> and skip it?
> >
> > I think using mayfail for mke2fs is the best option, I don't want to
> > check versions. The release of 1.46.5 is 2021-12-30, this is not that
> > old and likely widely used. Skipping the particular case is not a big
> > deal as it'll be covered on other testing instances.
> 
> Sounds good to me.
> 
> Just add an extra comment on the situation.
> 
> Although I really hope github CI can someday updates its infrastructures.

The updates happen from time to time, following Ubuntu LTS releases. The
upstream repository is https://github.com/actions/runner-images.

Now that I'm looking there it seems that 24.04 has been made available a
month ago but has to be selected explicitly, as ubuntu-latest is still
pointing to 22.

Kernel version is 6.8 and e2fsprogs is 1.47 so the update can fix that
and we don't have to do the workarounds. I'll do a test and update the
CI files if everythings works.

