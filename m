Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6398139249
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2020 14:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgAMNh4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jan 2020 08:37:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:43008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgAMNh4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jan 2020 08:37:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EB798AAC3;
        Mon, 13 Jan 2020 13:37:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0DFF4DA78B; Mon, 13 Jan 2020 14:37:42 +0100 (CET)
Date:   Mon, 13 Jan 2020 14:37:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Craig Andrews <candrews@integralblue.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Regression in Linux 5.5.0-rc[1-5]: btrfs send/receive out of
 memory
Message-ID: <20200113133741.GU3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Craig Andrews <candrews@integralblue.com>,
        linux-btrfs@vger.kernel.org
References: <5ba0716449eb4f838699fc0b1fb5b024@integralblue.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ba0716449eb4f838699fc0b1fb5b024@integralblue.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 13, 2020 at 07:41:13AM -0500, Craig Andrews wrote:
> If I perform a btrfs send receive like so:
> 
> sh -c btrfs send -p /mnt/everything/.snapshots/root.20191230 
> /mnt/everything/.snapshots/root.20191231 | btrfs receive 
> /mnt/backup/.snapshots/
> 
> On Linux 5.4.0, the process completes successfully.
> 
> Starting with Linux 5.5.0-rc1 up to the current 5.5 rc, 5.5.0-rc5, the 
> result is the OOM killer being invoked which (among other process 
> carnage) kills the btrfs processes stopping the backup.

As this is on the -rc1, it's possible that changes done in the MM
subsystem could change the logic of OOM and that send now is able to
trigger the OOM.

There are 2 btrfs patches in send.c but they reduce amount of work,
namely for heavily reflinked extents so the effects should be opposite.

To find out where's the cause, is it possible that you build a kernel
from the 5.4-based branch and run the send again? It's the same set of
btrfs patches that gets merged to 5.5.

From repository: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git 
branch: for-5.5-rc4

If this can't be done we'll find another way to debug it.
