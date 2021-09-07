Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAABF40291C
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 14:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344244AbhIGMoq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 08:44:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36092 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344267AbhIGMop (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Sep 2021 08:44:45 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5C1921FF87;
        Tue,  7 Sep 2021 12:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631018618;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tp1uiLc3LOQUh92sd215CmgfCzU4wzKNlOpHzCvjQZE=;
        b=woohVmeUxKv4PSTQbCe3Uo8EVjriLwKSUqOI25q3Qjp+Kv7XY+Ns+e6TmD9JX3Mm9qv48X
        DHwCLJqt7MYSvN/5JOH3PG3yS1KVRSoCDdX7N2SVl6+kCabFmbxrvmp+HXXr9ZF04G7a9B
        XoGhw3ucC8OpDY0hgmPdbwB76OCHgV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631018618;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tp1uiLc3LOQUh92sd215CmgfCzU4wzKNlOpHzCvjQZE=;
        b=NfGaPDtBiJK4uy2W+iHLLsXR7gLDU+itTZ/S5HYLjfOnT0gd4199AwbWRPyKwQ+xEL3+rW
        8yTrQ7Rx4en1tYAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2B618A3B89;
        Tue,  7 Sep 2021 12:43:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 39054DA7E1; Tue,  7 Sep 2021 14:43:34 +0200 (CEST)
Date:   Tue, 7 Sep 2021 14:43:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH 2/6] btrfs: zoned: add a dedicated data relocation block
 group
Message-ID: <20210907124333.GN3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
References: <cover.1630679569.git.johannes.thumshirn@wdc.com>
 <ac2e5fc11c47dfc3626999460f606b980b0f5523.1630679569.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac2e5fc11c47dfc3626999460f606b980b0f5523.1630679569.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 03, 2021 at 11:44:43PM +0900, Johannes Thumshirn wrote:
> +	/*
> +	 * Do not allow non-relocation blocks in the dedicated relocation block
> +	 * group, and vice versa.
> +	 */
> +	spin_lock(&fs_info->relocation_bg_lock);
> +	data_reloc_bytenr = fs_info->data_reloc_bg;
> +	skip = data_reloc_bytenr &&
> +		((ffe_ctl->for_data_reloc && bytenr != data_reloc_bytenr) ||
> +		 (!ffe_ctl->for_data_reloc && bytenr == data_reloc_bytenr));
> +	spin_unlock(&fs_info->relocation_bg_lock);

Please rewrite the expression into an if (...), the condition is not
trivial like in other cases, so it would be better to make it stand out
a bit.
