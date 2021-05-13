Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3053800A0
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 01:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhEMXBy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 May 2021 19:01:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:50876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231278AbhEMXBw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 May 2021 19:01:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 80DBFAEE5;
        Thu, 13 May 2021 23:00:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 05EBCDAF1B; Fri, 14 May 2021 00:58:10 +0200 (CEST)
Date:   Fri, 14 May 2021 00:58:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [Patch v2 03/42] btrfs: remove the unused parameter @len for
 btrfs_bio_fits_in_stripe()
Message-ID: <20210513225810.GN7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427230349.369603-4-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 28, 2021 at 07:03:10AM +0800, Qu Wenruo wrote:
> The parameter @len is not really used in btrfs_bio_fits_in_stripe(),
> just remove it.

I looked up the commit that stopped using @len, 420343131970 and updated
changelog to say why.
