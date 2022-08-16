Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60759595E3A
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Aug 2022 16:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbiHPOXI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Aug 2022 10:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiHPOXH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Aug 2022 10:23:07 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFF3B07;
        Tue, 16 Aug 2022 07:23:04 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id BA2D7580255;
        Tue, 16 Aug 2022 10:23:03 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Tue, 16 Aug 2022 10:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660659783; x=
        1660663383; bh=35h149IPL2yT5WUAl/Qc5n5Fyq2ANGh4qJ0KmuoASTI=; b=P
        11/8gmGj7ilZe7zEatFLfVstvXTbcQzsK/mvycUlldt0M6ureyvUGVgBkoYEUWpW
        0zboJ5bHgB4NRhCfPWqe0EPNGj1WfubYnwt/PM4w2MqDHKgvFTXJGNn+sMvJgeVX
        n+YRkpjjSzkFJfMhPsxua2P04LnezE98FoxD2h7EtsO0j++d0tRmdqh0AUUnAyap
        6I+yo8bvgwhkdTuprmfkK+sFxy7iRaWQ3heE07XU1pe84L3LZcQ/dC+/7hMU9g+c
        x35Y6chLy820HewCutnysjKSQADKcjFXxOXFmEzZiw+QDeGVCJwX3EWxdJNl9vf9
        SLJLSGI71uZpYmyU9MQHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660659783; x=1660663383; bh=35h149IPL2yT5WUAl/Qc5n5Fyq2A
        NGh4qJ0KmuoASTI=; b=dW5RvNGOjRWSWpEkdCmh4KsCDOvapiR5JO1lezwxGDDV
        6RhOW2aEJ6HspGqO2ZH12j7AO1iHkvzQ8BO3dQHOb3q6TSW/ZuKn4YclC3hjRd9p
        bOkuUmJwpgPkGEss5iTa/LjAqMMdbvV1HNVUJddu0TcDh0NWmLte4vGg0W6mHE9K
        2w+v/HMnj12S9baCZqZ/UZZ3yvVwLY9UbHbzryF29NhNf7Gdze10sUHcEGyWlhlW
        GrDKwyA+jaU6agrrmceor3yO8ZyxtHuvEdARb5TKYm3vNHuaR0HVqCevqP8ZOoWY
        fmTN2nFmQCyomWWWDu/9IqFdPnD0O5ZsPdthhaNhsg==
X-ME-Sender: <xms:R6j7Yo_2bIPckoNn-ceoklGDfTOMwp8IZE0DKEKAxCT8uJqyibVosw>
    <xme:R6j7YguRs3B5y0K1C4uWKpe_U9STf668RLYkOqFW83nzkYnLK6ASYKSZ4iG9hLiKL
    _sxnm0gHc2VBBXQ0EA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehgedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepofgfggfkjghffffhvfev
    ufgtsehttdertderredtnecuhfhrohhmpedfvehhrhhishcuofhurhhphhihfdcuoehlih
    hsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqeenucggtffrrghtthgvrhhnpeef
    heeliedugeeuleetffeuheegkeetgfdtveevudffgfejvdegveeljefhvdefhfenucffoh
    hmrghinhepghhoohhglhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:R6j7YuD7SIitmbnq31uRpdrB-vuKDx5k0O5md3d526ggdpetkq6KxA>
    <xmx:R6j7YofqwVDMlV0Kwos-RFTUpWsxGbM9qXUjdRKoUDJIU1i-iVWggg>
    <xmx:R6j7YtPp_R21368aRoHTER1d_S2hZe4-023oVEiyHHW29nu_8rMexw>
    <xmx:R6j7Yg0Fy9ILN0daNUJmeXL-jOfOZR4_BLtOIXc2APQKbVHgakCJKA>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EF7F01700082; Tue, 16 Aug 2022 10:23:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <4995baed-c561-421d-ba3e-3a75d6a738a3@www.fastmail.com>
