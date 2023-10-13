Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EB97C7EF6
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Oct 2023 09:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjJMHwL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Oct 2023 03:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjJMHwK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Oct 2023 03:52:10 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D2F83
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Oct 2023 00:52:09 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4054496bde3so18755935e9.1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Oct 2023 00:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697183527; x=1697788327; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7MI/6z0Vl5T7Tg/rfT4A+b/tZ7mqsTtaIG3taQo/s5M=;
        b=qwx6yZLka8ryA1xKw/Fc393yOk/jhc5DsB7x6vj4kdZEzjiv43BpVUl/7R+CHjmUGC
         ynFdBi37rSNE9NFY1JtxkZamt7RictrLt0rBSLRxpGvEk9pvMqmBhGAwZfP/y/i1TcIR
         5QNbOtIulJxKmJelOfd/juZnuhDi2TnQ24WYRpxJaniq8CjbJRqsznLKvDaiS85TW8Qr
         XOwaBqnGucopL6JW/K5xk6WI7sSIyh1BBirWfo9Zs1ww6AXHXlWleQ+cc4YZo2HwHBN3
         rscAvMYERN+pQCczmMTpV2pPuF1VhoKVJ+/31nBBqt7vb6fxJTzRVqXbWUe3tsokezd8
         Hw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697183527; x=1697788327;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7MI/6z0Vl5T7Tg/rfT4A+b/tZ7mqsTtaIG3taQo/s5M=;
        b=ek3/IRNS1QkRfA2/9g5t97FMpXTkjVrT2NpjbRws/C877RC09UoCRIn82z/IIzWjzp
         ojOODxnJhqk05BqtkjBd79/X22+lSMa9jDOFpIbyCg6tWKr6oF0APLBv27ObWAXPBhTR
         lPc4xAor69ky1lp2PNav22vsSDp4pU8OUWIKieBDgWwrR92gZuHN9gq2etbmqA3SK6uo
         ItOdo/TALwZy2XyIDKxX8CObQBsoZufRahM6b+5yZYLemUw363oIae2itn15Zro2kWER
         VMgJbVGuvo9/l1BGgh1P/8kdO1i8/E9HtYROnQeEwf266nQWcYd43fhPZuUh1YrvQUyi
         1jOw==
X-Gm-Message-State: AOJu0YwtUfd4VIUKqfRuDWBigKhnbfKEIiH7I+iLRi/olBMhUMkLUBUu
        ltTsLOQP/IgCbXPxa6dRdIvloDf8uBYgJmGmfyo=
X-Google-Smtp-Source: AGHT+IGlAs0WLOq7Iy4pe1pMvNo2gHKrNbDZTLSRH7xpENGPXFUgtDm59uPTFhoSb3+0ndPT6Y2P2w==
X-Received: by 2002:a05:6000:1141:b0:32d:8450:1f21 with SMTP id d1-20020a056000114100b0032d84501f21mr5635000wrx.0.1697183527671;
        Fri, 13 Oct 2023 00:52:07 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id dh13-20020a0560000a8d00b00327cd5e5ac1sm5640852wrb.1.2023.10.13.00.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 00:52:07 -0700 (PDT)
Date:   Fri, 13 Oct 2023 10:52:04 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     gerhard@heift.name
Cc:     linux-btrfs@vger.kernel.org
Subject: [bug report] btrfs: new ioctl TREE_SEARCH_V2
Message-ID: <ce6f4bd6-9453-4ffe-ba00-cee35495e10f@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Gerhard Heift,

The patch cc68a8a5a433: "btrfs: new ioctl TREE_SEARCH_V2" from Jan
30, 2014 (linux-next), leads to the following Smatch static checker
warning:

	fs/btrfs/ioctl.c:1787 btrfs_ioctl_tree_search_v2()
	warn: not copying enough bytes for '&uarg->buf_size' (8 vs 4 bytes)

fs/btrfs/ioctl.c
    1760 static noinline int btrfs_ioctl_tree_search_v2(struct inode *inode,
    1761                                                void __user *argp)
    1762 {
    1763         struct btrfs_ioctl_search_args_v2 __user *uarg = argp;
    1764         struct btrfs_ioctl_search_args_v2 args;
    1765         int ret;
    1766         size_t buf_size;
    1767         const size_t buf_limit = SZ_16M;
    1768 
    1769         if (!capable(CAP_SYS_ADMIN))
    1770                 return -EPERM;
    1771 
    1772         /* copy search header and buffer size */
    1773         if (copy_from_user(&args, uarg, sizeof(args)))
    1774                 return -EFAULT;
    1775 
    1776         buf_size = args.buf_size;
    1777 
    1778         /* limit result size to 16MB */
    1779         if (buf_size > buf_limit)
    1780                 buf_size = buf_limit;
    1781 
    1782         ret = search_ioctl(inode, &args.key, &buf_size,
    1783                            (char __user *)(&uarg->buf[0]));
    1784         if (ret == 0 && copy_to_user(&uarg->key, &args.key, sizeof(args.key)))
    1785                 ret = -EFAULT;
    1786         else if (ret == -EOVERFLOW &&
--> 1787                 copy_to_user(&uarg->buf_size, &buf_size, sizeof(buf_size)))

uarg->buf_size is a u64 but we are copying sizeof(unsigned long) bytes
so on 32 bit systems that's not enough.  It probably works fine on
little endian 32 bit systems, but on big endian 32 bit systems it won't.

    1788                 ret = -EFAULT;
    1789 
    1790         return ret;
    1791 }

regards,
dan carpenter
