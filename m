Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D036E6EB39E
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Apr 2023 23:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbjDUV1v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Apr 2023 17:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjDUV1u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Apr 2023 17:27:50 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED132134
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Apr 2023 14:27:48 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 243045C0066
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Apr 2023 17:27:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 21 Apr 2023 17:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1682112468; x=1682198868; bh=sro736x+Xzhc+QTSVIQovFvUQNkpSn3PbbN
        Fc8XWd5M=; b=lvqDzYtUJWd6i0YNOq03OyDyzlKqAyD3DDTkisysFkgpXZy+x8H
        Vs/WDcA2DO33KkknL9qm+mTUvkCX+PbfHtCQjt3W6omlaSnqHhCAMCJUnF4pvmFl
        JTGpm0cxBQ/DD/gbNjChJS/O53Ib3natS2TkBFR/etXknrR6OuaBtzEI8Yu1bTOz
        BRohPh84bwtKBAgUK4XlOREvWHQr3TmGIJ29QorrbN0ABNkuMzYz1SbsrSlkDnzH
        en4IgxyuJeNjRSFuVfAqic4DNcfkHCxjMmDJNzq3n5BgRrqeMLmtPCsHVpNWBNCn
        rkDni/uclIhd35jNJ9HH2i8VsIJTzPl1yUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1682112468; x=
        1682198868; bh=sro736x+Xzhc+QTSVIQovFvUQNkpSn3PbbNFc8XWd5M=; b=R
        pecJJmOuAjaS2EwstZlLcCdyAg80S4CuGLWYRl5lsi4oe3/zRJfdPPtwLR/bxKmD
        NigC7YYGDyha9c56ok+7L1f3L23BMeeStgLpUZKdeHZRRO9gIS/UKfS7LxDOUg9+
        /P40Ia+R4F9CmeaZlBATHnwzGpTnuXkKKuYAKE2NZYQaKKXBrxZDu4QLh2957NeD
        l2GeMhsC9YTfoAWDnzNTKdbsSia2cnc1JXupo4A95gkC6V6+qVXGqOJ7D6mdeXk4
        ybjdLnZPnMcRgMg4Gq/MNUKqOc8SruCgHuVvlndRSOdCSk0syhl6jQssUal7Zce8
        559es365cfqmmK845C1cQ==
X-ME-Sender: <xms:0_9CZHadYMHfxHDuCJMCdvVXlbF47nxnzojKTJ_eoVHlyZb8aoz1Eg>
    <xme:0_9CZGYrWejKDGEJbxkvkkPCzW1F0wSgk0CMmMwvn3AUUz876LdGuqCNwy3AeMijj
    3284ejjQ0qejfoIlA>
X-ME-Received: <xmr:0_9CZJ92XXg4P57pgs_WBy-LAQFXKNVQGvsQwXcMncVWMxY-e68HrVlstLFvjAiT38ioGRmTheObSNoHhS0c8LNVxKY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtgedgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffuvfhfkffffgggjggtgfesth
    ejredttdefjeenucfhrhhomheptfgvmhhiucfirghuvhhinhcuoehrvghmihesghgvohhr
    ghhirghnihhtrdgtohhmqeenucggtffrrghtthgvrhhnpefhgeffudfhkeefgfejtdeije
    eltdetvdevfeevueehtdduieelveevhfeviefgleenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehrvghmihesghgvohhrghhirghnihhtrdgtoh
    hm
X-ME-Proxy: <xmx:1P9CZNrH1bnWSLmfL-4wehmnqbSLB_zbJH6xHeg7_iDIjMleuVAziQ>
    <xmx:1P9CZCq4z7b1XB3Gqqg1WaB7PjuTjdw-I_x_f7_2hwU6P8_fXJklPQ>
    <xmx:1P9CZDTChSkjPqvqlBHkMdBeooHt4rs9LowMLUe-QANFxc3Da8Zukw>
    <xmx:1P9CZAEl9WQNa1aJGVOYM5Fe7IQd23_qNw1fg0Qr1ZRxGqMFof8w-w>
Feedback-ID: i10c840cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-btrfs@vger.kernel.org>; Fri, 21 Apr 2023 17:27:47 -0400 (EDT)
From:   Remi Gauvin <remi@georgianit.com>
Subject: Re: Does btrfs filesystem defragment -r also include the trees?
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <b7c067eb-e828-35f7-4b26-499173fd07d9@georgianit.com>
 <20230420224242.GZ19619@twin.jikos.cz>
 <6f795670-eae6-6aef-3fd0-dad81bb89700@suse.com>
 <fc0e9969-8414-e947-a768-320516c2eee0@georgianit.com>
 <59643ed9-3e51-f1b1-3719-a30c3c449f1d@dirtcellar.net>
Message-ID: <fc60e1db-f039-8167-f396-ce3119729bed@georgianit.com>
Date:   Fri, 21 Apr 2023 17:27:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <59643ed9-3e51-f1b1-3719-a30c3c449f1d@dirtcellar.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2023-04-21 1:41 p.m., waxhead wrote:

>>
> Are you sure that it is not just files being cached?
> 
> If you run something like find -type f | parallel md5sum{} on the
> directory/subvolume you can see if it has the same effect.

It's a problem I was observing for a very long time, and I'm positive
cache did not help.

However, I can not replicate it now on an older snapshot.  I think
something else mush have resolved the issue and I mistakenly gave credit
to experimenting with defrag.

Sorry for the noise, but to clarify:

btrfs filesystem defrag on a subvolume is *not* expected to have any
benefit without the -r switch?  It does spend several moments reading
and writing data.

