Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFB5A1764F5
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 21:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgCBUan (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 15:30:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:58200 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgCBUan (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Mar 2020 15:30:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F3A9DAE46;
        Mon,  2 Mar 2020 20:30:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 637FBDA7AA; Mon,  2 Mar 2020 21:30:20 +0100 (CET)
Date:   Mon, 2 Mar 2020 21:30:20 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use rounddown in decide_stripe_size
Message-ID: <20200302203020.GZ2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200302104651.1703-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302104651.1703-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 02, 2020 at 12:46:51PM +0200, Nikolay Borisov wrote:
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> 
> Dave, please fold this into c1ac11142016 ("btrfs: factor out decide_stripe_size()")

Will do, though I'll keep the comment given how confusing the rounddown
and round_down things are.
