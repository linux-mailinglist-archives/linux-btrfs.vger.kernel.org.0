Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE892AF441
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Nov 2020 15:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgKKO7B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Nov 2020 09:59:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:42614 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbgKKO7A (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Nov 2020 09:59:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 41319AFFA;
        Wed, 11 Nov 2020 14:58:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 17E3EDA6E1; Wed, 11 Nov 2020 15:57:12 +0100 (CET)
Date:   Wed, 11 Nov 2020 15:57:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/1] btrfs: cleanup btrfs_free_extra_devids() drop arg
 step
Message-ID: <20201111145711.GQ6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <cover.1604649817.git.anand.jain@oracle.com>
 <a20a37162b49e5b1de7a5ec70607102b61ac94eb.1604649817.git.anand.jain@oracle.com>
 <4275cb92-5451-a193-d7cf-a3f76b7c7cf6@toxicpanda.com>
 <f03b2ced-ed51-bbe4-acfd-147546abddbc@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f03b2ced-ed51-bbe4-acfd-147546abddbc@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Nov 07, 2020 at 07:41:01AM +0800, Anand Jain wrote:
> 
> 
> On 7/11/20 1:02 am, Josef Bacik wrote:
> > On 11/6/20 3:06 AM, Anand Jain wrote:
> >> Following patch
> >>   btrfs: dev-replace: fail mount if we don't have replace item with 
> >> target device
> >> dropped the multi ops of the function btrfs_free_extra_devids(), where 
> >> now
> >> it doesn't check the replace target device. So btrfs_free_extra_devid()
> >> doesn't need the 2nd argument %step anymore. Perpetuate the related
> >> changes back to the functions in the stack.
> >>
> >> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > 
> > Actually nm,  I forgot to build, this thing doesn't compile.  Thanks,
> 
>   The compile fail is not real to this patch. It happened due change in
>   patch's order in the misc-next. In specific, the compile fail happens
>   due to the dependent patch as below,
> 
>     btrfs: fix btrfs_find_device unused arg seed
> 
>   which I fixed locally as below. As David is reviewing the above patch,
>   I didn't want to send another revision and confuse him more. To compile
>   successfully, pls, after the above patch apply for the following
>   changes,

With so many cleanup patches floating around compilation failure due to
some dependency is not a problem. I'll notice and if there's
something beyond trivial to fix it I'd let you know and ask for a
resend.

The patch "btrfs: dev-replace: fail mount if we don't have replace item
with" got merged to master meanwhile so I've updated the reference to
also include the commit id. With that the patch is now in misc-next,
thanks.
