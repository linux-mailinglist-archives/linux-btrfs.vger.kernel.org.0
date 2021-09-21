Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3C2413224
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Sep 2021 13:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhIULDa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Sep 2021 07:03:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58764 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbhIULD1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Sep 2021 07:03:27 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9A4DC2006B;
        Tue, 21 Sep 2021 11:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632222118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gj0/ZNQJ6vqYUOL9dvVwqH6tJUGT62Ujqud6Xh4KqDQ=;
        b=sth5vdILRQFwNqr/TVomGnKubxSVOxfGDNtQhmEmiS4bv9kAKoBZ+CZiK9TlXrMKPwRzcz
        Ros2tz/Rt3aQAhiIm+QoJPjs/dBBOl+xpFL+MXLv+KOAYAmpJZTNnmTIg2SyexnuKtMDFj
        7DStjztosgKsVSe5LXNDmok1CPalTfw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5FCC513BC6;
        Tue, 21 Sep 2021 11:01:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ut4hFKa7SWE/bwAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 21 Sep 2021 11:01:58 +0000
Subject: Re: [PATCH v6 1/3] btrfs: declare seeding_dev in init_new_device as
 bool
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
References: <cover.1632179897.git.anand.jain@oracle.com>
 <d0e619aa1de4c142d5b12a41045cc60df0d1c8dc.1632179897.git.anand.jain@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <888843fc-5a4a-27ee-f1e5-469e853819eb@suse.com>
Date:   Tue, 21 Sep 2021 14:01:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d0e619aa1de4c142d5b12a41045cc60df0d1c8dc.1632179897.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21.09.21 г. 7:33, Anand Jain wrote:
> This patch declares int seeding_dev as a bool. Also, move its declaration
> a line below to adjust packing.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
