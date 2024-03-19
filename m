Return-Path: <linux-btrfs+bounces-3429-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A52C48802D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 17:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32C17283B1D
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 16:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC0F11723;
	Tue, 19 Mar 2024 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SZldstN1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="02HormXI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SZldstN1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="02HormXI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D081119F
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867448; cv=none; b=n3MFsGEEk54+uIy8GOrcy62szgQrGVLeBZpPEGCrEU4OV02sYK9+FgrSDXJZ5fIgLa63y34NQgTRVjHSDbV11zOTnH9kunnDwlHq0TA8iJDGU6ThYwgS7SKRDCgIhygNcDIB+wOdbN6YDhm4OF0A3kU9FjrWpPyu05fnDTfk1+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867448; c=relaxed/simple;
	bh=eSZ0941Qk3KEqkVpTuDqkDISGJlvuO11FOXwKzPa9zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ri5VidpY8HxN6mBV4fhAloitT2G2REipAZObQrsImrEtnsAPnyFgjK5MaLTs0mf4iMcdW7703flhjCEJ3ffHxidO38a6J9REGMS+Hp0emDRYAH+Hp1DKVZ2i6JMetEnCaaId27rELYKHxbCUMVLKcJ2Sr4hrfEFCxNEj+/LzCg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SZldstN1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=02HormXI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SZldstN1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=02HormXI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB5D55D9B8;
	Tue, 19 Mar 2024 16:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710867442;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Kq4h76dljba+89jftPmUjieCoQbdoSGYofPlCfDtnQ=;
	b=SZldstN177TJQfXAtk19l5UxkZCPhIL66n8cgh8qdUZRxYk4/B6orcV96sQWfb4UlxQpcA
	fvy4fhvDJEAZ408rTZRKpqtKWXKzThTgsMfKXZjDfeVo0Y+2GQe+cGWYrSp9AiZahcd4EA
	YGfKUoCsYBwsGoQhxqDxbr+itqEQzY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710867442;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Kq4h76dljba+89jftPmUjieCoQbdoSGYofPlCfDtnQ=;
	b=02HormXItSO5fHPAVTvzhf8ZTPG5GYgU57N12M23AVEdBxvCNuKXcw8428mCm0ilarQGkj
	uGYrwh8Uvm6hVgCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710867442;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Kq4h76dljba+89jftPmUjieCoQbdoSGYofPlCfDtnQ=;
	b=SZldstN177TJQfXAtk19l5UxkZCPhIL66n8cgh8qdUZRxYk4/B6orcV96sQWfb4UlxQpcA
	fvy4fhvDJEAZ408rTZRKpqtKWXKzThTgsMfKXZjDfeVo0Y+2GQe+cGWYrSp9AiZahcd4EA
	YGfKUoCsYBwsGoQhxqDxbr+itqEQzY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710867442;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Kq4h76dljba+89jftPmUjieCoQbdoSGYofPlCfDtnQ=;
	b=02HormXItSO5fHPAVTvzhf8ZTPG5GYgU57N12M23AVEdBxvCNuKXcw8428mCm0ilarQGkj
	uGYrwh8Uvm6hVgCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA8D1136D6;
	Tue, 19 Mar 2024 16:57:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bb12KfLD+WWaMAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 19 Mar 2024 16:57:22 +0000
Date: Tue, 19 Mar 2024 17:50:01 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
	linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: use EXPERIMENTAL instead of
 CONFIG_BTRFS_DEBUG
Message-ID: <20240319165001.GN16737@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a3d01ef26525e9730f1d94de3d7c8e57f3c73fc7.1710458248.git.boris@bur.io>
 <20240318221729.GK16737@twin.jikos.cz>
 <cc5af6c7-c2a5-48da-9d35-2988f5cf12c8@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc5af6c7-c2a5-48da-9d35-2988f5cf12c8@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -1.98
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.98 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.77)[84.38%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SZldstN1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=02HormXI
X-Rspamd-Queue-Id: BB5D55D9B8

On Tue, Mar 19, 2024 at 10:37:40AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/3/19 08:47, David Sterba 写道:
> > On Thu, Mar 14, 2024 at 04:19:00PM -0700, Boris Burkov wrote:
> >> not sure exactly how this ifdef was supposed to work originally, but it
> >> currently doesn't and I don't see other use cases of this pattern.
> >>
> >> Use EXPERIMENTAL which does work after:
> >
> > Ok, makes sense. I missed that because I searched for EXPERIMENTAL and
> > did not find anything relevant but CONFIG_BTRFS_DEBUG has an effect.
> > I'll add a comment so it does not get accidentally changed back when
> > syncin the kernel code. Thanks.
> >
> Can't we just convert CONFIG_BTRFS_DEBUG to EXPERIMENTAL in kerncompat.h?

In principle yes, but the code from kernel and user space is not close
enough so that would be safe so this needs an audit what could break.

