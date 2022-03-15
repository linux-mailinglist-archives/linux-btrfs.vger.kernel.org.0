Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CE04D9D27
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 15:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347714AbiCOOPT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 10:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349051AbiCOOPR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 10:15:17 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C9B4704D
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 07:14:05 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 4D28E3200A2F;
        Tue, 15 Mar 2022 10:14:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 15 Mar 2022 10:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=lNsc7Vo0Ni5o6Y
        WIH2hy4ImpGC+foIx6KCgLVXarEzM=; b=lFoQDOIJrnYiAj4zmhNb5RIxx3Y+I0
        BKcJc2RymvH9JNjnMgjfwy2yStSGMzu1IO/p2D4uQp0yHDNdlZzA2GzdpuIRaTKz
        1TlXTITiceVCDD/EjPVwzHnKfDHekcNeVwLiOoWyLAkkzJbPOt/BxoVySnd9Kuob
        pVEXGjho1tqMTkTRYGz9shtg94EVp9kKjmlwRQyDz3m3K/XIoDJNYsGz0+PyLS9p
        5w3bxZ2SerZ3aWKkrFDdGCFbJuIoM2tUAgLb9dKtndfR8xA2xxaTnR6p8O3HyR8f
        j2KaAi3sqli5/0l9kSw0rX4Ynm8iSQNQuyrUbqYZ1lmks0nXcKjCMGZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=lNsc7Vo0Ni5o6YWIH2hy4ImpGC+foIx6KCgLVXarE
        zM=; b=EG4ADOqvSG9IrTweHp3Mh59FCL/bIXTnnAS9r7wpw+8HWEbU/bAKMGdBy
        mjMX7IUiSl0Plc73UjJy87siu96CTIC62+u952JJ8JEwSal85DPti+pujDT93hZc
        q6u8B6GtQhZTJSNSIGIiCH8ztOTrJGowt6iFj+h1xKULaxgY0p1QvPP4orYUdrVZ
        llkc2/sgsghZv7lvH+//VU6BWKyn2jU9/TGwE0vZKCASsTDK8m5m4KmJTWIlOEea
        D0sd/FbWix7DWEL4itzC9zYJOut1vzaHEQmtGkCUb6Lfdx0+i97KbrANrVHciEVk
        cu/HhxVubxx7n8BEXjjFokmRDd0kg==
X-ME-Sender: <xms:Kp8wYhrwtC_XLAwNjSJ9Rqsk8VLv2rF1d9Ddk8V_sn5O3KvstUUUqQ>
    <xme:Kp8wYjqzrws7mvRBPUbrtVKpmQlRtJTKmJPIQ9elq5qqMDyxoJ7OYnEeZ_0x-dLJQ
    j8itwQQzEf_8f2zrw>
X-ME-Received: <xmr:Kp8wYuPDrVHtxCnOj0w74LSz4WXG20CZFSAIBfVneMZ82fCjCw5ZmgM09_I8mAJQFUp7DtSfpgbxAv7xLpVCwvLxXsc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeftddgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefvfhfhuffkffgfgggjtgfgsehtke
    ertddtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhg
    ihgrnhhithdrtghomheqnecuggftrfgrthhtvghrnhepheejhfetudduffffgfduheeive
    dtleekffeludekhfehheffuefggeegkeejiedunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:Kp8wYs7FIZnJfwiaXA8hcjusTix7FXU3juaLIVyLq1-DtKjATzOXVA>
    <xmx:Kp8wYg4RRMV3Th_5ybEC-fugfgCzIsm4dDkZtlqqPMKSRy5wfJMF3Q>
    <xmx:Kp8wYkhzHIMazbTXr1lXZHqFWu1X1fmCnGMuhMrB2ZUq4jT875nDEA>
    <xmx:Kp8wYlhaLOnD3KKmWHVwPJarl4IJZRFIIzBe7OjvGcS4za_JZDcPVQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Mar 2022 10:14:02 -0400 (EDT)
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <87tuc9q1fc.fsf@vps.thesusis.net>
 <CAODFU0py06T4Eet+i0ZAY5Zrp5174eQJOCGh_03oZdDXO55TKw@mail.gmail.com>
 <87tuc7gdzp.fsf@vps.thesusis.net>
 <CAODFU0oM02WDpOPXp1of177aEJ9=ux2QFrHZF=khhzAg+3N1dA@mail.gmail.com>
 <87ee34cnaq.fsf@vps.thesusis.net>
 <CAODFU0rXnDhQjGPyuBQ8kxUGBXzQFMkXrNXiSxmcvgaaixspvg@mail.gmail.com>
 <cd54e6e1-6180-1685-6500-278c639bb2e8@georgianit.com>
 <Yi/G+FFqF8TlafF3@hungrycats.org>
 <23441a6c-3860-4e99-0e56-43490d8c0ac2@georgianit.com>
 <Yi/SR7CNbtDvIsPn@hungrycats.org>
From:   Remi Gauvin <remi@georgianit.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
Message-ID: <eda21cae-4825-458a-dd69-1e2740955dc0@georgianit.com>
Date:   Tue, 15 Mar 2022 10:14:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <Yi/SR7CNbtDvIsPn@hungrycats.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2022-03-14 7:39 p.m., Zygo Blaxell wrote:

> 
> If we're adding a mount option for this (I'm not opposed to it, I'm
> pointing out that it's not the first tool to reach for), then ideally
> we'd overload it for the compressed batch size (currently hardcoded
> at 512K).

Are there any advantages to extents larger than 256K on ssd Media?  Even
if a much needed garbage collection process were to be created, the
smaller extents would mean less data would need to be re-written, (and
potentially duplicated due to snapshots and ref copies.)

The fine details on how to implement all of this is way over my head,
but it seemed to me like the logic to keep the extents small is already
more or less already there, and would need relatively very little work
to manifest.


