Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C426690C15
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Feb 2023 15:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjBIOlq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Feb 2023 09:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjBIOlp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Feb 2023 09:41:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0E15FFF
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Feb 2023 06:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675953659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WGTVV3BitmjG9OfxHngrxG4eroSVUzr+1PJmFw0NTBk=;
        b=LSG9bsoMv8JxnbW99Zvm6LnJgS4i+AmXTLuptKon99KyMIe6w4z5VxbAxlh2X70StBI+Gm
        6yYxNgFcqQQCEN1nk/UDhB/hWzN5H//J3OKAAQ7zdJUH9/lE9sSOJ8OKAdJ7+WbQUUOzuW
        +zoDBBAbSwsbvQCDBo/6R6Og4tgsyks=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-659-9ILxDrjANMK1zZXCXmXU1g-1; Thu, 09 Feb 2023 09:40:58 -0500
X-MC-Unique: 9ILxDrjANMK1zZXCXmXU1g-1
Received: by mail-pj1-f69.google.com with SMTP id oo13-20020a17090b1c8d00b0022936a63a22so3062738pjb.8
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Feb 2023 06:40:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGTVV3BitmjG9OfxHngrxG4eroSVUzr+1PJmFw0NTBk=;
        b=HiBSHsj/o8aLSoZB4QsxDl6OhCdGwwfC8avSYrLjJcL2nMT2viDtXRVC6NqV7i9IC9
         NIMAJmo/etYXiP0y+popYGjCbPz3280X0j0rRH/zQezuCNNVtBJwuXx7hc8pP3zYhg1O
         Qy5i3aS3JpmloN5AHlAWc2cyhojF0rNHwVfT5Z7LZLO2Xv3Qg5p4VuX7D7ZtAXa+e941
         7QcvCSDw2H9tolLn8AWp7FclMUuLxSTkuBxUZugcafP5ZTr0QpVNa0riHl8T0r4rfqrk
         GK/OHAftgI8wB/c/VsDc12qMwCMck5CYPd/rAWIisP3WCbEu/boFn4nQQ9tz1QkeTK2G
         XjYQ==
X-Gm-Message-State: AO0yUKXJNbfJL17z5badd3Wm/PyZb/xTR6Jzcx+IU8h3kwDO/MOgNWBg
        Y6nH7Zl+B0E+Kk15uqj6VSKdGw0571RufPFh8dQlUiuEtID+vP5msrqC+DZHflg6Cbs5mBrO8ue
        gqwK9Y+n8E/fdrTdtOeYNqrU=
X-Received: by 2002:a17:902:e74c:b0:199:2a36:6c3f with SMTP id p12-20020a170902e74c00b001992a366c3fmr13563930plf.6.1675953656963;
        Thu, 09 Feb 2023 06:40:56 -0800 (PST)
X-Google-Smtp-Source: AK7set+Zh8gVy83LTrL9BduALKhHLCsA/K5oGbTXhePkUg41ifksDQdNu3wcew8oQUEPFViVeF6NJw==
X-Received: by 2002:a17:902:e74c:b0:199:2a36:6c3f with SMTP id p12-20020a170902e74c00b001992a366c3fmr13563902plf.6.1675953656588;
        Thu, 09 Feb 2023 06:40:56 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g21-20020a170902869500b00195f242d0a0sm1558049plo.194.2023.02.09.06.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 06:40:56 -0800 (PST)
Date:   Thu, 9 Feb 2023 22:40:52 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: run more tests in the auto group
Message-ID: <20230209144052.qpc576kznevejhzj@zlang-mailbox>
References: <20230209051355.358942-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209051355.358942-1-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 09, 2023 at 06:13:48AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this series adds a more tests to the auto and quick groups so that they
> are run as part of the usual regressions tests.

Thanks, I'm glad to see more stable cases be added into *auto* group.

But as you said btrfs/219 still fails[1] now, so I hope we can use
another patch to fix btrfs/219 singly, even if use _fixed_by_kernel_commit
or _wants_kernel_commit to specify clarify why it's failed now.
Others looks good to me. If you don't mind, I'll merge others, exclude
btrfs/219 (before another patch improve it:)

Thanks,
Zorro

[1]
btrfs/219       [failed, exit status 1]- output mismatch (see /root/git/xfstests/results//simpledev/btrfs/219.out.bad)
    --- tests/btrfs/219.out     2022-04-29 23:07:22.997495284 +0800
    +++ /root/git/xfstests/results//simpledev/btrfs/219.out.bad 2023-02-09 22:22:43.447510026 +0800
    @@ -1,2 +1,4 @@
     QA output created by 219
    -Silence is golden
    +We couldn't mount the old generation
    +(see /root/git/xfstests/results//simpledev/btrfs/219.full for details)
    +umount: /mnt/test/219.mnt: not mounted.
    ...
    (Run 'diff -u /root/git/xfstests/tests/btrfs/219.out /root/git/xfstests/results//simpledev/btrfs/219.out.bad'  to see the entire diff)

> 

