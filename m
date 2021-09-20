Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C85411391
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 13:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbhITLdj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 07:33:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53100 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhITLdi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 07:33:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 93D49200C3;
        Mon, 20 Sep 2021 11:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632137531;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GkbqucqVLLx4khgsbPCIixNK+KXrXJ1lr+azDZKofqY=;
        b=wrj7fpaZJMLLYjqvQcYxTXTA0z8hD+p8boIMGxsRrDqYU3fwvmvgT4ZI6ncjq7MvJhDx8P
        T4DdR/p1K05MRwK22Q6CuO3Dwgu/xCdxOKfuulAT3vOr5xZYEgHGqTohhBMB9F5lq4gU4T
        tai/lsWmAGrPWzcT7XYnDiRRo41av08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632137531;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GkbqucqVLLx4khgsbPCIixNK+KXrXJ1lr+azDZKofqY=;
        b=NYBaSyx3Ovow5boIpBAx6ib3nAvjc/XP1nsH176KS73Zphdvzi1Vm0ZxrNsmMJp0XflBcc
        sXrCtmTUPpglYoBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 8AFD5A3B96;
        Mon, 20 Sep 2021 11:32:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 57D83DA7FB; Mon, 20 Sep 2021 13:32:00 +0200 (CEST)
Date:   Mon, 20 Sep 2021 13:32:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Steven Davies <btrfs-list@steev.me.uk>
Cc:     dsterba@suse.cz, Forza <forza@tnonline.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Select DUP metadata by default on single devices.
Message-ID: <20210920113200.GG9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Steven Davies <btrfs-list@steev.me.uk>,
        Forza <forza@tnonline.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <9809e10.87861547.17bfad90f99@tnonline.net>
 <20210920090914.GB9286@twin.jikos.cz>
 <433faf921e92e94fa117a4e263dfddcd@steev.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433faf921e92e94fa117a4e263dfddcd@steev.me.uk>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 20, 2021 at 12:12:33PM +0100, Steven Davies wrote:
> On 2021-09-20 10:09, David Sterba wrote:
> 
> > So:
> > - DUP by default for metadata on single device
> > - single by default for data on multiple devices (now it's raid0)
> > - free-space-tree on
> 
> Is this synonymous with space_cache=v2?

Yes. To reduce the mount option number I wanted it to be called v2, the
free-space-tree is the implementation, we use that interchangably
though.
