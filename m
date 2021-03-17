Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A00F33F05A
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 13:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhCQM3x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 08:29:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:59982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229727AbhCQM3f (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 08:29:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 498E6AC23;
        Wed, 17 Mar 2021 12:29:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 12C9EDA6E2; Wed, 17 Mar 2021 13:27:31 +0100 (CET)
Date:   Wed, 17 Mar 2021 13:27:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/3] Handle bad dev_root properly with rescue=all
Message-ID: <20210317122731.GQ7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1615479658.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615479658.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 11, 2021 at 11:23:13AM -0500, Josef Bacik wrote:
> Hello,
> 
> My recent debugging session with Neal's broken filesystem uncovered a glaring
> hole in my rescue=all patches, they don't deal with a NULL dev_root properly.
> In testing I only ever tested corrupting the extent tree or the csum tree, since
> those are the most problematic.  The following 3 fixes allowed Neal to get
> rescue=all working without panicing the machine, and I verified everything by
> using btrfs-corrupt-block to corrupt a dev root of a file system.  Thanks,

When rescue= is set lots of things can't work, I was wondering if we
should add messages once the "if (!dev_root)" cases are hit but I don't
think we need it, it should be clear enough from the other rescue=
related messages.
