Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E74396D35
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jun 2021 08:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhFAGTQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Jun 2021 02:19:16 -0400
Received: from mout.gmx.net ([212.227.17.21]:47895 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbhFAGTP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Jun 2021 02:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622528249;
        bh=B1PpJtSOJoCDf/xR1Iyd8oOLoFGxrX2oZE+tS03tDVw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Yja55VozCiDUUi7lmgRhp+kC4kHLESxN5+c8FpWpDozHeJFg8J20tdQ1ma/7eBcOx
         3ola8Kb16P4pp91rLuMrSVqMtbW5cY9xbor1KFszVzBBixASDeWh1o4dsXtaQvvVks
         LYA3hoCtGn2SSPgxK8CuKO6HeJw+H6ZNowGOTX0g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MwQTF-1lUmq51IlZ-00sPVp; Tue, 01
 Jun 2021 08:17:29 +0200
Subject: Re: [PATCH] btrfs: Fix return value of btrfs_mark_extent_written() in
 case of error
To:     Ritesh Harjani <riteshh@linux.ibm.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>
References: <76ddeec8b7de89c338b8cb94ee2c4015a0be6e2f.1622386360.git.riteshh@linux.ibm.com>
 <20210531184931.GE31483@twin.jikos.cz>
 <20210601060129.3n7eohzswwpddv63@riteshh-domain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <ab6613aa-2829-b479-e0c6-da3fa1c624a3@gmx.com>
Date:   Tue, 1 Jun 2021 14:17:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210601060129.3n7eohzswwpddv63@riteshh-domain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jiYJpH0PGq6xcoJt2BvLQxc7++eIt2u+FQGNRFL8TjAUo7NvJSZ
 lJC8VmYxxuuI4SoucDSjm31KwCUqsuxHgdUTDQmprVsQQb4ko3lhYFE7tbuY8mQpXBuQ+wL
 K7nDzY/FI3ovLBxfdHqkTVJlrDzZWG/QYb+0fqXkycxLywGHRxNDxprmo4zt8BAQliE5ojm
 XPwYRUe8zLWhYzXUSg4UQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rtLSQRLgvIY=:cUe/WZDwlWXzet1eopzuGW
 AvQ78MUB8zd2VEChEqfsAF24xwQMQSrMZZIqZuwV26D6hIn5bSInRVyufOZz1pNl8wu3ttJG+
 eAMSEQtsN2+JbPK8P05RVLWkwPHEEPebJbAUUzBgyphJn5gmS7vQdbGIofhjHEnRGOEtjxgeA
 mvVinegDiC4hropVYK+zLyWkAgxHVvoW5wHyt5sdQanwEtpEVGAeWaTWvkFZZmSvBAnhKTUGY
 4SRopvm2QJ2TodXFnoKOT4xeBx6mquUCDmVmK2ml4G0lQNu5/p9iR4BF3VFM+GjCXGX3HjSUO
 HU7nCDazyuY351hk0FuvsPYQKxA1ZJj8OZNnL/R03Yb5yck5zw8oF0fJSKrvPOOe8hblFTU6M
 bqQh6Snur2SYJOfkly0zpEyD3mqXSaWapyLuKyCC6ex7euTYwKJEmRn9Z66jPyfTpES/Sik24
 qgLiarjSeXP8D+FPKEQXdDLg4jIseidgbnpzAwQnVfkKI19FBAweSkhrcg865dauXkEigSDfx
 RQXbOmakinQ8JeItuVvO5w/yeG2XJZMl7+PrqTc/hTCbBK6RSKgmmaJ9r7anDPIz17kt6tDbm
 9u+FChMaeaDMpe/qb1GG1FHkW85ioO02PdAF/dGb3KkflcTH/GgfID/vBq4whGPKZ9/a2BVVx
 DLP+sX4aauGg9tusg9q3FdyK3PGKpOA+tmmPwGC87si8JpMIK9D5ZToeswAuI00ujuM+mpT7D
 Whfpn5KhzDfH3zft0/cTJ8EUXWb96eEorNY/UYAUD7XHViz71gPwUkAT59A/eV+2lSlxAEJve
 4Ex5FuHiLLjE1sKY4USkmpb8FcmggRl1hK8Ftr8o3n6PlKE1TzRllUA6uPo69a9vk1Fv2zPyD
 uP9NsSoC450Dv8xcrLKxZpbi5Y/A8dpOWkbIH60dKLPSQOmCQO1elkbQCP/+r+CiHcw7qtrR9
 1aG4X8UTVVNgfncWhpvD1kUZlh2H0wnyOydViBno3dBtp3Xj90sY5OvsW/vqzplpuE0lAUYug
 PkoX6noqOSnA6sot1LypeYhPmeJDMaBK5PImPfmK19709ulQFTW8lJqhUzVXRmwdyybzxQGLO
 IFb3wdUQMa6T078QH0lfwkp/Uf8L93ICK0NGWb3btlXobL188GnSYOb6DnxN27PKEWI/DO4tx
 IcEV3qVxbPy8ko/vamLjctUUmCb4U+YUwAwmxKMP3wVDvZ2X16fOJEhXoJGVgrBul+ebwsmwo
 JAZ8tptOSJCgVrk6e
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/1 =E4=B8=8B=E5=8D=882:01, Ritesh Harjani wrote:
> On 21/05/31 08:49PM, David Sterba wrote:
>> On Sun, May 30, 2021 at 08:24:05PM +0530, Ritesh Harjani wrote:
>>> We always return 0 even in case of an error in btrfs_mark_extent_writt=
en().
>>> Fix it to return proper error value in case of a failure.
>>
>> Oh right, this looks like it got forgotten, the whole function does the
>> right thing regarding errors and the callers also handle it.
>>
>>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>>> ---
>>> Tested fstests with "-g quick" group. No new failure seen.
>>
>> That won't be probably enough to trigger the error paths but the patch
>
> Yes. However, I found the bug while stress testing btrfs/062 failure
> with bs < ps patch series from Qu.
> On analyzing the kernel panic [1], it looked like it was caused by not
> properly returning an error from btrfs_mark_extent_written().
> So, I thought of just running "-g quick" test to avoid any obvious issue=
.

In fact for the btrfs/062 bug, it's caused by the full page defrag behavio=
r.
I wrongly thought enabling full page defrag would be OK, as most defrag
tests are fine, but it turns out that full page defrag is buggy, and can
lead to btrfs/062 problem and other ordered extent related problem.

Thus now on subpage branch, subpage defrag is fully disabled.
For subpage defrag support, the incoming subpage defrag patchset would
be the proper way to go.
No some compromise like full page defrag.

The patch you're submitting is completely fine, I guess it's just
btrfs/062 with full page defrag creates a situation to make
btrfs_mark_extent_written() to fail.

Thanks,
Qu
>
> [1]: https://www.spinics.net/lists/linux-btrfs/msg113280.html
>
>> otherwise looks correct to me. Added to misc-next, thanks.
>
> Thanks
>
