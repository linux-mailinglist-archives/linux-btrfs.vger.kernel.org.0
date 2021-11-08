Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3756B44974A
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 15:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240668AbhKHPBL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 10:01:11 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58880 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240661AbhKHPBH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 10:01:07 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8155D1FDBB;
        Mon,  8 Nov 2021 14:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636383502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I3IMSD5S395TafpXoHEhWIQtVfqFIfrjoEY897rT2UQ=;
        b=cflcnNBfPvF2cT50UlRsUwZec+MWhv5nRmNtWbhCPyA7R83C7qycmICIJqNeY8b43gu3TD
        37lNL4B3b3WZaPTjSsCCeYppHNCOdinloWLcsH1D1zq/ri5NUG1PsFb4WGkGr/SHcTAK5q
        PNuuX9gOOP+wMaPCBptfpvT1VN9W2Lg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57FC113BB6;
        Mon,  8 Nov 2021 14:58:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qVDaEg47iWGSNwAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 08 Nov 2021 14:58:22 +0000
Subject: Re: [PATCH v2 1/3] btrfs: introduce BTRFS_EXCLOP_BALANCE_PAUSED
 exclusive state
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20211108142820.1003187-1-nborisov@suse.com>
 <20211108142820.1003187-2-nborisov@suse.com>
 <YYk60W+6No80x7Ps@localhost.localdomain>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <1d3e9a55-b6e6-12a1-a654-f441ea2f4054@suse.com>
Date:   Mon, 8 Nov 2021 16:58:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YYk60W+6No80x7Ps@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 8.11.21 г. 16:57, Josef Bacik wrote:
> +	bool paused = false;


Argh, I thought I removed it .... David unless there are more changes
requested can you remove it during merge or I can resend as well.
