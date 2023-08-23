Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E6678524F
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 10:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjHWIIn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 04:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbjHWIHS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 04:07:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE73E10C1;
        Wed, 23 Aug 2023 01:07:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C26B61E42;
        Wed, 23 Aug 2023 08:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9023C433C7;
        Wed, 23 Aug 2023 08:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692778027;
        bh=ocvn8Jdq/UOs5jNQv4Ay957kqOG94u0DsOaH+OaRMkI=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=MlyzVah4mXSmLPtBTklk82u8ywRVMj0dsVogBdW9jklc+LoEdZKrqdJT3AzPvms2L
         mvIEjCaqKuiYoA4uZ1mOQsyZdkKojp1zwxsfJY+mLj373y+SdW+i7HtB8efg2DfmyU
         akDsyBI2Gt80Kd3xTA+VWHXYQ7FG1PdlPlQVS0nuOl/j3Tu5+33Wg5lkKuq9p+Bwe4
         Cs0huIcBHIYddDQdmCgFtX8WAnp5i7HvtcFS5bowPPdlgWHh16BCgk6VSp6wui/gaK
         RFFcTuF6cwCf50/1M/091JNr1BA3las7L7ehHfbj7EQrydJ96HxHtQFMv+/hgs0ZOW
         H1CHW4PoLpu0A==
Date:   Wed, 23 Aug 2023 09:07:02 +0100
From:   Lee Jones <lee@kernel.org>
To:     dsterba@suse.cz, Jia-Ju Bai <baijiaju1990@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: btrfs: fix possible use-after-free bug in error
 handling code of btrfs_get_root_ref()
Message-ID: <20230823080702.GA2472023@google.com>
References: <20220324134454.15192-1-baijiaju1990@gmail.com>
 <20220324181940.GK2237@suse.cz>
 <84720b1d-831e-4a2e-e2c5-4f20ac7bb778@gmail.com>
 <20220401155456.GL15609@twin.jikos.cz>
 <20230823080044.GA2468513@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230823080044.GA2468513@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 23 Aug 2023, Lee Jones wrote:

> On Fri, 01 Apr 2022, David Sterba wrote:
> 
> > On Fri, Mar 25, 2022 at 04:04:17PM +0800, Jia-Ju Bai wrote:
> > > >> @@ -1850,9 +1850,10 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
> > > >>   
> > > >>   	ret = btrfs_insert_fs_root(fs_info, root);
> > > >>   	if (ret) {
> > > >> -		btrfs_put_root(root);
> > > >> -		if (ret == -EEXIST)
> > > >> +		if (ret == -EEXIST) {
> > > >> +			btrfs_put_root(root);
> > > > I think this fix is correct, though it's not that clear. If you look how
> > > > the code changed, there was the unconditional put and then followed by a
> > > > free:
> > > >
> > > > 8c38938c7bb0 ("btrfs: move the root freeing stuff into btrfs_put_root")
> > > >
> > > > Here it's putting twice where one will be the final free.
> > > >
> > > > And then the whole refcounting gets updated in
> > > >
> > > > 4785e24fa5d2 ("btrfs: don't take an extra root ref at allocation time")
> > > >
> > > > which could be removing the wrong put, I'm not yet sure.
> > > 
> > > Thanks for the reply!
> > > 
> > > I think the bug should be introduced by this commit:
> > > bc44d7c4b2b1 ("btrfs: push btrfs_grab_fs_root into btrfs_get_fs_root")
> > > 
> > > This commit has a change:
> > >       ret = btrfs_insert_fs_root(fs_info, root);
> > >       if (ret) {
> > > +      btrfs_put_fs_root(root);
> > >           if (ret == -EEXIST) {
> > >               btrfs_free_fs_root(root);
> > >               goto again;
> > >           }
> > > 
> > > I could add a Fixes tag of this commit in my V2 patch.
> > > Is it okay?
> > 
> > I can add it myself, that's a minor thing. The fix is correct, I've
> > rewritten the changelog a bit, patch now added to misc-next, thanks.
> 
> Where is 'misc-next' please?

Nevermind.  I've just seen a) how old this thread is and b) the commit
subject was changed and subsequently committed as:

168a2f776b976 ("btrfs: fix root ref counts in error handling in btrfs_get_root_ref")

-- 
Lee Jones [李琼斯]
