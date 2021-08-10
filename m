Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CED93E548C
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 09:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbhHJHrF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 03:47:05 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58040 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbhHJHrF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 03:47:05 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 875DD21F41;
        Tue, 10 Aug 2021 07:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628581602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QSiuboMRK+fFED4rxMuhIyY0tK4NbPDC4iHqdzTj3eg=;
        b=IgScJrCwspt63Oii4JF/i4HI3kRpICmeO1HTlRrZgleA38QYeVkTsSHmHEm0CwZqz3M91q
        Ma/gFqTXMsRciH79JC4l0YwOO5HckzDNn/+VubZIcC/361laINDOg7fZVx1NXsVxLbSG+f
        omv6iqIg2iQjzIVWpThcorwL8zGVuyY=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6231C133D0;
        Tue, 10 Aug 2021 07:46:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 4oNUFeIuEmFgTQAAGKfGzw
        (envelope-from <nborisov@suse.com>); Tue, 10 Aug 2021 07:46:42 +0000
Subject: Re: Mixed inline and regular extents caused by btrfs/062
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <db939df7-412d-aaef-c044-62fd2d8b2e7b@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <2da42f71-b95d-4fb1-be93-be9e58eb1200@suse.com>
Date:   Tue, 10 Aug 2021 10:46:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <db939df7-412d-aaef-c044-62fd2d8b2e7b@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.08.21 г. 8:49, Qu Wenruo wrote:
> Hi,
> 
> Although I understand current kernel can handle mixed inline extent with
> regular extent without problem, but the idea of mixing them is still
> making me quite unease.
> 
> Thus I still go testing with modify btrfs-progs to detect such problem,
> and find out btrfs/062 can cause such mixed extents.
> 
> Since it's not really causing any on-disk data corruption, but just an
> inconsistent behavior, I'm wondering do we really need to fix it.
> (This is also the only reason why subpage has disabled inline extent
> creation completely, just to prevent such problem).
> 
> Any idea on whether we should "fix" the behavior?

What do you mean by mixed inline and regular extents? AFAICS inline
extents are created when you write at the beginning of the file and the
size of the write is less than the inline extent threshold? All
subsequent writes are going to be regular extents.

> 
> Thanks,
> Qu
> 
