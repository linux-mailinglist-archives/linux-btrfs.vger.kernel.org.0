Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62B97DFE61
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 09:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387929AbfJVHiH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 03:38:07 -0400
Received: from mout.gmx.net ([212.227.17.22]:51315 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729458AbfJVHiH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 03:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571729875;
        bh=V5Vgr4ObIQjKL0ag415uFrm9bIFv3js9n98VEGFbZmg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ioKAbQ7vUYbh06T0tZaCG8oWfHPpeDIW6uLJbYk9d11veBko4m8HIyGIVzsA5619v
         lvuJgZz6TTYb1abXjReop0l9UaOKA4GjUXqcV97DAV2ZWgxKT0RTv2H4s5cGmSabfX
         R5LUi3HfNmP96a2CS6Av4q9r4NsZ7avH4dlxEgL8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M89L1-1iQvT71hxb-005Jkh; Tue, 22
 Oct 2019 09:37:55 +0200
Subject: Re: [PATCH v2 1/2] btrfs-progs: warn users about the possible dangers
 of check --repair
To:     Johannes Thumshirn <jthumshirn@suse.de>, dsterba@suse.cz,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>, anand.jain@oracle.com,
        rbrown@suse.de,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191018111604.16463-1-jthumshirn@suse.de>
 <20191021152241.GN3001@twin.jikos.cz>
 <45385205-4b42-b89b-4c6f-581064c5f08c@suse.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <baccc7ef-2058-d779-7ce2-b2c120abefe4@gmx.com>
Date:   Tue, 22 Oct 2019 15:37:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <45385205-4b42-b89b-4c6f-581064c5f08c@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4oA7KKFVBwQTf9P8RmG99tW8J1gnQooIFcDVufGyocgUe8woWyV
 blDsnHN5Nie8XxGqFbZZUuPZKt4Wq/DNIA/9MdHXVf8BXsw3lqPBJ+28W767d+7fIiIzGUa
 N+HMrEe9EYTNt2rE/wyDgglqg7hHEMriE5MD4+b4oZxCHIIoLiAYijLZ2a1PBgzCW7K2MaD
 V1nszwkLNXZyJ+xyrPBAA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:F/ArB/0RkHA=:W/ReCY7zhXgA21KGq27Pxq
 q45hhKwRHrZ6ZxMivD4rNZMzE/Y4S7Hhq/KqGTYRq4fAkJbQeMAkoqGC21bZurD+L5auty2Mn
 gwVZIO6TjvirhPmcdQ4s1Eyz8f3kiO3zzCyXQWxQbn4j/a1jo3Pw/NoMObjDwq4mQP67TxInK
 fiU2Uou7QOIRapLo0uKSci61TNAOWyNDBoCoNerjpOqPfxZFf6WK2qzy6y8Ph0Wg/SS0/PLf9
 agxlT0D0bfCa1ycagJkLI3oOejB7qELywFXorikGlmpbeJEs3SQRO3Q0/QpLdKd0l6hKwAvG9
 LLJZSNhdLafx7ZGgr+eAJtpN6hQqhUKTg21yNNJUVL2LasrdQvFMN9v+tvM/zZta8RcGH8DG5
 MOtBOcukmKp+66Psc5F3vy1p2IDUfiPV/lVk9bh0XJYwC9bC8BmzAFU8um5F5dqobnwrbODhR
 pj1davePx8cgtetUmnsBp69oiOgEQf14DJzU9Lb4kvmIrgugh44vXL77L+wQJdo0zm8KQT25L
 3f9TkqajoIb7T8cvMDL4uQFhl52/6QkqhzwpxgbsQBgO8j66IgYYBmhzCbHfMjDuPUEHBGIOd
 TGPElnX04VsEB9IvGhFhgzjNE4MbC7KIuynTjRrgKbZYWlH1AmF/NPliSl+QxaMZvsyKAIst8
 eyZSUfeiTCNfHViwMZiKb/OK2oGh5Qnr72uVSnQyfDdOYvWS7Sf1adlDhMvIFYVzuaf9z4mBB
 hFM33tjqFs76Ha0/qx28iHNHYjNUBoV2Ucv7D2b5zFwpHcsu7rwQbxCRGpCewXOHAKf1Ber5g
 y0cAnCk8hzs/0+ndv3BlzJekVzi7N3AgaAtH3CblHVUJaZ1EBLBA10Y2es1C9xfmTeAfS5aYd
 dKkX45Ww/geK7FxhN34kOR5a7MHaib4obRy+MOYK1FYHV5viFY/MoVQG+dLgyk6TB0VeB3Do+
 tS1pLk03BNE9Y3CB92hal04/pDCqQVRtE0UR0yPhBIKUd+howmi44/0+v8J+vgen1UK0a8QQt
 sPt3k6MN0UdNfz3eWVkHm+aw1yfc2ORspIA4kwsktw3BbjaOmE+QMFXYVs2lU6JnqWHBwvZ1h
 5dZ56yRfNgx1/Ikb+6DDz7XGzw9DFLvq6QlnPT5zDrs9tOM/pKfuzfpBGPQruVGjxed0N7VdD
 /MKKk0E1GSLnQGFyDE9Simcudxmf8oV7peOgD1Nt/ZeWy3mlTVOSwC+eibQPVB66GPMbHMHo8
 Q1C6criW5apZcFWOyRXXxLtEUQzMU/VEKuxrSLGQIwbSST1lWQH8vQwoiTjc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/10/22 =E4=B8=8B=E5=8D=883:33, Johannes Thumshirn wrote:
> On 21/10/2019 17:22, David Sterba wrote:
>> --force was added for a different reason, to allow check on a mounted
>> filesystem. I don't think that combining --repair and --force just to
>> allow repair is a good idea. There's a 'dangerous repair' mode for eg.
>> xfs that allows to do live surgery on a mounted filesytem (followed by
>> immediate reboot). We want to be able to do that eventually.
>>
>> I understand where the motivation comes from, let me have a second
>> thought on that.
>
> So how about adding a '--yes' or '--accept', '--dangerous',
> '--allow-dangeruos' parameter instead of force to skip the warning?
>
> My vote would go for '--allow-dangerous'.

+1 for '--yes', at least e2fsck has a similar '-y' option.

Thanks,
Qu

>
> Byte,
> 	Johannes
>
