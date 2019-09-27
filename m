Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFB41C0612
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2019 15:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfI0NN1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Sep 2019 09:13:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:49856 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbfI0NN1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Sep 2019 09:13:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 282B8AFB2;
        Fri, 27 Sep 2019 13:13:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B8C58DA897; Fri, 27 Sep 2019 15:13:45 +0200 (CEST)
Date:   Fri, 27 Sep 2019 15:13:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs llseek improvement, take 2
Message-ID: <20190927131345.GV2751@twin.jikos.cz>
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

Regarding the offline discussions, I'd like to see more people look at
that until we're sure that it works, namely seek vs truncate and extent
range locking.
