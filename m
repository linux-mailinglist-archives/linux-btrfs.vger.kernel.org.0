Return-Path: <linux-btrfs+bounces-2860-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4284386B268
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 15:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F2C91C22D9E
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 14:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD00641C73;
	Wed, 28 Feb 2024 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QUwEYaa3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bM+6BRjj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QUwEYaa3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bM+6BRjj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5969414AD28
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Feb 2024 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132015; cv=none; b=U2D+YDm6VcmZ5RB+tbSqzPVdS3xgzDYzOuuw3oc4CaDxOD2hwmp6DgRhZDsblVhSfB27cvJlgw4kLAEOdTcvNIaBUy8oYv2mmnGtgQeLC4ZNqMkEmGA//CYHTaCiBHc3FPKFsVKjNNI5F1biZlGJMgUSS0Wqx8LdAdEHSJu0Kpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132015; c=relaxed/simple;
	bh=rAYHF4pEd0RMCpK0CSMET5FftETP+oVXDBBBbEQUo6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXcxnLS4IvKP6Yjjw2rLRhzVuyXRpEm/9wsjIG360wzkvn4O+xbWFBfqGyET7ZHrjEkSGCDay8Ku2L6xTm5O8skPWSXhImWCu15nGVwKI2TAeB8LTyes9SdQe3eV8yCQ7zdSY9VsYtMdMgI+/iQuBwa8q7BgSwrM0s07MjxPvgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QUwEYaa3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bM+6BRjj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QUwEYaa3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bM+6BRjj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 865931F45E;
	Wed, 28 Feb 2024 14:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709132011;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GciAcVQDeTwWHg/ciKoOK0KzCgboKUvR4r0j507vjYA=;
	b=QUwEYaa3SydoqxruuBybYiyWt/xN7Fz5pzFOiyOkLcYsBnoHp1UEesCYGfcPeUm2YZ59eo
	HUpdDXZmKJklNbrN/3xYkyzd5tV8Xs0uq6jaHUxVCPpp6ZG2tZSMobxYBbK2X7tC/HDJEz
	XviZDpX2s+XUdb0Rib4QoNqkOdgiVxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709132011;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GciAcVQDeTwWHg/ciKoOK0KzCgboKUvR4r0j507vjYA=;
	b=bM+6BRjjmSRnZhFMRKi19tHzLFb6Ja34ODFEHF18vtNIippTXHuKJRNfzwsijkaBAPeun/
	zRn6n/BulsjwYnBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709132011;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GciAcVQDeTwWHg/ciKoOK0KzCgboKUvR4r0j507vjYA=;
	b=QUwEYaa3SydoqxruuBybYiyWt/xN7Fz5pzFOiyOkLcYsBnoHp1UEesCYGfcPeUm2YZ59eo
	HUpdDXZmKJklNbrN/3xYkyzd5tV8Xs0uq6jaHUxVCPpp6ZG2tZSMobxYBbK2X7tC/HDJEz
	XviZDpX2s+XUdb0Rib4QoNqkOdgiVxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709132011;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GciAcVQDeTwWHg/ciKoOK0KzCgboKUvR4r0j507vjYA=;
	b=bM+6BRjjmSRnZhFMRKi19tHzLFb6Ja34ODFEHF18vtNIippTXHuKJRNfzwsijkaBAPeun/
	zRn6n/BulsjwYnBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F9E0134FB;
	Wed, 28 Feb 2024 14:53:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id TycMG+tI32U3HQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 28 Feb 2024 14:53:31 +0000
Date: Wed, 28 Feb 2024 15:52:50 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: remove btrfs_qgroup_inherit_add_copy()
Message-ID: <20240228145250.GP17966@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <25d16c7c81b93d33d23fcbcaa35c24ce07cc00ef.1709006537.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25d16c7c81b93d33d23fcbcaa35c24ce07cc00ef.1709006537.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.02
X-Spamd-Result: default: False [-3.02 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_TWO(0.00)[2];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-2.02)[95.16%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On Tue, Feb 27, 2024 at 02:32:33PM +1030, Qu Wenruo wrote:
> The function btrfs_qgroup_inherit_add_copy() is designed to add a pair
> of source/destination qgroups into btrfs_qgroup_inherit structure, so
> that rfer/excl numbers would be copied from the source qgroup into the
> destination one.
> 
> This behavior is intentionally hidden since 2016, as such copy will
> cause qgroup inconsistent immediately and a rescan would reset whatever
> numbers copied anyway.
> 
> Now we're going to reject the copy behaviors from kernel, there is no
> need to keep those hidden (and already disabled for "subvolume create")
> behaviors.
> 
> This patch would remove btrfs_qgroup_inherit_add_copy() call, and
> cleanup those undocumented options.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Ok let's remove the support, I don't think we have a clear use case for
that. Added to devel, thanks.

