Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90033240838
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 17:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgHJPOa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 11:14:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:46440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgHJPOa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 11:14:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 27036ACA2;
        Mon, 10 Aug 2020 15:14:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 12BC3DA7D5; Mon, 10 Aug 2020 17:13:28 +0200 (CEST)
Date:   Mon, 10 Aug 2020 17:13:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Pierre Couderc <pierre@couderc.eu>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Is there some doc or some example of libbtrfs ?
Message-ID: <20200810151327.GC2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Pierre Couderc <pierre@couderc.eu>,
        linux-btrfs@vger.kernel.org
References: <4bf44e81-0b4f-9c99-3010-410e110aec2d@couderc.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bf44e81-0b4f-9c99-3010-410e110aec2d@couderc.eu>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 07, 2020 at 11:36:10AM +0200, Pierre Couderc wrote:
> Ho do I get programmatically the list of the snapshots of a volume in C/C++?
> 
> I can analyse the output of "btrfs li sh", but is there an easier way ?
> 
> I have found no doc or example...

Please don't use libbtrfs, that's going to be removed in the future.
There's a proper library libbtrfsutil. See
btrfs_util_create_subvolume_iterator.
