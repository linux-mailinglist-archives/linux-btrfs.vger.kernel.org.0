Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C01359B096
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2019 15:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389335AbfHWNRD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Aug 2019 09:17:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:53030 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731783AbfHWNRC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Aug 2019 09:17:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5A99AAF39;
        Fri, 23 Aug 2019 13:17:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6BE45DA796; Fri, 23 Aug 2019 15:17:26 +0200 (CEST)
Date:   Fri, 23 Aug 2019 15:17:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5][v2] Fix global reserve size and can overcommit
Message-ID: <20190823131726.GQ2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <20190822191904.13939-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822191904.13939-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 22, 2019 at 03:18:59PM -0400, Josef Bacik wrote:
> This didn't series didn't change much, but I did move things around a little bit
> in previous series so these needed to be updated.
> 
>  fs/btrfs/block-rsv.c  | 36 ++++++++++++++++++++++++++----------
>  fs/btrfs/space-info.c | 51 ++++++++++++++++++++++++++-------------------------
>  2 files changed, 52 insertions(+), 35 deletions(-)

Added as topic branch to for-next (based on the ticket rework patchset).
