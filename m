Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58107651E8D
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Dec 2022 11:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbiLTKOF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Dec 2022 05:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbiLTKNy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Dec 2022 05:13:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9F764D2;
        Tue, 20 Dec 2022 02:13:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06F3E61303;
        Tue, 20 Dec 2022 10:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784C6C433D2;
        Tue, 20 Dec 2022 10:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671531231;
        bh=N3VbeltI1tdEoSrh6WhLPmdICK9vrK+OvOP2oUzz21c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OUnkRGmIJmAISk6E2KK2TtOE/baOy7wjP0ruYnMdxs2OPqL/pkQp0fjDN9MHRi43H
         f9VzG1Bh8nKTYDO/MLipJ3j5jmGxcBNIj3mCMsOnp0RTWz9W/E5rcAw3z5cRehpYVn
         4TUhkdSSV1N5RCW959jbFBWbUek01b6eZnlUnoQRL9YjsOxewMfaveIn2luQKXk8Wv
         maN2yDNC7BODfUqQez8xZUD4U2atzcbAO9x6LGokRIz+tXrOOm345qI9xP0vfsBUPO
         pgiNGpUEQG4rz8cuxI341ufWercMos0JZZGitbUbxRZBXoa5gpSsDKgD+vRu2PDwsS
         VamJFyUOGUgkw==
Date:   Tue, 20 Dec 2022 18:13:47 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] fstests: skip btrfs/253 for zoned devices
Message-ID: <20221220101347.6fpruzp2i6yg72wy@zlang-mailbox>
References: <20221128122952.51680-1-johannes.thumshirn@wdc.com>
 <c682ddaf-44c9-ba98-933b-9e0cfdcf7bfe@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c682ddaf-44c9-ba98-933b-9e0cfdcf7bfe@wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 20, 2022 at 09:19:06AM +0000, Johannes Thumshirn wrote:
> On 28.11.22 13:30, Johannes Thumshirn wrote:
> > The test-case btrfs/253 tests btrfs' chunk size setting, which is not
> > available on zoned btrfs, so the test will always fail.
> > 
> > Skip the test in case of a zoned device.
> > 
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > ---
> >  tests/btrfs/253 | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tests/btrfs/253 b/tests/btrfs/253
> > index fbbb81fae754..99eaee1e7cde 100755
> > --- a/tests/btrfs/253
> > +++ b/tests/btrfs/253
> > @@ -81,6 +81,7 @@ alloc_size() {
> >  _supported_fs btrfs
> >  _require_test
> >  _require_scratch
> > +_require_non_zoned_device "${SCRATCH_DEV}"
> >  
> >  # Delete log file if it exists.
> >  rm -f "${seqres}.full"
> 
> Ping?

Do I misunderstand something? I think this issue has been fixed long time
ago, by:

commit 2925f3b7f7738f85aabef4e8fe02f257fce0b786
Author: Naohiro Aota <naohiro.aota@wdc.com>
Date:   Tue Jul 26 16:57:59 2022 +0900

    btrfs/253: skip on zoned mode as we cannot change the chunk size

Which xfstests version do you use? Do you still hit any problems?

Thanks,
Zorro
