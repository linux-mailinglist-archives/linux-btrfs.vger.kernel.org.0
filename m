Return-Path: <linux-btrfs+bounces-8392-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB5198C1A8
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 17:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A641F24D92
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 15:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F0F1C68BD;
	Tue,  1 Oct 2024 15:30:50 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACD128FF
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Oct 2024 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796650; cv=none; b=AcpfbdW8oOcdHu/IZ1seSnTXL9j3jWrCHRO5LTNQ7aAozdW+RzGNJcAklmjtqa6RvpuFSVcprhdWvt1krRYvWuLZC8D6UFL6V9+WDBVM/d2gFXCX5b1Y8+5R1qulmYx4IcPITaqQQU3MMhsFwh46DnrW1NFLlzuG5LsHIPx1+h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796650; c=relaxed/simple;
	bh=rnD58Htza2y/8kj2WaBRvyNNV9mFYCuu19oLZY94/Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2uzWQtc/RcBoeKa0wmAERD+i2YYBbPXfTL66XNnlAoAKuKYNyo+CWWwKTEegps8bwplcF5XBT/mSFO6EkgEAh5hiQMOwlwLqSCQ38XFs7IiIpCmeFZQjSUTAlZk3xfEariFtkO23556oJcvxq3R45WW9Yj7h+mvqOWrPxwJJq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2205A1F8AE;
	Tue,  1 Oct 2024 15:30:47 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0795D13A73;
	Tue,  1 Oct 2024 15:30:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 28WbAacV/GZiNQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 01 Oct 2024 15:30:47 +0000
Date: Tue, 1 Oct 2024 17:30:45 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: simplify the page uptodate preparation for
 prepare_pages()
Message-ID: <20241001153045.GE28777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1727736323.git.wqu@suse.com>
 <51064f30d856c1529d47d70dfb4f3cad46a42187.1727736323.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51064f30d856c1529d47d70dfb4f3cad46a42187.1727736323.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 2205A1F8AE
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Tue, Oct 01, 2024 at 08:17:11AM +0930, Qu Wenruo wrote:
> +	if (force_uptodate)
> +		goto read;
> +
> +	/* The dirty range fully cover the page, no need to read it out. */
> +	if (IS_ALIGNED(clamp_start, PAGE_SIZE) &&
> +	    IS_ALIGNED(clamp_end, PAGE_SIZE))
> +		return 0;
> +read:

I've commented under v1 and will repeat it here so it does not get lost,
this if and goto is not necessary here and can be a normal if () { ...  }

