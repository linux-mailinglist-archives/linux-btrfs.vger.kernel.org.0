Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0398A3D586A
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 13:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhGZKkj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 06:40:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48194 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbhGZKki (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 06:40:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F231F21CBA;
        Mon, 26 Jul 2021 11:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627298466;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QGVjpS7LYdJN3maugMA0rmF+5qQFoYyr4ug1pVSqoE0=;
        b=vUaHiu/Gm90IRMofIgw+hgDF4gnCzfkKdJCmJkSN/bRluemHt/kpWMEIUl7Slyz+Jixawr
        KUbfbCnTtb/wabee9zX85JoHB43l390rr0wfh3W8sboVWUvRlKagoz+BVAFAHYSJ1RnHtx
        qfoAa0onpRj95BpEobGb1EUkD9IIDzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627298466;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QGVjpS7LYdJN3maugMA0rmF+5qQFoYyr4ug1pVSqoE0=;
        b=qz7sUB8x/dr1A7F8amL3Zl7BRWd9TucgdTfb5mqsBRPQpKnEAHGgh/bR+ejcUVQisJ4cNi
        dB61RYsTqvvK31Cg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E9FB7A4E3F;
        Mon, 26 Jul 2021 11:21:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 31A21DA8CA; Mon, 26 Jul 2021 13:18:23 +0200 (CEST)
Date:   Mon, 26 Jul 2021 13:18:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Su Yue <l@damenly.su>
Subject: Re: [PATCH v2] btrfs-progs: cmds: Fix build for using NAME_MAX
Message-ID: <20210726111822.GB5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Su Yue <l@damenly.su>
References: <20210725152438.70213-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210725152438.70213-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 25, 2021 at 03:24:38PM +0000, Sidong Yang wrote:
> There is some code that using NAME_MAX but it doesn't include header
> that is defined. This patch adds a line that includes linux/limits.h
> which defines NAME_MAX.
> 
> Issue: #386
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

That was an easier than I thought, thanks. Verified by musl container
build.
