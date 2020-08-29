Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12EE32563A4
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Aug 2020 02:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgH2AQo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Aug 2020 20:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgH2AQn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Aug 2020 20:16:43 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE65C061264
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Aug 2020 17:16:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id f7so676773wrw.1
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Aug 2020 17:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZQ6NNxK3jPOb158xfS82S8TM9mpcffnJsQo0a7lG6d8=;
        b=Rbejs1hgMj5W2fxtmKHdXlatUySiZNvVNc4bAL8VrgV8OFILNWriPzL1pygcvplNd3
         EzJn8xO6XjTLcVSyQX1vZw0cWAMYE8cAoynF9cAuOLTy/UvXDMqqp3Ww0ZO0k0wGempw
         QxSpNqJcQBOyvpZM8kcA9VYlf449vJ6vjjaKxD/7mO0aiyQCNW6LmSVZsVWmBpspa/j2
         Wsl2/JPDIpl7PArk6q6+P5qnJ5XqU1hjVqPOVNrIzMNnNuKq5OFy+m+Twxle9YKzREPZ
         A4bWn0Y1M40Ctv7YphXpNRGh45tIUiuWFwCYWw/ZE4xe2lQ2q4sM3Yjn9q5Ygur1galw
         UpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=ZQ6NNxK3jPOb158xfS82S8TM9mpcffnJsQo0a7lG6d8=;
        b=bReoN9Ipr6tkon0/ElWxOzEH3xLEHd7E7gSUDokqJHWdz+KQfIm9OrrfllH8hWlpBc
         3Pg7E88jHk5vOCyceQiuxOs2Edd1R8Una7GBPGUT8k5iQaU7W6f0+TF+jkyMnA8jERv+
         2cvkBJi0P1xi6VdCBOKIPlVQ7v+yRyb1CkXeGw9H06jAt0ejBvX+DA4i0SNI0/WBBYRG
         JdEzqtIFzE0FLHfufIKAzT82wogr5d0gw0PKmFmDpcWK+kk/893hf3HGhJMEpf4Jk4pf
         f7766XveAY+fEskEZ92wfw8oPKe5DVidbt1O25RlP6BCWLBlXcAO0GfHSSYNs65ADOTY
         4dfg==
X-Gm-Message-State: AOAM533A1CW8rjm6s9ToPxYNa/WoYn2qlQQdpK7vgXl4n2nuVlUKsHus
        5t3steGpq28avWtjDBNgYZE=
X-Google-Smtp-Source: ABdhPJx/8VWkU39wfgPDHdXTvqx9LgHidj0ydkROtCQHrdgQXg5KBH6NDxYy9e30cGXqND4Gt23URg==
X-Received: by 2002:adf:97dc:: with SMTP id t28mr1113481wrb.291.1598660202135;
        Fri, 28 Aug 2020 17:16:42 -0700 (PDT)
Received: from ?IPv6:2a02:8010:64ea:0:fad1:11ff:fead:57db? ([2a02:8010:64ea:0:fad1:11ff:fead:57db])
        by smtp.googlemail.com with ESMTPSA id d11sm1481566wrw.77.2020.08.28.17.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 17:16:41 -0700 (PDT)
Subject: Re: Optional case-insensitivity
To:     Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Chris Murphy <lists@colorremedies.com>
References: <CAEg-Je_Mhx2QewCvFbwcV5oVHHa9jkdPcpkFZN8YR_fktCHSCQ@mail.gmail.com>
From:   Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
 /dLFIhf2zxRylN1xq27M9P2t1xfQFocuYToPsVk=
Message-ID: <e5bce3b8-35f5-9c56-3abc-be4be33e875d@harmstone.com>
Date:   Sat, 29 Aug 2020 01:16:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAEg-Je_Mhx2QewCvFbwcV5oVHHa9jkdPcpkFZN8YR_fktCHSCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/8/20 8:43 pm, Neal Gompa wrote:
> Hey,
>
> So I saw today on LWN an article about ext4 gaining the ability to do
> per file/folder case-insensitivity[1]. I can see some value in this
> property existing for subvolume/folder/file level for Btrfs for things
> like Wine and Darling, which could take advantage of this to help
> support Windows and macOS applications that expect insensitivity to
> work properly. In particular, I'm looking at how games are glitchy
> with case sensitivity because it's rarely tested (both Windows and
> macOS are case-insensitive by default).
>
> Has anyone looked at what it would take to do this in Btrfs too?
>
> [1]: https://lwn.net/Articles/829737/
Hi Neal,

FWIW, I emulate the reverse of this, optional case-insensitity, in my Win=
dows
Btrfs driver, by using the xattr user.case_sensitive.

To do it properly, presumably all you'd need to do is add another DIR_IND=
EX/
DIR_ITEM pair to the inodes in question, though it'd imply another compat=
_ro
flag. I think it's something I've mentioned to Chris Mason before now.

Mark


