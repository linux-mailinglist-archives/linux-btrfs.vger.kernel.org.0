Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9D632535D
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Feb 2021 17:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbhBYQT0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Feb 2021 11:19:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:35682 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233158AbhBYQS7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Feb 2021 11:18:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5474EAC1D;
        Thu, 25 Feb 2021 16:18:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7F42FDA790; Thu, 25 Feb 2021 17:16:22 +0100 (CET)
Date:   Thu, 25 Feb 2021 17:16:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH 4/5] btrfs: scrub_checksum_tree_block() drop its function
 declaration
Message-ID: <20210225161622.GG7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com
References: <cover.1613019838.git.anand.jain@oracle.com>
 <b19539f16f4292749e201032459f5b2686709f0a.1613019838.git.anand.jain@oracle.com>
 <20210212143639.GJ1993@twin.jikos.cz>
 <d0f695b1-70b9-99d1-9b45-c5b21bc07b42@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0f695b1-70b9-99d1-9b45-c5b21bc07b42@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 25, 2021 at 09:21:31AM +0800, Anand Jain wrote:
> On 12/02/2021 22:36, David Sterba wrote:
> > On Wed, Feb 10, 2021 at 09:25:18PM -0800, Anand Jain wrote:
> >> Move the static function scrub_checksum_tree_block() before its use in
> >> the scrub.c, and drop its declaration.
> >>
> >> No functional changes.
> > 
> 
> > We've rejected patches that move static function within one file unless
> > there's another reason for it other than removing the prototype.
> 
> Ok.
> Patches 1-3 aren't of this type. I suppose they will be integrated?

Yes, they're good cleanups and now in misc-next, thanks.
