Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F345158C9
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Apr 2022 01:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381678AbiD2XHz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 19:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiD2XHy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 19:07:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6585C83B2C
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 16:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651273463;
        bh=k3WjzxA6MqP71oz1xusInpgvGHIrAvfe6MG1514Z2hw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=RiKjjC6J76LgMPM4K2qsvlWkCAyOA1kASqyZncTU0F10Z52RDaeND4lXxP8YbyQcP
         Hrk3ZS6EWwPtVWiYfBrOfoOmWolx82MW/pkz2Bkr6UHFvtTULx/kk21ICI4noNu5Ht
         cJbhy3TMRZom042SS/ywG/bX13ZWthaWtvCpOUCo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N5G9n-1nsZwx0no5-01179Z; Sat, 30
 Apr 2022 01:04:23 +0200
Message-ID: <b2da51c5-a61b-b5a3-2214-7d9690f328a1@gmx.com>
Date:   Sat, 30 Apr 2022 07:04:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v2 02/12] btrfs: always save bio::bi_iter into
 btrfs_bio::iter before submitting
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1651043617.git.wqu@suse.com>
 <b11499d578ab90258d83ec9be6d46df78c1056bf.1651043617.git.wqu@suse.com>
 <YmqXZ1Oa8UX3n2ZP@infradead.org>
 <82eb8269-bf14-1396-7452-a8671ed24511@gmx.com>
 <Ymv/pv3Z9x1TGMGv@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <Ymv/pv3Z9x1TGMGv@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/4Da5oAQuONcsYMUm3Q6FNjC+Kad3Y+OC27mTs6KfX0UzAR9jIi
 jRgdbnSdDuebDqmwEOGtWDsL2ZEGpoOnY3jKjng7QQYlogj5XLBK7GEZI8iGXSuJ3NtZVJA
 mcx4je+iZA79fFaWTin/lPXQuNoWcu87mXAfoYIqtnUtVhoQrt81xdfHb2/u6wYfGiOo48z
 Tw0WGdG3+iiDg7CLMpGlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:49jiQQHCmQ0=:uP+I+P5TQDpcYY877Q3oEg
 jDmQQQ79JcGNsm+k2zJAnbzHtXCMeASxzR9D5HA3kJDwyktjXETf/7YEoXG/CPddV2CQliTOG
 cAG01lvQouzVCoADvf/KLocnB2ZXj/BqMqTJXrnVlqf+zoIkHLeoLwKErONdl/ekTshrmMlPH
 eOyqwLxPFwn+gJnUJ3ayTTjF07CVQBJ+OzeiXl2x8ByVd3VuL6u4fxQLbBwun3fezNKdVO2VX
 nb7x7EYHgtcmTvmRYXZ/iGGiCoUvjEMFWK9SVxjFSyYlQONBMIla/RQ7o/iARZsCOK113a0+z
 wV7ECAxycmeMnEqOT3eYt0yKZFD+6mqLSc9XTYLJT/bRe5gCBlt1Lb9zjHDYJeQwoLF+nthid
 1d3KD5mSY/iwC1iB6mk+yVT9DNDA47ptMJt29GN0j1VohuNumLAhZwha+cTRjinb6cjATDf09
 fxuZWv2JyhzmVbUfgU5RH3O9xUxc4SQHhJiDlbStaeRl3sieVm7KoFtyiXN/TwEvs0RMSvAfY
 Q+H4rz7sudisn1161apnAyLE0yKOy/DiJDvENhAiOTosr0Km4WrlatYdpvBJ86fjH7/zgaAk1
 JiJeVXX5SUtYC6OQ9dMHiwTmTFTawRbmgdNJH+Nqaw4KnfzrluqDgElNwnXW/+jA2GUKpcAxK
 S5GGSaMsauf8ZNkBFgxh12/Hsdg3RQj9P5LgW1fWbWLT2MUOy2xVDG0Tw334+6Y6ShgzXO5Oc
 8B6hKltjvB4vMMLP1teFtfaKFaOHpRUW7x2xsPSDCYJ/YzOKLInC1+p9h0ydxzXsEmKRK3XQM
 /UG7hk5Da+JzGyE4tnmTl6ZGE+1jhuVZpQIdwAnJyUnYeL8bLygx2trAsWBoXIHj4yVEjkXfZ
 NMEb7QCsja6hJ0plJDA3zrbDTS6TJ5nPi0B20NZlO81wfVmEKvjL1LJfGCOW28pNOgmBtwO1e
 lqxm/Dj6sfNFl2rJETuGq/laaPDNps9ukxTcVV/D9A1TSxTtYMO/DqzvbB95g6Ol/EXP/0rJc
 ZLhzYCBiXO0GzvTtoTq+ZVep/UvVYVGw46Ail4xyt9JqLeyKARCeIwpTVsZIkJrvcYY9m+lf/
 ytVEr53nQ2EBJU=
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/29 23:09, Christoph Hellwig wrote:
> On Fri, Apr 29, 2022 at 06:41:15AM +0800, Qu Wenruo wrote:
>> The problem here is, if any endio function needs to grab the original
>> bio, and btrfs submit bio hooks failed before btrfs_map_bio(), like som=
e
>> failure from btrfs_bio_wq_end_io(), then we will call bio_endio(), and
>> the endio just got an empty iter.
>
> True.  But the only places that uses it is direct I/O read repair (and
> with this seris buffered I/O read repair), and those should not run
> when we fail to even submit the bio.  We currently do, but maybe we
> need to fix that first?  In fact with my pending bio cleanup series
> we should be more or less there.

OK, if we determine to make sure we only save the iter after
btrfs_map_bio(), then I'm completely fine with that.

Thanks,
Qu
