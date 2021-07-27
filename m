Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765993D7218
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 11:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbhG0JfL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 05:35:11 -0400
Received: from mout.gmx.net ([212.227.17.20]:42799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236087AbhG0JfK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 05:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627378507;
        bh=Ifq/r9IxuBTZr6d9lbqgascfM3lcUz+OmL6pB1IDZmU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=HeyOnu5u/gekfC+2E3lv3tQFgNn4nCSoRYqBf3+h8QnyV6fjanr2Pc/WfgEcjoxXd
         bjCceiMfgMYJTLyuqN603BpjZjMBIkteAPpt0u20RwRMre7aTQnFvNkl1ffu1TShbY
         lh6vOwpX6Y7cr7U8pSx5rZb9TanD23Sa6QekWdvk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M59GG-1m7DYs1Mua-00184p; Tue, 27
 Jul 2021 11:35:07 +0200
Subject: Re: [PATCH v8 00/18] btrfs: add data write support for subpage
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210726063507.160396-1-wqu@suse.com>
 <20210727091057.GM5047@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <e2568100-c8a9-7b16-a394-0c50071ca9a5@gmx.com>
Date:   Tue, 27 Jul 2021 17:35:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210727091057.GM5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HLOBxh/gDJN4hn15F2i1GRNtXCagbxadc+S1KH2EUKDdSwso/BK
 6bYzkpkki2ibmvj73QcDw40tE13+VasNIVNuUh7jzefxqaD4jU4bc82gE9z0I3AI3kPGSGW
 NLurahgTUxlOwYQ13pCisSnZTkW0QWR8kMaJHiinsnv5tpeOnzH1ERL9zunSZdh60pHz6dE
 UNc4Of1x+vGczSENKcmGA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MjUITB0BFkg=:buj895kP4tdBIjo+IuiV8e
 ZIl3EPzpne6Fci5eCZLeEXNYgro/DrIjvuHgYd0HZ2OTt+vttiSEG0Zm/qkGeT/OUL875JF2o
 Cd/PsBwU7gAVzaff9gZB7DTdhztvC1WfufDDuhfCxMHTjMvVidIipg7YEcTvXhJXJLcbirhoU
 RR3WRAhY6aJYqLVgz6oFBFZleEhPfPTutzrruHde81UerhOt0EIR3LOaJlyCnMNNtbSoXUP0W
 X+C2D1eUQyaP7oBccMYlUqTYTnp2y+TqphUI/zsWFDtS/yFVas2HtgccjTFvZSWd5tR8uKZWW
 TuoNC6NcOdMhr+HSibgP4fBS2kp70enG06v6PlZxE3GuHZqlifAmKAJnvfc+/LgcQQEj7aQIs
 4+uLND0IwPSnl55eFcL/U7gHXuDmFpQaz1bIXYupRdhQeMCQweoA/4b1cXl8c45YLC8Kpg+CA
 7IG88xJOqRlgC3PKRls0aaKV6WImEZUnZDFtmiTswCF+HO6gsfzwcuID3xpHNcBGLDmx8V89w
 SBQAfknA/VKwya0GqpBIMoZvLjzItiMwqALMD7SbV+ZdM/ZQhaN/1JlYmIXaFk2IaLUPpj51s
 E+EZ0SoCNwJtBk56TkmdAwl0MSV9L8dEJz0HGBrqINFTqFii+FQqWMx0OQhZt9SqW7Zw8vsp8
 NVRKij8WcBZmovOFhxazJyiYf0/2Zurmvk6o12dLV3CWqRTEYnU3SOdVyezMfEKjd2FrcF6zL
 JkLEAqYY1vY8OOif0clRUECsxzz+2X8S7/pGSx0I98TtbF82fEkqN/mITb2JF6o6EFQbKHIrb
 IolPNdhkuIuDNh0itOOw8/EUzn8jqdw7OVwTMhe9M0ABD0gxdFaZ9JLttI/0EALS3YIEHuR7L
 LLCKNsMGHgCkuCc/wcraId+XhurgY63VSJowDJUYqQzKovF0rrQaF0WaTiME7Hnrea88C6JXs
 VcyHSNBwrV6jHJKnVDuAc9wolkVeLOendbGh9tYVG0C4M/037pAggVXpjjOu5ddWMJp3QFMxk
 mSyU+R6vuBpkJZejeT9pDk4sVEaevKXjhD/KwJFVRrPiyU1TGvj1xdLH/IkJSD9P2wl2bnCbe
 AplO3MydVSgpDJ+PoAIpYn0TdM8jTGIriL4gdH7ol/Ogjk1pyWgPJYDEQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/27 =E4=B8=8B=E5=8D=885:10, David Sterba wrote:
> On Mon, Jul 26, 2021 at 02:34:49PM +0800, Qu Wenruo wrote:
>> This much smaller patchset can be fetched from github:
>> https://github.com/adam900710/linux/tree/subpage
>>
>> These patchset is targeted at v5.15 merge window.
>> There are 11 subpage enablment patches pending for a while, and not
>> touched, thus they should be pretty stable and safe.
>>
>> While there are 7 new patches, 4 of them are straightforward small
>> fixes, the remaining 2 are a little scary as they reworked the core cod=
e
>> of compression.
>> The final new patch is a special write path hotfix, aiming to make btrf=
s
>> subpage writeback more robust against tests like dm-dust.
>>
>> The rework should improve the readabilty thus make reviewing a
>> little easier (as least I hope so).
>
> The series is in a topic branch and I'll move it to misc-next after one
> more round of fstests, yesterday's testing was ok. Some of the changes
> are scary but I haven't seen anything obvious and once it's in misc-next
> it'll get more exposure so we'll be able to fix the remaining bugs.
>
> Please send any fixups either as separate patches or let me know where
> to do some simple tweaks. Thanks.
>
Great.

The latest update only adds a new patch which has been sent to the mail
list before, and that's also after the enablement patch, thus it should
be pretty easy to apply.

All other patches don't experience any other change AFAIK.

Thanks,
Qu
