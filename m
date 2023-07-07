Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B83474B02B
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jul 2023 13:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjGGLp6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jul 2023 07:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjGGLp5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jul 2023 07:45:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803BD10B
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 04:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1688730346; x=1689335146; i=quwenruo.btrfs@gmx.com;
 bh=4J0tTaHKbNi/VolGjY8BEGtr1vwX3iLFvd7gbMR6GUI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=e6hBZDyEvkiH2tN7pxsCTZ60PN/3BxfHO+zi0vBtAZPIZfY5QCEdQWHkh69ENjlVgluk5Yk
 3XQOJsJhuBc7+d4HevlvTKwk3A2qd73Rfywul3oLytAuS1iuynNK8FFPOvFTgdRRwnV58zlYY
 noKz9kqEKGKc0RH9YKDdqf1xeVft39fRprx07ynHvoowEUg7Xtr3m1NUqWST0yIbWu5Whmj4d
 UgPImknezskFJ9T5giFwt2qQylzw0p+X8/ZuPCsI5qvv1+xjrp2YwyK02R7d9L589AMO1MGIR
 o6J+pKX4AW399rzJ6rXKCdnZMSH6Iiw28pDWtwCP71GEGn6CSXMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtOGU-1q0TdX1VxG-00upIF; Fri, 07
 Jul 2023 13:45:46 +0200
Message-ID: <6ce97a6a-7068-311e-a63e-c6171321101a@gmx.com>
Date:   Fri, 7 Jul 2023 19:45:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: add a debug accounting for eb pages contiguousness
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230707084027.91022-1-wqu@suse.com>
 <ZKf5dDGx0S1YAT6/@infradead.org>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ZKf5dDGx0S1YAT6/@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gKgnk0kh4cfqDYe5fNw7TpE4F+QXtTR9SPg9wSaUs6zG+K/zE0L
 vmD02p6i2wWniOg9ixU2kyk2zdWJC5iRKAeQCtyvPYyF9ReyL4ocLU0cFa2mHDVFSmlXIte
 vqyGX6yJtr6DtpUQFgR12oLBe378uQksCVk2LGf6p7O5OOoigXZg1c9pYOVmGWR9nJNG0/3
 xM2nlTXEjxAGnvVf/gUow==
UI-OutboundReport: notjunk:1;M01:P0:v8EyZshHiqQ=;Ynu56cYqTuoQSsP9jUPtHacCSPK
 OTQDVIC7twAs6JIi2GeGwt02lIy/4gEnToWCmJHEJgUmXQ8D9TIfC/zi8xcRYHFskcz3GO9TM
 +oO9sBPGyDZ4SHhuwUm6XMEdx059zC5ZBpHosOExX9rc7uq3nKbiKYgNlp9DIiL16YruKUe31
 AOv0Uf4YbKw/55jWrqpdYjEMYSVYHyg7YdmhrtcD9HWJiBuQcQ9ovPOZHsZ0oVX024K69644a
 sB5OJ06Mcf0LdpK7A9LTdPVD6/DwgTMekZ/PSZE2/Ox4debxnN1y++TSWECBn1a/EzFSW8Hc6
 +G3090mX3JpwnUjZtNpOrTMmOJmRiRZNRqz2yWmQKDtXpSnW2S+BwxYaUCDRqil1I60DPQM6t
 xe2r/HxlAzH1VqaCLRKjzsemOU9llVVP5REMzUFL0+9gnpvZjyJAmTNlrofrSxFg3vqVccYji
 EVfVXZj2c1CexvE5E4PVrvfAuJa4NkTJgJnISDBY+B70gzCsn3s24Z93qOwaPeTPFpL1+xW1e
 4IzLkTePlhh3bsyPmOMY6Vyk36btckBWliBVwox7Qh8Y12114XLW4yGroiGXJv7OG/mKT4ghK
 E41EbpoxSTh+cJLPGkU1wbPT2YPsiJdlztO417R1I7G1hyQlD7KvqLXlNLeHNSA2ofSz43Ua6
 nEqLwqa9e4Q1ko9+oBiUz8lLz1vr7XP6coT1p5U5oUC9kY4ZaoGL5mzmTfJPXrmBta2kPvMX6
 19JyyakpZwaYoqVegUpJ7amXUHXJZvd9XtCtkV1yNIIkauU0SUmYhn1pGQ0HiQED5ywzjaL1n
 DPVaOWBjKXJcut0aH5b6hXxa7wYotKABqDicFKZFVk3ZoESbmgdnZmI53zdnC7L4ZOcKChNaP
 t+uza4fYFgbsMJl3rdEyDSTFcdAaOne+XTpFTaarfEwPtayF1EUBcWgc+bIttxDW0qJgyImlb
 PCQG8cpcaCP/b+f7vgD6CPA0Wt0=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/7 19:39, Christoph Hellwig wrote:
> On Fri, Jul 07, 2023 at 04:40:27PM +0800, Qu Wenruo wrote:
>> !!! DO NOT MERGE !!!
>>
>> Although the current folio interface is not yet providing a way to
>> allocate a range of contiguous pages,
>
> What do you mean?  Both folios and compound pages will allocate larger
> than PAGE_SIZE objects if you as for it.
>

I mean a multi-page/folios version of find_or_create_page().

We have filemap_get_folios(), but we can not use it to create new pages.
While find_or_create_page()/pagecache_get_page() can only get one page.

What I want here a something like find_or_create_folios() or
pagecache_get_pages().

Thanks,
Qu
