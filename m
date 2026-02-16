Return-Path: <linux-btrfs+bounces-21692-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AUHLaWKk2lA6QEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21692-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 22:22:45 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCB0147B38
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 22:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DD3A3011130
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 21:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9D02797B5;
	Mon, 16 Feb 2026 21:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="A1ubfEm6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E7A5B21A
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Feb 2026 21:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771276955; cv=none; b=IJdAHx2JYeFfDPwWxilnkBOIk7NZirXJ1B+Sysn567dWNd5yFvqGLbSqAqa3+WdlKyASGs5sbWZKFnfaxMIhAW1Iz/QWc0aGneJ0/j0l9PbsdsUnpASQXlQjZw6AxXcDHPmSvQ+Omc6nAq2dhTGt72XrzVjucgmuyV1SQruBeC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771276955; c=relaxed/simple;
	bh=eOYl9WH/t5QDwa38U3qz6zai8/ZtJS9WCrLdpznQDUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTxRjQC0TwjlVen+UVCLhRC2521De+rhydAj/W3psDnROAGPXU4ECO3JvetFNrZOExEKin4MG7BJBoCw2GoJnIQ+XNm1zKljQjn9IpjRFg+jyp4KQcsngntFL//7K9Qm9ErT0TDzcp/YEvliB0/xvw3dS8lLc0hS63T1D3+8/Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=A1ubfEm6; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1771276945; x=1771881745; i=quwenruo.btrfs@gmx.com;
	bh=aeJAK+3WCpe36Hj4EYhm3KnsO84tqUbk/4cNTXhxP+k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=A1ubfEm6OJnRef9oOVxekozjPXX67Dv8K3DDjADCyA4XVcbqPtA6+IlszhcE7bP2
	 d39nhyBEIxpxAyYOgzZKL/9U3WJLCVoE6j5/sVAfw7dLwvG4v5mMX7SFY1eAMKUr4
	 gZC8cUl8TtX0k0/hUjc0n5QBD5lfsaIouTta4M9TJU54e14L9wVmIZwhArvI9S71Q
	 na6amqVVvUNVYY7rkyX9+ME1+zzYNT5KPUECHG+BIIJOPkuBCeYYzy2jE7uhsF0wc
	 zxl9zGfAsWcFnfhMZ9XyK26Pt3GutFt3wrNt3Gy+dzjKQESOusXXa5c2tukWaBck3
	 xr7fDcu0eOtWnQP2JA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MkHMZ-1vTVoP2zur-00ZJcD; Mon, 16
 Feb 2026 22:22:25 +0100
Message-ID: <eb65cee1-5d15-4659-bc9c-7e40992043d6@gmx.com>
Date: Tue, 17 Feb 2026 07:52:20 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove folio parameter from ordered io related
 functions
