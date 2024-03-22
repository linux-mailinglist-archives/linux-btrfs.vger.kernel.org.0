Return-Path: <linux-btrfs+bounces-3507-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C7388653A
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Mar 2024 03:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800911C23558
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Mar 2024 02:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D03D6FCC;
	Fri, 22 Mar 2024 02:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3Gl4E4lj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="diGCZGMH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3Gl4E4lj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="diGCZGMH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDC063D5
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Mar 2024 02:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711075159; cv=none; b=omKFfu2buUf199ne60JW54d/wLkznjFcdxMTGNDUVNHQTxeU7SBYxiwx5osdfq6Hk95BBmczGXnPD4kOdQdeKqCWXLCQr7GHChMZmPx7ntQ03WDVkKEhRNTa+CarXpyczh0dvT52dQ4hr9S8DkxTB6NahKDAEQxZm52r9+otO30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711075159; c=relaxed/simple;
	bh=XFlJcx6nyUMznIXXVNIUUhYwER1Pzl3KM5at485qHA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLyuEfMHQW56+m/5JYMF5JAyiTMMnmAyCt8BUKlJ4pdG0aB4wfcanQoXV51ZRhWqxACUvji1Sb2luWIT/Uz5quWvOPyxNGb7m/5Tjo560SSWPQ73TCmOjZTxlXNs/SPKmh/KtKBNQVi/LgZf2I5xNfvioQrlhz6CfeO8TRadU88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3Gl4E4lj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=diGCZGMH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3Gl4E4lj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=diGCZGMH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 09C5637E5C;
	Fri, 22 Mar 2024 02:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711075156;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D8yOmQiypiSA6/S/bfOqi5ojKl6M7L+qBcd8FwWx/rE=;
	b=3Gl4E4lj9lsn9LXKeWFN8wUuyV7SIZB4qr1al3I38UoGXERldv3SDRfmAM6ym7jexw8jGE
	8KYUbMRPB6JLUD7l0351Kqy6z3oSdH75vfbe/XF+ObI62s2S8qz6bW75xhn7zV4UxuO8r4
	b8JnJFtWMvkBbDNwqnf4x6TVqrCgxJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711075156;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D8yOmQiypiSA6/S/bfOqi5ojKl6M7L+qBcd8FwWx/rE=;
	b=diGCZGMHx1F67ZEhxsSYxy1vmg7oj1vnJHmjsYsss2lOjTZxsag5bGtkeDMNh3AxlJGekL
	MIoKP+6GjrGni3BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711075156;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D8yOmQiypiSA6/S/bfOqi5ojKl6M7L+qBcd8FwWx/rE=;
	b=3Gl4E4lj9lsn9LXKeWFN8wUuyV7SIZB4qr1al3I38UoGXERldv3SDRfmAM6ym7jexw8jGE
	8KYUbMRPB6JLUD7l0351Kqy6z3oSdH75vfbe/XF+ObI62s2S8qz6bW75xhn7zV4UxuO8r4
	b8JnJFtWMvkBbDNwqnf4x6TVqrCgxJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711075156;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D8yOmQiypiSA6/S/bfOqi5ojKl6M7L+qBcd8FwWx/rE=;
	b=diGCZGMHx1F67ZEhxsSYxy1vmg7oj1vnJHmjsYsss2lOjTZxsag5bGtkeDMNh3AxlJGekL
	MIoKP+6GjrGni3BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDF15137D4;
	Fri, 22 Mar 2024 02:39:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ak/xOVPv/GXrSgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 22 Mar 2024 02:39:15 +0000
Date: Fri, 22 Mar 2024 03:32:01 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/29] trivial adjustments for return variable coding
 style
Message-ID: <20240322023201.GJ14596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1710857863.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710857863.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.99
X-Spamd-Result: default: False [-3.99 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.959];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Tue, Mar 19, 2024 at 08:25:08PM +0530, Anand Jain wrote:
> Rename variable 'err'; instead, use 'ret', and the 'ret' helper variable
> is renamed to 'ret2'.
> 
> https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html#code
> 
> In functions where 'ret' is already used as a return helper (but not the
> actual return), to avoid oversight, first rename the original 'ret'
> variable to 'ret2', compile it, and then rename 'err' to 'ret'.
> 
> Anand Jain (29):
>   btrfs: btrfs_cleanup_fs_roots rename ret to ret2 and err to ret
>   btrfs: btrfs_initxattrs rename err to ret
>   btrfs: send_extent_data rename err to ret
>   btrfs: btrfs_rmdir rename err to ret
>   btrfs: btrfs_cont_expand rename err to ret
>   btrfs: btrfs_setsize rename err to ret2
>   btrfs: btrfs_find_orphan_roots rename ret to ret2 and err to ret
>   btrfs: btrfs_ioctl_snap_destroy rename err to ret
>   btrfs: __set_extent_bit rename err to ret
>   btrfs: convert_extent_bit rename err to ret
>   btrfs: __btrfs_end_transaction rename err to ret
>   btrfs: btrfs_write_marked_extents rename werr to ret err to ret2
>   btrfs: __btrfs_wait_marked_extents rename werr to ret err to ret2
>   btrfs: build_backref_tree rename err to ret and ret to ret2
>   btrfs: relocate_tree_blocks rename ret to ret2 and err to ret
>   btrfs: relocate_block_group rename ret to ret2 and err to ret
>   btrfs: create_reloc_inode rename err to ret
>   btrfs: btrfs_relocate_block_group rename ret to ret2 and err ro ret
>   btrfs: mark_garbage_root rename err to ret2
>   btrfs: btrfs_recover_relocation rename ret to ret2 and err to ret
>   btrfs: quick_update_accounting rename err to ret2
>   btrfs: btrfs_qgroup_rescan_worker rename ret to ret2 and err to ret
>   btrfs: lookup_extent_data_ref rename ret to ret2 and err to ret
>   btrfs: btrfs_drop_snapshot rename ret to ret2 and err to ret
>   btrfs: btrfs_drop_subtree rename retw to ret2
>   btrfs: btrfs_dirty_pages rename variable err to ret
>   btrfs: prepare_pages rename err to ret
>   btrfs: btrfs_direct_write rename err to ret
>   btrfs: fixup_tree_root_location rename ret to ret2 and err to ret

Several patches got coments that would need an update but I think for
the simple err -> ret renames that did not involve anything else you can
add it to for-next. If you're not sure about some case then send it in
v2.

