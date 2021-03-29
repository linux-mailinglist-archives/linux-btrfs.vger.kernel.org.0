Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35ABC34D7A0
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Mar 2021 20:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhC2S4L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Mar 2021 14:56:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:47338 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231135AbhC2Szr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Mar 2021 14:55:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 400EFB000;
        Mon, 29 Mar 2021 18:55:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 502B5DA842; Mon, 29 Mar 2021 20:53:38 +0200 (CEST)
Date:   Mon, 29 Mar 2021 20:53:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
Message-ID: <20210329185338.GV7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210325071445.90896-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325071445.90896-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 25, 2021 at 03:14:32PM +0800, Qu Wenruo wrote:
> v3:
> - Rename the sysfs to supported_sectorsizes
> 
> - Rebased to latest misc-next branch
>   This removes 2 cleanup patches.
> 
> - Add new overview comment for subpage metadata

V3 is now in for-next, targeting merge for 5.13. Please post any fixups
as replies to the individual patches, I'll fold them in, rather a full
series resend. Thanks.
