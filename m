Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABA013BBCF
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 10:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbgAOJDU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 04:03:20 -0500
Received: from zaphod.cobb.me.uk ([213.138.97.131]:43944 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729242AbgAOJDU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 04:03:20 -0500
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id B8DE99C3E7; Wed, 15 Jan 2020 09:03:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1579078998;
        bh=cirpLWt+IBLiM7EyU+OY7foyRlYKhRKFqWlBKvbaKzg=;
        h=To:Cc:From:Subject:Date:From;
        b=jdJnQY0OsivChZCZNqVwP1G9hurCfrdHHLg9qpQamjBwbQdG2Whuab81Y8l9g4lOj
         wvzCGhH0UZCa0Cym6bQo59LKDKRNLRwQtqcAK6OJYsiMe/QEfnD6MqlOR4FUBFg0Oh
         MNX5mpZyuTko6dZcdPWTs3XTtLPne4LNx+5K9CKDwZQcrKSmGI5s7CABGXP8G98bAq
         eGxYcR6Ku8aGgO9Fuf/4xJsRw+EiyCIjev3/KihTtBIqwaME88pNMXy2Aly4f3ZOlG
         b5wTvi8vF+6zDDSc+tTnuXmQP50qPO1y7/Db2/gmQLmNrnmdDUeiqkn4VBLnfgUJx+
         EfRT/prsOqS6Q==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id DC7719B967;
        Wed, 15 Jan 2020 09:03:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1579078993;
        bh=cirpLWt+IBLiM7EyU+OY7foyRlYKhRKFqWlBKvbaKzg=;
        h=To:Cc:From:Subject:Date:From;
        b=NRppCrK0dhLD1qi5RnEC83XPgOEh+uPCzAjNMp+6XovGdwd3U8zTXuXgCNUgSnFBm
         nyey9G7btvfJrAsFyHSpvVoqdo0GFhM9Q5t7V4dS1rGjHwD5fZJk2oDZ+fuNDcd1Jb
         RSoyzUMthxXy4mmrqS67bTu5abO2r61MvepW4JtMNMWpMgOAloUuasA/Sth8XlN8w4
         SUOPkzKcwOVKeijWPq9S7xHs4TQGs+/nQrOPT/bUnxVLjc602leOxolkWyMTTRaYbU
         9+RdR/+xwo9+Uhkv270wF7riIplc86FtDq16M4+CUdtL6nZpbrQFtBTWTaAczvrwKH
         UwBZdqLyu+TQA==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 86DBAA2E6C;
        Wed, 15 Jan 2020 09:03:13 +0000 (GMT)
To:     linux-btrfs@vger.kernel.org
Cc:     =?UTF-8?Q?Sebastian_D=c3=b6ring?= <moralapostel@gmail.com>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Subject: Scrub resume regression
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <d0a97688-78be-08de-ca7d-bcb4c7fb397e@cobb.uk.net>
Date:   Wed, 15 Jan 2020 09:03:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

OK, I have bisected the problem with scrub resume being broken by the
scrub ioctl ABI being changed.

The bad commit is:

Fail
06fe39ab15a6a47d4979460fcc17d33b1d72ccf9 is the first bad commit
commit 06fe39ab15a6a47d4979460fcc17d33b1d72ccf9
Author: Filipe Manana <fdmanana@suse.com>
Date:   Fri Dec 14 19:50:17 2018 +0000

    Btrfs: do not overwrite scrub error with fault error in scrub ioctl

    If scrub returned an error and then the copy_to_user() call did not
    succeed, we would overwrite the error returned by scrub with -EFAULT.
    Fix that by calling copy_to_user() only if btrfs_scrub_dev() returned
    success.

    Signed-off-by: Filipe Manana <fdmanana@suse.com>
    Reviewed-by: David Sterba <dsterba@suse.com>
    Signed-off-by: David Sterba <dsterba@suse.com>

 fs/btrfs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
bisect run success

It is important that scrub always returns the stats, even when it
returns an error. This is critical for cancel, as that is how
cancel/resume works, but it should also apply in case of other errors so
that the user can see how much of the scrub was done before the fatal error.

I am not sure in which kernel release this commit appeared but as this
breaks the "scrub resume" command completely, I think the fix for this
needs to be backported and may want to be considered by distro kernel
maintainers.

I will reply later with the simple reproducer program I created for the
bisection in case it is useful for testing.
