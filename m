Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B35A7D765F
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Oct 2023 23:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjJYVIN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Oct 2023 17:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYVIN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Oct 2023 17:08:13 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5F212A
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Oct 2023 14:08:10 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 67AD45C02B3
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Oct 2023 17:08:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 25 Oct 2023 17:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1698268090; x=1698354490; bh=UDHJOsBy3UKF8Wd3vaUXiBqrxdSO2RYlhMK
        xbCu39wQ=; b=LW1t4PTXfqVGM7sw/gT2YBwEJ+EX3MW0J7xkSEQBsGAYYgFUR2V
        XFQTEiDeCwqBkBevddi0sjk3wVemzCdPeFWHr5BLAEdLJhHq9v2ow+IKjgIrdWmd
        SaDFwSn5TA8H1LhryV7Pe5yWfgXZcdzZW194eMliYtdm1SgTQnvyQMFAa1QQlRav
        wJufG7azEaxKm4moAoh+gFDo0+qJeui4AZsrAxvnhTJPLYO4AjbowpWyQf8/eSr0
        wPOmFX2e655CNG7WuD2ik5kMZIx2tU+6g6UKQVPOZL7MECUVzytBTrGWYDg50XGs
        atu86bb1GIX4xFgsflHhXxNN3PDOQe9aH8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698268090; x=
        1698354490; bh=UDHJOsBy3UKF8Wd3vaUXiBqrxdSO2RYlhMKxbCu39wQ=; b=C
        BiVXMpIia6cXwU0zzatknHYlPRXCTO7J/BqvEBjlRgSYf1LdnaFWGlHvYasQyP4J
        8e3Whc8yL/eFkRp0iL2/8GuL3lGi9TBU9QfSOiYrAy++Rw7nDwNZfuy99ExsWDqS
        eKEmmpmDCkPwpJabPwxehe46SGy3ClGhDHebDuLj1dTuarUPioSdi6EkGa85+mKk
        Z8qc9yrdP9RNzHRJmvYm/aWZOof1nnODMwow+uV6e2UC6wvMSyvFTQirsRW53w2r
        vocGisRgz0YP0zeuKfTjYVdvFr1jsrgqTEHgp7m/URl2xfXt9pWC8VS2BkivuzvJ
        9Vd/LL2zhpCyOWIkysLXg==
X-ME-Sender: <xms:uYM5ZWexFIbKUFiLwLVpzKNcEkBkMbJO1NgnuYLGErSFHCjfGBfM_g>
    <xme:uYM5ZQMvHNMhYNfKGl5AlkgzsT5xGaXzqiCkWVzq9cz7HIhu83U7jV03ggbQVmT-i
    xMa1e82qyRFh3W2tQ>
X-ME-Received: <xmr:uYM5ZXgOYR06HDNdCpkFOXu_cYubUMFvuMYSUhiyMqa58ENTobsZYdNiLtbPjOeQzsp0WpMq2SHUs19ToWP8GJkIYkE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledtgdduheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgsehtke
    ertddtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhg
    ihgrnhhithdrtghomheqnecuggftrfgrthhtvghrnhephfdtueehgeevheettdehjeffgf
    etffeuudethefhveffteevhfdvffduudduiedvnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:uYM5ZT9l1mDU7CUBiVz7ujgRz2LwJcOO18AAQsrQXOuLRI-_hIF2eA>
    <xmx:uYM5ZSt6lw7_J_XCJUaBPZO4J3d1BfycG340WvXMik-QCRaByMfvzg>
    <xmx:uYM5ZaFCzLihTHYkAItedaz3YFpGUbAoJnQJmeyLfM8r7OYvFTufww>
    <xmx:uoM5ZT4fCNBHlcMdrhhKsCK0KWDrhSMbqwPLiP61M1TVYyw89JI18A>
Feedback-ID: i10c840cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-btrfs@vger.kernel.org>; Wed, 25 Oct 2023 17:08:09 -0400 (EDT)
Subject: Re: Balance on 5-disk RAID1 put all data on 2 disks, leaving the rest
 empty
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <erRZVkhSqirieFSNm0d1BF5BemFMyUSCjGKT73prpKS7KDydKhqAvNqA7Eham7bQXmmh0CCx0rep6EAKKi_0itDlOf94KZ1zRRZfip_My4M=@protonmail.com>
From:   Remi Gauvin <remi@georgianit.com>
Message-ID: <16acffd1-9704-9681-c2d4-4f5b8280ade0@georgianit.com>
Date:   Wed, 25 Oct 2023 17:08:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <erRZVkhSqirieFSNm0d1BF5BemFMyUSCjGKT73prpKS7KDydKhqAvNqA7Eham7bQXmmh0CCx0rep6EAKKi_0itDlOf94KZ1zRRZfip_My4M=@protonmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2023-10-25 4:29 p.m., Peter Wedder wrote:
> Hello,
>
> I had a RAID1 array on top of 4x4TB drives. Recently I removed one 4TB drive and added two 16TB drives to it. After running a full, unfiltered balance on the array, I am left in a situation where all the 4TB drives are completely empty, and all the data and metadata is on the 16TB drives. Is this normal? I was expecting to have at least some data on the smaller drives.
>

Yes, this is normal.  The BTRFS allocates space in drives with the the
most available free space.  The idea is to balance the 'unallocated'
space on each drive, so they can be filled evenly.  The 4TB drives will
be used when the 16TB dives have less than 4TB unallocated.


