Return-Path: <linux-btrfs+bounces-1646-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27777838C83
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 11:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B6CCB253E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 10:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0EA5C902;
	Tue, 23 Jan 2024 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEgW0ahk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B305C8ED
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Jan 2024 10:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706007036; cv=none; b=Q9aSBorAcZxj1zqbZGl1NQXhM6UH131gwKqGzFJqADUHqULVozwKarqYRfFG20LedxZkSfPFzrQZd5qYd/fj30fi+HLpNadVPTzWBpfmSovPPjN2+acBEG2QS3WLHA6nHn770Kzn/r38NlhdDpWzRc/x6eL4apPhKZaPrU941/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706007036; c=relaxed/simple;
	bh=nUbHPxJHEuAd66Y5uKqqvsVj+kmJp+VMojsrPr76qVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JblQ1X2eC4FUZxO0jID3knAjBNyD1Dp6jjdMMj/b5HxnvZDSspNPdwv7mKwMetv5oGUhQ5576unEs9tDL9PMckOsvbuDvpjZ6ALwB50Zhnu0C6qsCPDWi/Jtwsj+tV8GSzNwNdG7TqR6B4TN2b+xT8NtFD/TIMkPJ0gxfRPPCq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEgW0ahk; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-46afd88430dso36346137.3
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Jan 2024 02:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706007034; x=1706611834; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eB4Dvx1RaZ5kmhqJpLKGa4xfTpybuE5FTPADq/xbM1M=;
        b=OEgW0ahkQrqv6B3yVX488xpYRJ0WWYhOw2kUOXgxCKsceUgEonjzf9eFTr3sCwE0fU
         ojLQsbav1w74mm2jWi5R2DPzySlhA++KFWohjABJLdY418aJ9FbIWZqPuUJ944SIMLP6
         jXB0WnB5d+DU6XGmmu/Ucl2t8i82wr79F9oUgCv5c3IVsk6FNwnG7isqSZF9M7Zu9UId
         OZ2YkcWYGKjpPOeIPelmW4JFBBmCMDREib4WMIPW96SOTros4DZXcxm2Hir6D1vW+sGh
         emPK+qQjAixkSJHRpdZo8s804DG/WCMOICqVFGlksCaH/DpcpC0nMdEkezWKIxGxA/s3
         1w0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706007034; x=1706611834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eB4Dvx1RaZ5kmhqJpLKGa4xfTpybuE5FTPADq/xbM1M=;
        b=TEVDQiw4Sldhm9F+bbTqI1ISWrTGV2A9p+IeNxMOSIusMqkHBW1x1qzfwD6hyLVh3S
         NJg+doNsmFIiCiELkn0ZdtozkEGyR7owoR0AHlnz7i0JjTiRB5L60GRmTwuAoh+YepZR
         bGUjxvf4rXjYqr8makdaUv02xEgWqJ6H2ed8IzyetJdGvqU7ny/dMj0/oUuFEXWzSoSj
         I48+ssBRAA71qk346icKggJ7YI27vfUW5bGEoUwuxYLbU2a7cWD8UyybFTdLkt7QHHJw
         x7DlW+caWupX+zd4jVeFMpwUy8ArWsLbr7CDyJW64Aq/B5Ete7ztpncMNYkVXbnR25Vm
         noMQ==
X-Gm-Message-State: AOJu0YwQIzSmg62nVnp4PC/IVtxT5Lri/XD8cP6soIsZTubSqeGCPf+U
	PDzSmXWdX7DIAlcvahxuMXiGKVV+ISiFJ37OcTsxNtWohlPCttf/TzCVzxUAQNuC46HYtofkRyd
	cbJJ6Z4JzBpIf96yEldZY8RMqZRA=
X-Google-Smtp-Source: AGHT+IGB5i/dKmpRyjGdqaoU9Oeqlaq3Egrb4Bw0UvOBUM12DddVdkpQKu65deAD9KQZoM0H31nJqOUM9IM5/HhApAU=
X-Received: by 2002:a67:e78d:0:b0:46a:25ec:20fc with SMTP id
 hx13-20020a67e78d000000b0046a25ec20fcmr1919114vsb.23.1706007034028; Tue, 23
 Jan 2024 02:50:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABq1_vj4GpUeZpVG49OHCo-3sdbe2-2ROcu_xDvUG-6-5zPRXg@mail.gmail.com>
 <20240122205947.GB31555@twin.jikos.cz> <20240122235433.GG31555@twin.jikos.cz>
In-Reply-To: <20240122235433.GG31555@twin.jikos.cz>
From: Klara Modin <klarasmodin@gmail.com>
Date: Tue, 23 Jan 2024 11:50:23 +0100
Message-ID: <CABq1_vicBpZP0UCAi4b7_PmKs_o-p5OX8DO+JDyZSsjhyU+K7A@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: zstd: fix and simplify the inline extent decompression
To: dsterba@suse.cz
Cc: wqu@suse.com, linux-btrfs@vger.kernel.org, terrelln@fb.com, 
	dsterba@suse.com, josef@toxicpanda.com, clm@fb.com
Content-Type: text/plain; charset="UTF-8"

Den tis 23 jan. 2024 kl 00:54 skrev David Sterba <dsterba@suse.cz>:
>
> On Mon, Jan 22, 2024 at 09:59:47PM +0100, David Sterba wrote:
> > On Mon, Jan 22, 2024 at 09:45:42PM +0100, Klara Modin wrote:
> > > Hi,
> > >
> > > With this patch [1], small zstd compressed files on btrfs return
> > > garbage when read on my x86_64 system. Reverting this on top of
> > > next-20240122 resolves the issue for me.
> >
> > Thanks for the report, this is serious. The patches have been in testing
> > for some time but haven't uncovered the problems you mention.
>
> Current status is that the commit is reverted in master branch as Linus
> also hit the bug. The cause and a fix are known
>
> https://lore.kernel.org/linux-btrfs/b55a95be-38e8-4db7-9653-f864788b475c@gmx.com/T/#m873962a3b205625045feb9a4f8db70e75f66e418
>
> For the time being the bug described in the changelog will be present
> (affecting the subpage case), with the fix for zstd revisited in the
> future.

Thanks for the update.

I tried the proposed fix,

-       memcpy_to_page(dest_page, dest_pgoff + to_copy,
workspace->out_buf.dst, to_copy);
+       memcpy_to_page(dest_page, dest_pgoff, workspace->out_buf.dst, to_copy);

and it resolves the issue for me.

