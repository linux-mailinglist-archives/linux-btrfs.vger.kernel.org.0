Return-Path: <linux-btrfs+bounces-17299-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0A1BAE53B
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 20:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31806323DE6
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 18:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E868226A08A;
	Tue, 30 Sep 2025 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="h3Hy5rkf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C939033EC;
	Tue, 30 Sep 2025 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759257581; cv=none; b=mXKSvyGDfRtzYaDbkZBK/qLMsd9pLxgUX2zKt80c6icX9UJkqDHsT/5txDY1UYRZCFz2K9/hKdyF175UufbyxNgH+6k0+ut8jPd2BHYVOK0x9QFKTUApwLBqhysEVjgWC67ZZnw9JNBZj3HueGQyvg6J0c27lx9PCcoI88YhWxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759257581; c=relaxed/simple;
	bh=NHhbW6XOibNDd+L6PGZjsEt/nr22HafaXJexwmknz/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I5WYITY3yHYZ8F3SzEP4twJSuysP5pdr7kJ4fkmiX8IJuJ8/zNN3Jkj1M2vGU4pgGG6FHp8B6vZDRoW37M0C8M4cGAC8vn3wiY9jsvmMeTsZSpYmJOU2I9vZbGLIJUkzNVc9aE5eBl1mMTc8c8qG7uJ9LdnQ64NqQ9NhwL8z3EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=h3Hy5rkf; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4cbn0P5GP0z9y8h;
	Tue, 30 Sep 2025 20:39:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1759257573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5QK+htnxkzn4WpcEK+6lK/We5lMiyB7Bvom3iaXJBk=;
	b=h3Hy5rkfd/oj2rTQhMEM60e3IzeU/9Dh/jCjGT6cXUXR0pDGlvfHXTp8XKntKFTi5Cyv4v
	6IruskTg/JEnr7rAevNQn/02oxfzSlLnxyZMKQg2anPngz+EwHZOYgAPHoibirKe9rScVv
	Bs8b99cK/mH0J9IYTAVnZPYpllTJa3EXBB5s//GkiRCn3Z81iWVCX5W3wUtmk2KaqNjX3T
	k2HLdO8yzhsCgamKgfwa+TRLPNmnv8IQdkMzuQdA8d71IHoO/YBLy9KBJs/xSftHe4ald+
	LzDhK/KEH/Z5VWo+JjkD/7FhEnV09p0gEx8MfnxNe8vfmtSW3qDCOrouF2dtlA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::2 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org,  clm@fb.com,  dsterba@suse.com,
  fdmanana@suse.com,  wqu@suse.com,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: btrfs: prevent a double kfree on delayed-ref
