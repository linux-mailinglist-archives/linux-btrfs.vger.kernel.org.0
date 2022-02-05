Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7524AAB12
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Feb 2022 19:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381024AbiBESut (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Feb 2022 13:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381022AbiBESut (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Feb 2022 13:50:49 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B21DC061348;
        Sat,  5 Feb 2022 10:50:49 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id bi36so5611326vkb.10;
        Sat, 05 Feb 2022 10:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iPSHCX7dPPAlJeiOKsxSML+ZX7Yf67krbPj9jJKUbQY=;
        b=XSg5aUz0AAkPmKRW7Xk+rjsNsh/PZi3ow1l5w2x2n5bmDmOkRVwUrxx3Gm0WNC3+z/
         onTuNJL2wsu7LtenlQf//3XM2YQ449Wdhr+McF8TzAE+m9zGJDW/m5VRjSAsj3uvmqBN
         Khqw9FtjCD11jJI0TFAWWXNAT5vtJYJoe07oihT3j2tuNLhKke21SHy8/8Ri8FEMhrYd
         Pzj/uYWFz4cHp/qtx701n+1eNWJczA6l8QRVhEchfV2KEA6O7m8M3q5PKIuDnvN3Re45
         0VrJcRB9749lu2Ab6Wfic4UcjO7/NiB4iegQD5E7/uAVz0LJDLFhMaxAUdo0+LoNqi6G
         SpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPSHCX7dPPAlJeiOKsxSML+ZX7Yf67krbPj9jJKUbQY=;
        b=wKZrHY1WlZohCmcqDFQlVqC++4/gqXdmMdZ/3yI2uRX2UnZ9kca+DqZiH0J9ydvDU7
         9rH7DhNHf8Yf1leQoIzbSBPCOGzGUi1i/HUQlokV7n+tbln3kHu5f4U2xWs4q3BlkuEN
         5TUEIxEHX46h1wrpLnZWv9ILPE+XsjnLnxv5a1ZeGoeBBtn/ZRf9ycfD0ETbqToZztE9
         8Z43RdnSJMes0EpTsCjsL422lAyTo+MCTH2fFxx96+jnLsyadBjEjkr3sqnHlqDamHVR
         XuZrgu9yOUPHgF+HPMYbkej8sK2jDSUgB8urBXf09SQgnFJpemfND7nLAtkHpx839HNn
         jYHA==
X-Gm-Message-State: AOAM533ST0ClAT5c03LIV8JRLh61zlxzjwylY8yNk/KYsDWWPyf6AI7x
        pL1GyR9tVxjrZ8MBeF4ZB5/tX/1NalJeUJ3JZylrstIpUtt8Nw==
X-Google-Smtp-Source: ABdhPJxtFadFsmu58zM722xXIDt+AMPMBkN3QRGnQ4sF4wLnXYVFMD6YobBLCZoK+NlaYXk5xyEJvEUiFXrlqVo6mLc=
X-Received: by 2002:a05:6122:91b:: with SMTP id j27mr3061280vka.32.1644087048090;
 Sat, 05 Feb 2022 10:50:48 -0800 (PST)
MIME-Version: 1.0
References: <20220202201437.7718-1-davispuh@gmail.com> <20220205013606.532212-1-davispuh@gmail.com>
In-Reply-To: <20220205013606.532212-1-davispuh@gmail.com>
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Sat, 5 Feb 2022 20:50:37 +0200
Message-ID: <CAOE4rSxCxGMNx1+0NRzMpY1Jhz61E+YOmqUhz58Ds91me1ZCAA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: send: in case of IO error log it
To:     BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index d8ccb62aa7d2..a1fd449a5ecc 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -5000,6 +5000,8 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
>                         if (!PageUptodate(page)) {
>                                 unlock_page(page);
>                                 put_page(page);
> +                               btrfs_err(fs_info, "send: IO error at offset=%llu for inode=%llu root=%llu",
> +                                       page_offset(page), sctx->cur_ino, sctx->send_root->root_key.objectid);

Thought more about this and I'm guessing using page after put_page is
probably wrong but it did work fine. Submitted v3.
