Return-Path: <linux-btrfs+bounces-126-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D70B37EAFA6
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Nov 2023 13:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A8728121B
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Nov 2023 12:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16513E47E;
	Tue, 14 Nov 2023 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="riPTfD4a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y9xxTCa8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AA23D3BC
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Nov 2023 12:10:34 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AC6128
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Nov 2023 04:10:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 417F7218D5;
	Tue, 14 Nov 2023 12:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699963831;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R3VxSmr0sH2jgtZC9rBOBehcDcAq0Pf3BaeUKV8Pz9A=;
	b=riPTfD4awjUpLxQqESpDKpwsmX1UwdNxUsXtJgxYIpmUNtTWzhHjX90Uar+jdvOzx4wZp2
	GpS7ccKBSwZN/PKUjeC6OvNNPqEpz4cxXUgfAgheQpY2FhTwcFW2UjdHCKbt81DPP4LpDM
	p0A1haI7hGrO35FmOLk8Urvt88oaDZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699963831;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R3VxSmr0sH2jgtZC9rBOBehcDcAq0Pf3BaeUKV8Pz9A=;
	b=y9xxTCa8Za2bGjiNO4SYPFNvBdGFbfszJEfU00MGYuCWTyXDSbh0oSgsGHu9pdiD/ZfD97
	nAyxN4tZ2mF59mAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2577D13416;
	Tue, 14 Nov 2023 12:10:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Y2GJCLdjU2UBYQAAMHmgww
	(envelope-from <dsterba@suse.cz>); Tue, 14 Nov 2023 12:10:31 +0000
Date: Tue, 14 Nov 2023 13:03:25 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add dmesg output when mounting and unmounting
Message-ID: <20231114120325.GZ11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <215e7eea95459d1b0cc4fd9ce522dc7c8f5d4e02.1698873846.git.wqu@suse.com>
 <20231113174502.GX11264@twin.jikos.cz>
 <83b7280d-6396-45c2-aa5e-fcd1f6f44963@gmx.com>
 <20231113210933.GY11264@twin.jikos.cz>
 <bfe5ce35-1bbf-4eb9-982d-30d52bec90fe@oracle.com>
 <80c99e71-363d-4e7d-860e-fc20a6c21492@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80c99e71-363d-4e7d-860e-fc20a6c21492@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.40
X-Spamd-Result: default: False [-6.40 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 BAYES_HAM(-2.60)[98.22%];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[suse.cz,gmx.com,suse.com,vger.kernel.org];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[]

On Tue, Nov 14, 2023 at 07:12:43PM +0800, Anand Jain wrote:
> 
> On misc-next:
> 
>      3212 btrfs_info(fs_info, "frist mount of filesystem %pU", 
> disk_super->fsid);
> 
> Has typo error.

Fixed, thanks for catching it.

