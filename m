Return-Path: <linux-btrfs+bounces-16602-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D465B40D80
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 21:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 448B13A4497
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 19:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22223469F9;
	Tue,  2 Sep 2025 19:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xuZWng22";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UuGy+rTn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xuZWng22";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UuGy+rTn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C9D326D4A
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 19:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756839793; cv=none; b=JTcKpwGuW8pwFZe7c/XrkD5Kb1wwRFGMHXzH82kGsZ6NYw2NhLGrsWc5Vaj3MtKa0wNPGTcHk5F9FszXPTv1IrY3OaucOHwwDTRe16nrLuG+SVwAt4Rr8OX8cn+cdek25yS8EAD/MLI4YWwFeTnnznv5l8F2LxO/WkQg5MYiS8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756839793; c=relaxed/simple;
	bh=2hpeMBuoZMElyhBIVshLOGBKG1nsUG1xdZBy2fE4Oj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfyRtic3G0ZviGKxnMMFwn+kaxtqotAW0eu/SxFjLEgoaBnlADRtlzJ/DEw3ey59WvnRky7Xf0KJGX6/w625edjVLbMbOnjTBlBsRVSBTeaHXOwwe4H/dvaKNImyC7dXm4le2+0AXTeF+4fKdbQxddT5fkj5bTG/fjcRgGiNp1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xuZWng22; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UuGy+rTn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xuZWng22; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UuGy+rTn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 07588211AB;
	Tue,  2 Sep 2025 19:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756839789;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JcHdKp8D4IOF5wTO0jGXticb7Xr+E3XjCxHweA2x6bk=;
	b=xuZWng220FJXs/lOP6mP+k9UEdtqcIQqubfXk50Ka+2W2TX05r4FGgM8hu6cYuT8KxS75r
	JZt2xweQ1ze/IzL25KXBBPVjUCeu2F4aBd61wb4l+VGwYUdsvMtuDIgPbS5ZQmScsfGNjw
	0TeM+jyKQul0vAIhxNcG51PmrHT4xtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756839789;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JcHdKp8D4IOF5wTO0jGXticb7Xr+E3XjCxHweA2x6bk=;
	b=UuGy+rTnySjanMki+ABmE2/uArRVY/Yg2McXBN5zTRobPW5stvVWOOEAjTHfbVAbS8RG+M
	vcucnQNhjdBvbfBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xuZWng22;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UuGy+rTn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756839789;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JcHdKp8D4IOF5wTO0jGXticb7Xr+E3XjCxHweA2x6bk=;
	b=xuZWng220FJXs/lOP6mP+k9UEdtqcIQqubfXk50Ka+2W2TX05r4FGgM8hu6cYuT8KxS75r
	JZt2xweQ1ze/IzL25KXBBPVjUCeu2F4aBd61wb4l+VGwYUdsvMtuDIgPbS5ZQmScsfGNjw
	0TeM+jyKQul0vAIhxNcG51PmrHT4xtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756839789;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JcHdKp8D4IOF5wTO0jGXticb7Xr+E3XjCxHweA2x6bk=;
	b=UuGy+rTnySjanMki+ABmE2/uArRVY/Yg2McXBN5zTRobPW5stvVWOOEAjTHfbVAbS8RG+M
	vcucnQNhjdBvbfBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC1F713888;
	Tue,  2 Sep 2025 19:03:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ehp3OWw/t2iebwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 02 Sep 2025 19:03:08 +0000
Date: Tue, 2 Sep 2025 21:03:07 +0200
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com
Subject: Re: [PATCH v2] btrfs: don't allow adding block device of less than 1
 MB
Message-ID: <20250902190307.GK5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250902103421.19479-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902103421.19479-1-mark@harmstone.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 07588211AB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21

On Tue, Sep 02, 2025 at 11:34:10AM +0100, Mark Harmstone wrote:
> Commit 15ae0410 in btrfs-progs inadvertently changed it so that if the
> BLKGETSIZE64 ioctl on a block device returned a size of 0, this was no
> longer seen as an error condition.
> 
> Unfortunately this is how disconnected NBD devices behave, meaning that
> with btrfs-progs 6.16 it's now possible to add a device you can't
> remove:
> 
> ~ # btrfs device add /dev/nbd0 /root/temp
> ~ # btrfs device remove /dev/nbd0 /root/temp
> ERROR: error removing device '/dev/nbd0': Invalid argument
> 
> This check should always have been done kernel-side anyway, so add a
> check in btrfs_init_new_device() that the new device doesn't have a size
> less than BTRFS_DEVICE_RANGE_RESERVED (i.e. 1 MB).
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>

Reviewed-by: David Sterba <dsterba@suse.com>

