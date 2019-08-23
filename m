Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 027A29AE29
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2019 13:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389197AbfHWLcS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Aug 2019 07:32:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:39828 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388715AbfHWLcS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Aug 2019 07:32:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 49D02B0BE;
        Fri, 23 Aug 2019 11:32:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 29176DA796; Fri, 23 Aug 2019 13:32:42 +0200 (CEST)
Date:   Fri, 23 Aug 2019 13:32:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH][RESEND] btrfs: add a force_chunk_alloc to space_info's
 sysfs
Message-ID: <20190823113241.GK2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <20190822190305.13673-1-josef@toxicpanda.com>
 <e54d6bb1-3bcb-a409-575a-c59b2e5da73d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e54d6bb1-3bcb-a409-575a-c59b2e5da73d@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 23, 2019 at 09:35:22AM +0300, Nikolay Borisov wrote:
> 
> 
> On 22.08.19 г. 22:03 ч., Josef Bacik wrote:
> > In testing various things such as the btrfsck patch to detect over
> > allocation of chunks, empty block group deletion, and balance I've had
> > various ways to force chunk allocations for debug purposes.  Add a sysfs
> > file to enable forcing of chunk allocation for the owning space info in
> > order to enable us to add testcases in the future to test these various
> > features easier.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Since this is really a debugging feature I think it should be gated by
> CONFIG_BTRFS_DEBUG.

I did the per-fs debug directories exactly for that purpose, the patches
have been in misc-next for some time ("btrfs: sysfs: add debugging
exports").
