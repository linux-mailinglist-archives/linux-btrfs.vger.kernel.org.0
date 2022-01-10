Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595EF48979C
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jan 2022 12:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244853AbiAJLiB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 06:38:01 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51600 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244841AbiAJLgt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 06:36:49 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CC22821127;
        Mon, 10 Jan 2022 11:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641814607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m4fVvl2DfDs3XjAmHqok36Ca/7xzF6YbvPOIZ24zWtk=;
        b=t0f99T/pIRjDGwljRRmoJsPaT26IHT5nreQu6C1Ao9d/rbv/L9S7+k89bUpuLLtlVY2Ce3
        1hYliOhKbNnZikbjLvskmNzQyfF2f5sf26T43Hpf06ICxM5MRH0wkESVFz3OQW6NhnallE
        pCZFTnD7PyjxZ/61cwQ6+KOJVy9L7CA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 888D3139ED;
        Mon, 10 Jan 2022 11:36:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YN7DHU8a3GGYdgAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 10 Jan 2022 11:36:47 +0000
Subject: Re: [PATCH] btrfs-progs: Don't crash when processing a clone request
 during received
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Muprhy <lists@colorremedies.com>
References: <20220110111201.1824108-1-nborisov@suse.com>
 <c880cf15-45eb-062e-f118-3b8467e4a62a@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <249309ec-824c-3390-363c-ad1c58539c25@suse.com>
Date:   Mon, 10 Jan 2022 13:36:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <c880cf15-45eb-062e-f118-3b8467e4a62a@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.01.22 г. 13:30, Qu Wenruo wrote:
> 
> Just curious that, can we refactor the helper to remove the NULL pointer
> return case?


Yes, the change is simple enough:

diff --git a/common/send-utils.c b/common/send-utils.c
index 4ed448b1f306..5002cfbbd0e8 100644
--- a/common/send-utils.c
+++ b/common/send-utils.c
@@ -308,10 +308,8 @@ struct subvol_info *subvol_uuid_search(int mnt_fd,
                goto out;

        info = calloc(1, sizeof(*info));
-       if (!info) {
-               ret = -ENOMEM;
-               goto out;
-       }
+       if (!info)
+               return ERR_PTR(-ENOMEM);
        info->root_id = root_id;
        memcpy(info->uuid, root_item.uuid, BTRFS_UUID_SIZE);
        memcpy(info->received_uuid, root_item.received_uuid,
BTRFS_UUID_SIZE);



However this only results in callers doing IS_ERR() rather than
IS_ERR_OR_NULL imo not much of a win.

