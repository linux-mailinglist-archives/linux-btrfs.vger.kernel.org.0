Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD2C2AE5E2
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Nov 2020 02:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731984AbgKKBgj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Nov 2020 20:36:39 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41515 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731657AbgKKBgi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Nov 2020 20:36:38 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D22025C00E8;
        Tue, 10 Nov 2020 20:36:37 -0500 (EST)
Received: from imap35 ([10.202.2.85])
  by compute3.internal (MEProxy); Tue, 10 Nov 2020 20:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=luHU5AUMcSQRCSNSmu/+YirFYKAtguO
        aSEjXidPWbJ8=; b=M2l48GtdzLsDks4H5HluHpct2qd5brNb5hG1kS38GrvzBji
        ReMzV4uUpx7L3PrA7hLr9Hz4KePIYJBRnREXhkJ/lXDGBJwUMXH/544g3GurxzVG
        IH0aobuwoRSwlssIyGutO43oa1SeC5m0J3XQf+Km04Zg6XsTKT8PjL8CHe/SQVvy
        WV1Iumt9TTr3LRiYmTYDr5psp3PH8Bli8fxSx3siVXw42QDneO2bfeEUd5W/QxC8
        +VDf6hi7mWamh+tpSm+zRIJOaxS2dNXmeaPIp2JUSEqoqXnHU9ZuWZd+36kM07jB
        D/0p3t0kjy1MBirpVWs0MWFwIyIeo6B0n9FsSSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=luHU5A
        UMcSQRCSNSmu/+YirFYKAtguOaSEjXidPWbJ8=; b=TApjeDSvKC6FHvP4qhdKZQ
        G2mjiwBAEI8pAN0AhIqy9oOmtK7E/nrZizgGhOMJRpOWzm3/jBfVDElnd6Nf0g0U
        DNp0eWsUhWgaMzmR+M8+HPab3sJ4yxLHRw8UC0+Jg/BeHTDsd9kIbNz9B24ZHSCT
        g1MsbRcU2lDvDqNYzuCDEeb1g8svAjhzv0YF1igNo70F6YrrH2PGE2lThNxzXaXL
        LTxulykRJ1gMEsI4VOn8phWpnQCvRX4JQ1KUG5E0G6BgpDJgcyN4oC4kHt/VW/NB
        Htz20rCAmdabrYhSK/t1o6yEhUOF51tK7MZMqmsHlWgRcS2U24PJpdlv3L1Wd4Qw
        ==
X-ME-Sender: <xms:JUCrXycpr407zy7S2A6mftRTuUsda4QsXmDbnMIyShkpcLC7ICGJXw>
    <xme:JUCrX8Ord7xxmG1UoLHqnyxKeXV7xeZlFWhz4t0Y5Os5U4cWhQiQ91H6uH_cfTllq
    VcNOnuAm3Zh4f0viA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudduledgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpefofgggkfgjfhffhffvufgtsehttdertder
    redtnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihii
    eqnecuggftrfgrthhtvghrnhepjefgveethfejlefgfedvtdfhffefuedtffegiefhkeet
    feehffegiedtieefhfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:JUCrXzisaSwfctMN7yuyFtB8_frX0HZYlUXtqVZ4pKgVuGWZx9n4hA>
    <xmx:JUCrX_8PPHJHyilymudixWMrFOSzkS5SlsjhUzi1JFs-D5uiVONUfw>
    <xmx:JUCrX-utSbcoBjgzScsdPaoMsDye52taZk1Em_buOiPMjjfcR7KtKA>
    <xmx:JUCrX00Y-y8cQbPjMnsyKaBI7Fpt4p0ufGsuBhTO1xpo5FVDEqbTPA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4EBE614C008C; Tue, 10 Nov 2020 20:36:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-570-gba0a262-fm-20201106.001-gba0a2623
Mime-Version: 1.0
Message-Id: <7af570c7-b2cd-42f2-9f6b-7e2be8e7234a@www.fastmail.com>
In-Reply-To: <e54b68968ee84f69fac0aa58db8495b99c845a82.1604103293.git.dxu@dxuuu.xyz>
References: <e54b68968ee84f69fac0aa58db8495b99c845a82.1604103293.git.dxu@dxuuu.xyz>
Date:   Tue, 10 Nov 2020 17:36:16 -0800
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Cc:     "Kernel Team" <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs-progs: Sort main help menu
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 30, 2020, at 5:15 PM, Daniel Xu wrote:
> `btrfs help` is quite long and requires scrolling. For someone
> who has a vague idea of what a subcommand is called but not quite sure,
> alphabetical listing can help them find what they're looking for faster.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  btrfs.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
[...]

Ping
