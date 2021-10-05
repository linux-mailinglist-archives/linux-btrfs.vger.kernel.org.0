Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B92F422F13
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 19:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236834AbhJERXW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 13:23:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33920 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236618AbhJERXT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 13:23:19 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CA543202D3;
        Tue,  5 Oct 2021 17:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633454487;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6sHhNRKQmpc5CBPF22SG9FIvvZhFZkovLOUgGLUHL1k=;
        b=xZLfv9pDhTm0Mlam5WcjZnSUsAIW5QRAe3goeL/NQI8tfMDmxq4sXTbj+Ysc6lrThijDNm
        lcFlXQcD6K7JzI5ZLM7AQDJpCiYSx5Lr9bMJen/j1lvnjggh0/Koz1bIg7ABuqOKeH78Co
        gcFwyyX+0wosWzBkiIygdcP/6gkchYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633454487;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6sHhNRKQmpc5CBPF22SG9FIvvZhFZkovLOUgGLUHL1k=;
        b=+Lq7/lEJ8PCA+xD+kB05IYIMhAduGBEilJ3eSzqsWrotdN2rOyM2cgvV0M+gHLpu+IK/ho
        yMkVD45PKgBrHVBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C43B9A3B88;
        Tue,  5 Oct 2021 17:21:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D7F8CDA7F3; Tue,  5 Oct 2021 19:21:07 +0200 (CEST)
Date:   Tue, 5 Oct 2021 19:21:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 00/26]
Message-ID: <20211005172107.GJ9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210927072208.21634-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927072208.21634-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 27, 2021 at 03:21:42PM +0800, Qu Wenruo wrote:
> The patchset can be fetched from github:
> https://github.com/adam900710/linux/tree/compression

Moved to misc-next. I did some minor changes in coding style or
changelogs, some of the subject lines were overly long, but otherwise
nothing significant. Most of the changes are pretty heavy and I did not
thoroughly review each expression switching from page to sector, the
additional assertions are great and tests don't complain anymore.
Thanks.
