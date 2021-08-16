Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A7B3ED1E4
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 12:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbhHPKYK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 06:24:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52578 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbhHPKXv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 06:23:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 37A7421E66;
        Mon, 16 Aug 2021 10:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629109398;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l7Y9OJT185f9lrvdNLlTDEti/sJoJ3cODm8Y4IIvGV0=;
        b=AvX+Z4rtRRSnrMicn6MVnPC1S7GcTpJs7phrctEDNZf28u9/E7N7fyKPAeZIbRd2Nd7me/
        VHAjfEz7uNg3/Xw4lLutZPLtf33+zUbrOPuZBr3sxTLwjcEfqFcK8jLAiWqAfdOPJqze74
        w+u2R9HT4U7FmJZ3Xv0FdDMmYvqu1yM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629109398;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l7Y9OJT185f9lrvdNLlTDEti/sJoJ3cODm8Y4IIvGV0=;
        b=2w3Ff2U2eX2scAvXiPuCffUujw/UeW9wIjccQS7OQb5J7Ynneqkfpw2eW8XrUDR4aSBK5x
        G2Tj37ZSQgIwL1Dg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2EF89A3B89;
        Mon, 16 Aug 2021 10:23:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8C339DA72C; Mon, 16 Aug 2021 12:20:22 +0200 (CEST)
Date:   Mon, 16 Aug 2021 12:20:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: 5.14-0-rc5, splat in block_group_cache_tree_search while
 __btrfs_unlink_inode
Message-ID: <20210816102022.GU5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtQEp1a=sf8hO7zL5PHz-7NLjMv-A2nXGCEkNCos+nVA6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtQEp1a=sf8hO7zL5PHz-7NLjMv-A2nXGCEkNCos+nVA6Q@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 13, 2021 at 10:33:05PM -0600, Chris Murphy wrote:
> I get the following call trace about 0.6s after dnf completes an
> update which I imagine deletes many files. I'll try to reproduce and
> get /proc/lock_stat
> 
> [   95.674507] kernel: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!

The message "BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low" is related to
lockdep and not a btrfs problem, but it appears from time to time and as
Johannes said either increase the config variable, or ignore it.