In-Reply-To: <61e5ccda-a527-4fea-9850-91095ffa91c4@www.fastmail.com>
References: <e38aa76d-6034-4dde-8624-df1745bb17fc@www.fastmail.com>
 <YvPvghdv6lzVRm/S@localhost.localdomain>
 <2220d403-e443-4e60-b7c3-d149e402c13e@www.fastmail.com>
 <cb1521d5-8b07-48d8-8b88-ca078828cf69@www.fastmail.com>
 <ad78a32c-7790-4e21-be9f-81c5848a4953@www.fastmail.com>
 <e36fe80f-a33b-4750-b593-3108ba169611@www.fastmail.com>
 <CAEzrpqe3rRTvH=s+-aXTtupn-XaCxe0=KUe_iQfEyHWp-pXb5w@mail.gmail.com>
 <d48c7e95-e21e-dcdc-a776-8ae7bed566cb@kernel.dk>
 <61e5ccda-a527-4fea-9850-91095ffa91c4@www.fastmail.com>
Date:   Tue, 16 Aug 2022 10:22:41 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Jens Axboe" <axboe@kernel.dk>, "Jan Kara" <jack@suse.cz>,
        "Paolo Valente" <paolo.valente@linaro.org>
Cc:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Josef Bacik" <josef@toxicpanda.com>
Subject: Re: stalling IO regression since linux 5.12, through 5.18
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Sun, Aug 14, 2022, at 4:28 PM, Chris Murphy wrote:
> On Fri, Aug 12, 2022, at 2:02 PM, Jens Axboe wrote:
>> Might be worth trying to revert those from 5.12 to see if they are
>> causing the issue? Jan, Paolo - does this ring any bells?
>
> git log --oneline --no-merges v5.11..c03c21ba6f4e > bisect.txt
>
> I tried checking out a33df75c6328, which is right before the first bfq 
> commit, but that kernel won't boot the hardware.
>
> Next I checked out v5.12, then reverted these commits in order (that 
> they were found in the bisect.txt file):
>
> 7684fbde4516 bfq: Use only idle IO periods for think time calculations
> 28c6def00919 bfq: Use 'ttime' local variable
> 41e76c85660c bfq: Avoid false bfq queue merging
>>>>a5bf0a92e1b8 bfq: bfq_check_waker() should be static
> 71217df39dc6 block, bfq: make waker-queue detection more robust
> 5a5436b98d5c block, bfq: save also injection state on queue merging
> e673914d52f9 block, bfq: save also weight-raised service on queue merging
> d1f600fa4732 block, bfq: fix switch back from soft-rt weitgh-raising
> 7f1995c27b19 block, bfq: re-evaluate convenience of I/O plugging on rq arrivals
> eb2fd80f9d2c block, bfq: replace mechanism for evaluating I/O intensity
>>>>1a23e06cdab2 bfq: don't duplicate code for different paths
> 2391d13ed484 block, bfq: do not expire a queue when it is the only busy 
> one
> 3c337690d2eb block, bfq: avoid spurious switches to soft_rt of 
> interactive queues
> 91b896f65d32 block, bfq: do not raise non-default weights
> ab1fb47e33dc block, bfq: increase time window for waker detection
> d4fc3640ff36 block, bfq: set next_rq to waker_bfqq->next_rq in waker 
> injection
> b5f74ecacc31 block, bfq: use half slice_idle as a threshold to check 
> short ttime
>
> The two commits prefixed by >>> above were not previously mentioned by 
> Jens, but I reverted them anyway because they showed up in the git log 
> command.
>
> OK so, within 10 minutes the problem does happen still. This is 
> block/bfq-iosched.c resulting from the above reverts, in case anyone 
> wants to double check what I did:
> https://drive.google.com/file/d/1ykU7MpmylJuXVobODWiiaLJk-XOiAjSt/view?usp=sharing

Any suggestions for further testing? I could try go down farther in the bisect.txt list. The problem is if the hardware falls over on an unbootable kernel, I have to bug someone with LOM access. That's a limited resource.


-- 
Chris Murphy
