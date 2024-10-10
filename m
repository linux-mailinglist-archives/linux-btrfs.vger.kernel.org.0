Return-Path: <linux-btrfs+bounces-8815-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C8E998E0D
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 19:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6141283B33
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 17:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E694A19CC16;
	Thu, 10 Oct 2024 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="npJuhWzm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MZIS41op";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="npJuhWzm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MZIS41op"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56012558B7
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728580127; cv=none; b=hoQ65vc6zbymRd+ZFqAsNx3HbvxvJxVhq4xqIRLorWZXQrIpd4Ymnlkrnvl5lOurqMSeeROwhbrG3mWeN/Y37jzl8lY1s6gRSxBxyJx3SHO0C+FQC0eJ8H3pzc5EzQs6/gd+P6jsXbbd/aMVTA1OLeqGXK4m5QZOMLphng7B5ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728580127; c=relaxed/simple;
	bh=IB1N70ld8qTSkuWf3PxuIJnZsKCCZL/45CX1PIKsAR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgaVoaQmqwicrxjrKUpXHEeurxHYN85a3m+bZKnWSWrIpzr902KillfP+onvEXVonQSVokVyAg8pEuDb76XFWKTTbeEPjvGHch4XXlR2FwGUZaJ3Xi7oYsrbLeE8+BAivsOntQKrN+N1NjwnQ8eynJRqTMD257X7U96K9j0wb5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=npJuhWzm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MZIS41op; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=npJuhWzm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MZIS41op; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 404E11F7EE;
	Thu, 10 Oct 2024 17:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728580123;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4LcFT7VPeXTXKDtPh3ACmYa7ATtVPHL9sVEx7gusdEc=;
	b=npJuhWzmjccCy3cQkydPtsvRFMDeWmoEyq+VGFi2Nrzzplw3+ErSpMSyX4lhnwLCJslscd
	t3A9UqPOZ2+LFk+7UwBQERH8udf7tuQrYZOUi+bJVmp5eQROhgeRRMo4TOb/7NPX33R7qk
	KuaLF8ZZEj7FXyOFIBIJfOYma9kK5Os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728580123;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4LcFT7VPeXTXKDtPh3ACmYa7ATtVPHL9sVEx7gusdEc=;
	b=MZIS41opX9+wTFcmCjB9FNEYMNgNinTYd7LJCqzBrEzCTyRgwWdm7OaW6T2ioYooZ4rvLb
	uhTXqFtf2yUtfRAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=npJuhWzm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MZIS41op
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728580123;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4LcFT7VPeXTXKDtPh3ACmYa7ATtVPHL9sVEx7gusdEc=;
	b=npJuhWzmjccCy3cQkydPtsvRFMDeWmoEyq+VGFi2Nrzzplw3+ErSpMSyX4lhnwLCJslscd
	t3A9UqPOZ2+LFk+7UwBQERH8udf7tuQrYZOUi+bJVmp5eQROhgeRRMo4TOb/7NPX33R7qk
	KuaLF8ZZEj7FXyOFIBIJfOYma9kK5Os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728580123;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4LcFT7VPeXTXKDtPh3ACmYa7ATtVPHL9sVEx7gusdEc=;
	b=MZIS41opX9+wTFcmCjB9FNEYMNgNinTYd7LJCqzBrEzCTyRgwWdm7OaW6T2ioYooZ4rvLb
	uhTXqFtf2yUtfRAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1216B13A6E;
	Thu, 10 Oct 2024 17:08:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MWjUAxsKCGf2GgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 10 Oct 2024 17:08:43 +0000
