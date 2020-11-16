Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBECB2B49E3
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Nov 2020 16:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbgKPPtH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Nov 2020 10:49:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:40344 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730340AbgKPPtH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Nov 2020 10:49:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DB920ABF4;
        Mon, 16 Nov 2020 15:49:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 629D2DA6E3; Mon, 16 Nov 2020 16:47:21 +0100 (CET)
Date:   Mon, 16 Nov 2020 16:47:21 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: Simplify setup_nodes_for_search
Message-ID: <20201116154721.GP6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201113072940.479655-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113072940.479655-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 13, 2020 at 09:29:40AM +0200, Nikolay Borisov wrote:
> The function is needlessly convoluted. Fix that by:
> 
> * Removing redundant sret variable definition in both if arms.
> 
> * Replace the again/done labels with direct return statements, the
> function is short enough and doesn't do anything special upon exit.
> 
> * Remove BUG_ON on split_node returning a positive number - it can't
>   happen as split_node returns either 0 or a negative error code.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next, thanks.
