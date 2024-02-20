Return-Path: <linux-btrfs+bounces-2583-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4ED85BBEC
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 13:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9AA281E1E
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 12:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A5B6996E;
	Tue, 20 Feb 2024 12:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KeRUeglP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mdU7mZ+6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KeRUeglP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mdU7mZ+6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B0069962
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Feb 2024 12:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431771; cv=none; b=BhUT2prm2vsX9bwPijfyxZCbQ6a7/fmhVBJRIFTrKngLBqV4Up9X7PtyslhoIR9fYuXZhYOt4vFmz5XJJL5L2/DmYGW3cFgix3mvxyd+K75v5QBLYN+OR7ZNB6P4ItIb+07Rh9mD5WqlqU7Y+jdKlmuyg2/Be4rmQT4Zmo21GqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431771; c=relaxed/simple;
	bh=Xe7LqiXANDllKyAjW2Y+PX38L3tljoCXU2ar+Amhb3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EoAGI0cygVq4VUbezaKiAJQo8hlt/uLUZ5xIa4/RlOhIfGFJ4Z5xAgQ4WP0rqgguLBEEruPtxjQQOAJpupd8srryLYsBja4YdWoF5yHvnZ6veTI71L/ruo2bOqkuSVCrDwAWtYlQU2ekDzpfieudL6iIxzVio9LhdEIE/eww9AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KeRUeglP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mdU7mZ+6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KeRUeglP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mdU7mZ+6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9E39D1F871;
	Tue, 20 Feb 2024 12:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708431767;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Khu3RFI5SBAK7lN33VeVnUTv6yJ5hBGFc5S1fVY6Dv0=;
	b=KeRUeglPKRpBh8ovtO0TPuhVM8tnVR/WcyspZMhVYyjNpKejgAreoF3Sh3THM5QOkfE9Ub
	Y/BeWmXPhoqs4Iua6Yy5ASDv+naLv7sjGHg4AwmT765YECYp7VtpKuoyWJP/fBqxNowPN3
	oI2zhid9VQ78fgKzxNeoBJ9Swu7FpY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708431767;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Khu3RFI5SBAK7lN33VeVnUTv6yJ5hBGFc5S1fVY6Dv0=;
	b=mdU7mZ+64LvtbBQ9ZDRQU7IM+kDAdTc+axPpO3+kvNYikqxmIes1KFKOuVZBfYTbXSK1L4
	iDXQo4ZzFOs4ufCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708431767;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Khu3RFI5SBAK7lN33VeVnUTv6yJ5hBGFc5S1fVY6Dv0=;
	b=KeRUeglPKRpBh8ovtO0TPuhVM8tnVR/WcyspZMhVYyjNpKejgAreoF3Sh3THM5QOkfE9Ub
	Y/BeWmXPhoqs4Iua6Yy5ASDv+naLv7sjGHg4AwmT765YECYp7VtpKuoyWJP/fBqxNowPN3
	oI2zhid9VQ78fgKzxNeoBJ9Swu7FpY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708431767;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Khu3RFI5SBAK7lN33VeVnUTv6yJ5hBGFc5S1fVY6Dv0=;
	b=mdU7mZ+64LvtbBQ9ZDRQU7IM+kDAdTc+axPpO3+kvNYikqxmIes1KFKOuVZBfYTbXSK1L4
	iDXQo4ZzFOs4ufCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8603B1358A;
	Tue, 20 Feb 2024 12:22:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id e26HIJeZ1GVcEgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 20 Feb 2024 12:22:47 +0000
Date: Tue, 20 Feb 2024 13:22:10 +0100
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org, wangyugui@e16-tech.com, clm@meta.com,
	hch@lst.de
Subject: Re: [PATCH v3] btrfs: introduce offload_csum_mode to tweak checksum
 offloading behavior
Message-ID: <20240220122210.GD355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <8dc4a312da70bb93f042f32a75efb7ec848cc08b.1707122589.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dc4a312da70bb93f042f32a75efb7ec848cc08b.1707122589.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KeRUeglP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mdU7mZ+6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.74 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 DWL_DNSWL_HI(-3.50)[suse.cz:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.03)[56.17%]
X-Spam-Score: -4.74
X-Rspamd-Queue-Id: 9E39D1F871
X-Spam-Flag: NO

On Mon, Feb 05, 2024 at 10:01:16PM +0900, Naohiro Aota wrote:
> We disable offloading checksum to workqueues and do it synchronously when
> the checksum algorithm is fast. However, as reported in the link below,
> RAID0 with multiple devices may suffer from the sync checksum, because
> "fast checksum" is still not fast enough to catch up RAID0 writing.
> 
> To measure the effectiveness of sync checksum and checksum offloading for
> developers, it would be better to have a switch for the checksum offloading
> under CONFIG_BTRFS_DEBUG hood.
> 
> This commit introduces fs_devices->offload_csum_mode for
> CONFIG_BTRFS_DEBUG, so that a btrfs developer can change the behavior by
> writing to /sys/fs/btrfs/<uuid>/offload_csum. The default is "auto" which
> is the same as the previous behavior. Or, you can set "on" or "off" (or "y"
> or "n" whatever kstrtobool() accepts) to always/never offload checksum.
> 
> More benchmark should be collected with this knob to implement a proper
> criteria to enable/disable checksum offloading.
> 
> Link: https://lore.kernel.org/linux-btrfs/20230731152223.4EFB.409509F4@e16-tech.com/
> Link: https://lore.kernel.org/linux-btrfs/p3vo3g7pqn664mhmdhlotu5dzcna6vjtcoc2hb2lsgo2fwct7k@xzaxclba5tae/
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

I'm adding this to for-next.

