Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9AE42C336
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 16:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbhJMOcl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 10:32:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42836 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbhJMOcj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 10:32:39 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AEBD32021C;
        Wed, 13 Oct 2021 14:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634135435;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DDG0URjCV+Z5Xh37DVs5lrRzAarxNGNuA5mThU+1vao=;
        b=t2ZER7TAiQ5kKOHL/TupeXMamGa76QcX7i8H6E2YC6YHKZDP1IuSGe37WkLiWiLFYWx4qx
        sB3nlbQh1n/c9cHds9kbzI+mlzzd+Ho/c8u1agCHqYPwYC8vRBN9wfVig56ton2S+kVFSA
        Ha0zZ+mAOc26u5f6XryRdQ48nGjp56U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634135435;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DDG0URjCV+Z5Xh37DVs5lrRzAarxNGNuA5mThU+1vao=;
        b=cynX90HXPF3jtXXAiv8Rr3nB4OiX6kHA9cCvycnYcVuNxKi1X/pfu6JRaiDPTxeBcvYLQj
        nOx5SSw2QkuRWGBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 28757A3B88;
        Wed, 13 Oct 2021 14:30:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9583FDA7A3; Wed, 13 Oct 2021 16:30:11 +0200 (CEST)
Date:   Wed, 13 Oct 2021 16:30:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: remove btrfs_bio::logical member
Message-ID: <20211013143011.GH9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211008073000.62391-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008073000.62391-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 08, 2021 at 03:29:58PM +0800, Qu Wenruo wrote:
> Although we have two call sites setting btrfs_bio::logical, but only one
> call site it really reading btrfs_bio::logical.
> 
> Furthermore, that only reader can grab the same info from
> btrfs_dio_private without any hassle.
> 
> Thus it means btrfs_bio::logical duplicated and can be removed.
> 
> This in fact proves my initial suspicion, that btrfs_bio::logical is
> duplicated, and the logical bytenr can be fetched using
> bio->bi_iter.bi_sector.
> 
> This saves 8 bytes from btrfs_bio, without any complicated refactor.

Great, thanks. Added to misc-next.
