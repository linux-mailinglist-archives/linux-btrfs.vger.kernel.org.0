Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3ED415C52
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 12:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240429AbhIWKyy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 06:54:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52292 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236762AbhIWKyx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 06:54:53 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CBF681FFA5;
        Thu, 23 Sep 2021 10:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632394401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n6n5yaPw5XDg1AsGl8GTlpO1rgvzlhLe38aP3VwPPW0=;
        b=nZfzPr/KVHKhxQL78sBxV4hc9/knKq/9WX8gcSoEKaEgaQ4o9Yu3mzhxjyDnafQkm6GphK
        7WeBjMugQO7n1HNzh7mFzNVgUa0g1c4siwZnF5Ljxi1zfq2IMAysFcsFiHOa9NaAbqDKNS
        8PGTXVxg7C/WSgBd65l/wlkZ1K0PJ5Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A3CB513DCD;
        Thu, 23 Sep 2021 10:53:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bgIzJaFcTGELbwAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 23 Sep 2021 10:53:21 +0000
Subject: Re: [PATCH] clear_bit BTRFS_DEV_STATE_MISSING if the device->bdev is
 not NULL During mount.
To:     li zhang <zhanglikernel@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <1632330390-29793-1-git-send-email-zhanglikernel@gmail.com>
 <5679da1e-2422-69c5-b4f8-326802363f7c@suse.com>
 <CAAa-AGmnKSDm=9my5+qi3OqOaB7BZqmGrGjoctm60Cfs6-9agg@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <d05d52fe-db30-5eb2-f42d-33d7852ba3bb@suse.com>
Date:   Thu, 23 Sep 2021 13:53:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAAa-AGmnKSDm=9my5+qi3OqOaB7BZqmGrGjoctm60Cfs6-9agg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 23.09.21 г. 13:10, li zhang wrote:
> Sure, I would love to do it.
> 
> To avoid ambiguity, Should I and write a test
> case to detect whether clear the BTRFS_DEV_STATE_MISSING
> if filesystem found a device, but it was marked to
> BTRFS_DEV_STATE_MISSING.

Yes, basically the idea is for the test case to fail without your patch
and pass with your patch. That way we'll ensure this won't regress in
the future.
