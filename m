Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6308F39E76F
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jun 2021 21:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhFGTZ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Jun 2021 15:25:26 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50696 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbhFGTZZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Jun 2021 15:25:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5B3F8219AC;
        Mon,  7 Jun 2021 19:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623093812;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5JIdenLbAgDkCcjMmnwwHVfJ9xKA9WpPm8DYECXClos=;
        b=ESp3+fUVU5UN4XwANLkW9q+GVtnbZqq6xyACrrEPa+frUwnf19ZkxhZaxUmru7CXaK6zMh
        Al0anlnBz5V/dRYvuR6/SAIO8SPxYYrimsU0BWVHFq6LFjUlRB7qy9VSvklUmOnDJJArXW
        8HsSkIAcNsZ63QhQWkn4rrRIX/Cp8go=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623093812;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5JIdenLbAgDkCcjMmnwwHVfJ9xKA9WpPm8DYECXClos=;
        b=Z72YwoZuuWS9isARD4zvqhvUaq98Q79GjMXZERjw16+Cp3tfQGIUvaSkIboBv7dF6ruYmA
        gS+JOH+6hV1n1uDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4F4F5A3BC9;
        Mon,  7 Jun 2021 19:23:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 21927DA8CA; Mon,  7 Jun 2021 21:20:49 +0200 (CEST)
Date:   Mon, 7 Jun 2021 21:20:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: device: print num_stripes in usage command
Message-ID: <20210607192048.GM31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20210530125636.791651-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210530125636.791651-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, May 30, 2021 at 12:56:36PM +0000, Sidong Yang wrote:
> This patch appends num_stripes for each chunks in device usage commands.
> It helps to see profiles easily. The output is like below.
> 
> /dev/vdb, ID: 1
>    Device size:             1.00GiB
>    Device slack:              0.00B
>    Data,single[1]:        120.00MiB
>    Metadata,DUP[2]:       102.38MiB
>    System,DUP[2]:          16.00MiB
>    Unallocated:           785.62MiB

This is example of single and dup, but the whole point was to print that
for the striped profiles, like is shown in the issue
https://github.com/kdave/btrfs-progs/issues/372 , so it needs to be
conditional.

As the mirrored profiles have a fixed number of copies, there's no doubt
on how many devices are printed, same for single and dup.

I'm more inclined to use the "/" as separator: 'RAID6/3' it's more like
"raid6 on three devices", the "[]" looks like indexing. "," is used as
separator of the type so it won't be as simple to parse that.
