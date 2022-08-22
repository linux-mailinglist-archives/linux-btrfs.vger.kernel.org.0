Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA07459CB55
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Aug 2022 00:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbiHVWOG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 18:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbiHVWOE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 18:14:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0AD3DBEF
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 15:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661206440;
        bh=RwXNKleIt9O+GpCW6rpf/M7V3siOISeBzH3Ns2TvWig=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=D7ZMmnM+HrA3vNlDwNcq6lzGGIYpWO8yYE0Q5eTThdGhR0QKk0+mM4I+Gi64dJAuD
         xKBq3AxEbtxvu6GJsLI4qQY9YVdqUc3YGwEXcr7iYdS8wDY6+3AIBfFgXQLyLyHoMu
         79bnPIHqj1QtxBx5wjXxVxt2gmVBgwrx0IXuLwaw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mxm3K-1pNxXt1kbu-00zILO; Tue, 23
 Aug 2022 00:14:00 +0200
Message-ID: <7cfc677c-80aa-ffe2-09f6-f221e7a41987@gmx.com>
Date:   Tue, 23 Aug 2022 06:13:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 0/5] btrfs: qgroup: address the performance penalty for
 subvolume dropping
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1657260271.git.wqu@suse.com>
 <20220822174541.GB13489@twin.jikos.cz>
 <5efc6c8b-94d3-992f-aed2-8f0026790f54@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <5efc6c8b-94d3-992f-aed2-8f0026790f54@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fSmsnGPsRAYgEgpLtKuo5HYBpbgvf2N5gD9OCVOJC3CNTcTJdfM
 RUKEKS8dca/5VquN/M+R9mvLEnPaSadjwRsfK8/WzeO5EhF/BVvKiRuSW27PtocV10Kv0oZ
 VcMxflvs338lPd4RmJVSZiYiAZyiEuSqLUnVDwcHn2lhkIGRT985z+fIbEPJk3/jiXFOo4+
 oqztWAcuMv4P1/E8mOt+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hwlbJRpZCqQ=:BbByILS38Gs3iEk5sk75yi
 PDIIKQ7/HR3cAHrjKosYTmI9w006F8CNF7owt+WjgLnM1h0k5NTchOAuFYUQLhJOyuVl54TxI
 NFc56bmYCL/P0j/CzLyQcRwdGum8yRRJxzqV/QtwmW2o6uEf4PLOZkCquPzgXUSLt8jVIT5nI
 QfU0/HsjLR3hG27KeJl+oLgGLTVpXW+I3tB3zT+ryCh5KXk67t4r52+8KkJh7dEW71zxmqcSr
 fo6tGbPbp4eAG5/BJtdZXjrC4S+jripTlfFaHIz0TDKRpe2XtlStE4zm/I8EsB6oRV4Os1HOJ
 I1vxuW6S2tl2YCO2lEv5pSTwHr+nfaUVUXONGsqrewFG++X4TPyoRbe4yJal+LDaECM9mrD+u
 4QVK7bkUGfsFM5lgGqRT9jkAUcCya1EcdKeji19Tx41KLOjn39yuYnH/VisxC5+om6wmnQFDF
 tqGrDdkbhesVxtT3NoyojI2qDejjooKfMSm6IRUP+RYVqXWmsQ2q1x+yY3I6osNgD2tL230OW
 Z5YLjgldJEtVePNPyIPD2/r5352Da/0kLg8GA2oXIcTtmk75rE+QlyxTkpKuIYxUzen2ndDx+
 X8qLuqZV3xdJJ11owQwhNB/cOJzUSwdMIXYXDJ4cbaK7j7m1uhxZB6fRd7+uuurHA8CQbO0MZ
 XrH3aybMaKILHDWba5zDWBO6EFr/jSG+Tsn/D6kLb8B1S9brhG7aikczaX3OzWgMqMIn7o6AJ
 xUMp80gx1WAT+YqXVkibc8F4ddBrAQKKco+1m9kVrx6kt9CCIBvOE6z3sDdDowKzbnBxTjVo6
 D4H534UfdbxVx0lEEhqTRa661T4cpno8VcY1TIC0858m7c+1XS6CzJfi6nlWuWRDmtAVmwzlu
 iDASAejulJCNE1/1ckKK6yUaBjcC/vb6CUBr8ryIEvhdCCbGObXj3W6Shr5vQ97Nd05b+LB4L
 yFFm3UCkBBcYOELV6ZbtdVjaRPAuUi7V2VkZgmpj5FRH6YzjPLLzRqbxVJNcNcS0jmP1XxkdR
 Plxx7qvu6jdxeVO/etfVvKCsDYAbb2O99rohWNDwEOw7ANYygJQKcnbehgNsHfj8JS+VvIWzj
 5Kg4RA1nb0z5BPTfaWDHtOmsVRYsm4epHklyKotPiJXOOwK2ViS+P09hQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/23 06:02, Qu Wenruo wrote:
>
>
> On 2022/8/23 01:45, David Sterba wrote:
>> On Fri, Jul 08, 2022 at 02:07:25PM +0800, Qu Wenruo wrote:
>>> Changelog:
>>> v2:
>>> - Split /sys/fs/btrfs/<uuid>/qgroups/qgroup_flags into two
>>> =C2=A0=C2=A0 entries
>>>
>>> - Update the cover letter to explain the drop_subtree_threshold better
>>>
>>> v3:
>>> - Rebased to latest misc-next
>>
>> I'll add this to misc-next, but regarding the overall design how to
>> set/unset the quota recalculation I'm not sure it's a clean solution.
>
> Yep, that's always the main concern.
>
> Alternatives includes new on-disk item for qgroup, something like
> QGROUP_CONFIG items.
>
> But that would need a new compat RO flags.

Wait, this doesn't even need to be compat RO, just compat flags.

Since the behavior doesn't affect qgroup consistency at all, purely a
performance related issue.

Even old kernel can still do the old qgroup tricks, just much slower.

Maybe it's the time for our first compat flags?

Thanks,
Qu
>
> Personally speaking I'm fine either way, any suggestion on this?
>
> Thanks,
> Q
