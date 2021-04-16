Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1114536279A
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 20:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244668AbhDPSVC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 14:21:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:58320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236112AbhDPSU7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 14:20:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D9476B061;
        Fri, 16 Apr 2021 18:20:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 14CC5DA790; Fri, 16 Apr 2021 20:18:17 +0200 (CEST)
Date:   Fri, 16 Apr 2021 20:18:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: Fix null pointer deref in balance_level
Message-ID: <20210416181816.GJ7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210406135503.164590-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406135503.164590-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 06, 2021 at 04:55:03PM +0300, Nikolay Borisov wrote:
> In case the right buffer is emptied it's first set to null and
> subsequently it's dereferenced to get its size to pass to root_sub_used.
> This naturally leads to a null pointer dereference. The correct thing
> to do is to pass the stashed right->len in "blocksize".
> 
> Fixes #296

I'm using the "Issue: #123" format for that.

> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to devel, thanks.
