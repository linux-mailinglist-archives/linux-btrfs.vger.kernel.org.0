Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6684866B3
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jan 2022 16:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240466AbiAFP16 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 10:27:58 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:48430 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240464AbiAFP15 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jan 2022 10:27:57 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6E77321126;
        Thu,  6 Jan 2022 15:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641482876;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=37QfFOPjWIiRZlHgWjc3hEgksqJzSBKKjQZ1fKAgkIU=;
        b=kF3RRre6alq1t2sSsNko2WnjptBGFh4bC1G65omKAa0pzMXYwSkUQxs2c2r151NiE92k0e
        Cc1Md+dsvjtk+FncOsKFzGeMk8r0wNcex3S2O+my7Tudyp8gyaY4WQxeAKDfo97Vq+Mh4h
        R9dLNMqHa9WrqlRkgCCPbGT4uPns7Ns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641482876;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=37QfFOPjWIiRZlHgWjc3hEgksqJzSBKKjQZ1fKAgkIU=;
        b=D8JpbLJhgZHWvqPT3dH49Firxg/iDO1MPEV9AnBwA1krtr8XTJysrfHDLayS5qYyzlyr8w
        yQZ3MNNY7d3+dRAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 654EBA3B85;
        Thu,  6 Jan 2022 15:27:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E405ADA799; Thu,  6 Jan 2022 16:27:25 +0100 (CET)
Date:   Thu, 6 Jan 2022 16:27:25 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sahil Kang <sahil.kang@asilaycomputing.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/1] btrfs: reuse existing pointers from btrfs_ioctl
Message-ID: <20220106152725.GG14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Sahil Kang <sahil.kang@asilaycomputing.com>,
        linux-btrfs@vger.kernel.org
References: <20220105083006.2793559-1-sahil.kang@asilaycomputing.com>
 <20220105083006.2793559-2-sahil.kang@asilaycomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105083006.2793559-2-sahil.kang@asilaycomputing.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 05, 2022 at 12:30:06AM -0800, Sahil Kang wrote:
> btrfs_ioctl already contains pointers to the inode and btrfs_root
> structs, so we can pass them into the subfunctions instead of the
> toplevel struct file.
> 
> Signed-off-by: Sahil Kang <sahil.kang@asilaycomputing.com>

Added to misc-next, thanks.
