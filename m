Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8207C122527
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 08:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfLQHFM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 02:05:12 -0500
Received: from mout.gmx.net ([212.227.15.15]:44615 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfLQHFM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 02:05:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576566306;
        bh=Rns56Ueqg7vBwVl2Jdx05y1B7S6N10jYiabfHQwJSxg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QKmlTY3ZpWK7m9FFcNzxOv9Z6bkyvcj6XMU9BwdaZ+xy59pUtT1aGRAqicxQj456+
         tXSbbZPjpJ3MCG3TbFmWHS4Te9KkXMZftmeMlfBpXO7wr7x4QB09lGySXBVUMvXh39
         BrT6wTelFahT/Q1nhticF5Brpb1V4AmWtKa4yI64=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.178] ([34.92.249.81]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZTmO-1iDpt1071S-00WT7n; Tue, 17
 Dec 2019 08:05:05 +0100
Subject: Re: [PATCH] btrfs-progs: ctree.h: Sync the comment for
 btrfs_file_extent_item
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191217065240.5919-1-wqu@suse.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <29a6ed10-250c-4eac-94f3-d9db6a9fe3fb@gmx.com>
Date:   Tue, 17 Dec 2019 15:05:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191217065240.5919-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HlJ1hHZNZOciDjwbc31xq8hprr0875oi4svGD0ZZJu6xNgZ+b/Y
 0yZDTLd9/H/E9eZfzKRto5Qogepl3F3sLJdTX9ynvu4kwolMFrtjrwx8PTTSDmJRR8yUiBX
 BKN1CU2lL7wzaJ769TzVDZS+k/bdZLF46u5sj8oauELoj/xisYMGqp8R9L/3mipx27gPL7v
 U12yzeZTQwP6GyLsqgERA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0w2EjGoLI4M=:7ot7SrHVJT7RR1lE+NErHJ
 N6Kj52VrsfYnIghcJwC5reN2k0BoHEIqt0uYqn5UuN9i3ouhbFcfCz/fWN7nrIHgoAKAkHnP+
 JX0GuQlfAuBcU/dJ658MxRpvXSnDYQ8XXOJ9pPDmTkgtmM1+kSxnxS5SsE99QCi9qZcfjlHuW
 OL/Udau0ovrt/+oUpXgN+9lZ8XqFGThkiGlfvhQEiwCm06f/Sf3irA6ga8cGcvbuqTk+cBUOK
 X4JX/gW5tKVoM3PpJoVg7kvKd8Z1qnjuk6TyexDRGRMSgc5HAkl/fiZOSolejQ5JY/aoMbBB3
 a8P3cRbQ7GyVSE+KEVBH9fzFteqDmceFZmUelwQ5fg6kx24e6du72KvUCPWlqJ0qSsTWZP1pq
 sH6s+pMo6w/SI13niHAwDF2wTayjFQdZpJ1w3ZtNi0ZHOgu6169g/vIFi9ZUeC6r6Gs/le3Fo
 09yAyG8ef89+I+E8U13zOuaBC/aUBj9l+YnC/KiQCnp5y0Q39YvlzHptwnVh04w7Pnt7djxfh
 XpbuPVZ/lfitIoBcWu3GRrZgj9QpCPYQARXZgKCNHrELP/se3dvpsKwiu7tQWixHV6YVy1dkw
 ypUEwb6B+dCGp7ql9B1179fwvZ2AzFl9XHebaGDP6Duh9BnanJIw4J2G1oy6I/1T767zO3zsm
 RKSx3+gJKOeeg8mDMeJqcVivC215y0zh8bgLsoVvot8rjjrYg5/yhbLAbt0UYKrmeYieJ8aZj
 xOj0e+0k7ZRFXGq/MsowzITjQFc/fXdvyHHaNTxJkrztDwsob8RogoUhYXC4dDqzgQp71LH3q
 gNvdDjGA1WmXSTY809XODOVQh2YSV+yd9CcB1EKu31VY2ngl7mEC+bSxeEvKIcLCGY7Uy3P5/
 KlQQ4/8vjNe7V6hmswFAXa3lKpoJY92klv1+fs+AcwdsS6qAWhLpti6PwRle9vgB4wO4JhB/v
 si4cNYQWCKIPCwFuv9axM1Pu4BpmkdKIffJpDJ32GwqKO2Z99vaEEsVkIabII1FVB93VN8zeO
 B6oBO02z408mHZPPjd5LUXCcRQbc84MEEQVQjC/zx5jPcPX3ixI9BW4I7RoeGzrh+6XPu2/cR
 yRns3KegpSJ50RIF/DzwLuFPU/RWiVR1m15dKFQ8YE5GAFdH6qufBPowKPflnwmXGexWkbYvA
 UnGP0hpdV/VZPfBnlVQHK01pqjEf8tdZ+4zsyNgbdx8d/Ev74m1iE5KyqyNet3OgANpKE+lor
 A46AMm6+gq4zKLlQ2oaV3BcrJT2TdHin27klg52Z50Zz6oxss6pUbKzDmDpU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019/12/17 2:52 PM, Qu Wenruo wrote:
> The comment about data checksum on disk_bytes is completely wrong.
>
> Sync it with fixed kernel comment to avoid confusion.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

LGTM.

Reviewed-by: Su Yue <Damenly_Su@gmx.com>

> ---
>   ctree.h | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/ctree.h b/ctree.h
> index 3e50d086..9459adf1 100644
> --- a/ctree.h
> +++ b/ctree.h
> @@ -916,13 +916,16 @@ struct btrfs_file_extent_item {
>   	u8 type;
>
>   	/*
> -	 * disk space consumed by the extent, checksum blocks are included
> -	 * in these numbers
> +	 * disk space consumed by the data extent
> +	 * Data checksum is stored in csum tree, thus no bytenr/length takes
> +	 * csum into consideration.
> +	 *
> +	 * At this offset in the structure, the inline extent data starts.
>   	 */
>   	__le64 disk_bytenr;
>   	__le64 disk_num_bytes;
>   	/*
> -	 * the logical offset in file blocks (no csums)
> +	 * the logical offset in file blocks
>   	 * this extent record is for.  This allows a file extent to point
>   	 * into the middle of an existing extent on disk, sharing it
>   	 * between two snapshots (useful if some bytes in the middle of the
> @@ -930,7 +933,8 @@ struct btrfs_file_extent_item {
>   	 */
>   	__le64 offset;
>   	/*
> -	 * the logical number of file blocks (no csums included)
> +	 * the logical number of file blocks. This always reflects the size
> +	 * uncompressed and without encoding.
>   	 */
>   	__le64 num_bytes;
>
>

