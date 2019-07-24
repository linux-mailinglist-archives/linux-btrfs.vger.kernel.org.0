Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4880172CBF
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2019 13:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfGXLA7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jul 2019 07:00:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:33192 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726514AbfGXLA7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jul 2019 07:00:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ECA79AF8E;
        Wed, 24 Jul 2019 11:00:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 396CADA808; Wed, 24 Jul 2019 13:01:35 +0200 (CEST)
Date:   Wed, 24 Jul 2019 13:01:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: check: initialize qgroup_item_count in
 earlier stage
Message-ID: <20190724110135.GJ2868@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20190723091911.19598-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723091911.19598-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 23, 2019 at 06:19:11PM +0900, Naohiro Aota wrote:
> "btrfsck -Q" segfaults because it does not call qgroup_set_item_count_ptr()
> properly:
> 
>   # btrfsck -Q /dev/sdk
>   Opening filesystem to check...
>   Checking filesystem on /dev/sdk
>   UUID: 34a35bbc-43f8-40f0-8043-65ed33f2e6c3
>   Print quota groups for /dev/sdk
>   UUID: 34a35bbc-43f8-40f0-8043-65ed33f2e6c3
>   Segmentation fault (core dumped)
> 
> Since "struct task_ctx ctx" is global, we can just move
> qgroup_set_item_count_ptr() much earlier stage in the check process to
> avoid to forget initializing it.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Applied, thanks.
