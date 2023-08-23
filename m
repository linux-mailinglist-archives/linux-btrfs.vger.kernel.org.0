Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FC178522A
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 10:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjHWIAz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 04:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjHWIAw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 04:00:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259121BE;
        Wed, 23 Aug 2023 01:00:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1BFF60E9D;
        Wed, 23 Aug 2023 08:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FDDC433C8;
        Wed, 23 Aug 2023 08:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692777648;
        bh=BhP1GaGS7jhbBecBniz09nP2eW5V3IaxW8OlSITljWE=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=WRzWz8bDCIiFtmGR1o2kp3dASu2sv2SsOYQu4EvN8QcjaaJRow6HcrGr7aCKSnuEa
         57RYY9fAUMnDeCU2WLEnQL26E95uyMkhIxUpvNR591ElIAs8BqgjxoFnE4t/hcRJoD
         4X7OjIXjpHMtg4Zr9lA/DqmI8tsjvdJS3hNcFQrTZW/xRu7mEyYR3wkTD0pnRNuQHn
         JSkbvqzYRQyi1IEY4lgoeLb90Qna3igJq8Qh6aCzwjXgoaOP2ckjbWeqnGlUUCY8iR
         Bugrcrn420bOdiBc1sNJDL5EMqMF9u9qjXKaARSyREaYLbfISRSx4vdJPkofmfjOeT
         Z0BEB61pYnN2g==
Date:   Wed, 23 Aug 2023 09:00:44 +0100
From:   Lee Jones <lee@kernel.org>
To:     dsterba@suse.cz, Jia-Ju Bai <baijiaju1990@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: btrfs: fix possible use-after-free bug in error
 handling code of btrfs_get_root_ref()
Message-ID: <20230823080044.GA2468513@google.com>
References: <20220324134454.15192-1-baijiaju1990@gmail.com>
 <20220324181940.GK2237@suse.cz>
 <84720b1d-831e-4a2e-e2c5-4f20ac7bb778@gmail.com>
 <20220401155456.GL15609@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220401155456.GL15609@twin.jikos.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 01 Apr 2022, David Sterba wrote:

> On Fri, Mar 25, 2022 at 04:04:17PM +0800, Jia-Ju Bai wrote:
> > >> @@ -1850,9 +1850,10 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
> > >>   
> > >>   	ret = btrfs_insert_fs_root(fs_info, root);
> > >>   	if (ret) {
> > >> -		btrfs_put_root(root);
> > >> -		if (ret == -EEXIST)
> > >> +		if (ret == -EEXIST) {
> > >> +			btrfs_put_root(root);
> > > I think this fix is correct, though it's not that clear. If you look how
> > > the code changed, there was the unconditional put and then followed by a
> > > free:
> > >
> > > 8c38938c7bb0 ("btrfs: move the root freeing stuff into btrfs_put_root")
> > >
> > > Here it's putting twice where one will be the final free.
> > >
> > > And then the whole refcounting gets updated in
> > >
> > > 4785e24fa5d2 ("btrfs: don't take an extra root ref at allocation time")
> > >
> > > which could be removing the wrong put, I'm not yet sure.
> > 
> > Thanks for the reply!
> > 
> > I think the bug should be introduced by this commit:
> > bc44d7c4b2b1 ("btrfs: push btrfs_grab_fs_root into btrfs_get_fs_root")
> > 
> > This commit has a change:
> >       ret = btrfs_insert_fs_root(fs_info, root);
> >       if (ret) {
> > +      btrfs_put_fs_root(root);
> >           if (ret == -EEXIST) {
> >               btrfs_free_fs_root(root);
> >               goto again;
> >           }
> > 
> > I could add a Fixes tag of this commit in my V2 patch.
> > Is it okay?
> 
> I can add it myself, that's a minor thing. The fix is correct, I've
> rewritten the changelog a bit, patch now added to misc-next, thanks.

Where is 'misc-next' please?

-- 
Lee Jones [李琼斯]
