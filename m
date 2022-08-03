Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4305889E3
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Aug 2022 11:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237649AbiHCJxp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 05:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237666AbiHCJx2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 05:53:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F213DB4BA
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Aug 2022 02:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659520373;
        bh=QdhfPyE1y4mDQZ36qqCIB1sJeMhxFP9NUg6jj1tygOc=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=buZ8SXKRDws0YU5kv+GMDHZD/88DtFjYRU64fNMM0djgxrtN1sAhaSHepWvTpvEgN
         gQIthhtGG2B4/8g8FtjjdrhgJw3psV6pUGUS3fM1MekQCkcPILEcdmP5cwm4AeAbn+
         R9mP23KqEWzNFIU/9sDiUQtxG4+pDPAFlwfYN7fw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MDQiS-1oAxZy0bVG-00ARyb; Wed, 03
 Aug 2022 11:52:53 +0200
Message-ID: <03c66233-2236-af2c-bfe5-b4b70f2a9965@gmx.com>
Date:   Wed, 3 Aug 2022 17:52:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 00/14] btrfs: introduce write-intent bitmaps for RAID56
Content-Language: en-US
To:     kreijack@inwind.it, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1658726692.git.wqu@suse.com>
 <9494ba7a-baf4-540f-dba5-b47bdc85162d@libero.it>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <9494ba7a-baf4-540f-dba5-b47bdc85162d@libero.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O9tczVt4sAc9gXXmONreWSDxxY9zRHc6ayJinOXylpJgA1MmcjN
 a/8lul9c2Wy3nVJatA3m5toCXodKn52edDrOUfseFWQh6wvtljJLpN+o7iqu+d2U5YVmiB1
 O45QmPsEPfbmg5W3gnQTsaOwHgHJQpbT5wPhD7Wsiapkv2AOn8HbXG+3pdpJKoxYftctKMR
 6Pr5H6qvYXZ8mT5EltETQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V/1EQ2XuTjg=:huDqySwLTmYSJnskuTvo7i
 VGVeJlo7ypztBXY1ag6P/N6mVNZDzqtY6RYq79owznNKLk75VXw/bBenv2CbtZwRVyjORDgCG
 i316Uu420Ee9kx+tifMooM57AELPRk3ByKzxgnGDQJ59M0gSZq7wN2N/gNSZSmy3V3+Qga2/r
 XVAlSargJFFJsHMMeUQ7SJYbGtGUW98d1mh2t1AkyMLbD47MTGo2CqO3fJIrrGJr9E+UZofwd
 /HcH/tp4QVxklIi35Q7Hn/iT+rqRiFmxtaN2JDMPiSble0ySHhjPDkZiAkiWkUrVXDYGCFlTI
 9cR4KM/N5QEELHiBA//uq0JHlSWSGTp6iNuatLoFkqjeXyVfjFa+RrGXfGoTOWSr3k72c8Lbd
 NJ/KVLg8c/0iDOwMSgAOfKTQq2AXqk9JlsdqGOKndJzsnxcQPCwK33bKsEvu5MO1oQVNsJdQN
 1e1rfVqMAWTptTsvP4gkmaa+C1fX7xb/4aEUP+LWRiLaI6IdHWHEGsbI5bXYlluLAbmNZtaLf
 M1wipXKO8w9oFyRMhDZRAaXopvxrfannIouLcNjqDPpYqaR/nzljW9UEeAdjz+5mts6DC8KYC
 xQkVCAUfV34bIfuM5qIFv2nQAZvUgA4SCnA61JYcKPZDUxQEGKuDlcViyHRn/+nT7GaMWjewK
 2EwHDi8j6YUHjH0XUmx3TDaZCAE9bT/LpQIgeyANMIDJt3T18LTJDsr8JPosnMQXr6XmYClqY
 +md9G2MGTrdgkDIbYhcxPql1yy8uN+4l/twa7v78GuEyYfwfMt6WZHClu2w5bf9neWWvWYrU3
 r1ptnsNeMpLGxhP1NrwvkWEOong2sOgEPgQ2fwSKzww04gu0NZ+5eUT2UpXgig/Ke1vTulYHf
 5sun9z7mBX3Vz1oB5RrpU4AC2A1fSGENQ3S/bWeTozqG7lmtfw229bOv8TlpjSzOYbeu59erA
 jWQWmbcEtBc2vyJtOcuHQS4kS3YV8iAEZxH9YLECfHpRkYrl+lCuHD7+TWVZEZ+I1BIHmDnPq
 SJ9FEAWIop/sqozQNBRAuYFf1jEfY8Iaoai1QfWe/E9Y/S+bRgFvDYdvQ3atW3aEw9dwXxOjw
 JAoZoccLurR1ThdMmgWjG9sYuJH2MhFMsUMVMeFkGf5segV6ZJLRS7hEw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/3 16:48, Goffredo Baroncelli wrote:
> Hi Qu,
> one minor tip in the cover letter
>
> On 25/07/2022 07.37, Qu Wenruo wrote:
>> [CHANGELOG]
>> v2->v1:
>
> [...]
>
>>
>> When there is a RAID56 write (currently all RAID56 write, including ful=
l
>> stripe write), before submitting all the real bios to disks,
>> write-intent bitmap will be updated and flushed to all writeable
>> devices.
>
> I think that the previous statement is not fully correct; now (with
> patch #13)
> the fully stripe is not logged anymore in the intent bitmap.

Oh right, forgot to update the cover letter.

Thanks for catching this out-of-date paragraph,
Qu
>
> [...]
>
