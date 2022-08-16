Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EF6595F2C
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Aug 2022 17:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbiHPPe6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Aug 2022 11:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236129AbiHPPef (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Aug 2022 11:34:35 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA563AE7E;
        Tue, 16 Aug 2022 08:34:26 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 280E35801C7;
        Tue, 16 Aug 2022 11:34:22 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Tue, 16 Aug 2022 11:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1660664062; x=1660667662; bh=hxD2OZ44Nc
        hM4rhx8vDMW4CDwAVBPxREEev8zWLQ1n4=; b=Yai7Nr4mibKy1IxFv4iCgOAIFJ
        ggnAG+aCVwCszQEAz2H80PeQw5tL/WMZgaQ/zDiT67BC2j1usIdjn5GS80gOMcYL
        0fM6a5UhhNoyBWVWBZ6oVhj6NWz/ANRYt/zEaZa2ZPA142du0lENEhUKUqtxD/1Z
        8Gd+CBhlNtSpEM63xsPEnVyBumKP597rhpsuWl4oYRnBYzNuUn8BfZGlYKUxGuIQ
        1cO6kRHAhGkT7yAUCx/kYBiMzumDQt6Ir18miAz/m4rJd7erUCIgTUGn+O5f88Jm
        /jhnjwwgpuVJ7HS3B/XNtakgLJ3P1RmKLCn9MiDfKEQ/XGAgycb4wk9kXhaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660664062; x=
        1660667662; bh=hxD2OZ44NchM4rhx8vDMW4CDwAVBPxREEev8zWLQ1n4=; b=I
        sivLvqanHeFnCX2zeOZyq/BZIHzcTjc3E2japhtSG3jGy9jmJojdKEwuGpQBR+vS
        rUrxOwxbvfGQcOkxxWqjskDRU4jBA/QR2CtbQaPek869ztwL6hso+B5ZAM4hOmw8
        iGFlmbsp/M+QscFgw3VQi/lPrQbYEvk0WnxeSlicYAYvBToUiUg1v9OCQA+x1nnB
        c0gbjXI00JOTpA9n04d5bJOBU6JEekjV84pIWWudn+m+Yly7xE+zkS/giquR78vJ
        9s4SASepB0W0/jeI91vOoIEmQe05ykWv7ub4utq94+eAqZ5arvb0efveDnqm31Uq
        aNHoGtvdbfNs0Se0LVtRw==
X-ME-Sender: <xms:_bj7Yue96JEe-5_oUqT5kL856sFdIs4voiROrZfk1H37RNwo_oOgGQ>
    <xme:_bj7YoOBoOVvBZjuM9cgQBVQLz6ral3q7nufaqpjr2eB7jF3-CwGoyGecgwC7cIoQ
    KQIh-wdR9PYldVQ6fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehgedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepofgfggfkjghffffhvfev
    ufgtgfesthhqredtreerjeenucfhrhhomhepfdevhhhrihhsucfouhhrphhhhidfuceolh
    hishhtshestgholhhorhhrvghmvgguihgvshdrtghomheqnecuggftrfgrthhtvghrnhep
    iefhledtudfgvdejvdfgkeelvedtfeekuefgfeehjefhgfelgfelkedvfefgffeinecuff
    homhgrihhnpehgohhoghhlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtoh
    hm
X-ME-Proxy: <xmx:_bj7Yvgu1-_Y_sStyDFFz66-zvRL2Zjq5At16H76Hig64xiSAYlZmg>
    <xmx:_bj7Yr87VRSm_kyBkwg4CwVKLR1TNHuR3At72EjDLjsYY14ew6qHdQ>
    <xmx:_bj7YqvOTy7m7af5il7noj82rX0H5IqIoSladD8Chp4tnWZ3qumSMw>
    <xmx:_rj7YuhqrTUWowGz6VVUFOUq_ylmt-kOJ3YwjNQjiqC9anX4xxhWNw>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6F8261700082; Tue, 16 Aug 2022 11:34:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
In-Reply-To: <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
References: <e38aa76d-6034-4dde-8624-df1745bb17fc@www.fastmail.com>
 <YvPvghdv6lzVRm/S@localhost.localdomain>
 <2220d403-e443-4e60-b7c3-d149e402c13e@www.fastmail.com>
 <cb1521d5-8b07-48d8-8b88-ca078828cf69@www.fastmail.com>
 <ad78a32c-7790-4e21-be9f-81c5848a4953@www.fastmail.com>
 <e36fe80f-a33b-4750-b593-3108ba169611@www.fastmail.com>
 <CAEzrpqe3rRTvH=s+-aXTtupn-XaCxe0=KUe_iQfEyHWp-pXb5w@mail.gmail.com>
 <d48c7e95-e21e-dcdc-a776-8ae7bed566cb@kernel.dk>
 <61e5ccda-a527-4fea-9850-91095ffa91c4@www.fastmail.com>
 <4995baed-c561-421d-ba3e-3a75d6a738a3@www.fastmail.com>
 <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
Date:   Tue, 16 Aug 2022 11:34:00 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Nikolay Borisov" <nborisov@suse.com>,
        "Jens Axboe" <axboe@kernel.dk>, "Jan Kara" <jack@suse.cz>,
        "Paolo Valente" <paolo.valente@linaro.org>
Cc:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Josef Bacik" <josef@toxicpanda.com>
Subject: Re: stalling IO regression since linux 5.12, through 5.18
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Tue, Aug 16, 2022, at 11:25 AM, Nikolay Borisov wrote:
> On 16.08.22 =D0=B3. 17:22 =D1=87., Chris Murphy wrote:
>>=20
>>=20
>> On Sun, Aug 14, 2022, at 4:28 PM, Chris Murphy wrote:
>>> On Fri, Aug 12, 2022, at 2:02 PM, Jens Axboe wrote:
>>>> Might be worth trying to revert those from 5.12 to see if they are
>>>> causing the issue? Jan, Paolo - does this ring any bells?
>>>
>>> git log --oneline --no-merges v5.11..c03c21ba6f4e > bisect.txt
>>>
>>> I tried checking out a33df75c6328, which is right before the first b=
fq
>>> commit, but that kernel won't boot the hardware.
>>>
>>> Next I checked out v5.12, then reverted these commits in order (that
>>> they were found in the bisect.txt file):
>>>
>>> 7684fbde4516 bfq: Use only idle IO periods for think time calculatio=
ns
>>> 28c6def00919 bfq: Use 'ttime' local variable
>>> 41e76c85660c bfq: Avoid false bfq queue merging
>>>>>> a5bf0a92e1b8 bfq: bfq_check_waker() should be static
>>> 71217df39dc6 block, bfq: make waker-queue detection more robust
>>> 5a5436b98d5c block, bfq: save also injection state on queue merging
>>> e673914d52f9 block, bfq: save also weight-raised service on queue me=
rging
>>> d1f600fa4732 block, bfq: fix switch back from soft-rt weitgh-raising
>>> 7f1995c27b19 block, bfq: re-evaluate convenience of I/O plugging on =
rq arrivals
>>> eb2fd80f9d2c block, bfq: replace mechanism for evaluating I/O intens=
ity
>>>>>> 1a23e06cdab2 bfq: don't duplicate code for different paths
>>> 2391d13ed484 block, bfq: do not expire a queue when it is the only b=
usy
>>> one
>>> 3c337690d2eb block, bfq: avoid spurious switches to soft_rt of
>>> interactive queues
>>> 91b896f65d32 block, bfq: do not raise non-default weights
>>> ab1fb47e33dc block, bfq: increase time window for waker detection
>>> d4fc3640ff36 block, bfq: set next_rq to waker_bfqq->next_rq in waker
>>> injection
>>> b5f74ecacc31 block, bfq: use half slice_idle as a threshold to check
>>> short ttime
>>>
>>> The two commits prefixed by >>> above were not previously mentioned =
by
>>> Jens, but I reverted them anyway because they showed up in the git l=
og
>>> command.
>>>
>>> OK so, within 10 minutes the problem does happen still. This is
>>> block/bfq-iosched.c resulting from the above reverts, in case anyone
>>> wants to double check what I did:
>>> https://drive.google.com/file/d/1ykU7MpmylJuXVobODWiiaLJk-XOiAjSt/vi=
ew?usp=3Dsharing
>>=20
>> Any suggestions for further testing? I could try go down farther in t=
he bisect.txt list. The problem is if the hardware falls over on an unbo=
otable kernel, I have to bug someone with LOM access. That's a limited r=
esource.
>>=20
>>=20
>
> How about changing the scheduler either mq-deadline or noop, just to s=
ee=20
> if this is also reproducible with a different scheduler. I guess noop=20
> would imply the blk cgroup controller is going to be disabled

I already reported on that: always happens with bfq within an hour or le=
ss. Doesn't happen with mq-deadline for ~25+ hours. Does happen with bfq=
 with the above patches removed. Does happen with cgroup.disabled=3Dio s=
et.

Sounds to me like it's something bfq depends on and is somehow becoming =
perturbed in a way that mq-deadline does not, and has changed between 5.=
11 and 5.12. I have no idea what's under bfq that matches this descripti=
on.

--=20
Chris Murphy
