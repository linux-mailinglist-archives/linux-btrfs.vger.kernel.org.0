Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F999118DD9
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 17:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfLJQlV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 11:41:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:52718 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727508AbfLJQlV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 11:41:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D66E7B2E6;
        Tue, 10 Dec 2019 16:41:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4D3E9DA727; Tue, 10 Dec 2019 17:41:19 +0100 (CET)
Date:   Tue, 10 Dec 2019 17:41:19 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anandsuveer@gmail.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs, sysfs cleanup and add dev_state
Message-ID: <20191210164119.GA3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anandsuveer@gmail.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20191205112706.8125-1-anand.jain@oracle.com>
 <454f1d49-d093-4957-2025-19995373cdf9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454f1d49-d093-4957-2025-19995373cdf9@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 10, 2019 at 06:48:56AM +0800, Anand Jain wrote:
> On 12/5/19 7:27 PM, Anand Jain wrote:
> > Patch 1/4 is a cleanup patch.
> > Patch 2/4 adds the kobject devinfo which is a preparatory to patch 4/4.
> > Patch 3/4 was sent before, no functional changes, change log is updated.
> > Patch 4/4 creates the attribute dev_state.
> > 
> > Anand Jain (4):
> >    btrfs: sysfs, use btrfs_sysfs_remove_fsid in fail return in add_fsid
> >    btrfs: sysfs, add UUID/devinfo kobject
> >    btrfs: sysfs, rename device_link add,remove functions
> >    btrfs: sysfs, add devid/dev_state kobject and attribute
> 
>   Is there a chance that partly/fully this could get into 5.5-rc3?
>   1,3 are cleanups and 2,4 are feature add.

... which is exactly why this cannot be added to 5.5-rc3. The merge
target 5.5 is now only for regressions introduced in the new code or
reasonable fixes (eg. for stable trees).

https://www.kernel.org/doc/html/latest/process/2.Process.html#the-big-picture
