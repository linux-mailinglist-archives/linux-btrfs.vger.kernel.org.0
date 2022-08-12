Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EBC591377
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Aug 2022 18:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbiHLQFp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Aug 2022 12:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239118AbiHLQFi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Aug 2022 12:05:38 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDEC1CFF3;
        Fri, 12 Aug 2022 09:05:36 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 50C2F580738;
        Fri, 12 Aug 2022 12:05:33 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Fri, 12 Aug 2022 12:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660320333; x=
        1660323933; bh=ZfavIhskby4GoKzVfw6MKy4s5jR3CPPCp0NyB7WB09Q=; b=X
        vhyLVw4NZweU60SIKsiCGV+4EJKvVC8rQ9uyDHozg9JtCXk5hzODpH6oO/RqLNAz
        OyrIxA2iK5V6V+xrjISpOaAp4ZA3UaTtvP+vHRiIRuu1VWFcbnUIDS3qo1hsmo4E
        VZmzNMS57hJwxzpr2PXQfN44x9qPjC7AxzZXUpGq+jPoFm7LijIX/ZLaRwFEPuW6
        JuSi7VzKG7klRfRmf+IzwEt/5/wz/IYcPdigT2ytkFYm5rWg1CK6pRLTOCSMctLz
        WlK6SQdKQvXTIzy2Nwui80nU0pJ1DI+jwnHU7kyvU/N0+rJeTP7q0W0mABBhLKtD
        Hq778xK4mEsTUuLv2JwCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660320333; x=1660323933; bh=ZfavIhskby4GoKzVfw6MKy4s5jR3
        CPPCp0NyB7WB09Q=; b=HwDdZJV/LIXfyrpXiV5kfQbqrztiOVOP4vTxlCH5p5lE
        fMJpeWasfiQKwsE6hyr/fD8DTeQWCeKGs4ZjX7LX3IPuFpwX8B85b3W7He6vc4sj
        RxHz3ixfoFaf3aukpqs2Yk7TSG9+pLs17fcNID9UNsrmCPzPBIspc4tCZ+ZT1kxO
        EzbKI0xYh7yqyyvxGcMMsxLx+9kgTbXaH2vlOHyF0Jlh48XSMbgnJTPHNqhfquNJ
        EXeTckTzC71s9+DNbcQDmo0aPfcjyuozcJq4BPvbW8XU6H5bYwIfyg3TEEqxx6OZ
        3ZngGXE0ffxgssrTHosHP55lusOQCP9v+EChQ0UolQ==
X-ME-Sender: <xms:TXr2YiPdo8BSTGH0u-7oSFNi8JvYAlE8wFJK3HWvHL6OzT6XFQWMiA>
    <xme:TXr2Yg-2rLy9k3xlhkyoqJLOcrb9kzEQnBNOF6sK_qi8Y-6kZsKyrE93S788-8aZs
    GnHgihxWFIpL3L_tpU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegiedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepofgfggfkjghffffhvfev
    ufgtsehttdertderredtnecuhfhrohhmpedfvehhrhhishcuofhurhhphhihfdcuoehlih
    hsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqeenucggtffrrghtthgvrhhnpeef
    heeliedugeeuleetffeuheegkeetgfdtveevudffgfejvdegveeljefhvdefhfenucffoh
    hmrghinhepghhoohhglhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:TXr2YpRWT1DsECf0xGghkhZ-dcDLZ0shkTLqbEuRIC0Pr-P8-CL2PA>
    <xmx:TXr2YitB5OaMMQStPbFdg8PFMGiqpI9NlVa-5kiAmA3BGPwJ9iwPtA>
    <xmx:TXr2YqclpPu14_5zWstifOFxLO06C60gf1rSbk3ELGqjr7XQ_8v_1A>
    <xmx:TXr2Yq6Up4L5JqAShY26M2xeReJ9StYP0wra2m8YljroE9DUfaWe1A>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id ECA551700082; Fri, 12 Aug 2022 12:05:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <e36fe80f-a33b-4750-b593-3108ba169611@www.fastmail.com>
In-Reply-To: <ad78a32c-7790-4e21-be9f-81c5848a4953@www.fastmail.com>
References: <e38aa76d-6034-4dde-8624-df1745bb17fc@www.fastmail.com>
 <YvPvghdv6lzVRm/S@localhost.localdomain>
 <2220d403-e443-4e60-b7c3-d149e402c13e@www.fastmail.com>
 <cb1521d5-8b07-48d8-8b88-ca078828cf69@www.fastmail.com>
 <ad78a32c-7790-4e21-be9f-81c5848a4953@www.fastmail.com>
Date:   Fri, 12 Aug 2022 12:05:12 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Josef Bacik" <josef@toxicpanda.com>, paolo.valente@linaro.org
Cc:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
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



On Wed, Aug 10, 2022, at 3:34 PM, Chris Murphy wrote:
> Booted with cgroup_disable=io, and confirmed cat 
> /sys/fs/cgroup/cgroup.controllers does not list io.

The problem still reproduces with the cgroup IO controller disabled.

On a whim, I decided to switch the IO scheduler from Fedora's default bfq for rotating drives to mq-deadline. The problem does not reproduce for 15+ hours, which is not 100% conclusive but probably 99% conclusive. I then switched live while running the workload to bfq on all eight drives, and within 10 minutes the system cratered, all new commands just hang. Load average goes to triple digits, i/o wait increasing, i/o pressure for the workload tasks to 100%, and IO completely stalls to zero. I was able to switch only two of the drive queues back to mq-deadline and then lost responsivness in that shell and had to issue sysrq+b...

Before that I was able to extra sysrq+w and sysrq+t.
https://drive.google.com/file/d/16hdQjyBnuzzQIhiQT6fQdE0nkRQJj7EI/view?usp=sharing

I can't tell if this is a bfq bug, or if there's some negative interaction between bfq and scsi or megaraid_sas. Obviously it's rare because otherwise people would have been falling over this much sooner. But at this point there's strong correlation that it's bfq related and is a kernel regression that's been around since 5.12.0 through 5.18.0, and I suspect also 5.19.0 but it's being partly masked by other improvements.



-- 
Chris Murphy
