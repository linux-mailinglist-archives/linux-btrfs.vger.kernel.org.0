Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F0922526E
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jul 2020 17:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgGSPTe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jul 2020 11:19:34 -0400
Received: from out20-123.mail.aliyun.com ([115.124.20.123]:43330 "EHLO
        out20-123.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgGSPTe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jul 2020 11:19:34 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09813765|-1;BR=01201311R141S32rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.174735-0.00328815-0.821976;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03302;MF=guan@eryu.me;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.I4L7d4B_1595171968;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.I4L7d4B_1595171968)
          by smtp.aliyun-inc.com(10.147.43.95);
          Sun, 19 Jul 2020 23:19:28 +0800
Date:   Sun, 19 Jul 2020 23:19:28 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        guaneryu@gmail.com
Subject: Re: [PATCH v2] fstests: btrfs test if show_devname returns sprout
 device
Message-ID: <20200719151928.GB2557159@desktop>
References: <6dcd6b3c-06a9-51a7-988b-63cb254d7749@suse.com>
 <20200713110017.66825-1-anand.jain@oracle.com>
 <f8d76542-f7bb-5207-267e-82dae31e49af@suse.com>
 <c334d1b4-5d68-f1ce-44b2-2c7501760f53@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c334d1b4-5d68-f1ce-44b2-2c7501760f53@oracle.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 13, 2020 at 07:32:57PM +0800, Anand Jain wrote:
> 
> 
> 
> > > +# check if the show_devname() returns the sprout device instead of seed device.
> > > +cat /proc/self/mounts | grep $SCRATCH_MNT | awk '{print $1}' | \
> > > +							_filter_devs $sprout
> > 
> > Why does this have to be so complicated - 4 chained program executions,
> > 1 additional function...
> > 
> 
> For example:
>  /dev/sdb /btrfs btrfs ro,relatime,noacl,space_cache,subvolid=5,subvol=/ 0 0
> 
>  $1 to $3 remain constant, but $4 options might vary. So to avoid
>  unnecessary breakage of test case due to kernel updates or mount
>  options, I just used $1.
> 
> > dev=$(grep $SCRATCH_MOUNT /proc/mounts | awk '{printf $1}')

This looks simpler, just use $AWK_PROG instead of bare awk.

> > 
> > if [ $sprout != $dev ]; then
> >   _fail "Unexpected device"
> > fi
>  fstests prefers use of .out file to look for the expected string.
>  Will wait for Eryu comments.

Even $dev is not constant, we don't have to filter the device to
"SCRATCH_DEV" by _filter_devs. Just do

echo "Silence is golden"
if [ "$sprout" != "$dev" ]; then
	echo "Unexpected device: $dev"
fi

Thanks,
Eryu
