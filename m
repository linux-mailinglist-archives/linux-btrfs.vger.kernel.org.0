Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0F54CEB67
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Mar 2022 12:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiCFLvo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Mar 2022 06:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiCFLvn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Mar 2022 06:51:43 -0500
X-Greylist: delayed 330 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Mar 2022 03:50:49 PST
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA47D21E2A
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 03:50:49 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 211F35C016C
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 06:45:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 06 Mar 2022 06:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=NIbAD58VRhbARm
        euDerie6FyzAkfhfbzeLKw6oObDD8=; b=lkkInH1rU9qtMRyTWMTIXi8QW+tZ20
        Amlh1S1BEZEIuFrQ3vRTVCnlRrVMwNBaPb+hAxaGh4dk2DB+Cv5GU9gZXOt2BGmh
        Tv+M3sMY75xML2HVp4xgJD1pAW9Zo4ow++hIiVBQqOd1k6BO9fni+kC6UKmgS9Qe
        JImZZ5KAdmCzJazu81BrQ1stz4CyeIAbkD/pqw8SoXMbDRDM6EnUaFCRSLmb2VdO
        uhmVWHgPzeu0cbSe8FSghzG/jw3cZY2vbVEEkld18UNcHX7frKgVrd4Moq6z4i17
        r0s+yrRhsyzdY+K++fWlsqaHDwr/07+KeRpNiJ5uxGVTEZsoVUNevoOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=NIbAD58VRhbARmeuDerie6FyzAkfhfbzeLKw6oObDD8=; b=D1WWQopK
        m8gdHvct7TsbkbJJdDQnnfJUkHFzri4pbxpWFaeXWplkYUznn5MqxgOuBxsEUgLM
        czmstM7f0Io9kj4NJx0fh5B/y7czlk3gCOOG4C1ObNWMWNOjts5q9eeHKuN8DFLH
        mUNDFOp4+6ytXyJ2SihYu83nMU1Yk2tPQsj4MYL6vpU2l+ZebnR5P2MQxYMcO9+p
        mtLU9BYeQyGLci47auGTuGClwsFptI1yO8J8UbAP2rFI8UY2m5eWq87PgcpcHS/w
        KyeNN9LOKBqcVwPov4WIlvIi70RwhDLLkMx+mag8mpBvDvlnJMjO/8al/ma/k3Zm
        dnNeOVQQYBvZRQ==
X-ME-Sender: <xms:zZ4kYmxuQ2t146y3CIUaivM6kBr7uh_7nsECx0XDcwHFXUR8gKHNrg>
    <xme:zZ4kYiQocfwkiW-oayrp-JBDN6s5_qnHFLqjslH8d4oAgAvSA6uCpl-5ZnSedSQY2
    n4i3z52coMTTF4JKw>
X-ME-Received: <xmr:zZ4kYoXHzlafTYId_alYDY9U9a0s3wDYcucjJGmJ3GXGYjXS4CcyqSE4zwEB9_bF22dX-BTsquwxsGKBII1PI8zAu3U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudduvddgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgsehtje
    ertddtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhg
    ihgrnhhithdrtghomheqnecuggftrfgrthhtvghrnhephffgfeeutddtudfhudejkeejud
    evledtudeufffhhfeukeejkeekiedtfffhffeinecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:zZ4kYsjdy0bVwTsZtLA-LWTC1RLw0HqKyn-J_NIzapH5XKyjXuPAUg>
    <xmx:zZ4kYoDism7sYTGHiCvlkoMf_o4M7Ijk8f3lJPuaWuT5z084FZ2bFg>
    <xmx:zZ4kYtIMkCgBeoaKY9Hk7zi7YJy_D5E8Aa71Kl1XQ7HImFHzN7DC_A>
    <xmx:zZ4kYn-7fGvZT4tUpig2yX7xBlaSf75ggSjkWbUtU1zqS_IpUWMn0Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-btrfs@vger.kernel.org>; Sun, 6 Mar 2022 06:45:16 -0500 (EST)
Subject: Re: Is this error fixable or do I need to rebuild the drive?
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAAzDdeysSbH-j-9rBGs3HBv2vyETbVyNoCjfDOKrka1OAkn1_g@mail.gmail.com>
 <2e9ee21e-65aa-9fb5-1d1c-1d6dea93eb12@gmx.com>
 <d3ad10fc-0e4a-a8b3-28d7-bc1957bf03ca@georgianit.com>
 <7c16b26a-e477-d6fd-d3bb-2ed7d086b1f0@gmx.com>
 <YiQzL1evWiPvz59Y@hungrycats.org>
From:   Remi Gauvin <remi@georgianit.com>
Message-ID: <c66abc04-9ab1-121c-01fe-69b8eaafb297@georgianit.com>
Date:   Sun, 6 Mar 2022 06:45:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YiQzL1evWiPvz59Y@hungrycats.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2022-03-05 11:06 p.m., Zygo Blaxell wrote:

> Ideally, 'btrfs replace' would be able to replace a device with itself,
> i.e. remove the restriction that the replacing device and the replaced
> device can't be the same device.  This is one of the more important
> management features that mdadm has which btrfs is still missing.
> 
> This form of replace should read from other disks if possible (like -r),
> otherwise don't write anything on the replaced disk since we'd just be
> reading the data that is already there and rewriting it in the same block.
> 

Ideally, this command would first read and compare the mirrored data.
That way, only stale data would be replaced.  That way, it can be used
with solid-state media without consuming a write cycle unnecessarily.


