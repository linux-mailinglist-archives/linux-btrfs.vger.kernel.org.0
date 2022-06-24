Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9174C559AAB
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jun 2022 15:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiFXNvS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jun 2022 09:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiFXNvR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jun 2022 09:51:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009B54CD4E;
        Fri, 24 Jun 2022 06:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656078667;
        bh=JhZfPQ+ziq8ElsF+fZC0GoWbI+6qsHdJf/mQTsAPrlE=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=XgEWKYJ6VYtp1uoOyQSboUTNHjHOv9dAcelFKwWckzH/vxKskeFnxFeXLO7O+Hb5m
         Q67rJKiKFMg8YBozLChb0H89spTiJ5/z/SbczZg4f+DGJk8L4lPNGsk+M3NbNzYKCV
         5CjUvrl5/1B1UTVSdItrrnh6xe/Kuf80LfsYdags=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYvY8-1o97QQ2Rns-00UnuH; Fri, 24
 Jun 2022 15:51:07 +0200
Message-ID: <3b0611ff-8d8d-a95b-d37f-f43a8d2bdb82@gmx.com>
Date:   Fri, 24 Jun 2022 21:50:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     dsterba@suse.cz, Christoph Hellwig <hch@lst.de>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <20220624122334.80603-1-hch@lst.de>
 <20220624124913.GS20633@twin.jikos.cz>
 <b058e226-8a77-42bc-8c92-5bd23244e7da@gmx.com>
 <20220624132701.GT20633@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: remove btrfs_writepage_cow_fixup
In-Reply-To: <20220624132701.GT20633@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Lz1kNbkB+Ws76wM5Dez6enGjsjrYmz3G9VF9neCmGAAYOHZGTMz
 +93uibVG+ohl77fxcjBITKgXF6X1pwd1rEGCdVk1rjAEqt/7OPBDgcTrrVzaZGT+X4wc9Lj
 8cg0CmesJa31OULF9itGNh9z18SgIJVDXfH6iDqjL0ZA1aKR5vVR3gCKVYzJctG1DTolgEs
 nZUXh9P0Ro0sNtGyJ3MLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uPxiYmheJfw=:1UFDtlR6wE96TBKPfgBdJa
 i8FZQCNuYRXx4xQfVSHsPyI6cwRJAPteB+u6M6jOtxZYhaj5SoOq/v5H5YfR+O8VGn8u6Exbe
 pR8HOwtk0njfXiUTpc9ny9NOF106Z+1Uq2ICQbMhggKTTgJvPkDqV1RfLo/X0IVPuehmXD5+r
 AC+31frwqFtzcAeSIO1V5fkxxer4m0qcWpCkOmfM+Uk2OdC/oKfOtiAME7IRRahT7iwWPFy95
 1cRMw0L2CHTn/3hoMeHyBAuCjTku+6hcaX/LuuTNLp6XRD7vMD29uoMV4Uu1wSEitXz7tMNIP
 hQEIMKIu+XvSoY9weAXOR/uXX0X6NwGTdmRX4sxSb1i18hxgk+TR12iNZj8vc8cLFLyKwHjWW
 Zvp60gm5poaWQbHwJHDFQcI4lQiSmybvCm7KZgohESKx2vcQjVoJ4v1okLRHsrgaZVykhEak0
 p6Kxy/XSy2SKSyvHJWA1VYWTd2N/P3vNvRcdORPPU3L+5bsrwUfLiw2Uoz6/XVzV/d7P+2s48
 UvFxksD7rJT+drPuUNTtFdWiZBSd7IAWQ96A95mRST/wZAFilBI2qOYsvHg4dLyqgwaSHPtbs
 IO3HObkLDNROjCp6OPEpFHdWxWjo/SWXVVcgBt2dUkGHrMyn4n33AQ99HVLarR6Zfi+l0gco9
 ReXfG45tm4DBMMJgU2ZBQIVSgBAkCtD7lWILj7WlbzQvDwnVE50znwm37uG0oQ0qqo3jB9mvs
 fo84rGA2DjEsGq0r0qCfYxIfHCYUFHvwSqZp4R+Jj2TeaXG2XiOOOEa8p1SFmoAkmr9+72E78
 0WXPWZ1CGGEIgRW5TrLefJwOT5Ayg5Y2FN9eFG3Zqbn4lDMCeN6iXmQRMNi+Oo5OjwnmVsy63
 SmddtdEj+2eEA6qdmE/wiZJOosdxAaQD6aFSm8qAEeECMbG11KuhOCfiGhqZT5xl95CGNUpq0
 /AGKHGE3bs3FXBUVlbsw4i35RPc3l4gGvKd9Nu8gcHP8dGe4V8uobTcVpKa/Exwz9X5EH4wlS
 7jMaPmksSViyQ1vMiYfXKpkqsD02hTC8Zp6PoiDVoE+zYBvE1LK+JIZ28WnOvjaNnp5Ww0eLU
 ov1Kk4EBqpg0LP3XwqT7tJDqAV7cDuvVXeSLbJ0Dlzjd9XTu8mxoyremA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/24 21:27, David Sterba wrote:
