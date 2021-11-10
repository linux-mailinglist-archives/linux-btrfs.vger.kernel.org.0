Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F60044BE45
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 11:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhKJKK1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 05:10:27 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60400 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhKJKK0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 05:10:26 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6A575212B7;
        Wed, 10 Nov 2021 10:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636538858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HyeNFvr8K3qaqgAEvup8CIkBYnJFdKpWX8Nlzezf7rU=;
        b=DE17gKuFHv4Scm5CM04Zr1uWb6GjiAaPBdE8v8wEAcfrhsgEsPQ+0xRybDQDyAvNzbAqt1
        v/4wG/8JreyyccNasqxvjK+DCIZucu5TFWt4rcRJkpZ5PBB492BojVqVfQmpdAQ/Vk9c+u
        rRHl2TA2NQZlee3FfjJYI6NKjoGqzbE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 39C1F13B7F;
        Wed, 10 Nov 2021 10:07:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MWp2C+qZi2FUKwAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 10 Nov 2021 10:07:38 +0000
Subject: Re: [PATCH v3] btrfs: Test proper interaction between skip_balance
 and paused balance
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20211108142901.1003352-1-nborisov@suse.com>
 <9a98623c-f34a-8a64-f211-18e3e3439078@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <2e4207b5-0266-392e-39fd-1848632c93f8@suse.com>
Date:   Wed, 10 Nov 2021 12:07:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <9a98623c-f34a-8a64-f211-18e3e3439078@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

<snip>


>> +# titled "btrfs: allow device add if balance is paused"
> 
> It is a new feature, not a bug fix? The kernel patch won't backport to
> the stable kernels. Then on older kernels, this test has to exit with
> _notrun().
> Is there any way to achieve this? There isn't any sysfs interface that
> will help and, so far we haven't used the kernel version to achieve
> something like this.
> 

No, and this is outside the remit of xfstest. Anyone who is running
xfstest should ensure incompatible tests are excluded.

<snip>
