Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C6355422A
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 07:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356650AbiFVFPn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 01:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356214AbiFVFPl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 01:15:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED0A3615A
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 22:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655874877;
        bh=2HPev6XgktputlwQDaoCw8auKoeI6N/49W91RNKkzA0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dCViLgwrQuTeGjhtTppQFFcQrVIGS0ZDOd4Ir/rsQAwoUQZueLoyeCDeQ22kwjpDF
         VdcopudtKQNgABGIhoiRcoHY6PovdQHMThh45IlFZgYsZEwRbJMxfaAo34kx8JdMTz
         dAA9a3kSZqvUICpG0CIxmJOyai/w0cUE41Hh/6tU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McYCb-1nY7mL18d3-00d2Rv; Wed, 22
 Jun 2022 07:14:37 +0200
Message-ID: <baeb9e98-fba4-8af9-9fd5-da6e1bd8ee34@gmx.com>
Date:   Wed, 22 Jun 2022 13:14:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] btrfs: repair all bad mirrors
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
References: <20220619082821.2151052-1-hch@lst.de>
 <6490bdce-d5f6-9e59-ba04-41f0fdf8bbff@gmx.com>
 <20220622050658.GA22104@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220622050658.GA22104@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XG+GlcM7hFu2QYc+jqqCQgXjUeeJ5/0SAmA52fOsOCVrWKaj1t4
 NfkbLISm3P5uqmhrVuqyfcmmAbWGt++ujTxnReWmFMm45JEwE1swHkoD+zbmQpZdzWJEkq6
 WYT1oco4+CGKc+IhjIixO0j+kkG8dcD1wiWw6neJZaE/t9L6HaKg/m6zybBGTK/6tVPqcgA
 EXQAG/Dz2gV5EFqJ346xw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SFVjB2Kx7wM=:IKLJs+5Q5xPCvxP3xKjL0N
 Jdr6ylZXjJ9si1uBFn1cLyeSiUkj0Vc3MMUMwnmVLMJZwmJs4wp6sbQ9wmvgiTaU6HXX7f4iO
 ro7u6p4HGNuRRo4N48eqJg/SGg+B8hnsLdeeu0ROW2KizIOZzNrVF1jffLHdDwrcIN5RqKoel
 mQubQ508g5gM32J00uvTvBjtkcdhSLxykNPApUKdpGEPntLzvFC2vjTQjECSBBKyHqfoZaRDd
 O3OtYDdj1eJ1AnJzP9KRKdOfhFSbLkaVYMfzECiLnabqVTHX8VPg1Po5c6fyTFbfWxwjgeQXE
 epDlDJWKXVJEMlpPccZnAlJcGkZjgOyMs/PbMweFucj/N10TmPvEzbND7Y3HAiutY8hPHcaKA
 0ocLwjZeq6mAeUXAfYUIU9DUtohA9ZpDIhjOIGL7Yx07NgHnxkz6TmIrcKM6KyF3DCwYDVKM3
 6Pa0q/ylF0THPtDfNYnh1TwE0VGFLd0E4C5kl1fAuN6mJWu86LMHX5jiHYsMGuU9dshrYmrMV
 NaMzngHwPI6sWR+L1+bdUYhRrRlxvUE/14dp1v8g3MImGcvszAQpjkge5/SzD7yYx4vUP2vgI
 +1IvXEYl0+nmhhivyJazxYh/jOiv/LeDsA3/0+X0VNZoE5n+DTdIzuA0HxyST2AGOhE068Mi0
 U1uCR9aRt2OgCiX65me1SaqmYWQGP+SqBtEw+RP3FZbmzgPfXSsUPzANOZpIfbgk9HFIMhB34
 feQsLpXb7Oz/BkGDZMszUIVRW4nFb7mtepdaMMECaUEwmD4o31RKVnqbO7UM4/AJ8BJq1l1q/
 xbrQ+WxQpGAYo0oB2ZncmvVqhMFYzRz7C5cQsp1B0dLHxSwpyugm+zxPexc2uTkBhjZDROFEn
 npfNqrmMlVgLqGffguqWYCXZl/qgOA2F338bfs4q6kX0pX8b5T+tdSqZPmiNOtStIcl8nh8Ya
 kw0ghDTTp6XP1t6dKkLyGx+BvmdJ497yaWFNQV+ji0s05PSMluzUURXGx3CVvqXQ1jvul1SRb
 fkTakdSpb1VDhfkQdrqhe8v1nvEaSGM7D805ShsgL6Usx88fUoUYGZVt+3y77AE2OUw4b7G14
 ACCiRjLULhFP9Ew8ZZC1jdpJzhbbaevrGBzEYwW51m86UbkppLzhKud+A==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/22 13:06, Christoph Hellwig wrote:
> On Wed, Jun 22, 2022 at 12:32:16PM +0800, Qu Wenruo wrote:
>> Personally speaking, why not only repair the initial failed mirror?
>
> Because that is a risk to data integity?  If we know there are multiple
> failures  we know that we are at risk of losing the data entirely if one
> (or in the case of raid1c4 two) additional copis fail.  And we can trivi=
ally
> fix it up.

OK, this makes sense.

>
>> It would be much simpler, no need to record which mirrors failed.
>
> How would it be "much simpler"?  You could replace the do{  } while loop
> with single call to repair_io_failure and loose the prev_mirror helper.
>
> We need to record at least one failed mirror to be able to repair it, an=
d
> with the design in this patch we can trivially walk back from the first
> good mirror to the first bad one.

Then in that case, I guess we can also just submit the good copy to all
mirrors instead, no matter if it's corrupted or not?

But considering repair_io_failure() is still synchronous submission,
it's definitely going to be slower for RAID1C3/C4.

So the patch looks good to me now.

Just a small nitpick related to the failrec.
Isn't the whole failrec facility going to be removed after the read
repair code rework?

So I guess this patch itself is just to solve the test case failure, but
will still be replaced by the new read repair rework?

Thanks,
Qu
