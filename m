Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619EB4B8809
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Feb 2022 13:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbiBPMtv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Feb 2022 07:49:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiBPMtu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Feb 2022 07:49:50 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF4E2A4168
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 04:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645015774;
        bh=6n8IyqiFN/c7FWIW1+V/9i22pWGQM3z0cxtRVSRiXiY=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=i32e5OkoeCqSa4BVLJevOhDvUK4a/QNjMDcR8xRzOGO7bG734ZA+/E3qJMkJt2WgN
         FVnDNLbscyHa79NV7XnN1UNifehaBdYP4IHsSjGKr/dCW5fmL4vzKJ5LuS1jq7S8PM
         efDI3jNRs7f4T2cWPhpnL/D4WQLxEhfllknktQhw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M5wPh-1nNKgI0XN5-007YoB; Wed, 16
 Feb 2022 13:49:33 +0100
Message-ID: <1e93f7ce-b5c2-e0aa-9323-27d9b8bdee27@gmx.com>
Date:   Wed, 16 Feb 2022 20:49:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, stable@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1644994950.git.wqu@suse.com>
 <d2ce0079f3d2144876f019575858b392263089c4.1644994950.git.wqu@suse.com>
 <20220216123759.GP12643@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH for v5.15 2/2] btrfs: defrag: use the same cluster size
 for defrag ioctl and autodefrag
In-Reply-To: <20220216123759.GP12643@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vtzJR/3/VQbEAHo4UOwhz7W3rDqf+O78XQLztq7qMzArbQTYiZm
 RfrzlLTHdFDXDTL8coLGP83SMTLVnhedkM/82Il+RPfibhqbdzU0SAkE0afv9BKhtlmEdfI
 YEQqDUOJoMxBCZvqzaKLbAlQ6cjkTrTwANpGu+4X9ZoS3mEI5p66+xVJWhaqWIHmgTMuxXX
 cfMqhvZK9Vj/yFtypcvJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3wcNPGODvaw=:iRsF2DiPo3vgHyyvcAkqrB
 MWzazjabR/NOzxbknxDfBIY8N+9q9W/bOOfu0oEHULpeQPI9qsRVn6XZTQOqYr5r5x+NYY1FY
 qtBWdU3l7+XFd5X+UOg4QANn8KuBYmk8G2DtoRTXiyxZAV2hWZ5e7A6YwJ6TiKJ7NQOT/Biki
 Ot8+Lg062IbMVdESHLWuzJWdaK7g5xwkE1fW8gYx2NQ44DYUD02BHNQHmf69TKelbsgv3cDO2
 qjjll76dJl9J4VJYdYOC5bFEt/qke3J+89EoRovXSdARCzrQ5fWXTes22jVnnxfIbuGPGWceg
 fFRLaroBZdRJ4fqJvU6mgDZU+NWcJdB/CfNt4VLQ+/xxZuJwH8TOd6VT+sXbAXadoKnnWGS9M
 hawOdZls9HBh7+TgvdlRsq3XEbmSSsiIjSgwDAU49kwJDDQTdm66mogTHaI5OnatN9zYpIW/B
 er3sSll2rtNdx2RS2hcRNzMV11+RHOwunLRrEDUELSnE6ekTaKuvY4kpDqnWx3rLKH2t6+XQz
 o6AuWEEsYNCeOEONaOqB5UJEP7On7SQvFusytH8TPWBbbhEJIQpDz27mKIlfDiu28Puc3wMTH
 ZNiBZoAn2bdyfm5x/nVClCXhYeHl5v+YbaR1DPgdIhN+0cdxM5Cv/6KEEFBDC8mQi4pJ5bhYy
 nPOV/MRWNPmrdbnZ1xuBAiIMe7FVTchjvieak3PSP2MQW4OpAO8Oyw38yynyMsUGPjfB8may1
 tXT3KDb67gApQPPuzU87WzdDiYtp/E9m1ISw8NTiQVWVmhK3bQpI3ygyJjxVoJ21vx4Qhxr08
 NXR2n3hUeRuJwgXI58GztZIKgpxkwVLwYCqBhb7//qdFurYN1DlHJhu13xCvx/CBaw870l2sb
 nkT+7/6EuIjDPa7jyjQ3V1vi8V0PbO3KpUPX9ptooBi7bNR7F45AsD74IkWXUPYPpMxGkufP0
 MRICtE4v+MPxx1n5PVyFnn0NflTz/MfLZf7Bny21uuv1Q/9UIovnUcdDMRCyY6ErrhtX0O484
 ZNNCK+J6y+mdeWFEi7MkAM4NrNOgrFmxv9nYL2XxsNVOG2j4jvV+ecI+qfJlHY5UuCuqgzxZr
 1cYbhgUipqTOjY=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/16 20:37, David Sterba wrote:
> On Wed, Feb 16, 2022 at 03:09:08PM +0800, Qu Wenruo wrote:
>> No upstream commit.
>> Since the bug only exists between v5.11 and v5.15. In v5.16 btrfs
>> reworked defrag and no longer has this bug.
>
> I'm not sure this will work as a stable patch. A backport of an existing
> upstream patch that is only adapted to older stable code base is fine
> but what is the counterpart of this patch?

The whole ill-fated rework on defrag.

>
>>
>> [BUG]
>> Since commit 7f458a3873ae ("btrfs: fix race when defragmenting leads to
>> unnecessary IO") autodefrag no longer works with the following script:
>
> The bug does no seem to be significant, autodefrag is basically a
> heuristic so if it does not work perfectly in all cases it's still OK.

Normally I'd say yes.

But I don't want to surprise end users by suddenly increase their IO for
autodefrag in the next LTS.

This bug is really setting a high bar (or low IO expectation) for end user=
s.

And another thing is, I can definitely create a local branch with this
fixed to test against fixed autodefrag code, but that won't make much sens=
e.

Thus getting this merged could provide a more realistic baseline for
autodefrag.


Finally, one lesssen I learnt from the defrag thing is, if we allow some
untested/undefined corner cases, it will bite us eventually.

So I really want autodefrag to behave just like ioctl defrag, with a
pre-defined and predictable (at least not under races) behavior.

Thanks,
Qu
