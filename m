Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8A965D12C
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jan 2023 12:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239160AbjADLDe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Jan 2023 06:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239163AbjADLDP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Jan 2023 06:03:15 -0500
X-Greylist: delayed 2322 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Jan 2023 03:03:14 PST
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD1013CC6
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Jan 2023 03:03:12 -0800 (PST)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1pD0vh-00014J-Vv; Wed, 04 Jan 2023 10:23:29 +0000
Date:   Wed, 4 Jan 2023 10:23:29 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     "Kengo.M" <kengo@kyoto-arc.or.jp>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Number of parity disks
Message-ID: <20230104102329.GJ25447@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        "Kengo.M" <kengo@kyoto-arc.or.jp>, linux-btrfs@vger.kernel.org
References: <p0600100fdfda6d2d6124@kyoto-arc.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p0600100fdfda6d2d6124@kyoto-arc.or.jp>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 04, 2023 at 08:40:10AM +0900, Kengo.M wrote:
> Hi Folks
> 
> I use btrfs conveniently.
> 
> Let me ask a very very basic question.
> 
> One parity disk can be used in RAID 5 and 2 parity disks can be used in RAID 6.
> ZFS RAIDZ-3 (raidz3) can use 3 parity disks.
> 
> Is it difficult to increase the number of parity disks to 4, 5 or more.
> If so, is the reason for this because of the time it takes to generate the
> parity bits?

   Someone pasted, some years ago, a patch that added parity
calculations up to 6. It is relatively difficult to find appropriate
orthogonal functions, but the computation of the parity values once
you know those functions isn't hugely expensive.

   I don't think the patch added actual n-way parity functionality to
btrfs or MD-RAID, though.

   Given the longevity (and severity) of some of the btrfs parity RAID
bugs, I think it's probably not a priority to layer more code onto an
already wobbly part of btrfs. That may change in the future, now that
parity RAID is seeing some major fixes landing, but I wouldn't hold
your breath for it.

   Hugo.

-- 
Hugo Mills             | This: Rock. You throw rock.
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                          Graeme Swann on fast bowlers
