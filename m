Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1022411383
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 13:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbhITL2L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 07:28:11 -0400
Received: from mout.gmx.net ([212.227.17.21]:57735 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236804AbhITL2L (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 07:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632137202;
        bh=t1bbPZAifJbdtxvNXBuRUSwiT+80VXtwbIjHdtU8fB0=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=jARigaGW6Dbgq+skLivm0xU2xsIyknf6zDCN/y1gfLWjRnwU1az5sh26b/ghSo/8Q
         m1Xr1jnMY1JpjOV8uKKKt2F+Hsdm5JGdjPk8G2h5luC1LQ8lUXD6isbOYzCST/SK5i
         lz1EdYKOow5JrVRw0EfnJM2rHfCO3wbFg3tzCpAo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3lYB-1mT6OI3nQB-000wyZ; Mon, 20
 Sep 2021 13:26:42 +0200
Message-ID: <a9b4ce46-27a2-377a-3c36-7706d71daf28@gmx.com>
Date:   Mon, 20 Sep 2021 19:26:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: Select DUP metadata by default on single devices.
Content-Language: en-US
To:     dsterba@suse.cz, Forza <forza@tnonline.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <9809e10.87861547.17bfad90f99@tnonline.net>
 <20210920090914.GB9286@twin.jikos.cz>
 <e28ecf10-99c3-ce99-f3c1-218175646c2d@gmx.com>
 <20210920112349.GE9286@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20210920112349.GE9286@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xWfv1P53YeOS1NFJJ0YIPhTwD6bJaYJxNj0x7Y/ozq3mES/qpfy
 ru1X5h690cIwM3kIrDUtooYCnGswJUC9LkIPbibyAIeKbh5QYTsBzXpssKUIP3s2zF8B7Ky
 EjJ/Etios6I1m6LDpBtEWTTduHSno7tsCelRT4Va8SSKzDZu3YsXfzBX+fJQF3tCgAU1UKj
 hQ8iNk9j4UP2dZGTpXwjw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tCddlfPTMTs=:mbCU0akpR6JuE2uj2gxx8q
 VVHMEL+HOxA5UAnLYgtArhl6XmX4m7fqZe20LcSVANexM+FKAFhDEBRrQgDCVdha72eyt9Czk
 ZAKXYp1TaEDNHsEQ1mz30BzB6zR9driAlZ7ydUfSJ4LgEqbcirLb/ccDP/c02glC1WEyac4Ql
 XNJyoc56vYFbbrypGRQDEkj9DMM062kyGYjhakxwS6HvtHZ4GRDgCSlQuPHdBTEmWGlCzmeAP
 rmcuzZMuYR5/pzOsH2hAr7UGqJYU1MmjUNiGwgOpDVAWOFi621AFDxFkksMrSJr/xjkHWDZ1J
 7tKKdTcGoDq1LyJUUUbH0tXI7kBah6xG2lqk3VZb0dJTOO3sfl/2+l15KiCng0qAXq0pxsJXs
 aTj/RSmPgLIZia+GEsASumyCpZx4KBgff3cStnuF/WxdZcSNGUgGRGMihpjGX48w1C949xhSv
 7fkTzFEemQp8Fa/iSmgTVnQtG43NyJpfr6kebajK104boaAU8f7QWnA7DeK/EV55vK4Uwr8PG
 lvOtYrjYa2iIBSIKomZbcvyVIVTCCqWQALs8Y6BkImTasWBc2rz+l/fPZ8KOpHjw2FL24MJRq
 kq+K1gzX1WiPauZ2DxKm+C2YsyBf41uWvedsh7fmNvDZnLCX/WKPGL04qwgi+GSO4wiPMkX3L
 mhNBrTW/HsYZvrQfu/cg9s2FZDVOZI0F4CAzr5M2m+qS90vzNRre9wczhSbDUvTTD6/f8FPIJ
 8725cmaZp1fMOtJGAH2wtY4fRiJktLrBeWd91LKougdvis+zVJgRK3BUzQ7OKqYduANK3viKi
 GSWaDjMo0TEXkVzMY3xuZowKP+lvZDAZs88iLvpeHWTvYJSLpOOBb1dPQxxWPoEdY55FjMZF8
 kVNDDR8VA3OVQhcJyBslazjLfAEknVVSLfTPRcpjXM/W4l+/f5W5Jy8cURx+nInAI81kOPcnQ
 QWsShPKkxIKttaSiHVZdwdLgp/zuJeX7qbhuMHAIt4ZAQIPERUi0Kl3f4Z2MO86S4WG95j2Xl
 L0P/5skfNEpsbGufGmu3tRJi6sqa5IKmnacGReMwBXe4gRmCUGgs24Gmsi4kODKXzHIh7dcy0
 pm51ROjJo3LM30=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/20 19:23, David Sterba wrote:
> On Mon, Sep 20, 2021 at 06:46:31PM +0800, Qu Wenruo wrote:
>>> - single by default for data on multiple devices (now it's raid0)
>>
>> Is there any discussion/thread on that part?
>>
>> As I'm not that aware about this.
>
> It's been discussed on IRC long time ago. The problem with raid0 is that
> it's a striped profile and changing to another profile may be
> problematic once all the chunk space is alloated. Unlike for single
> where it's on just one device and converting to anything is easy.
>
> I think that for multi-device fs everybody specifies the profiles
> manually anyway, but the defaults should be sane.

OK, that makes completely sense.

Then I have no concern for the switch so far.

Thanks,
Qu

>
>>> - free-space-tree on
>>> - no-holes on
>>>
>>> I'd vote for one version doing the whole switch rather than doing the
>>> changes by one.
>>
>> I'm fine on DUP and FST.
>>
>> On no-holes I'd prefer more feedback from Filipe as he has exposed some
>> no-holes related problem some time ago.
>
> Yeah I know Filipe is not all happy about making no-holes default, it
> removes some capabilities of 'check' to verify extents. Some bugs have
> been fixed recently (kernel side) but that's IMO on par with regular bug
> hunting & fixing.
>
> I don't know when would be the perfect time to make no-holes dfault,
> it's a feature to reduce metadata consumption which is IMO worth as FST
> will increase it again. Backward compatibility is good, lots of stable
> versions support it.
>
