Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D815F371646
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 May 2021 15:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbhECNyj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 May 2021 09:54:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:49876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233299AbhECNyj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 May 2021 09:54:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4E6FDB062;
        Mon,  3 May 2021 13:53:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 74C49DA7A5; Mon,  3 May 2021 15:51:19 +0200 (CEST)
Date:   Mon, 3 May 2021 15:51:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     trix@redhat.com
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: initialize return variable
Message-ID: <20210503135118.GK7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, trix@redhat.com, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210430180655.3328899-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430180655.3328899-1-trix@redhat.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 30, 2021 at 11:06:55AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Static analysis reports this problem
> free-space-cache.c:3965:2: warning: Undefined or garbage value returned
>   return ret;
>   ^~~~~~~~~~
> 
> ret is set in the node handling loop.
> Treat doing nothing as a success and initialize ret to 0.

Right, though it's unlikely the loop won't run at least once, having the
ret initialized is safe. Patch added to misc-next, thanks.
