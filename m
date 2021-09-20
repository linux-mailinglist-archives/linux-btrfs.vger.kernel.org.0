Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907D6410FCC
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 09:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbhITHFj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 03:05:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38714 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbhITHFi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 03:05:38 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 551B21FE45;
        Mon, 20 Sep 2021 07:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632121451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q6Us9H8XaDvtrqQ3M4LyTyI/JB8uimOo5eIeQEpFmwg=;
        b=XbHlkIYLAcuyl8VnQIFA2WvEWMY2Uw3l8cbe+KoG5raohG4xC78Kwtbq39eVKj0hu8Cje+
        1+6NV5BOFxn+prtUViUTfIxFgbOUDcTqbv01tAGjOSwiFbFJaXr9gVhwIm/fZaYMGCwuOK
        VcJJZW/qnxzZAh8ytF6YPPYMOsM/oDM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F83A13ACA;
        Mon, 20 Sep 2021 07:04:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XDdUA2sySGEucAAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 20 Sep 2021 07:04:11 +0000
Subject: Re: [PATCH v3 3/3] btrfs: rename struct btrfs_io_bio to
 btrfs_logical_bio
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210915071718.59418-1-wqu@suse.com>
 <20210915071718.59418-4-wqu@suse.com>
Cc:     David Sterba <dsterba@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <b49cb262-0239-78eb-8144-523caed28bef@suse.com>
Date:   Mon, 20 Sep 2021 10:04:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210915071718.59418-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 15.09.21 г. 10:17, Qu Wenruo wrote:
> Previously we have "struct btrfs_bio", which records IO context for
> mirrored IO and RAID56, and "strcut btrfs_io_bio", which records extra
> btrfs specific info for logical bytenr bio.
> 
> With "strcut btrfs_bio" renamed to "struct btrfs_io_context", we are
> safe to rename "strcut btrfs_io_bio" to "strcut btrfs_logical_bio" which
> is a more suitable name now.
> 
> Although the name, "btrfs_logical_bio", is a little long and name
> "btrfs_bio" can be much shorter, "btrfs_bio" conflicts with previous
> "btrfs_bio" structure and can cause a lot of problems for backports.
> 
> Thus here we choose the name "btrfs_logical_bio", which also emphasis
> those bios all work at logical bytenr.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>


So thinking a bit more about the renaming we are trading "awkwardness"
for future generations so that we make backporting easier or rather more
fool proof.

What if we backport a patch that does BUILD_BUG_ON predicated on the
size of the btrfs_io_bio. That way if a patch backports cleanly and
automatically but in fact git got confused by btrfs_bio vs btrfs_io_bio
then a build failure would ensue due to mismatched sizes and that would
be a clear indication something has gone wrong so whoever is doing the
backport can go and correct the backport? David what do you think about
this?
