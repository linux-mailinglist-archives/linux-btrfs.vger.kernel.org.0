Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1CC463470
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Nov 2021 13:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241638AbhK3Mj7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Nov 2021 07:39:59 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:34150 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbhK3Mj7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Nov 2021 07:39:59 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 785601FD5B;
        Tue, 30 Nov 2021 12:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638275799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GLtG8lkJw4t3dFQTHX9/x7zTH5CqRD5gC8CXsUW+E8k=;
        b=cK3MAdkZSlERjr2+LWtkHvOHDJ/wFiIpTlu9erEKGftHo8zx1DI7eyy/Cv7E4ORkABGkbb
        eH+UeovSR3JtMak8w4L+neX3cDKfylrDFVZZFZ8/ItoLaZZ+0a/K0RqXUri6A4W9DEWE1/
        xVJPcOKOH1cdjZybutWL0xcLUVXQiqc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D67313D3E;
        Tue, 30 Nov 2021 12:36:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KTTgD9capmGmegAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 30 Nov 2021 12:36:39 +0000
Subject: Re: 'btrfs replace' hangs at end of replacing a device (v5.10.82)
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
References: <20211129214647.GH17148@hungrycats.org>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <2b99db41-11ef-db6f-99f3-2a1aa950292d@suse.com>
Date:   Tue, 30 Nov 2021 14:36:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211129214647.GH17148@hungrycats.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29.11.21 г. 23:46, Zygo Blaxell wrote:
> Not a new bug, but it's still there.  btrfs replace ends in a transaction
> deadlock.
> 


Please provide the output of

grep PREEMPT /path/to/running/kernel/kconfig
