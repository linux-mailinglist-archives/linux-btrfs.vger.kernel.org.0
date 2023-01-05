Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D992665F043
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jan 2023 16:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbjAEPlX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Jan 2023 10:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjAEPlV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Jan 2023 10:41:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450034FD53;
        Thu,  5 Jan 2023 07:41:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D54E561B03;
        Thu,  5 Jan 2023 15:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E89AC433D2;
        Thu,  5 Jan 2023 15:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672933280;
        bh=HMw6d5DaD8oLSna6K7FKbXLZjsmjbQLLfWBhAkYmJ7w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PSWLh1x7NJlEJ3DCbCtV2eCYcuROG9GFlmEot0Ks5VwkcNKzADaNxZWEJhmBhYSVB
         cAOipZlX0wIE7QrhhAkK4q+qaUCEDFvWlIQsmsr7cQn2yPx3QXAznwsPelP566/Gwc
         OG0z20SOv1fHl+aj1ICbfjpFmhvZJAuDlB9WG3hHN+6gkiGh3/SDVEDKltPr7Kiqnx
         iKvZZWMIbCCr7hB6BlL5gLD2hcwey9EKTL6jsWB7QfluMwPz3zDs393vIP9lRpUxxD
         Z58DZ8yk/wUb3HUSEU8mfzGWk4TERdnUx7iqPf/ECds0DaYcfW/CkYJWT4c/Roxn+r
         3AvECw0nbpAuw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CEDB15C029A; Thu,  5 Jan 2023 07:41:19 -0800 (PST)
Date:   Thu, 5 Jan 2023 07:41:19 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH rcu 18/27] fs/btrfs: Remove "select SRCU"
Message-ID: <20230105154119.GT4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-18-paulmck@kernel.org>
 <ba9a15cd-5d95-d766-19a7-17e0925bc63c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba9a15cd-5d95-d766-19a7-17e0925bc63c@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 05, 2023 at 05:06:09PM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/1/5 08:38, Paul E. McKenney wrote:
> > Now that the SRCU Kconfig option is unconditionally selected, there is
> > no longer any point in selecting it.  Therefore, remove the "select SRCU"
> > Kconfig statements.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Chris Mason <clm@fb.com>
> > Cc: Josef Bacik <josef@toxicpanda.com>
> > Cc: David Sterba <dsterba@suse.com>
> > Cc: <linux-btrfs@vger.kernel.org>
> 
> In fact, since commit c75e839414d3 ("btrfs: kill the subvol_srcu"), we can
> completely remove any SRCU related configs and even includes.

$ git grep srcu fs/btrfs/
fs/btrfs/disk-io.h: *   fs_info->subvol_srcu

I know that situation.  ;-)

> Reviewed-by: Qu Wenruo <wqu@suse.com>

Thank you!  I will update on my next rebase.

							Thanx, Paul

> Thanks,
> Qu
> 
> > ---
> >   fs/btrfs/Kconfig | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
> > index 183e5c4aed348..37b6bab90c835 100644
> > --- a/fs/btrfs/Kconfig
> > +++ b/fs/btrfs/Kconfig
> > @@ -17,7 +17,6 @@ config BTRFS_FS
> >   	select FS_IOMAP
> >   	select RAID6_PQ
> >   	select XOR_BLOCKS
> > -	select SRCU
> >   	depends on PAGE_SIZE_LESS_THAN_256KB
> >   	help
