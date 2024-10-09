Return-Path: <linux-btrfs+bounces-8746-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B3F9973FD
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 20:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A1428926B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 18:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88AF1E0E08;
	Wed,  9 Oct 2024 18:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C9utfMCP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FzCukVwg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C9utfMCP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FzCukVwg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C977710C
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496986; cv=none; b=n+/zXY8vRxEVesFiJewDUi2vVJh6Wjk5ATzAN28gxAFA+t9qdNsW/cy5cGMESLHN2JEwK/T5TVKg0ZF4b/6ImXE5ZKQfUeijmDBzaserUgxD3dCW3mgCi9gd7b/+Z+7I15WpySa/IhvMBetCb/B6x/hQTeXszxaVrgzv2xlFQgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496986; c=relaxed/simple;
	bh=b29JA3JOujLHLGLwoxBMgvMzgY4+W8mAnFj1+TLoDrc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=b7/LeKenWiHqQxfaapOnoFrzJS15N2Cu1SXGzEjHnxXMWyDe2sTETRDKJsGNQGFqyDP/eZy0YMonX4slNVIsf3Z2t2LeT7+ZpQHdNE+yRBggQHQoqD65WOp1DBsrn06PEIkJFUEYwCZdX7dD5c5vbQdXhSh0ALlkhkRuFwYodds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C9utfMCP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FzCukVwg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C9utfMCP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FzCukVwg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1F2331FDC2;
	Wed,  9 Oct 2024 18:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728496982;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=N31OTu50coNuZUIOSw8xEJfaODAUEclZI6i6YP4TkQs=;
	b=C9utfMCPvCIZHBXm2n0jmZawCALZ55HkOdbUkFaLBoacQCWZ5yfhtndhRwT0dETB0/EkX/
	uT5Gz0fSeLYxxVgVAOvSHESYtCHE1t4r0noxE9zhlryNZWlKLfHqkaTIdB80gClOy3UV5b
	jPX4hOUpOP9OuUeAk/VMNL2GeevoT6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728496982;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=N31OTu50coNuZUIOSw8xEJfaODAUEclZI6i6YP4TkQs=;
	b=FzCukVwg9NK/znhICiSx0OmhFCTGbOSk33HlhlQ+qEcT8J+rp1DUYk1Kb01rVp6GY3JbjA
	ZYeB+Xj1LljeLuCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=C9utfMCP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FzCukVwg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728496982;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=N31OTu50coNuZUIOSw8xEJfaODAUEclZI6i6YP4TkQs=;
	b=C9utfMCPvCIZHBXm2n0jmZawCALZ55HkOdbUkFaLBoacQCWZ5yfhtndhRwT0dETB0/EkX/
	uT5Gz0fSeLYxxVgVAOvSHESYtCHE1t4r0noxE9zhlryNZWlKLfHqkaTIdB80gClOy3UV5b
	jPX4hOUpOP9OuUeAk/VMNL2GeevoT6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728496982;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=N31OTu50coNuZUIOSw8xEJfaODAUEclZI6i6YP4TkQs=;
	b=FzCukVwg9NK/znhICiSx0OmhFCTGbOSk33HlhlQ+qEcT8J+rp1DUYk1Kb01rVp6GY3JbjA
	ZYeB+Xj1LljeLuCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07E7D13A58;
	Wed,  9 Oct 2024 18:03:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FaJLAVbFBmfWBgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 09 Oct 2024 18:03:02 +0000
Date: Wed, 9 Oct 2024 20:03:00 +0200
From: David Sterba <dsterba@suse.cz>
To: linux-btrfs@vger.kernel.org
Subject: [RFC] New ioctl to query deleted subvolumes
Message-ID: <20241009180300.GN1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 1F2331FDC2
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

Hi,

I'd like some user feedback on a new ioctl that should handle several use cases
around subvolume deletion. Currently it's implemented on top of the privileged
SEARCH_TREE ioctl, it's not possible to do that with libbtrfsutil or
unprivileged ioctls.

The use cases:

  1) wait for a specific id until it's cleaned (blocking, not blocking)

This is what 'btrfs subvol sync id' does. In the non-blocking mode it checks if
a subvolume is in the queue for deletion.

  2) wait for all currently queued subvolumes (blocking)

Same as 'btrfs subvol sync' without any id.

  3) read id of the currently cleaned subvolume (not blocking)

Allow to implement sync purely in user space.

  4) read id of the last in the queue (not blocking)

As the subvolumes are added to the list in the order of deletion, reading the
last one is kind of a checkpoint. More subvolumes can be added to the queue in
the meanwhile so this adds some flexibility to applications.

  5) count the number of queued subvolumes (not blocking)

This is for convenience and progress reports.


There are some questions and potential problems stemming from the general
availability of the ioctl:

- the operations will need to take locks and/or lookup the subvolumes in the
  data structures, so it could be abused to overload the locks, but there are
  more such ways how to do that so I'm not sure what to do here

- deleted subvolume loses it's connection to path in directory hierarchy, so
  querying an id does not tell us if the user was allowed to see the subvolume

- the blocking operations can take a timeout parameter (seconds), this is for
  convenience, otherwise a simple "while (ioctl) sleep(1)" will always work


My questions:

- Are there other use cases that are missing from the list?

- Are there use cases that should not be implemented? E.g. not worth the
  trouble or not really useful.

I have a prototype for 1 and 2, the others would be easy to implement
but the number of cases affects the ioctl design (simple id vs modes).

Thanks.

