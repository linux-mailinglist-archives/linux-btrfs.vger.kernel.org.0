Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6383153F7FA
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 10:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiFGIOM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 04:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238023AbiFGIN6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 04:13:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0FA57B35
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 01:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654589628;
        bh=CaIxrQPRo5LPFR3if1yOtYs55nEXQzIxNH8S/8paldE=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=RJckkpAD5nApLTsrbmt9DrIwjEgdkFdh0wtca36ys1VGjJyTSsCwJQRI+vgKCnI4j
         NeOGZ7rI07YKU3bZnWNHI88OouLWje9h0wR7FqaiDi0tV7bXImi5k8moZCaGdvI18Y
         pLen0RwAtNSnMzOPhGEhJ8ZWHhvvbjk0mMgjVl1s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8ofO-1nju3h1Sy6-015sRa; Tue, 07
 Jun 2022 10:13:48 +0200
Message-ID: <c1f860f4-69df-02ca-58dd-b51af3043d16@gmx.com>
Date:   Tue, 7 Jun 2022 16:13:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20220527084320.2130831-1-hch@lst.de>
 <20220606212500.GI20633@twin.jikos.cz>
 <dcddfea0-ca0b-c59a-187b-34534509c538@gmx.com> <20220607061622.GA9258@lst.de>
 <14810ca4-9af6-3bc0-429e-aeddb341aae4@gmx.com> <20220607064530.GA9562@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: simple synchronous read repair v2
In-Reply-To: <20220607064530.GA9562@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DN3y7hDMep++ax/JhA+wt2Aqt7aHhoUGd5MttHWF1k6QnrnSmwB
 iGc6DEGAz7nWanQZqCb5pW6JzfX5gKq8SemYKOSEoPYV60GJag03xZG+nqBNu6BA6w6FzWn
 VqiDRC2t3UyInX/Cbb7Dr6lDaKz1wW5Hki7sCuZ1HxhFufV3H3xQp8P58y9kYMlIf9ZOd25
 XSR6JzPco7Q00AmE2ewuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o0HBkbIGlyk=:jj2B2SoJY5xt6m4hTvT8BH
 okYlgQj8LH3eUbhBsYKMMUGizFnVD44bVI9IS0ULzbBYhoRpTJM/cGiz1P3hAyaPeGRXALqiK
 COj3e5JNtcSraWHEFYQ5epTAxcHgCyx114HbN7TX2BWM9LB4lq13c50S1zdOis3aKIW48y7P3
 G50vIpl9dL7/bqGKE/KxTNQVSrGlSXrGpY4xPW3ksnk/Xvrv8FhRNt/DKUscbh3pCpxe7NgQJ
 u4ucv7EQ5TKQ3aG8OeVjEssNAFW9NxnOGzQ2hFx72K/nZ6GcF9lBx1BkbqpclEyswHs6DGGOA
 dHPSddDjmLCWra7dPcp4NqUtD9l1LS+x8jP3/oi8tmd3hlmrVmas0Ef378pM20Bh6hr3l3HRC
 CWzkNdjh0LeebWJuN0b7+hhG2wUA9ixDUQvvfbDu8sRZLO2ZsgtnmIOJeEy/Q8Zoh79h5IKs9
 kWKVgF3Cim1JEbruxqC7vByHrN9aPtRbGdaclM4/kWaqG75a/wsbG/O6dWoClDRrOuSIiblsR
 oDfhrXui8L6eNuLza9PVpDJcPAjMAvGxjaIkPlnHvYlnrIfvy464WA8FP5Xg13OBpvj5HkQZs
 h692119ZFowPlD6MLOaOdwk6gj2krCEg25mdACgInmZn9v8Oax/UZqvY/cbqXMAd3XbL5ECeV
 UVUOfhsvRFJnOeHgs9D+Hys1ImgexghkLBdPYjJIQ+Lq8vnvMGHgI9BdJh6x/SBS1pOaul6l0
 mZxrTiJgpVBKGer7Tq0AWICB5jWGbxUyBZNgP3RWB2bJyi/T+cuCaKLoHyoMe0g4u8QHvJ6CM
 Q2ryMgz5EcIAyEvo1KAnVg/95NGszUSgXXv5x+MvNfd77Z8iW8qQaXRwWrQB1+iVZ688mpzvl
 MTTMiTwM1wugVidyu2H1Huzgd//BbaI6Qnaa3/unFtzZINHvkJEVnDRPxJjuNCa0atmNMkaGz
 WHAkwDRLjzBjdrDSmIGLumHwZzsYRg70HxO+kcaBWT05SjOV3e6ylKS74XKU4y+485w58UXAy
 qRcDhXU1CUd4lP1by0Q+hc63r+Cf+sqjI92byftFUsxfs4WFG3mTgXBViK2BFC0Ix0ud1mupj
 dAvhHv7ij6qZoFvHSWhmvf0ZRgGL9lu6kCXDXh9h2+FVlEzaChLTFL/dA==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/7 14:45, Christoph Hellwig wrote:
> On Tue, Jun 07, 2022 at 02:34:02PM +0800, Qu Wenruo wrote:
>> As currently, we only write the recovered data back to *previous*
>> corrupted mirror, it doesn't ensure our initial mirror get repaired.
>
> Yes.  So it leaves the file system in a degraded state and reduces
> redundancy.
>
>> And in fact, only writing back to the initial mirror is also going to
>> make recovery faster and easier, as now we only need to do one
>> synchronous writeback.
>
> It does make recovery faster by not doing most of it.  By that logic we
> should stop repairing in the I/O path at all.  Which, thinking about it,
> might actually not be a bad idea.  Instead of doing synchronous repair
> from the I/O path, just serve the actual I/O with reads and instead
> kick of a background scrub process to fix it.

That has its own problem, mostly due to the lack of granularity from scrub=
.

Currently scrub can only work at a device level, which means we need to
scrub the whole device just for several corrupted sectors.

I got your point, but unfortunately unless we greatly enhanced the
granularity of scrub, it's not yet feasible for now, thus I'm afraid we
have to go the current path for near future.

I totally understand there are tons of scrub related code needs to be
improved, from the damn stupid multiple devices scrubbing method to how
to handle RAID56 scrub better.

And that would be my next main target, as it is the basis for mount time
scrub (thus for write-intent bitmap tree).

>  This removes code
> duplication between read repair and scrub, speeds up the reads
> themselves, including reducing the amount of I/O we might be doing
> under memory pressure and allows the scrube code to actually do the
> right thing everywhere, including rebuilding parity in the RAID6
> case, something that the read repair (both old and new) do not handle
> at all.
>

Yep, for RAID56 it's always a pain in the backend.

But let's focus on traditional mirror based ones for now, and I still
think just writing back the initial mirror is not a bad idea for this
particular case.

Another alternative is to write back the recovered data back to any
corrupted mirrors asynchronously.
(This means more complex code though)

For the existing at most 2 mirrors profiles (DUP,RAID1,RAID10), this is
no different than the existing behavior anyway.

For RAID1C3/C4, those two profiles are new profiles (which we didn't
really test read-repair that well).
Defining a better and determining behavior is what we should do when
introducing those two profiles.

Thanks,
Qu
