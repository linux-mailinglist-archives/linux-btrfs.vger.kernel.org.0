Return-Path: <linux-btrfs+bounces-6733-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FF493D773
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7960B1F24AB0
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 17:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1886B17C7D7;
	Fri, 26 Jul 2024 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZLW/wbd7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WquvlGbI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dZYfzUe9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tJxrz3zo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6362A11C83
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722014232; cv=none; b=NNm5AN33xhjJ+qJQJ9BGu71N9yc67L2qRIjqJMlZCTpKTufJJhApoGwDoPjz7tKNe9Cdb2VDuLPGTq82M7uYsLG7aJTkVIimPo0S6OSXxbJ5du6FVDz+fuImAhEo0CM7uSdNmP9LBL9rnoXJGNMdKkDeRRbNQwRAReqHKwTB6EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722014232; c=relaxed/simple;
	bh=JDodGFusjrNKo6VPIQfNzFCP3r/oFuAY/2Gr+BG9FdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dA7GgqOQdk8e6VXbxJYgox3+ihAOZcmOBSf1wZo22fdngeZFl9W7gYkttCftbznRneV0U+xZU8hLfc+uV33zKQDPh5WoxUdtFcGswLB5t1cSVvEmuQVGEXd/PRE0sfOqOSz6fvP5K5R8dVRXOOzTkBIRl1a4I8txErFSzOJHc84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZLW/wbd7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WquvlGbI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dZYfzUe9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tJxrz3zo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C1BA1F8BF;
	Fri, 26 Jul 2024 17:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722014228;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gC/GpfyE0X5VmZrg9KDbzmaPA8XGxghScz/54Vz50Kk=;
	b=ZLW/wbd7cs5GENw4D6V74yLbYDS+EsjM4AjZEgpip+ih1BfNHStRxl8kaUvWA4+9PuTmkP
	2WSZmZLSyAKjAGITjZYygTpZtBs0Q8bJVhc2WtQIOR2K3WyUQOjSt3/0GhwkTJw2g+6Avm
	qQVpASoNgM1RlXxL0yyDmw0RRI6fb4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722014228;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gC/GpfyE0X5VmZrg9KDbzmaPA8XGxghScz/54Vz50Kk=;
	b=WquvlGbIt0XztrjQJ6oq9p400//jP8DXYmV3SSBEDoXJbizZddINHOxQpieP8CJSCjKt+W
	XT2qaYI7Kq/LMKCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722014227;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gC/GpfyE0X5VmZrg9KDbzmaPA8XGxghScz/54Vz50Kk=;
	b=dZYfzUe97tAIWUvWRCTz7f1i28o0Dg4XOVSqUrxOlOosI/ziIiocBlvr81XxT/5KHz98zi
	8O6HgmJZ5OMXyrv2uZhBNTZ2oLZld3Mji5QEsmHGqBl1i0aCfTI+5qX6TzGPsOikYKZOeo
	LeUeMbh3EWOjtrNqi3Zg2aCXr2FepgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722014227;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gC/GpfyE0X5VmZrg9KDbzmaPA8XGxghScz/54Vz50Kk=;
	b=tJxrz3zoH0YJ0NnjOah6Bq7UAnzAQleWzr4ABNHt3NfxCIIS3hULRtE9noVqjmD23khBKj
	ozP6/CELYVnzGFBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EFC6138A7;
	Fri, 26 Jul 2024 17:17:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vpHAEhPao2YDTgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 26 Jul 2024 17:17:07 +0000
Date: Fri, 26 Jul 2024 19:17:06 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org,
	Mark Harmstone <maharmstone@meta.com>,
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 0/3] btrfs-progs: use libbtrfsutil for subvolume creation
Message-ID: <20240726171706.GL17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240628145807.1800474-1-maharmstone@fb.com>
 <ZqFCce87fcBxgdc9@devvm12410.ftw0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqFCce87fcBxgdc9@devvm12410.ftw0.facebook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-0.80 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Flag: NO
X-Spam-Score: -0.80

On Wed, Jul 24, 2024 at 11:05:37AM -0700, Boris Burkov wrote:
> On Fri, Jun 28, 2024 at 03:56:46PM +0100, Mark Harmstone wrote:
> > From: Mark Harmstone <maharmstone@meta.com>
> > 
> > These patches are a resending of Omar Sandoval's patch from 2018, which
> > appears to have been overlooked [0], split up and rebased against the
> > current code.
> > 
> > We change btrfs subvol create and btrfs subvol snapshot so that they use
> > libbtrfsutil rather than calling the ioctl directly.
> > 
> > [0] https://lore.kernel.org/linux-btrfs/ab09ba595157b7fb6606814730508cae4da48caf.1516991902.git.osandov@fb.com/
> 
> The series looks good to me, you can add
> Reviewed-by: Boris Burkov <boris@bur.io>
> to it.
> 
> Two high level questions:
> 1. I think you put duplicate Signed-off-by: and Co-authored-by: lines on
> each patch. Did you mean to put Omar as the Co-authored-by: ?

I think Omar's signed-off could be there in case the code is the same
except some minor adjustments to fix conflicts, or co-authored-by.

> 2. Have you run fstests with this patch applied? We have recently had
> some test failures from stdout in create subvol/snapshot changing, so I
> would like to avoid that fiasco again.

If the output changed then a filter needs to be added to fstests. I
don't see any for subvolume creation, only _filter_btrfs_subvol_delete.

Besides, the tests of btrfs-progs don't pass,
https://github.com/kdave/btrfs-progs/actions/runs/10114811661

misc test 033-filename-length-limit fails, subvolume length,
"unexpected success: subvolume with name 256 bytes long succeeded"

and cli test 019-subvolume-create-parents
"unexpected success: was able to create subvolume without an intermediate directory"

