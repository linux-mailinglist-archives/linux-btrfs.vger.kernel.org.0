Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CC3489728
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jan 2022 12:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244536AbiAJLQg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 06:16:36 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:48290 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244502AbiAJLQc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 06:16:32 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0C675210F8;
        Mon, 10 Jan 2022 11:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641813391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ag3l5IlLRwCVYREJse4mbHHNvUoZjDqGks4x8p28N6A=;
        b=j376aL2UkiEWEIM6oU039YghOzIJnUTtP2B1vHTfdpARj30dUeoP9afBnBzjGjYk7fgZIx
        HxXpSS4Y55eWpvQjubtw4D44LDlLjSXyfnNmprgcmPaoeWjj63TfIOBPjAsZMdieO7zaXs
        AmETAmJetVMjiffYpuVJhcNnEKwFjB8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D688C13D2A;
        Mon, 10 Jan 2022 11:16:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2jVdMY4V3GFMawAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 10 Jan 2022 11:16:30 +0000
Subject: Re: btrfs send/receive segfault
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtT-k3WbCSTvrvWLZQ7gLOUtTbXfOiKsGZxkPVb1g2srWg@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <cce9a86c-f7d7-b9a0-3563-5fd150bf4838@suse.com>
Date:   Mon, 10 Jan 2022 13:16:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtT-k3WbCSTvrvWLZQ7gLOUtTbXfOiKsGZxkPVb1g2srWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.01.22 г. 4:45, Chris Murphy wrote:
> kernel-5.16.0-0.rc8.20220106git75acfdb6fd92.56.fc36.x86_64
> btrfs-progs-5.15.1-1.fc35.x86_64
> 
> I'm seeing a crash during send/receive. The destination does have the
> source subvol, but it lacks received UUID for some reason, so this
> might be the instigating cause of the segmentation fault.
> 

So this is already fixed by the following commit:
https://github.com/kdave/btrfs-progs/commit/07320bd20fd1d4b9b0f51aa0f9413c8824063bad

