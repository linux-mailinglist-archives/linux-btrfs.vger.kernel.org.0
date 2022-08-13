Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEEA591912
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 08:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbiHMGxY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Aug 2022 02:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMGxX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Aug 2022 02:53:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967331CB23
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 23:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660373595;
        bh=2JqZ+HNZ452b7EqM82BVo6wi2LechIGg+aVjqznJX2g=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=RMLJPTfWprS4ZHyc96IRedTwrVfmfgwVJ647Na8YD9IWmWoiAEsq00z5xwD2Pg3pu
         2eMMcwuyzmRnTr9Zls760itiUOn4VnBxuLJgUGcQdxk7I7S3s1P9atPqTZLjwOjDUN
         O1zuPJNNTy9cGfvCVnH94TijdcLf0Wyw34pLzfXc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MnaoZ-1ndYyq3Ogn-00javw; Sat, 13
 Aug 2022 08:53:14 +0200
Message-ID: <ff84cdb1-fb69-ca19-d82d-658c976c89da@gmx.com>
Date:   Sat, 13 Aug 2022 14:53:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] Revert "btrfs: fix repair of compressed extents" and
 "btrfs: pass a btrfs_bio to btrfs_repair_one_sector"
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <09b666a5e355472749a243946a9199ce2d6cef77.1660370422.git.wqu@suse.com>
 <20220813061901.GA10401@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220813061901.GA10401@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZqAnwreFvs7+W2LfSazcr8wySNCHtiilo+l3ufChnzHx4ZPQnzw
 K8eHqe5He2pVEJbb/TW+FrF+3YwooBxWqfMRVvc9vpydAqMpYErEkUhKcGICuxbQlLKECkl
 c0aymfJOIyj+bkbMOSKtu/YssDu3yZVrImqBtdcJ6o8u9Af1UDiudB7Fia9c0NJp5/TV5t/
 wLAmrAVOqaBp5LRIgJllA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FRq8oqu5yZU=:NekpVHvsW0USj3GJPQ9PjN
 IFna9YDJ/PFfSWm0pgeEF4wHil4N3wK6tepvhfNlW8nRDuPkqj+Y1WpLAOBHYv5KLloC1wqQi
 TK0wJLNabOlXttdPXF5f9e8R4It1ntueQR/SAPbAEFS4+hH60/KlJWgu+bU7sZOYhmDROhHD4
 EVxCNBFrBLYZD1m7M+uoibGQws8nkzEWXNg2Xtgt7ikGt7bGBQlwgb6l6jZcbB/GPyYe16Sm3
 te+1/8uDtvxy5TgKi1RSXitTHY1jQiMmeNYzJJWLl05mJ2MQ3Ps60VNkAteGxD4DszDzo5Dsw
 M0cvO+bokMdtyLTLMhDdUcMRSed1NsdEhYIczA/Xo76ufSD0VzirIUhU2dlmKT7U7Kse3FmYz
 um6fSXJCezj4icrrphZ5OqvNx9Job1XmfYfAbrZPUfVs+IwlKi+YdcgWJ+UbRCqWbNC8CiVLS
 /eXa0mI2bZV+063Vd0bgdRyb2ydWssj9Iu74HaUoTyroYKZnFwt/0a/C5akvhQnIOn/PRQHNI
 IYGLRRGuqqKONVHwy2I4I9OlhdsYWoprY4YmFl/CPG7bwp44+gw/gAfxXz37GfVZwgl77GYXG
 AaTyYToHOsLXBVhaENtutI8z+CI52TICinuIZj3PGt4dlHsP6G5HK1x+JWjzuTVIST3SWqN0Y
 mGgrRgCo17lQG/B1uz3VWp/hM//5nsiw5vjf41C8cc58XLG0X54GtVrzXW+8o6j+yEGQp+CGv
 dG6Vf292PiWp76YGTifPxLgPwwhmwifFuYs+o73u74GTb3q0GRiYtyNFWN0EQjtfFuU/sEtT9
 yQWJI9JGuRBATkbhWl7BHJP0pqKutGTD1yBtooExHQ6LggbaLmiNU6/Yxb8E2SoORDTCg91E2
 xW9fTRuBuC0VpkbnH/igUiZYz/EP/WRX2GNzMw2dgpDXshGmD5PTKHOf6o9Sc71GVkpAwDEAI
 s1jsa9LtVNWmMqHa63LAFyMUx6ThPzUcui+0wkhyiJVgmAU+bfAerCbdBPi9g/YthcORKblYA
 t2qWibKMzgS3ZOaFV1tLCOPKgqhL6lyPZ9Mk5ywAStu9du0UxQUxZYnSYnGgJ0ilzDH1konOz
 L11VD4Yku60io3UcKzf6C6sWTcnIz7fLhE8eDb7FNNBIw8a3FsmHSfNzQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/13 14:19, Christoph Hellwig wrote:
> On Sat, Aug 13, 2022 at 02:00:25PM +0800, Qu Wenruo wrote:
>> To fix the problem, we need to revert commit 7aa51232e204 ("btrfs: pass
>> a btrfs_bio to btrfs_repair_one_sector"), but unfortunately later commi=
t
>> 81bd9328ab9f ("btrfs: fix repair of compressed extents") has a
>> dependency on that commit.
>
> Let's try to sort this out properly intead of doing a blind revert befor=
e
> -rc1.  I'll cook up a patch to pass an explicit offset ASAP as the quick
> fix, but for the longer run:  is there such a huge benefit of having
> these logically non-contigous bios?  They are so different from the
> I/O stack in any other file systems that I think we'll keep running into
> problems again an again.

OK, I didn't consider the reason why we allow non-contigous page into a bi=
o.

But indeed, if we allow that, it would be a much simpler fix.

Mind me to introduce a patch to add a new page offset contingous check
to the related code path?

Thanks,
Qu
