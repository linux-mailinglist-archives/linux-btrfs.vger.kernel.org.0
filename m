Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6847B38F6
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 19:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjI2R2r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Sep 2023 13:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbjI2R2i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Sep 2023 13:28:38 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFFF1717;
        Fri, 29 Sep 2023 10:27:55 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id B1C973200928;
        Fri, 29 Sep 2023 13:27:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 29 Sep 2023 13:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1696008474; x=1696094874; bh=uS8JFJ/XpQz06joJ7k+5B7Yse8CXE4zRSsW
        PHmChqEY=; b=ioAd3gozdDr6vUm2jIhRJUVZBKE53ItjpqKiUM/qmiRMBcbcoSp
        ndz7VqO+bz3C9wkLbBYznl4uHCLcVvygKnRZL6vZswYptRI4C2/G7+QOT2ivSAFc
        uTDhBUwwpthULQxjAdzTppUzSwLkU+jK62hSACj+TsJMHtbcZjxmhoVNTblCh1Nm
        /Dh2HXr8KM800muXyRd69EMIjmxbtQz0s1YmkmzNy/x+9Xms51r25Eu7T3v0ADgE
        LK/ytUKxXWKv0cfutdBVfErkd2FmUHAmCe90aV0kS7SGgRUDIlQWIhfHCEJr9rqG
        oiG1w0ZM5aXAwRdLwajBfsmgTohfaA1V6Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696008474; x=1696094874; bh=uS8JFJ/XpQz06joJ7k+5B7Yse8CXE4zRSsW
        PHmChqEY=; b=ZPbWTV6jMOzi5fGuHdK2parRl7eQp92sXgIAEPbK11RVom2/YPs
        A2E9d6Z6S+HmIQ0799+wBmCCtIPInq7Inl355ZxOkbL4HQOLwNHMY6oBKOPQ2ZFK
        WTyqyROUuSnn/Ov7gwYy/XEWqH06zvpDDlswtzNA44lL1PEOFdokOvwjoXOxjTI3
        16ghVeKUe9qRBwgDe4pYrZnhVIHg9cI/oZfVop/ivjHgUrF/HPHVPQ7uWDSJSphe
        RpeLfZUOpunYa30lIm4ipE9I55ufbl1TOsdNNM2oyDyNU2m16KhTeaqwYjzhXsEJ
        mNkeNId0PcudIeDEkd+tq3moWxO4sIDZAvg==
X-ME-Sender: <xms:GQkXZYjAChYRTS0Tf8NSrU2z-YgIImPe3hRo2dCoPjeBlOSdInSpjQ>
    <xme:GQkXZRBG5MDk3849FHWb65lMfj5DWScevy0s-R9bH-vMpAElmMO0yy7ei81mhRNWj
    rHoCx3t0gR-TQlHMjk>
X-ME-Received: <xmr:GQkXZQGNRKZHPYwD1gGx0cCqaxxxURSebxKF3QcaVN6brS8w81np4oWlIWMxaVo_4f43T7wXj3pWu5uJ4HFkvTocw50>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddvgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epgeelheehjeegudfhteetleehieffgefhjefftefhheekleeujedtkeeugeetfffhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:GgkXZZRbroEdR4SoD11qNMc1q2Lhv8i7P-3uBAdz6k0L2fQrbj3fwA>
    <xmx:GgkXZVy6N94MDiZm32RvnapODIcjOW-ND2f-miQLWMUOh2t8w0-ulw>
    <xmx:GgkXZX6d38QlEyB_-phYji_uixPFojxNq-TdWfON-prKhUYPa0vqBw>
    <xmx:GgkXZQ83BRK2NfX6tUxtovg4CJ1ZRoiJJYIqAso3WAnLEbCKu5k0WA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Sep 2023 13:27:53 -0400 (EDT)
Date:   Fri, 29 Sep 2023 10:28:50 -0700
From:   Boris Burkov <boris@bur.io>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH v4 6/6] btrfs: skip squota incompatible tests
Message-ID: <20230929172850.GA2503006@zen.localdomain>
References: <cover.1695942727.git.boris@bur.io>
 <32ac4b162efb7356eb02398446f9cc082344436f.1695942727.git.boris@bur.io>
 <ea2c732f-68be-74b1-f05e-218ebaa2b359@oracle.com>
 <9d06f5aa-9124-d3ed-5585-0c42988e155c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d06f5aa-9124-d3ed-5585-0c42988e155c@oracle.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 29, 2023 at 05:42:03PM +0800, Anand Jain wrote:
> On 29/09/2023 17:37, Anand Jain wrote:
> > 
> > > diff --git a/tests/btrfs/057 b/tests/btrfs/057
> > > index 782d854a0..e932a6572 100755
> > > --- a/tests/btrfs/057
> > > +++ b/tests/btrfs/057
> > > @@ -15,6 +15,7 @@ _begin_fstest auto quick
> > >   # real QA test starts here
> > >   _supported_fs btrfs
> > >   _require_scratch
> > > +_require_qgroup_rescan
> > >   _scratch_mkfs_sized $((1024 * 1024 * 1024)) >> $seqres.full 2>&1
> > 
> > It appears that there is an issue with rescan's stdout and stderr ,
> > causing the failure. Please consider sending a fixup which apply
> > on top of this.
> > 
> > 
> > btrfs/057 4s ... - output mismatch (see
> > /xfstests-dev/results//btrfs/057.out.bad)
> >      --- tests/btrfs/057.out    2023-02-20 12:32:31.399005973 +0800
> >      +++ /xfstests-dev/results//btrfs/057.out.bad    2023-09-29
> > 17:31:24.462334654 +0800
> >      @@ -1,2 +1,3 @@
> >       QA output created by 057
> >      +quota rescan started
> >       Silence is golden
> >      ...
> >      (Run 'diff -u /xfstests-dev/tests/btrfs/057.out
> > /xfstests-dev/results//btrfs/057.out.bad'  to see the entire diff)
> > 
> > Thanks, Anand
> 
> And btrfs/022 as well.
> 
> btrfs/022 3s ... - output mismatch (see
> /xfstests-dev/results//btrfs/022.out.bad)
>     --- tests/btrfs/022.out	2023-02-20 12:32:31.394980330 +0800
>     +++ /xfstests-dev/results//btrfs/022.out.bad	2023-09-29
> 17:41:18.393742664 +0800
>     @@ -1,2 +1,3 @@
>      QA output created by 022
>     +quota rescan started
>      Silence is golden
>     ...
>     (Run 'diff -u /xfstests-dev/tests/btrfs/022.out
> /xfstests-dev/results//btrfs/022.out.bad'  to see the entire diff)
> 
> 
> 
Actually, my previous analysis about btrfs-progs was incorrect, the
issue is more subtle, and has to do with the behavior of rescan -w.

TL;DR: btrfs-progs is racily swallowing that output so my setup happens
to not see it. We want to redirect it to fix it.

More detail:
In the new require_qgroup_rescan helper, we call quota rescan -w right
after quota enable, which will also trigger a rescan. That rescan -w can
hit EINPROGRESS which causes it to 1. not print "quota rescan started"
and 2. since wait_for_completion=true, it swallows that particular error
and issues the rescan wait ioctl which succeeds. Based on the doc, I am
assuming that is the intentional behavior of the util, so we need to
handle the variable output in fstests. The other rescan callers use the
checked helper, which redirects the output, but since this callsite
wants _notrun instead of _fail, it doesn't redirect, so if we race in
the way that actually starts a new rescan, we get the message.
