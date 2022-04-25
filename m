Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496E350DE9F
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 13:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241625AbiDYLUH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 07:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241668AbiDYLUD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 07:20:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16FDB369D
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 04:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650885387;
        bh=0/qHZtSQgzUwyrZLT6SBJtvtqedwhlAqUCFhdSmfaWE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=WX+nUPbl/Pl7hkUeb5ZDKC02xiRciAmcelbDsQyC8JuMBMpeC05IL/M3CSX9n10aP
         bYNyZDRadZt5GkkigTFfLUsm1GktH0QeaHc6KqlLMkMKfcRtP/yI+BNxmACxESe11h
         szdOg1/On1diugQyh6ebcnAEwsi/rw5XbcULdRso=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1wll-1nuC6F0My9-012LO8; Mon, 25
 Apr 2022 13:16:26 +0200
Message-ID: <bade7fa8-d95b-e0e8-0af8-e40fec341789@gmx.com>
Date:   Mon, 25 Apr 2022 19:16:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 03/10] btrfs: split btrfs_submit_data_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20220425075418.2192130-1-hch@lst.de>
 <20220425075418.2192130-4-hch@lst.de>
 <62f71a43-8167-f29f-8e9f-d95bc6667e0e@gmx.com>
 <20220425091920.GC16446@lst.de>
 <458ba4e0-15f3-93e4-bc17-ae464bdf13e7@gmx.com>
 <20220425110928.GA24430@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220425110928.GA24430@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zJB+uhEqwWiuDcWHO2dAgQdCLu09zQxKVU7vmgPLSJLNOI+KDNj
 wDfsbgP0FG7wu5uPn1iUCTxyZf4JtQ4Jb5ymN8Jq2gfRQgyL3ChcZ4IKilNQUfxehJO8fBp
 jYOqzwbRJym4/wV7dCc4c9VJBXOTXCJg5AWf0951fINS+PSSGPLxDWMVGKzL4whixPiDKAf
 VkiFadAbf32ruODMDaYQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e4trYRngVJs=:YfvsOeL4hDJTo0Qk5L28UH
 HWK20/S0K47i8HZ2/ANwYHby94wYZ4i2rZUvEbtMfAzczSd0x+KMODJlHq8CaX8DCR2o9F2as
 ws73TAtzAj2BMkntzRjaGTnO8XkPCEnVO3GYPEPL24HL4MDll0W4V7A2klrgy4XUqd5zF+66y
 yQx0kbnLgrWcchUjvBq3fc/fsTpTeGnQ0O4j234ez5vRKXuZWQJ8zzSrPORQvekH7YDTGZXVP
 VvPzei8rvmhtIMCrR34Fad6y3P5nA3b9oacoIrcru14msYd+mxl2j8iczWVxNAq0uBaMTfnpt
 94r2IYKN2AyouA/OqrmSAAo/TGgV+AKQXLxY25cMUALIqXFR8eacGWn6QrBlcdQ7gS2BNOi2l
 xl2Fre1w+gMYc+AvAbem1car2je7+VgH30Xki4H+Ubha7U8b2KL6hP3P1lg3yYubJYvcOmuX0
 0mq5O40GcCsoP1gwvOs//Sj/f+hoNv9m+46zrKRDeM3v7wK0HG1nd2pMnNHK4VPl2qt1v/d3r
 n9+4vvhbh8gn0zq2e8BsGbUIpXs1XJYE7RG/10ol4KapcGRjL3hk+aBi3tVDkSSLD6hgRqh1b
 aYQieXF1MlqMpUT8YJc7ffhbkovC+r2aWfGCwFCtnmBCacTsXSkiotkZMKmEZFXrOPNFEQyEd
 kmxUmwS/mng8+50gz3Q66MT+QuSQrNosJ+Nt52Bq33xy2u1v9uuDawjUOKQAW7TQDRX03DQxu
 p+XFgNwQxB1KRk9iaajmgindpVkkfw/9fxCkJbliGsUIvmBlp7gB2Uyi2dOO8C8e7QZGEgA0o
 53hAVo5K47TzNoUOwxtb5YES2w0zkZlXcqPtPzkzVS9W3686WTFlFH1C5AFGJTDIFK08LH2f3
 IMC7j4xYwUPuAsi1lBG2sr+jnZl78Ad3+nwuIQDj6HI96It5PWR67z5VzOHf6bnca1aEyI9op
 323gzFr+JLyB11AZtiogYR/zK4dD1XcN/z4tt4ziUYG4rB8t/ZohqGjWbi6KYOH3VuldrQwqT
 bR1XbfbNMN2U0ZmpZ5hslmJd/GsrVqE4quvbsp3dWsRYh23+jnxDamWTIuhK0z1j+pupWvV6O
 GUbf49aG+bwR+E=
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/25 19:09, Christoph Hellwig wrote:
> On Mon, Apr 25, 2022 at 05:37:40PM +0800, Qu Wenruo wrote:
>> Oh, please don't completely get rid of btrfs_bio, even just for writes.
>>
>> The btrfs_bio::iter is pretty important for us to grab the original
>> logical bytenr of a bio.
>> As bio::bi_iter can be modified by lower level (does dm modifies it
>> too?), or btrfs itself.
>>
>> In fact, my incoming updated btrfs repair repair code heavily rely on
>> btrfs_bio::iter, both read and write, to grab the original logical
>> bytenr of the bio.
>
> Then it's doing the wrong thing.  I actually have a series to remove
> it entirely.

I'm wondering how would you iterate the bvec of a cloned bio then.

Regular bio_for_each_segment_all() will just trigger warning on cloned bio=
.
If you go something like chained bio, then any error would mark the
whole range error, and in fact my repair work is going to make
read-repair work with chained bio, thus I have to directly iterate
cloned bio anyway.

Just bio_for_each_segment()? That bi_iter is no longer reliable, just
btrfs_map_block() can modify it.

Anyway, what I really need is just a proper way to:

- Iterate bvecs of a clone bio
- Grab the original logical bytenr from a bio

If you can do that with extra members, I'm fine with alternative ways.

Thanks,
Qu
