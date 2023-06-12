Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E375172D4CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 01:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjFLXKj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 19:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjFLXKi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 19:10:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8967CE4
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 16:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686611433; x=1687216233; i=quwenruo.btrfs@gmx.com;
 bh=LBXLKLpz7A2FLYTNgNk+AkAh8MOi2PyOT0JK41D3hCY=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=pwUqdniOhl3sMcEpxRl1JWzp2OQ1UBUt4lFcosFNwVT0NkchSnBq2liVSOECChTWfmjuTQv
 mn14X625UmFgL/YP09l8+USry7Tt8rUxcpnyEEaRAI1fKIU03xMOf/FFJ/wIHiZA51UapWWFN
 zCH7bQIyE/Q+GwcRUkZsNve5ceAB7KQbrQVWg2Gk8IApQRLaTZoD8HGNr496J8mtApyAGMp6R
 Nx1JWszhwCKnuX8Zh1vJn8+f74+GPVBpOCB/3Lq8wkH68h/hu6j2O3yrl4l6mk9ubFkT0q7I7
 /a+BHScZfjaJwzGEph5+Uxd8rJx7g2Ni4WgDfOf3ysvVe6tkyLTg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZTqW-1qc2uM1FkU-00WYaL; Tue, 13
 Jun 2023 01:10:32 +0200
Message-ID: <06b59342-286d-07c5-21f0-5750e754e1aa@gmx.com>
Date:   Tue, 13 Jun 2023 07:10:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: do not ASSERT() on duplicated global roots
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        syzbot+a694851c6ab28cbcfb9c@syzkaller.appspotmail.com
References: <89dec0414ce198ef49d3014232bd1b88e3e74260.1686441969.git.wqu@suse.com>
 <20230612213748.GG13486@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230612213748.GG13486@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4Y74EGZ7EtJILq7yt288nQu8o34YMkKb3lPWTakr6igSvXWZqv5
 MMieJEfxygMOCYD7v5/qNUjD9eE5SimR/b/mRI4VK13r0WR6ugCSmQqcvemNGI+dze73VDw
 /7agZeNC50mBY6vtPLLp869xUf28bQ+yXZAbQ9rjiKqiDMk2HkJFcqBbQsyzewv2Eq7AMra
 C9eNiNDbJDDcRMgjRq7EA==
UI-OutboundReport: notjunk:1;M01:P0:CULlDXHMgHs=;TXw+JF1gkIfUJWZTiz4PhvkJ1BF
 6WAnc0Tlm0ES+F05wwF9iU6JYpaW6Iz2diZaCRTgnPkrJYreCIl0IPoIjkmYVh+e1IYSP+C7n
 lXAquyCsJ5Te0noF3/Lt/9uwBzd5v3c8AJz37G9+JXX2/9J0rNGiIfvr6JZSoSxbx+kSd/f0n
 926DY/mTq3g2aofteWRIXoJLNIohhAXVz5/5NDbP/aKo6Un3NRJLK8hsd/G6Qu8zLLMuf2rMG
 C+muEg2lYKBPLRHQwhVpktnvlbnWh1RSfShneEYxRImQVF4MJuumltJd7Pu06JkspLzBsvDOs
 PsGvv3/yp/UiZiQCvXj919szcEcdO63EIe272MIuyUIE9dlqNbca9BSop2Txma1Z4rsIRUWvi
 OGMIRN4f5K142s9HO/9UBh0uJ+kg9a6uT2dsyb2PKpnLO60O/9K6tGz7U+ChYlmZRqW4wMXi2
 27L97wVWEI3YTpayGzfxul2AMSNqczfa6D1lFQQeMSQqRKqjTa1gxNMacDCZ96mKi1Ds3y4YE
 jZrW8NDC7JWemcMy+ghw+VyX5Hx2PQ4Bk8f55m65s2rr29bGzkyYWxM4x9huq67bjX38UZtM7
 sSTv+RUdBpmpSgmgINZprDAakrllAeod3eczAL/45/h/2bSwSrXqdDIOthMiee6yKng4nzRxx
 lK4zDiWsKKUXqEifL1ZtwrnZnHhGSTEiEjtrrqtPRHH3nmcQgBYMi7OaqbYl39W2dJ1ibGP4u
 gdG6J0cDI66jAGAKOWwi9sEKkiOh4MwGstufoK0rMDMQpUoVvyOm/41A2dJlZ+eH82FlxmHYn
 KasikRdV7HxFkybKfrTWNt9XETV/rsHH2Y3hb2e9Yf6bahyBLje6Qpk58hABAYLcH/BB8xHxI
 wiYB5HjklWGtDciR1SI1TQE/5Su5QPDMiDzaxDQpUkinNr1DwwS6OtnCtsUGuQsGu1b6PKLIp
 shmgMvwWuEz7R+OZ2c8knN4u+I0=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/13 05:37, David Sterba wrote:
