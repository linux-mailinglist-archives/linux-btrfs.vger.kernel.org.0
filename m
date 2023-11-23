Return-Path: <linux-btrfs+bounces-327-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FF07F66C1
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Nov 2023 19:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E60C7281B2B
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Nov 2023 18:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECBB4B5BA;
	Thu, 23 Nov 2023 18:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WDHCLOVj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NHfMT4Nf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18EE1AE
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Nov 2023 10:57:43 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 6C3A31F459;
	Thu, 23 Nov 2023 18:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700765862;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N3cDZEMgzwjhqcyF8BRRaaTkQj1bi0qn+hPrHUC4D0g=;
	b=WDHCLOVjgHNIA6OsLHoxtRtZ43UKJHRubIMHR7S41M1tCqWcCgxKDp3XK5mpSDBveuwaDJ
	60bxm7zR9bwr1yRhxcj6xXSqwJT/bk6mp9XOPWezDfAKJeLS7Jao1SZVRr/JibXZF6I5Ow
	/YzakMDt/ZHV067GnTHcnUhd3UQDllA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700765862;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N3cDZEMgzwjhqcyF8BRRaaTkQj1bi0qn+hPrHUC4D0g=;
	b=NHfMT4NflVV8wFXqS6NIVGfekmwbRvVXKIU2+aOZS1v696TTTrHHGtmn5Tw1PBgSZPEkH7
	jY6auUHbSDBFMICA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
	by relay2.suse.de (Postfix) with ESMTP id 7689F2C16B;
	Thu, 23 Nov 2023 18:57:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
	id D7248DA86C; Thu, 23 Nov 2023 19:50:32 +0100 (CET)
Date: Thu, 23 Nov 2023 19:50:32 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: allow extent buffer helpers to skip
 cross-page handling
Message-ID: <20231123185032.GA31451@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <721bab821198fc9b49d2795b2028ed6c436ab886.1700111928.git.wqu@suse.com>
 <20231122134642.GB11264@twin.jikos.cz>
 <c1c0dacb-8db5-4b6b-90f1-a71487fb44dd@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1c0dacb-8db5-4b6b-90f1-a71487fb44dd@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd1
X-Spamd-Result: default: False [15.69 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 DMARC_NA(1.20)[suse.cz];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
	 FREEMAIL_TO(0.00)[gmx.com];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 BAYES_HAM(-1.60)[92.45%]
X-Spam-Score: 15.69
X-Rspamd-Queue-Id: 6C3A31F459
X-Spam: Yes

On Thu, Nov 23, 2023 at 06:31:41AM +1030, Qu Wenruo wrote:
> 
> 
> On 2023/11/23 00:16, David Sterba wrote:
> > On Thu, Nov 16, 2023 at 03:49:06PM +1030, Qu Wenruo wrote:
> >> --- a/fs/btrfs/disk-io.c
> >> +++ b/fs/btrfs/disk-io.c
> >> @@ -80,8 +80,16 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
> >>   	char *kaddr;
> >>   	int i;
> >>
> >> +	memset(result, 0, BTRFS_CSUM_SIZE);
> >>   	shash->tfm = fs_info->csum_shash;
> >>   	crypto_shash_init(shash);
> >> +
> >> +	if (buf->addr) {
> >> +		crypto_shash_digest(shash, buf->addr + offset_in_page(buf->start) + BTRFS_CSUM_SIZE,
> >> +				    buf->len - BTRFS_CSUM_SIZE, result);
> >> +		return;
> >> +	}
> >
> > This duplicates the address and size
> >> +
> >>   	kaddr = page_address(buf->pages[0]) + offset_in_page(buf->start);
> >>   	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
> >>   			    first_page_part - BTRFS_CSUM_SIZE);
> >> @@ -90,7 +98,6 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
> >>   		kaddr = page_address(buf->pages[i]);
> >>   		crypto_shash_update(shash, kaddr, PAGE_SIZE);
> >>   	}
> >> -	memset(result, 0, BTRFS_CSUM_SIZE);
> >>   	crypto_shash_final(shash, result);
> >
> > I'd like to have only one code doing the crypto_shash_ calls, so I'm
> > suggesting this as the final code (the diff is not clear);
> 
> This looks good to me, mind to update it inside your branch?

There's something wrong with my updates, it fails in the first test so
I've verified your works and the used it in misc-next for now.

