Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07135158CF
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Apr 2022 01:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377112AbiD2XLm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 19:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiD2XLk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 19:11:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AA084A16
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 16:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651273695;
        bh=hW6gSLphHkSXgAsTRh8lQBW14weSzr+wBSKZ1QeT6MI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=chd5LAHZNJzXJuOXkZoFHKnYPEHMaXUi5Sszwlxyj117v+NmiztmRZnmiLQRN1urW
         ND5RkQaItUMiMOkaXEicL3uKxby4JM138jZUwVrkWRPdJlQUfgca8otZ4wA6hPrj+e
         HC7B+hFeAZ+KaKdv2Lx0qHoTt2eSFV2mFe+vmwIk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M8QWA-1nozZ00UyG-004WTy; Sat, 30
 Apr 2022 01:08:15 +0200
Message-ID: <27992c93-3676-fd8c-098e-5900214d6d02@gmx.com>
Date:   Sat, 30 Apr 2022 07:08:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v2 05/12] btrfs: add a helper to queue a corrupted
 sector for read repair
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1651043617.git.wqu@suse.com>
 <a136fe858afe9efd29c8caa98d82cb7439d89677.1651043617.git.wqu@suse.com>
 <2fd10883-5a4d-5cbd-d09f-7a30bb326a4a@suse.com>
 <YmqaOynJjWS2XB76@infradead.org>
 <4ac0c01f-73f6-e830-f3bc-6281bd79b7d2@gmx.com>
 <YmwAzU+UORfX92Te@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YmwAzU+UORfX92Te@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Pubcrf4gTdW7X4DQp+JkuH0xSTgrSr7IBsao5tydN6wJDYWzMec
 CYpOmxOucXvumSqMddCU/LxzLO+9GIMbRvEx0QRWUMP7h6ZKoRudtJLsWE/I/lhKIp6Xo4B
 oWmMVhCXY/YFk8bxWozFmARDApacI1ZA/bJ3+uiD9pQb6222X5fvfDaTrUbApv2xGIayRCj
 SFxssW/enBhW5tS1kA1EA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NYsB8iNiMxE=:8v6wFiLjI0S6kq/pX0YEs3
 3Y78rkAzK5vieExPPHpZ4cDvdU0fyT6NZTZ+59wG85P95w9H0ZJVRMp6Q0jat/ipUQ6nuWMRp
 acEf0e0wJs0lDprOfET0e2Tc3BA9EHIzkUC7e/j19WlYgzXqwmFWkQo4+xU5talhpoNiMBjBr
 06DYRcFSig/Hf2OCK8vC6qhcnDujWjDxolQkTgE+GTE4huKo+MyRIv1WfGmn0aKo26/6rBRQk
 oHzRmgAfDo2TqGYTmQwFATEZbw8bdZxoe21QRljgn/jf/o3TbWYi7pItRiIKuU0UQQDjME8W8
 GDbOYTrV8HhIGq2yB56ZgMzXu1Z+Qln6LfBlBqFXsUCW7NfB0pj6waSM8GX0ECI0gulIqIpIz
 MpR6kBmbfElMAme5ah5B0PgeHjWWKuHzjBwx5YbnBLn5AWZlTiFHvING5CTqdpBeiD5exCoiT
 S3C8yfampiU78ONCLOktMfvCHVbfVLDR4EH/vOMDkL3LIUoaTmT+EPVaU3cSP3dpDjQ3G8fB6
 f7wU32SBg328zMiKG+zpAAUJOiPN9/y0LyB3HVAtl3DXqh1l4pJJxhBD8o51GrDasUDY1YJhs
 UErbNGqqvrQwGNYqZJCO+tOOjrv+WgrmCacOihsNcP+2ZQWMGRv+Z2rbvkcGON9WEljRB4q2u
 TGB4/5jWrDOdJjfJOqWxdOahj7K7AO30Y1IxIYJwlNAoxp4k8a1EJlNbQxfoROEvst51iXkMZ
 8iYj2ccPscof+rkJcbJLTAhcORL/RfvSouWf72iZHwxJTNEKqrdoWqv7hXuZD1ZJhnjw2Gu45
 FSw74J9zVqtAKQEcyM+gKiuqj28X5gHr4NvBKH5Mw7g0i66QA0U21ChXShbJPAfRh56KWULNc
 I1nSt/DSM8WSbUVsO2RfGZu53/O3Tkf8/KHMp2m+nsSE7pjXS5idRwEbiKw9SURvDK0MszqA+
 D77qxlG1fowlMio+L+2Ztdl1bTkdUTSbmJEV15XnPfWPhIAU428y6/vhBUF3RcbXJiNY4u+I6
 T7nI58BIUpK9i1I1ablD/rR4tS7pEAbUVpHNsagratKPA+xKwCjNdHFO+S/ZFYPYiI27t0XPN
 Ow77QoK8KpkssQ=
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/29 23:14, Christoph Hellwig wrote:
> On Fri, Apr 29, 2022 at 06:55:59AM +0800, Qu Wenruo wrote:
>> Another consideration is, would it really dead lock?
>>
>> We're only called for read path, not writeback path.
>> IIRC it's easier to hit dead lock at writeback path, as writeback can b=
e
>> triggered by memory pressure.
>>
>> But would the same problem happen just for read path?
>
> System with sever memory pressure needs to page something in to get
> something out.  The readpage uses the last available bio in the btrfs
> bioset, but that read now needs a read repair, which needs to allocate
> another bio from the bio_set -> deadlock.

Thanks for the reason behind that.

Then I'm wondering why the original code is not causing problems (or at
least not so obviously), even the old code is allocating more bios.

Could it be the fact that, old code always submit the bio after
allocation immediately?

If so, I can get rid of the bio list and just hold the last bio for bio
merging, and submit the current one if we got a unmergable sector.

Thanks,
Qu
