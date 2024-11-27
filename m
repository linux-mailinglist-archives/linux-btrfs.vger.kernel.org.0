Return-Path: <linux-btrfs+bounces-9942-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8278F9DAACF
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2024 16:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4771D281DBD
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2024 15:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A334315A;
	Wed, 27 Nov 2024 15:30:44 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF501E51D
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2024 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732721444; cv=none; b=EPSqYfWINVuf8iEICpZh4plbh5+FppY7sP5DjcuOAxdMrGStbbcN73LYkXZGn9jRqOA4diaoy8obNp87uAjiJJktmsIaPzSrlx6LrXP2/+6meYkbA2zL+hhqTRZg9eaptDV8Z33t7J67xWa/kudmENXJJHNjRm78KlvpfTe5wO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732721444; c=relaxed/simple;
	bh=zRg7hftyVqQzsMn5VCc35vLrAt9EUs+fgIKRQ+jMsWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUBailtFgi1ym1d7jUnsa+KbOrBuCShZZMaTu8MQD6rChxltxXei8bhIsN+6INy0ggS2Zp+FWHVpfCadlcnmPiCuMrx6iLH+5rnTIqMERmojHTvSCNBsjJPzqPBUYwgW41DnJ2NxBR8JbpU+l3Vr+2Yyy7kul9PMti34tP3ALtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6315D21166;
	Wed, 27 Nov 2024 15:30:40 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 472A013941;
	Wed, 27 Nov 2024 15:30:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lLkiESA7R2crLgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 27 Nov 2024 15:30:40 +0000
Date: Wed, 27 Nov 2024 16:30:39 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: extra debug output for sector size < page
 size cases
Message-ID: <20241127153039.GO31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1732680197.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1732680197.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 6315D21166
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

On Wed, Nov 27, 2024 at 02:36:35PM +1030, Qu Wenruo wrote:
> The first patch is the long existing bug that full subpage bitmap dump
> is not working for checked bitmap.
> Thankfully even myself is not affected by the bug.
> 
> The second one is for a crash I hit where ASSERT() got triggered in
> btrfs_folio_set_locked() after a btrfs_run_delalloc_range() failure.
> 
> The last one is for the btrfs_run_delalloc_range() failure, which is
> not that rare in my environment, I guess the unsafe cache mode for my
> aarch64 VM makes it too easy to hit ENOSPC.
> 
> But ENOSPC from btrfs_run_delalloc_range() itself is already a problem
> for our data/metadata space reservation code, thus it should be
> outputted even for non-debug build.
> 
> Qu Wenruo (3):
>   btrfs: subpage: fix the bitmap dump for the locked flags
>   btrfs: subpage: dump the involved bitmap when ASSERT() failed
>   btrfs: add extra error messages for extent_writepage() failure

Reviewed-by: David Sterba <dsterba@suse.com>



