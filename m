Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4461EDB544
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 19:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394935AbfJQR4b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Oct 2019 13:56:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:50124 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394627AbfJQR4a (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Oct 2019 13:56:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5A7FFADD9;
        Thu, 17 Oct 2019 17:56:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E6406DA808; Thu, 17 Oct 2019 19:56:39 +0200 (CEST)
Date:   Thu, 17 Oct 2019 19:56:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs llseek improvement, take 2
Message-ID: <20191017175638.GM2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190927102318.12830-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927102318.12830-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 27, 2019 at 01:23:15PM +0300, Nikolay Borisov wrote:
> Here is v2 of the llseek improvements, main changes are: 
> 
>  * Patch 1 - changed the locking scheme. I'm now using inode_lock_shared since 
>  holding the extent lock is not sufficient to prevent concurrent truncates. 
> 
>  * Fixed lingo bugs in patch 2 changelog (Johaness)
> 
> Nikolay Borisov (3):
>   btrfs: Speed up btrfs_file_llseek
>   btrfs: Simplify btrfs_file_llseek
>   btrfs: Return offset from find_desired_extent

Moved from topic branch to misc-next. Thanks.
