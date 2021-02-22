Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9900232203E
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 20:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbhBVTfw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 14:35:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:49044 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233313AbhBVTfo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 14:35:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3C028ADE3;
        Mon, 22 Feb 2021 19:35:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3BB45DA7FF; Mon, 22 Feb 2021 20:33:03 +0100 (CET)
Date:   Mon, 22 Feb 2021 20:33:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dan Carpenter <dancarpenter@oracle.com>
Cc:     Chris Mason <clm@fb.com>, Arne Jansen <sensille@gmx.net>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] btrfs: prevent potential out of bounds in
 btrfs_ioctl_snap_create_v2()
Message-ID: <20210222193302.GT1993@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dan Carpenter <dancarpenter@oracle.com>,
        Chris Mason <clm@fb.com>, Arne Jansen <sensille@gmx.net>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <YCyx8u40HaplP7a+@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCyx8u40HaplP7a+@mwanda>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 17, 2021 at 09:04:34AM +0300, Dan Carpenter wrote:
> The problem is we're copying "inherit" from user space but we don't
> necessarily know that we're copying enough data for a 64 byte
> struct.  Then the next problem is that "inherit" has a variable size
> array at the end, and we have to verify that array is the size we
> expected.
> 
> Fixes: 6f72c7e20dba: ("Btrfs: add qgroup inheritance")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Presumably only root can create snapshots.

Well, no. After first analysis there are some "interesting memory access
patterns" possible, with a crafted data in the inherit member.

> Anyway, I have not tested
> this fix.  I believe it is correct, of course.  But perhaps it's best
> to check.

Yeah I'll write a test also to see where exactly the issues are. Thanks
for the report/fix.
