Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A322D60AF0B
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Oct 2022 17:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiJXP2P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Oct 2022 11:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiJXP1z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Oct 2022 11:27:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F927CAE6E
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 07:14:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9DBA21FD61;
        Mon, 24 Oct 2022 14:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666620083;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=10x1hyDvBj0MMmub22pd3xBU1LHwDoxfqRx6VpFMoRM=;
        b=AGOeI+aRPyt1b5dIhHlLaT63BoW7AFPXYXJ1b+sKvtn3CF8e1LoqTEeETdhCjH8kAauSN2
        8wPhn8ffTOa+ox2/O/BZEJBLQ7DiJJ22QfUYeIEr4djuo+SB98x+oaF86ETqvZ6RvxuaWP
        IXNMgv4Vc8flWgMZMauZC9GQsmBuf+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666620083;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=10x1hyDvBj0MMmub22pd3xBU1LHwDoxfqRx6VpFMoRM=;
        b=fxOgdiOkFWGCkoLOtPtcXVDtlpTcnTpCMhm+ppsqtRoKVAK5KfgZPkmQHwxDlW9s4zA83N
        7amq1wajVrwboXAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60F6B13357;
        Mon, 24 Oct 2022 14:01:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8LiVFrOaVmNcEQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 24 Oct 2022 14:01:23 +0000
Date:   Mon, 24 Oct 2022 16:01:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        Viktor Kuzmin <kvaster@gmail.com>
Subject: Re: [PATCH] btrfs: btrfs: don't trust sub_stripes from disk
Message-ID: <20221024140110.GC5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221021004403.eAzonZxNBMdAJAaPolyLYWT1R8ItQyLpUcdyy7uAquQ@z>
 <7550a460-a620-24e4-0e14-24078bf5eb63@oracle.com>
 <796812df-c849-ca04-a0e3-846478563f9e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <796812df-c849-ca04-a0e3-846478563f9e@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 21, 2022 at 04:26:24PM +0800, Qu Wenruo wrote:
> >> -    map->sub_stripes = btrfs_chunk_sub_stripes(leaf, chunk);
> >> +    /*
> >> +     * Don't trust the sub_stripes value, as for profiles other
> >> +     * than RAID10, they may have 0 as sub_stripes for older mkfs.
> >> +     * In that case, it can cause divide-by-zero errors later.
> >> +     * Since currently sub_stripes is fixed for each profile, let's
> >> +     * use the trusted value instead.
> >> +     */
> >> +    map->sub_stripes = btrfs_raid_array[index].sub_stripes;
> >
> > It is a potential security threat, we have to fix this in the kernel.
> > However, the code is doing correct to read from the disk instead of
> > setting it to the expected value. So if the read sub_stripes is
> > incorrect, why not return EUCLEAN so that the user will upgrade the
> > btrfs-progs to fix the mkfs instead.
> 
> Or we will reject all older fses and cause compatibility problems.
> 
> And you're asking users to mkfs to "fix" some fses which can be safely
> mounted just by older kernels?
> 
> That's not a fix, but a completely data wipe.

Yeah we can't suggest to use mkfs as a fix but can we at least rewrite
the items with the correct value at some occasion. Eventually we can add
a rescue subcommand.
