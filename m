Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D54E559A2F
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jun 2022 15:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiFXNNH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jun 2022 09:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiFXNNG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jun 2022 09:13:06 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DB3DEB5;
        Fri, 24 Jun 2022 06:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656076371;
        bh=mpgGbs0Th9qSc5wRx9aDtFvrJXSc6il6Q39uU61O9/Q=;
        h=X-UI-Sender-Class:Date:To:References:Cc:From:Subject:In-Reply-To;
        b=W13GLORQo4mFRzfAOT0zfMID4vv7W/3G/dTn33glJaBUfaqUwrhmDUOQbi6+RIuNl
         tlko9DswKfBwn1DhdR911ql/t/KT9H2X+QeeWuHscPB/QcqIdicMf2knnUte82MKLi
         heAAWaJ9GCp9KUD7v0mzJtV21hlaoFT1Mh0V1ULg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MlNtF-1nNNct0vS1-00lo3h; Fri, 24
 Jun 2022 15:12:51 +0200
Message-ID: <b058e226-8a77-42bc-8c92-5bd23244e7da@gmx.com>
Date:   Fri, 24 Jun 2022 21:12:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     dsterba@suse.cz, Christoph Hellwig <hch@lst.de>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <20220624122334.80603-1-hch@lst.de>
 <20220624124913.GS20633@twin.jikos.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: remove btrfs_writepage_cow_fixup
In-Reply-To: <20220624124913.GS20633@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jN5WovdcgKwQ7MC+rQehoNVujc6Vceol5Mpw4MjMm+kzk7LuLt8
 iQY5JSukD8cwWns0ier8wfJRmvaiKWzljF6hJ+fcPjE71Uwd7M5xhnKVh+NvqFqfcOV3vaJ
 xQeaMGhv3YUGfh2Y5xMQogOZu4yU5Zp8ZPihEfiJVuf/6ZJEmgNkKoAnxtdjU4Y5Py4LlF9
 50BqUOXMbij7jSSowBE1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ah5fHvL9uP8=:Mjl0wCGX/fo7MhMwzB+gHN
 pZe5V3uoDLqVzlj1v/z7VJ0slrMnXnXk/Pcc8MHxYcuni0m9vwNbGZVcD+SmWZyHAN9i+LBNw
 aTa0BlAHnE0ZZQQe5jmZDRslI8kifPlBESnXeOUtNb6gHxt3T6ZFlzzpFqFo4d4T5zSqNnrdB
 BlwgipCNE+LgwBGPyjB6xlRM4ClAfezTPlEt2sbIy3rsKs8lj0G/gvEwImETzD3Xu3lbHn1xf
 E5HvybpJil8aIB0VFwnCsQA9TEwAFeLRD6NciOc7mb8SdNLVUhq4zoQQ6hegY+yZ8mIV2C7NX
 f2SLujPLeIzciVCbr+ed/p6HjpKfKrNKm75eOpb7A5ovVf6+IMaV9SneHW4Vlfu7FPjd3z1/H
 DYXUxwQnoimhXQlAQD5CSv7tLN9JwJ3OBr3cyl80MGM0/n5d+qq03GQ6G1ZcXOlMyPkU+IArr
 +vWmFfMBIrURduly1LlOVkExg3A895QNFjtaD0sTdjd5oJKIP1v9tC1tfvAbOHRCZc+p69ZFH
 P7SMj7l9/8f0re1FKrjqQwYrB1prvzXz9tDof5Rn4l0tPoUCgR69gJaV77OG+trVusgO6MwWC
 hNnx3kWC/lHQym4CUPYk7D9OgvunEr9C6XgsgoD+BiWDA8ZIv7bpzjzI6X6gA3WCt02ensosx
 m3zUKVZw1XmPluXDFpT69x6b2dToXA9NJVzmOFBfdu4bixYV7ie5PKl2+G8E5USBgWLy4S/kC
 HVsLlQmFaZDM8PJTv1zwipENMBJWrS71jV8zCzOWzvtlpN+KTSw4Ph9D529RgPeQSRsgLnLNV
 eB8VrR+uLWprz5z0BRuRl1rRjZJizHbVuJ02In/ZJdil9+vZvdojP390uBLoahEtJ28njKn1Z
 BGtXqZaML0Gw2TcfP4u2EcswB+SKmtLEN9nj+NskGrkBylNCj/lFu9rmjX1c1dYwGX2di4JaL
 bxjy4ewYe7I3oqovQxYKIsVatHdI2xzVUQMc7Lp4hsk/drydTaytAmxwDr+4Beq5Q+sUX4W9a
 BCqtHd7w+PliTx0DVMKxoTi+OueJ6uL/tBE8ecsIgm8EItzmjzEKZN3kGJAGxdXWcHsVxK1dp
 6mUjE3mOn8W6TYT3H8b+34eU4BbfJasVersxlxwpUqSDpfYkSj5ITjxRA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/24 20:49, David Sterba wrote:
> On Fri, Jun 24, 2022 at 02:23:34PM +0200, Christoph Hellwig wrote:
>> Since the page_mkwrite address space operation was added, starting with
>> commit 9637a5efd4fb ("[PATCH] add page_mkwrite() vm_operations method")
>> in 2006, the kernel does not just dirty random pages without telling
>> the file system.
>
> It does and there's a history behind the fixup worker. tl;dr it can't be
> removed, though every now and then somebody comes and tries to.
>
> On s390 the page status is tracked in two places, hw and in memory and
> this needs to be synchronized manually.
>
> On x86_64 it's not a simple reason but it happens as well in some edge
> case where the mappings get removed and dirty page is set deep in the
> arch mm code.  We've been chasing it long time ago, I don't recall exact
> details and it's been a painful experience.
>
> If there's been any change on the s390 side or in arch/x86/mm code I
> don't know but to be on the safe side, I strongly assume the fixup code
> is needed unless proven otherwise.

I'd say, if this can be a problem to btrfs, then all fs supporting COW
should also be affected, and should have similar workaround.


Furthermore, this means we can get a page dirtied without us knowing.

This is a super big surprise to any fs, and should be properly
documented, not just leaving some seemly dead and special code in some
random fs.

Furthermore, I'm not sure even if handling this in a fs level is correct.
This looks like more a MM problem to me then.


I totally understand it's a pain to debug such lowlevel bug, but
shouldn't we have a proper regression for it then?

Instead of just keeping what we know works, I really want to handle this
old case/bug in a more modern way.

Thanks,
Qu
