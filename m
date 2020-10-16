Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F7C290747
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Oct 2020 16:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408942AbgJPOfY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Oct 2020 10:35:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:59500 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408868AbgJPOfX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Oct 2020 10:35:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B00D2ADFE;
        Fri, 16 Oct 2020 14:35:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5567BDA7C3; Fri, 16 Oct 2020 16:33:54 +0200 (CEST)
Date:   Fri, 16 Oct 2020 16:33:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        josef@toxicpanda.com, quwenruo.btrfs@gmx.com,
        Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v2] btrfs: Fix divide by zero
Message-ID: <20201016143354.GU6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Daniel Xu <dxu@dxuuu.xyz>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        josef@toxicpanda.com, quwenruo.btrfs@gmx.com,
        Qu Wenruo <wqu@suse.com>
References: <20201009010910.270794-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009010910.270794-1-dxu@dxuuu.xyz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 08, 2020 at 06:09:10PM -0700, Daniel Xu wrote:
> If there's no parity and num_stripes < ncopies, an btrfs image can
> trigger a divide by zero in calc_stripe_length().
> 
> The image (see link) was generated through fuzzing.
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=209587

For bugzillas please use Bugzilla: tag.

> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

Please write more descriptive subjects like

"btrfs: tree-checker: validate number of chunk stripes and parity"
