Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0853797C13
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 16:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbfHUOHf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 10:07:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:59014 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727949AbfHUOHf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 10:07:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 75603AFD4;
        Wed, 21 Aug 2019 14:07:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7A345DA7DB; Wed, 21 Aug 2019 16:07:59 +0200 (CEST)
Date:   Wed, 21 Aug 2019 16:07:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 8/8] btrfs: remove orig_bytes from reserve_ticket
Message-ID: <20190821140758.GH18575@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <20190816141952.19369-1-josef@toxicpanda.com>
 <20190816141952.19369-9-josef@toxicpanda.com>
 <7a26af57-a7a5-310f-6568-a274c28312a5@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a26af57-a7a5-310f-6568-a274c28312a5@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 20, 2019 at 11:28:54AM +0300, Nikolay Borisov wrote:
> 
> 
> On 16.08.19 г. 17:19 ч., Josef Bacik wrote:
> > Now that we do not do partial filling of tickets simply remove
> > orig_bytes, it is no longer needed.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> 
> nit: I think this patch should follow directly after 'btrfs: rework
> wake_all_tickets' or it could even be squashed in it. But let's see how
> David will prefer it.

The patch does not apply on current misc-next + the ticket series, but
looking at the patches as they are now, the separation seems ok. 8
depends on 7 so the unused code cleanup is not in the fix.
