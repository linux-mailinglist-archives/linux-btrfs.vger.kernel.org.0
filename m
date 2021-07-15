Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E413C9CA2
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 12:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241309AbhGOKdf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jul 2021 06:33:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37746 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhGOKdf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jul 2021 06:33:35 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5294622862;
        Thu, 15 Jul 2021 10:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626345041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DcsoMvaipggC+3J4Lzh44rGeXW0aW/cyeJrRNTKyQrA=;
        b=CySIL1ttJd+geBvWVppiuxk+ou8OuI+9qdBspG9SfgMh69U+Qt5twWCtFDHbHYKS+repIC
        YliXHJhdsD0hEZjM/PAJuC0XGVEKwQdZmyBpVT4TzxZuvaZzX42eN/U9bYRsgtU4SkytBa
        ek76Q/gArreMir+zGgSJk5IjZH5ouD8=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 0E50013D7E;
        Thu, 15 Jul 2021 10:30:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id THgIAVEO8GAbGgAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 15 Jul 2021 10:30:41 +0000
Subject: Re: Memory folios and Btrfs
To:     Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <CAEg-Je-JDyoWvcHZjVh-Wm-KOcV_qt3R+m-ObDzCR2kByft_2g@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <b46db172-c8c9-7daf-3bd9-f91c9e68bf11@suse.com>
Date:   Thu, 15 Jul 2021 13:30:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAEg-Je-JDyoWvcHZjVh-Wm-KOcV_qt3R+m-ObDzCR2kByft_2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 15.07.21 г. 13:26, Neal Gompa wrote:
> I've been peripherally following the work on memory folios that
> Matthew Wilcox has been doing[1], and I started wondering if Btrfs
> would benefit from it after the subpage stuff is done? It seems like
> adopting this would be an opportunity to decouple Btrfs from mm page
> size entirely, while allowing us to pick more optimal settings for
> Btrfs regardless of architecture.
The reason btrfs is coupled with the page size is not due to memory
folios but due to having the btree inode. So converting to memory folios
won't help on that front.
