Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FCF33CA58
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 01:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbhCPAaH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 20:30:07 -0400
Received: from mout.gmx.net ([212.227.15.15]:56723 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231911AbhCPA3m (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 20:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615854578;
        bh=cW+jtgzcTKlY5xjWTv1HPPcq3mCD+MlVXpK+0/6XVEg=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=btPLnceYy7qYXwJGiCgVhCTff5XHGzCwwQfIVUQ8IYonZ5chVFlCgPrfQR7UIptG0
         mJmclylLqJVLUYAY4DzT+G7PDGK/4uPedDbRi0LXCMj+P7fJtzfrfkvJ4Cfab4AW2Q
         teA36644uSdYPcPjXmrNz8fyetQjqBeUcHMRPTps=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbzyP-1lqt5x0hOJ-00daHn; Tue, 16
 Mar 2021 01:29:38 +0100
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210315053915.62420-1-wqu@suse.com>
 <20210315154205.GX7604@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 0/2] btrfs: fixes for subpage which also affect read-only
 mount
Message-ID: <09680ea1-12c1-eb0e-b3fb-08caff760b04@gmx.com>
Date:   Tue, 16 Mar 2021 08:29:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210315154205.GX7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xGm+XwIqMgB1DK+JYA4qupL/tXziO0sbEPe0IZziEUYHI5m4haA
 5YRPdEBWOm6SuOwwjXLeLt8BPOXKxeeosUbTMGLglTI9D2enbro94Wd9FWsvgWCxjJd39qp
 jdJp/NBqfnnMX4XqflZyiP9IcUFUIA71ob1E40ZxCJgBPlbd7YJi8l8HXbV4CtStxbj9gVm
 M3dlOCvwZ7pJzpg1eJSLQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:v+geSFj1WwQ=:VA2BrqaCQ7/4T0IsL1Jg6Z
 xV75sGcDEI6RI49SsDGolMu/0rIoh1Iugkq46y51yw71x7Dg873YDMvq7CpHYV1jXIwfljSCS
 J5y1xDkN1mRsqhrzYcD+H37nod1xw/3CBhY/iyHRZ1fWF1yqw5Os+XKBi83emVo/sU/lKzaOq
 tpl+2YGlyCoa2MqjT5n9IBUa5kqdQF5p4KendOmsa4rfdjagydK60tECF7JsCr8xLVd35PqyQ
 jATe+/erhed4EAjlN2CMxQj6RTYy538bl0iboL999C3cNia71x02laMBjIwMRQlFA1hQTwhqf
 aJb/5peH1msZRkSroOgX4sA6CQS40v3FPxop4TYYwDEnwGgDdumd5VyD4ktBaesXTMY7d4CVv
 2BLiAaH4+q8mY6eNITGHHe4P8QzvkpbitUHeCNgoX8odzOUnxIPaVQcFVogbQcHbsTFYH2rxq
 X6pCG+5Vpwmld/JtU8NasXXyZjzjyApBQQ21vA1MpcvdQQkKd3jICGu2wCn810tDAo7OP56hL
 lqayI6LA2wKSEclyjSMSB8ZtiN3L73rgs1sfTV3MqHUlAk9b/ptOKXAVEv244oD6C+EyeQm/9
 m9rQ1SL8Sr712Q+oT9U7ukOwZmO9/d1VfFEV3P1mM1S0a7PM+fM3V9D6zcon9xxEqydOedh+r
 eWnnnoLNq4kHxIlxqMB0C1mko95eudYCSkyl44YjxalkPVllHDuzHP/1eWqt9+0jLDtrxRgdo
 RLa261CscERkWpUMDbofNSUjStfFs9fwbOgprDBMgOv+6gjypOgeYRpegr9NjrLME7U7gpERl
 pi0n8F0UDbx4+W9NraNb6AxsGTYqT+T6CRZ29aHR3lX7RPBkL7AXrdNlHpUuP9IwC/4m9arS/
 6ZIz6ZxXdEU11UdNlOPg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/15 =E4=B8=8B=E5=8D=8811:42, David Sterba wrote:
> On Mon, Mar 15, 2021 at 01:39:13PM +0800, Qu Wenruo wrote:
>> During the fstests run for btrfs subpage read-write support, generic/47=
5
>> crashes the system with a very high chance.
>>
>> It turns out the cause is also affecting btrfs subpage read-only mount
>> so it's worthy a quick fix.
>>
>> Also the crash call site shows a new rabbit hole of hard coded
>> PAGE_SHIFT in readahead.
>
> There's still a lot of PAGE_SHIFT use, not all of them are wrong but I
> think we'll need to do an audit and categorize the valid uses, otherwise
> it'll be a whack-a-mole.
>

Already did that.

The current valid use case for PAGE_SHIFT are:
- Grab page
   Including:
   * compression
   * raid56
   * relocation
   * buffered write in file.c
   * sb cross page check in volumes.c
   * send
   * zoned
   * sb rw in disk-io.c
   * tree csum in disk-io.c
   * free space cache v1
- Some legacy code still runs in full page mode
   Including:
   * defrag

- Verification code
   That part has way more hardcoded part to be addressed.
   Will be addressed in the final part, along with selftest enhancement.

Although there can be something missing, I believe it shouldn't be that
hard to hit during fstests then.

Thanks,
Qu
