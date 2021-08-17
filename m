Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544123EED83
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Aug 2021 15:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237515AbhHQNdw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Aug 2021 09:33:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41606 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbhHQNdw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Aug 2021 09:33:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5B0C221F42;
        Tue, 17 Aug 2021 13:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629207198;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f0L6roeTpkE/ATNDZrqYTIzCPaXznbAby49gFKx0pS8=;
        b=fXOz+3uphCjjEzvaRQFW1nHxWM3pOt2XuOzc3A7GLYuNQ77LZFncKN0RSo0cLeqyLaZ5Rd
        Qp9dxrJsr2hLGDMNBOk++dgsIEch6AJ7n8e2wgAEXJbToiSSBOXyQ7QAnOZN6Zvmkt4ob1
        /Upk3/EMJ00zbongRJYqmdhRNkOq9I0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629207198;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f0L6roeTpkE/ATNDZrqYTIzCPaXznbAby49gFKx0pS8=;
        b=BXTHKPnMQYbS1M1gdDwKQ4wjV/gPnLhdl2nXcF/BOh1oZPxngo/uj8Az6SCTJjQz2uq4tf
        v6q4ipQPePHRMfDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 51C44A3B81;
        Tue, 17 Aug 2021 13:33:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2B166DA72C; Tue, 17 Aug 2021 15:30:22 +0200 (CEST)
Date:   Tue, 17 Aug 2021 15:30:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v4 2/2] btrfs-progs: cmds: Add subcommand that dumps file
 extents
Message-ID: <20210817133022.GM5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <20210718064601.3435-1-realwakka@gmail.com>
 <20210718064601.3435-3-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210718064601.3435-3-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 18, 2021 at 06:46:01AM +0000, Sidong Yang wrote:
> This patch adds an subcommand in inspect-internal. It dumps file extents of
> the file that user provided. It helps to show the internal information
> about file extents comprise the file.

Do you have an example of the output? That's the most interesting part.
Thanks.
