Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F996D6D45
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Apr 2023 21:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbjDDTjU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Apr 2023 15:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235693AbjDDTjT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Apr 2023 15:39:19 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68042C7
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Apr 2023 12:39:18 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 19AD85C0233;
        Tue,  4 Apr 2023 15:39:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 04 Apr 2023 15:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680637156; x=1680723556; bh=p5
        2G99CbhqR6i4dan3E3Oigkd5Vn4r2zzm1v+U+cgTg=; b=cpCpIaieTC7t7CQKik
        9YdT4HHmm4+jix9dazRp2Ki275jQSJLnuC+TGVfrBgj3TA2X7u8aF0DmJWv9lbZg
        VVgaWb6reQfLp9ePzALbQ2H6wKtqWwS2geiw/LEX11H41qkot1crNYyBkRsqph+W
        LZe4KhuRRB8Kt+imnlAymRwPUfROTZywbK7GhSTq7c2ykptDsgcDSbGrXyIw575p
        sRiaSKB238wNjIwuAcb6MQgJZgERHVPjbiIn3NwAW4n+/Ii0Azgk9N6uwFOdTyPR
        1lu6KSE4kSzvEFreW4fCEJ6OHzK2aICTa1gWQaMnuR50fKdtKqt5FTS5LCGmSdQd
        hnzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680637156; x=1680723556; bh=p52G99CbhqR6i
        4dan3E3Oigkd5Vn4r2zzm1v+U+cgTg=; b=tfpX6twJdjUUCMEk3/vZoaWoZYzIT
        Q8T+nbQ9qmb8esraRygWfb17XCqSaYkMaq0hhPqNCp0mNDh8l6bjFqTtrlpS0K+w
        UfSBBfbmjsoR/M1JvmLciGk/HXsrs8Gut+OuGcOCLHP0azQUwMg6+sko8ThEdRsg
        R///F5KQ92hWXEdq9MrQKw+RiUzz0B5Tdy9SBseDPfPhvvoDYAtYSMAxc1ThHrrs
        9D4KW6Qp3yArgpKTKb4QVwKFXRtQunk1x7TzR7BnloKuFG6SfOKx5pxI77hgdkSl
        HdiuJEe0VUNF0OVB8gllvhVaTHBDsvit7VO5tYURTpUbh1a/f5mgQ50PA==
X-ME-Sender: <xms:43wsZMDguzZit4Tyo65K9glDMn1KLMcsMvy-PRZ62KDlXGt9NHzpNQ>
    <xme:43wsZOhN4RJyYw7Ho0PG-NJ4oZHL02XRJa21lnRMxMQV8qMYQB7eh8ZJ0egBCUe-G
    rfyBcsDtX23Wfm6EQo>
X-ME-Received: <xmr:43wsZPnzLG9J_D7z0h66uJfnJ2u79I-LEK5dzLtk7TUB8jWWP_6Y04Jt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:43wsZCwDxdW0GfBKO5yyYrF-853ZF6uRyi1dEnrcN-pdw1LwdQjd2w>
    <xmx:43wsZBSmj1blo4e-ABYa5rffAzyclK4cpSEb9izf1PdNaqo_waxoGw>
    <xmx:43wsZNZKtt3UTRSzjl5X2N-JBxd8TcVumOkPXYWL1Pn93hHU70aBtQ>
    <xmx:5HwsZO9GEd57pfc8TWrlskjnAjqOXFCv5ybbOlHRal3nc3yTlUW19w>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Apr 2023 15:39:15 -0400 (EDT)
Date:   Tue, 4 Apr 2023 12:39:09 -0700
From:   Boris Burkov <boris@bur.io>
To:     David Sterba <dsterba@suse.cz>
Cc:     Chris Mason <clm@meta.com>, Christoph Hellwig <hch@infradead.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Sergei Trofimovich <slyich@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Christopher Price <pricechrispy@gmail.com>,
        anand.jain@oracle.com, clm@fb.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [6.2 regression][bisected]discard storm on idle since
 v6.1-rc8-59-g63a7cb130718 discard=async
Message-ID: <20230404193909.GC344341@zen>
References: <CAHmG9huwQcQXvy3HS0OP9bKFxwUa3aQj9MXZCr74emn0U+efqQ@mail.gmail.com>
 <CAEzrpqeOAiYCeHCuU2O8Hg5=xMwW_Suw1sXZtQ=f0f0WWHe9aw@mail.gmail.com>
 <ZBq+ktWm2gZR/sgq@infradead.org>
 <20230323222606.20d10de2@nz>
 <20d85dc4-b6c2-dac1-fdc6-94e44b43692a@leemhuis.info>
 <ZCxKc5ZzP3Np71IC@infradead.org>
 <41141706-2685-1b32-8624-c895a3b219ea@meta.com>
 <20230404185138.GB344341@zen>
 <20230404192205.GF19619@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404192205.GF19619@suse.cz>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 04, 2023 at 09:22:05PM +0200, David Sterba wrote:
> On Tue, Apr 04, 2023 at 11:51:51AM -0700, Boris Burkov wrote:
> > Our reasonable options, as I see them:
> > - back to nodiscard, rely on periodic trims from the OS.
> 
> We had that before and it's a fallback in case we can't fix it but still
> the problem would persist for anyone enabling async discard so it's only
> limiting the impact.
> 
> > - leave low iops_limit, drives stay busy unexpectedly long, conclude that
> >   that's OK, and communicate the tuning/measurement options better.
> 
> This does not sound user friendly, tuning should be possible but not
> required by default. We already have enough other things that users need
> to decide and in this case I don't know if there's enough information to
> even make a good decision upfront.
> 
> > - set a high iops_limit (e.g. 1000) drives will get back to idle faster.
> > - change an unset iops_limit to mean truly unlimited async discard, set
> >   that as the default, and anyone who cares to meter it can set an
> >   iops_limit.
> > 
> > The regression here is in drive idle time due to modest discard getting
> > metered out over minutes rather than dealt with relatively quickly. So
> > I would favor the unlimited async discard mode and will send a patch to
> > that effect which we can discuss.
> 
> Can we do options 3 and 4, i.e. set a high iops so that the batch gets
> processed faster and (4) that there's the manual override to drop the
> limit completely?

Yup, I'm on it.

Chris also had a good idea for a "time since commit" check to further
limit how long async discard would crank for.

This would look something like "go as fast as I'm allowed for 5s after
every transaction". It could lead to a big buildup that requires a
periodic trim to clear.

I'm playing with adding that as an additional tunable which would apply
if set.

Boris
