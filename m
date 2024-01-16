Return-Path: <linux-btrfs+bounces-1476-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2502482F210
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 17:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7B91F2188C
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 16:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B641CAAD;
	Tue, 16 Jan 2024 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sDuA4gz0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nGOo7I5n";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sDuA4gz0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nGOo7I5n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1751CA85
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 42138221E3;
	Tue, 16 Jan 2024 16:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705420854;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DvktxeyhlQTtxrdb5/FFrPWlcPsGygB3QUxbTa4GPKM=;
	b=sDuA4gz0dT/c5N0wLSdXEuil7VwdzajG08ETlOPk7wcu1RN7QFBuSW19kw05Jz1m8ExjPN
	erWI8rE+NJbxqNZS0PIUtv2DCejezHmKYxAcEqCv5adJ4eMVPlGBdCvfH71gScHkGVmeeZ
	VvkDfIuBXdwpaBSsKokgl0HTj9Q3bbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705420854;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DvktxeyhlQTtxrdb5/FFrPWlcPsGygB3QUxbTa4GPKM=;
	b=nGOo7I5ns36y9RhPQA/oDHG6j0LgcltLhW7YqQIeC42OIsXw+Yjhs6TE4R8E3nibz6rtBq
	OC5hjK6Me3D8MACQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705420854;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DvktxeyhlQTtxrdb5/FFrPWlcPsGygB3QUxbTa4GPKM=;
	b=sDuA4gz0dT/c5N0wLSdXEuil7VwdzajG08ETlOPk7wcu1RN7QFBuSW19kw05Jz1m8ExjPN
	erWI8rE+NJbxqNZS0PIUtv2DCejezHmKYxAcEqCv5adJ4eMVPlGBdCvfH71gScHkGVmeeZ
	VvkDfIuBXdwpaBSsKokgl0HTj9Q3bbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705420854;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DvktxeyhlQTtxrdb5/FFrPWlcPsGygB3QUxbTa4GPKM=;
	b=nGOo7I5ns36y9RhPQA/oDHG6j0LgcltLhW7YqQIeC42OIsXw+Yjhs6TE4R8E3nibz6rtBq
	OC5hjK6Me3D8MACQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 20CA0133CF;
	Tue, 16 Jan 2024 16:00:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id LdaIBzaopmXhKAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 16 Jan 2024 16:00:54 +0000
Date: Tue, 16 Jan 2024 17:00:36 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: tree-checker: dump the tree block when
 hitting an error
Message-ID: <20240116160036.GZ31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a5ab0e98ae40df23b3bb65235f7bd9296e3b0be4.1705027543.git.wqu@suse.com>
 <20240112153602.GP31555@twin.jikos.cz>
 <7e908c1f-d14f-4562-ae1e-1431c091b140@gmx.com>
 <20240115145438.GT31555@suse.cz>
 <c31f1082-82f5-4558-9795-db1b40079f91@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c31f1082-82f5-4558-9795-db1b40079f91@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.20 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
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
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[38.65%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.20

On Tue, Jan 16, 2024 at 09:13:23AM +1030, Qu Wenruo wrote:
> 
> 
> On 2024/1/16 01:24, David Sterba wrote:
> > On Sat, Jan 13, 2024 at 07:03:18AM +1030, Qu Wenruo wrote:
> >>>> +	btrfs_print_tree((struct extent_buffer *)eb, 0);
> >>>
> >>> Printing the eb should not require writable eb, but there are many
> >>> functions that would need to be converted to 'const' so the cas is OK
> >>> for now but cleaning that up would be welcome.
> >>
> >> I tried but failed.
> >>
> >> Most of the call sites are fine to be constified, but there is a special
> >> trap inside bfs_print_children(), where we call extent_buffer_get(),
> >> which can never be called on a const eb pointer.
> >
> > Oh, I see. We can't remove the ref update but what if we reset the path
> > slot to NULL before releasing it?
> 
> The other solution would be, only consitfy btrfs_print_node() and
> btrfs_print_leaf().
> 
> For anything that would need to traversal the tree, still allow them to
> modify the eb.
> 
> I'll give it a try, and if it passed compile, that would be my next step.
> Would this be a good idea?

Yeah makes sense, we'll se how much can it can be cleaned up. The const
parameters are nice to have as they don't really break anything, but
should be used as a matter of good coding practices.

