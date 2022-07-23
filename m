Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D222B57F11C
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Jul 2022 21:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiGWTK0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jul 2022 15:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiGWTKZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jul 2022 15:10:25 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFF111C2C
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Jul 2022 12:10:20 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 165A8580A2E;
        Sat, 23 Jul 2022 15:10:20 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Sat, 23 Jul 2022 15:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1658603420; x=
        1658607020; bh=GR5lz9+0EzNCRSKrIjMIOuawNr5NEkV6gNpX4M1OoCs=; b=L
        oYojk+s5cmY8CKAB+TKCNIjLX39bK4FQ1kVWCqEkH4Bsn4t1N6PMObChb2vBYlJT
        n1h9rtro7fUzRvNtyLI3XOYl2eaFBYdW6w4QiKLoXbMsYbPMEiIng+x5DrKl7DCV
        k0IfAn2J5FML1RafoMcK8xvD+H1fqPc8dkiGF9A9URPAhA+rR832kezvZZqgLqUu
        Maek2YUAVyLEl9E7a/of1kzehCIr1saVOC8QMtyWNFnKp2swm35C05krXa0ZwFGn
        XMnevLlEU9lV1AePbilvtE8UOM80oOvmMGeLk0gVBuM/uRTjoqXQwIKXlzx60iIv
        IheCBB270kKkaTh0vP0Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        i06494636.fm3; t=1658603420; x=1658607020; bh=GR5lz9+0EzNCRSKrIj
        MIOuawNr5NEkV6gNpX4M1OoCs=; b=v3F40jpv/50IbRzAwGOvhVw41DUBEPY/cw
        6HSYMGzTELXXUulwytB/aL/kbDHXhdIw4Of5NyptFCiANrNvmVCXHE2auyWilH4M
        rnGt8Ga+t51b04mw/7Fy2KUlYjNlP5/8SQ5MNUk0JZIR/h+tF/saS2vgLJg6RiTj
        BMWqnanWaBkHXVGjRZUTD+RyTMfZs8s5oimsoVCe6PiYGbUB3ApE6JDwjEqtr59j
        4u2e1DN4KFi412QkTNQ4aoW495KFmDK4QhphsEPtvvkS3UqKcBLmqLU+B0uRfusy
        zU/bkmOaDFkiFVadNkWmDG+WPqTpd6GBsuwoIrSnkmUIpCqAZgfw==
X-ME-Sender: <xms:m0fcYtS6IWYirrCOB5klF6f2BGcHKy5xRMKjoybiedCkpotUiWWvAw>
    <xme:m0fcYmwgnSWqUiJKeIOeQCQVZuOQEu4rLmdZuMawKblmXAZLRnVI4tvs2cdhS50wk
    j-_LRPz0E4Rqhx50ws>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddtgedgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdev
    hhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtg
    homheqnecuggftrfgrthhtvghrnhepieduueejkeelveeijeetteegkeekfeffuefhueev
    vdejveffudfhleegtdfhjeefnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlihhsthhssegt
    ohhlohhrrhgvmhgvughivghsrdgtohhm
X-ME-Proxy: <xmx:m0fcYi0u-LFl6TyI7gPvS3KPKZFglRZ7l16cNYky-pfVawWFRmh-MA>
    <xmx:m0fcYlCDh5y9N6KpH2B-hhPV-JoIje9-F0SfO-FkygBlhMcNPNzMDA>
    <xmx:m0fcYmiNsA8U093EbDrFqCEdWpXfro8r3Wrbcv-kksOOHypfEA90hQ>
    <xmx:m0fcYpvfaHIqU92t0AqQjZVemOBvTwkyzSmrQXlacDv7W_ghpEaeqwtOKaA>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B3596170007E; Sat, 23 Jul 2022 15:10:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-757-gc3ad9c75d3-fm-20220722.001-gc3ad9c75
