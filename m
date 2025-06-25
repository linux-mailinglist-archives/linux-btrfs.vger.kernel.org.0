Return-Path: <linux-btrfs+bounces-14945-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC39AE8066
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 12:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6DE2188A225
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 10:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938362C17B4;
	Wed, 25 Jun 2025 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGUwlA23"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C903B2BF000
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 10:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848965; cv=none; b=OiOuBC0X0y+y+Qmnk8EB6ev1XWpoQ0wkaezlqkmpdYyRL2SggWnC7zi6tnYWF+9S1+d2XgzWPxZUR2sSWQLAOfuGEed/ZUjVe9jR9QUZDnE4vgRIN3wf9DKsxbUeeukH+DhbjRyNSxyetmxcrmjE8+WP5P/w5JIfNvtsKPTwuFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848965; c=relaxed/simple;
	bh=LY3aIzteuavzSum3Rm/VydWQ8HM2vEb2GoX6WYFCVw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQOM6dTPSBYh541mLMUqkncjnG/I9u9IBXNDEXr7ZoZTskZQX91EpFbQ29y5uTbDs6nGMvt0VlnQSEAfYoNoFEj7Pf3RKdMCu+PMmtlZUEM2ye2BGUqrY7V11WE8ridF26Aaoo67gurVms9rf3N8fKsFYsCm69eAUqPbZeIUp+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGUwlA23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BEBC4CEEE
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 10:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750848965;
	bh=LY3aIzteuavzSum3Rm/VydWQ8HM2vEb2GoX6WYFCVw8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oGUwlA23g1KIA3Q9TFbZgv6YeTAtORkKq6CjpJwnbpnQiufq4Fs8XMRdFhvw8U7r7
	 RbddpbAWaM1LApATZzQuafNvncOTaP5LV8483Q3/IicpTrgQJS+/S5sXwZMGBCSL7h
	 iRnmBgfeWCBMxQCYzui+/fdjugd/b6uoI4DNuD3noN2QvSbqM9UxaHErXzzE3CDcCF
	 tUmjeZIPlHPekMwwn+9CfugeuvrrDnZp9VdWx8CTok8Pqzv7uR5Y4AZCnEfuddM7Qi
	 JEJlQL4Cf/0SJetW3zNObDQ6akQRcFP8WvyhwpEISmBDJFKae8Fm5SQyjo5wy3E6ty
	 +zVjElZprbH2g==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso152163166b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 03:56:05 -0700 (PDT)
X-Gm-Message-State: AOJu0YwesOexMbbHkZI1YCy8G2FVLpZVY3yXjcSY60ttcfX/UnwZKbAA
	af89FxUkc4AeXMmStlEUCQbWUzs8EnC5ECehK2poUZUesvYq2KJI0rDAN37lpMNX68mYlTGhzQc
	ffYdKdvSgDDky2EV/df84igLfg1cz294=
X-Google-Smtp-Source: AGHT+IEXR4XC+lSakeBsWHzapJUHnSuLHpD3MKn255ce92ZuqT8ivqlS2Dub25CncENWWNlVeB3rxhR06FZHsv2RhRM=
X-Received: by 2002:a17:907:3a10:b0:adf:f8f3:ee16 with SMTP id
 a640c23a62f3a-ae0a740dd9dmr515644566b.15.1750848964198; Wed, 25 Jun 2025
 03:56:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750709410.git.fdmanana@suse.com> <cfd83c633ff032b9eabe4e71ec829151461bf168.1750709411.git.fdmanana@suse.com>
 <0b60dd37-40e1-460a-839f-6b2d96002e41@wdc.com>
In-Reply-To: <0b60dd37-40e1-460a-839f-6b2d96002e41@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 25 Jun 2025 11:55:27 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4MDVZp+ie_vW_5CXwgRev4X5T0NVFu3-DypSZ_H6msmw@mail.gmail.com>
X-Gm-Features: Ac12FXy-AHfm3WAR-kiB5GneXKEaI8d6CuKrASpo2Jup1DZwuH_sW0CMk2OTfos
Message-ID: <CAL3q7H4MDVZp+ie_vW_5CXwgRev4X5T0NVFu3-DypSZ_H6msmw@mail.gmail.com>
Subject: Re: [PATCH 06/12] btrfs: use btrfs_record_snapshot_destroy() during rmdir
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 11:48=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> Shouldn't this be merged into 5/12?

These are two different behavioural changes, so I prefer to keep them
separate and with dedicate change logs.

