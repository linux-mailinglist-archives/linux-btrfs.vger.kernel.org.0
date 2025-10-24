Return-Path: <linux-btrfs+bounces-18250-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5241EC04E87
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 10:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F163BCDB8
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 07:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68BD2F7AD3;
	Fri, 24 Oct 2025 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVgNQ2+e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0664A2F7478
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 07:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292570; cv=none; b=uE95w0UGxij9EJ9NkCExSa7C/aL1GEZRLR+VX2skHPxi9pGJaTW4HfImzA2h3JgxmyAgGU4ade9dzPE82JSsnpiaUkUQl6nLZcezJxfL/em8DLBEYcgka7CSnHQBsqyXPu1wtxpDo123qBxEfI5Hb/95P2NvlMpfB4ZNnAVRXs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292570; c=relaxed/simple;
	bh=1Y5CDeCe7IaQVGb6VCKBAyP0sx3/ke62/uIwazpR8Dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKNrqRZYU8HDvWE4rz9EpSS0VnGDDJmMVMMGtHOJIDTsynYCT0kosd0RQ8LmDXfViZqiWsEzMDrHcvqia9xtsjxn9wnPiy9gIYpMJTDarGU77h9Qk2Y6PLfljxxqAYepkvWncPIMeRLSn6vwa48Wc7tgxh9LpYkQ4Ol8O8M2ioI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVgNQ2+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901D1C4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 07:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761292569;
	bh=1Y5CDeCe7IaQVGb6VCKBAyP0sx3/ke62/uIwazpR8Dk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iVgNQ2+ebYn/bpYxdIhvFK33YRaQpWeKswvo4mdHcDgR7dz5ddM5V5piJTRBDluTh
	 UK01hWgPrR/dFAK1Ne2nnBT5HNrfUocdIqWGTWD8BwPUsmZdzQQ3OToZWUQH7vWoxs
	 rG5TgeXOPlkDoBmce7gNAcjwxL/29xciD0rmNWdFX0WO7fd9hFhGwUhY+v+wn7L1Fu
	 F+2YLiRpMpMMHTkW6QOem91hOvK2QDQoMV/KSRypI3qGECwjeSCtgRKaWvOkeU9W3E
	 Cl69LoYiPBO7SrXB4HZj3Oaao2mRuaqslezhIeUJnj0OiNnJgsV+kW7tLHsylWT2mS
	 WK6n7Gq/ZPvlQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c523864caso4006861a12.1
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 00:56:09 -0700 (PDT)
X-Gm-Message-State: AOJu0YyMI8IBGm15WHMEsk83MrpimxCIcdP3/qlHpLQGX4WBVXJQEAqn
	1+v5xwCsiVVpUKf1Ecr0Xyt3fdnIL6NwHe3j4bdbEMlUgMAInCueG+mltt1i0nJXDorokS/152Z
	aQIZCcDZXb2TY6DOQZ8ARXDs1EmCakcg=
X-Google-Smtp-Source: AGHT+IFyDnIaMwEl3BwGfWId2i2J8+MSgUW0QqXVuIuNSvDtBdhgP0jB+Z/Xw9Bec9SA3ftmhHhX1UYdzMuq0wNTjsc=
X-Received: by 2002:a17:907:9801:b0:b3e:1400:6cab with SMTP id
 a640c23a62f3a-b6d6fdcab79mr161436666b.17.1761292568155; Fri, 24 Oct 2025
 00:56:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761234580.git.fdmanana@suse.com> <c7387d9ae30b7bf261932c8965cac5737699b228.1761234581.git.fdmanana@suse.com>
 <cb655bfd-c5c9-422e-bb0f-213007162db2@wdc.com>
In-Reply-To: <cb655bfd-c5c9-422e-bb0f-213007162db2@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 24 Oct 2025 08:55:31 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5qAhqnqn1sk7v7pWf0YktcbqhkZ7APcn=2qTzs4OKfdQ@mail.gmail.com>
X-Gm-Features: AS18NWDsRlIne5kEHZvddUAHmPXIVjCS9kGFq-DOvk3BHfEUk1IU2yKB13GY4Og
Message-ID: <CAL3q7H5qAhqnqn1sk7v7pWf0YktcbqhkZ7APcn=2qTzs4OKfdQ@mail.gmail.com>
Subject: Re: [PATCH 06/28] btrfs: inline btrfs_space_info_used()
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 7:52=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 10/23/25 6:01 PM, fdmanana@kernel.org wrote:
> > reduces the object code. In x86_64 with 14.2.0-19 from Debian the resul=
ts
>
> with GCC 14.2.0-19 from Debian?

Yes, I missed "gcc" before pasting the version.

>

