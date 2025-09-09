Return-Path: <linux-btrfs+bounces-16743-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DB9B4A568
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Sep 2025 10:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D913B4E2420
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Sep 2025 08:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6BF2517AF;
	Tue,  9 Sep 2025 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBRhY1by"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21BE22157F
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Sep 2025 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757406938; cv=none; b=eSEVsXju1u6DomwLe+L60rg/tgbVxczbJQsaGYW8KQqXC9SUZm3cW6tNXPcgwP3Kx/nan01p0tfgs8jBRScNyI2/1gUVrEqcS2t4H+Q8yOp6BIJ0wL3lzok9vnuniIrXTSdJXT9nc92iVB+UDqGPruBcXqtjmxHd2EVUUsHjffM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757406938; c=relaxed/simple;
	bh=UPd/Uw4aKi/KhkjigPjQ9dbz/4Oa7RHyVs7ZYWPMuoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AR43b7r49PRpEci5E9pfsXceF0Nxh7NZVX0PlH8IZB/YMH0B6su6aG2bIApnmHdWPE9pJd87LBT3whAgX3/IttZe12ot7f8QHu/UoMSnWfsYD+T4FU9EsFUGemoyy1zxIUAcwKbvLcNH00CsJ5RClfoMZnxmfPIUHkZLfGXXF9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iBRhY1by; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757406935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KIGIIU0MQA+r4AmfTj9KwUl/3NWYmrQkHDw6RC3TQjs=;
	b=iBRhY1byceK9TpV7kofbqlnM3iuTw/p85XF7xVCqxHJA8r40pwTgiknvXV90XLwWqjO9CF
	XvKQX3rlCCCgpsuil73oRFxCVmK+X1920AWtGzFHEKoINWdSHcB5Qt7451vTteFiqovwHQ
	oa6hahzPM+PknmfW1iebLnLWngxozu0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-BYASr646PeeDE-hKRlbhlQ-1; Tue, 09 Sep 2025 04:35:34 -0400
X-MC-Unique: BYASr646PeeDE-hKRlbhlQ-1
X-Mimecast-MFC-AGG-ID: BYASr646PeeDE-hKRlbhlQ_1757406933
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-336b13923d4so23912991fa.1
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Sep 2025 01:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757406933; x=1758011733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIGIIU0MQA+r4AmfTj9KwUl/3NWYmrQkHDw6RC3TQjs=;
        b=j7tXvtveMTOztvWDlZbizhOQWRm5RzW+uQ0dtwS3KblGeFvVWzVRfQKGqKVhS1EVqE
         2FBWPgx6hS6RnTxd+RJA0aw4OkcwWVYCg2fV4NbY1HUNE5L5UptZ5VoD/CHx0uugmXkN
         uire1zqAPhjovelxcp50UJQgrx8kpsZY9ADcG1kTgvZLCRVFV8IswjbAXM/z10Zq8fi6
         NOGtaJE7aOwg21ay8tLu47W3uQ6GquxzU9h36FlA2Vlw8Mr3EdN3YyoIpN+iX25YWSky
         LIJOmJa5MKS9ptnNHijo7duTGRYmCRcAlgCzbU4Pafl+poxvGXlTI5UTqvehd4zmQFqD
         Yndg==
X-Forwarded-Encrypted: i=1; AJvYcCVXgmPwyvuZk7QT5ziYrpV6Np3hvsBD9YzwaKz1U4x01Wd/ozwW8tufD5gLZ1koQ030D39HSbTVemEZcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YybzyUNpUOB1vMz6cPAl8oI5yCUCaTttsWx4a21ionictsrkCXY
	MkVXLEA3Luk5P8v8N0h6yfeVqydmMQh+XBJWtRDgkNdtd3kFHfjbJKOvH+SCCXK4m37P91Ir7zj
	HzaJsNORWaWfEY1u8sgY6/NLc17R1Q/DGoaNqGAeOpt1wG/gEimlDCyg+8uxasl02Mpk8VpB5Gy
	PByrKvvqq4mpp7wRlL97WbOGD4nXhlMIyeMgRC4rk=
X-Gm-Gg: ASbGncv8bCb7/IjNPX0lqxsC5o27yI7mZpcgf3pyE2zc5lX2faWpMeu2QK84Wk3rE6U
	vXcglUMnDOE3k3N8tQJpkh4l0EBqMGNnrz9V8r1PWwL1kycsI5TbTi60v21trOWBWSC3eavB4W7
	pU9zBT+/jxNfOifQrQQ43y7A==
X-Received: by 2002:a05:651c:b24:b0:338:d42:2a73 with SMTP id 38308e7fff4ca-33b5ada4819mr24470371fa.45.1757406933036;
        Tue, 09 Sep 2025 01:35:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEf+AOJCrvdWe0ZVDJNH1kUjM/qDLFfCo5S8iKhDLY/6ZtYZXarMJkTvuBtuHQVxXy998mM8VfUAXc+luP+9Yk=
X-Received: by 2002:a05:651c:b24:b0:338:d42:2a73 with SMTP id
 38308e7fff4ca-33b5ada4819mr24470141fa.45.1757406932556; Tue, 09 Sep 2025
 01:35:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905135443.188488-1-jth@kernel.org> <DCNZROY8CV6U.2WZ7G51K4JTRN@wdc.com>
In-Reply-To: <DCNZROY8CV6U.2WZ7G51K4JTRN@wdc.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 9 Sep 2025 16:35:20 +0800
X-Gm-Features: Ac12FXwvzh4EveTeB0voKc-JG7N0Y12CR5GKaqyVgDejHs_SzMzuvGqivUjOXd4
Message-ID: <CAHj4cs-K4takgbYjhgRJmCQ_11eFm0ViOhKcvL9Y++io4s4rQQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: zoned: fix incorrect ASSERT in btrfs_zoned_reserve_data_reloc_bg
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: Johannes Thumshirn <jth@kernel.org>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, David Sterba <dsterba@suse.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 12:42=E2=80=AFPM Naohiro Aota <Naohiro.Aota@wdc.com>=
 wrote:
>
> On Fri Sep 5, 2025 at 10:54 PM JST, Johannes Thumshirn wrote:
> > From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >
> > When moving a block-group to the dedicated data relocation space-info i=
n
> > btrfs_zoned_reserve_data_reloc_bg() it is ASSERT()ed that the newly
> > created block-group for data relocation does not contain any zone_unusa=
ble
> > bytes.
> >
> > But on disks with zone_capacity < zone_size, the difference between
> > zone_size and zone_capacity is accounted as zone_unusable.
> >
> > Instead of ASSERT()ing that the block-group does not contain any
> > zone_unusable bytes, remove them from the block-groups total size.
> >
> > Reported-by: Yi Zhang <yi.zhang@redhat.com>
> > Link: https://lore.kernel.org/linux-block/CAHj4cs8-cS2E+-xQ-d2Bj6vMJZ+C=
wT_cbdWBTju4BV35LsvEYw@mail.gmail.com/
> > Fixes: daa0fde322350 ("btrfs: zoned: fix data relocation block group re=
servation")
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

Thanks for the patch:

Tested-by: Yi Zhang <yi.zhang@redhat.com>


--=20
Best Regards,
  Yi Zhang


