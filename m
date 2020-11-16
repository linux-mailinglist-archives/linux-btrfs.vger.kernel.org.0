Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982E32B48F4
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Nov 2020 16:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbgKPPPZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Nov 2020 10:15:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:46604 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730791AbgKPPPY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Nov 2020 10:15:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 520C1ABF4;
        Mon, 16 Nov 2020 15:15:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7B2C4DA6E3; Mon, 16 Nov 2020 16:13:38 +0100 (CET)
Date:   Mon, 16 Nov 2020 16:13:38 +0100
From:   David Sterba <dsterba@suse.cz>
To:     xiakaixu1987@gmail.com
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] btrfs: remove the useless value assignment in
 btrfs_defrag_file
Message-ID: <20201116151338.GI6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, xiakaixu1987@gmail.com, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
References: <1605344781-10362-1-git-send-email-kaixuxia@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605344781-10362-1-git-send-email-kaixuxia@tencent.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Nov 14, 2020 at 05:06:21PM +0800, xiakaixu1987@gmail.com wrote:
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> The variable ret is overwritten by the following variable defrag_count
> and this assignment is useless, so remove it.

This could be actually pointing to a bug, please explain why you think
it's correct to remove it and not to return EAGAIN.
