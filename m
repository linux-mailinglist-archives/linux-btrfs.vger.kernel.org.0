Return-Path: <linux-btrfs+bounces-345-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC177F789B
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 17:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEFAC1C20905
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 16:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6D533CE8;
	Fri, 24 Nov 2023 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zrzYxcwY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b389d88F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAA712B
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Nov 2023 08:10:26 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 580721FF59;
	Fri, 24 Nov 2023 16:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700842225;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rR11UX/8qSbhCkYzrFp1MXa1nWO+TATJab4byBAYDsc=;
	b=zrzYxcwYaF7jNwvyPgSn7kmEZ2mMOnMONTjZS+7R+MPzeoHll//ioVID27hIJD3kufTt6r
	Kw4amz3EaXnMc+++eMAu33kVlfU2kqLyjhO3b3pEWFwJiePgpZep6ohWUAD7EQoKCaO1yV
	PaCPnaSPmZUEgAS0B2jo2lICJJN7u5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700842225;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rR11UX/8qSbhCkYzrFp1MXa1nWO+TATJab4byBAYDsc=;
	b=b389d88FSSyS+JvMpsQwjuU1j3wXxZQ77tbt7mu4fFFfgNRA4Suf0V1ccBfglRYz1jOO50
	aFJPZL9Ew5zt9TCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 23A75139E8;
	Fri, 24 Nov 2023 16:10:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id HTPAB/HKYGUpQQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 24 Nov 2023 16:10:25 +0000
Date: Fri, 24 Nov 2023 17:03:14 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: allow extent buffer helpers to skip
 cross-page handling
Message-ID: <20231124160314.GD18929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <721bab821198fc9b49d2795b2028ed6c436ab886.1700111928.git.wqu@suse.com>
 <20231122134642.GB11264@twin.jikos.cz>
 <c1c0dacb-8db5-4b6b-90f1-a71487fb44dd@gmx.com>
 <f2e23182-0f32-41e0-806b-c3b655362676@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2e23182-0f32-41e0-806b-c3b655362676@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.49
X-Spamd-Result: default: False [0.49 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 NEURAL_SPAM_LONG(3.49)[0.998];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Fri, Nov 24, 2023 at 07:21:04AM +1030, Qu Wenruo wrote:
> 
> 
> On 2023/11/23 06:31, Qu Wenruo wrote:
> > 
> > 
> > On 2023/11/23 00:16, David Sterba wrote:
> >> On Thu, Nov 16, 2023 at 03:49:06PM +1030, Qu Wenruo wrote:
> >>> --- a/fs/btrfs/disk-io.c
> >>> +++ b/fs/btrfs/disk-io.c
> >>> @@ -80,8 +80,16 @@ static void csum_tree_block(struct extent_buffer 
> >>> *buf, u8 *result)
> >>>       char *kaddr;
> >>>       int i;
> >>>
> >>> +    memset(result, 0, BTRFS_CSUM_SIZE);
> >>>       shash->tfm = fs_info->csum_shash;
> >>>       crypto_shash_init(shash);
> >>> +
> >>> +    if (buf->addr) {
> >>> +        crypto_shash_digest(shash, buf->addr + 
> >>> offset_in_page(buf->start) + BTRFS_CSUM_SIZE,
> >>> +                    buf->len - BTRFS_CSUM_SIZE, result);
> >>> +        return;
> >>> +    }
> >>
> >> This duplicates the address and size
> >>> +
> >>>       kaddr = page_address(buf->pages[0]) + offset_in_page(buf->start);
> >>>       crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
> >>>                   first_page_part - BTRFS_CSUM_SIZE);
> >>> @@ -90,7 +98,6 @@ static void csum_tree_block(struct extent_buffer 
> >>> *buf, u8 *result)
> >>>           kaddr = page_address(buf->pages[i]);
> >>>           crypto_shash_update(shash, kaddr, PAGE_SIZE);
> >>>       }
> >>> -    memset(result, 0, BTRFS_CSUM_SIZE);
> >>>       crypto_shash_final(shash, result);
> >>
> >> I'd like to have only one code doing the crypto_shash_ calls, so I'm
> >> suggesting this as the final code (the diff is not clear);
> > 
> > This looks good to me, mind to update it inside your branch?
> > 
> > Thanks,
> > Qu
> >>
> >>   74 static void csum_tree_block(struct extent_buffer *buf, u8 *result)
> >>   75 {
> >>   76         struct btrfs_fs_info *fs_info = buf->fs_info;
> >>   77         int num_pages;
> >>   78         u32 first_page_part;
> >>   79         SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
> >>   80         char *kaddr;
> >>   81         int i;
> >>   82
> >>   83         shash->tfm = fs_info->csum_shash;
> >>   84         crypto_shash_init(shash);
> >>   85
> >>   86         if (buf->addr) {
> >>   87                 /* Pages are contiguous, handle it as one big 
> >> page. */
> >>   88                 kaddr = buf->addr;
> >>   89                 first_page_part = fs_info->nodesize;
> >>   90                 num_pages = 1;
> >>   91         } else {
> >>   92                 kaddr = page_address(buf->pages[0]);
> >>   93                 first_page_part = min_t(u32, PAGE_SIZE, 
> >> fs_info->nodesize);
> >>   94                 num_pages = num_extent_pages(buf);
> >>   95         }
> >>   96         kaddr += offset_in_page(buf->start) + BTRFS_CSUM_SIZE;
> >>   97         first_page_part -= BTRFS_CSUM_SIZE;
> 
> This is decreasing the @first_page_part.
> 
> >>   98
> >>   99         crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
> >> 100                             first_page_part - BTRFS_CSUM_SIZE);
> 
> Meanwhile we're reducing the size again, and I guess this is the problem 
> causing the test failure.

Yes that was it.

> Although my initial version is indeed doing its own size calculation, 
> the extra calculation is much simpler and does not affect the existing 
> path (thus a little safer).
> 
> I'm fine with either way.

I have some WIP that modifies the checksumming and there are already
like 4 ways how to pass the data, that's the reason I'd like to keep the
cases to minimum, here it was easy.

