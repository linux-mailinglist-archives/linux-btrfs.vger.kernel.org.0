Return-Path: <linux-btrfs+bounces-1393-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0514482B1B2
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 16:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3217228377A
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 15:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9E24C60C;
	Thu, 11 Jan 2024 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Grl+rTEJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0bTKDVBx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Grl+rTEJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0bTKDVBx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA724BAB5
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jan 2024 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3CE38220FF;
	Thu, 11 Jan 2024 15:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704986712;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K2NlwdJbwUt6/1hG2YRM0qzwB7udlV2xTqJZaOpavRM=;
	b=Grl+rTEJx9Rolpw26HC13BRuL5lNcEcKONCDgElM1lcqk+yyIQBXKozAU+0/WglsEhFfvI
	1TMTlw45IRgPuYIpOLJ5p9EGVrMkj4PhZG5l39YTdVhcLO+21Fm5XOLBiHFNuy8cGk1ZcI
	f2uCNbOD/VG6KCu8s8RrZ8lgf8iv/Ck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704986712;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K2NlwdJbwUt6/1hG2YRM0qzwB7udlV2xTqJZaOpavRM=;
	b=0bTKDVBxSodqCvW08iuqjM+KEeewfWWF3hTAiyaSBfqtT4JXmJ/BKZ5c493q8JPrJznWs5
	VALuYhxntUjcmjCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704986712;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K2NlwdJbwUt6/1hG2YRM0qzwB7udlV2xTqJZaOpavRM=;
	b=Grl+rTEJx9Rolpw26HC13BRuL5lNcEcKONCDgElM1lcqk+yyIQBXKozAU+0/WglsEhFfvI
	1TMTlw45IRgPuYIpOLJ5p9EGVrMkj4PhZG5l39YTdVhcLO+21Fm5XOLBiHFNuy8cGk1ZcI
	f2uCNbOD/VG6KCu8s8RrZ8lgf8iv/Ck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704986712;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K2NlwdJbwUt6/1hG2YRM0qzwB7udlV2xTqJZaOpavRM=;
	b=0bTKDVBxSodqCvW08iuqjM+KEeewfWWF3hTAiyaSBfqtT4JXmJ/BKZ5c493q8JPrJznWs5
	VALuYhxntUjcmjCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C517132FA;
	Thu, 11 Jan 2024 15:25:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id nyebClgIoGXkdAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 11 Jan 2024 15:25:12 +0000
Date: Thu, 11 Jan 2024 16:24:52 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not restrict writes to devices
Message-ID: <20240111152452.GD31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2fe68e18d89abb7313392c8da61aaa9881bbe945.1704917721.git.josef@toxicpanda.com>
 <2878378f-358c-46ca-bc3b-d819f78658f4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2878378f-358c-46ca-bc3b-d819f78658f4@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Grl+rTEJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0bTKDVBx
X-Spamd-Result: default: False [-0.02 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[50.14%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.02
X-Rspamd-Queue-Id: 3CE38220FF
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Thu, Jan 11, 2024 at 04:59:00PM +0800, Anand Jain wrote:
> On 1/11/24 04:16, Josef Bacik wrote:
> > This is a version of ead622674df5 ("btrfs: Do not restrict writes to
> > btrfs devices"), which pushes this restriction closer to where we use
> > bdev_open_by_path.
> 
> 
> > This was in the mount path, and changed when we
> > switched to the new mount api,
> 
>   New mount api patchset [1]:
>       [1]  [PATCH v3 00/19] btrfs: convert to the new mount API
> 
> Do you have a specific patch here for me to understand the changes 
> you're talking about?
> 
> 
> > and with that loss we suddenly weren't
> > able to mount.
> 
> With the patchset [1] already in the mainline, I am able to mount.
> It looks like I'm missing something. What is the failing test case?

I don't think that mainline fails, I don't know what exactly Josef
tested though. There's a big merge diff
affc5af36bbb62073b6aaa4f4459b38937ff5331 and there's a manual resolution
by Linus moving the BLK_OPEN_RESTRICT_WRITES flags to the device open.

