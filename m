Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43824B632B
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Feb 2022 06:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbiBOFyx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Feb 2022 00:54:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiBOFyv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Feb 2022 00:54:51 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B361E75601
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Feb 2022 21:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644904474;
        bh=0ug+as133uqOoygkqbIDJKdulkhW4cW3mShTHLr1ZD4=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=LW1Kql1VR70jjNLPSYUexIjVJtnlfKqAydpq4x+fHQKuSMh2ZI1Gzoc4Ze7P83zbs
         ZVEIw0UxLoy/l1bGJyLL9Zqe6DOYtJ1b6ZXMbs9FQC1Z8JbnenXmqgcxO0/BKoKsMo
         /dWYpDFybiBIpLGOISdsBC3DWf0mi8lowpzug5WU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7zBb-1oN96A2L2p-015452; Tue, 15
 Feb 2022 06:54:34 +0100
Message-ID: <39aa76ae-3d4e-8df4-b88a-e9aad4cbe95f@gmx.com>
Date:   Tue, 15 Feb 2022 13:54:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH RFC 3/3] btrfs: make autodefrag to defrag small writes
 without rescanning the whole file
Content-Language: en-US
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1644398069.git.wqu@suse.com>
 <fc9f897e0859cccf90c33a7a609dc0a2e96ce3c1.1644398069.git.wqu@suse.com>
 <YgP8UocVo/yMT2Pj@debian9.Home>
 <32c44e26-9bd1-f75f-92df-3f7fbf44f8a0@gmx.com>
 <YgUzsYTCz48nB/XT@debian9.Home>
 <23693916-8269-0357-3a20-5e281cf53ff8@gmx.com>
 <20220214163557.GF12643@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220214163557.GF12643@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2lzzcjLOOK/Oz1/eITYZsIqQ9tkZ7X/BcOzQ9DqvzWxLtP9Ps9m
 46B/6m1wTssDjDA+WXx/UlXqNJgzuh5uBUcr4RiP+xcWIuzS9s2Q5Wpg+fTmIaRWXHiErfz
 Iuinb3xHZhYrrK1n9yEUwUZq7q/yN9+KGm9HptKCyC8kvEAgwBjF6fBFmQ3eYm5hQHBQA5W
 76n8yMWFBW1uARd7aEV9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S48MSn/Lzuk=:4ymewNQ2pGSKzZkZK5orlp
 12fp693OB/c9AdiJ+k40VMxxV2kvfPT8IWxSBzqTF4rg+mX3uc0NMvDdntif25lKm6geY/vGE
 hk/8DyKVuygqAN6c1aucvl+U6qJ6FZuFmVr6CTICTl09PPJRbv2o5s+JJ+AOxm/attM1f1fDR
 o9mZDTKB90/kcWPegd1hqxFv0Ungn+odfxHDN+J2AEsRKJGfYhyImW6wIpGVXyv5qv2d9LkB1
 0JMN0EJRG+6/tOXc4oh6n9+0UFHcl9T+Yy7nOfuAR06h4W6fF2XMfRMBdAyZVWc3CdvDrW44q
 VMmSxoberR/ZnWjGwd5CobtvznwEjtUzV5lH3FnTnpJo5qznbVX0oiQv5Bw+IVlFkvrmjmOSh
 xvzi5G5Jn3LgmEHRQr6CrJsmrxIu7mG/tUyL37kVRZPVbwxklF6JBOmhk1xHrWoOVJszgaBoV
 MYLIl9oyPKeSnqtaA2sKoNM9CBJoql3/4vB6BTo7QlCkXKnKi/cEvgUlxdH8jEmFyqPrS1juV
 QF5h4WhWlk0CBt+ymKovx6ex2JG3ES1okCOZUHwab5BPQC1OUUQRqwIXlPznrDYsacq94FQZr
 dgJX/fjSfRTNYw1U0JCbfdg03Hg0lHfb+3Q+5wv4t6Om1TDzULL2fkuutGQnarnkvLcDfOX24
 yQAL/frSzd5mIYazj/i+oPDTUe/h3+RTYuwORWg7ROGJqd3K9o5zleBcjsL3JalzUeQyrUVXX
 DmBGzCzLXfYMV6NvZFPB7hEvDTZjHwL1RDao4dpLlDnNw0Rdc3pv+SZmXaJPBuF3fSG2S5UmX
 e3Wa203iPkzxv6L5dtKEKnHZqkFWpS/nqIfPYECe7wD1BE7Tb2MBWFF4OG11pnVMf8Nl6ZjDx
 yWHyfsARUM2q9D0psYzMYpbkqYz1Ro79HCng+6ZaD4u0/1EnDMzuxOu0G6ZXGcBDrX8racNw8
 RFQzDHLo8J7qUlup0xY2CKU1bKoNQgQZOsqeUjBclrqrALb8F+2oFG3Bpoojph+HmfqSqDj4E
 NGM2i7IIKT5Jf3B44cQY00n2gbZ3ipFj90Yki15ov5d8oaGihyYEhRAvSRsfSvKIRlMMPL0Kd
 Nc3fcbYwkAE/fg=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/15 00:35, David Sterba wrote:
> On Fri, Feb 11, 2022 at 08:24:13AM +0800, Qu Wenruo wrote:
>>> As I read it, it seems it barely had any performance testing.
>>
>> OK, I'll try to find a way to replicate the IO of torrents downloading.
>> To get a reproducible result, some kind of replay with proper timing is
>> needed, any advice on such tool?
>
> A file generated by torrent-like write pattern can be achieved eg. by
> the following fio script:
>
> [torrent]
> filename=3Dtorrent-test
> rw=3Drandwrite

My original concern here is how to specify the random seed to get a
repeatable result.

After more digging, we can specify randseed and allrandrepeat to do that.

I'll do benchmark for the new autodefrag patchset to be more concrete
about the result.

Thanks,
Qu

> size=3D4g
> ioengine=3Dsync
>
> and you can tune the block sizes or other parameters. The result of this
> script is a file totally fragmented so it's the worst case, running a
> defrag on that takes a long time too.
