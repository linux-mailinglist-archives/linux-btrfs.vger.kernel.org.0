Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C427B2AD84E
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Nov 2020 15:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbgKJOKV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Nov 2020 09:10:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:58860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730097AbgKJOKV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Nov 2020 09:10:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 68B6FABD6;
        Tue, 10 Nov 2020 14:10:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E42B9DA7D7; Tue, 10 Nov 2020 15:08:37 +0100 (CET)
Date:   Tue, 10 Nov 2020 15:08:37 +0100
From:   David Sterba <dsterba@suse.cz>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@intel.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [btrfs]  fac2f60d5f:  fsmark.files_per_sec 62.6% improvement
Message-ID: <20201110140837.GE6756@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        kernel test robot <oliver.sang@intel.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com, linux-btrfs@vger.kernel.org
References: <20201110060012.GA3197@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110060012.GA3197@xsang-OptiPlex-9020>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 10, 2020 at 02:00:12PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a 62.6% improvement of fsmark.files_per_sec due to commit:
> 
> 
> commit: fac2f60d5fe83fd45ee08a85c2eb7a09659edbe3 ("btrfs: switch extent buffer tree lock to rw_semaphore")

Thanks for the report, that's a significant improvement, confirming the
trend that switching the locks does not regress.  I've skimmed other
collected stats and it seems like an overall improvement, so the effects
should be noticeable for other metadata-heavy workloads too.
