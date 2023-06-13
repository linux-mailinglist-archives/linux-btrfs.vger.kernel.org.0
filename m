Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CB972EF09
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jun 2023 00:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjFMWRm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 18:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbjFMWRj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 18:17:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AF910CC
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 15:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686694655; x=1687299455; i=quwenruo.btrfs@gmx.com;
 bh=DQprXeLHLhGQ7nBTpydwXEAMt74K3wyOOif5aSD/bmM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=sMYaIqo2/Yld7WTwWInNrMy1By3K9LRYhmZSmUq8r6+YK76gJe9LcEVZL6/G6TrDonYs0Vq
 +h+Pd925CJqRUPuTncvq2MftRswgBc9w7WTKHr1MdgGJIcUjJUH31RAtar9jZc05+TwhHKl80
 JeSkkPbCOYVvuEVNUGRUrmII46AeQoipPvG5V6M6POzqMDpL18rspC+AtcXWa13lD35qVpjAS
 uZFUMEQUKR6FFS5qCqtTPL5zeRUjiGI06wvgyCZ0GAnF2GQdK5gzFrfZ9I3WnHVcJD6Kx4Ze2
 4lHKSSDF7kJs83sArV6nRDewTrvAQuv9rLokXDgFb0V1vSSmxUFg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mwfac-1pu9FE2LRC-00y9Yo; Wed, 14
 Jun 2023 00:17:35 +0200
Message-ID: <0523f743-38e0-bc21-df4e-6a9d4e842ecf@gmx.com>
Date:   Wed, 14 Jun 2023 06:17:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Regression that causes data csum mismatch
To:     dsterba@suse.cz
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <da414ecc-f329-48ec-94d2-67c94755effb@gmx.com>
 <20230613160247.GK13486@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230613160247.GK13486@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v+YUvF7lnPdlumGF9RMqGTpjwqYsCLtCmy4lga0Xt1oaSaPOUz6
 Zl+0fZ6R2f+tMj4tGVXlJt83RrYw8dWgG6C+G5JU7VqMtZjASWc0Clk/fMO26QQCVIdT8Lk
 0lTU70QTB60PS5h208x3eS2O0MOanYrSBtGdwQTe4+iGrSbL06gGMRvC+0D/hQEkg0ViNbe
 vym4xFlQHrv/pIE+Sytrg==
UI-OutboundReport: notjunk:1;M01:P0:Lc0nzjZE1to=;E1Eda8qGjjoWK7PGqxL/JMLRagX
 DNdhi4qivnW0GaKNB60M/OwLclcii637c2naRLN6fhI9PWAQVjPTw4c844I9WS3ogq1u8W32p
 BqCHav14BEnM8hIciLup0IUu/9ap/IiDUxzLegO0JinscdXmRGhrCqsq9PtdVpnZZzNFO8+AR
 eNF3mt/QLYr/mtYJp5wYpoGitAW9wd2Cl6vkt7H9np4cO0G45Trycx41HMO/SwShUMOSlLCmk
 H0dWHD2DVyoN7aS4bTlI90gX7injfdOgkt1f+5rNPPcX8+vu0dGOORlHKWjWsDk7fMlVOSr1h
 4Kzk8sRn93xiXQmHfoDdpzT5LL5snFgk7qlkkbJxv0bQm8m83gdO+GGujH/bFH6NJjivHQMMe
 CZKzqdmnyMBH1CA/+wVveFMAXaCfl1GVsO/NWyapwlXxiKl9xoGqO0CLiV+fa+9d7q2aRt8f2
 EMSiGQbTEzHEn1af4l7qLzGDcu6mZH4jdMZ5BV5js0BvtfYs89Po93zaDl/dI6J95tDYpDymG
 LwOCpKLz7X2eJpcW3qYLTVPvoK5jB4CSwo7JYGoo2sjAra5FuJ+nMtNuFr3rj/xPymb3rLGpv
 0xYwCRWXlNKBtBagW9BoHRVshda+9gzjRKX2D+zXNX/6G4DtPF//CxoCz4CqOgPRQwAHFHos5
 zyBMtVUPuBETnHyGqQqc7n7/0qxpkM16A+mbbBgbnOICuQygSwoDOurW7EcXZYbMc9731lyHL
 wqmN9y44QS3EZneIF07/5cIhNZhPVQqBASRgvt9Uy4tL0/UNlpa8RtcGpyB4POIBnV8Q2JlWj
 qw1UZLtucJ00w9wrQfxJuPwglT09dsPB/EiVK1tUiEmLg4ugADMGtMXnscNPpfP0mbnj99Cvv
 mouVe7Wu1lQ7xxiSCv/S4vhQkRkDvrI/MvdbVdybxPCJoDzGllPAySMlCmK7YyyS87A4ksIcn
 UgyV0LGAYs2aLlOv5xsuSKHuamc=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/14 00:02, David Sterba wrote:
> On Tue, Jun 13, 2023 at 02:26:39PM +0800, Qu Wenruo wrote:
>> Hi,
>>
>> Recently I am testing scrub preparing for the incoming logical scrub.
>>
>> But I noticed some rare and random test cases failure from scrub and
>> replace groups.
>>
>> E.g. btrfs/072 has a chance of failure around 1/30.
>
> I'd like to get a list of tests that could potentially reproduce it.

For my last reproduce, it's pure btrfs/072 loop, no other extra test
involved.

>  I've
> started 072 in a loop but given the frequency and also a possible other
> factors this probably won't be enough.

Last night I ran it for around 4 hours, but surprisingly no reproduce
any more.

>
>> Initially I thought it's my scrub patches screwing things up, but with
>> more digging, it turns out that it's real data corruption.
>>
>> After scrubbing found errors, btrfs check --check-data-csum also report=
s
>> csum mismatch.
>
> It would be good to share the updates to fstests with the tests. I've
> added the data csum check to _check_btrfs_filesystem.
>
>> Furthermore this is profile independent, I have see all profiles hittin=
g
>> such data corruption.
>
> How does the corruption look like?

Just some csum mismatch, which both scrub and btrfs check
=2D-check-data-csum report.

One of my concern here is the temperature of my environment, with AC
running it no longer reproduces...

Hope it's really just a false alert.

Anyway thank you very much for the extra runs, I have to say my systems
are no longer reliable during north hemisphere summer...

Thanks,
Qu