In-Reply-To: <CAL3q7H66AOc_hbXX_PN-DGP5fT36NnxE7p4j2LqjPXyRaOu=iA@mail.gmail.com>
	(Filipe Manana's message of "Tue, 30 Sep 2025 17:07:47 +0100")
References: <20250930130452.297576-1-mssola@mssola.com>
	<CAL3q7H66AOc_hbXX_PN-DGP5fT36NnxE7p4j2LqjPXyRaOu=iA@mail.gmail.com>
Date: Tue, 30 Sep 2025 20:39:28 +0200
Message-ID: <87bjmraiov.fsf@>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Queue-Id: 4cbn0P5GP0z9y8h

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Filipe Manana @ 2025-09-30 17:07 +01:

> On Tue, Sep 30, 2025 at 2:05=E2=80=AFPM Miquel Sabat=C3=A9 Sol=C3=A0 <mss=
ola@mssola.com> wrote:
>>
>> In the previous code it was possible to incur into a double kfree()
>> scenario when calling 'add_delayed_ref_head'. This could happen if the
>> record was reported to already exist in the
>> 'btrfs_qgroup_trace_extent_nolock' call, but then there was an error
>> later on 'add_delayed_ref_head'. In this case, since
>> 'add_delayed_ref_head' returned an error, the caller went to free the
>> record. Since 'add_delayed_ref_head' couldn't set this kfree'd pointer
>> to NULL, then kfree() would have acted on a non-NULL 'record' object
>> which was pointing to memory already freed by the callee.
>>
>> The problem comes from the fact that the responsibility to kfree the
>> object is on both the caller and the callee at the same time. Hence, the
>> fix for this is to shift the ownership of the 'qrecord' object out of
>> the 'add_delayed_ref_head'. That is, we will never attempt to kfree()
>> the given object inside of this function, and will expect the caller to
>> act on the 'qrecord' object on its own. The only exception where the
>> 'qrecord' object cannot be kfree'd is if it was inserted into the
>> tracing logic, for which we already have the 'qrecord_inserted_ret'
>> boolean to account for this. Hence, the caller has to kfree the object
>> only if 'add_delayed_ref_head' reports not to have inserted it on the
>> tracing logic.
>>
>> As a side-effect of the above, we must guarantee that
>> 'qrecord_inserted_ret' is properly initialized at the start of the
>> function, not at the end, and then set when an actual insert
>> happens. This way we avoid 'qrecord_inserted_ret' having an invalid
>> value on an early exit.
>>
>> The documentation from the 'add_delayed_ref_head' has also been updated
>> to reflect on the exact ownership of the 'qrecord' object.
>>
>> Fixes: 6ef8fbce0104 ("btrfs: fix missing error handling when adding dela=
yed ref with qgroups enabled")
>> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>
>> ---
>>  fs/btrfs/delayed-ref.c | 39 +++++++++++++++++++++++++++++++--------
>>  1 file changed, 31 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
>> index 481802efaa14..bc61e0eacc69 100644
>> --- a/fs/btrfs/delayed-ref.c
>> +++ b/fs/btrfs/delayed-ref.c
>> @@ -798,10 +798,14 @@ static void init_delayed_ref_head(struct btrfs_del=
ayed_ref_head *head_ref,
>>  }
>>
>>  /*
>> - * helper function to actually insert a head node into the rbtree.
>> + * Helper function to actually insert a head node into the rbtree.
>
> Since you are updating this line just to capitalize the first word,
> you might as well replace rbtree with xarray as we don't use rbtree
> anymore.
>
>>   * this does all the dirty work in terms of maintaining the correct
>>   * overall modification count.
>>   *
>> + * The caller is responsible for calling kfree() on @qrecord. More spec=
ifically,
>> + * if this function reports that it did not insert it as noted in
>> + * @qrecord_inserted_ret, then it's safe to call kfree() on it.
>> + *
>>   * Returns an error pointer in case of an error.
>>   */
>>  static noinline struct btrfs_delayed_ref_head *
>> @@ -814,7 +818,14 @@ add_delayed_ref_head(struct btrfs_trans_handle *tra=
ns,
>>         struct btrfs_delayed_ref_head *existing;
>>         struct btrfs_delayed_ref_root *delayed_refs;
>>         const unsigned long index =3D (head_ref->bytenr >> fs_info->sect=
orsize_bits);
>> -       bool qrecord_inserted =3D false;
>> +
>> +       /*
>> +        * If 'qrecord_inserted_ret' is provided, then the first thing w=
e need
>> +        * to do is to initialize it to false just in case we have an ex=
it
>> +        * before trying to insert the record.
>> +        */
>> +       if (qrecord_inserted_ret)
>> +               *qrecord_inserted_ret =3D false;
>>
>>         delayed_refs =3D &trans->transaction->delayed_refs;
>>         lockdep_assert_held(&delayed_refs->lock);
>> @@ -833,6 +844,12 @@ add_delayed_ref_head(struct btrfs_trans_handle *tra=
ns,
>>
>>         /* Record qgroup extent info if provided */
>>         if (qrecord) {
>> +               /*
>> +                * Setting 'qrecord' but not 'qrecord_inserted_ret' will=
 likely
>> +                * result in a memory leakage.
>> +                */
>> +               WARN_ON(!qrecord_inserted_ret);
>
> For this sort of mandatory stuff, we use assertions, not warnings:
>
> ASSERT(qrecord_insert_ret !=3D NULL);
>
>
>> +
>>                 int ret;
>>
>>                 ret =3D btrfs_qgroup_trace_extent_nolock(fs_info, delaye=
d_refs, qrecord,
>> @@ -840,12 +857,10 @@ add_delayed_ref_head(struct btrfs_trans_handle *tr=
ans,
>>                 if (ret) {
>>                         /* Clean up if insertion fails or item exists. */
>>                         xa_release(&delayed_refs->dirty_extents, index);
>> -                       /* Caller responsible for freeing qrecord on err=
or. */
>>                         if (ret < 0)
>>                                 return ERR_PTR(ret);
>> -                       kfree(qrecord);
>> -               } else {
>> -                       qrecord_inserted =3D true;
>> +               } else if (qrecord_inserted_ret) {
>> +                       *qrecord_inserted_ret =3D true;
>>                 }
>>         }
>>
>> @@ -888,8 +903,6 @@ add_delayed_ref_head(struct btrfs_trans_handle *tran=
s,
>>                 delayed_refs->num_heads++;
>>                 delayed_refs->num_heads_ready++;
>>         }
>> -       if (qrecord_inserted_ret)
>> -               *qrecord_inserted_ret =3D qrecord_inserted;
>>
>>         return head_ref;
>>  }
>> @@ -1049,6 +1062,14 @@ static int add_delayed_ref(struct btrfs_trans_han=
dle *trans,
>>                 xa_release(&delayed_refs->head_refs, index);
>>                 spin_unlock(&delayed_refs->lock);
>>                 ret =3D PTR_ERR(new_head_ref);
>> +
>> +               /*
>> +                * It's only safe to call kfree() on 'qrecord' if
>> +                * 'add_delayed_ref_head' has _not_ inserted it for
>
> The notation we use for function names is  function_name(), not 'function=
_name'.

I've included all your comments into a v2 patch set. I'll wait a bit
before sending it in case I get more comments.

>
> Otherwise it looks good, thanks.
>

Thanks to you for the review!

>> +                * tracing. Otherwise we need to handle this here.
>> +                */
>> +               if (!qrecord_reserved || qrecord_inserted)
>> +                       goto free_head_ref;
>>                 goto free_record;
>>         }
>>         head_ref =3D new_head_ref;
>> @@ -1071,6 +1092,8 @@ static int add_delayed_ref(struct btrfs_trans_hand=
le *trans,
>>
>>         if (qrecord_inserted)
>>                 return btrfs_qgroup_trace_extent_post(trans, record, gen=
eric_ref->bytenr);
>> +
>> +       kfree(record);
>>         return 0;
>>
>>  free_record:
>> --
>> 2.51.0
>>
>>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmjcI+AbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZTn6EACjnrLB35GpOMa+hfXcpoo8OLq0pLSkKnXZH2jDBl5F5P2Tqo7uFIRJeusv
n2NqdgvBEC7dXiAHiifyK+8I5OKLZVmwE3GKSp5mbvTLm29pLzjNdUIYnotXmeiI
hTMbFd8Bz/elbVL0yVFg+hwm7Wgiac7RxHgz31ry+NKrTX3g08YU8zMaaCvKFhkN
y15xzCa0TKsIBAR2XcQ9zNMCCD1t0HpVxxJYrhfg5rwTQQsj3ieGP5iw/5D4EQi/
38mlAemAvGSP3gntKJ80tyhov/6mdqa5qmFAlQDh8g/R+qABRT4uKpPObXirDLjX
0zHRT3dv8f6aVus2uCt6mme0UlxCxJYcbmrrn8NU09byHd7Yo9CNXRQWWJgy+3t9
52fL2dmwGGmQWp7gs0SuUCGXzSZeC6w3koX6YwvpHs51uUZwMjLYdpv3qVNOXi8f
6JizIquPoa+ih87Yld8WSnnoBfutwEZnEzJYGUCFIirUbF4LDpV6KRC+aiuRcFvq
suRaP6GeFjKLYr3QfhO3fj1ansufDUVrgezpMhbzwfGwFQuSnrPntPHW10veImMx
lLtCXiFIrGnaBQgmrUqxBPvdY7xXZHvDaPZpV9uzjbfdEXLAG980RqjZqHNMOfmw
TxmSciPN9wsFGQ4TZl3hUUPjJxAJ7a6ozWdnUL9GVrL18xoFoA==
=2ckg
-----END PGP SIGNATURE-----
--=-=-=--

