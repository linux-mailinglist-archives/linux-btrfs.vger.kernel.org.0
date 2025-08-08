Return-Path: <linux-btrfs+bounces-15938-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA015B1EC39
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 17:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C172A173AE5
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 15:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA44C283C93;
	Fri,  8 Aug 2025 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xK2xbWRs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZESQOkjn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xK2xbWRs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZESQOkjn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8659322FF39
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Aug 2025 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754667461; cv=none; b=bGy9hst7BN5gy9Qqfl0RyW8MPgfDiteTsxclxtDto2miRrG8Ipfct8OiC2W2lNRTAoof1qvC/PkI8OwRkpjM3r5mrEZnwEHTKtBKUpxONjQ4l4c5KzmHICSXyMEhUsN3bkufHWHzSoivxzzmab7e+F4vjWWJsgcDw3DHNb8BT00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754667461; c=relaxed/simple;
	bh=BRUF0BCAbwsbDV/Nbi3e64rOs7/fvNoKzFa9Y4kfuVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puPHKv7DpaeBVtTAnMfCzUSKaCgpkbSlIarEK6JzWMZwb4Dj0yveyV7NDcgL770pniL7FI/85WASKv+VOObYeisqyxB9fIcEfldRBuRsOo6PYLvntPFlosEtEznTg1mEaeddQnFwK4DTxivIS5hF/pD++DgNJ2aUmEJGTWUc0cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xK2xbWRs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZESQOkjn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xK2xbWRs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZESQOkjn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7549633E11;
	Fri,  8 Aug 2025 15:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754667457;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAJa6K6CuvKO3X/mn5Xm6hIwWsKDvO96c3nKdziol+M=;
	b=xK2xbWRsMzRzlZQZrh5gAHkGHlPUbAuIO512F1MRGDx3PMu1UGKrCMv3QRhf6Vse+pjRps
	+KQ/IhXgqVNJ6/z6euKoEf1TdUEbBpcFGMjjgIYZzIDkf1I5xjit6Q9hK9TEv9azwCFOkZ
	U9F1JFQVSYMh4/YAX7+A4oWIDfYm0DU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754667457;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAJa6K6CuvKO3X/mn5Xm6hIwWsKDvO96c3nKdziol+M=;
	b=ZESQOkjnP37dRUHQzArf9S5yO/QydHP6rzQVLru93jcvuUNzGccG97gHV4Q/qvdXt2xqVf
	n/dP6tF3VF3OJwAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xK2xbWRs;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZESQOkjn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754667457;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAJa6K6CuvKO3X/mn5Xm6hIwWsKDvO96c3nKdziol+M=;
	b=xK2xbWRsMzRzlZQZrh5gAHkGHlPUbAuIO512F1MRGDx3PMu1UGKrCMv3QRhf6Vse+pjRps
	+KQ/IhXgqVNJ6/z6euKoEf1TdUEbBpcFGMjjgIYZzIDkf1I5xjit6Q9hK9TEv9azwCFOkZ
	U9F1JFQVSYMh4/YAX7+A4oWIDfYm0DU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754667457;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAJa6K6CuvKO3X/mn5Xm6hIwWsKDvO96c3nKdziol+M=;
	b=ZESQOkjnP37dRUHQzArf9S5yO/QydHP6rzQVLru93jcvuUNzGccG97gHV4Q/qvdXt2xqVf
	n/dP6tF3VF3OJwAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FC171392A;
	Fri,  8 Aug 2025 15:37:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NAIvF8EZlmiKRgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 08 Aug 2025 15:37:37 +0000
Date: Fri, 8 Aug 2025 17:37:36 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
	Boris Burkov <boris@bur.io>
Subject: Re: [PATCH v2 5/6] btrfs-progs: add error handling for
 device_get_partition_size()
Message-ID: <20250808153736.GV6704@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1754455239.git.wqu@suse.com>
 <aaefe04f784bc601f355d13b3b0ecbde1aa44dee.1754455239.git.wqu@suse.com>
 <4c815239-7b65-4460-a27f-4b48b7244c71@oracle.com>
 <531a7c76-0b6e-454a-bb7a-3fc3ee0d95ee@oracle.com>
 <c709e1b3-f57a-4c34-bf28-d00694c01cc8@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c709e1b3-f57a-4c34-bf28-d00694c01cc8@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 7549633E11
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.21

On Fri, Aug 08, 2025 at 07:01:47PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/8/8 18:56, Anand Jain 写道:
> > On 8/8/25 15:23, Anand Jain wrote:
> >> On 6/8/25 12:48, Qu Wenruo wrote:
> >>> The function device_get_partition_size() has all kinds of error paths,
> >>> but it has no way to return error other than returning 0.
> >>>
> >>> This is not helpful for end users to know what's going wrong.
> >>>
> >>
> >>
> >>> Change that function to return s64, as even the kernel won't return a
> >>> block size larger than LLONG_MAX.
> >>> Thus we're safe to use the minus range of s64 to indicate an error.
> >>
> > 
> >> Returning s64 is almost unused in btrfs-progs; Either PTR_ERR() or
> >> int return + arg parameter * u64; Rest looks good.
> > 
> > correction: almost unused -> mostly avoided
> 
> @Boris, mind me to revert back to the old int + u64 *ret solution?

Please convert it to int return and *u64 for the parameter.

> Despite the fact that s64 is seldomly used in progs, I also feel a 
> little uneasy with the s64->u64 (all the extra ASSERT() I added) or the 
> s64->int error code conversion.

Yeah, size related things should stick to u64, differences use s64.

