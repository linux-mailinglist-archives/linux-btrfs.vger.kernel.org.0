Return-Path: <linux-btrfs+bounces-5275-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36048CE496
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 12:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BF7EB211D9
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 10:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2981286151;
	Fri, 24 May 2024 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QzCCAApb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wWF1ZMgq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QzCCAApb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wWF1ZMgq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27148595A
	for <linux-btrfs@vger.kernel.org>; Fri, 24 May 2024 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716548356; cv=none; b=C8ar/eUumG7HGAuJvNedLv2u0Q2SiMLavcaCwf/OyTHGRFCTF8K+9oeSyt8JCTnxJMlyPudeJP+xPjaB3NluP9KJBWboz1NcMIs1ttmAengcU/Fy98+iQ1PChccMkvOtllmoCUg34R523egGuACD27NewS2Hg9qi1fVu4VuUwA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716548356; c=relaxed/simple;
	bh=7/z4PfE9CkYvTBSyOZuePTMxTLD3oMSugML97KpnbLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIGju18JExXv9jmk2NA7GWIyPVk+MyqkeYx5plwT2jA44SXBHAjIDrSqIUhs/IOzFCJYBjzNPtZoYgFwYAsp5p/TQxU3faLuuxmY6swwcEekZflyLX29wcer1yvMq2+JQqKIFcPRCg6/Nnq8t2mIaxS0MJF6kasg8acrd+jF3hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QzCCAApb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wWF1ZMgq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QzCCAApb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wWF1ZMgq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B7AB933826;
	Fri, 24 May 2024 10:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716548352;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X3gSQjHRVEBRVv+WvfA9UtdDGMSm6/lO915fWbo7LqI=;
	b=QzCCAApbTJTS7j9naaT35mGVNQeUnoT6TmW4IYiXOld5y2ewnO+CPWcgIZ4pFkJ0k3cj39
	pWj/ebFz3E9IjfxyfMcPxuzVfV/uw7cHhZDmjVxymmXsIwJ9qyf/cWPFU00DCqqKzZgYtD
	DJTgWIajKoj16hj9rOGvn1odlZTtOAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716548352;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X3gSQjHRVEBRVv+WvfA9UtdDGMSm6/lO915fWbo7LqI=;
	b=wWF1ZMgqVzQVSv8VjuL73H+ApshnVRUTq7tiuht46VYOTRCDDgZ9jaGdlleQrFuKtWX7Q2
	9b4/7Ro+mDDG8wBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716548352;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X3gSQjHRVEBRVv+WvfA9UtdDGMSm6/lO915fWbo7LqI=;
	b=QzCCAApbTJTS7j9naaT35mGVNQeUnoT6TmW4IYiXOld5y2ewnO+CPWcgIZ4pFkJ0k3cj39
	pWj/ebFz3E9IjfxyfMcPxuzVfV/uw7cHhZDmjVxymmXsIwJ9qyf/cWPFU00DCqqKzZgYtD
	DJTgWIajKoj16hj9rOGvn1odlZTtOAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716548352;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X3gSQjHRVEBRVv+WvfA9UtdDGMSm6/lO915fWbo7LqI=;
	b=wWF1ZMgqVzQVSv8VjuL73H+ApshnVRUTq7tiuht46VYOTRCDDgZ9jaGdlleQrFuKtWX7Q2
	9b4/7Ro+mDDG8wBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 979A713A3D;
	Fri, 24 May 2024 10:59:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dMTMJABzUGbtdAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 24 May 2024 10:59:12 +0000
Date: Fri, 24 May 2024 12:59:07 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v3 03/11] btrfs: introduce new members for extent_map
Message-ID: <20240524105907.GG17126@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1716440169.git.wqu@suse.com>
 <41be25a4c77c46f8725c13636098f5f37e5c3d93.1716440169.git.wqu@suse.com>
 <CAL3q7H4ESOZTAaG4Opf3u_8p4BJ_cQPDGs-SdY9vCCFHe6KrCg@mail.gmail.com>
 <f949b5b3-4c0a-417f-a9b1-7c5859bae8a0@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f949b5b3-4c0a-417f-a9b1-7c5859bae8a0@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]

On Fri, May 24, 2024 at 08:49:25AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/5/24 02:23, Filipe Manana 写道:
> [...]
> >> @@ -832,10 +897,11 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
> >>                                          split->orig_start = em->orig_start;
> >>                                  }
> >>                          } else {
> >> +                               split->disk_num_bytes = 0;
> >> +                               split->offset = 0;
> >>                                  split->ram_bytes = split->len;
> >>                                  split->orig_start = split->start;
> >>                                  split->block_len = 0;
> >> -                               split->disk_num_bytes = 0;
> >
> > Why move the assignment of ->disk_num_bytes ?
> > This is sort of distracting, doing unnecessary changes.
> 
> It's to group the newer members together, and to follow the new trend to
> put them in disk_bytenr disk_num_bytes offset ram_bytes order.
> 
> I know with structures, there is really no need to keep any order
> between the member assignment, but with fixed ordering, it would be
> better in the long run.

I agree this pays of in the long run. The most prominent example is
ordering of the btrfs_key initialization, if it's always
objectid/type/offset it's does not slow down reading, it's enough to
read the values. Admittedly for the extent_map it's not the same because
there are more members. The important thing is to keep the same order
everywhere.

