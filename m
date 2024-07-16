Return-Path: <linux-btrfs+bounces-6488-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FA2931DFF
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 02:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B882B22913
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 00:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18CEED8;
	Tue, 16 Jul 2024 00:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c7uyMsDp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ea12eyUd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c7uyMsDp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ea12eyUd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69D7182
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2024 00:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721088855; cv=none; b=F6wQKoxj0iJ2NJlqo03jw+xHcQJBIpXndEG7zGQPuha317FmqwHf7s2AFHr/sCa6ezqxLGPSvKB+7SIwRZKYoBib0BM2G+bTaA4go+n9jLiBrE32c4u4qOlToAvhAp15Ik7AWzT4Qi1NdUCPgZUol9CUrK06S15PPl7jrexwQTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721088855; c=relaxed/simple;
	bh=0VY09OKVEG6pqchEQrWTVRpeMzQrLvtA7To50qJzYWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUbsOD53fQAfcLT3xfsjlKgsT7ask/9Iyn/qjqE6G3OZUTTzON0RKxorbctAGwe87gTV8BCMMjKlyD2SnLv/6TthD0nuNz8Uzk2Wjy+Y4Y59vUOqfntIgU12kjiOpLlXoikWtqBu4QW8YZLMFXJNJmGKqY2lUhIxqDSnQlbx9Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c7uyMsDp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ea12eyUd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c7uyMsDp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ea12eyUd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B95D61F844;
	Tue, 16 Jul 2024 00:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721088851;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35EE+XtAK3nmj0sbn3+v6SoFyFKqArAYOvOK2Deef4k=;
	b=c7uyMsDpGRnIpPtXFJtyc6Ur+wqvDBTa92oc0H9SkKPa9sxfLWCDPsSWAgwntfthIZKCjy
	tJIr4vucOQdp/CBKYZpRsTAGblKjq6+ESu7rGfkvTQO07FFt3WVBh48O79+wl6wosmpPID
	UsvHBEzn3s2ghVfVMsDjf1XGxgfEpZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721088851;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35EE+XtAK3nmj0sbn3+v6SoFyFKqArAYOvOK2Deef4k=;
	b=Ea12eyUd/lbqg87B/9SFI37utRjAjpvf64Q0vyvkomN0C5ij7EE4eDOBJI2SquKSKjKstX
	PzAgLkvOk1S7VMBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=c7uyMsDp;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Ea12eyUd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721088851;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35EE+XtAK3nmj0sbn3+v6SoFyFKqArAYOvOK2Deef4k=;
	b=c7uyMsDpGRnIpPtXFJtyc6Ur+wqvDBTa92oc0H9SkKPa9sxfLWCDPsSWAgwntfthIZKCjy
	tJIr4vucOQdp/CBKYZpRsTAGblKjq6+ESu7rGfkvTQO07FFt3WVBh48O79+wl6wosmpPID
	UsvHBEzn3s2ghVfVMsDjf1XGxgfEpZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721088851;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35EE+XtAK3nmj0sbn3+v6SoFyFKqArAYOvOK2Deef4k=;
	b=Ea12eyUd/lbqg87B/9SFI37utRjAjpvf64Q0vyvkomN0C5ij7EE4eDOBJI2SquKSKjKstX
	PzAgLkvOk1S7VMBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 871E81395F;
	Tue, 16 Jul 2024 00:14:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uU6GIFO7lWb/CwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 16 Jul 2024 00:14:11 +0000
Date: Tue, 16 Jul 2024 02:14:01 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: change BTRFS_MOUNT_* flags to 64bits
Message-ID: <20240716001401.GF8022@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0955d2c5675a7fe3146292aaa766755f22bcd94b.1720865683.git.wqu@suse.com>
 <20240715123155.GD8022@twin.jikos.cz>
 <b3c459ff-d168-48a1-bff5-95bcb983f8fe@gmx.com>
 <f5b82cac-b1b2-41f5-8917-e236d682bd02@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5b82cac-b1b2-41f5-8917-e236d682bd02@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmx.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Level: 
X-Rspamd-Queue-Id: B95D61F844

On Tue, Jul 16, 2024 at 08:11:00AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/7/16 07:41, Qu Wenruo 写道:
> >
> >
> > 在 2024/7/15 22:01, David Sterba 写道:
> >> On Sat, Jul 13, 2024 at 07:45:08PM +0930, Qu Wenruo wrote:
> >>> Currently the BTRFS_MOUNT_* flags is already reaching 32 bits, and with
> >>> the incoming new rescue options, we're going beyond the width of 32
> >>> bits.
> >>>
> >>> This is going to cause problems as for quite some 32 bit systems,
> >>> 1ULL << 32 would overflow the width of unsigned long.
> >>>
> >>> Fix the problem by:
> >>>
> >>> - Migrate all existing BTRFS_MOUNT_* flags to unsigned long long
> >>> - Migrate all mount option related variables to unsigned long long
> >>>    * btrfs_fs_info::mount_opt
> >>>    * btrfs_fs_context::mount_opt
> >>>    * mount_opt parameter of btrfs_check_options()
> >>>    * old_opts parameter of btrfs_remount_begin()
> >>>    * old_opts parameter of btrfs_remount_cleanup()
> >>>    * mount_opt parameter of btrfs_check_mountopts_zoned()
> >>>    * mount_opt and opt parameters of check_ro_option()
> >>>
> >>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >>> ---
> >>> The current patch is still based on the latest for-next branch.
> >>>
> >>> But during merge time I will move this before the new rescue options.
> >>
> >> You konw you can't do that right? The branch for 6.11 can't be changed
> >> anymore and it was late last week already. I've forked the changes at
> >> 8e7860543a94784d744c7ce34b7 so far it's still subset of for-next if you
> >> change anything below that then it'll cause merge conflicts or would
> >> need manual resolution in another way. Until rc1 it's probably safest to
> >> just append to our for-next.
> >>
> >
> > I guess it's impossible to drop all the new rescue mount option patches
> > from 6.11 queue?
> 
> My bad, just see the git pull, so it's not possible anymore.
> 
> Then I just hope the patch can be merged as a bug fixes sooner, or we're
> going to be flooded by tons of compiling failures.

Yes a fixup is possible of course.

