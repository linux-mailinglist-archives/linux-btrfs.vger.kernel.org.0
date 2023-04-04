Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9CF6D70E1
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 01:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236636AbjDDXpx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Apr 2023 19:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236634AbjDDXpw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Apr 2023 19:45:52 -0400
X-Greylist: delayed 498 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Apr 2023 16:45:49 PDT
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C31421E
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Apr 2023 16:45:49 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id 322B02B066D4;
        Tue,  4 Apr 2023 19:37:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 04 Apr 2023 19:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680651449; x=1680655049; bh=J1BC/ZgMTCier5E+5tsATfmu2nswwvG40Pp
        bGL8skUk=; b=RKrlzfzAIpmCS2O0dTAgEKCfGvIf0I6xJBkDMcAHH3+HsV+oYXQ
        BWgi+Dj3auRNTYysGIPup+MFfUKMcA6hGVFpPXyQ0zzmL+ljhoDdDKpZ5EWholgk
        X/9gS0R2ZGHZIrT8PhDXIY0vTT4U9ZYCVS0h5W0z4oHDDIclQO9Rtz4BluRT2GV4
        CqJMwf4Ek+pxNWUNXdp2zDerQGdPshc4+thlZb5RTnIQ3yL+klzHn4HIOO6bYgYQ
        Tia+fO+Tfxy9MMj2HOYjn99GcMGOLbeo8pgIbe/nlod0Oc3BgFf5HPhovHsAouzf
        /L/a7oc/XI/9OXumavmQlRUfaDf2wgSdWOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=i3db14652.fm2;
         t=1680651449; x=1680655049; bh=J1BC/ZgMTCier5E+5tsATfmu2nswwvG4
        0PpbGL8skUk=; b=NUli5819vPakZfjWOAk1xje+MXfC/fhCSAwJ8zfbE7+SYLD4
        rqAjUXZV93did1jYpaKd8r2aO0IIOzBeB4VjNbAm+LMbHLzSSJ27WJ+62vKZwZdE
        DXoePGw0z20s2iuK2Mn10gFO0ncYRWnZxIDzXpHoxKaG6HN0mY9AlvgS7RoHG+mX
        XLZB2KPDLt7LNNdk7+gEBUudkxiVGeBCpgDmktz2GLsy2vYfKyPb8tyXWxrwv0Oc
        XcynzqOQXvEeVwQx/3dd2CG7ezqO8OEOsGf563sDZQp9k8YICGdpQSpPJljB37l6
        NOuyOUEGQRYnmEv8noIwLhPbTdSWuZcSb6RtCg==
X-ME-Sender: <xms:ubQsZCpktNsxhPss0DA61dKPIJtiRZddlQpS8_M5usJ9bKxOlFB5JQ>
    <xme:ubQsZAp-eqgCGJrnnKunNmHyV6cuGin9TioQCDnXLUexUjiejjEgd4VjwNytQv6kn
    yskK5fF10XRUh8fSwg>
X-ME-Received: <xmr:ubQsZHP-_J1-PVdGYOuG4no2mw4HK9-Au2YDBw4GwemeSu7rGA33Hp_ATaVNqSI01T_tvrCapEpcB7Vgc74p0sAtJSL3i-ss>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejtddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeffrghm
    ihgvnhcunfgvucfoohgrlhcuoegulhgvmhhorghlsehfrghsthhmrghilhdrtghomheqne
    cuggftrfgrthhtvghrnhepteefiefhieetgfevhfegfeehffetteduieetudfgleetvdff
    udelveejfefhfeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepughlvghmohgrlhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ubQsZB4VOyJ8rQxL1Y1HNN43un0cgZzjHBKa18xnjUsFxJQF5BLibg>
    <xmx:ubQsZB62DGANJXcUpP6Ofbtx7b-XlywSkeq_c9SeCLgnJSIyXLUBeQ>
    <xmx:ubQsZBgbl7kxlktD1d_VNpHHLG5LkgksPzFbR0m11AYpEz_Tj3ykVQ>
    <xmx:ubQsZGG51xVmDn4Gbm1XGABQFHGUWX1HYk9RFlavU9xUQypX0LkCy52I6ME>
