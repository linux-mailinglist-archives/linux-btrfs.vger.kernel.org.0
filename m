Return-Path: <linux-btrfs+bounces-1126-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE2F81C586
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Dec 2023 08:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6643B1F223AB
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Dec 2023 07:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025C3D530;
	Fri, 22 Dec 2023 07:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Wm264sNQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5A0ubJ+L";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Wm264sNQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5A0ubJ+L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2CAD2E0;
	Fri, 22 Dec 2023 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F8461FCD6;
	Fri, 22 Dec 2023 07:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703230257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ymDyiqX4ogXhrvbCgVVJhu3sFiirKCyNYF8ej/HXb9E=;
	b=Wm264sNQKsBSfTbhermQhXPjFXgUro0qj5oDPcmWfOhKhWJwJxd0U4BYSZao7ZDwste+4I
	ro0eaK329QOFwGCBueuVJu6SAdeDoHFXw4zmJsi64JFS6ed8T8Db+QBZtzeCnmzf+gEUDn
	XyTvi47qWG/nSXcNYne6o1CHLBGCnQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703230257;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ymDyiqX4ogXhrvbCgVVJhu3sFiirKCyNYF8ej/HXb9E=;
	b=5A0ubJ+Lm3w3wO0KyNQJ0JX9sa76fuZxbRMJn8co/a7/kQVm4CraR6gFYFX3cbAV2kBFT3
	u0umjO3kz8xaFSAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703230257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ymDyiqX4ogXhrvbCgVVJhu3sFiirKCyNYF8ej/HXb9E=;
	b=Wm264sNQKsBSfTbhermQhXPjFXgUro0qj5oDPcmWfOhKhWJwJxd0U4BYSZao7ZDwste+4I
	ro0eaK329QOFwGCBueuVJu6SAdeDoHFXw4zmJsi64JFS6ed8T8Db+QBZtzeCnmzf+gEUDn
	XyTvi47qWG/nSXcNYne6o1CHLBGCnQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703230257;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ymDyiqX4ogXhrvbCgVVJhu3sFiirKCyNYF8ej/HXb9E=;
	b=5A0ubJ+Lm3w3wO0KyNQJ0JX9sa76fuZxbRMJn8co/a7/kQVm4CraR6gFYFX3cbAV2kBFT3
	u0umjO3kz8xaFSAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E369136D6;
	Fri, 22 Dec 2023 07:30:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NdPnCy87hWUSYQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Fri, 22 Dec 2023 07:30:55 +0000
Date: Fri, 22 Dec 2023 18:30:47 +1100
From: David Disseldorp <ddiss@suse.de>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] fstests: btrfs: use proper filter for subvolume
 deletion
Message-ID: <20231222183047.4dc7d8ba@echidna>
In-Reply-To: <zc6nx5hyhpticuwhcjiahbp67sjteqqehfhnrpk4kwvhyrwmq4@lf6uhzx6nst3>
References: <727fc0e695846a43830bdfc2d6757d6edc2d6878.1703213691.git.naohiro.aota@wdc.com>
	<20231222160726.7206676f@echidna>
	<zc6nx5hyhpticuwhcjiahbp67sjteqqehfhnrpk4kwvhyrwmq4@lf6uhzx6nst3>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [0.39 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[46.77%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 0.39
X-Spam-Flag: NO

On Fri, 22 Dec 2023 06:02:41 +0000, Naohiro Aota wrote:

> > >  # Import common functions.
> > >  . ./common/filter
> > > +. ./common/filter.btrfs  
> > 
> > common/filter.btrfs sources common/filter, so you can replace these.  
> 
> Oh, I didn't notice that. But, there are many test cases importing
> both. Maybe, it's good to express direct dependency (e.g, for
> _filter_scratch) explicitly? Or, they should be fixed as well?

I don't have a strong preference either way. I don't see any ordering
dependencies, so separate imports would also work.

Cheers, David

