Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342644058D6
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Sep 2021 16:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbhIIOUi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Sep 2021 10:20:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33264 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239747AbhIIOU0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Sep 2021 10:20:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4D2502235F;
        Thu,  9 Sep 2021 14:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631197156;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sriNlLmhAgsxTy8qI1CXCJu9duBXD/a0PiKU+exUf7Q=;
        b=ewmZRhOTNctD9GeYgzZ9HHupDBXYqrnONLsIPa5jPRIgFSpz1KHmPqkmEtU21L/LaUUlzx
        5amptrcp52ditTTuieeQYiNW+YfQYnpTwL74a08fap1O42a9/Ozcak6/LUFg7yPQ7WkZhd
        MfrC8/Ktc02XHcxuLPpv/hzbehqaE1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631197156;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sriNlLmhAgsxTy8qI1CXCJu9duBXD/a0PiKU+exUf7Q=;
        b=lAw1EF7cQzgkrtUAsYh3H8hHavExFkqdnBvXJvXiQehI3e6xr7VV0MOu36jJbMK1B+6lLz
        mnlXZuUj2p6fjAAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4523FA4484;
        Thu,  9 Sep 2021 14:19:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1ED50DA7A9; Thu,  9 Sep 2021 16:19:10 +0200 (CEST)
Date:   Thu, 9 Sep 2021 16:19:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: remove the failing device argument from
 btrfs_check_rw_degradable()
Message-ID: <20210909141910.GY15306@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1631026981.git.fdmanana@suse.com>
 <6979a21084ce679d34896cf8092349e845e1843e.1631026981.git.fdmanana@suse.com>
 <20210907160506.GQ3379@twin.jikos.cz>
 <b590dde5-05be-7957-636e-29c8253da147@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b590dde5-05be-7957-636e-29c8253da147@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 08, 2021 at 10:25:52PM +0800, Anand Jain wrote:
> On 08/09/2021 00:05, David Sterba wrote:
> > On Tue, Sep 07, 2021 at 04:15:50PM +0100, fdmanana@kernel.org wrote:
> >> From: Filipe Manana <fdmanana@suse.com>
> >>
> >> Currently all callers of btrfs_check_rw_degradable() pass a NULL value for
> >> its 'failing_dev' argument, therefore making it useless. So just remove
> >> that argument.
> > 
> > Anand, did you have plans with using the argument? It's been NULL since
> > the initial patch
> > 
> > https://lore.kernel.org/linux-btrfs/00433e34-a56e-3898-80b9-32a304fe32e2@gmx.com/t/#u
> > 
> > as commit 6528b99d3d20 ("btrfs: factor btrfs_check_rw_degradable() to
> > check given device") and it was not part of a series.
> 
> I have a local patch which is V9 of this [1] using the 2nd argument of 
> btrfs_check_rw_degradable(). Essentially to check if the mounted fs 
> should fail or can continue to write when a disk fails.
> 
> [1]
> btrfs: introduce device dynamic state transition to failed
> 
> https://patchwork.kernel.org/project/linux-btrfs/patch/20171003155920.24925-2-anand.jain@oracle.com/
> 
> We need further discussions on this design. I think.

Yeah this does not look like a simple feature. I think we can remove the
parameter for now and add back eventually.
