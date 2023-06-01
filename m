Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEA57199DD
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 12:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjFAKem (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 06:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjFAKel (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 06:34:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1006098
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Jun 2023 03:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1685615675; x=1686220475; i=quwenruo.btrfs@gmx.com;
 bh=kG064dCIsNZOXKNio/fqMhnmsAsgkPzGB3okB2p9YyE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=J4J2z5aXMhcBwsWnCiZvR/D1lwk9s/vu0xAMQxq43+Y3z9fKKjR0TGRZEYD3EZzAfk4A4qq
 zY77Lz7Yr792Pu8UycA587tBuovSgIncKaKghZbiVCyDFBTY0+eebk4yZuxVoGtt5Fopy+t58
 o5b875vvEtAbpPmA0MszBldBgtM6oDPXPrsTxoIxTuLt4eNnBnn72TCusqWKYHIi8Ih99BDFx
 6LyvhaPlA49bTJEg9MZ91gGZEas+5e2WZ7KVKvHyP17tfN6gaqYaHOakYsjU5Qb2HPidYtYjU
 CsWObMvuwQpzGqSR3KJc2KFQ2bCNaYElVvgqHwRHxip1MaANiGIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mo6qp-1qPONt2bTn-00pdhl; Thu, 01
 Jun 2023 12:34:35 +0200
Message-ID: <2563f49b-13e6-a33a-d3c8-3f5cdf01f0a6@gmx.com>
Date:   Thu, 1 Jun 2023 18:34:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] btrfs: fix dev-replace after the scrub rework
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <0113e9e82b06106940e8ef7323fd4a9c01aa5afc.1685610531.git.wqu@suse.com>
 <20230601093747.GA6652@lst.de> <bbd57e3d-c61d-cf1e-6f8c-386c24625a69@gmx.com>
 <20230601102217.GA10149@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230601102217.GA10149@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nLw7W3kpNObQqOpisbMZ2axi/HADc00rzkLR7x/dHdIg9l79zWM
 I6e+WfHGO2B7ojxxZfZAy/ELVadW2STHDO1wVTmg/wVcARoXmuWPYWJBfYMIDtPVG5FtmsK
 y3mOKj410H7WD5D8VHNqljXIKv0WRHpNuTMPXobUAVOvIPTkHrgKFsEBBGPLALOLa3Hp5f+
 FKAJRKUURUb6EzQc2mGOg==
UI-OutboundReport: notjunk:1;M01:P0:XiTNq/uB5/4=;qAlsVcTLBvc/II/PT2lYG1NyOow
 PRkGLh2sxVtOAWuFNkebKYN2mmmHOCexcXHi/blnORNQi20dpJcChYBoToGQQdKW238t07kfH
 KMsMl11Lg2AsJBxbJ4r/ZU5kZubyOPK1PFMK14FTy43DmigExMiSI7Gbst3pWnyKtZp8DIB8l
 RsF2nQQLslTPQNERR5OM6ZB7odcF0Agks4SNxP/hRNcvxrIcaAZyKBp3UHDqT5O/IwWpFSsfn
 bia/jIPLiXgFxmaPXziYVwjgLF4uCmn/fRWtrIfq62azk6zCySWY96IOn+CWXD+9XdCtTpyhh
 PvheBBB8MYXgAvJhLEN43CB1VLxXYFkjaM0Xw7I4NPwbkvS0Nh7PssaTRo1PZzAe0bzjmypI8
 alHCOl5XytoREFXAtZxdcl85Si/tRcCad8HgTPMqZwlQExdtRkR6q7yvKju/+Oid7BPfDsxo1
 jt39p4fS+e8EWZcMOmJpyugBh5rm+H8VxyOf38tFPMdU64lj8YrwK79M7DTqIVlGomqZJubZd
 wjRRXeyZundL0SMICCoSYmpqa+DJxO8s4ak9FmPWsuGxDUZfDY9eXHdXORM+Nu6EYY2efiHWL
 nOTGLXSB/lUGhMJ+jmyrYvXflvzld1Kz80WbuZpFLCnRGMwRyMOU+bv3xHxuh4m4Fci68xveM
 Z0uoSUK/IP1aYSTsDcRUNO54YFTxSG9ngjGsWlFqAnNEo54M3qOsH9nKXEphAcOxTxnC3K5ev
 qqWPIt56P8VWpCH0dFATBcu1V1ereCFQllorGCu1ds237a7P5eVlv3o1RefHA07iRaVHe/Hb4
 +HZy8dIdPTYdbb2XmcNgu4+fqUZsFG7p/xAlOScch/7v9DIs9VyZl9t5lGKcbj/tm5jR280pj
 9C/T2cj5wyl+lJ96wWLUgnXWWfChxLow/sfAGOpkHCPFhWjp7cevU+GWsO4Z4332v59FKRu5Q
 s2O3r8yxOoCEnS7QS37t5beyTEI=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/1 18:22, Christoph Hellwig wrote:
> On Thu, Jun 01, 2023 at 06:12:12PM +0800, Qu Wenruo wrote:
>> Yes, the cleanup is also in my mind, but currently I prefer to do the
>> fix first in-place, then you can do the tide up after the more critical=
 fix.
>
> There isn't really much of a difference in the diffstat between
> doing the consolidation and duplicating everything.  So I don't
> think that's much of an argument.

Indeed, I'll update the patch to cleanup the call sites.

Thanks,
Qu
