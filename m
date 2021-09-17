Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE60D40F6A3
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Sep 2021 13:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbhIQLVB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Sep 2021 07:21:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60238 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbhIQLUz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Sep 2021 07:20:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DE43D1FE19;
        Fri, 17 Sep 2021 11:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631877572;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/zt51UR6VT+qdVlyH0TXv0llRFeoN+2sZFDDuho/kw8=;
        b=GB/XhSpEfEle/0Guh2zUfxYFtZRWGbksUaqkHpdf74rR9J5/E6mP9QSk6WHPhofWVDiAas
        SiuxmBT+lMOB3ejP+Xz3l8WYx+0rZqJEy7j/sm8qL6Hu5LL3rnAD0acg9F9CogDXBQzGgY
        fEcSHoqyQkwEry7Ao3LXa2GidKysVJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631877572;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/zt51UR6VT+qdVlyH0TXv0llRFeoN+2sZFDDuho/kw8=;
        b=yKMmN4EoaZwb7jDgDGHgw3fuoMwJpZxLJBIj0QaTUSMJy/BEfw7VRO4AacQG3BKNWjWdGL
        yI5VcBU/tYhtoVDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D33D0A3BB9;
        Fri, 17 Sep 2021 11:19:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4A382DA781; Fri, 17 Sep 2021 13:19:23 +0200 (CEST)
Date:   Fri, 17 Sep 2021 13:19:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 1/3] btrfs: rename btrfs_bio to btrfs_io_context
Message-ID: <20210917111923.GN9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210915071718.59418-1-wqu@suse.com>
 <20210915071718.59418-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915071718.59418-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 15, 2021 at 03:17:16PM +0800, Qu Wenruo wrote:
> The structure btrfs_bio is used by two different sites:
> 
> - bio->bi_private for mirror based profiles
>   For those profiles (SINGLE/DUP/RAID1*/RAID10), this structures records

Why is SINGLE here?
