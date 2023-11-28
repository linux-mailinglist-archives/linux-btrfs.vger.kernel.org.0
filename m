Return-Path: <linux-btrfs+bounces-413-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A0B7FBED3
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 17:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C047828260A
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 16:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F1A1E4AF;
	Tue, 28 Nov 2023 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BV2yIk8x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vLcW6q/0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBC3D51
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Nov 2023 08:03:16 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AD1FB219A1;
	Tue, 28 Nov 2023 16:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701187392;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ihUvSz/RPWLjxO6xnLvcGJHzVYhPCjqFbShedE3Hb7s=;
	b=BV2yIk8xGgzGM6WRVx4AIsG0G2nhnczPcsSzKhilAbjb3L9lKu9ZS7p5xzaeNap6PhvGxp
	5q/uUEwVNisTtyMxBCaFg5lBy2qy1HL/UCrdVUmSgPDILb6PgXiH/WTS/tAOuUoCAHLmyx
	Z4SAfX00Vn+vkVFfUlxT4Ns/pghiIkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701187392;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ihUvSz/RPWLjxO6xnLvcGJHzVYhPCjqFbShedE3Hb7s=;
	b=vLcW6q/0Df7y1sdxV9OKo7Y/ZCOYiHpLf9a6qVA4dOQgzwUUsNTXnMsvhSvytm6VpmcSGn
	Mhf9kGB3cgCWAbDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EEA6133B5;
	Tue, 28 Nov 2023 16:03:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id GzqQJkAPZmUhUQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 28 Nov 2023 16:03:12 +0000
Date: Tue, 28 Nov 2023 16:55:59 +0100
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix compile error with !CONFIG_BTRFS_FS_POSIX_ACL
Message-ID: <20231128155559.GJ18929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b649ade5b712e47f4b4b3793943fa304edb26bba.1701183605.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b649ade5b712e47f4b4b3793943fa304edb26bba.1701183605.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spamd-Result: default: False [-1.02 / 50.00];
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
	 SUBJECT_HAS_EXCLAIM(0.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[toxicpanda.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[52.25%]
X-Spam-Score: -1.02

On Tue, Nov 28, 2023 at 10:00:59AM -0500, Josef Bacik wrote:
> I accidentally introduced a compile error with
> !CONFIG_BTRFS_FS_POSIX_ACL in my mount api v2 patches.  Fix this by just
> returning -EINVAL.
> 
> Fixes: ed6a5b9bae38 ("btrfs: add parse_param callback for the new mount api")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> The fixes tag isn't useful because it's in my local branch, I put it in there so
> you have the title to fold this into the actual patch that introduced the
> problem.

Yeah I use the title to find the patches, you can still use the Fixes:
tag as it'a common format. The mount API switch is in a topic branch,
I'll move it to misc-next soon.

