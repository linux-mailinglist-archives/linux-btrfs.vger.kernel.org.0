Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEE269B1BD
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Feb 2023 18:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjBQRZp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Feb 2023 12:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjBQRZo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Feb 2023 12:25:44 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BE7718C1
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 09:25:33 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id y29so2248891lfj.12
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 09:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UGTMquXtO9yteQ7zo/R05uu5C04G58xlltOyyuR4Gdg=;
        b=WnvjSgwvXhiA1gxxVQzh+plZmLCtmFCTErgZeTnCTpS+xgr7yynBSk3GfC+5TjtLht
         oB9QRcA2OKwo4DseUBeV7tt5oaUNF08FoXHBJNyW4AFrzAK5y1vvvGUmoNOo11klAxEU
         MlkHgKK4OVqdQF7NKyZlfoIryDx+P3YW87BGtSIOaYyWNx4jQEut421W6MVB3IyVZhYZ
         4ai9ttTZ69dD/aWZ66qNHhXuZPBzhO9QBJzlJBZQbXWOFxE3F7kfILxBBcOT7a5CM1Fv
         Idei4SAFu/o85fh4iXWVmTPL6jHA0hb+U1DFJrk/t8z/4nGUSS6RDfMRzbX2+2ZURo2p
         iSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UGTMquXtO9yteQ7zo/R05uu5C04G58xlltOyyuR4Gdg=;
        b=Ig3q/v6HPlIpsyQXjQuajtmvULuPsma6g54OdzwDWU+pIj+eVhWQsH0/RTbc6P8GCE
         qxeoVVPxYV2ZNKjpl0LiHqotDQggepxB2yVkEFW1A8TVB5+7MtdI5FniXFZx+3zbONL5
         Y8Vi0HpEWC2MS7MevR4CF7LVVOmDhUFzAnIu3UxuMSs9aWJShrEjmYKk2upNhEDBtKJX
         dBr7l/Otf8BsA9Jv/h/9q4A26hR17WErWQdohoCj6JwsZHD14ZltrWrrhH+GolWjVWw/
         uQC42kecek32cYHQkHpLxp/EhLYlThbkWgfrrSmtAQILW7hpkfcND6XjQkbmwpU+KfSJ
         Mvag==
X-Gm-Message-State: AO0yUKUu8VELUhJRg9++CIxsXxoMYfhhPhXsur3kEmcZPJjEP8sxcCBQ
        BqSja9/AZ9qj2oJ6d26LNfNMFEWRzYE=
X-Google-Smtp-Source: AK7set+Oz+YWRCCfqvxd7d8tz0BcHFSZSXEcd5IdWNrDf0z/MSNElaL1rUfCqDavIr0U+Bo3g8bdmg==
X-Received: by 2002:ac2:544e:0:b0:4d0:e044:f865 with SMTP id d14-20020ac2544e000000b004d0e044f865mr582717lfn.6.1676654731926;
        Fri, 17 Feb 2023 09:25:31 -0800 (PST)
Received: from ?IPV6:2a00:1370:8182:1876:1305:9f91:d3c5:cac1? ([2a00:1370:8182:1876:1305:9f91:d3c5:cac1])
        by smtp.gmail.com with ESMTPSA id t12-20020a19ad0c000000b004db1afe388asm727912lfc.163.2023.02.17.09.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 09:25:31 -0800 (PST)
Message-ID: <c0e00d00-20ff-642f-bbfd-ecbd17669502@gmail.com>
Date:   Fri, 17 Feb 2023 20:25:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: back&forth send/receiving?
Content-Language: en-US
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     linux-btrfs@vger.kernel.org
References: <10fd619ccbe568df4344b6b1d93f061bc493d396.camel@scientia.org>
 <9a49ccb8-9728-029f-be0e-75ccb8e211d0@gmail.com>
 <3c77c6306ece13559de514940074ac70b4fc882a.camel@scientia.org>
 <a134a22a-80f2-91a5-f0a1-21145c487118@gmail.com>
 <bcb9bfe78715e98ea758df3723daa8f9afb2f20a.camel@scientia.org>
 <CAA91j0XNV68cuVmue7tuQDMZv7NirwWiJp1ntb1B9fKoSMKt-g@mail.gmail.com>
 <d02fb95aecf51439c7784c990784f73a11412e4b.camel@scientia.org>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <d02fb95aecf51439c7784c990784f73a11412e4b.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17.02.2023 20:12, Christoph Anton Mitterer wrote:
> ~/mnt/master# btrfs send snap-1 | /usr/bin/time -v btrfs receive ~/mnt/copy1/
> ~/mnt/master# btrfs send snap-1 | /usr/bin/time -v btrfs receive ~/mnt/copy2/
> ~/mnt/master# btrfs subvolume snapshot -r data/ snap-2
> Create a readonly snapshot of 'data/' in './snap-2'
> ~/mnt/master# btrfs send -p snap-1 snap-2 | /usr/bin/time -v btrfs receive ~/mnt/copy1/
> ~/mnt/master# btrfs send -p snap-1 snap-2 | /usr/bin/time -v btrfs receive ~/mnt/copy2/

So copy1 and copy2 are identical. This is not what you said earlier (at 
least, it is not how what you said earlier sounded).

Of course you can use either of them and continue incremental chain on 
another.
...
> 
> They may or may not be.
> Sometimes, I just send the same snapshot (e.g. from some specific date)
> to all copyN ... sometimes the most recent one of all of them is
> different.
> 

So are all copyN identical or not?

> But I always keep on (old) master the snapshot that are most recent on
> each of copyN, so that I can continue from there, when I do the next
> round of snapshot.
> 

It does not matter what you keep on old master because old master is 
gone. What matter is what you keep on each copyN.

