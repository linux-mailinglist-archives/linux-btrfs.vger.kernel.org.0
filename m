Return-Path: <linux-btrfs+bounces-21792-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HzjIrV8l2nmzAIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21792-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 22:12:21 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B10162A3C
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 22:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EA0630602D5
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 21:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22E5326932;
	Thu, 19 Feb 2026 21:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="uMgSs6ql"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B0B30DD3B
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771535312; cv=none; b=fimIQnScYSBMs4Xs2ng57qq9R2jmUtmGwQTcCUad6Lm2I0CnwQQSgmC6GEkB+Fv4UQz5XlpUu7HV6YKFHT5RaY3RbNI9qIXnWkcTodlVVPvvJU5BHdHB5mUJXZov3dQkdBUufHNAMq8huY7sDVo9aqT1sRBERP13JsXpBhLQ/TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771535312; c=relaxed/simple;
	bh=TyQsmLTwPsIvPuQ+n0fTKPoX3PCsm2QpqzuRub4NNQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hEfVdIgrI5jy8EU8asD5mV70+RVQCO+2MG6RHnXKLxOPFTBqd/FiUKKCR2wG8jSBZKoQ9HrR43TcrwMUVbm0Z4KAKWwulCw4ghY+4IHMS6uidBWmav5MZ6cQM7Uo/bDnmDIr3TWBAu+dn+U0um80mZ0fRl7pfLNTOiNU39LWuiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=uMgSs6ql; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1771535303; x=1772140103; i=quwenruo.btrfs@gmx.com;
	bh=LGVKwvMKsMiPp4XZ3ZfKGgHHuzTsa75aLC17esUFk58=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uMgSs6qltxQ7vF24HvRTa43rEdp9HfD7mZw/zpzuAOK7rD2Wbc6JeowmrC0M76BZ
	 CWw9qV5ge40jpXW6MIEIq6FHHfshKLs1gWj+BOQZjqsaC5Ae+duEfgtRz4QRiNLnh
	 qoiCC0ACWo6HZ1EOyyXhAsApDOlozsiuYoG8UgWqOHEtwoj0ejqNOye0Ozg4ZxRGJ
	 YCPKIHI/g0l/dxvfcBHh1grKFDRbvjJl4mR4UZf3RuJ81/xF8lxeTHegeej2/QJwG
	 zcxvLsKzKGXoeTphQ1ShSOwMpOBPwNYGRediICv9cWGLKUNSl1L26/2tdOok6jyUN
	 OWP1E/CeA37SKsTevw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8GQs-1vfzwE1jLk-00uGp2; Thu, 19
 Feb 2026 22:08:23 +0100
Message-ID: <335d7dd6-22a6-4257-9588-c7f30ad06b31@gmx.com>
Date: Fri, 20 Feb 2026 07:38:18 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: mark qgroup inconsistent if dropping a large
 subvolume
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <9cd4f22eb48de2ebca28146f6db26548a8a207e7.1766123622.git.wqu@suse.com>
 <CAL3q7H7uCbcVxcTSK5hd-5_yApfCVarms0u8LGgV8RqX+s8+kw@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <CAL3q7H7uCbcVxcTSK5hd-5_yApfCVarms0u8LGgV8RqX+s8+kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dxGCkDcsYJ0+FQwE7dY1jtNOnVeMiuRWidhOkG87Q7v614dLWp2
 O0NmENOp++W23YETaBAX90I+dEgLeyF7gtPVLvDHYdRDPfYvTy+saYO5/vQjb9tbNHDoEw6
 R/+c7SUV0NSgYjTzwV9wrmGr2/YVN7LT2+XkOnSwxdt1WrhtodSisb7rbBW9W6frJx1mA9G
 1ZBzGIeP9ZxY7NKkJ5evA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J2m9VIc7x3w=;YLpr5gTIqJ4Hu9ym4alWqAXTaWD
 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
 bZL9boR8=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21792-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmx.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.com:mid,gmx.com:dkim]
