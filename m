Return-Path: <linux-btrfs+bounces-9919-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B769D9B1F
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 17:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E09F166C05
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 16:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702081B4150;
	Tue, 26 Nov 2024 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MNd9zla1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/seIqjdu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j8ACsEI/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6RvAzkd7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E1911187;
	Tue, 26 Nov 2024 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732637612; cv=none; b=I8w+8s9rSO3Gb2AT9L0+L3DvElf5ZB9M1gvUDYN/+QaAn7wpENxdW456ezNJlPGUeZAdo5Dkzxx+21yxZH1tO39OGd68wiayFzo45TU8ezRr7JcfMuDN8csgRwJeY+/6lcHwCBObIJEa2BGnIpfQGYAMIqM2C0r/3A7ok/IjVtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732637612; c=relaxed/simple;
	bh=v6OAqnoDPSt07ROZ47jgRFk2b4k7RTATIakPJwN1X+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCmsn0HdKN4wTa+ztzCoH+EOSYIUQqWtXfDWo4rXoYiIg73eZ5S6xZZ1eWNWjI5+34FVVl+576YsHkJA9RvXSgmZThvKFooQryjDRKQhoBx/ELJjU2EEk2PSsveZUliJlGgut+qJzGCQ2hwVoDLZJwbxQ0tyj5yVgPwFWgmbMqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MNd9zla1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/seIqjdu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j8ACsEI/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6RvAzkd7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D781921164;
	Tue, 26 Nov 2024 16:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732637609;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1kg2P4Ndcd4ut2GqD5y34q+x31PuPSI7imrsLMbiwBQ=;
	b=MNd9zla10vOR1IjCZulYhHaK0P0uUIf2s7fArKYNfvSsarFSa9lg17AWivv94Y2NqXdil4
	vm47pdfIvNuspLeIndmPqdwuL48WRnIMrHqNcvF7vre0R5jnIt6/ZfqWCu2iKwgo34q/Lz
	QMTbpjvPcsZk/oJa719wv6XnVQtgGzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732637609;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1kg2P4Ndcd4ut2GqD5y34q+x31PuPSI7imrsLMbiwBQ=;
	b=/seIqjdu0L+SQkS4kPLy5abiIJQ++GdbBaKto51ULXWOlKdQW/YQ6REYmKKOlOw5sRqBeV
	pEjZCMoCbGqq0sDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732637608;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1kg2P4Ndcd4ut2GqD5y34q+x31PuPSI7imrsLMbiwBQ=;
	b=j8ACsEI/h0X8616WH9Is8Sjh9b9g9b0CckEmC/qSg4JrdU1qoaRe5telNMeCsL6xtjeNNQ
	ftrxmUsj/U/y5hco7OK2hBiDBannTHgA5sLA/FX+St0cuPemTE3tfyFvb69buoNgliGRFg
	QLKYSbW/OqZaUBAdm1Od2mkSSTSid54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732637608;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1kg2P4Ndcd4ut2GqD5y34q+x31PuPSI7imrsLMbiwBQ=;
	b=6RvAzkd7RgZpCT8Z8wQkiRilr8VlQzyltgbtWXLmE4qcQ43iCaXhcocz6YqaoA/addeuG7
	/bMQ0WTlTkB92UAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCAFF139AA;
	Tue, 26 Nov 2024 16:13:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WUPWLajzRWcoHQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 26 Nov 2024 16:13:28 +0000
Date: Tue, 26 Nov 2024 17:13:23 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Zorro Lang <zlang@redhat.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: a new test case to verify mount behavior with
 background remounting
Message-ID: <20241126161323.GK31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241101102956.174733-1-wqu@suse.com>
 <20241101125517.kb7akqvi5tae3wor@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <867b68d9-d873-4416-8d6d-be56bfc11542@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <867b68d9-d873-4416-8d6d-be56bfc11542@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Sat, Nov 02, 2024 at 07:08:44AM +1030, Qu Wenruo wrote:
> >> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1 >> $seqres.full
> >> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol2 >> $seqres.full
> >
> > Hmm... I wondering what'll happen, if remove these two lines then run this test
> > on other filesystems :)
> 
> Not sure about other filesystems, but do other filesystems allows
> different RO/RW flags for the same fs?

The subvolumes utilize the bind mount, so other filesystems can do that
as well but this will also do the synchronization inside VFS, while the
subvolume mount is called internally.

