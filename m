Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1306264A8C2
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 21:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbiLLUfA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 15:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiLLUe5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 15:34:57 -0500
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Dec 2022 12:34:55 PST
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A685363FB;
        Mon, 12 Dec 2022 12:34:55 -0800 (PST)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id F294082401;
        Mon, 12 Dec 2022 15:19:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1670876362; bh=ahecorPcbaJ/V1nEf8Rhmh8ANZrO4Ll8XuwJ2YCDEyo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QzAwbEjqRfQkd1q8ZDPhTQa3TOCe3sD5s5C44ffESvgXjePe0C44GJd5dUOTIOOGo
         5waDCzm1z4ovHXaCT7RHULCRkkFxRTWcliLvCOyEQtK7VwBO91Ahq/Cou9vERxK5qi
         7wmed7YRrsAZ+tW8UK6YndeYSRd/DfZQAiGCgpKAIM75cSQXxXqNRbw+ws16RFQDfT
         7CankfJpBO2iBgPOWqeZnuJejiFkA5ukypxWiQkoV90fMd/5nDHYWOmwx6J/L0+nlm
         bjVfgB2apKSr8xK2yK+2Z0yqwAsKoJRCUUcJGSmn+dHiroLWIbg0oRHZz9HknlbnDT
         Raa8viHJ1+ULg==
Message-ID: <bd148378-38b7-323a-eea3-26790c099920@dorminy.me>
Date:   Mon, 12 Dec 2022 15:19:21 -0500
MIME-Version: 1.0
Subject: Re: [PATCH] btrfs: Fix an error handling path in btrfs_rename()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <943f0f360f221da954f5dd7f16e366d0e294ae72.1670876024.git.christophe.jaillet@wanadoo.fr>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <943f0f360f221da954f5dd7f16e366d0e294ae72.1670876024.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12/12/22 15:14, Christophe JAILLET wrote:
> If new_whiteout_inode() fails, some resources need to be freed.
> Add the missing goto to the error handling path.
> 
> Fixes: ab3c5c18e8fa ("btrfs: setup qstr from dentrys using fscrypt helper")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Thanks for catching this.
