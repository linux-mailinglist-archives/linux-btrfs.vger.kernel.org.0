Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7CE321E7B
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 18:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhBVRsk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 12:48:40 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52941 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231737AbhBVRsh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 12:48:37 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B32A05C0203;
        Mon, 22 Feb 2021 12:47:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 22 Feb 2021 12:47:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=fuONmJ5scLuuL6VN4ly00RRrikr
        SrhHzaZzRtqzMfCk=; b=l7hvWEiFz6JkGl3ixSA59qYMASbqo09jD12mW0WR+XA
        Mz3t0O0a8WGhj47g1go8CCtyyIufc9EoLW0Scj9ZBvGabSYS70OWj+IYa53BIlyS
        7rgfOr+qvdj88DaNtob/hGH6jyKqjOlshbCmXmVOOn+15sS3+V1wPwhxabBopOiS
        LnHRrYwFGd5iFWLaC+7pjUp700bDoA1gqJEhayMuvRYIG9dqV0A/cA/5/VGou7GY
        qhduBR+ihgRhikVkBixAZFvWbGHAyw1JoMxRMVV1//Ub3XIetWqU1pqPhPjkfkqR
        AEPYB+hrNaiQlWqT4cWxekzE9zeJOdvqQcNPdCX2USA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=fuONmJ
        5scLuuL6VN4ly00RRrikrSrhHzaZzRtqzMfCk=; b=n0upqZQKqtrHURaScyly4a
        Ln/Q9OexPdE6pyqidyUeyqb4Hbv0NLn7S2iGFcxnsFR/pPhDzsM7Lgk9TkiKG1lL
        hXM2AQYElHEwmYt9BFwt2++YM6N5g/ld3rwOUJW8I8foUf0mDd/Q8CzcpZefCQ2l
        41Aew9vaatolxqiheGZ46ko5ZpvbM1xVsNlCt1uqkyyPQ0Ye94sw5wulfWODscl5
        fsVVKCbEqeJ/LJzE6cC9aBTnAYqy4E3Hc2tLc6A+8FWIGI3dMgbdgOC1o1qU2ce7
        CSZJ4Vee5bBEZesLjJZ+beLj2U5ExctN7HNmmq1wRyb7FKLAE2m2cJDryd6yHqgQ
        ==
X-ME-Sender: <xms:Ru4zYLoJ0A_BWpyRahGMPSp5r6aQQwWmPPInmducHypH5Xmjdd0_HA>
    <xme:Ru4zYCz93hzrV44BU8ECaevRJux0-Q_Qy_aKJQwwID3t-4Ge25ZAXWJBtU9hXPNDz
    AA-jz5rwipkaJBgEmY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeefgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    dvhffghfetueeggfdtgeduvedugeekgeeuvddvhfdugeduhfetkeevtdeitdegueenucfk
    phepudeifedruddugedrudefvddrfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:Ru4zYHOt8zJTRAFJwloIO1OvKrkFTeKGYgJ1B_D6NTif5FMV3iLxGQ>
    <xmx:Ru4zYP5z05Vh7WK77o2GOj4FVh_g0k6DmYvId0k3O0zAC6NHo9dGRA>
    <xmx:Ru4zYInY1-76FbfgYbYZZoOcg6IQPQrYx7SzI8lWxKVf5ADMYey7-A>
    <xmx:Ru4zYI_Ou5vz20VU2Hb5O_cP3oI7s4CNSf5iuFecBFyg1brYW1ylFw>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0EFCB1080066;
        Mon, 22 Feb 2021 12:47:50 -0500 (EST)
Date:   Mon, 22 Feb 2021 09:47:47 -0800
From:   Boris Burkov <boris@bur.io>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: 5.11 free space tree remount warning
Message-ID: <20210222174747.GA215319@devbig008.ftw2.facebook.com>
References: <CAJCQCtTT7djC+FPEeQg3mJuO75JTJUaoKuibBF+KOq0SWKt+zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtTT7djC+FPEeQg3mJuO75JTJUaoKuibBF+KOq0SWKt+zA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 19, 2021 at 07:01:41PM -0700, Chris Murphy wrote:
> Hi,
> 
> systemd does remount ro at reboot/shutdown time, and if free space
> tree exists, this is always logged:
> 
> [   27.476941] systemd-shutdown[1]: Unmounting file systems.
> [   27.479756] [1601]: Remounting '/' read-only in with options
> 'seclabel,compress=zstd:1,space_cache=v2,subvolid=258,subvol=/root'.
> [   27.489196] BTRFS info (device vda3): using free space tree
> [   27.492009] BTRFS warning (device vda3): remount supports changing
> free space tree only from ro to rw
> 
> Is there a way to better detect that this isn't an attempt to change
> to v2? If there's no v1 present, it's not a change.
> 
> -- 
> Chris Murphy

I am able to reproduce this with:

mkfs.btrfs -f dev
mount -o space_cache=v2 dev mnt
mount -o remount,ro mnt

At first I assumed I just completely ignored this case, but reading the
code now, it looks like it should have handled it. I assume I messed
up the value of the mount option during a remount when it isn't set by
the mount command.

Apologies for the noise, and I should hopefully have a fix soon.
Boris
