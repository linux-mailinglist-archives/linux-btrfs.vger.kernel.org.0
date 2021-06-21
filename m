Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3333AF99F
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jun 2021 01:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhFUXmL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Jun 2021 19:42:11 -0400
Received: from mout.gmx.net ([212.227.15.19]:33131 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231975AbhFUXmJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Jun 2021 19:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624318777;
        bh=OGE3oB4yUbrx5ZDX2sA+NupWUNECZ+7KgCAJr6TiEsI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=S1GbXPsSlDrw0cBLb0nTvlYFAXMXqYbC9amg6xZrm1t2+RbI5o34xZPTf4U6x71e9
         yxBVgvFykB7Crwg+FkPMqG3qdxwYoZSydK4yY5tZ1OIrZpr4yCUbLdLKxxR82bPLSc
         T86uhjWdogKQwVYJg1B8BjcSWFhrL5LGj3lSAV3g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MfpOd-1lJxth3oev-00gGLl; Tue, 22
 Jun 2021 01:39:37 +0200
Subject: Re: Please don't waste maintainers' time on your KPI grabbing patches
 (AKA, don't be a KPI jerk)
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
References: <e78add0a-8211-86c3-7032-6d851c30f614@suse.com>
 <YNCwIe33OOW9rxPU@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <99acef59-b448-d7b2-3e64-4056f78cac66@gmx.com>
Date:   Tue, 22 Jun 2021 07:39:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNCwIe33OOW9rxPU@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E/0/+uOKi58C+nRw4TZxBiH87W+2mvkM8QG70yyJkI3dTHlag60
 tNC2W1VGpB2LHEqlhGLW3N62ArS9HD4cwp+xWUWzRopblEwf7nvn5A1NhfEoadTdt79XyJX
 8jH0tvwMgEoscSXiBKtR6S2LhlyRJPug090TomPkE+K3GKeD79Pz1lu2Krx6aKMSlz7HUme
 5TScYlbvDgNGO8Ea+qolA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OI1DhBptqF8=:/cO8DyGeXeK85MJ7xsQdwX
 7ur+Wdd1MonQK1QCA6EFti8sxZwM5jRUdIZAs4ajc6fhfPdQvLaW5PmaEYxxn6lGdCbINbn3S
 cNqg9ZT0kSEWgexheKj5D0mqgrnHL9fZEw860GI4jdAseri2uLWbIRureHuazyPu52SqXTN1V
 iifpWK+3fNAPolQE5YLxNFVkyTtyOGC4/ipyKhvgbx93OqD8yqUci5+BPXrQ/Ds5QOGdGNbaf
 kl+Cf70N1c204cVKeoytaY+YGmuEZ8xVJcrFuB6eLBiPAv4akssYcrXqtqwxs+kFHaG/GkpGo
 ptnvzeb2/LYNlbySOEQj5/cfYbb2pj5Xw64oM4uYrly6rUyg6sia9s//KDmuViYg+oK5CCcU6
 SiNEL9GJpk03SZ8C3jqaz50rDaZ4lIysvUE4eDf472qYb9NXp3WHvAi3cu8/r7rRhV0PIyyqx
 9tkMYDbrpQgHklorQPK9s2fSjP+5ryDef75VoCO0g+G6UEYN49x0feN0JD/heteHRqrwz36dx
 OGxqA079yDm+UyRzoWAmqi+Lcc9Rp3mjdkLXAb+aM3kYAKKJR2rAEg5eSe+McX2g9+ATFPUcR
 Doc/vFVp6eqeqm4o4rLx7mwR0VXzHhbFiQouOj96sam8crFP4OJP1MNNekulXLNBPT6orrb1y
 wzW+3DbvoJDewbRi5KDscJSdRZ6KWFGrAN98bgKSP068Qyt17iLd76pdNP7q8lYdsX3drGoHQ
 j0zsMqmNUjE0cjaXQPcoVlUzvZXu8jgLmL1ccAmUTULp2Ul9OIBE11BPQQ0SPNHbTW3ORICQ4
 9nbyCV/UE/5uavSw78EUXEIi151F4QmsO/QbyJ/LAaUSCYZhySG4hCleG4NbOR2k8+U66yQkH
 9zw8S6TVD7piIcHX5ohroficKk3Jyeh4ErZLEAoaBsTQVxTht9oHb0Gx9W9PUTwkUusbk6XF3
 QtaGV733Vd7tIM+qLyB+qGnqg9b2Vafe/hwclQmd/4G26MDyq8Qa/a+T+aF/ahYCMwjDV1xNg
 bHVvABTvATzT3/pxxLo+TuRPqVvF0urQYuomTkNakokjPL3OwbyJoXXdpXbVaH/AWSEA9boiX
 417n7RJ84ZjDURcWjiY6dky2SGg9W76CWVGnC562pF3KSw+l81B3SkPtQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/21 =E4=B8=8B=E5=8D=8811:28, Christoph Hellwig wrote:
> WTF is KPI?
>
https://en.wikipedia.org/wiki/Performance_indicator

Not something open-source contributors should really care.
