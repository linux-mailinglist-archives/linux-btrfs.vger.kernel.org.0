Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB1E1D5A78
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 May 2020 22:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbgEOT7w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 May 2020 15:59:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:46624 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgEOT7w (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 May 2020 15:59:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 431A7B033;
        Fri, 15 May 2020 19:59:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 12692DA732; Fri, 15 May 2020 21:58:58 +0200 (CEST)
Date:   Fri, 15 May 2020 21:58:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v7 rebased 0/5] readmirror feature (sysfs and in-memory
 only approach; with new read_policy device)
Message-ID: <20200515195858.GS18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <1586173871-5559-1-git-send-email-anand.jain@oracle.com>
 <a963d6c8-f0ec-7d41-ff0a-26d3ef9d013d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a963d6c8-f0ec-7d41-ff0a-26d3ef9d013d@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 30, 2020 at 05:02:27PM +0800, Anand Jain wrote:
>   I am not sure if this will be integrated in 5.8 and worth the time to
>   rebase. Kindly suggest.

The preparatory work is ok, but the actual mirror selection policy
addresses a usecase that I think is not the one most users are
interested in. Devices of vastly different performance capabilities like
rotational disks vs nvme vs ssd vs network block devices in one
filesystem are not something commonly found.

What we really need is a saner balancing mechanism than pid-based, that
is also going to be used any time there are more devices from the same
speed class for the fast devices too.

So, no the patchset is not on track for a merge without the improved
default balancing. The preferred device for reads can be one of the
policies, I understand the usecase and have not problem with that
although wouldn't probably have use for it.
