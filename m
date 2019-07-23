Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA01971B85
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2019 17:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbfGWPYd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jul 2019 11:24:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:37616 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726283AbfGWPYc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jul 2019 11:24:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA6DBAFA9;
        Tue, 23 Jul 2019 15:24:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B1A39DA7D5; Tue, 23 Jul 2019 17:25:09 +0200 (CEST)
Date:   Tue, 23 Jul 2019 17:25:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3 RESEND Rebased] btrfs: add readmirror devid property
Message-ID: <20190723152509.GG2868@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20190626083402.1895-1-anand.jain@oracle.com>
 <20190626083402.1895-4-anand.jain@oracle.com>
 <20190723145553.GE2868@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723145553.GE2868@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 23, 2019 at 04:55:53PM +0200, David Sterba wrote:
> On Wed, Jun 26, 2019 at 04:34:02PM +0800, Anand Jain wrote:
> > Introduces devid readmirror property, to direct read IO to the specified
> > device(s).
> > 
> > The readmirror property is stored as extended attribute on the root
> > inode.
> 
> So this is permanently stored on the filesystem, is the policy applied
> at mount time?

Found in some previous version that it's not permanently stored, so
scratch that.

> > The readmirror input format is devid1,2,3.. etc. And for the
> > each devid provided, a new flag BTRFS_DEV_STATE_READ_OPTIMISED is set.
> 
> I'd say it should be called PREFERRED, and the format specifier could
> add ":" between devid and the numbers, like "devid:1,2,3", we'll
> probably want more types in the future.
> 
> This is the first whole-filesystem property so we can't follow a naming
> scheme, so we'll have to decide if we go with flat or hierarchical
> naming with more generic categories like policy.mirror.read and similar.

I'll have to go through the past discussions again, there was some
feedback regarding this I did not take into account.
