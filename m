Return-Path: <linux-btrfs+bounces-20875-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNfXKIlNcWkahAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20875-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 23:04:57 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 401E85E764
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 23:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1AC9180E4FF
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 21:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5E1425CEC;
	Wed, 21 Jan 2026 21:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kkGvzDAE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="26SIvrX+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JJMQU/Jg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fg/A/yYO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A5C3F0750
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 21:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032712; cv=none; b=jVztAfniO1/GFjscxCzPu8bMqQqfpJTl5XRkpU1EvCTqhAnBvOCV6Vp3QcHudz64M2vOWTHZbjxnV6ACR7mjB0QnPjz2LucZylpIX4nmxiCo0oit10QhgUaEV/x8glj7W7Kpche03R4zjOaVUpJJs1GsxeNTWHd1t93SyER6J8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032712; c=relaxed/simple;
	bh=UZV5otWlgIhZ/IACW6yPdtToh4qCNIOavqiMiL+GHJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJH2lhAMyVlqe8qScD69iwaSDFc9nAEEES7lSGoSUXYIr9DrT2ShQ7LBdzpkqClJMZAKelAzOZkqptobOpV+2CdLxUyVpx/Ky1BCTBezFkkVqhCMLun2dvrFuX9A7esZfCixGO+cODxljXBo2WNRbyUBJus0rarZhbmOLNYWzhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kkGvzDAE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=26SIvrX+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JJMQU/Jg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fg/A/yYO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E8CD75BD30;
	Wed, 21 Jan 2026 21:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769032709;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xxp1bj64TLdx5BIEqsYnan0805ZjECWnJt0mUgdqqZQ=;
	b=kkGvzDAE1LZLuAcHFx6IIjHN6i4Z1Ll+7zCvmz9jPr6cprcuptMkYEg9j2qQYMDDf/JaWi
	yYDQ4BuQm4lHLUhlk+opmS6DBqGKnLDpZ5YCbwnBVORcOWGowc3wA4VdSLsdx8nCHkI9Yf
	s6ShgkICtjL7wEtt9OcfzHIzZye2Q0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769032709;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xxp1bj64TLdx5BIEqsYnan0805ZjECWnJt0mUgdqqZQ=;
	b=26SIvrX+C+OSW9euhIoAiv9oVkgQOFRqXl1FXLvlaOYevACGmzX+u1uB0i0VU+WkCqPyW0
	556hPsSB2vRnBWCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769032708;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xxp1bj64TLdx5BIEqsYnan0805ZjECWnJt0mUgdqqZQ=;
	b=JJMQU/JgaMzujgCbTuvl7yBOAhrNW2vcAQKHJq/kABvyr6f5gcsR03MJR6zu0NpWR4Ho75
	KLH47uo9UlERJ8sfodPWigVUWa24xdDKuYwZGlGLATGc2Z5Sr08XOZfF2fa45lqKiyGTwU
	MjcGJXIKCGrSDYuStJVyC/k2mbzFRQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769032708;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xxp1bj64TLdx5BIEqsYnan0805ZjECWnJt0mUgdqqZQ=;
	b=fg/A/yYOPb+ilt7HnmWtYQOvauhXJtthuHwTlEC+YMBPJFB+Vn+DN98GHujzc5mcmGnfDa
	GTyOpdYXjkzzCGCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB8573EA63;
	Wed, 21 Jan 2026 21:58:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L585MQRMcWlvHQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 21 Jan 2026 21:58:28 +0000
Date: Wed, 21 Jan 2026 22:58:27 +0100
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/4] btrfs: allocate path in load_block_group_size_class()
Message-ID: <20260121215827.GQ26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1768911827.git.fdmanana@suse.com>
 <05452a804b036b205a791be1c1c5e09d0279812d.1768911827.git.fdmanana@suse.com>
 <3a5d1472-7ff0-447f-9d02-f75a60161ead@gmx.com>
 <20260121042455.GO26902@twin.jikos.cz>
 <b1f7072a-57de-4df5-abcf-a9e975e5c58f@gmx.com>
 <CAL3q7H5NRKqd4drKJfsLfcG8TB+tVo4p+KQyz2M6p7CnYg_b6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5NRKqd4drKJfsLfcG8TB+tVo4p+KQyz2M6p7CnYg_b6A@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20875-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmx.com,suse.cz,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[4];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.cz:replyto,suse.cz:dkim,gmx.com:email,twin.jikos.cz:mid]
X-Rspamd-Queue-Id: 401E85E764
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 10:42:23AM +0000, Filipe Manana wrote:
> On Wed, Jan 21, 2026 at 4:40 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > > how exactly to do it, maybe something is in the task_struct.
> > >
> >
> > I was looking into that during async csum development. But I didn't find
> > a good way to determine if we're in workqueue.
> 
> We can do this and it works:
> 
> /*
> * Since we run in workqueue context, we allocate the path on stack to
> * avoid memory allocation failure, as the stack in a work queue task
> * is not deep.
> */
> ASSERT(current_work() == &caching_ctl->work.normal_work);

Great, thanks. I was hoping for something less verbose that we can wrap
into eg. ASSERT_WORKQUEUE(...), and for different types we could use
_Generic.  But we can rethink it once we have more instances and see a
pattern.

