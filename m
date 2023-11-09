Return-Path: <linux-btrfs+bounces-61-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3F17E6C70
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Nov 2023 15:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B7C3B20E60
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Nov 2023 14:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F38B20328;
	Thu,  9 Nov 2023 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XgvQ07dv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="07Q4SpMq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC9A2031A
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Nov 2023 14:32:16 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1405F184
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Nov 2023 06:32:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B924121959;
	Thu,  9 Nov 2023 14:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699540334;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pFFhuS8MZmupOxtehwfWA3AqwGsIywIR7U+59VguL+Q=;
	b=XgvQ07dv+fiLC91GlVl7EWR5CErD7CHb8davGWuJ2PneLrYyhdr3yN4JwmAJbaco0vAcai
	/mlkDUknfcVo/cXL7+yZqPB0apmRiY8DzQnwuy3yki9JKMwaG4OXBRLProo606tmFwA0dH
	Xo01vFGFfuvCOESx0VAn7sCXOAEnVUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699540334;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pFFhuS8MZmupOxtehwfWA3AqwGsIywIR7U+59VguL+Q=;
	b=07Q4SpMqeXPSeajwT4/YVLop3478VrbON0Kb0DM1cAjZWjQZf3fcRj0ziHTv5ttE1+/YhM
	DdRppMN0pZaipcDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E5C8138E5;
	Thu,  9 Nov 2023 14:32:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id a9bgJW7tTGXjbwAAMHmgww
	(envelope-from <dsterba@suse.cz>); Thu, 09 Nov 2023 14:32:14 +0000
Date: Thu, 9 Nov 2023 15:25:11 +0100
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: make OWNER_REF_KEY type value smallest
 among inline refs
Message-ID: <20231109142511.GR11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <868ac4f8b351773d755e6518c6afa525371b1c56.1699036579.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <868ac4f8b351773d755e6518c6afa525371b1c56.1699036579.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)

On Fri, Nov 03, 2023 at 11:38:57AM -0700, Boris Burkov wrote:
> Companion patch to progs for the same change in the kernel. Inline refs
> are expected to have non-decreasing type value but owner ref violated
> this and got away with it via special parsing. Fix the inconsistency
> while it is still experimental.
> 
> Link: https://lore.kernel.org/linux-btrfs/20231103134547.GA3548732@perftesting/T/#mca2c0e21ecb7a0da616dd09980b9f008c3c00f63
> Signed-off-by: Boris Burkov <boris@bur.io>

Added to devel, thanks.

