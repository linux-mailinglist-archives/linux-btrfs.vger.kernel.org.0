Return-Path: <linux-btrfs+bounces-21660-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AeyI+msjmnYDgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21660-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 05:47:37 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BC5132E86
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 05:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB0A7305E556
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 04:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0592C2505AA;
	Fri, 13 Feb 2026 04:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="OSDDriPM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEA5BA3D
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Feb 2026 04:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770958049; cv=none; b=mp9R0/R7YTmzWLzctljF94DkAboy02IkXrS+edO8kqV0A+D2KCki16CJnfM9fYd43ZPbq0HL941GLQC9QcF5rceQ/RvqZlHLuHGGhVfvDnT+x58hICbKtx5HIBXtvYTdkgqXY3itbeK4fsvzgr9mtMguw9RkiTmA8fNRqrCn19M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770958049; c=relaxed/simple;
	bh=slWeiU9lMz0mkhCFbBIfl0Wh/IO4A9geOp3DsrpaTcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MsbDtb9WLcDUUBMojF+hIbDPKi7KPcQoL4BkOPRtcfa67EyTIwv9r1qkv1EEgICC0XMly0l5jg6z5597flb1CeR/R5ecibksU1oXsrs+GlCrFi7KAClYWMJ6lKncSFNCx9OpJH17BUWLk3NbEZolNeOsvDF3RDnzzwiwoeS1lbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=OSDDriPM; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1770958044; x=1771562844; i=quwenruo.btrfs@gmx.com;
	bh=L2QDpUk8tUZpJH2VZ97wZ9Mqpk7XVri055EzCKqhU8w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OSDDriPMBxx5cFZ42obv8lpWi4JLOtDWjxjIUThbH/Pd2Pht03HOE5sE/Ov+hd8v
	 wZ6WoCY2vwo7wTLxZ097arc9PZnyJLDocaSbZyPR7J7HHUiyIIMVWaIC6AH9A7etQ
	 VySar5jFamSg0SfFSsr7m0Hi9gc1NDvMxh2EThituW+d6in304Cxpy+hSSpIP7iw1
	 K8NJTG+b0DjW5oHOTp8YvZZ3nqLCASo4wpcJUh9LBEBlO1Wqgia00TAHlhMB7+0eR
	 L3CsOVAp3qcJkc7ZG3aprjypsJIXY+tEyEZ3e3RNP5TYPFIXasgRpT4V6Y22maDqp
	 5radzn+Ta1swppFA3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MoO24-1vSOd143BY-00mGt7; Fri, 13
 Feb 2026 05:47:24 +0100
Message-ID: <cdfc5693-9d6c-420f-b13d-b0e6495054c3@gmx.com>
Date: Fri, 13 Feb 2026 15:17:21 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove folio parameter from ordered io related
 functions
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cd0abcd6792c8a155af818bbe88d37d9957f4465.1770887628.git.wqu@suse.com>
 <CAL3q7H4y3reiYwXZPTXYyPqKOjxOP_SVHGPQKH7q3V=LmmBUmg@mail.gmail.com>
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
In-Reply-To: <CAL3q7H4y3reiYwXZPTXYyPqKOjxOP_SVHGPQKH7q3V=LmmBUmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l2i8O7MDXRg2vbDTUdlsdeJ7qTsc+Q4irdrhkpwGpHscioCySnu
 4VaHUE9XUCqtUBW+VNOoK8/JtV4G5P9KG0aRca/WrZro7tT32GFXgQUKxyaT5V7aFHQsO3U
 L6GaEbrPC9AkO+n4kjUy8DeRcXbpQKPeCQ+/++7JcIrU17fQzrCht8OxHBxS93QVdcOgyUz
 aqdnC1M3tzYe+YXXkme/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:etfCh6m7n7Y=;Ii436erhINV/o3Jp2wABF6pQcVY
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21660-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmx.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.com:mid,gmx.com:dkim]
X-Rspamd-Queue-Id: A6BC5132E86
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/13 02:57, Filipe Manana =E5=86=99=E9=81=93:
> On Thu, Feb 12, 2026 at 9:14=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Both functions btrfs_finish_ordered_extent() and
>> btrfs_mark_ordered_io_finished() are accepting an optional folio
>> parameter.
>>
>> That @folio is passed into can_finish_ordered_extent(), which later wil=
l
>> test and clear the ordered flag for the involved range.
>>
>> However I do not think there is any other call site that can clear
>> ordered flags of an page cache folio and can affect
>> can_finish_ordered_extent().
>>
>> There are limited *_clear_ordered() callers out of
>> can_finish_ordered_extent() function:
>>
>> - btrfs_migrate_folio()
>>    This is completely unrelated, it's just migrating the ordered flag t=
o
>>    the new folio.
>>
>> - btrfs_cleanup_ordered_extents()
>>    We manually clean the ordered flags of all involved folios, then cal=
l
>>    btrfs_mark_ordered_io_finished() without a @folio parameter.
>>    So it doesn't need and didn't pass a @folio parameter in the first
>>    place.
>>
>> - btrfs_writepage_fixup_worker()
>>    This function is going to be removed soon, and we should not hit tha=
t
>>    function anymore.
>=20
> I still hit that sporadically with fstests, (generic/475 and
> generic/648 at least).

