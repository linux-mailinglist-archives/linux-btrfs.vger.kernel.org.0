Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22B541BF46
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 08:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244444AbhI2GrT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 02:47:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56936 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244342AbhI2GrT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 02:47:19 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 741AF202EC;
        Wed, 29 Sep 2021 06:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632897937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/o6T2F2n3cwgLmeFH+mFdyCslz2UyQpNmFOT0F3Cnms=;
        b=e/7bcGezVObPFsNMyro+UBqqhod32+YqcR+ah0RyikG9wViDVNk5HdOH7u4hqpRizh/rbR
        Fz2NOSFpra3i7HzOCG65vKfofGdlDq6aGXne8iKqmtVW8fg9aePMi8ocI2BTzSZkU/kl/N
        PVh/SsG0aqkdIBvjLlAhndnY7ZaFlZU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 442EA13638;
        Wed, 29 Sep 2021 06:45:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JWYoDpELVGHdVwAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 29 Sep 2021 06:45:37 +0000
Subject: Re: [PATCH] fstests: btrfs/248: test if btrfs receive can handle
 clone command on inodes with different NODATASUM flags
To:     Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20210929004446.12654-1-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <7ee471f1-d262-dcc5-8e21-82b3cf2cffd5@suse.com>
Date:   Wed, 29 Sep 2021 09:45:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210929004446.12654-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29.09.21 г. 3:44, Qu Wenruo wrote:
> The planned fix is titled "btrfs-progs: receive: fallback to buffered
> copy if clone failed".
> 
> The test case itself will create two send streams, and the 2nd stream is
> an incremental stream with a clone command in it.
> 
> Using different mount options we are able to create a situation where
> clone source and destination have different NODATASUM flags, which is
> prohibited inside btrfs.
> 
> The planned fix will make btrfs receive to fall back to buffered write
> to copy the data from the source file.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

If this is fixed by btrfs-progs fix shouldn't the test be part of
btrfs-progs and not the kernel test suite?
