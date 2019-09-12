Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2F88B1402
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 19:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfILRtU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 13:49:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:39534 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726132AbfILRtU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 13:49:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1CDE6B823;
        Thu, 12 Sep 2019 17:49:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3F497DA835; Thu, 12 Sep 2019 19:49:35 +0200 (CEST)
Date:   Thu, 12 Sep 2019 19:49:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, jthumshirn@suse.de, dsterba@suse.cz
Subject: Re: [PATCH Fix-title-prefix] btrfs-progs: misc-tests-021 fix restore
 overlapped on disk's stale data
Message-ID: <20190912174935.GL2850@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, jthumshirn@suse.de
References: <23f82b13-5050-0acd-49fb-1ecd06811b8d@suse.de>
 <20190904132947.1232-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904132947.1232-1-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 04, 2019 at 09:29:47PM +0800, Anand Jain wrote:
> As misc-tests/021 image dump is restored on the same original loop
> device, this overlaps with the stale data and makes the test pass
> falsely.
> 
> Fix this by using a new device for restore.
> 
> And also, the btrfs-image dump and restore doesn't not collect the data,
> so any read on the files should be avoided. So instead of file data use
> file stat data for the md5sum.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Reported-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---

Applied, thanks.
