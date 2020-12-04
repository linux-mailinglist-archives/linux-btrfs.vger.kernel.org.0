Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED132CF365
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Dec 2020 18:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387746AbgLDRyX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Dec 2020 12:54:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:41722 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgLDRyX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Dec 2020 12:54:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 00BDBACBD;
        Fri,  4 Dec 2020 17:53:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 039D4DA7E3; Fri,  4 Dec 2020 18:52:06 +0100 (CET)
Date:   Fri, 4 Dec 2020 18:52:06 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH] btrfs: free-space-cache: Fix error return code in
 __load_free_space_cache
Message-ID: <20201204175206.GZ6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Zhihao Cheng <chengzhihao1@huawei.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20201120010804.440598-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120010804.440598-1-chengzhihao1@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 20, 2020 at 09:08:04AM +0800, Zhihao Cheng wrote:
> Fix to return the error code(instead always 0) when memory allocating
> failed in __load_free_space_cache().

This lacks the analysis of consequences, so there's only one caller and
that will treat values <=0 as 'cache not loaded'. There's no functional
change but otherwise the error values should be there for clarity.
Changelog updated.

> Fixes: a67509c30079f4c50 ("Btrfs: add a io_ctl struct and helpers ...")

BTW, please don't trim the patch subject in the Fixes line.
