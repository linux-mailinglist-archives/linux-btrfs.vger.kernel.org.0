Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 199C917A900
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2020 16:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgCEPip (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Mar 2020 10:38:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:42822 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbgCEPip (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Mar 2020 10:38:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 851ECB008;
        Thu,  5 Mar 2020 15:38:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 41227DA728; Thu,  5 Mar 2020 16:38:20 +0100 (CET)
Date:   Thu, 5 Mar 2020 16:38:19 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs-progs: fix check to catch gaps at the start of
 the file
Message-ID: <20200305153819.GD2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200130204736.49224-1-josef@toxicpanda.com>
 <20200130204736.49224-2-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130204736.49224-2-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 30, 2020 at 03:47:35PM -0500, Josef Bacik wrote:
> When writing my test for the i_size patches, I noticed that I was not
> actually failing without my patches as I should have been.  This is
> because we assume the first extent we find is the first valid spot, so
> we don't actually add a hole entry if there is no extent at offset 0.
> Fix this by setting our extent_start and extent_end to 0 so we can
> properly catch the corruption.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

This patch does not pass tests:

    [TEST/fsck]   020-extent-ref-cases                                                                   
failed: /labs/dsterba/gits/btrfs-progs/btrfs check ./keyed_data_ref_with_shared_leaf.img.restored        
test failed for case 020-extent-ref-cases
