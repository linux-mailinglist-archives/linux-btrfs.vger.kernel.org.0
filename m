Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2904B5737
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Feb 2022 17:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356739AbiBNQmQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Feb 2022 11:42:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243156AbiBNQmD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Feb 2022 11:42:03 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D980F652DD
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Feb 2022 08:39:42 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8C1F91F38A;
        Mon, 14 Feb 2022 16:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644856781;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=woBY7ImxMJbznyWJXROuJL9AckI+8tEAYyk9TJDvL30=;
        b=NjO/+iSJCS/rfdRQkZWYal/s1HherwKZWXzRpwFbL8aIIUOmk41mTTT4u0H+ewWIVW8G8A
        j7ZWE2VVF7UXeKNJSV+1Vpx4e1M2YpzQ+zz1n6gZ5F4k2JvpujPhM5TiB2TyG788eDsArM
        1iOyU8uMbToz0z8L7PqynM0ha0UynVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644856781;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=woBY7ImxMJbznyWJXROuJL9AckI+8tEAYyk9TJDvL30=;
        b=IJsDrBz66v2k/dcp6lS7toEwoDrvrU6wJJMHbk/Wlwbny5FeqFxjf8AtIFPwa0D2vD2uBe
        hRBkLHlBokseC+Cw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 812AEA3B84;
        Mon, 14 Feb 2022 16:39:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F363ADA832; Mon, 14 Feb 2022 17:35:57 +0100 (CET)
Date:   Mon, 14 Feb 2022 17:35:57 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] btrfs: make autodefrag to defrag small writes
 without rescanning the whole file
Message-ID: <20220214163557.GF12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1644398069.git.wqu@suse.com>
 <fc9f897e0859cccf90c33a7a609dc0a2e96ce3c1.1644398069.git.wqu@suse.com>
 <YgP8UocVo/yMT2Pj@debian9.Home>
 <32c44e26-9bd1-f75f-92df-3f7fbf44f8a0@gmx.com>
 <YgUzsYTCz48nB/XT@debian9.Home>
 <23693916-8269-0357-3a20-5e281cf53ff8@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23693916-8269-0357-3a20-5e281cf53ff8@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 11, 2022 at 08:24:13AM +0800, Qu Wenruo wrote:
> > As I read it, it seems it barely had any performance testing.
> 
> OK, I'll try to find a way to replicate the IO of torrents downloading.
> To get a reproducible result, some kind of replay with proper timing is
> needed, any advice on such tool?

A file generated by torrent-like write pattern can be achieved eg. by
the following fio script:

[torrent]
filename=torrent-test
rw=randwrite
size=4g
ioengine=sync

and you can tune the block sizes or other parameters. The result of this
script is a file totally fragmented so it's the worst case, running a
defrag on that takes a long time too.