X-Rspamd-Queue-Id: 03B10162A3C
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/19 22:17, Filipe Manana =E5=86=99=E9=81=93:
> On Fri, Dec 19, 2025 at 5:54=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Commit 011b46c30476 ("btrfs: skip subtree scan if it's too high to avoi=
d
>> low stall in btrfs_commit_transaction()") tries to solves the problem o=
f
>=20
> solves -> solve
>=20
>> long transaction hang caused by large qgroup workload triggered by
>> dropping a large subtree.
>>
>> But there is another situation where dropping a subvolume without any
>> snapshot can lead to the same problem.
>>
>> The only difference is that non-shared subvolume dropping triggers a lo=
t
>> of leaf rescan in one transaction. In theory btrfs_end_transaction()
>> should be able to commit a transaction due to various limits, but qgrou=
p
>> workload is never part of the threshold.
>=20
> What do you mean by btrfs_end_transaction() should be able to commit a
> transaction?
> We never trigger transaction commits there.

I mean never let a transaction to have too many dirty qgroup records=20
(and maybe other limits).

With that behavior we can spread the workload into multiple transactions=
=20
and each transaction will have a much smaller qgroup records to handle,=20
thus smaller critical sections.

>=20
>=20
>>
>> So for now just follow the same drop_subtree_threshold for any subvolum=
e
>> drop, so that we can avoid long transaction hang.
>>
>> Unfortunately this means any slightly large subvolume deletion will mar=
k
>> qgroup inconsistent and needs a rescan.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent-tree.c | 10 ++++++++++
>>   fs/btrfs/qgroup.c      | 14 ++++++++++++++
>>   fs/btrfs/qgroup.h      |  1 +
>>   3 files changed, 25 insertions(+)
>>
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index 1dcd69fe97ed..59fe3d89e910 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -6151,6 +6151,16 @@ int btrfs_drop_snapshot(struct btrfs_root *root,=
 bool update_ref, bool for_reloc
>>                  }
>>          }
>>
>> +       /*
>> +        * Not only high subtree can cause long qgroup workload,
>> +        * a lot of level 0 drop in a single transaction can also lead
>> +        * to a lot of qgroup load and freeze a transaction.
>=20
> I find this confusing. So it's saying that we can do a lot of heavy
> qgroup work if we drop a lot of trees that have a single node (root is
> a leaf, at level 0)?

No, I mean a subvolume that has high level, but no shared tree blocks=20
with any snapshot.

In that case we generate a lot of qgroup records on the leaves.

The existing qgroup pause checks are based on the subtree level, but=20
since there is no shared tree blocks, the subtree level is always 0.

The total amount of work is the same but when a tall subtree is dropped=20
we know it's going to freeze the transaction thus we pause qgroup account.

But a lot of level 0 subtrees won't trigger such pause, thus still=20
freeze the fs.

Thanks,
Qu

>=20
> But the code added in this patch doesn't do anything about that, it
> only looks at a single root to drop by checking its level against
> fs_info->qgroup_drop_subtree_thres, which has a default value of 3.
> That paragraph gives the idea we will check if we have many roots to
> drop below the threshold and do something about it too, not just for
> the case of a root at or above the threshold.
>=20
> The code seems ok, it's just this comment and that part in the
> changelog doesn't make sense to me.
> Thanks.
>=20
>> +        *
>> +        * So check the level and if it's too high just mark qgroup
>> +        * inconsistent instead of a possible long transaction freeze.
>> +        */
>> +       btrfs_qgroup_check_subvol_drop(fs_info, level);
>> +
>>          wc->restarted =3D test_bit(BTRFS_ROOT_DEAD_TREE, &root->state)=
;
>>          wc->level =3D level;
>>          wc->shared_level =3D -1;
>> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
>> index 14d393a5853d..4dfeed998c54 100644
>> --- a/fs/btrfs/qgroup.c
>> +++ b/fs/btrfs/qgroup.c
>> @@ -4953,3 +4953,17 @@ int btrfs_record_squota_delta(struct btrfs_fs_in=
fo *fs_info,
>>          spin_unlock(&fs_info->qgroup_lock);
>>          return ret;
>>   }
>> +
>> +void btrfs_qgroup_check_subvol_drop(struct btrfs_fs_info *fs_info, u8 =
level)
>> +{
>> +       u8 drop_subtree_thres;
>> +
>> +       if (!btrfs_qgroup_full_accounting(fs_info))
>> +               return;
>> +       spin_lock(&fs_info->qgroup_lock);
>> +       drop_subtree_thres =3D fs_info->qgroup_drop_subtree_thres;
>> +       spin_unlock(&fs_info->qgroup_lock);
>> +
>> +       if (level >=3D drop_subtree_thres)
>> +               qgroup_mark_inconsistent(fs_info, "subvolume level reac=
hed threshold");
>> +}
>> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
>> index a979fd59a4da..785ed16f5cc4 100644
>> --- a/fs/btrfs/qgroup.h
>> +++ b/fs/btrfs/qgroup.h
>> @@ -453,5 +453,6 @@ void btrfs_qgroup_destroy_extent_records(struct btr=
fs_transaction *trans);
>>   bool btrfs_check_quota_leak(const struct btrfs_fs_info *fs_info);
>>   int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
>>                                const struct btrfs_squota_delta *delta);
>> +void btrfs_qgroup_check_subvol_drop(struct btrfs_fs_info *fs_info, u8 =
level);
>>
>>   #endif
>> --
>> 2.52.0
>>
>>
>=20


