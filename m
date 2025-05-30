Return-Path: <linux-btrfs+bounces-14315-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A07AC90F5
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 16:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4DE188E2B2
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 14:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AC922A4EF;
	Fri, 30 May 2025 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iI6eOo9T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NrjLfAA5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iI6eOo9T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NrjLfAA5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100CB1C683
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 14:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748613868; cv=none; b=TxOSRD3moh7UxjPDIItzxtrZy8063hIud/5LqfQPLPavnmdbGs5Ab38qNyLYqEmkL0kBXSqJ/epsTuXIyS/sslwSsXGQaa6stfO1VpJEJtNHm77PFOfdMhcMwWGsjeaYQqNOm6Lj08H8IZ6jlUHqA4aAgNped4R31dOBnESHk7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748613868; c=relaxed/simple;
	bh=4mciU/2GBXFLDS2HFnsI8+BvZJMDmNLzeAtP/XEcIPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFNCmLvTnYcgzP398ItGhNbFNnTEus7cEDcYIlY+BgmyZsS4lW4A0iJLYk31ziPXVUEVhm07UTpxR660bGK/QXeViKxf9nWBL98Dsr38Rd964iQ7tx+toNhbIKWp7yT2svkjPrOcUWdyGIeaXlhFHjRojTi/Rn04LNr3OsUX25c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iI6eOo9T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NrjLfAA5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iI6eOo9T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NrjLfAA5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0E2E71F911;
	Fri, 30 May 2025 14:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748613865;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iqzBQO/+9zRnkF+P+xRhyFVInujmVHGquqq/omqq5DM=;
	b=iI6eOo9THlLrm4dzvF2Ns9P4fB3t0ITO5fyoT5FeD5omarVc3fa5iBALbkX3op5tvGilmx
	th1VHLvQZKkECVUl+SexihG2cOfg4Fh3qWJ24ESzuCvgwNpqY4nqN5JE9e99IMx5+u4M48
	OfQpet4Ujjw7Uw2dKqr5EMDpmZFc/NY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748613865;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iqzBQO/+9zRnkF+P+xRhyFVInujmVHGquqq/omqq5DM=;
	b=NrjLfAA5s7UElSgtxuxWx9+f8Afif+b2wFGR7tMRiLmxfJYJ//w5aaownnHxplHkqfWcGR
	vG1IQiIB4MgpCmCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748613865;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iqzBQO/+9zRnkF+P+xRhyFVInujmVHGquqq/omqq5DM=;
	b=iI6eOo9THlLrm4dzvF2Ns9P4fB3t0ITO5fyoT5FeD5omarVc3fa5iBALbkX3op5tvGilmx
	th1VHLvQZKkECVUl+SexihG2cOfg4Fh3qWJ24ESzuCvgwNpqY4nqN5JE9e99IMx5+u4M48
	OfQpet4Ujjw7Uw2dKqr5EMDpmZFc/NY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748613865;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iqzBQO/+9zRnkF+P+xRhyFVInujmVHGquqq/omqq5DM=;
	b=NrjLfAA5s7UElSgtxuxWx9+f8Afif+b2wFGR7tMRiLmxfJYJ//w5aaownnHxplHkqfWcGR
	vG1IQiIB4MgpCmCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC88A13889;
	Fri, 30 May 2025 14:04:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cE2DOei6OWgFQgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 30 May 2025 14:04:24 +0000
Date: Fri, 30 May 2025 16:04:08 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/4] btrfs-progs: new --inode-flags option
Message-ID: <20250530140408.GZ4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1747821454.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747821454.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 

On Wed, May 21, 2025 at 07:28:17PM +0930, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Fix typos
>   Exposed by github CI:
> 
>    ./mkfs/rootdir.c:1618: inheritted ==> inherited
>    ./kernel-shared/inode.c:161: Similiar ==> Similar
>    ./Documentation/mkfs.btrfs.rst:219: speicified ==> specified
> 
> The new --inode-flags option allows us to specify certain btrfs specific
> flags to each inode.
> 
> Currently we only support *nodatacow* and *nodatasum*.
> 
> But in the future compression flag can also be added, allowing more
> accurate per-file compression.
> 
> Furthermore child inodes will inherit the flag from their parents,
> meaning one only needs to specify the flag to the parent directory, then
> all children files/directories will have the flag.
> 
> This new option also works well with --subvol, although one has to
> note that, the inode flag inheritance does not cross subvolume boundary
> (the same as the kernel).
> 
> Finally, nodatacow and nodatasum will disable compression, just like the
> kernel.
> 
> Qu Wenruo (4):
>   btrfs-progs: allow new inodes to inherit flags from their parents
>   btrfs-progs: do not generate checksum nor compress if the inode has
>     NODATACOW or NODATASUM
>   btrfs-progs: mkfs: add --inode-flags option
>   btrfs-progs: mkfs-tests: a new test case for --inode-flags

Added to devel, thanks. This is better than the --subvol-nocow that was
proposed as a workaround before we have richer options for mkfs, but
the flags option itself is general enough so we can keep it in normal
build.

