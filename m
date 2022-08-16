Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB93595458
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Aug 2022 10:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiHPIBA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Aug 2022 04:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbiHPIAi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Aug 2022 04:00:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE9454CB9
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Aug 2022 22:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660627105;
        bh=EWSZQu8cF/2rLkZ1+C8JmS1nJBPDztkLrQOWw3D8rmE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=IDWG7tqq3LKzH2NznwZ5ZIyqhtFOd4Hqi1k7xOm9YHatxcZVURynDTIOZuSuPR4cA
         irVWMq3SQFUqpcg+XSqknlgqalPuhkPc0r1DXB88WX7GvusiY5x317dL5aAECbowVh
         KhnqHDzHvEXHquORmrH8XSwaTHiEVZJIFuZcdi8s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M59GA-1oOvQh3ysO-0018Rt; Tue, 16
 Aug 2022 07:18:25 +0200
Message-ID: <158cf69b-4797-9019-f137-7a437da5dd77@gmx.com>
Date:   Tue, 16 Aug 2022 13:18:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] btrfs-progs: chunk tree search solution for btrfs249
Content-Language: en-US
To:     hmsjwzb <hmsjwzb@zoho.com>
Cc:     linux-btrfs@vger.kernel.org, anand.jain@oracle.com
References: <20220815024341.4677-1-hmsjwzb@zoho.com>
 <65c8f002-eef7-365a-8f1f-53a4d8b216c4@gmx.com>
 <30296ee6-594c-3964-ca71-4c2fdafa4e05@zoho.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <30296ee6-594c-3964-ca71-4c2fdafa4e05@zoho.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2v520inrAJslZ1lWWgecnFV8FZm7R+VlF2FKK3NUUyJGRGxwO7T
 clOAAN3gUIefrcKYeVwwbUgoH1BzfkFhEzppAbDmfEZlZsL7mEQIjGkr6ZHGoKbY57LQp0O
 3mkJOqsiauZBL/+HcLrMJPa7ngj4I+0DmKa5t8HIkTVRvUkL3OdOcQpAB1ZMV5Q0aboYuvP
 wAVegb9CT5VYUXdMyfLBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lJTV8GwBTuQ=:UbAjSO1CYQGMO9owraUMBL
 0Q2yg7d5j4wOplZn2ja3ORetWomxsf67tj0/BqfV+Y2q7aoOcJJO8ScdrZHZKcftSoQ5LJ21M
 mDjkFXDM8gFzanHH9+g7pZa1UjO4XkpEo8F/OqM97wvyGdFShNs5Y0F/vbz8eQOhLzD9LcTMN
 4g7mapn2msVQTPU9dVQ9cfdvt5ZyPcDH7r6MIgrnSXFFY1XdUTyzH/bwIo/XU+QJXm6bZjxRs
 3QdKipXLNk0iCFQxUobPVyLmV+RaLocde8bszh2fEIbVi3wI+bAeblasZyQGHIet2cYqiQ2kj
 LedGOnDJuZJMTj651Hd1Di2SbpZ4dbRZuBMk9NkP83eoPDbeC+bcwXtSQYHco0Fdi2yOh3UlJ
 qT12rLBYfbw+AK3dcZZ4vwws94PtUhnMUrExaMqyKI8zKi2KvHUjTWd2dkYaB3F460tDMrgyM
 WqP2bep1JWvbL3B7bOp0sihqoS0Bjoo1eYg5vQiuWvbTG4s021/I9N9ZBcycY3nCsVJXEV0P6
 oRe50O2P4PF6nG/zoND2GCX8osz85iU6ItvTJjgATEJtkr7jpAH/3rY/+xnaCMbJOlALuU4O+
 BX282nD1hhD8Dbposfej0qto7lHFNYkpGXd4qoF0BXviMlWKA5iRqnn6mOJ3BkgM6yNmHpvoD
 c/9FWxe6hkWTGh0yuUz/tELKqepfyqoPdWRj4gKRPYm4xsTYGlkAS/jl1oeXlgSJpoSy67oF5
 st8mhyi86vpGRepTmWP8RwSid4KYKAOEQtaTE1UYfTEkAPw46U03/SYrFVT1RUlFRvXL68Zk+
 q1r4ykfImW1OvxDP6DBrM6iO+1XL/wdKPwtrs1WMfg4AMrcYSJsVvnKwfTSVsPlEa+arhrOdm
 OzjoYENVLUKCDWFHUopJdxjoa3cqs+0MHCe/qDhSpjMSyQ51N5OB3UwPIjY5fBSG5D+YL/iOz
 OYoL+Spxw46Z3HkwGqQwHHxw0IdDP7s1PyTglaBGA2yNkwdfLDBkSAM4vXXVn3sLWjpbU4KU2
 dgCZUT4KCRzVyyBdJtC3ux4+7qmA/KO99bUwgumiBSFWE34AbOJh8QM1zOThBgpezSJZW/Iy7
 hHN7WjogHyzeeTNfYG1jnEs++PnHUoh0IMRBM4at1zKwBmHS++AvY+34Q==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/16 10:40, hmsjwzb wrote:
> Hi Qu,
>
> IMO, for btrfs249
>
> mkfs.btrfs -d raid1 -m raid1 /dev/sdb /dev/sdc
>
> btrfstune -S 1 /dev/sdb
>
> wipefs -a /dev/sdb
>
> mount -o degraded /dev/sdc /mnt/scratch
>
> btrfs device add -f /dev/sdd /mnt/scratch
>
> After the above command, the sdb(missing deive) and sdc went to seed_lis=
t.
> So the missing device will not show by btrfs filesystem usage command.
>
> Fsid of sdb & sdc also changed in above command. Before this command,
> btrfs filesystem usage can dump out the device information of sdb & sdc.
> After that, only sdd will dump out.
>
> I think this behavior is proper.

My bad, I forgot it's fi usage, which only makes sense for RW devices.

So please discard my comment on that part.

Thanks,
Qu
>
> Thanks,
> Flint
>
> On 8/15/22 04:06, Qu Wenruo wrote:
>> This will only load the device info for rw devices.
>>
>> But no seed device will be populated, wouldn't this cause problem
>> showing missing seed devices?
