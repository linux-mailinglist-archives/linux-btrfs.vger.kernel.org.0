Return-Path: <linux-btrfs+bounces-1418-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8C582C329
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 16:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03BFB1C21F60
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 15:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23766EB7F;
	Fri, 12 Jan 2024 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cL6eARNb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TzugksmU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cL6eARNb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TzugksmU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449166EB6E
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Jan 2024 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3A3591FCDC;
	Fri, 12 Jan 2024 15:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705075102;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vrryde+EVtXdkoyZJ7nR/fTVbSbmKtKZoPsttaFOXfY=;
	b=cL6eARNbf5J2+hH4ItW4Ap6x4LcfWrfVEef6aJYow4wPFk9eeOinHNhv/szypmxnb4W55p
	wq7itl7HZGKikJVafsvKrWUnyOVu3MtveD70umsYfIYt5QOO2uScgNb3JsEdkhKXAiov1A
	esUWXtOn+f6ZdKJlh7s1o86cleNjkOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705075102;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vrryde+EVtXdkoyZJ7nR/fTVbSbmKtKZoPsttaFOXfY=;
	b=TzugksmUD/7dmvdO0gpcD4IqT02mo09i0WZ4DG1vRQGm99ikaWiOoSKD4L2NmcDZQybMdD
	/pHd61gldzwg7DAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705075102;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vrryde+EVtXdkoyZJ7nR/fTVbSbmKtKZoPsttaFOXfY=;
	b=cL6eARNbf5J2+hH4ItW4Ap6x4LcfWrfVEef6aJYow4wPFk9eeOinHNhv/szypmxnb4W55p
	wq7itl7HZGKikJVafsvKrWUnyOVu3MtveD70umsYfIYt5QOO2uScgNb3JsEdkhKXAiov1A
	esUWXtOn+f6ZdKJlh7s1o86cleNjkOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705075102;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vrryde+EVtXdkoyZJ7nR/fTVbSbmKtKZoPsttaFOXfY=;
	b=TzugksmUD/7dmvdO0gpcD4IqT02mo09i0WZ4DG1vRQGm99ikaWiOoSKD4L2NmcDZQybMdD
	/pHd61gldzwg7DAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F8DC1340F;
	Fri, 12 Jan 2024 15:58:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id z8BDB55hoWWiIQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 12 Jan 2024 15:58:22 +0000
Date: Fri, 12 Jan 2024 16:58:06 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org,
	Christoph Anton Mitterer <calestyo@scientia.org>
Subject: Re: [PATCH] btrfs: defrag: add under utilized extent to defrag
 target list
Message-ID: <20240112155806.GS31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2c2fac36b67c97c9955eb24a97c6f3c09d21c7ff.1704440000.git.wqu@suse.com>
 <20240110170941.GA31555@twin.jikos.cz>
 <a033550b-9300-42bd-9ec2-74f9ee15cad3@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a033550b-9300-42bd-9ec2-74f9ee15cad3@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cL6eARNb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TzugksmU
X-Spamd-Result: default: False [-3.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3A3591FCDC
X-Spam-Level: 
X-Spam-Score: -3.01
X-Spam-Flag: NO

On Thu, Jan 11, 2024 at 04:54:47PM +1030, Qu Wenruo wrote:
> 
> 
> On 2024/1/11 03:39, David Sterba wrote:
> > On Fri, Jan 05, 2024 at 06:03:40PM +1030, Qu Wenruo wrote:
> >> [BUG]
> >> The following script can lead to a very under utilized extent and we
> >> have no way to use defrag to properly reclaim its wasted space:
> >>
> >>    # mkfs.btrfs -f $dev
> >>    # mount $dev $mnt
> >>    # xfs_io -f -c "pwrite 0 128M" $mnt/foobar
> >>    # sync
> >>    # btrfs filesystem defrag $mnt/foobar
> >>    # sync
> > 
> > I don't see what's wrong with this example, as Filipe noted there's a
> > truncate missing, but still this should be explained better.
> 
> Sorry, the full explanation looks like this:
> 
> After above truncation, we will got the following file extent layout:
> 
> 	item 6 key (257 EXTENT_DATA 0) itemoff 15813 itemsize 53
> 		generation 7 type 1 (regular)
> 		extent data disk byte 298844160 nr 134217728
> 		extent data offset 0 nr 4096 ram 134217728
> 		extent compression 0 (none)
> 
> That would be the last 4K referring that 128M extent, aka, wasted 
> (128M-4K) bytes, or 99.695% of the extent.

Ok, so it's the known issue.

> Normally we expect defrag to properly re-dirty the extent so that we can 
> free that 128M extent.
> But defrag won't touch it at all, mostly due to there is no next extent 
> to merge.
> 
> > Is this the problem when an overwritten and shared extent is partially
> > overwritten but still occupying the whole range, aka. bookend extent?
> > If yes, defrag was never meant to deal with that, though we could use
> > the interface for that.
> 
> If we don't go defrag, there is really no good way to do it safely.
> 
> Sure you can copy the file to another non-btrfs location or dd it.
> But that's not safe if there is still some process accessing it etc.
> 
> > As Andrei pointed out, this is more like a garbage collection, get rid
> > of extent that is partially unreachable. Detecting such extent requires
> > looking for the unreferenced part of the extent while defragmentation
> > deals with live data. This could be a new ioctl entirely too. But first
> > I'd like to know if we're talking about the same thing.
> 
> Yes, we're talking about the bookend problem.
> As I would expect defrag to free most, if not all, such bookend extents.
> (And that's exactly what I recommend to the initial report)

Here the defrag can mean two things, the interface (ioctl and command)
and the implementation. As defrag tries to merge adjacent extents or
coalesce small extents and move it to a new location, this may not be
always necessary just to get rid of the unreachable extent parts.

From the interface side, we can add a mode that does only the garbage
collection, effectively just looking up the unreachable parts, trimming
the extents but leaving the live data intact.

The modes of operation:

- current defrag, move if filters and conditons allow that
- defrag + garbage collect extents
- just garbage collect extents

The third mode is for use case to let it run on the whole filesystem but
not try to rewrite everything.

I'm not sure how would it affect send/receive, read-only subvolumes
should not be touched.

