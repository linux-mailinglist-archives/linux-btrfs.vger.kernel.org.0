Return-Path: <linux-btrfs+bounces-14829-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B155EAE206E
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 18:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C7E4C1BCB
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 16:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6802E613A;
	Fri, 20 Jun 2025 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2tn6KQ02";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iALGugG4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qzeU+ukG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sXaycS68"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C561F03C7
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Jun 2025 16:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750438477; cv=none; b=iJb0HshDibxwc24cf36kGTzihGkqPIpfQGD7IGrHhnzl1Fj3HF3QqNqBPxEj+UUtwm/+HCqjTHoS+IizVuY8Nbme6xhgTeWEksWAm2kBkHz6XvJuEvSlWJISTCwftusrmlABDKqUdrMCI8uzPbmwuUfTli0uJXSCEyYInCQBSNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750438477; c=relaxed/simple;
	bh=Pil2z5deChpCStYj+M4M/raqBxC+WvcuEB1ihh9riQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sW8KRpeNZL7eaBralWpzQNatsszubrw3pwb0rQDr0jJfXPxqpQhvzKdZ7R3iMl20NLtkXhzL06HkMTXDX6SomG+PSw02TFtpDtJe5XvrS/KZ0Ookxy6Xw+S0Cso865QnPJ2G4NcGePjh6vvGAUL5LDHipH+UO1SCQwteMX3xaOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2tn6KQ02; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iALGugG4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qzeU+ukG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sXaycS68; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D9810216ED;
	Fri, 20 Jun 2025 16:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750438473;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JDxSbM3ZF9G4k2N5EH9auObb3aSwhUSKZlYRXcR0lOA=;
	b=2tn6KQ02vAfv/IYonfaSpbr8Duku6Bl+cB5sK0UZLfj08LN02bjvmRpQr2HbR2/LC/xyb6
	YUQ3nTNNwxlxIdwKmnsBb6P8EjMyubdT/YDAVfdrEPvzSlKw8nInxoNF+FjswowshwNdQA
	LHFbsR742Ckv+d0jrcyz1a9j5oyWfuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750438473;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JDxSbM3ZF9G4k2N5EH9auObb3aSwhUSKZlYRXcR0lOA=;
	b=iALGugG4NX0tV5Vi8NHcHjpjTBzuM3gPf+cahP+lKkAaRm6tW92CmfUwn9CtmR3u5c3siB
	NTkUbBAxXdP1LjBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750438472;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JDxSbM3ZF9G4k2N5EH9auObb3aSwhUSKZlYRXcR0lOA=;
	b=qzeU+ukGpzRUuZgeqakJh0wCRK5/uy98zV1DSVS7UfAy02me+AFFJyerj3LYDtU8PdBPLJ
	VQDL+m/VIqeTGoDXtj/UMWVxmrAIx5WMbkcWt2GDtm4z4Lc/csoXUV8Yl9zqiHzoKJHGqN
	TPtdAbCFDbe1ZzFcFbhLLzCnEi3o2EY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750438472;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JDxSbM3ZF9G4k2N5EH9auObb3aSwhUSKZlYRXcR0lOA=;
	b=sXaycS68vISpAcud0gxvmvl+gAUlV64xiCAvqO91zrAg8vRyTa89EJuQT8KL2tQwvZnDeS
	5Gu45Es+AQcpMZDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2B6F136BA;
	Fri, 20 Jun 2025 16:54:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T2v/LkiSVWhUeAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 20 Jun 2025 16:54:32 +0000
Date: Fri, 20 Jun 2025 18:54:31 +0200
From: David Sterba <dsterba@suse.cz>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com, dsterba@suse.com
Subject: Re: [PATCH] btrfs-progs: filesystems: Check DATA profile before
 creating swapfile
Message-ID: <20250620165431.GB4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250606150826.119456-1-mpdesouza@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606150826.119456-1-mpdesouza@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 

On Fri, Jun 06, 2025 at 12:08:26PM -0300, Marcos Paulo de Souza wrote:
> Link: https://github.com/kdave/btrfs-progs/issues/840
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
> 
> I'm not sure if it would be better to just add a new helper method to check
> for profiles, please let me know if you would like to have a helper instead.

> +	ret = sysfs_open_fsid_file(fd, "allocation/data/single/total_bytes");
> +	if (ret < 0) {
> +		error("swapfile isn't supported on a filesystem with DATA profile different from single");
> +		ret = 1;
> +		goto out;
> +	}

This works, new helper can be added in case we'd need this pattern more
often.

But I'm not sure the error and exit is right here, it's up to the kernel
implementation to check the constraints. In progs it's better to warn
and say kernel may not support that, for features where this may change
in the future.

Do you have a usecase where you rely on this command failing? Maybe we
can enhance it so it verifies the known limitations, separately from the
actual file creation.

