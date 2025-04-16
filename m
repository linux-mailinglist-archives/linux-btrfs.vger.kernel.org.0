Return-Path: <linux-btrfs+bounces-13101-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388BFA90C0C
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 21:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B1517F829
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 19:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D192248B5;
	Wed, 16 Apr 2025 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yoitvz+k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Uvjv9FeZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="crmkyeyk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n0N1tYyG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEB420E01B
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 19:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744830897; cv=none; b=UZq5LkgrznBy1i799Pua+aqE4qwvK9TVO/LK8sCA9Nb6Pc7kRzEIdrQQZ+GlwSFAYRnmMdyNpne00jU2cA2kKufnnsSI0b/VRKPs0sRQJU/TNgOEe3AKITX71EL3oBFDKicnNQdPz5Acd8KnskSh1c6PKXW1G5l7JU+2XRoCPUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744830897; c=relaxed/simple;
	bh=+xA08HkurtRDMz56IGbko/z3JkizEkBqALqlUoMEIs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NH8We2yBGWrjh9KUMtrMPbrpPMJEvGfkycuNv1ImUzL4MQIG/HsN8MFevctY+0eAiHxuzJOSrxqu3Fqw7eYMKksmbOz/rayNKEUkZrG0ZW3CkjazkJ7Kcj8ZTBaxloOHsqHTgYUDXhb/olMnipfr/EUZFodE8oObLiJjwnFdqE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yoitvz+k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Uvjv9FeZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=crmkyeyk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n0N1tYyG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2B01E21186;
	Wed, 16 Apr 2025 19:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744830894;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfdzaRfYMYc+L8kbzO3T79vetuh68zg8wHfjn6a4JZw=;
	b=Yoitvz+kZrIUv59Hf23vr/EYSM2t10OaipaCkkuHyl00KBXcyVDU5Tto9SHsV+WymCSYxI
	4XXxOi4zCocUlxG0hcsHED9q2x64RY9jr9/4jfhReGnw8cAVXmqNPLus7LrSNobHCK9gQs
	e8AsErJNjoE6bytade+z00DufGFf4gg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744830894;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfdzaRfYMYc+L8kbzO3T79vetuh68zg8wHfjn6a4JZw=;
	b=Uvjv9FeZ+mpDR+eJG6wwqHB/NK0tM9Q0/uF1QqG2ET7TrYTpgg8dMNjIUi0/2nHqH4P3aV
	1HyCvcQZ31g0CyDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=crmkyeyk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=n0N1tYyG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744830893;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfdzaRfYMYc+L8kbzO3T79vetuh68zg8wHfjn6a4JZw=;
	b=crmkyeykbskRzCFL0ACxy1ig9Pya2XWLIXPYZkCwj1fWNh/xPRBHCbaas5coO2OqfXLP7J
	y/xIiI9tyF4vjGk9BiyvN2ZTSd7AY5Nryzfs93eXV55wmJT6h4WlC3cQwHhdqr21cEBQ3P
	3LHKnB51w/g/Wp/LHgIn71LeC4ufFNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744830893;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfdzaRfYMYc+L8kbzO3T79vetuh68zg8wHfjn6a4JZw=;
	b=n0N1tYyG6lMUE/dWUs2Fjmg2DbJF0petaC57eGYe69zmuj4ILPb/Dgc4YxDqHV7i5Cpexc
	a8v5OLTGTcSlEXDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05DA213976;
	Wed, 16 Apr 2025 19:14:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zZf4AK0BAGgBHQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 16 Apr 2025 19:14:53 +0000
Date: Wed, 16 Apr 2025 21:14:47 +0200
From: David Sterba <dsterba@suse.cz>
To: =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
Cc: Sun YangKai <sunk67188@gmail.com>, "clm@fb.com" <clm@fb.com>,
	"dsterba@suse.com" <dsterba@suse.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"neelx@suse.com" <neelx@suse.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggMS8zXSBi?= =?utf-8?Q?trfs=3A?= get
 rid of path allocation in btrfs_del_inode_extref()
Message-ID: <20250416191447.GD13877@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250415033854.848776-1-frank.li@vivo.com>
 <3353953.aeNJFYEL58@saltykitkat>
 <20250415155637.GG16750@suse.cz>
 <SEZPR06MB5269DCFA737F179B0F552B01E8BD2@SEZPR06MB5269.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SEZPR06MB5269DCFA737F179B0F552B01E8BD2@SEZPR06MB5269.apcprd06.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 2B01E21186
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,fb.com,suse.com,toxicpanda.com,vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Wed, Apr 16, 2025 at 01:24:30PM +0000, 李扬韬 wrote:
> 
> 
> > Also a good point, the path should be in a pristine state, as if it were just allocated. Releasing paths in other functions may want to keep the bits but in this case we're crossing a function boundary and the same assumptions may not be the same.
> 
> > Release resets the ->nodes, so what's left is from ->slots until the the end of the structure. And a helper for that would be desirable rather than opencoding that.
> 
> IIUC, use btrfs_reset_path instead of btrfs_release_path?
> 
> noinline void btrfs_reset_path(struct btrfs_path *p)
> {
>         int i;
> 
>         for (i = 0; i < BTRFS_MAX_LEVEL; i++) {
>                 if (!p->nodes[i])
>                         continue;
>                 if (p->locks[i])
>                         btrfs_tree_unlock_rw(p->nodes[i], p->locks[i]);
>                 free_extent_buffer(p->nodes[i]);
>         }
>         memset(p, 0, sizeof(struct btrfs_path));
> }
> 
> BTW, I have seen released paths being passed across functions in some other paths.
> 
> Should these also be changed to reset paths, or should these flags be cleared in the release path?

No, a path may be passed among several functions but the path bits may
be set up in a particular way and must be preserved. E.g. if the first
caller sets up path to search commit root the next call expect this bit
to be set as well so clearing it would be a bug.

Example is resolve_indirect_ref(), resolve_indirect_refs() and
find_parent_nodes() that set skip_locks and search_commit_root.

