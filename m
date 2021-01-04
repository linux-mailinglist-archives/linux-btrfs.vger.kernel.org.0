Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A602E9827
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jan 2021 16:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbhADPNo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jan 2021 10:13:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:42508 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbhADPNn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Jan 2021 10:13:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2B1D5ACAF;
        Mon,  4 Jan 2021 15:13:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 98DEBDA882; Mon,  4 Jan 2021 16:11:13 +0100 (CET)
Date:   Mon, 4 Jan 2021 16:11:13 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Defang Bo <bodefang@126.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] fs/btrfs: avoid null pointer dereference if reloc
 control has not been initialized
Message-ID: <20210104151113.GG6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Defang Bo <bodefang@126.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1609080931-4048864-1-git-send-email-bodefang@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609080931-4048864-1-git-send-email-bodefang@126.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 27, 2020 at 10:55:31PM +0800, Defang Bo wrote:
> Similar to commmit<389305b2>,

Please use full commit reference like 389305b2aa68 ("btrfs: relocation:
Only remove reloc rb_trees if reloc control has been initialized")

> it turns out that fs_info::reloc_ctl can be NULL ,

Please describe how the NULL can get there.
