Return-Path: <linux-btrfs+bounces-6088-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 699C691DFF5
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 14:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A611F23460
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 12:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2FC15A869;
	Mon,  1 Jul 2024 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="siUyEY2t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I6gOcMnV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HaTpYa2W";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gMGPR4Yc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D604915ADA0
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719838445; cv=none; b=aeLDgT+z/JmK19wyldZfXoUOFNiS/sf3YIHDi2YckzGh9YSFqPPVBbp2oDItnhcySGbyCPXeCcf9GJG0IXV5ZgFFCH2Tobl1cgbLzxcujO/QAGIHkNuFZsc4iW/wXz3pyjUEFS2Y6yqWP2e5RN7zzsrlwewJXh7U0a6ZcZOhOBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719838445; c=relaxed/simple;
	bh=040OggmF0LI6EmPEcIXSlRegOHtsyos9czBy2STMc2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+M4E9ze/CgDl+dF/g6iunS9FxoG39ceNDAs5E63QewLr7A7CdTUUyzNrB4mRGfkGC0DJVNa3wZS3CCuTBEUblzxu3qj4DH7rKxfg0msXKIwwrwm0UphUdB1ruvshY641iE8oNEwugf+IAS90dxHg5y7JK764yYyd11WYWSeCGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=siUyEY2t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I6gOcMnV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HaTpYa2W; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gMGPR4Yc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A35221FB46;
	Mon,  1 Jul 2024 12:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719838440;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CzhCyBl2LB9UbmRPK/mkmBSogTFspYBWRwUvMoWTxBI=;
	b=siUyEY2twImiWtFnaZQlJ8OXajuIPc4kRutLw9RHGTgx6X1fGHANmEoS0raP6RMCY4Xoch
	x1QZdqBB4EnWn0nKZaw2+NJk6zRIC546cKzv9/bx+NHtrU7RAuyBXdU3Lp6Y2FfxVNav5n
	Gn5sCU/m88M4SHyqXyywM7FAoULox9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719838440;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CzhCyBl2LB9UbmRPK/mkmBSogTFspYBWRwUvMoWTxBI=;
	b=I6gOcMnVJNd0TCn9QYKBov4P2ze1mnzJFXQPZp0lEMUDMiDRGRFBxaDymXYrt8GwlrDLnS
	oq/sRjzld6KARuDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HaTpYa2W;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gMGPR4Yc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719838439;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CzhCyBl2LB9UbmRPK/mkmBSogTFspYBWRwUvMoWTxBI=;
	b=HaTpYa2W3iXF+02fWoKNVSPVFUSMcKSkcjuR2X+i9Jgh+zC/xuzXIrLjPyK/a4nX5rKbip
	ouWsljpGC0y3+tGBqvCkFOZrQRHJxcTYOhYMg2ULawDLZyJyloSlgR2RKrnp2SbbAi+Fx4
	6NZEClrsPjmVQPxMFvNfrm2En20SSDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719838439;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CzhCyBl2LB9UbmRPK/mkmBSogTFspYBWRwUvMoWTxBI=;
	b=gMGPR4Yci+efoQ7v2+NIwVZ+IhNDPMPqRrAdP4GgZY2oi6ATVekEdUwAElqE5CKuGC5Jpl
	CcCO59cyZ5hqjcBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 832FE139C2;
	Mon,  1 Jul 2024 12:53:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mYHKH+emgmbPUQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 01 Jul 2024 12:53:59 +0000
Date: Mon, 1 Jul 2024 14:53:58 +0200
From: David Sterba <dsterba@suse.cz>
To: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org,
	Igor Raits <igor@gooddata.com>, Jan Cipa <jan.cipa@gooddata.com>,
	Zdenek Pesek <zdenek.pesek@gooddata.com>,
	Daniel Secik <daniel.secik@gooddata.com>
Subject: Re: Linux 6.9.y btrfs: "NULL pointer dereference in
 attach_eb_folio_to_filemap" and "BUG: soft lockup" issues
Message-ID: <20240701125358.GA21023@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAK8fFZ5KVjrg0OO1eEXyC85Eg=97oP_CWvOdQ=1ZFKLKLOojyw@mail.gmail.com>
 <20240617134637.GG25756@twin.jikos.cz>
 <CAK8fFZ5E61qNKC5TtbWm0vTtRMS0yRt=TE0gP8HnamYig+vJ5A@mail.gmail.com>
 <CAK8fFZ4aRZj7PSOR9XsiVDUi01HMx5k8w4Gs-vntfB41YvAc0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8fFZ4aRZj7PSOR9XsiVDUi01HMx5k8w4Gs-vntfB41YvAc0Q@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A35221FB46
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Mon, Jul 01, 2024 at 01:39:40PM +0200, Jaroslav Pulchart wrote:
> >
> > >
> > > Hi,
> > >
> > > On Mon, Jun 17, 2024 at 01:33:59PM +0200, Jaroslav Pulchart wrote:
> > > > Hello,
> > > >
> > > > We recently upgraded part of our production environment to kernel
> > > > 6.9.y. Since then, we've been encountering random kernel "NULL pointer
> > > > dereference" and "soft lockup" errors when using BTRFS. These issues
> > > > occur sporadically, sometimes after several days, and I haven't been
> > > > able to reproduce them consistently. Due to this unpredictability,
> > > > bisecting is not a feasible option.
> > > >
> > > > Attached are console logs from some instances of these issues:
> > > > * "NULL pointer dereference" in "btrfs.issue.1.log"
> > > > * "soft lockup" in "btrfs.issue.1.log"
> > > > Any assistance with investigating and resolving these problems would
> > > > be greatly appreciated.
> > >
> > > thanks for the report, the symptoms match the problem that was fixed
> > > recently by commit f3a5367c679d ("btrfs: protect folio::private when
> > > attaching extent buffer folios").
> > >
> > > > [1072053.328255] CPU: 15 PID: 2354438 Comm: kworker/u195:18 Tainted: G            E      6.9.3-1.gdc.el9.x86_64 #1
> > >
> > > 6.9.3 does not have the fix yet (unless you're using a manually patched
> > > kernel), it's in 6.9.5.
> >
> > Thanks, we will try the 6.9.5 asap and report results after a few days.
> 
> 
> Hello,
> 
> we do not see the issue any more with >= 6.9.5

Great, thanks for testing.

