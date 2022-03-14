Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833EE4D900D
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 00:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbiCNXI5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 19:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237832AbiCNXI4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 19:08:56 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF8E38F
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 16:07:45 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 6B1CF3201DFB
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 19:07:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 14 Mar 2022 19:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=3G3dZ5V5cIAEFn
        duBTxQ0hM95qgCWOS76pbim29/mzw=; b=dVR2SIZq+ANuJqvjSJmC8ch0XY7hyj
        VDABblsGG3cvbZWY/9vOlsSdvOO6o55vLJiVnK0K0WBBs1sj8uSSDXxD1FsPq2qd
        oh1LCxhCaj4pxyCkg8PbCIbAormf4SwPjh+IY1l2e64c3J/0v9vcLUT3jVdOvOFE
        2WZflx5vFVGesayORU/Bv98U/VvOqnhvGaQkNLwRWt9Bg+xTDMpIs0CE8UeNrzoS
        ie523Nq6SW57Rk1/v1GB8CvcBlpiIn9Z9HVUGdQc2/hW+odoT3Tnd6t6JBWfOVPK
        WhdiJ80mBNaKxAajr8zNM2YsL7HGWdgor0f96CoyW3xpPZypygs1DoXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=3G3dZ5V5cIAEFnduBTxQ0hM95qgCWOS76pbim29/mzw=; b=NI0ad0e3
        bKQv1BOuj3tAvicT4zbB6UWoeOeCczmZ8aklc61PIqkR+ZIs9rkx1BOtDpVjn9fC
        ETaCQSaLbQNdvx0tPhUWt+nNtxZ0yKls0eFXSg+fr4tG83MTASwdsz8X3c+JEKyH
        XsYCd4Yu++OV2rSdD+4IlaPfVDV8vxcsDPFKSpTxfw3xliN0EnVGQ56lS7iWxmA4
        pfGcIndXeT9rvT5mWyBVpaNuKqDbvQIGPJkUNJYGv2hKNVX5YIaPuv+eG5LvsA2O
        DYMR0QzghJCTbvtWZ98fAm5wGNnxaBFMEMP59VrcWozakbvogijG9A4fbV7WWay0
        X7c/e0tSrxTJlw==
X-ME-Sender: <xms:wMovYjk0WF-ybAWuIGSqql2XX2WpYOVD0cnKfwhXgEWT5LDHU8J_jg>
    <xme:wMovYm2O-7HooDyZNg8iMjBE_mLWL7ylHgbm5_R2lNLL9wWLhglkrFRc1suBe3oPk
    Pl0j17Lk368iPdTpA>
X-ME-Received: <xmr:wMovYprq7ZPgJaru8tnVc0BEQQ4Zzg1UqwQ1TrMx3b8kYHbSuW0Uzh00KFgFJ3AmkCgn3d6XSxNMEVcexxOM3nw4bY4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvledgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhuffvfhfkffgfgggjtgfgsehtje
    ertddtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhg
    ihgrnhhithdrtghomheqnecuggftrfgrthhtvghrnhephfegffduhfekfefgjedtieejle
    dttedvveefveeuhedtudeileevvefhveeigfelnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:wMovYrmr7tOtAVGSEpla3gyVqLbdrbJFInO4nbGoouzq4qBdG6Oc_A>
    <xmx:wMovYh0Yt6MTmoVTMKcuEOhIMeeYwh0eTSpHOAXN38ITQVbTFI7XNQ>
    <xmx:wMovYqvuQRaSp5NBcHdzYi-WLV0xAAB_HvDb9N8dQwN77Jo8OkZCRA>
    <xmx:wMovYuhBaOdHtX0bnoNEnYi1UfY7h-Oy8KKid2w5piWUwvLMPYbQrQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 19:07:44 -0400 (EDT)
From:   Remi Gauvin <remi@georgianit.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <87tuc9q1fc.fsf@vps.thesusis.net>
 <CAODFU0py06T4Eet+i0ZAY5Zrp5174eQJOCGh_03oZdDXO55TKw@mail.gmail.com>
 <87tuc7gdzp.fsf@vps.thesusis.net>
 <CAODFU0oM02WDpOPXp1of177aEJ9=ux2QFrHZF=khhzAg+3N1dA@mail.gmail.com>
 <87ee34cnaq.fsf@vps.thesusis.net>
 <CAODFU0rXnDhQjGPyuBQ8kxUGBXzQFMkXrNXiSxmcvgaaixspvg@mail.gmail.com>
 <cd54e6e1-6180-1685-6500-278c639bb2e8@georgianit.com>
 <Yi/G+FFqF8TlafF3@hungrycats.org>
Message-ID: <23441a6c-3860-4e99-0e56-43490d8c0ac2@georgianit.com>
Date:   Mon, 14 Mar 2022 19:07:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <Yi/G+FFqF8TlafF3@hungrycats.org>
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

On 2022-03-14 6:51 p.m., Zygo Blaxell wrote:


> 
> If you never use prealloc or defrag, it's usually not a problem.
> 


You're assuming that the file is created from scratch on that media.  VM
and databases that are restored from images/backups, or re-written as
some kind of maintenance, (shrink vm images, compress database, or
whatever) become a huge problem.

In one instance, I had a VM image that was taking up more than 100% of
it's filesize due to lack of defrag.  For a while I was regularly
defragmenting those with target size of 100MB as the only way to garbage
collect, but that is a shameful waste of write cycles on SSD.  Adding
compress-force=lzo was the only way for me to solve this issue, (and it
even seems to help performance (on SSD, *not* HDD), though probably not
for small random reads,, I haven't properly compared that.)

