Return-Path: <linux-btrfs+bounces-2621-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDA485EB53
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 22:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345791F21BE8
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 21:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE451272D7;
	Wed, 21 Feb 2024 21:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gq1KhCTY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R+Os6ZOI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0INANFlK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4jTNePOA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F2F10953;
	Wed, 21 Feb 2024 21:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708552231; cv=none; b=auRZ18B1OVNU2VVomz4v/wvW6uzjalV5L+40Lr0k0Gx9n9EF1QOQKvnMFSPqXopn1Q/QPGy2s4NO2cz3F/1Z85qxuLwlN9br6yqqVizttFC5SyS1lBOPeHUqUSEED5sEOknl6A7NpLOBLak6z9IdyFYqoIdJGaf6QfjeNdFje9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708552231; c=relaxed/simple;
	bh=t9a+ea5soUDDDazhsg0btXEzeif/iF2NqR4czvKE9KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHyVWkU2lRPSDm3jPZWQX576lmHyYtwNISVbIKs0peCv6afhclHj6VnSD5zrsE6D3kQa450pTpWaqmH6foWKKvCJYsFqeWGvmou3czMd6Efu4087Vp5ph7C1a14tZGrcriBomqqR9tW2lbEyQvgB8KiwGzDZrU2EYogBodVWL0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gq1KhCTY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R+Os6ZOI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0INANFlK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4jTNePOA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E2DCF22102;
	Wed, 21 Feb 2024 21:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708552228;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ECGe6+5vmwC3C7l32TsJdztrw16tg8DS3PIzlID04vk=;
	b=gq1KhCTYvANhBIqTbTjb46LejIc3OT7JXxVqpT6svwIOQltpBeCcNklkE/Wf8V5TPd312q
	mc2bLi3pyqIvuHAWlkjGWbGb7E2ybRQn+jaAc3Xkjyt97krqm39VpT9KKX47Caa7X5ANHA
	tgfRX8vjPRiALnUBP9BKK58/4CoCZ+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708552228;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ECGe6+5vmwC3C7l32TsJdztrw16tg8DS3PIzlID04vk=;
	b=R+Os6ZOIzAgHBEFEG/NAzWvy/KMNPq4xfU8cm1B0w/nJbquo/OZ3YB5qeZw+L1Qu7RW5VR
	onPERYOxenZeeECw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708552227;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ECGe6+5vmwC3C7l32TsJdztrw16tg8DS3PIzlID04vk=;
	b=0INANFlKRpcTN5u0DdRap+YRu/we8S43m1EnQwF9UnHJtUvqQ0bt3VVY1gq9LIUmWYYdnG
	xtpA21oHp4+NCKGFKhoyu8jQqzaHSv6y/z0whHg+VIdYW0RUH05nJEiS9rA5CkeVSljN4L
	07DZIzgVHZYm2nG0NJMyoe4oUE5oEpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708552227;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ECGe6+5vmwC3C7l32TsJdztrw16tg8DS3PIzlID04vk=;
	b=4jTNePOAVyUBPXz6CRG7ByD6GaulsmkGYJfEQKK5x93mXG13enKGJIxWHEq4GFG1x6fuNa
	/2ni2xfULkXwtfDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C759413A42;
	Wed, 21 Feb 2024 21:50:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 0vV9MCNw1mXSJAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 21 Feb 2024 21:50:27 +0000
Date: Wed, 21 Feb 2024 22:49:50 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
	linux-btrfs@vger.kernel.org, dsterba@suse.com, aromosan@gmail.com,
	bernd.feige@gmx.net, CHECK_1234543212345@protonmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: do not skip re-registration for the mounted
 device
Message-ID: <20240221214949.GL355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <88673c60b1d866c289ef019945647adfc8ab51d0.1707781507.git.anand.jain@oracle.com>
 <20240214071620.GL355@twin.jikos.cz>
 <CAL3q7H5wx5rKmSzGWP7mRqaSfAY88g=35N4OBrbJB61rK0mt2w@mail.gmail.com>
 <20240220181236.GF355@suse.cz>
 <bdaa5790-56d8-4490-9eab-9a47e4926661@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdaa5790-56d8-4490-9eab-9a47e4926661@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0INANFlK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4jTNePOA
X-Spamd-Result: default: False [-0.07 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net,protonmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[suse.cz,kernel.org,vger.kernel.org,suse.com,gmail.com,gmx.net,protonmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.06)[61.34%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.07
X-Rspamd-Queue-Id: E2DCF22102
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Wed, Feb 21, 2024 at 10:09:59PM +0530, Anand Jain wrote:
> On 2/20/24 23:42, David Sterba wrote:
> > On Tue, Feb 20, 2024 at 02:08:00PM +0000, Filipe Manana wrote:
> >> On Wed, Feb 14, 2024 at 7:17 AM David Sterba <dsterba@suse.cz> wrote:
> >>> On Tue, Feb 13, 2024 at 09:13:56AM +0800, Anand Jain wrote:
> >>> https://btrfs.readthedocs.io/en/latest/dev/Developer-s-FAQ.html#ordering
> >>
> >> So this introduces a regression.
> >>
> >> $ ./check btrfs/14[6-9] btrfs/15[8-9]
> > 
> > Thanks, with this I can reproduce it and have some ideas what could go
> > wrong.
> 
> Thanks indeed.

I tested the following, it fixes the fsid problems and has passed full
fstests run. The temp-fsid test coverage needs to be done still.

@@ -1388,6 +1388,10 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
        if (ret)
                btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
                           path, ret);
+       if (devt) {
+               printk(KERN_ERR "free stale devt (for path %s)\n", path);
+               btrfs_free_stale_devices(devt, NULL);
+       }

