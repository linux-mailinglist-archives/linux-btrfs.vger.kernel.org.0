Return-Path: <linux-btrfs+bounces-1368-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FDC829EE4
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 18:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE21284319
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 17:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521694CE09;
	Wed, 10 Jan 2024 17:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XRZc2Bvm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oBftLUgo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XRZc2Bvm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oBftLUgo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5104C3C8
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 54CC22228F;
	Wed, 10 Jan 2024 17:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704906582;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wpsli+ADdK+IAZSHKAl2lyb6C05kG4vEL3IrjE0Vroo=;
	b=XRZc2BvmEhnssYB0TSq0BfbMceB2Tc3Sg8Ygi554lUIjRsre3C9fur3uAaYKpZZtdpM09H
	eH+UsOnfnDOOL6CnW7HPme1UWMXotB8SFh2LM9BF8qV0sWQFqyNDL5ZFYjIhxbAlH8a3RM
	TUC54K8XZY8r9w13n4Lcmc6vIh1zZqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704906582;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wpsli+ADdK+IAZSHKAl2lyb6C05kG4vEL3IrjE0Vroo=;
	b=oBftLUgoAr7sGPXGRZqDtJdh1qA17VoV1b/GB4CQwNJY7zM6im4pqfg7XPaQ/yo2LlEgMM
	z5qJ9MXgKDyvj0BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704906582;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wpsli+ADdK+IAZSHKAl2lyb6C05kG4vEL3IrjE0Vroo=;
	b=XRZc2BvmEhnssYB0TSq0BfbMceB2Tc3Sg8Ygi554lUIjRsre3C9fur3uAaYKpZZtdpM09H
	eH+UsOnfnDOOL6CnW7HPme1UWMXotB8SFh2LM9BF8qV0sWQFqyNDL5ZFYjIhxbAlH8a3RM
	TUC54K8XZY8r9w13n4Lcmc6vIh1zZqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704906582;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wpsli+ADdK+IAZSHKAl2lyb6C05kG4vEL3IrjE0Vroo=;
	b=oBftLUgoAr7sGPXGRZqDtJdh1qA17VoV1b/GB4CQwNJY7zM6im4pqfg7XPaQ/yo2LlEgMM
	z5qJ9MXgKDyvj0BA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C9420139C6;
	Wed, 10 Jan 2024 17:08:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id K4XiLwnPnmXUDAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 10 Jan 2024 17:08:25 +0000
Date: Wed, 10 Jan 2024 18:09:41 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Christoph Anton Mitterer <calestyo@scientia.org>
Subject: Re: [PATCH] btrfs: defrag: add under utilized extent to defrag
 target list
Message-ID: <20240110170941.GA31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2c2fac36b67c97c9955eb24a97c6f3c09d21c7ff.1704440000.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c2fac36b67c97c9955eb24a97c6f3c09d21c7ff.1704440000.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.07
X-Spamd-Result: default: False [-1.07 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.07)[62.26%]
X-Spam-Flag: NO

On Fri, Jan 05, 2024 at 06:03:40PM +1030, Qu Wenruo wrote:
> [BUG]
> The following script can lead to a very under utilized extent and we
> have no way to use defrag to properly reclaim its wasted space:
> 
>   # mkfs.btrfs -f $dev
>   # mount $dev $mnt
>   # xfs_io -f -c "pwrite 0 128M" $mnt/foobar
>   # sync
>   # btrfs filesystem defrag $mnt/foobar
>   # sync

I don't see what's wrong with this example, as Filipe noted there's a
truncate missing, but still this should be explained better.

Is this the problem when an overwritten and shared extent is partially
overwritten but still occupying the whole range, aka. bookend extent?
If yes, defrag was never meant to deal with that, though we could use
the interface for that.

As Andrei pointed out, this is more like a garbage collection, get rid
of extent that is partially unreachable. Detecting such extent requires
looking for the unreferenced part of the extent while defragmentation
deals with live data. This could be a new ioctl entirely too. But first
I'd like to know if we're talking about the same thing.

