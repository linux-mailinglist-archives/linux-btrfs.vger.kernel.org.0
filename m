Return-Path: <linux-btrfs+bounces-17176-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CBFB9EE6A
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 13:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE1C3853CD
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 11:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EB82F7ACE;
	Thu, 25 Sep 2025 11:27:55 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF471A9F8D
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Sep 2025 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758799674; cv=none; b=aS6MX+BKdAp8Qg8nQzQ4CKrLlG0u3fQhsigssvptPr7gGetKjYTaCNqfgN+vKNQ1oGcTTOVyHci67Xwv44GrHR/8k7Njse6jH4kacubzIItqruYk9bpLmmHSbcqaYAOSNwm/wf0RwD1BY138VcyriPlKOXsMEI86z8/jCOH2sW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758799674; c=relaxed/simple;
	bh=vWHoojtI1/dffhDfAsvwy7MnGEhyCm/Fh/r62Cu1k/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSDLUfuPPGd+t3XqJx1Sbdv1pB0rfK3PWBhe4xhXNVC6sx77AwRcV44vOYTSVCknW1sxHsJ6u18KCWZJedV/tGptMxgY8Q/QXkYFDxqhnmIYcUWVn+nzGxttKNzaRIkDVnW0AFhEdxCcpLsfyfHugfRriFZnZNPyXp+VJF7U2ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3BA086A96F;
	Thu, 25 Sep 2025 11:27:51 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B8F513869;
	Thu, 25 Sep 2025 11:27:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qXNyCjcn1WgYBQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 25 Sep 2025 11:27:51 +0000
Date: Thu, 25 Sep 2025 13:27:49 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] btrfs: remove the unnecessary NULL fs_info check from
 find_lock_delalloc_range()
Message-ID: <20250925112749.GN5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <686d2506851c2df8cb9ceab5241b15bb01737ebb.1758793968.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <686d2506851c2df8cb9ceab5241b15bb01737ebb.1758793968.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 3BA086A96F
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Thu, Sep 25, 2025 at 07:23:22PM +0930, Qu Wenruo wrote:
> [STATIC CHECK REPORT]
> Smatch is reporting that find_lock_delalloc_range() used to do a null
> pointer check before accessing fs_info, but now we're accessing it for
> sectorsize unconditionally.
> 
> [FALSE ALERT]
> This is a false alert, the existing null pointer check is introduced in
> commit f7b12a62f008 ("btrfs: replace BTRFS_MAX_EXTENT_SIZE with
> fs_info->max_extent_size"), but way before that, commit 7c0260ee098d
> ("btrfs: tests, require fs_info for root") is already forcing every
> btrfs_root to have a correct fs_info pointer.
> 
> So there is no way that btrfs_root::fs_info is NULL.
> 
> [FIX]
> Just remove the unnecessary NULL pointer checker.
> 
> Fixes: f7b12a62f008 ("btrfs: replace BTRFS_MAX_EXTENT_SIZE with fs_info->max_extent_size")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202509250925.4L4JQTtn-lkp@intel.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