Date: Thu, 10 Oct 2024 19:08:41 +0200
From: David Sterba <dsterba@suse.cz>
To: Yuwei Han <hrx@bupt.moe>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [RFC] New ioctl to query deleted subvolumes
Message-ID: <20241010170841.GR1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241009180300.GN1609@twin.jikos.cz>
 <308CF1DDC38EE68A+91e40dff-783f-43f4-9e49-a5cd4fa0b7a8@bupt.moe>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <308CF1DDC38EE68A+91e40dff-783f-43f4-9e49-a5cd4fa0b7a8@bupt.moe>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 404E11F7EE
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Oct 10, 2024 at 08:29:14PM +0800, Yuwei Han wrote:
> 
> 
> 在 2024/10/10 02:03, David Sterba 写道:
> > Hi,
> > 
> > I'd like some user feedback on a new ioctl that should handle several use cases
> > around subvolume deletion. Currently it's implemented on top of the privileged
> > SEARCH_TREE ioctl, it's not possible to do that with libbtrfsutil or
> > unprivileged ioctls.
> > 
> > The use cases:
> > 
> >    1) wait for a specific id until it's cleaned (blocking, not blocking)
> > 
> > This is what 'btrfs subvol sync id' does. In the non-blocking mode it checks if
> > a subvolume is in the queue for deletion.
> > 
> >    2) wait for all currently queued subvolumes (blocking)
> > 
> > Same as 'btrfs subvol sync' without any id.
> > 
> >    3) read id of the currently cleaned subvolume (not blocking)
> > 
> > Allow to implement sync purely in user space.
> > 
> >    4) read id of the last in the queue (not blocking)
> > 
> > As the subvolumes are added to the list in the order of deletion, reading the
> > last one is kind of a checkpoint. More subvolumes can be added to the queue in
> > the meanwhile so this adds some flexibility to applications.
> > 
> >    5) count the number of queued subvolumes (not blocking)
> > 
> > This is for convenience and progress reports.

> I don't understand why we need to get the status about subvolume 
> deletion. Can you provide some real world usage?

https://github.com/kdave/btrfs-progs/blob/devel/cmds/subvolume.c#L85

'btrfs subvol sync' prints at the beginning number of subvolumes

  "Waiting for 123 subvolumes"

And then prints the progress like

  "Subvolume id 456 is gone (1/10)"

So the ioctl mode is there to emulate that, for the common case of "wait
for all subvolumes currently queued for deletion".

> > 
> > There are some questions and potential problems stemming from the general
> > availability of the ioctl:
> > 
> > - the operations will need to take locks and/or lookup the subvolumes in the
> >    data structures, so it could be abused to overload the locks, but there are
> >    more such ways how to do that so I'm not sure what to do here
> Since it's privileged operation. I think it is up to users. But we can 
> have some hints like balance do.
> > - deleted subvolume loses it's connection to path in directory hierarchy, so
> >    querying an id does not tell us if the user was allowed to see the subvolume
> > 
> > - the blocking operations can take a timeout parameter (seconds), this is for
> >    convenience, otherwise a simple "while (ioctl) sleep(1)" will always work
> > 
> > 
> > My questions:
> > 
> > - Are there other use cases that are missing from the list?
> > 
> > - Are there use cases that should not be implemented? E.g. not worth the
> >    trouble or not really useful.
> > 
> > I have a prototype for 1 and 2, the others would be easy to implement
> > but the number of cases affects the ioctl design (simple id vs modes).
> > 
> > Thanks.
> > 
> Overall I am confused about this message. Did I miss something before?

Sorry, without the code it could be cryptic.  In the simplest version,
the ioctl could be defined to take only the a u64, the id of the
subvolume to wait for, or 0 to wait for all.

#define BTRFS_IOC_SUBVOL_SYNC_WAIT _IOW(BTRFS_IOCTL_MAGIC, 65, u64)

and implemented like (schematically):

btrfs_ioctl_subvol_sync_wait(struct btrfs_fs_info *fs_info, void __user *argp) {
	u64 subvolid;

	copy_from_user(&subvolid, argp);

	if (subvolid == 0)
		subvolid = btrfs_root_id("last root in the dead_roots list");

	while (1) {
		root = lookup_root(subvolid)
		"if exists, continue looping"
		"if gone, exit"
	}
}

So my question is if this is sufficient for all what's needed or if the
argument passed to the ioctl should be a structure with flags, modes,
timeout and such:

struct btrfs_ioctl_subvol_wailt {
	u32 mode;
	union {
		u32 timeout;
		u32 count;
	};
	u64 subvolid;
};

