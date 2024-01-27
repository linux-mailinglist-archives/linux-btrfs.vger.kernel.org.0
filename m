Return-Path: <linux-btrfs+bounces-1848-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3628283EF58
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jan 2024 18:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BF31C22006
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jan 2024 17:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697FC2D61A;
	Sat, 27 Jan 2024 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CU+lCf2u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D272D602;
	Sat, 27 Jan 2024 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706378371; cv=none; b=FGqnZuk9TiiQaVeRa4MGuTApNb6GhiFtIU5WCrelQA/Y46HY3+FX1U+tPe2cGSqbaeOnhlH+Gq3lVZ6zKo0PM31E21PX9h5OhDxyEaOl6a1SdXP0N/Jhc5PmDvqg2V9bct0WAR9aR4q+/oHf1Cmpm5X7em+J6DzbjcO101NfuMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706378371; c=relaxed/simple;
	bh=gvQC5KlWY5DmvbXMzH+mPH2Ftf5UIF36bObNOQK4mHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAdByOP5QYDBbfSski7nvnZA/I3Am8upoXaBKoj2Kc9LAl89dUbJs12zKObCYdc3vG1NypFLUJnusLzM/Cx15wSKJzmxKaoXDfJp/ZUwc5AOirSfRcS8nxu0vcqIxeBeyDgHrVRjWW8vg+oR9HIvJL6oAWhFJDhswyX7H/Kakck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CU+lCf2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6706C433A6;
	Sat, 27 Jan 2024 17:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706378370;
	bh=gvQC5KlWY5DmvbXMzH+mPH2Ftf5UIF36bObNOQK4mHo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CU+lCf2u9jlOmLs1xTxYvaX+tAESFwr75X+Djz4dK2WHE8XQ9vnBR4Er33GdiJuos
	 VfpfBVok9qF1ybu/J8MFmcKLUeLQOxEuPr7VG8zcQonji+HLvC0pIZvRI9MGDVvgmO
	 KifNRPOhNYSqD2Uv4kg6NwSqifAkFFYjC/U5Mh3nwJrqZ0lhuu25+PNS0C2UP8nM8i
	 INKOkh59p/IrcR+x3XWrMaNH8tGumYtuGMzHJDNt45O2DQQnc8SRBiU+h741WmX3Ih
	 1ApLduc/3W8K1LuLE6Hk7VomFb0/gSPydjUrh/ExkLq825ZvvdX6AcCGlFVSHHN9V5
	 DesgyC7s6crXQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5102bbe87afso704876e87.1;
        Sat, 27 Jan 2024 09:59:30 -0800 (PST)
X-Gm-Message-State: AOJu0Yy6lS8K1afkFQOawCJSYew87fM1VAc4gvzH4j/Y5Ct//hbo7KpU
	B/5p1pYljJx5sIIXrTb6CAJsTfMv+rPXka9Yau3OqkSkz9F0/dhVzEDpfmJ3DmyYpreBksgUxhS
	6ryf/sxkdUcRiw4CRq77OjddrU2Q=
X-Google-Smtp-Source: AGHT+IF6DavKcKdFodXfqQ5yl/YfBG+5xwTYev1b1o76KfSUC6m+vJyrXUvqmQZWHYc+BZ1FIo5IxD7WJVqVwXriqbM=
X-Received: by 2002:a05:6512:2256:b0:510:6e7:8e43 with SMTP id
 i22-20020a056512225600b0051006e78e43mr1327762lfu.49.1706378368928; Sat, 27
 Jan 2024 09:59:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706183427.git.fdmanana@suse.com> <2024012633-retold-avid-8113@gregkh>
In-Reply-To: <2024012633-retold-avid-8113@gregkh>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sat, 27 Jan 2024 17:58:52 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5ZXmN32iYx9LjMh7arcp+tyLdn1zDHZCT+8hGhMfAA9A@mail.gmail.com>
Message-ID: <CAL3q7H5ZXmN32iYx9LjMh7arcp+tyLdn1zDHZCT+8hGhMfAA9A@mail.gmail.com>
Subject: Re: [PATCH 0/4 for 5.15 stable] btrfs: some directory fixes for
 stable 5.15
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-btrfs@vger.kernel.org, erosca@de.adit-jv.com, 
	Maksim.Paimushkin@se.bosch.com, Matthias.Thomae@de.bosch.com, 
	Sebastian.Unger@bosch.com, Dirk.Behme@de.bosch.com, Eugeniu.Rosca@bosch.com, 
	wqu@suse.com, dsterba@suse.com, stable@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2024 at 1:15=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Jan 25, 2024 at 11:59:34AM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Here follows the backport of some directory related fixes for the stabl=
e
> > 5.15 tree. I tested these on top of 5.15.147.
>
> As these are not also in 6.1.y, we can't take these as you do not want
> to upgrade and have regressions, right?
>
> If you can provide a working set of 6.1.y changes for these, we will be
> glad to queue them all up, thanks.

Ok, here the version for 6.1, tested against 6.1.75:

https://lore.kernel.org/linux-btrfs/cover.1706377319.git.fdmanana@suse.com/

Thanks.

>
> greg k-h

