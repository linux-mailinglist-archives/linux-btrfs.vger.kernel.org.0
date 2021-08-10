Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E613E5C64
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 15:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241288AbhHJN56 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 09:57:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58536 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240350AbhHJN5t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 09:57:49 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 207D722073;
        Tue, 10 Aug 2021 13:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628603847;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ie7mA0Me1kv4uWKA3LMC0JwDjJsGQFAKtoj6vlLZkyk=;
        b=GU0Cn6dHJsmmsIt2GkshUmgIc+E387o2SxiTnEMWAl8sPCupPWZKfNcOVCrFq2x68sHxHe
        Zf4uAOWss9laTdC0a59+qIqXqbIS7Qx+J710rIVYMBYRn3YE4zPRK2aj5bheosJwycquZb
        Ez62PDdCu0vDDSn6kXp/fXKi+ZlV3UU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628603847;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ie7mA0Me1kv4uWKA3LMC0JwDjJsGQFAKtoj6vlLZkyk=;
        b=wXyc2+mW4TLehc9/WN84NWipyoAcxY3rRNvx8TDmlohEUGQ1muDqFC3pUGwHLEBikf5tMJ
        jkaRcuyUvgHgPIBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1888FA3B93;
        Tue, 10 Aug 2021 13:57:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D0CD0DA880; Tue, 10 Aug 2021 15:54:34 +0200 (CEST)
Date:   Tue, 10 Aug 2021 15:54:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: zoned: fix alloc offset calculation
Message-ID: <20210810135434.GU5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20210809041344.3002897-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809041344.3002897-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 09, 2021 at 01:13:44PM +0900, Naohiro Aota wrote:
> alloc_offset is offset from the start of a block group and @offset is
> actually an address in logical space. Thus, we need to consider
> block_group->start when calculating them.
> 
> Fixes: 011b41bffa3d ("btrfs: zoned: advance allocation pointer after tree log node")
> Cc: stable@vger.kernel.org # 5.12+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Added to misc-next, thanks.
