Return-Path: <linux-btrfs+bounces-11454-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4594CA34F4B
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 21:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D942116DA42
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 20:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DCB266180;
	Thu, 13 Feb 2025 20:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fdy/Ks3F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VT/U9aaW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fdy/Ks3F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VT/U9aaW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC8C2222DE
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2025 20:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739478192; cv=none; b=F7rP/IGrapBz40ENelIBbr2sucsmcLQShHfiGdzrU8QLLNaCt0h6Qe8IUtgHJ0R54Ustf69gqVLV6bHzJRPpc1xI1rNrCbCyEeK/jgJ9VFhRLyWpcqln6L3W2cbXxpSQAM/WRdMWp5tflXKMEQfqMfJp8h6yqr2Q/D9qS15YosM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739478192; c=relaxed/simple;
	bh=iUG7Mwsb+3AKHHOVs6ZQVMT3GAAsYZpomrrHUBWaTQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5LXcwYjCs6Y6i2gFNJ4urzGO0ZnLbo+qSCrE6nPzlg+5S3eo0Do6stZF9t8y4eeg8xxj7JI5Q1F8PIFGcpuoONxrwZ2Fkn+Np4SeFqpyOuNwwn/NiFtv02vDirws0AfNgvQds0yi47nQChpNPzmwXhznzzRreoMu1aaULvX+1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fdy/Ks3F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VT/U9aaW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fdy/Ks3F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VT/U9aaW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B38C621BED;
	Thu, 13 Feb 2025 20:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739478187;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0oR1cdNygTPRqQQllMAKDP+W6a5PcfOwVLZM5bn3u80=;
	b=fdy/Ks3FfaMXQSEod3InJobcmLi3rJmyN418dfbXZFGnWaJ8mXdiqVZiyKImUvyfJ553H8
	Qm12OL0bRSN82h384bL7l7sTw62QDf0zLWF9OG87ZRKhbpOfhXNwyCX9tyY82Pt1dwWbTX
	/Vk7fVmCVO/olvCaGSU0TBsle5lu44g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739478187;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0oR1cdNygTPRqQQllMAKDP+W6a5PcfOwVLZM5bn3u80=;
	b=VT/U9aaW3xBZXzoiNkdFCaDo/P/W3969Mxi91Cd3aAJpLt+AJothmIXZxoReIAbsuSO0Go
	iIrxMr3fp/8GqGAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="fdy/Ks3F";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="VT/U9aaW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739478187;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0oR1cdNygTPRqQQllMAKDP+W6a5PcfOwVLZM5bn3u80=;
	b=fdy/Ks3FfaMXQSEod3InJobcmLi3rJmyN418dfbXZFGnWaJ8mXdiqVZiyKImUvyfJ553H8
	Qm12OL0bRSN82h384bL7l7sTw62QDf0zLWF9OG87ZRKhbpOfhXNwyCX9tyY82Pt1dwWbTX
	/Vk7fVmCVO/olvCaGSU0TBsle5lu44g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739478187;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0oR1cdNygTPRqQQllMAKDP+W6a5PcfOwVLZM5bn3u80=;
	b=VT/U9aaW3xBZXzoiNkdFCaDo/P/W3969Mxi91Cd3aAJpLt+AJothmIXZxoReIAbsuSO0Go
	iIrxMr3fp/8GqGAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8077C137DB;
	Thu, 13 Feb 2025 20:23:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qfTOHqtUrmcKXgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 13 Feb 2025 20:23:07 +0000
Date: Thu, 13 Feb 2025 21:23:02 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH v2] btrfs: always fallback to buffered write if the inode
 requires checksum
Message-ID: <20250213202302.GD5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <e9b8716e2d613cac27e59ceb141f973540f40eef.1738639778.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9b8716e2d613cac27e59ceb141f973540f40eef.1738639778.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: B38C621BED
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Feb 04, 2025 at 02:00:23PM +1030, Qu Wenruo wrote:
> [BUG]
> It is a long known bug that VM image on btrfs can lead to data csum
> mismatch, if the qemu is using direct-io for the image (this is commonly
> known as cache mode none).
> 
> [CAUSE]
> Inside the VM, if the fs is EXT4 or XFS, or even NTFS from Windows, the
> fs is allowed to dirty/modify the folio even the folio is under
> writeback (as long as the address space doesn't have AS_STABLE_WRITES
> flag inherited from the block device).
> 
> This is a valid optimization to improve the concurrency, and since these
> filesystems have no extra checksum on data, the content change is not a
> problem at all.
> 
> But the final write into the image file is handled by btrfs, which need
> the content not to be modified during writeback, or the checksum will
> not match the data (checksum is calculated before submitting the bio).
> 
> So EXT4/XFS/NTRFS believes they can modify the folio under writeback,
> but btrfs requires no modification, this leads to the false csum
> mismatch.
> 
> This is only a controlled example, there are even cases where
> multi-thread programs can submit a direct IO write, then another thread
> modifies the direct IO buffer for whatever reason.
> 
> For such cases, btrfs has no sane way to detect such cases and leads to
> false data csum mismatch.
> 
> [FIX]
> I have considered the following ideas to solve the problem:
> 
> - Make direct IO to always skip data checksum
>   This not only requires a new incompatible flag, as it breaks the
>   current per-inode NODATASUM flag.
>   But also requires extra handling for no csum found cases.
> 
>   And this also reduces our checksum protection.
> 
> - Let hardware to handle all the checksum
>   AKA, just nodatasum mount option.
>   That requires trust for hardware (which is not that trustful in a lot
>   of cases), and it's not generic at all.
> 
> - Always fallback to buffered write if the inode requires checksum
>   This is suggested by Christoph, and is the solution utilized by this
>   patch.
> 
>   The cost is obvious, the extra buffer copying into page cache, thus it
>   reduce the performance.
>   But at least it's still user configurable, if the end user still wants
>   the zero-copy performance, just set NODATASUM flag for the inode
>   (which is a common practice for VM images on btrfs).
> 
>   Since we can not trust user space programs to keep the buffer
>   consistent during direct IO, we have no choice but always falling
>   back to buffered IO.
>   At least by this, we avoid the more deadly false data checksum
>   mismatch error.
> 
> Suggested-by: hch@infradead.org <hch@infradead.org>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

I had this patch in the -rc queue but I think this is a significant
change in the semantics of DIO so the target is 6.14. A backport to
older stable tree is possible but we may need a bit longer period before
this happens. DIO is used for speed in the VMs so falling back to the
buffered write will likely be noticed.

