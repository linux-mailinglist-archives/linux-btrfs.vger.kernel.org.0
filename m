Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3B46FBC53
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 03:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjEIBIj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 21:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjEIBIi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 21:08:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF84D19BB
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 18:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1683594514; i=quwenruo.btrfs@gmx.com;
        bh=EfnF5QR15sr/2YWI7ttwDI4cBoweqRoPWp45zkHB8RA=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=aTFpQwTY+a9AMxHXvOQ5rNf2TrbRqMl9CKuLkYlOyhe7Eno3eJsPLDNwlV03qIJZT
         0EPkw7BQx61Y5DpKlcy91AGKIazff3HEsuuqmuP4N/WO1epxS+AuV09KIsoQgr7IQd
         loGytAdzhIu3ZUdDEL0fEvxn7aPZjDeQ/s9MKTwtsc9eXz1jzqIBbmB8K37+915MpE
         iZ8+BZeE6kys3bli5wzA67cw/1PIlN5/+IXD3uce/VPnj4WayD55eq6qGyS9NPTuyv
         MF/WvxZAfLHdUb9ShoxwyG5r4K4DbjHuwOLyGxd3bai8EVeVjtmn6BMHFJVJ44iZ8x
         JyxvQqIKArb0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0oBx-1qA7im3sfd-00wpx7; Tue, 09
 May 2023 03:08:34 +0200
Message-ID: <d886e19b-524e-1cc8-a7ff-9c78b2c1c75b@gmx.com>
Date:   Tue, 9 May 2023 09:08:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: Errors detected
Content-Language: en-US
To:     COCK MAN <cockmanp5@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAKoLycBDazNXxD4j1epxwOMp2yb23EQowuT+ZWSK4c8kT5b4pQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAKoLycBDazNXxD4j1epxwOMp2yb23EQowuT+ZWSK4c8kT5b4pQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fRCvjtI+ZsqUfhFwJ9LeXGFlB9LWNzvx7+AiGLwNCoTM0DfE0hR
 fjMXHZElEydUSBwZ5hnpk19pLeopDcXrx9RKU0ZWqNa/+daxkjxgqCP3PQb6aZgw3DJ3J0K
 sQarH1vf/r5GzKg6X0/ECzlgktcM3dXKbSbYPonF8BlWb8F0oj68fifsdHuTcdMqitjVDEH
 VzVoYgn5brJ/P8iyTju5A==
UI-OutboundReport: notjunk:1;M01:P0:w4ldDhR/+aI=;mYXVhjZ838I/Qum6tqiV+SDdjPH
 FEb24KGVzUYtXZ8Dp24N0dNfemceQSyRpK6YNunL75/HMGBXaBNtQM4wYswrjYz7hThGE7Tex
 YvlzPgF5RjDWDwvqWr3e/Tz4sY8+gOzkTyr/bcJH9WpjPkIDDH7smEbGjS2AWDumnRjZd1geU
 sIhc8F7yRa76iwcMDQYyvqgBAn5vVwuISv6QVljJmvM//656pP8v2P6xwTs3J+ihesIATnGl5
 1K7GQxfYiIEraIhYf70ZrfFSBSLRyuqDfJThRjPdhhyMx/EEuDCeJfjn4fDAYzMA2CyoFtyzf
 NFyWK9v9GJy95TFGEK9wFr9ATHtlH/d1zgKQw/KUZ8k3RYWMCz6bJAL5Cgu+iSye4nx+ZMKyh
 1GX0VIjrW+DlnmwUGUkkksedXZN55iyDGOU7FJSp5iCe9gzyGRhu5VW550zOT65jTxThzQb0N
 f3m+UT2LFzuM6JyXdGYVk5VKdhPUfHOObBN//i9+OCT8b0o5oUpU+N6DKU3eQf9Y1FpNA9Rv3
 BaUU/DFcCkEI/hyQV+VE4CJdkPVvTDbHljeAJQvX6u1BJDIi0JC74o4fFLApGLyhsOXWDIfvF
 MH8LMNJeGKWr6I/MDVGBbrf7ONQIFyIkz+sE+d8ddcBqnj4IwO82dv8/2T9VZJk03PD2v4O2E
 NDLZT6QBQ4AGxHNGWR8dzauO8FJOWi4nIn3cf1zGRtnAcWuF2sd1E4IXLaKZ48VXVRLc+H9hr
 AF8RGsNTMlwsszFEVAIBeeuDcS6iW+BipRsRbw0gxnaAqYuVHRSJWKK4iML9IlVKW6IrcPwV3
 OVbAQM8o9PJRDpVL/ZpcOW8/fXdTx/mTKjvKCjBpYzOCioP4JAQ8gtvtPIoctZ1zdMLTbLped
 G4t8BizT+qJRy9eZbv1Vr+AGjm82LxXtffRZDH9MzK+hu+q1fgAOTJaBRS5K41hmb2wQP1DRl
 IP5Qr7WoKrfc/Eznks+fuaQmjF0=
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/9 00:26, COCK MAN wrote:
> This is my first time using a mailing list, and my first time properly
> dealing with btrfs outside of creating a partition. Apologies if I
> lack any sort of common knowledge when it comes to either.
> Additionally, sorry for the address - my regular provider seems to be
> blocked.
>
> I had been hunting for the cause of issues I was having with a game I
> was trying to play. Eventually, I found myself doing a (non-repair
> mode) check on my hard drive. Looking around for what to do next after
> seeing errors, I saw the same thing: head to the mailing list.

The free space tree problems itself can be easily fixed.

# btrfs check --clear-space-cache v2

Then mount it with space_cache=3Dv2 mount option to rebuild it.

But I still failed to directly bind it with your failure to play a
certain game.

Yes, fst corruption can lead to various more series problems, but your
fs is mostly fine, I doubt if that's the cause.

>
> Attached is the output of the check on my drive. I also did a scrub
> which didn't find anything, but it was only 60% complete. My drive is
> 4 TB large, the wait to finish would have been immense and the results
> of a check seemed to be more valuable.
> There is also "additional.txt", which contains the output of uname -a,
> btrfs --version and dmesg (needed according to kernel.org, 2 other
> commands not shown since drive is unmounted). If anything else is
> required, please let me know.

If your main concern is the failure of the game, please provide the
dmesg when your games failed.
That should provide more info about the root cause.

Thanks,
Qu
