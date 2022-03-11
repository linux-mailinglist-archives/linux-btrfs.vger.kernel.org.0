Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E6B4D64D2
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Mar 2022 16:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244279AbiCKPnU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 10:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240607AbiCKPnT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 10:43:19 -0500
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277A51C665A
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 07:42:16 -0800 (PST)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id E5F5E8060A;
        Fri, 11 Mar 2022 10:42:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1647013335; bh=0ZNVwb61/V3nTg6kqUQrCCGOwmd4/3PNnWDVNo0FTVE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PLNA3eyC21wz/6AYlw4CILVvn/WMpVxCIczMd/8tyHc9OOQMzKQxaTPxFaPvunbJd
         Uz4PnTIV2ORuHUqVkON6nzm6iOKdSapqCQjW1EzGjCto320nsgzJNIw/X62tVrshQ4
         VRdONW7zxqp1JF52bSFVoi5ucA48S9RgxjAwdhMV0cAQbPldaii94pQBruxyNU1e+6
         rAboXmL5QX5lLUVgZTlb10hHpCrcAzL1lY9+u+WYKmRuw5+rTjOMpYnBOmUT/AThQX
         xN/GlNlm+krRCJLSszbkcI7AuFRJ2XQhliJ6sg4q7WE1pwJU9kfmvUILyCfA7SOetb
         01G9RCgaGFPhA==
Message-ID: <1f55ff0e-c89d-0216-2c2f-0e1d7aa2a089@dorminy.me>
Date:   Fri, 11 Mar 2022 10:42:14 -0500
MIME-Version: 1.0
Subject: Re: [PATCH v2 03/16] btrfs: fix anon_dev leak in create_subvol()
Content-Language: en-US
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
References: <cover.1646875648.git.osandov@fb.com>
 <ee5528d299d357f225a228c394830d88e6eda17c.1646875648.git.osandov@fb.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <ee5528d299d357f225a228c394830d88e6eda17c.1646875648.git.osandov@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> +out_anon_dev:
>   	if (anon_dev)
>   		free_anon_bdev(anon_dev);

It looks to me as though the finer-grained cleanup means 
free_anon_bdev() can always be called with no conditional; if the code 
reaches this point in cleanup, anon_dev was populated by get_anon_bdev() 
(which must have returned zero, indicating successfully populating 
anon_dev).


Otherwise,

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

and thanks.

