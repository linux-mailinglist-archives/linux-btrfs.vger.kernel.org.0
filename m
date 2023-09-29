Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C382C7B3831
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 18:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjI2Q4e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Sep 2023 12:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjI2Q4d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Sep 2023 12:56:33 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D641A7;
        Fri, 29 Sep 2023 09:56:31 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 65706320090B;
        Fri, 29 Sep 2023 12:56:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 29 Sep 2023 12:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1696006589; x=1696092989; bh=+GIWqGH8Ehk99ol7oAMTaD7fm9Ab4Liu/A1
        iq2HxPIY=; b=bHZCVfFhmb/UBApyMMdUkoBLSONFZXsMDpTGtmQCvDVi2wUgCVo
        g2wnenzjWqJ2Ky+iLAfKCNpjoTmY131PdEyK9YjSa4WjqTIqHtEH/a//bSuGM1TM
        r4H4M5aaMy/VJ1HBvwGwTpN0N1JhHlSIJJRw6qhM6Bjw+yiOTnQBEXFGmzEtAtp+
        BD0sVHMTVQ/bX6hzK/SjmhjzZWrQJ4foFDS1GQmpAEfYRSiDMmqpOOP0aZT8hseA
        ZeHx5fT1jplwHQBXogOY9P4FlvAjFrZcPXFymSFW7aFtzhp7z5/2uXgC7ZF2pr7S
        39GdkGReeGIWluQvT2BQpfc2mCeIetUnO+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696006589; x=1696092989; bh=+GIWqGH8Ehk99ol7oAMTaD7fm9Ab4Liu/A1
        iq2HxPIY=; b=RUtOFBrMcoIIARMMUwlJHKKaETln9lQKTB17pFy9Wf1g8c/8RcE
        iTrts7fKeR8x1w8wdsDaGW/AcxKDSIgapzUqsGGQdLel9t/NqiBxGXlso97o2voB
        RGcsXtmpCpetrK5ymfLF2TsAYl7vMoZGOKMPXS1RjWeBcvFtIpmVoEkckK5pu32E
        vXUIgamljNHkCMJ+PyVaMkvbjSlW5KiI+dDf5w4ccyxxAnwxgSaPM0sm9ckpCpeM
        bW0VqPL2BogMCnlqBFFUicbRRQadhUnHWrqXT7G/5nA1EqHHJWY2s5zt6uZa10GM
        G6R+lITAwgavKP87on+dEebvfV5x0HivSeg==
X-ME-Sender: <xms:vAEXZQ4BlSsbMglZPjNOgVEjCZb9cMUCg_XEOt2tTFKAfuWRrarAWg>
    <xme:vAEXZR4jQtLt9EAEcCot8vzMhFiGSSv5wzss1AfnloAvJsPnYlfWdtFvEfi6oI7oW
    aSh7W1JjBqsuaet5os>
X-ME-Received: <xmr:vAEXZfc_vky9qaV8i7E4a2-4cx4kJ2O66MPCEklImIjeyreXcdK3ih7NEdH0CRN4mnNCTLFp7ijXokJuZL44U2GpQFY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddvgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epgeelheehjeegudfhteetleehieffgefhjefftefhheekleeujedtkeeugeetfffhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:vAEXZVKSEAkKXwnTKrBt7-A_7-q6yPeSpSjMFEhV5aIBflMlIC4QBw>
    <xmx:vAEXZUK9X_u4BcP0YIpXM9SUPH-yNPdkuCzmwH-W9noV39TZCe_NRg>
    <xmx:vAEXZWx9i0Fd3ocO9pg5n8vRTjqfVWsA16Owry1ZAVKEaKUjsT8E2g>
    <xmx:vQEXZbVwOPN07p6PyxNu73Fax1Uvntz2NXOaj-JB-3qPgD9PrxH9nw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Sep 2023 12:56:28 -0400 (EDT)
Date:   Fri, 29 Sep 2023 09:57:25 -0700
From:   Boris Burkov <boris@bur.io>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH v4 6/6] btrfs: skip squota incompatible tests
Message-ID: <20230929165725.GA2502493@zen.localdomain>
References: <cover.1695942727.git.boris@bur.io>
 <32ac4b162efb7356eb02398446f9cc082344436f.1695942727.git.boris@bur.io>
 <ea2c732f-68be-74b1-f05e-218ebaa2b359@oracle.com>
 <9d06f5aa-9124-d3ed-5585-0c42988e155c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d06f5aa-9124-d3ed-5585-0c42988e155c@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Oh, interesting. I am using BTRFS_UTIL_PROG to run a relatively new
local-built progs in my test setup and it looks like that only prints
the quota rescan message with -v passed in, while my system default
btrfs prints it without -v. I'll make sure the test passes with that
BTRFS_UTIL_PROG as well.

Thanks for the catch and all the other review!

Just to make sure, you would like this last fix as a separate patch or
should I resend?
