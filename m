Return-Path: <linux-btrfs+bounces-2436-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E0B856700
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 16:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F384EB22F0D
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 15:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0203132C05;
	Thu, 15 Feb 2024 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DQm00dn7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y/mcAnE8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DQm00dn7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y/mcAnE8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A85C132487
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Feb 2024 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708010066; cv=none; b=oakHmqVRFAOR16mZ+YoCHv5XY8luZf0wnTZ/fEnJmYQq+JoLUYqTb2angoKsZQ7C9DQAnELQHFYD3HDCm1fbmcuUJ3Yes1lTgypC1nY03GVcl0oEklx+3RscWpbjbz2E8NJPovxHsdxcNxFgmB/1MgDZd79JnhfTPbGD8MkzXt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708010066; c=relaxed/simple;
	bh=gq45+/aRUioNHJBUJ3r9R+yI3lFwYpi5PG77RXWxTJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1Jnctl//6uBABPlExTASu9MKQC919MdBcVTXxtPX+O3chIn0Wr+OdLv+dDMfoj5s0SbZQVcgQc80P0vAhEtfilCYs7W0Liwjn5jPbY0v1C+iyDlFoIVY+SLx1P4YloZq81GATHitBI94N2LrYYuVORkxMEdeOK3C24dcarhHjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DQm00dn7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y/mcAnE8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DQm00dn7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y/mcAnE8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3079E21D4B;
	Thu, 15 Feb 2024 15:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708010061;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uO/Hq0/1aJg8xPN1blLqC9e0XEXfbHeKsTS2nY2jag0=;
	b=DQm00dn7bPKMRLBOf0FHSS4+9Mjrh80slEeTfdmrU+Nonqp8+oqlS+xs4xCGxn38vdKiIR
	bWmpRMgrm0wQe4qEruk28WN5MPFVef62p3mvyZRlt703DcXu1/tcFxJlqnJRf1Ba61+5RZ
	f2HmVAX4BVvw3sYSeccbW/8861xghtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708010061;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uO/Hq0/1aJg8xPN1blLqC9e0XEXfbHeKsTS2nY2jag0=;
	b=Y/mcAnE8Fpvkiz74X28Gkus/ie6TfMYanql2wFVXrxdrLbkFUXNR/ryaj7PysJc0fMdyb/
	ZQZVUlb5SN+lH5Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708010061;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uO/Hq0/1aJg8xPN1blLqC9e0XEXfbHeKsTS2nY2jag0=;
	b=DQm00dn7bPKMRLBOf0FHSS4+9Mjrh80slEeTfdmrU+Nonqp8+oqlS+xs4xCGxn38vdKiIR
	bWmpRMgrm0wQe4qEruk28WN5MPFVef62p3mvyZRlt703DcXu1/tcFxJlqnJRf1Ba61+5RZ
	f2HmVAX4BVvw3sYSeccbW/8861xghtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708010061;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uO/Hq0/1aJg8xPN1blLqC9e0XEXfbHeKsTS2nY2jag0=;
	b=Y/mcAnE8Fpvkiz74X28Gkus/ie6TfMYanql2wFVXrxdrLbkFUXNR/ryaj7PysJc0fMdyb/
	ZQZVUlb5SN+lH5Bw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 17995139D0;
	Thu, 15 Feb 2024 15:14:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id xKKBBU0qzmW9MQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 15 Feb 2024 15:14:21 +0000
Date: Thu, 15 Feb 2024 16:13:46 +0100
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	Edward Adam Davis <eadavis@qq.com>
Subject: Re: [PATCH 0/3] Ioctl buffer name/path validation
Message-ID: <20240215151346.GU355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1707935035.git.dsterba@suse.com>
 <20240214212232.GA480208@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214212232.GA480208@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DQm00dn7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Y/mcAnE8"
X-Spamd-Result: default: False [-0.01 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[qq.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[suse.com,vger.kernel.org,qq.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[14.25%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.01
X-Rspamd-Queue-Id: 3079E21D4B
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Wed, Feb 14, 2024 at 01:22:32PM -0800, Boris Burkov wrote:
> On Wed, Feb 14, 2024 at 07:31:54PM +0100, David Sterba wrote:
> > This is inspired by a report and fix [1] where device replace buffers
> > were not properly validated (third patch). The other two are doing
> > proper validation of vol args path or name so that an unterminated
> > string is reported as an error rather than relying on later actions like
> > open that would catch an invalid path.
> > 
> > (I'm OK to replace the third patch in favor of Edward as he spent time
> > analyzing it but we did not agree on a fix and I did not get a reply
> > with the suggestion I implemented in the end.)
> > 
> > [1] https://lore.kernel.org/linux-btrfs/tencent_44CA0665C9836EF9EEC80CB9E7E206DF5206@qq.com/
> 
> LGTM. One note/question: would it be helpful to pull out:
> 
> ```
> if (memchr(str, 0, str) == NULL)
>         return -ENAMETOOLONG;
> return 0;
> ```
> 
> into a helper and use it in all these places?

I think not, it's a one liner and it reads as "see if there's 0 in the
string buffer", this not some obscure semantics where eg. incrementing a
value would mean to start some big process.

