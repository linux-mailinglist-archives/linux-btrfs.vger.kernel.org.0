Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2404836178
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2019 18:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfFEQi3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jun 2019 12:38:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:33142 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728263AbfFEQi3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jun 2019 12:38:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 20CB5AC3F
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jun 2019 16:38:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 840A0DA866; Wed,  5 Jun 2019 18:39:19 +0200 (CEST)
Date:   Wed, 5 Jun 2019 18:39:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: Metadata preallocation enhancement
Message-ID: <20190605163919.GG9896@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190416102144.12173-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416102144.12173-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 16, 2019 at 06:21:42PM +0800, Qu Wenruo wrote:
> This patchset will address the github issue #123 to make btrfs-convert
> less possible to report false ENOSPC.
> 
> The first patch will try to avoid the nested chunk/extent tree
> modification in a more explicit way.
> 
> The 2nd patch will address the ENOSPC problem, by adding CSUM tree to
> the metadata preallocate list.
> 
> The 2nd patch is not as aggressive as 7a12d8470e5f ("btrfs-progs:
> Do metadata preallocation as long as we're not modifying extent tree").
> Even we have the 1st patch I still prefer to make less modification to
> avoid possible bugs.
> 
> Qu Wenruo (2):
>   btrfs-progs: Avoid nested chunk allocation call
>   btrfs-progs: Do metadata preallocation for fs trees and csum tree

Added to devel, thanks.
