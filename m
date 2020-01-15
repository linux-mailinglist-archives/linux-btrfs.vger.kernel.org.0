Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C475413C905
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 17:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgAOQSL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 11:18:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:60900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgAOQSL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 11:18:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EDE8DABF5;
        Wed, 15 Jan 2020 16:18:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A3DBEDA791; Wed, 15 Jan 2020 17:17:56 +0100 (CET)
Date:   Wed, 15 Jan 2020 17:17:56 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: update devid after replace
Message-ID: <20200115161756.GS3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20200114183958.GJ3929@twin.jikos.cz>
 <20200115082250.3064-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115082250.3064-1-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 15, 2020 at 04:22:50PM +0800, Anand Jain wrote:
> During the replace the target device temporarily assumes devid 0 before
> assigning the devid of the soruce device.
> 
> In btrfs_dev_replace_finishing() we remove source sysfs devid using
> the function btrfs_sysfs_remove_devices_attr(), so after that call
> kobject_rename() to update the devid in the sysfs.
> This adds and calls btrfs_sysfs_update_devid() helper function to update
> the device id.
> 
> This patch must be squashed with the patch
>  [PATCH v4] btrfs: sysfs, add devid/dev_state kobject and attribute
> or its variant.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> David,
>  I couldn't find the patch-series..
>    [PATCH 0/4] btrfs, sysfs cleanup and add dev_state
>  in your misc-next. And I believe there were changes like
>  function rename and attribute list reorder in your workspace. So I am
>  sending a fix-patch which must be squashed to the patch v4 4/4.

I had to remove the patch from misc-next as it prevented further
testing. The whole patchset can be found in branch
ext/anand/sysfs-devinfo on github repo. Once I test this patch I'll add
it back.