> On Sun, Jun 11, 2023 at 08:09:13AM +0800, Qu Wenruo wrote:
>> [BUG]
>> Syzbot reports a reproducible ASSERT() when using rescue=3Dusebackuproo=
t
>> mount option on a corrupted fs.
>>
>> The full report can be found here:
>> https://syzkaller.appspot.com/bug?extid=3Dc4614eae20a166c25bf0
>
> I'll copy the stack trace here, the link is good for reference but we
> want to record the contents too.
>
>> [CAUSE]
>> Since the introduction of global roots, we handle
>> csum/extent/free-space-tree roots as global roots, even if no
>> extent-tree-v2 feature is enabled.
>>
>> So for regular csum/extent/fst roots, we load them into
>> fs_info::global_root_tree rb tree.
>>
>> And we should not expect any conflicts in that rb tree, thus we have an
>> ASSERT() inside btrfs_global_root_insert().
>>
>> But rescue=3Dusebackuproot can break the assumption, as we will try to
>> load those trees again and again as long as we have bad roots and have
>> backup roots slot remaining.
>>
>> So in that case we can have conflicting roots in the rb tree, and
>> triggering the ASSERT() crash.
>>
>> [FIX]
>> We can safely remove that ASSERT(), as the caller will properly put the
>> offending root.
>>
>> To make further debugging easier, also add two explicit error messages:
>>
>> - Error message for conflicting global roots
>> - Error message when using backup roots slot
>>
>> Reported-by: syzbot+a694851c6ab28cbcfb9c@syzkaller.appspotmail.com
>> Fixes: abed4aaae4f7 ("btrfs: track the csum, extent, and free space tre=
es in a rb tree")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/disk-io.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 1168e5df8bae..7f201975a303 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -748,13 +748,18 @@ int btrfs_global_root_insert(struct btrfs_root *r=
oot)
>>   {
>>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
>>   	struct rb_node *tmp;
>> +	int ret =3D 0;
>>
>>   	write_lock(&fs_info->global_root_lock);
>>   	tmp =3D rb_find_add(&root->rb_node, &fs_info->global_root_tree, glob=
al_root_cmp);
>>   	write_unlock(&fs_info->global_root_lock);
>> -	ASSERT(!tmp);
>>
>> -	return tmp ? -EEXIST : 0;
>> +	if (tmp) {
>> +		ret =3D -EEXIST;
>> +		btrfs_warn(fs_info, "global root %lld %llu already exists",
>
> %lld is to show the negative numbers, right? Are there any actual global
> roots with such numbers?
>
> BTRFS_DATA_RELOC_TREE_OBJECTID		-9
> BTRFS_TREE_RELOC_OBJECTID		-8
> BTRFS_TREE_LOG_FIXUP_OBJECTID		-7
> BTRFS_TREE_LOG_OBJECTID			-6
>
> None of them seems to be among the global roots.

Right, data reloc tree is not a global one, so %llu is OK.
>
>> +				root->root_key.objectid, root->root_key.offset);
>> +	}
>> +	return ret;
>>   }
>>
>>   void btrfs_global_root_delete(struct btrfs_root *root)
>> @@ -2591,6 +2596,7 @@ static int __cold init_tree_roots(struct btrfs_fs=
_info *fs_info)
>>   			/* We can't trust the free space cache either */
>>   			btrfs_set_opt(fs_info->mount_opt, CLEAR_CACHE);
>>
>> +			btrfs_warn(fs_info, "try to load backup roots slot %u", i);
>
> is int, so %d

But @i is only between [0, 4), thus %u is fine.

Thanks,
Qu

>
>>   			ret =3D read_backup_root(fs_info, i);
>>   			backup_index =3D ret;
>>   			if (ret < 0)
>> --
>> 2.41.0
