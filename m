Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF3F3BEAB5
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jul 2021 17:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhGGPeR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jul 2021 11:34:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33822 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbhGGPeP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jul 2021 11:34:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A9B5620438;
        Wed,  7 Jul 2021 15:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625671894;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=prrkn9/oumQdG2wF+aXIKRKPk1/5fUl5blRknAlUlYE=;
        b=v/CjA4e34RnNUTiTbJ/1y471SMze0d8NKGfyTiftdeYrPdeFF3wq0g+ItMLl8bMhxbF9KF
        vUY78Njcg0ZEuEkPtey7s7Zds0MSZX3uIs8Q3pVqMfy9/Qg+rKznnB7atebwS5RGdkddK3
        3+BljT3aoKggaDcZ5NBeh8bXIImBmA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625671894;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=prrkn9/oumQdG2wF+aXIKRKPk1/5fUl5blRknAlUlYE=;
        b=XWHAT8ZfPF9Ej24qpZzkdGYKyrOgHNCTNzgQ7rhgQyjLrw/y5zlZfM83Ti4h2IiIA7Owoh
        p4xC117jlGAd9iCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 76201A3B98;
        Wed,  7 Jul 2021 15:31:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BC133DA6FD; Wed,  7 Jul 2021 17:29:00 +0200 (CEST)
Date:   Wed, 7 Jul 2021 17:29:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't block if we can't acquire the reclaim lock
Message-ID: <20210707152900.GP2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <8fc77aa7ffbc61e7e55d57e8cfc7423642558b17.1625500974.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fc77aa7ffbc61e7e55d57e8cfc7423642558b17.1625500974.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 06, 2021 at 01:32:38AM +0900, Johannes Thumshirn wrote:
> If we can acquire the reclaim_bgs_lock in on block group reclaim, we block
> until it is free. This can potentially stall for a long time.
> 
> While reclaim of block groups is necessary for a good user experience on a
> zoned file system, there still is no need to block as it is best effort
> only, just like when we're deleting unused block groups.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Added to misc-next with the fixup, thanks.
