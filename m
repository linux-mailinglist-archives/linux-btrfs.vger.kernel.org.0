Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C101B100899
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 16:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfKRPp5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 10:45:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:53740 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727336AbfKRPp4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 10:45:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0AF56ABB1;
        Mon, 18 Nov 2019 15:45:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BB126DA823; Mon, 18 Nov 2019 16:45:56 +0100 (CET)
Date:   Mon, 18 Nov 2019 16:45:56 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/15] btrfs: sysfs, cleanups
Message-ID: <20191118154556.GJ3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20191118084656.3089-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118084656.3089-1-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 18, 2019 at 04:46:41PM +0800, Anand Jain wrote:
> Mostly cleanups patches.
> 
> Patches 1-7 are renames, code moves patches and there are no
> functional changes.
> 
> Patch 8 drops unused argument in the function btrfs_sysfs_add_fsid().
> Patch 9 merges two small functions which is an extension of the other.
> 
> Patches 10,11 and 13 removes unnecessary features in the functions, 
> originally it was planned to provide sysfs attributes for the scanned
> and unmounted devices, as in the un-merged patch in the mailing list [1]
>    [1] [PATCH] btrfs: Introduce device pool sysfs attributes

We want something like that, I don't recall all the past discussions,
but a separate directory for all the new sysfs files should be
introduced. Extending the existing /devices/ that contains just the
sysfs device like should stay as is.

/sys/fs/btrfs/UUID/
	devinfo/
		1/
			uuid
			state
			...
		2/
			...

