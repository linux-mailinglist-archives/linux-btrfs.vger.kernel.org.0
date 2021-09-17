Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4236240F84B
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Sep 2021 14:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbhIQMut (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Sep 2021 08:50:49 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45356 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbhIQMup (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Sep 2021 08:50:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E675B1FE90;
        Fri, 17 Sep 2021 12:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631882962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d9DZ7nIVhUpYuSj+OfQyBz+CcPPTeZhPgryU42wBAKw=;
        b=a9IFILkABLUOjxu0QuuJB85FWpyz2pquUII7x7IuzyegY9g9sF5p8dgD596AyvPJLS9Qq+
        aG48+7RLfDBzwqFlXt8DiAv0XH8WU8VhQaMnAxOaBfwTomz2rniDi0XfM9vKmhs0Xrnd93
        SzI0ejOuiVc7T3sDG/U4fzDhACZzfjg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9998F13ABA;
        Fri, 17 Sep 2021 12:49:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YbUGI9KORGHmVgAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 17 Sep 2021 12:49:22 +0000
Subject: Re: [PATCH v3 2/3] btrfs: remove btrfs_bio_alloc() helper
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20210915071718.59418-1-wqu@suse.com>
 <20210915071718.59418-3-wqu@suse.com>
 <a4380e7b-b728-fd85-b6c1-175a53f6a1ce@suse.com>
 <20210917124341.GS9286@twin.jikos.cz>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <6d4ee72e-1f3c-0d06-7ce4-6e17d296c390@suse.com>
Date:   Fri, 17 Sep 2021 15:49:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210917124341.GS9286@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 17.09.21 г. 15:43, David Sterba wrote:
> So should we add another helper that takes the exact number and drop the
> parameter everwhere is 0 so it's just btrfs_io_bio_alloc() with the
> fallback?

But by adding another helper we just introduce more indirection.

Actually I'd argue that if 0 is a sane default then BIO_MAX_VECS cannot
be any worse because:

a) It's a number which is as good as 0
b) It's even named. So this is technically better than a plain 0
