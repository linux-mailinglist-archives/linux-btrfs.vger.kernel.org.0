Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7829E4292B4
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 17:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237808AbhJKPDB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 11:03:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58482 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbhJKPDB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 11:03:01 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8927E220C9;
        Mon, 11 Oct 2021 15:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633964460;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RNVt9wle9x8yJUlZkfTShkFC+6ggTIZDghsbulC7MpI=;
        b=qbay5zRoR7ysaYvB/RuAIl6ST8wvkiXqSiD6Z/ER3LFQEoRVY8vV5RNK8JA/2M4NYyf3sY
        z5sYNBrKzWdNZiNSE6emd1pGtellQyGoJVPlHdyzKVx3HFLeR8XWPCQC0TZw+hp7dX5KyA
        lNkiuMsl1PaMApWfJQrhQYpdTawWKCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633964460;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RNVt9wle9x8yJUlZkfTShkFC+6ggTIZDghsbulC7MpI=;
        b=sBwUZ0pF4c+hvkmdbeJZxwDuwvx/e9foDD8tv07QVF6/RqJCZTEYaRGfsHJmPhTfP6sDd6
        gpojx/XzI9Sti+Bw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 80028A3B90;
        Mon, 11 Oct 2021 15:01:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 59477DA781; Mon, 11 Oct 2021 17:00:37 +0200 (CEST)
Date:   Mon, 11 Oct 2021 17:00:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/5] btrfs: Rename root fields in delayed refs structs
Message-ID: <20211011150037.GO9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211011101019.1409855-1-nborisov@suse.com>
 <20211011101019.1409855-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011101019.1409855-2-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 11, 2021 at 01:10:15PM +0300, Nikolay Borisov wrote:
> Both data and metadata delayed ref structures have fields named
> root/ref_root respectively. Those are somewhat cryptic and don't really
> convey the real meaning. In fact those roots are really the original
> owners of the respective block (i.e in case of a snapshot a data delref
> will contain the original root that owns the given block). Rename those
> fields accordingly and adjust comments.

Subject: Re: [PATCH 1/5] btrfs: Rename root fields in delayed refs structs
                                ^

Please use lower case first letter after the "btrfs:" prefix, thanks.
