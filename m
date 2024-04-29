Return-Path: <linux-btrfs+bounces-4632-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1683D8B654A
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2024 00:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38EFA1C21EFE
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 22:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7C019068B;
	Mon, 29 Apr 2024 22:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="beeujo5V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EB482D90
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714428072; cv=none; b=oqc3NcOA/JiybbLMk8BldzJDKCZNwmucWP6ZTxFahy3YnpPYTsvaXvt65rdamG7JmEsyARIhOnoifq/bESD/va7mpG+AMa+vyVvjL6jQE3ShOWrDZgIX3xW6r6yACdBeLXeL63Xtaowig+sXqmSngQZEbvauwGvXUZrBvhagKyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714428072; c=relaxed/simple;
	bh=yJGdclfdN1qsH9h78Z/VpqcHfqBd1URzCF8wlZ+N+6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zi7A86IVg97hHdMaafHLqPsSDkDr3Q1xo16mLlzLPhk8Kc4ICeuSEwHEWlh2ifd7st3l7WuXQ8TBIs//ut5Sw9o766cEFk/Pj93TYZd7pWuKyJEa90tzCB2dgD5zTyN4usc+YYuyvf/pCWJunUOI6p2HoPX0V3TpB/UxwMkcZL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=beeujo5V; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1714428064; x=1715032864; i=quwenruo.btrfs@gmx.com;
	bh=CHq2orSbw/e2oaOFZ3D79d81FLe+CEx7ekoMj0iI1SA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=beeujo5V4dIMblJ+KsfS6BRDsSV2kN/LChCGDFxTFZA8UZ3ULjRIQCKSTTTvojWM
	 cNSfb2keF/x6enJIokOYrG1q64xVrqlicZ85b8QhTx/LUKFCFs2PM7p7uomJV9d3m
	 Ps/m2uanPS+KXJW66eDsy93PGiZm5gtVVmHMwcNXRe8K4dUSbcRGarcjnMD2APgoV
	 UYn9/OJfzymGZzFodC95qqKwJb7+1KZKLqrKgRLIvumeNHbtP7AQenksiVZUNObTh
	 T3Kfkh6lQa7WwK3FPUpkywlYsCOqkUzFfiT/fppjZlB8veVtq1shQUVIvz1LjY062
	 qkQrDulZReK+ZMF4QA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhlKy-1sWTxH2wqW-00dkl0; Tue, 30
 Apr 2024 00:01:04 +0200
Message-ID: <d817e2ba-799c-4c88-b5b6-98b8e7233687@gmx.com>
Date: Tue, 30 Apr 2024 07:30:58 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] btrfs: slightly loose the requirement for qgroup
 removal
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1713519718.git.wqu@suse.com>
 <3fa525bceeec6096ddd131da98036e07b9947c9c.1713519718.git.wqu@suse.com>
 <20240429124741.GA21573@zen.localdomain>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20240429124741.GA21573@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jPbnrT/o7puIV0IEX1x9ezvluBU2t+UfsdUxx5+yOG1L0/qZiHN
 DOIve02+ue6UAo0D+ZTy+evm2keVPdZzrfgGGZmdQEq/keS/cXdd9/phFf05bB93/Kkxk9J
 qMRFWAWPmKFY4HMbZBkhJpG0+r9slFUCLJfD51vjgX3jvhInwaqg2yIjLMPAPWw9Y/POAw9
 XKgIKQAAmZliA0nhKD8Uw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SZZ3VEq6ylQ=;SfO41pLRGs+q4y1Hv/xd6QIH7bO
 BQLu0lbxuFzfREcu+EKIxHbPdR2c3JtNgCHyN3h2Jb3IHcDPg3vOm+nWMUZ5iyQO1EqOY5NMW
 CEXjbqb6BPjTiWb4MXXSvPEwiX8TaQRnUmYYySMExDrsjGqOYoVzs5cWWbAG2t5TaUcJqkST2
 gDyFRSr7K6TNfIDmXtSJjKRMS/SkC4vRNGqT4IdhUixIy6OtoCUK1IdeqP0oRQCnJxi2kyG/t
 ElgSUCHbv7XuTUO7BXzD1ExLa3xMp56cM5xNu8wqenz1wxpMJ3VotuOPq6WZ9+F7AORzbYbAN
 JoARqUVCu5WwgMPQ6zp1CqwFovCaWLyZiskveVPMPNr2xNVDKncz1Sagi+rSZ33qbPrYIwEdb
 5VWWvKU3y53YTSYc5FeB+UmZ41mvthW/rhFEruvNB/s6Yl9ElPWdPa8LQyhMr100D65R+A6sA
 AV7yMX9jlLrqFcvDff8zMta/6MAZIgbpqUBHpuU6IIjCPbxON7TcLxJ1njniagNG+FXswuugu
 HwNb8MHGNEb3PlSd1G93WyCuueHmVriJIXI54gaHwcNBulHC29+W2/SNGmGYpC+H0Ty5MV69v
 KSRTrE6yHDfZg4p5n1ruw7yker+ToEaH946q0izxNYXMgrsK2/2xE2wCIHBKFGEaJ1bUMZqL7
 eJTKFmyk/ZZQ4yLHxnqEyT1cVg4yv5bKsQZvZGECq7UYDkhCpvsKngIJa8l29TGbpyEQjjS+F
 1kCA5JN0GYQcnqXmvF92yhuFMnk6oNG8z1xu6gjMXcqWH9vCI5ONX0jcvnk4angV/+aWAgDXW
 hxO79t0O7CqUenRpFIZHCzk4Sc1Ypf3FDCi+6PxB0WuzU=



