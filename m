Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B059C57F128
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Jul 2022 21:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbiGWT0i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jul 2022 15:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiGWT0g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jul 2022 15:26:36 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F5813D66
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Jul 2022 12:26:35 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id DA982580995;
        Sat, 23 Jul 2022 15:26:34 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Sat, 23 Jul 2022 15:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1658604394; x=
        1658607994; bh=lQBTQN0LivR3KR7+m26xL0L9xIO/4ipIglRlP8mZ8VA=; b=V
        qrYS//iGclp/7EIKHp+8Lz0ba5h4W2TCiIoSZu/WiszXEslZ9k4WpJGjO25ELmXP
        hkbb1N/WW52XTEXAYqdx0wpl/UQV6/vr06hEGnasgUW6xPPUkM6RxRWpqclK29Ra
        ome/CEfp3yacThtAiFSrWpEd1TleIcC5/tx/9HEgbF9AxKI2Eiazx/P5EUBumgLX
        FMmP+AbYwXXc21YnIYxdV3vJ8V6/Xf9Z4/oTFzvm7CpI4JKmDzC76o9Nw2GjqyME
        Frb0WmJOBoqgoxhoi327wcsgzdyLblf7gf0x4dslm8ZYwiGMaIulOU1z3HoKfWYH
        1VRNpAQUf/25wLDLXgPGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        i06494636.fm3; t=1658604394; x=1658607994; bh=lQBTQN0LivR3KR7+m2
        6xL0L9xIO/4ipIglRlP8mZ8VA=; b=ihMPMIWUuWGBIk2eFoipYHIKE6iJnSL2CN
        BShhwYP1se9A+WVVKzFvN/i4BJpdotuBr/VlATBGLzhmfQ9ogjg9IjfyNNB08VjY
        UXozu9AXN+tp98xNomDa9r8w9v6G3eFEXhBbiqJgeiH62Lfx/PxzXQmBaeP+VmLa
        F3mQDt363GtWuYoJjR77AXclMH4rbbHv7Sb3NRjMK1qGsYGEz4ri2fRCjpukbS9B
        0PjsDkMDAmfhbaEEaTGrWGI2zR1AhjP8VfGm2ckVmlADHVYpekLgMDDVqSzC2M6p
        SMfE1nb0EkVS2PFvN4lXCZCgi2/0GpQqids3bt7znVcPvT/NUm9Q==
X-ME-Sender: <xms:akvcYkM0Y_rhC8c7k6W4Q8MYJREnNG4MzB1u6IYltB4IkZkC4a1Ejg>
    <xme:akvcYq-O60zJ9xUDloZ8clQipjE3PC_k54-8hL8chrplDO5LuSUKujidnMA-ctHG_
    FkTOGkjZjlzp1r8uxo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddtgedgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdev
    hhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtg
    homheqnecuggftrfgrthhtvghrnhepgfdvueektdefgfefgfdtleffvdeileetgfefuddt
    ffelueeiveeiveekhedtheeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:akvcYrRSMaWM56A7wXdI73q_h-bjzmpS72EtFl_Kzgr1xCQ_ED-4Yg>
    <xmx:akvcYstaIUFpB35gwXt1TPFEmgBsmlrY2qiftqMV292qZftWTpyUtg>
    <xmx:akvcYsfOLaxl2lofDP44wSKvfBoELaWngUYNKiv9ilFGaCzxhqMbKg>
    <xmx:akvcYk4LsZHhYdG-unZDnKpVkindhSWImYU0Xga52KncT5iqOhUDb6qtEoE>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6CE191700082; Sat, 23 Jul 2022 15:26:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-757-gc3ad9c75d3-fm-20220722.001-gc3ad9c75
Mime-Version: 1.0
Message-Id: <e5bcf7ed-fdbe-40b1-bec9-e20daedfe822@www.fastmail.com>
In-Reply-To: <Yfi2gVf5QOXkaM6+@hungrycats.org>
References: <9bdd0eb6-4a4f-e168-0fb0-77f4d753ec19@gmail.com>
 <YfHCLhpkS+t8a8CG@zen> <4263e65e-f585-e7f6-b1aa-04885c0ed662@gmail.com>
 <YfHXFfHMeqx4MowJ@zen>
 <CAJCQCtR5ngU8oF6apChzBgFgX1W-9CVcF9kjvgStbkcAq_TsHQ@mail.gmail.com>
 <042e75ab-ded2-009a-d9fc-95887c26d4d2@libero.it>
 <Yfi2gVf5QOXkaM6+@hungrycats.org>
Date:   Sat, 23 Jul 2022 15:26:13 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>,
        "Goffredo Baroncelli" <kreijack@inwind.it>
Cc:     "Boris Burkov" <boris@bur.io>, "Apostolos B." <barz621@gmail.com>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
        "systemd List" <systemd-devel@lists.freedesktop.org>
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

On Mon, Jan 31, 2022, at 11:26 PM, Zygo Blaxell wrote:
> On Sat, Jan 29, 2022 at 10:53:00AM +0100, Goffredo Baroncelli wrote:

> It does suck that the kernel handles resizing below the minimum size of
> the filesystem so badly; however, even if it rejected the resize request
> cleanly with an error, it's not necessarily a good idea to attempt it.
> Pushing the lower limits of what is possible in resize to save a handful
> of GB is asking for trouble.  It's far better to overestimate generously
> than to underestimate the minimum size.

Yeah there's an inherent conflict with online shrink: the longer the time needed to relocate bg's, the more unpredictable operations can occur during that time to thwart any original estimations made about the shrink operation.

I wondered a bit ago about a shrink API that takes shrink size as a suggestion rather than as a definite, and then the file system does the best job it can. Either this API reports actual shrink size once it completes, or the requesting program needs to know to call BTRFS_IOC_FS_INFO and BTRFS_IOC_DEV_INFO to know the actual size. This hypothetical API could have boundaries outside of which if the kernel code estimates it's going to fall short of, could trigger a cancel of the shrink. This could be size or time based.  e.g. BTRFS_IOC_RESIZE_BEST (effort).


-- 
Chris Murphy