Feedback-ID: i3db14652:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Apr 2023 19:37:26 -0400 (EDT)
Message-ID: <852ad310-092e-169c-d98a-9317aa0b4268@fastmail.com>
Date:   Wed, 5 Apr 2023 08:37:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [6.2 regression][bisected]discard storm on idle since
 v6.1-rc8-59-g63a7cb130718 discard=async
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Roman Mamedov <rm@romanrm.net>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Sergei Trofimovich <slyich@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Christopher Price <pricechrispy@gmail.com>,
        anand.jain@oracle.com, boris@bur.io, clm@fb.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
References: <CAHmG9huwQcQXvy3HS0OP9bKFxwUa3aQj9MXZCr74emn0U+efqQ@mail.gmail.com>
 <CAEzrpqeOAiYCeHCuU2O8Hg5=xMwW_Suw1sXZtQ=f0f0WWHe9aw@mail.gmail.com>
 <ZBq+ktWm2gZR/sgq@infradead.org> <20230323222606.20d10de2@nz>
 <20d85dc4-b6c2-dac1-fdc6-94e44b43692a@leemhuis.info>
 <ZCxKc5ZzP3Np71IC@infradead.org> <20230404212027.3730905d@nvm>
 <ZCxP/ll7YjPdb9Ou@infradead.org>
From:   Damien Le Moal <dlemoal@fastmail.com>
In-Reply-To: <ZCxP/ll7YjPdb9Ou@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/5/23 01:27, Christoph Hellwig wrote:
> On Tue, Apr 04, 2023 at 09:20:27PM +0500, Roman Mamedov wrote:
>> SSDs do not physically erase blocks on discard, that would be very slow.
>>
>> Instead they nuke corresponding records in the Flash translation layer (FTL)
>> tables, so that the discarded areas point "nowhere" instead of the actual
>> stored blocks. And when facing such pointers on trying to resolve read
>> requests, the controller knows to just return zeroes.
> 
> Of course they don't erase blocks on every discard (although if you look
> long enough you'll probably find a worst case implementation that does
> this anyway).  But you still need to persist your FTL changes, and the
> zeroing if any was done by the time your get a FLUSH command, because
> without that you'd return different data when reading a block after a
> powerfail (i.e. the old data) than before (zeros or a pattern), which is
> a no-go.
> 
>> Of course there can be varying behaviors per SSD, e.g. I know of some that
>> return random garbage instead of zeroes, and some which for a puzzling reason
>> prefer to return the byte FF instead.
> 
> All of that is valid behavior per the relevant standards.  
> 
>> But I think the 1st point above should
>> be universal, pretty certain there are none where a discard/TRIM would take
>> comparable time to "dd if=/dev/zero of=/dev/ssd" (making it unusable in
>> practice).
> 
> This is wishful thinking :)  SSDs generall optimize the fast path very
> heavily, so slow path command even when they should in theory be faster
> due to the underlying optimizations might not be, as they are processed
> in software instead of hardware offloads, moved to slower cores, etc.
> 
> For discard things have gotten a lot better in the last years, but for
> many older devices performance can be outright horrible.
> 
> For SATA SSDs the fact that classic TRIM isn't a queued command adds
> insult to injury as it always means draining the queue first and not
> issuing any I/O until the TRIM command is done.  There is a FPDMA
> version not, but I don't think it ws all that widely implemented before
> SATA SSDs fell out of favour.

Not to mention that many of the SATA SSDs actually implementing queued trim are
buggy. See ATA horkage flag ATA_HORKAGE_NO_NCQ_TRIM and the many consumer SSDs
that need that flag.

