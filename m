Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D73352B6EA
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 12:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbiERKIB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 06:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbiERKH5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 06:07:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE01154B07
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 03:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652868465;
        bh=sWbJhRwwBjzitU++wpPyHSP356/X/GzZuCvEEUFcvXE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=T10XNUSxRure2wLQZ9zS4UbWTq5mofUbh4WoxG703C66X32YI6UhRtX5muEIf2hw+
         a1LLVr8hF54yojNf9qtxblwO6sfa824T3LjYXmgpstLI1Da4n0YilAGtEpHsYrzPVJ
         Jm8VVTRUduDgrh4dGatusiFE7zeJMBbp57Er5o/E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBDnC-1o1kyc0eMw-00CeHY; Wed, 18
 May 2022 12:07:44 +0200
Message-ID: <bc356025-00b4-e5fd-2394-f00b3746a9d7@gmx.com>
Date:   Wed, 18 May 2022 18:07:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 05/15] btrfs: add a helper to iterate through a btrfs_bio
 with sector sized chunks
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20220517145039.3202184-1-hch@lst.de>
 <20220517145039.3202184-6-hch@lst.de>
 <PH0PR04MB7416A9EFBE86253DD0DB4DDE9BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220518084600.GD6933@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220518084600.GD6933@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dFoWl/MDGzVZW1DA98kVM4fgwb/BB0hYxyzAnGJQ82cAHw8zCi9
 iMyvThcCecnIEEhuIIs8o55KYtoopdIyI9gbLC2sieg1/yNgIl2cEPSKy48peIPTjAJR6Bu
 YDD+modlv0k6Mp1DBLf7GL7Ur3jZt5TBk7qoQKQ+9qIhcBcygESB1NbHGQDoK5DZXsfR9Kp
 TPxTxgOktRr09BLkqKtiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q7lRJy82NEU=:FhzRTGWcxSBwC0s7VaTW+Z
 ikwnuoGCQyMMUvZSkGPtLxv/4jj5kIYL2XzTJr4fVvu/cOSQi7GWP3uYvF5eycmTQNzTH5foe
 Q7H8fMGM1oh0LFNJAB0SIymPn/KlaUTfyOPV0tcsQfO526ZFnD4iFkyz8fHlhLnuoQU9ZkDt8
 8YwH6cXLJIsHzlaufEtgPSbsJXCaoC/oj+aZMYOarT9UB0ZkLlLvjLSfbPY78L3nXRLvz6nSi
 eSI0LR2QhPJV7TWvbpvt7NqpfhwMExG6R7HuN+O877bRUnxKYr1Dqg4kM0Vzu6TBCAkcCbQhQ
 59NYBAueRKmrI+fuon6IKuk1+9ailr48xNm0EpaIO44srH1y05oPIktkNvaEtQuodYj0Tj0uw
 gmnev6TikdeiqbwOZ86kymw6FChckmBEi/qKvo7PoTr7/QeL9yrm5yO+bzAsDW1mlX8/tPhX2
 BRoKPWW/TBIsr+4l8cNYO8ANOQuNhz2J9shyFeFQXVnx+cj7IcMhPouXY+tAfhdQfrIv9Z76J
 xBsWPXB+dec110cXnTzxUWzbo/EZlVsXcTC9H74BMlLEXCGCCjC3j4G5Ck2mznOU91OlikVue
 qTXsYGb2djTqnqm2EB4UeqReeLOhRiFhKHWTiqPPgprfagNNldqcvv/lS7hWIaFuTX5DRKFXE
 N2LsDit5/8KsHDpIU27IBX7WPwMdJzWdWM6Fxg6SHdBiJiXkjsnCiCtxpAaqS2nc99zIeQBxU
 9lTVLfstt1qOmOmLLQYR5+nSoP+AKhGK9LEfbGKbyv5mzimvPgRyR5qg28CLBsc2JILzt5iYy
 s4j8v6hPPXLL19xkoQ1u58onEpdjNrH02wsEWrOC+D5rGwb0Wp8RVo8XXyGO4SDGkWWLs4DfL
 lj2qoSI2ilX27BDZbK40c7nf404YnJCZTzMBR1F0LuLkIvpcNIxuf/v61KjmtPZzfrnjyatCu
 vMhkqK0sVd6FKqigFaoTTqWG4sxYb18piBFAjR3irdci6bogqoGgiGfo4zov7F1bW7sI3Lxyr
 Zi9a8QU+gnaDIbIBbcglq91qTR8e6QwBuy48YtFtnRCViQCJMdj2Oq/BrymB2ayNwiuYnOaTr
 KL/zVg/blLVR7zfisHURDGYhb3Km9pRaDMYEaUbaNnhL3jIcir/jQc7Bg==
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/18 16:46, Christoph Hellwig wrote:
> On Tue, May 17, 2022 at 03:27:35PM +0000, Johannes Thumshirn wrote:
>> On 17/05/2022 16:51, Christoph Hellwig wrote:
>>> +/*
>>> + * Iterate through a btrfs_bio (@bbio) on a per-sector basis.
>>> + */
>>> +#define btrfs_bio_for_each_sector(fs_info, bvl, bbio, iter, bio_offse=
t)	\
>>> +	for ((iter) =3D (bbio)->iter, (bio_offset) =3D 0;			\
>>> +	     (iter).bi_size &&					\
>>> +	     (((bvl) =3D bio_iter_iovec((&(bbio)->bio), (iter))), 1);	\
>>> +	     (bio_offset) +=3D fs_info->sectorsize,			\
>>> +	     bio_advance_iter_single(&(bbio)->bio, &(iter),		\
>>> +	     (fs_info)->sectorsize))
>>> +
>>> +
>>
>> This is first used in patch 12 why not move there?
>
> Because it is a logically separate change that doesn't really have
> anything to do with the repair code, except that it happens to be the
> first user?

In fact, there are some other call sites can benefit from the helper,
like btrfs_csum_one_bio().

Thus if you can convert those call sites, there will be no question on
introducing the helper in one patch.

Thanks,
Qu
