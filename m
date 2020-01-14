Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1256713B005
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 17:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgANQwF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 11:52:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:53104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbgANQwF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 11:52:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 09479AEC4;
        Tue, 14 Jan 2020 16:52:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4CB24DA795; Tue, 14 Jan 2020 17:51:51 +0100 (CET)
Date:   Tue, 14 Jan 2020 17:51:51 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: Add self-tests for btrfs_rmap_block
Message-ID: <20200114165151.GF3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191126160439.GI2734@twin.jikos.cz>
 <20191210180045.2047-1-nborisov@suse.com>
 <20200102154032.GJ3929@twin.jikos.cz>
 <d24de3e2-719f-e656-7d75-e5b258eb449b@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d24de3e2-719f-e656-7d75-e5b258eb449b@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 10, 2020 at 04:46:20PM +0200, Nikolay Borisov wrote:
> >> +	int expected_mapped_addr;
> > 
> > This should be bool
> 
> Actually the idea here is for expected_mapped_addr to contains the
> number of addresses we are expected to map. Currently tests only expect
> 0 or 1 but if tests are expanded in the future  this might be 2 or 3.
> 
> THe body of the test does:
> 
>  if (out_ndaddrs != test->expected_mapped_addr) {
>                   for (i = 0; i < out_ndaddrs; i++)
> 
>                           test_msg("Mapped %llu", logical[i]);

Ok, int is fine then.

> >> +	struct rmap_test_vector rmap_tests[] = {
> >> +		{
> >> +			/*
> >> +			 * Tests a chunk with 2 data stripes one of which
> >> +			 * interesects the physical address of the super block
> >> +			 * is correctly recognised.
> >> +			 */
> >> +			.raid_type = BTRFS_BLOCK_GROUP_RAID1,
> >> +			.physical_start = SZ_64M - SZ_4M,
> >> +			.data_stripe_size = SZ_256M,
> >> +			.num_data_stripes = 2,
> >> +			.num_stripes = 2,
> >> +			.data_stripe_phys_start = {SZ_64M - SZ_4M, SZ_64M - SZ_4M + SZ_256M},
> > 
> > Formatting
> 
> What do you mean?

Line over 80 cols
