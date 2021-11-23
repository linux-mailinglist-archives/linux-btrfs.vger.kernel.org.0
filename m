Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A742459C6B
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Nov 2021 07:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhKWGx0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Nov 2021 01:53:26 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37634 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbhKWGxZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Nov 2021 01:53:25 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3D7B4212C6;
        Tue, 23 Nov 2021 06:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637650217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wfl3ybnINwFlPM/9PIHcl4bwE/0EBFg/kRyWNyiTUPU=;
        b=QgBFTj6SDdxy80T9OWk/SgaLYFBsVOwqi8qmNH4qnWaE/r5G8M1xkYByk4UIiNIIpfilW2
        tV4v5oIfkMUCzr+b5FZ8l1LunVw6hBQ9zks9HvC43VKPPYGd+u9Xe3QZP0bLQEWrNXXBzD
        Vh8Omno5lyXNEdlyiw1BFZOVdAatDSE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 11D5F13CEF;
        Tue, 23 Nov 2021 06:50:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JxGgASmPnGErUwAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 23 Nov 2021 06:50:17 +0000
Subject: Re: [PATCH] btrfs: eliminate if in main loop in tree_search_offset
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20211122151713.14316-1-nborisov@suse.com>
 <YZvKVVVvkfGRD+PI@localhost.localdomain>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <3905db45-157c-264f-b030-4f7f964ca2a1@suse.com>
Date:   Tue, 23 Nov 2021 08:50:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YZvKVVVvkfGRD+PI@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22.11.21 г. 18:50, Josef Bacik wrote:
> On Mon, Nov 22, 2021 at 05:17:13PM +0200, Nikolay Borisov wrote:
>> Reshuffle the code inside the first loop of tree_search_offset so that
>> one if() is eliminated and the becomes more linear.
> 
> Need a SOB and you need to set entry = NULL initially if you're going to make
> this change.  Thanks,
Doh, I had it set before nuking the work via git checkout and on the 2nd
try I forgot....

> 
> Josef
> 
