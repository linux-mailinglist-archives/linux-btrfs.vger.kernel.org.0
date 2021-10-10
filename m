Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC044281EC
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Oct 2021 16:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhJJOby (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Oct 2021 10:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhJJObx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Oct 2021 10:31:53 -0400
Received: from mail.fsf.org (mail.fsf.org [IPv6:2001:470:142::13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB892C061570
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Oct 2021 07:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fsf.org;
        s=mail-fsf-org; h=MIME-Version:In-reply-to:Date:Subject:To:From:References;
         bh=LoPAvuisd97nV8zkVNjJj8hgVj5YqfUR9guwt5UtroQ=; b=jipU7NiFPR1+1YwHzJ+AkXvLm
        kCXwIiEKB7/fpOvPCk7Cm5EVO4dCxlE2ZuwSs7JtvDx9D+wh2iHyRLDh7TtV0CpgpjX8CoRIAumZA
        V3x54RdjsTp3fdQBg3B+Da7QanpgjRLjcO+9S1j5EOapXJ/rFFczMsegTuB5WP8UtQzygvbIgWtbf
        3aSQfkSGhMsNby4ryG3JvJ+oXc0gTPpxv7v3kqGw73LAsrXUb9C3m+PnnZUgCg51/I2HaMt7JYVGk
        gZVz/najbpxuIo1KgEf1QiGUQfM2WTU8LkVCRpwhH7y4kqm9jhVHCiUrAoHYhRWe5P9Si3G+JCmpS
        jgf+CWt4A==;
Received: from jumpgate.fsf.org ([74.94.156.211]:40936 helo=mail.iankelling.org)
        by mail.fsf.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <iank@fsf.org>)
        id 1mZZpp-00007a-Bk
        for linux-btrfs@vger.kernel.org; Sun, 10 Oct 2021 10:29:53 -0400
Received: from iank by mail.iankelling.org with local (Exim 4.93)
        (envelope-from <iank@fsf.org>)
        id 1mZZpo-00GE3X-LU
        for linux-btrfs@vger.kernel.org; Sun, 10 Oct 2021 10:29:52 -0400
References: <87ily8y9c8.fsf@fsf.org> <871r4wr1t3.fsf@fsf.org>
User-agent: mu4e 1.7.0; emacs 28.0.50
From:   Ian Kelling <iank@fsf.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: I got a write time tree block corruption detected
Date:   Sun, 10 Oct 2021 10:14:01 -0400
In-reply-to: <871r4wr1t3.fsf@fsf.org>
Message-ID: <87k0ilj6lb.fsf@fsf.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Update: btrfs check found no problem. I would really appreciate any
suggestions for next steps. Perhaps I should try a newer kernel and
btrfs-progs?

This reply took a few days because I got ooms and had to add ram. The
btrfs check was run on the disk that had the error reported, but I'm
going to run btrfs check on the other 3 disks now.


[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
Opening filesystem to check...
Checking filesystem on /dev/mapper/btrfs0
UUID: cdbab81e-20ec-49e6-904c-649f6096b112
found 16065287630848 bytes used, no error found
total csum bytes: 15558808924
total tree bytes: 130372911104
total fs tree bytes: 106602610688
total extent tree bytes: 5744771072
btree space waste bytes: 21717413011
file data blocks allocated: 15935065186304
 referenced 17934646562816
 
-- 
Ian Kelling | Senior Systems Administrator, Free Software Foundation
GPG Key: B125 F60B 7B28 7FF6 A2B7  DF8F 170A F0E2 9542 95DF
https://fsf.org | https://gnu.org
