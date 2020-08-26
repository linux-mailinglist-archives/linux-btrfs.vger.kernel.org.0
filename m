Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D282B252C60
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 13:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgHZLWB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 07:22:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:36966 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728718AbgHZLVZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 07:21:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA95FB1BE;
        Wed, 26 Aug 2020 11:21:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C34E2DA730; Wed, 26 Aug 2020 13:20:13 +0200 (CEST)
Date:   Wed, 26 Aug 2020 13:20:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/3] btrfs: remove the again: tag in
 process_one_batch()
Message-ID: <20200826112013.GF28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200824075959.85212-1-wqu@suse.com>
 <20200824075959.85212-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824075959.85212-4-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 24, 2020 at 03:59:59PM +0800, Qu Wenruo wrote:
> The again: tag here is for us to retry when we failed to lock extent
> range, which is only used once.

Subject: Re: [PATCH v2 3/3] btrfs: remove the again: tag in process_one_batch()

Please note that the terms 'tag' and 'label' have different meanings,
the jump target in C is called 'label', so please use that.
