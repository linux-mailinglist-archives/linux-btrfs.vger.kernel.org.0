Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8D232C545
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Mar 2021 01:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450653AbhCDATz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Mar 2021 19:19:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:34588 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351160AbhCCPRh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Mar 2021 10:17:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1DE02AC24;
        Wed,  3 Mar 2021 15:16:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7D462DA82B; Wed,  3 Mar 2021 16:14:58 +0100 (CET)
Date:   Wed, 3 Mar 2021 16:14:58 +0100
From:   David Sterba <dsterba@suse.cz>
To:     kreijack@inwind.it
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: add a warning and countdown for RAID5/6
 conversion
Message-ID: <20210303151458.GL7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, kreijack@inwind.it,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <164e102b2a6179f9af35ded962c11d780ccf8400.1598375602.git.josef@toxicpanda.com>
 <969bf9a2-6635-d7a4-a4b2-ae1fa28c73ed@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <969bf9a2-6635-d7a4-a4b2-ae1fa28c73ed@libero.it>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 25, 2020 at 07:28:45PM +0200, Goffredo Baroncelli wrote:
> On 8/25/20 7:13 PM, Josef Bacik wrote:
> > Similar to the mkfs warning, add a warning to btrfs balance -*convert
> > options, with a countdown to allow the user to have time to cancel the
> > operation.
> 
> It is possible to add a switch to skip the countdown ? Something like
> "--balance-raid56-i-know-what-i-am-doing". I am thinking to the
> developers which are doing some tests

I'd rather not add a new option for that, I think reusing --force for
that reason should be enough. It's otherwise used for redundancy
reduction, which does not get affected when the raid56 profiles are not
used.
