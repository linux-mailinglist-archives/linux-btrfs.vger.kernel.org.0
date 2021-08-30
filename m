Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774BB3FB1C9
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 09:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbhH3HTh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 03:19:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55696 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbhH3HTg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 03:19:36 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4717F2203F;
        Mon, 30 Aug 2021 07:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630307921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k+1+88D7JPYfouQ+2DYHBEp302s0CeAhHlZ2Ein8pJ4=;
        b=uOCQow1uXk4tKDXvvb5JbAfqkrqEX89pEHwz0w3gPFwsFO3JUSOKPPJK+pLMiezAq+qDo+
        J+RvaJ/KE+oLjwnSJxRX98ufscr5DcJFJzFW9OeRukAEuBwrMg5hQlEF4VjmIMlxl4MbQ7
        5VRpC5nSXRddCxvxq+1tAxTr10mKw7M=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 0CD461365E;
        Mon, 30 Aug 2021 07:18:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id yTh0O1CGLGHwFAAAGKfGzw
        (envelope-from <nborisov@suse.com>); Mon, 30 Aug 2021 07:18:40 +0000
Subject: Re: [PATCH] btrfs: Add test for rename exchange behavior between
 subvolumes
To:     fdmanana@gmail.com
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210819131456.304721-1-nborisov@suse.com>
 <CAL3q7H57NsQ2WhdsC3=gYftFp_JUKHVxNgCAQuXPwvFzux9CaA@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <b49f409f-e5cc-6d13-ef6a-2ab25f95d19e@suse.com>
Date:   Mon, 30 Aug 2021 10:18:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H57NsQ2WhdsC3=gYftFp_JUKHVxNgCAQuXPwvFzux9CaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



<snip>
> Finally, this would also be a good opportunity to test regular renames
> with subvolumes too, as we had bugs and regressions in the past like
> in commit 4871c1588f92c6c13f4713a7009f25f217055807 ("Btrfs: use right
> root when checking for hash collision
> "), and never got any test cases for them.

What specific tests do you have in mind? Ordinary renames of files
within a subvolume are already tested by merit of generic geneirc/02[345].

The test in the patch you cited is basically renaming a subvolume within
the same subvolume, that's easy enough.

<snip>
