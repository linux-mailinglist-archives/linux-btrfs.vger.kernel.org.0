Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD93625C47C
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 17:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbgICPLm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 11:11:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:46698 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729273AbgICPLZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Sep 2020 11:11:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E2DDDAD1B;
        Thu,  3 Sep 2020 15:11:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 40710DA6E0; Thu,  3 Sep 2020 17:10:10 +0200 (CEST)
Date:   Thu, 3 Sep 2020 17:10:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] btrfs: set ret to 0 in btrfs_get_extent
Message-ID: <20200903151010.GU28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200903143715.14848-1-nborisov@suse.com>
 <ca973e9e-d997-3ebd-9c15-f3889c9f8894@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca973e9e-d997-3ebd-9c15-f3889c9f8894@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 03, 2020 at 05:38:29PM +0300, Nikolay Borisov wrote:
> 
> 
> On 3.09.20 г. 17:37 ч., Nikolay Borisov wrote:
> > When btrfs_get_extent is called for a range that has an overlapping
> > inline extent coupled with  with 'page' parameter being
> > NULL it will erroneously return an error instead of the populate
> > extent_mapping struct. Fix this by setting ret to 0 in case we don't
> > have an exact match for our range.
> > 
> > Fixes: 85b1eebdaf1d: "btrfs: remove err variable from btrfs_get_extent"
> > Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> > ---
> 
> I believe this could simply be folded in the original patch, no ?

Yes, that's what I'm going to do, thanks.
