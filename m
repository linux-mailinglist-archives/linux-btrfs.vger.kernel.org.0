Return-Path: <linux-btrfs+bounces-1498-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA9682FE1E
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 01:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10DD91F2598A
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 00:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7423417D9;
	Wed, 17 Jan 2024 00:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jf4wQ5bB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eLRHuqxB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jf4wQ5bB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eLRHuqxB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E680F1364
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 00:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705453002; cv=none; b=Yz2YjSEr8pWNRMjUN0yofMQJnXnEt5yPw+9oUBfLExJeNxgtsgZZ9hg0O/iaj7RAtdwP1gE/MLbumklIKkf0BxXp4fYFW410/IffrgHYjxG/3Ra7vNx4HZWbsObYk89vykHQjhHLfabLI+ocda9u1ASoF3KkZw8EAqDGTIaD+/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705453002; c=relaxed/simple;
	bh=pPH5zQJ7fRhzVt9VSTiVDERiCylws+a+H+puceGUToU=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent:X-Spamd-Result:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Spam-Level:X-Spam-Score:
	 X-Spam-Flag; b=k56j+kngTu7KRydvMOksPhtaEni2pWNgDcmAQumydaSz7KH5FlWb/p5Z1VBQR9Cgd9gotW7aKr7uzPSL2niieM663W5S/bbkzD7RzqpLr2XsJaCCcNCmaDeSrG4D8VOvcr5yyP/gQ3RxwLvzsXfRDm/DPGIX2yVyO+RpHqh5zCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jf4wQ5bB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eLRHuqxB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jf4wQ5bB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eLRHuqxB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 059961FB45;
	Wed, 17 Jan 2024 00:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705452999;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a9ONCQYi++9Qoxjgg3vq8rozpZGhquDBQI4QLhtSZGo=;
	b=Jf4wQ5bBt1z1WNaEqteI+v863NIQBDeRhNlVqeknnSqiPthaYZBXbaciIEJd4nayIaHJiB
	6IAPLTuhtcERZv+V+k5yUz0NZkGH4BlzcowWuswzFbwZWNHN7PFlzaYHglKl9iEi4l4UBE
	kjfaDQsb1oBXpAUrqJol2dHaeAjIupg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705452999;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a9ONCQYi++9Qoxjgg3vq8rozpZGhquDBQI4QLhtSZGo=;
	b=eLRHuqxB7yZaEMcUJMYH+7TZBZzZTrWRFCU0qMxEwwTUyl0jTlwM9c6/tT425m/NkCxJwS
	ltL6d/D+KvAR9sBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705452999;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a9ONCQYi++9Qoxjgg3vq8rozpZGhquDBQI4QLhtSZGo=;
	b=Jf4wQ5bBt1z1WNaEqteI+v863NIQBDeRhNlVqeknnSqiPthaYZBXbaciIEJd4nayIaHJiB
	6IAPLTuhtcERZv+V+k5yUz0NZkGH4BlzcowWuswzFbwZWNHN7PFlzaYHglKl9iEi4l4UBE
	kjfaDQsb1oBXpAUrqJol2dHaeAjIupg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705452999;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a9ONCQYi++9Qoxjgg3vq8rozpZGhquDBQI4QLhtSZGo=;
	b=eLRHuqxB7yZaEMcUJMYH+7TZBZzZTrWRFCU0qMxEwwTUyl0jTlwM9c6/tT425m/NkCxJwS
	ltL6d/D+KvAR9sBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D5D1713482;
	Wed, 17 Jan 2024 00:56:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 6v/6M8Ylp2VUZQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 17 Jan 2024 00:56:38 +0000
Date: Wed, 17 Jan 2024 01:56:20 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: convert-ext2: insert a dummy inode item
 before inode ref
Message-ID: <20240117005620.GH31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6e1e07ad53a9e716be28e4d505042a50c1676254.1705134953.git.wqu@suse.com>
 <20240116184738.GE31555@twin.jikos.cz>
 <fec2ca19-2b17-476f-9ba1-55f85e622ea3@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fec2ca19-2b17-476f-9ba1-55f85e622ea3@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Jf4wQ5bB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eLRHuqxB
