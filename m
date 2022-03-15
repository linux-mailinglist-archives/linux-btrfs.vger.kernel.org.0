Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5266C4DA338
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 20:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345783AbiCOTYB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 15:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345039AbiCOTYA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 15:24:00 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CADB1E
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 12:22:46 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id F07D75C0243;
        Tue, 15 Mar 2022 15:22:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 15 Mar 2022 15:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=ugv531OgHik20g
        qVEWjn0TCQjvQSBY16lXr1WwRPT34=; b=M+k1mz2QyvrFsLLN+l2RfpIdH9FkaZ
        NFgVixwYINRrN3tUooXLuwnFYxRNM12Veth4VMWFN0IZdKfybo9sDnX1F1bAudBt
        VaKO0qndcegpxYVFE46mAlLfC40MXsZrWPD51K5cY2McXiQbJ35dASXVUgxGM3hh
        9IUAu2q2DTrFVVpOOLa+HZT0uvFT7IDO0x6c7ONBDIybFSDjATd2nxZsSxKkQPlX
        k7hpUBiywN7etO58r8YWdXqlRZGzcD8BbrUzTQanKPRJZOLvXXhqTK7S8LjSWl/q
        r6PRQ5V4F/gGJulzto0L39FozMLRV8neLd3ycXNXXRuBLpOqpq1avt8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ugv531OgHik20gqVEWjn0TCQjvQSBY16lXr1WwRPT34=; b=P2eWrvSj
        fsTappavOnF92SygIe4avwG3YMQJVv071tWpcLHeJVVJGvJKz5WAg1KugQzoJ/hV
        2NmQ3j9ohcdKTF+/ibTn+N+lVUfOa6fboDO/eszKEwPn4uNhgY4WXhWLymPwNm5d
        sYB/rrxHScizgc0DZYoU2cMLZtOqA2eLsNgMCd3J6GhwMjrZvtbnO3j+aichjx6C
        L9STfYSsYP4YVkOrGTZg1SVDesKyc1SbfvBFiXGBE3n/0+kTEA9NFA94HwKDe0zL
        90thdDCNJIj9YJzokEQ+E+uTJSFUJxBxlHHQ2ygVXNjGY1NRdO0g+oqQL0Ba6OeU
        1oZXaje6gA/cpA==
X-ME-Sender: <xms:g-cwYg2Ga-_Xq7fTYdj_imhoTgoYFv5wbCWs3tbvHwqFpn2PmhmW3g>
    <xme:g-cwYrHdKa3_2ije-iVKgbCAAOvoCYIeClqeJAQilI6iop1FLnTkAVOiz7zPa3leY
    0cuKinRnr0pemUI4A>
X-ME-Received: <xmr:g-cwYo7CjCwJ-IeD_Oqql7dRTfC9uQrtACBDfPf93HfDO0QJhSSk5oP73S3WMSQNDZe0gydBUwXsh9lFICVl9-FhOAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeftddguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepuffvfhfhkffffgggjggtgfesth
    ejredttdefjeenucfhrhhomheptfgvmhhiucfirghuvhhinhcuoehrvghmihesghgvohhr
    ghhirghnihhtrdgtohhmqeenucggtffrrghtthgvrhhnpefhgfefuedttdduhfdujeekje
    duveeltdduueffhffhueekjeekkeeitdffhfffieenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehrvghmihesghgvohhrghhirghnihhtrdgtoh
    hm
X-ME-Proxy: <xmx:g-cwYp3WhTIoGFiYK0kpRfg8AhZd0smA-M1jXZbQvtaa3tZry5u_gA>
    <xmx:g-cwYjEzzfxo00HdztPcXKlwRJlyFxIgv85rf40kYfg7miup2j4ZnA>
    <xmx:g-cwYi9uby8Ythx-v-rH-F0bw1Q7bkP3UL3ez5XWy3Tqb_9Sylu7YA>
    <xmx:g-cwYmNjzqPO0x73_hUCs0jDbNwEb-TsO1FUh1zbUBNKGfEuQGChbg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Mar 2022 15:22:43 -0400 (EDT)
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAODFU0py06T4Eet+i0ZAY5Zrp5174eQJOCGh_03oZdDXO55TKw@mail.gmail.com>
 <87tuc7gdzp.fsf@vps.thesusis.net>
 <CAODFU0oM02WDpOPXp1of177aEJ9=ux2QFrHZF=khhzAg+3N1dA@mail.gmail.com>
 <87ee34cnaq.fsf@vps.thesusis.net>
 <CAODFU0rXnDhQjGPyuBQ8kxUGBXzQFMkXrNXiSxmcvgaaixspvg@mail.gmail.com>
 <cd54e6e1-6180-1685-6500-278c639bb2e8@georgianit.com>
 <Yi/G+FFqF8TlafF3@hungrycats.org>
 <23441a6c-3860-4e99-0e56-43490d8c0ac2@georgianit.com>
 <Yi/SR7CNbtDvIsPn@hungrycats.org>
 <eda21cae-4825-458a-dd69-1e2740955dc0@georgianit.com>
 <YjDgKzAx/tawKHCz@hungrycats.org>
From:   Remi Gauvin <remi@georgianit.com>
Message-ID: <97800cf4-b96d-27f9-1ed9-b508501e5532@georgianit.com>
Date:   Tue, 15 Mar 2022 15:22:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YjDgKzAx/tawKHCz@hungrycats.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2022-03-15 2:51 p.m., Zygo Blaxell wrote:

> The main advantage of larger extents is smaller metadata, and it doesn't
> matter very much whether it's SSD or HDD.  Adjacent extents will be in
> the same metadata page, so not much is lost with 256K extents even on HDD,
> as long as they are physically allocated adjacent to each other.
> 

When I tried enabling compress-force on my HDD storage, it *killed*
sequential read performance.  I could write a file out at over
100MB/s... but trying to read that same file sequentially would trash
the drives with less than 5MB/s actually being able to be read.


No such problems were observed on ssd storage.

I was under the impression this problem was caused trying to read files
with the 127k extents,, which, for whatever reason, could not be done
without excessive seeking.


