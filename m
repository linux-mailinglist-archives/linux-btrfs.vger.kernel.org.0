Return-Path: <linux-btrfs+bounces-5320-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FBA8D2072
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 17:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73CDE1C2335F
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 15:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F6B16FF5E;
	Tue, 28 May 2024 15:33:55 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2628E16F831
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716910434; cv=none; b=cxpajaDnEuhJTVk49I54W1g6oZoC5SuOV5TuK2/sOQU0K3i3eUxUxnTLxZbhcx61VyvNa3YsZnJi0jz7cWczstu1omvVy7zSejHC5bNPpaC53ihTK571gMKL99nF8oo2E/iSXl0Vu5CtaUL30mdgUMpS6zGhViM3w6VWkryUyA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716910434; c=relaxed/simple;
	bh=EVEObqlePCXh7vbck4SXOAeYTzQyihc1djeLIlnTchI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpgtH0ngXIxHdkT2Q2ngN4Cr256fXw1qcWEq/8/BFYxzmx87Ou+lf67E6Voz9mBz4rqJ2b3AG5MCTzYcOhaAwd5VffzBAc/mdcx15a7Ndp901y7CzqTNDazHtqFt174Kgi0sGfoXvNz0kIcOMYL/IgBRy2PIiLHMHyQAoZXVEEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4684E2033B;
	Tue, 28 May 2024 15:33:51 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37D2913A5D;
	Tue, 28 May 2024 15:33:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9mR+DV/5VWaPHAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 28 May 2024 15:33:51 +0000
Date: Tue, 28 May 2024 17:33:45 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: basic header cleanups
Message-ID: <20240528153345.GD8631@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1716874214.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1716874214.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 4684E2033B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

On Tue, May 28, 2024 at 03:03:46PM +0930, Qu Wenruo wrote:
> While reading headers, clangd would do a lot of extra checks, from the
> very basic like including the header itself, to missing type definition
> inside the header's include chain.
> 
> There are 2 very basic fixes can be done immediately:
> 
> - Do not do recursive include
> 
> - Do not include rwlock_types.h
>   As it already mentioned to include spinlock_types.h instead.
> 
> Qu Wenruo (2):
>   btrfs: cleanup recursive include of the same header
>   btrfs: do not directly rwlock_types.h

Reviewed-by: David Sterba <dsterba@suse.com>

