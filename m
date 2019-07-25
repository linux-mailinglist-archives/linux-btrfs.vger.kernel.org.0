Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 837907570C
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2019 20:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfGYShF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jul 2019 14:37:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:55080 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbfGYShF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jul 2019 14:37:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6EF39AE47
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2019 18:37:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 70250DA7DE; Thu, 25 Jul 2019 20:37:41 +0200 (CEST)
Date:   Thu, 25 Jul 2019 20:37:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Allow more disks missing for RAID10
Message-ID: <20190725183741.GX2868@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190718062749.11276-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718062749.11276-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 18, 2019 at 02:27:49PM +0800, Qu Wenruo wrote:
> RAID10 can accept as much as half of its disks to be missing, as long as
> each sub stripe still has a good mirror.

Can you please make a test case for that?

I think the number of devices that can be lost can be higher than a half
in some extreme cases: one device has copies of all stripes, 2nd copy
can be scattered randomly on the other devices, but that's highly
unlikely to happen.

On average it's same as raid1, but the more exact check can potentially
utilize the stripe layout.
