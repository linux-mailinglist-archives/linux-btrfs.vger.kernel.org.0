Return-Path: <linux-btrfs+bounces-10012-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC4D9E0721
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 16:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CDA6179626
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 15:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE91207A2B;
	Mon,  2 Dec 2024 15:23:41 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17168204F8D
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Dec 2024 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153020; cv=none; b=OcC28imc+zZzJ40He41EDNk1+tOtyJfaPwVdIBYH4kSG3Fuu9n1PSFyzFAeuciCkrtkCoDLLXIw186idarVzPSmX00CRJymozgShoAcY6VmzL9HPCIiefl+13vDidWRIB3oqf38B6zRizSFoxdiz7XAItW/o19RfmeYFfiD8hOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153020; c=relaxed/simple;
	bh=a8wGiDo706xa1XNIZ6u94gDK6ultXBM9/WwlPH1gf1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAd4Xd7Ab/xf/m32/TBy2isDnU5QccZLTx24nXGRc7/IJf48GJC/prmSyijmd+LOyrGGAXYxFr/xcrnzus8govAowdM4NP8VLRxZJiP+OBGvYCSECGjRh0h6K28F2FwIuE/mN/18JhXotr3tGvnEo6vyt6uvhEMPg0jMLoXu8lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4281D210F4;
	Mon,  2 Dec 2024 15:23:37 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30693139C2;
	Mon,  2 Dec 2024 15:23:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g1rECvnQTWdVMAAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Mon, 02 Dec 2024 15:23:37 +0000
Date: Mon, 2 Dec 2024 16:23:51 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Cc: Zorro Lang <zlang@kernel.org>, ltp@lists.linux.it,
	linux-btrfs@vger.kernel.org
Subject: Re: [LTP] [PATCH 1/3] ioctl_ficlone02.c: set all_filesystems to zero
Message-ID: <Z03RB9JDmBVORPlf@yuki.lan>
References: <20241201093606.68993-1-zlang@kernel.org>
 <20241201093606.68993-2-zlang@kernel.org>
 <Z02337yqxrfeZxIn@yuki.lan>
 <Z029S0wgjrsv9qHL@yuki.lan>
 <20241202144208.GB321427@pevik>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202144208.GB321427@pevik>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 4281D210F4
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

Hi!
> It's a nice feature to be able to force testing on filesystem even it's set to
> be skipped without need to manually enable the filesystem and recompile.
> (It helps testing with LTP compiled as a package without need to compile LTP.)
> Therefore I would avoid this.

I guess that this should be another env variable e.g.
LTP_FORCE_SINGLE_FS_TYPE and it should print a big fat warning that it's
only for development purposes.

-- 
Cyril Hrubis
chrubis@suse.cz