=E5=9C=A8 2024/4/29 22:17, Boris Burkov =E5=86=99=E9=81=93:
> On Fri, Apr 19, 2024 at 07:16:52PM +0930, Qu Wenruo wrote:
>> [BUG]
>> Currently if one is utilizing "qgroups/drop_subtree_threshold" sysfs,
>> and a snapshot with level higher than that value is dropped, btrfs will
>> not be able to delete the qgroup until next qgroup rescan:
>>
>>    uuid=3Dffffffff-eeee-dddd-cccc-000000000000
>>
>>    wipefs -fa $dev
>>    mkfs.btrfs -f $dev -O quota -s 4k -n 4k -U $uuid
>>    mount $dev $mnt
>>
>>    btrfs subvolume create $mnt/subv1/
>>    for (( i =3D 0; i < 1024; i++ )); do
>>    	xfs_io -f -c "pwrite 0 2k" $mnt/subv1/file_$i > /dev/null
>>    done
>>    sync
>>    btrfs subv snapshot $mnt/subv1 $mnt/snapshot
>>    btrfs quota enable $mnt
>>    btrfs quota rescan -w $mnt
>>    sync
>>    echo 1 > /sys/fs/btrfs/$uuid/qgroups/drop_subtree_threshold
>>    btrfs subvolume delete $mnt/snapshot
>>    btrfs subv sync $mnt
>>    btrfs qgroup show -prce --sync $mnt
>>    btrfs qgroup destroy 0/257 $mnt
>>    umount $mnt
>>
>> The final qgroup removal would fail with the following error:
>>
>>    ERROR: unable to destroy quota group: Device or resource busy
>>
>> [CAUSE]
>> The above script would generate a subvolume of level 2, then snapshot
>> it, enable qgroup, set the drop_subtree_threshold, then drop the
>> snapshot.
>>
>> Since the subvolume drop would meet the threshold, qgroup would be
>> marked inconsistent and skip accounting to avoid hanging the system at
>> transaction commit.
>>
>> But currently we do not allow a qgroup with any rfer/excl numbers to be
>> dropped, and this is not really compatible with the new
>> drop_subtree_threshold behavior.
>>
>> [FIX]
>> Instead of a strong requirement for zero rfer/excl numbers, just check
>> if there is any child for higher level qgroup, and for subvolume qgroup=
s
>> check if there is a corresponding subvolume for it.
>>
>> For rsv values, do extra warnings, and for rfer/excl numbers, only do t=
he
>> warning if we're in full accounting mode and the qgroup is consistent.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/qgroup.c | 69 ++++++++++++++++++++++++++++++++++++++++++----=
-
>>   1 file changed, 62 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
>> index 9a9f84c4d3b8..2ea16a07a7d4 100644
>> --- a/fs/btrfs/qgroup.c
>> +++ b/fs/btrfs/qgroup.c
>> @@ -1736,13 +1736,38 @@ int btrfs_create_qgroup(struct btrfs_trans_hand=
le *trans, u64 qgroupid)
>>   	return ret;
>>   }
>>
>> -static bool qgroup_has_usage(struct btrfs_qgroup *qgroup)
>> +static bool can_delete_qgroup(struct btrfs_fs_info *fs_info,
>> +			      struct btrfs_qgroup *qgroup)
>>   {
>> -	return (qgroup->rfer > 0 || qgroup->rfer_cmpr > 0 ||
>> -		qgroup->excl > 0 || qgroup->excl_cmpr > 0 ||
>> -		qgroup->rsv.values[BTRFS_QGROUP_RSV_DATA] > 0 ||
>> -		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PREALLOC] > 0 ||
>> -		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PERTRANS] > 0);
>> +	struct btrfs_key key;
>> +	struct btrfs_path *path;
>> +	int ret;
>> +
>> +	/* For higher level qgroup, we can only delete it if it has no child.=
 */
