Return-Path: <linux-btrfs+bounces-19759-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B91CBF906
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 20:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2F033032FF5
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 19:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92653337B89;
	Mon, 15 Dec 2025 19:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TSe9PrE8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sCUzlH0r";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TSe9PrE8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sCUzlH0r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E22330304
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 19:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765826914; cv=none; b=OBwSNYc4xGQT3UrVrXkuh641BxX7ycQggaCVdx4pR1JpCfKmKIqy7u83GvmRzC1114Ks51sJoFaTPgt7GRfPYimxB30Jgo23By3tXSQGyclauyIRqxk/6nJ0XFTVFG1pQzi/yvP2XtgD0zkhlof5BrR+f8fEEddhuYQv57kE9dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765826914; c=relaxed/simple;
	bh=05Cnj9xOCGgFE/uSYBddwDdXiREwvlgLflviRLhMp/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d01RfP2+FikKMVxHTsa5O+SCar1yAzgbp93VM+YlJ4ruBa/Enpb5B7j9cxjQY1VG04p951203VpUZe/Jse+ETIPojCBNSKezu3Ahrf/7c5hjkdvKdfCYcwgO4MNlgIsOGiGH+11O3XOglVhnrQ0J9a6YBsNDBGkV4ag+2RTDthk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TSe9PrE8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sCUzlH0r; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TSe9PrE8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sCUzlH0r; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1BD505BCD8;
	Mon, 15 Dec 2025 19:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765826911;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYr/8bhCCtOOdIKDV9nCPViHW+zJIVCIL8PNtARp2rs=;
	b=TSe9PrE83ptU3Xg++biZdVr+fgfVR5312L2t7MkIVp7aycuZIF+UA7eay9a52C2tSBScEH
	xvy+s7kqTOSPsMgGe0CA+PfNiCuEoSsQ3ywpbtseWdQhxUh25IOr+4pBBHXaPV4Q6hIdFl
	DTGGlnouY0rdx/BYZUtTlBO6zrvL7Bo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765826911;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYr/8bhCCtOOdIKDV9nCPViHW+zJIVCIL8PNtARp2rs=;
	b=sCUzlH0rQODw79AXYtDYbmKE/up74VUgYjUlT1BXOkHyDt8Ksgo4yI6FwjIvXRw4R2sPjJ
	X3LjScpgfV+UtRBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765826911;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYr/8bhCCtOOdIKDV9nCPViHW+zJIVCIL8PNtARp2rs=;
	b=TSe9PrE83ptU3Xg++biZdVr+fgfVR5312L2t7MkIVp7aycuZIF+UA7eay9a52C2tSBScEH
	xvy+s7kqTOSPsMgGe0CA+PfNiCuEoSsQ3ywpbtseWdQhxUh25IOr+4pBBHXaPV4Q6hIdFl
	DTGGlnouY0rdx/BYZUtTlBO6zrvL7Bo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765826911;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYr/8bhCCtOOdIKDV9nCPViHW+zJIVCIL8PNtARp2rs=;
	b=sCUzlH0rQODw79AXYtDYbmKE/up74VUgYjUlT1BXOkHyDt8Ksgo4yI6FwjIvXRw4R2sPjJ
	X3LjScpgfV+UtRBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBF4D3EA63;
	Mon, 15 Dec 2025 19:28:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k4VuOV5hQGnILAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 15 Dec 2025 19:28:30 +0000
Date: Mon, 15 Dec 2025 20:28:25 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: Kai Krakow <kai@kaishome.de>, linux-btrfs@vger.kernel.org,
	Eli Venter <eli@genedx.com>
Subject: Re: [PATCH] btrfs: harden __reserve_bytes() with space_info==NULL
Message-ID: <20251215192825.GI3195@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251213200920.1808679-1-kai@kaishome.de>
 <350e9b44-7a16-4c3f-a54f-5b6b3f4931f3@suse.com>
 <CAC2ZOYtgvzThSVX7tsajF=czm3JaYzpKjCsJB72Tw3_35Notzw@mail.gmail.com>
 <4a4c04ff-3855-467c-af75-77c6ddf27098@suse.com>
 <CAC2ZOYvY1x-vx9rUs-tZ2J_oHjX-pj7C1muFwvnH5NHSHn0ntw@mail.gmail.com>
 <684a6f99-0df8-428a-8e57-294a38b8788e@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <684a6f99-0df8-428a-8e57-294a38b8788e@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -3.99
X-Spam-Level: 
X-Spamd-Result: default: False [-3.99 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.19)[-0.947];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid,suse.cz:replyto,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]

On Sun, Dec 14, 2025 at 09:01:41AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/12/14 08:13, Kai Krakow 写道:
> > Am Sa., 13. Dez. 2025 um 22:15 Uhr schrieb Qu Wenruo <wqu@suse.com>:
> [...]
> >>
> >> So if you really want to change a member, do a proper in-memory update
> >> only, and find a way (e.g. a new dirty dev list) to tell the fs to
> >> update the device item at commit time.
> > 
> > I don't want to steal your time,
> 
> I'm totally fine discussing the implementation details here.
> 
> > but is this a better approach?
> > https://gist.github.com/kakra/aa3eb8473cc05c1d3dd000160a5ee481
> 
> Unfortunately as long as if you're trying to do any metadata 
> modification, e.g. calling btrfs_update_device(), it will be a huge change.
> 
> 
> My idea would be something like this:
> 
> btrfs_dev_info_type_store()
> {
> 	btrfs_device *device = container_of();
> 
> 	/* Do the proper locking. */
> 
> 	WRITE_ONCE(device->type, type);
> 	if (!list_empty(&dev->dirty_list))
> 		list_add_tail(&fs_info->dirty_dev_list, &dev->dirty_list);

	set_bit(BTRFS_FS_NEED_TRANS_COMMIT, &fs_info->flags);
	wake_up_process(fs_info->transaction_kthread);

I don't think it would be wise to wait until the transaction is
committed before returning from the store handler. We don't do that for
other similar changes either so the write becomes permanent after a
sync, using eg. 'btrfs fi sync'.

> 	return len;
> }
> 
> 
> Then inside btrfs_commit_transaction(), I do not yet have a good idea on 
> the timing, but I guess it can done before btrfs_start_delalloc_flush().
> 
> Do something like this to write those dirty devices to chunk tree:
> 
> btrfs_commit_transaction()
> {
> 	list_for_each_entry(dev, &fs_info->dirty_dev_list, dirty_list) {
> 		ret = btrfs_update_device(dev);
> 	}
> 
> 	/* The remaining code. */
> 	ret = btrfs_start_delalloc_flush();
> }

This should work. The placement depends on what is changed and how it's
related to the current transaction.

