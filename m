Return-Path: <linux-btrfs+bounces-6912-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A675494327E
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 16:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9E31F217E4
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 14:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1811BBBD2;
	Wed, 31 Jul 2024 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N8U6XAuQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MNCbRMPr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N8U6XAuQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MNCbRMPr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46627186E4F;
	Wed, 31 Jul 2024 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722437687; cv=none; b=bmhYIKcr2JWvxrc/e6yDqBe77zF9az1v8XrSRmuq7R3bNflI9HdfZPN2t+YPBfI9dWi2MdZ7WGvvpGTVl9xQeAN8gbLezR+t4K1r2k407SwW6l0No7141rDlKe8DCmM4MzqFDQpOjkcxg10vipZriwUS8B2anEBi5jnVoVpbMWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722437687; c=relaxed/simple;
	bh=KJ1WkBjcihAVb1qiM/OJXktB3N9nEptIMEG1UtIUGIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUzqEGseCGgEKW6tbnuudNdDbgzFuIp5bGP1zLGLw/OhPSY5xzDyU2vd58RRImkubSSZ7O5hxZEaruJgLeQRA94Lup0dJrNthUVvDsNWRmjjhWMWwN8FeWDp9kiWSY6/tjatIo+MutB7EIWL8u99f9S2znlgGcKQZf3cp65X5jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N8U6XAuQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MNCbRMPr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N8U6XAuQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MNCbRMPr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 668761F6E6;
	Wed, 31 Jul 2024 14:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722437681;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MQ9a5mc46pg6WryvH5YTygbhkb+V89+L6ZQhUIWoEYM=;
	b=N8U6XAuQdFD1ivrH5BBW+9A3Gl+xQVcTnJ6TQ8L0CCV/86fPaFPpVLQ/kCkEmIcbGiqkdn
	Mdi1Jwr9wOtHjT2FsGEGIqDOuWWEpMeWmOgy7aC1+3Sp3CSCcRNDzwGlupIcqZv0PykWhK
	GcUWs5309Yfm+Q8sed82d2Z+bsfp0To=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722437681;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MQ9a5mc46pg6WryvH5YTygbhkb+V89+L6ZQhUIWoEYM=;
	b=MNCbRMPr0CdtObY2RuJ7xn0HxyYMfCo96vhtg6KaLe8epAMioN8TFVsSPGxYoOYMdcJoeY
	8YPsO0fSLl5NTqBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=N8U6XAuQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MNCbRMPr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722437681;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MQ9a5mc46pg6WryvH5YTygbhkb+V89+L6ZQhUIWoEYM=;
	b=N8U6XAuQdFD1ivrH5BBW+9A3Gl+xQVcTnJ6TQ8L0CCV/86fPaFPpVLQ/kCkEmIcbGiqkdn
	Mdi1Jwr9wOtHjT2FsGEGIqDOuWWEpMeWmOgy7aC1+3Sp3CSCcRNDzwGlupIcqZv0PykWhK
	GcUWs5309Yfm+Q8sed82d2Z+bsfp0To=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722437681;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MQ9a5mc46pg6WryvH5YTygbhkb+V89+L6ZQhUIWoEYM=;
	b=MNCbRMPr0CdtObY2RuJ7xn0HxyYMfCo96vhtg6KaLe8epAMioN8TFVsSPGxYoOYMdcJoeY
	8YPsO0fSLl5NTqBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48A1D13297;
	Wed, 31 Jul 2024 14:54:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DDt2ETFQqmZlfAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 31 Jul 2024 14:54:41 +0000
Date: Wed, 31 Jul 2024 16:54:39 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs/287: wait for subvolume deletion to complete
Message-ID: <20240731145439.GP17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <40c169580bd42e96faf11c7ce8805399dd0a180c.1722429630.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40c169580bd42e96faf11c7ce8805399dd0a180c.1722429630.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 668761F6E6
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]

On Wed, Jul 31, 2024 at 01:41:24PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The test deletes the subvolume and then immediately calls the logical
> resolve ioctl to confirm the extent is not referenced by the subvolume
> anymore. This however may often fail because the subvolume delete only
> makes the subvolume not accessible to user space anymore, but the actual
> deletion of the subvolume tree, and all its data references, happens in
> the background in the cleaner kthread running in kernel space.
> 
> So if by the time we do the query the cleaner kthread has not yet deleted
> the subvolume tree, the test fails like this:
> 
>   $ ./check btrfs/287
>   FSTYP         -- btrfs
>   PLATFORM      -- Linux/x86_64 debian0 5.14.0-btrfs-next-22 #1 SMP Tue Jul 30 16:31:55 WEST 2024
>   MKFS_OPTIONS  -- /dev/sdc
>   MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
>   btrfs/287 0s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad)
>       --- tests/btrfs/287.out	2024-07-30 17:40:49.037599612 +0100
>       +++ /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad	2024-07-31 13:06:28.275728352 +0100
>       @@ -82,12 +82,18 @@
>        inode 257 offset 20971520 snap2
>        inode 257 offset 12582912 snap2
>        inode 257 offset 4194304 snap2
>       +inode 257 offset 20971520 snap1
>       +inode 257 offset 12582912 snap1
>       +inode 257 offset 4194304 snap1
>        inode 257 offset 20971520 root 5
>       ...
>       (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/287.out /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad'  to see the entire diff)
> 
>   HINT: You _MAY_ be missing kernel fix:
>         0cad8f14d70c btrfs: fix backref walking not returning all inode refs
> 
> Fix this by using the "subvolume sync" command to wait for the subvolume
> to be deleted by the cleaner kthread before doing logical resolve queries.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

