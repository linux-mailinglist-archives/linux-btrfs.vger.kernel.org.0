Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936993E8AE5
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 09:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbhHKHQ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 03:16:26 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43794 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbhHKHQZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 03:16:25 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F004E22152;
        Wed, 11 Aug 2021 07:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628666160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qyWkzhkMRSgA+eWCQNd7a3Ian7Q0bInWBZgjohbmGDI=;
        b=f68l+6NvcnzCWyCOYNN1wHRJDR+h9Le3mDGMvBUOKOlaJm6HYiyPuD/017gxeOtWwIkIAr
        j12IrJiYr1RPuze/kCungdZr0Q/VYbmA97Sn/W6Y4usqXad2dGVROqJOYTKwTt/oBI5kyJ
        X5jFNPN7HGTzKrUaW6+mo1yDgAlzNtw=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C5C33137FE;
        Wed, 11 Aug 2021 07:16:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 7B69JTB5E2GcXQAAGKfGzw
        (envelope-from <nborisov@suse.com>); Wed, 11 Aug 2021 07:16:00 +0000
Subject: Re: [PATCH] btrfs: reduce return argument of btrfs_chunk_readonly
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <32a8d585312548c69ca242c6fd671755f78ddace.1628609924.git.anand.jain@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <da5074a6-c0bb-a844-bbfe-c57f38bba876@suse.com>
Date:   Wed, 11 Aug 2021 10:15:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <32a8d585312548c69ca242c6fd671755f78ddace.1628609924.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.08.21 г. 18:48, Anand Jain wrote:
> btrfs_chunk_readonly() checks if the given chunk is writeable. It returns
> 1 for readonly, and 0 for writeable. So the return argument type bool
> shall suffice instead of the current type int.
> 
> Also, rename btrfs_chunk_readonly() to btrfs_chunk_writeable() as we check
> if the bg is writeable, and helps to keep the logic at the parent function
> simpler.

I don't see how the logic is kept simpler, given that you just invert
it. IMO changing the argument to bool without renaming the function is a
sufficient change and it will result in a lot smaller diff.

<snip>