X-Spamd-Result: default: False [-3.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 059961FB45
X-Spam-Level: 
X-Spam-Score: -3.01
X-Spam-Flag: NO

On Wed, Jan 17, 2024 at 06:43:50AM +1030, Qu Wenruo wrote:
> 
> 
> On 2024/1/17 05:17, David Sterba wrote:
> > On Sat, Jan 13, 2024 at 07:07:06PM +1030, Qu Wenruo wrote:
> >> [BUG]
> >> There is a report about failed btrfs-convert, which shows the following
> >> error:
> >>
> >>    Create btrfs metadata
> >>    corrupt leaf: root=5 block=5001931145216 slot=1 ino=89911763, invalid previous key objectid, have 89911762 expect 89911763
> >>    leaf 5001931145216 items 336 free space 7 generation 90 owner FS_TREE
> >>    leaf 5001931145216 flags 0x1(WRITTEN) backref revision 1
> >>    fs uuid 8b69f018-37c3-4b30-b859-42ccfcbe2449
> >>    chunk uuid 448ce78c-ea41-49f6-99dc-46ad80b93da9
> >>            item 0 key (89911762 INODE_REF 3858733) itemoff 16222 itemsize 61
> >>                    index 171 namelen 51 name: [FILENAME1]
> >>            item 1 key (89911763 INODE_REF 3858733) itemoff 16161 itemsize 61
> >>                    index 103 namelen 51 name: [FILENAME2]
> >>
> >> [CAUSE]
> >> When iterating a directory, btrfs-convert would insert the DIR_ITEMs,
> >> along with the INODE_REF of that inode.
> >>
> >> This leads to above stray INODE_REFs, and trigger the tree-checker.
> >>
> >> This can only happen for large fs, as for most cases we have all these
> >> modified tree blocks cached, thus tree-checker won't be triggered.
> >> But when the tree block cache is not hit, and we have to read from disk,
> >> then such behavior can lead to above tree-checker error.
> >>
> >> [FIX]
> >> Insert a dummy INODE_ITEM for the INODE_REF first, the inode items would
> >> be updated when iterating the child inode of the directory.
> >>
> >> Issue: #731
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >
> > Thanks, the cached data are uncovering some bugs, I wonder if
> > https://github.com/kdave/btrfs-progs/issues/349 could be also caused by
> > that.
> 
> Unfortunately the csum is not the same problem at all.
> 
> I don't have any clue yet, but can take sometime to look into it since
> there is a reproducer.
> 
> >
> >> ---
> >>   check/mode-common.h   | 15 ---------------
> >>   common/utils.h        | 16 ++++++++++++++++
> >>   convert/source-ext2.c | 30 ++++++++++++++++++++----------
> >>   convert/source-fs.c   | 20 ++++++++++++++++++++
> >>   4 files changed, 56 insertions(+), 25 deletions(-)
> >>
> >> ---
> >> Changelog:
> >> v2:
> >> - Initialized dummy inodes' mode/generation/transid
> >>    As the mode can still trigger tree-checker warnings.
> >>
> >> diff --git a/check/mode-common.h b/check/mode-common.h
> >> index 894bbbb8141b..80672e51e870 100644
> >> --- a/check/mode-common.h
> >> +++ b/check/mode-common.h
> >> @@ -167,21 +167,6 @@ static inline bool is_valid_imode(u32 imode)
> >>
> >>   int recow_extent_buffer(struct btrfs_root *root, struct extent_buffer *eb);
> >>
> >> -static inline u32 btrfs_type_to_imode(u8 type)
> >> -{
> >> -	static u32 imode_by_btrfs_type[] = {
> >> -		[BTRFS_FT_REG_FILE]	= S_IFREG,
> >> -		[BTRFS_FT_DIR]		= S_IFDIR,
> >> -		[BTRFS_FT_CHRDEV]	= S_IFCHR,
> >> -		[BTRFS_FT_BLKDEV]	= S_IFBLK,
> >> -		[BTRFS_FT_FIFO]		= S_IFIFO,
> >> -		[BTRFS_FT_SOCK]		= S_IFSOCK,
> >> -		[BTRFS_FT_SYMLINK]	= S_IFLNK,
> >> -	};
> >> -
> >> -	return imode_by_btrfs_type[(type)];
> >> -}
> >
> > Why did you move this helper to utils.h? Here it's available for
> > anything that needs it. Mkfs and convert share some code, no style
> > problem to cross include from each other. Also moving it to utils.h is
> > going the opposite way, it's a header that's a default if there's no
> > better place. Lot of code has been factored out of it.
> 
> OK, my initial problem is about including headers from check/, but since
> it's not a problem then I'm totally fine.
> 
> Would update the patch and reflect that.

No need to, I've added it to devel already, thanks.

