Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803853D2743
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 18:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhGVP0h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 11:26:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43572 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhGVP0g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 11:26:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E90C91FF1F;
        Thu, 22 Jul 2021 16:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626970030;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JNr9U7r5wx8necUlOzFmsWQcBwWHomXHS3JOFH/1J3c=;
        b=xTGSwHzd1QeGdup8dlDibhJpMAhT/He39vBZONOVnhAOLna87hQnIbqRTXZTrEdcWbPHGr
        bTMSbzbf0FToi+t5PDFwEERpziaxW15HJLIFbah1+salbFPb0CkHV1Lm36Q773bUJ3Db1n
        peELK2GzK2gj05U3vwV5hPJig7yTTuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626970030;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JNr9U7r5wx8necUlOzFmsWQcBwWHomXHS3JOFH/1J3c=;
        b=h6dfEeyXF22pKFI0UQelZrwausZEB6AVxS0/lPcuwPt013Gc0NT3rsy0u11he4titRapmS
        3RY1X399Y7XEELBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E233BA7D64;
        Thu, 22 Jul 2021 16:07:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 34EAFDAF95; Thu, 22 Jul 2021 18:04:29 +0200 (CEST)
Date:   Thu, 22 Jul 2021 18:04:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove ignore_offset argument from
 btrfs_find_all_roots()
Message-ID: <20210722160428.GA19710@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <c36aede8c9c171c1153e3a153c4112222919985a.1626965759.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c36aede8c9c171c1153e3a153c4112222919985a.1626965759.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 22, 2021 at 03:58:10PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently all the callers of btrfs_find_all_roots() pass a value of false
> for its ignore_offset argument. This makes the argument pointless and we
> can remove it and make btrfs_find_all_roots() always pass false as the
> ignore_offset argument for btrfs_find_all_roots_safe(). So just do that.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
