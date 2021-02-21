Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8DB3207E1
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Feb 2021 02:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhBUBEa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Feb 2021 20:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhBUBEU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Feb 2021 20:04:20 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55688C061574
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Feb 2021 17:03:40 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id s10so3881472qvl.9
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Feb 2021 17:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9q2gk4vIMMS3gp1jr2mmzoRZKvNzASNKPW2uNlVhZx0=;
        b=RH49CmG6xkCQoCm6v/D5KoA4cq+8iuzKy3YJL0dwj+GBER2vfCMfw7CRR2JjrnHPfc
         r6+L9tOgPRs2owmt5tNkh3IKcf5BwvvFq3i6FgSh2+DEhttpU3Sy2Tjw2uuOaX49n5Bb
         D6hwkoNRnA4chNp+71reMP5ZfvusluDMk74vkR0GG/FKrMqbsxiZxDrWrWUA5KeroT4S
         L8pIEQ/lNgnfvBdkr4Yh9BxADVy2SGsEipBaifvJ3h9H1DGZXCo1BLXaNylLm/Im6CNX
         ZjOCEJATi5VNQB8rD/qJ9FUdFbZkx6wdTx+U5JselbvXa9jWy70U+PWJ7XoE9yaa+63f
         PrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9q2gk4vIMMS3gp1jr2mmzoRZKvNzASNKPW2uNlVhZx0=;
        b=qoF0O0ctKt+TubGi7FBdCLN0Q3YF+vM29GxwAOxshqMCMUkEjIpedpOUK7G6/aHbf2
         HHR0h4ZaoItO1ePa8jtf67Tqv7Gfnt3ux9JxfnN75/ALsA5iChPUjZQNQrEEKxcM91Mr
         YjfCGwub0I6HrCSr/TtQw23ymcmvbILzllcl37Inq++NFUJAkM0/jvBn5wEz0TBwxVph
         hfYcTe9Sz3aIa/EHvRlWswi+i1M5NaCD1sYCCwbcCc6ixuF6LHzy6COSi1c+SDSqU6Bx
         HKf0QjmPkY8yJHphNLY2LYFIh5g8EXkmEaof3WdDndxoHrsvxqSCB0vfEe5T3uRISeJe
         nBpQ==
X-Gm-Message-State: AOAM530H+VsPx39duIhD4LGSGDg/9+N0zHXD4BZgvdXGs/+5VO4Vh06l
        ZohAQFZfAOhKfstVAL5HNPntAqkicGTxUtlstC4=
X-Google-Smtp-Source: ABdhPJz9UjK9K7Nll/IjweRvbeoxgc/AG3zAeZQM8ipSKUESlRBOf2lxj+C2nWUhNI+H4Q0zCBgplUtcPFcm0ZuYe1I=
X-Received: by 2002:ad4:5110:: with SMTP id g16mr15536704qvp.50.1613869418901;
 Sat, 20 Feb 2021 17:03:38 -0800 (PST)
MIME-Version: 1.0
References: <CAOE4rSyacNvoACo7+CYc76=WFS6XYtKMJg9akV61qfnnR1uTGg@mail.gmail.com>
 <20210219192947.GJ32440@hungrycats.org> <CAOE4rSwPALKbk8Wv4eqnapbXKb=MeG2gYmGezWybx-mJ2ZPXXw@mail.gmail.com>
In-Reply-To: <CAOE4rSwPALKbk8Wv4eqnapbXKb=MeG2gYmGezWybx-mJ2ZPXXw@mail.gmail.com>
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Sun, 21 Feb 2021 03:03:27 +0200
Message-ID: <CAOE4rSyf06YjongJ2h1tpMXJeYj6wGV7TKV9AK_c8M1+7o4NsA@mail.gmail.com>
Subject: Re: ERROR: failed to read block groups: Input/output error
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I just found something really strange, it seems pointers for extent
tree and csum tree have somehow gotten swapped...

$ btrfs inspect dump-super -f /dev/sda | grep backup_extent_root
backup_extent_root:     21056867106816  gen: 2262737    level: 3
backup_extent_root:     21056867762176  gen: 2262738    level: 3
backup_extent_root:     21057133690880  gen: 2262740    level: 3 <<
points to CSUM_TREE
backup_extent_root:     21056854228992  gen: 2262736    level: 3

$ btrfs inspect dump-super -f /dev/sda | grep backup_csum_root
backup_csum_root:       21056868122624  gen: 2262737    level: 3
backup_csum_root:       21056944685056  gen: 2262738    level: 3
backup_csum_root:       21057139916800  gen: 2262740    level: 3 <<
points to EXTENT_TREE
backup_csum_root:       21056857341952  gen: 2262736    level: 3

$ btrfs inspect dump-tree -b 21057133690880 /dev/sda | head -n 2
btrfs-progs v5.10.1
node 21057133690880 level 1 items 316 free space 177 generation
2262698 owner CSUM_TREE

$ btrfs inspect dump-tree -b 21057139916800 /dev/sda | head -n 2
btrfs-progs v5.10.1
leaf 21057139916800 items 166 free space 6367 generation 2262696 owner
EXTENT_TREE


Previous gen is fine

$ btrfs inspect dump-tree -b 21056867762176 /dev/sda | head -n 2
btrfs-progs v5.10.1
node 21056867762176 level 3 items 2 free space 491 generation 2262738
owner EXTENT_TREE

$ btrfs inspect dump-tree -b 21056944685056 /dev/sda | head -n 2
btrfs-progs v5.10.1
node 21056944685056 level 3 items 5 free space 488 generation 2262738
owner CSUM_TREE

Also generation specified in backup root doesn't match with one in
block so seems like latest gen wasn't written to disk or something
like that.

In root tree there is different extent tree used than one specified in
backup root.
$ btrfs inspect dump-tree -b 21057011679232 /dev/sda | head -n 6
btrfs-progs v5.10.1
node 21057011679232 level 1 items 126 free space 367 generation
2262739 owner ROOT_TREE
node 21057011679232 flags 0x1(WRITTEN) backref revision 1
fs uuid 8aef11a9-beb6-49ea-9b2d-7876611a39e5
chunk uuid 4ffec48c-28ed-419d-ba87-229c0adb2ab9
key (EXTENT_TREE ROOT_ITEM 0) block 21057018363904 gen 2262739
