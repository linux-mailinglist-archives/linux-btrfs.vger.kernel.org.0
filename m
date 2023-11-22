Return-Path: <linux-btrfs+bounces-280-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D78227F47F7
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 14:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91DDD281480
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 13:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AE45647B;
	Wed, 22 Nov 2023 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1PZFYhom";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6jxt5kZO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13838BC
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 05:41:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 35F6A1F8D7;
	Wed, 22 Nov 2023 13:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700660496;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qaxUy0Ulvlus1yIQ52QQOuIRL+vQodardSRrtB6Si6g=;
	b=1PZFYhomwgqzhwC3OPAorfmjEVMSxsAVs2lcA+CmAONNgxJwglMcPrf3v52h5n/RHDolLv
	KX9WvVszPWwYI5wX2RzJFNNhgfymaeryQTVkLv/Jiki08KI1ge80ZnBfe2Pc++Bk5Y42od
	H06gH5wqmqidxFM5l4RwGGb6AHBOXHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700660496;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qaxUy0Ulvlus1yIQ52QQOuIRL+vQodardSRrtB6Si6g=;
	b=6jxt5kZOsNyE+PIhdBa2gMh2SE2fTYRv5CNuDx448sqTDUmS3OLDEB5oW4Q3qwJ4HZ9cGu
	KeG+CgftcfC45gBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16E2413467;
	Wed, 22 Nov 2023 13:41:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id DxfWBBAFXmXRcAAAMHmgww
	(envelope-from <dsterba@suse.cz>); Wed, 22 Nov 2023 13:41:36 +0000
Date: Wed, 22 Nov 2023 14:34:26 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: allow extent buffer helpers to skip
 cross-page handling
Message-ID: <20231122133426.GA11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <721bab821198fc9b49d2795b2028ed6c436ab886.1700111928.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <721bab821198fc9b49d2795b2028ed6c436ab886.1700111928.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.03
X-Spamd-Result: default: False [-1.03 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.944];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.05)[59.25%]

On Thu, Nov 16, 2023 at 03:49:06PM +1030, Qu Wenruo wrote:
> Currently btrfs extent buffer helpers are doing all the cross-page
> handling, as there is no guarantee that all those eb pages are
> contiguous.
> 
> However on systems with enough memory, there is a very high chance the
> page cache for btree_inode are allocated with physically contiguous
> pages.
> 
> In that case, we can skip all the complex cross-page handling, thus
> speeding up the code.
> 
> This patch adds a new member, extent_buffer::addr, which is only set to
> non-NULL if all the extent buffer pages are physically contiguous.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.

> ---
> Reason for RFC:
> 
> This change would increase the code size for all extent buffer helpers,
> and since there one more branch introduced, it may even slow down the
> system if most ebs do not have physically contiguous pages.

> But I still believe this is worthy trying, as my previous attempt to
> use virtually contiguous pages are rejected due to possible slow down in
> vm_map() call.
> 
> I don't have convincing benchmark yet, but so far no obvious performance
> drop observed either.

I've looked at the assembly code, it's "just" one test/jump in
frequently used functions but the slow path handling cross-page changes
is slow anyway.

