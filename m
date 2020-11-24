Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390092C2C84
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Nov 2020 17:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389841AbgKXQOR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Nov 2020 11:14:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:33140 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389424AbgKXQOR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Nov 2020 11:14:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9408BACA8;
        Tue, 24 Nov 2020 16:14:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 08D3FDA818; Tue, 24 Nov 2020 17:12:47 +0100 (CET)
Date:   Tue, 24 Nov 2020 17:12:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH 0/3] Simplify error handling in 3 functions
Message-ID: <20201124161247.GB6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com
References: <20201124154932.3180539-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124154932.3180539-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 24, 2020 at 05:49:29PM +0200, Nikolay Borisov wrote:
> Here are 3 very similar patches which switch some functions from using 2
> variables to implement their error handling to using simply 1 as the standard in
> the codebase dictates.

Nice, added to misc-next, thanks.