>> +	if (btrfs_qgroup_level(qgroup->qgroupid)) {
>> +		if (!list_empty(&qgroup->members))
>> +			return false;
>> +		return true;
>> +	}
>> +
>> +	/*
>> +	 * For level-0 qgroups, we can only delete it if it has no subvolume
>> +	 * for it.
>> +	 * This means even a subvolume is unlinked but not yet fully dropped,
>> +	 * we can not delete the qgroup.
>> +	 */
>
> This was what I originally considered for normal qgroups before observin=
g
> that usage is 0 anyway. I didn't know about the drop tree threshold,
> my mistake.
>
> With that said, I support this change for non-squota qgroups.
>
> For squota, I think this behavior would be OK, but undesirable, IMO. Any
> parent qgroup would still have its usage incremented against the limit,
> but it would be impossible to find any information on where it was from.

That's indeed another problem.

For regular qgroup that could only happen when qgroup is inconsistent,
and we're fine to drop the qgroup without updating the parent.

But for squota, there is no inconsistent state, meaning we should also
drop all the numbers from parent too.

>
> How do you feel about making this patch add the new logic and make it
> conditional on qgroup mode?

I'm totally fine to do it conditional, although I'd also like to get
feedback on dropping the numbers from parent qgroup (so we can do it for
both qgroup and squota).

Would the auto drop for parent numbers be a solution?

Thanks,
Qu
>
> Thanks,
> Boris
>
>> +	key.objectid =3D qgroup->qgroupid;
>> +	key.type =3D BTRFS_ROOT_ITEM_KEY;
>> +	key.offset =3D -1ULL;
>> +	path =3D btrfs_alloc_path();
>> +	if (!path)
>> +		return false;
>> +
>> +	ret =3D btrfs_find_root(fs_info->tree_root, &key, path, NULL, NULL);
>> +	btrfs_free_path(path);
>> +	if (ret > 0)
>> +		return true;
>> +	return false;
>>   }
>>
>>   int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupi=
d)
>> @@ -1764,7 +1789,7 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle=
 *trans, u64 qgroupid)
>>   		goto out;
>>   	}
>>
>> -	if (is_fstree(qgroupid) && qgroup_has_usage(qgroup)) {
>> +	if (!can_delete_qgroup(fs_info, qgroup)) {
>>   		ret =3D -EBUSY;
>>   		goto out;
>>   	}
>> @@ -1789,6 +1814,36 @@ int btrfs_remove_qgroup(struct btrfs_trans_handl=
e *trans, u64 qgroupid)
>>   	}
>>
>>   	spin_lock(&fs_info->qgroup_lock);
>> +	/*
>> +	 * Warn on reserved space. The subvolume should has no child nor
>> +	 * corresponding subvolume.
>> +	 * Thus its reserved space should all be zero, no matter if qgroup
>> +	 * is consistent or the mode.
>> +	 */
>> +	WARN_ON(qgroup->rsv.values[BTRFS_QGROUP_RSV_DATA] ||
>> +		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PREALLOC] ||
>> +		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PERTRANS]);
>> +	/*
>> +	 * The same for rfer/excl numbers, but that's only if our qgroup is
>> +	 * consistent and if it's in regular qgroup mode.
>> +	 * For simple mode it's not as accurate thus we can hit non-zero valu=
es
>> +	 * very frequently.
>> +	 */
>> +	if (btrfs_qgroup_mode(fs_info) =3D=3D BTRFS_QGROUP_MODE_FULL &&
>> +	    !(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT))=
 {
>> +		if (WARN_ON(qgroup->rfer || qgroup->excl ||
>> +			    qgroup->rfer_cmpr || qgroup->excl_cmpr)) {
>> +			btrfs_warn_rl(fs_info,
>> +"to be deleted qgroup %u/%llu has non-zero numbers, rfer %llu rfer_cmp=
r %llu excl %llu excl_cmpr %llu",
>> +				      btrfs_qgroup_level(qgroup->qgroupid),
>> +				      btrfs_qgroup_subvolid(qgroup->qgroupid),
>> +				      qgroup->rfer,
>> +				      qgroup->rfer_cmpr,
>> +				      qgroup->excl,
>> +				      qgroup->excl_cmpr);
>> +			qgroup_mark_inconsistent(fs_info);
>> +		}
>> +	}
>
> If you go ahead with making it conditional, I would fold this warning
> into the check logic. Either way is fine, of course.
>
>>   	del_qgroup_rb(fs_info, qgroupid);
>>   	spin_unlock(&fs_info->qgroup_lock);
>>
>> --
>> 2.44.0
>>
>

