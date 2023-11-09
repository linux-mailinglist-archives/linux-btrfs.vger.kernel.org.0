Return-Path: <linux-btrfs+bounces-60-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C24E7E6AE6
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Nov 2023 14:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215F41C20B73
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Nov 2023 13:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5858D18C21;
	Thu,  9 Nov 2023 13:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GvQQCNJ7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ms/GsBWy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886F7111AA
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Nov 2023 13:04:05 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D516C2D78
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Nov 2023 05:04:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 837BC21959;
	Thu,  9 Nov 2023 13:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699535043;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+8ScEP0LHkCJy50zsjVy2+2oEAnn+M6z20gN8fiLgdk=;
	b=GvQQCNJ7ddXzq6DlYs/3ittStAFyZqVOATBEY2ippUjs6sio6FU7GTdj6yPvcNAMlNpcGy
	d7QDn2DxRCW3+oGq0q8hmYHcXrxc76Hu1b+2YFR8GaxwU0ciDQ2wUFDG6G/b3ajWv6xeBe
	uIJckbSualYlUrVQiTK6KMEj5pWz3xU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699535043;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+8ScEP0LHkCJy50zsjVy2+2oEAnn+M6z20gN8fiLgdk=;
	b=Ms/GsBWy4yWGIqpEfwl9xOvjUB4G2+8xv5L6H87xIs9sREtl8ptEdMvkEAeSGZ1zZvfkTC
	0SyTc9laUBmG+bBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 642C413524;
	Thu,  9 Nov 2023 13:04:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 8vQHF8PYTGUbRQAAMHmgww
	(envelope-from <dsterba@suse.cz>); Thu, 09 Nov 2023 13:04:03 +0000
Date: Thu, 9 Nov 2023 13:57:00 +0100
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: make OWNER_REF_KEY type value smallest among
 inline refs
Message-ID: <20231109125700.GQ11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <9336edeaca6f158da080da16b9c2ee0270d671a9.1699036594.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9336edeaca6f158da080da16b9c2ee0270d671a9.1699036594.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)

On Fri, Nov 03, 2023 at 11:38:04AM -0700, Boris Burkov wrote:
> BTRFS_EXTENT_OWNER_REF_KEY is the type of simple quotas extent owner
> refs. This special inline ref goes in front of all other inline refs.
> 
> In general, inline refs have a required sorted order s.t. type never
> decreases (among other requirements). This was recently reified into a
> tree-checker and fsck rule, which broke simple quotas. To be fair,
> though, in a sense, the new owner ref item had also violated that not
> yet fully enforced requirement.
> 
> This fix brings the owner ref item into compliance with the requirement
> that inline ref type never decrease.
> 
> btrfs/301 exercises this behavior and should pass again with this fix.
> 
> Fixes: 1d014d89f9ef (btrfs: tree-checker: add type and sequence check for inline backrefs)
> Signed-off-by: Boris Burkov <boris@bur.io>

Added to misc-next and I'll add it to the next week pull request, once
it's merged to Linus' tree I'll do a progs 6.6.2 witht the user space
part. Until then the tests may if the kernel and progs are not in sync.

