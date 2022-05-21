Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5659B52F74E
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 May 2022 03:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350003AbiEUBQ3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 May 2022 21:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbiEUBQ0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 May 2022 21:16:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400271A838
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 18:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653095773;
        bh=e5sbanCLCpgo/XiZB8I778mGAeqey8pVM69iczF5lww=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dMLhmVb+nPJHq9lOtiA3GzHy9ToibPne43I7+xuYW+oqXPLaSsiTikte3MnU5tGp6
         IY8iJ0CKRzZjsQFYttDgSg+GWmaS/ExrC7gk4zj652u6WVUrkfiw/75FYEI8cTtEXV
         npoIBQAL7jfh2jz5quSxGIr/rdLuttjoVMZS7lVE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4hzj-1nlVz11Mhj-011fxY; Sat, 21
 May 2022 03:16:13 +0200
Message-ID: <3f182dac-a163-43b0-21b4-751622e3ce23@gmx.com>
Date:   Sat, 21 May 2022 09:16:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 05/15] btrfs: add a helper to iterate through a btrfs_bio
 with sector sized chunks
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20220517145039.3202184-1-hch@lst.de>
 <20220517145039.3202184-6-hch@lst.de>
 <PH0PR04MB7416A9EFBE86253DD0DB4DDE9BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220518084600.GD6933@lst.de> <bc356025-00b4-e5fd-2394-f00b3746a9d7@gmx.com>
 <20220520162736.GC25490@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220520162736.GC25490@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w2zNTVtdYUHzuE7DEng8ySuPK6h8KBd4FxbZvpknIzGkXTicb5a
 4ve58DDmfjkRE7bY1DDKe3BHydXlc/5uPqkm/vkFJ968sjAObUu+L01JSJ5az+x7do+Fwmq
 GtPAhwSqOxDlT547nBi+CV1et3OBbBRmPvolF4LaxWYgoSw+JsWFz6OkZFdZ/ETgGjpdkWP
 mNcsDS2LhGxJ/TrlnPuvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mt8HoRMNvpE=:DNDqummSEmy8tii8yHKy+Z
 aB5Ewi3ym+706DBJVf2CIPIdSiO5gZJ2B0oJkiKAzZg4hfjSdUf1c7jyMoU8gtxvj8qO7j4OD
 4RiFjiRpt27up4i2EZDSLEcayouNB4kBLkm7RE1kcyfvR4xKEOar7lzGKyhbuUeF7XV40hmp/
 tWmK4SrHtzCIzNxbQxLSgbT/v8AMrxNsxpuVx1b2TW2PKNMIRtI6Qrjb0oFWe+S9lJcWrVFP+
 K/2EOyO+eIuvx6/XqWTrVg5CHQ/z+Hx5/FV2QNnq/kVCwVqq22YIRzHhYZt2xaPcoYjliq9DH
 HbWBR+5RAJwfvsJqUq7XESFd2mlvx8FqPi7axvbvYsT37EbnWxd00RIn9OgphM3H2j9dOYNIQ
 Uxzgc11xs0Jj2SEtdgBtcFWYGnRdus7P3xjocwIyGcmIH44r2yGOx6Z+XG2TFZOaS8lSC9g8k
 dTtrId2chh1NzIINJXGBIoQz8L49MZcm0HpY0v1gLQM8ZAVyQZ8SFdu92oJt3oAJ1HktqtYXf
 oqnud+9FGMjAyxPx8RlecmMfJLOAQM9Bzcnc5In/FZvBDhXAy7I6EFvbMLXBpflujmHEmwwpt
 DH5DZvKaCJwodbVJ7q7lFPkvQjf503RtneccPf8hXkB3lmB27nsNlV0BxwhEaCTyOC8dOt7Zl
 7NmUxOac0BtLrL12eqrNhumntCwRl+4TwiIQ5NtAVYBlXwOKkH+GL6SXoPYwYBXVsmy9vARyl
 F7BzAL6sqAuRoX8FqeVda+jDWxlWcFWIpoZE2JXpuRrRhqdh2dOeddIFuZ2kjgyKzRDCLKy3y
 YXiz5Gn41XXbWP9YUsghAlr+rN5pC8jXKIQay7Tn9c2wicLIhUviRM2Ue+HpVHhnZYA/S7wCY
 nUEGbRut2Rgi5H9tTg1QaOOI118ZhZuhDKkfzXJ8hal8GXIZph1cqJQRvuQq/JkW9DCm5veRb
 WzkYQN/AataRjTGfk/189ufUwUiymC4UKk+7UKdIIsBdN47VI7uWd9/TfMK/H1IIqraGTS6Rt
 gLylRD17S1sTcUJP+4tDOEvtPFQsDPbk1a6OCdxWt+3KPUavCoF5zJeNhn0WOo2nrMPOsi40j
 rdL/10e0OdoA4XN17BJTcCw/zCqmSTYtl25+jMdB+v3Sy9ZGYzkq1vcSQ==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/21 00:27, Christoph Hellwig wrote:
> On Wed, May 18, 2022 at 06:07:38PM +0800, Qu Wenruo wrote:
>>> Because it is a logically separate change that doesn't really have
>>> anything to do with the repair code, except that it happens to be the
>>> first user?
>>
>> In fact, there are some other call sites can benefit from the helper,
>> like btrfs_csum_one_bio().
>>
>> Thus if you can convert those call sites, there will be no question on
>> introducing the helper in one patch.
>
> Yes, there is a bunch of places where it would be pretty useful.  But
> the series is already large enough as is, so for now I'd rather
> keep that for another round.

After more thought (refreshing bike riding), considering there are
already quite some independent fixes and cleanups, it looks reasonable
to me to split the patchset into two parts:

1. Independent cleanups/fixes/refactors
    Those can be queued for v5.20.
    And especially for this helper, I'd like to rework a lot of call
    sites to use this helpers to simplify the code.

2. Real read-time refactor
    In fact I also want to revive the old initial RFC version, and
    compare with different versions.

Does this sound OK?

Thanks,
Qu
