Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C19D2C584C
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Nov 2020 16:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391337AbgKZPdG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Nov 2020 10:33:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:58010 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731658AbgKZPdG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Nov 2020 10:33:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37CFCACD5;
        Thu, 26 Nov 2020 15:33:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B21E4DA87E; Thu, 26 Nov 2020 16:31:35 +0100 (CET)
Date:   Thu, 26 Nov 2020 16:31:35 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] Remove deprecated inode cache feature
Message-ID: <20201126153135.GY6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201126131039.3441290-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126131039.3441290-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 26, 2020 at 03:10:36PM +0200, Nikolay Borisov wrote:
> This patchset removes inode cache feature which has been deprecated since kernel
> v5.9 release. First 2 patches move code around and replace calls of functions
> which are to be removed. Patch 3 finally removes inode cache for good.

There's still the remaining issue what to do with the space occupied by
the cache inode if the feature was enabled. I haven't researched that,
eg. how big the inode is if it's worth removing it at all or if we
should do some lightweight scan to remove them at some appropriate time.
