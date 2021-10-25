Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE46438FC1
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 08:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhJYGw4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 02:52:56 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41404 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhJYGwz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 02:52:55 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ED38C1FCA3;
        Mon, 25 Oct 2021 06:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635144632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/MmfYdmV9GcwAfqb5LGAoNXLcONhHN7BwylFOAuAX4c=;
        b=owDfE/Xl7HkqXY+SUMZfWRYZ6N1sce3sjdMQZATJAN2MA7g47rO1omY+RgUEDVq7x8t+N/
        qU+WKCCs7lHFHXcKSMdbnVtVYkp8AjSVN5IUu1P3BSs1cSZ7XCZCexJwSVtaYwkk0IUGCi
        7eRckt0GahFaWKcpPbiiYx1RUXh/n4c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCBFC13216;
        Mon, 25 Oct 2021 06:50:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RamaK7hTdmHheAAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 25 Oct 2021 06:50:32 +0000
Subject: Re: [PATCH v2] btrfs: send: prepare for v2 protocol
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     osandov@osandov.com
References: <20211022145336.29711-1-dsterba@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <4f3f2444-66fd-5fa3-e078-b223a9bab5e3@suse.com>
Date:   Mon, 25 Oct 2021 09:48:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211022145336.29711-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22.10.21 г. 17:53, David Sterba wrote:
> This is the infrastructure part only, without any new updates, thus safe
> to be applied now and all other changes built on top of it, unless there
> are further comments.
> 
> ---
> 
> This is preparatory work for send protocol update to version 2 and
> higher.
> 
> We have many pending protocol update requests but still don't have the
> basic protocol rev in place, the first thing that must happen is to do
> the actual versioning support.
> 
> The protocol version is u32 and is a new member in the send ioctl
> struct. Validity of the version field is backed by a new flag bit. Old
> kernels would fail when a higher version is requested. Version protocol
> 0 will pick the highest supported version, BTRFS_SEND_STREAM_VERSION,
> that's also exported in sysfs.
> 
> The version is still unchanged and will be increased once we have new
> incompatible commands or stream updates.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>


Reviewed-by: Nikolay Borisov <nborisov@suse.com>
