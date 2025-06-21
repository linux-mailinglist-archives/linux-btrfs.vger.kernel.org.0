Return-Path: <linux-btrfs+bounces-14837-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D3BAE2A0C
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Jun 2025 18:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD2D3B67E2
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Jun 2025 15:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879E921CC71;
	Sat, 21 Jun 2025 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nbKZI8HT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dlEPPN2E";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XiwLBZlz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h/52Bua4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40B421FF4B
	for <linux-btrfs@vger.kernel.org>; Sat, 21 Jun 2025 16:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750521613; cv=none; b=OOy40AMADXdzAAQLfuxTuQOlfhl/0kNKfqSGFhF8RFy5Qwx/r2GNKzu0sok7jTWmY+CJ+Qp1PmEljLlLHY/MYV4rUKfsgV0X9zEdw5FuKyPmyNr1YtELZZkNZuoVRUfcTXOKAEselVZcCLMLR7wcmH6sPKSJgx/MDAt2Rl545tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750521613; c=relaxed/simple;
	bh=7mAM+nZF8QoTZvBEjbYz/YvUEWFnorwpiPqBij542Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYd49s8r8S0CTIT3ydJI4JufccumIu0tFOJotU3jGfycv8O/Lq8LXbTcgZCJ0RZX4aAoejIC/rLoGdyXrTL98G8zmRxEIpPzZP+sQo8r2S06GQC93OBsE6M4jXi4Q9mTDo8/QNj+fJusdL5WXKrzBpmwuoBaAFk6UHzojhKEgNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nbKZI8HT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dlEPPN2E; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XiwLBZlz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h/52Bua4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A4519211F1;
	Sat, 21 Jun 2025 16:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750521609;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i2QwdUCcwKOZrh0eEAa8URmNdPTM8ebHHUQEWPPjShQ=;
	b=nbKZI8HTR8WmN1xwBN1FNUd1qryPwd9C49UkpiUfqQ/PjRXqkRC0f4w5R0GN64IUP5U4Bp
	XpTPUJyAddO0RvzP803VZHbWj7JITRLD3ct0uyaANv+G2cVwljrgoJG3ADzwiC6l/+GhQM
	j0RlbyyrpGt3YvtWADeD/bBnHVSzhc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750521609;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i2QwdUCcwKOZrh0eEAa8URmNdPTM8ebHHUQEWPPjShQ=;
	b=dlEPPN2E6fHYGPV2PdNxF8P9xmS89BHSjLOuYDoocwkqsagrGhyWGxYv4WjuN435hDOeDR
	4ZEeNJaCGXa3DwBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XiwLBZlz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="h/52Bua4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750521608;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i2QwdUCcwKOZrh0eEAa8URmNdPTM8ebHHUQEWPPjShQ=;
	b=XiwLBZlz2drQyHA3RWaTcxnJIDFSJa6kTAc6zmpNk61M6bl16DdIoy6a5DBm94hfZWpoN6
	OTAxO06eSBSfxhaJDG2JKjMUlXm81+83PnwIBtjlNURXPsRnN/W1HY+g8XSlVv9GpQD0fU
	+cLDdUeKePL9h/cpIWr6oK/3c1EGQiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750521608;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i2QwdUCcwKOZrh0eEAa8URmNdPTM8ebHHUQEWPPjShQ=;
	b=h/52Bua48FAGPQBs2rGgXTyR/ytOq7RxpqeFsJPuE9Gpygk1Rdo7z8gGyuPGYba+jA5Mtx
	1hHc7ectbSoHZmBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BB4C136CB;
	Sat, 21 Jun 2025 16:00:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2YSYIQjXVmiEPAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Sat, 21 Jun 2025 16:00:08 +0000
Date: Sat, 21 Jun 2025 18:00:07 +0200
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: dsterba@suse.cz, Daniel Vacek <neelx@suse.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: open code RCU for device name
Message-ID: <20250621160007.GE4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1750244832.git.dsterba@suse.com>
 <6d43001159c86467bfa1afe928deade5805af8fe.1750244832.git.dsterba@suse.com>
 <CAPjX3FeGLSJ2WFJqdN12saSEAeBYObsoJdttYiA=iDZNMKM1HQ@mail.gmail.com>
 <20250620121025.GO4037@twin.jikos.cz>
 <CAL3q7H7e3Oy8pVVkAcAcwM5SvX5H9A3fxFTT_Mw_iUznfjNwTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7e3Oy8pVVkAcAcwM5SvX5H9A3fxFTT_Mw_iUznfjNwTg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A4519211F1
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.21
X-Spam-Level: 

On Fri, Jun 20, 2025 at 06:01:30PM +0100, Filipe Manana wrote:
> On Fri, Jun 20, 2025 at 1:12 PM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Thu, Jun 19, 2025 at 12:15:25PM +0200, Daniel Vacek wrote:
> > > > @@ -2167,7 +2171,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info, struct btrfs_devic
> > > >         btrfs_kobject_uevent(bdev, KOBJ_CHANGE);
> > > >
> > > >         /* Update ctime/mtime for device path for libblkid */
> > > > -       update_dev_time(device);
> > > > +       update_dev_time(device;
> > >
> > > This looks like a mistake. I believe the hunk should be removed,
> > > otherwise it won't compile.
> >
> > Yes it's a mistake. I've checked how it got there, most likely after
> > reordering the patch moving RCU to update_dev_time, the parameter
> > changed from device->name to device.
> 
> I think you also forgot to test the patchset.
> 
> After applying it (rebasing to latest for-next), running fstests the
> following trace can be triggered in many tests such as btrfs/003:

Apparently yes, I don't know where I lost track of the patchset so I'll
redo it from start. Patches removed from for-next.

