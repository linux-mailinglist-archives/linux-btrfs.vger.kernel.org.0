Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1B54322EC
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Oct 2021 17:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhJRPeo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 11:34:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34598 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhJRPen (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 11:34:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 46FBA21965;
        Mon, 18 Oct 2021 15:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634571151;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q8hQ6CPL8pXgC9tXRMUu23q7XMdXHi6WK1gJr48lq2U=;
        b=yrmeo1kMI9Ja4yN3BeJPw92aTCwOcTmIyPKRwuxYlS7WeIqw+Qdr211Yxs/En4ZBiQTiwh
        zjNHw2FsBsb8AMeHCFwEbAlrg9zLVFUYU9m/a8jSg28yoH9b8y12kxl1TplyLxozDUAZqv
        959ppq1BFGFJP+qmXzWuX+BlDmvKYds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634571151;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q8hQ6CPL8pXgC9tXRMUu23q7XMdXHi6WK1gJr48lq2U=;
        b=JH+tstGXvDwuqi/WJYcOQpbsYAErtIRMb5XbnimYQYbsymNPYSjJW0QADoOTWKkRxW0Oku
        XDo3gMoKW6CvXlCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3FD67A3B85;
        Mon, 18 Oct 2021 15:32:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3F76DDA7A3; Mon, 18 Oct 2021 17:32:04 +0200 (CEST)
Date:   Mon, 18 Oct 2021 17:32:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: stop storing the block device name in
 btrfsic_dev_state
Message-ID: <20211018153204.GK30611@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <20211014090550.1231755-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014090550.1231755-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 14, 2021 at 11:05:50AM +0200, Christoph Hellwig wrote:
> Just use the %pg format specifier in all the debug printks previously
> using it.  Note that both bdevname and the %pg specifier never print
> a pathname, so the kbasename call wasn't needed to start with.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Added to misc-next, thanks. I've adjusted the message strings that got
updated, namely indentation.
