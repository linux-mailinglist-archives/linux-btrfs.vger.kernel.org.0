Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE6419AF30
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Apr 2020 17:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733223AbgDAP6U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Apr 2020 11:58:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:46698 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732980AbgDAP6U (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Apr 2020 11:58:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 75C37AC92;
        Wed,  1 Apr 2020 15:58:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 65771DA727; Wed,  1 Apr 2020 17:57:44 +0200 (CEST)
Date:   Wed, 1 Apr 2020 17:57:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 5/7] btrfs: Add missing annotation for
 btrfs_lock_cluster()
Message-ID: <20200401155744.GU5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jules Irenge <jbi.octave@gmail.com>,
        linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>
References: <0/7>
 <20200331204643.11262-1-jbi.octave@gmail.com>
 <20200331204643.11262-6-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331204643.11262-6-jbi.octave@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 31, 2020 at 09:46:41PM +0100, Jules Irenge wrote:
> Sparse reports a warning at btrfs_lock_cluster()
> 
> warning: context imbalance in btrfs_lock_cluster()
> 	- wrong count
> 
> The root cause is the missing annotation at btrfs_lock_cluster()
> Add the missing __acquires(&cluster->refill_lock) annotation.
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

Thanks, I'll add it to devel queue. 
