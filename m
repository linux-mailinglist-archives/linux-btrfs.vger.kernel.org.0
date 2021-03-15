Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E5733AD55
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Mar 2021 09:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhCOI0D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 04:26:03 -0400
Received: from mout.gmx.net ([212.227.15.15]:56949 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229939AbhCOIZl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 04:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615796736;
        bh=XwYebh+LUk8u8XuNWu1kX2jRwVDcOCt7TPx7bSfPg8Q=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ekb8qohIFBQ19wuwWLMvdZKKZ2uHQKRune99EB1Z1BxhQDMdG9qWhLkWWBA4GTyo/
         OHkEOrs0DfNSF6+UcLHgwjYuca9K4v7UVtziQXUdSAhKdO+Gt5QRLUwJlQV/cx5nkf
         V65xquU41VS3JQznNW0wHKCJoeJVcPquZ03ztnNw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N33Ed-1lim7m1Lm1-013NhG; Mon, 15
 Mar 2021 09:25:36 +0100
Subject: Re: [PATCH 1/2] btrfs: fix wild pointer access during metadata read
 failure for subpage
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20210315053915.62420-1-wqu@suse.com>
 <20210315053915.62420-2-wqu@suse.com>
 <PH0PR04MB741641D5C56FD335C864FD0B9B6C9@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <f4ebad22-2004-b051-2871-8f1ed64cc6cc@gmx.com>
Date:   Mon, 15 Mar 2021 16:25:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <PH0PR04MB741641D5C56FD335C864FD0B9B6C9@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Qi/9BR+2XhvBI9kwHHvVJBAzx1SvVDsOSrFHhy9UaJhtpjvanOM
 zRT/QXhAG82F/ATVJGfwNCDtLAh9vNmtNxiHRayBDDzzZSyfIv8N9tnVeE1vAhlJRXd2OtT
 nHeYgm3yePJr/PeYfFUbARWX2h3NYm5M6Q/854+Axl0GKrOnS84fwcdohUROe9LTQ8xjOAY
 3MzOvS51Y6/tPMPy8rvqw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wVrPG0X3k+g=:7NBDemMY29ajK2k/5c0qsD
 4/X9Z6oISwcPD6hdlomc1/RE+gJFXrJjPdUm1idezxhegGff3pPx8ms4pzcZBNCHsieMOhH+Q
 hDE4yqgCeR1fQ8B09obleGzJoWDS5WuccV/CdXhtRcxNcFgvdLhe0283XYYKspPEZjn6tz8vm
 oWpLOY6b3HBvkCwkLPFPLvyS3sayymZQB/sD5vxotE/P8w3XMAltw5z4qmToW6DC9aBtjfcNP
 Qrch4de5uoCR/edUwFTBcrd0i4qarqnTT+Hm/z4+EjZdC/UNZw2tOCfHVuq81pCxQB4FpaXFz
 xJljw3w4tO+CI3qv9upSyxpKIIrqgUOwLiUdPi9+QkXwdLRiMJszhe2LZ8mu01KGdNtJzmDfc
 l4rW2em1Gvjrjjl6EHJtji1GcPY3WjsMtUC1OSw+6lEHH8lNgAU5ckQU6EvD+aWUb5A3XFlL/
 402GoUN+6NvJIEe9ObAN13YDeSjrfRu74XgS4DMU5v7DjDTTLJ05FKCsl5I2iQZmFijkDCMo3
 LKStuX5hFGDiqvjK0FUW6V7XCValQSY5PCrLPYVx4EZ8wSBUM/LOpbZmuy3rK5UW0M/KPGBUw
 daiD+mi8PiBIWERPzig003zubjJ9AWFCNol2xij1TGi4D5jeji35oc1KQvHFqzZL2YuLE2LHa
 bzEkU1neUdmKWwmUpT4x74rw9RKXJWEUG1TEOW7YWoepylIXvfCCB0eR0GFJRS+XT5JYNhZK/
 7b6HZsf1CQo37qpYc3TO3IrnBh38LUBvvKNUmkDEUF7X+9DLVO2+VfkFI9eTdvJ09jFnsz3Ic
 7DLCHrS51DlJmQidqO0wLzNX51puWuiyE9V0iIFrRoEPETgmAukXiiZJ5JV2E1rJGllIX/Z6g
 Py4NlTnCp+7fXo74iC7w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/15 =E4=B8=8B=E5=8D=883:55, Johannes Thumshirn wrote:
> On 15/03/2021 06:40, Qu Wenruo wrote:
>> The difference against find_extent_buffer_nospinlock() is:
>> - Also handles regular sectorsize =3D=3D PAGE_SIZE case
>> - No extent buffer refs increase/decrease
>>    As extent buffer under IO must has non-zero refs.
>
> Can these be merged into a single function? The sectorsie =3D=3D PAGE_SI=
ZE case
> won't do anything for find_extent_buffer_nospinlock() and the
> atomic_inc_not_zero(&eb->refs) can be hidden behind a 'if (write)' check=
.

That would make the eb refs change too inconsistent.

But I get your point.

How about calling find_extent_buffer_nospinlock() and then dec the refs
manually?

Thanks,
Qu

>
> Note, I was looking at this version:
> https://www.spinics.net/lists/linux-btrfs/msg111188.html
>
