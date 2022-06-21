Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E66553EC0
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 00:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354957AbiFUWxi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 18:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355022AbiFUWxe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 18:53:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C241570D
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 15:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655851993;
        bh=/gS1cgxxJdXqY+TCBgdRzTQBbur8BrfaqgyCpBC2uzw=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=ZjBEj62pYi6mXGAIfrQrqyRf3St+IzMqQXcypMdpHG6r9aR87KPfcVoUXCSs37DEZ
         wgb79iJ3IYI1ANPbegqzgBaIBUkGiyW9ZEFLeq+bEu1Eessmcfqcvk0cws0aCsxoZ3
         hiqtplsQfqjcLGCpvOAN0MemXEvAVvFi7H3F4eQI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTzfG-1oBzwI3ceo-00R1z7; Wed, 22
 Jun 2022 00:53:13 +0200
Message-ID: <0e5a4309-3110-8443-04e0-e4fda23fe198@gmx.com>
Date:   Wed, 22 Jun 2022 06:53:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     dsterba@suse.cz, Ira Weiny <ira.weiny@intel.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
References: <aa6f4902ae200435d9da603dd092e91c4dfdf69e.1655791043.git.wqu@suse.com>
 <20220621131521.GW20633@twin.jikos.cz> <YrH9VNQnVqHgUKAC@iweiny-desk3>
 <20220621181917.GE20633@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2] btrfs: zlib: refactor how we prepare the buffers
In-Reply-To: <20220621181917.GE20633@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vWpJoiX056WjuZ7U1Aa6Pgcjo0swUY6JmhurVDhTPj8exdsT1Lr
 33Z+c8+YNUO9o5kYlco0LuCo4aiBv/xU7a+vAUrqt6fJaAeTE5092XL1pjKjHrc7dmR2B8k
 q0VNNTpIFxx91y+XXC1XbKsMzKLZjI0KbyU0pmBQ7iFuKIYU/Ih9SHDwslvEdFRrlpOIDGc
 AXiTIqdM4gOc01IPb/ytA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1ba1qui3UWo=:v1/vYHS+I1h+7itJCiXi/M
 xd+owew6K5+YpxXiRKbKGRuPp2WhA9/uOrkojuFq/yCfxAoDcTMDYlxEKWHYZEkjsVd8G1H/L
 Z6ZXGLKn0Flavg/DRlU1YcsHqQ8sM/AAsx69SMt+aRRQcCgt/yt4J3qtDuJuEJOt2cWebWpJ4
 frjRcNif/nkMXPPNAYyD5wIOHwDi4auADvuaL3WOEWLvd+lfaTILKNLc4DHg1LMuVA3Zk1bcu
 3PboSZeTgqLbr+QUbkzMS7H9cIsInazRmiixgudYvFIljp2fLSmFIIDWt3L0EaW1+T5YSxK0h
 JJwA4DToQjn6DYDCQVuLzgWe1UTHlOpSK+7QNCdgOf/azuCWwQ159bAqtgudOuWJdXVaGmm78
 mTzHGqhTuFI+371HcJfCbV9kAFBP1MYRhWjzn/oO+ZHa1KJdIOxigr3z1SwfflIxc+Ps3A7Vr
 j7egrkajOMlnBZZO3/aLnrMyzkinhZ698xZpGzT14VXGLF9qVw+Ky9qWaSAyty4CdOvKfs1LO
 U3rG+gF5/A4NMY1V+I5Z4AZH6h23vL3x2IfUNEo4i8HUpx9Vs9QRnNhB1RecY5Ck+Orzrir5K
 DNSsR/7nztHIKK3pCbZMja/8h/0XyyYpOl9IUEh3GotNoZJWye0RPM+c6Tt4WOA3mBtAeKZdy
 ZOW47s6gVecAWm+onffFIRYALHFcfxr8P9H25AlFgRiUM/+ZTG2afARBgTEYRbkuR7dJtM6bI
 Ee5vb75vYn+2rSXOVYFwvRCCk1qNP7JkXb9y8b8GY+XNISeZ/svaLXSlqeGJ+nFLUXCmHmq8X
 vhzV7h8+/LrphM3FwCPmwxAkuLxihG7VCHmxXlncoQtoj6yDg+cCTnMw/Ps2hZfMFkOASs1de
 GTWnYvB05Jj1GKP6DRDslyxh/65IHk69kE6E5ESM9W3/g6QzmabP0hEAlyunjENaNohXy59+l
 XAbNx8WfWvBXAbRb46vQe05D4wEhHNbgBlz1RZ6RWn9Ed9GoVm+xdqxe7T0MgNUGP71cqn7qr
 e/ibeqAoWLDOvfjSAzZLzMmpe49NZSfs+GyvpLmOJpec6lAYwLodqBgK/XUl8lHyTmxt8k2Ol
 +aj63GXnofiYVMnkKoa6aaxpC0HnrYOx6Xbip7F3nf0K8RKgpIm2ecjkg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/22 02:19, David Sterba wrote:
> On Tue, Jun 21, 2022 at 10:18:12AM -0700, Ira Weiny wrote:
>> On Tue, Jun 21, 2022 at 03:15:21PM +0200, David Sterba wrote:
>>> On Tue, Jun 21, 2022 at 01:59:46PM +0800, Qu Wenruo wrote:
>>>>
>>>>    As kmap_local_page() have strict requirement on the sequence of ne=
sted
>>>>    kmap:
>>>>                     OK              |            BAD
>>>>    ---------------------------------+--------------------------------=
-
>>>>    in =3D kmap_local_page(in_page);   | in =3D kmap_local_page(in_pag=
e);
>>>>    out =3D kmap_local_page(out_page); | out =3D kmap_local_page(out_p=
age);
>>>
>>> The input pages come from page cache and could be allocated from
>>> highmem but the output pages are allocated by us and only with GFP_NOF=
S
>>> so they don't need to be kmapped at all, right?
>>
>> How important is it to optimize the HIGHMEM systems?
>
> We optimize for 64bit architectures and add maybe cheap fallbacks or
> warnings but specifically high memory is not supposed to be anywhere if
> possible, all highmem allocations have been dropped. The kmap
> requirement comes only when pages are from page cache and filesystem
> can't affect that.
>
>> On !HIGHMEM systems the kmap_local_page() calls fall out anyway.
>
> Right, but as long as it's kmap_local it must follow the nesting rules
> and this complicates the code or requires restructuring. My point is
> that we can drop kmap for the output page thus getting rid of the
> nesting. Then the mapping of input pages should be straightforward and
> working on 32bit architectures.

I got your point, we can get rid of the kmap_local/kunmap_local for the
output pages.

But since this patch completely refactor how we map pages (hides behind
the new helpers), it can handle output pages in highmem or not.

And to switch to non-highmem for output pages, it's really simple based
on this patch (just change map_output_buffer() and unmap_output_buffer()).

As you mentioned, previously we had problems related to kmap() changes,
so for now I want to be extra safe on both input and output pages.

As long as the patch is fine after enough tests, we can do any output
page mapping change super easily.


Another thing is, isn't this patch itself cleaning up the already
complex mapping scheme?
Yes, kmap_local_page() has extra requirement, but the requirement is
also pretty sane to me, and we should follow that requirement as our
basic scheme.

How we handling the original mapping code is so ugly, thus I believe
even we don't need to handle output page mapping, it's still a worthy
cleanup/refactor.

Thanks,
Qu