> On Fri, Jun 24, 2022 at 09:12:44PM +0800, Qu Wenruo wrote:
>> On 2022/6/24 20:49, David Sterba wrote:
>>> On Fri, Jun 24, 2022 at 02:23:34PM +0200, Christoph Hellwig wrote:
>>>> Since the page_mkwrite address space operation was added, starting wi=
th
>>>> commit 9637a5efd4fb ("[PATCH] add page_mkwrite() vm_operations method=
")
>>>> in 2006, the kernel does not just dirty random pages without telling
>>>> the file system.
>>>
>>> It does and there's a history behind the fixup worker. tl;dr it can't =
be
>>> removed, though every now and then somebody comes and tries to.
>>>
>>> On s390 the page status is tracked in two places, hw and in memory and
>>> this needs to be synchronized manually.
>>>
>>> On x86_64 it's not a simple reason but it happens as well in some edge
>>> case where the mappings get removed and dirty page is set deep in the
>>> arch mm code.  We've been chasing it long time ago, I don't recall exa=
ct
>>> details and it's been a painful experience.
>>>
>>> If there's been any change on the s390 side or in arch/x86/mm code I
>>> don't know but to be on the safe side, I strongly assume the fixup cod=
e
>>> is needed unless proven otherwise.
>>
>> I'd say, if this can be a problem to btrfs, then all fs supporting COW
>> should also be affected, and should have similar workaround.
>
> Probably yes.
>
>> Furthermore, this means we can get a page dirtied without us knowing.
>
> This should not happen because we do have the detection of the page and
> extent state mismatch and the fixup worker makes things right again.
>
>> This is a super big surprise to any fs, and should be properly
>> documented, not just leaving some seemly dead and special code in some
>> random fs.
>
> You seem to be a non-believer that the bug is real and calling the code
> dead.

Nope, as Jan mentioned RDMA, it immediately light the bulb in my head.

Now I'm totally convinced we can have page marked dirty without proper
notification to fs.

So now I think this is real bug.

But unfortunately the code itself has no concrete reasons on which cases
this can happen, just mentioned kernel can mark page dirty (seemly
randomly).

Thus it "looks like" a dead code.


> Each filesystem should validate the implementation agains the
> platform where it is and btrfs once found the hard way that there are
> some corner cases where structures get out of sync.

In fact, from the fs point of view, there are quite some expectation on
its interfaces, if there is a surprise and such problem is no long
really specific to btrfs, then it should be addressed more generically.

>
>> Furthermore, I'm not sure even if handling this in a fs level is correc=
t.
>> This looks like more a MM problem to me then.
>>
>>
>> I totally understand it's a pain to debug such lowlevel bug, but
>> shouldn't we have a proper regression for it then?
>
> The regression test is generic/208 and it was not reliable at all, it
> fired randomly once a week or month, there used to be a BUG() in the
> fixup worker callback.

And it doesn't have any comment even related to this unexpected dirty page=
s.

>
>> Instead of just keeping what we know works, I really want to handle thi=
s
>> old case/bug in a more modern way.
>
> As long as the guarantees stay the same, then fine. We need to be able
> to detect the unexpected dirty bit and have a way to react to it.
>
> f4b1363cae43 ("btrfs: do not do delalloc reservation under page lock")
> 25f3c5021985 ("Btrfs: keep pages dirty when using btrfs_writepage_fixup_=
worker")
> 1d53c9e67230 ("Btrfs: only associate the locked page with one async_chun=
k struct")
>
> And the commit that fixed it:
>
> 87826df0ec36 ("btrfs: delalloc for page dirtied out-of-band in fixup wor=
ker")
>
> You can find several reports in the mailing list archives (search term
> btrfs_writepage_fixup_worker):

To me, a proper and modern solution is not to rely on super old reports
(although they are definitely helpful as a record), but proper explanation=
.

Thanks to Jan, RDMA would be a very direct example for this.

Although personally speaking, I still think we should limit on who can
set a page from page cache dirty.
(AKA, ensuring fs receives notification on every dirtied page)

Thanks,
Qu

>
> https://lore.kernel.org/linux-btrfs/1295053074.15265.6.camel@mercury.loc=
aldomain
>
> https://lore.kernel.org/linux-btrfs/20110701174436.GA8352@yahoo.fr
>
> https://lore.kernel.org/linux-btrfs/j0k65i$29a$1@dough.gmane.org
>
> https://lore.kernel.org/linux-btrfs/CAO47_--H0+6bu4qQ2QA9gZcHvGVWO4QUGCA=
b3+9a5Kg3+23UiQ@mail.gmail.com
>
> https://lore.kernel.org/linux-btrfs/vqfmv8-9ch.ln1@hurikhan.ath.cx
