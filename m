Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F22E2C8759
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Nov 2020 16:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgK3PCC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Nov 2020 10:02:02 -0500
Received: from rin.romanrm.net ([51.158.148.128]:50060 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbgK3PCC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Nov 2020 10:02:02 -0500
Received: from natsu (unknown [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id 9852F50A;
        Mon, 30 Nov 2020 15:01:16 +0000 (UTC)
Date:   Mon, 30 Nov 2020 20:01:16 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not allow -o compress-force to override
 per-inode settings
Message-ID: <20201130200116.79a710fe@natsu>
In-Reply-To: <b92d0141-f68f-ce96-8099-e145ebc6f594@toxicpanda.com>
References: <a3cd057e747862eb7027ac6318bd26c6c36e0c49.1606743972.git.josef@toxicpanda.com>
        <20201130190805.48779810@natsu>
        <b92d0141-f68f-ce96-8099-e145ebc6f594@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 30 Nov 2020 09:50:13 -0500
Josef Bacik <josef@toxicpanda.com> wrote:

> The thing you're missing is that when we do chattr -c we're setting NOCOMPRESS 
> on the file.

Wow, and does this need a previously set +c to work? Or just -c on an already
-c file will change the Btrfs flag under the hood? Seems to be very weird in
any case, as from the user perspective there's no way to view the current
status of that flag, with the only way to change it being via a side-effect of
another operation.

>   If chattr -c is supposed to just be the removal of +c, then btrfs is doing the 
> wrong thing by setting NOCOMPRESS.

I would agree with that.

> I guess the question is what do we want?  Do we want to only allow the user to 
> indicate we want compression, or do we want to allow them to also indicate that 
> they don't want compression?  If we don't want to enable them to disable 
> compression for a file, then this patch needs to be thrown away, but then we 
> also need to fix up all the places we set NOCOMPRESS when we clear these flags. 

The patch also seems to prioritize "no compress if compression ratio is bad"
over compress-force, whereas the whole point of compress-force feels to be to
compress no matter what, especially no matter what are the possibly imperfect
compression ratio estimates.

-- 
With respect,
Roman
