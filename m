Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5060F14DAEA
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 13:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgA3Mqz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 07:46:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:60140 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbgA3Mqz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 07:46:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 69087ABC4;
        Thu, 30 Jan 2020 12:46:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 61E41DA84C; Thu, 30 Jan 2020 13:46:34 +0100 (CET)
Date:   Thu, 30 Jan 2020 13:46:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Add intrudoction to dev-replace.
Message-ID: <20200130124634.GP3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200123074450.24328-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123074450.24328-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 23, 2020 at 03:44:50PM +0800, Qu Wenruo wrote:
> The overview of btrfs dev-replace is not that complex.
> But digging into the code directly can waste some extra time, so add
> such introduction to help later guys.
> 
> Also, it mentions some corner cases caused by the write duplication and
> scrub based data copy, to inform new comers not to get trapped by that
> pitfall.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Thanks for the docs, I've adjusted some wording and fixed a few typos.
Please try to proofread it before sending, also reviews should catch
and point that out.
