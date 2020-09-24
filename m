Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7683276FDE
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 13:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgIXL0c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 07:26:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:60396 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726850AbgIXL0c (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 07:26:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4EF1BACD0;
        Thu, 24 Sep 2020 11:26:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 58F96DA6E3; Thu, 24 Sep 2020 13:25:14 +0200 (CEST)
Date:   Thu, 24 Sep 2020 13:25:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com
Subject: Re: [PATCH add reported by] btrfs: fix rw_devices count in
 __btrfs_free_extra_devids
Message-ID: <20200924112513.GT6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com
References: <b3a0a629df98bd044a1fd5c4964f381ff6e7aa05.1600777827.git.anand.jain@oracle.com>
 <4f924276-2db3-daba-32ec-1b2cf077d15d@toxicpanda.com>
 <3d5fdbd9-7a2c-d17f-62b7-f312042c7e0a@oracle.com>
 <a9910086-ad40-2cc8-8dd5-923ba6ff3990@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9910086-ad40-2cc8-8dd5-923ba6ff3990@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 23, 2020 at 09:42:17AM -0400, Josef Bacik wrote:
> On 9/23/20 12:42 AM, Anand Jain wrote:
> > On 22/9/20 9:08 pm, Josef Bacik wrote:
> >> On 9/22/20 8:33 AM, Anand Jain wrote:

> Yeah I mean we do something in btrfs_init_dev_replace(), like when we search for 
> the key, we double check to make sure we don't have a devid == 
> BTRFS_DEV_REPLACE_DEVID in our devices if we don't find a key.  If we do we 
> return -EIO and bail out of the mount.  Thanks,

From user perspective, then do what? Or do we treat this with minimal
efforts to provide a sane fallback and error handling just to pass
fuzzers (like in many other cases)?
