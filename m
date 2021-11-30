Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016914636CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Nov 2021 15:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242238AbhK3OiM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Nov 2021 09:38:12 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35070 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbhK3OiL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Nov 2021 09:38:11 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BE348212B9;
        Tue, 30 Nov 2021 14:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638282891;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ymYlkEdRzRThXsgytUcx26oQejHHqu8lMp4Vpricss=;
        b=rpjgtKDprWUYFEH6QxuZiJPo3tGyYRZBR5e3IC1LXhBp+MhgVqHESFbj95O58qzWSNIMrR
        bJyzhXkphGR3B2uVgVE2c6M4Tx9xngnJRUcnPa0pomf0fnfhxbPs5gd+JK4YR/xw801tpn
        ay8BESGodrAR4h/mTy3bW0PLmNDftA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638282891;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ymYlkEdRzRThXsgytUcx26oQejHHqu8lMp4Vpricss=;
        b=cv07tFte49l+LaGSc2uw8A1nLMoMLLRaSv7hWRtLHzuPhN8hn1EkVzpDs8TMKXR9+wUVIN
        d/nFzTmkpnvpQ9CQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 8A2D4A3B83;
        Tue, 30 Nov 2021 14:34:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8ADB0DA7A3; Tue, 30 Nov 2021 15:34:40 +0100 (CET)
Date:   Tue, 30 Nov 2021 15:34:40 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: Use generic Kconfig option for 256kB page
 size limit
Message-ID: <20211130143440.GI28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211129230141.228085-1-nathan@kernel.org>
 <20211129230141.228085-3-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129230141.228085-3-nathan@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 29, 2021 at 04:01:40PM -0700, Nathan Chancellor wrote:
> Use the newly introduced CONFIG_PAGE_SIZE_LESS_THAN_256KB to describe
> the dependency introduced by commit b05fbcc36be1 ("btrfs: disable build
> on platforms having page size 256K").
> 
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: David Sterba <dsterba@suse.com>
