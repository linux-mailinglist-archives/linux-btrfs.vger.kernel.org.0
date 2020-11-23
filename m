Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF20F2C1464
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Nov 2020 20:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbgKWTTP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Nov 2020 14:19:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:56256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729374AbgKWTTO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Nov 2020 14:19:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0D255AC91;
        Mon, 23 Nov 2020 19:19:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C1C8FDA818; Mon, 23 Nov 2020 20:17:23 +0100 (CET)
Date:   Mon, 23 Nov 2020 20:17:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     xiakaixu1987@gmail.com
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH v2] btrfs: return EAGAIN when receiving a pending signal
 in the defrag loops
Message-ID: <20201123191723.GM8669@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, xiakaixu1987@gmail.com, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
References: <1605672156-29051-1-git-send-email-kaixuxia@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605672156-29051-1-git-send-email-kaixuxia@tencent.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 18, 2020 at 12:02:36PM +0800, xiakaixu1987@gmail.com wrote:
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> The variable ret is overwritten by the following variable defrag_count.
> Actually the code should return EAGAIN when receiving a pending signal
> in the defrag loops.

This lacks explanation why is EAGAIN supposed to be the right return
value. This is about semantics of the FITRIM ioctl, changing that would
affect userspace applications.
