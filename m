Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F4548241D
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Dec 2021 14:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhLaNIC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Dec 2021 08:08:02 -0500
Received: from mout.gmx.net ([212.227.15.15]:37079 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229865AbhLaNIC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Dec 2021 08:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640956072;
        bh=JehM5EtgfGR2tbKCCIn7Gev3ar7EAEC9lWTKBOR1oW0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=TKb1PxGM889djFlOsImMt0dn/Ec3ikQjOe1ZJHAvnfH2wVjVB5KU0dwdC6fGtndkw
         Fl+JYCHZiQzilWm/J94enB1ZgWjGOrYRpdX2hozIRoZsL6bvgq5PirE48ON/wZG9V3
         P2XLJrJoaSktYAjsFYXj/xahgLD7dA9vAGxuKcCo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N3KTo-1mKyjl153S-010N3d; Fri, 31
 Dec 2021 14:07:52 +0100
Message-ID: <f6aa56ee-16b2-9a53-2377-07d638b1289b@gmx.com>
Date:   Fri, 31 Dec 2021 21:07:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] btrfs: Remove redundant initialization of slot
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20211231122306.13720-1-jiapeng.chong@linux.alibaba.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20211231122306.13720-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8camJwgylRYudZ8UupVrYlwAtCYSuqVhf8zfEPfABvzV5V6Np7L
 aRhcF1bhqWwJaiYFh1NcQ5NEXgXjjOKB1t3ynIi8Uwo4Lx1qJLNrXzInaR4aaKfWlz8M4/W
 4GqRYi7beH3LnYGmP24/1O3Es03CWauaAIvhgSi81C3erFlS34DPI/2bHEF1rXierebaJUs
 bDMejsNf2YWgIYYW38A2g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:on2/SsFZWwM=:l4qk+yt+/vgW5tTCUQbMPW
 v1ehCviT3OZPdfglPLVqzFE2HJGi6EP5x+Nmd2IGWVvNDRcJRI1D6fistiv6nRqhi8gsOx7Dh
 bidLyPCGXIXqmO3HzFgftKm4VcBzJmo4itqcQ75YKNrQfEvQXXBdSCDpx7WYdrGEMkS3HAyiE
 7zhfGD06Jo8Mm4zOotFzHsOi3jnnNJPbzpbEMqO9SNRMvoKYxzG0jBWxq1eDIVB+C5O4Ohl38
 U3O1DuTM3QacLBGrkgFOGH3JyM6RMj+0KZ+Sv6K3qPE3woyizGaRRga26pZopvDKoMSnbrKu2
 2wEqx+NBgxDOFV78SG94G6OYDZxpPF7NHZWkIxIr13scjX1V3H50i7/RIX3LZQhK84TwDNDCk
 mGAZYbKddUw/oNtfybVUmRqaWXD3i7CRp+TIvaKrLG/xu3IRAUfcLoETBjQUqIZrHCGVZSV+E
 XpcoFvUci/C2pwTI5au07ZbBTRUavLZepvskvz1ol/HsNVLkoJwt0mu7we+joAGlScr5q4nRl
 YzvzZM0IqNqNLyfbjPd/i1xZIP3jnTGtzy8SA+v5Cr6jEfD1Yd6YRyG33gBRuszexWj68/Y/N
 sZKJq3pahxjJsSxeMIA9YVORyUwEXV2c0HqZqFaRfqfZpFkbi35l3QWNznumDtPGEHDXlTJVp
 LPTaWcmA7QM4HotC62Un1+m2fYRnHomSJ6w3PFumY1yD4YjXDOAnxEKszlFEfHPEl1VILg0Li
 KzBXrsYvf34WWpxAdwKEwYhnN0sNdrPd3NcByr5Yoc23t/Jd+mb3wBCKeE33b4NUxRNgXyFK5
 3/jtGUAYfCWW+yIqUQjjXCEAESZ9wLUJvAO5kOiAEXEizMInzDtUE0GZ9S05z08EohsIrcE/5
 GaVac6/WdmicPEKc7MYaetwq1bJ/yixw1ruA6EMA+SFrf172kvA0RRBaxpqpMulpk4SNHvb3Q
 OkHv2gMgyVhb/k0n8DJMrSzGItilpvrNK6/8sS0/81wSTQ+XVXVOUuRsBjU5vgBz8TEO82NgE
 kL63DLNdQyLLhaoMbWQ+mQYVfP/JqHpiMOjxX0ItQPXKJHbakC6oqN+HXY/uQuDUm+qOSSOeZ
 2uB9NzM+pcmg0A=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/31 20:23, Jiapeng Chong wrote:
> slot is being initialized to path->slots[0] but this is never
> read as slot is overwritten later on. Remove the redundant
> initialization.
>
> Cleans up the following clang-analyzer warning:
>
> fs/btrfs/tree-log.c:6125:7: warning: Value stored to 'slot' during its
> initialization is never read [clang-analyzer-deadcode.DeadStores].
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   fs/btrfs/tree-log.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 9165486b554e..c083562a3334 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -6122,7 +6122,7 @@ static int log_new_ancestors(struct btrfs_trans_ha=
ndle *trans,
>   	while (true) {
>   		struct btrfs_fs_info *fs_info =3D root->fs_info;
>   		struct extent_buffer *leaf =3D path->nodes[0];
> -		int slot =3D path->slots[0];
> +		int slot;

If you're cleaning up slot, then why not also cleaning up leaf?

And again, no feedback no matter what on other patches from you, and
still CC to maintainers.


>   		struct btrfs_key search_key;
>   		struct inode *inode;
>   		u64 ino;
