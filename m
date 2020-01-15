Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7755713C362
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 14:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgAONlI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 08:41:08 -0500
Received: from snd00007.auone-net.jp ([111.86.247.7]:29568 "EHLO
        dmta0009.auone-net.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726088AbgAONlI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 08:41:08 -0500
Received: from ppp.dion.ne.jp by dmta0009.auone-net.jp with ESMTP
          id <20200115134106476.LBDG.46476.ppp.dion.ne.jp@dmta0009.auone-net.jp>;
          Wed, 15 Jan 2020 22:41:06 +0900
Date:   Wed, 15 Jan 2020 22:41:06 +0900
From:   Kusanagi Kouichi <slash@ac.auone-net.jp>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Implement lazytime
References: <20200114085325045.JFBE.12086.ppp.dion.ne.jp@dmta0008.auone-net.jp>
 <7d0eadb4-5712-6fa1-f50f-f8ea6d8aea43@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d0eadb4-5712-6fa1-f50f-f8ea6d8aea43@toxicpanda.com>
Message-Id: <20200115134106476.LBDG.46476.ppp.dion.ne.jp@dmta0009.auone-net.jp>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-01-14 05:44:33 -0800, Josef Bacik wrote:
> On 1/14/20 12:53 AM, Kusanagi Kouichi wrote:
> > I tested with xfstests and lazytime didn't cause any new failures.
> > 
> > Signed-off-by: Kusanagi Kouichi <slash@ac.auone-net.jp>
> > ---
> 
> We don't use the I_DIRTY flags for tracking our inodes, and .write_inode was
> removed because we didn't need it and it deadlocks.  Thanks,
> 
> Josef

Did you apply the patch and deadlock occur? According to commit 3c4276936f6f
("Btrfs: fix btrfs_write_inode vs delayed iput deadlock"), which removed
.write_inode, .write_inode calls btrfs_run_delayed_iputs and deadlock occurs.
But .write_inode in this patch doesn't seem to call btrfs_run_delayed_iputs.
