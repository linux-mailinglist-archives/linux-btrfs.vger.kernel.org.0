Return-Path: <linux-btrfs+bounces-3016-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D3A87220B
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 15:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C622834DB
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 14:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244EF126F0D;
	Tue,  5 Mar 2024 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y7zmoTBD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7XO3RaIP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y7zmoTBD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7XO3RaIP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775CC6127
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Mar 2024 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650455; cv=none; b=aqyLCXQdUgl/IWRPUJMi2HacRjUinRtnv9sAMGPiRosct1eYWLAz3YnVrdAJJaywD3DOWjdisHDjrTW2mKBETkGw+VqckMem52ltwRaAcJHC37TS84oC4+cA2qphvjVdnFitrSOJTVwBuCmsL/x24FJcwFmItRyQUeHWivs2v1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650455; c=relaxed/simple;
	bh=04ayYkKrXpjig8ZuyMDIooroqQhdt1XktebLRQpVwqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvfaowPWGZnnfcj8tPh1UXaXPnIjYGqFQwq8c7l0pnYXoU7Ztnm6+Xv3cLp4zlkks+0ZLIMtDVdzQKRCFfFn3VO5FwRl8+YoN/WkSDnoxl27ztK8LWd+NvjXph/yU7gSIUaBYGugPa/0hXK1bHeDH8I8qarnD1pYCOWS97b8B8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y7zmoTBD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7XO3RaIP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y7zmoTBD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7XO3RaIP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 767923EA7;
	Tue,  5 Mar 2024 14:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709650451;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDFJTHribv9R/vbd5IwDyfZ9/x6eUfkMwb5hgA1uEIY=;
	b=Y7zmoTBDOrylaKPRZemg2eN2K2AvVTqTQ/MKtiiiZaxbbz/Qnrmx+V85YSp096V3Xr5HJl
	274NdSG9BUHLtdKwbPl5m/zk9qRCP0gxpdsS7DLjsg7mKW/RCQtNZfmdfBqw+dT7IEWZNF
	CMera/qJTHQqipI3ewu+lUzEAXTkRIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709650451;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDFJTHribv9R/vbd5IwDyfZ9/x6eUfkMwb5hgA1uEIY=;
	b=7XO3RaIPAFBq3fG1Phe1RZMgDTmSiysP3Zzxrr7ver50CH/YKkj4YTEOUaD0ka35YUO4gt
	Svy0jQ1cqtyp/rDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709650451;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDFJTHribv9R/vbd5IwDyfZ9/x6eUfkMwb5hgA1uEIY=;
	b=Y7zmoTBDOrylaKPRZemg2eN2K2AvVTqTQ/MKtiiiZaxbbz/Qnrmx+V85YSp096V3Xr5HJl
	274NdSG9BUHLtdKwbPl5m/zk9qRCP0gxpdsS7DLjsg7mKW/RCQtNZfmdfBqw+dT7IEWZNF
	CMera/qJTHQqipI3ewu+lUzEAXTkRIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709650451;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDFJTHribv9R/vbd5IwDyfZ9/x6eUfkMwb5hgA1uEIY=;
	b=7XO3RaIPAFBq3fG1Phe1RZMgDTmSiysP3Zzxrr7ver50CH/YKkj4YTEOUaD0ka35YUO4gt
	Svy0jQ1cqtyp/rDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F9BE13466;
	Tue,  5 Mar 2024 14:54:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id lBEpFxMy52XeTQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 05 Mar 2024 14:54:11 +0000
Date: Tue, 5 Mar 2024 15:47:05 +0100
From: David Sterba <dsterba@suse.cz>
To: li zhang <zhanglikernel@gmail.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs fixes for 6.8-rc7, part 2
Message-ID: <20240305144705.GO2604@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1709299316.git.dsterba@suse.com>
 <CAAa-AG=ad-2SxdTUsOWXtee+cnjUb+amOX+7d0EJdsXRV1n-yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAa-AG=ad-2SxdTUsOWXtee+cnjUb+amOX+7d0EJdsXRV1n-yg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Y7zmoTBD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7XO3RaIP
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_DN_SOME(0.00)[];
	 BAYES_HAM(-0.80)[84.73%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -2.01
X-Rspamd-Queue-Id: 767923EA7
X-Spam-Flag: NO

On Tue, Mar 05, 2024 at 10:45:31PM +0800, li zhang wrote:
> Hi,
> After pulling lasteast version, I can't compile, here's the error message.
> 
> 
> In file included from ./arch/x86/include/generated/asm/rwonce.h:1,
>                  from ./include/linux/compiler.h:251,
>                  from ./include/linux/instrumented.h:10,
>                  from ./include/linux/uaccess.h:6,
>                  from net/core/dev.c:71:
> net/core/dev.c: In function ‘netdev_dpll_pin_assign’:
> ./include/linux/rcupdate.h:462:36: error: dereferencing pointer to
> incomplete type ‘struct dpll_pin’

Unknown type struct dpll_pin, that's not related to btrfs.

