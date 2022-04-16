Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4144503487
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Apr 2022 08:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiDPGvU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Apr 2022 02:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiDPGvT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Apr 2022 02:51:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F6EFA238
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 23:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650091723;
        bh=UK5MYdEWItmZDpGZC2ZBCfm60MIV5ClK18iden1ZPps=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CfwrCUp2FltTElrjcg7F3+Y0mg9riINRxInmIPk59t7380/ko3Xv+V/0h6llMbApb
         e5+8JaOgAlZq/Srbh5/0lmPALCinr3O45B+X+2ymx2yNUwSmQ29nY/wyf3U6H1TD9D
         xrR6AfpBtX2trf6V8nYsGqbZYvb+rP7JRlygKH5k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MEUz4-1nhFs81y1K-00Fyjn; Sat, 16
 Apr 2022 08:48:43 +0200
Message-ID: <eac890d4-f85f-a9fc-0088-3d55dbcdd3a5@gmx.com>
Date:   Sat, 16 Apr 2022 14:48:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 4/5] btrfs: do not return errors from
 btrfs_submit_compressed_read
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220415143328.349010-1-hch@lst.de>
 <20220415143328.349010-5-hch@lst.de>
 <935e4667-2414-4620-382c-333075150f8f@gmx.com> <20220416044920.GB6162@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220416044920.GB6162@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TFsPT5tSgFRUMTMdnifBpPMa9sTaHhqv1ws+RSLtKqIMkeSc19j
 k098qMu190QlaQqOn77wlb0IVyqkNDmci0olJmxQ4uUmxGIHG6EqXGieHjNuyWgiVqSn8eB
 sf7e5geArNnmnT/zxS+hG0gIxM8IZUrYJfURoqrBlRs+b7Pt+Yg8Iwv9QBYZ8mvCT+IqAAl
 ekXnU84Y+TxU9Hpp+n/uA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XZbc450llhU=:b1r2XF9HV6hSlBY2I2v1VD
 Hf8GGJmgZT3vZ4dZiyrS7uMOXxzBF+10lc7kdOqAs4EZ5cRsZIo3ekelo8dZY0e//QUohXViQ
 WHKAzwhhef3Ra2b2Q9mlOQDoDW4+CtHlcCt0Ic3VCPv5+n5JGQvs+eLvg5MeG6b5YIHlQwE2A
 zHFL/srBgBJLdJidr44GhcRaIY8qyIDMTvN/MqjHZkeUUa9PwwhGC8j5t6XYbGk1Ui3BOTllI
 M+gJr58HAvSEy60bt4SIW0BzKhYBuomL+rDk1CiTxZ1OAxE1K7Mtg+t8/ILJ3cVdDlYewloFz
 4j1Y4k9EQAe0yZ9Rnf1hNXp12UHBJ0i+hbpwwj4SqUpMzx/KnIRtffmuxPmEiOmGnjqNU10m3
 uG0xu1ymWB1XWd87hIVq5DtMGNFoz01OyDF9M/r/4mgA5+usPnmbvPHr5Z27dumilt7TsSLUN
 OTk76mR6/39r72roMRiy56l4wfIT8ItZcf+ijbEVfkbUOvRw6VsG7saB8M5ASOWdyo/76Acdz
 I5kTh5sOa0BhwGUXhEuyFeMgYFv71HZXP6lvYUCahpi5Y2GZG8sDMlDTaljOVWnuUu9OZLNez
 i/kIL4QD2Y7I2NZWklmSwofTpPgrEyUJcUsEmBArsNIiQ8t+2JmsnahT081AduunIJJ7WwIfX
 Dqzw1fSQYW0vloBSPE6fzMTJJKBjiRNrqV1d+o8ZkZUSkuvArvBfdVt47VOqMAKU5/XPLJ+O+
 0vLSW1muaWg8QjKtIrr73m7l94dJ83SHaw3Tm/vHrMmV7u/FvhiRyCl3yx1EcCmQd0nG50fDt
 XQv+x1eyKtRKxq9niX3xhtFdYMStPixsFn+yOcvZ61JRK72wcYe2/6+IgL6fSxGRr9bKf9Ifg
 zRt8q5X+kojTav8/eBMN++wU/I/4Aq4vyVSocQvkfrI6VYGyk7R+HxXnxTI6RsI6siesWuOmX
 ZNXAjK/VB+/5Vkfs/4TKGSKfcyN5CG2YHIU4/m6+DxNqcG4HJKUZp0jNV2qA5P456ENueu8RC
 4hGDGyKHcvBBG4v5jh+aK5cTmqr3wPPBWLNHG96sqe3hI/0U5jwOn1wH0MEc41KLzGo6bTwW5
 g4ysrK0GB9eTQs=
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/16 12:49, Christoph Hellwig wrote:
> On Sat, Apr 16, 2022 at 06:48:37AM +0800, Qu Wenruo wrote:
>> More and more bio submit functions are returning void and endio of the =
bio.
>>
>> But there are still quite some not doing this, like btrfs_map_bio().
>>
>> I'm wondering at which boundary we should return void and handle
>> everything in-house?
>
> I don't think it is quite clear.  All the I/O errors with a bio should
> be handled through end_io, and we already have that, module the compress=
ed
> case with it's extra layer of bios.  Now at what point we call the
> endio handler is a different question.  Duplicating it everywhere is
> a bit annoying, so having some low-level helpers that just return an
> error might be useful.  I plan a fair amount of refactoring around
> btrfs_map_bio, so I'll see if lifting the end_io call into it might
> or might no make sense while I'm at it.

Great to know that.

Thanks,
Qu