To: Filipe Manana <fdmanana@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cd0abcd6792c8a155af818bbe88d37d9957f4465.1770887628.git.wqu@suse.com>
 <CAL3q7H4y3reiYwXZPTXYyPqKOjxOP_SVHGPQKH7q3V=LmmBUmg@mail.gmail.com>
 <cdfc5693-9d6c-420f-b13d-b0e6495054c3@gmx.com>
 <CAL3q7H4052behXuaqkRxcPMbGyPYNeN0uruJ-b3RGJ3NC9aRsA@mail.gmail.com>
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
In-Reply-To: <CAL3q7H4052behXuaqkRxcPMbGyPYNeN0uruJ-b3RGJ3NC9aRsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ucjEP4k0omx4wrCAPHbJ/PwdQx2X8BHTVNZT59AE+GmUaV7BxBn
 HBcwnVPkmDEtD7rvGf0K02MUUZWwCWi2gLdHUb4evurSMs+VtXuxNJJJqJEP/Zy2OyhKKLE
 0UFHzMRahoPgA//MjwgDn3OKH6kVombBJbMILuC4yYRIGasleI3Avt/zbOxIJQmlLBBj+2P
 O1gHTwEOG13RwpcTBZYfw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rdT20woAXDc=;p2qlW9wB01sHxVLOdMuxlvFF7Oz
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21692-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmx.com:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.com]
X-Rspamd-Queue-Id: 0DCB0147B38
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/16 22:53, Filipe Manana =E5=86=99=E9=81=93:
> On Fri, Feb 13, 2026 at 4:47=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
>>
>>
>>
>> =E5=9C=A8 2026/2/13 02:57, Filipe Manana =E5=86=99=E9=81=93:
>>> On Thu, Feb 12, 2026 at 9:14=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote=
:
>>>>
>>>> Both functions btrfs_finish_ordered_extent() and
>>>> btrfs_mark_ordered_io_finished() are accepting an optional folio
>>>> parameter.
>>>>
>>>> That @folio is passed into can_finish_ordered_extent(), which later w=
ill
>>>> test and clear the ordered flag for the involved range.
>>>>
>>>> However I do not think there is any other call site that can clear
>>>> ordered flags of an page cache folio and can affect
>>>> can_finish_ordered_extent().
>>>>
>>>> There are limited *_clear_ordered() callers out of
>>>> can_finish_ordered_extent() function:
>>>>
>>>> - btrfs_migrate_folio()
>>>>     This is completely unrelated, it's just migrating the ordered fla=
g to
>>>>     the new folio.
>>>>
>>>> - btrfs_cleanup_ordered_extents()
>>>>     We manually clean the ordered flags of all involved folios, then =
call
>>>>     btrfs_mark_ordered_io_finished() without a @folio parameter.
>>>>     So it doesn't need and didn't pass a @folio parameter in the firs=
t
>>>>     place.
>>>>
>>>> - btrfs_writepage_fixup_worker()
>>>>     This function is going to be removed soon, and we should not hit =
that
>>>>     function anymore.
>>>
>>> I still hit that sporadically with fstests, (generic/475 and
>>> generic/648 at least).
>>
>> It may help if you have saved the dmesg of failed runs and can share
>> that dmesg.
>=20
> https://pastebin.com/raw/JZD4bWar

Thanks a lot, it shows some patterns that match my failed runs:

- Always after a transaction abort

- There is no other delalloc error for the affected inode

So there must be some new corner cases that is not covered.

Thanks,
Qu

>=20
>>
>> I just checked my failed dmesgs, but failed to get a good clue.
>>
>> Thanks,
>> Qu
>>
>>>
>>>>
>>>> - btrfs_invalidate_folio()
>>>>     This is the real call site we need to bother.
>>>
>>> bother -> bother with
>>>
>>> Otherwise it looks good.
>>>
>>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>>>
>>> Thanks.
>>>
>>>>
>>>>     If we already have a bio running, btrfs_finish_ordered_extent() i=
n
>>>>     end_bbio_data_write() will be executed first, as
>>>>     btrfs_invalidate_folio() will wait for the writeback to finish.
>>>>
>>>>     Thus if there is a running bio, it will not see the range has
>>>>     ordered flags, and just skip to the next range.
>>>>
>>>>     If there is no bio running, meaning the ordered extent is created=
 but
