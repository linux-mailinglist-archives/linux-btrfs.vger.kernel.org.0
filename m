Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABDAD13BF06
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 12:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgAOLzy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 06:55:54 -0500
Received: from zaphod.cobb.me.uk ([213.138.97.131]:49038 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbgAOLzy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 06:55:54 -0500
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id BBF229C3EA; Wed, 15 Jan 2020 11:55:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1579089352;
        bh=CEsbbi+aBnmj2gcw9GXONVHbNP0o5WPVik2GkarjLac=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UhmGAxaX2iZZtEngiMhJ+IhRuaQY44bJ5ZAwoU87hxBUFR/+jQPhYpkwI3UgKdJWe
         tfVxY/owlNdjAynj4XJDWmWyOiSrzuB8JJfGNxcA9dCneiJ9NSSK/IxKp2IMwMWKvq
         FfDCb58iN1NjSY1/oeYS+Sgl2VtUTYOCVbwoHYXr3NG8FN1UBWJMg9jzYxMoq760q1
         I8Tskq5BOJo2AGI/TMcSkONCznOpUkcRj10MzPtbHzRyspkX9axuajc7Lwx3XfaPVT
         3Bapu7ynPclt8VYuob6h+/nmmg1aJuBpxhS+FsyngaWlJO7nzcUlFxhtUhk46f55TV
         exGRCO2sRcoVw==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 65E1A9C307;
        Wed, 15 Jan 2020 11:55:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1579089348;
        bh=CEsbbi+aBnmj2gcw9GXONVHbNP0o5WPVik2GkarjLac=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sZQwooDCs0aXSDj8+QrSzO7bjE6a/IbIHe70jMynbQrOEyqxO2+RBneSYfC2xoCno
         B+TnGnCEEjSOZ48vIt34QyKLP63nrnmKTqkecqZLyyMGfR7lDH98blwlGSERl/3Jri
         2TwioNsRjvVjBqOJWhHchDrkJlsO4CdLcGhyZ0WfTJ8jsiaLYXzVU2BqxCFD9UV9YE
         pqz5s+U9cGtX0Bucg1ERtvDa1Ht8PkK240N448hv+pGr2sBJnQ76+NGAmmjfCnJqWA
         QEIrRhbyV8w0mEbZCqdTivo3Pg9CVxeSdNmto+xZqa9IBFvk2BB/u8xF8hXdrBq0Ys
         Omuq2aGAdk+iw==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 131A9A2F20;
        Wed, 15 Jan 2020 11:55:48 +0000 (GMT)
Subject: Re: Scrub resume regression
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        =?UTF-8?Q?Sebastian_D=c3=b6ring?= <moralapostel@gmail.com>
References: <d0a97688-78be-08de-ca7d-bcb4c7fb397e@cobb.uk.net>
 <CAL3q7H7ERYHeKPsQcyT05A=rgY7QJcgDhhnSFjmFfbKMfam_hg@mail.gmail.com>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <26efdad1-cd74-d93e-23c1-1915b2d9c8d0@cobb.uk.net>
Date:   Wed, 15 Jan 2020 11:55:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H7ERYHeKPsQcyT05A=rgY7QJcgDhhnSFjmFfbKMfam_hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/01/2020 09:33, Filipe Manana wrote:
> On Wed, Jan 15, 2020 at 9:04 AM Graham Cobb <g.btrfs@cobb.uk.net> wrote:
>>
>> OK, I have bisected the problem with scrub resume being broken by the
>> scrub ioctl ABI being changed.
[snip]
> 
> Try this:
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 3a4bd5cd67fa..611dfe8cdbb1 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4253,8 +4253,10 @@ static long btrfs_ioctl_scrub(struct file
> *file, void __user *arg)
>                               &sa->progress, sa->flags & BTRFS_SCRUB_READONLY,
>                               0);
> 
> -       if (ret == 0 && copy_to_user(arg, sa, sizeof(*sa)))
> -               ret = -EFAULT;
> +       if (copy_to_user(arg, sa, sizeof(*sa))) {
> +               if (!ret)
> +                       ret = -EFAULT;
> +       }
> 
>         if (!(sa->flags & BTRFS_SCRUB_READONLY))
>                 mnt_drop_write_file(file);
> 
> I'll later send a patch with a changelog to the list.
> Thanks.

Thanks Filipe. I have tested that the patch builds and works with my
reproducer on a 5.4 kernel.

Later I will build a distro kernel with the patch and try my monthly
scrub-with-interruptions script. That will take a day or two.


