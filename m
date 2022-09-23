Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A085E7E43
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Sep 2022 17:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbiIWPXR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Sep 2022 11:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbiIWPXG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Sep 2022 11:23:06 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF9414357F
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 08:22:52 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id o64so194063oib.12
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 08:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/LF8fXV+lJ2+xt84GMEYMXfBByMeKqQ8BDNt2N6935A=;
        b=3L2qKeBkS2jomnZO8ReZD+dVRBktDNNTbacEM36Jeg6ARRdO9JKlc3WrMxILMNf5ND
         uUZfPgOyYP0b0z/CU6ZA5xt4nbZ3Df/Rp1uz92vMKhdaShvWeXYUczHYVcyhvuYWWVNa
         jrg3Xxsvwbz+vnJuc8qapu7TpadhJyA6Dzsgx0veolfpBIj920jZDkVLtcKWYEmJIUoa
         6LyP4mlK4f87rmtjm7QWhGS+SP8vRVlx/HcaW5jGlPbDfQNOVCG08bsylLZM6NExZMNg
         tVDQf5JFfT8oEOZUyZJBcyDYr4jdFmIzISNyrj7JIoaCWinn2KH01euDwlf3OhjFgPk8
         GsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/LF8fXV+lJ2+xt84GMEYMXfBByMeKqQ8BDNt2N6935A=;
        b=HzlgAfao3ZGTcQHoe9KxPSVh09x7B4E9llWkuZ1PKyFBHvX9pchGSeTbeudqaN7FNM
         QuEd0UvN+5r82pPADPSCTUxRCTQZ4wsJromyIWv5V9yhXjWj4UfTme0+EGwok6nAq9AA
         7YHy6qsL6XrknuOrSFcPWcrRnKxCzoOVt+rQJ6MSJtS0++/YNdiJPAeHSCuD5GR9p/cL
         xIu3TEqvYLmzqBt5N75s8BwjRbmSWuc2hQqYL4Q/S/MCnEpUvnoIUKm1ygqV9LXAev9W
         S1HeL8UoinvKuDgkPqA79aUlkhViU6YwVgRgNhReT7nLkJ2SQIuE8fqBf6MEgG6niX+F
         7E/w==
X-Gm-Message-State: ACrzQf0r8rXY0pTL9lRIUJCCBLVGsD3ufx7Pd1Dp90b+R5fN9SHSLLth
        UOOJboqB+u1Z07IAMUuQGLe6IE8OIZ4UyBaPe6Hh68aKrbI=
X-Google-Smtp-Source: AMsMyM5mB/px+UPEENp2F/+eIdY9WrZB5LJWnU7jhnfWWHFXl3pePbIviNbvze495I0/yPHg/21ip0bIMx6eD8v3EI4=
X-Received: by 2002:a05:6808:14a:b0:34f:97d7:81e4 with SMTP id
 h10-20020a056808014a00b0034f97d781e4mr4234088oie.181.1663946570920; Fri, 23
 Sep 2022 08:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <Yy3I2J2MxTZQQNjs@kili>
In-Reply-To: <Yy3I2J2MxTZQQNjs@kili>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Fri, 23 Sep 2022 11:22:39 -0400
Message-ID: <CAEzrpqdVs6O5yHwwMxjvMfvNUWLt2QN=7dYGDVu8Gy1PEf=vsg@mail.gmail.com>
Subject: Re: [bug report] btrfs: make can_nocow_extent nowait compatible
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 23, 2022 at 10:55 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Josef Bacik,
>
> The patch 9ec9594f6de7: "btrfs: make can_nocow_extent nowait
> compatible" from Sep 12, 2022, leads to the following Smatch static
> checker warning:
>
>         fs/btrfs/extent-tree.c:2225 check_delayed_ref()
>         warn: refcount leak 'cur_trans->use_count.refs.counter': lines='2225'
>
> fs/btrfs/extent-tree.c
>     2193 static noinline int check_delayed_ref(struct btrfs_root *root,
>     2194                                       struct btrfs_path *path,
>     2195                                       u64 objectid, u64 offset, u64 bytenr)
>     2196 {
>     2197         struct btrfs_delayed_ref_head *head;
>     2198         struct btrfs_delayed_ref_node *ref;
>     2199         struct btrfs_delayed_data_ref *data_ref;
>     2200         struct btrfs_delayed_ref_root *delayed_refs;
>     2201         struct btrfs_transaction *cur_trans;
>     2202         struct rb_node *node;
>     2203         int ret = 0;
>     2204
>     2205         spin_lock(&root->fs_info->trans_lock);
>     2206         cur_trans = root->fs_info->running_transaction;
>     2207         if (cur_trans)
>     2208                 refcount_inc(&cur_trans->use_count);
>     2209         spin_unlock(&root->fs_info->trans_lock);
>     2210         if (!cur_trans)
>     2211                 return 0;
>     2212
>     2213         delayed_refs = &cur_trans->delayed_refs;
>     2214         spin_lock(&delayed_refs->lock);
>     2215         head = btrfs_find_delayed_ref_head(delayed_refs, bytenr);
>     2216         if (!head) {
>     2217                 spin_unlock(&delayed_refs->lock);
>     2218                 btrfs_put_transaction(cur_trans);
>     2219                 return 0;
>     2220         }
>     2221
>     2222         if (!mutex_trylock(&head->mutex)) {
>     2223                 if (path->nowait) {
>     2224                         spin_unlock(&delayed_refs->lock);
> --> 2225                         return -EAGAIN;
>
> Call btrfs_put_transaction(cur_trans); before returning?

Ah well that's pretty fucking cool Dan, nice catch.  Thanks,

Josef
