Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BC93BD7F8
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jul 2021 15:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbhGFNo2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jul 2021 09:44:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57228 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbhGFNo1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jul 2021 09:44:27 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 299F622709;
        Tue,  6 Jul 2021 13:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625578908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yxbf1hVaYC7vdG6vdR/VLmLw0N1cXJSne/7f2G9x42k=;
        b=hJfygZeVqdQ40PQ2JofmzJ09jkr2PEH2XllbheHIrAlebQKWiYLiRtjQtOpCeJBHt4aoLi
        nd0Wdu2hvEYAdGTX8YZmSUXwqkUOigTlsxit1qpJvpS8nWOt1y4u8+ECCKvUKqD6SQofZk
        A1bR5KzQXvQ7Pes6yT5kinsGqgXpTY4=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D4D3E133D0;
        Tue,  6 Jul 2021 13:41:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id mQYdMJtd5GCUJAAAGKfGzw
        (envelope-from <nborisov@suse.com>); Tue, 06 Jul 2021 13:41:47 +0000
Subject: Re: [PATCH] btrfs-progs: default to SINGLE profile on zoned devices
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>
References: <20210706091922.38650-1-johannes.thumshirn@wdc.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <e2168115-5025-5281-94d5-3a962d0e92af@suse.com>
Date:   Tue, 6 Jul 2021 16:41:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210706091922.38650-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 6.07.21 г. 12:19, Johannes Thumshirn wrote:
> On zoned devices we're currently not supporting any other block group
> profile than the SINGLE profile, so pick it as default value otherwise a
> user would have to specify it manually at mkfs time for rotational zoned
> devices.
> 
> Reported-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
