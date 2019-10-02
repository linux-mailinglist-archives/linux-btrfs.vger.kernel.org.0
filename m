Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA224C8701
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2019 13:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfJBLJo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 07:09:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:47604 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbfJBLJo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Oct 2019 07:09:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4CFC2AFB0;
        Wed,  2 Oct 2019 11:09:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C55A0DA88C; Wed,  2 Oct 2019 13:10:00 +0200 (CEST)
Date:   Wed, 2 Oct 2019 13:10:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add device scanned-by process name in the scan
 message
Message-ID: <20191002111000.GL2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <1570012248-16099-1-git-send-email-anand.jain@oracle.com>
 <1e84a4cb-1c50-9dbb-99ee-a50632a8f0ff@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e84a4cb-1c50-9dbb-99ee-a50632a8f0ff@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 02, 2019 at 01:39:03PM +0300, Nikolay Borisov wrote:
> 
> 
> On 2.10.19 г. 13:30 ч., Anand Jain wrote:
> > Its very helpful if we had logged the device scanner process name
> > to debug the race condition between the systemd-udevd scan and the
> > user initiated device forget command.
> > 
> > This patch adds scanned-by process name to the scan message.
> > 
> > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> Same effect can be achieved (for debugging purposes) if you have used
> ftrace on device_list_add without needing to patch the kernel.

For reproducible issues adding a debugging hooks is fine but races can
be tricky and device scanning depends on the state of the system and
other processes so I understand the need to document what happens for
post-mortem analysis.

> I'm somewhat indifferent whether this will be merged or not but I
> personally don't see much value in it.

We have messages for many administrative tasks, either requested by
users or by developers so I don't object in principle against adding
more.
