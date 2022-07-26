Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FDA581A45
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 21:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239800AbiGZTZ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 15:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGZTZz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 15:25:55 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A018B1A807;
        Tue, 26 Jul 2022 12:25:54 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 963022B05B4C;
        Tue, 26 Jul 2022 15:19:58 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Tue, 26 Jul 2022 15:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1658863198; x=
        1658866798; bh=y3t0wMrfyAqUUNVLPOLMRMGGh0t/qSHeaVbcb4BusIw=; b=D
        oZFPi6fuudfAb6NIcUi2L0g7R2dj+ZZueMT5LIgc4i0/yfEasJvJnA9D1kOEBrwl
        icbgyf7YBv5OrjUSm7IPQnge+xRqAO1+vCLPlg2MbCSohqzUxekkkn9IerCWKfnY
        q+p5ViSG2BEkmC/UYCrnHtYRUhvnNXIL4Ba/Qd1Lk1E+7CaPeFLmowpSRTekUWak
        2vxsJ6Ozye12crn735EL8SQKomOoYnzFEOU6+BY5iUZxHyGmtgUpQX7R5QYdXxEG
        GZjwnZQs/591MUwQXEQkvEC/dY+4Rsojayl+V0RBalBoLejKHqCuCT/Vyu02VKIP
        6Gcqpe3KScjj1x3rKVO4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        i06494636.fm3; t=1658863198; x=1658866798; bh=y3t0wMrfyAqUUNVLPO
        LMRMGGh0t/qSHeaVbcb4BusIw=; b=QNPLNe5allO8z/7dyz17HVBl0CB+jmUYAx
        P7XtU1G0gDJiK7fDnyLy53XxSL9prQd+pWYRfydkM4YqcDLIshb7QFPv/gtnbmG3
        ulJrEiA4o4IIUl0JVmGtXY8q2h4XNVOtqdj0aWpPnTaCaWlZ5AvvHbM1vKZt3W/A
        AhzPt8dYiJlvtgfR0wQ4061QpQUPt2YchB/UxXIDhbYIwg0srl/3FRDrSRD+6cK+
        BXb6inoZMgmkXH0pYQAz3P+rwNiUIodhWveJ9JnL9oH4PcZ13KaeUvoceT/fAtcf
        OdrdlpKTLlsbfd15JujTfSXceMNQwX334Oznd/LQvklRBM9zel0Q==
X-ME-Sender: <xms:XT7gYpdXfQJbL-mihJa-J_MeXWnFoV9EKW-J5I9siK4bOvH6Z9dpHA>
    <xme:XT7gYnMROqXTyXYFk_rx2ma0KmIVQFJ7VJqeA9E7Qz8t9L1ADBPH7-nvQCj1Ciyyj
    TfS3JWgOb04ma2gz8o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddutddgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdev
    hhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtg
    homheqnecuggftrfgrthhtvghrnhepgfdvueektdefgfefgfdtleffvdeileetgfefuddt
    ffelueeiveeiveekhedtheeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:XT7gYigYy0xpOS4NrNX2IRZhecy6BkXiC_dpvTrEZDddyQBfmB5mMg>
    <xmx:XT7gYi-l8GMLm4XqOV9kQYSgjK6vtTPzjiEGeEZH4jNA-qAd98cz8Q>
    <xmx:XT7gYltTdgfp0RvWP8dQ3__NhEL0UV8RPcyxY6h7T20AO9FvhUGdXQ>
    <xmx:Xj7gYmWHv4TxmKPjnNi_6X4iBadIXOtk0o7YAhX7Ziy-8EnbOesh9CzKwHQ6kkgb>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 970E6170007E; Tue, 26 Jul 2022 15:19:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-757-gc3ad9c75d3-fm-20220722.001-gc3ad9c75
Mime-Version: 1.0
Message-Id: <fa57195c-cd1e-464e-b099-7552f65e39f5@www.fastmail.com>
In-Reply-To: <20220726164250.GE13489@twin.jikos.cz>
References: <CABXGCsN+BcaGO0+0bJszDPvA=5JF_bOPfXC=OLzMzsXY2M8hyQ@mail.gmail.com>
 <20220726164250.GE13489@twin.jikos.cz>
Date:   Tue, 26 Jul 2022 15:19:34 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "David Sterba" <dsterba@suse.cz>,
        =?UTF-8?Q?=D0=9C=D0=B8=D1=85=D0=B0=D0=B8=D0=BB_=D0=93=D0=B0=D0=B2=D1=80?=
         =?UTF-8?Q?=D0=B8=D0=BB=D0=BE=D0=B2?= 
        <mikhail.v.gavrilov@gmail.com>
Cc:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Tue, Jul 26, 2022, at 12:42 PM, David Sterba wrote:
> On Tue, Jul 26, 2022 at 05:32:54PM +0500, Mikhail Gavrilov wrote:
>> Hi guys.
>> Always with intensive writing on a btrfs volume, the message "BUG:
>> MAX_LOCKDEP_CHAIN_HLOCKS too low!" appears in the kernel logs.
>
> Increase the config value of LOCKDEP_CHAINS_BITS, default is 16, 18
> tends to work.

Fedora is using 17. I'll make a request to bump it to 18. Thanks.

--
Chris Murphy
