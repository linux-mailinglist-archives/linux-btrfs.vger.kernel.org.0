Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6076913C95E
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 17:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgAOQbo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 11:31:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:39478 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgAOQbn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 11:31:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0FC5BAB7F;
        Wed, 15 Jan 2020 16:31:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 43D81DA791; Wed, 15 Jan 2020 17:31:28 +0100 (CET)
Date:   Wed, 15 Jan 2020 17:31:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Kusanagi Kouichi <slash@ac.auone-net.jp>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Implement lazytime
Message-ID: <20200115163128.GT3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Kusanagi Kouichi <slash@ac.auone-net.jp>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200114085325045.JFBE.12086.ppp.dion.ne.jp@dmta0008.auone-net.jp>
 <20200114212107.GM3929@twin.jikos.cz>
 <20200115134536820.LBFZ.46476.ppp.dion.ne.jp@dmta0009.auone-net.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115134536820.LBFZ.46476.ppp.dion.ne.jp@dmta0009.auone-net.jp>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 15, 2020 at 10:45:36PM +0900, Kusanagi Kouichi wrote:
> On 2020-01-14 22:21:07 +0100, David Sterba wrote:
> > On Tue, Jan 14, 2020 at 05:53:24PM +0900, Kusanagi Kouichi wrote:
> > > I tested with xfstests and lazytime didn't cause any new failures.
> > 
> > The changelog should describe what the patch does (the 'why' part too,
> > but this is obvious from the subject in this case). That fstests pass
> > without new failures is nice but there should be a specific test for
> > that or instructions in the changelog how to test.
> 
> To test lazytime, I set the following variables:
> TEST_FS_MOUNT_OPTS="-o lazytime,space_cache=v2"
> MOUNT_OPTIONS="-o lazytime,space_cache=v2"

How did you verify that the lazy time updates were applied properly?
