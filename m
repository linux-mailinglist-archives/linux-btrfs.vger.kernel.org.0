Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E88425E44
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Oct 2021 22:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbhJGU6y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Oct 2021 16:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbhJGU6x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Oct 2021 16:58:53 -0400
Received: from mail.fsf.org (mail.fsf.org [IPv6:2001:470:142::13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBE8C061570
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Oct 2021 13:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fsf.org;
        s=mail-fsf-org; h=MIME-Version:In-reply-to:Date:Subject:To:From:References;
         bh=mhonkSaNNhPw8HHx7A3atvtcX5r1zq5zz5wAFJvtjDY=; b=qSuO5870Dj9YJf9UY02KN9R5o
        9ytE1LQF/J6dcbkliNb4Bi31f47hdYefGlDRkMateVHDweHcUw5Vm2EMiB3ALxtxrGTVaTlZ2cqd+
        cPBLtohbmTyNRSacn04mdZ5SUKXlVIstKHAAwdRnGwAoR5LT2Ha5e6dc2f2gcrZJIPluzgnQck/NF
        hZTnGIFBM+30htIQgQIw1BAXWZ9eUEY9ovQ1MhFXwwXLt/xIouSrcQGStgzVKvGXzlk/IAJfBGAw3
        +xU9JALrt8ARrvuKNQqgH1ACM9k5L/UK5yRDsonyhuDvRN7X1P7jGLe/HI9OzQg6/K5ojY7SHABvJ
        IxxPPjkmg==;
Received: (helo=mail.iankelling.org)
        by mail.fsf.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <iank@fsf.org>)
        id 1mYaRl-0005me-2V
        for linux-btrfs@vger.kernel.org; Thu, 07 Oct 2021 16:56:57 -0400
Received: from iank by mail.iankelling.org with local (Exim 4.93)
        (envelope-from <iank@fsf.org>)
        id 1mYaRk-000btN-Ef
        for linux-btrfs@vger.kernel.org; Thu, 07 Oct 2021 16:56:56 -0400
References: <87ily8y9c8.fsf@fsf.org>
User-agent: mu4e 1.7.0; emacs 28.0.50
From:   Ian Kelling <iank@fsf.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: I got a write time tree block corruption detected
Date:   Thu, 07 Oct 2021 16:54:36 -0400
In-reply-to: <87ily8y9c8.fsf@fsf.org>
Message-ID: <871r4wr1t3.fsf@fsf.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--=-=-=
Content-Type: text/plain

For this log line,

[Thu Oct  7 13:04:41 2021] BTRFS critical (device dm-3): corrupt leaf: root=5 block=5558935797760 slot=0 ino=161138910, invalid nlink: has 2 expect no more than 1 for dir

I see a previous report on the list and someone requested output of a command (
https://lore.kernel.org/linux-btrfs/fb556cb2-4444-005f-4a94-6346f2a641ac@gmx.com/ )

btrfs ins dump-tree -b 5558935797760 /dev/dm-3

The output is rather long, I've attached it, but here is the head and tail
also in case that is enough:

btrfs-progs v5.10.1 
leaf 5558935797760 items 244 free space 2131 generation 129446 owner EXTENT_TREE
leaf 5558935797760 flags 0x1(WRITTEN) backref revision 1
fs uuid cdbab81e-20ec-49e6-904c-649f6096b112
chunk uuid 41516bf2-a2b3-4793-bb1c-bbcb8a7cca40
        item 0 key (15927669194752 METADATA_ITEM 0) itemoff 16250 itemsize 33
                refs 1 gen 129210 flags TREE_BLOCK
                tree block skinny level 0
                tree block backref root EXTENT_TREE
        item 1 key (15927669211136 METADATA_ITEM 0) itemoff 16217 itemsize 33
                refs 1 gen 129216 flags TREE_BLOCK
                tree block skinny level 0
                tree block backref root FS_TREE

...

        item 242 key (15927673700352 METADATA_ITEM 0) itemoff 8264 itemsize 33
                refs 1 gen 129225 flags TREE_BLOCK
                tree block skinny level 0
                tree block backref root FS_TREE
        item 243 key (15927673716736 METADATA_ITEM 0) itemoff 8231 itemsize 33
                refs 1 gen 129239 flags TREE_BLOCK
                tree block skinny level 0
                tree block backref root EXTENT_TREE

--=-=-=
Content-Type: application/x-gtar-compressed
Content-Disposition: attachment; filename=btrfs_ins_dump-tree.tgz
Content-Transfer-Encoding: base64

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
--=-=-=
Content-Type: text/plain


-- 
Ian Kelling | Senior Systems Administrator, Free Software Foundation
GPG Key: B125 F60B 7B28 7FF6 A2B7  DF8F 170A F0E2 9542 95DF
https://fsf.org | https://gnu.org

--=-=-=--
