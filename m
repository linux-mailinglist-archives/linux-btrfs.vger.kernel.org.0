Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB0F6EAB20
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Apr 2023 14:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjDUM67 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Apr 2023 08:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjDUM66 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Apr 2023 08:58:58 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649AA139
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Apr 2023 05:58:57 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id D064080858;
        Fri, 21 Apr 2023 08:58:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1682081936; bh=zqW0ty3H+D8imlaKqAAzIONU39Ijr4o2QlLWUZtkGG4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iDjlOoBulEoIIJ+TAq8wZsn6dMARB8no/NPsetd71fUG7J6jN9T8tpbVrrloziDlZ
         7G9+e4zhBEurregi0qyHG90MMdFJIL4cINYemY3DqpTi6lXi6TT6J9m1O3eG5SHwCA
         YpJl3wPP6oDUUZef8Xejx6EKiqmLvQdbf7Mkw3lUSEeP/3xVBMvRX+dvYPdtyvc9Oa
         E3dFBEmyrh34gF75EKtLXj0KnnTtTts+AjGmv+c2EpnhZLfIb2z+Got1bxoE9JxjeY
         hZItBZKxUASZRsGXHc3CzINPT+WN8sxCdC1nEcgRWX3hnD4EWhuipCSWpnyfmIEdeD
         AlTQfZFAEGbTQ==
Message-ID: <9472eb7d-9daa-54c0-2d33-740edf509542@dorminy.me>
Date:   Fri, 21 Apr 2023 08:58:54 -0400
MIME-Version: 1.0
Subject: Re: [PATCH] btrfs: don't commit transaction for every subvol create
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@meta.com
References: <61e8946ae040075ce2fe378e39b500c4ac97e8a3.1681151504.git.sweettea-kernel@dorminy.me>
 <20230417184635.GL19619@twin.jikos.cz>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <20230417184635.GL19619@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> 
> So I think it's safe and allows the use case of creating many subvolumes
> without the full transaction commit overhead. And we don't need the
> commandline options. Added to misc-next, thanks.

Just to check, have you pushed misc-next containing this to github? I 
can't find it in git log.
Thanks!
