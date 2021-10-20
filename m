Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345774350D5
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 18:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhJTRAe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 13:00:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51060 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhJTRAc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 13:00:32 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1068821960;
        Wed, 20 Oct 2021 16:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634749097;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tuWI3pcpohxuUy9yghQ3uIvP4FHCV3ZBDAtJ+CJ239A=;
        b=w/y5KW+RyDPIWl0SOMAjvEHNBuv+lxLDGn3cfCxpcQ2wlaG1IidiGJTAehcK0ZniEBJUHG
        JJUheQIJ8J2RHBFw5LCQOTA4sYV5KoG20fJ6MNLl/+kwdIDR2DkzWjl1AbOjXX6UDppSPO
        atqSiQRJ6xhqSN7BVc8jKFk1yinMl2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634749097;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tuWI3pcpohxuUy9yghQ3uIvP4FHCV3ZBDAtJ+CJ239A=;
        b=SHnrByuX6oxwJVoyiV49nkti+peGrAIvh0i0OExnacMWHvtcFhzCc/1F+xJNc6zOI0K1V1
        mopsXI8KLDKnzHDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D6EA3A3B83;
        Wed, 20 Oct 2021 16:58:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B611CDA7A3; Wed, 20 Oct 2021 18:57:48 +0200 (CEST)
Date:   Wed, 20 Oct 2021 18:57:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2 0/7] btrfs-progs: use direct-IO for zoned device
Message-ID: <20211020165748.GZ30611@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <20211005062305.549871-1-naohiro.aota@wdc.com>
 <20211006210247.GY9286@twin.jikos.cz>
 <20211020065332.csyjedb27xshy7mq@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020065332.csyjedb27xshy7mq@naota-xeon>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 20, 2021 at 06:53:32AM +0000, Naohiro Aota wrote:
> On Wed, Oct 06, 2021 at 11:02:47PM +0200, David Sterba wrote:
> > On Tue, Oct 05, 2021 at 03:22:58PM +0900, Naohiro Aota wrote:
> > Is this still supposed to work?
> > 
> >   $ ./mkfs.btrfs -f -O zoned -d single -m single img
> >   ...
> >   ERROR: 16384 is not aligned to 1048576
> >   ERROR: error during mkfs: Input/output error
> > 
> > On commit below this patchset it works and creates a filesystem with
> > zoned mode and zone size 256M.
> 
> The mkfs on an image file should work well. I tested the current
> "devel" branch. While it needs a patch to replace pwrite with
> btrfs_pwrite in create_free_space_tree(), it worked well besides
> that. Is this failing on your side?

Yes it still fails with the patched pwrite, same error, with or without
enabling free-space-tree.
