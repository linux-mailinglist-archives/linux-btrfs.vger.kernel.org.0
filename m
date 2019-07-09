Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C948763916
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2019 18:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfGIQKe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Jul 2019 12:10:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41497 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfGIQKe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Jul 2019 12:10:34 -0400
Received: by mail-pl1-f194.google.com with SMTP id m9so6649927pls.8;
        Tue, 09 Jul 2019 09:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Sg8Y/+nJCqL5nneX2knQ5cyB6HIpIg84jtKACGxUrtw=;
        b=hac0RIVrFQWNBa7HyDu3rESY+4QAmgxOZDpne12VkNC2JObfBJGw36vTlr+lEnPSQB
         2Wb+y3VrIKcvyzxXb7qRITLG546QEqXnc5retHQ+rIWq21lVxTb6XXRxo3oM6NA4Jtez
         utAx29+Pgy9BSI2mo7gqC5lVKYAxWsP3IpiWkVA5ENyf47Q3w+rrtN+CCQhiNyANXZLP
         GIDEhvxGpO1h9IKl9XcNK8rRHOJ6MDl8Owe7Imy/TuQtwdTUGu5WYa5caSIs+5eTyBSS
         uQ2UOc0Lo7yhl08iWaXw4DEvcNR9Z2Zf3YqCTeIZjn+4HPCOoxR7nXBfhgTir9k3H/nY
         vs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sg8Y/+nJCqL5nneX2knQ5cyB6HIpIg84jtKACGxUrtw=;
        b=Zu1NgcZmTZa2Uo1S4taymuFK2uJqTFycqv87pIaca0QnPBWEOWLXzhfV1/ojwMbWfx
         AY0kS+muxGG2a4SdbEU+cf7EueyEq1i+iiVwNNGM9Yu0uPcBw4Q4bCLGcB6Mv+hJXHP1
         KIz7OiEKDIy1XhZI9RpY9kOP96oXPVd+wcJnnWtbBN/iCEyRzm1/ZJISHn/PNBGLvDWF
         o4VhE1sR2MpoV9DBX4CTI05Vo/VcjKJNbRWxw2Hv4pvxZqUTtsGCxffFFanYKJ9mmFZJ
         8qhXqNDRpCNeIqCytCHPI37vj5bfnE2Lo2Q1wp+kt/GBfW7V3UEs6Jn5xBim4m9Wgg7+
         Q5aA==
X-Gm-Message-State: APjAAAWDXG/r8h+RJ06BFNtOZ73H83C7DKOUvA7Pzt6ueLTNpBKXo1+v
        Zfus4wIy1h7zFTvq5DJLrJEMlwb1
X-Google-Smtp-Source: APXvYqwVCKjVczwu6Z4CpF0VZnh+8Dmbi51CLTfiYlVD+b4tl0+NtgaI7USMXSMQt3RuERkP1h5DlA==
X-Received: by 2002:a17:902:f01:: with SMTP id 1mr33110232ply.170.1562688633691;
        Tue, 09 Jul 2019 09:10:33 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u6sm2967708pjx.23.2019.07.09.09.10.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 09:10:32 -0700 (PDT)
Date:   Tue, 9 Jul 2019 09:10:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH -next] btrfs: Select LIBCRC32C again
Message-ID: <20190709161031.GA7703@roeck-us.net>
References: <1562593403-19545-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562593403-19545-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 08, 2019 at 06:43:23AM -0700, Guenter Roeck wrote:
> With CONFIG_BTRFS_FS=y and CONFIG_CRYPTO_CRC32C=m, we get:
> 
> fs/btrfs/super.o: In function `btrfs_mount_root':
> fs/btrfs/super.c:1557: undefined reference to `crc32c_impl'
> fs/btrfs/super.o: In function `btrfs_print_mod_info':
> fs/btrfs/super.c:2348: undefined reference to `crc32c_impl'
> fs/btrfs/extent-tree.o: In function `btrfs_crc32c':
> fs/btrfs/ctree.h:2609: undefined reference to `crc32c'
> fs/btrfs/ctree.h:2609: undefined reference to `crc32c'
> fs/btrfs/ctree.h:2609: undefined reference to `crc32c'
> fs/btrfs/dir-item.o: In function `btrfs_name_hash':
> fs/btrfs/ctree.h:2619: undefined reference to `crc32c'
> fs/btrfs/ctree.h:2619: undefined reference to `crc32c'
> 
> and more.
> 
> Note that the comment in the offending commit "The module dependency on
> crc32c is preserved via MODULE_SOFTDEP("pre: crc32c"), which was previously
> provided by LIBCRC32C config option doing the same." is wrong, since it
> permits CONFIG_BTRFS_FS=y in combination with CONFIG_CRYPTO_CRC32C=m.
> 

Meh, that should have been CONFIG_LIBCRC32C=m. Sorry for the confusion.

Anyway, I'll select CONFIG_LIBCRC32C=y in conjunction with CONFIG_BTRFS_FS=y
in my own build/boot tests going forward. That won't fix the problem, but
it will avoid loss of test coverage.

Guenter

> Cc: David Sterba <dsterba@suse.com>
> Fixes: d5178578bcd4 ("btrfs: directly call into crypto framework for checksumming")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  fs/btrfs/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
> index 212b4a854f2c..4c80c70597f9 100644
> --- a/fs/btrfs/Kconfig
> +++ b/fs/btrfs/Kconfig
> @@ -2,6 +2,7 @@
>  
>  config BTRFS_FS
>  	tristate "Btrfs filesystem support"
> +	select LIBCRC32C
>  	select CRYPTO
>  	select CRYPTO_CRC32C
>  	select ZLIB_INFLATE
> -- 
> 2.7.4
> 
