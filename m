Return-Path: <linux-btrfs+bounces-8965-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2999A0E2F
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 17:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0893E28338B
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 15:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5270820E034;
	Wed, 16 Oct 2024 15:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OKhOrFPR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dvLa54c/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OKhOrFPR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dvLa54c/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C7820E01F
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2024 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729092522; cv=none; b=qAcVeZ3nRVXU7oHD1xYKmqla6uubwwG0Anis0q5IAd0095/sMGVFra9DurDeF3Iq8OQS9XOVpBK5EiPl4K/qJ8B73sykDLVdgE0VfGaPf5IS7i6NpfaKG4gnUP+YKhNGjsGHmrqz6e3equWqiTKeCtJtnLqOtD4zDM6CRLsonc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729092522; c=relaxed/simple;
	bh=vg2pqLLvIYeEPj4eaPD88pq2T0W8jHhCdTBZjbLpBb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NY4YmRvblOPDtW6iP3dPoKjzmWand0jqPZtZHqItX24Xz3lAHOnTBV/0GstHoCE5q9ttbMukto01Aw51ZnvZvN2NH0fF4vp1ebIuW0sk7dqKQ45SdK2hSfT0wYA0ExXuTA207K4OQrlXmYIiBh1CRa2+L8cd3yZrTA7OOxRUm94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OKhOrFPR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dvLa54c/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OKhOrFPR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dvLa54c/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 045A521E65;
	Wed, 16 Oct 2024 15:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729092519;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fGBb4Z2++sNJVT3uSidCPPhEaGMy4Qvv3NRRl6IfchU=;
	b=OKhOrFPRXcw98MEX3odoiRcS6SvuOhGp/psvDEFwzOGJVHwREQJ+z05PcbSHq0Z4mE9Icd
	54u8clzDg9MrO/NWzU4Ma2lbXZxw8qlLDyv6CFTC1fmcJNz+7QozkE2UXHZKyBiz+p9WYc
	b0l9MLpanP+bRWD+JduxHhXhWMomMyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729092519;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fGBb4Z2++sNJVT3uSidCPPhEaGMy4Qvv3NRRl6IfchU=;
	b=dvLa54c/G5cAqcbUYYWyyqNbbGawNDqAcd7KN51ghqDEhyIHmZvt1v1cEvYnMsGYiZLZC1
	aJsHSsVkLfoUGXDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729092519;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fGBb4Z2++sNJVT3uSidCPPhEaGMy4Qvv3NRRl6IfchU=;
	b=OKhOrFPRXcw98MEX3odoiRcS6SvuOhGp/psvDEFwzOGJVHwREQJ+z05PcbSHq0Z4mE9Icd
	54u8clzDg9MrO/NWzU4Ma2lbXZxw8qlLDyv6CFTC1fmcJNz+7QozkE2UXHZKyBiz+p9WYc
	b0l9MLpanP+bRWD+JduxHhXhWMomMyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729092519;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fGBb4Z2++sNJVT3uSidCPPhEaGMy4Qvv3NRRl6IfchU=;
	b=dvLa54c/G5cAqcbUYYWyyqNbbGawNDqAcd7KN51ghqDEhyIHmZvt1v1cEvYnMsGYiZLZC1
	aJsHSsVkLfoUGXDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5C9C1376C;
	Wed, 16 Oct 2024 15:28:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OivfN6bbD2cmMQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 16 Oct 2024 15:28:38 +0000
Date: Wed, 16 Oct 2024 17:28:37 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] btrfs: unify the read and writer locks for
 btrfs_subpage
Message-ID: <20241016152837.GQ1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1728452897.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728452897.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Oct 09, 2024 at 04:21:05PM +1030, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Rename btrfs_subpage::locked to btrfs_subpage::nr_locked
> 
> When the handling of sector size < page size is introduced, there are
> two types of locking, reader and writer lock.
> 
> The main reason for the reader lock is to handle metadata to make sure
> the page::private is not released when there is still a metadata being
> read.
> 
> However since commit d7172f52e993 ("btrfs: use per-buffer locking for
> extent_buffer reading"), metadata read no longer relies on
> btrfs_subpage::readers.
> 
> Making the writer lock as the only utilized subpage locking.
> 
> This patchset converts all the existing reader lock usage and rename the
> writer lock into a generic lock.
> 
> This patchset relies on this patch "btrfs: fix the delalloc range
> locking if sector size < page size", as it removes the last user of
> btrfs_folio_start_writer_lock().
> 
> Qu Wenruo (2):
>   btrfs: unify to use writer locks for subpage locking
>   btrfs: rename btrfs_folio_(set|start|end)_writer_lock()

Reviewed-by: David Sterba <dsterba@suse.com>

