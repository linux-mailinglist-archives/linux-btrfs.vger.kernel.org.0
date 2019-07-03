Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03B4B5E867
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2019 18:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfGCQIY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jul 2019 12:08:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:42056 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726678AbfGCQIY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jul 2019 12:08:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B2A05AF68;
        Wed,  3 Jul 2019 16:08:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 36EC1DA8A9; Wed,  3 Jul 2019 18:09:07 +0200 (CEST)
Date:   Wed, 3 Jul 2019 18:09:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v7 RESEND Rebased] btrfs-progs: dump-tree: add noscan
 option
Message-ID: <20190703160907.GW20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20190626083017.1833-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626083017.1833-1-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 26, 2019 at 01:30:17AM -0700, Anand Jain wrote:
> From: Anand Jain <Anand.Jain@oracle.com>
> 
> The cli 'btrfs inspect dump-tree <dev>' will scan for the partner devices
> if any by default.
> 
> So as of now you can not inspect each mirrored device independently.
> 
> This patch adds noscan option, which when used won't scan the system for
> the partner devices, instead it just uses the devices provided in the
> argument.
> 
> For example:
>   btrfs inspect dump-tree --noscan <dev> [<dev>..]
> 
> This helps to debug degraded raid1 and raid10.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

This makes misc-test/021-image-multi-devices fail

====== RUN CHECK root_helper mount /dev/loop2 .../btrfs-progs/tests//mnt
====== RUN CHECK md5sum .../btrfs-progs/tests//mnt/foobar
md5sum: .../btrfs-progs/tests//mnt/foobar: Input/output error
failed: md5sum .../btrfs-progs/tests//mnt/foobar
====== RUN CHECK root_helper umount .../btrfs-progs/tests//mnt
====== RUN CHECK root_helper losetup -d /dev/loop2
====== RUN CHECK root_helper losetup -d /dev/loop3

note the md5sum error, that does not happen otherwise
