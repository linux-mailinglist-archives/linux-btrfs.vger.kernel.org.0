Return-Path: <linux-btrfs+bounces-6383-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8AC92EA23
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 16:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1A4CB253F2
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 14:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A290D16130D;
	Thu, 11 Jul 2024 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jOnC4nsr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mk7WFm4y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jOnC4nsr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mk7WFm4y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312C4148FE8;
	Thu, 11 Jul 2024 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706620; cv=none; b=aKpfT2iBfqbvksSwts16YbuvIjokqfsYnF3zMSvc/7U0jfItbut3yHiwrEe+aNCcubzTV+yPFoMAXHSQ4aw6DgZYI5Nv1n6saIu4FMDmMvaM2D5dB9+hh0n7x2wwc0qBvw1Mh9XjwD3OYq+ASDjWqX4cG3I4PJPwSqjbhwI7NM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706620; c=relaxed/simple;
	bh=U3CRHF+4+0gsUq7qK38iXbVNUCP0mO5fs98IoDwhozc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbccQkYXaNjLDM3A3Rp2AokPFBfJOW2TKFjxIp2ZE3iPPfqsE6+d066KhdrHY+xA/eaihgg0YKS/zAUFBWnL0Yii38FfdcuQF/hDp8a9faRcgHWQSydAC3gag6g+TPCuJmpBNYggNsXN8w0Wcf7LTCs85lTwzSCPqSgMR2rd1Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jOnC4nsr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mk7WFm4y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jOnC4nsr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mk7WFm4y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4BFB321A5A;
	Thu, 11 Jul 2024 14:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720706617;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3mBP9DOHa93/XfXeFXWzUgUiBp6ZrszI9d4AlY0Cnzs=;
	b=jOnC4nsr3KcRWHpSgWmqN2qTUvFL3v5ZFR1nEARuF9Yw+8DxW7/KC0/8ubwdit7QxJYZ7T
	OkFhVS1bAWSZHXrnCBH6lGCTupJ+2LIH4x2SE5txWYm5puW9tl9GEZZnxQxN2LTqSl7UIJ
	XCrGVZxk9gMGlngIpDcCXpU4e7a2cIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720706617;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3mBP9DOHa93/XfXeFXWzUgUiBp6ZrszI9d4AlY0Cnzs=;
	b=Mk7WFm4yT+v8R5iNFtv/p4L2uIN6FUF213wfA4cp8HRyWHNX+SV/1gf28QrQOKRTOKKf5i
	+b75DUrSgaMI3DCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jOnC4nsr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Mk7WFm4y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720706617;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3mBP9DOHa93/XfXeFXWzUgUiBp6ZrszI9d4AlY0Cnzs=;
	b=jOnC4nsr3KcRWHpSgWmqN2qTUvFL3v5ZFR1nEARuF9Yw+8DxW7/KC0/8ubwdit7QxJYZ7T
	OkFhVS1bAWSZHXrnCBH6lGCTupJ+2LIH4x2SE5txWYm5puW9tl9GEZZnxQxN2LTqSl7UIJ
	XCrGVZxk9gMGlngIpDcCXpU4e7a2cIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720706617;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3mBP9DOHa93/XfXeFXWzUgUiBp6ZrszI9d4AlY0Cnzs=;
	b=Mk7WFm4yT+v8R5iNFtv/p4L2uIN6FUF213wfA4cp8HRyWHNX+SV/1gf28QrQOKRTOKKf5i
	+b75DUrSgaMI3DCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EF64139E0;
	Thu, 11 Jul 2024 14:03:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 97gtCznmj2ZbCAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 11 Jul 2024 14:03:37 +0000
Date: Thu, 11 Jul 2024 16:03:36 +0200
From: David Sterba <dsterba@suse.cz>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] btrfs: Remove duplicate btrfs_inode.h header
Message-ID: <20240711140336.GA8022@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240710053420.23713-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710053420.23713-1-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 4BFB321A5A
X-Spam-Flag: NO
X-Spam-Score: -0.21
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.21 / 50.00];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spamd-Bar: /

On Wed, Jul 10, 2024 at 01:34:20PM +0800, Jiapeng Chong wrote:
> ./fs/btrfs/zlib.c: btrfs_inode.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9492
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Thanks, it's from an unmerged development patch so I removed the include
from there.

