Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B80405A31
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Sep 2021 17:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbhIIP36 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Sep 2021 11:29:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44790 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbhIIP35 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Sep 2021 11:29:57 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6BD622234A;
        Thu,  9 Sep 2021 15:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631201327;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=irzPsgvHbS6vKMMh9rCBN1HIb1GsKrTPKZbTgW9ZD88=;
        b=HFb4zvBmzne4onWfQV6QamP5YcmvqwTNI3A9C9MkztPDc5Ykrkff2S7f382cnEA9ybl8MA
        Hk8KMzJaB6cztO2eO4FuHvYAugElzT3B9ZF58u2l6h7qORyrhBP9JPAOVdFA32LCHXEs7S
        pMGVZXtoN2p+lovueT+BLwXCz0WbLCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631201327;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=irzPsgvHbS6vKMMh9rCBN1HIb1GsKrTPKZbTgW9ZD88=;
        b=q8O63g5znf8bMjtCeM0h4+jd58tMs7d9rNFrExgMdOppe0QsZ/R/38VYPqk4pT2kInwhFp
        lP7/6SfFP+oWFsBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6602AA3B99;
        Thu,  9 Sep 2021 15:28:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8B4CFDA7A9; Thu,  9 Sep 2021 17:28:41 +0200 (CEST)
Date:   Thu, 9 Sep 2021 17:28:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix transaction handle leak after verity rollback
 failure
Message-ID: <20210909152840.GZ15306@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <b390e518f2091df52fd314806cce52fd00a19a00.1631114872.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b390e518f2091df52fd314806cce52fd00a19a00.1631114872.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 08, 2021 at 04:29:26PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During a verity rollback, if we fail to update the inode or delete the
> orphan, we abort the transaction and return without releasing our
> transaction handle. Fix that by releasing the handle.
> 
> Fixes: 146054090b0859 ("btrfs: initial fsverity support")
> Fixes: 705242538ff348 ("btrfs: verity metadata orphan items")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
