Return-Path: <linux-btrfs+bounces-62-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 855577E6C7A
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Nov 2023 15:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465212812E1
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Nov 2023 14:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3283620315;
	Thu,  9 Nov 2023 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x3d6087z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yboH44R6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0BB20310
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Nov 2023 14:34:10 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4E12D78
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Nov 2023 06:34:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2868B1F8B8;
	Thu,  9 Nov 2023 14:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699540448;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4t7K1Pajl20rTv2FT6W94QgStxWsNkD1Fx5CCX5scDM=;
	b=x3d6087zARp6ZVQ7DlQtJ+GxK+0E/vKGVD48FfgMubIEnlorAUi0X6DI/j7ePXcojlM2sz
	e+IR8FvRYYjWmVCofCv5QjEpmXPeYq606WwuwJ3ilZZfcd8jvrjivuk3xjNq3gCdCGkzX8
	6quKIHMdPVTVQF6V9ic2jlEl5MACSVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699540448;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4t7K1Pajl20rTv2FT6W94QgStxWsNkD1Fx5CCX5scDM=;
	b=yboH44R6r9i6sqnllSSfM5VKcdIgc9/UZDI5wmcFxwBvhVQDUwNGN5Q72OkUFPfNQ+orPt
	vPjwMSVhz/AWGVDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 079EE138E5;
	Thu,  9 Nov 2023 14:34:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 3jdrAODtTGXRcAAAMHmgww
	(envelope-from <dsterba@suse.cz>); Thu, 09 Nov 2023 14:34:07 +0000
Date: Thu, 9 Nov 2023 15:27:05 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: tests: use new sysfs interface to check
 prereq acl
Message-ID: <20231109142705.GS11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a98e31546da07a22e785cbb1dc40720fcdb4b095.1699432917.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a98e31546da07a22e785cbb1dc40720fcdb4b095.1699432917.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)

On Wed, Nov 08, 2023 at 04:51:20PM +0800, Anand Jain wrote:
> With the kernel commit 070bb0011ccf ("btrfs: sysfs: show if ACL
> support has been compiled in") we can now check if ACL is compiled
> without requiring a btrfs device. Retain older method for older
> kernels.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to devel, thanks.

