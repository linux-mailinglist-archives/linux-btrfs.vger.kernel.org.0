Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB7531FF2E
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 20:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhBSTC5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 14:02:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:33502 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229932AbhBSTCz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 14:02:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4A47ACCF;
        Fri, 19 Feb 2021 19:02:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4C604DA6FC; Fri, 19 Feb 2021 20:00:15 +0100 (CET)
Date:   Fri, 19 Feb 2021 20:00:15 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: fix return code for failed replace start
Message-ID: <20210219190015.GJ1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <48194115537d723d04bba0505411525b77f3e73b.1601402292.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48194115537d723d04bba0505411525b77f3e73b.1601402292.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 30, 2020 at 10:46:14AM +0800, Anand Jain wrote:
> When replace-starts with no-background and fails for the reason that
> a BTRFS_FS_EXCL_OP is in progress, we still return the value 0 and also
> leak the target device open, because in cmd_replace_start() we missed
> the goto leave_with_error for this error.
> 
> So the test case btrfs/064 in its seqres.full output reports...
> 
>   Replacing /dev/sdf with /dev/sdc
>   ERROR: /dev/sdc is mounted
> 
> instead of...
> 
>   Replacing /dev/sdc with /dev/sdf
>   ERROR: ioctl(DEV_REPLACE_START) '/mnt/scratch': add/delete/balance/replace/resize operation in progress
> 
> for the failed replace attempts in the test case
> 
> Fix it by adding a goto leave_with_error for this error which also fixes
> the device open leak.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to devel, thanks.
