Return-Path: <linux-btrfs+bounces-1542-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF548310C5
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 02:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 358601C218DB
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 01:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD6D33CF;
	Thu, 18 Jan 2024 01:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vJkgFOVR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="l4TNH2BT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vJkgFOVR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="l4TNH2BT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8337B28F5
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jan 2024 01:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705540589; cv=none; b=SuKhSW6t+mcqAS12ML5oitbxUdLr/fC0j3GOGdqNuA/wud19g++FYMtNUQvqaqgERZPhYV09GlJ/lovToaEjYlVK4RApZtIzGZeJaKbsISrKlHRmTX7z4fW5WrAwvFF94KNt6Dze0PiMWZeWSsMENR5zR8HhsqX6rR31UgW5bsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705540589; c=relaxed/simple;
	bh=R4q2AuV8v9itiQKI6OgWFErNNapZzuBVC4apdQZ9DUo=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent:X-Spam-Level:
	 X-Rspamd-Server:X-Spamd-Result:X-Spam-Score:X-Rspamd-Queue-Id:
	 X-Spam-Flag; b=d8DZf/6oNUov+baObFc1K/hAqOePCT/l6WiG65V3Zm1wC+yVky3F7U9n2BwfiJeXI9tYLAbcmBPo4N9/2iTByT8ZnP2SEEedmz74/G8mlHmUMXpNP8aNudPAaAaGKXFRxnfuEtthZyFDgEpvTdK9xpAIf5KEMQNxMKxiR/b9TJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vJkgFOVR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=l4TNH2BT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vJkgFOVR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=l4TNH2BT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5AEF41F450;
	Thu, 18 Jan 2024 01:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705540583;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v0cEKHCklPbVroYH+qqHAUa3ml9IK6F5pUCJX2M/YfA=;
	b=vJkgFOVRFFS9/Sgiyu/FosGpRmXjhhXXBDQOgtoYJGS+4rFzPgACQAoicgP0u2234Jw0ne
	I75iahOIEfXQfuAN4x7Ot3vwLIBdqrtCoACvBJPXd+QnUSl1XMom122OaE4/jDO7/GFVXZ
	YHv4KrAMbI62jw1CxyYcYLLziklAKF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705540583;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v0cEKHCklPbVroYH+qqHAUa3ml9IK6F5pUCJX2M/YfA=;
	b=l4TNH2BT1Bo12VdSSDiqly9gbS4hz/UAMK4e/PKHIIrJXTRg7dVMh/3lMgDxYUJqDTmZiR
	aXYjbFynfe1DGqCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705540583;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v0cEKHCklPbVroYH+qqHAUa3ml9IK6F5pUCJX2M/YfA=;
	b=vJkgFOVRFFS9/Sgiyu/FosGpRmXjhhXXBDQOgtoYJGS+4rFzPgACQAoicgP0u2234Jw0ne
	I75iahOIEfXQfuAN4x7Ot3vwLIBdqrtCoACvBJPXd+QnUSl1XMom122OaE4/jDO7/GFVXZ
	YHv4KrAMbI62jw1CxyYcYLLziklAKF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705540583;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v0cEKHCklPbVroYH+qqHAUa3ml9IK6F5pUCJX2M/YfA=;
	b=l4TNH2BT1Bo12VdSSDiqly9gbS4hz/UAMK4e/PKHIIrJXTRg7dVMh/3lMgDxYUJqDTmZiR
	aXYjbFynfe1DGqCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 469F113462;
	Thu, 18 Jan 2024 01:16:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id nPqmEOd7qGVxCwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 18 Jan 2024 01:16:23 +0000
Date: Thu, 18 Jan 2024 02:16:04 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] btrfs-progs: parser related cleanups
Message-ID: <20240118011604.GP31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1705533399.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1705533399.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vJkgFOVR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=l4TNH2BT
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.21 / 50.00];
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
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[35.03%]
X-Spam-Score: -1.21
X-Rspamd-Queue-Id: 5AEF41F450
X-Spam-Flag: NO

On Thu, Jan 18, 2024 at 09:47:00AM +1030, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Properly return the parsed value for parse_u64_with_suffix()
>   Facepalm, I forgot to assign the result to @value_ret, and only relied
>   on cli-tests to catch them, but they are not enough to catch.
> 
> - Avoid outputting any error message inside parse_u64_with_suffix()
>   One error message and exit(1) call is left from previous function.
>   Need to be consistent with all other error situations.
> 
> - Rebased using the patch from devel branch
>   So that the modification David did won't need to be redone.

Updated thanks.

