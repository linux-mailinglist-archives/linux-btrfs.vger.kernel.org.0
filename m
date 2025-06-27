Return-Path: <linux-btrfs+bounces-15034-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9115BAEB3D2
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 12:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3735B1C206FB
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 10:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75820296176;
	Fri, 27 Jun 2025 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tgGXAS0z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VLZM93aU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tgGXAS0z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VLZM93aU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B059C1E493C
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751018958; cv=none; b=EJ+I3bkVS2GSh/eW4McforlRYI0BWIeS9uFFEPBrcqnJ3Od8b0+WcjP/ENCYM46WdBqfURlNJN+OVprjrA9lA176zhQz60646QgLZRFJl27QAmVySY7bPOImWqQnRuMH+ipe8ZWG96GfXNr3ChuoHlJK0tqwLHiqGY4vdw20FJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751018958; c=relaxed/simple;
	bh=PIGBXiIRYQp6y+qm5CZ7FB9qbIW2Eb4iyHn0luaYzeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2M3maj1HD3pO8NXwEgqRCfI4QpAxRDEyy+QFt+k++5gUT3yLArNch0wpk9yMV3jk+r4Co5vqTK/0dXyrmCm4rG8TqG9ovZdDHoXd9dYtqW32+fsgqOTbQXjLmpNnD7/DyQ/QePgKtLkx7ngPFLaDKYsj7Wnm5d8j7BrUhzs3GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tgGXAS0z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VLZM93aU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tgGXAS0z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VLZM93aU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AFDF121165;
	Fri, 27 Jun 2025 10:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751018954;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PWDoY8Of5uXHQj9rdG2Ai6keZpBTDFPQGRlpbdSmdHc=;
	b=tgGXAS0zeoWmHGczPE1TSI89qx/4SKtGJVsBARu8i6E3ArCQ7lAe1mPhAAzkaesQFdKqqT
	JqomObE/bGU+DQCb2gh8Wt14Td2PNoWE4VSLOQSY1lI3/x7pb1whcfGHhY93a7rAY4UADy
	h7sXusphzRxjaL2X/H0zRMKNp2u7QbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751018954;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PWDoY8Of5uXHQj9rdG2Ai6keZpBTDFPQGRlpbdSmdHc=;
	b=VLZM93aUVzpWG/y0AqIrHkFJyn7PBCAjJf6jV8rYBBBe3EUyudUVKD9MS7FnPov4s7GUkt
	Yr+DIVi2VMxT1ZDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tgGXAS0z;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VLZM93aU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751018954;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PWDoY8Of5uXHQj9rdG2Ai6keZpBTDFPQGRlpbdSmdHc=;
	b=tgGXAS0zeoWmHGczPE1TSI89qx/4SKtGJVsBARu8i6E3ArCQ7lAe1mPhAAzkaesQFdKqqT
	JqomObE/bGU+DQCb2gh8Wt14Td2PNoWE4VSLOQSY1lI3/x7pb1whcfGHhY93a7rAY4UADy
	h7sXusphzRxjaL2X/H0zRMKNp2u7QbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751018954;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PWDoY8Of5uXHQj9rdG2Ai6keZpBTDFPQGRlpbdSmdHc=;
	b=VLZM93aUVzpWG/y0AqIrHkFJyn7PBCAjJf6jV8rYBBBe3EUyudUVKD9MS7FnPov4s7GUkt
	Yr+DIVi2VMxT1ZDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 977F213786;
	Fri, 27 Jun 2025 10:09:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JfS4JMptXmiUegAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 27 Jun 2025 10:09:14 +0000
Date: Fri, 27 Jun 2025 12:09:08 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "fdmanana@kernel.org" <fdmanana@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 10/12] btrfs: split inode rextef processing from
 __add_inode_ref() into a helper
Message-ID: <20250627100908.GE31241@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1750709410.git.fdmanana@suse.com>
 <77fb4fa12feec93ced283745958274bf33747104.1750709411.git.fdmanana@suse.com>
 <c6de293d-e194-425b-b87a-53805bf7b7fc@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6de293d-e194-425b-b87a-53805bf7b7fc@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AFDF121165
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21
X-Spam-Level: 

On Wed, Jun 25, 2025 at 11:35:04AM +0000, Johannes Thumshirn wrote:
> On 24.06.25 16:56, fdmanana@kernel.org wrote:
> > +static int unlink_extrefs_not_in_log(struct btrfs_trans_handle *trans,
> > +				     struct btrfs_path *path,
> > +				     struct btrfs_root *root,
> > +				     struct btrfs_root *log_root,
> > +				     struct btrfs_key *search_key,
> > +				     struct btrfs_inode *inode,
> > +				     u64 inode_objectid,
> > +				     u64 parent_objectid)
> > +{
> 
> 
> Again personal preference I guess, but unlink_extrefs_not_in_log() has 8 
> arguments. The previous patch introduced unlink_refs_not_in_log() which 
> has 7.
> 
> Of them trans, path, log_root, search_key, inode and parent_objectid are 
> shared.
> 
> I'd suggest making a 'struct unlink_not_in_log_ctx' that can be passed 
> into unlink_extrefs_not_in_log() and unlink_refs_not_in_log() reducing 
> the number of parameters.

This makes sense when the set of parameters is passed accross several
functions, it's not much of a difference when it's just one call,
arguably it's worse as passing it in a structre is one more indirection.

