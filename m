Return-Path: <linux-btrfs+bounces-3192-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7B587885A
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 19:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645591F21604
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 18:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D244559175;
	Mon, 11 Mar 2024 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PQLjN7Rq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vP+yZ5sM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PQLjN7Rq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vP+yZ5sM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0EF59162
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Mar 2024 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182949; cv=none; b=c5GzJzP2O8jBeOshkGBRMSy7knvdzB+RYXU/YPm67nZ55C9xUc0DXHwqqjlGhBxTno35oxC/ejVMe6hZkkBfl8cY1RsncXN+E7hMq8e58o9zILhB309FC5WXSaQt68iC66o8NUELTbNFiPCSAUI1QjGse9TgRlT3FDO45ypIiYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182949; c=relaxed/simple;
	bh=0dfVRSbag9n63PAjlLMe6G+Ju22njctKQwaS9DGcn5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKeOBZRnVMuqpiqjg6bf1E0BZ3LQcuFQdFdHJLsySi1YhuPJb63WdS0M+GGty14yWipU4xqRN1pRpinpKjrGBmn1FsMUi/09SHOkNS3vwqeLnTkN76SLsK66mQyVGhP7h5ctcUXVGXEyEazmG9HCH0IKzQg1+C/eA28Suau3EBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PQLjN7Rq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vP+yZ5sM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PQLjN7Rq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vP+yZ5sM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8C6BF5CA53;
	Mon, 11 Mar 2024 18:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710182945;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TMNtI8V2+HMm+mob5wLXpbpRoLPC7g/3ArIEpVpzGqY=;
	b=PQLjN7RqEUtgJf22dKAHp1E+PLzQHAngXYzm66FAl1AJwhmNArOqhGs96aJeIAKdlkh36E
	f6is6ennfS4na+JgyLcCFmcdM0W7uTsRedvF4SFTr+ST2UNrmqxXAujvWz4b+Qv7UxWJvp
	xXZ6M/XKT7xNWjkEIC3E1/SxMPa5JBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710182945;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TMNtI8V2+HMm+mob5wLXpbpRoLPC7g/3ArIEpVpzGqY=;
	b=vP+yZ5sM5jz1fxLN7maQZUUxl0QwSMoK8QCvEsacMwDGrQQPNXHmseL0i9Hu8DWI+R0oFU
	qAtz+3rN051shVAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710182945;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TMNtI8V2+HMm+mob5wLXpbpRoLPC7g/3ArIEpVpzGqY=;
	b=PQLjN7RqEUtgJf22dKAHp1E+PLzQHAngXYzm66FAl1AJwhmNArOqhGs96aJeIAKdlkh36E
	f6is6ennfS4na+JgyLcCFmcdM0W7uTsRedvF4SFTr+ST2UNrmqxXAujvWz4b+Qv7UxWJvp
	xXZ6M/XKT7xNWjkEIC3E1/SxMPa5JBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710182945;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TMNtI8V2+HMm+mob5wLXpbpRoLPC7g/3ArIEpVpzGqY=;
	b=vP+yZ5sM5jz1fxLN7maQZUUxl0QwSMoK8QCvEsacMwDGrQQPNXHmseL0i9Hu8DWI+R0oFU
	qAtz+3rN051shVAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DCC313695;
	Mon, 11 Mar 2024 18:49:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Mv6NHiFS72WkQgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 11 Mar 2024 18:49:05 +0000
Date: Mon, 11 Mar 2024 19:41:56 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, WA AM <waautomata@gmail.com>,
	Qu Wenru <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v3] btrfs: zoned: use zone aware sb location for scrub
Message-ID: <20240311184156.GT2604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4d3e8c5cd6ba3e178a1e820c318d96317ac12845.1709890038.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d3e8c5cd6ba3e178a1e820c318d96317ac12845.1709890038.git.jth@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PQLjN7Rq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vP+yZ5sM
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.21 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.986];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.01)[45.86%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,suse.com,wdc.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.21
X-Rspamd-Queue-Id: 8C6BF5CA53
X-Spam-Flag: NO

On Fri, Mar 08, 2024 at 10:28:44AM +0100, Johannes Thumshirn wrote:
> At the moment scrub_supers() doesn't grab the super block's location via
> the zoned device aware btrfs_sb_log_location() but via btrfs_sb_offset().
> 
> This leads to checksum errors on 'scrub' as we're not accessing the
> correct location of the super block.
> 
> So use btrfs_sb_log_location() for getting the super blocks location on
> scrub.
> 
> Reported-by: WA AM <waautomata@gmail.com>
> Cc: Qu Wenru <wqu@suse.com>
> Link: http://lore.kernel.org/linux-btrfs/CANU2Z0EvUzfYxczLgGUiREoMndE9WdQnbaawV5Fv5gNXptPUKw@mail.gmail.com
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: David Sterba <dsterba@suse.com>

