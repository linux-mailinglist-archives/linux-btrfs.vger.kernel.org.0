Return-Path: <linux-btrfs+bounces-330-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4057F6707
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Nov 2023 20:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7270281D2B
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Nov 2023 19:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720894BAB4;
	Thu, 23 Nov 2023 19:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fQnL43Ll";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oRDGysqf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254C2BA
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Nov 2023 11:18:50 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 837DF2198F;
	Thu, 23 Nov 2023 19:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700767128;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gYbhUUE/W1L+gVSU26UZwhNSMQC+nrEN43LTh0+rK38=;
	b=fQnL43Llw9JjqCUhpM9G75+9pWSeKO21xH0HMraSTKVciEu21RWkxzLa3eges//q5cZu9K
	zisL5Gga7AN786x+ydIJrDPCAtPLpJix7kYtU1sthnfBPKcZHCYKbrCdti8beZJziLjysA
	vgzv7TuPVicDxe62kVU84xPVnM46xdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700767128;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gYbhUUE/W1L+gVSU26UZwhNSMQC+nrEN43LTh0+rK38=;
	b=oRDGysqf+9HDE9GoS9fXpwTe2053Tf2W4XfPkzXVnyz0K1QtSB3hNR2vkM03wMtWLBbx3t
	6obcC7NhfEK0U4Bw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
	by relay2.suse.de (Postfix) with ESMTP id 78DAC2C15F;
	Thu, 23 Nov 2023 19:18:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
	id 3E769DA86C; Thu, 23 Nov 2023 20:11:38 +0100 (CET)
Date: Thu, 23 Nov 2023 20:11:38 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs-progs: subvolume create: handle failure for
 strdup()
Message-ID: <20231123191138.GD31451@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1698903010.git.wqu@suse.com>
 <8c3df11d55b5add76a6abfd7896762697520a136.1698903010.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c3df11d55b5add76a6abfd7896762697520a136.1698903010.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Bar: ++++++++++++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [16.58 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 DMARC_NA(1.20)[suse.cz];
	 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 BAYES_HAM(-0.71)[83.57%]
X-Spam-Score: 16.58
X-Rspamd-Queue-Id: 837DF2198F

On Thu, Nov 02, 2023 at 04:03:48PM +1030, Qu Wenruo wrote:
> The function strdup() can return NULL if the system is out of memory,
> thus we need to hanle the rare but possible -ENOMEM case.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  cmds/subvolume.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/cmds/subvolume.c b/cmds/subvolume.c
> index 8504c380c9ee..bccc4968dad3 100644
> --- a/cmds/subvolume.c
> +++ b/cmds/subvolume.c
> @@ -194,8 +194,17 @@ static int cmd_subvolume_create(const struct cmd_struct *cmd, int argc, char **a
>  	}
>  
>  	dupname = strdup(dst);
> +	if (!dupname) {
> +		error("out of memory when duplicating %s", dst);

There are message templats for the most common errors, so this is now

error_msg(ERROR_MSG_MEMORY, "duplicating %s", dst);

