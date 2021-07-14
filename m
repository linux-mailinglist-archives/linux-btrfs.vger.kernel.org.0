Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14EA53C7DC5
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 07:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237877AbhGNFEA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 01:04:00 -0400
Received: from mout.gmx.net ([212.227.15.19]:40039 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhGNFDz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 01:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626238863;
        bh=IBfICecFV5jOFPrpkoKU9Aju9nZlrTw3IbO0U+7j3/g=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fNDhQA+Ls5Fi0sKX4tyWWJg/bvdPlrg+kBEp0/tKZ+SuHbGeFmkP2cGmoTIw+OpRq
         RqITBAzuZ3AdCWk8ZQf18g1zMOhj8qFnjDNrfMvpmFhegxCRLkn9iMdbmGqd6hWPX5
         DlN0L+zkWTSxGU7GaMtj9+pLtWcd/CtBSW7bJIcE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MBlxW-1lrNwI0flc-00CEe1; Wed, 14
 Jul 2021 07:01:03 +0200
Subject: Re: Enhancement Idea - Optional PGO+LTO build for btrfs-progs
To:     DanglingPointer <danglingpointerexception@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <d0f8f74f-edd3-6591-c6e5-138daf6b25f5@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <f68a2809-eb46-744f-7045-93eaeb4bb44f@gmx.com>
Date:   Wed, 14 Jul 2021 13:00:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d0f8f74f-edd3-6591-c6e5-138daf6b25f5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rYzXh66K1NM+DqMaGM24AYGwWl8w7nD/xH+2uB5rBtG855g1noS
 Vw8SmoGNwnWqotWqaSa7x5mqXROz+BHiUOGjEhveKkk9GuAt4YzvbsYaz2HO1+bgjgTqPXX
 vkpBs4KOb4+XBY79bjmD0XSJcExMty8cdYQURTQJM/wFzU9GnDaBt8RBOXOuBd+CHzhmpPr
 QvHG8yLG3FNZKrQe7OvZg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:roE08pBGAi8=:uWY7nX2OmQjZaqvyh4jpmH
 R1eyCnS2RKEGZe9OThe7BWovqeBASwEFyWquMCeV5vUAXb71ogIylnhd3gp07SPxTc88sHeDj
 Gcoy5WlQ3klNcXtW0B4EOSHzXKsKSFpqh7JoOS+RoaYG+3H5MenvYZaXaZjgw+CzZwSdUOR2B
 HWpPf6zZHglYEtur1xoNJyDl4zkqvAZZcJGdploAhWPNVm7B5MejOwzChehnhR9CHSTyudqv/
 X2o/cY6AcxxCDqhhq8g+mPDYtg4Fmqg0kHTIgk88o64hGqQpQkHA6KUgWZyO+P/Fn2Iy1+Xlj
 hLI4lIoJs6qkZ6uTyy7auyaSRvOFslroSvPXJcJXWL6Rl0sakQB31UdNIAbaoYxgMCaRUEaxG
 ZKb20Jbq40klPE5kUoqQBVC2K74fdCpkjTO6XB96a08lneQtJjVf0AjW0xbqnqYRQYBfuA4yo
 hHDFNgSTtEtQkby6TMiGw0ykw0hFYNQaVELoYQEKPLjaVOqsQnEA6yD2ndMPdMHUDVcWYoG/e
 NbqNxizBzTTaQNUHEiNhrc/Da0ZUHMs3fbWe4TZVOMH02J7NHAU1xHSjx6NEOpB61XMxQhbDR
 6HA0tXT79g9YzHxCNJ9xrCZzU70OI2vxh60oTrml4q9dQ9GvIkagw9sxIckqoysbA7h4GBkQG
 4pHON+ZJeIgmKMJjbvRjpHfI5ot3wHMRxYnpi5wAbzOx0PBQHsRt9hfqtvLY9QQybE8VPh/PG
 EhLTJlmpeICeBKoz07fAiTLPTq7DB7bwt/E/VkXtjc4YR5SMFP5w3AEgWYtuBh6kRYg+VYSF5
 3GKIO4V8YNJt+gTnvzFAR5QToYparysJIyCezA9ejPBLIvha2GqhlAXY/OfgNviulTvHm6QcQ
 sIBfpM6g21aQr33GdKRzwHIQxEoocgc+fFzHSbs0QFbqB491qMGyZ0vuzmf/R5DyQWB79N/QI
 Fv4K50+tdDjgKvgqKkjpUbmzmOqTs+QZQ5z5G9f6K8httJ6F1Eu6zEv0M0Cd/x/uRMHbPykQR
 f47PLjCpqesnAZVoHPQA3aQJnN76qTsqllC8T6PeblGe3JB5b/spagYRG+yXEYvaVvlGAjzPA
 Td0nZXYYuFY2SO5PM2dn3dLJsKfDDJX8aZvFj8dP+NjwrAB8LqT/miy8g==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/14 =E4=B8=8A=E5=8D=8810:51, DanglingPointer wrote:
> Recently we have been impacted by some performance issues with the
> workstations in my lab with large multi-terabyte arrays in btrfs.=C2=A0 =
I
> have detailed this on a separate thread.=C2=A0 It got me thinking howeve=
r,
> why not have an optional configure option for btrfs-progs to use PGO
> against the entire suite of regression tests?
>
> Idea is:
>
> 1. configure with optional "-pgo" or "-fdo" option which will configure
>  =C2=A0=C2=A0 a relative path from source root where instrumentation fil=
es will go
>  =C2=A0=C2=A0 (let's start with gcc only for now, so *.gcda files into a=
 folder).
>  =C2=A0=C2=A0 We then add the instrumentation compiler option
> 2. build btrfs-progs
> 3. run every single tests available ( make test &&=C2=A0 make test-fsck =
&&
>  =C2=A0=C2=A0 make test-convert)
> 4. clean-up except for instrumentation files
> 5. re-build without the instrumentation flag from point 1; and use the
>  =C2=A0=C2=A0 instrumentation files for feedback directed optimisation (=
FDO) (for
>  =C2=A0=C2=A0 gcc add additional partial-training flag); add LTO.

Why would you think btrfs-progs is the one needs to optimization?

 From your original report, there is nothing btrfs-progs related at all.

All your work, from scrub to IO, it's all handled by kernel btrfs module.

Thus optimization of btrfs-progs would bring no impact.

Thanks,
Qu
>
> I know btrfs is primarily IO bound and not cpu.=C2=A0 But just thinking =
of
> squeezing every last efficiency out of whatever is running in the cpu,
> cache and memory.
>
> I suppose people can do the above on their own, but was thinking if it
> was provided as a configuration optional option then it would make it
> easier for people to do without more hacking.=C2=A0 Just need to add war=
nings
> that it will take a long time, have a coffee.
>
> The python3 configure process has the process above as an optional
> option but caters for gcc and clang (might even cater for icc).
>
> Anyways, that's my idea for an enhancement above.
>
> Would like to know your thoughts.=C2=A0 cheers...
>
