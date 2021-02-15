Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBF031BBC3
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Feb 2021 16:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhBOPCU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Feb 2021 10:02:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:38910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhBOPCJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Feb 2021 10:02:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4B5364EB7;
        Mon, 15 Feb 2021 14:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613401192;
        bh=JjIwSMnEt+ETU9tmeFvEN7EkYGKaOjW0SGFIf8zkMnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CVS/6iNDL3Ek4g4gnSsDYI+jHQ+z/QjpdEuAqtvydsBH8b6RkXTdJw+YZ/8Xw0zB/
         UkofTO2kkV3vPYDcte30qfqmfGsT58t3qnhquEzzeRTDFKsKFazdCfKvnraL/7hjMX
         nC76rWpL2+JzL7+aA+udet4xKH5i+Zcogx9x12vA=
Date:   Mon, 15 Feb 2021 15:59:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michal Rostecki <mrostecki@suse.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Michal Rostecki <mrostecki@suse.com>
Subject: Re: [PATCH RFC 5/6] btrfs: sysfs: Add directory for read policies
Message-ID: <YCqMR3JZIlmYNt1s@kroah.com>
References: <20210209203041.21493-1-mrostecki@suse.de>
 <20210209203041.21493-6-mrostecki@suse.de>
 <YCensH6UvkIp7Hnm@kroah.com>
 <20210215143535.GA21872@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215143535.GA21872@wotan.suse.de>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 15, 2021 at 02:35:35PM +0000, Michal Rostecki wrote:
> On Sat, Feb 13, 2021 at 11:19:28AM +0100, Greg KH wrote:
> > On Tue, Feb 09, 2021 at 09:30:39PM +0100, Michal Rostecki wrote:
> > > From: Michal Rostecki <mrostecki@suse.com>
> > > 
> > > Before this change, raid1 read policy could be selected by using the
> > > /sys/fs/btrfs/[fsid]/read_policy file.
> > > 
> > > Change it to /sys/fs/btrfs/[fsid]/read_policies/policy.
> > > 
> > > The motivation behing creating the read_policies directory is that the
> > > next changes and new read policies are going to intruduce settings
> > > specific to read policies.
> > 
> > No Documentation/ABI/ update for this change?
> > 
> 
> Good point. As far as I see, we have no btrfs-related file there. I will
> add it to Documentation/ABI/testing in v2.
> 
> I guess we also need to document all the options from btrfs that are
> unaffected by this particular patchset? Would it make sense to cover
> them in a separate patch?

That would be a good idea to do as a separate and new patch, yes.

thanks,

greg k-h
