Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02563C8E2B
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2019 18:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfJBQV1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 12:21:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:34772 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726669AbfJBQV1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Oct 2019 12:21:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 66B7CAE16;
        Wed,  2 Oct 2019 16:21:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6A21DDA88C; Wed,  2 Oct 2019 18:21:40 +0200 (CEST)
Date:   Wed, 2 Oct 2019 18:21:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] btrfs: fix uninitialized ret in ref-verify
Message-ID: <20191002162138.GQ2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Colin Ian King <colin.king@canonical.com>
References: <20191002140336.2338-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002140336.2338-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 02, 2019 at 10:03:36AM -0400, Josef Bacik wrote:
> Coverity caught a case where we could return with a uninitialized value
> in ret in process_leaf.  This is actually pretty likely because we could
> very easily run into a block group item key and have a garbage value in
> ret and think there was an errror.  Fix this by initializing ret to 0.
> 
> Reported-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: David Sterba <dsterba@suse.com>

Added to misc-next, thanks.
