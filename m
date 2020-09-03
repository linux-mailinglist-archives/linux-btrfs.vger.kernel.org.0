Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9AC325BE23
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 11:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgICJMj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 05:12:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:41408 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgICJMi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Sep 2020 05:12:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 13F96AC4C;
        Thu,  3 Sep 2020 09:12:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3CD95DA6E0; Thu,  3 Sep 2020 11:11:24 +0200 (CEST)
Date:   Thu, 3 Sep 2020 11:11:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>,
        David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ltp@lists.linux.it, linux-btrfs@vger.kernel.org
Subject: Re: [btrfs] c0aaf9b7a1: ltp: stuck at diotest4
Message-ID: <20200903091123.GO28318@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        kernel test robot <oliver.sang@intel.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ltp@lists.linux.it, linux-btrfs@vger.kernel.org
References: <20200903062837.GA3654@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903062837.GA3654@xsang-OptiPlex-9020>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 03, 2020 at 02:28:37PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: c0aaf9b7a114f6b75e0da97be7d99c102347a751 ("btrfs: switch to iomap_dio_rw() for dio")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

That's probably the O_DIRECT + O_(D)SYNC deadlock that was found
recently. One of the cases in diotest4 does

	open(filename, O_DIRECT | O_RDWR | O_SYNC)

Fix is work in progress, thanks for the report.
