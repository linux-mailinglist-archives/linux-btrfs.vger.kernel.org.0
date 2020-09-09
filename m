Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E00262F6A
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 15:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgIINSl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 09:18:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:54838 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730349AbgIINQs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Sep 2020 09:16:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B7EFCB253;
        Wed,  9 Sep 2020 13:16:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 97ECDDA7C6; Wed,  9 Sep 2020 15:14:53 +0200 (CEST)
Date:   Wed, 9 Sep 2020 15:14:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com, nborisov@suse.com
Subject: Re: [PATCH v3 0/16] btrfs: seed fix null ptr, use only main
 device_list_mutex, and cleanups
Message-ID: <20200909131453.GG18399@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, josef@toxicpanda.com,
        nborisov@suse.com
References: <cover.1599234146.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1599234146.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 05, 2020 at 01:34:20AM +0800, Anand Jain wrote:
> v3:
> Makes bug fixing patches suitable for the backports. They are patch 1-2.
> patch 1 fix the put of kobject null issue, fixed by checking the
>         state_initalized.
> patch 2 fixes the replacement of seed device in a sprout filesystem.

These go to misc-next,

> The rest of the patches remains the same, except for a conflict fix in patch 4.
> 
> The patch set has passed xfstests -g volume and seed
> The new patch (seed delete testing) btrfs/219 has been modified to suit
> the older kernels. Which is also attached to this thread.

and the rest will follow soon. I changed some subjects and updated some
changelogs that I found not clear enough but the whole series is
straightforward so no need for resends. Thanks.
