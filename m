Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629C65B02DF
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 13:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiIGL2G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 07:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiIGL2F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 07:28:05 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32991B0B3B
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 04:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662550074;
        bh=avFqwuHuKb3WpelmcZfRYfdlk2M93fbYgOpTIn8YRTQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Oe2F+SgKqa+Y6ttdfCZ3zezCymZCmw9UuFeqSvg7PYw7O/jUAHNaqTfzgSKMFespZ
         c+uIwKZ8ku2C4GX4e4izBzDoAXzgyh/GHhafTcihVUwau+oof7vH9Dt0mKrpKy9YCT
         2fv5vZkI/DEJw4kCz/R3MhzkHPRHcQsSL8EKRvLg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MryT9-1pAmXE2SHt-00nwnp; Wed, 07
 Sep 2022 13:27:54 +0200
Message-ID: <f1d43420-3fda-1287-5fc2-4035ea988e0c@gmx.com>
Date:   Wed, 7 Sep 2022 19:27:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: code placement for bio / storage layer code
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220901074216.1849941-1-hch@lst.de>
 <20220907091056.GA32007@lst.de>
 <382f747b-7ea3-f1a9-805f-0550ae90963e@gmx.com> <20220907111009.GA8131@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220907111009.GA8131@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6epaXZbK+UKolBk8Y1o0BDYgSfOtoginIj/NdSDUqaSJVR86KLR
 T0LWi/VY+CeEi9w8YX0VAYSX763KOz2euoXQO2XssmGRw2Y/q5uTwcYsHULNaCQDAjm2YOC
 y/MO4qbTmtVOucwWOEfGO7kFCi0ZyFb7ssLlCb6t7clel1DuYSmbcIFZzq0NY1XabWzKcfo
 Ks0EA9PSTRXaaNyvul7lQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S35CLr8/M4k=:/b7Hs1Ux6brBne1D3nVY8t
 ekwxHq4ODEVWlZkbDNNNbNZmJJD1YCbTYKG2GagO9gX8bObAbdPNvl6FdMH5d0mywSkYLKQ8R
 ntsw2baU5z5sJFwNLYbp0hPpwFMrEaovo5Og1dfjs/T1vz446ql/ZzTBkP9OIk3HDsKIn+uzK
 4XUz7/bTjX1d/dEkpwpdyKmKxtFvSG1dyTMB056vjrbafCV53AynPF5R+xu1y4A/c40ZwMOi5
 J5m3qwYIqF7L/O119bOaG+L+/57OUbxHUlkRnHaFjLb3mfo7BKOxpSjlOvLCq0/EzdJfbpSkz
 KbsAk4NDf0lcByr8w1sRnZDgKcymK9Mi4LhQB9rwBjczmI3aKlcZN5MK3D6HmH/XyeCie3heN
 SeTeCSSYXd8rh4DxUXgKZcAWmiNsAEOXbW7iqxx9Ei8uYrgoE6FfxwehP97/+OQtsRQrsUJSw
 DruoP3HwAl29a+wosACT5b290dvVuJvelDT7yxPdsAyL22VJNZXUoPPTTsgsqzB/sBo/qQEJv
 BfofalvR7AU/oQwxc1Tayk7UQ9cMjARQfoZiSsOlh/XdFPqRlDT1zRbSqqcwqGnOtpnkwRMO/
 YSAKhiMIvj3tLdTciQE9M6xFlyCPI1vSij4ReSpQPEcyXWKbBXSSrf2yMiqRhbPg6VTuRqyug
 ++snHKQ8ZGjG8AVizXmah1azrqFLOTy+qP75inO7LH8hxUIdsC/SCIxSro2lVI81id2jKLDlo
 Mgi8RXxiGEPaMpZX5JxfKN0nescZh4X7BKq06YsAiA/+rDEYXdorhIrWc1VJxR3lSHJNaRNiz
 akpa5d68x50mHGTx79bmVHVOOjQjvY8RmrqZbRRI8h6DrvG13y2S2sHgUGQpztbL0W1HQVekO
 rbKM5SM4aFFmZF2sp5dWbphm1pP/t/ter2hARkens/1fBoD4NWzVLKRTeOVHpmy14JgoL4wfa
 0oHaUlf2A6ELTsCa+Ksnl/KP7rp66oTnDaPFvIeWuF6cSvIwvc/AubaBAhRYB+KxYhCrvINSl
 m34OnfHshsLl2x6DPixXQOXKquTVdtzOUkiXRQY4+cB8LbsX01IwclrtS/71d64Q+2Hl7iACv
 xXomx52MbllPPRzHA+trh6z6VIU+6dYwGi14YjNGTI6ncyVTLs0zvFhLehMYLcbXwR9VTRyY4
 FnGOoSoXGlIPFqYcDlTsp7VqLQ
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/7 19:10, Christoph Hellwig wrote:
> On Wed, Sep 07, 2022 at 06:28:05PM +0800, Qu Wenruo wrote:
>> To me, the old volumes should really only contain the chunk tree relate=
d
>> code (read, add, delete a chunk), thus it may be better renamed to
>> somethings like chunks.c?
>
> I'll leave that question to folks who know that area of code much better=
.
>
>> Then the storage layer code should be the lower level code mostly
>> touching the bio.
>
> For the initial version just doing the move, this would be
>
>   - btrfs_submit_bio
>   - btrfs_submit_mirrored_bio
>   - btrfs_submit_dev_bio
>   - btrfs_clone_write_end_io
>   - btrfs_orig_write_end_io
>   - btrfs_raid56_end_io

This is scrub only usage, I guess we may find a better way to determine
if it should go there.

>   - btrfs_simple_end_io
>   - btrfs_end_bio_work
>   - btrfs_end_io_wq
>   - btrfs_log_dev_io_error
>   - btrfs_bio_clone_partial
>   - btrfs_bio_alloc
>   - btrfs_bio_init
>   - btrfs_bioset_init
>   - btrfs_bioset_exit

Otherwise looks pretty good to me.

Thanks,
Qu
>
>> BTW, we may also want to extract a lot of code from extent_io.c to that
>> new storage layer file.
>
> Yes, this series moves a fair chunk to volumes.c that should go into
> the new file instead, and there might be a few more bits.
>
>> But I'm not sure if the bio.c is really the best name.
>> What about storage.c?
>
> I'm fine either way with a slight preference for bio.c.
