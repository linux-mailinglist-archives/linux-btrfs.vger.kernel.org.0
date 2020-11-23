Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2B42C12C6
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Nov 2020 19:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390646AbgKWSAU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Nov 2020 13:00:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:56708 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbgKWSAS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Nov 2020 13:00:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 58D69AE1C;
        Mon, 23 Nov 2020 18:00:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A8E7ADA818; Mon, 23 Nov 2020 18:58:26 +0100 (CET)
Date:   Mon, 23 Nov 2020 18:58:26 +0100
From:   David Sterba <dsterba@suse.cz>
To:     kaixuxia <xiakaixu1987@gmail.com>
Cc:     dsterba@suse.cz, dsterba@suse.com, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] btrfs: remove the useless value assignment in
 block_rsv_release_bytes
Message-ID: <20201123175826.GL8669@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, kaixuxia <xiakaixu1987@gmail.com>,
        dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
References: <1605422363-14947-1-git-send-email-kaixuxia@tencent.com>
 <20201116151512.GJ6756@twin.jikos.cz>
 <104c5965-fbbe-b306-e835-5f2bbf60aa7f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <104c5965-fbbe-b306-e835-5f2bbf60aa7f@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 17, 2020 at 11:17:17AM +0800, kaixuxia wrote:
> 
> 
> On 2020/11/16 23:15, David Sterba wrote:
> > On Sun, Nov 15, 2020 at 02:39:23PM +0800, xiakaixu1987@gmail.com wrote:
> >> From: Kaixu Xia <kaixuxia@tencent.com>
> >>
> >> The variable qgroup_to_release is overwritten by the following if/else
> >> statement before it is used, so this assignment is useless. Remove it.
> > 
> > Again this lacks explanation why removing it is correct.
> > 
> Actually this assignment is redundant because the variable qgroup_to_release
> has been overwritten before it is used. The logic like this,

That's obvious and I did not mean that. Have you checked in which commit
the variable became unused and why? It's possible that it was indeed
just an oversight, but if not it could point to a bug.
