Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5541D13C375
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 14:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgAONpi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 08:45:38 -0500
Received: from snd00010.auone-net.jp ([111.86.247.10]:51296 "EHLO
        dmta0009.auone-net.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726071AbgAONpi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 08:45:38 -0500
Received: from ppp.dion.ne.jp by dmta0009.auone-net.jp with ESMTP
          id <20200115134536820.LBFZ.46476.ppp.dion.ne.jp@dmta0009.auone-net.jp>;
          Wed, 15 Jan 2020 22:45:36 +0900
Date:   Wed, 15 Jan 2020 22:45:36 +0900
From:   Kusanagi Kouichi <slash@ac.auone-net.jp>
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Implement lazytime
References: <20200114085325045.JFBE.12086.ppp.dion.ne.jp@dmta0008.auone-net.jp>
 <20200114212107.GM3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114212107.GM3929@twin.jikos.cz>
Message-Id: <20200115134536820.LBFZ.46476.ppp.dion.ne.jp@dmta0009.auone-net.jp>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-01-14 22:21:07 +0100, David Sterba wrote:
> On Tue, Jan 14, 2020 at 05:53:24PM +0900, Kusanagi Kouichi wrote:
> > I tested with xfstests and lazytime didn't cause any new failures.
> 
> The changelog should describe what the patch does (the 'why' part too,
> but this is obvious from the subject in this case). That fstests pass
> without new failures is nice but there should be a specific test for
> that or instructions in the changelog how to test.

To test lazytime, I set the following variables:
TEST_FS_MOUNT_OPTS="-o lazytime,space_cache=v2"
MOUNT_OPTIONS="-o lazytime,space_cache=v2"
