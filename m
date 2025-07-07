Return-Path: <linux-btrfs+bounces-15287-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AFBAFB217
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 13:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0512E1891B7E
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 11:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B318B29A308;
	Mon,  7 Jul 2025 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5eoahfn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3F6299A8F
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Jul 2025 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751886921; cv=none; b=J6gAt2vesdVWk9xdT/3UVNWrRDAIXnmbgt3oYA9Jr5B9VbTe1NfrnUxVmQlaCl5c+1vyEa3JVSRXTjtnzaDe2LRmtxbWNEPaqYSVhL/rVjii2li547OEg2j65vXyI4I53+6mzzmFvlynJPOzacPOm4VujiKMgKnYkzMP6cWrOCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751886921; c=relaxed/simple;
	bh=OVLRO4Q7nTiV0f5+DoiVSEZPExC36LLfBSWAFTExpY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IW3Ke8D2HTzYCpaZ1yLaXE0icWSKl7RyI0oIZeOWLxqcS3weF7r9Ua77A8IEUkDBp1XsrZV4YkKzRHkcXt7nR9+jlpPQqnhk78a/JfTdcceZcrKF+LYSNDIlN9Oni5SUsSS550pWgCkC6ROFV4C/2S/OfSAAJf3lxYu5K/vb4tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5eoahfn; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-553d52cb80dso2674527e87.1
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Jul 2025 04:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751886917; x=1752491717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVLRO4Q7nTiV0f5+DoiVSEZPExC36LLfBSWAFTExpY8=;
        b=a5eoahfndv1uj6G+d4NRrx+yX0K8lKs/cW3U8oSHxj1ori+X4PS9DvX1kg05x36+sT
         00CjfTrIBwCTt4nilfp34kV1lq0dTkPND/eXqY62gJ9vPC5uDrKfvkjTXz/EaE5dYc5E
         kXxOTThlpXUgJQK5LHbg4bAZnEvH68UtdtAc154UuNGQFVk33qtqh833FPfgbNQFM+NN
         Px2QAHgtUKreWWLFiw1qWSMfrT6pltK9WoJIExRlI1TqG1IiSneC9nUzeeeGfycl10+G
         4HD9asnIlwnPFv9zljajDZYeh78Xig3bGnKk9WkQink4pcmxhuyOT8Y61DWAVtoLKkYJ
         U2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751886917; x=1752491717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVLRO4Q7nTiV0f5+DoiVSEZPExC36LLfBSWAFTExpY8=;
        b=B0Pb6Z7KA2q+X8ADkX1s0XG3YJU6boxFp38SZxrSP/rpwMldc5/XfYvzXw6S+7H61A
         IsZs6yX/9MOc4jpUK7P0zhvyzISp/YkJXSjoS1EHmesjem4NkDOlvQhJCho5hgAFSmnC
         uiIbBmh7lq5e1ozozT5pSsLW7kmK1ZvGDkBAl7kLFdL+MP6T2kcFKfR7mpN40UMBxauo
         YZ6vm/tpADbb1ceYSye3jnxzXcsLJR4B/1skM7VUz84/c3sClAlx2eHn2IjIYETWjkAF
         MVtMZ+jXf0PyIFWBGeU6tu6ffLmQFT9g5zknPo87zm64OP7z2HQow9OWxpclgChJMTl/
         h25Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4I9CYZb0vqR3qYrETFfTwtkOmN3/LC2B8qz/nLOhAJIRVqC4cqUW5xWrRfGS+cHwZTfYhcPyfhAm1eA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtHnqihEE2FDtu+OnHFLn4Rh0gaYYIgCXzsGK9EbK7aHm+Y8jn
	51nqnIWhn3oy2O/Wd0ycu2bdrCG1G6cbvqyNldzhdjvsi4AMZ6FGLuj1hIag/OjUmt4jzGNoVjt
	6qLk8JK622OZVE0/a8BS8rG1tMuc7spw=
X-Gm-Gg: ASbGncvZWTvtpUtsZVBIs4GyZIgOl/KyxobBxHVHiKO6acdyttZERR5lKP7Z8Iz6PXl
	PYauFXAndLzY/GAGM2OlYGmJUSkU3s12jmt0Qae/aYZm4/2I0JIW+PFJt6VzTNosW+nzUMWrJF5
	SHBd1Ew0TWhcoQbbHgUftlRwFlcpJKetmYuaUVAPv7j18=
X-Google-Smtp-Source: AGHT+IEjQNG2/KPTLPYrJAvYluUvpzhH/Vrz6Snn7ZozvQpVDATu2s4VXilzw7SvAgJM6QXCsdWFKSkHrkNqVN1NlzE=
X-Received: by 2002:a05:6512:3989:b0:553:2154:7bcc with SMTP id
 2adb3069b0e04-556439350e7mr3301286e87.20.1751886917191; Mon, 07 Jul 2025
 04:15:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fce139db-4458-4788-bb97-c29acf6cb1df@cachyos.org>
 <a6f03aff-c9fc-4e7f-b1fb-42d6a4cd770a@gmx.com> <f6d53293-3d55-4ccd-a213-c877dc22935a@cachyos.org>
In-Reply-To: <f6d53293-3d55-4ccd-a213-c877dc22935a@cachyos.org>
From: Andrei Borzenkov <arvidjaar@gmail.com>
Date: Mon, 7 Jul 2025 14:15:05 +0300
X-Gm-Features: Ac12FXwgY0xywiYAQHr9eI0EfJ3D9cWtIGTJlsGcgE9C80Hn6df32InEjfBUHoY
Message-ID: <CAA91j0X=q5sRq75Y2Urpg9Ft9aRe6+vYvc1m39+LdTsAGhfuYg@mail.gmail.com>
Subject: Re: Increased reports since 6.15.3 of corruption within the log tree
To: Peter Jung <ptr1337@cachyos.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org, dave@jikos.cz, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dnaim@cachyos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 2:12=E2=80=AFPM Peter Jung <ptr1337@cachyos.org> wro=
te:
>
>
>
> On 7/7/25 13:00, Qu Wenruo wrote:
> > Unfortunately none of those comment is helpful.
> >
> > They do not provide the dmesg of the mount failure, and that's the most
> > important info.
> >
> > If you got any new reports, please ask for the dmesg of inside the
> > emergency shell.
> >
> > Thanks,
> > Qu
>
> Thanks for your answer - but how it would work saving the logs in the
> emergency shell, specially if the root partitions can not be mounted?
>

You can save it to any other filesystem that can be mounted including
a USB FAT stick.

