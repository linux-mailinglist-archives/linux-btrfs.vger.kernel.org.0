Return-Path: <linux-btrfs+bounces-2582-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5DF85BB50
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 13:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1ECC1C24A99
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 12:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC19167C5B;
	Tue, 20 Feb 2024 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EEdmR64K";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cYlnb2pX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EEdmR64K";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cYlnb2pX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C7067C4F
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Feb 2024 12:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430527; cv=none; b=abEF6A9QDfTwHVavBWVDd6W3mzghv7fhZFv/R47Xk1LGbaoX4nIUaIZ5SGCoQG2YIyk8aJ5A9Sn1rzCk6Jqw4ttMn6+KAUCpYurB/jlrc0IE8mFeZHeAykUS62ENuvCftS7e1eh2g+ZeaqUCafS/RQhhNpSTmV0DKW7MP6N8dz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430527; c=relaxed/simple;
	bh=2ReH+xIi+r6FPNIQX+Yey6NpngIPbPGGsoW9EaJPSu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k047GPRMkaCZKpyWhrBAUSX2wRf/Y5y+Id+jBR/n1IZPGkyVkptkjTtNXxeSuj8NDSvsZd3PiVOjSKnaIXX5kWfFJCiNK/mOY/aKaJd9ctEygrx7PscLhvxrjUTniO7GGSaG/8CLkzXOX8P8Ao/S85mxS+nnyRwUMXhF04tdhTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EEdmR64K; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cYlnb2pX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EEdmR64K; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cYlnb2pX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D86A1FD36;
	Tue, 20 Feb 2024 12:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708430523;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=buth4zRNvG91KkRBAi3QnGFUdrVoy/69BlrHd0kbSuc=;
	b=EEdmR64K+ES9/tI6C+bCJNZIV5zlqhNbDENEgT0MnebywA8BQ39NtokaUqPR/Vb6CcFRjg
	Vc7v3UzXjM5TH9vXobIaIEsEgV/raRqnYCNcr/dL2QSq5lcx9i9rrC9UBcrkda988964xu
	LhlrNhzshEGcVLiXNHRe8mhsXDD+oD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708430523;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=buth4zRNvG91KkRBAi3QnGFUdrVoy/69BlrHd0kbSuc=;
	b=cYlnb2pXnA8st9YPPKQ5gfYNBqR2+0JkgvnOILIt7kSVtkr28EqdvtBIEijdRwtj4Aj9Es
	sPJQ5Fxl5oedcRDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708430523;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=buth4zRNvG91KkRBAi3QnGFUdrVoy/69BlrHd0kbSuc=;
	b=EEdmR64K+ES9/tI6C+bCJNZIV5zlqhNbDENEgT0MnebywA8BQ39NtokaUqPR/Vb6CcFRjg
	Vc7v3UzXjM5TH9vXobIaIEsEgV/raRqnYCNcr/dL2QSq5lcx9i9rrC9UBcrkda988964xu
	LhlrNhzshEGcVLiXNHRe8mhsXDD+oD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708430523;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=buth4zRNvG91KkRBAi3QnGFUdrVoy/69BlrHd0kbSuc=;
	b=cYlnb2pXnA8st9YPPKQ5gfYNBqR2+0JkgvnOILIt7kSVtkr28EqdvtBIEijdRwtj4Aj9Es
	sPJQ5Fxl5oedcRDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C4441358A;
	Tue, 20 Feb 2024 12:02:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id aDeSDruU1GXJDQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 20 Feb 2024 12:02:03 +0000
Date: Tue, 20 Feb 2024 13:01:26 +0100
From: David Sterba <dsterba@suse.cz>
To: Goffredo Baroncelli <kreijack@libero.it>
Cc: linux-btrfs@vger.kernel.org, Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: [PATCH 0/9][V2][btrfs-progs] Remove unused dirstream variable
Message-ID: <20240220120126.GC355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1707423567.git.kreijack@inwind.it>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707423567.git.kreijack@inwind.it>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 FREEMAIL_ENVRCPT(0.00)[inwind.it,libero.it];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[libero.it];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,inwind.it];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Thu, Feb 08, 2024 at 09:19:18PM +0100, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> For historical reason, the helpers [btrfs_]open_[file_or_]dir() work with
> directory returning the 'fd' and a 'dirstream' variable returned by
> opendir(3).
> 
> If the path is a file, the 'fd' is computed from open(2) and dirstream is 
> set to NULL. If the path is a directory, first the directory is opened by 
> opendir(3), then the 'fd' is computed using dirfd(3).
> However the 'dirstream' returned by opendir(3) is left open until 'fd'
> is not needed anymore.
> 
> In near every case the 'dirstream' variable is not used. Only 'fd' is used.
> 
> A call to close_file_or_dir() freed both 'fd' and 'dirstream'.
> 
> Aim of this patch set is to getrid of this complexity; when the path of
> a directory is passed, the fd is get directly using open(path, O_RDONLY):
> so we don't need to use readdir(3) and to maintain the not used variable
> 'dirstream'.
> 
> So each call of a legacy [btrfs_]open_[file_or_]dir() helper is
> replaced by a call to the new btrfs_open_[file_or_]dir_fd() functions.
> These functions return only the file descriptor.
> 
> Also close_file_or_dir() is not needed anymore.
> 
> The first patch, introduces the new helpers; the last patch removed the
> unused older helpers. The intermediate patches updated the code.
> 
> The 3rd patch updated also the add_seen_fsid() function. Before it
> stored the dirstream variable. But now it is not needed anymore.
> So we removed a parameter of the functions and a field in the structure.
> 
> In the 8th patch, the only occurrences where 'dirstream' is used was
> corrected: the dirstream is computed using fdopendir(3), and the cleanup
> is updated according.
> 
> The results is:
> - removed 7 functions
> - add 4 new functions
> - removed ~100 lines
> - removed 44 occurrences of an unused 'dirstream' variable.
> 
> 
> Changelog:
> 
> 09/dec/2023: V1: first issue
> 08/feb/2024: V2
> 	- rebased over 6.7
> 	- swapped the tests order inside the btrfs_open_fd2() function
> 	  to prevent the failure of the test 003-fi-resize-args
> 	- removed two new occurences of open_file_or_dir() inside
> 	  cmd_scrub_limit() (introduced after V1 pateches set)
> 
> 
> BR
> G.Baroncelli
> 
> 
> Goffredo Baroncelli (9):
>   Killing dirstream: add helpers
>   Killing dirstream: replace btrfs_open_dir with btrfs_open_dir_fd
>   Killing dirstream: replace btrfs_open_dir with btrfs_open_dir_fd
>   Killing dirstream: replace open_path_or_dev_mnt with btrfs_open_mnt_fd
>   Killing dirstream: replace open_file_or_dir3 with btrfs_open_fd2
>   Killing dirstream: replace btrfs_open_file_or_dir with
>     btrfs_open_file_or_dir_fd
>   Killing dirstream: replace open_file_or_dir with btrfs_open_fd2
>   Killing dirstream: remove open_file_or_dir3 from du_add_file
>   Killing dirstream: remove unused functions

Added to devel with some updates, thanks.

