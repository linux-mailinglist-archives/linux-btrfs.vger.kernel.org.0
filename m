Return-Path: <linux-btrfs+bounces-11080-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6C2A1D889
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 15:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8EBF3A3CE6
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 14:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C411EB3E;
	Mon, 27 Jan 2025 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO0LEIJ5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEB25672
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737988644; cv=none; b=V3vLJuPqWrg/QlkTv8JEl9JIXnuHu55oDFcGT3fHf+p3F3EJjLtKzt79rbbguqa2P6La+1MKYm3ZTB57e4fEYjtHgS4CND2VHXTvqOhut97EQ8sQQpKpAnbn5WEvE82l31xxhPr8uc4KYQViVvYTTOVLjhuuFotyxuUYvSFKUjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737988644; c=relaxed/simple;
	bh=GYr4VIvNuKJKjlnKzQEjc+s/cb1NZC4ezUCMzmUqxN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GR86F8dJJRDtnLTbni5TnczQGfF1JCqwS1Wgvg+Btj2aPil9UMZIdooxBgb4PCR3SXuCB7YEB/8Scax5zcZKDEHNUB0tIYazGftnMY1ryFIzV8JDhqGrOtgwNmoqj196fwu0C4S272+7Y8ZRe7bUWORAkOx09/ViAx/DTKXFCqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SO0LEIJ5; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3ee1be3d496so2366208b6e.0
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 06:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737988642; x=1738593442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvdCh9pY15eozACJaUZVd4Fl8icNgHAlp7x5AE0i51c=;
        b=SO0LEIJ5sr/3tAOBTzQJm7Nofc62A0rdlGVWZU749mc7Y0WqgLmj644K9KInoS7Q3k
         5QgsGfl/J/nUGy78zXwuObEGAPJM/p7dFmsk1dYoWVeF2ipcvPzDU9aIzYJcR6/aTAcV
         9fJa70azwKfJP4633G9JlxVsaOOw5exPWKan/IiA2jYnEE6IuZ5Ny0ZJW85dvFF07p20
         f9+HMIYp4BwT6gckLXDy3tcA7IJ5WfltC7VLjDTLfeH2eOh3qUBFtd24scO2fdhArPGB
         0qW3tYt0cSrIchX14Uw4vapByDBd7m8dKvEcvSH+3Nmp9pO6ax/hgFm3lo/EvH0YHp3x
         4e3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737988642; x=1738593442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvdCh9pY15eozACJaUZVd4Fl8icNgHAlp7x5AE0i51c=;
        b=Df4I34+jSXSoyvHXG2auEu5wJrLw0RBJfRBBLTzM82YUTUSyxWwlu5OChgPdQ9yZQG
         KGRBtHinhv1naqyH8oQS4+Mt6pxLbiCusSEFtBQncbywffCJdVyQqxvv7BH2QwSqCPFg
         BAmmiAFIAUa1d6by6VkddWRyGO4TXg1ZQJQW7sg58xIbyFYTBvozVWDe7SHdHimKVwDK
         6SuV3Jk5H+YsAR+ecOXcnDGMNYXuiRkiVZ+GOGlVH8/zicOGfqWsuZto6JTPTVuU4OXJ
         BCWPzNMtITUa4eYfizjj97SMXZH2VShlsxk/giSlQQFR+jERPH5bWDhXzLGd/8KBR9pl
         eySw==
X-Gm-Message-State: AOJu0YwCwpSG1rblylVg1p0Zq5Mad+h2bVX/SybmfgZLlG+lnqAj1dmz
	wY3w+fmMwuCZFT8YxBJyjjRwrvEbq8QKfbWR97h16FC442RYMd//a68ojWZ+MBIksnMjkruAILl
	wYYrF0w/n+LHKnuYklBRWdx8eR0c=
X-Gm-Gg: ASbGnctsM59VY608Z1sXDTMxKIvkc+675wxD/AW6UlqRQMjttrAhcjA7BorYcJPJ7en
	wMOHZeKfk72Gp9F4c4UlBZ/bQWp2pxxoooENzZHI5ie51shjws3asu4N81IVi7ws=
X-Google-Smtp-Source: AGHT+IFQ1eXYwjdL436TCUHW/KuI2l6xFjzTu9J601fl/XzeSJVhlr/mlyFkkhon93h6Vtz6t7HqdvANeXNf9ZStB7E=
X-Received: by 2002:a05:6808:1512:b0:3ea:9a5c:ac06 with SMTP id
 5614622812f47-3f1efb9ac8emr8212742b6e.1.1737988641754; Mon, 27 Jan 2025
 06:37:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PAXPR04MB855864623B37A9E3F25267EED6EC2@PAXPR04MB8558.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB855864623B37A9E3F25267EED6EC2@PAXPR04MB8558.eurprd04.prod.outlook.com>
From: Andrei Borzenkov <arvidjaar@gmail.com>
Date: Mon, 27 Jan 2025 17:37:06 +0300
X-Gm-Features: AWEUYZm0koBJkBBES24dYtRsSnKtdbrMt0lABniEIiOcPU-82tKemHDnZooK5fs
Message-ID: <CAA91j0WwVt3u9stCj6sNSRkFM=HDtNoN+6DNBukUBU2WqFqVwA@mail.gmail.com>
Subject: Re: some questions to quota and qgroup
To: Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 5:29=E2=80=AFPM Bernd Lentes
<bernd.lentes@helmholtz-muenchen.de> wrote:
>
> Hi,
>
> I'm using BTRFS since a while, but now I want to use quotas.
> Why ? I installed snapper, and snapper creates quota-groups for the snaps=
hots.

a) this can be disabled
b) snapper only needs quota to perform space-based snapshots cleanup

> I'm using Ubuntu 22.04 with kernel 6.8.0-51-generic and snapper 0.9.0-1.
> Reading the man page of quota I stumbled across:
> "PERFORMANCE IMPLICATIONS
>        When quotas are activated, they affect all extent processing, whic=
h takes a performance hit. Activation of qgroups is not recommended unless =
the user intends to actually
>        use them.
>  STABILITY STATUS
>        The qgroup implementation has turned out to be quite difficult as =
it affects the core of the filesystem operation. Qgroup users have hit vari=
ous corner cases over time,
>        such as incorrect accounting or system instability. The situation =
is gradually improving and issues found and fixed."
>
> How is the current status?
> The host will be used for computing scientific data.
> How big is the performance hit?
> How stable are qgroups?
>
> Thanks.
>
> Regards,
>
> Bernd
>
> --
>
> Bernd Lentes
> SystemAdministrator
> Institute of Metabolism and Cell Death
> Helmholtz Zentrum M=C3=BCnchen
> Building 25 office 129
> Bernd.lentes@helmholtz-munich.de
> +49 89 3187 1241
>
> Helmholtz Zentrum M=C3=BCnchen =E2=80=93 Deutsches Forschungszentrum f=C3=
=BCr Gesundheit und Umwelt (GmbH)
> Ingolst=C3=A4dter Landstra=C3=9Fe 1, D-85764 Neuherberg, https://www.helm=
holtz-munich.de
> Gesch=C3=A4ftsf=C3=BChrung: Prof. Dr. med. Dr. h.c. Matthias H. Tsch=C3=
=B6p, Dr. Michael Frieser | Aufsichtsratsvorsitzende: MinDir=E2=80=99in Pro=
f. Dr. Veronika von Messling
> Registergericht: Amtsgericht M=C3=BCnchen HRB 6466 | USt-IdNr. DE 1295216=
71

