Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8358654A855
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 06:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbiFNEv6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 00:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiFNEv5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 00:51:57 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB24135DDD
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 21:51:55 -0700 (PDT)
Received: from [76.132.34.178] (port=59316 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1o0xoT-0005vb-OW by authid <merlins.org> with srv_auth_plain; Mon, 13 Jun 2022 21:51:48 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1o0yWq-00DFso-Pe; Mon, 13 Jun 2022 21:51:48 -0700
Date:   Mon, 13 Jun 2022 21:51:48 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Roman Mamedov <rm@romanrm.net>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Andrea Gelmini <andrea.gelmini@gmail.com>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Suggestions for building new 44TB Raid5 array
Message-ID: <20220614045148.GU1664812@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqeZJ1j2ZYGpvY7v@hungrycats.org>
 <20220613232907.6d71be87@nvm>
 <Yqd9sIhOiuCSg99Z@hungrycats.org>
 <20220613230625.78631b8a@nvm>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-Broken-Reverse-DNS: no host name for IP address 76.132.34.178
X-SA-Exim-Connect-IP: 76.132.34.178
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks to you both for your kind help. If I'm rebulding everything,
might as well future-proof it as well as possible.

On Mon, Jun 13, 2022 at 11:06:25PM +0500, Roman Mamedov wrote:
> What I mean is bcache in this way stays bcache-without-a-cache forever, which
> feels odd; it still goes through the bcache code, has the module loaded, keeps
> the device name, etc;
 
Fair point. I have done that, but I see what you're saying.

> Whereas in LVM caching is a completely optional side-feature, and many people
> would just run LVM in any case, not even thinking about enabling cache. LVM is
> basically "the next generation" of disk partitions, with way more features,
> but not much more overhead.

Fair enough. I have used LVM for many years, since the now defunct lvm1,
and I've run through a fair amount of issues, some reliability, some
performance. that was many many years ago though, so I'll take your word
for it that it's a lot more lightweight and safe now.

Actually I think I stopped using LVM the same time I started using
btrfs, because effectively btrfs subvolumes were close enough to LVM LVs
for my use, but yes I understand that different LVs are actually
different filesystems and you can do extra stuff like caching.

Actually I have another array where there were so many files and
snapshots that I split it into different LVs with dm-thin so that I
didn't stress the btrfs code too much (which I'm told gets unhappy when
you have hundreds of snapshots).

On Mon, Jun 13, 2022 at 02:10:56PM -0400, Zygo Blaxell wrote:
> You can trivially convert from lvmcache to plain LV on the fly.  It's a
> pretty essential capability for long-term maintenance, since you can't
> move or resize the LV while it's cached.
> 
> If you have a LV and you want it to be cached with bcache, you can hack
> up the LVM configuration after the fact with https://github.com/g2p/blocks
 
Got it, thanks much.

On Mon, Jun 13, 2022 at 11:29:07PM +0500, Roman Mamedov wrote:
> It is a question of whether you want to cache encrypted, or plain-text data. I
> guess the former should be preferable, for a complete peace-of-mind against
> data forensics vs the cache device, but with a toll on performance, due to the
> need to re-decrypt even the cache hits each time.
 
Right, I know that tradeoff. Also, LUKS makes things a bit more complicated
if you want to grow the FS.

> In case of caching encrypted, it's:
> 
> mdraid => PV => LV => LUKS
>                 |
>              (cache)
> 
> Otherwise:
> 
> mdraid => LUKS => PV => LV
>                         |
>                      (cache)

Right. I'll probably do that.

On Mon, Jun 13, 2022 at 04:08:07PM -0400, Zygo Blaxell wrote:
> Add a cache LV to an existing LV with:
> 
> 	lvcreate $vg -n $meta -L 1G $device
> 	lvcreate $vg -n $pool -l 90%PVS $device
> 	lvconvert -f --type cache-pool --poolmetadata $vg/$meta $vg/$pool
> 	lvconvert -f --type cache --cachepool $vg/$pool $vg/$data --cachemode writethrough
> 
> Uncache with:
> 
> 	lvconvert -f --uncache $vg/$data
> 
> Note that 'lvconvert' will flush the entire cache back to the backing
> store during uncache at minimum IO priority, so it will take some time
> and can be prolonged indefinitely by a continuous IO workload on top.
> Also, the uncache operation will propagate any corruption in the SSD
> cache back to the HDD LV, even in writethrough mode.

Thanks much for the heads up.

Best,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
