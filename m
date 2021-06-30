Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CCE3B833E
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jun 2021 15:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbhF3Nie (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Jun 2021 09:38:34 -0400
Received: from mout.gmx.net ([212.227.17.22]:54973 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234784AbhF3Nid (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Jun 2021 09:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625060161;
        bh=DP6LRLj5W9v0m4wBGjIOFziQJhzwX377jxrGqUqp5Ys=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=FmOGR2+387YQkA+z6S1U4S7pFH6BqtR6fLDlqzUdB+xP9wUtJcrgDlqgLXOAl2KgP
         fL3wOy0xzfti0TwdLPFrLtwM1JajhCdZk0H5lcnjNNTg/9vxKxCSt871bJcEImYqsU
         d3dTCWuSkkVMqOj9QOit4+Ers29b+f0wyxNKUSnM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MjS54-1lWeEM2sSQ-00ky39; Wed, 30
 Jun 2021 15:36:01 +0200
Subject: Re: [PATCH 3/3] btrfs: allow BTRFS_IOC_SNAP_DESTROY_V2 to remove
 ghost subvolume
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210628101637.349718-1-wqu@suse.com>
 <20210628101637.349718-4-wqu@suse.com> <20210630131640.GM2610@twin.jikos.cz>
 <43550620-f6b6-aec9-9315-ca50cfbbac9b@suse.com>
 <20210630133046.GO2610@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <6cc162f0-65c5-98a9-14f2-9dde7d6216ea@gmx.com>
Date:   Wed, 30 Jun 2021 21:35:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630133046.GO2610@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R7Elai/Pj3X+Ha9dYAZq4qSTSA98ocSjWjrXGxqCAJgzDzaOEGP
 duo58tp9Fe5lUerMCB+sdIAZuX8I+EkFoDqH5nEhu0TH6K4NF/M8AarAQ4HyBJ0bGjs9/cy
 Cjzl0C8cgJaOTxxTKnMqnD7HpJ/kTE9rFSr41dl5FEIvOrhY2nzRsdBA25rjx+fhLZXEv9X
 70eeRJCvkjlRb5Zs/8W+w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mn4AJ8wyl9Y=:XMUkiRYR7W0BHBJDm3ZHp5
 brWwxOihIzqhJDFo0+pEsEdzmIYbWhSVTSONm6Gvvenw0b4iBqe0D31OzWOAy5wj1YMWP0HBw
 vS5dW5Ek/qYnlG5kmX10v5ma5mZFbm7BWtViy3CjgxPHxR3YUS/HFF+mWVgTWuDuwReR8cQks
 ao6SAh97F6WdpYCcgPyGO1A9dD9+4GC3Hcu+/h0+TWNZtZgo/X/tZdQzT2D/ncEaijUVOupdr
 BIQ1pwY9H+GMFQLY5dBkX+iIe3Of4HNq+XB92Zm/lSkYfQaDsCUVB7U7YyITeSlloseHboOa7
 Siuc9Q1WV+rDYH2ZnOqQ3IY74HbMNJItzkc4ezjJFIXFEgaRNnT6tiOL78m5UeMk9Mk0sm3Fe
 Tw2OsFGbOwnXhiiZnpchH//AD8EI4yCS7bN9cstiJh444qxTMaXPd6cwQjbWkorNdgFxZI8j+
 0p2IqoyQ1HnymhrKPIKtcFJNCHZKZyIksq3BT33V1Nmzkan358d7swFxFbHjuNHWtbTxI0tCB
 PgcTZsm0VuqQBvGfQXcHtkEHLWXEF8zoOm59blO+Qvu0P0OQi6YqI+7Cz9EyAHd6wyS0tJOsP
 44MekcC/tAJGCeR72cqjzE947h4i1DgPyIeBhvs1Mejq4Lo17+2aDxBFDhj7aWfIIsxL2Opcu
 W/DCpSusg7MAchJ2iMzqcpkGopOqv65g3cBnqKJQ2DTD19u6+f/yjO6cHJOaZKL38Ejp3Uj0D
 P91X3Xg2kSfQcQ7R6ouJEWgQiTV//JBq5DT2uhf4GNnr7ndrTLbrP1flzEe+G2pPi01Pb2/TH
 9J59oS13t+pMwLqt0tdLR+YjfGHyMcuT3BzGcdWM2jfYIlc1g6rAtKHQCyM5IygHliS8QfLM3
 KQ938KEOJWvGKAEXKW2CsrDJqQBTHdoN1mV1AUQPNoUWBxd3HXdwfb3D3S9SFmbQuVSsnwbtF
 /m6eXKiBVpwizyB2Mdc7J7p7R5hz6Tjf6HIoZkzipm8WxHLAQKggpkNaRIJEKPPz9WzlqMlbY
 OMPOBlhKnaum3BrbvFMlX7x504eJx+qrJ0dxRbdpzBKwugeVNxqgV2T/Aa1hJkziccWHbx/JA
 ZB6aF5XFagyUM9WnczYDpm/GOn3BkbZOzTPFB8xbxHGuGCH6m3ux4IrxQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/30 =E4=B8=8B=E5=8D=889:30, David Sterba wrote:
> On Wed, Jun 30, 2021 at 09:26:20PM +0800, Qu Wenruo wrote:
>>> Is there a way to list such subvolumes from progs?
>>
>> No, root with 0 ref will not show up in "btrfs subv list".
>
> We might need one then, but I'll read the full report, maybe it's a
> one-off bug.
>
>> In fact unless we pass @check_ref =3D false, btrfs_get_fs_root() won't
>> return such ghost root at all.
>
> In progs the subvolumes are searched directly by the key, so this
> (kernel function) is not relevant.
>
Anyway, you can use the test image from the btrfs-progs patchset to test
btrfs-progs modification.

THanks,
Qu
