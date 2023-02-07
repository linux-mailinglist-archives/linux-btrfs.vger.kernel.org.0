Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EED468DDBB
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Feb 2023 17:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjBGQPn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Feb 2023 11:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjBGQPl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Feb 2023 11:15:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B884F5FFC
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Feb 2023 08:15:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30D84B819A4
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Feb 2023 16:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0AFC4339B
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Feb 2023 16:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675786537;
        bh=KyDNGNN7o0VE8/oOVcO2xR64fV/w7lN3kkQYL60/+Ts=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PonbMbrTyyQc1ME03wGWahdHa9zzS0ZuS+ikRkqLfi6xv6I2o+Q1qYdMwle9HZtsg
         CZSE2WIpZJE/xv7kYsDDnThX9NCqZSvjWGdtxqJK5qtKet2Fy252xZoq+E5Og+j+v8
         FkcBAkW8yf/gKjeQrsoanwg/MepIn0Bs0m2YzbuYAeWg8VzTCLgWoOU77hen02GFHe
         DAiY1YTb7OZE1MRKssdHCkmvds1rTagq+9v/X7IWktAhlHWXuL1RKunhqyzQF6s2zC
         6k7Ku8/1utZNDsQHhtiS2FgyKXOZTRTymaZP6Y4Ew44kldvj3+42Ho+xgiViodC21g
         UFP/2p/bzszJA==
Received: by mail-oi1-f174.google.com with SMTP id cz14so3656707oib.12
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Feb 2023 08:15:37 -0800 (PST)
X-Gm-Message-State: AO0yUKUIuIDGpYdp6JuMXG3ucfq77ZUInIqyNiT65IZQqj3aRELBt5ES
        ijT6Hr4ut74l4wzXvWB4waEim9rmdgqP+G1j6Ss=
X-Google-Smtp-Source: AK7set+1dsPYW3o+NOsLTENZ3Q2RsgLTTGMLxaZ/yhYTHKm78zPQoOBQrRn9mN7EtdJQD+A/asAblGM0nOwk05cEIqE=
X-Received: by 2002:a05:6808:138c:b0:37b:4e18:2fa7 with SMTP id
 c12-20020a056808138c00b0037b4e182fa7mr377869oiw.98.1675786536990; Tue, 07 Feb
 2023 08:15:36 -0800 (PST)
MIME-Version: 1.0
References: <5c6c1cefa7df5fbe9c4dc2fe517f521760a2f4be.1674492773.git.fdmanana@suse.com>
 <20230207154021.GG28288@twin.jikos.cz>
In-Reply-To: <20230207154021.GG28288@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 7 Feb 2023 16:15:00 +0000
X-Gmail-Original-Message-ID: <CAL3q7H52v9xo856Tp5g61a2ah=7FPvaOPeQ_cR18cB63f6tWHQ@mail.gmail.com>
Message-ID: <CAL3q7H52v9xo856Tp5g61a2ah=7FPvaOPeQ_cR18cB63f6tWHQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: lock the inode in shared mode before starting fiemap
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 7, 2023 at 3:46 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, Jan 23, 2023 at 04:54:46PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
>
> > Fix this by taking the inode's lock (VFS lock) in shared mode when
> > entering fiemap. This effectively serializes fiemap with fsync (except the
> > most expensive part of fsync, the log sync), preventing this deadlock.
>
> Could this be a problem, when a continuous fiemap would block fsync on a
> file? Fsync is more important and I'd give it priority when the inode
> lock is contended, fiemap is only informative and best effort. The
> deadlock needs to be fixed of course but some mechanism should be in
> place to favor other lock holders than fiemap. Quick idea is to relock
> after each say 100 extents.

Typically fiemap is called with a small buffer for extent entries. cp
and filefrag for example use a small buffer.
So they repeatedly call fiemap with such a small buffer (not more than
a 100 or 200 entries).

Do you think it's that common to have fiemap and fsync attempts in parallel?

I don't think it's a problem, not only it shouldn't be common, but if
it happens it's for a very short time. Even for a very long fiemap
buffer.
