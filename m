Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F713F3E16
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Aug 2021 08:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhHVGDI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Aug 2021 02:03:08 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:42836 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhHVGDI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Aug 2021 02:03:08 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 5F578B4160F; Sun, 22 Aug 2021 02:02:27 -0400 (EDT)
Date:   Sun, 22 Aug 2021 02:02:27 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Regression in v5.14-rc1: f2165627319f btrfs: compression: don't
 try to compress if we don't have enough pages
Message-ID: <20210822060227.GA27656@hungrycats.org>
References: <20210822055115.GD29026@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210822055115.GD29026@hungrycats.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 22, 2021 at 01:51:15AM -0400, Zygo Blaxell wrote:

I trimmed my cut+paste too eagerly...

> Before this commit:
> 
> 	# head /dev/zero -c 4095 > inline
> 	# compsize inline
	Processed 1 file, 0 regular extents (0 refs), 1 inline.
> 	Type       Perc     Disk Usage   Uncompressed Referenced  
> 	TOTAL        0%       18B         3.9K         3.9K       
> 	zstd         0%       18B         3.9K         3.9K       
> 
> After this commit:
> 
> 	# head /dev/zero -c 4095 > inline                                                                        
> 	# compsize inline                                                                                        
> 	Processed 1 file, 1 regular extents (1 refs), 0 inline.                                                                                      
> 	Type       Perc     Disk Usage   Uncompressed Referenced                                                                                     
> 	TOTAL      100%      4.0K         4.0K         4.0K                                                                                          
> 	none       100%      4.0K         4.0K         4.0K                                                                                          
> 
> This change makes the metadata sizes of trees of small files (e.g. source
> checkouts) blow up.
> 
> It looks like we need to look at the offset of the extent, as well as
> its length.
