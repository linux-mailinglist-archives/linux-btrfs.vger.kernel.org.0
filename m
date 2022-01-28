Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006C14A033D
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 22:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351676AbiA1V57 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 16:57:59 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54124 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbiA1V55 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 16:57:57 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7EC4821101;
        Fri, 28 Jan 2022 21:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643407076;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hAs2quB9TNzxdOba3OifnzVDAeI0fPW8+hORpZrAp4o=;
        b=XjVosPQtwIsBIZYcWYKsUPIlO0xBBLJfknKPFqMO/LkZXAIvmAE/LHI5qQpCheOMC0rKAA
        yKwmte5eiHVYTHA98BdvZ54AbX+6ptOYSyqwEcMcxsI3NlVkacchFAeaYs4jH/b2rdXNYJ
        ZPeVw9rBFh/8r8yrnN7bC24qjGjQj1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643407076;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hAs2quB9TNzxdOba3OifnzVDAeI0fPW8+hORpZrAp4o=;
        b=aNinIlZOELKcGXFk017WlMRvd3A2EGydW8pJqG9eXVKDTFuk2vjaYSewsDu1G4wusl8ogs
        PWhCqA2pUGM6NACg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4FA8DA3B81;
        Fri, 28 Jan 2022 21:57:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 57002DA7A9; Fri, 28 Jan 2022 22:57:14 +0100 (CET)
Date:   Fri, 28 Jan 2022 22:57:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/4] btrfs: implement metadata DUP for zoned mode
Message-ID: <20220128215714.GK14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1643204608.git.johannes.thumshirn@wdc.com>
 <20220126160540.GB14046@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126160540.GB14046@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 26, 2022 at 05:05:40PM +0100, David Sterba wrote:
> On Wed, Jan 26, 2022 at 05:46:19AM -0800, Johannes Thumshirn wrote:
> > Btrfs' default block-group profile for metadata on rotating devices has been
> > DUP for a long time. Recently the default also changed for non-rotating
> > devices.
> > 
> > Technically, there is no reason why btrfs on zoned devices can't use DUP for
> > metadata as well. All I/O to metadata block-groups is serialized via the
> > zoned_meta_io_lock and written with regular REQ_OP_WRITE operations. Therefore
> > reordering due to REQ_OP_ZONE_APPEND cannot happen on metadata (as opposed to
> > data).
> > 
> > The first three patches lay the groundwork by making sure zoned btrfs can work
> > with more than one stripe and the last patch then implements DUP on metadata
> > block groups in zoned btrfs.
> > 
> > Changes to v1:
> > * if only one zone is active, activate the other one as well
> > 
> > Johannes Thumshirn (4):
> >   btrfs: zoned: make zone activation multi stripe capable
> >   btrfs: zoned: make zone finishing multi stripe capable
> >   btrfs: zoned: prepare for allowing DUP on zoned
> >   btrfs: zoned: allow DUP on meta-data block groups
> 
> I'll add the patchset to a topic for-next branch, as it's in zoned code
> and should not break anything else. Thanks.

Moved to misc-next.
