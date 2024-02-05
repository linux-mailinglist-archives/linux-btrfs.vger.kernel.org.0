Return-Path: <linux-btrfs+bounces-2107-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77403849A0E
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 13:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FA32B2195F
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 12:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E58F1BC36;
	Mon,  5 Feb 2024 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ft2O+wOB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VznUUhDs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ft2O+wOB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VznUUhDs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4551B962;
	Mon,  5 Feb 2024 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707135974; cv=none; b=t0nCd4RX5+xIwaa35Fe6JOu8BTsYp/mZAOVar88M7U+u3mR4MQEiyJK2dYdLS+GvkU6RnlGsO5hDBQBj8h1fHKtRNE4cHbmj2Jozj2WDKum36V56cYNi7cEVd++00QWIZocE4fsAY+iD4hGBXnVIfG4X7YohumLxYbEZvPXYUww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707135974; c=relaxed/simple;
	bh=/WWD3To6u+eCPZpMGJRKkDX3WCOFpVPIyW/rSDLnnps=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vv4VeibTmlijKx4ZmOfYuuXkBL4XImQSAU7mPcb+Ddcw1vI/WyNVNeazOaj+DsCW4ElPqs/P93wUFzKptaiuzghXaoinpnU+lfSDkAFFttGD/Wjce6G2xLkYLdTQRWglPjpbtWTs/Pqwyv0uD4/wBOdjkcT6+zpUpIdlh0QNXfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ft2O+wOB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VznUUhDs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ft2O+wOB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VznUUhDs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 65B60220F4;
	Mon,  5 Feb 2024 12:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707135970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q8yovX7ZkSzL2tX8Zi0vM7tz818nJBFWsJQqQ44fHwY=;
	b=ft2O+wOBVhLzyVuh8m3TJANQEJ54TwrDlbm8wRcPqjtkMDMd0IMp170PoGN5Z7Q3RaobkP
	IxPQhFZeIzpMisCBmhjEEEA5TQ+cAmrrXiKxpBwt21On9RuywYyDe92RYlKdMlCaxel1Wt
	v/uhqw3Jw/piEYbw/KGowsk3Gr0w+Iw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707135970;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q8yovX7ZkSzL2tX8Zi0vM7tz818nJBFWsJQqQ44fHwY=;
	b=VznUUhDsl6kJgB4uhlbT5YfUlRarjPWLvCwambMuaSAtIOLlFC8URCXfK8jk1p/G4U4iwE
	rQ+5Rpd4XCuVl8Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707135970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q8yovX7ZkSzL2tX8Zi0vM7tz818nJBFWsJQqQ44fHwY=;
	b=ft2O+wOBVhLzyVuh8m3TJANQEJ54TwrDlbm8wRcPqjtkMDMd0IMp170PoGN5Z7Q3RaobkP
	IxPQhFZeIzpMisCBmhjEEEA5TQ+cAmrrXiKxpBwt21On9RuywYyDe92RYlKdMlCaxel1Wt
	v/uhqw3Jw/piEYbw/KGowsk3Gr0w+Iw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707135970;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q8yovX7ZkSzL2tX8Zi0vM7tz818nJBFWsJQqQ44fHwY=;
	b=VznUUhDsl6kJgB4uhlbT5YfUlRarjPWLvCwambMuaSAtIOLlFC8URCXfK8jk1p/G4U4iwE
	rQ+5Rpd4XCuVl8Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 785E313707;
	Mon,  5 Feb 2024 12:26:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MSGMCuDTwGV4TwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 05 Feb 2024 12:26:08 +0000
Date: Mon, 5 Feb 2024 23:26:00 +1100
From: David Disseldorp <ddiss@suse.de>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, Filipe Manana
 <fdmanana@suse.com>
Subject: Re: [PATCH 2/4] btrfs/173: make the test work when mounting with
 nodatacow
Message-ID: <20240205232600.15796771@echidna>
In-Reply-To: <0e243759cb9551eaac8b6f10f4dfbcbd5e880d56.1706810184.git.fdmanana@suse.com>
References: <cover.1706810184.git.fdmanana@suse.com>
	<0e243759cb9551eaac8b6f10f4dfbcbd5e880d56.1706810184.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ft2O+wOB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VznUUhDs
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[25.52%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -1.01
X-Rspamd-Queue-Id: 65B60220F4
X-Spam-Flag: NO

On Thu,  1 Feb 2024 18:03:48 +0000, fdmanana@kernel.org wrote:

> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently btrfs/173 fails when passing "-o nodatacow" to MOUNT_OPTIONS
> because it assumes that when creating a file it does not have the
> nodatacow flag set, which is obviously not true if the fs is mounted with
> "-o nodatacow". To allow the test to run successfully with nodatacow,
> just make sure it clears the nodatacow flag from the file if the fs was
> mounted with "-o nodatacow".
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/btrfs/173 | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tests/btrfs/173 b/tests/btrfs/173
> index 6e78a826..42af2d26 100755
> --- a/tests/btrfs/173
> +++ b/tests/btrfs/173
> @@ -23,6 +23,11 @@ echo "COW file"
>  # unset it after the swap file has been created.
>  rm -f "$SCRATCH_MNT/swap"
>  touch "$SCRATCH_MNT/swap"
> +# Make sure we have a COW file if we were mounted with "-o nodatacow".
> +if _normalize_mount_options "$MOUNT_OPTIONS" | grep -q "nodatacow"; then
> +	_require_chattr C
> +	$CHATTR_PROG -C "$SCRATCH_MNT/swap"
> +fi

Nit: _format_swapfile already calls $CHATTR_PROG +C, so might as well
put the _require_chattr call alongside _require_scratch_swapfile

>  chmod 0600 "$SCRATCH_MNT/swap"
>  _pwrite_byte 0x61 0 $(($(_get_page_size) * 10)) "$SCRATCH_MNT/swap" >> $seqres.full
>  $MKSWAP_PROG "$SCRATCH_MNT/swap" >> $seqres.full


