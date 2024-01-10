Return-Path: <linux-btrfs+bounces-1340-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED598291AE
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 02:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7599E1C2413E
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 01:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D8A81F;
	Wed, 10 Jan 2024 01:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RJMJS7gd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DCzFngSm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RJMJS7gd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DCzFngSm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F2563D
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 01:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 993391F83E;
	Wed, 10 Jan 2024 01:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704848527;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E4PR5cAxV8IBrZn1PUcg01taecP/flmImpZaNC2zyfE=;
	b=RJMJS7gdCNVrtjjmFyU3RrrjG+BiBVryjODVmltB61uVvpHpgc8JZq0ukqan4W6k2gtJrX
	j9b8pcD0t/2RW2RGHs3Xd6jTlkZQs0IoNclDSUQSHgCRNWp4zDsik/yUj9aWL227Wgsr0a
	j5VPQhR12vLPESs+qWJECkv+jnZR0j4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704848527;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E4PR5cAxV8IBrZn1PUcg01taecP/flmImpZaNC2zyfE=;
	b=DCzFngSmvXrx4IPuzgEaDmRq84ktOfctINQ4uj5i5muKGrlgEwKFVYv8hXJGDbs5BdLZ14
	H25A7uRfpMa+TJAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704848527;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E4PR5cAxV8IBrZn1PUcg01taecP/flmImpZaNC2zyfE=;
	b=RJMJS7gdCNVrtjjmFyU3RrrjG+BiBVryjODVmltB61uVvpHpgc8JZq0ukqan4W6k2gtJrX
	j9b8pcD0t/2RW2RGHs3Xd6jTlkZQs0IoNclDSUQSHgCRNWp4zDsik/yUj9aWL227Wgsr0a
	j5VPQhR12vLPESs+qWJECkv+jnZR0j4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704848527;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E4PR5cAxV8IBrZn1PUcg01taecP/flmImpZaNC2zyfE=;
	b=DCzFngSmvXrx4IPuzgEaDmRq84ktOfctINQ4uj5i5muKGrlgEwKFVYv8hXJGDbs5BdLZ14
	H25A7uRfpMa+TJAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BA3C13786;
	Wed, 10 Jan 2024 01:02:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UD7eIY/snWVebwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 10 Jan 2024 01:02:07 +0000
Date: Wed, 10 Jan 2024 02:01:53 +0100
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: WARN_ON_ONCE() in our leak detection code
Message-ID: <20240110010153.GO28693@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <f94513bea5369c4ea65c8dab9a5a83403381c521.1704226673.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f94513bea5369c4ea65c8dab9a5a83403381c521.1704226673.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: **
X-Spam-Score: 2.59
X-Spamd-Result: default: False [2.59 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.91)[86.11%]
X-Spam-Flag: NO

On Tue, Jan 02, 2024 at 03:18:07PM -0500, Josef Bacik wrote:
> fstests looks for WARN_ON's in dmesg.  Add WARN_ON_ONCE() to our leak
> detection code so that fstests will fail if these things trip at all.
> This will allow us to easily catch problems with our reference counting
> that may otherwise go unnoticed.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.

