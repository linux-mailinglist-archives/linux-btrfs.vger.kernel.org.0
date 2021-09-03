Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345D74007E4
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Sep 2021 00:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbhICWZD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Sep 2021 18:25:03 -0400
Received: from mout.gmx.net ([212.227.15.18]:33893 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234285AbhICWZD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Sep 2021 18:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630707838;
        bh=HlOHBEyA5Qmx8U54xA4NrmWLfiHwP01L60zdHz1Mayw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=AFtvuEu5NDVJ9O8OXEMHs8nKcgpvgFuIe2aePV6300FuNjdOZEC8ObdFm7VZJ7Mr0
         dzkL3s7vWClk1wzliMn6rk4fwQf5hCIBW7rIPxQ/XyYnTyLd5g4AOgD/qSfUqwbg3c
         S/PqP5McCWAXBhfB17udyTxp9RxIGneZjTyUj1NU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MY68d-1mUK3615tV-00YP4U; Sat, 04
 Sep 2021 00:23:57 +0200
Subject: Re: [PATCH 1/3] btrfs-progs: use btrfs_key for btrfs_check_node() and
 btrfs_check_leaf()
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210902130843.120176-1-wqu@suse.com>
 <20210902130843.120176-2-wqu@suse.com> <20210903140207.GE3379@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <7946f5ee-13e4-c5c9-d48f-1d0fd80e5f69@gmx.com>
Date:   Sat, 4 Sep 2021 06:23:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210903140207.GE3379@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UcCAnuxKDcqvy6xiKYxNcbUt/3AVCwx89/SZtZVD3fJ0OITX0FI
 qRW5+fDrBwkDPh6s82YnxHDBa4IgwF/+ngQmB2uSayiOMK3DPiQS4nX0SQcPEjARRrQ20i+
 sdh53RD2FfbE2m/TVmM3S8amnUyd+gN6o4HUocZ1EQgHgy006mJwUwOvsyHeGphmUbUWoZh
 6HhIeCDRM6FDcDnW9tJzg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:o1k3Ay1RpK4=:uC5pri7K1LU6+QUYIHZ5hs
 tyYQB70wj+b4vGg1Xz6kaOFBLXI+ndgJYAO3nKrTSXiShZZPNozjcr7fxWZpXFnwCFD9uPyfv
 m8lp+uF8JxX5OzyncfVtrHJ8B4iTLxHRCkri4UePpH0saf3MGfj9yJJAlZt/Eo7PM0CDRqgsR
 5TLfF9E5jmdsffQIhEDzMVh/Ev8EhaP1I9YBdKPmZha9JtErWJRsjv/8bpDo9Jg88Sw4oxku5
 e0Ax9Sg2Nb1YYzzRt9zjxQ1I3g0tfw37X43qTPEIvZHBE4KfflxG/mz/XtAEWi/CgzXagexZc
 hZGzSW2ywTjoNtibQV1otfEsGb3l4hDVjT7eaJoigazKgGkQ6JGKydVMj08+t6UJrUFRlB3xg
 EKLsZJ/XVWtM0ZEL25ZLoq9FG4wgdXH4u9v1bJgwJnU8Am6AH0iRW89JBv7FHoi7M8T3tfKh/
 FrNn03YWHeSVU5Tm/kdGE7VhHNqu/9joEhqbyLARH2JeNfBUMuaWJry5buZKOgrg/3O9p9qRd
 /VdERGuiGDoFrhFZD8xCKPFcJ1mTEu0l9oYxVw31QDwVC1U+lXPVA6LzjkTEGeD0CQPLk/i9d
 RNnLn67TWDCBVnkVELeh0Ls6g6NWrFAGyrERKO2NV8bGOqRKqabXSDLDhO1j0W6NMPshSLYT5
 X1pjKvyLNK0tvhTUgdKxiO3YVqoyiCdZEWQwyXOOZrio3Sv0b6Ltg3iNBKbAjrMXV+bxxJM5r
 zUhL0R9x797gMv8xSgIf3scA0LwdvBZ/IWppQ6bkws2+lFn8ZYybN+OJ5uon2WYwUWBayhd7h
 oeRyZUzmyO/ID7e3NZMB3fZ9XmmWZxVZ4n2ibAbxzZpv2wbY44cc2XGwvqCjvYCbcwN3EADUO
 Yq1HbmP6LJcCOkrBxRQKaZQ5LV27w+S0APwyrrT7+Rsa3+UuxzKgWRWpJzKG8K0kKtL9xNLoE
 gvLNPNDazbeuqmME13Go6n8EjuOortfFFc3r+es6OWky+kzZShac/hnBh5AOrxtl7fbHN5bpE
 7+T5Gk5f+C/EggGU1rFqQiBVsw3Qj6PeTcmDp9BhjYYR0FZY3l1Ht4YgBn+wFvw/oFFDvLdsE
 saYnEt01tm5Lc7ulKpqjj2AhIBOe3T5QtnkIh38uXSoGETQVIGBiF0BFQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/3 =E4=B8=8B=E5=8D=8810:02, David Sterba wrote:
> On Thu, Sep 02, 2021 at 09:08:41PM +0800, Qu Wenruo wrote:
>> In kernel space we hardly use btrfs_disk_key, unless for very lowlevel
>> code.
>>
>> There is no need to intentionally use btrfs_disk_key in btrfs-progs
>> either.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> This fails on fsck/001 test
>
>      [TEST/fsck]   001-bad-file-extent-bytenr
> failed to restore image ./default_case.img
> basename: missing operand
> Try 'basename --help' for more information.
> failed: /labs/dsterba/gits/btrfs-progs/btrfs check --repair --force
> make: *** [Makefile:413: test-fsck] Error 1
>

Not reproducible locally.

And of course, for such lowlevel change I would run all tests on it.

Mind to share the base?

I'm basing all my patches on the following commit:

commit 06bae7076265242f118471ce8c4340dcc5e3f555 (david/devel)
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Mon Aug 23 15:23:13 2021 -0400

     btrfs-progs: tests: add image with an invalid super bytes_used

And I also re-checked the test on this patch, it also passes locally.

Thanks,
Qu
