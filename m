Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE816642EB
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jan 2023 15:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjAJONU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Jan 2023 09:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjAJONQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Jan 2023 09:13:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D155271E
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 06:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673359950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2oLtxlw5NQr6j574pRIpdKLcP45xIyvdULrznqpcz3s=;
        b=aMN0pGxRcKdKH4l65o3qgkvTDqbt5M/MhBo42l2BZ37dDYMMioY1fCECh7A8sMdFp2CRKW
        NGA0WwnBz83NurNeSV2oJmxMP/IRt+LZZMyuV7pEfeskFr2USVy1oseyCX3+zfm7PKj2YV
        pOkhicXVvochimhtCDyKTTFQjuGUWJI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-232-vyXWCcJ2PbuI9KDtl-hBAg-1; Tue, 10 Jan 2023 09:12:29 -0500
X-MC-Unique: vyXWCcJ2PbuI9KDtl-hBAg-1
Received: by mail-pj1-f69.google.com with SMTP id om16-20020a17090b3a9000b002216006cbffso9308780pjb.3
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 06:12:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oLtxlw5NQr6j574pRIpdKLcP45xIyvdULrznqpcz3s=;
        b=48KqPkyeTFuyrP1T4aYDfLjzL3pv/ZmW7SQw2/NFxUQFWBX6kNyixkw2znRgKpIrdU
         rcRXvYVu7W37uo3zbxYScG3cgHCU6rFrJB6cELBemvh8NvTDyAECNC2mFI+ZWdrb/9kh
         E5ypx022tUUgMEVgM11fNVCrJiaOjdC0Z+ZfgxUplncfBxbxcQQNtHvEIKsUFXgzyWYT
         VbFPqCjWwgDvEJczFcqWw0hiqggMxu8jqUVpLWEmw0R6IuHeLRBsSqE0gD1sYY92Z+Rv
         u0tS/B1mdCoXAF95s5YQ4NTVg3eFFAGp11dN28QKeKb0EpOqQn8iktkCXx9IbK1CFQRB
         S+ig==
X-Gm-Message-State: AFqh2kqJk6czo3vSAsX0WDIQY/cNAYbNGEsW6XTfZiiDzN9keP0GLj57
        XxkmlK4hjZGPy2bTxWOcVDSWZAEyqKUV7v62xjAdxOFnV0VyyyI9lV5xuk1axqzN30Bt0fJspbL
        o+giYJkiJ4Mqc5CZJ4mGvRqk=
X-Received: by 2002:a05:6a00:1255:b0:576:b8e1:862b with SMTP id u21-20020a056a00125500b00576b8e1862bmr83028524pfi.14.1673359948306;
        Tue, 10 Jan 2023 06:12:28 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuBcm+WnvzSTeN5NdXcAQfX21dpIyjlZSs+d6IgL64UAFe0QfUS/1UNQJyVBXO/Tu3A6gyKzA==
X-Received: by 2002:a05:6a00:1255:b0:576:b8e1:862b with SMTP id u21-20020a056a00125500b00576b8e1862bmr83028505pfi.14.1673359948014;
        Tue, 10 Jan 2023 06:12:28 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v67-20020a622f46000000b00581ad007a9fsm8102982pfv.153.2023.01.10.06.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 06:12:27 -0800 (PST)
Date:   Tue, 10 Jan 2023 22:12:23 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Wang Yugui <wangyugui@e16-tech.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs/012: check if ext4 is available
Message-ID: <20230110141223.adgbm5oehxwh5tnw@zlang-mailbox>
References: <20230110082924.1687152-1-johannes.thumshirn@wdc.com>
 <20230110192321.34D5.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110192321.34D5.409509F4@e16-tech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 10, 2023 at 07:23:22PM +0800, Wang Yugui wrote:
> Hi,
> 
> > btrfs/012 is requiring ext4 support to test the conversion, but the test
> > case is only checking if mkfs.ext4 is available, not if the filesystem
> > driver is actually available on the test host.
> > 
> > Check if the driver is available as well, before trying to run the test.
> > 
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > ---
> >  tests/btrfs/012 | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/tests/btrfs/012 b/tests/btrfs/012
> > index 60461a342545..86fbbb7ac189 100755
> > --- a/tests/btrfs/012
> > +++ b/tests/btrfs/012
> > @@ -32,6 +32,8 @@ _require_command "$E2FSCK_PROG" e2fsck
> >  _require_non_zoned_device "${SCRATCH_DEV}"
> >  _require_loop
> >  
> > +grep -q ext4 /proc/filesystems || _notrun "no ext4 support"
> 
> when ext4 is module, and is not used, 'ext4' will not be in /proc/filesystems.

Really? Actually I'm not sure about that. There's an existing helper in
common/rc named _require_extra_fs(). Which we usually used to check if
a secondary filesystem is supported by the current kernel. Likes:

$ grep -rsn _require_extra_fs tests/
tests/generic/631:42:_require_extra_fs overlay
tests/generic/699:26:_require_extra_fs overlay
tests/overlay/025:36:_require_extra_fs tmpfs
tests/overlay/106:22:_require_extra_fs tmpfs
tests/overlay/107:22:_require_extra_fs tmpfs
tests/overlay/108:22:_require_extra_fs tmpfs
tests/overlay/109:22:_require_extra_fs tmpfs
tests/xfs/049:43:_require_extra_fs ext2

Thanks,
Zorro

> 
> so we need a right way to check ext4 support.
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2023/01/10
> 

