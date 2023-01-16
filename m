Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5D366C402
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jan 2023 16:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjAPPeM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 16 Jan 2023 10:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjAPPdZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Jan 2023 10:33:25 -0500
Received: from mail.lichtvoll.de (luna.lichtvoll.de [194.150.191.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5568A234F2
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:30:23 -0800 (PST)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 7DD005C20D6;
        Mon, 16 Jan 2023 16:30:22 +0100 (CET)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Correct way to clear a free space cache file invalid error
Date:   Mon, 16 Jan 2023 16:30:22 +0100
Message-ID: <1842057.tdWV9SEqCh@lichtvoll.de>
In-Reply-To: <bddd724d-649b-aa3b-9a97-f415fe7b6afd@gmx.com>
References: <2269684.ElGaqSPkdT@lichtvoll.de>
 <bddd724d-649b-aa3b-9a97-f415fe7b6afd@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo - 16.01.23, 11:41:07 CET:
> On 2023/1/16 18:22, Martin Steigerwald wrote:
[…]
> > So what is the correct way to clear that error?
> 
> "btrfs check --clear-space-cache v1 <device>".
> 
> Of course you need to unmount the fs in the first place.
> 
> The clear_cache mount option only clears the old cache of touched bgs.
> If the bg is not touched during the runtime, it won't be modified.
> 
> Or, you can go v2 cache, which would drop the v1 cache at the first
> mount.

Thanks. I went to v2 cache during rebooting by putting the mount options 
for that in /etc/fstab temporarily. This appears to have worked.

Ciao,
-- 
Martin


