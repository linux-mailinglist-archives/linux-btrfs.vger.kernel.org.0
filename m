Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B754F532AE5
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 15:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbiEXNNr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 09:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiEXNNq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 09:13:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C484B92D2E
        for <linux-btrfs@vger.kernel.org>; Tue, 24 May 2022 06:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653398015;
        bh=jbMuaiMvKfN58NHdOhjmpPdsayF+Voe+qXgr9teRmws=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CNyBdPVT1IHdyebUfJ5nHzQlp8EosmS3yEBR+qHBlugpf1bbd4UCM/z7vIus3qbM4
         6+nsN6KDXU2om/3z8Ni7QPQxO4Fl4rHRl+mcOwjCHndMChqFpybaeE5BtHa7Orgu7i
         C9TuNx1RdPgnDWlEUSPWR5E6a0SewlL9+NowBwlo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MEFzx-1o1V5n1FrR-00AGwC; Tue, 24
 May 2022 15:13:35 +0200
Message-ID: <d966f776-79d7-1eec-efe0-bce1c771bc77@gmx.com>
Date:   Tue, 24 May 2022 21:13:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 8/8] btrfs: use btrfs_bio_for_each_sector in
 btrfs_check_read_dio_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <d3065bfe-c7ae-5182-84de-17101afbd39e@gmx.com>
 <20220522123108.GA23355@lst.de>
 <d7a1e588-7b2b-e85e-c204-a711d54ecc7c@gmx.com>
 <20220522125337.GB24032@lst.de>
 <8a6fb996-64c3-63b3-7f9c-aec78e83504e@gmx.com>
 <20220523062636.GA29750@lst.de>
 <84b022dc-6310-1d52-b8e3-33f915a4fee7@gmx.com>
 <20220524073216.GB26145@lst.de>
 <6047f29e-966d-1bf5-6052-915c1572d07a@gmx.com>
 <b78b6c09-eb70-68a7-7e69-e8481378b968@gmx.com>
 <20220524120847.GA18478@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220524120847.GA18478@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XQM8szGcNgC57zRMWpAX4CRLK2RR4j142bE4vFY4SAWEUd40f6n
 PIjw6zfvimdP4THIUIm/yMAkiiXcraeYRkksnFnY3HdTKhku0XMII7Ql/jQ8lITRogyTP4F
 2yBBueScvxOCW7TNi10/19WpN6G2tUVh5HN8UwNVEiJkckr5Ahq1pgu1LYWLGUmDRTxMPNL
 IiDMy/uoum3zqo2rbsJHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+5F5ecMFoC8=:7v4aA4wCZwkwPOw8MxJREz
 JNvxhRaDcrdcF5slLP17+aCa/Hy+0F14v25kJNSOe5o8dg4uaKOeL47sp7m9ggIiUPHZmXn+H
 7JaYmwtg8qjahTu8/cu08U/w+chk5GsXIxfSxIA6E3nbY+z11aj1iT/konLfDn4qJqQKc6STf
 pi/FtUNXW1A3lyWlzzrM0UWZGKOkn/lEuEoUTw1H3zkeK/fazMe+cPJGRWO7Jtnvl+bwSv0Bs
 LE1b9VBg/fwA+pYoCDTCGRsrHnfrQ4/LAV0NoGsn7lMQfl2sPOM5PeKNm5fFtq5hGXIOFhzpG
 p2GkHLDGdutp/h9GQoRwg6K4MhSzBidGjqm3VHO59C10/MW0b0AfNsx4sl7H/Y5NfWjGbrWFC
 He334KEvaaFUHEFi0b+QSrzBhFJ4DKclIT6iJ74utaA/w7X3uY863uq8/YfVGZ+Q9aW0WKauE
 3SF9Tbn6vKgbbaiQnNkNZSDFM5AjDIVbnTEsDZ8m9ZsdoM2FzB6/uMQm0prB93JjVecEomOy2
 JNr6vz0loFs2z8PrJGgkworUsktJE99fwD7cE1KTZMg2sFezqxAGOrEZ7R0YXG+9AuXo8wy3p
 bCbaHQiYiUQNBkNxEc9GavVVfOxRyltgwJWVaqRxH7qjTXiOC4/T/R6xoAOS0vjpttBFpLbgg
 5QXZrNDF1WEdG+on6Np2HdOzL+ziK71mPOlXqhUd8nj42F5E5WOAt/bTgl8Gfm7IAjj6+ZWSJ
 7gSScWckxSV3EGyFKXP0KYXPEPYqA8SgpE8UJXlsOOgjz1rCputhHQcpN/EY1Yepno+fnC1m3
 6DHtthAO7UKkH7nsLjRP25K4rPCsgfH0K+ePP9x1v/hj64E9nnWK2lmyaW3IVLP7tH7h75U41
 41Zx+EQkRZebtMj2lX2HWgZdNxZA8Nvd+4FgaNkdKjcfPGuaodzbq+UwOpuBBK5SYeF7lpU8L
 0hzA1t6pekqIcT5a0JWCwW6fxXV1G894chkYchoW3xx9UhwKiH1aoQGtt7cTQiFhJero5rIVY
 hTq/Fk0TfUTdiRp4AnOe1ID5voWWnZFdxEsQreatQdV/9SpDsJdyl1Zm0bduMPpftB6e5wRxD
 ZVlJ8UKesXnVvLlOKS8DXbIsRd7r3TbpVbdV3ChMj/pHR+u61ayFG6cjw==
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/24 20:08, Christoph Hellwig wrote:
> On Tue, May 24, 2022 at 04:21:38PM +0800, Qu Wenruo wrote:
>>> The things like resetting initial_mirror, making the naming "initial"
>>> meaningless.
>>> And the reset on the length part is also very quirky.
>>
>> In fact, if you didn't do the initial_mirror and length change (which i=
s
>> a big disaster of readability, to change iterator in a loop, at least t=
o
>> me),
>
> So what is the big problem there?  Do I need more extensive documentatio=
n
> or as there anything in this concept that is just too confusing.

Modifying the iterator inside a loop is the biggest problem to me.

Yes, extra comments can help, but that doesn't help the readability.

And that's why most of guys here prefer for () loop if we can.

Thanks,
Qu
>
>> and rely on the VFS re-read behavior to fall back to sector by
>> secot read, I would call it better readability...
>
> I don't think relying on undocumented VFS behavior is a good idea.  It
> will also not work for direct I/O if any single direct I/O bio has
> ever more than a single page, which is something btrfs badly needs
> if it wants to get any kind of performance out of direct I/O.
