Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C83C3FC65F
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 13:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241360AbhHaLHU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 07:07:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36870 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241296AbhHaLHU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 07:07:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B08A422205;
        Tue, 31 Aug 2021 11:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630407984;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9BnqTL3P1nDL5SGEcIk88nCK+Vd80GPqdQK5wnKArpY=;
        b=He74lyX0WMSdCnMt533y58CcpX50n/OF6r9qaWFR4lFSEtHi271I5IGfyilOPFTSzGjxT2
        HPdzBAl8zr4p2xS4KLFReX9noSWCCXppnK1/YjgHByusfc7XXIqHA8gtdZkojFhfDzyMo5
        QIfRP5PVCKgXnR8tjy+PphTIv5rDflQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630407984;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9BnqTL3P1nDL5SGEcIk88nCK+Vd80GPqdQK5wnKArpY=;
        b=t6KaV+Ho0x5jJQG1Ut166WNwHmWkSHtVpT5uHL3AyadGCy3kV1TQCQURtWPKrvlulNGCws
        f0+4erjkV75a4PCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A97A1A3B95;
        Tue, 31 Aug 2021 11:06:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F33ACDA733; Tue, 31 Aug 2021 13:03:33 +0200 (CEST)
Date:   Tue, 31 Aug 2021 13:03:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH 1/8] fs: btrfs: Introduce btrfs_for_each_slot
Message-ID: <20210831110333.GF3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20210826164054.14993-1-mpdesouza@suse.com>
 <20210826164054.14993-2-mpdesouza@suse.com>
 <99e18442-6ed7-f968-46e2-3491dee7ec12@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99e18442-6ed7-f968-46e2-3491dee7ec12@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 30, 2021 at 03:37:03PM +0300, Nikolay Borisov wrote:
> On 26.08.21 г. 19:40, Marcos Paulo de Souza wrote:
> > +/* Search for a valid slot for the given path.
> > + * @root: The root node of the tree.
> > + * @key: Will contain a valid item if found.
> > + * @path: The start point to validate the slot.
> > + *
> > + * Return 0 if the item is valid, 1 if not found and < 0 if error.
> > + */
> > +int btrfs_valid_slot(struct btrfs_root *root, struct btrfs_key *key,
> 
> nit: The name of this function is a bit misleading since it's not really
> a predicate, more like a function that returns the value and if it can't
> return the current value pointed to by path it gets the next leaf. I
> guess a more apt name would be "btrfs_get_next_valid_item" or some such.

Yeah the function name is confusing, like a predicate. The suggested
name sounds good to me.
