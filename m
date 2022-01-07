Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B5B4870B3
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jan 2022 03:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344839AbiAGCpp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 21:45:45 -0500
Received: from marcansoft.com ([212.63.210.85]:36390 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344689AbiAGCpp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Jan 2022 21:45:45 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 70AEA43320;
        Fri,  7 Jan 2022 02:45:40 +0000 (UTC)
Message-ID: <d8cd9082-4514-9c6c-85c7-418356f1f66d@marcan.st>
Date:   Fri, 7 Jan 2022 11:45:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH] fs: btrfs: Disable BTRFS on platforms having 256K pages
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Neal Gompa <ngompa13@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-hexagon@vger.kernel.org
References: <a16c31f3caf448dda5d9315e056585b6fafc22c5.1623302442.git.christophe.leroy@csgroup.eu>
 <6c7a6762-6bec-842b-70b4-4a53297687d1@gmx.com>
 <CAEg-Je9UJDJ=hvLLqQDsHijWnxh1Z1CwaLKCFm+-bLTfCFingg@mail.gmail.com>
 <db88497c-ea17-27ca-6158-2a987acb7a1c@gmx.com>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <db88497c-ea17-27ca-6158-2a987acb7a1c@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2022/01/07 9:13, Qu Wenruo wrote:
> 
> 
> On 2022/1/7 00:31, Neal Gompa wrote:
>> On Wed, Jan 5, 2022 at 7:05 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>
>>> Hi Christophe,
>>>
>>> I'm recently enhancing the subpage support for btrfs, and my current
>>> branch should solve the problem for btrfs to support larger page sizes.
>>>
>>> But unfortunately my current test environment can only provide page size
>>> with 64K or 4K, no 16K or 128K/256K support.
>>>
>>> Mind to test my new branch on 128K page size systems?
>>> (256K page size support is still lacking though, which will be addressed
>>> in the future)
>>>
>>> https://github.com/adam900710/linux/tree/metadata_subpage_switch
>>>
>>
>> The Linux Asahi folks have a 16K page environment (M1 Macs)...
> 
> Su Yue kindly helped me testing 16K page size, and it's pretty OK there.
> 
> So I'm not that concerned.
> 
> It's 128K page size that I'm a little concerned, and I have not machine
> supporting that large page size to do the test.
> 
> Thanks,
> Qu

I'm happy to test things on 16K in the future if you need me to :-)

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
