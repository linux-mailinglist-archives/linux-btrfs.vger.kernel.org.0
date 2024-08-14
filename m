Return-Path: <linux-btrfs+bounces-7202-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D38795259D
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 00:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D657EB23260
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 22:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CBC14A084;
	Wed, 14 Aug 2024 22:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sKw7jGjp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0V7CT/No";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sKw7jGjp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0V7CT/No"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E091D149E05
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Aug 2024 22:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723674064; cv=none; b=Cx+FxBb+SJdiq3zqSzgM7vcZZWEZWT+qz8zdjcL3Fxx0lRir02PnflYMnEtay9JUxg+dvR2c8pEujm7UScnkdFluvTuLuEoR5HcaQN621w9M+qTF7lehJgR7/tIFcy9qmFdXSf2wmp/V1OlqIBHr2IRKbHbprw1xJFInubeRUpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723674064; c=relaxed/simple;
	bh=P0N9cKphYDSwEKNx7dy+7vhHqbVahYFFn2m8sVfcf9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+044mW9TaKWrMGFlhUPZKsbrbFDKd5fo93l+OuvN8ilP/WXyH84OFallsynR6Ep+1NaSxAL4nRMxjkQoHNxoy33Hwmtjwp8PW0ydWkxBPJvCDYe3za0slld5NcJ3HE1Nrwf+HI1bPtnlrHUTuhQvHkYjbV0gP05xq/XevM/pZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sKw7jGjp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0V7CT/No; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sKw7jGjp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0V7CT/No; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 758E2223BC;
	Wed, 14 Aug 2024 22:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723674060;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oni0O83n6cQc9BrqgIlq+ZgvWmNoJBtEoLPkPFSm2ic=;
	b=sKw7jGjpNxuEed6upmGpkE0iRvQ/EGdDt+DgBBywm+XmpKMcszThw8p9NSjcKFVhfvLkm3
	APPa8JLygrUv2CRVh7Wm5EQPcO6ukVEGuIPXZcHM6ThQcch5vzxbSUIR07NVh/ICUkjSiq
	JYiZKqTA0a8NuscMMznAZHOVbzADcpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723674060;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oni0O83n6cQc9BrqgIlq+ZgvWmNoJBtEoLPkPFSm2ic=;
	b=0V7CT/NoYN1ySFpculfPkSxDdsCeQCl5wtdQzDGvIyJczSsQrlrQKCZ2mP3xVUthZw9HLK
	+aYGtwyiCvACWrBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sKw7jGjp;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="0V7CT/No"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723674060;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oni0O83n6cQc9BrqgIlq+ZgvWmNoJBtEoLPkPFSm2ic=;
	b=sKw7jGjpNxuEed6upmGpkE0iRvQ/EGdDt+DgBBywm+XmpKMcszThw8p9NSjcKFVhfvLkm3
	APPa8JLygrUv2CRVh7Wm5EQPcO6ukVEGuIPXZcHM6ThQcch5vzxbSUIR07NVh/ICUkjSiq
	JYiZKqTA0a8NuscMMznAZHOVbzADcpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723674060;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oni0O83n6cQc9BrqgIlq+ZgvWmNoJBtEoLPkPFSm2ic=;
	b=0V7CT/NoYN1ySFpculfPkSxDdsCeQCl5wtdQzDGvIyJczSsQrlrQKCZ2mP3xVUthZw9HLK
	+aYGtwyiCvACWrBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57022139B9;
	Wed, 14 Aug 2024 22:21:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EnqNFMwtvWZBXgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 14 Aug 2024 22:21:00 +0000
Date: Thu, 15 Aug 2024 00:20:51 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: kreijack@inwind.it, Mark Harmstone <maharmstone@fb.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5] btrfs-progs: add --subvol option to mkfs.btrfs
Message-ID: <20240814222051.GC25962@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240808171721.370556-1-maharmstone@fb.com>
 <20240809193112.GD25962@twin.jikos.cz>
 <f9492406-1fc4-4801-a74d-890353a34e3e@libero.it>
 <df13dc7a-88d5-4769-b028-3c5c28c29698@gmx.com>
 <1af5c6be-27ff-4dd5-ba5e-9213bd1e9f68@inwind.it>
 <77cda2a4-08ae-47b9-8efd-e3ca0e8fe9bc@gmx.com>
 <20240814215703.GB25962@suse.cz>
 <93991cfd-8a39-4178-b8ff-a5edd445410a@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93991cfd-8a39-4178-b8ff-a5edd445410a@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	FREEMAIL_CC(0.00)[inwind.it,fb.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com,inwind.it]
X-Rspamd-Queue-Id: 758E2223BC
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spam-Score: -4.21

On Thu, Aug 15, 2024 at 07:41:03AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/8/15 07:27, David Sterba 写道:
> [...]
> >>
> >> You ignored all the things like owner/group/privilege bits and maybe
> >> even xattrs (for SELINUX) that will be needed.
> >
> > There are probably two main use cases:
> >
> > - create something simple, with files copied from a directory and now
> >    newly also to make some directories subvolumes
> >
> > - create a filesystem where any detail can be specified, like uid/gid,
> >    access rights, ACL, XATTR, ...
> >
> > So far the focus is on option 1 and it seems we have the most common use
> > covered. For option 2 the command line options are probably the wron
> > interface.
> 
> Nope, the current implementation (inherited from the --rootdir option)
> handles both.
> 
> We have everything, except the hardlinks, copied from the rootdir,
> including uid/gid/access mode, XATTR.

For rootdir it copies exactly the uid/git values. The use case I have in
mind is to allow to change it to eg. root:root although the source files
are onwed by a "user:group".

> > I suggest to use an approach using a list of definitions, e.g. in a
> > file, where each line says what should be done on the filesystem. This
> > is not a new idea, XFS has a protofile, which is ancient and we don't
> > have to copy the exact format, but it's the same idea.
> 
> I think it's asking for problems that is already resolved.
> 
> The current rootdir is already providing every functionality, except
> subvolume related ones (subvolume, snapshot, default subvolume etc).
> 
> And Mark's excellent work handles the missing subvolume part, and he is
> also working on the default subvolume part too.
> 
> So far I really see no reason to introduce a completely new and complex
> (and conflicting with --rootdir) interface, while everything can be done
> by --rootdir + --subvol already.
> 
> The only exception is snapshot, but for mkosi usage, I didn't see much
> need for a snapshot.

I don't agree that everything is possible with --rootdir, like the
example above with the different user:group. Setting a root user
requires root but for cases where the image is built by an unprivileged
user it does not work. The difference is between actually modifying the
existing file (e.g. under SElinux or similar), but allowing the user to
create the filesystem image without limitations.

