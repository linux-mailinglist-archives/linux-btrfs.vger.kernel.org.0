Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFE91B992E
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Apr 2020 10:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgD0IAf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Apr 2020 04:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgD0IAf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Apr 2020 04:00:35 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D0DC061A0F
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Apr 2020 01:00:34 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id e26so18452028wmk.5
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Apr 2020 01:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2qx4yUZh98M5GP4MVl19+zUtnFXdQihiGtvPVCAuRds=;
        b=GufE6Edn3+TOpCoEKTJgOLLY2TbijAxcWqzmnwmzDyr4a/SQzXssvUVxKf4+ZJsL48
         fj5cu9D7RyAr9Id9IKrst9TpRfj4XgEGXOjFFl6uGcSXoEqzBeYEV5n/KXN4vqR6khqL
         myslU724KYtyLniK3BbFGz+Nc9CLdc6tL0HWP7zA62BxJm69Df/Dn0kQUnahFMAvxmQf
         Y3jt8DwQgzt5nrFV1VgAMS44lFStcGY2gzbTL/WIBTO7p4CefX3DidFSo8R+i3b6e0+v
         WPugqs68jHppxHuup8x+0b9Wh+PijSfR1FuPMCoYVpTcl6ua+vuJMoqpieC8UHGpE/p9
         IKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=2qx4yUZh98M5GP4MVl19+zUtnFXdQihiGtvPVCAuRds=;
        b=IROCgHEw5G1JLbItquPUC1iAVXaORm9wlBHFtiRM/CaIQkbSNLn67bDHgCyq0LuxZk
         rB7ieBqXTw7ddXCA85Q8kGwISbkNUEdWqjxGzQPrDzmQ5ZiD3u8BNk2tJHY8fMzvWue2
         zeizkgHKtz3pt5tcYUt19lZ05o64yeaE8pq4n9AChReWC3c99yAX0xIF4Owow1D3QsGK
         KLkWA7groHQetOrlwg/TfwIwvF1JXtlYwq6aACUcfmWlcBmv3jGVtlgUeEHFpmt4+Qrm
         J8vWwIBv7G/iFyuN0sH3+2BVNpMIjpj6POe1mp7zzUJjHgMzKZ+J99EmDiRL/omLUQMO
         zF5g==
X-Gm-Message-State: AGi0Pub6YGVh+K83CW3Qqu638VM8hugRZ9lcxk7VTA0Jz1qzIWKgiegD
        3H2pDDH94AtkB2mCjswmqL4=
X-Google-Smtp-Source: APiQypLNBIPn/+WL8sje2JULkS8SMtLztVMCjpvvTNPToMRPHIhl/zh42k8Bg/7cmZcVaZ+RU3TF4w==
X-Received: by 2002:a05:600c:4401:: with SMTP id u1mr24327030wmn.31.1587974433565;
        Mon, 27 Apr 2020 01:00:33 -0700 (PDT)
Received: from ?IPv6:2a02:8010:64ea:0:fad1:11ff:fead:57db? ([2a02:8010:64ea:0:fad1:11ff:fead:57db])
        by smtp.googlemail.com with ESMTPSA id l5sm19783894wrm.66.2020.04.27.01.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 01:00:32 -0700 (PDT)
Subject: Re: Btrfs native encryption
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
References: <CAEg-Je8zM4xq7GEG+cphKkR6wjquwG3jv9bbJ88chzrZUEzuYg@mail.gmail.com>
 <59e1e1e4-b856-8784-3c4d-3fbd7a724cf8@suse.com>
 <7512bb89-65b1-edcb-9572-6afa2e07fd2e@harmstone.com>
 <CAJCQCtRbSyoRy+mb-bqvqWqOuNs+81xfuqMyGgQnwtuFm9TjZQ@mail.gmail.com>
From:   Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
 /dLFIhf2zxRylN1xq27M9P2t1xfQFocuYToPsVk=
Message-ID: <a0d275d3-9004-6d1a-66e0-0c1a4b31d6c1@harmstone.com>
Date:   Mon, 27 Apr 2020 09:00:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtRbSyoRy+mb-bqvqWqOuNs+81xfuqMyGgQnwtuFm9TjZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fair enough. I imagine the intersection of "people who know about filesys=
tems" and "people who know about crypto" is pretty small anyway.

There were solid reasons why fscrypt wasn't feasible - IIRC, it was becau=
se the XTS scheme that it uses ties a block's encryption to its physical =
location on disk, which breaks balancing. You could use the logical locat=
ion within the file instead, but that's horrendously insecure (all files =
with the same cleartext would have the same ciphertext).

My version gets round this by randomizing the initialization vector whene=
ver an extent is created, and storing this with the metadata. It also wor=
ks with reflink copies - there's no reason why you can't do this with enc=
rypted files.

Omar, or whoever, is there anything I can do to speed this along? I was c=
areful not to repeat the mistakes that other people here have made while =
tackling the same issue previously, so it'd be a shame to let it go to wa=
ste.

On 27/4/20 5:49 am, Chris Murphy wrote:
> On Sun, Apr 26, 2020 at 8:25 AM Mark Harmstone <mark@harmstone.com> wro=
te:
>> Last thing I heard was that Omar Sandoval at Facebook was looking into=
 it. I never heard anything back about my patches, though.
> I think the biggest difficulty with that patchset isn't as much the
> patchset, but the bandwidth of people who can review it. It was a
> complex patchset and didn't use fscrypt. (For reasons that are
> explained, but then also at least originally the Btrfs maintainers
> wanted to initially implement an fscrypt/VFS approach. Maybe it's too
> difficult.)
>
> I'm curious whether Omar is working on something and what the time
> frame could plausibly be. In the meantime, other approaches are being
> explored, based on LUKS encrypted loop mounted files, as in
> https://systemd.io/HOME_DIRECTORY/
>
> Btrfs has advantages here, including asynd discards and online fs
> resize, in case someone wants to attempt to manage the ensuing fantasy
> of sparse backing files. The loss of dedup and reflink doesn't seem to
> be a problem because it can't be done with encrypted extents anyway.
>


