Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBC8D1024CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 13:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfKSMpz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 07:45:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:46716 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbfKSMpz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 07:45:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 05217AC2E;
        Tue, 19 Nov 2019 12:45:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 507B3DAAC2; Tue, 19 Nov 2019 13:45:55 +0100 (CET)
Date:   Tue, 19 Nov 2019 13:45:55 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix error messages in qgroup_rescan_init
Message-ID: <20191119124554.GS3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191118121644.15289-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118121644.15289-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 18, 2019 at 02:16:44PM +0200, Nikolay Borisov wrote:
> The branch of qgroup_rescan_init which is executed from the mount
> path prints wrong errors messages. The textual print out in case
> BTRFS_QGROUP_STATUS_FLAG_RESCAN/BTRFS_QGROUP_STATUS_FLAG_ON are not
> set are transposed. Fix it by exchanging their place.

While that's fixing the swapped messages, I'm considering dropping some
of the messages completely. Eg. the warning 'rescan in progress' seems
useless because why I as a user should be notified about that? If I run
rescan twice and it's still in progress, there's no problem. And with
similar usability reasoning, look at the messages and drop them
eventually.

The specific messages were added by Qu in 9593bf49675ef, to improve the
message that printed function name and error code. That was an
improvement but now I'm questioning the utility of the messages.
