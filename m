Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C8644D703
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 14:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhKKNNo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 08:13:44 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43004 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231380AbhKKNNn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 08:13:43 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ABC4F1FD4A;
        Thu, 11 Nov 2021 13:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636636253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fmgmLbU4hGWAavNgexqbYf1+Y5CAdISJbLbWIbTeV7I=;
        b=X9a2rjzTZSgpNcBpba2gTGZE/ls1zpR1acKJQBBHVWvmD92JSq27+IGS4tsLtwOLkzKGbA
        1VFqNx0fq/GrW6qLqncefvMXakf6JeMCB2837xZPFLi9aBhocFNKUpnXOTkHDb7H3lSTtz
        e/FxoghABVy1yZBXk6a4EAKmh1cDNBw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 739F913DB4;
        Thu, 11 Nov 2021 13:10:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id djEdGV0WjWEKGQAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 11 Nov 2021 13:10:53 +0000
Subject: Re: [PATCH v3 1/7] btrfs: handle priority ticket failures in their
 respective helpers
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1636470628.git.josef@toxicpanda.com>
 <78469f9381de3b91f689d419cb0d632346d294b8.1636470628.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <21489ebb-d529-eaf2-5913-cba64a6326e8@suse.com>
Date:   Thu, 11 Nov 2021 15:10:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <78469f9381de3b91f689d419cb0d632346d294b8.1636470628.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9.11.21 г. 17:12, Josef Bacik wrote:
> Currently the error case for the priority tickets is handled where we
> deal with all of the tickets, priority and non-priority.  This is ok in
> general, but it makes for some awkward locking.  We take and drop the
> space_info->lock back to back because of these different types of
> tickets.
> 
> Rework the code to handle priority ticket failures in their respective
> helpers.  This allows us to be less wonky with our space_info->lock
> usage, and means that the main handler simply has to check
> ticket->error, as the ticket is guaranteed to be off any list and
> completely handled by the time it exits one of the handlers.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
