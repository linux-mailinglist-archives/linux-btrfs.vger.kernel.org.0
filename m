Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32AB919CF6
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2019 14:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfEJMEN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 May 2019 08:04:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:58480 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727067AbfEJMEM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 May 2019 08:04:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 68364ACD4
        for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2019 12:04:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 95B7FDA8D6; Fri, 10 May 2019 14:05:09 +0200 (CEST)
Date:   Fri, 10 May 2019 14:05:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Ordered extent flushing refactor
Message-ID: <20190510120509.GZ20156@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190507071924.17643-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507071924.17643-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 07, 2019 at 10:19:21AM +0300, Nikolay Borisov wrote:
> Here is v2 of factoring out common code when flushing ordered extent. The main
> change in this version is the switch from inode to btrfs_inode for  function 
> interfaces as per David's feedback. 
> 
> Nikolay Borisov (3):
>   btrfs: Implement btrfs_lock_and_flush_ordered_range
>   btrfs: Use newly introduced btrfs_lock_and_flush_ordered_range
>   btrfs: Always use a cached extent_state in
>     btrfs_lock_and_flush_ordered_range

1-3 added to 5.3 queue, thanks.
