Return-Path: <linux-btrfs+bounces-329-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F14D7F66D8
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Nov 2023 20:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92D3AB21382
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Nov 2023 19:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB854B5B2;
	Thu, 23 Nov 2023 19:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V01vOEzD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fxKgeRib"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B5A9E;
	Thu, 23 Nov 2023 11:02:22 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id CCAE421985;
	Thu, 23 Nov 2023 19:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700766140;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v9TGYvTKQ0lFAleqc3DOkuuAQwtF3iftxKoOgpQgym0=;
	b=V01vOEzDysHb/o2JkFC0tz+oDkugDTXBWRmgAJaVfee1D6eghHb44978VEcmWmIEzOAV2q
	/klBoZZIvGp0utZZ2HmJ1sLdxc//mRCEYYhnTbTFa95RFx5mrXtiPz1IWjVNI8xwk6jOsK
	8PGx0hxJKyDnsWFeZK+Z6hURU4E7y+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700766140;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v9TGYvTKQ0lFAleqc3DOkuuAQwtF3iftxKoOgpQgym0=;
	b=fxKgeRibAOl/dvl2/5KA96PdEpS5fV78+I84Y7I47drLVHxV61ZEVI5S8oi3b1/SIr3ZCZ
	/WI4iPHuJSDl1DBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
	by relay2.suse.de (Postfix) with ESMTP id C07112C16B;
	Thu, 23 Nov 2023 19:02:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
	id 9186FDA86C; Thu, 23 Nov 2023 19:55:11 +0100 (CET)
Date: Thu, 23 Nov 2023 19:55:11 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v2 0/5] btrfs: zoned: remove extent_buffer redirtying
Message-ID: <20231123185511.GC31451@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231123-josef-generic-163-v2-0-ed1a79a8e51e@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123-josef-generic-163-v2-0-ed1a79a8e51e@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Bar: +++++++++++++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd1
X-Spamd-Result: default: False [17.29 / 50.00];
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
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 BAYES_HAM(-0.00)[15.58%]
X-Spam-Score: 17.29
X-Rspamd-Queue-Id: CCAE421985

On Thu, Nov 23, 2023 at 07:47:14AM -0800, Johannes Thumshirn wrote:
> Since the beginning of zoned mode, I've promised Josef to get rid of the
> extent_buffer redirtying, but never actually got around to doing so.
> 
> Then 2 weeks ago our CI has hit an ASSERT() in this area and I started to look
> into it again. After some discussion with Christoph we came to the conclusion
> to finally take the time and get rid of the extent_buffer redirtying once and
> for all.
> 
> Patch one renames EXTENT_BUFFER_NO_CHECK into EXTENT_BUFFER_ZONED_ZEROOUT,
> because this fits the new model somewhat better.
> 
> Number two sets the cancel bit instead of clearing the dirty bit from a zoned
> extent_buffer.
> 
> Number three removes the last remaining bits of btrfs_redirty_list_add().
> 
> The last two patches in this series are just trivial cleanups I came across
> while looking at the code.
> 
> ---
> Changes in v2:
> - Rename EXTENT_BUFFER_CANCELLED to EXTENT_BUFFER_ZONED_ZEROOUT
> - Add comments why we're marking the buffer as zeroout and zero it.
> - Add Reviews from Josef and Christoph
> - Link to v1: https://lore.kernel.org/r/20231121-josef-generic-163-v1-0-049e37185841@wdc.com
> 
> ---
> Johannes Thumshirn (5):
>       btrfs: rename EXTENT_BUFFER_NO_CHECK to EXTENT_BUFFER_ZONED_ZEROOUT
>       btrfs: zoned: don't clear dirty flag of extent buffer
>       btrfs: remove now unneeded btrfs_redirty_list_add
>       btrfs: use memset_page instead of opencoding it
>       btrfs: reflow btrfs_free_tree_block

With the rename in patch 5/5 added to misc-next, thanks.

