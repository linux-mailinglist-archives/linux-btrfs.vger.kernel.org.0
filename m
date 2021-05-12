Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327F737F023
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 May 2021 01:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhELX42 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 May 2021 19:56:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:60893 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347916AbhELXuC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 May 2021 19:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620863310;
        bh=e/0sIhPiAXlmYbVlJvVarbAbIw+rnvXv8u208L+cVzs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QJZJt3wpwY5Xphmo+UzO9SZjPPo2TQN0qxuE7FWa6BfcL/kVrGeCJwgcl8/op9vzl
         mFggoGLZBaBOZyTz1KN0KfFYIiewECwOqE2/OfeaNHJIW4d5szwnccoWm3nTnJd0N8
         hkUEoWq6UBrCiL1k7IVkn0Af8bH3NlEDiueO00uE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1Ygt-1lfasQ41LH-0039WC; Thu, 13
 May 2021 01:48:30 +0200
Subject: Re: [Patch v2 00/42] btrfs: add data write support for subpage
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210427230349.369603-1-wqu@suse.com>
 <20210512221821.GB7604@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <de2c2a25-a8da-4d69-819e-847c4721b3f4@gmx.com>
Date:   Thu, 13 May 2021 07:48:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210512221821.GB7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:65Kx7wXkvadQ/NNYmtiqkLFdFm5qUgJfWg74+kCxsyeoe541ZN2
 +spP+lLWPQQdw2bc07gaOc3rzZrok1nziIYZgYofuSLQ3TYP9EwgrVqM+23BsimeW7KcXLs
 /UhresWHzYTBYPlgs+ImRbklPErLNcWRaiOTd1y5YANYxKMSnI/is/ziTxPYwfAXMGrTaQN
 cnb2b8OEAv9ZacRoHbvcg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bguLJz2r3+g=:ETmJsZg/caHW+jPOxH0GoA
 Dji/aTKCT2ZfPypkzp08zzE0aYgPC+DFdTAimhiah4VqyE/BwbVryZdWNKzCq2Yf8G/0bZNg9
 52622R+7+N+jBPlKp1LVUaQPKcy2/VGk3/eA1VTFAgIuf84VxUv2vl7h3uzH5J9vW9DktrdQW
 eMj4UfsXx/ZMMWnX9IS03u9w9HVTR7xswGAjqGFNv1Y3g/fCwVYuIzKkdacQAbIP+OqmWIhUz
 2No50hGjcqpDRBW/1NCYY32U6MTlq3eb2qQuoE2sloVLY8DLlW9naCDErFgxWZXhOkAevsAq1
 rb6/k5xX/jkJn6iAprmEcXYVODx0f5ELe/EnDthiaxwb5n8gMKf2SJfxbKjeaj5N+J0UNMjkq
 3qu7xC4L9ap1cacXaZ/sdGh8R9K15KXbzu3zXh5xSvOuRLsTUKiR5MkopkbkYkafTc+UDRYnc
 sQskkUuBLrlR+BmkRLfzl2AY7myX2LiTelGPScb5pMdMRmqQRyl3HftaluPMrAhT0INsUIL8B
 6RQ2M8c+2stc6dQPYWTj4os6eOL15btMB7hnk31LVNiFmyg9QuXRceD17g1ejLd4/aWpZU4rw
 Fb8WL0vv4KdTtLoKQHkiQdgebL8xHwcofAQHIfTO9i7PFFsP5AMXQPuTOQ0che8cvpnmkRNWv
 JDhlT1rsJpwklCL70X9TeyoRC3qaY3dllADKSO14RmY/maDAgAaNmszLjX1AkPsh1y933Pjj8
 RXBDbVbt7Ci4tIivRwLUQSrgDmsTpxGNYALxAHfxe99WLlV1k8NeuHTpu1xi58I4+oYHUkJQ0
 gLEwFgv4t10Pt1Ao9E6t3zo3ntJK55bgtEkK0aN9kVX20qoSXfRmRCcmrLsAe5j9kQ7v3ETKy
 eh4YJg1vnE4iWPz6SYtI0ZpO1qw3oPzYHntrJc/7UDQTVZOZhjUDhhm5EBCWtPFc2g/TbRd/c
 JMVIccGIXqKELO06BozJ8wEUkg45T2dmfg0i1MtxhADpTArFqK4xqCd6zFEkuLJ99cLnJQxmZ
 7kvMDG63oSIzRWzo2SF2g/pMyK60CKjgfYWobW42gvHdH9f1uNVGGizjaYItFCxD1EdGlr4m3
 zIV7QZxKdqHgiXATshVuC8MAEn718sIBY++IkHOmRBofzQtFbyONpARzFb+2+K6t8apXwuSex
 o3MjLEpX4F3uJhGvEH3d64L4IsSk0RVxMytX/cz/pHSmMJ4/nmZpebc3yqCZCm0xH6Uf5Tr8v
 CBOk4LwO0J5luvb8g
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/13 =E4=B8=8A=E5=8D=886:18, David Sterba wrote:
> On Wed, Apr 28, 2021 at 07:03:07AM +0800, Qu Wenruo wrote:
>> =3D=3D=3D Patchset structure =3D=3D=3D
>>
>> Patch 01~02:	hardcoded PAGE_SIZE related fixes
>> Patch 03~05:	submit_extent_page() refactor which will reduce overhead
>> 		for write path.
>> 		This should benefit 4K page the most. Although the
>> 		primary objective is just to make the code easier to
>> 		read.
>> Patch 06:	Cleanup for metadata writepath, to reduce the impact on
>> 		regular sectorsize path.
>> Patch 07~13:	PagePrivate2 and ordered extent related refactor.
>> 		Although it's still a refactor, the refactor is pretty
>> 		important for subpage data write path, as for subpage we
>> 		could have btrfs_writepage_endio_finish_ordered() call
>> 		across several sectors, which may or may not have
>> 		ordered extent for those sectors.
>>
>> ^^^ Above patches are all subpage data write preparation ^^^
>
> Do you think the patches 1-13 are safe to be merged independently? I've
> paged through the whole patchset and some of the patches are obviously
> preparatory stuff so they can go in without much risk.

Yes. I believe they are OK for merge.

I have run the full tests on x86 VM for the whole patchset, no new
regression.

Especially patch 03~05 would benefit 4K page size the most, thus merging
them first would definitely help.

Just let me to run the tests with patch 1~13 only, to see if there is
any special dependency missing.

>
> I haven't looked at your git if there are updates from what was posted,
> but I don't expect any significant changes, but what I saw looked ok to
> me.

I haven't touched those patches since v2 submission, thus there
shouldn't be any modification to them.
(At most some cosmetic change for the commit message/comments)
>
> If there are changes, please post 1-13 (ie. all the preparatory
> patches), I'll put them to misc-next so you can focus on the rest.
>

Thanks a lot!
Qu
