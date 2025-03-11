Return-Path: <linux-btrfs+bounces-12174-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8797A5B6FF
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 03:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726293AF58E
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 02:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CA41E7C38;
	Tue, 11 Mar 2025 02:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpLxby0X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFF11DE2DF
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 02:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741661807; cv=none; b=EpI9p0pQvSDBN3OvHZjd8SLZxVHERVKWvBthkq3EgJxuxZ5kDpOpk9riMZQzbV7Ix/QpTV1ToZKKQ53ZSme5SEQJOMMbel8la8UY/zHFd3/ZknwAaSkMvzvU45tLb4Vs4i9oqAOj4pHziWA13V745AjW5terWl3pYwyJne2mqvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741661807; c=relaxed/simple;
	bh=2Wofpx/10ex4L4V/6EIFs/gHoJPyBM0q5jwiIt09Uy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLIOKA+rmoPyXZbV437ZOj5Rr+TKAvnAIrxpqUtTkKrYKoU9Tdfus8Gof9DUXeuTtmcNeF6pKDYBxuQDmLe2JVyADXTzX+pLFw9Y/SO8fr9n9mnPRvFzK34oxG8FeJjRfYwVCPXhKxKJKCbKQDb7sz/p91Sbquf6ds1M8VeW99Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpLxby0X; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso4252719f8f.2
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 19:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741661804; x=1742266604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxLyYD8tHoBlGqJ3Bsy9VDqVuGKv2UDKRqi/9Djg0qQ=;
        b=hpLxby0X6hf1YLlQGZQFtlm8p9b4KcqyKPWw7ty0rjZVCOv1zOZZiRyUwfsFOwW6e3
         clfkSAOasGF+r4m7G25Daxbt7br5XPQg3xYeyYXeAMaljTEGyk9K3a3iyhKunTRcXVYB
         WN9+lmMzj+pM5gon0w2/HoLDm9SqNXIjSdKEU5cL4qzz8KogZRD3PXo4IKPxxqdcWDcS
         Jm4Qb5o70l1Sv2Cm1AFmkXU3OjQlVJk9OayVpqrv/kiSWThgZ6JZqbz0MoVAyTJY2C+X
         BuhRDegnQI8tZra1scABzA0VuNsHWu0Zs7OLM8GHsLG7BJb5DEEoC0j1BzrAD0KTMYn6
         JovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741661804; x=1742266604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxLyYD8tHoBlGqJ3Bsy9VDqVuGKv2UDKRqi/9Djg0qQ=;
        b=FjSK2faEX+/jxZzDYzzUtjHMZXcRaoA14f3caUwL+yOCXWn1haD6soKg0UhaCc4/fi
         1spnJdAXuTezsrmX6o+U2rei3HnmQ3WT2KUImYzxMZdOm3xrUc6l/6O+EP0KtWraWXbj
         Tc0zmneijfA9/Y/2Mqg3WsuvXvRoorTC2yLuFtAi9qHyw/ofXPckycgkmVyAQWFx7WUv
         jlC1J6ATlKXSf/10nwO/Zo4fK07vexL8QwEUsQY24VT9AbbkDAPMnIoGDxRWRyRevAdG
         499EguzH4u1gIpAaZeT8mgBiyYG/nuO6+703bUaZogR8/6hK/BzkQ2gSDNy7aooOWIji
         ZuSg==
X-Gm-Message-State: AOJu0YzK74b01TmptZwVQm7EjK0Ngq2xN4CUlfDqpwpmVOuDFJbqqxh8
	MHnCPd24v7IBxJKiEe47OkIIyYoLGb0daxQNqzxJ28QOS5qCryKYBg0/nbEM8KIyreyeQ/E0jcT
	+nuulmkiMtLfEaxtK3GPIchhzGDk=
X-Gm-Gg: ASbGnctG35HMjLz/uz4kU6gOUo60SVP98ei6XH00mclYInDkRFmpV+NfUcQ2fRQFbRO
	FXDspTYvxnqrXAhpc9vdrw9THRZmEDNSJurgZke2UKQNpITYvSCtYXc33MLA0aXOLj1MrtFQauo
	fi8TAvbU1n/EL10MHoa0tzBQ==
X-Google-Smtp-Source: AGHT+IGYxwpWhbU1SQbbQEiNlFO0pzUazXUdKJQyt8P2YXCozGTUocFctmQ/qFtuaYf1JZL7gZhTEnBRopDWflbDg2E=
X-Received: by 2002:a05:6000:4103:b0:391:39fb:a4d4 with SMTP id
 ffacd0b85a97d-39139fba505mr7356228f8f.7.1741661804095; Mon, 10 Mar 2025
 19:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB_b4sBhDe3tscz=duVyhc9hNE+gu=B8CrgLO152uMyanR8BEA@mail.gmail.com>
 <7addae55-e0a4-40c4-b4b5-279d4eb91fd4@wdc.com> <CAB_b4sAba_AtdQfM+23LhnL_F038wuE677DZx-1T_Q1TH6rtMg@mail.gmail.com>
