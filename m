Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203255BBAF4
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Sep 2022 01:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiIQXJw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Sep 2022 19:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIQXJu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Sep 2022 19:09:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D38B13EBD
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Sep 2022 16:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663456184;
        bh=MY5qgnbzSXu5w6mercQK36b0ceHLvFXkqHCzLWnoxCE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=cG2aRFuaQDQevT5m3jkcfv3YYpj04Iw4TH5f9meNehQTC9zqAGg1V76lV1LXcXKWR
         +bcN9k7Bm7jlKcS4e+RrXzh7o/72EU88fNVWOJuXZ4DPbfQOfBcWkr4KlEEYdJXD5b
         2AyJBVvjK3oFhT47UwHTrfMtgkyDJWlK08l7RrhA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MkHMP-1p2k9h02uH-00kdm2; Sun, 18
 Sep 2022 01:09:44 +0200
Message-ID: <2c2fae28-c96a-c80d-f014-ba975c43057a@gmx.com>
Date:   Sun, 18 Sep 2022 07:09:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: Help w/ Parent transid verify failed
To:     Brian Clark <bsclark75@gmail.com>, linux-btrfs@vger.kernel.org
References: <CADQkWYDMLfAi+XVNrXJYjUV1iS7Uj8zLs5L2XNGiQBSTYM0K2Q@mail.gmail.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CADQkWYDMLfAi+XVNrXJYjUV1iS7Uj8zLs5L2XNGiQBSTYM0K2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hheOWSxeV+ej8nXsO3tAL/zz1bBZof/38k8qzGn7vFmCk+ugFtO
 6c5R1obRt+t4zjq4HCAM2y4yxnE96ATxMGsxpcTLRV504/1j/65qadJmsWeYDCy+TjtYzQi
 NwcYHaHWGV059nqDH1adfxb/i96Vq3sSXYM2eR4j8lSleQogjv/JTCTNXdhBEiBx3c0Fgwc
 IXfH2BsH3Lls48tuXBEVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6lkNRHzGBfo=:oDXn6nnax/hz4M+qg30dE1
 9vN15YaWHsZe6V0+8jiNpP0/Fl4x4m+ZffjYq5y2iN5nNGEmn7l77vHhcBbqgE2c+hDvkEveG
 AptlpNnxGOi+2mIMAVYQL7ScJRPYh/XBUai9ZzWdr5nAbzr6BBy9IE77NOl4vJ+xzn0W0zyDT
 rhFKVcHX2SMm5zAyOB07XIWeFfWUyomAH1WcYn/0uSb1izTWxOyWMLX9touNZ6nclpir0lAbh
 pVlu78+EhKj0GKPg80g9caCT0PEh8XttMJAT1qNXed1uatuS1KL5x1PW1dIZILNoJvfOheUgl
 h0ObRytKxQUnsdovEzvFq90U/F6E99ICfVnwIEpl6CBxtRktNPbor6F8KIl/Jk1igUrhNho8r
 y8E329xBAUEHHc8HE+dvqfYS1IkZ/RPCeOqkJggEmTFBkXEotb5d6YrpogqTB09kTqwE2jqWm
 hUZsHYQk8znUn0X1L+bSEaPDaRjLze95DJ+FkTTB5+HiFaT1zg1o7NqNdcBGW+vG53vxg+Cgu
 sb7BnNGAWWO/n2gJ6n5vjlfVUxqts3UtYvdWPtvn8xHacf3axVkr6eXq57ReLR2r/CH/JsNDj
 gq58KTh4PgjYOYzhSZuT0wqqKS+WsFidd9M+4Mjimt/Y7oZ6nNYLw/jFT6Cj12tHOkVLGDu0R
 LuBJtDQJwxF29FXESrLILqmzyxrfnuaCcdeZayVGk7tKOoQOxMu1V4ndl0PQKXc89NoxiET2q
 XamiU9KMJ+k2gLwWz+evkiKkHd2kW7Z7TEwA7MUd0qlGMeyH2Wqoyw7qPDravIMVopZcufj8Y
 sHyFzFqAAnPOJwyuGn4jZuTRqmSI2jD5bKuHfWLmoulY+diwmZ3lBqsdG5Kx5Q3MMCWFn8woy
 P8L4Rzb1A0BaVIjBzDx7rI2INc0b/5BGXNiPnncAHRLZAkLWstHNICzL3GxklgCMX0CgCMMPb
 /eX1Lw9jRDB6fwsusXT5SRyi+nFJkb6xvRWsVVfaNizIzEU8GPLYHTvKghklmCA4B+F2KVfYe
 8R+TfK+6SXICX5x6+azOjZm/BUguM5C3Y8pTpeSXbkNY2e0HFlVJmvzkjsGOfGIbgQAWrhrIF
 UCpGdZq5hZvQw5wNTEncW6F4g7dZrW/3zg1MLjwfLI2fv8gzASQHtX/LPYnUWMAcFpPxhdcQs
 3l4cESP0kaSnYKl3RxtXFegEQ1
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/18 05:32, Brian Clark wrote:
> Hello,
>
> I have a Fedora 36 Workstation running as a VirtualBox.  This evening
> I started it up to the error above and is now sitting at an emergency
> boot prompt.  I am going to have to type some of the needed
> information because the trouble system is not booted far enough to
> allow copy/paste.

LiveCD and btrfs check please.

>
> Linux Fedora 5.17.5-300.fc36.x86_64  ...
> btrfs-progs v5.16.2
> Label: 'fedora-LIVE' uuid:  ...
>       Total device 1 FS size 5.1 GB
>      devid 1 39GB used 6.52 GB path /dev/sda2
>       unable to mount device to get output
>
> Any help would be appreciated to recover the data.

Normally you'd want to try "mount -o rescue=3Dall,ro" then backup data.

But I'm more interested in how we got into this situation.
Any history on the VM and host?

Thanks,
Qu

>
> Thanks in advance,
>
> Brian S. Clark
