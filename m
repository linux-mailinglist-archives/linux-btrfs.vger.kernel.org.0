Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4DE4C057C
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Feb 2022 00:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbiBVXpB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 18:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236267AbiBVXpA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 18:45:00 -0500
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7DDAF4F
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 15:44:34 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id BB0AA52EC3E;
        Wed, 23 Feb 2022 10:44:33 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nMepc-00FFq1-Mx; Wed, 23 Feb 2022 10:44:32 +1100
Date:   Wed, 23 Feb 2022 10:44:32 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: test log replay after fsync of file with prealloc
 extents beyond eof
Message-ID: <20220222234432.GF3061737@dread.disaster.area>
References: <abbc821350c8ef515e0a0317b5cbd64e3c5b81ab.1645099449.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abbc821350c8ef515e0a0317b5cbd64e3c5b81ab.1645099449.git.fdmanana@suse.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62157562
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=oGFeUVbbRNcA:10 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
        a=7-415B0cAAAA:8 a=acDezmiKnF9vzkGikd0A:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 17, 2022 at 12:14:21PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that after a full fsync of a file with preallocated extents beyond
> the file's size, if a power failure happens, the preallocated extents
> still exist after we mount the filesystem.
> 
> This test currently fails and there is a patch for btrfs that fixes this
> issue and has the following subject:
> 
>   "btrfs: fix lost prealloc extents beyond eof after full fsync"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/btrfs/261     | 79 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/261.out | 10 ++++++

What is btrfs specific about this test?

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
