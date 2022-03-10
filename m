Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9B84D554B
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Mar 2022 00:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344318AbiCJX1X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Mar 2022 18:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240855AbiCJX1W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Mar 2022 18:27:22 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B31199E2C
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 15:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646954776;
        bh=SmAflAoWjniYCBpcHQhKyt2CtmMk17LrGgpkmmnTZHw=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=IfH/acV+oV5iq1WroTWj8U2YkeW+gBoA8asQpdJ0sv+vB8WoKo4tOKFpFcAf+lG0B
         lJJ0PF/Z0BsQSrjREL+fvfxpAlBlmkqxaBdo8GcKOzh5ILP4IuMi+79kb+JrusQg17
         jYeCZGThSSIcShxgW4ETUzmUyKVXmK3S3/zoWwIU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEm6L-1nLcgW2C0R-00GIy0; Fri, 11
 Mar 2022 00:26:16 +0100
Message-ID: <90dd757a-10ed-2212-6f54-0bd349808dbb@gmx.com>
Date:   Fri, 11 Mar 2022 07:26:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/3] btrfs: scrub: big renaming to address the page and
 sector difference
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1645530899.git.wqu@suse.com>
 <20220310192900.GD12643@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220310192900.GD12643@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gf2HVdvM7HXJvqUb285zKVQoos7ESw38e6FB4n+SZwGqnWV90rm
 gfIXRBfnbfWNZvm1M2vrdJuSR4uVYBUPIw3V7T4DuQ63Gzm7AgOGRleTGvOrFGbiAawwFQI
 GWAd3cMKNR/ugCs5yU2iXveYp3zXe1KWu0OKlgKx44o7f/qZYAQgLELXv+uUqiBv6hL6e70
 6FYgJey5OagW6P3cBxi8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TDrXW9rX99Y=:VhSOgm7mX1DWA2qb4D3Nbe
 Dxg4ZYaDCfRd2cN09IgsoYVLVRn7r3HF7vMeKjTiO4wOu6BHVeoGdFsHsTgKYXbZjqIr7RePI
 PXKwckyKn0McnE7o3fDEYVusW3JgmJjYMtC6Ya3u5XVAkesIE6r7KSk8qZMmaQKKR7kPaAwCJ
 UgourSFUQpOqwjR3o5ZJvt29+967oeWUYwN6u/LgqDplrzZOZ6O/3c2pL8xeQztriEdTnDXeb
 0bCNIA9Y87PIldw/htZw+PfOkruzEDDvASqdzkD2Vf1kjXH1+iLJUCClwpFbNBLAmaCU+/FNo
 GLeUERejeX56uoA/+6sLM4axrIN+OzyCfTldRmtu2u8nIva6dJjS0axL3IstXnVT1BlKrQ6py
 skOMEVNj0KST/bnbtbH8IiAvzQfCs5KPM4Rnqop338Dzi4AgMEBA73d87FGpsSbtweAI0eAcw
 MmIcWyNIq+XnDJT/lkuIBr8lXA504uDUj1E8LDRwnkswxrQjz8bp/Ckj28k4iFtxTwp+q32os
 dZoPvBDgPYRBeTbyHiq22/L1Y7DxuLWv4WAUfd4WLy9I1CMbmlQOCyxUW80BjylKCLYaHxh99
 pfDXtgqkX17BuPcBotSCzUeumAhEF30cb4A2EBRQnrwYcHHiJed08R4LLDhHgyxXP5rcPHBYS
 eELPntqwMCzpgHVoijFuZ8UViSoWxxwYZ8ySCM1cVhdKZIeLRYtdTB+jnY5RPysOoldFr+IcS
 IOTDsp25UxZmdrKDBqFPCbHcyLZx5Qmgg2CEF4Q2bzwCbXVthiTR5Tq++9vyCnEu+sfFqwgFU
 Z/wekHMGna8nWi1Tv3vWP0GitGuDjbXNlrzw2tJGDXhWG7V0G4X2pqRAhSJ7CBWRd790tIL4P
 uYvRpuZiJyevdBigASxlzj/CLfnWkicRumKWjTblYCSR7u/Xzy3U+8GIOKf4PoKhURfWRK5VF
 9ZrV1E7SXTBHbtbhwsCHQEDPmz3ObcMbVc2h9Uc/JN0hQfOmYQrGycWQdMCjlMovs+0WMIKxL
 S8chQm466VVJcxj27dnuOR1QQ/TsR5Z61mqy/WJTdz77dFdGsUT5eMiUBXtxAHqsR7uaWIBrq
 3qi0A3CCQK2czo=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/11 03:29, David Sterba wrote:
> On Tue, Feb 22, 2022 at 08:09:35PM +0800, Qu Wenruo wrote:
>> >From the ancient day, btrfs doesn't support sectorsize < PAGE_SIZE, th=
us
>> a lot of the old code consider one page =3D=3D one sector, not only the
>> behavior, but also the naming.
>>
>> This is no longer true after v5.16 since we have subpage support.
>>
>> One of the worst location is scrub, we have tons of things named like
>> scrub_page, scrub_block::pagev, scrub_bio::pagev.
>>
>> Even scrub for subpage is supported, the naming is not touched yet.
>>
>> This patchset will first do the rename, providing the basis for later
>> scrub enhancement for subpage.
>>
>> This patchset should not bring any behavior change.
>>
>> Qu Wenruo (3):
>>    btrfs: scrub: rename members related to scrub_block::pagev
>>    btrfs: scrub: rename scrub_page to scrub_sector
>>    btrfs: scrub: rename scrub_bio::pagev and related members
>
> This conflicts with the scrub refactoring, but applies cleanly on
> misc-next. I think the rename could go in first as it's a less risky
> change and any fixups or fine tuning of the refactoring would not affect
> it.

No problem, since it applies cleanly, I don't need to send a refreshed
version, right?

I'll re-arrange all the scrub related patches in my local branch, the
planned sequence would be (also the future submission sequence):

1. Rename

2. Entrance refactor

3. Subpage optimization

Would that look OK for you?

Thanks,
Qu
