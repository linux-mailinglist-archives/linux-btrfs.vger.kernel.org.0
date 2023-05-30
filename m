Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C89715573
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 08:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjE3GTZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 02:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjE3GTX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 02:19:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267A6BF
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 23:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1685427552; x=1686032352; i=quwenruo.btrfs@gmx.com;
 bh=t5rvY84gyYff0nN+s6uQyirg789lPMOX+ABDEJHkxHY=;
 h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
 b=QPZ+BIPhzXvQ2xCaTmsPnn959pKLWj4yZ0K7Jh6o9FKDTSUzxXfyLSgu9OKMi8LbubjKl73
 ovqFmiuK05umFnWFRMFXW32Jzc7pVC7a2myfvAgRM7li1GT44Z7Bev6UwaNQHlikyC5OA2fdf
 f8Dkps9jRX/Q9cYt4Dk/z7GSP9Tg140NJ/69bu1hycwJWvVOYSBKsvk8JwZs0YAhR5bg1ZiMj
 WF51PwT917hbtabyongtdooEH5ftHUmF3f7pp64uiMsQLiD2V4FzGTarSxYcGE52uDI3Wt1L5
 37Gy6Yzs2Wl5hBpcHmPEoH21Kwg1lf2WRWc6oK7DaGpqt5OX2xMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MDQiS-1puZ2X2Cvu-00AY1u; Tue, 30
 May 2023 08:19:12 +0200
Message-ID: <8267e2d0-2bb4-36c5-b252-bbba7e18bb0e@gmx.com>
Date:   Tue, 30 May 2023 14:19:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1685411033.git.wqu@suse.com>
 <5b3edb0ed26aa790fa92d0319739adfd71b3b2f5.1685411033.git.wqu@suse.com>
 <ZHWM5U754Na8KyCi@infradead.org>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2 3/3] btrfs: remove processed_extent infrastructure
In-Reply-To: <ZHWM5U754Na8KyCi@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eR8SwlxXP9tH7RHp0Mb5v/uaxLNyaeGlmNKq6ykBakPaMvPiIHP
 m6OeQoOSEKTcqVTGMAKQkVe9CJ3aAPfYA3/hCU1NX9eFbBY1GteZZBfR0qQbAJ817435S7F
 sgvb/+9pwcEmdkkrdIFliiVNNnDLITkTp+JobQGjPWh9xqNGtJP4IyAl6O0UcIif7oNNWM4
 nrvyYjGtK+QO/btGLpfTw==
UI-OutboundReport: notjunk:1;M01:P0:rHMvWvYmPaw=;0Exa/zOqurzEYb5AcF9ishn3Lg3
 lrAEaLm2jR+/YTHC/d6GehBRvB0Za8zSc5+uODLv+TGXcZelvKs8Vfi56ZlfsDkDdKHho8Fyh
 PBIccF22rL5T7209PfYOwk4As/tvSofrgp9tuFKbhCShKLkrFEEfw23pE0n5i25FI+curOoLT
 IVjYlDPyFn7tF+D71N4l/IGtqo8kzQ4lVSRX0zM/zzPm7ZIMVWaVAIGNIa/fJPLDqDeyj9G9J
 e4t6cyNxyOX4mgvNyc4NARhnuvFt8Y9azdcMHZUdao5kvklP1kix1Qn5adBGcrWpHbCDGAo09
 YTjS1iRttgV2GhDnMLsF0Lr2nmTwBVXsWoo/iwWH4EBXDCZtUlemdy8nWkiJasnhgvM7cSlMA
 6glcBPr2uStinuxY0e/ZdA2JYZLNpWPNAeTAvcEisvxhhEAOjcLDIcTVzcQY76DvM7UjCgNIf
 RbeeXT2fLhJNFSo+TpUEi87wEuAAoho417iT+mp12yR5wPwccKBX1K/WpPK4ZsK7FTdzlUMe3
 ri3o3jU8HUqbcREak8bssQeUF5I01s1ii1TnpkidKfpJv9IoGRPwtRgWDX5Xu/otQYqmG6WFb
 PcX2atDR0myoe6j9NnyHpVkXkIH9nEQCxXKNb+mdit9LHsiTmejMbhY5H+auIA4eheagHmfas
 lxC1Tp/AilsgdWFeBMGwaqsntdEZiZztzxv63ygDBWnctzRPsog5dBswdzuKUVWWLQtTwE6Sg
 iNb6qEaJtjOowZZawTlr8fd14p9/dVGhpfz7PsaS3Xw49D5tu/PL9E/lM3DYXsk4bAakE/cgK
 MvVmedjjlrTE0lTcxutoLlEIpUnCh+MyaaEUNCvn0BUKcdupBiU7AmNZmHOoQw2S3fbiHVC/u
 3k64/mz2PD6Lzos1NefkrYezr8QrCQBXHyKBZ9bG+SeJO+FEer9RsXbJZSbywcu+BqRnyNXgQ
 VnszErGndzhZGXjCoqYPMrMdSqI=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/30 13:43, Christoph Hellwig wrote:
> I recently posted an equivalent patch:
>
> https://www.spinics.net/lists/linux-btrfs/msg134188.html
>
> but it turns out this actually breaks with compression enabled, where
> due to the ompression we can get gaps in the logical addresses.  IIRC
> you had to do an auto run with -o compress to catch it.
>
Great thanks for the mentioning on the existing patch.

However I'm still not sure why compression can be broken.

Yes, data read would also use the same endio hook for both compressed
and regular reads.

But that endio hook is always handling file pages, thus the range it's
handling should always be continuous.
Or did I miss something?

Thanks,
Qu
