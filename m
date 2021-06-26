Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25FC3B4DBB
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jun 2021 10:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhFZIyZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Jun 2021 04:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZIyZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Jun 2021 04:54:25 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29423C061574
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Jun 2021 01:52:03 -0700 (PDT)
Received: from ananda.localnet (unknown [IPv6:2001:a62:1a52:5a00:19da:1263:b56c:4c4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 2675027AF85;
        Sat, 26 Jun 2021 10:52:00 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     NeilBrown <neilb@suse.de>
Cc:     linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: Assumption on fixed device numbers in Plasma's desktop search Baloo
Date:   Sat, 26 Jun 2021 10:51:59 +0200
Message-ID: <1769070.0rzTUBzp5V@ananda>
In-Reply-To: <162466884942.28671.6997551060359774034@noble.neil.brown.name>
References: <41661070.mPYKQbcTYQ@ananda> <162466884942.28671.6997551060359774034@noble.neil.brown.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin2 smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

NeilBrown - 26.06.21, 02:54:09 CEST:
> > And that Baloo needs an "invariant" for
> 
> > a file. See comment #11 of that bug report:
> That is really hard to provide in general.  Possibly the best approach
> is to use the statfs() systemcall to get the "f_fsid" field.  This is
> 64bits.  It is not supported uniformly well by all filesystems, but I
> think it is at least not worse than using the device number.  For a
> lot of older filesystems it is just an encoding of the device number.
> 
> For btrfs, xfs, ext4 it is much much better.

Thank you for the clear statement and for your alternative suggestion. I 
will forward this to Baloo upstream.

I think the main focus of Baloo would be to work on currently mostly in 
use Linux filesystem which should be BTRFS, XFS, EXT4 and probably F2FS.

-- 
Martin


