Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1CA429DD7
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 08:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhJLGjg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 02:39:36 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:32768 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbhJLGje (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 02:39:34 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 67C061FF2A;
        Tue, 12 Oct 2021 06:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634020650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qsMh/u2zjNnEFD52oF9t3BVjGYiQzocu62+WJG7p1X0=;
        b=QomDbEMiKHfvuxZ3leW1qP1B3U8ge7Mc4QeK4FEE7lhoq87bu/Kh+vv9FPp4Pib/f57RHi
        aAGN/2Yh8awhNH58T1FqwVJUsNz3bfkeq3XDgrrDdZG10GWsZ5T4OYjvQ5Yr9uS5llssYQ
        moxoUNAYch6dUhJVXhhZzLnsoLQOrVE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 29F1313A6F;
        Tue, 12 Oct 2021 06:37:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JUSwByotZWEaGAAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 12 Oct 2021 06:37:30 +0000
Subject: Re: [PATCH] btrfs: use bvec_kmap_local in btrfs_csum_one_bio
To:     Christoph Hellwig <hch@lst.de>, josef@toxicpanda.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
References: <20211012063153.380185-1-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <95fffdaa-baa5-f543-1b65-7aa8144598c7@suse.com>
Date:   Tue, 12 Oct 2021 09:37:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211012063153.380185-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12.10.21 г. 9:31, Christoph Hellwig wrote:
> Using local kmaps slightly reduces the chances to stray writes, and
> the bvec interface cleans up the code a little bit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
