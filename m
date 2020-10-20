Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26A1294026
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Oct 2020 18:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437030AbgJTQEf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Oct 2020 12:04:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:33618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730935AbgJTQEf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Oct 2020 12:04:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 407E1AF99;
        Tue, 20 Oct 2020 16:04:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F3C3BDA8A2; Tue, 20 Oct 2020 18:03:02 +0200 (CEST)
Date:   Tue, 20 Oct 2020 18:03:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v4 5/8] btrfs: show rescue=usebackuproot in /proc/mounts
Message-ID: <20201020160302.GA6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1602862052.git.josef@toxicpanda.com>
 <007ef6e4d542210148bc373d3a432d801e83019e.1602862052.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007ef6e4d542210148bc373d3a432d801e83019e.1602862052.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 16, 2020 at 11:29:17AM -0400, Josef Bacik wrote:
> This got missed somehow, so add it in.

No, that it's not in the list is intentional, see disk-io.c:

3348         /*
3349          * backuproot only affect mount behavior, and if open_ctree succeeded,
3350          * no need to keep the flag
3351          */
3352         btrfs_clear_opt(fs_info->mount_opt, USEBACKUPROOT);

so it would never reach show_options, but the question is if it should
be in the list. I'd vote for yes, it maybe made some sense for a
standalone option but now that it's a one of rescue, it should not
randomy disappear.
