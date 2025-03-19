Return-Path: <linux-btrfs+bounces-12437-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC71A69BBE
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 23:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C42E17A02D
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 22:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BFE21A452;
	Wed, 19 Mar 2025 22:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JR4zIymN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CVKWnPep";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JR4zIymN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CVKWnPep"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967EB21A453
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 22:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421841; cv=none; b=p78xFkfxuj750jxjS0lyLzcSX0qqucdAJr6DjKjQunp1xAc9P21gHu8FTHu+4NtX2LaR58/GhkXXTjW4q9jxjiuL3nPOxMnbcURFtfdUhDaTANGvE37BVVCLn4pymgbQw7zjGKZPB+9adPFlqdbitQQjWIRL+Gajoq1UgS7pOMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421841; c=relaxed/simple;
	bh=MygNA23VpjmxHbF3U8Ah6zH7cJyGR6BBED0tCCyqrn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfQFXoRyCSvIIyH8QTZlRfw0sDyNnz3ERUH5RjM7WfPdbQrYpGQ3uSnBXzxKLfkssf+bM3c8g7XFFLnxYYPxJhwy4z/zbb1uIAoOfnQwMkdsJCikd0PZA5hRKkLaY4HydFDnMAhEUqfy1T8fBQuCN5HGdJEX0AVqD30rKDVAYFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JR4zIymN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CVKWnPep; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JR4zIymN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CVKWnPep; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 895E621CEB;
	Wed, 19 Mar 2025 22:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742421837;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DPlozwB6uN50P5+UZxvXw7tNBqrgNvhbjqQ73E4jVUQ=;
	b=JR4zIymN0cWI7AdH3fBrRyeCNLRpW+K+vo5niBovwfD36XRgusspXLEHG2DipWawpMP8mp
	W6HVXTKMlh1YW9H83SUHUEcrJxJjUFgLzwjeuT+UxaNvGx+rbkGHZ5HimK/Ih5DSN5GW4Y
	GaRANr63kcWbTegW6tTg9YTa8gm7Nf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742421837;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DPlozwB6uN50P5+UZxvXw7tNBqrgNvhbjqQ73E4jVUQ=;
	b=CVKWnPepC/CQICmgtW0zPomR3884WHGtiSje7mAcdQZ7WMZMYvOC6NSPej0WvY9izwyMGZ
	/WftVZ1AEgAuU6Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JR4zIymN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CVKWnPep
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742421837;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DPlozwB6uN50P5+UZxvXw7tNBqrgNvhbjqQ73E4jVUQ=;
	b=JR4zIymN0cWI7AdH3fBrRyeCNLRpW+K+vo5niBovwfD36XRgusspXLEHG2DipWawpMP8mp
	W6HVXTKMlh1YW9H83SUHUEcrJxJjUFgLzwjeuT+UxaNvGx+rbkGHZ5HimK/Ih5DSN5GW4Y
	GaRANr63kcWbTegW6tTg9YTa8gm7Nf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742421837;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DPlozwB6uN50P5+UZxvXw7tNBqrgNvhbjqQ73E4jVUQ=;
	b=CVKWnPepC/CQICmgtW0zPomR3884WHGtiSje7mAcdQZ7WMZMYvOC6NSPej0WvY9izwyMGZ
	/WftVZ1AEgAuU6Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 776F813726;
	Wed, 19 Mar 2025 22:03:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1N2fHE0/22cXPwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 19 Mar 2025 22:03:57 +0000
Date: Wed, 19 Mar 2025 23:03:52 +0100
From: David Sterba <dsterba@suse.cz>
To: Sidong Yang <realwakka@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: cmds: show child subvolumes during
 recursive delete
Message-ID: <20250319220352.GP32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250119105048.5452-1-realwakka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250119105048.5452-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 895E621CEB
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Sun, Jan 19, 2025 at 10:50:46AM +0000, Sidong Yang wrote:
> When a subvolume is deleted with the recursive option, any nested (child)
> subvolumes also get removed without report it. This patch modifies the
> delete subvol command to print a listt of child subvolumes during
> recursive deletion.
> 
> Issue: #923
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

Thanks, for the record this has been in devel for some time.

