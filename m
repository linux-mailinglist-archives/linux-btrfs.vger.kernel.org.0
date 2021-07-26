Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F793D6983
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 00:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhGZVqZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 17:46:25 -0400
Received: from mout.gmx.net ([212.227.15.15]:60251 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233651AbhGZVqY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 17:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627338410;
        bh=fOkYPAn+NB38f23Gt07fHwQoECDnKQCIMGwyu6T4CSY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=I/7di3dM2QX3ORDGjsfyG559ILB5RMIn19hTwB3wjL2U6BHVLKSGLt8AILmYV0E0I
         2jfxKODEFPEaKpJAF+Vm5LB30YGG9/jrq1qFnxienSlb8pf4gi5pAYPmGgcSVnSRa3
         EuqLifPg83vsNtYNSmHAQQII0fsXUH8LxQNPbrzQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MxDkw-1lAwjZ3lPc-00xcUR; Tue, 27
 Jul 2021 00:26:50 +0200
Subject: Re: [PATCH 10/10] btrfs: add and use simple page/bio to inode/fs_info
 helpers
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1627300614.git.dsterba@suse.com>
 <4d3594dcca4dd8a8e58b134409922c2787b6a757.1627300614.git.dsterba@suse.com>
 <6cac34b2-39ba-f344-d601-b78a3f0c7698@gmx.com>
 <20210726150953.GG5047@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <cc110ee1-c1bf-2b83-b5db-f70468b159f7@gmx.com>
Date:   Tue, 27 Jul 2021 06:26:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210726150953.GG5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gWgP06gzvAgmS+ftLla04+z2eMkzPnG0Y1KrRi1qXLC91k2p+8c
 rgJc9hpIZDb9ZfBMLG6m0PU3RYWuhDvOtOEqVchp5upANyqidzIrKmXkEbhJ/qfQKaVvqf8
 QBVxehv1W5doq5V8Fg6uogJgvNzjFWnPgS8XOW4qsp9AwvtfXYKrkzcA2D+J5VxrVIUqkT+
 lf9QfWAfoj6jTH60eqptQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fgm+7Od3psM=:hUAIlMqobQerK/2Yf8MdNx
 rvOoKN2MHD3lAx2giyl4SxpRBEerPYZ0A1Sk8aDTt3y+tmOu/cLDOf6FM26YOHLAgKSw2JEgx
 AvzN9SajZr21AvF0QgdRu+7LTtnaZfQFxK6H+9UytrTLbFM3htlOtCzGv1V5pe2yO5x7N/y+R
 4gQzJgoN9fg8O4+ponyAN3Qdzz9WJoAsYVEFd1hVoDe0BweSe6DOssTkAXEczeUIGi6yG+1R5
 vmSjOyRqBRjqbEYmTQFLBI8beBgsxyc5kxoj3NFWi7gbY6vi32seNiM1YP2Dqv1YzNww6qeFK
 XHAN/Ek5aQwC4HgVNypXC7kxZZlC/pTXpEqnLc6eXUBWsMe92SiMfgL4G2zgu7AUeE0SL3y/m
 q6YLVDL0jA3jiwNo0lTvzVaoIPRlbQzD7eQFHAA1A0brLQ8847SNMcruCpUxplkJTfE1Ajlvd
 FdrgPe6C9Tf51jJz9jtQAayjnvPEe0RBn0xKvfog8VxamRwuHpwiK3LzgAHFaSafN0nAmrkbP
 Fqs38qzaNC+ihvKsmjSYmbL4WIfDS6+nPXmSgkmGVfk47PGskC6X+Zm7FoopfvM27cyvau28u
 GXtZ0kkkGqa7T0E2PwjfnJmhqPID/yCEMpXtogJWm//eUk2LRcWEUaSdPA4HJb74f7LmXvVRe
 BDBBUu/yjyk09Dcl/zXFQQQbsUF7edgAB38pAStrGGGRY4cI0PdlvIy0OKrmmtvNNJnKQgYYi
 4iKEqAjmOh/hbdStxpsKTAx8kBBqS46Wbw5YzKjE8c2y0rGUyCgRt5di4ts1mI2BtJ4hdcq7W
 bfUPN1tWj16Bvt03HM3rbDjszQisu2/k8oOV4vtwlBi/86MqTw/YyrMaYtnjmqwIdjhV1Hcjk
 qzAzgbvB2AG6G9zUHjH/thTQpUD+qPINOnNoCA1tb2z6MlXX/7Mr7F3Y/vPRY7owHAsR6GysZ
 KNc5Cgw+IWQo7mW/1gc11nhvnmfJgOvfyYSdDN1CQdXsKQ48Ej47iZyiMnaCavNf7/PDJsItO
 8LrRD6O9G4Scr0QLjyo98+qrGwNt8uirt5O6wAxY6ENTPSRqWECFnC/eeE7Tu/RV1+tYi0YRK
 x2jmryjdvXrgBRW/2dhNyXWuKi+jCGBBAvD6TsvTaSnj5OSwWj/eRoUAg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/26 =E4=B8=8B=E5=8D=8811:09, David Sterba wrote:
> On Mon, Jul 26, 2021 at 08:41:57PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/7/26 =E4=B8=8B=E5=8D=888:15, David Sterba wrote:
>>> We have lots of places where we want to obtain inode from page, fs_inf=
o
>>> from page and open code the pointer chains.
>>
>> All those inode/fs_info grabbing from just a page is dangerous.
>>
>> If an anonymous page is passed in unintentionally, it can easily crash
>> the system.
>>
>> Thus at least some ASSERT() here is a must to me.
>
> But we can only check if the pointer is valid, any page can have a valid
> pointer but not our fs_info. If it crashes on an unexpected page than
> what can we do in the code anyway?
>

What I mean is to check page->mapping for the page passed in.

Indeed we can't do anything when we hit a page with NULL mapping
pointer, but that's a code bug.
An ASSERT() would make us developer aware what's going wrong and to fix
the bug.

Thanks,
Qu
