Return-Path: <linux-btrfs+bounces-9064-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A1F9AB000
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 15:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3AC81F22F6A
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 13:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D65519F42C;
	Tue, 22 Oct 2024 13:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VBo1rsad";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LpN1ehLU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VBo1rsad";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LpN1ehLU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAA319D8AD;
	Tue, 22 Oct 2024 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604907; cv=none; b=glTmkbu4e4R4XUVY+1ldUpeypYS4n0MMH47XpULG3C2ReerZRWULJ1YIQn2BSgvzWZMtFtRhw7Osai1xPaAHAvAcg4n35jMX7ZnT1/pcod6KBPhsfQVhojwBJ0mox0NcF5hAethWad3WurChj1OBP51Y6q2eNaRarNvQkVYbsHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604907; c=relaxed/simple;
	bh=u+no5sVh5kwppL0jkXYcySLBkTUixR1af2Xw/XyL3mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1Xe4r2PbLELHQh/jsSiLPF2NkXnpov8jpsRcgvQCviepuJvh7T7/Ivx7akXETYXXcWZi4xllVd2mSrHviPd+Eazjvcu1A209RouCgTZE4LE0RNPG9seBsUuZk2uAcz32SeDg4X0cTrBjnlIUqTrcczoKgFGuPAhMazqmBLH6SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VBo1rsad; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LpN1ehLU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VBo1rsad; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LpN1ehLU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 647951F844;
	Tue, 22 Oct 2024 13:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729604903;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q9IDTfTcN6BmY6N1zSS/KyRFKhsf/VPYqKCc9v2BDdU=;
	b=VBo1rsadl5i4SX+VMrzAFDx5f9FCuLj7grIvFKW5ud97LDBlw9A3P0/+MW9UIR2krFW9Cv
	FoHQTjcDDA/q5myuEUxP+qUidBPB9dLmpn+IixL7CG8xp4P4jECkCeEWvfkupEgphb9DCs
	Z/vtD/NRqwA1gTxMVV3XT+TxVXZRGz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729604903;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q9IDTfTcN6BmY6N1zSS/KyRFKhsf/VPYqKCc9v2BDdU=;
	b=LpN1ehLUCxC9hQGGMX4yHWX745UW9P1cvGFmrwUxoSbchT56NevyFdIjOPsHoDs4uaIU7R
	YvfOYyp/BROYMeDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729604903;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q9IDTfTcN6BmY6N1zSS/KyRFKhsf/VPYqKCc9v2BDdU=;
	b=VBo1rsadl5i4SX+VMrzAFDx5f9FCuLj7grIvFKW5ud97LDBlw9A3P0/+MW9UIR2krFW9Cv
	FoHQTjcDDA/q5myuEUxP+qUidBPB9dLmpn+IixL7CG8xp4P4jECkCeEWvfkupEgphb9DCs
	Z/vtD/NRqwA1gTxMVV3XT+TxVXZRGz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729604903;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q9IDTfTcN6BmY6N1zSS/KyRFKhsf/VPYqKCc9v2BDdU=;
	b=LpN1ehLUCxC9hQGGMX4yHWX745UW9P1cvGFmrwUxoSbchT56NevyFdIjOPsHoDs4uaIU7R
	YvfOYyp/BROYMeDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4176113AC9;
	Tue, 22 Oct 2024 13:48:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i16BDyetF2caZQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 22 Oct 2024 13:48:23 +0000
Date: Tue, 22 Oct 2024 15:48:22 +0200
From: David Sterba <dsterba@suse.cz>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: clm@fb.com, josef@toxicpanda.com, Johannes.Thumshirn@wdc.com,
	dsterba@suse.com, mpdesouza@suse.com, gniebler@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: Fix passing 0 to ERR_PTR in
 btrfs_search_dir_index_item()
Message-ID: <20241022134821.GC31418@suse.cz>
Reply-To: dsterba@suse.cz
References: <20241022095208.1369473-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022095208.1369473-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-3.99 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.19)[-0.960];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,suse.cz:mid,huawei.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -3.99
X-Spam-Flag: NO

On Tue, Oct 22, 2024 at 05:52:08PM +0800, Yue Haibing wrote:
> ret may be zero in btrfs_search_dir_index_item() and should not passed
> to ERR_PTR(). Now btrfs_unlink_subvol() is the only caller to this,
> reconstructed it to check ERR_PTR(-ENOENT) while ret >= 0, this fix
> smatch warnings:
> 
> fs/btrfs/dir-item.c:353
>  btrfs_search_dir_index_item() warn: passing zero to 'ERR_PTR'
> 
> Fixes: 9dcbe16fccbb ("btrfs: use btrfs_for_each_slot in btrfs_search_dir_index_item")
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
> v2: return ERR_PTR(-ENOENT) while ret >= 0

Reviewed-by: David Sterba <dsterba@suse.com>

Added to for-next, thanks.

