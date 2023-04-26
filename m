Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E086EF093
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Apr 2023 11:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbjDZJFz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Apr 2023 05:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239308AbjDZJFx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Apr 2023 05:05:53 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A1940D5
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 02:05:51 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9A61B5C00D5;
        Wed, 26 Apr 2023 05:05:50 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute4.internal (MEProxy); Wed, 26 Apr 2023 05:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dend.ro; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1682499950; x=1682586350; bh=4y
        EGWc74vFQOlnhALBqYnacdg2UPGwmIPnioWwjFDMk=; b=RIc+r5kgFyWYEQpkBg
        sRBRG5a6nCiks6KAVcwEnGotBD0XsoInOenwiCqutSh4dsAfLutoS+31krtLtrpW
        3y8ev6/39Z/l5rGoD+Qi3kt/4dKuK0yErs90vRxCPn8U9sN8dH7BvJh+xDHZrdbG
        X17Txp2/gAh6P9Npe0sqH+yUM+SOKi0IZF6JdMaINfExQlC/Q8sML6jDuklD/8aZ
        1HmrpFcW0u3SKThGplBrCkbfJjCjVZJl/TVRVlEkmc684OXh6FEI8Uwul43bFylL
        Vjow6MWdQb4ZNpIyup6oq55iQGnvPr/B9Zgsy7HDxyzdTFt1Il87yuH4CUP89Aat
        tYog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682499950; x=1682586350; bh=4yEGWc74vFQOl
        nhALBqYnacdg2UPGwmIPnioWwjFDMk=; b=C41Cr1bIZHm0RhxgSH5rAYc4NTNHz
        WZvptSK0pVG3EU0Zoai3NLZ9B2fu0qdqXCr0gFLHG8REsIbPvPWbZQjQg+JBJOut
        AexVRCvR1b98k8dWcGCwvIxUcx+f2TTBgSP4MBrgnF3z3zh7622I/62DTdHFCckb
        yCxqrNsFQvgzd7X94MQlRvF0a0wdWVFqY5EtlFXHG80+xLbOtcpGl19HOLJWyCUO
        aHgGYm3lgO/6eo3jqxFDE8ZAimXPadryrBra7JyKSShI4jTo5q5SEw2LroBCrs3c
        SJF4IYGYOwexm2rQETqbnQEDy1NHGIQgeM1BiqfSfTyjnTfTNqm/rDYaA==
X-ME-Sender: <xms:bulIZNHZk4f_zinm2f1zzb84OxlHtAbgRmHrGoyp8Qa-ahNgCWiGZg>
    <xme:bulIZCWgR-JOL8rAoGDRRcsootAOjUU4J1R-mxQnURRFA2nhZJII_8_hw191_mNKk
    3GxNHp4CVzU2Fr9AA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedugedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreerjeenucfhrhhomhepnfgruhhrvghnthhiuhcupfhitgholhgruceolhhnihgt
    ohhlrgesuggvnhgurdhroheqnecuggftrfgrthhtvghrnheptdetlefghfffteefvdeuvd
    ejjeelkefhueeluedujeegueffffetheejieehhfegnecuffhomhgrihhnpegtvghnthho
    shdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehlnhhitgholhgrseguvghnugdrrhho
X-ME-Proxy: <xmx:bulIZPLF3GHMsy0ILg1k26w-IRQppDrU9TjImjj0lRJpimQJjULfiQ>
    <xmx:bulIZDEg06BCSxlYSF8NzAdBuLlyZQfeYOiSuw_NfwbeZqjSbcBh7w>
    <xmx:bulIZDV_QJBC5iAs0j5KV6Ba4jlD4YvPI4q9-Rvi96MpJaTJ_Qa5nA>
    <xmx:bulIZKDSzzf10E55QceAGaTVeOnuZz0D0NKMiRcehFdeaSO50Dsv6A>
Feedback-ID: ic7f8409e:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 67E881700089; Wed, 26 Apr 2023 05:05:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-374-g72c94f7a42-fm-20230417.001-g72c94f7a
Mime-Version: 1.0
Message-Id: <974307f3-7cd7-4221-8ba2-30ce0d7bb49e@betaapp.fastmail.com>
In-Reply-To: <1e917ae3-71fd-b684-12b0-044e49d22afa@gmx.com>
References: <d2975210-6fd4-4bf2-b72f-ffba664bdcc0@betaapp.fastmail.com>
 <a0f6195f-e6d1-f633-9cd7-310fe5786546@gmx.com>
 <f057bdd1-bdd9-459f-b25f-6a2faa652499@betaapp.fastmail.com>
 <1e917ae3-71fd-b684-12b0-044e49d22afa@gmx.com>
Date:   Wed, 26 Apr 2023 12:05:30 +0300
From:   =?UTF-8?Q?Lauren=C8=9Biu_Nicola?= <lnicola@dend.ro>
To:     "Qu Wenruo" <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Corruption and error on Linux 6.2.8 in btrfs_commit_transaction ->
 btrfs_run_delayed_refs
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

On Wed, Apr 26, 2023, at 11:50, Qu Wenruo wrote:
> Thanks for that link, it shows a pretty good dmesg of that RO flip.
>
> It in fact shows a case where there is no EXTENT_ITEM but an invalid 
> type key (40). (file "2", item 29)
>
> Furthermore, that item 29 has a size of 37, which matches a inline 
> extent backref to a parent.
>
> And the determining evidence is the following:
>
> bin(168) = 0b10101000	(EXTENT_ITEM key type, expected)
> bin(40)  = 0b00101000   (Bad key type from the dmesg)
>
> So a bit flip is causing the problem, unfortunately tree-checker is not 
> strict enough to detect it (for now).
>

Thanks, I see what you mean after cross-checking with btrfs_tree.h.

> If you can still reproduce the problem, and keeps the original dmesg of 
> the RO flips, then I may have a chance to determine if it's really bitflip.

I have this full dump I got after I rebooted https://paste.centos.org/view/21560210, but it only has METADATA_ITEMs. Unfortunately I didn't save the original one.

Laurentiu
