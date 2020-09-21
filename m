Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C93E2730C6
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 19:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgIURUI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 13:20:08 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46871 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726991AbgIURUI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 13:20:08 -0400
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 13:20:07 EDT
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id AA4A55C0213;
        Mon, 21 Sep 2020 13:13:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 21 Sep 2020 13:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=fm2; bh=5Un/rAP2bNsPAcdNhW6C0yPPHkQMvz+gjm1DVuFH
        G30=; b=dJoGia7JyyhDcpYJZ8Z+Eo9rX8l/5v/OS8gNtijF3H3v798Oq/nzcsOC
        QDik4q05y2YrQoHWY9utzN9DkJ89RqHKz2nQujLQI2mpXgSrcQzDMIv1pFxjEiBr
        e+Bf1cXBMHNjYtakqVGL0+WSDd7TjXRQ2jeWAIly63Iy82wwp2qYFu+HXXCci5mq
        PWAqs2IC5j04b4b3aRCVukvmHH4JbECZR9S4lOp9SLHwhWSoFztRNFmzWeUTDTNa
        qTi4eGjMq8ho2yXeE+uiuENEiEdplOsl1unzLSuMhb0Y4vZwjNAVMMJF1aFDeChZ
        cZq1p45o6ifYLjr2a7unP9ZKgSeOwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=5Un/rA
        P2bNsPAcdNhW6C0yPPHkQMvz+gjm1DVuFHG30=; b=uF5lYUm11n+PVK+ww5zxz4
        6aZhJtMCZNfMKjvm6Awp52kF9BB7f+dnynZoQTiVcOAfezfxfP13Mq350/gSHcEJ
        8lKujz5T4RNUA/M0GBtsDCl/T5mT0MYSKv19iNXrCy7wowYNcDcmXqMLV5JfbUT+
        PPZcIyNjrJeZTA0zBYOXP/B6B+CFy1o6fE1ljoz0/jjXQmVBz9T7TRGOouS4TeCR
        AdgEP9RMKz1PpGdajM9HnK2rSGfKOIQieufBZuhyfi79DWrHM5pLwVoUbdzgeCQT
        egwOIXM7xtiOqJ5TswYeUY5qZtoSEzIEACU7OTYCAmbUswxllqTac7FtmGqVWpGg
        ==
X-ME-Sender: <xms:Md9oXzsFuQ1m1FlaI4uBtMPwIvrsWyEB-m9nwRapkoOlWR5BtUmQlA>
    <xme:Md9oX0dY1FadIzJSQaHKPC0e2xcXbvJgaXR7-3P8XJZL5K6stRersDKTJzoa4c9CP
    PjgALxiTw2YKDB3WC8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    eugefhvdffgedvuefgffeufeegkedtuefhtddtveevgfekleelkeeiueekleelteenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeduieefrdduudegrddufedvrdefne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhi
    shessghurhdrihho
X-ME-Proxy: <xmx:Md9oX2y4japuzfRjy_Ki1q3qZfoXhJ9rLaCIxXxMwa_xGL0eYzUhCg>
    <xmx:Md9oXyP6e-LKpv2aSf0eNZ9tXbUt4tIOWXPMnC1j_Aipi-Bp_NJmJA>
    <xmx:Md9oXz-3DADfxZCHUPKimbeCUyvkKPsGveUaev-PVksOwMGIpe8Pug>
    <xmx:Mt9oX9kGvTFdNJscpDwEl4YEFOEMvflwthyilNVhQuhqBcGiVnuWmQ>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5F5AB3064680;
        Mon, 21 Sep 2020 13:13:20 -0400 (EDT)
Date:   Mon, 21 Sep 2020 10:13:17 -0700
From:   Boris Burkov <boris@bur.io>
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/4] btrfs: use sb state to print space_cache mount option
Message-ID: <20200921171317.GA4045720@devvm842.ftw2.facebook.com>
References: <cover.1600282812.git.boris@bur.io>
 <e7fe51d3013637cfe2bc9581983468d5940fdce5.1600282812.git.boris@bur.io>
 <bae2283f-ed1e-d09c-55bd-afedabe9b3f3@toxicpanda.com>
 <20200921170405.GL6756@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921170405.GL6756@twin.jikos.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 21, 2020 at 07:04:05PM +0200, David Sterba wrote:
> On Mon, Sep 21, 2020 at 10:50:25AM -0400, Josef Bacik wrote:
> > On 9/17/20 2:13 PM, Boris Burkov wrote:
> > > To make the contents of /proc/mounts better match the actual state of
> > > the file system, base the display of the space cache mount options off
> > > the contents of the super block rather than the last mount options
> > > passed in. Since there are many scenarios where the mount will ignore a
> > > space cache option, simply showing the passed in option is misleading.
> > > 
> > > For example, if we mount with -o remount,space_cache=v2 on a read-write
> > > file system without an existing free space tree, we won't build a free
> > > space tree, but /proc/mounts will read space_cache=v2 (until we mount
> > > again and it goes away)
> > > 
> > > There is already mount logic based on the super block's cache_generation
> > > and free space tree flag that helps decide a consistent setting for the
> > > space cache options, so we just bring those further to the fore. For
> > > free space tree, the flag is already consistent, so we just switch mount
> > > option display to use it. cache_generation is not always reliably set
> > > correctly, so we ensure that cache_generation > 0 iff the file system
> > > is using space_cache v1. This requires committing a transaction on any
> > > mount which changes whether we are using v1. (v1->nospace_cache, v1->v2,
> > > nospace_cache->v1, v2->v1).
> > > 
> > > References: https://github.com/btrfs/btrfs-todo/issues/5
> > > Signed-off-by: Boris Burkov <boris@bur.io>
> > 
> > Dave already took this, but next time I'd prefer if we'd keep logical changes 
> > separate.  So one patch to change /proc/mounts, one patch to deal with clearing 
> > the free space generation field if we're not using it.
> 
> I haven't taken it yet, adding branches to for-next is only to get test
> coverage, by 'taken' you can count addig it to misc-next.

Would you guys like me to split it up? I felt it was worth keeping the
two changes together because changing the mount options without clearing
the generation will break /proc/mounts in cases that currently work OK.

e.g., I believe it will never show space_cache=v2 if you have the
space_cache if look at generation, and the generation has ever been set.
