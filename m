Return-Path: <linux-btrfs+bounces-6792-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A26C093DAE2
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jul 2024 00:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 580C2282EBE
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 22:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F6514F118;
	Fri, 26 Jul 2024 22:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XUfb3gWu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mV0DguEs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XUfb3gWu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mV0DguEs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA7742AAA
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 22:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722034728; cv=none; b=bbN9OpRZvoTxKbYc5nHhMqlIIHN/bi4zXqv0hhXJlUVgb1silyvlXhwpVtVBSyzdG+x5Bqf8Hz1lFi1+uLt4I8cMSFo5lMgsJ1kO8r0dQk7yWkxENxZDLTTKkGYjAcESwdQEk5QKyTBdDW9OcUHAijZsR8iGIA7H9oygOxv6eTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722034728; c=relaxed/simple;
	bh=pRGl9E5FImzjaHvj+t41IRhvl/9C6jisoiu/Waw1RzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWqhYOr0oZnZDCIYiMBmgc86t+wqmVrZUvDw9TnQ1LCoavgg5hiKwBUCot3TYjyx9jpH8fKUf7yFiiyPK0q/CZ1VCklLAOtSFs7JK3o+q812n9Roxv6bYRGDW4xsoDcyEFhRQcpMN37JHnqyYYgl8bcLFV45+QN3j4E/gPfvx/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XUfb3gWu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mV0DguEs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XUfb3gWu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mV0DguEs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 872D821C0E;
	Fri, 26 Jul 2024 22:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722034724;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NJhlxrt3iv/K0fcQ96amsnc7fz/BAoGb4+Ez9HZvqf0=;
	b=XUfb3gWuAiROrpmIrJAj8A4jLNciU9IUb0YyMKOi/KC6MLW7yLGNCvZa+2hupcfQPCfuIg
	CA+6UaqOCDpnwOQXqcSGWU1zCktZzMCDJPF+766d933K/YDR8OQaHVZ6E58H5wQ96YsQ7T
	1tdMIAMOqr++Eh/6rwA+C9mEIdUcbSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722034724;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NJhlxrt3iv/K0fcQ96amsnc7fz/BAoGb4+Ez9HZvqf0=;
	b=mV0DguEsdKHStnIoCnW3boK1z8hDBWk91yTgctPChDHyEj9zMWxpXOg4+8dmCvfK78pP+b
	/Y7GAg4Dvhu99zBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XUfb3gWu;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mV0DguEs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722034724;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NJhlxrt3iv/K0fcQ96amsnc7fz/BAoGb4+Ez9HZvqf0=;
	b=XUfb3gWuAiROrpmIrJAj8A4jLNciU9IUb0YyMKOi/KC6MLW7yLGNCvZa+2hupcfQPCfuIg
	CA+6UaqOCDpnwOQXqcSGWU1zCktZzMCDJPF+766d933K/YDR8OQaHVZ6E58H5wQ96YsQ7T
	1tdMIAMOqr++Eh/6rwA+C9mEIdUcbSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722034724;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NJhlxrt3iv/K0fcQ96amsnc7fz/BAoGb4+Ez9HZvqf0=;
	b=mV0DguEsdKHStnIoCnW3boK1z8hDBWk91yTgctPChDHyEj9zMWxpXOg4+8dmCvfK78pP+b
	/Y7GAg4Dvhu99zBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D0A3138A7;
	Fri, 26 Jul 2024 22:58:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wr1AFiQqpGY/GwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 26 Jul 2024 22:58:44 +0000
Date: Sat, 27 Jul 2024 00:58:35 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs-progs: introduce btrfs_rebuild_uuid_tree() for
 mkfs and btrfs-convert
Message-ID: <20240726225835.GQ17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1721987605.git.wqu@suse.com>
 <8e33931a4d078d1e1aa620aa5fe717f35146ef31.1721987605.git.wqu@suse.com>
 <20240726153515.GI17473@twin.jikos.cz>
 <2a103477-428f-4145-94c0-5d2352c9a926@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a103477-428f-4145-94c0-5d2352c9a926@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -1.01
X-Rspamd-Queue-Id: 872D821C0E

On Sat, Jul 27, 2024 at 08:03:23AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/7/27 01:05, David Sterba 写道:
> > On Fri, Jul 26, 2024 at 07:29:55PM +0930, Qu Wenruo wrote:
> >> Currently mkfs uses its own create_uuid_tree(), but that function is
> >> only handling FS_TREE.
> >>
> >> This means for btrfs-convert, we do not generate the uuid tree, nor
> >> add the UUID of the image subvolume.
> >>
> >> This can be a problem if we're going to support multiple subvolumes
> >> during mkfs time.
> >>
> >> To address this inconvenience, this patch introduces a new helper,
> >> btrfs_rebuild_uuid_tree(), which will:
> >>
> >> - Create a new uuid tree if there is not one
> >>
> >> - Empty the existing uuid tree
> >>
> >> - Iterate through all subvolumes
> >>    * If the subvolume has no valid UUID, regenerate one
> >>    * Add the uuid entry for the subvolume UUID
> >>    * If the subvolume has received UUID, also add it to UUID tree
> >>
> >> By this, this new helper can handle all the uuid tree generation needs for:
> >>
> >> - Current mkfs
> >>    Only one uuid entry for FS_TREE
> >>
> >> - Current btrfs-convert
> >>    Only FS_TREE and the image subvolume
> >>
> >> - Future multi-subvolume mkfs
> >>    As we do the scan for all subvolumes.
> >>
> >> - Future "btrfs rescue rebuild-uuid-tree"
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   common/root-tree-utils.c | 265 +++++++++++++++++++++++++++++++++++++++
> >>   common/root-tree-utils.h |   1 +
> >>   convert/main.c           |   5 +
> >>   mkfs/main.c              |  37 +-----
> >>   4 files changed, 274 insertions(+), 34 deletions(-)
> >>
> >> diff --git a/common/root-tree-utils.c b/common/root-tree-utils.c
> >> index 6a57c51a8a74..13f89dbd5293 100644
> >> --- a/common/root-tree-utils.c
> >> +++ b/common/root-tree-utils.c
> >> @@ -15,9 +15,11 @@
> >>    */
> >>
> >>   #include <time.h>
> >> +#include <uuid/uuid.h>
> >>   #include "common/root-tree-utils.h"
> >>   #include "common/messages.h"
> >>   #include "kernel-shared/disk-io.h"
> >> +#include "kernel-shared/uuid-tree.h"
> >>
> >>   int btrfs_make_root_dir(struct btrfs_trans_handle *trans,
> >>   			struct btrfs_root *root, u64 objectid)
> >> @@ -212,3 +214,266 @@ abort:
> >>   	btrfs_abort_transaction(trans, ret);
> >>   	return ret;
> >>   }
> >> +
> >> +static int empty_tree(struct btrfs_root *root)
> >
> > Please rename this, it's confusing as empty can be a noun and verb so
> > it's not clear if it's a meant as a predicate or action.
> >
> Any recommendation? clear_tree()?

I've posted soem suggestions as the pull request review comments.

