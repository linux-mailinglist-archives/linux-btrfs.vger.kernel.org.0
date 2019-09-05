Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68BD0AA625
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2019 16:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389760AbfIEOn0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Sep 2019 10:43:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:37804 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726080AbfIEOn0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Sep 2019 10:43:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 05ED9B0BF;
        Thu,  5 Sep 2019 14:43:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 88B18DA8F3; Thu,  5 Sep 2019 16:43:50 +0200 (CEST)
Date:   Thu, 5 Sep 2019 16:43:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: Don't assign retval of
 btrfs_try_tree_write_lock/btrfs_tree_read_lock_atomic
Message-ID: <20190905144350.GB2850@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190904171635.13783-1-nborisov@suse.com>
 <20190904172239.14276-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904172239.14276-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 04, 2019 at 08:22:39PM +0300, Nikolay Borisov wrote:
> Those function are simple boolean predicates there is no need to assign
> their return values to interim variables. Use them directly as
> predicates. No functional changes.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next, thanks.
