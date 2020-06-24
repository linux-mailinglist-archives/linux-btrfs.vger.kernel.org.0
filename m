Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD252078E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 18:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404890AbgFXQRP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 12:17:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:41260 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404431AbgFXQRP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 12:17:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E6779B158;
        Wed, 24 Jun 2020 16:17:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F1A99DA79B; Wed, 24 Jun 2020 18:16:24 +0200 (CEST)
Date:   Wed, 24 Jun 2020 18:16:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Denis Efremov <efremov@linux.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: tests: remove if duplicate in
 __check_free_space_extents()
Message-ID: <20200624161624.GX27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Denis Efremov <efremov@linux.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200622201841.14619-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622201841.14619-1-efremov@linux.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 22, 2020 at 11:18:41PM +0300, Denis Efremov wrote:
> num_extents is already checked in the next if condition and can
> be safely removed.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>

Added to misc-next, thanks.
