Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A1955781C
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jun 2022 12:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiFWKsR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jun 2022 06:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiFWKsQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jun 2022 06:48:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C5738A0
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 03:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655981292;
        bh=SzoPL7FlyWsoGVR6TdHkU5+2KPeJGywscFG6tXpcZ8U=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=KnGk20E0q0SHOogcPwOiXHtdJ8Z3jq19bCHMRpUqTxO3i5MSmlNtdJeMiuBAH47tH
         xsCUXGYNzUDx5+FEtrY/swAyGFqewxmcIeDFDDi2aT2bEPyvWsdwDGkBgbfb3Q1NbY
         MjvR/8y+HNKrbLIQnNgJwXcB3yJr3QGR4tct5Lh8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9Wyy-1nyqCt2Nuu-005VdH; Thu, 23
 Jun 2022 12:48:12 +0200
Message-ID: <9fc237c2-ca79-17a0-4508-0ddf27fbd529@gmx.com>
Date:   Thu, 23 Jun 2022 18:48:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] btrfs: Properly flag filesystem with
 BTRFS_FEATURE_INCOMPAT_BIG_METADATA
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20220623075547.1430106-1-nborisov@suse.com>
 <4466c55e-7270-7d63-a591-e119fb5e3f8a@gmx.com>
 <083b0fc0-d5bc-3beb-d34a-75a76eeda1dc@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <083b0fc0-d5bc-3beb-d34a-75a76eeda1dc@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1lLaSpKTXtadmREejvJtv7IrZen+Bo4vvvfqH4W5Lns5H/LAT69
 Ww0rxP/lBlVX80BONVI60e6jB0hJZVoGCv/TiWicCwJ/oYB3wfMZm+EpuWJ2Ly9YWqil9TK
 J3hvhdQ9wcT+2aHBvzk8oSpRJZE5BRDoLLDaLMXp72iGiHm2U/nw0LdfokD3HP9rV4ThH9A
 JSDqefHi+nq+BLHrRi2iA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OX3kJh/Aj7A=:uDQmzU36YIKBsXiQSUvgZt
 yUq//YvbRpgiLAbWO/LOYTVSfCa8dkK2yPHzv9YoZbUMOvFyIPPRrkPLOIUieJn/7LL+6+y4V
 wKCbmWmmbcXF/YOHt8bU4QMBYRVnjd2vcI54S6OtlLxfv9sXp03P7z7kI33B0pG04aXdakxPW
 T2QBZaMY1d5pxruhtIeAUuaEKnS8Ib32tPPhEaZMzfb27lJKybfeQnIk/gpgebU2WlEulplzV
 ckhXTLfKa2CXq2TQW4dRDyGngIQvDHh28h/gdEbWo8QaGd/qkSOUAGz1oCBIEwbrbbCVm1DOb
 dHf2u0zWvjfTRdUJRZ7jpua3qebbwIvRKmf1I0yUefP1y5SvrR48lCKS7hQggyKonZsr+8azS
 TGwnddavSjQ9uR1enj33KjhFCTC4u1HSxAvN33t7LaM5NWWluEf1Ac7ESTBbwLrwgJ/WsmN/I
 6Kp8En6lDdKSPr1SEzK9FWTm7tWuP4aiinbrMZ0400ImmJ6eCADAj1G3mlVEtQf/RKS7MP0Sh
 0CesMBYJet12tzIe1xd9QeTmqO+MbsGCS9nz4z0+qzdvQyl0BKjuKHMJciNVjZjvthiMsPRTn
 o0d/DxU6lgz2mnp5maVrpjKfLhcfX6b9wwvpW54Xt3xKTNz+dg4x4mpPF6H+f5DwT9gXY+jg4
 /p+GoorvTQukZ9hXTw0dPqMAy6BieiXHLd0Pv5siUYDaK82A45R18mskNpUsDMya8se/OsUcI
 h3eMV4nh8N7Sz1iLmOxhyKmf7mjIf3NU2DuvX/XBkqn11leI0xbWWN5Haj2Rn179yoZ+zSv8k
 D7bZaF7wQqGNoMbgbBJvxBWPAcQmvRK27E6yUok0M6DtOpf/8XxPGzYbq4HNwXzHBYfIJLEK3
 4a/0ohpNZdnEFYumwOE09gEXRFGbTmdNXxDo1qOHcTM41ty13hq9voiARBB41MjrNqAwcMIRE
 GJm4V2wif7VAFfltjdVQoeag/1XAKOJT+xrfc+m0y9jz116vVZ3r7daSyx7Y4Wl/FC0NXpz3Q
 SZUmy1z+5FWY5/VUfcWbrKcQIGSphr34NXECRBh9iJmO2QXW0GZQnudnRLUiItA8WJtgkWEna
 loL1xQPkh8rdf0rIdFx5YaETG5db0K9n0NSHpNvZjgzbgq23qwf/CJWLA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/23 18:15, Nikolay Borisov wrote:
>
>
> On 23.06.22 =D0=B3. 12:57 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2022/6/23 15:55, Nikolay Borisov wrote:
>>> Commit 6f93e834fa7c seeimingly inadvertently moved the code responsibl=
e
>>> for flagging the filesystem as having BIG_METADATA to a place where
>>> setting the flag was essentially lost.
>>
>> Sorry, I didn't see the problem here.
>>
>> The existing check seems fine to me, mind to share why the existing cal=
l
>> timing is bad?
>>
>
>
> The problem is that when BTRFS_FEATURE_INCOMPAT_BIG_METADATA is set in
> features then we need to call btrfs_set_super_incompat_flags(disk_super,
> features); so that those flags are put into the superblock and
> subsequently persisted on-disk. However, with the code motion in the
> offending commit features would have BTRFS_FEATURE_INCOMPAT_BIG_METADATA
> set but then it would be rewritten by the call to:
>
> features =3D btrfs_super_incompat_flags(disk_super);
>
> meaning INCOMPAT_BIG_METADATA never went to disk. It's very subtle

Ah, got it. Indeed we later rewrite features.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
