Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C235E589442
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Aug 2022 00:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbiHCWDh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 18:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbiHCWDg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 18:03:36 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B2E5C9FB
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Aug 2022 15:03:35 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gb36so8199254ejc.10
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Aug 2022 15:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xWvo1hXHcm4c74Fa6EiiDmZCWQLToep9LsievYqATlk=;
        b=glex+ulSc5pp/uo50vjjV6bOJCnWlEqFVycxULeTvgDGFPMwFfpGtUl7XdNTX54nlN
         8wU/mEqDdvnbqXA3hgum/EyTtvnG7BQR/5SGKzzDWwgcTLC4MFXaaW0GalZMaBIeDPfy
         di20YzSxZ3UBaLYjC3qdeUAottwXCpUmn0nUaUGA7TQVX+VHx6V2iez7p9nIS+OknYuC
         53lyi7SgD12YIKXlOd19sySnxaPpDWQOztKdGfcA6B9h6G2co1jDohIDsm2tTPHVyROb
         Y5b7r/vsQHZXGQKOBpOMGW8K8JkCoQv3hzQ1OVNIotPswRQjtFxWhJEMTKFA+mYkzDBQ
         Gi7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xWvo1hXHcm4c74Fa6EiiDmZCWQLToep9LsievYqATlk=;
        b=KiLrWz5vqe+lfMsLC3vzkYi4hUA/Cdt3UpsBy6Sg1mb7ViJVpnj+PYZ2TMvl60+ABG
         d4aa2PrNnZbRDftTUh3xGu/znlGpbf1eJHtSponiT0G9qQA0V9yhKRLnjuZ6miAoksJu
         D87W5Lk7g9iX0oVPWQ7d8epJ6S4GqZA3gMPQGAW7nySEGkIqik/9CgnDNMc5lSdt5bT0
         wFkWDBQ987DYr+wuL+UPJYYeWiWEfNrzuuQLxGRIpGgxhm1L5FZwcJ2nT41UCHf9oJ1g
         +X4HGDIlO2mc1IU0rSzuUr01St99YX0AtCbUWr9XJQJta7MOktsqckyyPZViYS4EeiZJ
         8KqA==
X-Gm-Message-State: AJIora+sdAA2jXmobZUbUvnZTJV4tuY6olWpD+yac5tSAQZc7M0xfgb4
        SPSJDeb7iIuoIfMvjjNE4K5B6eY9TYTiV4XQgJtMOuMs
X-Google-Smtp-Source: AGRyM1uK8gMg8sWOtJTZXHlkq/msdkd0+S/tCLYp+jPRglcCjnVJ77GPrQb3Oc24t6nyv3I6oALvdKRzaNuiM6oji44=
X-Received: by 2002:a17:906:5d08:b0:6ff:8ed:db63 with SMTP id
 g8-20020a1709065d0800b006ff08eddb63mr22200138ejt.408.1659564213683; Wed, 03
 Aug 2022 15:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHs_hg1NTbSsoev93y0Sx6NguVKndR+d410yZzbMhii2ipaBcQ@mail.gmail.com>
 <CAO1Y9wo_HcouRuOa8b7+2bXwZJOHNiy9PsxcYxsQAZ8ggvTxzw@mail.gmail.com>
In-Reply-To: <CAO1Y9wo_HcouRuOa8b7+2bXwZJOHNiy9PsxcYxsQAZ8ggvTxzw@mail.gmail.com>
From:   Martin <mbakiev@gmail.com>
Date:   Wed, 3 Aug 2022 16:02:57 -0600
Message-ID: <CAHs_hg3_KFLSC+kMpT+cbKuhUCJqwaYWcWL7R7Q1xT9_-xWvvw@mail.gmail.com>
Subject: Re: Balance fails with csum errors, but scrub passes without errors
To:     Thiago Ramon <thiagoramon@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> I've had similar issues. There's 2 general cases which you need to
> find and correct: actual csum errors on file data, and csum errors
> outside the file data (AFAIK only on compressed files).
> The first one is easier to spot by reading all files in the FS and
> logging anything that throws an IO error. Just running a find and
> cat'ing the files to /dev/null should do and list all errors, though
> you might prefer to use something more sophisticated to log and resume
> if you encounter any problems while doing it (might stumble on some
> kernel BUG while doing it).
> After you found all the actually damaged files and dealt with them
> (ddrescue or just deleting them), you are left with pretty much trying
> to balance, getting an error, finding the responsible file from the
> offset on the error message (it's the offset inside the block group
> being currently relocated) and then just defragging the file should be
> enough to clear the error. Then just resume the balance and continue
> on to the next one...

Do you have more information on how to figure out which files are
affected from the log error messages there?
Reading all the files first seems unnecessary if I can just use the
block group/offset to figure out the damaged files.
Using `find . -inum 257` points me to a file, but the entire file
reads just fine, so I suspect that's incorrect and has something to do
with the "root -9" part of the error message.
