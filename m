Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC24503081
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Apr 2022 01:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350367AbiDOWqo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Apr 2022 18:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiDOWqn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Apr 2022 18:46:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D539F399
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 15:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650062650;
        bh=vlpqM0T7T0NevziI1qEn3a1XqPhjnG84r0w8zB++LYU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=B2+JFfYxIS3h3JRf7VfwSdVatBMcPVIF7YjP/tuvoFO2VeM3VztfbcCdPIEu/Wq0G
         HzOvhwsSb0Su7zP8nqlWctPvLnoN9jKtQYOQRl+UWF76DIF6hO4wDbetOYad2Lyr/8
         cfaNE2I0U3F06mMyjikwHWd+uhRD9Pg7y8LTFjsI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEm6L-1nhvV41d6p-00GM2c; Sat, 16
 Apr 2022 00:44:10 +0200
Message-ID: <fc163e9a-ff50-ac31-9b41-fea23913f579@gmx.com>
Date:   Sat, 16 Apr 2022 06:44:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: minor bio submission cleanups
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220415143328.349010-1-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220415143328.349010-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vxhJl9wKBVrVg8hR9xAj/GR5IgDrj8LiUPzWkgBjkhNM+2RycOU
 HiLCVvt2V3UkXRs6woZetM8RqjiJuP3x83fNhZbClz97DEHXlTrKgQ6nCK9Q19e/wVKsjhX
 0FqV8FYLiQQrmm4XXOWz+Ioqt5DDNZji2bA6F10wgAQlCDDRYqfAeApJAAyfU1EGEe2ekEm
 fMuLMGBifSH4THaDBOHFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FNNVgNJklYI=:UBKRtm09Jd9iM3ICZbObfs
 HE2B60/6Wr5FhYnJI9O1hhaVC0liIW/eEDZX/OBKzZ8tcA+cGy5+1llAIiUIjLC82GgdfDYCN
 eOPKT4l9LOuA3LYUpQHe93YtCpKAXjOJqoWSWYvApxXpE9p1j1C+67gQHiHar27Y6ZIxPBsjy
 DuPlzyGCvsCb3xOk78daboDYwGzPOv1VOeWfl3VFJ3GdKo24WLeIZOiMjMYnIVwG4081Q7vlf
 oM9c5Te18ixYFcLg1cmCDMageU78lrycxYqBA7BoqGvsaFgyblOQbBtRBt6ZuvQ/OpQv4OVEw
 PRu13yqI13rIJ8u7QSX5YSSjejqQAPD0QiKKuE/Jh1iPT95SORxyzsGvNFTIOIuBR+ooUWCHE
 8urZhv0umKIHwU7VnMs8roly0GfLEKRgURKMispY+IWZx3nbgsbMn6vYokwW5VKYnerhiGK28
 +DPjN0rea4a/L/XihcYWZcAYw8pa8vFs+tIHn1CXtZs/iQR4HUOPfSyueiSpXx7vhdQQ84c+g
 3Pr9tTUcrTrouAe1uBj7wpnVd35e9nuoHlSz/fSHJo3rckrrSX4lVhLLZa/2WoRjJAyrzOy60
 ZDme+w8hYcE5urfuGuCMyl+uSNa3MJltgLFLL67vgVYcrrO1J902cukhl84vBt+S46jC9/Gon
 ylOEqDS77teUiUFX7QI6ryFB0wyl/EMwz4zotxQGYjWxER6ODc/M+KHMSyJhhcBmv40IVW2yO
 n7otd/cHdVdsdqF8WLPuRfgvylmun6DosO4Ybb/2Gr9FH5zuRhmWb7VnLwLb/h4d/zzO8EMyW
 /89lwOJsRCxD2laJJll30TQoLjm66kOUB7aysvnYOYcgG291t2uVfQCJ2m6TxWGvbxaM9Bmq4
 4j3kgr9uhmFGb9Cx7a+oP4aI6mcbjAb0ZwtTr57BW5hhNzMCZI3VhDxALNwZoMf6tpqevcy5U
 8yhIdXX0LXRW+yLsnHhf9Sin6E7QHCoaE7Q1sldugJbgNaQva1Q8gd5Y49D3l5BiqVB9zBB+W
 LEpbY2z82rNtW3Mppky58eNzqTOK0rtAFXDTSpNEnBa2ZQWlsiJZ7f2qJf76yaxZIm6yy3nkI
 MW9IQOKB84i1LM=
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/15 22:33, Christoph Hellwig wrote:
> Hi all,
>
> this series cleans up a few loose ends in the btrfs bio submission path.

Mind to share which commit your code are based on?

After patch 3/5 "btrfs: do not return errors from
btrfs_submit_metadata_bio", I was expecting the same cleanup for
btrfs_submit_data_bio(), but it doesn't.

Thus I guess it already handled by other patches in your branch?

Thanks,
Qu
>
> Diffstat:
>   compression.c |   11 +++++------
>   compression.h |    4 ++--
>   ctree.h       |    5 ++---
>   disk-io.c     |   26 ++++++++++----------------
>   disk-io.h     |    4 ++--
>   extent_io.c   |   39 +++++++++++++++++++++++++++++++++++----
>   extent_io.h   |   18 ++----------------
>   inode.c       |   49 ++++++++++---------------------------------------
>   8 files changed, 68 insertions(+), 88 deletions(-)
