Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6854614DF88
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 17:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgA3Q75 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 11:59:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:50672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727158AbgA3Q75 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 11:59:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A7E22AFF4;
        Thu, 30 Jan 2020 16:59:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 67E05DA84C; Thu, 30 Jan 2020 17:59:36 +0100 (CET)
Date:   Thu, 30 Jan 2020 17:59:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     halfdog <me@halfdog.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: FIDEDUPERANGE woes
Message-ID: <20200130165936.GY3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, halfdog <me@halfdog.net>,
        linux-btrfs@vger.kernel.org
References: <2019-1576167349.500456@svIo.N5dq.dFFD>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2019-1576167349.500456@svIo.N5dq.dFFD>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 12, 2019 at 04:15:49PM +0000, halfdog wrote:
> Hello list,
> 
> Using btrfs on
> 
> Linux version 5.3.0-2-amd64 (debian-kernel@lists.debian.org) (gcc version 9.2.1 20191109 (Debian 9.2.1-19)) #1 SMP Debian 5.3.9-3 (2019-11-19)
> 
> the FIDEDUPERANGE exposes weird behaviour on two identical but
> not too large files that seems to be depending on the file size.
> Before FIDEDUPERANGE both files have a single extent, afterwards
> first file is still single extent, second file has all bytes sharing
> with the extent of the first file except for the last 4096 bytes.
> 
> Is there anything known about a bug fixed since the above mentioned
> kernel version?

For the record, the fix(es) for deduplicating tail extents have been
merged to 5.6 and will appear in stable trees soon.
