Return-Path: <linux-btrfs+bounces-6208-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9E9927CF7
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 20:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF401C2204E
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 18:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC307757E7;
	Thu,  4 Jul 2024 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XeUW6A1v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jzwB/h9f";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XeUW6A1v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jzwB/h9f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A47D62171
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jul 2024 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720117500; cv=none; b=ItY1g+VMjBEKi5ZpBHHvhEnecj1uOJ63TPGnDb+PGIuMgeXhDSW6nXhJsuZpuxeV0QyXXtZ8eLNizCFPY/uhg4rLp9hvCWflU4CiNh6v9HbAYSVznZ1NsWlXIlIXUGhe3cZSIn75uv8/e3CTFcAwxBkbIKeONV0sv4F8c7RmJKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720117500; c=relaxed/simple;
	bh=losupFkXvEjw8v3XKVCu3L8tHJDKe1ku9mjS1iUimkI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I0ajWxhwO9kntwrHnREVxMl3kK9sIUINvpVHmzMEsv8Bpc4Iam45jZ3NomSgFPT51uMBBQt3G6Q6x+kuIHm5iLsoPV+z6U4zRTtzb5/a0UZ+kMfGMtGQoIcyVk5b6WnrE+GoWoNiiqSCzi25wDzHPHYskzlb+yDxLm4aJDOwozA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XeUW6A1v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jzwB/h9f; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XeUW6A1v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jzwB/h9f; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1467D21BB2;
	Thu,  4 Jul 2024 18:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720117496;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=losupFkXvEjw8v3XKVCu3L8tHJDKe1ku9mjS1iUimkI=;
	b=XeUW6A1vS8q8BkEWjpah2dzCy3qWbdL2Gwr5m80M/7j9ey9s8PzUKRrJJpw0ln3pIROVFl
	cB2JtGTZ0vaXsF1fchoP305hKxtplActt1/W35aRPHCfIfpE8RZ7arCeD1/J3ctgprQhXr
	ryiMRPZHjb82fEoQIaf+l2SDejDpvFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720117496;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=losupFkXvEjw8v3XKVCu3L8tHJDKe1ku9mjS1iUimkI=;
	b=jzwB/h9fFREw9qY3TyCucjL/CZIW/0gc+nXxJd6uUhGPaCdW41TXDh6+a8U/U8SsQ8seLU
	f3VhqbEJ80s3kJBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XeUW6A1v;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="jzwB/h9f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720117496;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=losupFkXvEjw8v3XKVCu3L8tHJDKe1ku9mjS1iUimkI=;
	b=XeUW6A1vS8q8BkEWjpah2dzCy3qWbdL2Gwr5m80M/7j9ey9s8PzUKRrJJpw0ln3pIROVFl
	cB2JtGTZ0vaXsF1fchoP305hKxtplActt1/W35aRPHCfIfpE8RZ7arCeD1/J3ctgprQhXr
	ryiMRPZHjb82fEoQIaf+l2SDejDpvFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720117496;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=losupFkXvEjw8v3XKVCu3L8tHJDKe1ku9mjS1iUimkI=;
	b=jzwB/h9fFREw9qY3TyCucjL/CZIW/0gc+nXxJd6uUhGPaCdW41TXDh6+a8U/U8SsQ8seLU
	f3VhqbEJ80s3kJBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05C3F1369F;
	Thu,  4 Jul 2024 18:24:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IgrcAPjohmY9bwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 04 Jul 2024 18:24:56 +0000
Date: Thu, 4 Jul 2024 20:24:54 +0200
From: David Sterba <dsterba@suse.cz>
To: linux-btrfs@vger.kernel.org
Subject: Btrfsmaintenance 0.5.2
Message-ID: <20240704182454.GZ21023@twin.jikos.cz>
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
X-Spamd-Result: default: False [-4.05 / 50.00];
	BAYES_HAM(-2.84)[99.30%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	URIBL_BLOCKED(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1467D21BB2
X-Spam-Flag: NO
X-Spam-Score: -4.05
X-Spam-Level: 

Hi,

a bug fix release.

- fix syntax error in run_task, preventing jobs to start
- start scrub jobs sequentially if RAID5 or RAID6 data profile is found
- fix btrfsmaintenance-refresh.service description

https://github.com/kdave/btrfsmaintenance
https://github.com/kdave/btrfsmaintenance/releases/tag/v0.5.2

