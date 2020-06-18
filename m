Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789CF1FF548
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jun 2020 16:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731184AbgFROqT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jun 2020 10:46:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:44340 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730858AbgFROqS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jun 2020 10:46:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B6909ACF9;
        Thu, 18 Jun 2020 14:46:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2BCF1DA703; Thu, 18 Jun 2020 16:46:06 +0200 (CEST)
Date:   Thu, 18 Jun 2020 16:46:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 btrfs/for-next] btrfs: fix fatal extent_buffer
 readahead vs releasepage race
Message-ID: <20200618144605.GW27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <CAL3q7H4GqjcesWir69PULr4a9rSi2cVQ366y5bAEU23wS6xJkA@mail.gmail.com>
 <20200617183519.152946-1-boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617183519.152946-1-boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 17, 2020 at 11:35:19AM -0700, Boris Burkov wrote:
[...]

> Signed-off-by: Boris Burkov <boris@bur.io>

Added to misc-next, thanks.