Mime-Version: 1.0
Message-Id: <79adde9b-0ef6-4845-ab5a-c10a3563c3de@www.fastmail.com>
In-Reply-To: <t77bub$vp5$1@ciao.gmane.io>
References: <9bdd0eb6-4a4f-e168-0fb0-77f4d753ec19@gmail.com>
 <YfHCLhpkS+t8a8CG@zen> <4263e65e-f585-e7f6-b1aa-04885c0ed662@gmail.com>
 <YfHXFfHMeqx4MowJ@zen>
 <CAJCQCtR5ngU8oF6apChzBgFgX1W-9CVcF9kjvgStbkcAq_TsHQ@mail.gmail.com>
 <042e75ab-ded2-009a-d9fc-95887c26d4d2@libero.it>
 <CAJCQCtQv327wHwsT+j+mq3Fvt2fJwyC7SqFcj_+Ph80OuLKTAw@mail.gmail.com>
 <295c62ca-1864-270f-c1b1-3e5cb8fc58dd@inwind.it>
 <367f0891-f286-198b-617c-279dc61a2c3b@colin.guthr.ie>
 <CAEg-Je9rr4Y7JQbD3iO1UqMy48j7feAXFFeaqpJc6eP7FSduEw@mail.gmail.com>
 <t752jd$pjm$1@ciao.gmane.io> <24613105-faa7-8b0d-5d55-53d01a7c1172@libero.it>
 <t77bub$vp5$1@ciao.gmane.io>
Date:   Sat, 23 Jul 2022 15:09:59 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Colin Guthrie" <gmane@colin.guthr.ie>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Cc:     "systemd List" <systemd-devel@lists.freedesktop.org>,
        "Goffredo Baroncelli" <kreijack@libero.it>,
        "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>
Subject: Re: No space left errors on shutdown with systemd-homed /home dir
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[sorry had to resend to get it on btrfs list, due to html in the original :\]

On Wed, Jun 1, 2022, at 5:36 AM, Colin Guthrie wrote:
> Goffredo Baroncelli wrote on 31/05/2022 19:12:
> 
> > I suppose that colin.home is a sparse file, so even it has a length of 
> > 394GB, it consumes only 184GB. So to me these are valid values. It 
> > doesn't matter the length of the files. What does matter is the value 
> > returned by "du -sh".
> > 
> > Below I create a file with a length of 1000GB. However being a sparse 
> > file, it doesn't consume any space and "du -sh" returns 0
> > 
> > $ truncate -s 1000GB foo
> > $ du -sh foo
> > 0    foo
> > $ ls -l foo
> > -rw-r--r-- 1 ghigo ghigo 1000000000000 May 31 19:29 foo
> 
> Yeah the file will be sparse.
> 
> That's not really an issue, I'm not worried about the fact it's not 
> consuming as much as it reports as that's all expected.
> 
> The issue is that systemd-homed (or btrfs's fallocate) can't handle this 
> situation and that user is effectively bricked unless migrated to a host 
> with more storage space!

Hopefully there's time for systemd-252 for a change still? That version is what I expect to ship in Fedora 37 [1] There's merit to sd-homed and I want it to be safe and reliable for users to keep using, in order to build momentum. 

I really think sd-homed must move the shrink on logout, to login.

When the user logs out, they are decently likely to immediately close the laptop lid thus suspend-to-ram; or shutdown. I don't know if shrink can be cancelled. But regardless, there's going to be a period of time where the file system and storage stacks are busy, right at the time the user is expecting *imminent* suspend or shutdown, which no matter what has to be inhibited until the shrink is cancelled or completed, and all pending writes are flushed to stable media.

Next, consider the low battery situation. Upon notification, anyone with an 18+ month old battery knows there may be no additional warnings, and you could in fact get a power failure next. In this scenario we have to depend on all storage stack layers, and the drive firmware, doing the exact correct thing in order for the file system to be in a consistent state to be mountable at next boot. I just think this is too much risk, and since sd-homed is targeted at laptop users primarily, all the more reason the fs resize operation should happen at login time, not logout.

In fact, sd-homed might want to inhibit a resize shrink operation if (a) AC power is not plugged in and (b) battery remaining is less than 30%, or some other reasonable value. The resize grow operation is sufficiently cheap and fast that I don't think it needs inhibiting.

Thoughts?

I also just found a few bug reports with a non-exhaustive search that also make me nervous about fs shrink at logout (also implying restart and shutdown) time.

On shutdown, homed resizes until it gets killed
https://github.com/systemd/systemd/issues/22901
Getting "New partition doesn't fit into backing storage, refusing"
https://github.com/systemd/systemd/issues/22255
fails to resize 
https://github.com/systemd/systemd/issues/22124



[1]
Branch from Rawhide August 9, the earliest release date would be October 18.



--
Chris Murphy