>>>>     the folio is not yet submitted.
>>>>
>>>>     In that case btrfs_invalidate_folio() will manually clear the fol=
io
>>>>     ordered range, but then manually finish the ordered extent with
>>>>     btrfs_dec_test_ordered_pending() without bothering the folio orde=
red
>>>>     flags.
>>>>
>>>>     Meaning if the OE range with folio ordered flags will be finished
>>>>     manually without the need to call can_finish_ordered_extent().
>>>>
>>>> This means all can_finish_ordered_extent() call sites should get a ra=
nge
>>>> that has folio ordered flag set, thus the old "return false" branch
>>>> should never be triggered.
>>>>
>>>> Now we can:
>>>>
>>>> - Remove the @folio parameter from involved functions
>>>>     * btrfs_mark_ordered_io_finished()
>>>>     * btrfs_finish_ordered_extent()
>>>>
>>>>     For call sites passing a @folio into those functions, let them
>>>>     manually clear the ordered flag of involved folios.
>>>>
>>>> - Move btrfs_finish_ordered_extent() out of the loop in
>>>>     end_bbio_data_write()
>>>>
>>>>     We only need to call btrfs_finish_ordered_extent() once per bbio,
>>>>     not per folio.
>>>>
>>>> - Add an ASSERT() to make sure all folio ranges have ordered flags
>>>>     It's only for end_bbio_data_write().
>>>>
>>>>     And we already have enough safe nets to catch over-accounting of =
ordered
>>>>     extents.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>
>>>> But I still appreciate any extra eyes on the call site analyze.
>>>> ---
>>>>    fs/btrfs/compression.c  |  2 +-
>>>>    fs/btrfs/direct-io.c    |  9 ++++-----
>>>>    fs/btrfs/extent_io.c    | 23 ++++++++++++++---------
>>>>    fs/btrfs/inode.c        |  6 ++++--
>>>>    fs/btrfs/ordered-data.c | 29 +++++------------------------
>>>>    fs/btrfs/ordered-data.h |  6 ++----
>>>>    6 files changed, 30 insertions(+), 45 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
>>>> index 1e7174ad32e2..1938d33ab57a 100644
>>>> --- a/fs/btrfs/compression.c
>>>> +++ b/fs/btrfs/compression.c
>>>> @@ -292,7 +292,7 @@ static void end_bbio_compressed_write(struct btrf=
s_bio *bbio)
>>>>           struct compressed_bio *cb =3D to_compressed_bio(bbio);
>>>>           struct folio_iter fi;
>>>>
>>>> -       btrfs_finish_ordered_extent(cb->bbio.ordered, NULL, cb->start=
, cb->len,
>>>> +       btrfs_finish_ordered_extent(cb->bbio.ordered, cb->start, cb->=
len,
>>>>                                       cb->bbio.bio.bi_status =3D=3D B=
LK_STS_OK);
>>>>
>>>>           if (cb->writeback)
>>>> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
>>>> index 9a63200d7a53..837306254f73 100644
>>>> --- a/fs/btrfs/direct-io.c
>>>> +++ b/fs/btrfs/direct-io.c
>>>> @@ -625,7 +625,7 @@ static int btrfs_dio_iomap_end(struct inode *inod=
e, loff_t pos, loff_t length,
>>>>                   pos +=3D submitted;
>>>>                   length -=3D submitted;
>>>>                   if (write)
>>>> -                       btrfs_finish_ordered_extent(dio_data->ordered=
, NULL,
>>>> +                       btrfs_finish_ordered_extent(dio_data->ordered=
,
>>>>                                                       pos, length, fa=
lse);
>>>>                   else
>>>>                           btrfs_unlock_dio_extent(&BTRFS_I(inode)->io=
_tree, pos,
>>>> @@ -657,9 +657,8 @@ static void btrfs_dio_end_io(struct btrfs_bio *bb=
io)
>>>>           }
>>>>
>>>>           if (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE) {
>>>> -               btrfs_finish_ordered_extent(bbio->ordered, NULL,
>>>> -                                           dip->file_offset, dip->by=
tes,
>>>> -                                           !bio->bi_status);
>>>> +               btrfs_finish_ordered_extent(bbio->ordered, dip->file_=
offset,
>>>> +                                           dip->bytes, !bio->bi_stat=
us);
>>>>           } else {
>>>>                   btrfs_unlock_dio_extent(&inode->io_tree, dip->file_=
offset,
>>>>                                           dip->file_offset + dip->byt=
es - 1, NULL);
>>>> @@ -735,7 +734,7 @@ static void btrfs_dio_submit_io(const struct ioma=
p_iter *iter, struct bio *bio,
>>>>
>>>>                   ret =3D btrfs_extract_ordered_extent(bbio, dio_data=
->ordered);
>>>>                   if (ret) {
>>>> -                       btrfs_finish_ordered_extent(dio_data->ordered=
, NULL,
>>>> +                       btrfs_finish_ordered_extent(dio_data->ordered=
,
>>>>                                                       file_offset, di=
p->bytes,
>>>>                                                       !ret);
>>>>                           bio->bi_status =3D errno_to_blk_status(ret)=
;
>>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>>> index 11faecb66109..8914eda1c28f 100644
>>>> --- a/fs/btrfs/extent_io.c
>>>> +++ b/fs/btrfs/extent_io.c
>>>> @@ -521,6 +521,7 @@ static void end_bbio_data_write(struct btrfs_bio =
*bbio)
>>>>           int error =3D blk_status_to_errno(bio->bi_status);
>>>>           struct folio_iter fi;
>>>>           const u32 sectorsize =3D fs_info->sectorsize;
>>>> +       u32 bio_size =3D 0;
>>>>
>>>>           ASSERT(!bio_flagged(bio, BIO_CLONED));
>>>>           bio_for_each_folio_all(fi, bio) {
>>>> @@ -528,6 +529,7 @@ static void end_bbio_data_write(struct btrfs_bio =
*bbio)
>>>>                   u64 start =3D folio_pos(folio) + fi.offset;
>>>>                   u32 len =3D fi.length;
>>>>
>>>> +               bio_size +=3D len;
>>>>                   /* Our read/write should always be sector aligned. =
*/
>>>>                   if (!IS_ALIGNED(fi.offset, sectorsize))
>>>>                           btrfs_err(fs_info,
>>>> @@ -538,13 +540,15 @@ static void end_bbio_data_write(struct btrfs_bi=
o *bbio)
>>>>                   "incomplete page write with offset %zu and length %=
zu",
>>>>                                      fi.offset, fi.length);
>>>>
>>>> -               btrfs_finish_ordered_extent(bbio->ordered, folio, sta=
rt, len,
>>>> -                                           !error);
>>>>                   if (error)
>>>>                           mapping_set_error(folio->mapping, error);
>>>> +
>>>> +               ASSERT(btrfs_folio_test_ordered(fs_info, folio, start=
, len));
>>>> +               btrfs_folio_clear_ordered(fs_info, folio, start, len)=
;
>>>>                   btrfs_folio_clear_writeback(fs_info, folio, start, =
len);
>>>>           }
>>>>
>>>> +       btrfs_finish_ordered_extent(bbio->ordered, bbio->file_offset,=
 bio_size, !error);
>>>>           bio_put(bio);
>>>>    }
>>>>
>>>> @@ -1577,7 +1581,8 @@ static noinline_for_stack int writepage_delallo=
c(struct btrfs_inode *inode,
>>>>                           u64 start =3D page_start + (start_bit << fs=
_info->sectorsize_bits);
>>>>                           u32 len =3D (end_bit - start_bit) << fs_inf=
o->sectorsize_bits;
>>>>
>>>> -                       btrfs_mark_ordered_io_finished(inode, folio, =
start, len, false);
>>>> +                       btrfs_folio_clear_ordered(fs_info, folio, sta=
rt, len);
>>>> +                       btrfs_mark_ordered_io_finished(inode, start, =
len, false);
>>>>                   }
>>>>                   return ret;
>>>>           }
>>>> @@ -1653,6 +1658,7 @@ static int submit_one_sector(struct btrfs_inode=
 *inode,
>>>>                    * ordered extent.
>>>>                    */
>>>>                   btrfs_folio_clear_dirty(fs_info, folio, filepos, se=
ctorsize);
>>>> +               btrfs_folio_clear_ordered(fs_info, folio, filepos, se=
ctorsize);
>>>>                   btrfs_folio_set_writeback(fs_info, folio, filepos, =
sectorsize);
>>>>                   btrfs_folio_clear_writeback(fs_info, folio, filepos=
, sectorsize);
>>>>
>>>> @@ -1660,8 +1666,8 @@ static int submit_one_sector(struct btrfs_inode=
 *inode,
>>>>                    * Since there is no bio submitted to finish the or=
dered
>>>>                    * extent, we have to manually finish this sector.
>>>>                    */
>>>> -               btrfs_mark_ordered_io_finished(inode, folio, filepos,
>>>> -                                              fs_info->sectorsize, f=
alse);
>>>> +               btrfs_mark_ordered_io_finished(inode, filepos, fs_inf=
o->sectorsize,
>>>> +                                              false);
>>>>                   return PTR_ERR(em);
>>>>           }
>>>>
>>>> @@ -1773,8 +1779,8 @@ static noinline_for_stack int extent_writepage_=
io(struct btrfs_inode *inode,
>>>>                           spin_unlock(&inode->ordered_tree_lock);
>>>>                           btrfs_put_ordered_extent(ordered);
>>>>
>>>> -                       btrfs_mark_ordered_io_finished(inode, folio, =
cur,
>>>> -                                                      fs_info->secto=
rsize, true);
>>>> +                       btrfs_folio_clear_ordered(fs_info, folio, cur=
, fs_info->sectorsize);
>>>> +                       btrfs_mark_ordered_io_finished(inode, cur, fs=
_info->sectorsize, true);
>>>>                           /*
>>>>                            * This range is beyond i_size, thus we don=
't need to
>>>>                            * bother writing back.
>>>> @@ -2649,8 +2655,7 @@ void extent_write_locked_range(struct inode *in=
ode, const struct folio *locked_f
>>>>                   if (IS_ERR(folio)) {
>>>>                           cur_end =3D min(round_down(cur, PAGE_SIZE) =
+ PAGE_SIZE - 1, end);
>>>>                           cur_len =3D cur_end + 1 - cur;
>>>> -                       btrfs_mark_ordered_io_finished(BTRFS_I(inode)=
, NULL,
>>>> -                                                      cur, cur_len, =
false);
>>>> +                       btrfs_mark_ordered_io_finished(BTRFS_I(inode)=
, cur, cur_len, false);
>>>>                           mapping_set_error(mapping, PTR_ERR(folio));
>>>>                           cur =3D cur_end;
>>>>                           continue;
>>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>>> index 3af087c81724..b6b386e06529 100644
>>>> --- a/fs/btrfs/inode.c
>>>> +++ b/fs/btrfs/inode.c
>>>> @@ -424,7 +424,7 @@ static inline void btrfs_cleanup_ordered_extents(=
struct btrfs_inode *inode,
>>>>                   folio_put(folio);
>>>>           }
>>>>
>>>> -       return btrfs_mark_ordered_io_finished(inode, NULL, offset, by=
tes, false);
>>>> +       return btrfs_mark_ordered_io_finished(inode, offset, bytes, f=
alse);
>>>>    }
>>>>
>>>>    static int btrfs_dirty_inode(struct btrfs_inode *inode);
>>>> @@ -2945,7 +2945,9 @@ static void btrfs_writepage_fixup_worker(struct=
 btrfs_work *work)
>>>>                    * to reflect the errors and clean the page.
>>>>                    */
>>>>                   mapping_set_error(folio->mapping, ret);
>>>> -               btrfs_mark_ordered_io_finished(inode, folio, page_sta=
rt,
>>>> +               btrfs_folio_clear_ordered(fs_info, folio, page_start,
>>>> +                                         folio_size(folio));
>>>> +               btrfs_mark_ordered_io_finished(inode, page_start,
>>>>                                                  folio_size(folio), !=
ret);
>>>>                   folio_clear_dirty_for_io(folio);
>>>>           }
>>>> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
>>>> index e47c3a3a619a..8405d07b49cd 100644
>>>> --- a/fs/btrfs/ordered-data.c
>>>> +++ b/fs/btrfs/ordered-data.c
>>>> @@ -348,30 +348,13 @@ static void finish_ordered_fn(struct btrfs_work=
 *work)
>>>>    }
>>>>
>>>>    static bool can_finish_ordered_extent(struct btrfs_ordered_extent =
*ordered,
>>>> -                                     struct folio *folio, u64 file_o=
ffset,
>>>> -                                     u64 len, bool uptodate)
>>>> +                                     u64 file_offset, u64 len, bool =
uptodate)
>>>>    {
>>>>           struct btrfs_inode *inode =3D ordered->inode;
>>>>           struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>>>>
>>>>           lockdep_assert_held(&inode->ordered_tree_lock);
>>>>
>>>> -       if (folio) {
>>>> -               ASSERT(folio->mapping);
>>>> -               ASSERT(folio_pos(folio) <=3D file_offset);
>>>> -               ASSERT(file_offset + len <=3D folio_next_pos(folio));
>>>> -
>>>> -               /*
>>>> -                * Ordered flag indicates whether we still have
>>>> -                * pending io unfinished for the ordered extent.
>>>> -                *
>>>> -                * If it's not set, we need to skip to next range.
>>>> -                */
>>>> -               if (!btrfs_folio_test_ordered(fs_info, folio, file_of=
fset, len))
>>>> -                       return false;
>>>> -               btrfs_folio_clear_ordered(fs_info, folio, file_offset=
, len);
>>>> -       }
>>>> -
>>>>           /* Now we're fine to update the accounting. */
>>>>           if (WARN_ON_ONCE(len > ordered->bytes_left)) {
>>>>                   btrfs_crit(fs_info,
>>>> @@ -413,8 +396,7 @@ static void btrfs_queue_ordered_fn(struct btrfs_o=
rdered_extent *ordered)
>>>>    }
>>>>
>>>>    void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *orde=
red,
>>>> -                                struct folio *folio, u64 file_offset=
, u64 len,
>>>> -                                bool uptodate)
>>>> +                                u64 file_offset, u64 len, bool uptod=
ate)
>>>>    {
>>>>           struct btrfs_inode *inode =3D ordered->inode;
>>>>           bool ret;
>>>> @@ -422,7 +404,7 @@ void btrfs_finish_ordered_extent(struct btrfs_ord=
ered_extent *ordered,
>>>>           trace_btrfs_finish_ordered_extent(inode, file_offset, len, =
uptodate);
>>>>
>>>>           spin_lock(&inode->ordered_tree_lock);
>>>> -       ret =3D can_finish_ordered_extent(ordered, folio, file_offset=
, len,
>>>> +       ret =3D can_finish_ordered_extent(ordered, file_offset, len,
>>>>                                           uptodate);
>>>>           spin_unlock(&inode->ordered_tree_lock);
>>>>
>>>> @@ -475,8 +457,7 @@ void btrfs_finish_ordered_extent(struct btrfs_ord=
ered_extent *ordered,
>>>>     * extent(s) covering it.
>>>>     */
>>>>    void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
>>>> -                                   struct folio *folio, u64 file_off=
set,
>>>> -                                   u64 num_bytes, bool uptodate)
>>>> +                                   u64 file_offset, u64 num_bytes, b=
ool uptodate)
>>>>    {
>>>>           struct rb_node *node;
>>>>           struct btrfs_ordered_extent *entry =3D NULL;
>>>> @@ -536,7 +517,7 @@ void btrfs_mark_ordered_io_finished(struct btrfs_=
inode *inode,
>>>>                   len =3D this_end - cur;
>>>>                   ASSERT(len < U32_MAX);
>>>>
>>>> -               if (can_finish_ordered_extent(entry, folio, cur, len,=
 uptodate)) {
>>>> +               if (can_finish_ordered_extent(entry, cur, len, uptoda=
te)) {
>>>>                           spin_unlock(&inode->ordered_tree_lock);
>>>>                           btrfs_queue_ordered_fn(entry);
>>>>                           spin_lock(&inode->ordered_tree_lock);
>>>> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
>>>> index 86e69de9e9ff..cd74c5ecfd67 100644
>>>> --- a/fs/btrfs/ordered-data.h
>>>> +++ b/fs/btrfs/ordered-data.h
>>>> @@ -163,11 +163,9 @@ int btrfs_finish_ordered_io(struct btrfs_ordered=
_extent *ordered_extent);
>>>>    void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry);
>>>>    void btrfs_remove_ordered_extent(struct btrfs_ordered_extent *entr=
y);
>>>>    void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *orde=
red,
>>>> -                                struct folio *folio, u64 file_offset=
, u64 len,
>>>> -                                bool uptodate);
>>>> +                                u64 file_offset, u64 len, bool uptod=
ate);
>>>>    void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
>>>> -                                   struct folio *folio, u64 file_off=
set,
>>>> -                                   u64 num_bytes, bool uptodate);
>>>> +                                   u64 file_offset, u64 num_bytes, b=
ool uptodate);
>>>>    bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
>>>>                                       struct btrfs_ordered_extent **c=
ached,
>>>>                                       u64 file_offset, u64 io_size);
>>>> --
>>>> 2.52.0
>>>>
>>>>
>>>
>>
>>


