Return-Path: <linux-btrfs+bounces-10268-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 338949ED882
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 22:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B680A1619F6
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 21:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C1C1EC4C3;
	Wed, 11 Dec 2024 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nrv0FbFu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V2MaSrnc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nrv0FbFu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V2MaSrnc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B021E9B32
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 21:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952383; cv=none; b=UsKIjBJenRNfcAanhe+xn1bB8w9LLS/n6aWGrrtLUjO2S8RqorYVVyDOr6DRAbmQp3JFuiHQREm2Sdf+U3mkKhXvgsdWfJftqFzF8JXzROjVFOxba3VMkD0aRFkSUo22JZXgyh/kNLGZl6Gho0J7FwC51SY0OTyz62yaPoDpK7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952383; c=relaxed/simple;
	bh=Ml9pOMh14snCpL3/AxJPY0pPoQz+ajNxV4vAOphsCaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPD7hMVL+6DMwhmrPk8OH/UupdMajzcWeZHv5/1w5sSykbtkzGKt6cr+JRYIzYcVd7lUxl3a//tmahapst4l/W26pTA31ufJp2j+xJJHUbRbvledNCKN9B1nSn1jxoI7UyrmDrz+Z3RvQ6ZV8cK5RW8E+FBUZHWBuWxUmo7B+go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nrv0FbFu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V2MaSrnc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nrv0FbFu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V2MaSrnc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 850D521168;
	Wed, 11 Dec 2024 21:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733952379;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I9t52aNN1WA38YeqAzxTq1mhfjrN7Dt0kB/Wf/DtE4A=;
	b=Nrv0FbFuI+O+SGHfAysYzS82JodrYMzFynAecDKT0MlSo37AmLRp6cpkqxaXCq/TG0fq9w
	qZZZSZP3ORzaxRaRqIe9Ob7CO2QVLz+R27lfp9JW0JXK36mLPc3VNZ1dq9+RKdbDJ89vwG
	PUIqGqqJVq5yxsJVaNaOVzrYZ18AW5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733952379;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I9t52aNN1WA38YeqAzxTq1mhfjrN7Dt0kB/Wf/DtE4A=;
	b=V2MaSrncSy+tj4q/ywEQZbr04qsuwTy/xy9IRTHOoHPQcveHDnrOgGfqBL7qLiDoCexSFP
	w2cJ+1DzSvWfG5DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Nrv0FbFu;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=V2MaSrnc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733952379;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I9t52aNN1WA38YeqAzxTq1mhfjrN7Dt0kB/Wf/DtE4A=;
	b=Nrv0FbFuI+O+SGHfAysYzS82JodrYMzFynAecDKT0MlSo37AmLRp6cpkqxaXCq/TG0fq9w
	qZZZSZP3ORzaxRaRqIe9Ob7CO2QVLz+R27lfp9JW0JXK36mLPc3VNZ1dq9+RKdbDJ89vwG
	PUIqGqqJVq5yxsJVaNaOVzrYZ18AW5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733952379;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I9t52aNN1WA38YeqAzxTq1mhfjrN7Dt0kB/Wf/DtE4A=;
	b=V2MaSrncSy+tj4q/ywEQZbr04qsuwTy/xy9IRTHOoHPQcveHDnrOgGfqBL7qLiDoCexSFP
	w2cJ+1DzSvWfG5DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 689C11344A;
	Wed, 11 Dec 2024 21:26:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /PBAGXsDWmfcLAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 11 Dec 2024 21:26:19 +0000
Date: Wed, 11 Dec 2024 22:26:14 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: kernel test robot <lkp@intel.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] btrfs: enhance ordered extent double freeing detection
Message-ID: <20241211212614.GV31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <53b793f2e7a7788f89cda97de565cfc1577cbf75.1733890357.git.wqu@suse.com>
 <202412120136.6OwbbtZf-lkp@intel.com>
 <2e8ec0ba-aaa8-4107-9fbe-b3288a45f5a6@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e8ec0ba-aaa8-4107-9fbe-b3288a45f5a6@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 850D521168
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmx.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Thu, Dec 12, 2024 at 06:17:37AM +1030, Qu Wenruo wrote:
> >>> fs/btrfs/ordered-data.c:200:10: error: no member named 'finished_bitmap' in 'struct btrfs_ordered_extent'
> >       200 |                 entry->finished_bitmap = bitmap_zalloc(
> >           |                 ~~~~~  ^
> 
> I don't know why but it looks like IS_ENABLED() is not exactly doing the
> #ifdef #endif, thus those checks are not fully skipped in this case.

It's never been equvalent to ifdef/endif, it evaluates to 0 or 1 if the
config option is enabled or not but otherwise the source code is still
compiled. The compiler then finds out it's dead code and eliminates it.

