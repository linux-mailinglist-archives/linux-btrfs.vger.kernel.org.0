Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D318F12D158
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 16:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfL3PIl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Dec 2019 10:08:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:37270 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727513AbfL3PIl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 10:08:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9B84AADF0;
        Mon, 30 Dec 2019 15:08:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 70939DA790; Mon, 30 Dec 2019 16:08:32 +0100 (CET)
Date:   Mon, 30 Dec 2019 16:08:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: punt all bios created in
 btrfs_submit_compressed_write()
Message-ID: <20191230150831.GT3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <d934383ea528d920a95b6107daad6023b516f0f4.1576109087.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d934383ea528d920a95b6107daad6023b516f0f4.1576109087.git.dennis@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 11, 2019 at 04:07:06PM -0800, Dennis Zhou wrote:
> Compressed writes happen in the background via kworkers. However, this
> causes bios to be attributed to root bypassing any cgroup limits from
> the actual writer. We tag the first bio with REQ_CGROUP_PUNT, which will
> punt the bio to an appropriate cgroup specific workqueue and attribute
> the IO properly. However, if btrfs_submit_compressed_write() creates a
> new bio, we don't tag it the same way. Add the appropriate tagging for
> subsequent bios.
> 
> Fixes: ec39f7696ccfa ("Btrfs: use REQ_CGROUP_PUNT for worker thread submitted bios")
> Cc: Chris Mason <clm@fb.com>
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

1 and 2 queued for 5.5-rc, thanks.
