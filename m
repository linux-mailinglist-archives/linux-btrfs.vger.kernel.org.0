Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C8043FD4B
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Oct 2021 15:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhJ2NZf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Oct 2021 09:25:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60454 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhJ2NZe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Oct 2021 09:25:34 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B5BD0218F7;
        Fri, 29 Oct 2021 13:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635513785;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CrNFe0CGFV/bJzu/OdIfgizBVCWZerJJ8eyQ/UfYcRo=;
        b=a1cQOOofBwTUfqgRMY1JvxjX3kqautbSQ8AXmEPJ/DdNW7GfonHJWEAmRLsS94+r0BcoM3
        jX54QvIxbA9boqLiIMLFdqSzL8Ak4/Im2xdS3XA4Gwnf5XOWKSqJqMCcNwE8Wii1otmS7H
        32iaA9Fb4X4htxYSbih6HSNKUZ9TEN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635513785;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CrNFe0CGFV/bJzu/OdIfgizBVCWZerJJ8eyQ/UfYcRo=;
        b=VKdhVxM84rJNNeXWns9GLYeREYKUK9h8sdTicgs4I++m9zsxHJ0XrOIN8xvF4hRI00K2zW
        SjbizE+ppnYwM+AA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AE1FBA3B81;
        Fri, 29 Oct 2021 13:23:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A412CDA7A9; Fri, 29 Oct 2021 15:22:32 +0200 (CEST)
Date:   Fri, 29 Oct 2021 15:22:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Jingyun He <jingyun.ho@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: unable to run mkfs.btrfs for host managed sata hdd
Message-ID: <20211029132232.GA20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jingyun He <jingyun.ho@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAHQ7scWxVCuQkbtY_dTo3rPoW+J0ofADW4GYGDMb_bfcha81CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQ7scWxVCuQkbtY_dTo3rPoW+J0ofADW4GYGDMb_bfcha81CA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 29, 2021 at 08:48:45PM +0800, Jingyun He wrote:
> Hello, all
> I have a LSI 2308 HBA in IT mode, and attached a sata host managed disk.
> And run mkfs.btrfs /dev/sdb -O zoned -d single -m single -f
> get following errors:
> btrfs-progs v5.13.1
> ERROR: superblock magic doesn't match
> Resetting device zones /dev/sdb (67056 zones) ...
> ERROR: error during mkfs: Operation not permitted

Can you also reset the zones by 'blkzone reset' under the same user
account that also runs the 'mkfs.btrfs' command?
