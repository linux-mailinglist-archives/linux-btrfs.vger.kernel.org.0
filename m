Return-Path: <linux-btrfs+bounces-19144-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B03FC6E99C
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 13:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1D4A4FE80B
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 12:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D25834846D;
	Wed, 19 Nov 2025 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kgJ3jKEY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+dMUfjO2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kgJ3jKEY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+dMUfjO2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1119F1A7AE3
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555793; cv=none; b=OeYjM1v166KwBIttAzbqsjQkKi/pbtEjUL3HnUjQKsiMQJXyqK7XzfYsI3BqEOoqGfJo5sIjC+H719cSBXCqGP2PtmWEj30sDTwKOG6W8JHOt+IYekFV/Zy0xOwmLuhzo9wfbKSsZkmqJJDX0ceP/Dqk4UqLjkMK+Qku7I55AJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555793; c=relaxed/simple;
	bh=0wMfWNv6PGqEfOTXHs9WuzjqYFUY8tKvZeptPndQ9Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRIoSy9A5QOZH/iMRXxddd/ZUwNYqaShX1DCSvWJTbbFYZVtXAt5C96PT7JYS9UK2EoX5LC21c2fGgPUk2J2mNIx2VnPUlPEucgiIyfdt7aipe7rwoSHACnG07C1Z0oq+tlvFUeNU2rGOKynfBeAd6D2eAMRJAgTXFUUcXJWaC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kgJ3jKEY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+dMUfjO2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kgJ3jKEY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+dMUfjO2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1BEE12042B;
	Wed, 19 Nov 2025 12:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763555790;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=18OCw2FY3zyP//CDPAdkOiD9pcJkdtsMX+1rvczLHAg=;
	b=kgJ3jKEYkcCzFpXA93+5dSuiEom3PQPfacnswHMrCL6RjlqG2BDzlDYFr1yn+EL8KPLt3v
	JD/loATn0aqi+qJok++NmDMCdeuZ76BBUdD5ToJoL9OzojZJxsz2GuR9i2wh2XiJ4AwpiM
	TCSexLquPIlbNgzTswfANQcptfS/Sis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763555790;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=18OCw2FY3zyP//CDPAdkOiD9pcJkdtsMX+1rvczLHAg=;
	b=+dMUfjO2MJEy8Bbf3ucJMa+BzSJcT5DHFueeJ0k6XHtVHktrx4FoShpxRs6IzZger5+AQb
	VqiGsfizcbdgfIAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763555790;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=18OCw2FY3zyP//CDPAdkOiD9pcJkdtsMX+1rvczLHAg=;
	b=kgJ3jKEYkcCzFpXA93+5dSuiEom3PQPfacnswHMrCL6RjlqG2BDzlDYFr1yn+EL8KPLt3v
	JD/loATn0aqi+qJok++NmDMCdeuZ76BBUdD5ToJoL9OzojZJxsz2GuR9i2wh2XiJ4AwpiM
	TCSexLquPIlbNgzTswfANQcptfS/Sis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763555790;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=18OCw2FY3zyP//CDPAdkOiD9pcJkdtsMX+1rvczLHAg=;
	b=+dMUfjO2MJEy8Bbf3ucJMa+BzSJcT5DHFueeJ0k6XHtVHktrx4FoShpxRs6IzZger5+AQb
	VqiGsfizcbdgfIAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A5B03EA61;
	Wed, 19 Nov 2025 12:36:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YUJeAs65HWmDBgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 19 Nov 2025 12:36:30 +0000
Date: Wed, 19 Nov 2025 13:36:28 +0100
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: fix data race on transaction->state
Message-ID: <20251119123628.GG13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1763481355.git.josef@toxicpanda.com>
 <9db5125d171003458bcf98470f4044c5890fb789.1763481355.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9db5125d171003458bcf98470f4044c5890fb789.1763481355.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:replyto,toxicpanda.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Tue, Nov 18, 2025 at 10:59:28AM -0500, Josef Bacik wrote:
> Debugging a hang with btrfs on QEMU I discovered a data race with
> transaction->state. In wait_current_trans we do
> 
> wait_event(fs_info->transaction_wait,
> 	   cur_trans->state>=TRANS_STATE_UNBLOCKED ||
> 	   TRANS_ABORTED(cur_trans));
> 
> however we're doing this outside of the fs_info->trans_lock. This
> generally isn't super problematic because we hit
> wake_up(fs_info->transaction_wait) quite a bit, but it could lead to
> latencies where we miss wakeups, or in the worst case (like the compiler
> re-orders the load of the ->state outside of the wait_event loop) we
> could hang completely.

I doubt that compiler could reorder the read outside of wait_event(),
this would potentially break any use of the macro. The condition is
evaluated each time after wake up and there's a barrier implied
(wait_event -> __wait_event -> prepare_to_wait_event -> spin lock or
set_task_state).

The transaction state changes could cause some missed wakeups though I
don't see exactly where and how. The ONCE annotations do not affect the
code, eg before each wake_up() it's a no-op as there's implied barrier.
Inside the trans_lock section this could potentially bleed out and
interact with unprotected read of ->state. This is where we should look
and which could cause the hangs you observe.

> Fix this by using WRITE_ONCE whenever we update trans->state, and use
> READ_ONCE everywhere we're not holding fs_info->trans_lock.

As this is about inter process interaction the *_ONCE annotation is not
the right fix, if we need a wrapper for the unlocked acceess we need to
use the smp_* barriers.

> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/disk-io.c     |  8 ++++----
>  fs/btrfs/qgroup.c      |  2 +-
>  fs/btrfs/transaction.c | 28 +++++++++++++++-------------
>  fs/btrfs/volumes.c     |  3 ++-
>  4 files changed, 22 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 0aa7e5d1b05f..3859d934f658 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4795,17 +4795,17 @@ void btrfs_cleanup_one_transaction(struct btrfs_transaction *cur_trans)
>  
>  	btrfs_destroy_delayed_refs(cur_trans);
>  
> -	cur_trans->state = TRANS_STATE_COMMIT_START;
> +	WRITE_ONCE(cur_trans->state, TRANS_STATE_COMMIT_START);
>  	wake_up(&fs_info->transaction_blocked_wait);

Removing the unnecessary annotations like this one will probably show
the remaining problematic cases.