In-Reply-To: <CAB_b4sAba_AtdQfM+23LhnL_F038wuE677DZx-1T_Q1TH6rtMg@mail.gmail.com>
From: =?UTF-8?B?6KW/5pyo6YeO576w5Z+6?= <yanqiyu01@gmail.com>
Date: Tue, 11 Mar 2025 10:56:32 +0800
X-Gm-Features: AQ5f1Jot5f9Kx4fb6rFDvpLeXSxSvdDvbsjeO3iU_kzhtd1p_P4PNRzDZwq1n-0
Message-ID: <CAB_b4sCNenuqK79ce7ijSDQzXgLAq8jEe98z4P6_UqAz-OvhEQ@mail.gmail.com>
Subject: Re: [bug report] NULL pointer dereference after a balance error on
 zoned device
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Naohiro Aota <Naohiro.Aota@wdc.com>, 
	WenRuo Qu <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I did a quick glance at the code, it seems that the nullptr is related to:

free-space-cache.c:
static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_gro=
up,
                    u64 bytenr, u64 size, bool used)
{
    struct btrfs_space_info *sinfo =3D block_group->space_info;
....
    if (!initial)
        bg_reclaim_threshold =3D READ_ONCE(sinfo->bg_reclaim_threshold);

when sinfo =3D nullptr, so I traced where block_group->space_info is
supposed to be set, which turns out to be

block-group.c:
struct btrfs_block_group *btrfs_make_block_group(struct
btrfs_trans_handle *trans,
                         u64 type,
                         u64 chunk_offset, u64 size)
    struct btrfs_fs_info *fs_info =3D trans->fs_info;
    struct btrfs_block_group *cache;
...
    ret =3D btrfs_add_new_free_space(cache, chunk_offset, chunk_offset +
size, NULL);
    btrfs_free_excluded_extents(cache);
    if (ret) {
        btrfs_put_block_group(cache);
        return ERR_PTR(ret);
    }
...
    cache->space_info =3D btrfs_find_space_info(fs_info, cache->flags);
    ASSERT(cache->space_info);
...

btrfs_add_new_free_space leads to the site of null deref and
btrfs_find_space_info is the function that creates space_info struct.
It seems that the code path always wants to use space_info before it
is initialized.

Best,
Qiyu

=E8=A5=BF=E6=9C=A8=E9=87=8E=E7=BE=B0=E5=9F=BA <yanqiyu01@gmail.com> =E4=BA=
=8E2025=E5=B9=B43=E6=9C=8811=E6=97=A5=E5=91=A8=E4=BA=8C 09:34=E5=86=99=E9=
=81=93=EF=BC=9A
>
> Johannes Thumshirn <Johannes.Thumshirn@wdc.com> =E4=BA=8E2025=E5=B9=B43=
=E6=9C=8810=E6=97=A5=E5=91=A8=E4=B8=80 23:47=E5=86=99=E9=81=93=EF=BC=9A
> > OK I need some help reproducing this bug report. My current reproducer =
is:
>
> The disk was setup to receive incremental snapshots from different
> sources, and the second disk was added recently. The first disk has
> encountered serveral power loss incidents before, so the zone pointer
> issue might be the consequences for that?
>
> Another special observation I want to mention is following:
> $ sudo btrfs fi us /media/cold
> Overall:
>     Device size:                  36.38TiB
>     Device allocated:             11.20TiB
>     Device unallocated:           25.18TiB
>     Device missing:                  0.00B
>     Device slack:                    0.00B
>     Device zone unusable:        429.67GiB
>     Device zone size:            256.00MiB
>     Used:                         10.63TiB
>     Free (estimated):             25.45TiB      (min: 12.86TiB)
>     Free (statfs, df):            25.45TiB
>     Data ratio:                       1.00
>     Metadata ratio:                   2.00
>     Global reserve:              512.00MiB      (used: 32.00KiB)
>     Multiple profiles:                  no
>
> Data,single: Size:10.84TiB, Used:10.58TiB (97.54%)
>    /dev/sdc        9.42TiB
>    /dev/sdg        1.42TiB
>
> Metadata,DUP: Size:183.25GiB, Used:25.54GiB (13.93%)
>    /dev/sdc        6.00GiB
>    /dev/sdg      360.50GiB
>
> System,DUP: Size:256.00MiB, Used:4.95MiB (1.93%)
>    /dev/sdg      512.00MiB
>
> Unallocated:
>    /dev/sdc        8.76TiB
>    /dev/sdg       16.41TiB
>
> I am having very low metadata allocator effiency, and
> $ cat /sys/fs/btrfs/23b68b38-a625-4d90-a56b-5d07d93c8ffb/allocation/metad=
ata/bytes_zone_unusable
> 151356981248
>
> 151356981248/1024^3 \approx 140 GB >> 25.54GiB, I am expecting that
> the reclaim process should have already kicked in to compact the
> metadata but it has not (due to fragmentation of metadata?).
>
> And the numbers I got is after deleting some unneeded snapshots and
> after several balances with musage=3D10, before (when I encountered the
> null deref issue) the number of bytes_zone_unusable would be more
> extreme.
>
> >
> > As far as I see this is a stock Fedora 41 kernel, is it?
>
> Yes it is.

