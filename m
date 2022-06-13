Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C422B54A2E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 01:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbiFMXuf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 19:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiFMXue (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 19:50:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC59A33359
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 16:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655164229;
        bh=Y17WQLAchr4mbPSlQ78MiPL6+W8sAQdZHSINEEZoYsQ=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=GOoeuX/qtn6WiVtU2/dX9w/W7fYD6z3lzG/sdhBuwJA7ohr0OLXPvSYb/Vvovds7/
         YH1GzbPT6mAgFrxDoM4M6ztuWgUunBj43MGqZs61NxpcLtDNiJVNTzRG+IHG+9XDtR
         IwvGL9HdNIQfv6WCzFDZdSLCqurDRLoOv2Jd+B3A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MpUUm-1nOItk3KhQ-00psQQ; Tue, 14
 Jun 2022 01:50:29 +0200
Message-ID: <0441092d-db6d-000a-8652-026720bbb931@gmx.com>
Date:   Tue, 14 Jun 2022 07:50:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/2] btrfs: cleanup related to the 1MiB reserved space
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1655103954.git.wqu@suse.com>
 <20220613182034.GC20633@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220613182034.GC20633@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dKdo7tJsngP+1rwamn6mekf1WPwb4frgL9XGTofHD4U/zNCVnIw
 X8737GVQV+ouLA1bQwQA5H4GtmYS1ojzAvHyr46H6b49LiwuU2F07YZYC8SFVRt9t121IzT
 CxujA3pFagpcKH0K/Bd9B0NcyAAJkxClv1vNg5TSfpIeV6+F6UOGBsHNgeEaJ305Kr9k+p4
 Mt3Pte8rqDKUk5ERCBNvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/d5RWltEckk=:EIEK8a6map8Qi1ITeZLZf4
 3NBx4HHDDU8dsQP78deB2yLvTP6BSQrICGyeZxGVSIZicPpK85clSN1liN0IDVn5qSZbdXene
 eHT+PQ0+xctTOkmG4tykZxCYgA4z+kqrOiJogvw4SRUM7LHB9pwjQOP1FEl3lFhmf1MRrgh4U
 HNtMS+xTZAn40qybTyPYpjlao3s6IgKudLcBKeWyHSwgo3+pAtL1nqE1yE3/v4Wlbm3tqth64
 FJWDi4GacOXzG6g42lDSgAoeGLwPU86ZkMhAzyHZwqChEv33rdveOeMeLrC6od2lX5hqzNj5A
 pdyyZyncW6FqQKZkfIjLVWA760sIrFNdN76fzqQdb8M4TQYVde9cR39uXmpCFLjjDr72LEh9I
 LZo0TFZT8gEUNIqEa4BN5MNF8U4kIUvh/pfwWAlBWxnBzUbirEGqq0yxwvAUT5vTfZvmdFCIL
 ujStf423R8RMMTjIKtteZfVdOO/7lHK6RkNoSosk6RdSjQ+RKQTqR5KYjGSFsKNhPtnJmP50m
 Tvz8d217jpF+gX8Gz7ffGaQlab8dBD7IWGpeXJqilqwBN3Tcvf3Fog6XOGlwmfPEmsxxpHSPB
 h75o8VujsJl/asn0OoWq1IQA5ydsvPd+9fUxSb4CzpEzIHdlUOg66MBU4CZmn3GTG/X6cPkk+
 pLolsgv0i+G7rkG98Xdfs+n4oGk6epe1OkET3R1PpMStDGqrR7kKN/hVRGQnmnqPqwTC+27ou
 ogEoXodxaTkR4OloemOB0CB8qXE3gsD1L05ii+UcrU35q0qY9RLUnVfwvZFoglTRDYULh4BFf
 2CwgaGk1Pu9piIhqkdkUYapMQzZON4tp6LD8Hr82XN+xHg8G2X9kUbcEeaXtsbGozxxs64GgI
 yIrJOVEPBiPfvlHcBmcJJNkMuZ0dSFozq8kA59mSjBY+S+ibvgkiVX5bhHFtBUzP9PFlZbdEU
 as33sJ2zLHBB3nWXXlF8dcfg1cvgPtXiT+n5drIkClmyi+51iRivQivrx+MZe4NbB4DdQcSWs
 b0j3F/rD57O1o0dNrp9P0wpIyGwMJZMOJWFOsVY8awdAvtNaXvWMvr1dvngxQZznyu4waZpTV
 k1tVlQyPOA6Be8ZU7l5K4IdVdb/vi+fuuBQpJZzGGNQGWufuMNQPHxHXg==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/14 02:20, David Sterba wrote:
> On Mon, Jun 13, 2022 at 03:06:33PM +0800, Qu Wenruo wrote:
>> The 1MiB reserved space is only introduced in v4.1 btrfs-progs, and
>> kernel has the same reserved space around the same time.
>
> Kernel had this since the beginnning, or do you have pointer for the
> commits? I know that progs wrongly allocated some of the tree roots
> under 1M and this got fixed, but otherwise kernel never used the 1st
> megabyte for allocations.

My bad, kernel part is indeed doing the reservation from the very beginnin=
g.

>
>> But there are two small nitpicks:
>>
>> - Kernel never has a unified MACRO for this
>>    We just use SZ_1M, with extra comments on this.
>>
>>    This makes later write-intent bitmap harder to implement, as the
>>    incoming write-intent bitmap will enlarge the reserved space to
>>    2MiB, and use the extra 1MiB for write-intent bitmap.
>>    (of course with extra RO compat flags)
>>
>>    This will be addressed in the first patch, with a new
>>    BTRFS_DEFAULT_RESERVED macro.
>
> Cleaning up the raw 1M value and the comments makes sense, but I'm not
> sure about making it dynamic. We used to have mount option and mkfs
> parameter alloc_offset and it got removed.

The dynamic part will be done at mkfs time, and will introduce new RO
compat flags for it.

So no mount option to change that.

>
>>    Later write-intent bitmap code will use BTRFS_DEFAULT_RESERVED as a
>>    beacon to ensure btrfs never touches the enlarged reserved space.
>
> Ok, I'll wait with further comments until I see the patches.

So do I need to include those two patches in the incoming write-intent
series?

Thanks,
Qu
