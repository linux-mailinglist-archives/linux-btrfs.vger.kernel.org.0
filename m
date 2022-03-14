Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0C64D8F7F
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 23:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245568AbiCNWZ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 18:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245547AbiCNWZ4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 18:25:56 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC44C5FFB
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 15:24:45 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 33D5832009E0
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 18:24:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 14 Mar 2022 18:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=xiBsnhnYHXj9OT
        /F++2SCi/9CbkDfGyLZvYt2bviH8g=; b=iR0ZjT0hzcxYG8HTT+GPv4R5bWRxZ1
        rHphN75ywrn7hwW96QECMLNbXi8y4pl+VWNXkTWwRy1X98XvB9ESYAUMmTENeEra
        1Tiem/7wZ1sDBdTwNYDMXnc6Xkw/Tex4yGELxowRgNUFJj5HiAvi4ccxc/L/CWcv
        pa1s3KwM/iPpHHe+JifotvMCrHy9istlhVtod+2CJtzE1Atq7Kk2ivZknAVKvjXE
        KiVXJ1BKEuc00mgOTONOIeOY19ZepkRqUGBdkSllEr4b+R5VfDzi0YHbIIxZtq1S
        pn+h4iaVV7bJrLNSJWqwpM5LG9VMO8GhPkcWLuLIiFwipbefGo2ey2Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=xiBsnhnYHXj9OT/F++2SCi/9CbkDfGyLZvYt2bviH8g=; b=oRQ36WRg
        opSrAs1kqQl6mLVuuL4wxZAppwvBCm37xT0q+1FcUWeHUTRRh4NTvDfOlMpBwoxc
        AldzbNFtc8ItX0jZuapVUQ1KAQJkQRpo/dNagrFSb9O9SdKJcSvFhQTUhErYLmV8
        psFuJMs2/bL2gBZDWpdVa6JrBvVcWLtV2SkpDdq+uA0D4Gr2DmO2Tx0Nl1bAhFch
        5TcAj5L1VYilEKDjDSH6hBWgAVSSW3Q3vche78TC95JcKR/Q1lW7BL1lBgi1iqIu
        Qsz9OVwnLF6lDkOJFWLicyAcdbHQAZq0bVsSF1JLPZ22TQgOFBQv66mHuymMAOFr
        lwAP/tjqQqXTug==
X-ME-Sender: <xms:rMAvYgNXIyxS_1I33zh6QEDcAuZIFw9aEWvJ0xZZZxrAOVM1mCTefg>
    <xme:rMAvYm_a8qNY3R5BD-jb3MSq6Usn-1OhTwM9_OS5DoBVYJJoNZfxUPjGqKQ1JaqD3
    HzmEJg5GjegC8KBnA>
X-ME-Received: <xmr:rMAvYnQTW5Ye9EHcRWNCJevlE_-N1ujmCxBYzBYMdQM22TUOeIY0uwOS76Sr_pKXO8IhhGmG-wyC8TTnH6jZSc5o1q4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvkedgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepuffvfhfhkffffgggjggtgfesth
    ejredttdefjeenucfhrhhomheptfgvmhhiucfirghuvhhinhcuoehrvghmihesghgvohhr
    ghhirghnihhtrdgtohhmqeenucggtffrrghtthgvrhhnpefhgfefuedttdduhfdujeekje
    duveeltdduueffhffhueekjeekkeeitdffhfffieenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehrvghmihesghgvohhrghhirghnihhtrdgtoh
    hm
X-ME-Proxy: <xmx:rMAvYovsFKS6UWss7sp79l4Y2MKrhzQQVbxqCqT0N8Z1hQXg2pzNKw>
    <xmx:rMAvYodd1X8uaFnsBUGLnwNif-15upgjymc5DfcwtDvc6QH3e70F0A>
    <xmx:rMAvYs24OutbPrM99gOS57x2fW9tybEM9y41WRlFjuomL_UeNGXRzw>
    <xmx:rMAvYipMyOoHT5vvVro7nEvKwv27XUdXu2j9uEFhIfs27ZLbLCbEug>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 18:24:44 -0400 (EDT)
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
From:   Remi Gauvin <remi@georgianit.com>
Message-ID: <cd54e6e1-6180-1685-6500-278c639bb2e8@georgianit.com>
Date:   Mon, 14 Mar 2022 18:24:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAODFU0rXnDhQjGPyuBQ8kxUGBXzQFMkXrNXiSxmcvgaaixspvg@mail.gmail.com>
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

On 2022-03-14 5:53 p.m., Jan Ziak wrote:


> ....
> 
> In this test case, "Disk Usage" is 60% higher than the file's size:
> 
> $ compsize data
> Processed 1 file, 612 regular extents (1221 refs), 0 inline.
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL      100%       16M          16M          10M


It would be nice if we could get a mount option to specify maximum
extent size, so this effect could be minimized on SSD without having to
use compress-force.  (Or maybe this should be the default When ssd mode
is automaticallyd detected.)


