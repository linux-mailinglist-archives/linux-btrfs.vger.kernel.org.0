Return-Path: <linux-btrfs+bounces-1529-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C40830D7F
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 20:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D043128836C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 19:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B472E2562C;
	Wed, 17 Jan 2024 19:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hO7KLt/T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7mIY5uMv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tOYqmoqF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uZndRm3t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1667825622
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 19:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521176; cv=none; b=oZR7Zh0qlxNGMTCAP8lKtZfrRfZuMpvDShoF0qUGGckhMkg1Gb+Nc8Z1ZE6Qa3C4ByHuGjfez6p878irzhaVjVdDrYBu64KyhrzwF4g9Z8v9bwPkm4u0Ln4wQXsHuex27S/lMQcMKkoTQNaalBvDgBC2YqLDmwbVs1xhGjT8cRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521176; c=relaxed/simple;
	bh=sSeKUDnDD2SaRLbLsPH+urLP0ku8cazQjElr76C8Nig=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent:X-Spam-Level:
	 X-Spam-Score:X-Spamd-Result:X-Spam-Flag; b=c2keiBRHrLs4t8cSHBP8JES7OSjczBd5Kcdhk3FzseLvVoXaDGWafJTeDjf0PlzqIen6HQ9z95S9ewYtJElT5tFpjI0cu4S7ZtDZcUQ26U8Fs7H6FPJEqeU6ukqbI6ocF6+j8OmBcr788ATrKt6FCMXv92vuTIjim35VhULURTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hO7KLt/T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7mIY5uMv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tOYqmoqF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uZndRm3t; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 135E121F4A;
	Wed, 17 Jan 2024 19:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705521173;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4M16YY+P5nNkSaLxe6hSIuFN72SlLds8XZXvTyQktRE=;
	b=hO7KLt/TIs4X7PIBYpM9KzvM77BQ8x7tdkRHgf0v88SNm1fLlnmUG5XLgKVf3DmcmTJs1/
	ChzGx5nBXmvKQ0D8T4uyDLtH/2UCFMs4jrQltfjljgvWC35/+ax6ILlfY9J1OegTu3K9Nj
	T9nnDZpFt4YGipEtjhQRnHig9by7vOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705521173;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4M16YY+P5nNkSaLxe6hSIuFN72SlLds8XZXvTyQktRE=;
	b=7mIY5uMvjiQcFvrE/GNHGiL0BJA51y59a3ViirF7eeHRG+yRtRhtCElAxL3tIKmmbtP+zu
	XC9aPn+pxSiM5ZCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705521172;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4M16YY+P5nNkSaLxe6hSIuFN72SlLds8XZXvTyQktRE=;
	b=tOYqmoqF38kHI78fGLdtXsh7cUNFwHCnw8CogTX/lJzmXQQRiDEoODwefxUd43yM12Jbmn
	8pUPZxe9ba7qeYDf5Z7GkTMGbc63/hyFO8X3TNIPIdgIOtCKDAYiIr/umJs/VtJs6wlrs1
	SF6zK70hq9YNqfyzmNp7TW9056HHruQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705521172;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4M16YY+P5nNkSaLxe6hSIuFN72SlLds8XZXvTyQktRE=;
	b=uZndRm3tRzDunhUBcSybVmcpFiqLcTh1LkRMwihF9nFRAli3LUZF1J1Db3vZAy0qJA0K7J
	0hLj7oGX7QdQYHDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id F349013482;
	Wed, 17 Jan 2024 19:52:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ztTvOhMwqGUfZQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 17 Jan 2024 19:52:51 +0000
Date: Wed, 17 Jan 2024 20:52:33 +0100
From: David Sterba <dsterba@suse.cz>
To: Goffredo Baroncelli <kreijack@libero.it>
Cc: linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
	Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: [PATCH] btrfs-progs: btrfs dev us: don't print uncorrect
 unallocated data
Message-ID: <20240117195233.GM31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <f862a81c8ac4b63b2cca2096ffb75907ae899c95.1704398024.git.kreijack@inwind.it>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f862a81c8ac4b63b2cca2096ffb75907ae899c95.1704398024.git.kreijack@inwind.it>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.00
X-Spamd-Result: default: False [-1.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[inwind.it,libero.it];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,libero.it:email,inwind.it:email];
	 FREEMAIL_TO(0.00)[libero.it];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,oracle.com,inwind.it];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[38.04%]
X-Spam-Flag: NO

On Thu, Jan 04, 2024 at 08:53:44PM +0100, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> If "btrfs dev us" is invoked by a not root user, it is imposible to
> collect the chunk info data (not enough privileges). This causes
> "btrfs dev us" to print as "Unallocated" value the size of the disk.
> 
> This patch handle the case where print_device_chunks() is invoked
> without the chunk info data, printing "Unallocated N/A":
> 
> Before the patch:
> 
> $ btrfs dev us t/
> WARNING: cannot read detailed chunk info, per-device usage will not be shown, run as root
> /dev/loop0, ID: 1
>    Device size:             5.00GiB
>    Device slack:              0.00B
>    Unallocated:             5.00GiB  <-- Wrong
> 
> $ sudo btrfs dev us t/
> [sudo] password for ghigo:
> /dev/loop0, ID: 1
>    Device size:             5.00GiB
>    Device slack:              0.00B
>    Data,single:             8.00MiB
>    Metadata,DUP:          512.00MiB
>    System,DUP:             16.00MiB
>    Unallocated:             4.48GiB  <-- Correct
> 
> After the patch:
> $ ./btrfs dev us /tmp/t/
> WARNING: cannot read detailed chunk info, per-device usage will not be shown, run as root
> /dev/loop0, ID: 1
>    Device size:             5.00GiB
>    Device slack:              0.00B
>    Unallocated:                 N/A
> 
> $ sudo ./btrfs dev us /tmp/t/
> [sudo] password for ghigo:
> /dev/loop0, ID: 1
>    Device size:             5.00GiB
>    Device slack:              0.00B
>    Data,single:             8.00MiB
>    Metadata,DUP:          512.00MiB
>    System,DUP:             16.00MiB
>    Unallocated:             4.48GiB
> 
> Signed-off-by: Goffredo Baroncelli <kreijack@libero.it>
> Reviewed-by: Anand Jain <anand.jain@oracle.com>

Added to devel, thanks.