It may help if you have saved the dmesg of failed runs and can share=20
that dmesg.

I just checked my failed dmesgs, but failed to get a good clue.

Thanks,
Qu

>=20
>>
>> - btrfs_invalidate_folio()
>>    This is the real call site we need to bother.
>=20
> bother -> bother with
>=20
> Otherwise it looks good.
>=20
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>=20
> Thanks.
>=20
>>
>>    If we already have a bio running, btrfs_finish_ordered_extent() in
>>    end_bbio_data_write() will be executed first, as
>>    btrfs_invalidate_folio() will wait for the writeback to finish.
>>
>>    Thus if there is a running bio, it will not see the range has
>>    ordered flags, and just skip to the next range.
>>
>>    If there is no bio running, meaning the ordered extent is created bu=
t
>>    the folio is not yet submitted.
>>
>>    In that case btrfs_invalidate_folio() will manually clear the folio
>>    ordered range, but then manually finish the ordered extent with
>>    btrfs_dec_test_ordered_pending() without bothering the folio ordered
>>    flags.
>>
>>    Meaning if the OE range with folio ordered flags will be finished
>>    manually without the need to call can_finish_ordered_extent().
>>
>> This means all can_finish_ordered_extent() call sites should get a rang=
e
>> that has folio ordered flag set, thus the old "return false" branch
>> should never be triggered.
>>
>> Now we can:
>>
>> - Remove the @folio parameter from involved functions
>>    * btrfs_mark_ordered_io_finished()
>>    * btrfs_finish_ordered_extent()
>>
>>    For call sites passing a @folio into those functions, let them
>>    manually clear the ordered flag of involved folios.
>>
>> - Move btrfs_finish_ordered_extent() out of the loop in
>>    end_bbio_data_write()
>>
>>    We only need to call btrfs_finish_ordered_extent() once per bbio,
>>    not per folio.
>>
>> - Add an ASSERT() to make sure all folio ranges have ordered flags
>>    It's only for end_bbio_data_write().
>>
>>    And we already have enough safe nets to catch over-accounting of ord=
ered
>>    extents.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>
>> But I still appreciate any extra eyes on the call site analyze.
>> ---
>>   fs/btrfs/compression.c  |  2 +-
>>   fs/btrfs/direct-io.c    |  9 ++++-----
>>   fs/btrfs/extent_io.c    | 23 ++++++++++++++---------
>>   fs/btrfs/inode.c        |  6 ++++--
>>   fs/btrfs/ordered-data.c | 29 +++++------------------------
>>   fs/btrfs/ordered-data.h |  6 ++----
>>   6 files changed, 30 insertions(+), 45 deletions(-)
>>
>> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
>> index 1e7174ad32e2..1938d33ab57a 100644
>> --- a/fs/btrfs/compression.c
>> +++ b/fs/btrfs/compression.c
>> @@ -292,7 +292,7 @@ static void end_bbio_compressed_write(struct btrfs_=
bio *bbio)
>>          struct compressed_bio *cb =3D to_compressed_bio(bbio);
>>          struct folio_iter fi;
>>
>> -       btrfs_finish_ordered_extent(cb->bbio.ordered, NULL, cb->start, =
cb->len,
>> +       btrfs_finish_ordered_extent(cb->bbio.ordered, cb->start, cb->le=
n,
>>                                      cb->bbio.bio.bi_status =3D=3D BLK_=
STS_OK);
>>
>>          if (cb->writeback)
>> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
>> index 9a63200d7a53..837306254f73 100644
>> --- a/fs/btrfs/direct-io.c
>> +++ b/fs/btrfs/direct-io.c
>> @@ -625,7 +625,7 @@ static int btrfs_dio_iomap_end(struct inode *inode,=
 loff_t pos, loff_t length,
>>                  pos +=3D submitted;
>>                  length -=3D submitted;
>>                  if (write)
>> -                       btrfs_finish_ordered_extent(dio_data->ordered, =
NULL,
>> +                       btrfs_finish_ordered_extent(dio_data->ordered,
>>                                                      pos, length, false=
);
>>                  else
>>                          btrfs_unlock_dio_extent(&BTRFS_I(inode)->io_tr=
ee, pos,
>> @@ -657,9 +657,8 @@ static void btrfs_dio_end_io(struct btrfs_bio *bbio=
)
>>          }
>>
>>          if (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE) {
>> -               btrfs_finish_ordered_extent(bbio->ordered, NULL,
>> -                                           dip->file_offset, dip->byte=
s,
>> -                                           !bio->bi_status);
>> +               btrfs_finish_ordered_extent(bbio->ordered, dip->file_of=
fset,
>> +                                           dip->bytes, !bio->bi_status=
);
>>          } else {
>>                  btrfs_unlock_dio_extent(&inode->io_tree, dip->file_off=
set,
>>                                          dip->file_offset + dip->bytes =
- 1, NULL);
>> @@ -735,7 +734,7 @@ static void btrfs_dio_submit_io(const struct iomap_=
iter *iter, struct bio *bio,
>>
>>                  ret =3D btrfs_extract_ordered_extent(bbio, dio_data->o=
rdered);
>>                  if (ret) {
>> -                       btrfs_finish_ordered_extent(dio_data->ordered, =
NULL,
>> +                       btrfs_finish_ordered_extent(dio_data->ordered,
>>                                                      file_offset, dip->=
bytes,
>>                                                      !ret);
>>                          bio->bi_status =3D errno_to_blk_status(ret);
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 11faecb66109..8914eda1c28f 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -521,6 +521,7 @@ static void end_bbio_data_write(struct btrfs_bio *b=
bio)
>>          int error =3D blk_status_to_errno(bio->bi_status);
>>          struct folio_iter fi;
>>          const u32 sectorsize =3D fs_info->sectorsize;
>> +       u32 bio_size =3D 0;
>>
>>          ASSERT(!bio_flagged(bio, BIO_CLONED));
>>          bio_for_each_folio_all(fi, bio) {
>> @@ -528,6 +529,7 @@ static void end_bbio_data_write(struct btrfs_bio *b=
bio)
>>                  u64 start =3D folio_pos(folio) + fi.offset;
>>                  u32 len =3D fi.length;
>>
>> +               bio_size +=3D len;
>>                  /* Our read/write should always be sector aligned. */
>>                  if (!IS_ALIGNED(fi.offset, sectorsize))
>>                          btrfs_err(fs_info,
>> @@ -538,13 +540,15 @@ static void end_bbio_data_write(struct btrfs_bio =
*bbio)
>>                  "incomplete page write with offset %zu and length %zu"=
,
>>                                     fi.offset, fi.length);
>>
>> -               btrfs_finish_ordered_extent(bbio->ordered, folio, start=
, len,
>> -                                           !error);
>>                  if (error)
>>                          mapping_set_error(folio->mapping, error);
>> +
>> +               ASSERT(btrfs_folio_test_ordered(fs_info, folio, start, =
len));
>> +               btrfs_folio_clear_ordered(fs_info, folio, start, len);
>>                  btrfs_folio_clear_writeback(fs_info, folio, start, len=
);
>>          }
>>
>> +       btrfs_finish_ordered_extent(bbio->ordered, bbio->file_offset, b=
io_size, !error);
>>          bio_put(bio);
>>   }
>>
>> @@ -1577,7 +1581,8 @@ static noinline_for_stack int writepage_delalloc(=
struct btrfs_inode *inode,
>>                          u64 start =3D page_start + (start_bit << fs_in=
fo->sectorsize_bits);
>>                          u32 len =3D (end_bit - start_bit) << fs_info->=
sectorsize_bits;
>>
>> -                       btrfs_mark_ordered_io_finished(inode, folio, st=
art, len, false);
>> +                       btrfs_folio_clear_ordered(fs_info, folio, start=
, len);
>> +                       btrfs_mark_ordered_io_finished(inode, start, le=
n, false);
>>                  }
>>                  return ret;
>>          }
>> @@ -1653,6 +1658,7 @@ static int submit_one_sector(struct btrfs_inode *=
inode,
>>                   * ordered extent.
>>                   */
>>                  btrfs_folio_clear_dirty(fs_info, folio, filepos, secto=
rsize);
>> +               btrfs_folio_clear_ordered(fs_info, folio, filepos, sect=
orsize);
>>                  btrfs_folio_set_writeback(fs_info, folio, filepos, sec=
torsize);
>>                  btrfs_folio_clear_writeback(fs_info, folio, filepos, s=
ectorsize);
>>
>> @@ -1660,8 +1666,8 @@ static int submit_one_sector(struct btrfs_inode *=
inode,
>>                   * Since there is no bio submitted to finish the order=
ed
>>                   * extent, we have to manually finish this sector.
>>                   */
>> -               btrfs_mark_ordered_io_finished(inode, folio, filepos,
>> -                                              fs_info->sectorsize, fal=
se);
>> +               btrfs_mark_ordered_io_finished(inode, filepos, fs_info-=
>sectorsize,
>> +                                              false);
>>                  return PTR_ERR(em);
>>          }
>>
>> @@ -1773,8 +1779,8 @@ static noinline_for_stack int extent_writepage_io=
(struct btrfs_inode *inode,
>>                          spin_unlock(&inode->ordered_tree_lock);
>>                          btrfs_put_ordered_extent(ordered);
>>
>> -                       btrfs_mark_ordered_io_finished(inode, folio, cu=
r,
>> -                                                      fs_info->sectors=
ize, true);
>> +                       btrfs_folio_clear_ordered(fs_info, folio, cur, =
fs_info->sectorsize);
>> +                       btrfs_mark_ordered_io_finished(inode, cur, fs_i=
nfo->sectorsize, true);
>>                          /*
>>                           * This range is beyond i_size, thus we don't =
need to
>>                           * bother writing back.
>> @@ -2649,8 +2655,7 @@ void extent_write_locked_range(struct inode *inod=
e, const struct folio *locked_f
>>                  if (IS_ERR(folio)) {
>>                          cur_end =3D min(round_down(cur, PAGE_SIZE) + P=
AGE_SIZE - 1, end);
>>                          cur_len =3D cur_end + 1 - cur;
>> -                       btrfs_mark_ordered_io_finished(BTRFS_I(inode), =
NULL,
>> -                                                      cur, cur_len, fa=
lse);
>> +                       btrfs_mark_ordered_io_finished(BTRFS_I(inode), =
cur, cur_len, false);
>>                          mapping_set_error(mapping, PTR_ERR(folio));
>>                          cur =3D cur_end;
>>                          continue;
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 3af087c81724..b6b386e06529 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -424,7 +424,7 @@ static inline void btrfs_cleanup_ordered_extents(st=
ruct btrfs_inode *inode,
>>                  folio_put(folio);
>>          }
>>
>> -       return btrfs_mark_ordered_io_finished(inode, NULL, offset, byte=
s, false);
>> +       return btrfs_mark_ordered_io_finished(inode, offset, bytes, fal=
se);
>>   }
>>
>>   static int btrfs_dirty_inode(struct btrfs_inode *inode);
>> @@ -2945,7 +2945,9 @@ static void btrfs_writepage_fixup_worker(struct b=
trfs_work *work)
>>                   * to reflect the errors and clean the page.
>>                   */
>>                  mapping_set_error(folio->mapping, ret);
>> -               btrfs_mark_ordered_io_finished(inode, folio, page_start=
,
>> +               btrfs_folio_clear_ordered(fs_info, folio, page_start,
>> +                                         folio_size(folio));
>> +               btrfs_mark_ordered_io_finished(inode, page_start,
>>                                                 folio_size(folio), !ret=
);
>>                  folio_clear_dirty_for_io(folio);
>>          }
>> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
>> index e47c3a3a619a..8405d07b49cd 100644
>> --- a/fs/btrfs/ordered-data.c
>> +++ b/fs/btrfs/ordered-data.c
>> @@ -348,30 +348,13 @@ static void finish_ordered_fn(struct btrfs_work *=
work)
>>   }
>>
>>   static bool can_finish_ordered_extent(struct btrfs_ordered_extent *or=
dered,
>> -                                     struct folio *folio, u64 file_off=
set,
>> -                                     u64 len, bool uptodate)
>> +                                     u64 file_offset, u64 len, bool up=
todate)
>>   {
>>          struct btrfs_inode *inode =3D ordered->inode;
>>          struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>>
>>          lockdep_assert_held(&inode->ordered_tree_lock);
>>
>> -       if (folio) {
>> -               ASSERT(folio->mapping);
>> -               ASSERT(folio_pos(folio) <=3D file_offset);
>> -               ASSERT(file_offset + len <=3D folio_next_pos(folio));
>> -
>> -               /*
>> -                * Ordered flag indicates whether we still have
>> -                * pending io unfinished for the ordered extent.
>> -                *
>> -                * If it's not set, we need to skip to next range.
>> -                */
>> -               if (!btrfs_folio_test_ordered(fs_info, folio, file_offs=
et, len))
>> -                       return false;
>> -               btrfs_folio_clear_ordered(fs_info, folio, file_offset, =
len);
>> -       }
>> -
>>          /* Now we're fine to update the accounting. */
>>          if (WARN_ON_ONCE(len > ordered->bytes_left)) {
>>                  btrfs_crit(fs_info,
>> @@ -413,8 +396,7 @@ static void btrfs_queue_ordered_fn(struct btrfs_ord=
ered_extent *ordered)
>>   }
>>
>>   void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered=
,
>> -                                struct folio *folio, u64 file_offset, =
u64 len,
>> -                                bool uptodate)
>> +                                u64 file_offset, u64 len, bool uptodat=
e)
>>   {
>>          struct btrfs_inode *inode =3D ordered->inode;
>>          bool ret;
>> @@ -422,7 +404,7 @@ void btrfs_finish_ordered_extent(struct btrfs_order=
ed_extent *ordered,
>>          trace_btrfs_finish_ordered_extent(inode, file_offset, len, upt=
odate);
>>
>>          spin_lock(&inode->ordered_tree_lock);
>> -       ret =3D can_finish_ordered_extent(ordered, folio, file_offset, =
len,
>> +       ret =3D can_finish_ordered_extent(ordered, file_offset, len,
>>                                          uptodate);
>>          spin_unlock(&inode->ordered_tree_lock);
>>
>> @@ -475,8 +457,7 @@ void btrfs_finish_ordered_extent(struct btrfs_order=
ed_extent *ordered,
>>    * extent(s) covering it.
>>    */
>>   void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
>> -                                   struct folio *folio, u64 file_offse=
t,
>> -                                   u64 num_bytes, bool uptodate)
>> +                                   u64 file_offset, u64 num_bytes, boo=
l uptodate)
>>   {
>>          struct rb_node *node;
>>          struct btrfs_ordered_extent *entry =3D NULL;
>> @@ -536,7 +517,7 @@ void btrfs_mark_ordered_io_finished(struct btrfs_in=
ode *inode,
>>                  len =3D this_end - cur;
>>                  ASSERT(len < U32_MAX);
>>
>> -               if (can_finish_ordered_extent(entry, folio, cur, len, u=
ptodate)) {
>> +               if (can_finish_ordered_extent(entry, cur, len, uptodate=
)) {
>>                          spin_unlock(&inode->ordered_tree_lock);
>>                          btrfs_queue_ordered_fn(entry);
>>                          spin_lock(&inode->ordered_tree_lock);
>> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
>> index 86e69de9e9ff..cd74c5ecfd67 100644
>> --- a/fs/btrfs/ordered-data.h
>> +++ b/fs/btrfs/ordered-data.h
>> @@ -163,11 +163,9 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_e=
xtent *ordered_extent);
>>   void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry);
>>   void btrfs_remove_ordered_extent(struct btrfs_ordered_extent *entry);
>>   void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered=
,
>> -                                struct folio *folio, u64 file_offset, =
u64 len,
>> -                                bool uptodate);
>> +                                u64 file_offset, u64 len, bool uptodat=
e);
>>   void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
>> -                                   struct folio *folio, u64 file_offse=
t,
>> -                                   u64 num_bytes, bool uptodate);
>> +                                   u64 file_offset, u64 num_bytes, boo=
l uptodate);
>>   bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
>>                                      struct btrfs_ordered_extent **cach=
ed,
>>                                      u64 file_offset, u64 io_size);
>> --
>> 2.52.0
>>
>>
>=20


