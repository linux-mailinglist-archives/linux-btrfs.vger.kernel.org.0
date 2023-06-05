Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A30722CFA
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jun 2023 18:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbjFEQur (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 12:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbjFEQua (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 12:50:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58729EA
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 09:50:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E5E8F1FE78;
        Mon,  5 Jun 2023 16:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685983826;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7+6PIrmjrxFDWXsNdCOoDwx/01J2DHOM87Bt0lx2hOU=;
        b=bb3TOum41NE4nhA89METVeFBPTDaFvouOTvQ10OnVpsKY98ULdY3O/PAv+js7Tdq+gTV+l
        HefyV/YR848Rl1HzKlyzcua2C1LQIch6thqel2UNMPT4/jy/k6cNAAYpJhMq9ApDs6IdNq
        UyJfAHsGZLabt/KuYekNZIarVOss1bU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685983826;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7+6PIrmjrxFDWXsNdCOoDwx/01J2DHOM87Bt0lx2hOU=;
        b=ek3kzs7Y+sB3Zz2CQpfcYG6dIlPMiIS/ZGahNqrH3cMz4SgsVHGm05EC5fBL2FfQyuj7b5
        O+VxOdk4szC9RYAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE432139C8;
        Mon,  5 Jun 2023 16:50:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cie9LVISfmSuIQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 05 Jun 2023 16:50:26 +0000
Date:   Mon, 5 Jun 2023 18:44:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix a crash in metadata repair path
Message-ID: <20230605164412.GC25292@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cd4159ae5d32fdb87deba4bf6485819614016c11.1685088405.git.wqu@suse.com>
 <ZHC3T+OMEJ7VIkwi@infradead.org>
 <a836a7f0-2105-c0e1-7a51-6fa5dec0935d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a836a7f0-2105-c0e1-7a51-6fa5dec0935d@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 27, 2023 at 06:28:40AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/5/26 21:42, Christoph Hellwig wrote:
> > On Fri, May 26, 2023 at 08:30:20PM +0800, Qu Wenruo wrote:
> >>   	struct btrfs_fs_info *fs_info = eb->fs_info;
> >> -	u64 start = eb->start;
> >>   	int i, num_pages = num_extent_pages(eb);
> >>   	int ret = 0;
> >>
> >> @@ -185,12 +184,14 @@ static int btrfs_repair_eb_io_failure(const struct extent_buffer *eb,
> >>
> >>   	for (i = 0; i < num_pages; i++) {
> >>   		struct page *p = eb->pages[i];
> >> +		u64 start = max_t(u64, eb->start, page_offset(p));
> >> +		u64 end = min_t(u64, eb->start + eb->len, page_offset(p) + PAGE_SIZE);
> >> +		u32 len = end - start;
> >>
> >> -		ret = btrfs_repair_io_failure(fs_info, 0, start, PAGE_SIZE,
> >> -				start, p, start - page_offset(p), mirror_num);
> >> +		ret = btrfs_repair_io_failure(fs_info, 0, start, len,
> >> +				start, p, offset_in_page(start), mirror_num);
> >>   		if (ret)
> >>   			break;
> >> -		start += PAGE_SIZE;
> >
> > I actually just noticed this a week or so ago, but didn't have a
> > reproducer.  My fix  does this a little differeny by adding a branch
> > for nodesize < PAGE_SIZE similar to write_one_eb or
> > read_extent_buffer_pages, which feels a bit simpler and easier to read
> > to me:
> 
> Sometimes the extra calculation is going to damage the readability indeed.

I prefer your version as it has only one call to btrfs_repair_io_failure
which takes several parameters. The 'iterate/prepare arguments/call'
is a pattern I think we've been using often. The separate checks for
subpage were ment as an intermediate step so we don't touch the
non-subpage code but the goal is to merge them, meaning the logic would
be pushed to 'prepare arguments'.
