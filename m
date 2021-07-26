Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46ED83D5982
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 14:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbhGZLt0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 07:49:26 -0400
Received: from mout.gmx.net ([212.227.17.20]:34923 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233995AbhGZLtZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 07:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627302591;
        bh=7KPiIGxPDpovmhOcivY1M0Rjj0fb3CkoMxTX4f+WXLI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=jQlfl8+LfUVQ2J8jIOxmi44MR5jSPrSpasdH5cDueCvJbkvwE2Ly/yo6ObeUZ4Q6N
         2dLfRXBU5PSYmTB0s0bZ7gCuHiTpFrFPC+OdHuN5V0EWRiWQVeL7AjN9+jis9hWgIt
         aTR99HLgc15nU/CE7kNezX/QZt1TZAKf/PcJTJSI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mof9F-1lJVgd3fTd-00p7qf; Mon, 26
 Jul 2021 14:29:51 +0200
Subject: Re: [PATCH 05/10] btrfs: tree-checker: add missing stripe checks for
 raid1c3/4 profiles
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1627300614.git.dsterba@suse.com>
 <867952ec2e4728190693011e215a81ea9a4eb73c.1627300614.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <53d058cc-cf3f-20d2-2d86-336cea00be5a@gmx.com>
Date:   Mon, 26 Jul 2021 20:29:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <867952ec2e4728190693011e215a81ea9a4eb73c.1627300614.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F4NGIxNGGAnGZGsuFWGySi6TuBQnXsStdHtRMCsCfE5qZwjkLqo
 QlFt4XQqCK9yQdtsQD1aYN9uyB1Qtm5rVk4H0YpKQF7pfLZ6mD381nRwaCxlEbOo2pzvBNg
 MKMoPnv0H06QLg/uYOy68+4C6ahr8yLsCQIpqmljwK1xkwxfvijNfCZ7nAUN+p5jodBdLyz
 r4n5/jrxxCwQStb3/HBQQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:teV9wDQziMw=:YWR0KdCPc5NDq1/Enr7Fky
 0+OQYESyDGMwNwjMYRzOsQ1noo+LwBA7Crh5b7N2QbsUXWrIRz3WKTWq4MHyEUPeiYvY9A91c
 AHDxMQ3FoAq7miXVrGasw8XKnyavg+b1mpmg2rwjeiXydDt7FFjpXftRRmWS1IppuiFCXNcvV
 oykhUGayI1o/45IxLCTF7iUZ5HiXvhVV+Fn04Yz3OjBrFJzX3vvriSW18lh6v8nrbOYk8Ywrd
 A5sGqOAQMjYKobhux1zaRJrC6SCcGbNKw0KuRa1vaq2vAT4o4/H3aPfzXwQndDeuDgyZlJCmA
 vbdMjw0ukZZZBr83/M0w96NIPe4RtYIieCldRs0uRwpLYTuZX6vW7viQ4qHx7cciKmaleDBUD
 9a2D8kQi9XA9HQGPnjYt/lWLITd9+yT2Pnl7W4TU1L7k2HKcTVRaUDgmf4qNn4I4xIyz5lj8u
 PzWYrlV9H5WO+/eEzA5gWNa12b7KeFsy3DxVM+Qg8E5DA+G0apogZpn6bYIsRwZIbSFxZYj8N
 29jqr0gsVmegxfT+ji2eaA/JgvOR3mYtk7/p7DnKwFm0iKSt8Ok8NnpXcoHmzDYoDrncD1a8A
 WMdcRcIA+K4sTCMUIADysfSlURKHSp6SxlZDiprPhvGBHu5kpxLoGkqtpBAxHFvGCHeVNBVK+
 udTQDDZgE/oW4fQNTb9BJ247MLAkfP3n5duExcJ2JZOPO4p2F8DLZbLpsqD0eMCrgPfUWqr+k
 jMX84FwEUdUIm9VcyWfBTzwQq8M1eCn3aUrNCeVQVv75hP30dKGDbc1cYOjyFO4jhxUR0BQFw
 YtRHx4y3SgKnKE00xDk1nWe6Eglr0Ib0YYQYaLA7Y3CPG5Jnvr1QK8ABukWs9S9oiVJTtSX70
 CNiHoOGO2pau4HhKf9PGAcZmNZjwk8wKf6KXqU5r///FXpKIAWGTWsnoBYZxTqG2wqFkA5R7x
 roA4ZOTjioYMtuyF7df8vEf9VyEScyLz9VG9IDeYQhA4yTwTrVb8eojxgCcuzCYuyd53uFOdf
 NaMjMmZ62JAJ+/N8CZ8QSwiTDZwf4G32R0U6A3BdlVz47hqYei0jDI0izydcTIHcdoMZGYRWV
 Z+i2rLkEeYgAP5KePbVjK6/VN+jpj6RA/b/N9IaJNuHhZWem5cbOv8sQA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/26 =E4=B8=8B=E5=8D=888:15, David Sterba wrote:
> The stripe checks for raid1c3/raid1c4 are missing in the sequence in
> btrfs_check_chunk_valid.
>
> Signed-off-by: David Sterba <dsterba@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/tree-checker.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index ac9416cb4496..7ba94b683ee3 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -877,6 +877,10 @@ int btrfs_check_chunk_valid(struct extent_buffer *l=
eaf,
>   		      sub_stripes !=3D btrfs_raid_array[BTRFS_RAID_RAID10].sub_strip=
es) ||
>   		     (type & BTRFS_BLOCK_GROUP_RAID1 &&
>   		      num_stripes !=3D btrfs_raid_array[BTRFS_RAID_RAID1].devs_min) =
||
> +		     (type & BTRFS_BLOCK_GROUP_RAID1C3 &&
> +		      num_stripes !=3D btrfs_raid_array[BTRFS_RAID_RAID1C3].devs_min)=
 ||
> +		     (type & BTRFS_BLOCK_GROUP_RAID1C4 &&
> +		      num_stripes !=3D btrfs_raid_array[BTRFS_RAID_RAID1C4].devs_min)=
 ||
>   		     (type & BTRFS_BLOCK_GROUP_RAID5 &&
>   		      num_stripes < btrfs_raid_array[BTRFS_RAID_RAID5].devs_min) ||
>   		     (type & BTRFS_BLOCK_GROUP_RAID6 &&
>
