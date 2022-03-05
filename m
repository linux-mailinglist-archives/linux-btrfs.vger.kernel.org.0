Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FDC4CE265
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Mar 2022 04:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiCEDMA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Mar 2022 22:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiCEDL7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Mar 2022 22:11:59 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6488C3DA7F
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Mar 2022 19:11:09 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E344932009BE;
        Fri,  4 Mar 2022 22:11:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 04 Mar 2022 22:11:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=zYAuxlIycTslZC
        wU+Ut+6C55KpdyOyydMKAwPrVJAnQ=; b=UTpp+kxL09mRYwYTYPVdkWeqm4l1bv
        ihJVQy9DEgfXm26usSWol85IkVgC+lVtOEqEPY+Lpux433kP2P21ZdOKgAtFJGcI
        Cuk7Q6g/ctdztYhRehtJfb+zXM8jo/MeTOZ6RsNpEJH1whjsVPUae+8Rr3I49BVl
        e/m1KYeseIb/jHSQSn511LtlNVkEWoHeITOIUcSfsISyYwT1xuiKMsvlqLEmEu0O
        rXvF46yGTheeTo9XQMz7ARQgeuycKkWfzOIZu0qhHWL3AWoYCTaTzop8R8WY0Xle
        oFLddYtsnmdEfO6q4BCjP/ze+1fHhf/KnldDPwuTqEpit0SV2uRt8cWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=zYAuxlIycTslZCwU+Ut+6C55KpdyOyydMKAwPrVJAnQ=; b=Ha8WLxeN
        3m0ejOaTHPE8MgdLS50M4hHdR8uJTi7uKWsP3qafk2z0pcLFzGwW+AuFxnsXDJOm
        Wq/Iv5fF/qbKBcuA2uTmNZ7TKKXPcaS9BmrbbrKjDouPTBYTaKLhY+ROUHxQx+NI
        w53w3MbA5IBZrlU1xxw0a9i+xsPkX7XutwrHntLJv0QCYoLKIDSSL6Tc7LYIvrMo
        0lTLM3R9ZTMVxGX5L89fXI2MjMxAwOnS49QPAeL2I98IF0vCY9GltE0ZQK9PSwTo
        XfC9v+Hu5dRZM0uTj7PRtOC2FuLZ0SYa1uP/hgTe66ZWxthZ2LU38zx5i/uPM9i6
        UgNzcslePK6iTA==
X-ME-Sender: <xms:ydQiYrqEPuWacJWWWbfEahgb5TWlEG8lvYoNZEQNdmZs-PYmsBH8mw>
    <xme:ydQiYlq7S7b71ZNrvFnblcPd5PO11Cfbl0fe29XDbFPdJmgU4nlqM0mCbqum4Uoat
    j3NGPdOpZCg0K1HLw>
X-ME-Received: <xmr:ydQiYoP56WI07ih00gMZFuye7EHea1aM5RWcI2ZILMUqAk7HglKsGmxXFq57gn1NmvtbLtqmpAM0_cCxPYzhSO2Q15I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtledgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefvfhfhuffkffgfgggjtgfgsehtke
    ertddtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhg
    ihgrnhhithdrtghomheqnecuggftrfgrthhtvghrnhepheejhfetudduffffgfduheeive
    dtleekffeludekhfehheffuefggeegkeejiedunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:ydQiYu5acjfkNLUxy-i4W8vfH-2bXkOPV9CRV0dPirf2Fi6zPcxXgw>
    <xmx:ydQiYq5PDs2DhxIQSD57gyFecA-pJvsaKRX1yLczz4nCQhYCz4VwIA>
    <xmx:ydQiYmjd_ANGlrDH5MlR98TlPm7ss0VKv3DPwemTtrrhujv2RAWVqA>
    <xmx:ytQiYgSW9D3KSA_wah1OwK2FRBkAPl7y0VglltDS7W40XgX0cEGysA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Mar 2022 22:11:05 -0500 (EST)
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Jan Kanis <jan.code@jankanis.nl>, linux-btrfs@vger.kernel.org
References: <CAAzDdeysSbH-j-9rBGs3HBv2vyETbVyNoCjfDOKrka1OAkn1_g@mail.gmail.com>
 <2e9ee21e-65aa-9fb5-1d1c-1d6dea93eb12@gmx.com>
From:   Remi Gauvin <remi@georgianit.com>
Subject: Re: Is this error fixable or do I need to rebuild the drive?
Message-ID: <d3ad10fc-0e4a-a8b3-28d7-bc1957bf03ca@georgianit.com>
Date:   Fri, 4 Mar 2022 22:11:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2e9ee21e-65aa-9fb5-1d1c-1d6dea93eb12@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2022-03-04 6:39 p.m., Qu Wenruo wrote:

>  So by now I'm thinking that btrfs
>> apparently does not fix this error by itself. What's happening here,
>> and why isn't btrfs fixing it, it has two copies of everything?
>> What's the best way to fix it manually? Rebalance the data? scrub it?
> 
> Scrub it would be the correct thing to do.
> 

Correct me if I'm wrong, the statistical math is a little above my head.

Since the failed drive was disconnected for some time while the
filesystem was read write, there is potentially hundreds of thousands of
sectors with incorrect data.  That will not only make scrub slow, but
due to CRC collision, has a 'significant' chance of leaving some data on
the failed drive corrupt.

If I understand this correctly, the safest way to fix this filesystem
without unnecessary chance of corrupt data is to do a dev replace of the
failed drive to a hot spare with the -r switch, so it is only reading
from the drive with the most consistent data.  This strategy requires a
3rd drive, at least temporarily.

So, if /dev/sda1 is the drive that was always good, and /dev/sdb1 is the
drive that had taken a vacation....

And /dev/sdc1 is a new hot spare

btrfs replace start -r /dev/sdb1 /dev/sdc1

(On some kernel versions you might have to reboot for the replace
operation to finish.  But once /dev/sdb1 is completely removed, if you
wanted to use it again, you could

btrfs replace start /dev/sdc1 /dev/sdb1

