Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58DCC9D5D5
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 20:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfHZSaF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 14:30:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:34838 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728559AbfHZSaE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 14:30:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C0421AF39;
        Mon, 26 Aug 2019 18:30:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 23EB2DA98E; Mon, 26 Aug 2019 20:30:27 +0200 (CEST)
Date:   Mon, 26 Aug 2019 20:30:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Vladimir Panteleev <git@panteleev.md>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/1] btrfs-progs: docs: document btrfs-balance exit
 status in detail
Message-ID: <20190826183026.GB2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Vladimir Panteleev <git@panteleev.md>,
        linux-btrfs@vger.kernel.org
References: <20190825060256.20529-1-git@vladimir.panteleev.md>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825060256.20529-1-git@vladimir.panteleev.md>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 25, 2019 at 06:02:55AM +0000, Vladimir Panteleev wrote:
> The `balance status` exit code is a bit of a mess, and the opposite of
> pause/cancel/resume. I assume it's too late to fix it, so documenting
> it is the best we can do.

Unfortunatelly, it is. Applied, thanks.
