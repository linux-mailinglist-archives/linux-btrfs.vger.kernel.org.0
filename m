Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19106168471
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 18:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgBURJu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 12:09:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:38218 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbgBURJu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 12:09:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 212D3ACBD;
        Fri, 21 Feb 2020 17:09:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A4991DA70E; Fri, 21 Feb 2020 18:09:31 +0100 (CET)
Date:   Fri, 21 Feb 2020 18:09:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: bail out of uuid tree scanning if we're closing
Message-ID: <20200221170931.GP2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200214200501.2524-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214200501.2524-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 14, 2020 at 03:05:01PM -0500, Josef Bacik wrote:
> In doing my fsstress+EIO stress testing I started running into issues
> where umount would get stuck forever because the uuid checker was
> chewing through the thousands of subvolumes I had created.  We shouldn't
> block umount on this, simply bail if we're unmounting the fs.  We need
> to make sure we don't mark the UUID tree as ok, so we only set that bit
> if we made it through the whole rescan operation, but otherwise this is
> completely safe.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
