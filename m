Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDA6EA0933
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2019 20:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfH1SC4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Aug 2019 14:02:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:52622 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726549AbfH1SC4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Aug 2019 14:02:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 12F04AF55;
        Wed, 28 Aug 2019 18:02:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 051B8DA809; Wed, 28 Aug 2019 20:03:17 +0200 (CEST)
Date:   Wed, 28 Aug 2019 20:03:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5][v2] Fix global reserve size and can overcommit
Message-ID: <20190828180317.GH2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <20190822191904.13939-1-josef@toxicpanda.com>
 <20190823131726.GQ2752@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823131726.GQ2752@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 23, 2019 at 03:17:26PM +0200, David Sterba wrote:
> On Thu, Aug 22, 2019 at 03:18:59PM -0400, Josef Bacik wrote:
> > This didn't series didn't change much, but I did move things around a little bit
> > in previous series so these needed to be updated.
> > 
> >  fs/btrfs/block-rsv.c  | 36 ++++++++++++++++++++++++++----------
> >  fs/btrfs/space-info.c | 51 ++++++++++++++++++++++++++-------------------------
> >  2 files changed, 52 insertions(+), 35 deletions(-)
> 
> Added as topic branch to for-next (based on the ticket rework patchset).

Moved to misc-next.
