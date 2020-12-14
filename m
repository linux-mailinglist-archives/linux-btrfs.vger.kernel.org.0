Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D858E2D9DF3
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 18:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502317AbgLNRjv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 12:39:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:49362 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408632AbgLNRjg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 12:39:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8A883AC10;
        Mon, 14 Dec 2020 17:38:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C2FACDA7C3; Mon, 14 Dec 2020 18:37:15 +0100 (CET)
Date:   Mon, 14 Dec 2020 18:37:15 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 for-next 0/3] btrfs async discard fixes & improvements
Message-ID: <20201214173715.GR6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Pavel Begunkov <asml.silence@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1607269878.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1607269878.git.asml.silence@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 06, 2020 at 03:56:19PM +0000, Pavel Begunkov wrote:
> Fix async discard stalls with the first patch, and address other minor
> things.
> 
> v2: fix async discard stalls, see patch [1/3]
> v3: if now == bg->discard_eligible_time it fails to init discard state,
>     and index. Always init it if peek return !=NULL bg, it's more
>     resilient.
> 
> Pavel Begunkov (3):
>   btrfs: fix async discard stall
>   btrfs: fix racy access to discard_ctl data
>   btrfs: don't overabuse discard lock

Thanks.  I'll add the patchset to for-next and will send it with some
post rc1 pull request. 
