Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F583D8F33
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 15:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbhG1NdL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 09:33:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49574 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236659AbhG1NdI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 09:33:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 319311FFAC;
        Wed, 28 Jul 2021 13:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627479186;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eHT3Ty+Q4sXPcuW6N5VxvNqUWkPpWoSAvj5Z3cfUkOQ=;
        b=2kUKlY/t36CK60RmRUpjEk6mZIgwxwJbkVhpGfN6AgYYDMmKzbWIPM20THgWqvgaYDEAU1
        loN59XohYeIZlbNLbwP0Vx1myDMD2SRDOxd+WsmvZFfOj4PZWamBKZAsJxP9dIJWPROLZB
        cpkN2nHbwBKKiz6Ge8LYtEnIckUmsxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627479186;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eHT3Ty+Q4sXPcuW6N5VxvNqUWkPpWoSAvj5Z3cfUkOQ=;
        b=WYWEpzwZiKpMw8yEdzPfXcMOuW4pFe/5QSvxZc11kG1UcwatvmJ6LZ0FLXGlBs03Cvqs/w
        KI2mwKTobICZ1uAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2A313A3BA1;
        Wed, 28 Jul 2021 13:33:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 51CB2DA8A7; Wed, 28 Jul 2021 15:30:21 +0200 (CEST)
Date:   Wed, 28 Jul 2021 15:30:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v8 12/18] btrfs: reject raid5/6 fs for subpage
Message-ID: <20210728133021.GJ5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>
References: <20210726063507.160396-1-wqu@suse.com>
 <20210726063507.160396-13-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726063507.160396-13-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 26, 2021 at 02:35:01PM +0800, Qu Wenruo wrote:
> +			btrfs_err(fs_info,
> +	"raid5/6 is not yet supported for sector size %u with page size %lu",
> +				sectorsize, PAGE_SIZE);

> +		btrfs_err(fs_info,
> +	"RAID5/6 is not supported yet for sectorsize %u with page size %lu",
> +			  fs_info->sectorsize, PAGE_SIZE);

The error messages should use same spelling so I've changed both to say
"RAID56".
