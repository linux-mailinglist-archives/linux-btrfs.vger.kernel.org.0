Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC14C43C313
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 08:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbhJ0Gjf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Oct 2021 02:39:35 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53238 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhJ0Gje (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Oct 2021 02:39:34 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 27F821FD40;
        Wed, 27 Oct 2021 06:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635316629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LblacaNKda3IskaI8lee2SCTPOm7vuc1AovazJNPywI=;
        b=hCZsaEJpIALEw6VbdM/aajk9OrgwprYilfHisPKh15qaRfXasrBkvnS6L++E5zI7z55Eey
        h6Mwk9Iv41C0KJpdZYsu3dxHJmpxzFuh8S3JdIyJdfr+85Mzno6gocA8BzN1j8hSous54n
        faB7QSNI8ApQdtKiiwIADwyICBVLHNs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F230F13FDC;
        Wed, 27 Oct 2021 06:37:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NbFnOJTzeGHZXAAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 27 Oct 2021 06:37:08 +0000
Subject: Re: [PATCH v2 2/2] btrfs: use ilog2() to replace if () branches for
 btrfs_bg_flags_to_raid_index()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20211027052859.44507-1-wqu@suse.com>
 <20211027052859.44507-3-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <62d6f59e-b4f0-fb47-54b2-bb6e5c5b744b@suse.com>
Date:   Wed, 27 Oct 2021 09:37:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211027052859.44507-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 27.10.21 г. 8:28, Qu Wenruo wrote:
> In function btrfs_bg_flags_to_raid_index(), we use quite some if () to
> convert the BTRFS_BLOCK_GROUP_* bits to a index number.
> 
> But the truth is, there is really no such need for so many branches at
> all.
> Since all BTRFS_BLOCK_GROUP_* flags are just one single bit set inside
> BTRFS_BLOCK_GROUP_PROFILES_MASK, we can easily use ilog2() to calculate
> their values.
> 
> Only one fixed offset is needed to make the index sequential (the
> lowest profile bit starts at ilog2(1 << 3) while we have 0 reserved for
> SINGLE).
> 
> Even with that calculation involved (one if(), one ilog2(), one minus),
> it should still be way faster than the if () branches, and now it is
> definitely small enough to be inlined.
> 

Is this used in a performance critical path, are there any numbers which
prove that it's indeed faster?
