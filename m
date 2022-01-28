Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681B74A000B
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 19:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346999AbiA1SX4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 13:23:56 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59753 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343789AbiA1SXz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 13:23:55 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 88EC25C014E;
        Fri, 28 Jan 2022 13:23:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 28 Jan 2022 13:23:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=xvG22ClJN8iEXW
        NcalKGKwtqVB6WEoJoI3m0oW5juOc=; b=CgyjWjyfSas9pfGkdeRgmWZXk212co
        /ropp3/8mLSOrcj6kdJFMz/RpitrZ4Ms72JW/OeDl3kw0htzvPbzj2Uco2X503rm
        Lp8eLevdUDYYwY2YVKorK6yv6iUOlYn38Zlv/TUG9gLtT9RSZOVngvhmVTL1eITz
        y2JN47gwg6/vuI4T60SVbYNhIvbkk0ik4tTMxMBokCgXfm6xGEsRqNkj0zBT2doe
        UMlDBSEff4MZAWAmkcorwh4iQUTahpdbZ4cB9sdBK8ODRy8UNbYlaMDhObmla1GV
        VmFFa2jSksvaROJnAteaa3anvi4qap8plbzInrCATftkD+EkADaLo8xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=xvG22ClJN8iEXWNcalKGKwtqVB6WEoJoI3m0oW5ju
        Oc=; b=Z7W4DuOTyYXxwTgJ1MPmjAiKsgwOvYUGhHBTGwCSUEJii1pE4WWzg5FL2
        1zYnJS+xFcmsBlmBDLIaEPmBcO36jarlCkKu76+oRFO3zLL5UBrm3XAgdrRFCuDI
        EuQSjHLNSI1D5xe/QGnFkBb4sXKNrc7IBEf0jejmkqN0qESz88T6j7Gh0Vc1+fE+
        Cijgxs9X8VDfhbBwPgg/2gG4JcBMCBn339TzbaO5tXg2mxKlGTuMXbiLDTg+BHpB
        k6mZdG7SpWhY9miJ6RaP4Q+btj147oCZLAqxvj6lsdXuw9MIdPnsqT1JTFM5+Xm9
        R+eNy9vB1+9fxmQWJBVb+LSj9mnwQ==
X-ME-Sender: <xms:ujT0YTCt6wthWMgPapBWZ-ha99qRLv5K6PsRxptBf9NaXZCxONnJyA>
    <xme:ujT0YZj5J2E_Nk2Ki4QxVlv7TXVAwoKtD4gGdEykrd56afpBIbtwT4PCSSwc2THPp
    kDrurQJknkDLi_zAg>
X-ME-Received: <xmr:ujT0YektxCfFl12kIrfkNZCDJ2KwEVLYneMgYR0DYwfOyMqdakKqAnLL2jpBF7EQCt_Cp13MpnDe4nwJ4pcuIkpbjJ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfeehgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefvfhfhuffkffgfgggjtgfgsehtke
    ertddtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhg
    ihgrnhhithdrtghomheqnecuggftrfgrthhtvghrnhepheejhfetudduffffgfduheeive
    dtleekffeludekhfehheffuefggeegkeejiedunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:ujT0YVxOdtXvAXp8D26xzSByQNRJ6DjleBbUTI4xkJySnKC9T4iBSQ>
    <xmx:ujT0YYTJ2W6PNJwtmEmPSuAoXEI3bp-r7Zl474qeGlgU9t9BjEpg7g>
    <xmx:ujT0YYYBXpyOVWdQ1vmXj7wSg_M-Yfp5z5PY-X3mbZ76kE0eiyFBpw>
    <xmx:ujT0YR6_x3qQZ3itsxRw04DL3Xzx69ezGu4cfAlcHGclH00MpTa6Bw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Jan 2022 13:23:54 -0500 (EST)
To:     Kai Krakow <hurikhan77+btrfs@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <10e51417-2203-f0a4-2021-86c8511cc367@gmx.com>
 <CAMthOuOg8SVYrehoS4VS=Gj4paYyobmqX85bKzGxYcG-2oJBDA@mail.gmail.com>
 <5e538d4d-e540-0dfd-0ad6-286bbe5739e8@georgianit.com>
 <CAMthOuNVxu5b9=RLYMbTnz=zcwtC9K5GHD_hjcGyb80sps_MOA@mail.gmail.com>
From:   Remi Gauvin <remi@georgianit.com>
Subject: Re: fstab autodegrag with 5.10 & 5.15 kernels, Debian?
Message-ID: <215b4b90-5199-57c1-b762-266245a0263c@georgianit.com>
Date:   Fri, 28 Jan 2022 13:23:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAMthOuNVxu5b9=RLYMbTnz=zcwtC9K5GHD_hjcGyb80sps_MOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2022-01-28 1:07 p.m., Kai Krakow wrote:

> 
> So the question is: Does the space and performance overhead just come
> from metadata? And using compress-force just "fixes" that from the
> other side? For HDD, the seek overhead is probably the dominant
> performance factor and you'd want to avoid that by all means.
> 


The Space overhead happens because CoW extents are immutable, and are
not removed or modified until none of it is referenced by a file.

So for a VM image example,, you write out a fresh image, and most of it
it is in 128MB extents.  Your VM scribbles litterally 10's of thousands
4k writes all over,  Each of those 4k writes is a new extent.  Even
though it replaces the data in the old 128MB extent, that space is now
consumed twice.


I don't know why compressed sequential read is so slow on HDD with
compression.. I suspect there's some optimization that can be done to
fix this, because the same data can be *written* sequentially at full
speed, but not read back.




