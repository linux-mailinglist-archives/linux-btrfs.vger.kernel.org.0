Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C08C3F1481
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 09:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbhHSHrB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 03:47:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52134 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhHSHrA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 03:47:00 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 40BBE220AA;
        Thu, 19 Aug 2021 07:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629359184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xn/71hRWwMUH2nqOhHvW74pI4u6sFNGT4UHze81fr1I=;
        b=jXQ8eza1egMapIuy2Tsvb4A52zdFS+QOVDtQ55C9L2ESmgLmLEJoruMm94JafHmxvFPrsJ
        e+kKL0MgMTn7tJtMx6f/FqmYioH1zBmLW9R4fJ9UUAi9d03qN2JGDU0Rq1nHhEKOpxD0Vo
        M6vJJI8fktgObQO202Of7YZgxGaKQaw=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1C45313756;
        Thu, 19 Aug 2021 07:46:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id S/p2BFAMHmFODAAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 19 Aug 2021 07:46:24 +0000
Subject: Re: failed to read the system array: -2 / open_ctree failed
To:     Christoph Anton Mitterer <calestyo@scientia.net>,
        linux-btrfs@vger.kernel.org
References: <2d56668e7c0f83531c6e46b9582bc4a0704e690a.camel@scientia.net>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <9775aead-8884-dfb6-d877-a38c093e696d@suse.com>
Date:   Thu, 19 Aug 2021 10:46:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2d56668e7c0f83531c6e46b9582bc4a0704e690a.camel@scientia.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 19.08.21 г. 2:36, Christoph Anton Mitterer wrote:
> Hey.
> 


The system array is the array which holds the chunk maps i.e it's the
first thing which needs to be read from the super block (housed at
offset 64k in the device). So the error basically tells you that this
cannot be read and return -ENOENT. If the system chunk array is broken
then you can't really do anything with the filesystem. But given your
other explanation - that the system doesn't really have corrupted trees
(as visible from btrfs check output) then this is indeed caused by some
timing issues with the hard drives not being able to be brought up.
