Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0090D5B01E9
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 12:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiIGK2Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 06:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiIGK2W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 06:28:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACFE75FF4
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 03:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662546491;
        bh=qrxxW+7ejZ0aSJa11Gko7yBfikSfSOkkAC6m+T3w06U=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=d08z8NDIABuAjgLPdh/oD/s/k4KsOlOkXNZl7GhY6Ql4NiOImVIzihNuzn6nTLDrd
         U7jNtCp6tZdmdthfwlQchybXdMZVBa76md5zTgx42QjZCI/mhzbb6JWn4ZGVabKg2N
         iyQ4Vy+QbwzdoWSpAnzoCvqmYQB7o5ItA0jeg5JM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfpOT-1oysVf2U0n-00gD37; Wed, 07
 Sep 2022 12:28:11 +0200
Message-ID: <382f747b-7ea3-f1a9-805f-0550ae90963e@gmx.com>
Date:   Wed, 7 Sep 2022 18:28:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: code placement for bio / storage layer code
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220901074216.1849941-1-hch@lst.de>
 <20220907091056.GA32007@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220907091056.GA32007@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iMFbfp5sRaPcOKQD66UfutqLeYiIKP7PAmsdiGhIj4SXQ4y//ct
 +BAIpHCdJLJB3lAPn/BxgtLUkOYuEi+vmsLFsgOAW7ONJ+UPnXXInCgyEAajPJFTUzdlrLb
 YQ3iuH95Abm0HQ08QRDXzYYNe3FoSAwUfVqmtbXejnKlNdqa1kflImuHhsMO+llju9g7GDg
 o2rF6IyxT74cE4YyQ6L3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b3GFfigcm7s=:lc0tblRVmAX37xPOy8H6Zv
 e6/OQrHPsR3dk+sdxOayLZMuVqPid0e8OVgWcYc/qAIgvmv99nfmXFfCcCHOTSiEsaKB6mmV+
 rPnlgkZwFt1ukXRl2gb0TjogtZznWYWZH/Lfz/LWdY4fSc2Q7W/M6IkuUOT1NR4i5E+QdB3+I
 mmDly5A8FKqc2/0TF6YINximUDgfATBQC+CBYYuJRj7lsGRkSb4sskdNQF99uypqj40KRzufd
 CEMsO2l8DAMjMImh+Z6m1hUP60mgCFMa5WSzD+cUfCfrW4in9TjRYARuvR8y2rf7BkqzvRLGx
 C47L1jqBLRLJwXF1ZOL93GE3lAItb9Gw08jjQ53TRUN1JejUL5jSlU4HbTQQTv4SdrYJcegWN
 StJOV7pBHq1iKuvrN6GaQZk8pQVt+BUZol6/kTHRTNIy8ZEDIyIWfj7s2pa6gK9CwGM+2+ImL
 1GR2rEDKeWT19uWM77BC0ASQDx62EZGgK4xs2ZRi3SuXHFhx/wrL37xcopxdXQQ+HKj2xcbfU
 m9u1mglSKoJjjLtXMzgk7vU+Yffva2eqYG1GajfGhvtgRXMVDQlyDiapkIZJbTTEhMf0U4H3a
 KLsy+S3GgWUXx9VUmMq/qnYIZE34OeAczHDwPZLFl6CNv+ume1Z+KMOzjKtEoBi3wklepciGr
 M/WEOzLiwYieMX+vXrSth6iUZZX/tscdccp3LLcx/37ccToeDvlUEt9z4gLTolNdm8v+36Rb8
 372RXJ6WZaFLNX5GrDX6KMBiW+gGjICyirj02DW0IfRvd2zCD6lmXXKRXxoBY6+6gqCcpzkYA
 lQCriZONXy/DdpjPY7fcREF9t7/1QCfJWR3jh2pnxO/ch7vSnf2aWQdn+nLZFFiXIBgGyOFT0
 snm8QTOHQvaG2+9RwiWr4KaJWPmvG3rPhed1StcasMG/toP1dqOaOFik6QgImA09iqRUYSTmO
 O7imu/rPdCEkFoKNbYNiEJqODqzqsxGc02FONh7vCDkO67SZe6fAtvIE29Xjezyz82fgNsn7K
 Xuzz1gZ/vrGTKoTrt2jr4RnNmSB00GpXTwaYQNkpSsE0/vw3TQm7sDiWkweEfnKh0qc5JI7FJ
 ArWEr/ncW01S6rX/WLa+SygwDp/huTRSf+OOLrvBBmdDH7dFEfAlin1hCZNAX4nX/8+zuIiZ8
 7AfPMT/WRl1XOHLtVNS2SBDWgy
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/7 17:10, Christoph Hellwig wrote:
> Hi all,
>
> On Thu, Sep 01, 2022 at 10:41:59AM +0300, Christoph Hellwig wrote:
>> Note: this adds a fair amount of code to volumes.c, which already is
>> quite large.  It might make sense to add a prep patch to move
>> btrfs_submit_bio into a new bio.c file, but I only want to do that
>> if we have agreement on the move as the conflicts will be painful
>> when rebasing.
>
> any comments on this question?  Should I just keep adding this code
> to volumes.c?  Or create a new bio.c?  If so I could send out a
> small prep series to do the move of the existing code ASAP.

I'm pretty happy with a new file.

But before that, I want something more guide lines on what to put into
the two files.

To me, the old volumes should really only contain the chunk tree related
code (read, add, delete a chunk), thus it may be better renamed to
somethings like chunks.c?

Then the storage layer code should be the lower level code mostly
touching the bio.

BTW, we may also want to extract a lot of code from extent_io.c to that
new storage layer file.


But I'm not sure if the bio.c is really the best name.
What about storage.c?

Thanks,
Qu
