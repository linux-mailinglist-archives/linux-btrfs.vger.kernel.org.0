Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8C620765
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2019 14:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfEPM4s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 May 2019 08:56:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:52552 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726537AbfEPM4s (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 May 2019 08:56:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A8CC4AA71
        for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2019 12:56:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 84DE2DA86C; Thu, 16 May 2019 14:57:47 +0200 (CEST)
Date:   Thu, 16 May 2019 14:57:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: tree-checker: Check if the file extent end
 overflow
Message-ID: <20190516125746.GZ3138@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190503003054.9346-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503003054.9346-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 03, 2019 at 08:30:54AM +0800, Qu Wenruo wrote:
> Under certain condition, we could have strange file extent item in log
> tree like:
> 
>   item 18 key (69599 108 397312) itemoff 15208 itemsize 53
> 	extent data disk bytenr 0 nr 0
> 	extent data offset 0 nr 18446744073709547520 ram 18446744073709547520
> 
> The num_bytes and ram_bytes part overflow.
> 
> For num_bytes part, we can detect such overflow along with file offset
> (key->offset), as file_offset + num_bytes should never go beyond u64
> max.
> 
> For ram_bytes part, it's about the decompressed size of the extent, not
> directly related to the size.
> In theory is OK to have super large value, and put extra
> limitation on ram bytes may cause unexpected false alert.
> 
> So in tree-checker, we only check if the file offset and num bytes
> overflow.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

So this patch can be dropped because of "Btrfs: tree-checker: detect
file extent items with overlapping ranges", right?
