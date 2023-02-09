Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E1369144C
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 00:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjBIXXy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Feb 2023 18:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBIXXx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Feb 2023 18:23:53 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C7020059
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Feb 2023 15:23:51 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B11505C0124
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Feb 2023 18:23:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 09 Feb 2023 18:23:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1675985030; x=
        1676071430; bh=pl3VLq+N+exXBxiGGTZPlzdo+vAxKzRkzVcovDyrCSE=; b=H
        R8Ee1TdRswmC1FVwIw7LYsR8vYo/nko66hR6lDMydR9kymezGpuvLqHAuC1tZ5Jn
        pEC6bIsGa6Hij7W5MYcObU/0QMyJmTnF60t9JqA88NA4ctocP2yYIt9zhcaWBtZn
        U3F2OllCzlwXKUitQgfIVl2z51t7PgO4A/qt30k9k+OBPR4fOkjRdv4bSFmVFwUZ
        YAdrpTaL/N767n3ghGmRbogYFXkhgsLFZFHabBSQXdkzrD9PRevKbJ4Ci8/oE1I/
        SFefh03vXSYPPDU5Vp6D11muniBp1dZQ5Ci59tUAxFu06wKujFet2+sPLT97PUue
        L8M7jpk19Pjeg8ar5R0NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1675985030; x=1676071430; bh=p
        l3VLq+N+exXBxiGGTZPlzdo+vAxKzRkzVcovDyrCSE=; b=D5ZXfC77GH0WrSuus
        n7FtielV4e9ELUXoH2C1SKoioW1TzwyHPgR3G2bIBSJctNgyDV34EdaUrKb2PqOO
        Q8+EJ7O9zS2XjC866H0nDYmUPJ1IaUK2ReTeSDRCsCyWCivEU9tIWDG4gyiEND6N
        NFWb/TCJA+P4VzFbWcuIah+XmsxrLMpmBxf0yHsvN95+QvGrGcUhf8Gf4EKD9FIJ
        BVRqZSvj/BIvOFezPcM9KL33T2HbhjlSaEea/wSvAV3EAE59/DvbE7FdGFkP82zs
        mOicDBl1UJl+XAyUKgS3I+iR7y5v+5Ayck2JnYr09sqoQbZ1N3FvcsJYntb369l/
        KRMaA==
X-ME-Sender: <xms:hoDlY9B53BkYD_bKPVV6EL4WPNnBOdurtlIi-NOiEw7nR1ylEpIBCw>
    <xme:hoDlY7jZBgwxAw60RfU7WlvyryBEYCH_BCVctwoC85A2CjvjUyq0knbvYhxhT1N1b
    IE6M9gfLUh_8-izQQ>
X-ME-Received: <xmr:hoDlY4lbhoPpw09ClW2BRdDJwrXNKrQbEzjLUX4s9V_8zXDtFpJSG7NMW5LFjuruaWXmvviFwfAhQi1RJJde9W-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehgedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgsehtje
    ertddtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhg
    ihgrnhhithdrtghomheqnecuggftrfgrthhtvghrnhephffgfeeutddtudfhudejkeejud
    evledtudeufffhhfeukeejkeekiedtfffhffeinecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:hoDlY3x7oSvGvzG75yPOMyuRi2TadRL4ojy9DSFu7rquD9xHEw2_VQ>
    <xmx:hoDlYyTARkNoy31pJzN5HrsmK-_oYjMyfX2cyEY0fPuGFUT4I-to5g>
    <xmx:hoDlY6bD1g_nCvw90Go8Aug8Cdl3HZ5AwaSahyJj4Uqa585BCEP89g>
    <xmx:hoDlY5OLd_118OXiE5gzf4SAzyLGot_RyI0JFz3Sj1Bo5_fgxcc1Bw>
Feedback-ID: i10c840cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-btrfs@vger.kernel.org>; Thu, 9 Feb 2023 18:23:50 -0500 (EST)
Subject: Re: RAID5 on SSDs - looking for advice
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <a502eed4-b164-278a-2e80-b72013bcfc4f@arcor.de>
 <86f8b839-da7f-aa19-d824-06926db13675@gmx.com>
 <CAFMvigd+j-ARVRepKKrW4KtjfAHGu9gW0YFb6BCegGj5Lj07ew@mail.gmail.com>
 <7074289e-13cd-ced8-a4d8-0d0b23ba177d@gmx.com>
 <CAFMvige6+2z3PHHqns3HD-_zAO+OePSM943_QeS+jxaWXiwi8g@mail.gmail.com>
From:   Remi Gauvin <remi@georgianit.com>
Message-ID: <dc292760-6809-aea4-7d20-de7b028751b5@georgianit.com>
Date:   Thu, 9 Feb 2023 18:23:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAFMvige6+2z3PHHqns3HD-_zAO+OePSM943_QeS+jxaWXiwi8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2023-02-09 6:12 p.m., me@jse.io wrote:
> You know, NOCOW is plagued with issues like this. Imo, it really seems
> half baked, particularly around Btrfs RAID. Not only this, but the
> fact it has a "write hole" like issue on other RAID profiles since
> writes are not atomic, there is no bitmap to track dirty blocks until
> all redundant copies are written, and no way for scrub to resync
> correctly in cases where we could. Would it be possible to have a
> mount option like nodatacow, but does the opposite: it would ignore
> the nocow attribute and perform COW+csuming regardless?
> 
> Perhaps extend datacow to work like this: datacow=on (the default) and
> datacow=always to prevent NOCOW, sort of like discard and
> discard=async? It seems asinine to me that something as critical to
> data integrity which Btrfs is supposed to help protect can be bypassed
> in unprivileged userspace all with a simple attribute, even against
> the admins intention. It's especially infuriating since so many
> programs do it lately without (ie systemd-tmpfiles, or libvirt), if
> you use containers and btrfs subvolumes, then you gotta configure
> every container specifically just to prevent this.


I think an option to force cow would be good,, but in my opinion,
mirrored RAID should, by itself, force cow regardless of any option.
BTRFS raid is,,, ridiculous with NoCOW..  RAID that results in
inconsistent copies that can't even be synchronized with a scrub is
pathological.

