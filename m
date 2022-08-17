Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BFF597267
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 17:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240781AbiHQPEL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 11:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240749AbiHQPDz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 11:03:55 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4D89DFB0;
        Wed, 17 Aug 2022 08:02:59 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 87523580A19;
        Wed, 17 Aug 2022 11:02:47 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 17 Aug 2022 11:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660748567; x=
        1660752167; bh=XuAuMZJGsQZ1NsfHlxjT4d04G2KbCrSJAFw2yyq2vRA=; b=P
        FbRKcnX1q4OWjL9ew45cds15G9s+rSwCTdBjWgzxK6Whq4At+oqyf4l0S6wyXNHp
        Tx83jSgmSLEOEzHNxtmfUThxjONB5em/fHBxq9OoGOfdeb9oDKlIAXG+6jbSudN3
        p0qN/vJXkUdA4PFjqCMMvaVwh3stYV/f3sMjc3LKstq61I81oatyAeYMSMSk8CJs
        FQFuPGHo9NXBmtBgyfM1LQ5KNcbiHgZ74LnRbBAfzS5ENsaF0IwQl/ZKZ43g70Q9
        dycwLYQYZnJvQqlGe/huns80Ly6QUocduKcdwQ2gO1XL1GfswVvW73hbnIvQJ2zF
        fddl73oUU9ZUoxguwB8eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660748567; x=1660752167; bh=XuAuMZJGsQZ1NsfHlxjT4d04G2Kb
        CrSJAFw2yyq2vRA=; b=k8N276/Fcz7+YiYL7vg1qm6LiskF7S7WB8GJxuw93uQ4
        t3Nq43ONuP/RXSwp42dHj1Rg5dQ2KOUCSoZ5xKKFdOGORYw4BErCe8i9T2j9+Xai
        wXbm/X8QfGyJ7OE8Q12q/hnZCbBnYw3jRnfue/c7hUY5hppnEf5DpKJ+e54A91Yw
        TTw1ICfwu5eh0RJ/lYci9JcrIi5C2VOk0iFzjB9xgWr88GbZecnU9Qshpt00YcCl
        JYNrqfpw+f9HVN1SZVkVHN2lvULgzpg60zYBIs6z9VABgD9pwIt4C39Ml+7T2+IZ
        SeiC/i/sN0GhAjW2EC+lp3Xh9q1RHWtRF1BmD8kujg==
X-ME-Sender: <xms:FgP9Ypx03P47G8vAyWngwArPSuk9h_dJMItI_KaXa4dbwkrdKFrB7w>
    <xme:FgP9YpTqZ6TvCBaF4--zpBCeASsC5wc05gZ0Q2ETyUHOCBdnN2z25JitKQMH12MaG
    na_aON8HJnh_AaY4XE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehiedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepofgfggfkjghffffhvfev
    ufgtsehttdertderredtnecuhfhrohhmpedfvehhrhhishcuofhurhhphhihfdcuoehlih
    hsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqeenucggtffrrghtthgvrhhnpeef
    heeliedugeeuleetffeuheegkeetgfdtveevudffgfejvdegveeljefhvdefhfenucffoh
    hmrghinhepghhoohhglhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:FgP9YjUx0Ow-p-CQ3n6tUd0L5zgiGd46Xbaoj9bAXOGUV6w5anuDUQ>
    <xmx:FgP9Yrj9mXgH1uEC_J-_GRtqafc18c2QNR20pVoLDRRcKbolj31GZw>
    <xmx:FgP9YrAbaGUWjWNU7vNnVVHm4fUZZ1nNlpSdOgmr7FcDj-e0Toh-RQ>
    <xmx:FwP9YtBBsUv4yps0uSjILU23lh-o2DksbsZqHIMNPHf5X1cuD72Olw>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C90A51700082; Wed, 17 Aug 2022 11:02:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <f633c476-bdc9-40e2-a93f-29601979f833@www.fastmail.com>
In-Reply-To: <Yv0A6UhioH3rbi0E@T590>
References: <ad78a32c-7790-4e21-be9f-81c5848a4953@www.fastmail.com>
 <e36fe80f-a33b-4750-b593-3108ba169611@www.fastmail.com>
 <CAEzrpqe3rRTvH=s+-aXTtupn-XaCxe0=KUe_iQfEyHWp-pXb5w@mail.gmail.com>
 <d48c7e95-e21e-dcdc-a776-8ae7bed566cb@kernel.dk>
 <61e5ccda-a527-4fea-9850-91095ffa91c4@www.fastmail.com>
 <4995baed-c561-421d-ba3e-3a75d6a738a3@www.fastmail.com>
 <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
 <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
 <CAFj5m9+6Vj3NdSg_n3nw1icscY1qr9f9SOvkWYyqpEtFBb_-1g@mail.gmail.com>
 <b236ca6e-2e69-4faf-9c95-642339d04543@www.fastmail.com>
 <Yv0A6UhioH3rbi0E@T590>
Date:   Wed, 17 Aug 2022 11:02:25 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Ming Lei" <ming.lei@redhat.com>
Cc:     "Nikolay Borisov" <nborisov@suse.com>,
        "Jens Axboe" <axboe@kernel.dk>, "Jan Kara" <jack@suse.cz>,
        "Paolo Valente" <paolo.valente@linaro.org>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Josef Bacik" <josef@toxicpanda.com>
Subject: Re: stalling IO regression since linux 5.12, through 5.18
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Wed, Aug 17, 2022, at 10:53 AM, Ming Lei wrote:
> On Wed, Aug 17, 2022 at 10:34:38AM -0400, Chris Murphy wrote:
>> 
>> 
>> On Wed, Aug 17, 2022, at 8:06 AM, Ming Lei wrote:
>> 
>> > blk-mq debugfs log is usually helpful for io stall issue, care to post
>> > the blk-mq debugfs log:
>> >
>> > (cd /sys/kernel/debug/block/$disk && find . -type f -exec grep -aH . {} \;)
>> 
>> This is only sda
>> https://drive.google.com/file/d/1aAld-kXb3RUiv_ShAvD_AGAFDRS03Lr0/view?usp=sharing
>
> From the log, there isn't any in-flight IO request.
>
> So please confirm that it is collected after the IO stall is triggered.

Yes, iotop reports no reads or writes at the time of collection. IO pressure 99% for auditd, systemd-journald, rsyslogd, and postgresql, with increasing pressure from all the qemu processes.

Keep in mind this is a raid10, so maybe it's enough for just one block device IO to stall and the whole thing stops? That's why I included all block devices.

> If yes, the issue may not be related with BFQ, and should be related
> with blk-cgroup code.

Problem happens with cgroup.disable=io, does this setting affect blk-cgroup?

-- 
Chris Murphy
